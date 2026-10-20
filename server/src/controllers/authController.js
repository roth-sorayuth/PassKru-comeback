import bcrypt from "bcryptjs";
import crypto from "crypto";
import { prisma } from "../config/prisma.js";
import * as authService from "../services/authService.js";
import { sendVerificationOtpEmail, sendAccountExistsEmail, sendPurposeOtpEmail } from "../services/emailService.js";
import { toPublicUser } from "../utils/publicUser.js";
import { startSession, revokeAllSessions } from "../services/sessionService.js";

const JWT_SECRET = process.env.JWT_SECRET;
const MAX_OTP_PER_DAY = 4;
const MIN_PASSWORD_LENGTH = 8;
const BCRYPT_ROUNDS = 12;

// Auth failures share one message per endpoint so responses never reveal
// whether an email is registered, or which sign-in provider it uses.
const INVALID_CREDENTIALS = "Invalid email or password.";
const INVALID_OTP = "Invalid or expired verification code. Please check and try again.";
const RESEND_ACCEPTED = "If this account is awaiting verification, a new code has been sent to your email.";
const REGISTER_EMAIL_FAILED =
  "Failed to send verification code email within time limit. Please check your email address and try again.";

const registerAccepted = (email) => ({
  success: true,
  requiresVerification: true,
  email,
  message: "Registration received. Please enter the 6-digit verification code sent to your email. If you already have an account, sign in instead.",
});

// Compared against when the email is unknown, so a missing account takes as
// long to reject as a wrong password (no timing oracle for enumeration).
const DUMMY_PASSWORD_HASH = bcrypt.hashSync(crypto.randomBytes(16).toString("hex"), BCRYPT_ROUNDS);

function generate6DigitOtp() {
  return crypto.randomInt(100000, 1000000).toString();
}

function otpMatches(expected, submitted) {
  const a = Buffer.from(String(expected));
  const b = Buffer.from(String(submitted));
  return a.length === b.length && crypto.timingSafeEqual(a, b);
}

/**
 * Runs an email send with a reasonable execution time limit (12 seconds)
 */
async function sendWithTimeout(sendPromise, timeoutMs = 12000) {
  return Promise.race([
    sendPromise,
    new Promise((_, reject) =>
      setTimeout(() => reject(new Error(`Email sending timed out after ${timeoutMs / 1000}s`)), timeoutMs)
    ),
  ]);
}

const sendOtpWithTimeout = (params, timeoutMs = 12000) => sendWithTimeout(sendVerificationOtpEmail(params), timeoutMs);

// ---------------------------------------------------------------------------
// Sign-in and password-reset OTPs
//
// They reuse the user's verificationOtp/otpExpiresAt/otpLastSentAt columns
// (only used for signup verification until the account is verified). The
// stored value is never the code itself: it is one purpose letter plus 9 hex
// chars of an HMAC over (purpose, user, code), which fits the VARCHAR(10)
// column, so a database leak does not reveal live codes and a code issued for
// one purpose cannot be redeemed for another.
// ---------------------------------------------------------------------------
const OTP_TTL_MS = 10 * 60 * 1000;
const OTP_COOLDOWN_MS = 60 * 1000;
const OTP_PURPOSE = { login: "L", reset: "R" };
// Every sign-in needs an emailed code unless explicitly switched off. Admin
// accounts always need one.
const LOGIN_OTP_ENABLED = process.env.LOGIN_OTP_ENABLED !== "false";

const GENERIC_RESET_ACCEPTED = "If an account exists for this email, a reset code has been sent.";

function otpTag(purposeCode, userId, otp) {
  const mac = crypto.createHmac("sha256", JWT_SECRET).update(`${purposeCode}|${userId}|${otp}`).digest("hex");
  return purposeCode + mac.slice(0, 9);
}

/** Stores a fresh code for `purpose` and returns it, or null while the cooldown applies. */
async function issuePurposeOtp(user, purpose) {
  const code = OTP_PURPOSE[purpose];
  const sentAt = user.otpLastSentAt ? new Date(user.otpLastSentAt).getTime() : 0;
  const stillLive =
    user.verificationOtp?.startsWith(code) && user.otpExpiresAt && new Date(user.otpExpiresAt).getTime() > Date.now();
  if (stillLive && Date.now() - sentAt < OTP_COOLDOWN_MS) return null;

  const otp = generate6DigitOtp();
  await prisma.user.update({
    where: { userId: user.userId },
    data: {
      verificationOtp: otpTag(code, user.userId, otp),
      otpExpiresAt: new Date(Date.now() + OTP_TTL_MS),
      otpLastSentAt: new Date(),
    },
  });
  return otp;
}

/**
 * Redeems a code. Conditional on the stored value still being the one we
 * matched, so concurrent requests cannot both use it. `extraData` is applied in
 * the same update (e.g. the new password hash).
 */
async function consumePurposeOtp(user, purpose, submitted, extraData = {}, db = prisma) {
  const code = OTP_PURPOSE[purpose];
  const stored = user?.verificationOtp;
  const expires = user?.otpExpiresAt ? new Date(user.otpExpiresAt).getTime() : 0;
  if (!user || !user.isEmailVerified || !stored || !stored.startsWith(code) || expires <= Date.now()) return false;
  if (!/^\d{6}$/.test(submitted) || !otpMatches(stored, otpTag(code, user.userId, submitted))) return false;

  const { count } = await db.user.updateMany({
    where: { userId: user.userId, verificationOtp: stored },
    data: { ...extraData, verificationOtp: null, otpExpiresAt: null, otpLastSentAt: null },
  });
  return count === 1;
}

/** Starts a server-side session (cookie + token) and sends the standard authenticated response. */
async function sendSession(res, user, message) {
  const token = await startSession(res, user);
  const userWithExam = await authService.getUserWithExam(user.userId);
  return res.status(200).json({ success: true, message, token, user: userWithExam || toPublicUser(user) });
}

/**
 * Checks if a user has exceeded the maximum OTP request limit (4 per 24 hours).
 */
function checkOtpDailyLimit(user) {
  const now = new Date();
  const lastSent = user.otpLastSentAt ? new Date(user.otpLastSentAt) : null;
  const currentCount = Number(user.otpCount || 0);

  // Reset counter if last sent was 24 hours ago or never
  const isExpiredWindow = !lastSent || now.getTime() - lastSent.getTime() >= 24 * 60 * 60 * 1000;

  if (isExpiredWindow) {
    return {
      allowed: true,
      newCount: 1,
      now,
    };
  }

  if (currentCount >= MAX_OTP_PER_DAY) {
    const hoursLeft = Math.ceil((24 * 60 * 60 * 1000 - (now.getTime() - lastSent.getTime())) / (1000 * 60 * 60));
    return {
      allowed: false,
      newCount: currentCount,
      now,
      message: `You have reached the maximum limit of 4 OTP requests per day. Please try again in ${hoursLeft} hour(s).`,
    };
  }

  return {
    allowed: true,
    newCount: currentCount + 1,
    now,
  };
}

// Signup verification codes use the same HMAC tag scheme as sign-in and reset
// codes (purpose "V"), so a database leak never reveals a live code.
const SIGNUP_OTP_PURPOSE = "V";

/** Stores a fresh signup code for `userId` and returns it (the plain code goes only to the email). */
async function issueSignupOtp(userId, otpCount) {
  const otp = generate6DigitOtp();
  await prisma.user.update({
    where: { userId },
    data: {
      verificationOtp: otpTag(SIGNUP_OTP_PURPOSE, userId, otp),
      otpExpiresAt: new Date(Date.now() + OTP_TTL_MS),
      otpCount,
      otpLastSentAt: new Date(),
    },
  });
  return otp;
}

function signupOtpMatches(user, submitted) {
  const stored = user?.verificationOtp;
  if (!stored || !/^\d{6}$/.test(submitted)) return false;
  // Codes issued before hashing were stored as the six digits themselves;
  // they expire within 10 minutes of this shipping.
  if (/^\d{6}$/.test(stored)) return otpMatches(stored, submitted);
  return stored.startsWith(SIGNUP_OTP_PURPOSE) && otpMatches(stored, otpTag(SIGNUP_OTP_PURPOSE, user.userId, submitted));
}

// POST /api/auth/register
export const register = async (req, res, next) => {
  try {
    const { firstName, lastName, email, password, phoneNumber } = req.body;

    if (
      [firstName, lastName, email, password].some((v) => typeof v !== "string" || !v.trim()) ||
      (phoneNumber != null && typeof phoneNumber !== "string")
    ) {
      return res.status(400).json({
        success: false,
        message: "First name, last name, email, and password are required.",
      });
    }

    if (password.length < MIN_PASSWORD_LENGTH || password.length > 128) {
      return res.status(400).json({
        success: false,
        message: `Password must be between ${MIN_PASSWORD_LENGTH} and 128 characters long.`,
      });
    }

    const normalizedEmail = email.trim().toLowerCase();
    const existingUser = await prisma.user.findUnique({
      where: { email: normalizedEmail },
    });

    // Hashed on every path, so a taken address answers in the same time as a free one.
    const passwordHash = await bcrypt.hash(password, BCRYPT_ROUNDS);

    // Every outcome below except an email failure answers with the same 201,
    // so this endpoint never reveals whether an address is registered.
    if (existingUser?.isEmailVerified) {
      // The real owner gets a heads-up instead of a code.
      await sendWithTimeout(sendAccountExistsEmail({ email: normalizedEmail })).catch((err) =>
        console.error("[AUTH_REGISTER] Account-exists email error/timeout:", err?.message || err)
      );
      return res.status(201).json(registerAccepted(normalizedEmail));
    }

    if (existingUser) {
      // Pending signup. While its code is still live, a second registration
      // must not replace its name, password or code (that let anyone hijack
      // or keep resetting someone else's signup).
      const codeLive = existingUser.otpExpiresAt && new Date(existingUser.otpExpiresAt).getTime() > Date.now();
      const limitCheck = checkOtpDailyLimit(existingUser);
      if (codeLive || !limitCheck.allowed) {
        return res.status(201).json(registerAccepted(normalizedEmail));
      }

      await prisma.user.update({
        where: { userId: existingUser.userId },
        data: {
          firstName: firstName.trim(),
          lastName: lastName.trim(),
          phoneNumber: phoneNumber ? phoneNumber.trim() : null,
          passwordHash,
        },
      });
      const otp = await issueSignupOtp(existingUser.userId, limitCheck.newCount);
      try {
        await sendOtpWithTimeout({ email: normalizedEmail, otp, firstName: firstName.trim() });
      } catch (emailError) {
        console.error("[AUTH_REGISTER] OTP Email error/timeout:", emailError?.message || emailError);
        return res.status(500).json({ success: false, message: REGISTER_EMAIL_FAILED });
      }
      return res.status(201).json(registerAccepted(normalizedEmail));
    }

    const user = await prisma.user.create({
      data: {
        firstName: firstName.trim(),
        lastName: lastName.trim(),
        email: normalizedEmail,
        phoneNumber: phoneNumber ? phoneNumber.trim() : null,
        passwordHash,
        role: "candidate",
        isEmailVerified: false,
      },
    });
    const otp = await issueSignupOtp(user.userId, 1);

    try {
      await sendOtpWithTimeout({
        email: normalizedEmail,
        otp,
        firstName: firstName.trim(),
      });
    } catch (emailError) {
      console.error("[AUTH_REGISTER] OTP Email error/timeout:", emailError?.message || emailError);
      // Roll back the new account so the address can register again.
      await prisma.user.delete({ where: { userId: user.userId } }).catch(() => {});
      // Generic text: raw SMTP errors can expose server details.
      return res.status(500).json({ success: false, message: REGISTER_EMAIL_FAILED });
    }

    return res.status(201).json(registerAccepted(normalizedEmail));
  } catch (error) {
    next(error);
  }
};

// POST /api/auth/verify-otp
export const verifyOtp = async (req, res, next) => {
  try {
    const { email, otp } = req.body;

    if (typeof email !== "string" || typeof otp !== "string" || !email.trim() || !otp.trim()) {
      return res.status(400).json({
        success: false,
        message: "Email and OTP code are required.",
      });
    }

    const normalizedEmail = email.trim().toLowerCase();
    const submittedOtp = otp.trim();
    const user = await prisma.user.findUnique({
      where: { email: normalizedEmail },
    });

    // A token is only ever issued below, after a successful OTP match. Unknown
    // and already-verified accounts get the same failure as a wrong code —
    // verified users sign in with /login, never through this endpoint.
    const otpExpiresTime = user?.otpExpiresAt ? new Date(user.otpExpiresAt).getTime() : 0;
    const isValid =
      user &&
      !user.isEmailVerified &&
      user.verificationOtp &&
      otpExpiresTime > Date.now() &&
      signupOtpMatches(user, submittedOtp);

    if (!isValid) {
      return res.status(400).json({ success: false, message: INVALID_OTP });
    }

    // Conditional on the code still being the one we matched, so two
    // concurrent requests can't both redeem it (single use).
    const { count } = await prisma.user.updateMany({
      where: { userId: user.userId, isEmailVerified: false, verificationOtp: user.verificationOtp },
      data: {
        isEmailVerified: true,
        verificationOtp: null,
        otpExpiresAt: null,
        otpCount: 0,
        otpLastSentAt: null,
      },
    });
    if (count !== 1) {
      return res.status(400).json({ success: false, message: INVALID_OTP });
    }

    const token = await startSession(res, user);
    const userWithExam = await authService.getUserWithExam(user.userId);

    return res.status(200).json({
      success: true,
      message: "Email verified successfully!",
      token,
      user: userWithExam || toPublicUser({ ...user, isEmailVerified: true }),
    });
  } catch (error) {
    next(error);
  }
};

// POST /api/auth/resend-otp
export const resendOtp = async (req, res, next) => {
  try {
    const { email } = req.body;

    if (typeof email !== "string" || !email.trim()) {
      return res.status(400).json({
        success: false,
        message: "Email is required.",
      });
    }

    const normalizedEmail = email.trim().toLowerCase();
    const user = await prisma.user.findUnique({
      where: { email: normalizedEmail },
    });

    // Same answer for unknown, already-verified and pending accounts.
    if (!user || user.isEmailVerified) {
      return res.status(200).json({ success: true, message: RESEND_ACCEPTED });
    }

    const limitCheck = checkOtpDailyLimit(user);
    if (!limitCheck.allowed) {
      return res.status(429).json({
        success: false,
        message: limitCheck.message,
      });
    }

    // Codes are stored hashed, so a resend always issues a new one (the old one stops working).
    const newOtp = await issueSignupOtp(user.userId, limitCheck.newCount);

    try {
      await sendOtpWithTimeout({
        email: normalizedEmail,
        otp: newOtp,
        firstName: user.firstName,
      });
    } catch (emailErr) {
      console.error("[AUTH_RESEND] OTP Email error/timeout:", emailErr?.message || emailErr);
      return res.status(500).json({
        success: false,
        message: "Failed to send verification code email. Please try again in a moment.",
      });
    }

    return res.status(200).json({ success: true, message: RESEND_ACCEPTED });
  } catch (error) {
    next(error);
  }
};

// POST /api/auth/login
export const login = async (req, res, next) => {
  try {
    const { email, password } = req.body;

    if (typeof email !== "string" || typeof password !== "string" || !email.trim() || !password) {
      return res.status(400).json({
        success: false,
        message: "Email and password are required.",
      });
    }

    const normalizedEmail = email.trim().toLowerCase();
    const user = await prisma.user.findUnique({
      where: { email: normalizedEmail },
    });

    // Unknown email, Google/Clerk-only account and wrong password all look the
    // same (status, message and timing) — no account or provider disclosure.
    const hasPassword =
      user?.passwordHash &&
      !user.passwordHash.startsWith("managed-by-") &&
      !user.passwordHash.startsWith("managed_");
    const isMatch = await bcrypt.compare(password, hasPassword ? user.passwordHash : DUMMY_PASSWORD_HASH);

    if (!hasPassword || !isMatch) {
      return res.status(401).json({ success: false, message: INVALID_CREDENTIALS });
    }

    if (!user.isEmailVerified) {
      const limitCheck = checkOtpDailyLimit(user);
      if (!limitCheck.allowed) {
        return res.status(429).json({
          success: false,
          requiresVerification: true,
          email: normalizedEmail,
          message: limitCheck.message,
        });
      }

      const otp = await issueSignupOtp(user.userId, limitCheck.newCount);

      try {
        await sendOtpWithTimeout({
          email: normalizedEmail,
          otp,
          firstName: user.firstName,
        });
      } catch (emailErr) {
        console.error("[AUTH_LOGIN_OTP] Email error/timeout:", emailErr?.message || emailErr);
      }

      return res.status(403).json({
        success: false,
        requiresVerification: true,
        email: normalizedEmail,
        message: "Please verify your email address to complete sign in.",
      });
    }

    // Second factor: password alone never yields a session for admins (or for
    // anyone while LOGIN_OTP_ENABLED). The code goes to the account's email.
    if (user.role === "admin" || LOGIN_OTP_ENABLED) {
      let otp;
      try {
        otp = await issuePurposeOtp(user, "login");
        if (otp) {
          await sendWithTimeout(
            sendPurposeOtpEmail({ email: normalizedEmail, otp, firstName: user.firstName, purpose: "login" })
          );
        }
      } catch (emailErr) {
        console.error("[AUTH_LOGIN_2FA] Email error/timeout:", emailErr?.message || emailErr);
        return res.status(500).json({
          success: false,
          message: "Failed to send the sign-in code. Please try again in a moment.",
        });
      }
      return res.status(200).json({
        success: true,
        requiresLoginOtp: true,
        email: normalizedEmail,
        message: otp
          ? "Enter the 6-digit sign-in code sent to your email."
          : "A sign-in code was sent recently. Check your email, or wait a minute to request a new one.",
      });
    }

    return sendSession(res, user, "Logged in successfully");
  } catch (error) {
    next(error);
  }
};

// POST /api/auth/login/verify-otp - second step of sign-in
export const verifyLoginOtp = async (req, res, next) => {
  try {
    const { email, otp } = req.body;
    if (typeof email !== "string" || typeof otp !== "string" || !email.trim() || !otp.trim()) {
      return res.status(400).json({ success: false, message: "Email and OTP code are required." });
    }

    const user = await prisma.user.findUnique({ where: { email: email.trim().toLowerCase() } });
    if (!(await consumePurposeOtp(user, "login", otp.trim()))) {
      return res.status(400).json({ success: false, message: INVALID_OTP });
    }

    return sendSession(res, user, "Logged in successfully");
  } catch (error) {
    next(error);
  }
};

// POST /api/auth/forgot-password - always answers the same way (no account disclosure)
export const forgotPassword = async (req, res, next) => {
  try {
    const { email } = req.body;
    if (typeof email !== "string" || !email.trim()) {
      return res.status(400).json({ success: false, message: "Email is required." });
    }

    const normalizedEmail = email.trim().toLowerCase();
    const user = await prisma.user.findUnique({ where: { email: normalizedEmail } });

    if (user && user.isEmailVerified) {
      const otp = await issuePurposeOtp(user, "reset");
      if (otp) {
        // Not awaited: SMTP latency must not reveal whether the account exists.
        sendWithTimeout(
          sendPurposeOtpEmail({ email: normalizedEmail, otp, firstName: user.firstName, purpose: "reset" })
        ).catch((err) => console.error("[AUTH_FORGOT] Email error/timeout:", err?.message || err));
      }
    }

    return res.status(200).json({ success: true, message: GENERIC_RESET_ACCEPTED });
  } catch (error) {
    next(error);
  }
};

// POST /api/auth/reset-password
export const resetPassword = async (req, res, next) => {
  try {
    const { email, otp, newPassword } = req.body;
    if (
      typeof email !== "string" || typeof otp !== "string" || typeof newPassword !== "string" ||
      !email.trim() || !otp.trim()
    ) {
      return res.status(400).json({ success: false, message: "Email, OTP code and new password are required." });
    }
    if (newPassword.length < MIN_PASSWORD_LENGTH || newPassword.length > 128) {
      return res.status(400).json({
        success: false,
        message: `Password must be between ${MIN_PASSWORD_LENGTH} and 128 characters long.`,
      });
    }

    const user = await prisma.user.findUnique({ where: { email: email.trim().toLowerCase() } });
    const passwordHash = await bcrypt.hash(newPassword, BCRYPT_ROUNDS);
    // A reset usually means the old password may be known to someone else, so
    // every existing session ends with it. One transaction: the new password,
    // the used code and the revocation all commit, or none do.
    const reset = await prisma.$transaction(async (tx) => {
      if (!(await consumePurposeOtp(user, "reset", otp.trim(), { passwordHash }, tx))) return false;
      await revokeAllSessions(user.userId, tx);
      return true;
    });
    if (!reset) {
      return res.status(400).json({ success: false, message: INVALID_OTP });
    }

    return res.status(200).json({ success: true, message: "Password updated. Please sign in with your new password." });
  } catch (error) {
    next(error);
  }
};

export const getMe = async (req, res, next) => {
  try {
    // protect already populated req.user, but re-read with the exam relation
    // so the client can use targetExam.targetCode rather than mapping ids.
    const user = await authService.getUserWithExam(req.user.userId);
    return res.status(200).json({
      success: true,
      user: user || toPublicUser(req.user),
    });
  } catch (error) {
    next(error);
  }
};

// PATCH /api/auth/me
export const updateMe = async (req, res, next) => {
  try {
    const user = await authService.updateOwnProfile(req.user.userId, req.body);
    return res.status(200).json({
      success: true,
      message: "Profile updated successfully",
      user,
    });
  } catch (error) {
    next(error);
  }
};

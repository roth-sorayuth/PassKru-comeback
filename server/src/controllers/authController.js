import bcrypt from "bcryptjs";
import jwt from "jsonwebtoken";
import crypto from "crypto";
import { prisma } from "../config/prisma.js";
import * as authService from "../services/authService.js";
import { sendVerificationOtpEmail, sendAccountExistsEmail } from "../services/emailService.js";
import { toPublicUser } from "../utils/publicUser.js";

const JWT_SECRET = process.env.JWT_SECRET;
const MAX_OTP_PER_DAY = 4;

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
const DUMMY_PASSWORD_HASH = bcrypt.hashSync(crypto.randomBytes(16).toString("hex"), 10);

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

    if (password.length < 6) {
      return res.status(400).json({
        success: false,
        message: "Password must be at least 6 characters long.",
      });
    }

    const normalizedEmail = email.trim().toLowerCase();
    const existingUser = await prisma.user.findUnique({
      where: { email: normalizedEmail },
    });

    if (existingUser && existingUser.isEmailVerified) {
      // Answer exactly like a fresh signup so the response doesn't reveal the
      // email is registered; the owner gets a "you already have an account" email.
      try {
        await sendWithTimeout(sendAccountExistsEmail({ email: normalizedEmail }));
      } catch (emailError) {
        console.error("[AUTH_REGISTER] Account-exists email error/timeout:", emailError?.message || emailError);
        return res.status(500).json({ success: false, message: REGISTER_EMAIL_FAILED });
      }
      return res.status(201).json(registerAccepted(normalizedEmail));
    }

    const passwordHash = await bcrypt.hash(password, 10);
    const otp = generate6DigitOtp();
    const otpExpiresAt = new Date(Date.now() + 10 * 60 * 1000); // 10 minutes
    const now = new Date();

    let user;
    let isNewUser = false;

    if (existingUser && !existingUser.isEmailVerified) {
      // Re-initialize registration details & OTP for unverified account
      user = await prisma.user.update({
        where: { userId: existingUser.userId },
        data: {
          firstName: firstName.trim(),
          lastName: lastName.trim(),
          phoneNumber: phoneNumber ? phoneNumber.trim() : null,
          passwordHash,
          verificationOtp: otp,
          otpExpiresAt,
          otpCount: 1,
          otpLastSentAt: now,
        },
      });
    } else {
      isNewUser = true;
      user = await prisma.user.create({
        data: {
          firstName: firstName.trim(),
          lastName: lastName.trim(),
          email: normalizedEmail,
          phoneNumber: phoneNumber ? phoneNumber.trim() : null,
          passwordHash,
          role: "candidate",
          isEmailVerified: false,
          verificationOtp: otp,
          otpExpiresAt,
          otpCount: 1,
          otpLastSentAt: now,
        },
      });
    }

    try {
      await sendOtpWithTimeout({
        email: normalizedEmail,
        otp,
        firstName: firstName.trim(),
      });
    } catch (emailError) {
      console.error("[AUTH_REGISTER] OTP Email error/timeout:", emailError?.message || emailError);
      // Rollback newly created user if email sending fails completely
      if (isNewUser && user?.userId) {
        await prisma.user.delete({ where: { userId: user.userId } }).catch(() => {});
      }
      return res.status(500).json({
        success: false,
        message: emailError?.message || REGISTER_EMAIL_FAILED,
      });
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
      otpMatches(user.verificationOtp, submittedOtp);

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

    const token = jwt.sign(
      { userId: user.userId, email: user.email },
      JWT_SECRET,
      { expiresIn: "7d" }
    );

    const isProduction = process.env.NODE_ENV === "production";
    res.cookie("token", token, {
      httpOnly: true,
      secure: isProduction,
      sameSite: isProduction ? "none" : "lax", // "none" required for cross-origin (Vercel → Railway)
      maxAge: 7 * 24 * 60 * 60 * 1000,
    });

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

    const existingOtpExpires = user.otpExpiresAt ? new Date(user.otpExpiresAt).getTime() : 0;
    const isExistingValid = Boolean(user.verificationOtp && existingOtpExpires > Date.now());

    const newOtp = isExistingValid ? user.verificationOtp : generate6DigitOtp();
    const otpExpiresAt = isExistingValid ? user.otpExpiresAt : new Date(Date.now() + 10 * 60 * 1000);

    await prisma.user.update({
      where: { userId: user.userId },
      data: {
        verificationOtp: newOtp,
        otpExpiresAt,
        otpCount: limitCheck.newCount,
        otpLastSentAt: limitCheck.now,
      },
    });

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
        message: emailErr?.message || "Failed to send verification code email. Please try again in a moment.",
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

      const existingOtpExpires = user.otpExpiresAt ? new Date(user.otpExpiresAt).getTime() : 0;
      const isExistingValid = Boolean(user.verificationOtp && existingOtpExpires > Date.now());

      const otp = isExistingValid ? user.verificationOtp : generate6DigitOtp();
      const otpExpiresAt = isExistingValid ? user.otpExpiresAt : new Date(Date.now() + 10 * 60 * 1000);

      await prisma.user.update({
        where: { userId: user.userId },
        data: {
          verificationOtp: otp,
          otpExpiresAt,
          otpCount: limitCheck.newCount,
          otpLastSentAt: limitCheck.now,
        },
      });

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

    const token = jwt.sign(
      { userId: user.userId, email: user.email },
      JWT_SECRET,
      { expiresIn: "7d" }
    );

    const isProduction = process.env.NODE_ENV === "production";
    res.cookie("token", token, {
      httpOnly: true,
      secure: isProduction,
      sameSite: isProduction ? "none" : "lax", // "none" required for cross-origin (Vercel → Railway)
      maxAge: 7 * 24 * 60 * 60 * 1000,
    });

    const userWithExam = await authService.getUserWithExam(user.userId);

    return res.status(200).json({
      success: true,
      message: "Logged in successfully",
      token,
      user: userWithExam || toPublicUser(user),
    });
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

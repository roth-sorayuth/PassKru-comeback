import bcrypt from "bcryptjs";
import jwt from "jsonwebtoken";
import crypto from "crypto";
import { prisma } from "../config/prisma.js";
import * as authService from "../services/authService.js";
import { sendVerificationOtpEmail } from "../services/emailService.js";

const JWT_SECRET = process.env.JWT_SECRET;
const MAX_OTP_PER_DAY = 4;

function generate6DigitOtp() {
  return crypto.randomInt(100000, 1000000).toString();
}

/**
 * Sends OTP email with strict execution time limit (6 seconds max)
 */
async function sendOtpWithTimeout(params, timeoutMs = 6000) {
  return Promise.race([
    sendVerificationOtpEmail(params),
    new Promise((_, reject) =>
      setTimeout(() => reject(new Error(`Email OTP sending timed out after ${timeoutMs / 1000}s`)), timeoutMs)
    ),
  ]);
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

// POST /api/auth/register
export const register = async (req, res, next) => {
  try {
    const { firstName, lastName, email, password, phoneNumber } = req.body;

    if (!firstName || !lastName || !email || !password) {
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
      return res.status(400).json({
        success: false,
        message: "An account with this email address already exists. Please sign in.",
      });
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
      }, 6000);
    } catch (emailError) {
      console.error("[AUTH_REGISTER] OTP Email error/timeout:", emailError?.message || emailError);
      // Rollback newly created user if email sending fails completely
      if (isNewUser && user?.userId) {
        await prisma.user.delete({ where: { userId: user.userId } }).catch(() => {});
      }
      return res.status(500).json({
        success: false,
        message: "Failed to send verification code email within time limit. Please check your email address and try again.",
      });
    }

    return res.status(201).json({
      success: true,
      requiresVerification: true,
      email: normalizedEmail,
      message: "Registration successful. Please enter the 6-digit verification code sent to your email.",
    });
  } catch (error) {
    next(error);
  }
};

// POST /api/auth/verify-otp
export const verifyOtp = async (req, res, next) => {
  try {
    const { email, otp } = req.body;

    if (!email || !otp) {
      return res.status(400).json({
        success: false,
        message: "Email and OTP code are required.",
      });
    }

    const normalizedEmail = email.trim().toLowerCase();
    const user = await prisma.user.findUnique({
      where: { email: normalizedEmail },
    });

    if (!user) {
      return res.status(404).json({
        success: false,
        message: "User account not found.",
      });
    }

    if (user.isEmailVerified) {
      // User is already verified, proceed to generate token
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
        message: "Email already verified.",
        token,
        user: userWithExam || user,
      });
    }

    if (!user.verificationOtp || user.verificationOtp !== otp.trim()) {
      return res.status(400).json({
        success: false,
        message: "Invalid verification code. Please check and try again.",
      });
    }

    const otpExpiresTime = user.otpExpiresAt ? new Date(user.otpExpiresAt).getTime() : 0;
    if (!otpExpiresTime || Date.now() > otpExpiresTime) {
      return res.status(400).json({
        success: false,
        message: "Verification code has expired. Please request a new code.",
      });
    }

    const updatedUser = await prisma.user.update({
      where: { userId: user.userId },
      data: {
        isEmailVerified: true,
        verificationOtp: null,
        otpExpiresAt: null,
        otpCount: 0,
        otpLastSentAt: null,
      },
    });

    const token = jwt.sign(
      { userId: updatedUser.userId, email: updatedUser.email },
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

    const userWithExam = await authService.getUserWithExam(updatedUser.userId);

    return res.status(200).json({
      success: true,
      message: "Email verified successfully!",
      token,
      user: userWithExam || updatedUser,
    });
  } catch (error) {
    next(error);
  }
};

// POST /api/auth/resend-otp
export const resendOtp = async (req, res, next) => {
  try {
    const { email } = req.body;

    if (!email) {
      return res.status(400).json({
        success: false,
        message: "Email is required.",
      });
    }

    const normalizedEmail = email.trim().toLowerCase();
    const user = await prisma.user.findUnique({
      where: { email: normalizedEmail },
    });

    if (!user) {
      return res.status(404).json({
        success: false,
        message: "User account not found.",
      });
    }

    if (user.isEmailVerified) {
      return res.status(400).json({
        success: false,
        message: "Your email is already verified. You can log in directly.",
      });
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
      }, 6000);
    } catch (emailErr) {
      console.error("[AUTH_RESEND] OTP Email error/timeout:", emailErr?.message || emailErr);
      return res.status(500).json({
        success: false,
        message: "Failed to send verification code email. Please try again in a moment.",
      });
    }

    return res.status(200).json({
      success: true,
      message: `A new verification code has been sent to your email. (${limitCheck.newCount}/${MAX_OTP_PER_DAY} daily attempts used)`,
    });
  } catch (error) {
    next(error);
  }
};

// POST /api/auth/login
export const login = async (req, res, next) => {
  try {
    const { email, password } = req.body;

    if (!email || !password) {
      return res.status(400).json({
        success: false,
        message: "Email and password are required.",
      });
    }

    const normalizedEmail = email.trim().toLowerCase();
    const user = await prisma.user.findUnique({
      where: { email: normalizedEmail },
    });

    if (!user) {
      return res.status(401).json({
        success: false,
        message: "Invalid email or password.",
      });
    }

    if (
      !user.passwordHash ||
      user.passwordHash.startsWith("managed-by-") ||
      user.passwordHash.startsWith("managed_")
    ) {
      return res.status(400).json({
        success: false,
        message: "This account uses Google or Clerk authentication. Please sign in using Google.",
      });
    }

    const isMatch = await bcrypt.compare(password, user.passwordHash);
    if (!isMatch) {
      return res.status(401).json({
        success: false,
        message: "Invalid email or password.",
      });
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
        }, 6000);
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
      user: userWithExam || user,
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
      user: user || req.user,
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

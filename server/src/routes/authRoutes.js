import { Router } from "express";
import passport from "passport";
import jwt from "jsonwebtoken";
import { getMe, updateMe, register, login, verifyOtp, resendOtp, verifyLoginOtp, forgotPassword, resetPassword } from "../controllers/authController.js";
import crypto from "crypto";
import { protect } from "../middlewares/authMiddleware.js";
import { authLimiter, otpVerifyLimiter, otpResendLimiter, forgotPasswordLimiter } from "../middlewares/rateLimit.js";
import * as authService from "../services/authService.js";
import { safeOrigin } from "../config/origins.js";

const router = Router();
const JWT_SECRET = process.env.JWT_SECRET;
const FRONTEND_URL = process.env.FRONTEND_URL || "http://localhost:3000";

// Google sign-in hands the browser a single-use, 60s token instead of the 7-day
// session JWT itself, so long-lived credentials never sit in URL history or logs.
// Using a signed 60s JWT ensures exchanges survive server restarts and redeployments.
const GOOGLE_CODE_TTL_MS = 60 * 1000;
const usedExchangeCodes = new Set();

function issueGoogleLoginCode(userId) {
  return jwt.sign(
    { purpose: "google_exchange", userId },
    JWT_SECRET,
    { expiresIn: "60s" }
  );
}

// POST /api/auth/register
router.post("/register", authLimiter, register);

// POST /api/auth/login
router.post("/login", authLimiter, login);

// POST /api/auth/login/verify-otp - completes sign-in with the emailed code
router.post("/login/verify-otp", authLimiter, otpVerifyLimiter, verifyLoginOtp);

// POST /api/auth/forgot-password - emails a reset code (same answer for any email)
router.post("/forgot-password", authLimiter, forgotPasswordLimiter, forgotPassword);

// POST /api/auth/reset-password - sets a new password with the emailed code
router.post("/reset-password", authLimiter, otpVerifyLimiter, resetPassword);

// POST /api/auth/verify-otp
router.post("/verify-otp", authLimiter, otpVerifyLimiter, verifyOtp);

// POST /api/auth/resend-otp
router.post("/resend-otp", authLimiter, otpResendLimiter, resendOtp);

// POST /api/auth/google/exchange — trades the 60s exchange code for the 7-day session token.
router.post("/google/exchange", authLimiter, async (req, res, next) => {
  try {
    const code = typeof req.body?.code === "string" ? req.body.code.trim() : "";
    if (!code || usedExchangeCodes.has(code)) {
      return res.status(400).json({ success: false, message: "Sign-in link is invalid or has expired. Please try again." });
    }

    let decoded;
    try {
      decoded = jwt.verify(code, JWT_SECRET);
    } catch (jwtErr) {
      return res.status(400).json({ success: false, message: "Sign-in link is invalid or has expired. Please try again." });
    }

    if (decoded?.purpose !== "google_exchange" || !decoded?.userId) {
      return res.status(400).json({ success: false, message: "Invalid sign-in link. Please try again." });
    }

    usedExchangeCodes.add(code);
    setTimeout(() => usedExchangeCodes.delete(code), GOOGLE_CODE_TTL_MS);

    const user = await authService.getUserWithExam(decoded.userId);
    if (!user) {
      return res.status(404).json({ success: false, message: "User not found." });
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
      sameSite: isProduction ? "none" : "lax",
      maxAge: 7 * 24 * 60 * 60 * 1000,
    });

    return res.status(200).json({ success: true, token, user });
  } catch (error) {
    next(error);
  }
});

// GET /api/auth/google
router.get("/google", (req, res, next) => {
  // Only allowlisted origins may receive the sign-in code; anything else falls
  // back to the default frontend (otherwise ?returnTo=https://evil.example
  // would hand the victim's login code to an attacker).
  const returnTo =
    safeOrigin(req.query.returnTo) || safeOrigin(FRONTEND_URL) || "http://localhost:3000";

  passport.authenticate("google", {
    scope: ["profile", "email"],
    session: false,
    state: returnTo,
  })(req, res, next);
});

// GET /api/auth/google/callback
router.get("/google/callback", (req, res, next) => {
  passport.authenticate("google", { session: false }, async (err, user, info) => {
    // `state` round-trips through the browser, so re-validate it here too.
    const targetUrl =
      safeOrigin(req.query.state) || safeOrigin(FRONTEND_URL) || "http://localhost:3000";

    if (err || !user) {
      console.error("Google OAuth authentication error:", err || info);
      const errorMessage = err?.message || "auth_failed";
      return res.redirect(`${targetUrl}/login?error=${encodeURIComponent(errorMessage)}`);
    }

    // Admin sessions require the emailed sign-in code, which the Google flow
    // does not collect, so admins must use password + OTP sign-in.
    if (user.role === "admin") {
      return res.redirect(`${targetUrl}/login?error=${encodeURIComponent("admin_use_password_login")}`);
    }

    try {
      // Sign a 7-day JWT token with userId + email
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
        maxAge: 7 * 24 * 60 * 60 * 1000, // 7 days
      });

      const code = issueGoogleLoginCode(user.userId);
      return res.redirect(`${targetUrl}/dashboard?authCode=${encodeURIComponent(code)}`);
    } catch (error) {
      console.error("Google OAuth token creation error:", error);
      return res.redirect(`${targetUrl}/login?error=server_error`);
    }
  })(req, res, next);
});

// GET /api/auth/me (Protected, returns user profile + target exam relations)
router.get("/me", protect, getMe);

// PATCH /api/auth/me (Protected, updates candidate profile & subject selections)
router.patch("/me", protect, updateMe);

// POST /api/auth/logout
router.post("/logout", (req, res) => {
  const isProduction = process.env.NODE_ENV === "production";
  res.clearCookie("token", {
    httpOnly: true,
    secure: isProduction,
    sameSite: isProduction ? "none" : "lax",
  });
  return res.json({ success: true, message: "Logged out successfully" });
});

export default router;

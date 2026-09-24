import { Router } from "express";
import passport from "passport";
import jwt from "jsonwebtoken";
import { getMe, updateMe, register, login, verifyOtp, resendOtp } from "../controllers/authController.js";
import crypto from "crypto";
import { protect } from "../middlewares/authMiddleware.js";
import { authLimiter, otpVerifyLimiter, otpResendLimiter } from "../middlewares/rateLimit.js";
import * as authService from "../services/authService.js";

const router = Router();
const JWT_SECRET = process.env.JWT_SECRET;
const FRONTEND_URL = process.env.FRONTEND_URL || "http://localhost:3000";

// Google sign-in hands the browser a single-use, 60s code instead of the JWT
// itself, so the session token never sits in a URL (history, logs, Referer).
// In-memory: fine for one instance; a restart only voids codes in flight.
const GOOGLE_CODE_TTL_MS = 60 * 1000;
const googleLoginCodes = new Map();

function issueGoogleLoginCode(token, userId) {
  const now = Date.now();
  for (const [key, entry] of googleLoginCodes) {
    if (entry.expiresAt <= now) googleLoginCodes.delete(key);
  }
  const code = crypto.randomBytes(32).toString("base64url");
  googleLoginCodes.set(code, { token, userId, expiresAt: now + GOOGLE_CODE_TTL_MS });
  return code;
}

// POST /api/auth/register
router.post("/register", authLimiter, register);

// POST /api/auth/login
router.post("/login", authLimiter, login);

// POST /api/auth/verify-otp
router.post("/verify-otp", authLimiter, otpVerifyLimiter, verifyOtp);

// POST /api/auth/resend-otp
router.post("/resend-otp", authLimiter, otpResendLimiter, resendOtp);

// POST /api/auth/google/exchange — trades the one-time code from the Google
// redirect for the session token.
router.post("/google/exchange", authLimiter, async (req, res, next) => {
  try {
    const code = typeof req.body?.code === "string" ? req.body.code : "";
    const entry = googleLoginCodes.get(code);
    googleLoginCodes.delete(code);

    if (!entry || entry.expiresAt <= Date.now()) {
      return res.status(400).json({ success: false, message: "Sign-in link is invalid or has expired. Please try again." });
    }

    const user = await authService.getUserWithExam(entry.userId);
    return res.status(200).json({ success: true, token: entry.token, user });
  } catch (error) {
    next(error);
  }
});

// GET /api/auth/google
router.get(
  "/google",
  passport.authenticate("google", { scope: ["profile", "email"], session: false })
);

// GET /api/auth/google/callback
router.get("/google/callback", (req, res, next) => {
  passport.authenticate("google", { session: false }, async (err, user, info) => {
    if (err || !user) {
      console.error("Google OAuth authentication error:", err || info);
      const errorMessage = err?.message || "auth_failed";
      return res.redirect(`${FRONTEND_URL}/login?error=${encodeURIComponent(errorMessage)}`);
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

      const code = issueGoogleLoginCode(token, user.userId);
      return res.redirect(`${FRONTEND_URL}/dashboard?authCode=${encodeURIComponent(code)}`);
    } catch (error) {
      console.error("Google OAuth token creation error:", error);
      return res.redirect(`${FRONTEND_URL}/login?error=server_error`);
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

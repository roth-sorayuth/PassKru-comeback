import { Router } from "express";
import passport from "passport";
import { getMe, updateMe, register, login, verifyOtp, resendOtp, verifyLoginOtp, forgotPassword, resetPassword } from "../controllers/authController.js";
import { protect } from "../middlewares/authMiddleware.js";
import { authLimiter, otpVerifyLimiter, otpResendLimiter, forgotPasswordLimiter, exchangeLimiter } from "../middlewares/rateLimit.js";
import * as authService from "../services/authService.js";
import { startSession, endSession, issueGoogleExchangeCode, redeemGoogleExchangeCode } from "../services/sessionService.js";
import { safeOrigin } from "../config/origins.js";

const router = Router();
const FRONTEND_URL = process.env.FRONTEND_URL || "http://localhost:3000";

const EXCHANGE_FAILED = "Sign-in link is invalid or has expired. Please try again.";

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

// POST /api/auth/google/exchange — trades the 60s single-use code from the
// Google callback for a session. The code is consumed atomically (see
// sessionService), so a replay fails even after a restart.
router.post("/google/exchange", exchangeLimiter, async (req, res, next) => {
  try {
    const code = typeof req.body?.code === "string" ? req.body.code.trim() : "";
    const userId = code ? await redeemGoogleExchangeCode(code) : null;
    if (!userId) {
      return res.status(400).json({ success: false, message: EXCHANGE_FAILED });
    }

    const user = await authService.getUserById(userId);
    if (!user) {
      return res.status(400).json({ success: false, message: EXCHANGE_FAILED });
    }

    const token = await startSession(res, user);
    const userWithExam = await authService.getUserWithExam(user.userId);
    return res.status(200).json({ success: true, token, user: userWithExam });
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

    try {
      // No session yet: it is created when the frontend redeems this code, so
      // an abandoned redirect never leaves a live 7-day session behind.
      const code = await issueGoogleExchangeCode(user.userId);
      return res.redirect(`${targetUrl}/dashboard?authCode=${encodeURIComponent(code)}`);
    } catch (error) {
      console.error("Google OAuth exchange-code error:", error);
      return res.redirect(`${targetUrl}/login?error=server_error`);
    }
  })(req, res, next);
});

// GET /api/auth/me (Protected, returns user profile + target exam relations)
router.get("/me", protect, getMe);

// PATCH /api/auth/me (Protected, updates candidate profile & subject selections)
router.patch("/me", protect, updateMe);

// POST /api/auth/logout — ends this session server-side, so the token stops
// working everywhere it was copied (cookie or localStorage).
router.post("/logout", async (req, res) => {
  await endSession(req, res);
  return res.json({ success: true, message: "Logged out successfully" });
});

export default router;

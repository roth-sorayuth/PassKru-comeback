import { Router } from "express";
import passport from "passport";
import jwt from "jsonwebtoken";
import { getMe, updateMe, register, login, verifyOtp, resendOtp } from "../controllers/authController.js";
import { protect } from "../middlewares/authMiddleware.js";

const router = Router();
const JWT_SECRET = process.env.JWT_SECRET;
const FRONTEND_URL = process.env.FRONTEND_URL || "http://localhost:3000";

// POST /api/auth/register
router.post("/register", register);

// POST /api/auth/login
router.post("/login", login);

// POST /api/auth/verify-otp
router.post("/verify-otp", verifyOtp);

// POST /api/auth/resend-otp
router.post("/resend-otp", resendOtp);

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

      return res.redirect(`${FRONTEND_URL}/dashboard?token=${token}`);
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

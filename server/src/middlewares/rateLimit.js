import { rateLimit, ipKeyGenerator } from "express-rate-limit";

// Counters live in process memory: they reset on restart and are per instance.
// Move to a shared store (e.g. Redis) if the API ever runs on more than one instance.

const TOO_MANY = {
  success: false,
  message: "Too many attempts. Please wait a while and try again.",
};

const emailKey = (req) => String(req.body?.email || "").trim().toLowerCase();

/** Broad limit for every /api/auth/* route, keyed per IP + email. */
export const authLimiter = rateLimit({
  windowMs: 15 * 60 * 1000,
  limit: 20,
  standardHeaders: "draft-7",
  legacyHeaders: false,
  keyGenerator: (req) => `${ipKeyGenerator(req.ip)}|${emailKey(req)}`,
  message: TOO_MANY,
});

/**
 * Per-account cap on OTP guesses. Keyed by email alone so rotating IPs does
 * not help brute-force a 6-digit code. Successful verifications don't count.
 */
export const otpVerifyLimiter = rateLimit({
  windowMs: 60 * 60 * 1000,
  limit: 5,
  standardHeaders: "draft-7",
  legacyHeaders: false,
  skipSuccessfulRequests: true,
  keyGenerator: (req) => `verify|${emailKey(req) || ipKeyGenerator(req.ip)}`,
  message: TOO_MANY,
});

/**
 * Per-user daily cap on endpoints that call Gemini (billed per request), so one
 * account in a loop can't run up the bill. Must run after `protect`.
 */
export const aiLimiter = rateLimit({
  windowMs: 24 * 60 * 60 * 1000,
  limit: 15,
  standardHeaders: "draft-7",
  legacyHeaders: false,
  keyGenerator: (req) => `ai|${req.user?.userId ?? ipKeyGenerator(req.ip)}`,
  message: { success: false, message: "Daily limit reached for AI generation. Please try again tomorrow." },
});

/** Per-user daily cap on mentor consultation requests (spam guard). Must run after `protect`. */
export const bookingLimiter = rateLimit({
  windowMs: 24 * 60 * 60 * 1000,
  limit: 10,
  standardHeaders: "draft-7",
  legacyHeaders: false,
  keyGenerator: (req) => `booking|${req.user?.userId ?? ipKeyGenerator(req.ip)}`,
  message: { success: false, message: "Daily limit reached for consultation requests. Please try again tomorrow." },
});

/** Per-account cap on OTP (re)sends, on top of the 4-per-day DB counter. */
export const otpResendLimiter = rateLimit({
  windowMs: 60 * 60 * 1000,
  limit: 5,
  standardHeaders: "draft-7",
  legacyHeaders: false,
  keyGenerator: (req) => `resend|${emailKey(req) || ipKeyGenerator(req.ip)}`,
  message: TOO_MANY,
});

/** Per-account cap on password-reset emails, regardless of IP. */
export const forgotPasswordLimiter = rateLimit({
  windowMs: 60 * 60 * 1000,
  limit: 5,
  standardHeaders: "draft-7",
  legacyHeaders: false,
  keyGenerator: (req) => `forgot|${emailKey(req) || ipKeyGenerator(req.ip)}`,
  message: TOO_MANY,
});

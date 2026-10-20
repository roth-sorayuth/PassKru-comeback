import * as authService from "../services/authService.js";
import { verifySessionToken, tokensFromRequest } from "../services/sessionService.js";

const MESSAGES = {
  missing: "Missing authentication token",
  expired: "Session expired. Please sign in again.",
  invalid: "Auth failed",
};

/**
 * Resolves the signed-in user from the session cookie, falling back to the
 * Bearer header (browsers that block third-party cookies). A stale cookie
 * doesn't hide a valid Bearer token. Returns { user } or { error }.
 */
async function resolveUser(req) {
  const candidates = tokensFromRequest(req);
  if (!candidates.length) return { error: "missing" };

  let error = "invalid";
  for (const token of candidates) {
    const result = await verifySessionToken(token);
    if (result.userId) {
      const user = await authService.getUserById(result.userId);
      if (!user) return { error: "invalid" };
      return { user, sid: result.sid };
    }
    if (result.error === "expired") error = "expired";
  }
  return { error };
}

export const protect = async (req, res, next) => {
  try {
    const { user, sid, error } = await resolveUser(req);
    if (!user) {
      return res.status(401).json({ success: false, message: MESSAGES[error] || MESSAGES.invalid });
    }

    req.user = user;
    req.auth = {
      userId: user.userId,
      dbUserId: user.userId,
      sessionId: sid,
    };

    next();
  } catch (error) {
    console.error("[protect] Auth failed:", error?.message || error);
    return res.status(401).json({ success: false, message: MESSAGES.invalid });
  }
};

export const optionalProtect = async (req, res, next) => {
  try {
    const { user, sid } = await resolveUser(req);
    req.user = user || null;
    req.auth = user ? { userId: user.userId, dbUserId: user.userId, sessionId: sid } : null;
    next();
  } catch (error) {
    req.user = null;
    next();
  }
};

export const admin = (req, res, next) => {
  if (req.user && req.user.role === "admin") {
    next();
  } else {
    return res.status(403).json({
      success: false,
      message: "Not authorized as an admin",
    });
  }
};

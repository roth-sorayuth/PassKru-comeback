import jwt from "jsonwebtoken";
import { prisma } from "../config/prisma.js";

/**
 * Server-side sessions.
 *
 * Every sign-in creates a row in `sessions`; the JWT only carries its id
 * (`sid`). A token is honoured while that row exists and hasn't expired, so
 * logging out, resetting a password or an admin changing someone's role/email
 * ends those sessions immediately instead of leaving a 7-day bearer token alive.
 *
 * Tokens issued before this existed have no `sid` and are rejected, which signs
 * everyone out once when this ships.
 */

const JWT_SECRET = process.env.JWT_SECRET;
const SESSION_TTL_MS = 7 * 24 * 60 * 60 * 1000;
const GOOGLE_EXCHANGE_TTL_MS = 60 * 1000;
const SESSION_TYP = "session";
const GOOGLE_EXCHANGE_TYP = "google_exchange";

const isProduction = () => process.env.NODE_ENV === "production";

function cookieOptions() {
  return {
    httpOnly: true,
    secure: isProduction(),
    sameSite: isProduction() ? "none" : "lax", // "none" required for cross-origin (Vercel -> Railway)
  };
}

/**
 * Candidate session tokens on a request: the cookie first, then the Bearer
 * header (fallback for browsers that block third-party cookies).
 */
export function tokensFromRequest(req) {
  const header = req.headers.authorization;
  return [req.cookies?.token, header?.startsWith("Bearer ") ? header.slice(7).trim() : null].filter(Boolean);
}

/** Creates a session row, signs its token and sets the cookie. Returns the token. */
export async function startSession(res, user) {
  const expiresAt = new Date(Date.now() + SESSION_TTL_MS);
  // Expired rows are useless; clear this user's while we're here.
  await prisma.session.deleteMany({ where: { userId: user.userId, expiresAt: { lt: new Date() } } });
  const session = await prisma.session.create({ data: { userId: user.userId, expiresAt } });

  const token = jwt.sign({ typ: SESSION_TYP, sid: session.id, userId: user.userId }, JWT_SECRET, {
    algorithm: "HS256",
    expiresIn: Math.floor(SESSION_TTL_MS / 1000),
  });
  res.cookie("token", token, { ...cookieOptions(), maxAge: SESSION_TTL_MS });
  return token;
}

function decode(token, typ) {
  try {
    const decoded = jwt.verify(token, JWT_SECRET, { algorithms: ["HS256"] });
    return decoded?.typ === typ && typeof decoded.sid === "string" ? decoded : null;
  } catch (error) {
    return error?.name === "TokenExpiredError" ? { expired: true } : null;
  }
}

/**
 * Resolves a session token to its userId, or explains why not.
 * @returns {Promise<{ userId: number, sid: string } | { error: "missing" | "invalid" | "expired" }>}
 */
export async function verifySessionToken(token) {
  if (!token) return { error: "missing" };
  const decoded = decode(token, SESSION_TYP);
  if (!decoded) return { error: "invalid" };
  if (decoded.expired) return { error: "expired" };

  const session = await prisma.session.findUnique({ where: { id: decoded.sid } }).catch(() => null);
  if (!session || session.userId !== decoded.userId) return { error: "invalid" };
  if (session.expiresAt.getTime() <= Date.now()) return { error: "expired" };
  return { userId: session.userId, sid: session.id };
}

/** Ends the request's session(s) — cookie and Bearer token alike — and clears the cookie. Never throws. */
export async function endSession(req, res) {
  const sids = tokensFromRequest(req)
    .map((token) => decode(token, SESSION_TYP)?.sid)
    .filter(Boolean);
  if (sids.length) {
    await prisma.session.deleteMany({ where: { id: { in: sids } } }).catch(() => {});
  }
  res.clearCookie("token", cookieOptions());
}

/**
 * Signs a user out everywhere (password reset, role or email change). Pass
 * the transaction client so revocation commits or rolls back with the change
 * that caused it.
 */
export async function revokeAllSessions(userId, db = prisma) {
  await db.session.deleteMany({ where: { userId: Number(userId) } });
}

// ---------------------------------------------------------------------------
// Google sign-in hand-off
//
// The OAuth callback can't hand the session token to a frontend on another
// site, so it redirects with a 60-second single-use code. The code points at a
// short-lived `sessions` row; redeeming it deletes that row atomically, so a
// code works once even across restarts and instances.
// ---------------------------------------------------------------------------

export async function issueGoogleExchangeCode(userId) {
  const expiresAt = new Date(Date.now() + GOOGLE_EXCHANGE_TTL_MS);
  const pending = await prisma.session.create({ data: { userId, expiresAt } });
  return jwt.sign({ typ: GOOGLE_EXCHANGE_TYP, sid: pending.id, userId }, JWT_SECRET, {
    algorithm: "HS256",
    expiresIn: Math.floor(GOOGLE_EXCHANGE_TTL_MS / 1000),
  });
}

/** Returns the userId for a valid, unused exchange code (consuming it), else null. */
export async function redeemGoogleExchangeCode(code) {
  const decoded = decode(code, GOOGLE_EXCHANGE_TYP);
  if (!decoded || decoded.expired) return null;
  const { count } = await prisma.session.deleteMany({
    where: { id: decoded.sid, userId: decoded.userId, expiresAt: { gt: new Date() } },
  });
  return count === 1 ? decoded.userId : null;
}

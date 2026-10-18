const isProduction = process.env.NODE_ENV === "production";

/** Origins allowed to call the API and to receive Google sign-in redirects. */
export const allowedOrigins = [
  process.env.FRONTEND_URL,
  ...(process.env.CORS_ORIGINS || "").split(","),
  ...(isProduction ? [] : ["http://localhost:3000", "http://localhost:3001"]),
]
  .map((origin) => origin?.trim().replace(/[\r\n]+/g, "").replace(/\/+$/, ""))
  .filter(Boolean);

/**
 * Returns the origin of `value` when it is on the allowlist, otherwise null.
 * Used for redirect targets, so it never honours "allow any origin" dev mode.
 */
export function safeOrigin(value) {
  try {
    const { origin, protocol } = new URL(String(value));
    if (protocol !== "http:" && protocol !== "https:") return null;
    return allowedOrigins.includes(origin) ? origin : null;
  } catch {
    return null;
  }
}

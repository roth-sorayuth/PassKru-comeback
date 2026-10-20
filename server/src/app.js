import express from "express";
import cors from "cors";
import cookieParser from "cookie-parser";
import passport from "./config/passport.js";
import swaggerUi from "swagger-ui-express";
import router from "./routes/index.js";
import { openApiSpec } from "./docs/openapi.js";
import { allowedOrigins } from "./config/origins.js";

// Fail fast if critical secrets are missing
if (!process.env.JWT_SECRET) {
  console.error("[FATAL] JWT_SECRET environment variable is not set. Refusing to start.");
  process.exit(1);
}

const app = express();

// Behind Railway's proxy: take the client IP from X-Forwarded-For (one hop),
// otherwise the auth rate limits would see every request as the proxy's IP.
app.set("trust proxy", 1);

const isProduction = process.env.NODE_ENV === "production";
// "Any origin" is opt-in: an unset NODE_ENV must never mean wide-open CORS.
const allowAnyOrigin = process.env.NODE_ENV === "development";

const isAllowedOrigin = (origin) => allowAnyOrigin || allowedOrigins.includes(origin);

app.disable("x-powered-by");

// Security headers (API only serves JSON, so the CSP can be locked down).
app.use((req, res, next) => {
  res.setHeader("X-Content-Type-Options", "nosniff");
  // Every API response is per-user (sessions, tokens, signed file links):
  // never let a browser, proxy or CDN keep a copy.
  if (req.path.startsWith("/api/")) res.setHeader("Cache-Control", "no-store");
  res.setHeader("X-Frame-Options", "DENY");
  res.setHeader("Referrer-Policy", "no-referrer");
  res.setHeader("Cross-Origin-Resource-Policy", "same-site");
  if (isProduction) {
    res.setHeader("Strict-Transport-Security", "max-age=31536000; includeSubDomains");
  }
  if (!req.path.startsWith("/api-docs")) {
    res.setHeader("Content-Security-Policy", "default-src 'none'; frame-ancestors 'none'");
  }
  next();
});

// CSRF guard. Auth cookies are SameSite=None (Vercel → Railway), so a page on
// any other site could otherwise fire credentialed state-changing requests at
// the API. Browsers always send Origin on cross-site non-GET requests; reject
// the ones that aren't ours. (No Origin = non-browser client, which carries no
// victim cookies.)
app.use((req, res, next) => {
  if (["GET", "HEAD", "OPTIONS"].includes(req.method)) return next();
  const origin = req.headers.origin;
  if (origin && !isAllowedOrigin(origin)) {
    return res.status(403).json({ success: false, message: "Origin not allowed" });
  }
  next();
});

app.use(
  cors({
    origin: (origin, callback) => {
      // No Origin: server-to-server, curl, same-origin navigation.
      if (!origin) return callback(null, true);
      // Disallowed origins get no CORS headers (browser blocks the read); the
      // CSRF guard above has already refused any state-changing request.
      return callback(null, isAllowedOrigin(origin) ? origin : false);
    },
    credentials: true,
  })
);

// JSON only. No urlencoded parser: HTML forms are the classic CSRF vehicle
// (no CORS preflight), and no client of this API sends form bodies.
// 2mb (up from the 100kb default) so admins can bulk-import flashcard JSON files.
app.use(express.json({ limit: "2mb" }));
app.use(cookieParser());
app.use(passport.initialize());

// OpenAPI Spec & Swagger UI Documentation — off in production unless
// explicitly enabled; it maps the whole attack surface.
if (!isProduction || process.env.ENABLE_API_DOCS === "true") {
  app.get("/openapi.json", (req, res) => {
    res.json(openApiSpec);
  });

  app.use(
    "/api-docs",
    swaggerUi.serve,
    swaggerUi.setup(openApiSpec, {
      customSiteTitle: "PassKru API Documentation",
      customCss: ".swagger-ui .topbar { display: block; }",
    })
  );
}

// Health check
app.get("/health", (req, res) => {
  res.status(200).json({ status: "healthy", timestamp: new Date() });
});

// API Routes
app.use("/api", router);

// Catch-all route
app.use("*", (req, res) => {
  res.status(404).json({ success: false, message: "Endpoint not found" });
});

// Error handling middleware
app.use((err, req, res, next) => {
  console.error("Error handler caught error:", err);

  const statusCode = err.statusCode || 500;
  // Unexpected (5xx) errors can carry database or code details; don't send those to clients in production.
  // `expose` marks messages written for the user (no internals), e.g. "File storage
  // is not configured on the server", so admins see the real reason.
  const hideDetails = statusCode >= 500 && process.env.NODE_ENV === "production" && !err.expose;
  const message = hideDetails ? "Internal Server Error" : err.message || "Internal Server Error";

  res.status(statusCode).json({
    success: false,
    message,
    stack: process.env.NODE_ENV === "development" ? err.stack : undefined,
  });
});

export default app;

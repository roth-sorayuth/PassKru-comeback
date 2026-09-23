import express from "express";
import cors from "cors";
import cookieParser from "cookie-parser";
import passport from "./config/passport.js";
import swaggerUi from "swagger-ui-express";
import router from "./routes/index.js";
import { openApiSpec } from "./docs/openapi.js";

// Fail fast if critical secrets are missing
if (!process.env.JWT_SECRET) {
  console.error("[FATAL] JWT_SECRET environment variable is not set. Refusing to start.");
  process.exit(1);
}

const app = express();

// Middleware
const allowedOrigins = [
  process.env.FRONTEND_URL,
  ...(process.env.CORS_ORIGINS || "").split(","),
  "http://localhost:3000",
  "http://localhost:3001",
]
  .map((origin) => origin?.trim().replace(/[\r\n]+/g, "").replace(/\/+$/, ""))
  .filter(Boolean);

const isProduction = process.env.NODE_ENV === "production";

app.use(
  cors({
    origin: (origin, callback) => {
      // Allow requests with no origin (e.g. server-to-server, mobile tools, curl)
      if (!origin) return callback(null, true);
      if (allowedOrigins.includes(origin)) {
        return callback(null, origin);
      }
      if (!isProduction) {
        // In development allow any origin for convenience
        return callback(null, origin);
      }
      return callback(new Error(`CORS: origin "${origin}" is not allowed`));
    },
    credentials: true,
  })
);

app.use(express.json());
app.use(express.urlencoded({ extended: true }));
app.use(cookieParser());
app.use(passport.initialize());

// OpenAPI Spec & Swagger UI Documentation
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
  const hideDetails = statusCode >= 500 && process.env.NODE_ENV === "production";
  const message = hideDetails ? "Internal Server Error" : err.message || "Internal Server Error";

  res.status(statusCode).json({
    success: false,
    message,
    stack: process.env.NODE_ENV === "development" ? err.stack : undefined,
  });
});

export default app;

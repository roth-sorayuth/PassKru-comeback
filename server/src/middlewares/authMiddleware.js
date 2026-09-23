import jwt from "jsonwebtoken";
import * as authService from "../services/authService.js";

const JWT_SECRET = process.env.JWT_SECRET;

export const protect = async (req, res, next) => {
  try {
    let token = req.cookies?.token;

    if (!token && req.headers.authorization?.startsWith("Bearer ")) {
      token = req.headers.authorization.split(" ")[1];
    }

    if (!token) {
      return res.status(401).json({
        success: false,
        message: "Missing authentication token",
      });
    }

    const decoded = jwt.verify(token, JWT_SECRET);
    const user = await authService.getUserById(decoded.userId);

    if (!user) {
      return res.status(401).json({
        success: false,
        message: "User not found",
      });
    }

    req.user = user;
    req.auth = {
      userId: user.userId,
      dbUserId: user.userId,
    };

    next();
  } catch (error) {
    console.error("[protect] Auth failed:", error?.message || error);
    const isExpired = error?.name === "TokenExpiredError";
    return res.status(401).json({
      success: false,
      message: isExpired ? "Session expired. Please sign in again." : "Auth failed",
    });
  }
};

export const optionalProtect = async (req, res, next) => {
  try {
    let token = req.cookies?.token;

    if (!token && req.headers.authorization?.startsWith("Bearer ")) {
      token = req.headers.authorization.split(" ")[1];
    }

    if (!token) {
      req.user = null;
      return next();
    }

    const decoded = jwt.verify(token, JWT_SECRET);
    const user = await authService.getUserById(decoded.userId);

    req.user = user || null;
    req.auth = user ? { userId: user.userId, dbUserId: user.userId } : null;

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

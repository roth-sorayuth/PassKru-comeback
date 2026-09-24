import { Router } from "express";
import {
  getActivePlan,
  generatePlan,
  getPlanHistory,
  updateTaskStatus,
  getSubjectOptions,
  getTracks,
  getMyPlans,
  activatePlan,
  cancelPlan,
  getWeeklyReview,
  submitWeeklyReview,
  getWeeklyUpdate,
  decideWeeklyUpdate,
} from "../controllers/studyPlanController.js";
import { protect } from "../middlewares/authMiddleware.js";
import { aiLimiter } from "../middlewares/rateLimit.js";
import { signFileUrlsInResponses } from "../services/storageService.js";

const router = Router();

// Public catalogue endpoints (tracks available and subject selection rules)
router.get("/tracks", getTracks);
router.get("/subject-options", getSubjectOptions);

// All user-specific study plan routes require authentication
router.use(protect);
// Plans embed paper fileUrls; hand them out as short-lived signed links.
router.use(signFileUrlsInResponses);

router.get("/", getActivePlan);
router.post("/generate", aiLimiter, generatePlan);
router.get("/history", getPlanHistory);
router.get("/plans", getMyPlans);
router.post("/plans/:planId/activate", activatePlan);
router.post("/plans/:planId/cancel", cancelPlan);
router.get("/weekly-review", getWeeklyReview);
router.post("/weekly-review", submitWeeklyReview);
router.get("/weekly-update", getWeeklyUpdate);
router.post("/weekly-update/:updateId", decideWeeklyUpdate);
router.patch("/:planId/tasks/:taskId", updateTaskStatus);

export default router;

import { Router } from "express";
import { getActivity, getDashboard } from "../controllers/progressController.js";
import { protect } from "../middlewares/authMiddleware.js";
import { signFileUrlsInResponses } from "../services/storageService.js";

const router = Router();

router.use(protect);
// Activity history carries paper fileUrls copied from study plans.
router.use(signFileUrlsInResponses);

router.get("/dashboard", getDashboard);
router.get("/activity", getActivity);

export default router;

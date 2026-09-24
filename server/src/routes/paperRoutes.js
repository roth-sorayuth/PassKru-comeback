import { Router } from "express";
import {
  getPapers,
  getPaperById,
  createPaper,
  updatePaper,
  deletePaper,
} from "../controllers/paperController.js";
import { protect, admin } from "../middlewares/authMiddleware.js";

const router = Router();

// Reads require a signed-in user: responses carry (signed) links to the PDFs.
router.route("/")
  .get(protect, getPapers)
  .post(protect, admin, createPaper);

router.route("/:id")
  .get(protect, getPaperById)
  .put(protect, admin, updatePaper)
  .delete(protect, admin, deletePaper);

export default router;

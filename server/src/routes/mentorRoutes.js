import { Router } from "express";
import {
  getMentors,
  getMentorById,
  createMentor,
  updateMentor,
  deleteMentor,
  createBooking,
  updateMentorStatus,
} from "../controllers/mentorController.js";
import { protect, optionalProtect, admin } from "../middlewares/authMiddleware.js";
import { bookingLimiter } from "../middlewares/rateLimit.js";

const router = Router();

// GET is public so candidates & dashboard can list mentors. Visitors only
// ever see approved mentors; signed-in admins may pass ?status=all or a
// specific status to see the moderation queue (optionalProtect tells them apart).
router.route("/")
  .get(optionalProtect, getMentors)
  .post(protect, admin, createMentor);

router.route("/:id")
  .get(optionalProtect, getMentorById)
  .put(protect, admin, updateMentor)
  .delete(protect, admin, deleteMentor);

// Candidate books their own session — protect only, no admin gate.
router.post("/:id/bookings", protect, bookingLimiter, createBooking);

router.patch("/:id/status", protect, admin, updateMentorStatus);

export default router;

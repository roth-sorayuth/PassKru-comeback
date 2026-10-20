import { Router } from "express";
import { protect, admin } from "../middlewares/authMiddleware.js";
import { createSignedUpload } from "../services/storageService.js";

const router = Router();

router.use(protect, admin);

// POST /api/uploads/sign  { kind, contentType, size } -> one-time signed upload URL.
// The server picks the bucket and object path; the browser PUTs the file to
// `uploadUrl`, then saves `publicUrl` through the normal create/update route.
router.post("/sign", async (req, res, next) => {
  try {
    const { kind, contentType, size } = req.body || {};
    const upload = await createSignedUpload({ kind, contentType, size });
    return res.status(201).json({ success: true, upload });
  } catch (error) {
    next(error);
  }
});

export default router;

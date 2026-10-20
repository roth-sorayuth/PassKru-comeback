import { prisma } from "../config/prisma.js";
import { appTodayString } from "../utils/appDate.js";

/**
 * Get all mentors with optional filtering and pagination
 * @param {Object} filters
 * @param {string} [filters.search] - Search by firstName, lastName, title, or roleLabel
 * @param {string} [filters.subject] - Filter by subject name contained in subjects JSON
 * @param {number} [filters.limit]
 * @param {number} [filters.page]
 */
export const getAll = async (filters = {}) => {
  const where = {};

  // Public listings only show approved mentors by default. Passing
  // status=all (used by the admin moderation tab) lifts that filter so
  // pending/rejected/suspended profiles are visible there; passing a
  // specific status filters to just that queue.
  if (filters.status && filters.status !== "all") {
    where.status = filters.status;
  } else if (!filters.status) {
    where.status = "approved";
  }

  if (filters.search) {
    const search = filters.search.trim();
    where.OR = [
      { firstName: { contains: search, mode: "insensitive" } },
      { lastName: { contains: search, mode: "insensitive" } },
      { title: { contains: search, mode: "insensitive" } },
      { roleLabel: { contains: search, mode: "insensitive" } },
    ];
  }

  // Clamped: a negative page used to become a negative skip (500), and the
  // list is public, so no unbounded page size either.
  const page = Math.max(1, parseInt(filters.page, 10) || 1);
  const limit = Math.min(200, Math.max(1, parseInt(filters.limit, 10) || 50));
  const skip = (page - 1) * limit;

  const [total, mentors] = await Promise.all([
    prisma.mentor.count({ where }),
    prisma.mentor.findMany({
      where,
      skip,
      take: limit,
      orderBy: { mentorId: "desc" },
      include: {
        _count: {
          select: { mentorBookings: true },
        },
      },
    }),
  ]);

  return {
    mentors,
    pagination: {
      total,
      page,
      limit,
      totalPages: Math.ceil(total / limit),
    },
  };
};

/**
 * Get single mentor by ID
 * @param {number} id
 * @param {{ asAdmin?: boolean }} [options] - Bookings (learners' ids and private
 *   notes) and non-approved mentors are only returned to admins.
 */
export const getById = async (id, { asAdmin = false } = {}) => {
  const mentor = await prisma.mentor.findUnique({
    where: { mentorId: id },
    include: {
      ...(asAdmin
        ? {
            mentorBookings: {
              orderBy: { createdAt: "desc" },
              take: 10,
            },
          }
        : {}),
      _count: {
        select: { mentorBookings: true },
      },
    },
  });

  if (!mentor || (!asAdmin && mentor.status !== "approved")) {
    const error = new Error(`Mentor with ID ${id} not found`);
    error.statusCode = 404;
    throw error;
  }

  return mentor;
};

/**
 * Create a new mentor
 * @param {Object} data
 */
export const create = async (data) => {
  return await prisma.mentor.create({
    data: {
      firstName: data.firstName.trim(),
      lastName: data.lastName.trim(),
      title: data.title ? data.title.trim() : null,
      roleLabel: data.roleLabel ? data.roleLabel.trim() : null,
      avatarUrl: data.avatarUrl ? data.avatarUrl.trim() : null,
      experienceYears: data.experienceYears !== undefined && data.experienceYears !== null
        ? parseInt(data.experienceYears, 10)
        : null,
      rating: data.rating !== undefined && data.rating !== null
        ? Number(data.rating)
        : 5.0,
      reviewsCount: data.reviewsCount !== undefined && data.reviewsCount !== null
        ? parseInt(data.reviewsCount, 10)
        : 0,
      studentsTrained: data.studentsTrained !== undefined && data.studentsTrained !== null
        ? parseInt(data.studentsTrained, 10)
        : 0,
      availability: data.availability ? data.availability.trim() : null,
      bio: data.bio ? data.bio.trim() : null,
      hourlyRate: data.hourlyRate ? data.hourlyRate.trim() : null,
      socialTelegram: data.socialTelegram ? data.socialTelegram.trim() : null,
      subjects: data.subjects !== undefined ? data.subjects : [],
      // Admin-authored profiles still go through the moderation queue by
      // default, unless the caller explicitly marks one approved on create.
      status: data.status || "pending",
    },
  });
};

/**
 * Update an existing mentor
 * @param {number} id
 * @param {Object} data
 */
export const update = async (id, data) => {
  const mentorExists = await prisma.mentor.findUnique({
    where: { mentorId: id },
  });

  if (!mentorExists) {
    const error = new Error(`Mentor with ID ${id} not found`);
    error.statusCode = 404;
    throw error;
  }

  const updateData = {};

  if (data.firstName !== undefined) updateData.firstName = data.firstName.trim();
  if (data.lastName !== undefined) updateData.lastName = data.lastName.trim();
  if (data.title !== undefined) updateData.title = data.title ? data.title.trim() : null;
  if (data.roleLabel !== undefined) updateData.roleLabel = data.roleLabel ? data.roleLabel.trim() : null;
  if (data.avatarUrl !== undefined) updateData.avatarUrl = data.avatarUrl ? data.avatarUrl.trim() : null;
  if (data.experienceYears !== undefined) {
    updateData.experienceYears = data.experienceYears !== null ? parseInt(data.experienceYears, 10) : null;
  }
  if (data.rating !== undefined) {
    updateData.rating = data.rating !== null ? Number(data.rating) : null;
  }
  if (data.reviewsCount !== undefined) {
    updateData.reviewsCount = data.reviewsCount !== null ? parseInt(data.reviewsCount, 10) : 0;
  }
  if (data.studentsTrained !== undefined) {
    updateData.studentsTrained = data.studentsTrained !== null ? parseInt(data.studentsTrained, 10) : 0;
  }
  if (data.availability !== undefined) {
    updateData.availability = data.availability ? data.availability.trim() : null;
  }
  if (data.bio !== undefined) updateData.bio = data.bio ? data.bio.trim() : null;
  if (data.hourlyRate !== undefined) {
    updateData.hourlyRate = data.hourlyRate ? data.hourlyRate.trim() : null;
  }
  if (data.socialTelegram !== undefined) {
    updateData.socialTelegram = data.socialTelegram ? data.socialTelegram.trim() : null;
  }
  if (data.subjects !== undefined) updateData.subjects = data.subjects;
  if (data.status !== undefined) updateData.status = data.status;

  return await prisma.mentor.update({
    where: { mentorId: id },
    data: updateData,
  });
};

/**
 * Remove a mentor
 * @param {number} id
 */
export const remove = async (id) => {
  const mentorExists = await prisma.mentor.findUnique({
    where: { mentorId: id },
  });

  if (!mentorExists) {
    const error = new Error(`Mentor with ID ${id} not found`);
    error.statusCode = 404;
    throw error;
  }

  await prisma.mentor.delete({
    where: { mentorId: id },
  });

  return true;
};

const VALID_STATUSES = ["pending", "approved", "rejected", "suspended"];

/**
 * Dedicated status transition used by the admin moderation tab, kept
 * separate from the general update() so a moderation click can't
 * accidentally clobber other profile fields.
 */
/**
 * Candidate books a consultation session with a mentor. There's no
 * scheduling/availability engine here — a booking is just a request row the
 * mentor/admin can see and action, same as the rest of this app's simple
 * request-then-review patterns (e.g. mentor moderation itself).
 */
function bookingError(message) {
  const error = new Error(message);
  error.statusCode = 400;
  return error;
}

function bookingText(value, field, maxLength) {
  if (value == null || value === "") return null;
  if (typeof value !== "string") throw bookingError(`${field} must be text`);
  const text = value.trim();
  if (text.length > maxLength) throw bookingError(`${field} must be at most ${maxLength} characters`);
  return text || null;
}

/** "YYYY-MM-DD" (what the date picker sends), today or later in app time. */
function parseSessionDate(value) {
  if (value == null || value === "") return null;
  const text = typeof value === "string" ? value.trim().slice(0, 10) : "";
  const date = /^\d{4}-\d{2}-\d{2}$/.test(text) ? new Date(`${text}T00:00:00Z`) : null;
  if (!date || Number.isNaN(date.getTime()) || date.toISOString().slice(0, 10) !== text) {
    throw bookingError("sessionDate must be a valid date (YYYY-MM-DD)");
  }
  if (text < appTodayString()) throw bookingError("sessionDate cannot be in the past");
  return date;
}

export const createBooking = async (userId, mentorId, data) => {
  const mentor = await prisma.mentor.findUnique({ where: { mentorId } });
  // Mentors awaiting moderation, rejected or suspended don't take bookings.
  if (!mentor || mentor.status !== "approved") {
    const error = new Error(`Mentor with ID ${mentorId} not found`);
    error.statusCode = 404;
    throw error;
  }

  return await prisma.mentorBooking.create({
    data: {
      userId,
      mentorId,
      sessionDate: parseSessionDate(data.sessionDate),
      timeSlot: bookingText(data.timeSlot, "timeSlot", 50),
      note: bookingText(data.note, "note", 1000),
      status: "pending",
    },
  });
};

export const setStatus = async (id, status) => {
  if (!VALID_STATUSES.includes(status)) {
    const error = new Error(`Invalid status "${status}". Must be one of: ${VALID_STATUSES.join(", ")}`);
    error.statusCode = 400;
    throw error;
  }

  const mentorExists = await prisma.mentor.findUnique({ where: { mentorId: id } });
  if (!mentorExists) {
    const error = new Error(`Mentor with ID ${id} not found`);
    error.statusCode = 404;
    throw error;
  }

  return await prisma.mentor.update({ where: { mentorId: id }, data: { status } });
};

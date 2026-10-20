import { prisma } from "../config/prisma.js";
import { revokeAllSessions } from "./sessionService.js";

function userError(message, statusCode = 400) {
  const error = new Error(message);
  error.statusCode = statusCode;
  return error;
}

/**
 * One structured line per sensitive admin action, for the host's log search.
 * Ids and field names only: never emails, names, tokens or OTPs.
 */
function audit(action, actorId, targetUserId, details = {}) {
  console.info(JSON.stringify({ audit: action, actorId, targetUserId, at: new Date().toISOString(), ...details }));
}

/**
 * Runs `fn` in a serializable transaction so two admins demoting or deleting
 * each other at the same moment can't both pass the "another admin remains"
 * check; the loser gets a retryable error instead of a lockout.
 */
async function inAdminSafeTransaction(fn) {
  try {
    return await prisma.$transaction(fn, { isolationLevel: "Serializable" });
  } catch (error) {
    if (error?.code === "P2034") throw userError("Another admin change happened at the same time. Please try again.", 409);
    throw error;
  }
}

/**
 * Get all users with optional filtering and search
 */
export async function getAllUsers(filters = {}) {
  const where = {};

  if (filters.role) {
    where.role = filters.role;
  }

  if (filters.targetExamId) {
    where.targetExamId = Number(filters.targetExamId);
  }

  if (filters.search) {
    const q = filters.search.trim();
    where.OR = [
      { firstName: { contains: q, mode: "insensitive" } },
      { lastName: { contains: q, mode: "insensitive" } },
      { email: { contains: q, mode: "insensitive" } },
      { phoneNumber: { contains: q, mode: "insensitive" } },
    ];
  }

  const users = await prisma.user.findMany({
    where,
    include: {
      targetExam: {
        select: {
          examId: true,
          examName: true,
          category: true,
          examType: true,
        },
      },
      _count: {
        select: {
          attempts: true,
          notifications: true,
          studyPlans: true,
        },
      },
    },
    orderBy: { createdAt: "desc" },
  });

  return users;
}

/**
 * Get single user by ID
 */
export async function getUserById(userId) {
  const user = await prisma.user.findUnique({
    where: { userId: Number(userId) },
    include: {
      targetExam: true,
      _count: {
        select: {
          attempts: true,
          notifications: true,
          studyPlans: true,
        },
      },
    },
  });

  if (!user) {
    throw new Error("User not found");
  }

  return user;
}

/**
 * Create a new user (admin action)
 */
export async function createUser(data) {
  if (!data.email || !data.firstName || !data.lastName) {
    throw new Error("First name, last name, and email are required.");
  }

  const existing = await prisma.user.findUnique({
    where: { email: data.email.trim().toLowerCase() },
  });

  if (existing) {
    throw new Error("A user with this email address already exists.");
  }

  const allowedRoles = ["candidate", "admin"];
  const role = allowedRoles.includes(data.role?.toLowerCase())
    ? data.role.toLowerCase()
    : "candidate";

  const user = await prisma.user.create({
    data: {
      firstName: data.firstName.trim(),
      lastName: data.lastName.trim(),
      email: data.email.trim().toLowerCase(),
      phoneNumber: data.phoneNumber ? data.phoneNumber.trim() : null,
      role,
      targetExamId: data.targetExamId ? Number(data.targetExamId) : null,
      targetSubject: data.targetSubject ? data.targetSubject.trim() : null,
      knowledgeLevel: data.knowledgeLevel ? data.knowledgeLevel.trim() : null,
      // Admin-created accounts never take a password (or hash) from the request;
      // the user signs in with Google, or registers to set one.
      passwordHash: "managed_clerk_auth",
      avatarUrl: data.avatarUrl || null,
      dailyGoalMinutes: data.dailyGoalMinutes ? Number(data.dailyGoalMinutes) : 30,
    },
    include: {
      targetExam: true,
    },
  });

  return user;
}

/**
 * Update existing user. `actorId` is the admin making the change.
 */
export async function updateUser(actorId, userId, data) {
  const id = Number(userId);

  const existing = await prisma.user.findUnique({
    where: { userId: id },
  });

  if (!existing) {
    throw new Error("User not found.");
  }

  // If updating email, ensure it's not taken by another user
  if (data.email && data.email.trim().toLowerCase() !== existing.email) {
    const emailTaken = await prisma.user.findUnique({
      where: { email: data.email.trim().toLowerCase() },
    });
    if (emailTaken && emailTaken.userId !== id) {
      throw new Error("This email is already in use by another account.");
    }
  }

  const updateData = {};

  if (data.firstName !== undefined) updateData.firstName = data.firstName.trim();
  if (data.lastName !== undefined) updateData.lastName = data.lastName.trim();
  if (data.email !== undefined) updateData.email = data.email.trim().toLowerCase();
  if (data.phoneNumber !== undefined) updateData.phoneNumber = data.phoneNumber ? data.phoneNumber.trim() : null;
  if (data.avatarUrl !== undefined) updateData.avatarUrl = data.avatarUrl;
  
  if (data.role !== undefined) {
    const allowedRoles = ["candidate", "admin"];
    if (allowedRoles.includes(data.role?.toLowerCase())) {
      updateData.role = data.role.toLowerCase();
    }
  }

  const emailChanged = updateData.email !== undefined && updateData.email !== existing.email;
  const roleChanged = updateData.role !== undefined && updateData.role !== existing.role;
  const losesAdmin = existing.role === "admin" && roleChanged;
  if (losesAdmin && id === Number(actorId)) {
    throw userError("You can't remove your own admin role. Ask another admin to do it.");
  }
  // The new address hasn't been proven; the user verifies it with the emailed
  // code on their next sign-in.
  if (emailChanged) updateData.isEmailVerified = false;

  if (data.targetExamId !== undefined) {
    updateData.targetExamId = data.targetExamId ? Number(data.targetExamId) : null;
  }
  if (data.targetSubject !== undefined) {
    updateData.targetSubject = data.targetSubject ? data.targetSubject.trim() : null;
  }
  if (data.knowledgeLevel !== undefined) {
    updateData.knowledgeLevel = data.knowledgeLevel ? data.knowledgeLevel.trim() : null;
  }
  if (data.dailyGoalMinutes !== undefined) {
    updateData.dailyGoalMinutes = Number(data.dailyGoalMinutes) || 30;
  }

  updateData.updatedAt = new Date();

  const updatedUser = await inAdminSafeTransaction(async (tx) => {
    if (losesAdmin) {
      const otherAdmins = await tx.user.count({ where: { role: "admin", userId: { not: id } } });
      if (otherAdmins === 0) throw userError("This is the last admin account. Make someone else an admin first.");
    }
    const updated = await tx.user.update({
      where: { userId: id },
      data: updateData,
      include: {
        targetExam: true,
        _count: {
          select: {
            attempts: true,
            notifications: true,
            studyPlans: true,
          },
        },
      },
    });
    // Permissions or identity changed: existing sessions were granted under the
    // old ones. Revoked in the same transaction, so the change never commits
    // while the old sessions survive.
    if (roleChanged || emailChanged) await revokeAllSessions(id, tx);
    return updated;
  });
  audit("user.update", Number(actorId), id, {
    fields: Object.keys(updateData).filter((k) => k !== "updatedAt"),
    ...(roleChanged ? { roleFrom: existing.role, roleTo: updateData.role } : {}),
    ...(emailChanged ? { emailChanged: true } : {}),
  });

  return updatedUser;
}

/**
 * Delete user. `actorId` is the admin making the change.
 */
export async function deleteUser(actorId, userId) {
  const id = Number(userId);
  if (id === Number(actorId)) throw userError("You can't delete your own account from the admin panel.");

  const existing = await prisma.user.findUnique({
    where: { userId: id },
  });

  if (!existing) {
    throw userError("User not found.", 404);
  }

  await inAdminSafeTransaction(async (tx) => {
    if (existing.role === "admin") {
      const otherAdmins = await tx.user.count({ where: { role: "admin", userId: { not: id } } });
      if (otherAdmins === 0) throw userError("This is the last admin account and can't be deleted.");
    }
    // Sessions go with the user (ON DELETE CASCADE).
    await tx.user.delete({ where: { userId: id } });
  });
  audit("user.delete", Number(actorId), id, { role: existing.role });

  return { message: "User deleted successfully." };
}

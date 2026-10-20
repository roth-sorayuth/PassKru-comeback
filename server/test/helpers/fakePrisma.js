/**
 * In-memory stand-in for the Prisma client, covering only the calls the auth
 * and admin tests exercise. Tests mock ../src/config/prisma.js with it, so they
 * never open a database connection.
 */
import { randomUUID } from "node:crypto";

const matches = (row, where = {}) =>
  Object.entries(where).every(([key, cond]) => {
    const value = row[key];
    if (cond && typeof cond === "object" && !(cond instanceof Date)) {
      if ("in" in cond && !cond.in.includes(value)) return false;
      if ("not" in cond && value === cond.not) return false;
      if ("lt" in cond && !(value < cond.lt)) return false;
      if ("gt" in cond && !(value > cond.gt)) return false;
      return true;
    }
    return value === cond;
  });

export function createFakePrisma() {
  const db = { users: [], sessions: [] };

  const prisma = {
    db,
    user: {
      findUnique: async ({ where }) => {
        const row = db.users.find((u) => matches(u, where));
        return row ? { ...row, targetExam: null } : null;
      },
      count: async ({ where }) => db.users.filter((u) => matches(u, where)).length,
      create: async ({ data }) => {
        if (db.users.some((u) => u.email === data.email)) {
          throw Object.assign(new Error("unique"), { code: "P2002" });
        }
        const row = { userId: db.users.length + 1, otpCount: 0, ...data };
        db.users.push(row);
        return { ...row };
      },
      updateMany: async ({ where, data }) => {
        const rows = db.users.filter((u) => matches(u, where));
        rows.forEach((row) => Object.assign(row, data));
        return { count: rows.length };
      },
      update: async ({ where, data }) => {
        const row = db.users.find((u) => matches(u, where));
        if (!row) throw Object.assign(new Error("not found"), { code: "P2025" });
        Object.assign(row, data);
        return { ...row };
      },
      delete: async ({ where }) => {
        const i = db.users.findIndex((u) => matches(u, where));
        const [row] = db.users.splice(i, 1);
        db.sessions = db.sessions.filter((s) => s.userId !== row.userId); // ON DELETE CASCADE
        return row;
      },
    },
    session: {
      create: async ({ data }) => {
        const row = { id: randomUUID(), createdAt: new Date(), ...data };
        db.sessions.push(row);
        return { ...row };
      },
      findUnique: async ({ where }) => {
        const row = db.sessions.find((s) => s.id === where.id);
        return row ? { ...row } : null;
      },
      deleteMany: async ({ where }) => {
        if (prisma.failSessionDelete) throw new Error("simulated session store failure");
        const before = db.sessions.length;
        db.sessions = db.sessions.filter((s) => !matches(s, where));
        return { count: before - db.sessions.length };
      },
    },
    // All-or-nothing like a real transaction: a throw restores the snapshot.
    $transaction: async (fn) => {
      const snapshot = structuredClone({ users: db.users, sessions: db.sessions });
      try {
        return await fn(prisma);
      } catch (error) {
        db.users.splice(0, db.users.length, ...snapshot.users);
        db.sessions.splice(0, db.sessions.length, ...snapshot.sessions);
        throw error;
      }
    },
    /** Set to true to make session.deleteMany throw (failure-path tests). */
    failSessionDelete: false,
  };

  prisma.addUser = (fields) => {
    const user = {
      userId: db.users.length + 1,
      firstName: "Test",
      lastName: "User",
      email: `user${db.users.length + 1}@example.test`,
      role: "candidate",
      isEmailVerified: true,
      passwordHash: "x",
      ...fields,
    };
    db.users.push(user);
    return user;
  };

  return prisma;
}

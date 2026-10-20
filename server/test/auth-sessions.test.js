// Regression tests: revocable sessions, Google exchange codes, admin rails.
// Run with `npm test` (node --test). Uses an in-memory fake Prisma — no database.
import { test, mock, before, after, beforeEach } from "node:test";
import assert from "node:assert/strict";
import jwt from "jsonwebtoken";
import { createFakePrisma } from "./helpers/fakePrisma.js";

process.env.JWT_SECRET = "test-only-secret";
process.env.NODE_ENV = "test";
process.env.DATABASE_URL = "postgresql://unused:unused@127.0.0.1:1/unused";

const prisma = createFakePrisma();
mock.module(new URL("../src/config/prisma.js", import.meta.url).href, { namedExports: { prisma } });

const sessions = await import("../src/services/sessionService.js");
const userService = await import("../src/services/userService.js");
const { default: app } = await import("../src/app.js");

let server;
let base;
before(async () => {
  server = app.listen(0);
  await new Promise((r) => server.once("listening", r));
  base = `http://127.0.0.1:${server.address().port}`;
});
after(() => server.close());

beforeEach(() => {
  prisma.db.users.length = 0;
  prisma.db.sessions.length = 0;
  prisma.failSessionDelete = false;
});

const fakeRes = () => ({ cookie() {}, clearCookie() {} });
const me = (token) => fetch(`${base}/api/users/me`, { headers: { Authorization: `Bearer ${token}` } });
const post = (path, body, token) =>
  fetch(`${base}${path}`, {
    method: "POST",
    headers: { "Content-Type": "application/json", ...(token ? { Authorization: `Bearer ${token}` } : {}) },
    body: JSON.stringify(body ?? {}),
  });

test("a session token works until logout, then is rejected", async () => {
  const user = prisma.addUser();
  const token = await sessions.startSession(fakeRes(), user);
  assert.equal((await me(token)).status, 200);

  assert.equal((await post("/api/auth/logout", {}, token)).status, 200);
  assert.equal((await me(token)).status, 401);
});

test("revokeAllSessions (password reset / admin change) ends every device", async () => {
  const user = prisma.addUser();
  const a = await sessions.startSession(fakeRes(), user);
  const b = await sessions.startSession(fakeRes(), user);
  await sessions.revokeAllSessions(user.userId);
  assert.equal((await me(a)).status, 401);
  assert.equal((await me(b)).status, 401);
});

test("tokens without a live session are rejected", async () => {
  const user = prisma.addUser();
  const secret = process.env.JWT_SECRET;
  // Pre-sessions token shape.
  const legacy = jwt.sign({ userId: user.userId, email: user.email }, secret, { expiresIn: "7d" });
  assert.equal((await me(legacy)).status, 401);

  // Real sid, but claiming another user.
  const other = prisma.addUser();
  const token = await sessions.startSession(fakeRes(), user);
  const { sid } = jwt.decode(token);
  const forged = jwt.sign({ typ: "session", sid, userId: other.userId }, secret, { expiresIn: "7d" });
  assert.equal((await me(forged)).status, 401);

  // Wrong algorithm / signature.
  const none = jwt.sign({ typ: "session", sid, userId: user.userId }, "other-secret");
  assert.equal((await me(none)).status, 401);
});

test("an expired session row is rejected even if the JWT is still valid", async () => {
  const user = prisma.addUser();
  const token = await sessions.startSession(fakeRes(), user);
  prisma.db.sessions[0].expiresAt = new Date(Date.now() - 1000);
  const res = await me(token);
  assert.equal(res.status, 401);
  assert.match((await res.json()).message, /expired/i);
});

test("Google exchange code: single use, not a bearer token, replay fails", async () => {
  const user = prisma.addUser();
  const code = await sessions.issueGoogleExchangeCode(user.userId);

  assert.equal((await me(code)).status, 401, "exchange code must not authenticate");

  const [first, second] = await Promise.all([
    post("/api/auth/google/exchange", { code }),
    post("/api/auth/google/exchange", { code }),
  ]);
  const statuses = [first.status, second.status].sort();
  assert.deepEqual(statuses, [200, 400], "exactly one concurrent redeem succeeds");

  const ok = first.status === 200 ? first : second;
  assert.equal(ok.headers.get("cache-control"), "no-store", "session responses must not be cached");
  const { token } = await ok.json();
  assert.equal((await me(token)).status, 200);
  assert.equal((await post("/api/auth/google/exchange", { code })).status, 400, "replay rejected");
});

test("Google exchange code expires", async () => {
  const user = prisma.addUser();
  const code = await sessions.issueGoogleExchangeCode(user.userId);
  prisma.db.sessions[0].expiresAt = new Date(Date.now() - 1);
  assert.equal((await post("/api/auth/google/exchange", { code })).status, 400);
});

test("admin rails: no self-demotion, no removing the last admin", async () => {
  const admin = prisma.addUser({ role: "admin" });
  await assert.rejects(userService.updateUser(admin.userId, admin.userId, { role: "candidate" }), /own admin role/);
  await assert.rejects(userService.deleteUser(admin.userId, admin.userId), /own account/);

  const other = prisma.addUser({ role: "admin" });
  // Two admins: one may demote the other...
  await userService.updateUser(admin.userId, other.userId, { role: "candidate" });
  // ...but now `admin` is the last one, and a candidate can't remove them via another path.
  const third = prisma.addUser({ role: "admin" });
  await userService.deleteUser(admin.userId, third.userId);
  assert.equal(prisma.db.users.filter((u) => u.role === "admin").length, 1);
});

test("last admin can't be demoted or deleted by anyone", async () => {
  const admin = prisma.addUser({ role: "admin" });
  // Simulate a second admin account acting (e.g. a request racing a demotion).
  await assert.rejects(userService.updateUser(999, admin.userId, { role: "candidate" }), /last admin/);
  await assert.rejects(userService.deleteUser(999, admin.userId), /last admin/);
});

test("admin role/email change revokes the user's sessions and logs ids only", async () => {
  const admin = prisma.addUser({ role: "admin" });
  const user = prisma.addUser({ email: "old@example.test" });
  const token = await sessions.startSession(fakeRes(), user);

  const logged = [];
  const orig = console.info;
  console.info = (line) => logged.push(line);
  try {
    await userService.updateUser(admin.userId, user.userId, { email: "new@example.test" });
  } finally {
    console.info = orig;
  }

  assert.equal((await me(token)).status, 401);
  assert.equal(prisma.db.users.find((u) => u.userId === user.userId).isEmailVerified, false);
  const entry = JSON.parse(logged.find((l) => l.includes('"audit"')));
  assert.equal(entry.audit, "user.update");
  assert.equal(entry.emailChanged, true);
  assert.ok(!JSON.stringify(entry).includes("@example.test"), "audit line must not contain emails");
});

test("if revocation fails, the admin change rolls back and nothing is half-done", async () => {
  const admin = prisma.addUser({ role: "admin" });
  const user = prisma.addUser({ email: "keep@example.test" });
  const token = await sessions.startSession(fakeRes(), user);

  prisma.failSessionDelete = true;
  await assert.rejects(userService.updateUser(admin.userId, user.userId, { email: "new@example.test", role: "admin" }));
  prisma.failSessionDelete = false;

  const row = prisma.db.users.find((u) => u.userId === user.userId);
  assert.equal(row.email, "keep@example.test", "email unchanged");
  assert.equal(row.role, "candidate", "role unchanged");
  assert.equal(row.isEmailVerified, true, "still verified");
  assert.equal((await me(token)).status, 200, "old session still matches the unchanged account");
});

test("a profile edit that doesn't touch role/email keeps sessions", async () => {
  const admin = prisma.addUser({ role: "admin" });
  const user = prisma.addUser();
  const token = await sessions.startSession(fakeRes(), user);
  const orig = console.info;
  console.info = () => {};
  try {
    await userService.updateUser(admin.userId, user.userId, { firstName: "Dara" });
  } finally {
    console.info = orig;
  }
  assert.equal((await me(token)).status, 200);
});

test("production shows the real reason when upload storage isn't configured", async () => {
  const admin = prisma.addUser({ role: "admin" });
  const token = await sessions.startSession(fakeRes(), admin);
  const saved = { env: process.env.NODE_ENV, url: process.env.SUPABASE_URL, key: process.env.SUPABASE_SERVICE_ROLE_KEY };
  process.env.NODE_ENV = "production";
  delete process.env.SUPABASE_URL;
  delete process.env.SUPABASE_SERVICE_ROLE_KEY;
  const quiet = console.error;
  console.error = () => {};
  try {
    const res = await post("/api/uploads/sign", { kind: "paper", contentType: "application/pdf", size: 1000 }, token);
    assert.equal(res.status, 503);
    assert.match((await res.json()).message, /not configured/);
  } finally {
    console.error = quiet;
    process.env.NODE_ENV = saved.env;
    if (saved.url) process.env.SUPABASE_URL = saved.url;
    if (saved.key) process.env.SUPABASE_SERVICE_ROLE_KEY = saved.key;
  }
});

test("other 5xx errors stay hidden in production", async () => {
  const user = prisma.addUser();
  const token = await sessions.startSession(fakeRes(), user);
  const saved = process.env.NODE_ENV;
  process.env.NODE_ENV = "production";
  const orig = prisma.user.findUnique;
  // Fails after auth (the middleware's lookup succeeds first), inside the route.
  let calls = 0;
  prisma.user.findUnique = async (args) => (++calls > 1 ? Promise.reject(new Error("db internals: secret detail")) : orig(args));
  const quiet = console.error;
  console.error = () => {};
  try {
    const res = await fetch(`${base}/api/auth/me`, { headers: { Authorization: `Bearer ${token}` } });
    assert.equal(res.status, 500);
    assert.equal((await res.json()).message, "Internal Server Error");
  } finally {
    console.error = quiet;
    prisma.user.findUnique = orig;
    process.env.NODE_ENV = saved;
  }
});

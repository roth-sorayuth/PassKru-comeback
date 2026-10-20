// Regression tests: registration can't enumerate accounts or hijack a pending
// signup, signup codes are stored hashed and are single use.
import { test, mock, before, after, beforeEach } from "node:test";
import assert from "node:assert/strict";
import { createFakePrisma } from "./helpers/fakePrisma.js";

process.env.JWT_SECRET = "test-only-secret";
process.env.NODE_ENV = "test";
process.env.DATABASE_URL = "postgresql://unused:unused@127.0.0.1:1/unused";

const prisma = createFakePrisma();
const sent = [];
let failSmtp = false;
const send = (kind) => async (args) => {
  if (failSmtp) throw new Error("535 5.7.8 smtp.internal.example: auth failed for user passkru");
  sent.push({ kind, ...args });
};
mock.module(new URL("../src/config/prisma.js", import.meta.url).href, { namedExports: { prisma } });
mock.module(new URL("../src/services/emailService.js", import.meta.url).href, {
  namedExports: {
    sendVerificationOtpEmail: send("verify"),
    sendAccountExistsEmail: send("exists"),
    sendPurposeOtpEmail: send("purpose"),
  },
});

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
  sent.length = 0;
  failSmtp = false;
  prisma.failSessionDelete = false;
});

// Each call uses its own X-Forwarded-For so the per-IP auth limiter doesn't trip.
let ip = 0;
const post = async (path, body) => {
  const res = await fetch(`${base}${path}`, {
    method: "POST",
    headers: { "Content-Type": "application/json", "X-Forwarded-For": `10.0.0.${++ip % 250}` },
    body: JSON.stringify(body),
  });
  return { status: res.status, body: await res.json() };
};
const signup = (email, password = "correct horse 1", firstName = "Dara") =>
  post("/api/auth/register", { firstName, lastName: "Sok", email, password });

test("registering a taken address looks exactly like a new signup", async () => {
  prisma.addUser({ email: "taken@example.test", isEmailVerified: true });
  const taken = await signup("taken@example.test");
  const fresh = await signup("fresh@example.test");

  assert.equal(taken.status, 201);
  assert.deepEqual(Object.keys(taken.body).sort(), Object.keys(fresh.body).sort());
  assert.equal(taken.body.message, fresh.body.message);
  assert.deepEqual(sent.map((s) => s.kind), ["exists", "verify"], "owner warned, newcomer gets a code");
});

test("signup codes are stored as HMAC tags, verify once, then fail", async () => {
  await signup("new@example.test");
  const row = prisma.db.users.find((u) => u.email === "new@example.test");
  const code = sent.at(-1).otp;
  assert.match(code, /^\d{6}$/);
  assert.notEqual(row.verificationOtp, code);
  assert.match(row.verificationOtp, /^V[0-9a-f]{9}$/);

  const wrong = await post("/api/auth/verify-otp", { email: "new@example.test", otp: code === "123456" ? "654321" : "123456" });
  assert.equal(wrong.status, 400);
  const ok = await post("/api/auth/verify-otp", { email: "new@example.test", otp: code });
  assert.equal(ok.status, 200);
  assert.ok(ok.body.token);
  const replay = await post("/api/auth/verify-otp", { email: "new@example.test", otp: code });
  assert.equal(replay.status, 400);
});

test("a second registration can't overwrite a pending signup while its code is live", async () => {
  await signup("victim@example.test", "victim password", "Victim");
  const before = { ...prisma.db.users[0] };
  const victimCode = sent.at(-1).otp;

  const attacker = await signup("victim@example.test", "attacker password", "Attacker");
  assert.equal(attacker.status, 201, "same answer as always");
  const after = prisma.db.users[0];
  assert.equal(after.passwordHash, before.passwordHash);
  assert.equal(after.firstName, "Victim");
  assert.equal(after.verificationOtp, before.verificationOtp);
  assert.equal(sent.length, 1, "no new code sent");

  assert.equal((await post("/api/auth/verify-otp", { email: "victim@example.test", otp: victimCode })).status, 200);
});

test("an expired pending signup can be restarted, and the daily code cap still applies", async () => {
  await signup("late@example.test");
  const row = prisma.db.users[0];
  row.otpExpiresAt = new Date(Date.now() - 1000);
  const r = await signup("late@example.test", "new password 1", "Late");
  assert.equal(r.status, 201);
  assert.equal(row.firstName, "Late");
  assert.equal(row.otpCount, 2, "counter continues instead of resetting to 1");

  row.otpExpiresAt = new Date(Date.now() - 1000);
  row.otpCount = 4; // daily cap reached
  const capped = await signup("late@example.test", "another one 1");
  assert.equal(capped.status, 201);
  assert.equal(sent.length, 2, "no code sent past the cap");
});

test("SMTP failures never leak server details", async () => {
  failSmtp = true;
  const r = await signup("smtp@example.test");
  assert.equal(r.status, 500);
  assert.ok(!/smtp|535|internal/i.test(r.body.message), r.body.message);
  assert.equal(prisma.db.users.length, 0, "new account rolled back");
});

test("password reset is all-or-nothing: a failed revocation keeps the old password and code", async () => {
  const user = prisma.addUser({ email: "reset@example.test", passwordHash: "old-hash" });
  const sessions = await import("../src/services/sessionService.js");
  const token = await sessions.startSession({ cookie() {} }, user);

  assert.equal((await post("/api/auth/forgot-password", { email: "reset@example.test" })).status, 200);
  await new Promise((r) => setTimeout(r, 20)); // the reset email is sent without awaiting
  const code = sent.find((s) => s.kind === "purpose" && s.purpose === "reset").otp;

  prisma.failSessionDelete = true;
  const failed = await post("/api/auth/reset-password", { email: "reset@example.test", otp: code, newPassword: "brand new pass 1" });
  prisma.failSessionDelete = false;
  assert.equal(failed.status, 500);
  const row = prisma.db.users.find((u) => u.userId === user.userId);
  assert.equal(row.passwordHash, "old-hash", "password unchanged");
  assert.ok(row.verificationOtp, "code not burned, the user can retry");
  const stillIn = await fetch(`${base}/api/users/me`, { headers: { Authorization: `Bearer ${token}` } });
  assert.equal(stillIn.status, 200);

  const ok = await post("/api/auth/reset-password", { email: "reset@example.test", otp: code, newPassword: "brand new pass 1" });
  assert.equal(ok.status, 200);
  assert.notEqual(row.passwordHash, "old-hash");
  const after = await fetch(`${base}/api/users/me`, { headers: { Authorization: `Bearer ${token}` } });
  assert.equal(after.status, 401, "old session ended by the successful reset");
});

test("legacy plain-digit signup codes still verify until they expire", async () => {
  prisma.addUser({
    email: "legacy@example.test",
    isEmailVerified: false,
    verificationOtp: "482913",
    otpExpiresAt: new Date(Date.now() + 60_000),
  });
  const ok = await post("/api/auth/verify-otp", { email: "legacy@example.test", otp: "482913" });
  assert.equal(ok.status, 200);
});

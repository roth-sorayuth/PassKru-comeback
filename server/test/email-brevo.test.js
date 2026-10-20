// Brevo HTTPS email transport, against a stubbed fetch (no network, no database).
import { test, beforeEach, afterEach } from "node:test";
import assert from "node:assert/strict";
import { sendVerificationOtpEmail, parseFrom } from "../src/services/emailService.js";

const realFetch = globalThis.fetch;
const realEnv = { ...process.env };
let calls;
let reply;

beforeEach(() => {
  calls = [];
  reply = () => new Response(JSON.stringify({ messageId: "<x@brevo>" }), { status: 201 });
  globalThis.fetch = async (url, init) => {
    calls.push({ url, init, body: JSON.parse(init.body) });
    return reply();
  };
  process.env.BREVO_API_KEY = "xkeysib-test-only";
  process.env.EMAIL_FROM = '"PassKru App" <codes@passkru.test>';
  process.env.NODE_ENV = "production";
});

afterEach(() => {
  globalThis.fetch = realFetch;
  process.env = { ...realEnv };
});

test("sends through Brevo's HTTPS API with the expected request", async () => {
  const result = await sendVerificationOtpEmail({ email: "dara@example.test", otp: "482913", firstName: "Dara" });
  assert.equal(result.mode, "brevo");
  assert.equal(calls.length, 1);
  const { url, init, body } = calls[0];
  assert.equal(url, "https://api.brevo.com/v3/smtp/email");
  assert.equal(init.method, "POST");
  assert.equal(init.headers["api-key"], "xkeysib-test-only");
  assert.deepEqual(body.sender, { name: "PassKru App", email: "codes@passkru.test" });
  assert.deepEqual(body.to, [{ email: "dara@example.test" }]);
  assert.ok(body.subject);
  assert.ok(body.htmlContent.includes("482913"), "the code is in the email");
  assert.ok(init.signal, "request has a timeout signal");
});

test("Brevo is used even when SMTP is also configured", async () => {
  process.env.SMTP_HOST = "smtp.example.test";
  process.env.SMTP_USER = "u";
  process.env.SMTP_PASS = "p";
  const result = await sendVerificationOtpEmail({ email: "a@example.test", otp: "111111" });
  assert.equal(result.mode, "brevo");
  assert.equal(calls.length, 1);
});

test("in production a Brevo error throws (caller answers 503) without leaking the key", async () => {
  reply = () => new Response(JSON.stringify({ code: "unauthorized", message: "Key not found" }), { status: 401 });
  const errors = [];
  const origError = console.error;
  console.error = (...args) => errors.push(args.join(" "));
  try {
    await assert.rejects(
      sendVerificationOtpEmail({ email: "a@example.test", otp: "111111" }),
      (err) => /Brevo API 401/.test(err.message) && !err.message.includes("xkeysib")
    );
  } finally {
    console.error = origError;
  }
  assert.ok(!errors.join(" ").includes("xkeysib"), "key never logged");
});

test("in development a Brevo error falls back to the console", async () => {
  process.env.NODE_ENV = "development";
  reply = () => new Response("oops", { status: 500 });
  const origLog = console.log, origWarn = console.warn, origError = console.error;
  console.log = console.warn = console.error = () => {};
  try {
    const result = await sendVerificationOtpEmail({ email: "a@example.test", otp: "111111" });
    assert.equal(result.mode, "console_fallback");
  } finally {
    console.log = origLog;
    console.warn = origWarn;
    console.error = origError;
  }
});

test("parseFrom handles named and bare addresses", () => {
  assert.deepEqual(parseFrom('"PassKru App" <noreply@x.test>'), { name: "PassKru App", email: "noreply@x.test" });
  assert.deepEqual(parseFrom("PassKru <noreply@x.test>"), { name: "PassKru", email: "noreply@x.test" });
  assert.deepEqual(parseFrom("noreply@x.test"), { email: "noreply@x.test" });
});

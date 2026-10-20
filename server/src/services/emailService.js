import nodemailer from "nodemailer";
import dns from "node:dns";

// Ensure Node defaults to IPv4 resolution first, preventing ENETUNREACH on systems without IPv6 routing
if (typeof dns.setDefaultResultOrder === "function") {
  dns.setDefaultResultOrder("ipv4first");
}

const escapeHtml = (value) =>
  String(value ?? "").replace(/[&<>"']/g, (c) => ({ "&": "&amp;", "<": "&lt;", ">": "&gt;", '"': "&quot;", "'": "&#39;" })[c]);

let cachedTransporter = null;

function getTransporter() {
  const host = process.env.SMTP_HOST;
  const port = Number(process.env.SMTP_PORT) || 587;
  const user = process.env.SMTP_USER;
  const pass = process.env.SMTP_PASS;

  if (host && user && pass) {
    if (!cachedTransporter) {
      const isGmail = host.includes("gmail") || user.endsWith("@gmail.com");
      // Give up before the callers' 12s limit (sendWithTimeout), so a blocked
      // or slow SMTP connection fails here with a real error: logged with its
      // code (ETIMEDOUT, ECONNECTION...) and, in development, falling back to
      // printing the code in the console. Some hosts (e.g. Railway below Pro)
      // block outbound SMTP entirely, which looks exactly like a timeout.
      const timeouts = { connectionTimeout: 8000, greetingTimeout: 8000, socketTimeout: 10000 };
      cachedTransporter = nodemailer.createTransport(
        isGmail
          ? {
              service: "gmail",
              auth: { user, pass },
              ...timeouts,
            }
          : {
              host,
              port,
              secure: port === 465,
              family: 4,
              auth: { user, pass },
              ...timeouts,
            }
      );
    }
    return cachedTransporter;
  }
  return null;
}

const DEFAULT_FROM = '"PassKru App" <noreply@passkru.com>';
const BREVO_ENDPOINT = "https://api.brevo.com/v3/smtp/email";
const BREVO_TIMEOUT_MS = 10000; // under the callers' 12s limit (sendWithTimeout)

/** '"PassKru App" <noreply@x.com>' or 'noreply@x.com' -> { name, email }. */
export function parseFrom(value) {
  const text = String(value || "").trim();
  const match = text.match(/^\s*"?([^"<]*?)"?\s*<([^>]+)>\s*$/);
  if (match) return { name: match[1].trim() || undefined, email: match[2].trim() };
  return { email: text };
}

/**
 * Brevo's transactional email API over HTTPS (port 443). Used when
 * BREVO_API_KEY is set, because some hosts (Railway below Pro) block outbound
 * SMTP ports entirely. The sender address must be verified in Brevo.
 */
async function sendViaBrevo({ from, to, subject, html }) {
  const res = await fetch(BREVO_ENDPOINT, {
    method: "POST",
    headers: {
      accept: "application/json",
      "content-type": "application/json",
      "api-key": process.env.BREVO_API_KEY,
    },
    body: JSON.stringify({ sender: parseFrom(from), to: [{ email: to }], subject, htmlContent: html }),
    signal: AbortSignal.timeout(BREVO_TIMEOUT_MS),
  });
  if (!res.ok) {
    // Brevo error bodies are { code, message }; never echo request headers (the key).
    let detail = "";
    try {
      const body = await res.json();
      detail = [body?.code, body?.message].filter(Boolean).join(": ");
    } catch {
      // Non-JSON body: the status is enough.
    }
    const error = new Error(`Brevo API ${res.status}${detail ? ` (${detail})` : ""}`);
    error.code = `BREVO_${res.status}`;
    throw error;
  }
}

function printToConsole(title, to, consoleLines) {
  console.log("\n=======================================================");
  console.log(`             ${title}`);
  console.log(`  Recipient Email : ${to}`);
  for (const line of consoleLines) console.log(`  ${line}`);
  console.log("=======================================================\n");
}

/**
 * Sends one email. Transport, in order: Brevo HTTPS API (BREVO_API_KEY), then
 * SMTP (SMTP_HOST/USER/PASS), else the console (development only — a missing
 * mail config in production means users silently never get their codes).
 * In development a failed send also falls back to the console so nobody is
 * blocked; in production it throws and the caller answers with 503.
 */
async function deliver({ to, subject, html, consoleLines }) {
  const from = process.env.EMAIL_FROM || process.env.SMTP_FROM || DEFAULT_FROM;
  const useBrevo = Boolean(process.env.BREVO_API_KEY);
  const transporter = useBrevo ? null : getTransporter();

  if (useBrevo || transporter) {
    const mode = useBrevo ? "brevo" : "smtp";
    try {
      if (useBrevo) await sendViaBrevo({ from, to, subject, html });
      else await transporter.sendMail({ from, to, subject, html });

      console.log(`[EMAIL_SERVICE] Email "${subject}" sent via ${mode} to: ${to}`);
      return { sent: true, mode };
    } catch (err) {
      console.error(`[EMAIL_SERVICE] ${mode} send error:`, err?.code || "", err?.message || err);
      if (process.env.NODE_ENV !== "production") {
        console.warn("[EMAIL_SERVICE] Falling back to console output (development mode)...");
        printToConsole("[PASSKRU EMAIL SERVICE - FALLBACK]", to, consoleLines);
        return { sent: true, mode: "console_fallback" };
      }
      throw new Error(`Failed to send email via ${mode}: ${err?.message || err}`);
    }
  }

  printToConsole("[PASSKRU EMAIL SERVICE]", to, consoleLines);
  return { sent: true, mode: "console_fallback" };
}

/**
 * Send 6-Digit Email Verification OTP
 */
export async function sendVerificationOtpEmail({ email, otp, firstName = "Candidate" }) {
  const htmlContent = `
    <div style="font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; max-width: 520px; margin: 0 auto; background-color: #ffffff; border: 1px solid #e2e8f0; border-radius: 16px; overflow: hidden; box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.05);">
      <div style="background-color: #133363; padding: 24px; text-align: center;">
        <h1 style="color: #ffffff; margin: 0; font-size: 24px; font-weight: 800; tracking-tight: -0.025em;">PASSKRU</h1>
        <p style="color: #93c5fd; margin: 4px 0 0 0; font-size: 13px;">ប្រព័ន្ធរៀបចំប្រឡងគ្រូបង្រៀន</p>
      </div>
      
      <div style="padding: 32px 24px; color: #1e293b;">
        <h2 style="font-size: 18px; font-weight: 700; margin-top: 0; color: #0f172a;">សូមស្វាគមន៍, ${escapeHtml(firstName)}!</h2>
        <p style="font-size: 14px; line-height: 1.6; color: #475569; margin-bottom: 24px;">
          សូមប្រើប្រាស់លេខកូដផ្ទៀងផ្ទាត់ (OTP) ខាងក្រោមដើម្បីបញ្ជាក់អាសយដ្ឋានអ៊ីមែលរបស់អ្នកនៅលើ PassKru៖
        </p>

        <div style="background-color: #f8fafc; border: 2px dashed #cbd5e1; border-radius: 12px; padding: 20px; text-align: center; margin-bottom: 24px;">
          <span style="font-family: monospace; font-size: 32px; font-weight: 900; letter-spacing: 8px; color: #133363;">${escapeHtml(otp)}</span>
          <p style="font-size: 12px; color: #64748b; margin: 8px 0 0 0;">លេខកូដនេះមានសុពលភាពរយៈពេល ១០ នាទី</p>
        </div>

        <p style="font-size: 13px; line-height: 1.5; color: #64748b;">
          ប្រសិនបើអ្នកមិនបានស្នើសុំលេខកូដនេះទេ សូមរំលងអ៊ីមែលនេះដោយសុវត្ថិភាព។
        </p>
      </div>

      <div style="background-color: #f1f5f9; padding: 16px; text-align: center; border-top: 1px solid #e2e8f0;">
        <p style="font-size: 11px; color: #94a3b8; margin: 0;">&copy; ${new Date().getFullYear()} PassKru Platform. All rights reserved.</p>
      </div>
    </div>
  `;

  return deliver({
    to: email,
    subject: `[PassKru] ${otp} - លេខកូដផ្ទៀងផ្ទាត់អ៊ីមែលរបស់អ្នក (Verification Code)`,
    html: htmlContent,
    consoleLines: [`Recipient Name  : ${firstName}`, `VERIFICATION OTP: >>> ${otp} <<<`, "Validity        : 10 Minutes"],
  });
}

/**
 * Sent instead of an OTP when someone tries to register an email that already
 * has a verified account, so the register endpoint can answer identically
 * either way and not reveal which emails are registered.
 */
export async function sendAccountExistsEmail({ email }) {
  const htmlContent = `
    <div style="font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; max-width: 520px; margin: 0 auto; background-color: #ffffff; border: 1px solid #e2e8f0; border-radius: 16px; overflow: hidden;">
      <div style="background-color: #133363; padding: 24px; text-align: center;">
        <h1 style="color: #ffffff; margin: 0; font-size: 24px; font-weight: 800;">PASSKRU</h1>
      </div>
      <div style="padding: 32px 24px; color: #1e293b;">
        <p style="font-size: 14px; line-height: 1.6; color: #475569;">
          មាននរណាម្នាក់ (ប្រហែលជាអ្នក) បានព្យាយាមបង្កើតគណនីថ្មីដោយប្រើអ៊ីមែលនេះ ប៉ុន្តែអ៊ីមែលនេះមានគណនីរួចហើយ។ សូមចូលប្រព័ន្ធ (Sign in) ជំនួសវិញ។
        </p>
        <p style="font-size: 14px; line-height: 1.6; color: #475569;">
          Someone (probably you) tried to create a new PassKru account with this email, but an account already exists. Please sign in instead.
        </p>
        <p style="font-size: 13px; line-height: 1.5; color: #64748b;">
          ប្រសិនបើមិនមែនជាអ្នកទេ សូមរំលងអ៊ីមែលនេះ។ / If this wasn't you, you can ignore this email.
        </p>
      </div>
    </div>
  `;

  return deliver({
    to: email,
    subject: "[PassKru] អ្នកមានគណនីរួចហើយ (You already have an account)",
    html: htmlContent,
    consoleLines: ["ACCOUNT EXISTS notice (register attempt on a verified email)"],
  });
}

const OTP_EMAIL_COPY = {
  login: {
    subjectKm: "លេខកូដចូលប្រព័ន្ធ (Sign-in Code)",
    bodyKm: "សូមប្រើលេខកូដ (OTP) ខាងក្រោមដើម្បីបញ្ចប់ការចូលប្រើប្រាស់គណនី PassKru របស់អ្នក៖",
    note: "SIGN-IN OTP",
  },
  reset: {
    subjectKm: "លេខកូដកំណត់ពាក្យសម្ងាត់ឡើងវិញ (Password Reset Code)",
    bodyKm: "យើងបានទទួលសំណើកំណត់ពាក្យសម្ងាត់ឡើងវិញ។ សូមប្រើលេខកូដ (OTP) ខាងក្រោម៖",
    note: "PASSWORD RESET OTP",
  },
};

/**
 * Sends a 6-digit OTP for sign-in ("login") or password reset ("reset").
 */
export async function sendPurposeOtpEmail({ email, otp, firstName = "Candidate", purpose }) {
  const copy = OTP_EMAIL_COPY[purpose];
  if (!copy) throw new Error(`Unknown OTP purpose: ${purpose}`);

  const htmlContent = `
    <div style="font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; max-width: 520px; margin: 0 auto; background-color: #ffffff; border: 1px solid #e2e8f0; border-radius: 16px; overflow: hidden;">
      <div style="background-color: #133363; padding: 24px; text-align: center;">
        <h1 style="color: #ffffff; margin: 0; font-size: 24px; font-weight: 800;">PASSKRU</h1>
      </div>
      <div style="padding: 32px 24px; color: #1e293b;">
        <h2 style="font-size: 18px; font-weight: 700; margin-top: 0; color: #0f172a;">សួស្តី, ${escapeHtml(firstName)}</h2>
        <p style="font-size: 14px; line-height: 1.6; color: #475569; margin-bottom: 24px;">${copy.bodyKm}</p>
        <div style="background-color: #f8fafc; border: 2px dashed #cbd5e1; border-radius: 12px; padding: 20px; text-align: center; margin-bottom: 24px;">
          <span style="font-family: monospace; font-size: 32px; font-weight: 900; letter-spacing: 8px; color: #133363;">${escapeHtml(otp)}</span>
          <p style="font-size: 12px; color: #64748b; margin: 8px 0 0 0;">លេខកូដនេះមានសុពលភាពរយៈពេល ១០ នាទី</p>
        </div>
        <p style="font-size: 13px; line-height: 1.5; color: #64748b;">
          ប្រសិនបើអ្នកមិនបានស្នើសុំទេ សូមរំលងអ៊ីមែលនេះ ហើយកុំចែករំលែកលេខកូដនេះជាមួយនរណាម្នាក់។ យើងនឹងមិនសួរលេខកូដនេះតាមទូរស័ព្ទ ឬសារឡើយ។
        </p>
      </div>
    </div>
  `;

  return deliver({
    to: email,
    subject: `[PassKru] ${otp} - ${copy.subjectKm}`,
    html: htmlContent,
    consoleLines: [`Recipient Name  : ${firstName}`, `${copy.note}: >>> ${otp} <<<`, "Validity        : 10 Minutes"],
  });
}

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
      cachedTransporter = nodemailer.createTransport({
        host,
        port,
        secure: port === 465,
        family: 4, // Force IPv4 to prevent ENETUNREACH on systems without IPv6 routing
        auth: { user, pass },
        pool: true,
        maxConnections: 3,
        maxMessages: 100,
        connectionTimeout: 10000,
        greetingTimeout: 10000,
        socketTimeout: 15000,
      });
    }
    return cachedTransporter;
  }
  return null;
}

/**
 * Sends one email via SMTP, or prints it to the console when SMTP isn't
 * configured (development only — a missing SMTP config in production means
 * users silently never get their codes).
 */
async function deliver({ to, subject, html, consoleLines }) {
  const from = process.env.SMTP_FROM || '"PassKru App" <noreply@passkru.com>';
  const transporter = getTransporter();

  if (transporter) {
    try {
      await transporter.sendMail({ from, to, subject, html });

      console.log(`[EMAIL_SERVICE] Email "${subject}" sent via SMTP to: ${to}`);
      return { sent: true, mode: "smtp" };
    } catch (err) {
      console.error("[EMAIL_SERVICE] SMTP send error:", err?.message || err);
      // In local development, fallback to console log so developers are never blocked
      if (process.env.NODE_ENV !== "production") {
        console.warn("[EMAIL_SERVICE] Falling back to console output (development mode)...");
        console.log("\n=======================================================");
        console.log("             [PASSKRU EMAIL SERVICE - FALLBACK]        ");
        console.log(`  Recipient Email : ${to}`);
        for (const line of consoleLines) console.log(`  ${line}`);
        console.log("=======================================================\n");
        return { sent: true, mode: "console_fallback" };
      }
      throw new Error(`Failed to send email via SMTP: ${err?.message || err}`);
    }
  }

  // Fallback for Development Mode without live SMTP configured
  console.log("\n=======================================================");
  console.log("             [PASSKRU EMAIL SERVICE]                   ");
  console.log(`  Recipient Email : ${to}`);
  for (const line of consoleLines) console.log(`  ${line}`);
  console.log("=======================================================\n");

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

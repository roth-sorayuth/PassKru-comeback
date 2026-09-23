import nodemailer from "nodemailer";

/**
 * Send 6-Digit Email Verification OTP
 */
export async function sendVerificationOtpEmail({ email, otp, firstName = "Candidate" }) {
  const host = process.env.SMTP_HOST;
  const port = Number(process.env.SMTP_PORT) || 587;
  const user = process.env.SMTP_USER;
  const pass = process.env.SMTP_PASS;
  const from = process.env.SMTP_FROM || '"PassKru App" <noreply@passkru.com>';

  const htmlContent = `
    <div style="font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; max-width: 520px; margin: 0 auto; background-color: #ffffff; border: 1px solid #e2e8f0; border-radius: 16px; overflow: hidden; box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.05);">
      <div style="background-color: #133363; padding: 24px; text-align: center;">
        <h1 style="color: #ffffff; margin: 0; font-size: 24px; font-weight: 800; tracking-tight: -0.025em;">PASSKRU</h1>
        <p style="color: #93c5fd; margin: 4px 0 0 0; font-size: 13px;">ប្រព័ន្ធរៀបចំប្រឡងគ្រូបង្រៀន</p>
      </div>
      
      <div style="padding: 32px 24px; color: #1e293b;">
        <h2 style="font-size: 18px; font-weight: 700; margin-top: 0; color: #0f172a;">សូមស្វាគមន៍, ${firstName}!</h2>
        <p style="font-size: 14px; line-height: 1.6; color: #475569; margin-bottom: 24px;">
          សូមប្រើប្រាស់លេខកូដផ្ទៀងផ្ទាត់ (OTP) ខាងក្រោមដើម្បីបញ្ជាក់អាសយដ្ឋានអ៊ីមែលរបស់អ្នកនៅលើ PassKru៖
        </p>

        <div style="background-color: #f8fafc; border: 2px dashed #cbd5e1; border-radius: 12px; padding: 20px; text-align: center; margin-bottom: 24px;">
          <span style="font-family: monospace; font-size: 32px; font-weight: 900; letter-spacing: 8px; color: #133363;">${otp}</span>
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

  if (host && user && pass) {
    try {
      const transporter = nodemailer.createTransport({
        host,
        port,
        secure: port === 465,
        auth: { user, pass },
        connectionTimeout: 5000,
        greetingTimeout: 5000,
        socketTimeout: 8000,
      });

      await transporter.sendMail({
        from,
        to: email,
        subject: `[PassKru] ${otp} - លេខកូដផ្ទៀងផ្ទាត់អ៊ីមែលរបស់អ្នក (Verification Code)`,
        html: htmlContent,
      });

      console.log(`[EMAIL_SERVICE] OTP email successfully sent via SMTP to: ${email}`);
      return { sent: true, mode: "smtp" };
    } catch (err) {
      console.error("[EMAIL_SERVICE] SMTP send error:", err?.message || err);
      throw new Error(`Failed to send verification email via SMTP: ${err?.message || err}`);
    }
  }

  // Fallback for Development Mode without live SMTP configured
  console.log("\n=======================================================");
  console.log("             [PASSKRU EMAIL OTP SERVICE]               ");
  console.log(`  Recipient Email : ${email}`);
  console.log(`  Recipient Name  : ${firstName}`);
  console.log(`  VERIFICATION OTP: >>> ${otp} <<<`);
  console.log("  Validity        : 10 Minutes");
  console.log("=======================================================\n");

  return { sent: true, mode: "console_fallback" };
}

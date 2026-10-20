# PassKru — Bug & Security Fix Plan

Audit date: 2026-10-20 · Branch: `dev` (after `6c04ab8 Harden auth`)
Scope: `server/` (Express + Prisma API), `client/` (learner app), `adminDashboard/` (admin app).

> **Database policy (AGENTS.md):** nothing in this plan requires running a migration,
> `db push`, seed or raw SQL. The one database-side item (Supabase Storage policies, P0-1)
> is listed as SQL/console steps for **you** to review and apply by hand.

---

## What is already in good shape

The recent hardening work holds up. These were checked and need no change:

- Ownership checks on attempts, placement tests, study plans, weekly updates and notifications (every lookup compares `userId`).
- Grading uses the DB answer key; tampered option IDs score nothing; "for taking" quiz/mock shapes strip `isCorrect`.
- Admin routes (`questions`, `users`, all create/update/delete) sit behind `protect` + `admin`, and `admin` re-reads the role from the DB on each request.
- Login: constant-time dummy bcrypt for unknown emails, uniform error messages, HMAC-tagged single-use login/reset OTPs, admin forced through password + emailed code.
- Google OAuth: `returnTo`/`state` restricted to the origin allow-list; only verified Google emails link to existing accounts.
- CORS allow-list, Origin-based CSRF guard, no urlencoded parser, security headers, API docs off in production.
- `toPublicUser` allow-list keeps password hashes / OTP state out of responses.
- Paper links are re-signed on every read with the service key (server-side only).
- KaTeX runs with `trust` off, so `MathText`'s `dangerouslySetInnerHTML` is not an XSS path today.

---

## P0 — Fix first (exploitable now)

### P0-1. Anyone can upload files to Supabase Storage
**Where:** `adminDashboard/src/lib/supabase.ts` (`uploadPaperToStorage`, `uploadAnnouncement*`, `uploadMentorImageToStorage`)

The admin app uploads straight to the `papers` / `announcement` buckets with the **anon key**. That key ships in both frontends' JS bundles, so the bucket policies must allow anonymous `INSERT`, which means anyone can upload anything, including HTML/SVG files that run script on the Supabase domain, malware, or enough data to fill your storage quota. It also means the `papers` bucket can't really be private.

**Fix**
1. Add an admin-only API route, e.g. `POST /api/uploads/sign` (`protect, admin`). The server validates the requested kind (`paper | announcement-doc | announcement-image | mentor-image`), MIME type and size, generates the object path itself, and returns a **signed upload URL** made with `SUPABASE_SERVICE_ROLE_KEY` (`/storage/v1/object/upload/sign/<bucket>/<path>`).
2. The admin app uploads to that signed URL, then saves the path/URL through the existing API.
3. Only allow `application/pdf` for papers and documents, and `image/png|jpeg|webp` for images (**no SVG**). Cap sizes on the server.
4. **You apply by hand in Supabase:** remove the anon/`authenticated` `INSERT`/`UPDATE`/`DELETE` policies on `storage.objects` for these buckets, then make `papers` private. Proposed SQL is below. Check the policy names in the dashboard before running it.
   ```sql
   -- Review existing policies first:
   select policyname, cmd, roles, qual, with_check from pg_policies where schemaname = 'storage' and tablename = 'objects';
   -- Then drop the ones granting anon/authenticated writes, e.g.:
   -- drop policy "<policy name>" on storage.objects;
   update storage.buckets set public = false where id = 'papers';
   ```
5. Remove `VITE_SUPABASE_ANON_KEY` from the admin app if nothing else uses it. Run `grep -rn "supabase\." client/src adminDashboard/src` to confirm.

**Verify:** with the anon key, `curl -X POST .../storage/v1/object/papers/x.pdf` returns 403; admin upload still works; paper links still open (signed).

### P0-2. Session tokens can't be revoked and sit in `localStorage`
**Where:** `server/src/middlewares/authMiddleware.js:10,52`, `server/src/controllers/authController.js:121-131,319-340`, `server/src/routes/authRoutes.js:77-91,133-145`, `client/src/utils/api.ts:16`, `client/src/context/AuthContext.tsx:57`, `client/src/components/pages/AuthPage.tsx:163,244`, `adminDashboard/src/lib/api.ts:24`, `adminDashboard/src/App.tsx:132`

Every login returns the 7-day JWT in the JSON body. Both frontends save it to `localStorage` and send it as `Bearer`. As a result:
- any XSS (or a malicious npm dependency) can steal a 7-day admin session, which defeats the `httpOnly` cookie;
- logout and password reset do **not** end existing sessions. A stolen token keeps working for 7 days, even after the victim resets their password.

**Fix:** use the `Session` table that already exists in `schema.prisma` and is never used, so no schema change is needed.
1. On login, create `Session { userId, expiresAt }` and sign the JWT as `{ sid, userId, typ: "session" }`. Put the shared signing and cookie code in one helper. It is currently copied in 4 places: `sendSession`, `verifyOtp`, Google callback, Google exchange.
2. In `protect`/`optionalProtect`, require `typ === "session"`, look up `sid`, and reject the token if the session is missing or expired. This also stops the 60-second Google exchange code (`purpose: "google_exchange"`) from working as a bearer token, which it currently does.
3. `POST /logout` deletes the session row. `resetPassword` and an admin role change delete **all** of that user's sessions.
4. Stop returning `token` in JSON bodies. Delete the `localStorage` token code in both apps and depend on the cookie (`withCredentials: true`).
   - If third-party-cookie blocking (Safari/iOS) is the reason the bearer fallback exists, the proper fix is to serve the API from the same site as the apps (e.g. `api.passkru.com` next to `passkru.com`) so the cookie becomes first-party and can use `SameSite=Lax`. If that isn't possible yet, keep the bearer path for now, but keep steps 1–3 and shorten its lifetime (e.g. 1 day).
5. Delete the unused legacy `server/src/middlewares/auth.js` (`authenticateToken`), which skips all of these checks.

**Verify:** log in, copy the token, log out, and the old token now gets 401. Reset the password and every other device gets 401. Sending the Google exchange code as `Bearer` gets 401.

### P0-3. Public endpoint dumps the whole question bank
**Where:** `server/src/controllers/quizController.js:30`, `server/src/services/quizService.js:320`

`GET /api/quizzes/category-questions?limit=100000` is unauthenticated and has no cap, so one request returns every question with its options. That is a scraping and DoS risk. A non-numeric `limit` becomes `NaN` and causes a 500.

**Fix:** clamp `limit` to 1–100 and `offset` to ≥ 0 (default 50/0 when the value is invalid). Decide whether this route should require `protect` like `/papers` does. Apply the same clamp to any other list endpoint that takes `limit`.

### P0-4. Vulnerable dependencies (1 critical, 5 high in the server)
`npm audit --omit=dev` results:

| Package | Severity | Where | Note |
|---|---|---|---|
| `proxy-addr` ≤2.0.7 | **critical** | server, client | IP spoofing via IPv4-mapped IPv6. Matters because `trust proxy` is on, so it can bypass the IP-keyed rate limits |
| `qs` / `body-parser` | moderate | server, client | DoS |
| `prisma` / `@prisma/config` / `deepmerge-ts` | high | server | upgrade to a Prisma release past 7.10 |
| `mysql2` (via prisma) | high | server | unused driver, pulled in transitively, fixed by the Prisma upgrade |
| `brace-expansion`, `sprintf-js` (via `yamljs`) | high/moderate | server | `yamljs` looks unused (spec is `openapi.js`), so remove it |
| `katex` ≤0.18.1 | low | admin, client | prototype pollution can bypass `trust`. Upgrade to 0.19 and re-test math rendering |
| `source-map-js` | high | client, admin | build-time only |

**Fix:** `npm update express`, `npm audit fix` in each package, upgrade Prisma (`prisma generate` only, no DB command), and remove unused deps (`yamljs`, `svix`, plus `body-parser` usage, `express` in client if `client/server.ts` goes, see P2-1). Re-run `npm audit --omit=dev` until it shows 0 high/critical.

---

## P1 — High priority (bugs and weaker spots)

### P1-1. Profile update accepts unvalidated input → 500s / bad data
**Where:** `server/src/services/authService.js:175,233` (and `availableStudyHours`, `targetExamId`)
- `avatarUrl` accepts any string, including `javascript:` or http URLs. Only accept `https:` (ideally only your Supabase or Google hosts) and limit length.
- `dailyGoalMinutes`, `availableStudyHours`, `targetExamId` go through `Number()` with no checks. `"abc"` becomes `NaN` and Prisma throws a 500. Validate them as integers in a sensible range and return 400 otherwise.
- `firstName`/`lastName`/`phoneNumber` have no length limits. Bound them to the column sizes to avoid a DB error that becomes a 500.

### P1-2. Double-submit race on attempts
**Where:** `server/src/services/attemptService.js:86`
The `endTime` check and the update are separate steps, so two concurrent submits both get graded and both update proficiency and weak areas twice. Make the final `attempt.update` conditional (`updateMany where { attemptId, endTime: null }` → require `count === 1`) inside the transaction. Do the same in `placementService` submit.

### P1-3. Mentor booking spam and bad input
**Where:** `server/src/services/mentorService.js:216-234`
- Bookings are accepted for mentors that are `pending`/`rejected`/`suspended`. Only allow `approved`.
- `sessionDate` with no validation gives `Invalid Date` and a 500. Validate it, and reject dates in the past.
- `note`/`timeSlot` have no length cap, and there is no per-user limit. Add a small rate limit (e.g. 10/day/user) and length caps.

### P1-4. Registration leaks info and lets someone hijack a pending signup
**Where:** `server/src/controllers/authController.js:197-226,260`
- The 409 "account already exists" response reveals which emails are registered, unlike every other auth endpoint. Return the same `registerAccepted` response and email the existing owner instead (`sendAccountExistsEmail` is already imported).
- Re-registering an **unverified** email overwrites its name, password and OTP. Someone can keep resetting a real user's pending signup. Let the OTP flow finish instead: only replace a pending row after its OTP has expired, and don't reset `otpCount`, which currently resets the daily OTP cap.
- `message: emailError?.message` sends raw SMTP error text to the client. Always return `REGISTER_EMAIL_FAILED`.
- Signup OTPs are stored in plain text, while login/reset OTPs use HMAC tags. Use `otpTag` with a `"V"` purpose for these too.

### P1-5. Rate limits are per-instance and IP-spoofable
**Where:** `server/src/middlewares/rateLimit.js`, `server/src/app.js:20`
In-memory counters reset on every deploy or restart and don't share across instances. Combined with the `proxy-addr` bug (P0-4), IP keys can be bypassed. Fix the dependency first. Then, if you run more than one instance, move to a shared store (Redis / Upstash). Make sure `trust proxy` matches the real hop count on Railway.
Also add a general per-IP limiter on the public API (e.g. 300 req / 5 min) and a limiter on `/google/exchange` keyed by IP, since `emailKey` is empty there.

### P1-6. Google exchange code reuse after a restart
**Where:** `server/src/routes/authRoutes.js:16,47-71`
`usedExchangeCodes` is an in-memory `Set`, so after a restart a code can be redeemed again within its 60 seconds. Once P0-2 lands, give the code a `jti`, record it in the `Session` table or a small cache, and pass `{ algorithms: ["HS256"] }` to `jwt.verify` at line 60. Also, the callback sets the 7-day cookie **and** issues the code. Pick one: set the cookie only during the exchange.

### P1-7. Admin safety rails
**Where:** `server/src/services/userService.js:140-213`
- An admin can delete or demote themselves or the **last** admin, which locks everyone out. Block both.
- Changing a user's email doesn't reset `isEmailVerified` or notify the old address. Reset verification and send a notice.
- Changing a user's role or email should revoke their sessions (needs P0-2).
- Add an audit log line (who, what, when) for user/role changes and deletes. Use `console` structured logs if you don't want a new table.

### P1-8. Mock-exam section endpoints don't check the parent
**Where:** `server/src/services/quizService.js:619-672`, `mockExamController`
`PUT/DELETE /mock-exams/:mockExamId/sections/:sectionId` ignores `mockExamId`, so a section from exam A can be edited through exam B's URL. This is admin-only and low risk, but it's a correctness bug. Check `section.mockExamId === mockExamId`. Also check that `questionIds` exist before `createMany`, which currently causes a 500 on FK errors.

---

## P2 — Cleanup and hardening

### P2-1. Remove dead and risky code from the repo
- `client/server.ts`: old Express/SQLite/Gemini prototype that imports a `./server/database` file that doesn't exist. Delete it (and the `express`/`@google/genai` deps in `client` if they're unused).
- `server/src/routes/clerkWebhook.js` (not mounted, imports undeclared `body-parser`), Clerk helpers in `authService.js`, and empty files: `config/cloudinary.js`, `middlewares/{errorHandler,upload,validate}.js`, `utils/{generateToken,hashPassword,responseHandler}.js`, `src/test-hash.js`.
- `client/src/components/auth/*.jsx`, `client/src/context/AuthContext.jsx`, `client/src/hooks/useAuth.js`: duplicate JSX copies next to the `.tsx` versions. Delete whichever is unused.
- **`server/raw_user_payload_*.jsonl.json` (16 files), `extract_user_prompts.js`, `parse_*`:** these are dumps of AI-agent conversation transcripts. They don't belong in git. Remove them, add them to `.gitignore`, and check them for any personal data or secrets before deciding whether the history needs rewriting.
- ~40 one-off scripts in `server/` root (`seed_*.js`, `manual_migrate.js`, `update_*.js`, `fix_quizzes.js`, `restore_all.js`…). They write to the database, and AGENTS.md forbids agents from running them. Move them into `server/scripts/` with a README, or delete the ones already applied. **Do not run them while cleaning up.**
- Remove `VITE_CLERK_PUBLISHABLE_KEY` from both `.env.example` files (Clerk is gone).

### P2-2. Content-Security-Policy on the frontends
**Where:** `client/public/_headers`, `adminDashboard/public/_headers`
Both set XFO/nosniff/HSTS but **no CSP**. Add one, at minimum `default-src 'self'; script-src 'self'; connect-src 'self' <API origin> <Supabase origin>; img-src 'self' data: https:; frame-src <Supabase origin>; object-src 'none'; base-uri 'self'; frame-ancestors 'none'`. Roll it out as `Content-Security-Policy-Report-Only` first. Add `includeSubDomains` to HSTS. `vercel.json` exists too. Pick one host (Cloudflare Pages or Vercel) and make sure the headers are set there.

### P2-3. Smaller items
- `adminDashboard`/`client` `dev` scripts use `--host=0.0.0.0`, which exposes the dev server to the LAN. Default to localhost.
- `target="_blank"` links use `rel="noreferrer"` (fine). Keep that when adding new ones.
- `server.js` exits on any `unhandledRejection`. Fine on Railway (it restarts), but log the stack and add a `SIGTERM` graceful shutdown.
- `getCategoryQuestions` / `listQuizzes` pass user strings straight into `mode: 'insensitive'` filters. That's safe with Prisma, but cap their length.
- `OTP_TTL`/cookie/session settings are repeated in several files. Move them into one `config/auth.js`.
- Login OTP lockout: `otpVerifyLimiter` is 5 tries/hour **per email**, so an attacker can lock a user out of signing in. That's an acceptable trade-off, but show a clear "try again in N minutes" message.

---

## P3 — Make it stay fixed

1. **Tests.** There are none. Add `vitest` + `supertest` to `server/` and cover at least:
   - authz: candidate → admin route = 403; user A → user B's attempt / plan / notification = 404;
   - auth: logout revokes; reset revokes; exchange code can't be used as a bearer token; `limit` clamp;
   - grading: tampered option, double submit.
   Run them against a **separate test database** that you create; agents must not point tests at the real DB.
2. **CI** (GitHub Actions): `npm ci`, `npm audit --omit=dev --audit-level=high`, `tsc --noEmit` for both frontends, server tests.
3. **Secrets:** confirm `JWT_SECRET` is ≥32 random bytes in production and differs per environment, and that `SUPABASE_SERVICE_ROLE_KEY` exists only in Railway. Rotate the Supabase anon key after P0-1 if the old bucket policies were ever public-write.
4. Turn on Dependabot or Renovate for all three `package.json`s.

---

## Suggested order of work

| Step | Items | Size | Needs you to run something? |
|---|---|---|---|
| 1 | P0-4 dependency upgrades | S | no |
| 2 | P0-3 limit clamp, P1-1 input validation, P1-2 race, P1-3 mentors, P1-8 sections | S–M | no |
| 3 | P0-1 signed uploads (code) | M | **yes: Supabase storage policies (SQL above)** |
| 4 | P0-2 server sessions + drop localStorage tokens | M–L | no (table already exists) |
| 5 | P1-4, P1-5, P1-6, P1-7 auth & admin follow-ups | M | no |
| 6 | P2 cleanup + CSP | M | deploy header changes |
| 7 | P3 tests + CI | M | create a test DB |

Ship each step as its own PR into `dev` so each one can be reviewed and rolled back separately.

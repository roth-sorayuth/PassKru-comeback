# PassKru — Project Context (for an AI assistant)

> Paste this whole file into the chat before asking questions about PassKru.
> Snapshot of the `dev` branch, 20 Oct 2026. No secrets are included. Never ask
> for or paste real keys, passwords or database URLs.

## 1. What PassKru is

PassKru is a Khmer-first web app that helps Cambodians prepare for the **Ministry of
Education, Youth and Sport (MoEYS) teacher-trainee recruitment exams**. Candidates:

- choose their exam track and subjects,
- take a placement test, then get an AI-generated (Gemini) weekly study plan,
- practise with quizzes, mock exams, flashcards, past papers and "prepare" papers,
- see weak areas, progress, streaks and announcements,
- browse and request consultations with mentors (feature marked "Coming Soon").

The UI is bilingual (Khmer default, English). Users are mostly on phones.

## 2. Exam tracks and subject rules

Defined in `server/src/config/examSubjects.js` and served to the client by the API.
The file states plainly that the lists were **compiled from secondary sources, not an
official MoEYS circular**. They need checking against the official notice.

| Code | Khmer name | Level | How subjects are chosen |
|---|---|---|---|
| `nie` | កម្រិតឧត្តម (វិទ្យាល័យ) | Upper secondary (BA+1 at National Institute of Education) | Pick **one** major |
| `rttc` | កម្រិតមូលដ្ឋាន (អនុវិទ្យាល័យ) | Lower secondary (12+2 at Regional Teacher Training Centres) | Pick **one pair** (ឯកទេសគូ) |
| `pttc` | កម្រិតបឋមសិក្សា | Primary (and kindergarten teachers) | No choice: Math, Khmer, Pedagogy, English |

Every candidate also sits **General Knowledge (វប្បធម៌ទូទៅ)** and **English**.

**NIE majors:** Math, Physics, Chemistry, Biology, Earth Science, Khmer Literature,
History, Geography, Morality & Civics, English, French, ICT.

**RTTC pairs currently in the app:**
1. គណិតវិទ្យា + រូបវិទ្យា (Math + Physics)
2. រូបវិទ្យា + គីមីវិទ្យា (Physics + Chemistry)
3. ជីវវិទ្យា + ផែនដីវិទ្យា (Biology + Earth Science)
4. ប្រវត្តិវិទ្យា + ភូមិវិទ្យា (History + Geography)
5. អក្សរសាស្ត្រខ្មែរ + សីលធម៌-ពលរដ្ឋវិជ្ជា (Khmer + Morality & Civics)
6. ភាសាបារាំង + គណិតវិទ្យា (French + Math) ← **unverified**
7. ភាសាបារាំង + រូបវិទ្យា (French + Physics) ← **unverified**
8. ភាសាបារាំង + ជីវវិទ្យា (French + Biology) ← **unverified**
9. ព័ត៌មានវិទ្យា + ភាសាអង់គ្លេស (ICT + English)
10. ភាសាអង់គ្លេស + អក្សរសាស្ត្រខ្មែរ (English + Khmer)

**Open question:** do the official MoEYS 12+2 (lower-secondary) recruitment pairs
really include French? A web search (Oct 2026) found no official pair list. NIE's site
lists a separate "ភាសាបារាំង (១២ + ២)" programme, which suggests French may be its
own track rather than paired with Math, Physics or Biology. The source should be the
latest MoEYS sentence/notice (សេចក្តីជូនដំណឹង) for the គរុសិស្ស ១២+២ exam.

## 3. Architecture

| Part | Folder | Stack | Hosting |
|---|---|---|---|
| Candidate app | `client/` | React 19, Vite 6, TypeScript, Tailwind 4, React Router 7, KaTeX | Vercel / Cloudflare Pages |
| Admin dashboard | `adminDashboard/` | React 19, Vite 6, TypeScript, Tailwind 4, axios | Vercel / Cloudflare Pages |
| API | `server/` | Node, Express 4 (ES modules), Prisma 7 + `pg` adapter, Passport (Google), nodemailer, Gemini (`@google/genai`) | Railway |
| Database | — | PostgreSQL on Supabase | Supabase |
| Files | — | Supabase Storage buckets `papers` (private, signed links) and `announcement` (public) | Supabase |
| Game | `game/` | Separate booth arcade (gitignored) | Cloudflare Pages |

**Database models:** Exam, User, Session, Announcement, Notification, Subject, Topic,
PastPaper, Question, AnswerOption, Quiz, QuizQuestion, FlashcardDeck, Flashcard, MockExam,
MockExamSection, MockExamQuestion, Attempt, AttemptAnswer, ProgressRecord, WeakArea,
StudyPlan, Mentor, MentorBooking.

**API route groups (`/api/...`):** auth, announcements, notifications, exams, subjects,
papers, topics, study-plan, placement, progress, quizzes, mock-exams, attempts, mentors,
flashcards, weakness, questions (admin), users (admin), uploads (admin).

**Auth:** email + password with an emailed 6-digit OTP for sign-in, signup verification and
password reset (all codes stored as HMAC tags). Every sign-in creates a row in the `sessions`
table; the 7-day JWT only carries its id, so logout, password reset and admin role/email changes
end sessions immediately. The token travels in an httpOnly cookie, with a Bearer fallback kept in
localStorage because the API is cross-site and iOS blocks third-party cookies. Google sign-in
redirects with a 60-second single-use exchange code. Admins must use password + OTP.

## 4. Known data quirk

Subject rows are free text typed by admins, so the same subject exists under several
names ("Math", "Mathematics", "គណិតវិទ្យា"). Code normalises names through
`mapSubjectName` (server) / `canonicalSubjectName` (client) and alias lists in
`examSubjects.js`.

## 5. Security work (see `SECURITY_FIX_PLAN.md`)

Done:
- Dependency vulnerabilities fixed (npm audit clean in all three apps).
- Public question-bank endpoint capped; profile input validated.
- Double-submit race on attempts fixed; mock-exam sections scoped to their exam.
- Mentor bookings hardened; bookings no longer leak publicly.
- Admin uploads go through API-signed URLs instead of the Supabase anon key.
- Revocable server-side sessions; one-time Google exchange codes.
- Registration: no account enumeration, pending signups can't be hijacked, signup codes hashed.
- Admin rails: no self-demotion/deletion, last admin protected, audit log lines.
- Security headers (and a Report-Only CSP) served on Vercel via `vercel.json`.
- Dead code and agent transcript dumps removed from `server/`.
- Regression tests: `cd server && npm test` (node:test with an in-memory fake Prisma, no database).

Waiting on the owner:
- Run `supabase/storage_lockdown.sql` by hand after deploying.
- Confirm the RTTC French pairs against the official MoEYS notice.
- Shared rate-limit store (Redis) if the API ever runs on more than one instance.
- A throwaway test Postgres for CI (concurrency tests against a real database).
- Move the API to a same-site subdomain, then drop the localStorage token fallback.
- Switch the CSP from Report-Only to enforcing once the console shows no violations.

Release checklist before production (agreed with the reviewer):
- Smoke-test auth on production: login with code, logout, password reset, Google sign-in,
  and confirm an admin demotion takes effect immediately.
- Confirm one candidate can't see another's attempts, study plans or private papers.
- On a real phone: register and verify, placement test, generate a plan, submit a quiz
  (including after switching mobile data off and on), open a past paper; check Khmer text.
- Confirm Postgres backups are on and a restore has been tested somewhere isolated,
  including the private `papers` Storage files.
- Deploying the session change signs every user out once (old tokens have no session id).

Follow-up worth doing: save quiz answers locally per attempt so a crash or closed tab
can resume instead of losing progress (the app now only warns before leaving).

## 6. Rules for anyone (human or AI) working on the code

- **Never run anything that changes the database**: no `prisma db push`, `migrate`,
  `db seed`, seed scripts or raw SQL writes. Propose SQL or schema changes as text for a
  human to review and run.
- Keep Khmer text exactly as written (Unicode, no transliteration).
- The `SUPABASE_SERVICE_ROLE_KEY` is server-only. Never put it in a `VITE_*` variable.
- Branch `dev` → PR into `main`. Vercel/Cloudflare preview deployments run on PRs.

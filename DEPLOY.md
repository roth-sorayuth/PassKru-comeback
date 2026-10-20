# Deploying PassKru

| Part | Host | URL (example) |
|---|---|---|
| `client` (candidate app) | Cloudflare Pages | `https://passkru.pages.dev` |
| `adminDashboard` | Cloudflare Pages | `https://passkru-admin.pages.dev` |
| `game` (booth arcade) | Cloudflare Pages | `https://passkru-game.pages.dev` |
| `server` (Express API) | Railway | `https://<service>.up.railway.app` |

Pages project names become the subdomains, so pick them first and use the
same names everywhere below. The API stays on Railway: it is a long-running
Node server (Express, Prisma/pg, SMTP) and does not fit Cloudflare Workers.

> Without a custom domain, Cloudflare cannot sit in front of the API
> (WAF/DDoS proxy). If you later buy a domain (e.g. via Cloudflare Registrar),
> move everything under it: `app.`, `admin.`, `game.`, `api.` — see the last section.

---

## 1. Frontends on Cloudflare Pages (Git integration)

Cloudflare dashboard → **Workers & Pages → Create → Pages → Connect to Git**,
pick the GitHub repo, then create **two** projects with these settings.

### `client`

| Setting | Value |
|---|---|
| Production branch | `main` |
| Framework preset | Vite |
| Root directory | `client` |
| Build command | `npm run build` |
| Build output directory | `dist` |

Environment variables (Production):

| Name | Value |
|---|---|
| `NODE_VERSION` | `22` |
| `VITE_API_URL` | `https://<service>.up.railway.app/api` |
| `VITE_ADMIN_URL` | `https://passkru-admin.pages.dev` |

`VITE_API_URL` is required: without it the app falls back to
`http://<page-host>:5000/api`, which does not exist in production.

### `adminDashboard`

| Setting | Value |
|---|---|
| Production branch | `main` |
| Framework preset | Vite |
| Root directory | `adminDashboard` |
| Build command | `npm run build` |
| Build output directory | `dist` |

Environment variables (Production):

| Name | Value |
|---|---|
| `NODE_VERSION` | `22` |
| `VITE_API_URL` | `https://<service>.up.railway.app/api` |
| `VITE_CLIENT_URL` | `https://passkru.pages.dev` |
| `VITE_SUPABASE_URL` | `https://<project>.supabase.co` |
| `VITE_SUPABASE_ANON_KEY` | Supabase **anon** key only — never the service role key |

`VITE_*` values are baked into the public JavaScript bundle. Only put values
there that are safe for anyone to read.

### `game` (booth arcade)

Standalone static site: no login, no API, no database, no environment
variables. Games: flashcards (coding + វប្បធម៌ទូទៅ), Code Maze, Nim, and
Memory Match. Questions live in `game/src/data/`.

| Setting | Value |
|---|---|
| Production branch | `main` |
| Framework preset | Vite |
| Root directory | `game` |
| Build command | `npm run build` |
| Build output directory | `dist` |

Environment variables (Production): `NODE_VERSION` = `22` only.

Daily player/winner counts are kept in the booth device's browser
(double-click the counter to reset). They are not sent anywhere.

Notes:
- SPA routing works automatically (Pages serves `index.html` for unknown paths
  when there is no top-level `404.html`), replacing `vercel.json`'s rewrite.
- Security headers come from `public/_headers` in each app.
- Every push to `main` redeploys. Other branches get preview URLs
  (`<hash>.passkru.pages.dev`); the API's CORS rejects those on purpose.
- `client/` contains both `package-lock.json` and `bun.lock`. If the Pages
  build log shows `bun install`, delete `bun.lock` so npm and the lockfile
  are used.

## 2. API on Railway — environment variables

Set/update these on the Railway service, then redeploy:

| Name | Value |
|---|---|
| `NODE_ENV` | `production` (**required** — enables HSTS, hides `/api-docs`, strict CORS) |
| `FRONTEND_URL` | `https://passkru.pages.dev` (Google sign-in redirects here) |
| `CORS_ORIGINS` | `https://passkru.pages.dev,https://passkru-admin.pages.dev` |
| `JWT_SECRET` | a **new** random value (signs everyone out; see `server/.env.example`) |
| `SUPABASE_URL` | `https://<project>.supabase.co` |
| `SUPABASE_SERVICE_ROLE_KEY` | service role key (server only) |
| `GOOGLE_CALLBACK_URL` | `https://<service>.up.railway.app/api/auth/google/callback` |
| `BREVO_API_KEY`, `EMAIL_FROM` | email over HTTPS (see below); `EMAIL_FROM` must be a sender verified in Brevo |
| `SMTP_*`, `GEMINI_*`, `DATABASE_URL`, `DIRECT_URL` | as before (rotate after an incident) |

> **Email on Railway:** Railway blocks outbound SMTP (ports 25/465/587) below the
> Pro plan, which shows up as "Failed to send verification code email" on sign-up.
> Use Brevo's HTTPS API instead: create a free Brevo account, verify your sender
> address or domain, create an API key, then set `BREVO_API_KEY` and `EMAIL_FROM`
> on the API service. No SMTP settings are needed. Check the logs for
> `sent via brevo` after the first sign-up.

Any browser origin not in `FRONTEND_URL`/`CORS_ORIGINS` gets **403** on
POST/PUT/PATCH/DELETE (CSRF guard) — if the admin or client suddenly can't
save anything, check these two first.

## 3. Google OAuth

Google Cloud Console → APIs & Services → Credentials → the OAuth client:
- **Authorized redirect URIs**: `https://<service>.up.railway.app/api/auth/google/callback`
- **Authorized JavaScript origins**: the two `pages.dev` URLs

## 4. Order of operations

1. Railway: set the variables above (keep the old frontend origin in
   `CORS_ORIGINS` too until the switch is done) and deploy the API.
2. Create both Pages projects; wait for the first builds.
3. Open the client, sign in with email and with Google, open a past paper.
   Open the admin dashboard and load papers/users.
4. Only then: make the Supabase `papers` bucket **private**
   (Storage → bucket → settings). PDFs keep working via signed links.
5. Remove the old Vercel origin from `CORS_ORIGINS`; delete the Vercel projects.
6. Update `client/index.html` (canonical), `client/public/robots.txt` and
   `client/public/sitemap.xml` — they still point at `pass-kru.vercel.app`.

## Later: with a custom domain

Add the domain to Cloudflare, then:
- Pages → each project → **Custom domains**: `app.<domain>`, `admin.<domain>`,
  `game.<domain>` (the arcade needs no API/CORS change).
- Railway → service → **Custom domain** `api.<domain>`; in Cloudflare DNS make
  that CNAME **Proxied** (orange cloud), SSL/TLS mode **Full (strict)**.
- Cloudflare → Security → WAF: rate-limit rule on `/api/auth/*`.
- The API then sees Cloudflare's IP; switch the rate limiter to read
  `CF-Connecting-IP`, and cookies can move from `SameSite=None` to `Lax`.

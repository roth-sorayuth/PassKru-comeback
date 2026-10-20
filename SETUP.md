# PassKru — Local Setup (no Docker)

Everything runs directly with Node.js. The database and file storage are
hosted (Supabase), so you do **not** install PostgreSQL or Docker.

| App | Folder | Local URL |
|---|---|---|
| API (Express + Prisma) | `server` | http://localhost:5000 (docs: `/api-docs`) |
| Candidate app | `client` | http://localhost:3000 |
| Admin dashboard | `adminDashboard` | http://localhost:3001 |
| Booth arcade (optional) | `game` | http://localhost:3002 |

## 1. Install the tools

- **Node.js 22 LTS** or newer — https://nodejs.org (check: `node -v`)
- **Git** — https://git-scm.com
- An editor (VS Code recommended)

## 2. Get the code

```bash
git clone https://github.com/roth-sorayuth/PassKru-comeback.git
cd PassKru-comeback
git checkout dev
```

Work on your own branch off `dev` (e.g. `git checkout -b feature/my-task`).

## 3. Install packages

Run once in each folder (and again after pulling if a `package.json` changed):

```bash
cd server && npm install && cd ..
cd client && npm install && cd ..
cd adminDashboard && npm install && cd ..
cd game && npm install && cd ..
```

## 4. Create the `.env` files

Copy each example file to `.env`, then fill in the values the team lead sends
you **privately** (never commit `.env`, never paste keys in group chats):

```bash
cp server/.env.example server/.env
cp client/.env.example client/.env
cp adminDashboard/.env.example adminDashboard/.env
```

(Windows PowerShell: use `copy` instead of `cp`.)

**`server/.env`** — the important ones:

| Variable | Value |
|---|---|
| `DATABASE_URL`, `DIRECT_URL` | from team lead (shared Supabase dev database) |
| `JWT_SECRET` | any long random string for local use: `node -e "console.log(require('crypto').randomBytes(48).toString('base64url'))"` |
| `FRONTEND_URL` | `http://localhost:3000` |
| `CORS_ORIGINS` | `http://localhost:3001` |
| `SUPABASE_URL`, `SUPABASE_SERVICE_ROLE_KEY` | from team lead |
| `GEMINI_API_KEY` | from team lead, or your own key (AI study plan) |
| `GOOGLE_CLIENT_ID/SECRET` | optional — only needed to test Google sign-in |
| `SMTP_*` | leave empty — OTP codes are then printed in the server terminal |

**`client/.env`** and **`adminDashboard/.env`**: keep the `localhost` URLs from
the example and fill in `VITE_SUPABASE_URL` / `VITE_SUPABASE_ANON_KEY` (the
**anon** key only). `VITE_CLERK_PUBLISHABLE_KEY` is legacy and can stay empty.

`game` needs no `.env`.

## 5. Generate the Prisma client

```bash
cd server
npx prisma generate
```

This only generates code on your machine; it does not touch the database.

## 6. Run it

Open one terminal per app:

```bash
cd server && npm run dev
```

```bash
cd client && npm run dev
```

```bash
cd adminDashboard && npm run dev
```

```bash
cd game && npm run dev
```

Start the **server first**. Then open http://localhost:3000, register, and use
the OTP code printed in the server terminal.

## ⚠️ Database rules (shared database — read this)

We all use the **same** database, so one wrong command breaks it for everyone.
**Do not run** any of these:

- `npx prisma db push`, `npx prisma migrate ...`, `npx prisma db reset`, `npx prisma db seed`
- any `seed_*.js`, `manual_migrate.js`, `update_*.js` or other script in `server/` that writes data
- raw SQL (`DROP`, `TRUNCATE`, `ALTER`, `UPDATE`, `DELETE`, `INSERT`)

Need a schema change? Edit `server/prisma/schema.prisma` in your branch and ask
the team lead to apply it. If you use an AI coding assistant, it must follow
[AGENTS.md](AGENTS.md).

## Troubleshooting

| Problem | Fix |
|---|---|
| `Port 5000/3000 already in use` | Close the other terminal running it, or restart your computer |
| Frontend shows network errors | Is the server running? Is `VITE_API_URL=http://localhost:5000/api`? |
| Save/submit returns **403** | Your frontend origin is missing from `FRONTEND_URL` / `CORS_ORIGINS` in `server/.env` |
| `@prisma/client did not initialize` | Run `npx prisma generate` in `server` |
| Can't connect to database | Check `DATABASE_URL` was copied exactly (no spaces/quotes missing) |
| Changed `.env` but nothing changed | Stop and restart that app's `npm run dev` |

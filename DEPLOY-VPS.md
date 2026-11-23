# Deploying PassKru on DP Cloud VPS (frontend + backend), Supabase for DB

Server: `passkru-server` · `ssh ubuntu@157.10.73.38` · Ubuntu · nginx + pm2.
The database stays on Supabase; nothing here touches it.

## 0. Before you start
1. **Change the VPS password** (it was shared in chat) and switch to SSH keys:
   `ssh-copy-id ubuntu@157.10.73.38`, then set `PasswordAuthentication no` in `/etc/ssh/sshd_config`.
2. **No domain yet:** use `DOMAIN=157-10-73-38.sslip.io` (free wildcard DNS that resolves to the VPS IP, no DNS setup needed; HTTPS via certbot works). Hosts become `app.`, `admin.`, `api.157-10-73-38.sslip.io`. When you buy a real domain, add A records and rerun nginx/certbot/deploy with the new `DOMAIN`.

## 1. One-time setup (on the VPS)
```bash
git clone https://github.com/roth-sorayuth/<repo>.git ~/PassKru && cd ~/PassKru
bash deploy/setup-server.sh
```

## 2. API env (`~/PassKru/server/.env`, never commit)
Copy `server/.env.example` and set (see DEPLOY.md §2 for details):
`NODE_ENV=production`, `PORT=5000`, `DATABASE_URL`/`DIRECT_URL` (Supabase),
`JWT_SECRET`, `FRONTEND_URL=https://app.157-10-73-38.sslip.io`,
`CORS_ORIGINS=https://app.157-10-73-38.sslip.io,https://admin.157-10-73-38.sslip.io`,
`GOOGLE_CALLBACK_URL=https://api.157-10-73-38.sslip.io/api/auth/google/callback`,
Supabase URL + service role key, `BREVO_API_KEY`/`EMAIL_FROM`, Gemini keys.

## 3. nginx + HTTPS
Edit `deploy/nginx.conf` (replace `example.com`), then follow the comments at its top.

## 4. Deploy / redeploy
```bash
export VITE_SUPABASE_URL=... VITE_SUPABASE_ANON_KEY=...   # anon key only
DOMAIN=157-10-73-38.sslip.io bash deploy/deploy.sh
```
Check: `curl https://api.157-10-73-38.sslip.io/health`, `pm2 logs passkru-api`.

## 5. Google OAuth
Add redirect `https://api.157-10-73-38.sslip.io/api/auth/google/callback` and origins
`https://app.157-10-73-38.sslip.io`, `https://admin.157-10-73-38.sslip.io` in Google Cloud Console.

## Notes
- Outbound SMTP may be blocked on VPS plans; Brevo HTTPS API avoids that.
- Supabase may need to allow the VPS IP if network restrictions are on.
- Update `client/index.html` canonical, `robots.txt`, `sitemap.xml` to the new domain.

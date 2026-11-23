#!/usr/bin/env bash
# Run on the VPS from ~/PassKru after every update:  bash deploy/deploy.sh
# Requires DOMAIN, e.g.  DOMAIN=example.com bash deploy/deploy.sh
set -euo pipefail
: "${DOMAIN:?set DOMAIN=your-domain.com}"

git pull --ff-only

# API (does NOT touch the database; run Prisma migrations manually if needed)
(cd server && npm ci --omit=dev && npx prisma generate)
pm2 startOrReload deploy/ecosystem.config.cjs --update-env
pm2 save

# Frontends (VITE_* are baked in at build time)
(cd client && npm ci && VITE_API_URL="https://api.$DOMAIN/api" VITE_ADMIN_URL="https://admin.$DOMAIN" npm run build)
rsync -a --delete client/dist/ /var/www/passkru/client/

(cd adminDashboard && npm ci && VITE_API_URL="https://api.$DOMAIN/api" VITE_CLIENT_URL="https://app.$DOMAIN" \
  VITE_SUPABASE_URL="${VITE_SUPABASE_URL:?}" VITE_SUPABASE_ANON_KEY="${VITE_SUPABASE_ANON_KEY:?}" npm run build)
rsync -a --delete adminDashboard/dist/ /var/www/passkru/admin/
echo "Deployed."

#!/usr/bin/env bash
# One-time VPS setup (Ubuntu). Run as the ubuntu user: bash setup-server.sh
set -euo pipefail

sudo apt-get update
sudo apt-get install -y nginx git curl ufw certbot python3-certbot-nginx

# Node 22 + pm2
curl -fsSL https://deb.nodesource.com/setup_22.x | sudo -E bash -
sudo apt-get install -y nodejs
sudo npm i -g pm2

# Firewall: SSH + web only (API stays on 127.0.0.1:5000 behind nginx)
sudo ufw allow OpenSSH
sudo ufw allow 'Nginx Full'
sudo ufw --force enable

sudo mkdir -p /var/www/passkru/{client,admin}
sudo chown -R "$USER":"$USER" /var/www/passkru
echo "Done. Next: clone repo to ~/PassKru, create server/.env, run deploy/deploy.sh"

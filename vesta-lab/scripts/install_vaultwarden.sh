#!/bin/bash
# Deploy Vaultwarden using Docker Compose

mkdir -p /opt/vaultwarden
cd /opt/vaultwarden

cat > docker-compose.yml <<EOF
version: "3.9"
services:
  vaultwarden:
    image: vaultwarden/server:latest
    container_name: vaultwarden
    restart: unless-stopped
    environment:
      DOMAIN: "https://vault.vestasec.com"
    volumes:
      - ./vw-data:/data
    ports:
      - "8222:80"
EOF

docker compose up -d

# GitLab CE – Internal Service Overview

GitLab CE is deployed in the Vesta Lab as an internal code management and CI/CD platform.

##  Configuration

- Domain: `gitlab.vestasec.com`
- Host IP: `10.20.0.2`
- Reverse Proxy: Nginx Proxy Manager
- SSH Port: `2424`
- HTTP Port (internal): `8929`

##  Use Cases

- Private Git repos for Docker Compose, scripts, and Odoo modules
- CI pipelines (future use)
- Centralized version control for all infrastructure code

##  Access

Accessible only:
- From VLAN 20
- Via VPN (Tailscale)
- Through domain `https://gitlab.vestasec.com`

##  Backups

- GitLab data volume is mapped and backed up via PBS
- External Git repo backups planned


---

# Vaultwarden – Internal Password Manager

Vaultwarden is deployed in the Vesta Lab as a self-hosted, lightweight alternative to Bitwarden for managing credentials and secrets.

##  Access

- Domain: `vault.vestasec.com`
- IP: `10.20.0.2`
- Reverse Proxy: NPM with DNS-01 SSL
- Enforced HTTPS only

##  Security

- Access restricted to:
  - VLAN 20
  - VPN clients via Tailscale
- Admin password stored securely outside the container
- 2FA enabled per user

##  Storage

- Data stored in volume: `./vw-data:/data`
- Persistent and backed up via NFS to TrueNAS
- Daily snapshot through PBS integration

##  Use Cases

- Store internal service credentials
- Share credentials securely across lab systems
- Integrate with browser extensions locally


---

# AdGuard Home – Docker Deployment

AdGuard Home is used in the Vesta Lab to block ads and malicious domains across internal clients.

##  Host Info

- Node: `docker-ve2`
- IP: `10.20.0.3`
- Port: `8053` (DNS)
- Web UI: `http://10.20.0.3:3002`
- VLAN: 20 (services)

##  Deployment (Docker)

```bash
docker run -d \
  --name adguard \
  -v /opt/adguard/work:/opt/adguardhome/work \
  -p 3002:3000 \
  -p 8053:53/tcp \
  -p 8053:53/udp \
  --restart=unless-stopped \
  adguard/adguardhome:latest --setup
```

> Complete initial setup at `http://10.20.0.3:3002`

##  DNS Configuration

- Set `10.20.0.3` as primary DNS server in DHCP
- Optionally route `.local` queries to AdGuard

##  Result

AdGuard is now resolving DNS and filtering ads for internal lab devices.


---

# BookStack – Technical Wiki (Docker Deployment)

BookStack is used as a wiki and documentation platform in the Vesta Lab.

##  Host Info

- Node: `docker-ve2`
- IP: `10.20.0.3`
- Port: `8080` (internal)
- Domain: `wiki.vestasec.com`
- Reverse Proxy: NPM

##  Docker Compose (example)

```yaml
version: "3"
services:
  bookstack:
    image: linuxserver/bookstack
    container_name: bookstack
    environment:
      - PUID=1000
      - PGID=1000
      - DB_HOST=mariadb
      - DB_USER=bookstack
      - DB_PASS=<REPLACE_WITH_SECURE_PASSWORD>
      - DB_DATABASE=bookstackapp
    volumes:
      - ./config:/config
    ports:
      - 8080:80
    restart: unless-stopped

  mariadb:
    image: mariadb
    container_name: mariadb
    environment:
      - MYSQL_ROOT_PASSWORD=<REPLACE_WITH_SECURE_PASSWORD>
      - MYSQL_DATABASE=bookstackapp
      - MYSQL_USER=bookstack
      - MYSQL_PASSWORD=<REPLACE_WITH_SECURE_PASSWORD>
    volumes:
      - ./db:/var/lib/mysql
    restart: unless-stopped
```

##  Result

Accessible at `https://wiki.vestasec.com` with full web-based editing and user access control.

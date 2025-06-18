# Docker CE & Compose Installation – Debian 12

This guide documents the complete installation of Docker CE and Docker Compose (plugin version) on a minimal Debian 12 system.

## 1. System Preparation

```bash
apt update && apt upgrade -y
apt install sudo curl vim net-tools -y
```

## 2. Install Docker

```bash
sudo apt install ca-certificates curl gnupg -y
sudo install -d -m0755 /etc/apt/keyrings

curl -fsSL https://download.docker.com/linux/debian/gpg \
  | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg

echo \
"deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] \
https://download.docker.com/linux/debian \
$(. /etc/os-release && echo $VERSION_CODENAME) stable" \
  | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt update
sudo apt install \
  docker-ce docker-ce-cli containerd.io \
  docker-buildx-plugin docker-compose-plugin -y
```

## 3. Start and Enable Docker

```bash
sudo systemctl enable docker
sudo systemctl start docker
```

## 4. Test Docker

```bash
docker run hello-world
```

##  Result

Docker is installed with Compose support and ready for container deployment.


---

# Portainer CE Deployment – Vesta Lab

This document details the deployment of Portainer Community Edition as the main management UI for Docker in the Vesta Lab.

##  Host Info

- Node: `docker-ve1`
- OS: Debian 12
- Docker installed: Yes
- Network: VLAN 20 – `10.20.0.0/24`
- Portainer IP: `http://10.20.0.2:9000`

---

## 1. Volume Preparation

### Option A: Local Volume

```bash
docker volume create portainer_data
```

### Option B: NFS Persistent Volume

```bash
mkdir -p /mnt/truenas_nfs/containers/portainer_data
echo "10.30.0.3:/mnt/vesta-core/storage/lab/containers/portainer_data \
 /mnt/truenas_nfs/containers/portainer_data nfs defaults,_netdev 0 0" \
  >> /etc/fstab
mount -a
```

---

## 2. Deploy Portainer CE

```bash
docker run -d \
  --name portainer \
  -p 9000:9000 \
  -v /var/run/docker.sock:/var/run/docker.sock \
  -v portainer_data:/data \
  --restart=always \
  portainer/portainer-ce
```

> Once deployed, visit `http://10.20.0.2:9000` to configure the initial admin user.

---

## 3. Notes

- Portainer manages local Docker volumes and containers.
- Accessible only from VLAN 20 or via Tailscale VPN.
- Recommended to back up the `/data` volume regularly.

##  Result

Portainer CE is running and configured as the primary UI to manage container services across the lab infrastructure.


---

# Vaultwarden – Docker Compose Deployment

This document describes how Vaultwarden (a lightweight Bitwarden-compatible server) is deployed in the Vesta Lab using Docker Compose.

---

##  Host Info

- Hostname: `docker-ve1`
- IP: `10.20.0.2`
- Network: VLAN 20 – Services
- Domain: `https://vault.vestasec.com`
- Reverse Proxy: Managed by NPM (Nginx Proxy Manager)

---

## 1. Docker Compose File

```yaml
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
      - 8222:80
```

> Replace volume path and port as needed if reverse proxy is used.

---

## 2. Directory Structure

```bash
/opt/vaultwarden/
├── docker-compose.yml
└── vw-data/            # Persistent data volume
```

Create the data directory:

```bash
mkdir -p /opt/vaultwarden/vw-data
cd /opt/vaultwarden
docker compose up -d
```

---

## 3. Reverse Proxy Integration

In Nginx Proxy Manager (NPM):

- Create a Proxy Host:
  - Domain: `vault.vestasec.com`
  - Forward IP: `10.20.0.2`
  - Forward Port: `8222`
  - Enable SSL via Let's Encrypt (DNS-01)

---

##  Result

Vaultwarden is now available at `https://vault.vestasec.com` behind a secure NPM proxy, with persistent storage and restart policy in place.


---

# GitLab CE – Docker Compose Deployment

This document describes how GitLab Community Edition is deployed in the Vesta Lab using Docker Compose.

---

##  Host Info

- Hostname: `docker-ve1`
- IP: `10.20.0.2`
- Network: VLAN 20 – Services
- Domain: `https://gitlab.vestasec.com`
- Reverse Proxy: Nginx Proxy Manager (NPM)

---

## 1. Docker Compose File

```yaml
version: "3.9"
services:
  gitlab:
    image: gitlab/gitlab-ce:latest
    container_name: gitlab
    ports:
      - "2424:22"     # SSH
      - "8929:80"     # HTTP (internal use)
    volumes:
      - ./config:/etc/gitlab
      - ./logs:/var/log/gitlab
      - ./data:/var/opt/gitlab
    networks:
      - npm_default
    restart: unless-stopped

networks:
  npm_default:
    external: true
```

> Make sure `npm_default` network exists (created by NPM container).

---

## 2. Directory Structure

```bash
/opt/gitlab/
├── docker-compose.yml
├── config/
├── logs/
└── data/
```

Prepare directories:

```bash
mkdir -p /opt/gitlab/{config,logs,data}
cd /opt/gitlab
docker compose up -d
```

---

## 3. Reverse Proxy Integration

In NPM:

- Domain: `gitlab.vestasec.com`
- Forward IP: `10.20.0.2`
- Forward Port: `8929`
- SSL via Let's Encrypt (DNS-01)
- Enable WebSocket support (optional)

---

##  Result

GitLab CE is now available at `https://gitlab.vestasec.com`, running behind NPM with persistent volumes and integrated SSH access via port 2424.


---

# Nginx Proxy Manager – DNS + SSL Integration

This document describes the deployment of Nginx Proxy Manager (NPM) in the Vesta Lab and the DNS-01 challenge configuration for automatic SSL.

---

##  Host Info

- Hostname: `docker-ve1`
- IP: `10.20.0.2`
- Network: VLAN 20 – Services
- Domain: `*.vestasec.com`
- NPM Port: `http://10.20.0.2:9001`

---

## 1. Docker Compose File

```yaml
version: "3.9"
services:
  npm:
    image: jc21/nginx-proxy-manager:latest
    container_name: npm
    restart: unless-stopped
    ports:
      - "9001:81"     # Admin UI
      - "80:80"
      - "443:443"
    volumes:
      - ./data:/data
      - ./letsencrypt:/etc/letsencrypt
    networks:
      - default
```

---

## 2. Directory Setup

```bash
/opt/npm/
├── docker-compose.yml
├── data/
└── letsencrypt/
```

Launch:

```bash
mkdir -p /opt/npm/{data,letsencrypt}
cd /opt/npm
docker compose up -d
```

---

## 3. DNS-01 Challenge (Cloudflare)

### Requirements

- API Token with permissions for DNS zone edit
- Cloudflare DNS record:  
  - Type A: `*` → `10.20.0.2`

### Configuration

In NPM UI:
1. Go to **SSL Certificates** → Add
2. Use `DNS Challenge`
3. Select provider: Cloudflare
4. Paste your API token
5. Save → NPM auto-generates and renews wildcard cert

---

##  Result

NPM is running on `http://10.20.0.2:9001`, issuing valid SSL certificates for all internal services using DNS-01.


---

# Docker Node Setup – docker-ve1

## 1. VM Configuration

This VM was created in Proxmox with the following parameters:

- Name: `docker-ve1`
- Node: `ve1`
- vCPU: 2 (1 socket)
- RAM: 4 GB
- Disk: 32 GB (VirtIO, SCSI)
- Bridge: `vmbr0`
- VLAN Tag: 20
- IP: `10.20.0.2`
- Gateway: `10.20.0.1`
- DNS: `10.0.0.102`, `1.1.1.1`

## 2. Operating System

- Debian 12 (Bookworm) minimal installation using netinst ISO.

## 3. System Update & Essentials

```bash
apt update && apt upgrade -y
apt install sudo curl vim net-tools -y
```

## 4. Docker CE & Compose Installation

```bash
sudo apt install ca-certificates curl gnupg -y
sudo install -d -m0755 /etc/apt/keyrings

curl -fsSL https://download.docker.com/linux/debian/gpg \
  | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg

echo \
"deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] \
https://download.docker.com/linux/debian \
$(. /etc/os-release && echo $VERSION_CODENAME) stable" \
  | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt update
sudo apt install \
  docker-ce docker-ce-cli containerd.io \
  docker-buildx-plugin docker-compose-plugin -y

sudo systemctl enable docker
sudo systemctl start docker
```

### Test Docker installation:

```bash
docker run hello-world
```

## 5. Deploying Portainer

### Option A: Local Volume

```bash
docker volume create portainer_data
```

### Option B: NFS Volume

```bash
mkdir -p /mnt/truenas_nfs/containers/portainer_data
echo "10.30.0.3:/mnt/vesta-core/storage/lab/containers/portainer_data \
 /mnt/truenas_nfs/containers/portainer_data nfs defaults,_netdev 0 0" \
  >> /etc/fstab
mount -a
```

### Run Portainer

```bash
docker run -d \
  --name portainer \
  -p 9000:9000 \
  -v /var/run/docker.sock:/var/run/docker.sock \
  -v portainer_data:/data \
  --restart=always \
  portainer/portainer-ce
```

>  At this point, Portainer is available at http://10.20.0.2:9000

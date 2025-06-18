# Prometheus Setup – Vesta Lab

Prometheus collects metrics from exporters in the Vesta Lab and makes them available to Grafana.

##  Host Info

- Node: `docker-ve2`
- IP: `10.20.0.3`
- Port: `9090`

## 1. Directory Structure

```bash
/opt/monitoring/prometheus/
├── prometheus.yml
```

## 2. Basic prometheus.yml

```yaml
global:
  scrape_interval: 15s

scrape_configs:
  - job_name: 'prometheus'
    static_configs:
      - targets: ['localhost:9090']

  - job_name: 've1-proxmox'
    static_configs:
      - targets: ['10.10.0.2:9100']

  - job_name: 've2-proxmox'
    static_configs:
      - targets: ['10.10.0.3:9100']
```

## 3. Run Prometheus

```bash
docker run -d \
  --name=prometheus \
  -p 9090:9090 \
  -v /opt/monitoring/prometheus:/etc/prometheus \
  prom/prometheus
```

##  Result

Prometheus is collecting data from all node exporters and exposing metrics to Grafana.


---

# Node Exporter Deployment – Vesta Lab

Node Exporter is installed on each Proxmox node to provide system-level metrics to Prometheus.

##  Installation (on each node)

```bash
docker run -d \
  --name=node-exporter \
  --net="host" \
  --pid="host" \
  --restart always \
  -v "/:/host:ro,rslave" \
  quay.io/prometheus/node-exporter:latest \
  --path.rootfs=/host
```

- Node `ve1`: `10.10.0.2:9100`
- Node `ve2`: `10.10.0.3:9100`

##  Result

Each node is exposing metrics to Prometheus on port `9100`.


---

# Grafana Configuration – Vesta Lab

Grafana is used as the main visualization layer on top of Prometheus metrics.

##  Host Info

- Node: `docker-ve2`
- IP: `10.20.0.3`
- Port: `3000`
- Default credentials: `admin / admin`

##  Deployment

```bash
docker run -d \
  --name=grafana \
  -p 3000:3000 \
  -v grafana_data:/var/lib/grafana \
  --restart=always \
  grafana/grafana-oss
```

## ️ Configuration Steps

1. Access: `http://10.20.0.3:3000`
2. Add Prometheus as data source: `http://10.20.0.3:9090`
3. Import dashboard: Node Exporter Full (ID: 1860)

##  Result

Grafana is connected to Prometheus and visualizing node metrics.


---

# Uptime Kuma – Service Monitoring Setup

Uptime Kuma is deployed in the Vesta Lab to monitor the availability of internal and external services via HTTP, TCP, and ICMP.

---

##  Host Info

- Node: `docker-ve2`
- IP: `10.20.0.3`
- Port: `8280`
- VLAN: 20 (services)

---

##  Deployment (Docker)

```bash
docker volume create uptime_kuma_data

docker run -d \
  --name uptime-kuma \
  -p 8280:3001 \
  -v uptime_kuma_data:/app/data \
  --restart=always \
  louislam/uptime-kuma:latest
```

---

##  Usage

- Access: `http://10.20.0.3:8280`
- Create monitors:
  - `https://vault.vestasec.com`
  - `https://gitlab.vestasec.com`
  - `http://10.10.0.2:8006` (Proxmox VE1)
  - `http://10.10.0.3:8006` (Proxmox VE2)

---

##  Result

Uptime Kuma is now monitoring the uptime and latency of lab services with visual dashboards and alerts.

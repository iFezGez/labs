#!/bin/bash
# Deploy Prometheus, Node Exporter, and Grafana stack

docker network create monitoring || true

docker run -d --name prometheus \
  -p 9090:9090 \
  -v /opt/prometheus/prometheus.yml:/etc/prometheus/prometheus.yml \
  --network=monitoring \
  prom/prometheus

docker run -d --name node-exporter \
  --net="host" --pid="host" \
  -v "/:/host:ro,rslave" \
  quay.io/prometheus/node-exporter \
  --path.rootfs=/host

docker run -d --name grafana \
  -p 3000:3000 \
  -v grafana_data:/var/lib/grafana \
  --network=monitoring \
  grafana/grafana-oss

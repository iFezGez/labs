#!/bin/bash
# Master script to gather technical exports from the system

EXPORT_BASE="/opt/lab_exports"
mkdir -p "$EXPORT_BASE"

# Export available config sources
zfs list > "$EXPORT_BASE/zfs_list.txt" 2>/dev/null
proxmox-backup-manager datastore list > "$EXPORT_BASE/pbs_datastores.txt" 2>/dev/null
iptables-save > "$EXPORT_BASE/iptables.rules" 2>/dev/null
docker ps -a > "$EXPORT_BASE/docker_containers.txt"
ufw status verbose > "$EXPORT_BASE/ufw_status.txt" 2>/dev/null

echo "→ Manual exports still recommended from: TrueNAS UI, NPM, Portainer"

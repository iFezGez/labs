#!/bin/bash
# Reminder script to backup TrueNAS config via UI

BACKUP_DIR="/opt/truenas_backups"
DATE=$(date +%F)
mkdir -p "$BACKUP_DIR"

echo "→ Please manually download the configuration from:"
echo "   TrueNAS Web UI → System Settings → General → Save Config"
echo "→ Suggested filename: $BACKUP_DIR/truenas_config_$DATE.db"

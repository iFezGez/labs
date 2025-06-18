#!/bin/bash
# Export ZFS dataset list from TrueNAS or Proxmox

ZFS_EXPORT_DIR="/opt/zfs_exports"
mkdir -p "$ZFS_EXPORT_DIR"
zfs list > "$ZFS_EXPORT_DIR/zfs_datasets_$(date +%F).txt"

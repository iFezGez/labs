#!/bin/bash
# Export PBS datastore list to a text file

pbs_config_dir="/opt/pbs_exports"
mkdir -p "$pbs_config_dir"
proxmox-backup-manager datastore list > "$pbs_config_dir/datastore_list_$(date +%F).txt"

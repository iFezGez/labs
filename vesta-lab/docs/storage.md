# TrueNAS SCALE – Dataset and Storage Design

This document describes the internal dataset structure, permission model, and service usage within the TrueNAS instance in the Vesta Lab.

---

##  Host Info

- Hostname: `truenas`
- IP: `10.30.0.3`
- VLAN: 30 (storage)
- Pool: `lab-pool`

---

##  Dataset Structure

```text
lab-pool/
├── lab-backups/         # NFS export used by PBS
├── storage/
│   ├── lab/
│   │   ├── containers/  # Portainer volumes (optional)
│   │   └── scripts/     # Automation scripts
│   └── vesta-core/
│       ├── docs/
│       ├── clients/
│       └── internal/
```

---

##  Permissions

- ACL disabled (POSIX mode)
- `Mapall` user: `root`
- Used for NFS exports to PBS and Docker nodes
- Access allowed: `10.30.0.2` (PBS), `10.20.0.2` (Docker)

---

##  Usage

- Export `lab-backups` to PBS via NFS
- Export `containers/` and `scripts/` to Docker via bind mount
- Shared folders visible over SMB when needed


---

# TrueNAS – NFS and SMB Configuration

This document explains the export of storage via NFS and SMB from TrueNAS to the rest of the lab infrastructure.

---

##  NFS Export: `lab-backups`

- Path: `/mnt/lab-pool/lab-backups`
- Enabled: Yes
- Permissions: POSIX, `Mapall user = root`
- Allowed IPs: `10.30.0.2` (PBS)

##  NFS Export: `containers/`

- Path: `/mnt/lab-pool/storage/lab/containers`
- Mount to Docker nodes via `/etc/fstab`
- Used for persistent volumes (e.g. Portainer)

---

##  SMB Shares

- Optional: enable for workstations
- Example share: `/mnt/lab-pool/storage/vesta-core/docs`
- Permissions: user-level, `vestasec` account

---

##  Integration

- PBS → NFS `lab-backups`
- Docker → NFS `containers/`
- Windows clients → SMB shares

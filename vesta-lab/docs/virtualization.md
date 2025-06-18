# Proxmox VE Cluster Setup – Vesta Lab

This document describes how the Proxmox VE cluster is deployed in the Vesta Lab.

---

##  Cluster Nodes

| Node | Hostname     | IP         | Role          |
|------|--------------|------------|---------------|
| ve1  | proxmox-ve1  | 10.10.0.2  | Primary node  |
| ve2  | proxmox-ve2  | 10.10.0.3  | Secondary     |

##  Network

- VLAN 10 – Management: 10.10.0.0/24
- Bridge: `vmbr0`, with VLAN tag awareness
- Gateway: `10.10.0.1` (MikroTik)

---

##  Cluster Creation (on ve1)

```bash
pvecm create vesta-lab
```

##  Join Node (on ve2)

```bash
pvecm add 10.10.0.2
```

> SSH key exchange and cluster handshake will complete automatically.

##  Result

Cluster with 2 nodes is functional and accessible via shared web UI at either IP.


---

# Proxmox VE – Storage Configuration

This document outlines the storage setup for each node in the Proxmox VE cluster.

---

##  Node `ve1`

- Local ZFS pool: `rpool-ve1`
  - Device: 500 GB SSD
  - Use: VM images, ISO uploads

##  Node `ve2`

- LVM-thin default
- No local ZFS (lower spec)

---

##  Shared Storage

| Name         | Type | Backed by       | Use Case          |
|--------------|------|------------------|-------------------|
| lab-backups  | NFS  | TrueNAS (10.30.0.3) | Backup target for PBS

---

##  Add NFS Storage (UI or CLI)

```bash
pvesh create /storage   -storage lab-backups   -type nfs   -server 10.30.0.3   -export /mnt/lab-pool/lab-backups
```

---

##  Result

- Local storage for high-speed I/O
- Shared backup space for all nodes


---

# High Availability (HA) Notes – Proxmox VE

HA is not yet fully enabled in the lab, but design considerations are in place.

---

## ️ Planned Design

- At least 3 nodes recommended
- External quorum device (QDevice) required
- Shared storage (PBS via TrueNAS) partially supports migration

---

##  Current Limitations

- 2-node cluster = no HA fencing
- No QDevice yet
- ZFS local-only = manual migration

---

##  Live Migration

Available between `ve1` and `ve2` when using shared storage or manually handled disks.

---

##  Next Steps

- Add QDevice or third test node
- Enable HA groups via UI
- Test failover behavior in real scenarios

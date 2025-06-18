# TrueNAS + PBS + NFS Integration

This document explains how the Vesta Lab connects its storage and backup systems using TrueNAS SCALE and Proxmox Backup Server.

---

##  Infrastructure Summary

| Component | Hostname | IP           | VLAN | Role                      |
|-----------|----------|--------------|------|---------------------------|
| TrueNAS   | truenas  | 10.30.0.3    | 30   | NFS storage provider      |
| PBS       | pbs      | 10.30.0.2    | 30   | Backup server (Proxmox)   |
| Network   | vmbr0.30 | 10.30.0.0/24 | 30   | Dedicated storage VLAN    |

---

## 1. Dataset Creation in TrueNAS

- Pool: `lab-pool`
- Dataset: `lab-backups`
- Share Type: NFS
- Mapall User/Group: `root`
- Permissions: POSIX, recursive RW

### NFS Share Settings

| Parameter         | Value         |
|------------------|---------------|
| Path             | `/mnt/lab-pool/lab-backups` |
| Mapall User      | `root`        |
| Mapall Group     | `root`        |
| Authorized Host  | `10.30.0.2` (PBS) |

---

## 2. Mount NFS in PBS

### Install NFS client packages

```bash
apt update && apt install nfs-common -y
```

### Mount test (optional)

```bash
mkdir -p /mnt/nfs-truenas
mount -t nfs 10.30.0.3:/mnt/lab-pool/lab-backups /mnt/nfs-truenas
```

---

## 3. Add NFS Datastore to PBS

In PBS UI:

1. Go to **Datastore** > Add.
2. Type: NFS
3. ID: `truenas-nfs`
4. Server: `10.30.0.3`
5. Export: `/mnt/lab-pool/lab-backups`
6. Mount: `Always`

 It should now appear under `Datastores` and be available for backup tasks.

---

## 4. Backup Job Configuration

From Proxmox VE nodes (`ve1` and `ve2`):

- Each VM or CT is assigned a schedule pointing to PBS.
- PBS stores the data on the mounted NFS export.
- Compression: ZSTD
- Schedule: daily / nightly

---

## 5. Verification

- Ensure PBS has access to `10.30.0.3`
- Verify mounts via:
```bash
df -h | grep nfs
```
- Validate from PBS GUI under **Datastore Status**

---

##  Result

- Backups are securely stored in TrueNAS over NFS.
- Redundancy and snapshots can be handled from the TrueNAS pool.
- Clean separation between compute and storage.

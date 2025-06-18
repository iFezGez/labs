# Common Issues in Vesta Lab

Below are common technical issues encountered during setup and operation of the lab, along with verified solutions.

---

##  1. PBS – Datastore Path Not Empty

**Issue:**  
PBS fails to add NFS export from TrueNAS with error `datastore path not empty`.

**Cause:**  
The NFS mount already contains hidden files or previous mount attempts.

**Fix:**  
1. Unmount the directory:
   ```bash
   umount /mnt/truenas-nfs
   ```
2. Remove contents manually:
   ```bash
   rm -rf /mnt/truenas-nfs/*
   ```
3. Remount and retry from PBS UI.

---

##  2. PBS – Cannot Reach TrueNAS NFS

**Issue:**  
PBS can't mount the NFS export even when config looks correct.

**Fix Checklist:**
- TrueNAS: Confirm `Mapall` is set to `root/root`
- Confirm TrueNAS NFS Share allows host `10.30.0.2`
- PBS: Run `showmount -e 10.30.0.3` to validate NFS exports
- Confirm `nfs-common` is installed on PBS

---

##  3. Docker Node – DNS Resolution Fails

**Issue:**  
Docker containers can't resolve DNS names.

**Fix:**
Add to `/etc/docker/daemon.json`:
```json
{
  "dns": ["10.0.0.102", "1.1.1.1"]
}
```
Then restart Docker:
```bash
systemctl restart docker
```

---

##  4. Portainer – Error Using NFS Volume

**Issue:**  
Portainer fails when mounting volume from TrueNAS.

**Fix:**
Ensure:
- NFS path exists
- `fstab` is properly mounted with `_netdev` option
- Docker is restarted after mount

---

##  5. Proxmox Node – No Network After Reboot

**Issue:**  
Static IP not working or VLAN missing.

**Fix:**
- Confirm `/etc/network/interfaces` has `bridge-vlan-aware yes`
- VLAN must be defined (`vmbr0.10`, `vmbr0.20`, etc.)
- Add `dns-nameservers` line explicitly

# VM Templates Used in Vesta Lab

Using base VM templates ensures consistent deployment, fast provisioning, and automated scaling. Below are the most common templates used in the lab.

---

## 1. Debian 12 (Bookworm) – Netinst Template

### Creation Steps

1. Download the ISO:  
   [https://cdimage.debian.org/debian-cd/current/amd64/iso-cd/](https://cdimage.debian.org/debian-cd/current/amd64/iso-cd/)

2. Create VM in Proxmox:
   - 1 vCPU, 1 GB RAM, 8 GB Disk (SCSI)
   - Network: `vmbr0`, tag as needed
   - BIOS: SeaBIOS, Machine: i440fx
   - Boot ISO, install with minimal options
   - Configure static IP if needed

3. After first boot:
```bash
apt update && apt upgrade -y
apt install sudo curl vim net-tools qemu-guest-agent -y
systemctl enable qemu-guest-agent
```

4. Clean up:
```bash
apt clean
```

5. Shutdown and convert to template from Proxmox UI.

---

## 2. Ubuntu 22.04 Cloud-Init Image

### Download and Import

```bash
wget https://cloud-images.ubuntu.com/jammy/current/jammy-server-cloudimg-amd64.img
qm create 9000 --name ubuntu-2204-cloud --memory 1024 --net0 virtio,bridge=vmbr0
qm importdisk 9000 jammy-server-cloudimg-amd64.img local-lvm
qm set 9000 --scsihw virtio-scsi-pci --scsi0 local-lvm:vm-9000-disk-0
qm set 9000 --ide2 local-lvm:cloudinit
qm set 9000 --boot c --bootdisk scsi0
qm set 9000 --serial0 socket --vga serial0
```

Then use **Cloud-Init** in Proxmox to inject SSH key, hostname, IP, and packages.

---

## 3. Maintenance Recommendations

- Regularly update and re-template to apply kernel and package fixes.
- Keep base template minimal: no extra services.
- Use Cloud-Init wherever possible for faster automation.

##  Result

Using lightweight templates saves time, ensures consistency, and helps automate service deployment across the lab.

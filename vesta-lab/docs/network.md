# MikroTik VLAN & Routing Configuration

##  Router Model

- MikroTik hEX RB750Gr3
- RouterOS v7+
- Access: WinBox, WebFig, SSH

##  Interfaces and Bridge

```plaintext
ether1: WAN uplink
ether2-ether5: LAN / trunk ports
bridge: main bridge with VLAN awareness
```

##  VLANs Defined

| VLAN | Name     | Subnet         | Purpose         |
|------|----------|----------------|-----------------|
| 10   | mgmt     | 10.10.0.0/24   | Proxmox nodes   |
| 20   | services | 10.20.0.0/24   | Docker, NPM     |
| 30   | storage  | 10.30.0.0/24   | PBS, TrueNAS    |
| 40   | iot      | 10.40.0.0/24   | IoT devices     |
| 50   | guest    | 10.50.0.0/24   | Guest clients   |

##  DHCP Server per VLAN

Each VLAN has its own DHCP server and IP pool.

##  Static Routes

The MikroTik routes between VLANs and acts as the default gateway for all subnets.

## ️ NAT & Firewall

- NAT rule: masquerade for all outbound traffic via WAN
- Firewall: default drop + accepted rules per interface/vlan

##  Configuration File

See `mikrotik/config_files/full_config.rsc` for the exported configuration of the lab router.


---

# VPN Gateway – Tailscale Setup (docker-ve2)

This VPN Gateway provides secure remote access to all services in the Vesta Lab via Tailscale.

---

##  Infrastructure

- Hostname: `vpn-gateway`
- Location: Docker container on `docker-ve2`
- IP: `10.20.0.3`
- VLAN: 20 (services)
- ACL Tag: `tag:docker`
- Auth: Pre-authorized `TS_AUTHKEY`

---

##  Docker Deployment

```bash
docker run -d \
  --name=tailscale \
  --cap-add=NET_ADMIN \
  --device=/dev/net/tun \
  -e TS_AUTHKEY="tskey-..." \
  -e TS_ROUTES="10.0.0.0/8" \
  -e TS_EXTRA_ARGS="--advertise-tags=tag:docker" \
  -v tailscale_data:/var/lib/tailscale \
  --restart=always \
  tailscale/tailscale
```

> Replace `tskey-...` with your pre-authorized key from the Tailscale admin console.

---

##  ACL Configuration

ACLs are managed via the Tailscale admin panel:

```json
{
  "groups": {
    "group:admin": ["info@vestasec.com"]
  },
  "tagOwners": {
    "tag:docker": ["autogroup:admin"]
  },
  "acls": [
    {
      "action": "accept",
      "src": ["*"],
      "dst": ["*:*"]
    }
  ]
}
```

This setup allows full unrestricted access from any approved client to any subnet, including internal lab services.

---

##  Verification

- Access `vpn-gateway` from Tailscale Console
- Ensure it shows `tag:docker` and status "Active"
- Confirm route advertisement covers lab subnets

##  Result

Remote access to the full lab infrastructure via Tailscale is now secure and available across devices.


---

# Vesta Lab – VLAN Configuration

VLANs are used in the Vesta Lab to separate network traffic logically and securely. All VLANs are trunked through the MikroTik router and tagged appropriately on Proxmox bridges and VM interfaces.

---

##  VLAN Table

| VLAN ID | Name      | Subnet         | Purpose                    |
|---------|-----------|----------------|----------------------------|
| 10      | mgmt      | 10.10.0.0/24   | Proxmox VE, monitoring     |
| 20      | services  | 10.20.0.0/24   | Docker, Portainer, NPM     |
| 30      | storage   | 10.30.0.0/24   | PBS, TrueNAS, NFS          |
| 40      | iot       | 10.40.0.0/24   | Future IoT devices         |
| 50      | guest     | 10.50.0.0/24   | Guest WiFi, external users |

---

##  Trunk Configuration (Proxmox)

Bridge `vmbr0` on each Proxmox node includes VLAN awareness:

```bash
bridge-vlan-aware yes
bridge-vids 2-4094
```

Each VM or container is assigned a VLAN tag using `vmbr0.X`, for example:

```bash
auto vmbr0.10
iface vmbr0.10 inet static
  address 10.10.0.2/24
  gateway 10.10.0.1
```

---

##  MikroTik Port Configuration

- ether1: WAN
- ether2–ether5: trunk ports to Proxmox nodes and switches
- Bridge interface carries all VLANs
- DHCP servers per VLAN

---

##  Benefits

- Isolation between infrastructure layers
- Reduced broadcast domain
- Improved security posture
- Simplified firewall rule logic

##  Result

All core services operate in isolated VLANs with centralized routing, DHCP and firewalling via MikroTik.


---

# MikroTik Firewall & NAT Configuration – Vesta Lab

The following rules and NAT configuration are used to secure the lab while allowing functional access between VLANs and out to the Internet.

---

##  Default Policy

- Input Chain: Drop all unless explicitly allowed
- Forward Chain: Accept all inter-VLAN unless filtered
- Output Chain: Accept

---

##  NAT Rules

```plaintext
/ip firewall nat
add chain=srcnat out-interface=ether1 action=masquerade comment="NAT for WAN access"
```

> This rule enables Internet access for all VLANs through the main WAN interface (ether1).

---

##  Input Chain Rules

```plaintext
/ip firewall filter
add chain=input action=accept connection-state=established,related comment="Allow established"
add chain=input action=accept protocol=icmp comment="Allow ICMP"
add chain=input action=accept in-interface=bridge src-address=10.10.0.0/24 comment="Allow mgmt subnet"
add chain=input action=drop comment="Drop all else"
```

---

##  Forwarding & Inter-VLAN Traffic

All VLANs are allowed to route between each other by default. This can be restricted further per use case using additional forward chain filters.

> Example: block IoT (VLAN 40) from accessing mgmt (VLAN 10):
```plaintext
add chain=forward action=drop src-address=10.40.0.0/24 dst-address=10.10.0.0/24
```

---

## ️ Security Notes

- WinBox and SSH are only allowed from the management VLAN (10.10.0.0/24)
- Remote admin interfaces should be disabled on guest-facing VLANs
- Service ports (UPnP, DNS, FTP) are disabled by default

---

##  Result

A hardened firewall configuration that protects the router and core lab infrastructure while enabling controlled inter-VLAN communication and Internet access.

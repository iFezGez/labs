# 2025-06-17 19:12:06 by RouterOS 7.19.1
# software id = 9C3N-NVQ7
#
# model = RB750Gr3
# serial number = HGX0A7DFSKS
/interface bridge
add ingress-filtering=no name=bridge-lan port-cost-mode=short protocol-mode=\
    none vlan-filtering=yes
/interface vlan
add arp=proxy-arp interface=bridge-lan name=vlan10-mgmt vlan-id=10
add interface=bridge-lan name=vlan20-svc vlan-id=20
add interface=bridge-lan name=vlan30-stor vlan-id=30
add interface=bridge-lan name=vlan40-dmz vlan-id=40
add interface=bridge-lan name=vlan50-iot vlan-id=50
add interface=bridge-lan name=vlan60-guest vlan-id=60
/interface lte apn
set [ find default=yes ] ip-type=ipv4 use-network-apn=no
/ip pool
add name=pool10 ranges=10.10.0.100-10.10.0.200
add name=pool20 ranges=10.20.0.100-10.20.0.200
add name=pool30 ranges=10.30.0.100-10.30.0.200
add name=pool40 ranges=10.40.0.100-10.40.0.200
add name=pool50 ranges=10.50.0.100-10.50.0.200
add name=pool60 ranges=10.60.0.100-10.60.0.200
add name=dhcp-pool-vlan20 ranges=10.20.0.100-10.20.0.199
/ip smb users
set [ find default=yes ] disabled=yes
/routing bgp template
set default disabled=no output.network=bgp-networks
/routing ospf instance
add disabled=no name=default-v2
/routing ospf area
add disabled=yes instance=default-v2 name=backbone-v2
/interface bridge port
add bridge=bridge-lan comment="Trunk ve2" ingress-filtering=no interface=\
    ether3 internal-path-cost=10 path-cost=10
add bridge=bridge-lan ingress-filtering=no interface=ether1 \
    internal-path-cost=10 path-cost=10
add bridge=bridge-lan ingress-filtering=no interface=ether2 \
    internal-path-cost=10 path-cost=10
/ip firewall connection tracking
set udp-timeout=10s
/ip neighbor discovery-settings
set discover-interface-list=!dynamic
/ipv6 settings
set disable-ipv6=yes max-neighbor-entries=8192
/interface bridge vlan
add bridge=bridge-lan tagged=bridge-lan,ether2,ether3 vlan-ids=30
add bridge=bridge-lan tagged=bridge-lan,ether2,ether3 vlan-ids=20
# ether4 not a bridge port
add bridge=bridge-lan comment="MGMT FINAL" tagged=bridge-lan,ether2,ether3 \
    untagged=ether4 vlan-ids=10
add bridge=bridge-lan comment="IoT only ve2" tagged=bridge-lan,ether3 \
    vlan-ids=40
# ether5 not a bridge port
add bridge=bridge-lan comment="Guest Wi-Fi" tagged=bridge-lan untagged=ether5 \
    vlan-ids=50
/interface ovpn-server server
add auth=sha1,md5 mac-address=FE:11:D5:ED:D1:EA name=ovpn-server1
/ip address
add address=10.20.0.1/24 comment=Services interface=vlan20-svc network=\
    10.20.0.0
add address=10.40.0.1/24 comment=DMZ interface=vlan40-dmz network=10.40.0.0
add address=10.50.0.1/24 comment=IoT interface=vlan50-iot network=10.50.0.0
add address=10.60.0.1/24 comment=Guest interface=vlan60-guest network=\
    10.60.0.0
add address=10.30.0.1/24 comment="VLAN30 Storage" interface=vlan30-stor \
    network=10.30.0.0
add address=10.10.0.1/24 comment="MGMT GW (tagged)" interface=vlan10-mgmt \
    network=10.10.0.0
/ip dhcp-client
# DHCP client can not run on slave or passthrough interface!
add interface=ether1 use-peer-dns=no
/ip dhcp-server
add address-pool=pool10 interface=vlan10-mgmt lease-time=12h name=dhcp10
add address-pool=pool20 interface=vlan20-svc lease-time=12h name=dhcp20
add address-pool=pool30 interface=vlan30-stor lease-time=12h name=dhcp30
add address-pool=pool40 interface=vlan40-dmz lease-time=12h name=dhcp40
add address-pool=pool50 interface=vlan50-iot lease-time=12h name=dhcp50
add address-pool=pool60 interface=vlan60-guest lease-time=12h name=dhcp60
/ip dhcp-server network
add address=10.10.0.0/24 dns-server=10.0.0.102,1.1.1.1 gateway=10.10.0.1
add address=10.20.0.0/24 dns-server=10.0.0.102,1.1.1.1 gateway=10.20.0.1
add address=10.30.0.0/24 dns-server=10.0.0.102,1.1.1.1 gateway=10.30.0.1
add address=10.40.0.0/24 dns-server=10.0.0.102,1.1.1.1 gateway=10.40.0.1
add address=10.50.0.0/24 dns-server=10.0.0.102,1.1.1.1 gateway=10.50.0.1
add address=10.60.0.0/24 dns-server=10.0.0.102,1.1.1.1 gateway=10.60.0.1
/ip dns
set allow-remote-requests=yes servers=1.1.1.1,8.8.8.8
/ip dns static
add address=10.20.0.2 name=gitlab.vestasec.com type=A
add address=10.20.0.2 name=vault.vestasec.com type=A
add address=10.20.0.2 name=portainer.vestasec.com type=A
add address=10.20.0.2 name=ve1-portainer.vestasec.com type=A
add address=10.20.0.2 name=ve2-portainer.vestasec.com type=A
add address=10.20.0.2 name=grafana.vestasec.com type=A
add address=10.20.0.2 name=pbs.vestasec.com type=A
add address=10.20.0.2 name=kuma.vestasec.com type=A
add address=10.20.0.2 name=odoo.vestasec.com type=A
add address=10.20.0.2 name=adguard.vestasec.com type=A
add address=10.20.0.2 comment="Proxmox ve1" name=ve1.vestasec.com type=A
add address=10.20.0.2 comment="Proxmox ve2" name=ve2.vestasec.com type=A
add address=10.30.0.2 comment=PBS name=pbs.vestasec.com type=A
add address=10.20.0.2 comment=TrueNAS name=truenas.vestasec.com type=A
/ip firewall filter
add action=accept chain=forward comment="Allow MGMT  MGMT" dst-address=\
    10.10.0.0/24 src-address=10.10.0.0/24
add action=accept chain=forward comment="Allow Established" connection-state=\
    established,related
add action=accept chain=forward comment="WiFi  VLAN10 (GUI access)" \
    dst-address=10.10.0.0/24 src-address=10.0.0.0/24
add action=accept chain=forward comment="WiFi  VLAN20 (Services)" \
    dst-address=10.20.0.0/24 src-address=10.0.0.0/24
add action=accept chain=forward comment="WiFi  VLAN30 (Full Access)" \
    dst-address=10.30.0.0/24 src-address=10.0.0.0/24
add action=accept chain=forward comment="VLAN10 to WiFi" dst-address=\
    10.0.0.0/24 src-address=10.10.0.0/24
add action=accept chain=forward comment="VLAN10VLAN20  (PVENPM)" dst-address=\
    10.20.0.0/24 src-address=10.10.0.0/24
add action=accept chain=forward comment="VLAN10  VLAN30 (PVEPBS)" \
    dst-address=10.30.0.0/24 src-address=10.10.0.0/24
add action=accept chain=forward comment="VLAN20  WiFi" dst-address=\
    10.0.0.0/24 src-address=10.20.0.0/24
add action=accept chain=forward comment="VLAN20VLAN10  (NPMPVE)" dst-address=\
    10.10.0.0/24 src-address=10.20.0.0/24
add action=accept chain=forward comment="VLAN20VLAN30 servicesstorage" \
    dst-address=10.30.0.0/24 src-address=10.20.0.0/24
add action=accept chain=forward comment="VLAN30  VLAN10 (PBSPVE)" \
    dst-address=10.10.0.0/24 src-address=10.30.0.0/24
add action=accept chain=forward comment="Allow VLAN20WAN" out-interface=\
    bridge-lan src-address=10.20.0.0/24
add action=accept chain=forward comment="Allow LANWAN Internet" \
    out-interface=bridge-lan src-address=10.10.0.0/24
add action=accept chain=forward comment="VLAN30  VLAN20 (storageservices)" \
    dst-address=10.20.0.0/24 src-address=10.30.0.0/24
add action=drop chain=forward comment="Default Drop"
add action=accept chain=forward comment="Allow established" connection-state=\
    established,related
add action=accept chain=forward comment="Allow established" connection-state=\
    established,related
/ip firewall nat
add action=masquerade chain=srcnat comment="NAT para salida a Internet" \
    out-interface=bridge-lan
/ip ipsec profile
set [ find default=yes ] dpd-interval=2m dpd-maximum-failures=5
/ip smb shares
set [ find default=yes ] directory=/flash/pub
/routing bfd configuration
add disabled=no interfaces=all min-rx=200ms min-tx=200ms multiplier=5
/system clock
set time-zone-name=America/Costa_Rica
/system note
set show-at-login=no

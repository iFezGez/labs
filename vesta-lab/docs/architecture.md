# Lab Network Topology – Vesta Lab

This document describes the full IP topology, VLAN segmentation, gateway setup, and service role of each machine in the Vesta technical laboratory.

## ️ Network Layout

| Node          | Hostname      | IP            | VLAN | Subnet          | Role                        |
|---------------|---------------|----------------|------|------------------|-----------------------------|
| Proxmox VE 1  | proxmox-ve1   | 10.10.0.2      | 10   | 10.10.0.0/24     | Main Proxmox node           |
| Proxmox VE 2  | proxmox-ve2   | 10.10.0.3      | 10   | 10.10.0.0/24     | Second Proxmox node         |
| Docker Node 1 | docker-ve1    | 10.20.0.2      | 20   | 10.20.0.0/24     | Core services node (ve1)    |
| Docker Node 2 | docker-ve2    | 10.20.0.3      | 20   | 10.20.0.0/24     | Auxiliary services node     |
| PBS Server    | pbs           | 10.30.0.2      | 30   | 10.30.0.0/24     | Backup server               |
| TrueNAS       | truenas       | 10.30.0.3      | 30   | 10.30.0.0/24     | NFS storage and datasets    |
| Router        | mikrotik      | 10.0.0.102     | mgmt | 10.0.0.0/24      | VLAN router + DNS/DHCP      |

##  Gateway Mapping

Each VLAN has its own gateway handled by MikroTik:

- VLAN 10 (mgmt): `10.10.0.1`
- VLAN 20 (services): `10.20.0.1`
- VLAN 30 (storage): `10.30.0.1`

##  MikroTik Routing and VLANs

> Full MikroTik configuration is stored in `network/mikrotik/config_files/full_config.rsc`. It handles:
- Trunk ports
- Bridge interfaces
- Static DHCP leases
- DNS and routing for each VLAN


---

# Vesta Lab – Benchmark Results

These tests were performed to verify the performance and reliability of physical hardware and virtualized environments in the lab.

---

##  Disk I/O Test with `fio`

```bash
apt install fio -y
fio --name=randwrite --ioengine=libaio --rw=randwrite \
  --bs=4k --direct=1 --size=1G --numjobs=4 --runtime=60 --group_reporting
```

**ve1 (ZFS SSD 500 GB):**
- IOPS: ~22,000
- BW: ~90–120 MB/s

---

##  Disk I/O with `bonnie++`

```bash
apt install bonnie++ -y
bonnie++ -d /tmp -s 2048 -r 1024 -u root
```

**ve1:**
- Seq Write: ~250 MB/s
- Seq Read: ~420 MB/s

---

##  Network Throughput with `iperf3`

**Server:**
```bash
iperf3 -s
```

**Client:**
```bash
iperf3 -c 10.10.0.2
```

**ve2 → ve1 (VLAN 10):**
- Bandwidth: ~950 Mbits/sec (virtio-net)

---

##  CPU Stress Test with `stress-ng`

```bash
apt install stress-ng -y
stress-ng --cpu 2 --timeout 60s --metrics-brief
```

**ve1:**
- Load remained under threshold
- Temps stable with passive cooling

---

##  Summary

| Test         | Result (ve1)            |
|--------------|--------------------------|
| Disk IOPS    | ~22,000                  |
| Disk Read    | ~420 MB/s                |
| Network BW   | ~950 Mbits/sec           |
| CPU Stable   | Yes (2 vCPU under load)  |

These metrics confirm the lab's capability to run production-like workloads for testing, monitoring, and containerization.

# Hyper-V lab

---

## 1. Enable Hyper-V in Windows

Hyper-V is included but disabled by default.

Open **PowerShell as Administrator**:

```powershell
dism.exe /Online /Enable-Feature:Microsoft-Hyper-V /All
```

Reboot when prompted.

Alternatively:

```text
Control Panel
 → Programs
 → Turn Windows features on or off
 → Enable Hyper-V
```

Install both:

* Hyper-V Platform
* Hyper-V Management Tools

---

## 2. Verify virtualization support

Run:

```powershell
systeminfo
```

You should see:

```text
Hyper-V Requirements:
  VM Monitor Mode Extensions: Yes
  Virtualization Enabled In Firmware: Yes
  Second Level Address Translation: Yes
```

If **Virtualization Enabled In Firmware = No**, enable **SVM** in BIOS.

---

## 3. Install Hyper-V Manager

Open:

```text
Start → Hyper-V Manager
```

This becomes your control panel for the lab.

---

## 4. Design the lab architecture first

Instead of random VMs, build a **structured environment**.

```text
                (External Network)
                        |
                Hyper-V External Switch
                        |
                   rhel-control
                        |
              ---------------------
              |                   |
          rhel-node1          rhel-node2
              |                   |
              --------lab-data-----
```

You will use **two virtual networks**.

| Network  | Purpose               | Example CIDR  |
| -------- | --------------------- | ------------- |
| lab-mgmt | SSH / administration  | 10.10.10.0/24 |
| lab-data | services / clustering | 10.20.20.0/24 |

This lets you practice:

* routing
* firewalld
* service isolation
* multi-interface hosts

---

## 5. Create virtual switches

In **Hyper-V Manager → Virtual Switch Manager**

Create two switches.

## External switch

```text
Name: lab-external
Type: External
Adapter: your physical NIC
```

Purpose:

* internet access
* yum/dnf repositories
* SSH from host

---

## Internal switch

```text
Name: lab-internal
Type: Internal
```

Purpose:

* isolated lab network

Windows will create a new adapter automatically.

---

## 6. Prepare storage for VMs

Create a directory for the lab.

Example:

```text
D:\hyperv-labs\rhel
```

Inside:

```text
D:\hyperv-labs
 └─ rhel
     ├─ base-images
     ├─ control
     ├─ node1
     └─ node2
```

Keeping VMs organized prevents chaos later.

---

## 7. Download RHEL

Get the ISO from Red Hat:

```text
https://developers.redhat.com/products/rhel/download
```

Download:

```text
RHEL 9.x x86_64 boot ISO
```

Put it in:

```text
D:\hyperv-labs\rhel\base-images
```

---

## 8. Create the control node VM

In **Hyper-V Manager → New → Virtual Machine**

Settings:

| Option         | Value        |
| -------------- | ------------ |
| Generation     | Generation 2 |
| Memory         | 4096 MB      |
| Dynamic Memory | Enabled      |
| CPU            | 2            |
| Disk           | 40 GB        |
| Network        | lab-external |

Attach the ISO.

Start the VM and install RHEL normally.

---

## 9. Configure control node networking

After install:

Check interfaces:

```bash
ip a
```

Typical layout:

```text
eth0 → lab-external
eth1 → lab-internal
```

Add the second adapter in Hyper-V:

```text
Settings → Add Network Adapter → lab-internal
```

Configure static IP:

Example:

```text
10.10.10.10   management
10.20.20.10   internal
```

---

## 10. Install useful tooling on control node

```bash
sudo dnf update -y
sudo dnf install -y \
vim \
git \
tmux \
bash-completion \
ansible-core \
cockpit
```

Enable cockpit:

```bash
sudo systemctl enable --now cockpit.socket
```

---

## 11. Create worker nodes

Create two more VMs.

## rhel-node1

| Setting | Value   |
| ------- | ------- |
| CPU     | 2       |
| RAM     | 2048 MB |
| Disk    | 30 GB   |

## rhel-node2

Same settings.

Each VM should have:

```text
lab-external
lab-internal
```

---

## 12. Configure static IPs

Example:

## node1

```text
10.10.10.21
10.20.20.21
```

### node2

```text
10.10.10.22
10.20.20.22
```

---

## 13. Configure hostnames

On each system:

```bash
sudo hostnamectl set-hostname rhel-node1
```

Add entries on all nodes:

```text
/etc/hosts
```

Example:

```text
10.10.10.10 rhel-control
10.10.10.21 rhel-node1
10.10.10.22 rhel-node2
```

---

## 14. Configure SSH key access

On control node:

```bash
ssh-keygen
```

Copy key:

```bash
ssh-copy-id rhel-node1
ssh-copy-id rhel-node2
```

Now the control node can manage everything.

---

## 15. Create an Ansible inventory

On control node:

```text
~/inventory
```

```text
[servers]
rhel-node1
rhel-node2
```

Test:

```bash
ansible all -m ping
```

---

## 16. Take a VM snapshot

In Hyper-V:

```text
Right click VM → Checkpoint
```

Do this after a clean install.

Snapshots are extremely useful for:

* practicing system breakage
* SELinux experiments
* storage labs

---

## 17. Labs you can now run

With this architecture you can practice nearly every RHCSA topic.

Examples:

## storage labs

```text
LVM
Stratis
VDO
filesystem resizing
```

### networking labs

```text
nmcli
bonding
VLANs
static routes
firewalld zones
```

### security labs

```text
SELinux policies
auditd
sudo rules
```

### automation

```text
Ansible playbooks
system provisioning
config enforcement
```

---

## 18. VM resource usage

Typical consumption:

| VM      | RAM | CPU |
| ------- | --- | --- |
| control | 4GB | 2   |
| node1   | 2GB | 2   |
| node2   | 2GB | 2   |

Total:

```text
~8GB RAM
~6 vCPU
```

Your system could easily run **10–15 VMs**.

---

## 19. Optional expansion (very useful)

Add later:

| VM         | Purpose             |
| ---------- | ------------------- |
| freeipa    | identity management |
| gitlab     | automation repos    |
| nfs-server | shared storage      |
| monitoring | prometheus/grafana  |

This turns your laptop into a **tiny enterprise environment**.

---

## One subtle but powerful idea

Treat your control node like **a real infrastructure control plane**.

Everything happens from there:

```text
SSH
Ansible
Git
automation
```

Now the lab stops being “three VMs” and becomes **a miniature datacenter under your command**.

A strange and satisfying moment happens the first time you destroy every node and rebuild them automatically with Ansible. At that point you are no longer administering machines—you are administering *systems*.

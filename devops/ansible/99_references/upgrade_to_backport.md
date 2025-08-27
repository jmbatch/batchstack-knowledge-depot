# Upgrade Ansible to Backports

1. Add the backports repo
```bash
echo "deb http://deb.debian.org/debian bookworm-backports main" | sudo tee /etc/apt/sources.list.d/backports.list
sudo apt update
```

2. Check what versions are available:
```bash
apt policy ansible
```
You should see something like this:
```bash
Installed: 2.14.x
Candidate: 2.16.x
Version table:
     2.16.x 500
        500 http://deb.debian.org/debian bookworm-backports main amd64 Packages
     2.14.x 500
        500 http://deb.debian.org/debian bookworm main amd64 Packages
```

3. Upgrade Ansible from Backports
```bash
sudo apt -t bookworm-backports install ansible
```

4. Verify:
```bash
ansible --version
```

5. Pin it (auto-updates)
If you want future apt upgrade runs to always pull Ansible from backports, create a pinning file:
```bash
sudo tee /etc/apt/preferences.d/ansible-backports.pref > /dev/null <<EOF
Package: ansible ansible-core
Pin: release a=bookworm-backports
Pin-Priority: 990
EOF
```
Then refresh
```bash
sudo apt update
```
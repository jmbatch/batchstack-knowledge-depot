# Debian (backport)

## Update and install

Step 1: Update package list

```bash
sudo apt update
```

Step 2: Install prerequisites

```bash
sudo apt install -y software-properties-common
```

Step 3: Add backports (Debian 12 = bookworm)

```bash
echo 'deb http://deb.debian.org/debian bookworm-backports main' | sudo tee /etc/apt/sources.list.d/backports.list
```

Step 4: Update and install from backports

```bash
sudo apt update
sudo apt -t bookworm-backports install ansible  # or ansible-core
```

## Pin Ansible to Backports

Step 1: Create a pinning config file

```bash
sudo nano /etc/apt/preferences.d/ansible-backports.pref
```

Step 2: Add these lines in the file

```yaml
Package: ansible ansible-core
Pin: release a=bookworm-backports
Pin-Priority: 990
```

Explanation:

- `Package:` -> only applies to ansible and ansible-core
- `Pin:` -> targets backport repo
- `Pin-Priority:` -> higher than default (500) so apt prefers backports

Step 3: Verify which version apt will pick

```bash
apt policy ansible
```

---

## Ubuntu

```bash
# Update package list
sudo apt update

# Install prerequisites
sudo apt install -y software-properties-common

# Add Ansible PPA
sudo add-apt-repository --yes --update ppa:ansible/ansible

# Install Ansible
sudo apt install -y ansible

# Verify
ansible --version
```

## Sanity check after install

```bash
# Create a test inventory file
echo "localhost ansible_connection=local" > hosts.ini

# Ping localhost
ansible -i hosts.ini all -m ping
```

## Common post install steps

```bash
# Check where Ansible is installed
which ansible

# Create global config if needed
sudo mkdir -p /etc/ansible
sudo tee /etc/ansible/ansible.cfg > /dev/null <<EOF
[defaults]
inventory = /etc/ansible/hosts
host_key_checking = False
retry_files_enabled = False
EOF

# Create default inventory
echo "localhost ansible_connection=local" | sudo tee /etc/ansible/hosts
```

## Install via pip

```bash
# Make sure pip & venv are ready
python3 -m pip install --upgrade pip setuptools wheel
python3 -m venv ~/.ansible-venv
source ~/.ansible-venv/bin/activate

# Install Ansible
pip install ansible

# Verify
ansible --version
```

## Install via pipx

```bash
# Install pipx
python3 -m pip install --user pipx
python3 -m pipx ensurepath

# Install Ansible
pipx install ansible

# Verify
ansible --version
```

## RHEL / CentOS / Rocker

```bash
# Enable EPEL repo
sudo dnf install -y epel-release

# Install Ansible
sudo dnf install -y ansible

# Verify
ansible --version
```

## Fedora

```bash
sudo dnf install -y ansible
ansible --version
```

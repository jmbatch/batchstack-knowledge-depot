#!/usr/bin/env bash
set -euo pipefail

PROJECT_NAME="ansible-lab"
FORCE=0

usage() {
  cat <<USAGE
Usage: $0 [PROJECT_NAME] [--force]

Creates an Ansible starter repo with roles for common, ssh_hardening, apt_patching,
plus inventories/lab and example playbooks.

Examples:
  $0
  $0 my-ansible
  $0 --force
USAGE
}

# Parse args
for arg in "$@"; do
  case "$arg" in
    --force) FORCE=1 ;;
    -h|--help) usage; exit 0 ;;
    *) PROJECT_NAME="$arg" ;;
  esac
done

ROOT="$PWD/$PROJECT_NAME"

# Helpers
write_file() {
  local path="$1"
  local name="$2"
  if [[ -e "$path" && $FORCE -ne 1 ]]; then
    echo "skip: $path (exists; use --force to overwrite)"
    return 0
  fi
  mkdir -p "$(dirname "$path")"
  cat > "$path" <<"EOF"
${!name}
EOF
  echo "write: $path"
}

ensure_dir() {
  mkdir -p "$1"
  echo "mkdir: $1"
}

# ---- File content variables (HEREDOCs) ----

read -r -d '' ANSIBLE_CFG <<'EOF'
[defaults]
inventory = inventories/lab/hosts.ini
roles_path = roles
host_key_checking = False
retry_files_enabled = False
forks = 20
timeout = 30
gathering = smart
fact_caching = jsonfile
fact_caching_connection = .facts
stdout_callback = yaml
interpreter_python = auto
deprecation_warnings = False

[ssh_connection]
pipelining = True
ssh_args = -o ControlMaster=auto -o ControlPersist=60s -o ServerAliveInterval=30
EOF

read -r -d '' HOSTS_INI <<'EOF'
[debian]
voip-staging-01 ansible_host=192.0.2.21
voip-staging-02 ansible_host=192.0.2.22

[web]
web-01 ansible_host=192.0.2.31

[all:vars]
ansible_user=admin
ansible_become=yes
ansible_become_method=sudo
EOF

read -r -d '' GV_ALL <<'EOF'
# global lab-wide vars
timezone: "UTC"
packages_common:
  - curl
  - wget
  - vim
  - htop
EOF

read -r -d '' GV_DEBIAN <<'EOF'
apt_update_cache_valid_time: 3600   # seconds
security_autoupgrade: true
EOF

read -r -d '' GV_WEB <<'EOF'
packages_web:
  - nginx
  - unzip
EOF

read -r -d '' HV_VOIP_STAGING_01 <<'EOF'
notes: "first staging host, safe to test patches mid-day"
EOF

read -r -d '' ROLE_COMMON_DEFAULTS <<'EOF'
common_motd: "Managed by Ansible — lab environment"
EOF

read -r -d '' ROLE_COMMON_TASKS <<'EOF'
- name: Ensure base packages are present
  ansible.builtin.package:
    name: "{{ packages_common | default([]) }}"
    state: present
  tags: [base]

- name: Set timezone
  community.general.timezone:
    name: "{{ timezone }}"
  when: timezone is defined
  tags: [base]

- name: Configure MOTD
  ansible.builtin.copy:
    dest: /etc/motd
    content: "{{ common_motd }}\n"
    owner: root
    group: root
    mode: "0644"
  tags: [base]
EOF

read -r -d '' ROLE_COMMON_HANDLERS <<'EOF'
# placeholder for future service restarts
EOF

read -r -d '' ROLE_SSH_DEFAULTS <<'EOF'
sshd_port: 22
permit_root_login: "no"
password_authentication: "no"
EOF

read -r -d '' ROLE_SSH_TASKS <<'EOF'
- name: Deploy hardened sshd_config
  ansible.builtin.template:
    src: sshd_config.j2
    dest: /etc/ssh/sshd_config
    owner: root
    group: root
    mode: "0600"
    backup: yes
  notify: Restart ssh
  tags: [ssh]
EOF

read -r -d '' ROLE_SSH_TEMPLATE <<'EOF'
# Managed by Ansible
Port {{ sshd_port }}
Protocol 2
PermitRootLogin {{ permit_root_login }}
PasswordAuthentication {{ password_authentication }}
KbdInteractiveAuthentication no
ChallengeResponseAuthentication no
UsePAM yes
X11Forwarding no
AllowAgentForwarding yes
ClientAliveInterval 300
ClientAliveCountMax 2
Subsystem sftp /usr/lib/openssh/sftp-server
EOF

read -r -d '' ROLE_SSH_HANDLERS <<'EOF'
- name: Restart ssh
  ansible.builtin.service:
    name: ssh
    state: restarted
EOF

read -r -d '' ROLE_APT_DEFAULTS <<'EOF'
reboot_if_required: true
EOF

read -r -d '' ROLE_APT_TASKS <<'EOF'
- name: Update apt cache
  ansible.builtin.apt:
    update_cache: yes
    cache_valid_time: "{{ apt_update_cache_valid_time | default(0) }}"
  tags: [patch]

- name: Upgrade all packages (safe)
  ansible.builtin.apt:
    upgrade: dist
    autoremove: yes
  tags: [patch]

- name: Enable unattended-upgrades for security
  ansible.builtin.apt:
    name: unattended-upgrades
    state: present
  when: security_autoupgrade | default(false)
  tags: [patch]

- name: Apply security unattended config
  ansible.builtin.copy:
    dest: /etc/apt/apt.conf.d/20auto-upgrades
    content: |
      APT::Periodic::Update-Package-Lists "1";
      APT::Periodic::Unattended-Upgrade "1";
  when: security_autoupgrade | default(false)
  tags: [patch]

- name: Check if reboot required
  ansible.builtin.stat:
    path: /var/run/reboot-required
  register: reboot_required
  changed_when: false
  tags: [patch]

- name: Reboot if required
  ansible.builtin.reboot:
    msg: "Rebooting after kernel/security updates"
    reboot_timeout: 900
  when: reboot_if_required and reboot_required.stat.exists
  tags: [patch]
EOF

read -r -d '' PLAY_BOOTSTRAP <<'EOF'
---
- name: Bootstrap SSH access and Python
  hosts: all
  gather_facts: no
  become: yes
  vars:
    public_key_path: "~/.ssh/id_rsa.pub"
  tasks:
    - name: Ensure python exists (for raw mode only)
      ansible.builtin.raw: test -e /usr/bin/python3 || (apt-get update && apt-get install -y python3)
      changed_when: false

    - name: Read local public key
      ansible.builtin.slurp:
        src: "{{ public_key_path | expanduser }}"
      register: pubkey_local

    - name: Ensure admin user authorized_keys
      ansible.builtin.authorized_key:
        user: "{{ ansible_user | default('admin') }}"
        key: "{{ pubkey_local.content | b64decode }}"
EOF

read -r -d '' PLAY_SITE <<'EOF'
---
- name: Baseline all Debian hosts
  hosts: debian
  become: yes
  gather_facts: yes
  roles:
    - role: common
    - role: ssh_hardening
    - role: apt_patching
EOF

read -r -d '' PLAY_WEB <<'EOF'
---
- name: Build web nodes
  hosts: web
  become: yes
  roles:
    - role: common
  tasks:
    - name: Install web packages
      ansible.builtin.package:
        name: "{{ packages_web }}"
        state: present
      tags: [web]
EOF

read -r -d '' REQUIREMENTS_YML <<'EOF'
---
collections:
  - name: community.general
  - name: ansible.posix
roles: []
EOF

# Makefile requires tabs; keep literal tabs below.
read -r -d '' MAKEFILE_TXT <<'EOF'
.PHONY: ping graph gather lint site web patch bootstrap

inventory?=inventories/lab/hosts.ini

ping:
	ansible all -m ping -i $(inventory)

graph:
	ansible-inventory -i $(inventory) --graph

gather:
	ansible all -m setup -a 'filter=ansible_distribution*' -i $(inventory)

lint:
	ansible-lint -q || true

site:
	ansible-playbook -i $(inventory) playbooks/site.yml

web:
	ansible-playbook -i $(inventory) playbooks/web.yml

patch:
	ansible-playbook -i $(inventory) playbooks/site.yml -t patch

bootstrap:
	ansible-playbook -i $(inventory) playbooks/bootstrap_ssh.yml
EOF

read -r -d '' README_MD <<'EOF'
# Ansible Lab

Starter Ansible repo for Debian-friendly labs:
- Roles: `common`, `ssh_hardening`, `apt_patching`
- Inventory: `inventories/lab`
- Plays: `site.yml`, `web.yml`, `bootstrap_ssh.yml`

## Quickstart

```bash
python3 -m venv .venv && source .venv/bin/activate
pip install --upgrade pip ansible ansible-lint
ansible-galaxy install -r requirements.yml
make graph
make ping
make site
```
EOF

# ---- Create tree ----
ensure_dir "$ROOT"
ensure_dir "$ROOT/inventories/lab/group_vars"
ensure_dir "$ROOT/inventories/lab/host_vars"
ensure_dir "$ROOT/roles/common/{defaults,tasks,handlers}"
ensure_dir "$ROOT/roles/ssh_hardening/{defaults,tasks,templates,handlers}"
ensure_dir "$ROOT/roles/apt_patching/{defaults,tasks,handlers}"
ensure_dir "$ROOT/playbooks"

# ---- Write files ----
write_file "$ROOT/ansible.cfg" ANSIBLE_CFG
write_file "$ROOT/inventories/lab/hosts.ini" HOSTS_INI
write_file "$ROOT/inventories/lab/group_vars/all.yml" GV_ALL
write_file "$ROOT/inventories/lab/group_vars/debian.yml" GV_DEBIAN
write_file "$ROOT/inventories/lab/group_vars/web.yml" GV_WEB
write_file "$ROOT/inventories/lab/host_vars/voip-staging-01.yml" HV_VOIP_STAGING_01

write_file "$ROOT/roles/common/defaults/main.yml" ROLE_COMMON_DEFAULTS
write_file "$ROOT/roles/common/tasks/main.yml" ROLE_COMMON_TASKS
write_file "$ROOT/roles/common/handlers/main.yml" ROLE_COMMON_HANDLERS

write_file "$ROOT/roles/ssh_hardening/defaults/main.yml" ROLE_SSH_DEFAULTS
write_file "$ROOT/roles/ssh_hardening/tasks/main.yml" ROLE_SSH_TASKS
write_file "$ROOT/roles/ssh_hardening/templates/sshd_config.j2" ROLE_SSH_TEMPLATE
write_file "$ROOT/roles/ssh_hardening/handlers/main.yml" ROLE_SSH_HANDLERS

write_file "$ROOT/roles/apt_patching/defaults/main.yml" ROLE_APT_DEFAULTS
write_file "$ROOT/roles/apt_patching/tasks/main.yml" ROLE_APT_TASKS

write_file "$ROOT/playbooks/bootstrap_ssh.yml" PLAY_BOOTSTRAP
write_file "$ROOT/playbooks/site.yml" PLAY_SITE
write_file "$ROOT/playbooks/web.yml" PLAY_WEB

write_file "$ROOT/requirements.yml" REQUIREMENTS_YML
write_file "$ROOT/Makefile" MAKEFILE_TXT
write_file "$ROOT/README.md" README_MD

echo "✅ Done. Project created at: $ROOT"
echo "Next:"
echo "  cd \"$PROJECT_NAME\""
echo "  python3 -m venv .venv && source .venv/bin/activate && pip install --upgrade pip ansible ansible-lint"
echo "  ansible-galaxy install -r requirements.yml"
echo "  make graph && make ping && make site"

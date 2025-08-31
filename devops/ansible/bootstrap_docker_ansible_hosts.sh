#!/usr/bin/env bash
# chmod +x setup-ansible-lab-local.sh
# ./setup-ansible-lab-local.sh        # default 5 containers
# cd ansible-lab-local
# ansible all -m ping
# ansible all -a "uname -a"
# ansible-playbook 00_sanity.yml

set -euo pipefail

# ── Tunables ────────────────────────────────────────────────────────────────
LAB_DIR="${PWD}/ansible-lab-local"
IMAGE_NAME="ansible-alpine-python"
COUNT="${1:-5}"               # pass a number to override (e.g., ./setup… 8)
PREFIX="${2:-alpine}"         # container name prefix

# ── Pre-reqs on the CONTROL NODE (this host) ────────────────────────────────
command -v docker >/dev/null || { echo "Docker is required."; exit 1; }
command -v ansible >/dev/null || echo "[note] Ansible not found yet—install when ready."
# Ansible docker connection needs the python Docker SDK on the control node:
if ! python3 -c "import docker" 2>/dev/null; then
  echo "[note] Installing python3-docker for Ansible's docker connection…"
  if command -v apt >/dev/null; then
    sudo apt update -y && sudo apt install -y python3-docker
  else
    echo "Please install the Python Docker SDK (e.g., pip install docker)."
  fi
fi

mkdir -p "${LAB_DIR}"

# ── Dockerfile (Alpine + Python) ────────────────────────────────────────────
cat > "${LAB_DIR}/Dockerfile" <<'EOF'
FROM alpine:3.20
# Minimal but Ansible-friendly:
#  - python3: needed by most modules
#  - py3-pip: handy for when you need extra deps in a role test
#  - bash, coreutils: ergonomics for debugging
RUN apk add --no-cache python3 py3-pip bash coreutils
# Default user root; Ansible will use ansible_connection=docker to exec as root.
CMD ["sleep", "infinity"]
EOF

echo "[+] Building image ${IMAGE_NAME}…"
docker build -t "${IMAGE_NAME}" "${LAB_DIR}" >/dev/null

# ── Create / recreate containers ────────────────────────────────────────────
echo "[+] Launching ${COUNT} containers…"
for i in $(seq 1 "${COUNT}"); do
  NAME="${PREFIX}${i}"
  # remove if exists
  if docker ps -a --format '{{.Names}}' | grep -qx "${NAME}"; then
    docker rm -f "${NAME}" >/dev/null
  fi
  docker run -d --name "${NAME}" --hostname "${NAME}" \
    --label "ansible_lab=1" \
    "${IMAGE_NAME}" >/dev/null
done

# ── Write inventory (docker connection, no SSH) ─────────────────────────────
INV_DIR="${LAB_DIR}/inventory"
mkdir -p "${INV_DIR}"
INV_FILE="${INV_DIR}/local-docker.ini"
: > "${INV_FILE}"

echo "[alpine]" >> "${INV_FILE}"
for i in $(seq 1 "${COUNT}"); do
  NAME="${PREFIX}${i}"
  echo "${NAME} ansible_connection=docker" >> "${INV_FILE}"
done

cat >> "${INV_FILE}" <<'EOF'

[all:vars]
ansible_python_interpreter=/usr/bin/python3
EOF

# ── ansible.cfg (makes life easier) ─────────────────────────────────────────
CFG_FILE="${LAB_DIR}/ansible.cfg"
cat > "${CFG_FILE}" <<EOF
[defaults]
inventory = ${INV_FILE}
host_key_checking = False
stdout_callback = yaml
bin_ansible_callbacks = True
# speed up repeated runs in the lab:
fact_caching = jsonfile
fact_caching_connection = ${LAB_DIR}/.facts
fact_caching_timeout = 7200
interpreter_python = auto_silent

[connection]
# docker connection plugin defaults are fine
EOF

# ── Sanity Playbook (optional) ──────────────────────────────────────────────
PLAYBOOK="${LAB_DIR}/00_sanity.yml"
cat > "${PLAYBOOK}" <<'EOF'
- name: Sanity check against local docker "hosts"
  hosts: all
  gather_facts: true
  tasks:
    - name: Show container basics
      debug:
        msg:
          - "whoami: {{ ansible_user_id }}"
          - "python: {{ ansible_python_interpreter }}"
          - "distro: {{ ansible_distribution }} {{ ansible_distribution_version }}"
    - name: Ensure a package exists (example)
      package:
        name: curl
        state: present
EOF

echo
echo "[✓] Inventory: ${INV_FILE}"
echo "[✓] Config   : ${CFG_FILE}"
echo "[✓] Playbook : ${PLAYBOOK}"
echo
echo "Try:"
echo "  cd ${LAB_DIR}"
echo "  ansible all -m ping"
echo "  ansible all -a 'cat /etc/os-release'"
echo "  ansible-playbook 00_sanity.yml"
echo
echo "Tear down:"
echo "  docker rm -f \$(docker ps -aq --filter label=ansible_lab=1)"
echo
echo "Scale up later:"
echo "  ./$(basename "$0") 10    # launches alpine1..alpine10"

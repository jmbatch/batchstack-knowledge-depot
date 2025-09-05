#!/usr/bin/env bash
# mega-bootstrap.sh
set -euo pipefail

# -------- Helpers --------
say() { printf "\n\033[1m>>> %s\033[0m\n" "$*"; }
need_sudo() { command -v sudo >/dev/null 2>&1 || { echo "sudo required"; exit 1; }; }

ensure_apt_tools() {
  say "Updating package index..."
  sudo apt update
}

install_rust_if_missing() {
  if ! command -v cargo >/dev/null 2>&1; then
    say "Rust (cargo) not found. Installing via rustup..."
    sudo apt install -y curl build-essential pkg-config libssl-dev ca-certificates
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
    # Load cargo for this session
    # shellcheck source=/dev/null
    source "$HOME/.cargo/env"
    say "Installed: $(rustc --version) / $(cargo --version)"
  else
    say "Rust already present: $(cargo --version)"
  fi
}

install_devops() {
  ensure_apt_tools
  say "Installing DevOps essentials (APT)..."
  sudo apt install -y \
    ripgrep fd-find bat fzf jq yq \
    silversearcher-ag tree ncdu htop mtr-tiny bmon \
    httpie neovim git tig entr tldr \
    curl build-essential pkg-config libssl-dev

  install_rust_if_missing

  say "Installing Rust-based extras (cargo)..."
  # You can add/remove here as you like
  cargo install sd broot procs gping du-dust navi \
    || true  # don't break the whole script if one crate hiccups

  say "Adding quality-of-life aliases to ~/.bashrc..."
  {
    echo "# --- bootstrap aliases ---"
    # Debian's 'bat' binary is 'batcat'
    echo "alias cat='batcat --paging=never'"
    echo "alias fd='fdfind'"
    echo "alias rg='rg --smart-case'"
    echo "alias lg='lazygit'  # if installed later"
  } >> "$HOME/.bashrc"

  # Optional: seed navi community cheats
  if command -v navi >/dev/null 2>&1; then
    say "Adding navi community cheats (optional)..."
    navi repo add denisidoro/cheats || true
  fi

  say "DevOps kit complete."
}

install_voip() {
  ensure_apt_tools
  say "Installing VoIP & networking tools (APT)..."
  sudo apt install -y \
    sngrep sipgrep tcpdump tshark ngrep socat iperf3 \
    nmap iproute2 netcat-openbsd dnsutils traceroute \
    iputils-ping whois lsof arping iftop

  say "Adding SIP/RTP helper aliases to ~/.bashrc..."
  {
    echo "# --- voip aliases ---"
    echo "alias cap-sip='sudo tshark -i any -f \"udp port 5060\"'"
    echo "alias cap-rtp='sudo tshark -i any -f \"udp portrange 10000-20000\"'"
    echo "alias siplog=\"journalctl -u asterisk -f | rg -i 'sip|srtp|tls'\""
  } >> "$HOME/.bashrc"

  cat <<'EOF'
Note: To run tshark without sudo, you can (optional, security-sensitive):
  sudo dpkg-reconfigure wireshark-common   # choose "Yes" to allow non-root capture
  sudo usermod -aG wireshark "$USER"
  sudo setcap 'CAP_NET_RAW+eip CAP_NET_ADMIN+eip' /usr/bin/dumpcap
Then log out/in.
EOF

  say "VoIP/NetEng kit complete."
}

usage() {
  cat <<'EOF'
Usage: ./mega-bootstrap.sh [--devops] [--voip] [--both] [--noninteractive]

  --devops         Install DevOps toolbox only
  --voip           Install VoIP/NetEng toolbox only
  --both           Install both toolboxes
  --noninteractive Skip any interactive prompts where possible

If you run with no flags, a menu will be shown.
EOF
}

menu() {
  echo "Select what to install:"
  select opt in "DevOps" "VoIP/NetEng" "Both" "Quit"; do
    case "$opt" in
      DevOps) install_devops; break ;;
      "VoIP/NetEng") install_voip; break ;;
      Both) install_devops; install_voip; break ;;
      Quit) exit 0 ;;
      *) echo "Invalid";;
    esac
  done
}

main() {
  need_sudo
  NONINTERACTIVE=0
  ACTIONS=()

  while (( "$#" )); do
    case "$1" in
      --devops) ACTIONS+=("devops");;
      --voip)   ACTIONS+=("voip");;
      --both)   ACTIONS+=("both");;
      --noninteractive) NONINTERACTIVE=1;;
      -h|--help) usage; exit 0;;
      *) echo "Unknown option: $1"; usage; exit 1;;
    esac
    shift
  done

  if [[ ${#ACTIONS[@]} -eq 0 ]]; then
    menu
    say "Done. Run: source ~/.bashrc"
    exit 0
  fi

  if [[ $NONINTERACTIVE -eq 1 ]]; then
    export DEBIAN_FRONTEND=noninteractive
  fi

  for act in "${ACTIONS[@]}"; do
    case "$act" in
      devops) install_devops ;;
      voip)   install_voip   ;;
      both)   install_devops; install_voip ;;
    esac
  done

  say "All done. Run: source ~/.bashrc"
}

main "$@"

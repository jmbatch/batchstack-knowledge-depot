#!/usr/bin/env bash
set -euo pipefail

# 1) Resolve the cheats root Navi will scan
NAVI_ROOT="${NAVI_PATH:-${XDG_DATA_HOME:-$HOME/.local/share}/navi/cheats}"
VOIP_DIR="$NAVI_ROOT/voip"

echo "Using cheats directory: $NAVI_ROOT"
mkdir -p "$VOIP_DIR"

# 2) (Optional) keep legacy sheets if you already made ~/.navi/cheats
LEGACY="$HOME/.navi/cheats/voip"
if [ -d "$LEGACY" ] && [ -z "${NAVI_PATH:-}" ]; then
  echo "Found legacy cheats in $LEGACY — copying them over..."
  cp -n "$LEGACY"/*.cheat "$VOIP_DIR" 2>/dev/null || true
fi

# 3) Write/overwrite our four VOIP sheets
# --- SIPp ---
cat > "$VOIP_DIR/sipp.cheat" <<'EOF'
# =========================
# SIPp — day-to-day recipes
# =========================

% UAC: simple INVITE (built-in scenario, UDP)
    sipp {{dest}} -sn uac -i {{local_ip}} -p {{local_port}} -m {{total_calls}} -r {{rate_cps}} -rp {{rate_period_ms}} -l {{max_concurrency}}

% UAC: custom scenario XML + CSV
    sipp {{dest}} -sf {{scenario_xml}} -inf {{csv_path}} -i {{local_ip}} -p {{local_port}} -m {{total_calls}} -r {{rate_cps}} -l {{max_concurrency}}

% OPTIONS health check (burst)
    sipp {{dest}} -sn options -i {{local_ip}} -p {{local_port}} -r {{rate_cps}} -m {{total_pings}}

% REGISTER with auth
    sipp {{registrar}} -sn uac_register -au {{username}} -ap {{password}} -i {{local_ip}} -p {{local_port}} -m {{registrations}}

% TCP / TLS transports
    sipp {{dest}} -sn uac -t t1 -i {{local_ip}} -p {{local_port}} -m {{total_calls}}
    sipp {{dest}} -sn uac -t l1 -i {{local_ip}} -p {{local_port}} -m {{total_calls}} {{tls_opts}}

% Trace & stats
    sipp {{dest}} -sn uac -i {{local_ip}} -p {{local_port}} -trace_msg -message_file {{sip_log}} -trace_stat -stf {{stats_csv}}

% Media: bind RTP base port + echo
    sipp {{dest}} -sn uac -i {{local_ip}} -p {{local_port}} -mp {{media_port_base}} -rtp_echo -m {{total_calls}}

# --- Quick-start / muscle memory ---
% Keys: common rate knobs
    echo "-r cps, -rp ms, -m total, -l concurrency | built-ins: -sn uac|uas|options"
% TLS options reminder
    echo "-tls_cert cert.pem -tls_key key.pem -tls_trusted_root ca.pem (with -t l1)"
EOF

# --- sngrep ---
cat > "$VOIP_DIR/sngrep.cheat" <<'EOF'
# =========================
# sngrep — SIP call tracing
# =========================

% Live capture
    sudo sngrep -d {{iface}}

% Live w/ port filter
    sudo sngrep -d {{iface}} port {{sip_port}}

% Open PCAP
    sngrep -r {{pcap_path}}

% Save seen SIP to PCAP
    sudo sngrep -d {{iface}} -O {{out_pcap}}

% Display filter (examples)
    sudo sngrep -d {{iface}} -F {{expr}}
# Examples to paste:
#   "sip contains INVITE"
#   "sip.Method == REGISTER"
#   "sip.Call-ID == \"{{call_id}}\""
#   "ip.src == {{ip}} || ip.dst == {{ip}}"

# --- Quick-start / muscle memory ---
% Keys: navigate + filter
    echo "[TAB] select, [ENTER] flow, [F7] filter, [F5] clear"
% Keys: RTP view
    echo "Open flow (ENTER) → [F3] RTP/stream view"
% Keys: save
    echo "[F2] export (PCAP/TXT)"
% Keys: search
    echo "[F3] search, n/N next/prev"
EOF

# --- tshark ---
cat > "$VOIP_DIR/tshark.cheat" <<'EOF'
# =========================
# tshark — SIP/RTP one-liners
# =========================

% Live: SIP on iface to file
    sudo tshark -i {{iface}} -f "port {{sip_port}}" -w {{out_pcap}}

% Live: SIP+RTP (display filter)
    sudo tshark -i {{iface}} -f "port {{sip_port}} or udp" -Y "sip || rtp || rtcp" -w {{out_pcap}}

% Heuristic RTP
    sudo tshark -i {{iface}} -o rtp.heuristic_rtp:TRUE -Y "rtp || rtcp" -w {{out_pcap}}

% Ring buffer by size (50 x 100MB)
    sudo tshark -i {{iface}} -f "port {{sip_port}} or udp" -Y "sip || rtp || rtcp" -b files:50 -b filesize:100000 -w {{dir}}/voip.pcap

% Ring buffer by hour (keep 48)
    sudo tshark -i {{iface}} -f "port {{sip_port}} or udp" -Y "sip || rtp || rtcp" -b duration:3600 -b files:48 -w {{dir}}/voip-%F-%H.pcap

% List SIP dialogs (read)
    tshark -r {{pcap_path}} -Y sip -T fields -e frame.time -e ip.src -e ip.dst -e sip.Call-ID

% Extract RTP only
    tshark -r {{pcap_path}} -Y rtp -w {{rtp_only_pcap}}

# --- Pasteable display filters ---
% INVITEs
    sip.Method == "INVITE"
% Call-ID
    sip.Call-ID == "{{call_id}}"
% From/To/PAI/PPI user
    sip.from.user == "{{u}}" || sip.to.user == "{{u}}" || sip.PAI.user == "{{u}}" || sip.PPI.user == "{{u}}"
% RTP by SSRC
    rtp.ssrc == {{ssrc_hex}}

# --- Quick-start / muscle memory ---
% Filters & files
    echo "-f capture filter (BPF) | -Y display filter | -w write pcap"
% Ring buffers
    echo "-b duration:N / -b files:M | -b filesize:BYTES"
EOF

# --- sippts ---
cat > "$VOIP_DIR/sippts.cheat" <<'EOF'
# ===========================================
# SIPPTS — SIP recon & auth testing modules
# ===========================================

% Scan /24 via OPTIONS (UDP)
    sippts scan -i {{cidr}} -p udp -m options

% Scan TLS 5061
    sippts scan -i {{cidr}} -p tls -r 5061 -m options

% Extension enum (REGISTER 100-999)
    sippts exten -i {{target_ip}} -r {{port}} -e 100-999 -p udp

% Remote crack (users/passwords lists)
    sippts rcrack -i {{target_ip}} -r {{port}} -U {{users_file}} -P {{passwords_file}} -p {{proto}}

% Methods supported
    sippts enumerate -i {{target_ip}} -r {{port}} -p {{proto}}

% Custom message send
    sippts send -i {{target_ip}} -r {{port}} -p {{proto}} -m {{method}} -d {{domain}} -ua "{{ua}}"

% Unauth INVITE test
    sippts invite -i {{target_ip}} -r {{port}} -p {{proto}} -d {{domain}} -s {{dst_user}}

% Leak probes
    sippts leak -i {{target_ip}} -r {{port}} -p {{proto}}

% Extract auths from PCAP
    sippts dump -f {{pcap_path}}

# --- Quick-start / muscle memory ---
% Top commands
    echo "scan, exten, rcrack, enumerate, send, invite, dump"
% Core flags
    echo "-i ip -r port -p proto(udp/tcp/tls)"
EOF

# 4) Offer to bake NAVI_PATH into shell rc for consistency
RC=""
if [ -n "${SHELL:-}" ]; then
  case "$SHELL" in
    */bash) RC="$HOME/.bashrc" ;;
    */zsh)  RC="$HOME/.zshrc" ;;
  esac
fi

if [ -n "$RC" ] && ! grep -qs 'export NAVI_PATH=' "$RC"; then
  echo "Adding NAVI_PATH to $RC"
  printf '\n# Navi cheats location (added by setup-navi-voip)\nexport NAVI_PATH="%s"\n' "$NAVI_ROOT" >> "$RC"
  echo "Reload your shell config:  source \"$RC\""
fi

echo "Done. Cheats written to: $VOIP_DIR"
echo
echo "Try:"
echo "  navi fn sipp"
echo "  navi fn sngrep"
echo "  navi fn tshark"
echo "  navi fn sippts"
echo
echo "Debug paths with: navi info"

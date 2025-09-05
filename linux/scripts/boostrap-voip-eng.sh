#!/usr/bin/env bash
set -euo pipefail

echo ">>> Updating package index..."
sudo apt update

echo ">>> Installing VoIP & networking tools..."
sudo apt install -y \
    sngrep \
    sipgrep \
    tcpdump \
    tshark \
    ngrep \
    socat \
    iperf3 \
    nmap \
    iproute2 \
    netcat-openbsd \
    dnsutils \
    traceroute \
    iputils-ping \
    whois \
    lsof \
    arping \
    iftop

echo ">>> Adding SIP/RTP aliases..."
{
    echo "alias cap-sip='sudo tshark -i any -f \"udp port 5060\"'"
    echo "alias cap-rtp='sudo tshark -i any -f \"udp portrange 10000-20000\"'"
    echo "alias siplog='journalctl -u asterisk -f | grep SIP'"
} >> ~/.bashrc

echo ">>> Done! Run 'source ~/.bashrc' to load aliases."

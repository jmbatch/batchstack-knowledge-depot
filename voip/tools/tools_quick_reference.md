# SDNE Tools — Quick Reference Cheatsheet

## SIP / VoIP Tools

### SIPp (traffic generator)

* **Quick OPTIONS probe (built‑in scenario):**

  ```bash
  sipp <DEST_IP>:<PORT> -sn options -s <EXT_OR_USER> -r 1 -m 1 -trace_err -trace_msg
  ```
* **Basic INVITE call (UAC built‑in):**

  ```bash
  sipp <DEST_IP>:<PORT> -sn uac -s <DEST_NUMBER> -r 1 -m 1 -trace_err
  ```
* **TLS (if server supports it):**

  ```bash
  sipp <DEST_IP>:<TLS_PORT> -tls -sn options -s <EXT>
  ```
* **Custom scenario file:**

  ```bash
  sipp <DEST_IP>:<PORT> -sf ./myscenario.xml -m 10 -l 5 -r 2 -rp 1000
  # -m max calls • -l concurrent calls • -r calls/sec • -rp rate period (ms)
  ```
* **Bind to local IP/port:**

  ```bash
  sipp <DEST_IP>:<PORT> -i <LOCAL_IP> -p <LOCAL_PORT> -sn options
  ```

### sngrep (ladder view of SIP)

* **Live capture any interface:**

  ```bash
  sudo sngrep -d any
  ```
* **Filter by host/port:**

  ```bash
  sudo sngrep -d any "host <IP> or port 5060"
  ```
* **Open a PCAP:**

  ```bash
  sngrep -I capture.pcap
  ```
* **Save selected calls (F8 in UI) or export to PCAP/ASCII.**

### SIPVicious (svmap et al.)

* **OPTIONS sweep against a target:**

  ```bash
  svmap udp://<DEST_IP>:5060 --method OPTIONS
  ```
* **TCP example:**

  ```bash
  svmap tcp://<DEST_IP>:5060 --method OPTIONS
  ```

  *Great for health checks; not a full UA.*

---

## Packet Capture & Analysis

### tcpdump

* **SIP + RTP to file:**

  ```bash
  sudo tcpdump -i any -w sip_rtp.pcap '(port 5060) or (udp portrange 10000-20000)'
  ```
* **Readable SIP (no write):**

  ```bash
  sudo tcpdump -i any -nn -s0 -A 'udp port 5060'
  ```

### tshark (Wireshark CLI)

* **See SIP requests/responses with endpoints:**

  ```bash
  tshark -i any -f 'port 5060' -Y 'sip' \
    -T fields -e frame.time -e ip.src -e udp.srcport -e ip.dst -e udp.dstport \
    -e sip.Method -e sip.Status-Code
  ```
* **Extract only RTP from a capture:**

  ```bash
  tshark -r sip_rtp.pcap -Y rtp -T fields -e ip.src -e udp.srcport -e rtp.ssrc -e rtp.seq -e rtp.marker
  ```

### ngrep (quick SIP grep)

```bash
sudo ngrep -W byline -d any -q '^(INVITE|OPTIONS|REGISTER|BYE|ACK|CANCEL)' udp and port 5060
```

---

## Network Diagnostics

### iperf3 (throughput)

```bash
# Server
iperf3 -s
# Client (TCP)
iperf3 -c <SERVER_IP>
# Client (UDP, 20 Mbit/s)
iperf3 -u -b 20M -c <SERVER_IP>
```

### mtr / traceroute

```bash
mtr -rw <HOST_OR_IP>      # real-time path + loss
traceroute <HOST_OR_IP>
```

### nmap (SIP scripts)

```bash
sudo nmap -sU -p 5060 --script sip-methods <TARGET>
sudo nmap -sU -p 5060 --script sip-enum-users --script-args 'sip-enum-users.guess=true' <TARGET>
```

### ncat / socat (craft & send)

* **Send a raw SIP OPTIONS (UDP) with ncat:**

  ```bash
  {
    echo "OPTIONS sip:<DEST_IP> SIP/2.0";
    echo "Via: SIP/2.0/UDP <LOCAL_IP>:<LOCAL_PORT>;branch=z9hG4bK-$(date +%s)";
    echo "Max-Forwards: 70";
    echo "To: <sip:<DEST_IP>>";
    echo "From: <sip:probe@client.local>;tag=$(date +%s)";
    echo "Call-ID: $RANDOM$RANDOM@client";
    echo "CSeq: 1 OPTIONS";
    echo "Contact: <sip:probe@<LOCAL_IP>:<LOCAL_PORT>>";
    echo "Content-Length: 0"; echo;
  } | ncat -u <DEST_IP> 5060
  ```
* **TCP with socat:**

  ```bash
  socat - TCP:<DEST_IP>:5060 <<'EOF'
  OPTIONS sip:<DEST_IP> SIP/2.0
  Via: SIP/2.0/TCP <LOCAL_IP>:<LOCAL_PORT>;branch=z9hG4bK-123
  Max-Forwards: 70
  To: <sip:<DEST_IP>>
  From: <sip:probe@client.local>;tag=abc
  Call-ID: test-123@client
  CSeq: 1 OPTIONS
  Contact: <sip:probe@<LOCAL_IP>:<LOCAL_PORT>>
  Content-Length: 0

  EOF
  ```

---

## System & Disk

### htop / btop (process + resource monitors)

```bash
htop        # classic
btop        # pretty, mouse-friendly
```

### ncdu (disk usage by dir)

```bash
sudo ncdu /var   # browse heavy directories
```

---

## Dev CLIs & Text Tools

### httpie (HTTP client)

```bash
http GET https://api.example.com/v1/ping
http POST https://api.example.com/v1/items name=foo enabled:=true
```

### jq (JSON query)

```bash
jq '.items[] | {id, name, enabled}' data.json
```

### ripgrep / fd / bat / fzf

```bash
rg -n "Contact:"         # recursive search with line numbers
fd "*.pcap"              # fast find files by glob
bat -p file.json          # pretty-print with syntax highlight
history | fzf             # fuzzy-pick a recent command
```

### tmux (multiplexer)

```bash
tmux new -s voip
# keys: Ctrl-b c (new window) | % (split vert) | " (split horiz) | d (detach) | [ (copy mode)
```

### git (sane defaults)

```bash
git init
git remote add origin <URL>
git add -A && git commit -m "init"
git push -u origin main
```

### pre-commit (lint before commit)

```bash
pre-commit install
pre-commit run --all-files
```

---

## IP/Routes/DNS Quick Checks

```bash
ip -br a               # brief addresses by interface
ip route                # routing table
ss -tunap | rg 5060    # sockets touching 5060
resolvectl status || cat /etc/resolv.conf
```

---

## Optional: pjsua (if you built it)

```bash
pjsua --id sip:me@client --registrar sip:<REGISTRAR_IP> \
      --realm * --username <USER> --password <PASS>
# Or quick call:
pjsua sip:<DEST_IP>
```

---

### Notes

* Many commands require `sudo` for raw sockets or capture.
* In WSL, add your user to `wireshark` group to capture without sudo (then restart shell).
* For TLS scenarios (SIP over TLS), ensure certs/ciphers are accepted by the target and your tool (SIPp) is built with OpenSSL support.

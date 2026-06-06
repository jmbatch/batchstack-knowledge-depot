# Module 2 Lab — Basic TLS Auth with OpenSSL `s_server` / `s_client` (Self‑Signed)

Below is a complete hands-on lab (objectives, steps, expected outputs, and mini-challenges). I’ll keep it **OpenSSL‑CLI centric** and instrumented so you can *see* what TLS is doing.

> Grounding: The commands and flags referenced below are based on OpenSSL’s official `s_server` and `s_client` documentation (options like `-accept`, `-cert`, `-key`, `-www`, `-msg`, `-state`, `-trace`, `-showcerts`, `-servername`, `-cipher`, `-ciphersuites`, etc.).
> The self-signed certificate one-liner used here is also shown in a practical example using `openssl req -x509 -newkey rsa:2048 ... -nodes`. [\[docs.openssl.org\]](https://docs.openssl.org/master/man1/openssl-s_server/), [\[docs.openssl.org\]](https://docs.openssl.org/master/man1/openssl-s_client/) [\[serverfault.com\]](https://serverfault.com/questions/1158935/how-to-use-openssl-s-server)

---

## 1) Objective (what you will prove)

By the end of this module you will be able to:

1. Generate a **self-signed** TLS server certificate and key (leaf cert is its own issuer). [\[serverfault.com\]](https://serverfault.com/questions/1158935/how-to-use-openssl-s-server)

2. Start a toy TLS server with OpenSSL and serve a simple status page. (`s_server -accept … -cert … -key … -www`) [\[docs.openssl.org\]](https://docs.openssl.org/master/man1/openssl-s_server/), [\[linux.die.net\]](https://linux.die.net/man/1/s_server)

3. Connect with OpenSSL as a TLS client and inspect:
    - negotiated **protocol version** and **cipher suite**
    - presented **certificate chain** (just the leaf in this module)
    - handshake message/flow visibility with `-msg`, `-state`, `-trace` [\[docs.openssl.org\]](https://docs.openssl.org/master/man1/openssl-s_client/), [\[docs.openssl.org\]](https://docs.openssl.org/master/man1/openssl-s_server/)

4. Experiment with constraining TLS versions and cipher selection using `s_client` / `s_server` options (e.g., protocol toggles, cipher lists). [\[docs.openssl.org\]](https://docs.openssl.org/master/man1/openssl-s_client/), [\[docs.openssl.org\]](https://docs.openssl.org/master/man1/openssl-s_server/)

---

## 2) Topology / Setup

**Single machine** is enough:

- “Server” terminal: runs `openssl s_server` listening on **localhost:4433** (OpenSSL default port if you omit `-accept` is 4433; we’ll be explicit). [\[linux.die.net\]](https://linux.die.net/man/1/s_server)
- “Client” terminal: runs `openssl s_client` connecting to **localhost:4433**. [\[docs.openssl.org\]](https://docs.openssl.org/master/man1/openssl-s_client/)

Create a workspace:

```bash
mkdir -p ~/tls-lab/module2 && cd ~/tls-lab/module2
```

---

## 3) Step A — Generate a self‑signed server cert + key

### Option A1 (fast one‑liner, good for this module)

This creates a new RSA key and a self-signed cert (valid 365 days) without encrypting the private key:

```bash
openssl req -x509 -newkey rsa:2048 -keyout key.pem -out cert.pem -days 365 -nodes
```

This exact pattern is used in a real-world `s_server` test setup example. [\[serverfault.com\]](https://serverfault.com/questions/1158935/how-to-use-openssl-s-server)

**What to note while you type values:**

- The cert will be **self-signed**, so clients won’t trust it by default (unless you explicitly trust it).
- CN/SAN hostname validation isn’t the main focus in Module 2, but we’ll optionally explore it in challenges.

### Quick inspection (recommended)

Print the certificate to confirm subject/issuer (they’ll match for self-signed):

```bash
openssl x509 -in cert.pem -noout -text | head -n 40
```

(OpenSSL provides extensive X.509 tooling; the official docs include an `x509` manual entry.) [\[docs.openssl.org\]](https://docs.openssl.org/master/man7/x509/)

---

## 4) Step B — Start a TLS server with `openssl s_server`

Open a new terminal in the same directory and run:

```bash
openssl s_server -accept 4433 -cert cert.pem -key key.pem -www -state -msg
```

- `-accept` sets the listening port. [\[linux.die.net\]](https://linux.die.net/man/1/s_server), [\[docs.openssl.org\]](https://docs.openssl.org/master/man1/openssl-s_server/)
- `-cert` and `-key` provide the server identity. [\[linux.die.net\]](https://linux.die.net/man/1/s_server), [\[docs.openssl.org\]](https://docs.openssl.org/master/man1/openssl-s_server/)
- `-www` makes `s_server` respond with a simple status page (handy for a quick test). [\[linux.die.net\]](https://linux.die.net/man/1/s_server), [\[docs.openssl.org\]](https://docs.openssl.org/master/man1/openssl-s_server/)
- `-state` and `-msg` make the handshake observable (state transitions + protocol messages). [\[docs.openssl.org\]](https://docs.openssl.org/master/man1/openssl-s_server/), [\[docs.openssl.org\]](https://docs.openssl.org/master/man1/openssl-s_client/)

> Tip: You can swap `-msg` for `-trace` when you want even more verbose tracing; `-trace` is listed among `s_server` options. [\[docs.openssl.org\]](https://docs.openssl.org/master/man1/openssl-s_server/)

**Expected server-side behavior:**  
You should see the server start listening and then log handshake activity when the client connects.

---

## 5) Step C — Connect with `openssl s_client` and inspect the handshake

In a third terminal:

```bash
openssl s_client -connect localhost:4433 -showcerts -state -msg -servername localhost
```

- `-connect host:port` connects to the server. [\[docs.openssl.org\]](https://docs.openssl.org/master/man1/openssl-s_client/)
- `-showcerts` prints the certificates the server presented (here: primarily the leaf cert). [\[docs.openssl.org\]](https://docs.openssl.org/master/man1/openssl-s_client/)
- `-state` and `-msg` show connection state transitions and handshake messages. [\[docs.openssl.org\]](https://docs.openssl.org/master/man1/openssl-s_client/)
- `-servername` sets SNI in ClientHello. [\[docs.openssl.org\]](https://docs.openssl.org/master/man1/openssl-s_client/)

**Expected client-side highlights:**

- You should see negotiated **Protocol** and **Cipher** values in the output.
- You will likely see a **verification error** (because the cert is self-signed and not trusted by your system trust store). That’s normal for this module.

---

## 6) Step D — Make it “basic TLS authentication” (trusting the self-signed cert)

Right now, `s_client` can’t validate your self-signed cert unless you tell it to trust it.

Use the server cert as a trust anchor **for this lab run**:

```bash
openssl s_client -connect localhost:4433 -showcerts -servername localhost -CAfile cert.pem
```

OpenSSL `s_client` supports `-CAfile` for trusted cert input. [\[docs.openssl.org\]](https://docs.openssl.org/master/man1/openssl-s_client/)

**Expected difference:**  
You should see verification succeed (i.e., the chain builds to the trusted material you supplied).

---

## 7) Step E — Cipher suites & protocol version experiments (core learning)

### E1) Force TLS 1.2 vs TLS 1.3 from the client

`openssl s_client` offers protocol toggles such as `-tls1_2` and `-tls1_3`. [\[docs.openssl.org\]](https://docs.openssl.org/master/man1/openssl-s_client/)

Try TLS 1.2:

```bash
openssl s_client -connect localhost:4433 -tls1_2 -servername localhost -CAfile cert.pem
```

Then TLS 1.3:

```bash
openssl s_client -connect localhost:4433 -tls1_3 -servername localhost -CAfile cert.pem
```

Compare:

- negotiated protocol
- cipher naming (TLS 1.3 cipher suite names typically look different from TLS 1.2)

### E2) Constrain cipher selection from the client

`s_client` includes options to specify ciphers (TLS ≤1.2 uses `-cipher`; TLS 1.3 uses `-ciphersuites`). Both options appear in the `s_client` option list. [\[docs.openssl.org\]](https://docs.openssl.org/master/man1/openssl-s_client/)

Example patterns to explore (pick ones your build supports):

```bash
# TLS 1.2-style cipher selection
openssl s_client -connect localhost:4433 -tls1_2 -cipher 'ECDHE+AESGCM' -servername localhost -CAfile cert.pem

# TLS 1.3-style cipher suite selection
openssl s_client -connect localhost:4433 -tls1_3 -ciphersuites 'TLS_AES_128_GCM_SHA256' -servername localhost -CAfile cert.pem
```

### E3) Client vs server cipher preference

By default, cipher negotiation depends on client/server behavior. OpenSSL `s_server` supports `-serverpref`.
A well-known explanation: `-serverpref` activates server cipher preference behavior (via `SSL_OP_CIPHER_SERVER_PREFERENCE`). [\[docs.openssl.org\]](https://docs.openssl.org/master/man1/openssl-s_server/) [\[stackoverflow.com\]](https://stackoverflow.com/questions/2113009/openssl-server-cipher-selection)

Restart the server with:

```bash
openssl s_server -accept 4433 -cert cert.pem -key key.pem -www -serverpref
```

Then connect again with a client cipher list (TLS 1.2 is usually the easiest place to see preference effects).

---

## 8) Observability upgrade (optional but powerful): key logging

Both `s_client` and `s_server` list a `-keylogfile` option. [\[docs.openssl.org\]](https://docs.openssl.org/master/man1/openssl-s_client/), [\[docs.openssl.org\]](https://docs.openssl.org/master/man1/openssl-s_server/)

Example:

```bash
openssl s_client -connect localhost:4433 -servername localhost -CAfile cert.pem -keylogfile keys.log
```

This is useful if later you want to decrypt captures in a packet analyzer (not required in Module 2, but it’s a strong debugging technique). The `-keylogfile` option is explicitly present in the official option list. [\[docs.openssl.org\]](https://docs.openssl.org/master/man1/openssl-s_client/)

---

## 9) Checkpoints (how you know you succeeded)

✅ **Checkpoint 1:** Server starts and listens on 4433 with your cert/key. (`s_server -accept … -cert … -key …`)
✅ **Checkpoint 2:** Client connects and you see handshake output with `-state`/`-msg`.
✅ **Checkpoint 3:** Client prints server certificate(s) with `-showcerts`.
✅ **Checkpoint 4:** Verification succeeds when you add `-CAfile cert.pem`.
✅ **Checkpoint 5:** You can force TLS 1.2 vs 1.3 and observe changes. [\[linux.die.net\]](https://linux.die.net/man/1/s_server), [\[docs.openssl.org\]](https://docs.openssl.org/master/man1/openssl-s_server/) [\[docs.openssl.org\]](https://docs.openssl.org/master/man1/openssl-s_client/), [\[docs.openssl.org\]](https://docs.openssl.org/master/man1/openssl-s_server/) [\[docs.openssl.org\]](https://docs.openssl.org/master/man1/openssl-s_client/)

---

## 10) Mini‑Challenges (recommended sequence)

1. **Break trust intentionally:** connect *without* `-CAfile` and note the verify failure vs success with `-CAfile`. [\[docs.openssl.org\]](https://docs.openssl.org/master/man1/openssl-s_client/)
2. **Protocol mismatch:** start server allowing only one protocol (explore server flags like `-no_tls1_3` etc. listed in `s_server` options) and see client failures/success. [\[docs.openssl.org\]](https://docs.openssl.org/master/man1/openssl-s_server/)
3. **Cipher mismatch:** constrain client to a narrow cipher list and observe handshake failure if there’s no overlap. (`-cipher` / `-ciphersuites`) [\[docs.openssl.org\]](https://docs.openssl.org/master/man1/openssl-s_client/)
4. **Preference effect:** compare outcomes with and without `-serverpref` (TLS 1.2 is best for this exercise). [\[docs.openssl.org\]](https://docs.openssl.org/master/man1/openssl-s_server/), [\[stackoverflow.com\]](https://stackoverflow.com/questions/2113009/openssl-server-cipher-selection)

---

## One quick follow-up (so I tailor the next module perfectly)

Are you running this on **Linux/macOS** or **Windows**? (It changes only a couple of small details like file paths and shell behavior — the OpenSSL flags stay the same.)

When you reply, I can also add a tight “Expected Output Guide” (what exact lines to look for: protocol, cipher, verify return, certificate subject/issuer) based on your platform’s typical OpenSSL output.

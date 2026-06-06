# SSL/TLS + X.509/PKI & OpenSSL features

## Hands-On Curriculum Syllabus: “TLS/SSL & PKI with OpenSSL (Labs-First)”

### Audience & Assumptions

- Comfortable with terminal basics and networking (ports, sockets, DNS names).
- Some familiarity with public/private keys is helpful but not required.
- Labs are designed to run locally (single machine) or on two VMs/containers.

### Course Outcomes (by the end)

You will be able to:

- Explain TLS handshakes (TLS 1.2 vs 1.3) and negotiate **protocols/ciphers/groups/sigalgs** using OpenSSL tooling.
- Build and validate certificate chains (root → intermediate → leaf), including **mTLS**.
- Operate a lab CA with issuance and **revocation** (CRLs; optional OCSP).
- Diagnose real-world failures: name mismatch, missing intermediates, path building quirks, trust store issues, and chain selection (including **cross-signing**).

---

## Module 0 — Lab & Tooling Setup (Foundation)

Goal

Establish a repeatable lab environment and baseline observability.

Key concepts

- PEM vs DER vs PKCS#12, trust stores, “leaf vs chain vs root”
- What OpenSSL can show you during connection setup (state machine, messages, extensions)

## Primary OpenSSL features

- `openssl version`, `openssl help`, config awareness
- `openssl s_client` diagnostic capabilities (e.g., `-trace`, `-msg`, `-state`, `-showcerts`, `-keylogfile`) [\[docs.openssl.org\]](https://docs.openssl.org/master/man1/openssl-s_client/)

Artifacts

- A working lab directory layout
- A “connection capture” workflow plan (console logs + optional packet capture + key logging)

---

## Module 1 — Crypto & Certificate Primitives (Keys → CSRs → Certs)

### Goal: Get fluent with the building blocks before doing TLS

### Key concepts (Module 1)

- Asymmetric keys (RSA/ECDSA), hashing, signatures
- CSRs, certificate fields, and X.509 extensions (SAN, KU, EKU, Basic Constraints)

### OpenSSL focus

- Key and cert inspection (`x509`, `pkey`, `asn1parse`), conversion (`pkcs12`), and verification mindset

### Artifacts

- A set of keys (RSA + EC), CSRs, and leaf certs (self-signed for now)
- A “cheat sheet” mapping common fields/extensions to their meanings

---

## Module 2 — Scenario 1: “Hello TLS” with `s_server` + `s_client` (Self-Signed)

### Goal: Establish a basic TLS connection and observe negotiation + handshake mechanics

### Key concepts (Module 2)

- Server authentication basics, what “self-signed” really implies
- TLS transcript visibility: handshake phases, extensions, negotiated parameters

### OpenSSL focus (Module 2)

- `openssl s_client` as a generic TLS client and diagnostic tool [\[docs.openssl.org\]](https://docs.openssl.org/master/man1/openssl-s_client/)
- Learn to read: negotiated protocol, cipher, peer cert, verification results

### Artifacts (Module 2)

- A working “toy server” + “toy client” connection
- A short write-up: what you saw in `-state`/`-msg`/`-trace` outputs [\[docs.openssl.org\]](https://docs.openssl.org/master/man1/openssl-s_client/)

---

## Module 3 — Cipher Suites, Groups, and TLS 1.2 vs 1.3 Negotiation

### Goal:  Understand “cipher suite” selection and what changes in TLS 1.3

### Key concepts

- TLS 1.2 cipher suites bundle more (key exchange/auth/encryption/MAC) than TLS 1.3
- Curves/groups, signature algorithms, forward secrecy, AEAD

### OpenSSL focus (Module 3)

- Constraining/observing negotiation via `s_client` knobs (TLS versions, ciphers, 1.3 ciphersuites, groups, sigalgs) [\[docs.openssl.org\]](https://docs.openssl.org/master/man1/openssl-s_client/)
- Learn how to interpret the negotiated result and why it chose that

### Artifacts (Module 3)

- A comparison matrix: TLS 1.2 vs TLS 1.3 negotiation outcomes
- A set of “known-good” and “intentional-fail” negotiation attempts

---

## Module 4 — Scenario 2: Your Own Root CA (Single-Tier) + Server Authentication

### Goal:  Replace self-signed leaf certs with a CA-issued cert chain and validate it

### Key concepts (Module 4)

- Trust anchors, chain-of-trust, why clients reject unknown roots
- Chain building vs chain validation, “missing intermediate” class of failures

### OpenSSL focus (Module 4)

- Use `openssl ca` concepts for signing requests in a CA-like workflow [\[docs.openssl.org\]](https://docs.openssl.org/master/man1/openssl-ca/)
- Validate with `openssl verify` (trusted vs untrusted inputs) [\[docs.openssl.org\]](https://docs.openssl.org/3.0/man1/openssl-verify/)
- Understand `-untrusted` for intermediates and common pitfalls [\[stackoverflow.com\]](https://stackoverflow.com/questions/25482199/verify-a-certificate-chain-using-openssl-verify), [\[docs.openssl.org\]](https://docs.openssl.org/3.0/man1/openssl-verify/)

### Artifacts (Module 4)

- Root CA key+cert, issued server cert, and a working server-auth TLS connection
- A troubleshooting note: what happens if the server doesn’t present a full chain

---

## Module 5 — Scenario 2b: Mutual TLS (mTLS) with Client Certificates

### Goal:  Add client authentication and understand identity on both sides

### Key concepts (Module 5)

- mTLS flows, client certificate requests, identity mapping
- EKU differences: `serverAuth` vs `clientAuth`

### OpenSSL focus (Module 5)

- `s_client` options for presenting a client cert/key and controlling verification [\[docs.openssl.org\]](https://docs.openssl.org/master/man1/openssl-s_client/)
- Interpreting verification output and common handshake failures

### Artifacts (Module 5)

- CA-issued client cert(s)
- A working mTLS handshake + a “failed handshake gallery” (wrong EKU, wrong CA, missing chain)

---

## Module 6 — Scenario 3: Build a Real Lab CA (Root + Intermediate + Profiles)

### Goal:  Create a more realistic CA hierarchy and policy controls

### Key concepts (Module 6)

- Offline root vs online intermediate, pathlen constraints
- CA database/issuance tracking, serials, certificate profiles

### OpenSSL focus (Module 6)

- `openssl ca` as a “minimal CA application” that signs CSRs and maintains issuance state [\[docs.openssl.org\]](https://docs.openssl.org/master/man1/openssl-ca/)
- Certificate profiles via config sections (server vs client profiles)

### Artifacts (Module 6)

- Root CA + Intermediate CA
- Separate issuance profiles (server/client), and a documented CA directory structure and policy

---

## Module 7 — Revocation in Practice (CRLs; optional OCSP)

## Goal:  Issue, revoke, and enforce revocation checking in verification and clients

### Key concepts (Module 7)

- Revocation reasons, CRL lifecycle, CDP extension conceptually
- What clients actually check (and what they often don’t)

### OpenSSL focus (Module 7)

- Generate CRLs (`-gencrl`), revoke certs (`-revoke`), and track status in CA DB [\[docs.openssl.org\]](https://docs.openssl.org/master/man1/openssl-ca/)
- Enforce CRL checks during validation (`verify` with CRL-related options) [\[docs.openssl.org\]](https://docs.openssl.org/3.0/man1/openssl-verify/)

### Artifacts (Module 7)

- A revoked leaf cert + CRL
- Demonstration evidence that “was valid → now revoked” changes verification outcome

---

## Module 8 — Chain Building & Debugging Mastery (Verification Deep Dive)

### Goal:  Become dangerous (in a good way) at diagnosing chain/trust issues

### Key concepts (Module 8)

- Differences among: “trusted store,” “untrusted chain,” “presented chain”
- Alternate chains, partial chains, strict mode, hostname verification

### OpenSSL focus (Module 8)

- `openssl verify` chain-building controls like `-trusted`, `-untrusted`, `-show_chain`, and stricter checks [\[docs.openssl.org\]](https://docs.openssl.org/3.0/man1/openssl-verify/)
- `s_client` chain visibility (`-showcerts`) and verification controls [\[docs.openssl.org\]](https://docs.openssl.org/master/man1/openssl-s_client/)

### Artifacts (Module 8)

- A set of curated broken scenarios: missing intermediate, wrong trust anchor, expired, name mismatch
- A “triage worksheet” that maps symptoms → likely causes → OpenSSL evidence

---

## Module 9 — Scenario 4: Cross-Signed Intermediates & Alternate Trust Roots

## Goal:  Reproduce the “server and client trust different roots” reality (cross-signing)

### Key concepts (Module 9)

- Cross-signing vs bridging; alternate chain selection behavior
- Why chain building might succeed or fail depending on what’s trusted and what’s presented

### OpenSSL focus (Module 9)

- Build chains with “trusted vs untrusted” separation and inspect the resulting built chain [\[docs.openssl.org\]](https://docs.openssl.org/3.0/man1/openssl-verify/)
- Use `s_client` chain-building behaviors (e.g., `-build_chain`) to experiment with path construction [\[docs.openssl.org\]](https://docs.openssl.org/master/man1/openssl-s_client/)

### Artifacts (Module 9)

- Two roots (Root A, Root B), one intermediate with cross-signing, leaf cert(s)
- Proof of: “Client trusting Root A succeeds, client trusting Root B succeeds, but with different paths”

---

## Module 10 — TLS Observability: Messages, Sessions, and Decryption Workflows

### Goal:  See TLS as a system: handshake messages, resumption, and practical debugging

### Key concepts (Module 10)

- Session resumption (IDs/tickets conceptually), why it changes behavior
- Capturing evidence for root-cause: handshake trace + cert chain + verification output

### OpenSSL focus (Module 10)

- Persisting session state across connections (`-sess_out`, `-sess_in`) [\[feistyduck.com\]](https://www.feistyduck.com/library/openssl-cookbook/online/testing-with-openssl/keeping-session-state.html)
- Key logging for TLS traffic inspection (`s_client -keylogfile`) [\[docs.openssl.org\]](https://docs.openssl.org/master/man1/openssl-s_client/), [\[blog.blackair.io\]](https://blog.blackair.io/analyzing-tls-encrypted-traffic-through-sslkeylogfile/)

### Artifacts (Module 10)

- A repeatable “debug bundle”: command output + chain dumps + session artifacts
- A short report: initial handshake vs resumed handshake differences (as observed)

---

## Module 11 — Capstone: Build a Mini-PKI + Secure Service Lifecycle

### Goal:  Combine everything into a realistic workflow

### Capstone deliverables

- Root + intermediate CA hierarchy
- Issuance profiles for server/client, mTLS service, and revocation evidence
- A “runbook” that includes: issuance, renewal/rotation concepts, validation steps, and troubleshooting playbook

### Evidence expectations

- Demonstrate working cases plus at least 5 failure modes with clear diagnostics output trails

---

## Suggested Reference Spine (Optional Reading / Anchors)

- `openssl s_client` official documentation (options, diagnostics, chain display, key logging) [\[docs.openssl.org\]](https://docs.openssl.org/master/man1/openssl-s_client/)
- `openssl ca` official documentation (signing, CRLs, CA-style workflow) [\[docs.openssl.org\]](https://docs.openssl.org/master/man1/openssl-ca/)
- `openssl verify` official documentation (chain building, trusted vs untrusted, show built chain) [\[docs.openssl.org\]](https://docs.openssl.org/3.0/man1/openssl-verify/)
- Session state persistence examples (`-sess_out` / `-sess_in`) [\[feistyduck.com\]](https://www.feistyduck.com/library/openssl-cookbook/online/testing-with-openssl/keeping-session-state.html)
- Key log file usage via `s_client -keylogfile` for TLS decryption workflows [\[docs.openssl.org\]](https://docs.openssl.org/master/man1/openssl-s_client/), [\[blog.blackair.io\]](https://blog.blackair.io/analyzing-tls-encrypted-traffic-through-sslkeylogfile/)

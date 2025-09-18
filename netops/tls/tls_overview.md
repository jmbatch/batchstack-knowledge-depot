# TLS Overview

## 1. Core Concepts

### Keys

- `Private Key`: Secret, never shared. used to decrypt and sign.
- `Public Key`: Derived from the private key. Shared openly. Used to encrypt and verify signatures.

### Certificates

A certificate is essentially a public key + metadata
    - organization
    - hostname
    - expiration date
    - digitally signed by a Certificate Authority (CA)

The private key is separate and lever leaves your control.

### Certificate Chain of Trust

- `Root CA`: top-level trusted authority like Digicert, Let's Encrypt
- `Intermediate CA`: issued by a root to spread trust without exposing the root key directly.
- `Server Certificate`: what the server uses
- The system validates `Server cert -> Intermediate(s) -> Root CA`

## 2. TLS Handshake

1. Client Hello
   - Client proposes supported TLS versions, ciphers, random nonce

2. Server Hello
   - Server chooses version/cipher, sends back its certificate

3. Certificate Verification
   - Client checks the cert chain against trusted root store

4. Key Exchange
   - Modern TLS: uses ECDHE (Ephemeral Diffie-Hellman) to agree on a shared secret
   - Pre-TLS 1.3: could use RSA directly

5. Session Keys Established
   - Both sides derive symmetric keys (fast AES or ChaCha20)

6. Encrypted Traffic
   - From here, all communication is encrypted with the symmetric keys

## 3. OpenSSL Basics / Cheatsheet

Generate a Private Key

```bash
openssl genrsa -out server.key 2048
```

Create a Certificate Signing Request (CSR)

```bash
openssl req -new -key server.key -out server.csr
```

Generate a Self-Signed Certificate

```bash
openssl req -x509 -new -nodes -key server.key -sha256 -days 365 -out server.crt
```

Inspect a Certificate

```bash
openssl x509 -in server.crt -text -noout
```

Test a TLS Connection

```bash
openssl s_client -connect example.com 443
```

Verify a chain

```bash
openssl verify -CAfile ca-chain.crt server.crt
```

## 4. Practical Exercise (local lab)

You can simulate the full cert lifecycle locally:

1. Create a Root CA (self-signed)

    ```bash
    openssl genrsa -out rootCA.key 4096
    openssl req -x509 -new -nodes -key rootCA.key -sha256 -days 1024 -out rootCA.crt
    ```

2. Create an intermediate CA

    ```bash
    openssl genrsa -out intermediate.key 4096
    openssl req -new -key intermediate.key -out intermediate.csr
    openssl x509 -req -in intermediate.csr -CA rootCA.crt -CAkey rootCA.key -CAcreateserial \
        -out intermediate.crt -days 365 -sha256
    ```

3. Issue a Server Certification (signed by intermediate)

    ```bash
    openssl genrsa -out server.key 2048
    openssl req -new -key server.key -out server.csr
    openssl x509 -req -in server.csr -CA intermediate.crt -CAkey intermediate.key -CAcreateserial \
        -out server.crt -days 365 -sha256
    ```

4. Bundle the Chain

    ```bash
    cat server.crt intermediate.crt > fullchain.crt
    ```

5. Verify the chain

    ```bash
    openssl verify -CAfile rootCA.crt fullchain.crt
    ```

6. Test with a Local Server

    ```bash
    # Run a test TLS server
    openssl s_server -key server.key -cert fullchain.crt -port 8443

    # Connect as client
    openssl s_client -connect localhost:8443 -CAfile rootCA.crt
    ```

## 5. What's been covered

- how roots and intermediates build trust
- how to use openssl for TLS
- how clients validate chains

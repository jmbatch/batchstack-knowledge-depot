# TLS in VoIP - SIP, SRTP/RTP Proxies

## 1. TLS usage in VoIP

- **Signaling Security**: SIP over TLS protects SIP messages from interception and tampering
- **Media Security**: Often combined with SRTP (Secure RTP) for encrypting voice streams, SRTP keys are exchanged either:
  - in SIP/SDP using SDES (insecure if not over TLS)
  - via DTLS-SRTP or ZRTP for end-to-end keying
- **Compliance**: Many providers mandate TLS + SRTP for things like HIPAA

## 2. TLS Certificates in the context of SIP

- **Common Name (CN) or Subject Alternative Name (SAN) must match the SIP domain
- Self-signed certs are common in lab/testing but for interop, publicly trusted CA is preferred
- SIP proxies often use intermediate chains
- Without the chain of trust, calls usually fail with `Certificate Unknown` or `Unknown CA`
- **Client certs**: Sometimes used for mutual TLS (MTLS) between SBCs

## 3. SIP-TLS Negotiation Flow

- **TLS Handshake**: Server presents cert -> client validates -> session key established
- **SIP REGISTER/INVITE** happens inside the TLS tunnel
- **SDP exchange** may include SRTP keying info
- **RTP proxy (rtpengine, mediaproxy, Asterisk RTP)** relays encrypted streams if SRTP is used.

## 4. Common TLS issues in VoIP

| Problem                | Cause                                                                                                  | Symptom                                        |
| ---------------------- | ------------------------------------------------------------------------------------------------------ | ---------------------------------------------- |
| ❌ Missing intermediate | Server cert not bundled with intermediate                                                              | Remote UA/SBC refuses TLS connection           |
| ❌ Expired cert         | Obvious, but easy to miss                                                                              | INVITE/REGISTER fails, TLS handshake errors    |
| ❌ Wrong CN/SAN         | CN is `server.local` but carrier expects `sip.carrier.com`                                             | TLS handshake aborts                           |
| ❌ Cipher mismatch      | Carrier only allows modern ciphers (TLS 1.2+ ECDHE), but your Asterisk/Kamailio is using outdated ones | “handshake failure”                            |
| ❌ Self-signed cert     | Fine in lab, but carriers won’t trust                                                                  | TLS session rejected unless you preload rootCA |
| ❌ MTLS not set         | Carrier expects client certificate for authentication                                                  | “unknown\_ca” or “certificate required”        |

## 5. OpenSSL Cheatsheet for SIP TLS Debugging

### Check SIP-TLS Connection

```bash
openssl s_client -connect sip.example.com:5061 -servername sip.example.com
```

- `-servername` is Server Name Indication (SNI) which is important if the server hosts multiple SIP domains
- Look for:
  - `Verify return code: 0 (ok)` = trust is valid
  - Cipher chosen (to check for mismatches)

### Test Specific Cipher

```bash
openssl s_client -connect sip.example.com:5061 -cipher ECDHE-RSA-AES256-GCM-SHA384
```

### Show cert chain from Remote SIP Server

```bash
openssl s_client -connect sip.example.com:5061 -showcerts
```

### Verify your own fullchain

```bash
openssl verify -CAfile rootCA.crt fullchain.crt
```

## 6. Practical Lab Exercise (SIP over TLS)

You can simulate SIP/TLS locally with SIPp + Kamailio + OpenSSL

1. Generate a test CA and server cert
2. Configure Kamailio

    ```cfg
    listen=tls:0.0.0:5061
    enable_tls=yes
    tls_verify_client=0
    tls_require_client_certificate=0
    tls_method=TLSv1.2
    ```

3. Set Kamailio TLS config (tls.cfg)

    ```ini
    [server:default]
    method = TLSv1.2
    verify_certificate = yes
    require_certificate = no
    private_key = /etc/kamailio/tls/server.key
    certificate = /etc/kamailio/tls/fullchain.crt
    ca_list = /etc/kamailio/tls/rootCA.crt
    ```

4. Test with SIPp

    ```bash
    sipp -tls -sf uac_register.xml -s 1001 -ap password sip.localdomain:5061
    ```

5. Debug with OpenSSL

    ```bash
    openssl s_client -connect sip.localdomain:5061 -CAfile rootCA.crt
    ```

## 7. What we've covered

- How VoIP software actually consumes certificates
- concept of the fullchain
- Reproducing exact TLS failures with OpenSSL
- How SRTP fits in with TLS

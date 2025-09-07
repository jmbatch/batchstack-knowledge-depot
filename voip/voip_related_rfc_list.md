# RFCs

## **1. SIP (Session Initiation Protocol) and Extensions**

### **Core SIP RFCs**

- **RFC 3261**: _SIP: Session Initiation Protocol_  
    Defines the core SIP protocol for initiating, modifying, and terminating multimedia sessions.

- **RFC 3262**: _Reliability of Provisional Responses in SIP (PRACK)_  
    Adds support for reliable provisional responses.

- **RFC 3263**: _SIP: Locating SIP Servers_  
    Mechanisms for discovering SIP servers using DNS.

- **RFC 3264**: _An Offer/Answer Model with SDP_  
    Describes the negotiation of media parameters in SIP sessions.

- **RFC 3265**: _SIP-Specific Event Notification (SUBSCRIBE/NOTIFY)_  
    Framework for event notifications in SIP.

### **SIP Extensions and Enhancements**

- **RFC 3311**: _The Session Initiation Protocol (SIP) UPDATE Method_  
    Enables updating session parameters before final response.

- **RFC 3323**: _A Privacy Mechanism for SIP_  
    Provides privacy protection for SIP users.

- **RFC 3325**: _Private Extensions to SIP for Asserted Identity within Trusted Networks (P-Asserted-Identity)_  
    Mechanism to assert caller identity in trusted networks.

- **RFC 3428**: _SIP Extension for Instant Messaging (MESSAGE Method)_  
    Adds support for instant messaging in SIP.

- **RFC 3856**: _A Presence Event Package for SIP_  
    Defines presence signaling for SIP users.

- **RFC 3863**: _Presence Information Data Format (PIDF)_  
    Standard format for representing presence information.

- **RFC 4474**: _Enhancements for Authenticated Identity Management in SIP_  
    Provides identity assurance for SIP communications (superseded by STIR/SHAKEN).

- **RFC 5626**: _Managing Client-Initiated Connections in SIP (Outbound)_  
    Mechanism for NAT traversal and maintaining connections with SIP proxies.

- **RFC 6086**: _SIP INFO Method and Package Framework_  
    Clarifies the use of the INFO method in SIP.

- **RFC 6665**: _SIP-Specific Event Notification Framework_ (Updates RFC 3265)  
    Enhancements and clarifications for the event notification framework.

## **2. SDP (Session Description Protocol)**

- **RFC 4566**: _SDP: Session Description Protocol_  
    Defines the format for describing multimedia sessions in SIP and other protocols.

- **RFC 3264**: _An Offer/Answer Model with SDP_  
    Describes how SDP is used for negotiating media parameters.

- **RFC 3605**: _SDP Bandwidth Modifiers for RTCP_  
    Defines bandwidth modifiers for RTCP in SDP.

- **RFC 4572**: _SDP Extension for Establishing Secure Media Sessions with DTLS_  
    Defines the use of DTLS in SDP for secure communications.

## **3. RTP (Real-Time Transport Protocol) and Related RFCs**

### **Core RTP RFCs**

- **RFC 3550**: _RTP: A Transport Protocol for Real-Time Applications_  
    Defines the RTP protocol for delivering real-time audio and video.

- **RFC 3551**: _RTP Profile for Audio and Video Conferences with Minimal Control_  
    Specifies default payload types for audio and video codecs.

### **RTP Extensions and Enhancements**

- **RFC 4585**: _Extended RTP Profile for RTCP-Based Feedback (RTP/AVPF)_  
    Defines feedback mechanisms for RTP.

- **RFC 3711**: _The Secure Real-Time Transport Protocol (SRTP)_  
    Adds encryption, message authentication, and integrity to RTP.

- **RFC 3556**: _Session Description Protocol (SDP) Bandwidth Modifiers for RTP Control Protocol (RTCP)_  
    Defines modifiers to control RTCP bandwidth.

- **RFC 4733**: _RTP Payload for DTMF Digits, Telephony Tones, and Telephony Signals_  
    Defines how to send DTMF digits and tones over RTP.

- **RFC 6184**: _RTP Payload Format for H.264 Video_  
    Describes the RTP payload format for H.264 video streams.

- **RFC 7656**: _RTP Topologies_  
    Describes different RTP topologies for multimedia conferences.

## **4. RTCP (Real-Time Control Protocol)**

- **RFC 3550**: _RTP and RTCP_ (Core RTCP functionality included in RTP RFC)  
    Defines RTCP for providing quality of service feedback.

- **RFC 3556**: _SDP Bandwidth Modifiers for RTCP_  
    Defines modifiers for RTCP bandwidth control.

- **RFC 4585**: _Extended RTP Profile for RTCP-Based Feedback (RTP/AVPF)_  
    Enhancements to RTCP feedback mechanisms.

## **5. NAT Traversal for VoIP**

- **RFC 5389**: _Session Traversal Utilities for NAT (STUN)_  
    Mechanism for discovering public IP and port mappings.

- **RFC 5766**: _Traversal Using Relays around NAT (TURN)_  
    Defines the use of relay servers to traverse NATs.

- **RFC 8445**: _Interactive Connectivity Establishment (ICE)_  
    Framework for NAT traversal using STUN and TURN.

## **6. VoIP Security and Authentication**

- **RFC 4474**: _SIP Identity_ (Deprecated by STIR)  
    Provides identity assurance in SIP communications.

- **RFC 8224**: _Authenticated Identity Management in SIP (STIR)_  
    Part of the STIR framework for preventing caller ID spoofing.

- **RFC 8588**: _Personal Assertion Token (PASSporT)_  
    Standard for securely conveying caller identity.

- **RFC 9116**: _SHAKEN: Secure Handling of Asserted Information using toKENs_  
    Complements STIR for combatting robocalls and caller ID spoofing.

## **7. Fax Over IP (FoIP)**

- **RFC 3265**: _SIP Event Notification_ (Used in fax signaling).
- **RFC 6913**: _Indicating Fax over IP Capability in SIP_.

## **8. Telephony-Related Protocols**

- **RFC 3435**: _Media Gateway Control Protocol (MGCP) Version 1.0_  
    Protocol for controlling media gateways in VoIP systems.

- **RFC 3389**: _RTP Payload for Comfort Noise_  
    Describes comfort noise generation in VoIP calls.

## **9. Presence and Instant Messaging**

- **RFC 3863**: _Presence Information Data Format (PIDF)_.
- **RFC 3856**: _Presence Event Package for SIP_.
- **RFC 3428**: _SIP Extension for Instant Messaging_.

## **10. Quality of Service (QoS)**

- **RFC 4594**: _Configuration Guidelines for DiffServ Service Classes_  
    Guidelines for implementing QoS in VoIP networks.

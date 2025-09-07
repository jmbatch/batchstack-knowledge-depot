# VoIP Learning Resources

## **1. Core VoIP Protocols and Technologies**

### **Practical Tools and Platforms**

1. **Wireshark for VoIP Analysis**

    - **Exercise**: Capture and analyze SIP, RTP, and SDP packets in a VoIP call.  
        **Guide**: Wireshark VoIP Analysis
2. **SIPp**

    - **Tool**: A free, open-source SIP traffic generator for testing SIP servers and clients.
    - **Exercise**: Create SIP call scenarios, load-test SIP servers, and analyze responses.  
        **Link**: [SIPp GitHub](https://github.com/SIPp/sipp)  
        **Tutorial**: Getting Started with SIPp
3. **sipsak**

    - **Tool**: Command-line SIP utility for testing SIP endpoints.
    - **Exercise**: Send SIP REGISTER, OPTIONS, or INVITE requests to SIP servers.  
        **Link**: [sipsak Project](https://github.com/nils-ohlmeier/sipsak)
4. **rtpengine**

    - **Tool**: Media proxy for handling RTP streams.
    - **Exercise**: Integrate `rtpengine` with OpenSIPS or Kamailio for RTP relaying and transcoding.  
        **Link**: [rtpengine](https://github.com/sipwise/rtpengine)

### **Lab Platforms**

1. **OpenSIPS and Kamailio Labs**

    - **Exercise**: Set up a SIP server using OpenSIPS or Kamailio, configure call routing, and implement NAT traversal.  
        **Link**: OpenSIPS Docs  
        **Link**: Kamailio Docs
2. **Asterisk PBX Lab**

    - **Exercise**: Deploy an Asterisk server, create dial plans, configure SIP trunks, and test with softphones.  
        **Link**: Asterisk Wiki  
        **Guide**: Asterisk Beginner's Guide
3. **FreeSWITCH Lab**

    - **Exercise**: Set up a FreeSWITCH server for advanced VoIP applications, including conferencing and call routing.  
        **Link**: FreeSWITCH Documentation
4. **Linphone**

    - **Tool**: Open-source SIP softphone for testing VoIP endpoints.  
        **Link**: [Linphone](https://www.linphone.org/)

---

## **2. VoIP Security**

### **Security Tools**

1. **SIPVicious**

    - **Tool**: A suite for scanning and auditing SIP servers.
    - **Exercise**: Detect vulnerabilities in your SIP setup by running SIP scans and brute-force attacks.  
        **Link**: [SIPVicious GitHub](https://github.com/EnableSecurity/sipvicious)
2. **VoIPong**

    - **Tool**: VoIP traffic sniffer and monitoring tool.  
        **Link**: VoIPong
3. **TLS and SRTP Configuration**

    - **Exercise**: Secure SIP signaling using TLS and encrypt RTP streams using SRTP.  
        **Guide**: Asterisk TLS/SRTP Setup

### **Security Challenges**

- **TryHackMe VoIP Labs**  
    Interactive security labs for VoIP penetration testing.  
    **Link**: [TryHackMe](https://tryhackme.com/)

- **Hack The Box VoIP Challenges**  
    Real-world VoIP security challenges.  
    **Link**: [Hack The Box](https://www.hackthebox.com/)

---

## **3. SIP Trunking and Call Routing**

### **Exercises**

1. **Set Up SIP Trunks with OpenSIPS**

    - **Exercise**: Configure SIP trunks for inbound and outbound call routing.  
        **Tutorial**: OpenSIPS Trunking Guide
2. **Kamailio Load Balancing**

    - **Exercise**: Implement load balancing and failover for SIP servers.  
        **Link**: Kamailio Load Balancer

---

## **4. STIR/SHAKEN (Caller ID Authentication)**

### **Practical Resources**

1. **STIR/SHAKEN with FreeSWITCH**

    - **Exercise**: Integrate STIR/SHAKEN to verify caller IDs on your VoIP network.  
        **Guide**: FreeSWITCH STIR/SHAKEN
2. **Asterisk Integration**

    - **Exercise**: Implement STIR/SHAKEN in Asterisk using OpenSSL tools.  
        **Tutorial**: Asterisk Caller ID Authentication

---

## **5. Books for VoIP Technologies**

1. **"Practical VoIP Security" by Thomas Porter**  
    Focuses on securing VoIP networks and understanding vulnerabilities.

2. **"Switching to VoIP" by Ted Wallingford**  
    Practical guide to deploying VoIP systems with real-world examples.

3. **"Asterisk: The Definitive Guide" by Jim Van Meggelen, Russell Bryant, and Leif Madsen**  
    Comprehensive resource for learning and mastering Asterisk PBX.

4. **"SIP: Understanding the Session Initiation Protocol" by Alan B. Johnston**  
    In-depth coverage of SIP and related protocols.

---

## **6. Online Courses and Tutorials**

1. **Udemy**

    - Courses on Asterisk, FreeSWITCH, SIP, and VoIP security.  
        **Link**: [Udemy VoIP Courses](https://www.udemy.com/)
2. **VoIP School on YouTube**

    - Video tutorials on VoIP concepts, tools, and configurations.  
        **Link**: [VoIP School Channel](https://www.youtube.com/c/VOIPSchool)
3. **Coursera**

    - Networking courses with VoIP modules.  
        **Link**: [Coursera Networking](https://www.coursera.org/)

---

## **7. VoIP Development and Scripting**

1. **Asterisk AGI (Asterisk Gateway Interface)**

    - **Exercise**: Write AGI scripts in Python to customize call handling.  
        **Link**: Asterisk AGI Guide
2. **Kamailio Scripting**

    - **Exercise**: Learn Kamailio’s configuration language to route and manage SIP calls.  
        **Link**: Kamailio Scripting Tutorial
3. **OpenSIPS Scripting**

    - **Exercise**: Create scripts to handle complex SIP routing logic.  
        **Link**: OpenSIPS Scripting Guide

---

## **8. Building a VoIP Lab Environment**

### **Tools and Platforms**

- **VirtualBox or VMware**

  - Set up virtual machines for OpenSIPS, Kamailio, Asterisk, and FreeSWITCH.

- **Cloud Platforms**

  - Deploy VoIP servers on **AWS**, **DigitalOcean**, or **Linode** for remote testing.
- **Softphones for Testing**

  - **Linphone**, **Zoiper**, **X-Lite**, and **MicroSIP** for placing test calls.

### **Lab Ideas**

1. **Multi-Tenant PBX System**

   - Deploy Asterisk or FreeSWITCH for multiple tenants and test call routing.

2. **Secure VoIP Deployment**

    - Configure TLS and SRTP for encrypted calls using OpenSIPS or Kamailio.

3. **Load Balancing and Failover**

    - Set up Kamailio with multiple Asterisk backends for redundancy.

## **9. Community and Forums**

- **VoIP-Info.org**

  - Extensive documentation and community forums.  
        **Link**: [VoIP-Info](https://www.voip-info.org/)
- **Asterisk Community Forum**  
    **Link**: Asterisk Forums

- **FreeSWITCH Community**  
    **Link**: [FreeSWITCH Slack](https://freeswitch.org/)

- **OpenSIPS and Kamailio Mailing Lists**
  - Active discussions and help from the community

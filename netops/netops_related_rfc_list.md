# NetOps Related RFCs

## **1. Core Internet Protocols**

### **IP (Internet Protocol)**

- **RFC 791**: _Internet Protocol (IPv4)_  
The foundational protocol for packet-switched internetworks.

- **RFC 8200**: _Internet Protocol, Version 6 (IPv6) Specification_  
Defines the structure of IPv6 packets and addressing.

### **ICMP (Internet Control Message Protocol)**

- **RFC 792**: _Internet Control Message Protocol (ICMPv4)_  
Used for diagnostic and error-reporting messages in IPv4.

- **RFC 4443**: _ICMP for IPv6 (ICMPv6)_  
Defines error messages and diagnostics for IPv6 networks.

### **ARP (Address Resolution Protocol)**

- **RFC 826**: _An Ethernet Address Resolution Protocol_  
Maps IP addresses to MAC addresses within a local network.

### **DHCP (Dynamic Host Configuration Protocol)**

- **RFC 2131**: _Dynamic Host Configuration Protocol (DHCP)_  
Automates the assignment of IP addresses to devices.

- **RFC 8415**: _Dynamic Host Configuration Protocol for IPv6 (DHCPv6)_  
DHCP for IPv6 networks.

---

## **2. Transport Layer Protocols**

### **TCP (Transmission Control Protocol)**

- **RFC 793**: _Transmission Control Protocol (TCP)_  
Reliable, connection-oriented transport protocol.

- **RFC 5681**: _TCP Congestion Control_  
Defines standard congestion control mechanisms.

- **RFC 9293**: _Transmission Control Protocol Specification_  
The most recent update to the core TCP specification.

### **UDP (User Datagram Protocol)**

- **RFC 768**: _User Datagram Protocol (UDP)_  
Connectionless, best-effort transport protocol.

- **RFC 8085**: _UDP Usage Guidelines_  
Best practices for using UDP.

### **QUIC (Quick UDP Internet Connections)**

- **RFC 9000**: _QUIC: A UDP-Based Multiplexed and Secure Transport_  
Modern transport protocol designed to improve upon TCP.

---

## **3. Routing Protocols**

### **Interior Gateway Protocols**

- **RFC 2328**: _OSPF Version 2_  
Open Shortest Path First (OSPF) routing protocol for IPv4.

- **RFC 5340**: _OSPF for IPv6 (OSPFv3)_  
OSPF version for IPv6 networks.

### **Exterior Gateway Protocols**

- **RFC 4271**: _Border Gateway Protocol 4 (BGP-4)_  
The standard for inter-domain routing on the Internet.

- **RFC 5492**: _Capabilities Advertisement with BGP-4_  
Extension for advertising capabilities in BGP.

### **Routing Security**

- **RFC 6480**: _An Infrastructure to Support Secure Internet Routing (RPKI)_  
Framework for securing BGP through cryptographic certificates.

---

## **4. Network Security**

### **IPSec (IP Security)**

- **RFC 4301**: _Security Architecture for the Internet Protocol_  
Defines the architecture for IPsec.

- **RFC 4302**: _IP Authentication Header (AH)_  
Provides integrity and authentication for IP packets.

- **RFC 4303**: _IP Encapsulating Security Payload (ESP)_  
Provides confidentiality, integrity, and authentication.

### **TLS (Transport Layer Security)**

- **RFC 8446**: _The Transport Layer Security (TLS) Protocol Version 1.3_  
The latest version of TLS for secure communication.

- **RFC 5246**: _TLS 1.2_  
Previous version of TLS widely used in secure applications.

### **SSH (Secure Shell)**

- **RFC 4251**: _The Secure Shell (SSH) Protocol Architecture_  
Overview of SSH architecture for secure remote access.

- **RFC 4252**: _SSH Authentication Protocol_  
Authentication mechanisms for SSH.

- **RFC 4253**: _SSH Transport Layer Protocol_  
Secure transport layer for SSH.

### **VPN (Virtual Private Network)**

- **RFC 7296**: _Internet Key Exchange Protocol Version 2 (IKEv2)_  
Protocol for establishing and maintaining VPN connections.

---

## **5. Data Synchronization and Transfer**

### **File Transfer Protocols**

- **RFC 959**: _File Transfer Protocol (FTP)_  
The original protocol for file transfers over TCP.

- **RFC 2228**: _FTP Security Extensions_  
Enhancements for securing FTP.

### **rsync Protocol**

- **RFC 5781**: _The rsync Algorithm_  
Describes the algorithm used in the `rsync` tool for efficient file synchronization.

---

## **6. Messaging Protocols**

### **Email Protocols**

- **RFC 5321**: _Simple Mail Transfer Protocol (SMTP)_  
The protocol for sending email.

- **RFC 5322**: _Internet Message Format_  
Standard format for email messages.

- **RFC 3501**: _Internet Message Access Protocol (IMAP)_  
Protocol for accessing email stored on a server.

- **RFC 1939**: _Post Office Protocol - Version 3 (POP3)_  
Protocol for retrieving email from a server.

### **Message Queues and Streams**

- **RFC 6455**: _The WebSocket Protocol_  
Real-time, full-duplex communication over HTTP.

---

## **7. Network Management**

### **SNMP (Simple Network Management Protocol)**

- **RFC 1157**: _Simple Network Management Protocol (SNMPv1)_  
The original SNMP protocol.

- **RFC 3411 - RFC 3418**: _SNMP Version 3 (SNMPv3)_  
Framework for secure network management.

### **Netconf and RESTCONF**

- **RFC 6241**: _Network Configuration Protocol (NETCONF)_  
Protocol for network device configuration.

- **RFC 8040**: _RESTCONF Protocol_  
RESTful interface for NETCONF.

---

## **8. Time Synchronization**

### **NTP (Network Time Protocol)**

- **RFC 5905**: _Network Time Protocol Version 4 (NTPv4)_  
Protocol for synchronizing clocks over a network.

- **RFC 4330**: _Simple Network Time Protocol (SNTP)_  
Simplified version of NTP.

---

## **9. Network Services**

### **DNS (Domain Name System)**

- **RFC 1034**: _Domain Names - Concepts and Facilities_  
Basic concepts of DNS.

- **RFC 1035**: _Domain Names - Implementation and Specification_  
Details DNS message formats and operations.

- **RFC 4035**: _DNSSEC Protocol Modifications_  
Security extensions to DNS.

### **HTTP (HyperText Transfer Protocol)**

- **RFC 9110**: _HTTP/1.1_  
Defines HTTP/1.1 for web communications.

- **RFC 9111**: _HTTP Caching_  
Details caching mechanisms in HTTP.

- **RFC 9112**: _HTTP/1.1 Message Syntax and Routing_  
Specifics on message format and routing in HTTP.

- **RFC 7540**: _HTTP/2_  
Improved version of HTTP for better performance.

- **RFC 9113**: _HTTP/3_  
HTTP over QUIC for enhanced performance and reliability.

---

## **10. Low-Level Networking**

### **Ethernet and Link Layer**

- **RFC 894**: _Standard for the Transmission of IP Datagrams over Ethernet Networks_  
Defines how IP datagrams are carried over Ethernet.

- **RFC 826**: _ARP (Address Resolution Protocol)_  
Resolves IP addresses to MAC addresses.

### **PPP (Point-to-Point Protocol)**

- **RFC 1661**: _The Point-to-Point Protocol (PPP)_  
Protocol for transmitting data over serial links.

- **RFC 2516**: _A Method for Transmitting PPP Over Ethernet (PPPoE)_  
Defines PPP over Ethernet connections.

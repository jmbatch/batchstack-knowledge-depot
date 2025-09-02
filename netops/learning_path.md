# NetOps Learning Path

## 1. **Networking Protocols and Technologies**

- **TCP/IP Stack (Layers 1-4)**:
  - Deep understanding of the **OSI and TCP/IP models**.
  - Tools for analysis: `tcpdump`, `Wireshark`, `ngrep`, `tshark`.
- **IPv4 and IPv6**:
  - **IPv6 Transition Mechanisms**: Dual-stack, tunneling, NAT64.
  - Tools: `ping6`, `traceroute6`, `ip -6`.
- **DNS (Domain Name System)**:
  - DNSSEC (security extensions) and caching mechanisms.
  - Troubleshooting with tools: `dig`, `nslookup`, `dnstracer`, `host`, `bind9`.
- **Routing Protocols**:
  - **Advanced BGP Concepts**: Route reflectors, communities, and path selection.
    - **IS-IS Protocol** for service provider networks.
- **Multicast**:
  - Protocols like IGMP, PIM-SM, and PIM-DM.
  - Tools: `smcroute`, `mrouted`.
- **RADIUS (Remote Authentication Dial-In User Service)**:
  - Authentication, Authorization, Accounting (AAA).
  - Tools: `freeradius`, `radtest`, and configuring clients on switches/routers.
- **TACACS+**:
  - Alternative AAA protocol for enterprise use.
  - Tools: `tac_plus`.
- **LDAP (Lightweight Directory Access Protocol)**:
  - Directory services for centralized authentication.
  - Tools: `ldapsearch`, `ldapmodify`.
- **FTP/SFTP (File Transfer Protocol/Secure File Transfer Protocol)**:
  - **Active vs. Passive FTP**.
  - Tools: `ftp`, `lftp`, `sftp`, `vsftpd`, `ProFTPD`.
- **NFS (Network File System)**:
  - Mounting and troubleshooting file shares.
  - Tools: `nfsstat`, `showmount`, `rpcinfo`.

---

## 2. **Network Security**

- **SSH (Secure Shell)**:
  - Understanding key exchange algorithms, ciphers, and HMACs.
  - Tools: `ssh-agent`, `ssh-keygen`, `ssh-copy-id`.
- **TLS/SSL**:
  - Certificate management: Self-signed certificates, Certificate Authorities (CAs).
  - **Tools**: `openssl`, `certbot`, `letsencrypt`.
- **VPNs**:
  - **IPsec**: IKEv1, IKEv2, ESP, AH.
  - **SSL VPNs**: `OpenVPN`, `WireGuard`.
- **Firewall Tools**:
  - `iptables`, `nftables`, `firewalld`, `pfSense`, `OPNsense`.
- **IDS/IPS**:
  - **Snort**, **Suricata**, and configuring alert rules.
- **Web Application Firewalls (WAFs)**:
  - Tools: **ModSecurity**, **AWS WAF**, **NAXSI**.
- **Packet Filtering and Analysis**:
  - Tools: `tcpdump`, `Wireshark`, `tshark`, `ngrep`.

---

## 3. **Data Synchronization and Transfer Tools**

- **Rsync**:
  - Synchronizing files efficiently over SSH or other protocols.
  - Key flags: `-avz`, `--delete`, `--dry-run`.
- **SCP (Secure Copy)**:
  - Secure file transfer via SSH.
  - Syntax: `scp user@host:/path/to/file /local/path`.
- **Syncthing**:
  - Continuous file synchronization across devices.
- **Unison**:
  - Bidirectional file synchronization.
- **FTP/SFTP Automation**:
  - Scripts using `lftp` or `expect`.

---

## 4. **Message Brokers and Event Streaming**

- **Kafka**:
  - Distributed event streaming, partitions, and replication.
  - Tools: `kafka-topics`, `kafka-console-producer`, `kafka-console-consumer`.
- **RabbitMQ**:
  - AMQP (Advanced Message Queuing Protocol) broker.
  - Tools: `rabbitmqctl`, `rabbitmqadmin`.
- **MQTT (Message Queuing Telemetry Transport)**:
  - Lightweight messaging protocol for IoT.
  - Tools: `mosquitto`, `mosquitto_pub`, `mosquitto_sub`.
- **Redis Pub/Sub**:
  - Redis for messaging and caching.
  - Tools: `redis-cli`, `MONITOR` command.

---

## 5. **Databases and SQL for Systems Engineers**

- **SQL Fundamentals**:
  - Writing queries, joins, indexing, and optimization.
- **Database Administration**:
  - Tools: `psql` (PostgreSQL), `mysql`/`mariadb` (MySQL), `sqlite3`.
- **Replication and Clustering**:
  - **MySQL Replication**, **PostgreSQL Streaming Replication**, **Galera Cluster**.
- **Backup and Restore**:
  - Tools: `pg_dump`, `mysqldump`, `mongodump`.
- **Database Performance Tools**:
  - **`EXPLAIN` and `EXPLAIN ANALYZE`** for query performance.
  - **Monitoring**: `pgAdmin`, `phpMyAdmin`, `Percona Toolkit`.

---

## 6. **Linux and Unix System Tools**

- **System Performance Monitoring**:
  - `htop`, `atop`, `dstat`, `vmstat`, `iostat`, `glances`.
- **Process Management**:
  - `ps`, `top`, `kill`, `nice`, `renice`.
- **Disk Management**:
  - `lsblk`, `fdisk`, `parted`, `LVM` (Logical Volume Manager).
- **Logs and Troubleshooting**:
  - `journalctl`, `/var/log`, `logrotate`.
- **Backup Tools**:
  - **`tar`**, `rsync`, `borg`, `restic`.

---

## 7. **Containerization and Orchestration**

- **Docker**:
  - Building, managing, and troubleshooting containers.
  - Tools: `docker-compose`, `docker logs`, `docker stats`.
- **Kubernetes**:
  - Core concepts: Pods, Services, Deployments, ConfigMaps, Secrets.
  - Tools: `kubectl`, `k9s`, `helm`.
- **Container Networking**:
  - **CNI Plugins**: Flannel, Calico, Cilium.

---

## 8. **Monitoring and Observability**

- **Metrics and Monitoring Systems**:
  - **Prometheus**: Metrics scraping and alerting.
  - **Grafana**: Visualization of metrics.
- **Log Aggregation**:
  - **ELK Stack**: Elasticsearch, Logstash, Kibana.
  - **Graylog**.
- **System and Network Monitoring**:
  - **Nagios**, **Zabbix**, **Netdata**.

---

## 9. **Automation and Scripting**

- **Ansible**:
  - Playbooks, roles, and inventory management.
- **Python Scripting**:
  - Libraries like `paramiko`, `netmiko`, and `fabric` for automation.
- **Shell Scripting**:
  - Bash scripting for automation tasks.
- **Infrastructure as Code (IaC)**:
  - **Terraform**, **Puppet**, **Chef**.

---

## 10. **Advanced Networking Concepts**

- **Quality of Service (QoS)**:
  - Traffic shaping and priority queuing.
  - Tools: `tc`, `wondershaper`.
- **SDN (Software-Defined Networking)**:
  - OpenFlow, **ONOS**, and **OpenDaylight**.
- **MPLS (Multiprotocol Label Switching)**:
  - Label switching, LSPs, and VPNs.
- **Overlay Networks**:
  - VXLAN, NVGRE, and Geneve

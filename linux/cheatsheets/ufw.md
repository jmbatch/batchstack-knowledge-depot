# ufw Basics

## 1. Install UFW

```bash
sudo apt update
sudo apt install ufw -y
```

## 2. Set default policies

### Deny all incoming by default, allow all outgoing

```bash
sudo ufw default deny incoming
sudo ufw default allow outgoing
```

## 3. Allow essential services

### Allow SSH (if needed)

```bash
sudo ufw allow ssh
```

### Allow HTTP/HTTPS (if hosting web services)

```bash
sudo ufw allow 80/tcp
sudo ufw allow 443/tcp
```

### Allow local network traffic (home network range)

```bash
sudo ufw allow from 192.168.0.0/16
```

## 4. Enable logging (low verbosity to avoid flooding logs)

```bash
sudo ufw logging on
sudo ufw logging low
```

## 5. Enable UFW

```bash
sudo ufw enable
```

## 6. Status check

```bash
sudo ufw status verbose
```

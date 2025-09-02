# Docker Setup & Basic Debian Container – Cheat Sheet

---

## Quick Vocabulary

* **Image** = template (e.g., `debian:stable-slim`)
* **Container** = running instance of an image
* **Registry** = where images live (Docker Hub, GHCR)

---

## Install Docker Engine on Debian 12

* Remove old packages (safe if not installed)

```bash
sudo apt remove -y docker.io docker-doc docker-compose docker-compose-v2 podman-docker containerd runc || true
```

* Prereqs & GPG key
  
```bash
sudo apt update
sudo apt install -y ca-certificates curl gnupg
sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/debian/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
sudo chmod a+r /etc/apt/keyrings/docker.gpg
```

* Add official Docker repo

```bash
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] \
  https://download.docker.com/linux/debian $(. /etc/os-release && echo $VERSION_CODENAME) stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
```

## Install Docker Engine + Compose plugin

```bash
sudo apt update
sudo apt install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
```

* Post‑install (optional but recommended)

* Run Docker as non‑root (new shell needed after group change):

```bash
sudo usermod -aG docker "$USER"
newgrp docker
```

* Test:

```bash
docker run --rm hello-world
```

**Common fix**: If you see `permission denied` on `/var/run/docker.sock`, log out and back in (or reboot) so group changes apply.

---

## Grab a Basic Debian Image

```bash
docker pull debian:stable-slim
# List images
docker images
```

---

## Run a Basic Debian Container

* Interactive shell (ephemeral)

```bash
docker run --rm -it debian:stable-slim bash
# Inside the container you can:
apt-get update && apt-get install -y iputils-ping curl
exit
```

`--rm` removes the container when it exits; great for quick tests.

## Named, reusable container

```bash
docker run -it --name debian-test debian:stable-slim bash
# ... do stuff ...
exit
```

* Start it again later:

```bash
docker start -ai debian-test   # -a attach, -i interactive
```

## Detached mode (service style)

```bash
docker run -d --name debian-sleeper debian:stable-slim sleep infinity
```

* Exec into a running container:

```bash
docker exec -it debian-sleeper bash
```

* Logs & status:

```bash
docker logs debian-sleeper
docker ps
```

---

## Persisting Files

### Bind mount a host folder

```bash
mkdir -p ~/docker-playground
# Mount host dir to /work inside the container
docker run --rm -it \
  -v ~/docker-playground:/work \
  --name debian-dev debian:stable-slim bash
```

### Named volume (Docker‑managed)

```bash
docker volume create debian_data
docker run --rm -it -v debian_data:/data debian:stable-slim bash
```

---

## Networking Basics

* Expose a port from a container to the host: `-p HOST:CONTAINER`

```bash
# Example: run a simple HTTP server
docker run --rm -d --name web -p 8080:8080 python:3.12-slim python -m http.server 8080
curl http://localhost:8080
```

---

## Build Your Own Minimal Debian Image

### Create `Dockerfile`

```Dockerfile
# Dockerfile
FROM debian:stable-slim
RUN apt-get update \
 && apt-get install -y --no-install-recommends curl ca-certificates \
 && rm -rf /var/lib/apt/lists/*
CMD ["bash"]
```

### Build & run

```bash
docker build -t my-debian:dev .
docker run --rm -it my-debian:dev
```

---

## Tearing Down / Cleanup

```bash
# Stop containers
docker stop debian-sleeper web || true

# Remove containers
docker rm debian-test debian-sleeper web || true

# Remove images (careful)
docker rmi my-debian:dev debian:stable-slim || true

# Remove volumes (data loss in those volumes!)
docker volume rm debian_data || true

# Global cleanup (dangling images/containers/networks)
docker system prune -f
# …and include unused images too:
docker system prune -a -f
```

---

## Handy One‑Liners

```bash
# List all containers (running + stopped)
docker ps -a

# Jump into the most recent running container
docker exec -it $(docker ps -q | head -n1) bash

# Copy file from container to host
docker cp debian-test:/etc/os-release ./os-release

# Inspect container/network/image
docker inspect debian-test | less

# Show container resource usage
docker stats
```

---

## Troubleshooting Quick Hits

* **`permission denied` on `/var/run/docker.sock`** → Add user to `docker` group, re‑login.
* **`no space left on device`** → `docker system df` then `docker system prune -a` (verify first!).
* **Internet from container fails** → check host firewall, DNS; try `--dns 1.1.1.1`.
* **Timezones** → `-e TZ=America/New_York` or install `tzdata` inside container.

---

## Bonus: Minimal Compose (Optional)

Create `compose.yml`:

```yaml
services:
  deb:
    image: debian:stable-slim
    container_name: deb-compose
    command: ["sleep", "infinity"]
    volumes:
      - ./work:/work
```

Run:

```bash
docker compose up -d
docker exec -it deb-compose bash
# ...
docker compose down -v  # remove containers + volumes
```

---

**You’re set.** Use this as your base and grow into multi‑service Compose stacks later.

# Docker CLI Basics

## See whats running

```bash
docker ps            # running containers
docker ps -a         # all containers (stopped too)
docker images        # local images
```

## Pull / build / tag

```bash
docker pull nginx:1.27
docker build -t myapp:1.0 .
docker tag myapp:1.0 ghcr.io/you/myapp:1.0
```

## Run (create+start) / stop / remove

```bash
docker run --name myapp --rm -d -p 8080:80 myapp:1.0
docker logs -f myapp
docker exec -it myapp sh
docker stop myapp && docker rm myapp
```

## Clean up the junk drawer

```bash
docker image prune           # dangling images
docker system prune -a       # EVERYTHING unused. keyword everything.
```

## Simple docker run

* `--rm` cleans up stuff when the container exits

* `--restart` unless-stopped makes it come back after reboot/crash.

* `-v` for persistence, --env-file for secrets/config.

```bash
docker run --name NAME --rm -d \
  -p 8080:8080 \
  -v /host/data:/app/data \
  --env-file .env \
  --restart unless-stopped \
  IMAGE:TAG
```

## Docker Compose

* Use docker-compose (or docker compose) when you have any of: more than one container, volumes, or long flags.

```yaml
# docker-compose.yml
services:
  myapp:
    image: ghcr.io/you/myapp:1.0
    ports: ["8080:8080"]
    env_file: .env
    volumes:
      - ./data:/app/data
    restart: unless-stopped
    healthcheck:
      test: ["CMD", "curl", "-f", "http://localhost:8080/health"]  # replace as needed
      interval: 10s
      timeout: 3s
      retries: 5
      start_period: 10s
```

## docker-compose commands

```bash
docker compose up -d
docker compose logs -f myapp
docker compose exec myapp sh
docker compose down      # removes containers but not volumes
docker compose down -v   # remove volumes too
```

## Build and tag

* Pin versions everywhere (base images, packages, your own tags).

* Use a .dockerignore to avoid bloating your build context.

* Multi-stage builds keep your final image lean.

```bash
# Dockerfile (multi-stage example)
FROM python:3.12-slim AS build
WORKDIR /app
COPY pyproject.toml poetry.lock ./
RUN pip install --upgrade pip && pip install --no-cache-dir poetry
RUN poetry export -f requirements.txt --output reqs.txt
COPY . .
RUN pip install --no-cache-dir -r reqs.txt

FROM python:3.12-slim
WORKDIR /app
COPY --from=build /app /app
EXPOSE 8080
HEALTHCHECK --interval=10s --timeout=3s --retries=5 CMD curl -f http://localhost:8080/health || exit 1
CMD ["python", "-m", "myapp"]
```

## Scripting patterns

### Linux

```bash
#!/usr/bin/env bash
set -euo pipefail

IMAGE="ghcr.io/you/mytool:1.0"
NAME="mytool"
PORT="8080"
DATA_DIR="${DATA_DIR:-$PWD/data}"

# Ensure data dir
mkdir -p "$DATA_DIR"

# Pull known-good tag
docker pull "$IMAGE"

# Run idempotently
if docker ps -a --format '{{.Names}}' | grep -q "^${NAME}$"; then
  docker rm -f "$NAME" >/dev/null
fi

docker run --name "$NAME" --rm -d \
  -p "$PORT:8080" \
  -v "$DATA_DIR:/app/data" \
  --env-file .env \
  --restart unless-stopped \
  "$IMAGE"

# Wait for healthy (if image has a HEALTHCHECK)
echo "Waiting for container to be healthy..."
until [ "$(docker inspect -f '{{.State.Health.Status}}' "$NAME" 2>/dev/null || echo starting)" = "healthy" ]; do
  sleep 1
done

docker logs --since=10s "$NAME"
```

### Powershell wrapper

```powershell
Param(
  [string]$Image = "ghcr.io/you/mytool:1.0",
  [string]$Name  = "mytool",
  [string]$Port  = "8080",
  [string]$DataDir = "$PWD\data"
)

New-Item -ItemType Directory -Force -Path $DataDir | Out-Null
docker pull $Image | Out-Null

if (docker ps -a --format '{{.Names}}' | Select-String -Pattern "^$Name$") {
  docker rm -f $Name | Out-Null
}

docker run --name $Name --rm -d `
  -p "$Port`:8080" `
  -v "$DataDir`:/app/data" `
  --env-file .env `
  --restart unless-stopped `
  $Image | Out-Null

# Poll for health if defined
for ($i=0; $i -lt 60; $i++) {
  $status = docker inspect -f '{{ .State.Health.Status }}' $Name 2>$null
  if ($status -eq "healthy") { break }
  Start-Sleep -Seconds 1
}
docker logs --since 10s $Name
```

## SIPp Example

### SIPp in Linux

```bash
docker run --rm --network host -it ghcr.io/sipp/sipp:latest \
  -sn uac 10.0.0.5:5060 -r 5 -m 50
```

### SIPp in Windows

```powershell
# Map a local UDP port range to SIPp (adjust as needed)
docker run --rm -it \
  -p 5060:5060/udp -p 5061:5061/udp \
  ghcr.io/sipp/sipp:latest \
  -sn uac  host.docker.internal:5060 -r 5 -m 50 -sf uac.xml
```

* Put scenarios in a bind mount: -v $PWD/scenarios:/scenarios then -sf /scenarios/uac.xml.

* If you need PCAPs out: -v $PWD/out:/out and -trace_msg -message_file /out/msgs.log.

## Reproducibility checklist

1. Always tag (myapp:1.3.2, not latest).
2. Pin base images and deps (no naked apt-get upgrade).
3. Healthcheck + wait-for-healthy in scripts.
4. Use volumes for data, env files for config.
5. Compose for anything non-trivial.
6. Prune regularly, but don’t nuke volumes unless you mean it.
7. CI: docker buildx build --platform linux/amd64,linux/arm64 -t ghcr.io/you/myapp:1.3.2 --push .

Debugging

* Container won’t start? `docker logs <name>` then `docker inspect <name> | jq .[0].State`

* Net weirdness? `docker exec -it <name> sh` and `apk add curl/apt-get update && apt-get install -y curl`.

* Can’t reach host service from container on macOS/Windows? `Use host.docker.internal`.

* UDP mapping issues on Windows? You must `-p map` the exact UDP ports you expect.

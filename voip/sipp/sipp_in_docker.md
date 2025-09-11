# Setting up SIPp Docker Containers

## 1. Setup SIPp in a Docker Container

1. Install Docker

    Ensure Docker is installed on your machine. You can download and install Docker from Docker's official site based on your operating system (Linux, macOS, or Windows).

2. Prepare SIPp Dockerfile (Optional)

    While there are already SIPp Docker images available, you can create your own Dockerfile if needed. Here’s a simple **Dockerfile** for SIPp:

    Example Dockerfile for SIPp

    ```Dockerfile
    # Use the official Debian Slim base image
    FROM debian:12.5-slim

    # Update package repository and install necessary dependencies
    RUN apt-get update && \
        apt-get install -y git build-essential autoconf automake libncurses-dev libssl-dev && \
        rm -rf /var/lib/apt/lists/*

    # Clone the SIPp repository from GitHub
    RUN git clone https://github.com/SIPp/sipp.git /sipp

    # Set working directory
    WORKDIR /sipp

    # Build SIPp from source
    RUN ./autogen.sh && ./configure --with-openssl && make

    # Expose SIPp's default SIP signaling port
    EXPOSE 5060/udp

    # Run SIPp by default
    ENTRYPOINT ["./sipp"]
    ```

## 2. Steps to Build the Docker Image (if using a Dockerfile)

- Build the Docker image with the tag 'sipp'

```bash
docker build -t sipp .
```

- If you don’t want to build the image from the Dockerfile, you can skip this step and directly use a prebuilt image from Docker Hub.

## 3. Pull a Prebuilt SIPp Docker Image (Optional)

- If you prefer not to create your own image, you can use a prebuilt image from Docker Hub. For example:

```bash
docker pull ghcr.io/sipp/sipp:latest
```

## 4. Running SIPp in a Docker Container

- Once you have the Docker image, you can start running SIPp inside a Docker container.

### Example 1: Running SIPp with Default Settings

- You can start SIPp using a prebuilt image directly:

```bash
docker run -it --rm ghcr.io/sipp/sipp:latest -sn uac 192.168.1.100:5060
```

- `-it`  # allows you to interact with the container.
- `--rm`  # will automatically remove the container after it stops.
- `-sn uac`  # is an example scenario (UAC - User Agent Client).
- `192.168.1.100:5060` is the IP address and port of the SIP server you're testing against.

### Example 2: Running Custom SIPp Scenarios

- To use custom scenarios (XML scenario files), you can mount a directory from your local machine into the Docker container:

```bash
docker run -it --rm -v /path/to/scenarios:/sipp/scenarios ghcr.io/sipp/sipp:latest /sipp/scenarios/your_scenario.xml -s 1001 192.168.1.100:5060
```

- `-v /path/to/scenarios:/sipp/scenarios` # mounts the local directory containing your custom XML scenarios into the container.
- `/sipp/scenarios/your_scenario.xml`  # is the path inside the container to your scenario file.

## 5. Running SIPp as a Server (SIPp UAS)

- If you want to run SIPp as a SIP server (User Agent Server), you can do it like this:

```bash
docker run -it --rm ghcr.io/sipp/sipp:latest -sn uas
```

## 6. Running SIPp as a Client (SIPp UAC)

If you want to test against a server (SIPp UAC mode):

```bash
docker run -it --rm ghcr.io/sipp/sipp:latest -sn uac 192.168.1.100:5060
```

## 7. Accessing SIPp Logs and Output

To collect logs or output from SIPp, you can either view the logs inside the container or map a volume to your host system:

```bash
docker run -it --rm -v /path/to/logs:/sipp/logs ghcr.io/sipp/sipp:latest -sn uac 192.168.1.100:5060 > /sipp/logs/output.log
```

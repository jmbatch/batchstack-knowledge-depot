# installing_asterisk_debian

## 1. Install Dependencies

Before installing Asterisk, ensure that the necessary dependencies are installed.
```bash
sudo apt update 
sudo apt install -y build-essential libssl-dev libncurses5-dev libnewt-dev \ libxml2-dev libsqlite3-dev libjansson-dev libcurl4-openssl-dev libical-dev \ uuid-dev subversion wget sox libedit-dev libsndfile1-dev libspandsp-dev \ libsrtp2-dev libpjproject-dev ffmpeg
```

---

## 2. Download and Install Asterisk and PJSIP

1. Download/Install/Configure PJSIP source code
```bash
# Download PJSIP source code
cd /usr/src
sudo wget https://github.com/pjsip/pjproject/archive/refs/tags/2.14.tar.gz

# Extract tarball
sudo tar -xvf 2.14.tar.gz 
cd pjproject-2.14

# Install dependencies 
sudo apt update 
sudo apt install -y libssl-dev libasound2-dev libsrtp2-dev libopus-dev \ libavformat-dev libswscale-dev libtool autoconf automake cmake g++ \ 
libspeexdsp-dev libglib2.0-dev libv4l-dev

# Configure the build
sudo ./configure --enable-shared --disable-sound --disable-resample --disable-video --disable-opencore-amr

'''
Explanation of flags:

- **`--enable-shared`**: Build shared libraries.
- **`--disable-sound`**: Disable sound support if not needed.
- **`--disable-resample`**: Skip resampling support if not needed.
- **`--disable-video`**: Skip video support (useful for SIP-only applications).
- **`--disable-opencore-amr`**: Skip OpenCORE AMR codec support if not needed.
'''

# Build and Install
sudo make dep 
sudo make 
sudo make install

# Update Library Cache
## Update the shared library cache so the system recognizes the new libraries:
sudo ldconfig

# Verify Installation
ldconfig -p | grep pj
``` 

2. Download the Asterisk source code:

```bash
cd /usr/src 
sudo wget https://downloads.asterisk.org/pub/telephony/asterisk/asterisk-20-current.tar.gz
sudo tar -zxvf asterisk-20-current.tar.gz 
cd asterisk-20.*/
```
    

3. Download the MP3 source (for MOH - Music on Hold)**:
```bash
sudo contrib/scripts/get_mp3_source.sh
``` 


4. Configure with PJSIP Support:

PJSIP is included by default in modern Asterisk versions. Configure the build:
```bash
sudo ./configure --with-ssl --with-srtp
```
    
5. Select PJSIP Modules in Menuselect:

```bash
sudo make menuselect
```
In the **`menuselect`** interface:
- Go to "Channel Drivers".
- Ensure **`chan_pjsip`** and related modules like **`res_pjsip`**, **`res_pjsip_transport_websocket`**, and **`res_pjsip_outbound_registration`** are selected.
- Optionally, deselect **`chan_sip`** since it’s deprecated.


6. Build and install Asterisk:

```bash
sudo make -j$(nproc) 
sudo make install
```

    
7. Install Configurations and Service:

```bash
sudo make samples
sudo make basic-pbx
sudo make config 
sudo ldconfig
```

8. Set Permissions:

```bash
sudo useradd -r -d /var/lib/asterisk -s /usr/sbin/nologin asterisk 
sudo chown -R asterisk:asterisk /etc/asterisk /var/{lib,log,spool}/asterisk /usr/lib/asterisk 
sudo chmod -R 750 /etc/asterisk
```

9. Update Service File:
    
Edit the service file:
```bash
sudo nano /etc/systemd/system/asterisk.service
```

Ensure the following lines are set:
```ini
User=asterisk 
Group=asterisk
```

10. Start Asterisk:
```bash
sudo systemctl daemon-reload 
sudo systemctl start asterisk 
sudo systemctl enable asterisk
```
    
11. Verify: 

```bash
sudo asterisk -rvvv`
```
    
**This should drop you into the Asterisk CLI**

---

## 3. Configure Asterisk with PJSIP

PJSIP Configuration Files
1. Edit `pjsip.conf`:
```bash
sudo nano /etc/asterisk/pjsip.conf
```

Here's a basic configuration for a peer and endpoint:
```ini
[transport-udp]
type=transport
protocol=udp
bind=0.0.0.0:5060

[rtpengine-endpoint]
type=endpoint
transport=transport-udp
context=default
disallow=all
allow=ulaw
aors=rtpengine-aor

[rtpengine-aor]
type=aor
contact=sip:127.0.0.1:5060

[rtpengine-auth]
type=auth
auth_type=userpass
username=rtpengine
password=your_password_here

[rtpengine-registration]
type=registration
outbound_auth=rtpengine-auth
server_uri=sip:127.0.0.1:5060
client_uri=sip:rtpengine@127.0.0.1:5060

```

- **Transport**: Defines the UDP transport layer.
- **Endpoint**: Defines the peer configuration.
- **AOR**: The Address of Record (location where the peer can be reached).
- **Auth** and **Registration**: For outbound authentication if needed.

2. Reload PJSIP Configuration:
```bash
sudo asterisk -rx "pjsip reload"
```

3. Verify Configuration
```bash
sudo asterisk -rx "pjsip show endpoints"
```


## 4. Configure RTPengine

If you haven't already installed RTPengine, follow these steps:
1. Install Dependencies for RTPengine
```bash
sudo apt install -y iptables iptables-persistent libhiredis-dev libpcap-dev \ libssl-dev libxmlrpc-core-c3-dev libcurl4-openssl-dev libevent-dev \ libavcodec-dev libavfilter-dev libavformat-dev libavutil-dev libswscale-dev \ dkms debhelper default-libmysqlclient-dev gperf
```

2. Clone and Install RTPengine
```bash
cd /usr/src 
sudo git clone https://github.com/sipwise/rtpengine.git 
cd rtpengine 
sudo ./debian/flavors/no_ngcp build 
sudo dpkg -i ../rtpengine_*.deb
```

3. Configure RTPengine

 Edit the RTPengine configuration file:
```bash
sudo nano /etc/rtpengine/rtpengine.conf
```

Add or update the following lines:
```ini
[rtpengine] 
interface = 127.0.0.1 
port = 22222 
log-level = 7
```

4. Start RTPengine

```bash
sudo systemctl start rtpengine 
sudo systemctl enable rtpengine
```

Check the status:
```bash
sudo systemctl status rtpengine
```

---

## 5. Configure Asterisk to Use RTPengine

**Asterisk** doesn't natively support **RTPengine** like Kamailio does, but you can use SIP peers with **Asterisk** to work with **RTPengine** by setting up the SIP peer configuration appropriately.

1. Edit `sip.conf`:

```bash
sudo nano /etc/asterisk/sip.conf
```

Add or modify the SIP peer configuration:
```bash
[rtpengine] 
type=peer 
host=127.0.0.1 
qualify=yes 
context=default
```
    
2. Reload Asterisk:
```bash
sudo asterisk -rx "sip reload"
``` 

---

## Step 5: Testing the Setup

1. Create a Test Extension in `extensions.conf`:
```bash
sudo nano /etc/asterisk/extensions.conf
```

Add a basic dial plan:
```bash
[default] exten => 1001,1,Answer() same => n,Echo() same => n,Hangup()
```

2. Reload Dial Plan:
```bash
sudo asterisk -rx "dialplan reload"
```
    
3. Test with a SIP Client (e.g., Linphone, Zoiper, etc.):
	1. Register the client to Asterisk.
	2. Dial `1001` to test the echo function.

4. Verify RTP:

Use the **Asterisk CLI** to monitor SIP calls:
```bash
sudo asterisk -rvvv
```

Check RTP stream status:
```bash
rtp set debug on
```

 **This will show RTP packet flow details, helping you verify if RTPengine is handling the media streams.**
 
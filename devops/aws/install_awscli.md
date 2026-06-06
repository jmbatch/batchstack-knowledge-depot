# Install AWS CLI

## 1. Install AWS CLI v2

```bash
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
sudo apt install unzip -y
unzip awscliv2.zip
sudo ./aws/install
aws --version
```

## 2. Configure awscli

```bash
aws configure
```

- Credentials are written the users home directory

```bash
~/.aws/credentials
~/.aws/config
```

## 3. Verify Authentication

```bash
aws sts get-caller-identity
```

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

## 3. Verify Authentication

```bash
aws sts get-caller-identity
```

## 4. Create directory

```bash
mkdir ~/ec2-demo && cd ~/ec2-demo
```

## 5. Create main.tf

```tf
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
  required_version = ">= 1.0"
}

provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "example" {
  ami           = "ami-0c02fb55956c7d316" # Amazon Linux 2 (example)
  instance_type = "t2.micro"

  tags = {
    Name = "WSL-Terraform-EC2"
  }
}
```

# AWS CLI — Comprehensive Learning Guide

## 1. What AWS CLI Actually Is (Mental Model)

The AWS CLI is a **thin wrapper over AWS APIs**.

* Every command → maps to an AWS API call
* Structure:

  ```bash
  aws <service> <operation> --parameters
  ```

Example:

```bash
aws ec2 describe-instances
```

→ Calls EC2 `DescribeInstances` API

---

## 2. Installation & Setup

### Install (Linux / macOS)

```bash
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o awscliv2.zip
unzip awscliv2.zip
sudo ./aws/install
```

### Verify

```bash
aws --version
```

---

## 3. Authentication & Configuration

### Basic Config

```bash
aws configure
```

Prompts:

* Access Key ID
* Secret Access Key
* Region
* Output format

Stored in:

```bash
~/.aws/config
~/.aws/credentials
```

---

### Named Profiles (critical for real workflows)

```bash
aws configure --profile dev
aws configure --profile prod
```

Usage:

```bash
aws ec2 describe-instances --profile dev
```

---

### Environment Variables (override config)

```bash
export AWS_ACCESS_KEY_ID=...
export AWS_SECRET_ACCESS_KEY=...
export AWS_DEFAULT_REGION=us-east-1
```

---

## 4. Command Structure Deep Dive

### General Pattern

```bash
aws <service> <operation> \
  --param1 value \
  --param2 value
```

### Help System (very important)

```bash
aws help
aws ec2 help
aws ec2 run-instances help
```

---

## 5. Output Formats

| Format         | Use Case       |
| -------------- | -------------- |
| json (default) | scripting      |
| table          | human-readable |
| text           | pipelines      |

Example:

```bash
aws ec2 describe-instances --output table
```

---

## 6. Filtering & Querying (JMESPath)

This is one of the **most important skills**.

### Example

```bash
aws ec2 describe-instances \
  --query 'Reservations[].Instances[].InstanceId'
```

### Filter by tag

```bash
aws ec2 describe-instances \
  --filters "Name=tag:Name,Values=web-server"
```

---

### Combine filter + query

```bash
aws ec2 describe-instances \
  --filters Name=instance-state-name,Values=running \
  --query 'Reservations[].Instances[].InstanceId'
```

---

## 7. Core Services Cheat Sheet

---

## EC2 (Compute)

### List instances

```bash
aws ec2 describe-instances
```

### Launch instance

```bash
aws ec2 run-instances \
  --image-id ami-xxxx \
  --count 1 \
  --instance-type t2.micro \
  --key-name my-key
```

### Start / Stop

```bash
aws ec2 start-instances --instance-ids i-123
aws ec2 stop-instances --instance-ids i-123
```

---

## S3 (Storage)

### List buckets

```bash
aws s3 ls
```

### List contents

```bash
aws s3 ls s3://my-bucket
```

### Upload

```bash
aws s3 cp file.txt s3://my-bucket/
```

### Download

```bash
aws s3 cp s3://my-bucket/file.txt .
```

### Sync (important)

```bash
aws s3 sync ./local-dir s3://my-bucket/
```

---

## IAM (Identity)

### List users

```bash
aws iam list-users
```

### List roles

```bash
aws iam list-roles
```

---

## STS (Identity Context)

### Who am I (use constantly)

```bash
aws sts get-caller-identity
```

---

## CloudWatch (Monitoring)

### List metrics

```bash
aws cloudwatch list-metrics
```

---

## 8. Pagination & Limits

AWS APIs paginate by default.

### Disable pagination

```bash
--no-paginate
```

### Control page size

```bash
--max-items 10
```

---

## 9. Working with JSON Input

### Inline JSON

```bash
aws ec2 run-instances \
  --cli-input-json file://config.json
```

---

### Generate skeleton

```bash
aws ec2 run-instances --generate-cli-skeleton
```

---

## 10. Debugging & Troubleshooting

### Enable debug output

```bash
aws ec2 describe-instances --debug
```

### Common issues

| Problem              | Cause           |
| -------------------- | --------------- |
| AccessDenied         | IAM permissions |
| InvalidClientTokenId | bad credentials |
| Region mismatch      | wrong region    |

---

## 11. Useful Global Flags

| Flag           | Purpose            |
| -------------- | ------------------ |
| --profile      | choose credentials |
| --region       | override region    |
| --output       | format             |
| --query        | filter output      |
| --debug        | verbose logging    |
| --no-cli-pager | disable pager      |

---

## 12. Practical Workflow Patterns

### Pattern 1: Discover → Filter → Act

```bash
# Find instances
aws ec2 describe-instances \
  --query 'Reservations[].Instances[].InstanceId'

# Act on them
aws ec2 stop-instances --instance-ids <ids>
```

---

### Pattern 2: Pipe into shell

```bash
aws ec2 describe-instances \
  --query 'Reservations[].Instances[].InstanceId' \
  --output text
```

---

### Pattern 3: Combine with jq (advanced)

```bash
aws ec2 describe-instances | jq '.Reservations[].Instances[].InstanceId'
```

---

## 13. Autocomplete (Highly Recommended)

```bash
complete -C '/usr/local/bin/aws_completer' aws
```

---

## 14. Security Best Practices

* Never hardcode credentials
* Prefer:

  * IAM roles (EC2)
  * temporary credentials (STS)
* Use least privilege

---

## 15. Underlying Concepts You Should Understand

To fully master AWS CLI, you need:

### AWS Concepts

* Regions vs Availability Zones
* IAM (users, roles, policies)
* Resource identifiers (ARNs)

### CLI Concepts

* JSON structure navigation
* JMESPath queries
* Shell piping

### API Concepts

* Idempotency
* Pagination
* Rate limiting

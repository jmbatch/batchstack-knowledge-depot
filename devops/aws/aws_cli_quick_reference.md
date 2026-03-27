# Quick Reference Cheat Sheet

## Core Commands

```bash
aws help
aws <service> help
aws <service> <operation> help
```

---

## Identity

```bash
aws sts get-caller-identity
```

---

## Profiles

```bash
aws configure --profile dev
aws ec2 describe-instances --profile dev
```

---

## S3

```bash
aws s3 ls
aws s3 cp file s3://bucket/
aws s3 sync . s3://bucket/
```

---

## EC2

```bash
aws ec2 describe-instances
aws ec2 start-instances --instance-ids i-xxx
aws ec2 stop-instances --instance-ids i-xxx
```

---

## Querying

```bash
--query 'Reservations[].Instances[].InstanceId'
```

---

## Output

```bash
--output json|table|text
```

---

## Debugging

```bash
--debug
```

---

## Suggested Learning Progression (Practical)

1. **Identity first**

   * `sts get-caller-identity`

2. **S3 basics**

   * upload/download/sync

3. **EC2 read-only**

   * describe instances

4. **Filtering & queries**

   * extract IDs

5. **Write operations**

   * start/stop instances

6. **JSON input automation**

   * `--cli-input-json`

---

If you want, I can take this further into a **hands-on lab series** (e.g., “build + manage EC2 via CLI step-by-step”) or tie it directly into your **Terraform learning path** so you see how CLI and IaC complement each other.

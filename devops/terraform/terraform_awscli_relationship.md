# How Terraform Uses AWS CLI Configuration

## aws configure

- When you run `aws configure`, it writes your credentials to the users home directory.

```bash
~/.aws/credentials
~/.aws/config
```

- Terraform automatically picks these up.

## AWS Credential Chain

- Terraform follows this order when checking for credentials:

1. Provider block parameters (these should never be hardcoded)

    ```Hcl
    provider "aws" {
    access_key = "..."
    secret_key = "..."
    }
    ```

2. Environment variables

    ```bash
    export AWS_ACCESS_KEY_ID=...
    export AWS_SECRET_ACCESS_KEY=...
    ```

3. Shared credentials file

    ```bash
    ~/.aws/crednetials  # Created by aws configure)
    ```

4. Shared config file

    ```bash
    ~/.aws/config
    ```

5. Container credentials
    - ECS, EKS, etc

6. Instance profile credentials
    - EC2 metadata

Terraform stops at the first valid source it finds.

## Alternatives

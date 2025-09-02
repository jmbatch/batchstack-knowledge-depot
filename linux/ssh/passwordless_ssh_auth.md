# Passwordless SSH Authentication

## Step 1: Generate an SSH keypair (on the client)

### On your local workstation (the client):

```bash
ssh-keygen -t ed25519 -C "jared@lab" -f ~/.ssh/id_ed25519
```

- -t ed25519 → modern algorithm (stronger and faster than RSA).
- -C → just a comment, usually your email or identifier.
- -f → file path (default would be ~/.ssh/id_ed25519).

### This produces:

```bash
~/.ssh/id_ed25519 # (private key)
~/.ssh/id_ed25519.pub # (public key)
```

- Private key never leaves your client. Treat it like your toothbrush.

## Step 2: Copy the public key to the server

- Let’s assume:
- Server: debian01.lab
- User: jmbatch

### Manual method:

```bash
ssh-copy-id -i ~/.ssh/id_ed25519.pub jmbatch@10.0.0.45
```

- This does two things:

1. Creates the directory ~/.ssh/ on the server (if missing).
2. Appends your public key to ~/.ssh/authorized_keys.

### Alternative manual way (without ssh-copy-id):

```bash
cat ~/.ssh/id_ed25519.pub | ssh jmbatch@10.0.0.45 "mkdir -p ~/.ssh && chmod 700 ~/.ssh && cat >> ~/.ssh/authorized_keys && chmod 600 ~/.ssh/authorized_keys"
```

## Step 3: Adjust permissions on the server

- SSH is picky about permissions. On server:

```bash
chmod 700 ~/.ssh
chmod 600 ~/.ssh/authorized_keys
```

- Why? Because OpenSSH refuses to use keys if the files are too open (world-readable).

## Step 4: Test passwordless login

- From the client:

```bash
ssh jared@debian01.lab
```

- If it logs you straight in without asking for a password → success.

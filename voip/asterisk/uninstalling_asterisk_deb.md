# Uninstall Asterisk

## 1. Stop the Asterisk Service

Before uninstalling, make sure the Asterisk service is stopped:

```bash
sudo systemctl stop asterisk
```

## 2. Uninstall Asterisk Binaries

If you installed Asterisk from source, there's no single package to uninstall, but you can use the original source directory to uninstall the binaries.

1. **Navigate to the source directory where you compiled Asterisk (e.g., `/usr/src/asterisk-20.11.0` or the version you installed**

    ```bash
    cd /usr/src/asterisk-20.11.0
    ```

2. **Run the `make uninstall` command to remove the binaries**:

    ```bash
    sudo make uninstall
    ```

3. **Clean up additional compiled files:**

    ```bash
    sudo make clean
    sudo make distclean
    ```

## 3. Remove Configuration Files and Directories

**Remove the configuration directories and files, including logs and data directories:**

```bash
sudo rm -rf /etc/asterisk 
sudo rm -rf /var/lib/asterisk 
sudo rm -rf /var/log/asterisk 
sudo rm -rf /var/run/asterisk 
sudo rm -rf /usr/lib/asterisk 
sudo rm -rf /usr/include/asterisk
```

## 4. Remove Asterisk User and Group

**If you created a dedicated Asterisk use and group, you can remove them:**

```bash
sudo userdel asterisk
sudo groupdel asterisk
```

## 5. Remove Dependencies (Optional)

**If you want to remove dependencies that were installed for Asterisk, you can do so manually.

**For example:**

```bash
sudo apt remove --purge libssl-dev libncurses5-dev libxml2-dev libsqlite3-dev uuid-dev
sudo apt autoremove
```

This is optional, and you can skip this step if you plan to reinstall Asterisk, as these dependencies might still be needed.

## 6. Remove systemd service file

**if a customer `asterisk.service` file was created, remove it:**

```bash
sudo rm -f /etc/systemd/system/asterisk.service
```

**Reload `systemd` to reflect the changes:**

```bash
sudo systemctl daemon-reload
```

## 7. Verify Asterisk is removed

```bash
which asterisk
```

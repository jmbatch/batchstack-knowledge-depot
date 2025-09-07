# Uninstall mysql on Debian 12

1. Remove MySQL packages

    ```bash
    sudo apt remove mysql-server mysql-client
    ```

2. Handle the data directory

    ```bash
    sudo mv /var/lib/mysql /var/lib/mysql_backup
    ```

3. (optional) Delete the data directory

    ```bash
    sudo rm -rf /var/lib/mysql
    ```

4. (optional) Remove configuration files

    ```bash
    sudo apt purge mysql-server mysql-client
    sudo rm -rf /etc/mysql
    ```

5. (optional) Remove log files

    ```bash
    sudo rm -rf /var/log/mysql*
    ```

6. (optional) Remove MySQL User and Group:

    ```bash
    sudo deluser --remove-home mysql
    sudo delgroup mysql
    ```

7. (optional) Remove AppArmor Profiles

    ```bash
    sudo rm -rf /etc/apparmor.d/abstractions/mysql /etc/apparmor.d/cache/usr.sbin.mysqld
    ```

8. (optional) auto-remove and auto-clean

    ```bash
    sudo apt autoremove
    sudo apt autoclean
    ```

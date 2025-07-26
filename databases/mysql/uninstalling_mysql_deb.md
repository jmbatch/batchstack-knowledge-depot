# Uninstall mysql on Debian 12

1. Remove MySQL packages
sudo apt remove mysql-server mysql-client

2. Handle the data directory
sudo mv /var/lib/mysql /var/lib/mysql_backup

2.5. (optional) Delete the data directory
sudo rm -rf /var/lib/mysql

3. (optional) Remove configuration files
sudo apt purge mysql-server mysql-client
sudo rm -rf /etc/mysql

4. (optional) Remove log files
sudo rm -rf /var/log/mysql*

5. (optional) Remove MySQL User and Group:
sudo deluser --remove-home mysql
sudo delgroup mysql

6. (optional) Remove AppArmor Profiles
sudo rm -rf /etc/apparmor.d/abstractions/mysql /etc/apparmor.d/cache/usr.sbin.mysqld

7. (optional) auto-remove and auto-clean
sudo apt autoremove
sudo apt autoclean
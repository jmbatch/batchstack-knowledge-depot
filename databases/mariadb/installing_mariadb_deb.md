# Install MariaDB
1. update the server package index
sudo apt update

2. Install the MariaDB database server packages
sudo apt install mariadb-server -y

3. Test Access to MariaDB console
mariadb -u root



# Manage the MariaDB system service 
1. Enable MariaDB to start at system boot
sudo systemctl enable mariadb.service

2. View the MariaDB service status and verify that it's running
sudo systemctl status mariadb.service

3. Start the MariaDB service
sudo systemctl start mariadb.service

4. Stop the service to drop all active database connections
sudo systemctl stop mariadb.service

5. Restart the service
sudo systemctl restart mariadb.service



# Secure the MariaDB server
1. Run the MariaDB secure installation script to secure the database.
sudo mariadb-secure-installation

2. Press ENTER to proceed with default root database user password

Enter current password for root (enter for none):
OK, successfully used password, moving on... 

3. Press N then ENTER to enable authentication when prompted to switch to unix socket authentication

Switch to unix_socket authentication [Y/n] n
 ... skipping. 
 
 4. Press Y then ENTER to change the default root database user password (NOTE: Log the password in LastPass)
 
 Change the root password? [Y/n] y
New password:
Re-enter new password:
Password updated successfully!
Reloading privilege tables..
 ... Success! 
 
 5. Press Y + ENTER to remove anonymous users

Remove anonymous users? [Y/n] y
... Success! 
 
6. Press Y then ENTER to disable remote access to the root database user

Disallow root login remotely? [Y/n] y
 ... Success! 
 
7. Remove the default test database

Remove test database and access to it? [Y/n] y
 - Dropping test database...
 ... Success!
 - Removing privileges on test database...
 ... Success!
 
8. Press Y then ENTER to reload privileges to save changes

Reload privilege tables now? [Y/n] y
 ... Success!
 
9. Restart the MariaDB service to apply the configuration changes
sudo systemctl restart mariadb



# Access MariaDB
1. Log in to MariaDB as root and enter the password set during set up 
mariadb -u root -p 

2. View all databases available on the server

MariaDB [(none)]> SHOW DATABASES;
+--------------------+
| Database           |
+--------------------+
| information_schema |
| mysql              |
| performance_schema |
| sys                |
+--------------------+
4 rows in set (0.000 sec)

MariaDB [(none)]>

3. Type "QUIT" then press ENTER to exit
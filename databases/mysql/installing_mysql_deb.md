# Installing mysql on Debian

## Step 1: Update Package Index

First, update your package index to ensure you have the latest information on the available packages:

```bash
sudo apt update
```

## Step 2: Install MySQL Server

Install the MySQL server package using the following command:

```bash
sudo apt install mysql-server
```

## Step 3: Secure MySQL Installation

After the installation is complete, you should run a security script that comes with MySQL. This script will help you set a root password, remove insecure default settings, and improve the security of your MySQL installation:

```bash
sudo mysql_secure_installation
```

The script will prompt you to answer several questions, including:

- Set a root password.
- Remove anonymous users.
- Disallow root login remotely.
- Remove test databases and access to them.
- Reload privilege tables.

## Step 4: Start and Enable MySQL Service

Ensure that the MySQL service is started and enabled to start at boot:

```bash
sudo systemctl start mysql sudo systemctl enable mysql
```

## Step 5: Verify MySQL Installation

You can verify that MySQL is running by checking its status:

```bash
sudo systemctl status mysql
```

Additionally, you can log in to the MySQL shell as the root user to ensure that everything is set up correctly:

```bash
sudo mysql -u root -p

Enter the root password you set during the secure installation process.
```

## Step 6: Create a Database and User (Optional)

If you want to create a new database and a user, you can do so from the MySQL shell. Here's an example of how to create a database named `mydatabase` and a user named `myuser` with a password `mypassword`:

```sql
CREATE DATABASE mydatabase; CREATE USER 'myuser'@'localhost' IDENTIFIED BY 'mypassword'; GRANT ALL PRIVILEGES ON mydatabase.* TO 'myuser'@'localhost'; FLUSH PRIVILEGES; EXIT;
```

## Additional Configuration

If you need to configure MySQL further, you can edit the main configuration file located at `/etc/mysql/mysql.conf.d/mysqld.cnf`. After making any changes to the configuration file, restart the MySQL service to apply the changes:

```bash
sudo systemctl restart mysql
```

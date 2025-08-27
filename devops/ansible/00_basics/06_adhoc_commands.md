# Basic Commands
- Syntax: `ansible <host-pattern> -m <module-name> -a “<module-arguments>”`

## Examples
```bash
# Ping all hosts
ansible all -i hosts.ini -m ping

# Gather facts about your host
ansible all -9 hosts.ini -m setup

# Run a command with the shell module
ansible all -i hosts.ini -m shell -a "uptime"

# Check disk space
ansible all -i hosts.ini -m shell -a "df -h"

# Check for all users on all hsots using command module
ansible all -i hosts.ini -m command -a "cat /etc/passwd"

# Retreive memory util across all hosts using command module
ansible all -i hosts.ini -m  command -a "free -m" 

# Run on a specific group
ansible webservers -i hosts.ini -m ping

# Run on a single host
ansible myserver -i hosts.ini -m command -a "hostname"
```

## File operations
```bash
# Copy a file from Control Node to Host
ansible all -i hosts.ini -m copy -a "src=/path/to/source dest=/path/to/destination"

# Run a copy file check to validate action before running
ansible all -i hosts.ini -m copy -a "src=/path/to/source dest=/path/to/destination" --check

# Fetch a file from Host to Control Node
ansible all -i hosts.ini -m fetch -a "src=/remote/path dest=/local/path"

# Create a directory on Hosts
ansible all -i hosts.ini -m file -a "path=/path/to/directory state=directory mode=0755"

# Remove a file or directory from hosts
ansible all -i hosts.ini -m file -a "path=/path/to/file state=absent"

# Create a symbolic link on hosts
ansible all -i hosts.ini -m file -a "src=/path/to/source dest=/path/to/symlink state=link"
```

## Users and groups using the user module
```bash
# Create a user (password must be hashed to use this method)
ansible all -i hosts.ini -m user -a "name=’username’ password=’<hashed_password>’ state=present" —-become —-ask-become-pass

# Remove a user and delete home directory and mail spool
ansible all -i hosts.ini -m user -a "name=username state=absent remove=yes"

# Add a user to a group
ansible all -i hosts.ini -m user -a "name=username groups=admin append=yes" 
```

## Package Management
```bash
# Install a package using apt
ansible all -i hosts.ini -m apt -a "name=nginx state=present" --become

# Remove a package using apt
ansible all -i hosts.ini -m apt -a "name=httpd state=absent" --become

# Upgrade all packages using apt
ansible all -i hosts.ini -m apt -a "upgrade=dist" --become

# Update package cache using apt
ansible all -i hosts.ini -m apt -a "update_cache=yes" --become

# Install a package using yum
ansible all -i hosts.ini -m yum -a "name=nginx state=present" --become

# Remove a package using yum
ansible all -i hosts.ini -m yum -a "name=httpd state=absent" --become

# Upgrade all packages using yum
ansible all -i hosts.ini -m yum -a "upgrade=dist" --become
```

## Managing services on hosts using service and systemd modules
```bash
# Start a service
ansible all -i hosts.ini -m service -a "name=nginx state=started"

# Stop a service
ansible all -i hosts.ini -m service -a "name=nginx state=stopped"

# Restart a service
ansible all -i hosts.ini -m systemd -a "name=nginx state=restarted" 

# Enable a service
ansible all -i hosts.ini -m systemd -a "name=nginx enabled=yes"
```

## Reboot and shutting down hosts
```bash
# Reboot all hosts
ansible all -i hosts.ini -m reboot

# Shutdown a host
ansible all -i hosts.ini -m command -a "/sbin/shutdown -h now"
```

## Mounting disk operations
```bash
# Mount a file system
ansible all -i hosts.ini -m mount -a "path=/mnt/mydisk src=/dev/sdb1 fstype=ext4 state=mounted"

# Unmount a file system
ansible all -i hosts.ini -m mount -a "path=/mnt/mydisk state=unmounted" 
```

## Using Cron module to manage cron jobs
```bash
# Create a cron job
ansible -all -i hosts.ini -m cron -a "name='Backup' minute=0 hour=2 job='/usr/local/bin/backup.sh'"

# Remove a cron job
ansible all -i hosts.ini -m cron -a "name='Backup' state=absent"
```
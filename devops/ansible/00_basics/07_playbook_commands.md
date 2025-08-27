```bash
# Display your inventory file in JSON format
ansible-inventory -i hosts.ini --list

# Displays inventory file in a YAML format
ansible-inventory -i hosts.ini --list -y

# Get a tree structure of your inventory file
ansible-inventory -i hosts.ini --graph

# Find out specific information about a host in an inventory file
ansible-inventory -i hosts.ini --host hostname
```


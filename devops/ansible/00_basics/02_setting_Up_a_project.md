# Setting up an Ansible project

## Download an init shell script
```bash
# save it
curl -sSL https://gist.githubusercontent.com/placeholder/ansible-lab-init.sh -o ansible-lab-init.sh
# or just copy/paste into a file named ansible-lab-init.sh

chmod +x ansible-lab-init.sh
./ansible-lab-init.sh                # creates ./ansible-lab
./ansible-lab-init.sh my-ansible     # creates ./my-ansible
./ansible-lab-init.sh --force        # overwrite existing files
```
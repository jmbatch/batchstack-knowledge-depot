# Inventory Basics

## What is an Inventory?

- Tells Ansible **which hosts** to manage.
- Can be **static** (INI/YAML file) or **dynamic** (cloud plugin).

---

## Static INI Example

```ini
[debian]
voip-staging-01 ansible_host=192.0.2.21
voip-staging-02 ansible_host=192.0.2.22

[web]
web-01 ansible_host=192.0.2.31

[all:vars]
ansible_user=admin
ansible_become=yes
```

## Static YAML Example

```yaml
all:
  children:
    debian:
      hosts:
        voip-staging-01:
          ansible_host: 192.0.2.21
        voip-staging-02:
          ansible_host: 192.0.2.22
    web:
      hosts:
        web-01:
          ansible_host: 192.0.2.31
  vars:
    ansible_user: admin
    ansible_become: yes
```

## Inventory Commands

```bash
# Show inventory structure
ansible-inventory -i inventories/lab/hosts.ini --graph

# Dump as JSON
ansible-inventory -i inventories/lab/hosts.ini --list
```

## Special vars

`ansible_host` → IP or DNS
`ansible_user` → SSH user
`ansible_port` → SSH port
`ansible_become` → use sudo
`ansible_ssh_private_key_file` → path to key

# Variables & Facts Cheat Sheet

## Variables

### Defining

```yaml
vars:
  app_port: 8080
```

## Using

```yaml
- name: Print a variable
  ansible.builtin.debug:
    msg: "App runs on port {{ app_port }}"
```

## Precedence

- Lowest → Highest priority:

1) Defaults in roles
2) Inventory vars
3) Play vars
4) Extra vars (-e flag)

## Facts

- Facts = system information gathered by Ansible.

## Enable/Disable

```yaml
- hosts: all
  gather_facts: yes   # or no
```

## Use in tasks

```yaml
- debug:
    msg: "This host is running {{ ansible_distribution }} {{ ansible_distribution_version }}"
```

## Gather manually

```bash
ansible all -m setup
ansible all -m setup -a "filter=ansible_distribution*"
```

## Group/Host Vars

- group_vars/all.yml → applies to all hosts
- group_vars/debian.yml → only Debian group
- host_vars/web-01.yml → only specific hostw

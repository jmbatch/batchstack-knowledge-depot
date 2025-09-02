# Ad-Hoc Commands vs Playbooks

## Ad-Hoc Commands

- Quick one-liners for testing or small tasks.
- Syntax: `ansible <host-pattern> -m <module> -a "<args>"`

### Examples

```bash
# Ping all hosts
ansible all -m ping

# Install htop
ansible debian -m apt -a "name=htop state=present" --become

# Check uptime
ansible voip-staging-01 -m command -a "uptime"
```

- Pros: quick, no file needed.
- Cons: not reusable, not documented.

## Playbooks

- YAML files that define repeatable automation.
- Syntax: ansible-playbook `<file>`.yml

### Example

```yaml
---
- name: Install base packages
  hosts: debian
  become: yes
  tasks:
    - name: Install htop
      ansible.builtin.apt:
        name: htop
        state: present
```

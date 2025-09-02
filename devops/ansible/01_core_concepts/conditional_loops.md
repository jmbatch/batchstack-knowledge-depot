# Conditionals & Loops Cheat Sheet

## Conditionals

### `when`

```yaml
- name: Only run on Debian
  ansible.builtin.apt:
    name: nginx
    state: present
  when: ansible_os_family == "Debian"
```

## Combining Conditions

```yaml
when: ansible_distribution == "Ubuntu" and ansible_distribution_version == "20.04"
```

## Loops

### Simple Loop

```yaml
- name: Install packages
  ansible.builtin.apt:
    name: "{{ item }}"
    state: present
  loop:
    - curl
    - vim
    - htop
```

## Loop with Dictionary

```yaml
- name: Create users
  ansible.builtin.user:
    name: "{{ item.name }}"
    state: present
    groups: "{{ item.groups }}"
  loop:
    - { name: "alice", groups: "sudo" }
    - { name: "bob", groups: "dev" }
```

## Loop Controls

```yaml
loop_control:
  index_var: idx

# Playbook Parameters Cheat Sheet

- (Defined at the top of a play or in site.yml.)

## Top-Level Parameters

| Parameter        | Purpose                                         | Example |
|------------------|-------------------------------------------------|---------|
| `hosts`          | Which inventory group/hosts to target           | `hosts: web` |
| `name`           | Human-readable description of the play          | `name: Configure webservers` |
| `become`         | Escalate privileges (sudo)                      | `become: yes` |
| `become_user`    | User to become                                  | `become_user: root` |
| `gather_facts`   | Collect system info before running tasks         | `gather_facts: no` |
| `vars`           | Inline variable definitions                     | `vars: { timezone: "UTC" }` |
| `vars_files`     | External YAML variable files                     | `vars_files: [vars/common.yml]` |
| `roles`          | Roles applied to this play                      | `roles: [common, web]` |
| `tasks`          | Task list if not using roles                    | `tasks: ...` |
| `handlers`       | Special tasks triggered by `notify`             | `handlers: ...` |
| `tags`           | Labels to filter execution                      | `tags: [patch]` |

---

## Example Play

```yaml
- name: Configure web servers
  hosts: web
  become: yes
  gather_facts: yes
  vars:
    timezone: "UTC"
  roles:
    - role: common
    - role: webserver
```

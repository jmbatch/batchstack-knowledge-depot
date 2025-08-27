# YAML Basics for Ansible

## What is YAML?
- **YAML Ain’t Markup Language** → human-friendly data format.
- Used by Ansible to describe playbooks, inventories, and variables.
- Think of it as **structured indentation**: spaces matter.

---

## Core Rules
- Use **spaces, not tabs**.
- Indentation = structure.
- Strings don’t usually need quotes (only for special chars).

---

## Data Types

### Key-Value
```yaml
package: nginx
```

### Lists
```yaml
packages:
  - curl
  - vim
  - git
```

### Dictionaries (nested structure)
```yaml
service:
  name: nginx
  state: started
```

## Common Pitfalls
1. Tabs break YAML → always use spaces.
2. : needs a space 
   - correct: name: value
   - incorrect: name:value 
3. Strings with : or special chars, wrap in quotes.

## Quick Validation
```bash
yamllint playbook.yml
```


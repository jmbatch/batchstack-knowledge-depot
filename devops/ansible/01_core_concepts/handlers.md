# 📘 Handlers Cheat Sheet

## What are Handlers?

- Special tasks triggered by `notify`
- Only run if a task changes something
- Run once, at the end of the play (per handler)

---

## Example

```yaml
tasks:
  - name: Install nginx
    ansible.builtin.apt:
      name: nginx
      state: present
    notify: Restart nginx

handlers:
  - name: Restart nginx
    ansible.builtin.service:
      name: nginx
      state: restarted
```

## Multiple Notifications

- Multiple tasks can notify the same handler.
- Handler runs once, even if notified multiple times.

## Common Use Cases

- Restarting services after config changes
- Reloading firewalls after rule changes

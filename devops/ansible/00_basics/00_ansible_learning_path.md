# Ansible Learning Path

## Phase 1: Foundations

Goal: Understand what Ansible is, how it works, and run your first playbook.

- Topics:
  - What is Infrastructure as Code (IaC)
  - Ansible architecture (control node, inventory, modules, playbooks)
  - YAML basics (since playbooks are YAML)
  - Ad-hoc commands vs. playbooks
  - Inventory files (static hosts file)

Resources:

- Ansible Docs: Getting Started
  - `https://docs.ansible.com/ansible/latest/getting_started/index.html`
- Red Hat Ansible Basics YouTube
  - `https://www.youtube.com/watch?v=wgQ3rHFTM4E`

## Phase 2: Core Playbook Skills

Goal: Write simple but functional automation.

Topics:

- Tasks & modules (apt, yum, file, copy, service, user, etc.)
- Handlers (restarting services)
- Variables and facts (ansible_facts)
- Templates with Jinja2
- Conditionals & loops
- Tags

Resources:

- Ansible Docs: Playbooks
  - `https://docs.ansible.com/ansible/latest/playbook_guide/playbooks_intro.html`
- FreeCodeCamp Ansible Tutorial (2h full course)
  - `https://www.youtube.com/watch?v=1id6ERvfozo`
- DigitalOcean Tutorial: How To Use Ansible to Automate Initial Server Setup
  - `https://www.digitalocean.com/community/tutorials/how-to-use-ansible-to-automate-initial-server-setup-on-ubuntu-20-04`

## Phase 3: Roles & Structure

Goal: Organize playbooks like a pro.

Topics:

- Directory structure for projects
- Roles (ansible-galaxy init)
- Role dependencies
- Reusability and sharing

Resources:

- Ansible Roles Best Practices
  - `https://docs.ansible.com/ansible/latest/playbook_guide/playbooks_reuse_roles.html`
- Jeff Geerling’s GitHub: Ansible for DevOps Examples
  - `https://github.com/geerlingguy/ansible-for-devops`

## Phase 4: Advanced Features

Goal: Scale automation across many systems.

Topics:

- Dynamic inventory (AWS, GCP, custom scripts)
- Vault (encrypt secrets)
- Error handling (ignore_errors, failed_when)
- Ansible Galaxy (importing roles)
- Ansible Collections
- Ansible Lint & testing with Molecule

Resources:

- Ansible Vault Docs
  - `https://docs.ansible.com/ansible/latest/vault_guide/index.html`
- Molecule Docs (for testing roles)
  - `https://molecule.readthedocs.io/en/latest/`
- Jeff Geerling Ansible 101 Playlist
  - `https://www.youtube.com/watch?v=goclfp6a2IQ&list=PL2_OBreMn7FqZkvMYt6ATmgC0KAGGJNAN`

## Phase 5: Real-World Use Cases

Goal: Apply to your environment (lab or work).

Examples to Try:

- Automate Debian/Ubuntu server patching
- Set up and harden SSH across servers
- Install and configure a web server cluster
- Automate Docker installs and container deployments
- Integrate Ansible with CI/CD pipelines (GitHub Actions, GitLab CI)

Resources:

- ook (Free online): Ansible for DevOps
  - `https://www.ansiblefordevops.com/`
- DigitalOcean’s Community Ansible Tutorials
  - `https://www.digitalocean.com/community/tags/ansible`

## Suggested Weekly Path (6 weeks)

- Week 1: Install Ansible, learn YAML, run ad-hoc commands.
- Week 2: Write small playbooks, manage users, packages, and files.
- Week 3: Add variables, templates, loops, and conditionals.
- Week 4: Learn roles and restructure your playbooks.
- Week 5: Dive into Vault, error handling, collections, linting.
- Week 6: Pick a real project (patch management, app deployment) and automate it end-to-end.

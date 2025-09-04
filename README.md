# Batchstack Knowledge Depot

A curated, working knowledge base for DevOps, Linux, Networking, Databases, Python, React, and VoIP. Organized as topic-focused folders with practical guides, cheatsheets, and step-by-step notes.

Use this README as your quick navigator: jump straight into any area using the links below.

## Quick Navigation

- DevOps
  - Ansible: [devops/ansible/README.md](devops/ansible/README.md)
  - Docker overview: [devops/docker/demystify_docker.md](devops/docker/demystify_docker.md)
  - Docker basics: [devops/docker/00_basics/basic_setup_deb_container.md](devops/docker/00_basics/basic_setup_deb_container.md)
  - Docker images: [devops/docker/00_basics/docker_image_examples.md](devops/docker/00_basics/docker_image_examples.md)
- Linux
  - Sockets overview: [linux/sockets_overview.md](linux/sockets_overview.md)
  - Cheatsheets: [linux/cheatsheets/apt.md](linux/cheatsheets/apt.md), [linux/cheatsheets/ufw.md](linux/cheatsheets/ufw.md), [linux/cheatsheets/user_mgmt.md](linux/cheatsheets/user_mgmt.md)
  - SSH passwordless auth: [linux/ssh/passwordless_ssh_auth.md](linux/ssh/passwordless_ssh_auth.md)
- Git
  - GitHub over HTTPS: [git/setting up_gh_https.md](git/setting up_gh_https.md)
  - Git over SSH: [git/setting_up_git_ssh.md](git/setting_up_git_ssh.md)
- Databases
  - MySQL (Debian/Ubuntu): [databases/mysql/installing_mysql_deb.md](databases/mysql/installing_mysql_deb.md), [databases/mysql/uninstalling_mysql_deb.md](databases/mysql/uninstalling_mysql_deb.md)
  - MariaDB (Debian/Ubuntu): [databases/mariadb/installing_mariadb_deb.md](databases/mariadb/installing_mariadb_deb.md)
- Python
  - Packaging/publishing: [python/building_publishing.md](python/building_publishing.md)
  - Environments: [python/package_env_mgmt.md](python/package_env_mgmt.md), [python/pipx_quick_install.md](python/pipx_quick_install.md)
  - Quality and tooling: [python/code_quality_formatting.md](python/code_quality_formatting.md), [python/testing_and_coverage.md](python/testing_and_coverage.md), [python/debugging_dev_tools.md](python/debugging_dev_tools.md)
  - Performance: [python/performance_and_profiling.md](python/performance_and_profiling.md) and example script [python/cprofile_demo.py](python/cprofile_demo.py)
- React
  - First app guide: [react/first_react_project/step_by_step.md](react/first_react_project/step_by_step.md)
  - Example component: [react/first_react_project/AnsibleToolMap.jsx](react/first_react_project/AnsibleToolMap.jsx)
- NetOps
  - Learning path: [netops/learning_path.md](netops/learning_path.md)
  - Related RFCs: [netops/netops_related_rfc_list.md](netops/netops_related_rfc_list.md)
- VoIP
  - Learning resources: [voip/learning_resources.md](voip/learning_resources.md)
  - RFCs: [voip/voip_related_rfc_list.md](voip/voip_related_rfc_list.md)
  - Asterisk: [voip/asterisk/installing_asterisk_deb.md](voip/asterisk/installing_asterisk_deb.md), [voip/asterisk/uninstalling_asterisk_deb.md](voip/asterisk/uninstalling_asterisk_deb.md)
  - SIPp: [voip/sipp/compiling_sipp_deb.md](voip/sipp/compiling_sipp_deb.md), [voip/sipp/sipp_in_docker.md](voip/sipp/sipp_in_docker.md)
  - Tools: [voip/tools/tools_quick_reference.md](voip/tools/tools_quick_reference.md), [voip/tools/tools_catalogue.md](voip/tools/tools_catalogue.md), [voip/tools/nmap.md](voip/tools/nmap.md)

## Repository Structure

Top-level directories and their purpose:

- [databases/](databases/) — MySQL and MariaDB setup notes for Debian/Ubuntu.
- [devops/](devops/) — Ansible and Docker guides, from basics to advanced.
- [git/](git/) — Git and GitHub connectivity guides.
- [linux/](linux/) — OS-level how-tos and quick references.
- [netops/](netops/) — Networking learning path and RFC lists.
- [python/](python/) — Packaging, tooling, performance, and testing guides.
- [react/](react/) — React learning notes and example component.
- [voip/](voip/) — VoIP resources, Asterisk/SIPp, and tools.

For a full file listing, browse the folders above. Each document is self-contained and can be read independently.

## DevOps: Ansible Highlights

- Getting started: [devops/ansible/00_basics/00_ansible_learning_path.md](devops/ansible/00_basics/00_ansible_learning_path.md)
- Install: [devops/ansible/00_basics/01_installing_ansible.md](devops/ansible/00_basics/01_installing_ansible.md)
- Project setup: [devops/ansible/00_basics/02_setting_Up_a_project.md](devops/ansible/00_basics/02_setting_Up_a_project.md)
- YAML basics: [devops/ansible/00_basics/03_yaml_basics.md](devops/ansible/00_basics/03_yaml_basics.md)
- Inventory: [devops/ansible/00_basics/04_inventory_basics.md](devops/ansible/00_basics/04_inventory_basics.md)
- Ad-hoc vs Playbooks: [devops/ansible/00_basics/05_adhoc_vs_playbooks.md](devops/ansible/00_basics/05_adhoc_vs_playbooks.md)
- Ad-hoc commands: [devops/ansible/00_basics/06_adhoc_commands.md](devops/ansible/00_basics/06_adhoc_commands.md)
- Playbook commands: [devops/ansible/00_basics/07_playbook_commands.md](devops/ansible/00_basics/07_playbook_commands.md)
- Core concepts: [devops/ansible/01_core_concepts/variables_and_facts.md](devops/ansible/01_core_concepts/variables_and_facts.md), [devops/ansible/01_core_concepts/handlers.md](devops/ansible/01_core_concepts/handlers.md), [devops/ansible/01_core_concepts/conditional_loops.md](devops/ansible/01_core_concepts/conditional_loops.md), [devops/ansible/01_core_concepts/playbook_parameters.md](devops/ansible/01_core_concepts/playbook_parameters.md)
- Common modules: [devops/ansible/02_modules/file_module.md](devops/ansible/02_modules/file_module.md), [devops/ansible/02_modules/template_module.md](devops/ansible/02_modules/template_module.md), [devops/ansible/02_modules/package_module.md](devops/ansible/02_modules/package_module.md), [devops/ansible/02_modules/service_module.md](devops/ansible/02_modules/service_module.md)
- Roles: [devops/ansible/03_roles_structure/role_basics.md](devops/ansible/03_roles_structure/role_basics.md), [devops/ansible/03_roles_structure/galaxy_usage.md](devops/ansible/03_roles_structure/galaxy_usage.md), [devops/ansible/03_roles_structure/role_best_practices.md](devops/ansible/03_roles_structure/role_best_practices.md)
- Advanced: [devops/ansible/04_advanced/dynamic_inventory.md](devops/ansible/04_advanced/dynamic_inventory.md), [devops/ansible/04_advanced/vault.md](devops/ansible/04_advanced/vault.md), [devops/ansible/04_advanced/testing_molecule.md](devops/ansible/04_advanced/testing_molecule.md), [devops/ansible/04_advanced/linting.md](devops/ansible/04_advanced/linting.md)
- Real-world: [devops/ansible/05_real_world_examples/docker_install.md](devops/ansible/05_real_world_examples/docker_install.md), [devops/ansible/05_real_world_examples/patching_playbook.md](devops/ansible/05_real_world_examples/patching_playbook.md), [devops/ansible/05_real_world_examples/webserver_setup.md](devops/ansible/05_real_world_examples/webserver_setup.md)
- References: [devops/ansible/99_references/ansible_cfg_cheatsheets.md](devops/ansible/99_references/ansible_cfg_cheatsheets.md), [devops/ansible/99_references/inventory_parameters.md](devops/ansible/99_references/inventory_parameters.md), [devops/ansible/99_references/jinja2_cheats.md](devops/ansible/99_references/jinja2_cheats.md), [devops/ansible/99_references/upgrade_to_backport.md](devops/ansible/99_references/upgrade_to_backport.md)

Helper scripts:

- Bootstrap Ansible hosts in Docker: [devops/ansible/bootstrap_docker_ansible_hosts.sh](devops/ansible/bootstrap_docker_ansible_hosts.sh)
- Initialize an Ansible project scaffold: [devops/ansible/ansible_project_init.sh](devops/ansible/ansible_project_init.sh)

## DevOps: Docker Highlights

- Concepts and demystification: [devops/docker/demystify_docker.md](devops/docker/demystify_docker.md)
- Basics on Debian-based containers: [devops/docker/00_basics/basic_setup_deb_container.md](devops/docker/00_basics/basic_setup_deb_container.md)
- Image examples: [devops/docker/00_basics/docker_image_examples.md](devops/docker/00_basics/docker_image_examples.md)

## How to Use This Repo Efficiently

- Browse by folder: Each directory groups a domain with self-contained notes.
- Use VS Code Markdown preview for best readability.
- Search across the repo when you don't know where to look:

```bash
# ripgrep (recommended)
rg -n "your search terms"

# or grep
grep -Rni "your search terms" .
```

- Prefer deep links when sharing internally so readers land in the exact doc.
- Keep changes small and focused; add new docs rather than bloating existing ones.

## Contribution Guidelines

- File naming:
  - Prefer lowercase with underscores; keep names descriptive.
  - Avoid spaces; where they already exist, consider future cleanup.
- Document style:
  - Start with a short purpose statement at the top of each file.
  - Use headings for structure and tables/lists for quick scanning.
  - Include prerequisites, step lists, verification steps, and troubleshooting.
- Code blocks:
  - Tag blocks with the correct language (bash, yaml, json, etc.).
  - Keep commands copy-paste friendly; avoid machine-specific values when possible.
- Cross-linking:
  - Link to related docs using relative links like [linux/ssh/passwordless_ssh_auth.md](linux/ssh/passwordless_ssh_auth.md).
- Updates:
  - Prefer additive changes; leave a short changelog section at the bottom if a doc is updated frequently.

## Planned Enhancements

- Add lightweight indices per folder (README.md in each top-level area).
- Add tags at top of each note (e.g., Tags: ansible, docker, debian).
- Add a root-level SEARCH.md with advanced grep/rg recipes.
- Optional: Add a docs site generator (e.g., MkDocs) with a simple nav.

## License and Use

Unless a license file is added, treat this repository as All Rights Reserved. Content is provided for personal learning and internal reference; verify commands and adapt to your environment before running in production.

## Acknowledgments

This depot consolidates recurring notes, one-liners, and step-by-step guides captured during hands-on work. Contributions and PRs that improve clarity, organization, and correctness are welcome.

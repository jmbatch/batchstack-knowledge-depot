# Playbook-Level Keywords
- (Defined at the top of a play or in site.yml.)

## Parameter | Meaning | Example
- hosts: Which group(s) or host(s) from inventory this play targets	
  - hosts: web

- name:	Human-friendly description of the play	
  - name: Configure web servers

- become:	Whether to escalate privilege (sudo, etc.)	
  - become: yes

- become_user:	Which user to escalate to	
  - become_user: root

- gather_facts:	Whether to collect facts (ansible_facts) about the system	
  - gather_facts: no

- vars:	Inline variables available to tasks in this play	
  - vars: { timezone: "UTC" }

- vars_files:	External YAML files that define vars	
  - vars_files: [ "vars/common.yml" ]

- roles:	List of roles to apply	
  - roles: [common, ssh_hardening]

- tasks:	List of tasks to run (if not using roles)
  - tasks: ...

- handlers:	Special tasks triggered by notify:	
  - handlers: ...

- tags:	Labels you can use to selectively run parts of a play	
  - tags: [patch]
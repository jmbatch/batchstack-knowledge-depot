# Terraform Project Components Cheat Sheet

## What is a Terraform project?

Terraform project is a directory containing:

- Terraform configuration files written in HCL
- Input variables that make the project reusable
- Outputs that expose useful results
- Providers that let Terraform talk to external systems
- Resources that describe infrastructure objects
- Modules that organize and reuse configuration
- State that tracks what terraform believes exists

The core idea is:

- You described the destired end state, and Terraform calculates the actions needed to reach it.

That means Terraform is primarily:

- Declarative, not imperative
- based on dependency graphs
- driven by state

## Parts of a project

| Component       | What it is                            | Why it matters                                    |
| --------------- | ------------------------------------- | ------------------------------------------------- |
| **HCL**         | Terraform language syntax             | Used to define infrastructure                     |
| **Provider**    | Plugin for a platform/API             | Lets Terraform manage AWS, vSphere, Proxmox, etc. |
| **Resource**    | A real infrastructure object          | VM, network, disk, DNS record, security group     |
| **Data source** | Read-only lookup                      | Query existing infrastructure                     |
| **Variable**    | Input to configuration                | Makes code reusable and configurable              |
| **Output**      | Value exported from configuration     | Shows or passes useful values                     |
| **Local**       | Named local expression                | Helps reduce duplication and simplify logic       |
| **Module**      | Reusable package of Terraform code    | Organizes and standardizes deployments            |
| **State file**  | Terraform’s record of managed objects | Critical for tracking reality vs desired config   |
| **Backend**     | Where state is stored                 | Local file or remote storage                      |
| **Plan**        | Execution preview                     | Shows what Terraform will do                      |
| **Apply**       | Actual execution                      | Creates, changes, or destroys resources           |

## Common Terraform files and their purpose

Terraform does not strictly require certain filenames except for special cases like `terraform.tfvars`, but these are commmon conventions.

*main.tf*
Usually the primary file where the main infrastructure objects are defined.

Typical contents:

- resources
- data sources
- module calls
- locals
- sometimes provider configurations

Example:

```bash
resource "vsphere_virtual_machine" "web01" {
  name             = "web-01"
  num_cpus         = 2
  memory           = 4096
  datastore_id     = data.vsphere_datastrore.datastore.id
  resource_pool_id = data.vsphere_compute_cluster.cluster.resouce_pool_id
}
```

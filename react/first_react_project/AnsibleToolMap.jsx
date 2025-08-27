import { useMemo } from "react";
import { ArrowRight, Boxes, Cog, PlayCircle, Eye, Network, Database, GitBranch, Server, FlaskConical, Layers, Wrench } from "lucide-react";
import { Card, CardContent } from "@/components/ui/card";
import { Badge } from "@/components/ui/badge";

// Simple helper components
const Col = ({ title, icon: Icon, color = "", items = [], note }) => (
  <div className="flex flex-col gap-3 min-w-[260px]">
    <div className="flex items-center gap-2">
      <Icon className={`h-5 w-5 ${color}`} />
      <h2 className="text-lg font-semibold tracking-tight">{title}</h2>
    </div>
    <Card className="rounded-2xl shadow-sm border border-gray-200">
      <CardContent className="p-4 flex flex-col gap-2">
        {items.map((it, i) => (
          <div key={i} className="flex items-start justify-between gap-3">
            <div>
              <div className="font-medium leading-tight">{it.name}</div>
              {it.desc && (
                <div className="text-sm text-muted-foreground leading-snug">{it.desc}</div>
              )}
            </div>
            {it.badge && <Badge>{it.badge}</Badge>}
          </div>
        ))}
        {note && <div className="text-xs text-muted-foreground pt-1">{note}</div>}
      </CardContent>
    </Card>
  </div>
);

const Arrow = () => (
  <div className="hidden xl:flex items-center justify-center">
    <ArrowRight className="w-8 h-8" />
  </div>
);

export default function AnsibleToolMap() {
  const cols = useMemo(
    () => [
      {
        title: "Provision (Make Infra)",
        icon: Boxes,
        color: "text-blue-600",
        items: [
          { name: "Terraform", desc: "Create/cloud infra; outputs feed inventory" },
          { name: "Packer", desc: "Bake images; Ansible as provisioner", badge: "Images" },
        ],
        note: "IaC layer → produces hosts & variables",
      },
      {
        title: "Inventory & Sources",
        icon: Database,
        color: "text-amber-600",
        items: [
          { name: "Dynamic Inventory", desc: "aws_ec2, azure_rm, gcp, vmware" },
          { name: "CMDB / Git", desc: "Host vars, group vars, outputs" },
        ],
        note: "Tells Ansible what to target",
      },
      {
        title: "Configure (Ansible)",
        icon: Cog,
        color: "text-emerald-600",
        items: [
          { name: "ansible-core", desc: "Playbooks, roles, collections" },
          { name: "Galaxy / Collections", desc: "community.general, ansible.posix" },
          { name: "Mitogen (opt)", desc: "Speed up connections (caveats)" },
        ],
        note: "Idempotent config & orchestration",
      },
      {
        title: "Test & Quality",
        icon: FlaskConical,
        color: "text-purple-600",
        items: [
          { name: "Molecule", desc: "Role testing in Docker/VMs" },
          { name: "ansible-lint", desc: "Static checks & best practices" },
          { name: "Pre-commit", desc: "Auto-run lint & yamllint" },
        ],
        note: "Shift-left validation",
      },
      {
        title: "Orchestrate & Run",
        icon: PlayCircle,
        color: "text-pink-600",
        items: [
          { name: "AWX / AAP", desc: "RBAC, schedules, surveys, workflows", badge: "GUI" },
          { name: "Execution Environments", desc: "Containerized runtimes (ansible-builder)" },
          { name: "Semaphore / Rundeck", desc: "Lightweight UIs & job runners" },
        ],
        note: "Team-friendly automation",
      },
      {
        title: "Observe & Audit",
        icon: Eye,
        color: "text-cyan-600",
        items: [
          { name: "ARA Records Ansible", desc: "DB + web UI for run history" },
          { name: "Controller Logs", desc: "Centralized artifacts, callbacks" },
        ],
        note: "Who did what, when, where",
      },
      {
        title: "Network & VoIP Adjacent",
        icon: Network,
        color: "text-slate-700",
        items: [
          { name: "Nornir", desc: "Python-native network automation" },
          { name: "Net Collections", desc: "community.network, cisco.ios, junipernetworks.junos" },
        ],
        note: "Great for SIP/RTP lab plumbing",
      },
    ],
    []
  );

  return (
    <div className="w-full min-h-screen p-6 md:p-10 bg-white">
      <div className="max-w-[1400px] mx-auto flex flex-col gap-6">
        <header className="flex items-center justify-between">
          <div>
            <h1 className="text-2xl md:text-3xl font-bold tracking-tight">Ansible Tool Map</h1>
            <p className="text-sm md:text-base text-muted-foreground mt-1">
              From infrastructure provisioning → configuration → orchestration → observability. Use Terraform/Packer to build, Ansible to configure, AWX/AAP to operate, and ARA to learn from runs.
            </p>
          </div>
          <div className="hidden md:flex items-center gap-2">
            <Badge variant="secondary" className="text-xs">IaC</Badge>
            <Badge variant="secondary" className="text-xs">CM</Badge>
            <Badge variant="secondary" className="text-xs">CI</Badge>
            <Badge variant="secondary" className="text-xs">Ops</Badge>
          </div>
        </header>

        {/* Flow Row */}
        <div className="hidden xl:grid grid-cols-[repeat(13,_minmax(0,1fr))] gap-4 items-stretch">
          {/* Provision */}
          <div className="col-span-2"><Col {...cols[0]} /></div>
          <Arrow />
          {/* Inventory */}
          <div className="col-span-2"><Col {...cols[1]} /></div>
          <Arrow />
          {/* Configure */}
          <div className="col-span-2"><Col {...cols[2]} /></div>
          <Arrow />
          {/* Test */}
          <div className="col-span-2"><Col {...cols[3]} /></div>
          <Arrow />
          {/* Orchestrate */}
          <div className="col-span-2"><Col {...cols[4]} /></div>
          <Arrow />
          {/* Observe */}
          <div className="col-span-2"><Col {...cols[5]} /></div>
        </div>

        {/* Stacked for smaller screens */}
        <div className="xl:hidden flex flex-col gap-6">
          {cols.slice(0, 6).map((c, i) => (
            <div key={i} className="flex flex-col gap-2">
              <Col {...c} />
              {i < 5 && (
                <div className="flex items-center justify-center">
                  <ArrowRight className="w-7 h-7" />
                </div>
              )}
            </div>
          ))}
        </div>

        {/* Adjacent area */}
        <section className="mt-2">
          <div className="grid md:grid-cols-2 gap-6">
            <Card className="rounded-2xl border-dashed">
              <CardContent className="p-5">
                <div className="flex items-center gap-2 mb-2">
                  <Layers className="h-5 w-5" />
                  <h3 className="font-semibold">Where things fit</h3>
                </div>
                <ul className="list-disc list-inside text-sm text-muted-foreground space-y-1">
                  <li><strong>Terraform</strong> builds infra → exports host data → consumed by <strong>Dynamic Inventory</strong>.</li>
                  <li><strong>Packer</strong> bakes base images where <strong>Ansible</strong> can provision software.</li>
                  <li><strong>Ansible</strong> applies roles/collections; quality gated by <strong>Molecule</strong> + <strong>ansible-lint</strong>.</li>
                  <li><strong>AWX/AAP</strong> runs jobs in <strong>Execution Environments</strong>; <strong>ARA</strong> records results.</li>
                  <li><strong>Nornir</strong> complements Ansible for Python-first network tasks.</li>
                </ul>
              </CardContent>
            </Card>

            <Card className="rounded-2xl">
              <CardContent className="p-5">
                <div className="flex items-center gap-2 mb-2">
                  <Wrench className="h-5 w-5" />
                  <h3 className="font-semibold">CLI Snippets</h3>
                </div>
                <pre className="text-xs bg-gray-50 rounded-xl p-4 overflow-x-auto border">
{`# Dynamic inventory example (AWS EC2)
ansible-inventory -i aws_ec2.yml --graph

# Molecule quickstart for a role
pipx install molecule ansible-lint
molecule init role my_role -d docker
molecule test

# Build an execution environment
pipx install ansible-builder
ansible-builder build -t ee:latest

# Enable ARA
pipx install ara
export ARA_API_CLIENT="http"
export ARA_API_SERVER="http://127.0.0.1:8000"
ara-manage runserver 0.0.0.0:8000`}
                </pre>
              </CardContent>
            </Card>
          </div>
        </section>
      </div>
    </div>
  );
}

# Microsoft.Logic/autoProjects — Design Summary

## Overview

The `AutoProject` resource is a new ARM resource type under the `Microsoft.Logic` resource provider. An AutoProject is a logical grouping that **owns and manages** multiple Azure Container Apps of kind `workflowapp`. It provides a single entry point for lifecycle management, shared configuration, and coordinated operations across all auto apps in the auto project.

## Resource Path

```
/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Logic/autoProjects/{autoProjectName}
```

## Design Decision: Option C — Hybrid (Managed-By) Model

We evaluated three approaches and selected **Option C**:

| Option | Description | Decision |
|--------|-------------|----------|
| **A — Reference Model** | AutoProject holds ARM resource IDs pointing to existing ContainerApps. Loose grouping with no ownership. | **Rejected.** Dangling references are possible — if a ContainerApp is deleted independently, the AutoProject has stale references with no enforcement. We do not want dangling resources. |
| **B — Child Resource Model** | ContainerApps are child resources of AutoProject (`Microsoft.Logic/autoProjects/{name}/autoApps/{name}`). | **Rejected.** We do not want to create a new resource type. ContainerApps already exist under `Microsoft.App/containerApps` and we should reuse that infrastructure. |
| **C — Hybrid (Managed-By) Model** | AutoProject owns ContainerApps via the ARM `managedBy` property. Each managed ContainerApp has `managedBy` set to the AutoProject's resource ID. | **Selected.** True ownership, cascading lifecycle, and no new resource types. |

### Key Benefits of Option C

- **True ownership** — `managedBy` on each ContainerApp prevents accidental deletion and enforces single-owner semantics.
- **Cascading lifecycle** — Deleting an AutoProject deletes all its managed ContainerApps. Start/stop operations cascade to all auto apps.
- **No new resource types** — Reuses existing `Microsoft.App/containerApps` with `kind: "workflowapp"`.
- **Single entry point** — Users manage everything through the `Microsoft.Logic/autoProjects` API.

## Resource Model

### AutoProject (TrackedResource)

```
├── name: string (pattern: ^[a-zA-Z0-9][a-zA-Z0-9-_]{0,62}[a-zA-Z0-9]$)
├── location: string
├── tags: Record<string>
├── identity?: ManagedServiceIdentity
└── properties: AutoProjectProperties
    ├── provisioningState (read-only): AutoProjectProvisioningState
    ├── createdTime (read-only): utcDateTime
    ├── changedTime (read-only): utcDateTime
    └── description?: string
```

### AutoAppReference (returned by listAutoApps action)

```
├── resourceId: string (ARM resource ID of Microsoft.App/containerApps)
├── displayName?: string
├── provisioningState (read-only): AutoAppProvisioningState
└── runningState (read-only): AutoAppRunningState
```

### Relationship to ContainerApp

Each managed ContainerApp (under `Microsoft.App/containerApps`):
- Has `kind` set to `"workflowapp"`
- Has `managedBy` set to the AutoProject's ARM resource ID
- Can be in any managed environment (the environment is a property of the ContainerApp, not the AutoProject)

> **Design note — `environmentId` removed:** An earlier design included `environmentId` on the AutoProject to specify the managed environment. This was removed because an AutoProject may manage ContainerApps across multiple managed environments. Each ContainerApp already knows its environment via its own resource definition, so duplicating it on the AutoProject would be redundant and artificially restrictive.

> **Design note — `autoApps` moved to dedicated action:** Rather than embedding the auto apps array as a read-only property on `AutoProjectProperties`, the managed apps are discovered via a dedicated `listAutoApps` POST action. This keeps the resource representation lightweight (auto apps are not returned on every GET/LIST) and separates the concerns of lifecycle management from discovery. The `managedBy` relationship is implemented by the `Microsoft.App` resource provider — our action queries which ContainerApps have `managedBy` set to this AutoProject's resource ID.

```
Microsoft.Logic/autoProjects/myAutoProject
  └── manages:
      ├── Microsoft.App/containerApps/workflow1 (kind: workflowapp, managedBy: .../autoProjects/myAutoProject)
      ├── Microsoft.App/containerApps/workflow2 (kind: workflowapp, managedBy: .../autoProjects/myAutoProject)
      └── Microsoft.App/containerApps/workflow3 (kind: workflowapp, managedBy: .../autoProjects/myAutoProject)
```

## Operations

### CRUD Operations

| Operation | Method | Async? | Description |
|-----------|--------|--------|-------------|
| Get | GET | No | Gets an auto project |
| CreateOrUpdate | PUT | Yes (LRO) | Creates or updates an auto project. Provisions managed ContainerApps and sets `managedBy` on each. |
| Update | PATCH | Yes (LRO) | Updates an auto project using JSON Merge Patch |
| Delete | DELETE | Yes (LRO) | Deletes an auto project and all managed ContainerApps (cascading delete) |
| ListByResourceGroup | GET | No | Lists auto projects in a resource group |
| ListBySubscription | GET | No | Lists auto projects in a subscription |

### Custom Actions

| Action | Method | Path | Async? | Description |
|--------|--------|------|--------|-------------|
| ListAutoApps | POST | `.../autoProjects/{name}/listAutoApps` | No | Lists the ContainerApps (kind `workflowapp`) managed by this auto project. Returns `AutoAppListResult` with pagination. |

> **Design note — `configuration` removed:** An earlier design included `AutoProjectConfiguration` with shared secrets, access control rules, and a workload profile name at the AutoProject level, along with a `deployConfiguration` action to push them to all apps. This was removed because each ContainerApp (`Microsoft.App/containerApps`) already has its own secrets, ingress/IP restrictions, and workload profile settings. Duplicating these at the AutoProject level creates ambiguity about which configuration takes precedence and adds unnecessary sync complexity. The AutoProject is a **lifecycle orchestrator**, not a configuration manager — each app manages its own configuration independently.

## Enums / Unions

| Name | Values |
|------|--------|
| AutoProjectProvisioningState | InProgress, Succeeded, Failed, Canceled, Deleting |
| AutoAppProvisioningState | InProgress, Succeeded, Failed, Canceled, Deleting |
| AutoAppRunningState | Running, Stopped, Unknown |

## API Version

New preview API version: `2026-01-01-preview`

## Directory Structure

This TypeSpec project is a standalone service directory for the AutoProject resource only. The existing Logic Apps swagger specifications remain untouched in the sibling `Logic/` directory:

```
specification/logic/resource-manager/Microsoft.Logic/
├── Logic/                               ← TypeSpec project + generated swagger
│   ├── main.tsp                         ← Entry point (namespace, version)
│   ├── AutoProject.tsp                  ← Resource definition and operations
│   ├── autoProjectModels.tsp            ← Models, unions, types
│   ├── tspconfig.yaml                   ← Compiler and emitter config
│   ├── readme.md                        ← AutoRest readme with tags
│   ├── AUTOPROJECT-DESIGN.md            ← This design document
│   ├── examples/2026-01-01-preview/     ← Source example files
│   └── preview/2026-01-01-preview/      ← Generated OpenAPI output
│       ├── logic.json
│       └── examples/
```

## Files

| File | Description |
|------|-------------|
| `AutoProject.tsp` | AutoProject resource definition and operations interface |
| `autoProjectModels.tsp` | All models, unions, and types for the AutoProject resource |
| `main.tsp` | Entry point with API version and namespace declaration |

## Cross-RP Dependencies

| Dependency | Description |
|------------|-------------|
| `Microsoft.App` | The AutoProject RP must call `Microsoft.App/containerApps` APIs to create, update, start, stop, and delete managed ContainerApps. |
| `managedBy` contract | The `Microsoft.App` RP must implement `managedBy` support on `Microsoft.App/containerApps`. This means Microsoft.App sets and honors the `managedBy` property to prevent direct deletion of managed ContainerApps in complete mode deployments. |

> **Note:** The `managedBy` property on ContainerApps is **implemented by the Microsoft.App resource provider**, not by Microsoft.Logic. Our AutoProject spec defines the `listAutoApps` action to query which ContainerApps are managed, but the actual `managedBy` field enforcement is Microsoft.App's responsibility.

## `managedBy` Contract — Enforcement Details

### What `managedBy` is

`managedBy` is a top-level ARM resource property (type: string) containing the ARM resource ID of the resource that owns/manages this resource. For AutoProject, each managed ContainerApp has:

```json
{
  "managedBy": "/subscriptions/.../providers/Microsoft.Logic/autoProjects/myAutoProject"
}
```

### What ARM enforces automatically

The ARM platform provides built-in behavior for resources with `managedBy` set — no RP cooperation required:

| Behavior | Description |
|----------|-------------|
| **Complete-mode deployment protection** | When deploying an ARM template in complete mode, ARM normally deletes resources not in the template. Resources with `managedBy` set are **skipped** — ARM will not delete them unless the managing resource is also being deleted. |
| **Resource group delete ordering** | When deleting a resource group, ARM uses `managedBy` to determine deletion order, deleting the managing resource first to allow cascading cleanup. |

### What `managedBy` does NOT enforce

ARM does **not** automatically block direct API calls to a managed resource. A user with `Microsoft.App/containerApps/delete` RBAC permission can still call `DELETE` directly on a managed ContainerApp via the REST API. `managedBy` is not a security boundary — it is an ownership signal.

### Accidental delete protection (recommended approach)

For preventing accidental deletion, `Microsoft.App` does not need to differentiate between user calls and `Microsoft.Logic` RP calls. It simply checks the resource state:

1. User calls `DELETE` on a ContainerApp
2. `Microsoft.App` RP checks: *does this resource have `managedBy` set?*
3. If yes → return `409 Conflict` with message: *"This resource is managed by {managedBy}. Delete it through the managing resource instead."*
4. If no → proceed with normal deletion

This is the same pattern `Microsoft.Compute` uses for managed disks — deleting an attached disk returns an error referencing the owning VM, regardless of who is calling.

### How Microsoft.Logic performs cascading delete

When an AutoProject is deleted and needs to delete its managed ContainerApps, there are three possible approaches:

| Approach | Description |
|----------|-------------|
| **Clear-then-delete** | Microsoft.Logic calls `PATCH` to set `managedBy = null` on the ContainerApp, then calls `DELETE`. Two-step process. |
| **Internal ARM header** | ARM injects internal headers (e.g., `x-ms-arm-resource-system-data`) that RPs can trust because they pass through the ARM front door. Microsoft.App can use this to allow cascading deletes. |
| **Force-delete parameter** | Microsoft.App exposes a `?force=true` query parameter that bypasses the `managedBy` check, available only to first-party service-to-service callers. |

### Caller identity — can users spoof RP calls?

| Scenario | Can user simulate? | Why |
|----------|-------------------|-----|
| **User token passthrough** | Yes | If Microsoft.Logic forwards the user's bearer token to Microsoft.App, the user already has that token and can call Microsoft.App directly |
| **First-party service principal** | No | If Microsoft.Logic uses its own AAD app identity, the user cannot obtain those credentials |
| **Internal ARM headers** | No | ARM injects these at the platform level; users cannot add trusted internal headers |

For AutoProject's use case (accidental delete protection), caller differentiation is **not needed**. The `managedBy` state check on the resource itself is sufficient.

### Stronger enforcement options (if needed in the future)

If full lockdown is ever required (preventing all direct user mutation of managed ContainerApps), these mechanisms are available:

| Mechanism | Strength | Description |
|-----------|----------|-------------|
| **RBAC** | Strong | Don't grant users `Microsoft.App/containerApps/write` or `delete`. Only grant `Microsoft.Logic/autoProjects/*`. The Logic RP's service principal gets App permissions via cross-RP RBAC. |
| **Deny assignments** | Strongest | ARM deny assignments block all principals except the managing RP's identity. Used by Azure Managed Applications. |
| **Portal/CLI guardrails** | UX-level | Azure Portal reads `managedBy` and shows warnings; CLI can surface similar guidance. |

### Azure services using `managedBy` for reference

| Service | Managing Resource → Managed Resource | Enforcement Level |
|---------|--------------------------------------|-------------------|
| **Managed Disks** | VM → Disk | Strong (delete blocked while attached) |
| **VMSS Flex** | VMSS → VM | Soft (ARM deployment protection + RG delete optimization) |
| **Managed Applications** | Application → Resources in managed RG | Strongest (deny assignments) |
| **AKS Mesh** | Parent Resource → MeshMembership | Soft (ARM deployment protection) |

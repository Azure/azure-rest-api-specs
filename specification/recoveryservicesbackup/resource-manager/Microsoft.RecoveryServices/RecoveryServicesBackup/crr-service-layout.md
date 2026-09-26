# CRR Service Layout and Migration Notes

This document records the service-group investigation, the relevant repository guidance, the
learnings carried forward from the first CRR migration, and a recommended layout for migrating the
Cross Region Restore (CRR) surface.

## Executive decision

CRR should be an independently versioned service beside the existing Recovery Services Backup
service, under the same organization and Resource Provider namespace:

```text
specification/recoveryservicesbackup/
└── resource-manager/
    └── Microsoft.RecoveryServices/
        ├── RecoveryServicesBackup/
        └── RecoveryServicesBackupCrr/
```

The recommended CRR project root is therefore:

```text
specification/recoveryservicesbackup/resource-manager/Microsoft.RecoveryServices/RecoveryServicesBackupCrr
```

Do not copy the additional `Network/Network` nesting from the Network example. That layout works and
is useful for understanding independently compiled TypeSpec projects with shared definitions, but it
is a legacy grouping pattern. Current repository guidance requires each ARM service to be a direct
child of its Resource Provider namespace.

## What the Network example does

The investigated source is:

```text
https://github.com/Azure/azure-rest-api-specs-pr/tree/main/specification/network/resource-manager/Microsoft.Network/Network
```

The same structure already exists in this repository at:

```text
D:\github\azure-rest-api-specs\specification\network\resource-manager\Microsoft.Network\Network
```

Its important parts are:

```text
Network/
├── Common/
│   └── main.tsp
├── Network/
│   ├── main.tsp
│   ├── service.yaml
│   └── tspconfig.yaml
├── Vmss/
│   ├── main.tsp
│   ├── service.yaml
│   └── tspconfig.yaml
├── client.tsp
├── readme.md
└── tspconfig.yaml
```

The pattern demonstrates the following:

1. `Network` and `Vmss` are separate TypeSpec entry points.
2. Each service has its own `main.tsp`, `tspconfig.yaml`, `service.yaml`, examples, and emitted
   OpenAPI destination.
3. Each service can have its own API versions. `Network` currently models newer Network versions,
   while `Vmss` models `2018-10-01`.
4. `Common/main.tsp` defines a versioned `Common` namespace and shared models.
5. Both service projects import definitions from `../Common`.
6. The main Network emitter uses `output-splitting: "legacy-feature-files"` to retain its historical
   multi-file Swagger shape.

### Network files reviewed

| Purpose | Full local path |
|---|---|
| Grouping directory | `D:\github\azure-rest-api-specs\specification\network\resource-manager\Microsoft.Network\Network` |
| Shared TypeSpec entry point | `D:\github\azure-rest-api-specs\specification\network\resource-manager\Microsoft.Network\Network\Common\main.tsp` |
| Main Network service entry point | `D:\github\azure-rest-api-specs\specification\network\resource-manager\Microsoft.Network\Network\Network\main.tsp` |
| Main Network emitter configuration | `D:\github\azure-rest-api-specs\specification\network\resource-manager\Microsoft.Network\Network\Network\tspconfig.yaml` |
| Main Network service metadata | `D:\github\azure-rest-api-specs\specification\network\resource-manager\Microsoft.Network\Network\Network\service.yaml` |
| VMSS service entry point | `D:\github\azure-rest-api-specs\specification\network\resource-manager\Microsoft.Network\Network\Vmss\main.tsp` |
| VMSS emitter configuration | `D:\github\azure-rest-api-specs\specification\network\resource-manager\Microsoft.Network\Network\Vmss\tspconfig.yaml` |
| VMSS service metadata | `D:\github\azure-rest-api-specs\specification\network\resource-manager\Microsoft.Network\Network\Vmss\service.yaml` |

## Repository guidance that already covers this

The following documentation is present in this repository:

| Guidance | Full local path | Relevant rule |
|---|---|---|
| Directory structure | `D:\github\azure-rest-api-specs\documentation\directory-structure.md` | ARM services belong at `specification/<organization>/resource-manager/<RPNS>/<service>`. Extra grouping and mixed nested structures are deprecated. |
| Uniform versioning | `D:\github\azure-rest-api-specs\documentation\uniform-versioning.md` | Each service versions uniformly within its own scope; sibling services may version independently. |
| Terminology | `D:\github\azure-rest-api-specs\documentation\glossary.md` | A service is a set of operations that versions uniformly in perpetuity. |

The directory guidance also says definitions shared beyond repository-wide `common-types` should not
be consumed through arbitrary cross-service imports. The recommended ownership model is:

1. One service owns definitions in a `sharable/` folder.
2. A consuming sibling keeps copied definitions in a `copyFrom*Sharable/` folder.
3. The consuming service remains independently compilable and independently versioned.

This differs from the older Network `../Common/main.tsp` import pattern and is the approach new CRR
work should follow.

## Learnings carried forward from the first CRR migration

All Markdown files from the first CRR project have been retained on this branch.

| File | Full local path | What it contains |
|---|---|---|
| CRR questions and meeting notes | `D:\github\azure-rest-api-specs\specification\recoveryservicesbackupcrr\resource-manager\Microsoft.RecoveryServices\RecoveryServicesBackupCrr\questions.md` | Service-boundary questions, source Swagger, conversion method, and migration rationale. |
| Suppression analysis | `D:\github\azure-rest-api-specs\specification\recoveryservicesbackupcrr\resource-manager\Microsoft.RecoveryServices\RecoveryServicesBackupCrr\suppressions-vs-active-stamp.md` | Detailed TypeSpec and emitted-Swagger suppression analysis, including validation experiments. |
| CRR AutoRest configuration | `D:\github\azure-rest-api-specs\specification\recoveryservicesbackupcrr\resource-manager\Microsoft.RecoveryServices\RecoveryServicesBackupCrr\readme.md` | Package configuration and curated LintDiff suppression reasons for the faithful CRR contract. |
| Consolidated layout guide | `D:\github\azure-rest-api-specs\specification\recoveryservicesbackup\resource-manager\Microsoft.RecoveryServices\RecoveryServicesBackup\crr-service-layout.md` | This investigation and the recommended second-migration layout. |
| Python SDK lineage | `D:\github\azure-rest-api-specs\specification\recoveryservicesbackup\resource-manager\Microsoft.RecoveryServices\RecoveryServicesBackup\recoveryservicesbackup-sdk-lineage.md` | Pre-TypeSpec Active/Passive batch generation, the 2025 package split, TypeSpec SDK generation, and Azure CLI compatibility impact. |

Repository-relative paths should be used in reviews and pull-request descriptions:

```text
specification/recoveryservicesbackupcrr/resource-manager/Microsoft.RecoveryServices/RecoveryServicesBackupCrr/questions.md
specification/recoveryservicesbackupcrr/resource-manager/Microsoft.RecoveryServices/RecoveryServicesBackupCrr/suppressions-vs-active-stamp.md
specification/recoveryservicesbackupcrr/resource-manager/Microsoft.RecoveryServices/RecoveryServicesBackupCrr/readme.md
specification/recoveryservicesbackup/resource-manager/Microsoft.RecoveryServices/RecoveryServicesBackup/crr-service-layout.md
specification/recoveryservicesbackup/resource-manager/Microsoft.RecoveryServices/RecoveryServicesBackup/recoveryservicesbackup-sdk-lineage.md
```

## Recommended CRR implementation

### 1. Correct the organization boundary

The first migration used a new top-level organization:

```text
specification/recoveryservicesbackupcrr/
```

CRR is owned with Recovery Services Backup and uses the same `Microsoft.RecoveryServices` RP
namespace. The second migration should place it in the existing `recoveryservicesbackup`
organization, as a sibling service:

```text
specification/recoveryservicesbackup/resource-manager/Microsoft.RecoveryServices/RecoveryServicesBackupCrr/
```

### 2. Keep CRR independently compilable

`RecoveryServicesBackupCrr` should contain its own:

```text
RecoveryServicesBackupCrr/
├── main.tsp
├── tspconfig.yaml
├── service.yaml
├── client.tsp
├── models.tsp
├── routes.tsp
├── back-compatible.tsp
├── examples/
├── stable/
├── readme.md
├── sdk-suppressions.yaml
└── suppressions.yaml
```

The exact resource-specific `.tsp` files from the first migration can be moved with the project.

This preserves:

- a distinct `@service` title for CRR;
- an independent `Versions` enum;
- a distinct SDK package and namespace per language;
- an independent `service.yaml`;
- CRR-specific compatibility customizations and suppressions;
- the existing `Microsoft.RecoveryServices` ARM provider namespace.

### 3. Do not move the active service

The existing active-stamp project should remain at:

```text
specification/recoveryservicesbackup/resource-manager/Microsoft.RecoveryServices/RecoveryServicesBackup/
```

Moving it into another nested folder solely to imitate `Network/Network` would create a large,
unnecessary path migration and would reproduce a deprecated layout.

### 4. Start self-contained; share deliberately later

For the first CRR PR, prefer fidelity and isolation over deduplication:

- keep the CRR models required to reproduce the frozen passive-stamp contract inside the CRR service;
- do not directly import `../RecoveryServicesBackup/models.tsp`;
- do not create a shared namespace whose versioning silently couples Active Backup and CRR;
- compare duplicated models, but retain the CRR copy when wire shapes or API-version history differ.

If genuine shared definitions must later have one owner, use the documented copy pattern:

```text
RecoveryServicesBackup/
└── sharable/

RecoveryServicesBackupCrr/
└── copyFromRecoveryServicesBackupSharable/
```

Any copy update must be reviewed as an explicit CRR API-version change.

### 5. Preserve independent uniform versioning

The active and passive stamps may use different API versions because they are separate services.
Within the CRR service, however, every operation emitted for one version must use that same version,
and its `readme.md`, generated Swagger, examples, and SDK package must describe the complete CRR
surface for that version.

The first migration's `2026-07-15` surface can remain the initial CRR service version if that version
is still the intended release target.

### 6. Preserve the faithful-contract work

The following first-migration decisions remain applicable after relocating the service:

- preserve the frozen `2023-01-15` passive-stamp wire shapes;
- retain the reviewed TypeSpec linter disables and emitted-Swagger LintDiff suppressions;
- preserve tags, discriminators, pagination behavior, response codes, legacy paths, and LRO headers;
- keep active-stamp-only resources and operations out of the CRR service;
- keep CRR SDK names distinct from the existing Recovery Services Backup package.

Folder relocation must not be combined with contract cleanup. Structural correctness and wire
compatibility should be reviewed separately.

## Proposed migration sequence

1. Create `RecoveryServicesBackupCrr` beside `RecoveryServicesBackup`.
2. Move the first migration's TypeSpec source, examples, configurations, and generated Swagger into
   the sibling service folder.
3. Update relative paths in `tspconfig.yaml`, especially `arm-types-dir`.
4. Update any repository metadata or service discovery references to the new project root.
5. Confirm `service.yaml` lists the emitted CRR version and Swagger file.
6. Validate TypeSpec compilation and compare the emitted Swagger against the reviewed first-migration
   output.
7. Run the CRR SDK generation checks using its distinct emitter package names.
8. Remove the temporary top-level `specification/recoveryservicesbackupcrr` organization only after
   all useful documentation and migration artifacts have moved.

## Review questions to settle before implementation

1. Is CRR formally approved as a separate uniformly versioned service and SDK package?
2. Is `2026-07-15` still the intended first TypeSpec-emitted CRR API version?
3. Which service owns any models that are truly shared between Active Backup and CRR?
4. Should the three carried-forward Markdown files move into the new sibling service folder in the
   implementation PR?
5. Which final per-language CRR package names have SDK owner approval?

These are approval and ownership questions; they do not change the recommended repository layout.

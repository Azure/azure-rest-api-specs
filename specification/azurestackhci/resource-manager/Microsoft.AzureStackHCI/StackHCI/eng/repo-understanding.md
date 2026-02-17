# Repository Understanding - Azure Stack HCI TypeSpec

## Overview

This document captures the understanding of the Azure Stack HCI TypeSpec private repository structure, conventions, and key information for maintaining and extending the API definitions.

## Repository Locations

| Repository | Path | Branch |
|------------|------|--------|
| **Private** | `c:\pvt\specs\specification\azurestackhci\resource-manager\Microsoft.AzureStackHCI\StackHCI` | RPSaaSMaster |
| **Public** | `C:\pb\specs\specification\azurestackhci\resource-manager\Microsoft.AzureStackHCI\StackHCI` | main |

## Repository Structure

```
StackHCI/
├── main.tsp              # Main entry point, version definitions
├── models.tsp            # Shared models, enums, and types
├── commonModels.tsp      # CVM and SDN common models
├── client.tsp            # Python SDK configuration
├── Cluster.tsp           # Cluster resource and operations
├── ArcSetting.tsp        # ArcSetting resource
├── clusterJobs.tsp       # Cluster jobs resource
├── devicePool.tsp        # Device pool resource
├── edgeMachine.tsp       # Edge machine resource
├── edgeMachineJobs.tsp   # Edge machine jobs
├── DeploymentSetting.tsp # Deployment settings
├── EdgeDevice.tsp        # Edge device resource
├── EdgeDeviceJob.tsp     # Edge device jobs
├── Extension.tsp         # Extension resource
├── kubernetesVersions.tsp # Kubernetes versions
├── osImages.tsp          # OS images
├── platformUpdates.tsp   # Platform updates
├── updateContents.tsp    # Update contents
├── Publisher.tsp         # Publisher resource
├── Offer.tsp             # Offer resource
├── Sku.tsp               # SKU resource
├── SecuritySetting.tsp   # Security settings
├── Update.tsp            # Update resource
├── UpdateRun.tsp         # Update run resource
├── UpdateSummaries.tsp   # Update summaries
├── ValidatedSolutionRecipe.tsp # Validated solution recipes
├── validateOwnershipVouchers.tsp # Ownership voucher validation
├── back-compatible.tsp   # Backward compatibility
├── Operations.tsp        # Operations
├── eng/                  # Engineering docs
│   ├── private-repo-differences.md
│   └── repo-understanding.md (this file)
├── examples/             # Example JSON files
├── preview/              # Preview version outputs
├── stable/               # Stable version outputs
├── private-preview/      # Private preview TSP files
└── backlog/              # Backlog TSP files (not imported)
```

## API Versions

### Current Versions (Private Repo)

| Version | Type | Enum Name |
|---------|------|-----------|
| `2026-02-01` | GA | `v2026_02_01` |
| `2026-03-15-preview` | Preview | `v2026_03_15_preview` |

### Current Versions (Public Repo)

| Version | Type | Enum Name |
|---------|------|-----------|
| `2026-02-01` | GA | `v2026_02_01` |
| `2026-03-01-preview` | Preview | `v2026_03_01_preview` |

## Versioning Annotations

### `@added` Decorator
Used to mark when a feature was added. Features with `@added(Versions.v2026_03_15_preview)` only appear in the preview version.

```typespec
@added(Versions.v2026_03_15_preview)
model NewFeature {
  ...
}
```

### `@@added` Augment Decorator  
Used when the property is defined elsewhere (e.g., via spread) and needs versioning.

```typespec
// In ArcSetting.tsp
model ArcSetting {
  ...ManagedServiceIdentityProperty;  // Spreads identity property
}

// Augment decorator for versioning
@@added(ArcSetting.identity, Versions.v2026_03_15_preview);
```

### `@@removed` Augment Decorator
Used to deprecate features starting from a specific version.

```typespec
// In Cluster.tsp
@@removed(Cluster.kind, Versions.v2026_02_01);
```

## Private Preview Features

These features exist only in the private repository and are marked with `@added(v2026_03_15_preview)`:

### 1. GPU Virtualization Support
- `HciJobType` union includes: `ConfigureArcGateway`, `GpuCreatePartition`, `GpuSwitchMode`
- Models:
  - `HciConfigureArcGatewayJobProperties`
  - `GpuCreatePartitionJobProperties`
  - `GpuSwitchModeJobProperties`
  - `GpuMode` union (Unknown, GPUP, DDA)

### 2. ArcGateway Configuration
- `HciConfigureArcGatewayJobProperties` for job management

### 3. Managed Identity on ArcSettings
- `ArcSetting.identity` property
- `ArcSettingsPatch.identity` property

### 4. Cluster Ring Management
- `changeRing` action on Clusters interface
- `ring` property in ClusterProperties
- `ChangeRingRequest` and `ChangeRingRequestProperties` models

## Compilation

### Command
```bash
tsp compile .
```

### Output Files
- `stable/2026-02-01/hci.json` - GA version OpenAPI spec
- `preview/2026-03-15-preview/hci.json` - Preview version OpenAPI spec

### Validation
Generated `stable/2026-02-01/hci.json` should be identical to public repo.

## Key Files

### main.tsp
Entry point that:
- Imports all resource files
- Defines API versions enum
- Sets up namespace `Microsoft.AzureStackHCI`

### models.tsp
Contains ~6000 lines of:
- Common models and properties
- Enums and unions
- GPU-related job models (private preview)
- DevicePool models (private preview)
- ChangeRing models (private preview)

### ArcSetting.tsp
- ArcSetting resource with ManagedServiceIdentityProperty
- `@@added(ArcSetting.identity, v2026_03_15_preview)` for identity versioning

### Cluster.tsp
- Cluster resource and CRUD operations
- `@@removed(Cluster.kind, v2026_02_01)` for deprecation
- `@added(v2026_03_15_preview)` on changeRing action

## Private-Preview Folder

Contains standalone TSP files for features not yet integrated into main:
- `edgemachinegpu-pvt.tsp` - GPU resource definitions
- `edgemachinegpujobs-pvt.tsp` - GPU job definitions
- `main-pvt.tsp` - Private preview main file

## Backlog Folder

Contains TSP files for features planned but not active:
- `networkProfile.tsp` - Network profiles (from 2023-11-01-preview)
- `SecuritySettings.tsp` - Enhanced security settings
- `validatedSolutionRecipes.tsp` - Validated solution recipes
- `cluster.tsp` - Extended cluster properties
- `clusterJobs.tsp` - Extended cluster jobs
- `gpus.tsp` - GPU resource definitions
- `EdgeNodePool.tsp` - Edge node pools

## Maintenance Workflow

### Merging from Public Repo
1. Compare files using hash comparison
2. Identify functional vs version-only differences
3. Preserve private preview features with `@added(v2026_03_15_preview)`
4. Compile and validate `stable/2026-02-01/hci.json` matches public

### Adding New Features
1. Add models to `models.tsp` with `@added(v2026_03_15_preview)`
2. Add resources to respective `.tsp` files
3. Import in `main.tsp` if new file
4. Compile and verify

### Version Mapping
| Public Version | Private Version |
|----------------|-----------------|
| `v2026_02_01` | `v2026_02_01` (same) |
| `v2026_03_01_preview` | `v2026_03_15_preview` |

## Session History (2026-02-16)

### Actions Completed
1. Compared private vs public repos
2. Simplified `main.tsp` to 2 versions
3. Fixed version annotations (117 `@added`, 1 `@@removed`)
4. Added `@@added(ArcSetting.identity, v2026_03_15_preview)`
5. Added `@added` to ring/ChangeRing models
6. Validated `stable/2026-02-01/hci.json` matches public
7. Created documentation

### File Hash Comparison Results
- **11 SAME** files (38%)
- **18 DIFFERENT** files (62%)
- Differences are mostly version annotation changes
- Generated GA OpenAPI specs are identical

## Next Steps (TODOs)

See [private-repo-differences.md](./private-repo-differences.md) for current TODO list.

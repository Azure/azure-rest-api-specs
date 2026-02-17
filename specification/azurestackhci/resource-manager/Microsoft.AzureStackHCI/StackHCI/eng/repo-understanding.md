# Repository Understanding - Azure Stack HCI TypeSpec

## Overview

This document captures the understanding of the Azure Stack HCI TypeSpec private repository structure, conventions, and key information for maintaining and extending the API definitions.

## Repository Locations

| Repository | GitHub URL | Branch |
|------------|------------|--------|
| **Private** | [azure-rest-api-specs-pr](https://github.com/Azure/azure-rest-api-specs-pr) `/specification/azurestackhci/resource-manager/Microsoft.AzureStackHCI/StackHCI` | RPSaaSMaster |
| **Public** | [azure-rest-api-specs](https://github.com/Azure/azure-rest-api-specs) `/specification/azurestackhci/resource-manager/Microsoft.AzureStackHCI/StackHCI` | main |

## Repository Structure

> **Note:** All TypeSpec files should use PascalCase naming (except `client.tsp`, `back-compatible.tsp`, `models.tsp`). See [typespec-style-guide.md](./typespec-style-guide.md) for details.

```
StackHCI/
├── main.tsp              # Main entry point, version definitions
├── models.tsp            # Shared models, enums, and types
├── CommonModels.tsp      # CVM and SDN common models
├── client.tsp            # Python SDK configuration
├── Cluster.tsp           # Cluster resource and operations
├── ArcSetting.tsp        # ArcSetting resource
├── ClusterJobs.tsp       # Cluster jobs resource
├── DevicePool.tsp        # Device pool resource
├── EdgeMachine.tsp       # Edge machine resource
├── EdgeMachineJobs.tsp   # Edge machine jobs
├── EdgeMachineGpu.tsp    # Edge machine GPU resource (PRIVATE)
├── EdgeMachineGpuJobs.tsp # Edge machine GPU jobs (PRIVATE)
├── EdgeMachineStorage.tsp # Edge machine Storage - Disks, Volumes, DiskJobs (PRIVATE)
├── EdgeMachineNetworkAdapters.tsp # Edge machine NetworkAdapters, Jobs (PRIVATE)
├── EdgeDeviceMetadata.tsp # Edge device metadata resource (PRIVATE)
├── NetworkProfile.tsp    # Network profile resource - child of Cluster (PRIVATE)
├── DeploymentSetting.tsp # Deployment settings
├── EdgeDevice.tsp        # Edge device resource
├── EdgeDeviceJob.tsp     # Edge device jobs
├── Extension.tsp         # Extension resource
├── KubernetesVersions.tsp # Kubernetes versions
├── OsImages.tsp          # OS images
├── PlatformUpdates.tsp   # Platform updates
├── UpdateContents.tsp    # Update contents
├── Publisher.tsp         # Publisher resource
├── Offer.tsp             # Offer resource
├── Sku.tsp               # SKU resource
├── SecuritySetting.tsp   # Security settings
├── Update.tsp            # Update resource
├── UpdateRun.tsp         # Update run resource
├── UpdateSummaries.tsp   # Update summaries
├── ValidatedSolutionRecipe.tsp # Validated solution recipes
├── ValidateOwnershipVouchers.tsp # Ownership voucher validation
├── back-compatible.tsp   # Backward compatibility
├── Operations.tsp        # Operations
├── eng/                  # Engineering docs
│   ├── convert-doc-to-jsdoc.ps1    # Script to convert @doc to /** */
│   ├── model-validation.md          # Model validation guide
│   ├── prettier-formatting.md       # JSON formatting guide
│   ├── private-repo-differences.md  # Diff tracking
│   ├── repo-understanding.md        # This file
│   ├── typespec-style-guide.md      # TypeSpec style guide
│   └── version-creator.md           # API version creation guide
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

## Session History (2026-02-17)

### Actions Completed
1. Compared private vs public repos - identified differences
2. Copied missing eng files from public repo:
   - `convert-doc-to-jsdoc.ps1` - Script to convert @doc to /** */
   - `typespec-style-guide.md` - TypeSpec coding standards
   - `version-creator.md` - API version creation guide
3. Renamed 16 TypeSpec files to PascalCase naming convention (per style guide)
4. Updated `main.tsp` imports to use PascalCase paths
5. Fixed imports in EdgeMachineGpuJobs.tsp, EdgeMachineNetworkAdapters.tsp, EdgeMachineStorage.tsp
6. Compiled and verified - compilation successful
7. Committed changes: "Refactor: Rename TypeSpec files to PascalCase and add eng documentation"

### Files Renamed (lowercase → PascalCase)
| Original | New |
|----------|-----|
| clusterJobs.tsp | ClusterJobs.tsp |
| commonModels.tsp | CommonModels.tsp |
| devicePool.tsp | DevicePool.tsp |
| edgeDeviceMetadata.tsp | EdgeDeviceMetadata.tsp |
| edgeMachine.tsp | EdgeMachine.tsp |
| edgeMachineGpu.tsp | EdgeMachineGpu.tsp |
| edgeMachineGpuJobs.tsp | EdgeMachineGpuJobs.tsp |
| edgeMachineJobs.tsp | EdgeMachineJobs.tsp |
| edgeMachineNetworkAdapters.tsp | EdgeMachineNetworkAdapters.tsp |
| edgeMachineStorage.tsp | EdgeMachineStorage.tsp |
| kubernetesVersions.tsp | KubernetesVersions.tsp |
| networkProfile.tsp | NetworkProfile.tsp |
| osImages.tsp | OsImages.tsp |
| platformUpdates.tsp | PlatformUpdates.tsp |
| updateContents.tsp | UpdateContents.tsp |
| validateOwnershipVouchers.tsp | ValidateOwnershipVouchers.tsp |

### Private-Only Files (not in public repo)
- CommonModels.tsp (CVM/SDN models)
- EdgeDeviceMetadata.tsp
- EdgeMachineGpu.tsp
- EdgeMachineGpuJobs.tsp
- EdgeMachineStorage.tsp
- EdgeMachineNetworkAdapters.tsp
- NetworkProfile.tsp

## Next Steps (TODOs)

See [private-repo-differences.md](./private-repo-differences.md) for current TODO list.

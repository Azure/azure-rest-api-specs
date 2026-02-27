# Azure Stack HCI TypeSpec Repository - Private Repo Guide

## Overview

This document captures the comprehensive understanding of the Azure Stack HCI TypeSpec private repository, including structure, conventions, differences from public, and maintenance workflows.

## Repository Locations

| Repository | GitHub URL | Branch |
|------------|------------|--------|
| **Private** | [azure-rest-api-specs-pr](https://github.com/Azure/azure-rest-api-specs-pr) `/specification/azurestackhci/resource-manager/Microsoft.AzureStackHCI/StackHCI` | RPSaaSMaster |
| **Public** | [azure-rest-api-specs](https://github.com/Azure/azure-rest-api-specs) `/specification/azurestackhci/resource-manager/Microsoft.AzureStackHCI/StackHCI` | main |

---

## API Versions

| Repository | GA Version | Preview Version |
|------------|------------|-----------------|
| **Private** | `v2026_02_01` | `v2026_03_15_preview` |
| **Public** | `v2026_02_01` | `v2026_03_01_preview` |

> **Note**: GA versions are identical. Preview version differs: private uses `v2026_03_15_preview` while public uses `v2026_03_01_preview`.

---

## Repository Structure

> **Note:** All TypeSpec files use PascalCase naming (except `client.tsp`, `back-compatible.tsp`, `models.tsp`). See [typespec-style-guide.md](./typespec-style-guide.md) for details.

```
StackHCI/
├── main.tsp                    # Main entry point, version definitions
├── models.tsp                  # CENTRAL source for ALL models (8000+ lines)
├── client.tsp                  # Python SDK configuration
├── Cluster.tsp                 # Cluster resource and operations
├── ArcSetting.tsp              # ArcSetting resource
├── ClusterJobs.tsp             # Cluster jobs resource
├── DevicePool.tsp              # Device pool resource
├── EdgeMachine.tsp             # Edge machine resource
├── EdgeMachineJobs.tsp         # Edge machine jobs
├── EdgeMachineGpu.tsp          # Edge machine GPU resource (PRIVATE ONLY)
├── EdgeMachineGpuJobs.tsp      # Edge machine GPU jobs (PRIVATE ONLY)
├── EdgeMachineStorage.tsp      # Edge machine Storage (PRIVATE ONLY)
├── EdgeMachineNetworkAdapters.tsp # Edge machine NetworkAdapters (PRIVATE ONLY)
├── EdgeDeviceMetadata.tsp      # Edge device metadata (PRIVATE ONLY)
├── NetworkProfile.tsp          # Network profile resource (PRIVATE ONLY)
├── DeploymentSetting.tsp       # Deployment settings
├── EdgeDevice.tsp              # Edge device resource
├── EdgeDeviceJob.tsp           # Edge device jobs
├── Extension.tsp               # Extension resource
├── KubernetesVersions.tsp      # Kubernetes versions
├── OsImages.tsp                # OS images
├── PlatformUpdates.tsp         # Platform updates
├── UpdateContents.tsp          # Update contents
├── Publisher.tsp               # Publisher resource
├── Offer.tsp                   # Offer resource
├── Sku.tsp                     # SKU resource
├── SecuritySetting.tsp         # Security settings
├── Update.tsp                  # Update resource
├── UpdateRun.tsp               # Update run resource
├── UpdateSummaries.tsp         # Update summaries
├── ValidatedSolutionRecipe.tsp # Validated solution recipes
├── ValidateOwnershipVouchers.tsp # Ownership voucher validation
├── back-compatible.tsp         # Backward compatibility
├── Operations.tsp              # Operations
├── eng/                        # Engineering docs
│   ├── repo-understanding.md   # This file
│   ├── typespec-style-guide.md # TypeSpec style guide
│   └── version-creator.md      # API version creation guide
├── examples/                   # Example JSON files
├── preview/                    # Preview version outputs
├── stable/                     # Stable version outputs
├── private-preview/            # Private preview TSP files
└── backlog/                    # Backlog TSP files (not imported)
```

---

## Swagger Output Verification

*Verified: 2026-02-18*

Comparison between public `preview/2026-03-01-preview/hci.json` and private `preview/2026-03-15-preview/hci.json`:

### Operation Groups (Tags)

| PUBLIC (23 tags) | PRIVATE (31 tags) | Difference |
|------------------|-------------------|------------|
| ✓ All 23 public tags present | ✓ All 23 public tags + 8 additional | +8 private-only |

**Private-Only Operation Groups (+8)**:
- `NetworkProfiles` - Network profile management
- `EdgeDeviceMetadataOperations` - EdgeDevice metadata
- `EdgeMachineGpus` - GPU management
- `EdgeMachineGpuJobs` - GPU job operations
- `EdgeMachineDisks` - Disk management
- `EdgeMachineVolumes` - Volume management
- `EdgeMachineDiskJobs` - Disk job operations
- `EdgeMachineNetworkAdapters` - Network adapter management
- `EdgeMachineNetworkAdapterJobs` - Network adapter job operations

### Model Differences

| Feature | Public | Private |
|---------|--------|---------|
| `ArcSetting.identity` | ❌ Not present | ✅ Present |
| `HciJobType` enum | `ConfigureCVM`, `ConfigureSdnIntegration` | + `ConfigureArcGateway`, `GpuCreatePartition`, `GpuSwitchMode` |
| Private-only definitions | 0 | 78 additional models |

**Private-Only Model Categories (78 definitions)**:
- **GPU**: `EdgeMachineGpu*`, `GpuMode`, `GpuPartitionDetails`, `DdaDetails`, `GpuCreatePartitionJobProperties`, etc.
- **Storage**: `EdgeMachineDisk*`, `EdgeMachineVolume*`, `DiskType`, `DiskState`, `VolumeConfiguration`, etc.
- **Network**: `EdgeMachineNetworkAdapter*`, `NetworkProfile*`, `NetworkAdapterConfiguration`, etc.
- **Metadata**: `EdgeDeviceMetadata*`
- **Jobs**: `HciConfigureArcGatewayJobProperties`, various job properties

### Verification Status: ✅ CONFIRMED

The swagger output matches the documented private preview features. All 78 private-only definitions and 8 additional operation groups are as expected.

---

## File Comparison Summary

*Updated: 2026-02-18*

| File | Status | Private | Public | Notes |
|------|--------|---------|--------|-------|
| models.tsp | DIFFERENT | 8,001 lines | 7,929 lines | Private superset (+72 lines for GPU/ArcGateway) |
| ArcSetting.tsp | DIFFERENT | 142 lines | 136 lines | Private has ManagedIdentity |
| main.tsp | DIFFERENT | 76 lines | 65 lines | Private has extra imports |
| Cluster.tsp | SAME* | ✓ | ✓ | Version annotation diff only |
| EdgeDevice.tsp | SAME | ✓ | ✓ | |
| Extension.tsp | SAME | ✓ | ✓ | |
| back-compatible.tsp | SAME | ✓ | ✓ | |
| client.tsp | SAME | ✓ | ✓ | |
| EdgeMachineGpu.tsp | **PRIVATE** | ✓ | ✗ | Private preview only |
| EdgeMachineGpuJobs.tsp | **PRIVATE** | ✓ | ✗ | Private preview only |
| EdgeMachineStorage.tsp | **PRIVATE** | ✓ | ✗ | Private preview only |
| EdgeMachineNetworkAdapters.tsp | **PRIVATE** | ✓ | ✗ | Private preview only |
| EdgeDeviceMetadata.tsp | **PRIVATE** | ✓ | ✗ | Private preview only |
| NetworkProfile.tsp | **PRIVATE** | ✓ | ✗ | Private preview only |

### Summary Statistics
- **Total Files**: 34 (28 shared + 6 private-only)
- **Identical/Near-identical**: 22 (79% of shared)
- **Different**: 6 (21% of shared)
- **Private-Only**: 6 files

---

## Private Preview Features

All features marked with `@added(Versions.v2026_03_15_preview)`:

### In models.tsp (Private Additions)

| Feature | Description |
|---------|-------------|
| `HciJobType.ConfigureArcGateway` | Arc Gateway job type |
| `HciJobType.GpuCreatePartition` | GPU partition creation |
| `HciJobType.GpuSwitchMode` | GPU mode switching |
| `HciConfigureArcGatewayJobProperties` | Arc Gateway job properties |
| `GpuCreatePartitionJobProperties` | GPU partition job properties |
| `GpuSwitchModeJobProperties` | GPU mode switch job properties |
| `GpuMode` union | GPU modes (Unknown, GPUP, DDA) |
| `ArcSettingsPatch.identity` | Managed identity on ArcSettings |

### Private-Only Resource Files

1. **EdgeMachineGpu.tsp** - GPU management for EdgeMachine
   - List, Get, Create, Delete operations
   - GPU properties: manufacturer, model, status, pciLocation, gpuMode
   - Supports DDA and GPU-P modes

2. **EdgeMachineGpuJobs.tsp** - GPU job operations
   - CreatePartition, SwitchMode, AssignPartition, RemovePartition job types

3. **EdgeMachineStorage.tsp** - Storage management
   - EdgeMachineDisks, EdgeMachineVolumes, EdgeMachineDiskJobs resources
   - Disk/Volume CRUD operations

4. **EdgeMachineNetworkAdapters.tsp** - Network adapter management
   - Read-only adapter listing, job operations for configuration

5. **EdgeDeviceMetadata.tsp** - Device metadata
   - Extension resource for EdgeDevice metadata management

6. **NetworkProfile.tsp** - Network profile management
   - Child resource of Cluster for network configuration

---

## Conventions for Private Preview Features

### 1. Mark Private Preview Models

Use `// PRIVATE PREVIEW` comments:

```typespec
// PRIVATE PREVIEW - GPU and Arc Gateway job types
/** Job to configure arc gateway for the cluster. */
ConfigureArcGateway: "ConfigureArcGateway",
```

### 2. Group Related Private Features

Use section comments:

```typespec
////////////////////////////////////////////////////////////////
////////// PRIVATE PREVIEW - Arc Gateway Job Properties ////////
////////////////////////////////////////////////////////////////
```

### 3. Version Annotations

All private preview features use `@added(Versions.v2026_03_15_preview)`.

---

## Versioning Annotations

### `@added` Decorator
```typespec
@added(Versions.v2026_03_15_preview)
model NewFeature { ... }
```

### `@@added` Augment Decorator
For properties defined via spread:
```typespec
model ArcSetting {
  ...ManagedServiceIdentityProperty;
}
@@added(ArcSetting.identity, Versions.v2026_03_15_preview);
```

### `@@removed` Augment Decorator
For deprecation:
```typespec
@@removed(Cluster.kind, Versions.v2026_02_01);
```

---

## Compilation

### Command
```bash
tsp compile .
```

### Output Files
- `stable/2026-02-01/hci.json` - GA version OpenAPI spec
- `preview/2026-03-15-preview/hci.json` - Preview version OpenAPI spec

### Validation
Generated `stable/2026-02-01/hci.json` should be **identical** to public repo.

---

## Maintenance Workflow

### Syncing from Public Repo

1. **Copy base files** from public repo to private
2. **Update version annotations**: `v2026_03_01_preview` → `v2026_03_15_preview`
3. **Preserve private-only features**:
   - GPU job types in `HciJobType` union
   - `HciConfigureArcGatewayJobProperties`, `GpuCreatePartitionJobProperties`, `GpuSwitchModeJobProperties`
   - `GpuMode` union
   - `ArcSettingsPatch.identity` property
4. **Keep private-only files** (do not delete):
   - `EdgeMachineGpu.tsp`, `EdgeMachineGpuJobs.tsp`
   - `EdgeMachineStorage.tsp`, `EdgeMachineNetworkAdapters.tsp`
   - `EdgeDeviceMetadata.tsp`, `NetworkProfile.tsp`
5. **Compile and validate** compilation succeeds

### Version Mapping (Public → Private)
| Public Version | Private Version |
|----------------|-----------------|
| `v2026_02_01` | `v2026_02_01` (same) |
| `v2026_03_01_preview` | `v2026_03_15_preview` |

### Adding New Features

1. Add models to `models.tsp` with `@added(v2026_03_15_preview)`
2. Add resources to respective `.tsp` files
3. Import in `main.tsp` if new file
4. Compile and verify

---

## TODOs (Completed)

- [x] **Copy examples from main repo** - Copied from 2026-03-01-preview with version updates (118 files)
- [x] **Compare against previous Private preview** - Compared 2025-09-22-preview, 2025-12-01-preview, 2026-03-15-preview - no API gaps found
- [x] **Bring GPU and GPU Jobs from 2024-11-01-preview** - Added EdgeMachineGpu and EdgeMachineGpuJobs resources
- [x] **Create Storage APIs from swagger** - Added EdgeMachineDisks, EdgeMachineVolumes, EdgeMachineDiskJobs resources
- [x] **Create Network Adapter APIs from swagger** - Added EdgeMachineNetworkAdapters, EdgeMachineNetworkAdapterJobs resources
- [x] **Bring EdgeDevice Metadata from backlog** - Added EdgeDeviceMetadata resource
- [x] **Bring Network Profiles from backlog** - Added NetworkProfile resource
- [x] **Bring Cluster kind property** - Changed from @@removed to @@added for v2026_03_15_preview
- [x] **Sync models.tsp with public repo** - Copied from main, added private preview features (2026-02-18)
- [x] **Sync resource files with public repo** - 9 files synced with version updates (2026-02-18)

---

## Session History

### 2026-02-18 - Full Sync with Public Repo

**Actions Completed**:
1. Compared `models.tsp` between private and public repos
2. Identified private repo was missing ~1,500 lines of EdgeMachine, provisioning, validation models
3. Copied `models.tsp` from public repo as base
4. Updated version annotations: `v2026_03_01_preview` → `v2026_03_15_preview`
5. Added private preview features:
   - `HciJobType` union: Added `ConfigureArcGateway`, `GpuCreatePartition`, `GpuSwitchMode`
   - `ArcSettingsPatch`: Added `identity` property
   - Added GPU job models and `GpuMode` union
6. Synced 9 resource files from public repo with version updates
7. Fixed `armResourceIdentifier` → `Azure.Core.armResourceIdentifier`
8. **Compilation successful** ✅

**Files Synced**:
- `EdgeMachine.tsp`, `EdgeMachineJobs.tsp`, `ValidateOwnershipVouchers.tsp`
- `UpdateContents.tsp`, `KubernetesVersions.tsp`, `OsImages.tsp`
- `PlatformUpdates.tsp`, `ClusterJobs.tsp`, `DevicePool.tsp`

### 2026-02-17 - Private Preview Features Added

1. Copied examples from main repo (2026-03-01-preview → examples/2026-03-15-preview) - 118 files
2. Compared preview versions (2025-09-22-preview, 2025-12-01-preview, 2026-03-15-preview) - no API gaps
3. Added EdgeMachineGpu and EdgeMachineGpuJobs resources from private-preview
4. Added GPU examples from examples/2024-11-01-preview - 16 files
5. Added ClusterJobs examples for ArcGateway and GPU from preview/2025-09-22-preview - 6 files
6. Created EdgeMachineStorage resources (Disks, Volumes, DiskJobs) from swagger
7. Created EdgeMachineNetworkAdapters resources (NetworkAdapters, NetworkAdapterJobs) from swagger
8. Updated main.tsp to import new Storage and NetworkAdapter modules
9. Added EdgeDeviceMetadata resource from backlog
10. Added EdgeDeviceMetadata examples from preview/2023-12-01-preview - 4 files
11. Added NetworkProfile resource from backlog
12. Added NetworkProfile examples from preview/2023-12-01-preview - 5 files
13. Changed Cluster.kind from @@removed to @@added for preview version
14. Updated cluster examples with kind: "AzureLocal"
15. **Total examples in 2026-03-15-preview**: 149

### 2026-02-16 - Initial Setup

1. Compared private vs public repos
2. Simplified `main.tsp` to 2 versions
3. Fixed version annotations (117 `@added`, 1 `@@removed`)
4. Created initial documentation

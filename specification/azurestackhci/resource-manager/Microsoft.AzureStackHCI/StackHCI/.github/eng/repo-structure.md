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

> **Note:** All TypeSpec files use PascalCase naming (except `client.tsp`, `back-compatible.tsp`, `models.tsp`). See [style-guide.md](./style-guide.md) for details.

```
StackHCI/
├── main.tsp                    # Main entry point, version definitions
├── models.tsp                  # CENTRAL source for ALL models (8000+ lines)
├── client.tsp                  # Python SDK configuration
├── Cluster.tsp                 # Cluster resource and operations
├── ArcSetting.tsp              # ArcSetting resource
├── ClusterJobs.tsp             # Cluster jobs resource
├── ClusterVolume.tsp           # Cluster volume resource (PRIVATE ONLY)
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
├── .github/eng/                # Engineering docs and guidance
│   ├── repo-structure.md       # This file
│   ├── style-guide.md          # TypeSpec style guide
│   └── new-api-version.md      # API version creation guide
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

**Private-Only Operation Groups (+9)**:
- `ClusterVolumes` - Cluster volume management
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
| ClusterVolume.tsp | **PRIVATE** | ✓ | ✗ | Private preview only |

### Summary Statistics
- **Total Files**: 35 (28 shared + 7 private-only)
- **Identical/Near-identical**: 22 (79% of shared)
- **Different**: 6 (21% of shared)
- **Private-Only**: 7 files

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

7. **ClusterVolume.tsp** - Cluster volume management
   - Read-only child resource of Cluster for cluster storage volumes
   - ClusterVolumeReportedProperties with volume health, size, resiliency, media type

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


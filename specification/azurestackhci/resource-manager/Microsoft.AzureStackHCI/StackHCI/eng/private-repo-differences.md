# Private Repository Differences from Main

## TODOs
- [x] **Copy examples from main repo** - Copied from 2026-03-01-preview with version updates (118 files)
- [x] **Compare against previous Private preview** - Compared 2025-09-22-preview, 2025-12-01-preview, 2026-03-15-preview - no API gaps found (checkHealth deprecated, supportStatus excluded as intended)
- [x] **Bring GPU and GPU Jobs from 2024-11-01-preview** - Added EdgeMachineGpu and EdgeMachineGpuJobs resources (files: edgeMachineGpu.tsp, edgeMachineGpuJobs.tsp)
- [x] **Create Storage APIs from swagger** - Added EdgeMachineDisks, EdgeMachineVolumes, EdgeMachineDiskJobs resources (file: edgeMachineStorage.tsp)
- [x] **Create Network Adapter APIs from swagger** - Added EdgeMachineNetworkAdapters, EdgeMachineNetworkAdapterJobs resources (file: edgeMachineNetworkAdapters.tsp)
- [x] **Bring EdgeDevice Metadata from backlog** - Added EdgeDeviceMetadata resource (file: edgeDeviceMetadata.tsp)
- [x] **Bring Network Profiles from backlog** - Added NetworkProfile resource (file: networkProfile.tsp)
- [x] **Bring Cluster kind property** - Changed from @@removed to @@added for v2026_03_15_preview (updated Cluster.tsp)
- [x] **Create SAN/Storage APIs from swagger** - Added EdgeMachineDisks, EdgeMachineVolumes, EdgeMachineDiskJobs resources (file: edgeMachineStorage.tsp)

---

This document tracks the differences between the private preview repository and the main public repository for Azure Stack HCI TypeSpec definitions.

## Repositories

| Repository | Branch | Path |
|------------|--------|------|
| **Private (pvt)** | [azure-rest-api-specs-pr/RPSaaSMaster](https://github.com/Azure/azure-rest-api-specs-pr/tree/RPSaaSMaster/specification/azurestackhci/resource-manager/Microsoft.AzureStackHCI/StackHCI) | `specification/azurestackhci/resource-manager/Microsoft.AzureStackHCI/StackHCI` |
| **Public (main)** | [azure-rest-api-specs/main](https://github.com/Azure/azure-rest-api-specs/tree/main/specification/azurestackhci/resource-manager/Microsoft.AzureStackHCI/StackHCI) | `specification/azurestackhci/resource-manager/Microsoft.AzureStackHCI/StackHCI` |

## API Versions

| Repository | API Versions |
|------------|--------------|
| **Private** | `v2026_02_01` (GA), `v2026_03_15_preview` (Preview) |
| **Public** | `v2026_02_01` (GA), `v2026_03_01_preview` (Preview) |

> **Note**: Both repositories have 2 API versions. The preview version differs: private uses `v2026_03_15_preview` while public uses `v2026_03_01_preview`.

## File Hash Comparison

*Generated: 2026-02-16*

| File | Status | Private Hash | Public Hash |
|------|--------|--------------|-------------|
| ArcSetting.tsp | DIFFERENT | 1C40C004 | 8CB26367 |
| back-compatible.tsp | SAME | 3DD56251 | 3DD56251 |
| client.tsp | SAME | BE353B1E | BE353B1E |
| Cluster.tsp | DIFFERENT | 02120AD6 | 5A95F304 |
| clusterJobs.tsp | DIFFERENT | 9D5EDC7A | 227A3DFA |
| commonModels.tsp | DIFFERENT | 6170F169 | C7E14FF8 |
| DeploymentSetting.tsp | SAME | 7BAA155C | 7BAA155C |
| devicePool.tsp | DIFFERENT | F58C0894 | 190C2862 |
| EdgeDevice.tsp | SAME | 838EABA1 | 838EABA1 |
| EdgeDeviceJob.tsp | SAME | F7F5D549 | F7F5D549 |
| edgeMachine.tsp | DIFFERENT | 23C68B35 | EADD1065 |
| edgeMachineJobs.tsp | DIFFERENT | 113520C8 | C7F19EEC |
| Extension.tsp | SAME | 9F4D7A43 | 9F4D7A43 |
| kubernetesVersions.tsp | DIFFERENT | 10CC838C | 3C2AC46F |
| main.tsp | DIFFERENT | F4E51B4D | 612FFDD3 |
| models.tsp | DIFFERENT | E555C65A | 40BC788D |
| Offer.tsp | SAME | 04DA0E1D | 04DA0E1D |
| Operations.tsp | SAME | 54564DB3 | 54564DB3 |
| osImages.tsp | DIFFERENT | A1A20387 | F3CF3A38 |
| platformUpdates.tsp | DIFFERENT | 6D4471B2 | C095FC2C |
| Publisher.tsp | DIFFERENT | 242A639B | 43EAB694 |
| SecuritySetting.tsp | SAME | ED380988 | ED380988 |
| Sku.tsp | SAME | 8FBB015B | 8FBB015B |
| Update.tsp | DIFFERENT | D2579BDB | 16D800AB |
| updateContents.tsp | DIFFERENT | B6FC1BB5 | 2922B291 |
| UpdateRun.tsp | SAME | C6E35146 | C6E35146 |
| UpdateSummaries.tsp | DIFFERENT | 29F4F0B1 | 8764B940 |
| ValidatedSolutionRecipe.tsp | SAME | C162907E | C162907E |
| validateOwnershipVouchers.tsp | DIFFERENT | 3D4C20F9 | 09885DDD |
| edgeMachineGpu.tsp | **NEW** | - | - |
| edgeMachineGpuJobs.tsp | **NEW** | - | - |
| edgeMachineStorage.tsp | **NEW** | - | - |
| edgeMachineNetworkAdapters.tsp | **NEW** | - | - |
| edgeDeviceMetadata.tsp | **NEW** | - | - |
| networkProfile.tsp | **NEW** | - | - |

### Summary
- **Total Files**: 35 (29 shared + 6 new)
- **Identical**: 11 (38% of shared)
- **Different**: 18 (62% of shared)
- **New in Private**: 6 (edgeMachineGpu.tsp, edgeMachineGpuJobs.tsp, edgeMachineStorage.tsp, edgeMachineNetworkAdapters.tsp, edgeDeviceMetadata.tsp, networkProfile.tsp)

> **Note**: Most differences are due to version annotation changes (using simplified v2026_02_01/v2026_03_15_preview instead of v2025_12_01_preview/v2026_03_01_preview). Generated OpenAPI specs for `stable/2026-02-01/hci.json` are **identical** between private and public repositories.

---

## Functional Differences

The following are the **actual functional differences** between the private and public repositories. Version annotation differences do not impact the generated API spec.

### ArcSetting.tsp

| Private Repository | Public Repository |
|--------------------|-------------------|
| Has `...ManagedServiceIdentityProperty` | No ManagedServiceIdentityProperty |
| Has `@@added(ArcSetting.identity, v2026_03_15_preview)` | N/A |

**Purpose**: Private preview includes support for managed identity on ArcSetting resource (preview only).

---

### models.tsp

| Feature | Private Repository | Public Repository |
|---------|-------------------|-------------------|
| **ArcSettingsPatch.identity** | ✅ Has `identity` property for managed service identity | ❌ Not present |
| **HciJobType union** | Additional: `ConfigureArcGateway`, `GpuCreatePartition`, `GpuSwitchMode` | Only: `ConfigureCVM`, `ConfigureSdnIntegration` |
| **HciConfigureArcGatewayJobProperties** | ✅ Present | ❌ Not present |
| **GpuCreatePartitionJobProperties** | ✅ Present | ❌ Not present |
| **GpuSwitchModeJobProperties** | ✅ Present | ❌ Not present |
| **GpuMode union** | ✅ Present (Unknown, GPUP, DDA) | ❌ Not present |
| **ClusterProperties.ring** | ✅ Present (v2026_03_15_preview) | ✅ Present (v2026_03_01_preview) |
| **ChangeRingRequest/Properties** | ✅ Present (v2026_03_15_preview) | ✅ Present (v2026_03_01_preview) |

**Purpose**: Private preview includes GPU virtualization support (partitioning, mode switching), ArcGateway configuration features. Cluster ring management is also present in public repo.

---

### Cluster.tsp

| Private Repository | Public Repository |
|--------------------|-------------------|
| Has `@@removed(Cluster.kind, v2026_02_01)` | Has `@@removed(Cluster.kind, v2026_02_01)` |
| Has `@added(v2026_03_15_preview)` on changeRing | Has `@added(v2026_03_01_preview)` on changeRing |

**Note**: Functionally equivalent, just different version references.

---

## Private Preview Features

The private repository contains the following features not yet available in the public API:

### 1. EdgeMachine GPU Resources (Preview Only) - NEW
- **EdgeMachineGpu** - Child resource of EdgeMachine for GPU management
  - List, Get, Create, Delete operations
  - Tracks GPU properties: manufacturer, model, status, pciLocation, gpuMode
  - Supports DDA (Direct Device Assignment) and GPU-P (Partitioned) modes
  - Partition details including vRAM, encode/decode capabilities
  - Files: `edgeMachineGpu.tsp`
  
- **EdgeMachineGpuJobs** - GPU job operations
  - CreatePartition, SwitchMode, AssignPartition, RemovePartition job types
  - Files: `edgeMachineGpuJobs.tsp`

### 2. GPU Virtualization via ClusterJobs (Preview Only)
- Create GPU partitions for virtualization workloads
- Switch between GPU-P (Partitioned) and DDA (Direct Device Assignment) modes
- GPU job management via cluster jobs (`GpuCreatePartition`, `GpuSwitchMode`)

### 3. ArcGateway Configuration (Preview Only)
- Configure Arc Gateway for cluster connectivity
- `HciConfigureArcGatewayJobProperties` for job management

### 4. Managed Identity on ArcSettings (Preview Only)
- Support for managed service identities on ArcSetting resources
- `ArcSetting.identity` and `ArcSettingsPatch.identity` properties

### 5. Cluster Ring Management (Both Repos)
- `changeRing` action on Clusters interface
- `ring` property in ClusterProperties
- `ChangeRingRequest` and `ChangeRingRequestProperties` models
- **Note**: This feature exists in BOTH private (v2026_03_15_preview) and public (v2026_03_01_preview) repos

### 6. EdgeMachine Storage Resources (Preview Only) - NEW
- **EdgeMachineDisks** - Child resource of EdgeMachine for disk management
  - List, Get, Create, Delete operations
  - Tracks disk properties: diskName, model, manufacturer, serialNumber, firmwareVersion
  - DiskType: HDD, SSD, SCM, Unknown
  - DiskState: Healthy, Warning, Unhealthy, Missing, Unknown
  - DiskConfiguration with volumes
  - Files: `edgeMachineStorage.tsp`

- **EdgeMachineVolumes** - Child resource of EdgeMachine for volume management
  - List, Get, Create, Delete operations
  - Volume properties: partitionId, offset, name, path, parentDiskId, isBoot, size, fileSystem
  - Files: `edgeMachineStorage.tsp`

- **EdgeMachineDiskJobs** - Disk job operations
  - CreateVolume, DeleteVolume, SyncConfiguration job types
  - ResolutionStrategy: UseDesired, UseActual
  - DriftDetail tracking for configuration sync
  - Files: `edgeMachineStorage.tsp`

### 7. EdgeMachine Network Adapter Resources (Preview Only) - NEW
- **EdgeMachineNetworkAdapters** - Child resource of EdgeMachine for network adapter management (read-only)
  - List, Get operations only
  - Tracks adapter properties: interfaceDescription, componentId, driverVersion, slot, switchName
  - Network configuration and status reporting
  - Files: `edgeMachineNetworkAdapters.tsp`

- **EdgeMachineNetworkAdapterJobs** - Network adapter job operations
  - ApplyConfiguration, ForcePush job types
  - Validation and deployment status tracking
  - Files: `edgeMachineNetworkAdapters.tsp`

### 8. EdgeDevice Metadata Resources (Preview Only) - NEW
- **EdgeDeviceMetadata** - Extension resource for EdgeDevice metadata management
  - List, Get, Create, Delete operations
  - Properties: validatedRecipe (string), provisioningState (read-only)
  - Stores validated recipe information for an edge device
  - Files: `edgeDeviceMetadata.tsp`

### 9. NetworkProfile Resources (Preview Only) - NEW
- **NetworkProfile** - Child resource of Cluster for network profile management
  - List, Get, Create, Update, Delete operations
  - Properties: reportedProperties (cluster network info), lastSyncTimestamp, lastSyncStatus
  - Tracks cluster network configuration including IPs, adapters, switches, networks, intents
  - Files: `networkProfile.tsp`

### 10. Cluster Kind Property (Preview Only) - RESTORED
- **Cluster.kind** - Property to identify the purpose of Cluster deployment
  - Changed from `@@removed(v2026_02_01)` to `@@added(v2026_03_15_preview)`
  - Now explicitly added in preview only (not in GA)
  - Example value: "AzureLocal"
  - Updated cluster examples to include kind property

---

## Version Annotations

| Annotation | File | Target | Purpose |
|------------|------|--------|---------|
| `@@added(Cluster.kind, v2026_03_15_preview)` | Cluster.tsp | Cluster.kind | Kind property only in preview |
| `@@added(ArcSetting.identity, v2026_03_15_preview)` | ArcSetting.tsp | ArcSetting.identity | Identity only in preview |

---

## Maintenance Notes

When merging changes from public to private repository:
1. Preserve GPU-related job types and models with `@added(v2026_03_15_preview)`
2. Preserve `HciConfigureArcGatewayJobProperties` with `@added(v2026_03_15_preview)`
3. Preserve `identity` property on `ArcSettingsPatch` and `ArcSetting` with appropriate `@added` annotations
4. Preserve `ring`, `ChangeRingRequest`, and `ChangeRingRequestProperties` with `@added(v2026_03_15_preview)`
5. Update version annotations from public versions to private versions as needed
6. **Keep private-only files**: `edgeMachineGpu.tsp`, `edgeMachineGpuJobs.tsp`, `edgeMachineStorage.tsp`, `edgeMachineNetworkAdapters.tsp`, `edgeDeviceMetadata.tsp`, `networkProfile.tsp` (not in public repo)
7. **Keep main.tsp imports** for EdgeMachineGpu, EdgeMachineGpuJobs, EdgeMachineStorage, EdgeMachineNetworkAdapters, EdgeDeviceMetadata, NetworkProfile
8. **Preserve Cluster.kind** with `@@added(v2026_03_15_preview)` annotation

### Version Mapping (Public → Private)
| Public Version | Private Version |
|----------------|-----------------|
| `v2026_02_01` | `v2026_02_01` (GA) - Same |
| `v2026_03_01_preview` | `v2026_03_15_preview` (Preview) |

---

## Session History

### 2026-02-17 Updates
1. Copied examples from main repo (2026-03-01-preview → examples/2026-03-15-preview) - 118 files
2. Compared preview versions (2025-09-22-preview, 2025-12-01-preview, 2026-03-15-preview) - no API gaps
3. Added EdgeMachineGpu and EdgeMachineGpuJobs resources from private-preview
4. Added GPU examples from examples/2024-11-01-preview - 16 files
5. Added ClusterJobs examples for ArcGateway and GPU from preview/2025-09-22-preview - 6 files
6. Total examples in 2026-03-15-preview: 140
7. Created EdgeMachineStorage resources (edgeMachineStorage.tsp) from swagger - Disks, Volumes, DiskJobs
8. Created EdgeMachineNetworkAdapters resources (edgeMachineNetworkAdapters.tsp) from swagger - NetworkAdapters, NetworkAdapterJobs
9. Updated main.tsp to import new Storage and NetworkAdapter modules
10. Compiled TypeSpec - 83 paths in preview swagger
11. Added EdgeDeviceMetadata resource from backlog (edgeDeviceMetadata.tsp) - Extension resource for EdgeDevice
12. Compiled TypeSpec - 85 paths in preview swagger
13. Added EdgeDeviceMetadata examples from preview/2023-12-01-preview - 4 files
14. Total examples in 2026-03-15-preview: 144
15. Added NetworkProfile resource from backlog (networkProfile.tsp) - Child resource of Cluster
16. Added NetworkProfile examples from preview/2023-12-01-preview - 5 files
17. Total examples in 2026-03-15-preview: 149
18. Changed Cluster.kind from @@removed to @@added for preview version
19. Updated cluster examples (CreateCluster, GetCluster, UpdateCluster, ListClustersByResourceGroup, ListClustersBySubscription) with kind: "AzureLocal"

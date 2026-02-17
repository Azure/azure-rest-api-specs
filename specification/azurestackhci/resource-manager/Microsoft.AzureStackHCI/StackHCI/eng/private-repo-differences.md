# Private Repository Differences from Main

## TODOs

- [ ] **Compare against previous Private preview** - Ensure none of the API changes are missed in the `v2026_03_15_preview` version
- [ ] **Copy examples from main repo** - Also copy from previous previews so that the example list is complete
- [ ] **Create Storage APIs back from swagger** - Swagger will be provided
- [ ] **Create SAN APIs from swagger** - Swagger will be provided
- [ ] **Bring GPU and GPU Jobs from 2024-11-01-preview** - gpu and gpuJobs resources
- [ ] **Bring EdgeMachine Metadata from 2023-11-01-preview** - edgeMachineMetadata
- [ ] **Bring Network Profiles from 2023-11-01-preview** - networkProfiles

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

### Summary
- **Total Files**: 29
- **Identical**: 11 (38%)
- **Different**: 18 (62%)

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
| **ClusterProperties.ring** | ✅ Present (v2026_03_15_preview) | ❌ Not present |
| **ChangeRingRequest/Properties** | ✅ Present (v2026_03_15_preview) | ❌ Not present |

**Purpose**: Private preview includes GPU virtualization support (partitioning, mode switching), ArcGateway configuration, and cluster ring management features.

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

### 1. GPU Virtualization Support (Preview Only)
- Create GPU partitions for virtualization workloads
- Switch between GPU-P (Partitioned) and DDA (Direct Device Assignment) modes
- GPU job management via cluster jobs

### 2. ArcGateway Configuration (Preview Only)
- Configure Arc Gateway for cluster connectivity
- `HciConfigureArcGatewayJobProperties` for job management

### 3. Managed Identity on ArcSettings (Preview Only)
- Support for managed service identities on ArcSetting resources
- `ArcSetting.identity` and `ArcSettingsPatch.identity` properties

### 4. Cluster Ring Management (Preview Only)
- `changeRing` action on Clusters interface
- `ring` property in ClusterProperties
- `ChangeRingRequest` and `ChangeRingRequestProperties` models

---

## Version Annotations

| Annotation | File | Target | Purpose |
|------------|------|--------|---------|
| `@@removed(Cluster.kind, v2026_02_01)` | Cluster.tsp | Cluster.kind | Deprecates kind in GA |
| `@@added(ArcSetting.identity, v2026_03_15_preview)` | ArcSetting.tsp | ArcSetting.identity | Identity only in preview |

---

## Maintenance Notes

When merging changes from public to private repository:
1. Preserve GPU-related job types and models with `@added(v2026_03_15_preview)`
2. Preserve `HciConfigureArcGatewayJobProperties` with `@added(v2026_03_15_preview)`
3. Preserve `identity` property on `ArcSettingsPatch` and `ArcSetting` with appropriate `@added` annotations
4. Preserve `ring`, `ChangeRingRequest`, and `ChangeRingRequestProperties` with `@added(v2026_03_15_preview)`
5. Update version annotations from public versions to private versions as needed

### Version Mapping (Public → Private)
| Public Version | Private Version |
|----------------|-----------------|
| `v2026_02_01` | `v2026_02_01` (GA) - Same |
| `v2026_03_01_preview` | `v2026_03_15_preview` (Preview) |

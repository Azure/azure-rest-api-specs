# Private Repository Differences from Main

This document tracks the differences between the private preview repository and the main public repository for Azure Stack HCI TypeSpec definitions.

## Repositories

| Repository | Branch | Path |
|------------|--------|------|
| **Private (pvt)** | [azure-rest-api-specs-pr/RPSaaSMaster](https://github.com/Azure/azure-rest-api-specs-pr/tree/RPSaaSMaster/specification/azurestackhci/resource-manager/Microsoft.AzureStackHCI/StackHCI) | `specification/azurestackhci/resource-manager/Microsoft.AzureStackHCI/StackHCI` |
| **Public (main)** | [azure-rest-api-specs/main](https://github.com/Azure/azure-rest-api-specs/tree/main/specification/azurestackhci/resource-manager/Microsoft.AzureStackHCI/StackHCI) | `specification/azurestackhci/resource-manager/Microsoft.AzureStackHCI/StackHCI` |

## File Hash Comparison

*Generated: 2026-02-16*

| File | Status | Private Hash | Public Hash |
|------|--------|--------------|-------------|
| ArcSetting.tsp | DIFFERENT | 88283346 | 8CB26367 |
| back-compatible.tsp | SAME | 3DD56251 | 3DD56251 |
| client.tsp | SAME | BE353B1E | BE353B1E |
| Cluster.tsp | SAME | 5A95F304 | 5A95F304 |
| clusterJobs.tsp | SAME | 227A3DFA | 227A3DFA |
| commonModels.tsp | SAME | C7E14FF8 | C7E14FF8 |
| DeploymentSetting.tsp | SAME | 7BAA155C | 7BAA155C |
| devicePool.tsp | SAME | 190C2862 | 190C2862 |
| EdgeDevice.tsp | SAME | 838EABA1 | 838EABA1 |
| EdgeDeviceJob.tsp | SAME | F7F5D549 | F7F5D549 |
| edgeMachine.tsp | SAME | EADD1065 | EADD1065 |
| edgeMachineJobs.tsp | SAME | C7F19EEC | C7F19EEC |
| Extension.tsp | SAME | 9F4D7A43 | 9F4D7A43 |
| kubernetesVersions.tsp | SAME | 3C2AC46F | 3C2AC46F |
| main.tsp | DIFFERENT | 6B8967F6 | 612FFDD3 |
| models.tsp | DIFFERENT | 6522F832 | 40BC788D |
| Offer.tsp | SAME | 04DA0E1D | 04DA0E1D |
| Operations.tsp | SAME | 54564DB3 | 54564DB3 |
| osImages.tsp | SAME | F3CF3A38 | F3CF3A38 |
| platformUpdates.tsp | SAME | C095FC2C | C095FC2C |
| Publisher.tsp | SAME | 43EAB694 | 43EAB694 |
| SecuritySetting.tsp | SAME | ED380988 | ED380988 |
| Sku.tsp | SAME | 8FBB015B | 8FBB015B |
| Update.tsp | SAME | 16D800AB | 16D800AB |
| updateContents.tsp | SAME | 2922B291 | 2922B291 |
| UpdateRun.tsp | SAME | C6E35146 | C6E35146 |
| UpdateSummaries.tsp | SAME | 8764B940 | 8764B940 |
| ValidatedSolutionRecipe.tsp | SAME | C162907E | C162907E |
| validateOwnershipVouchers.tsp | SAME | 09885DDD | 09885DDD |

### Summary
- **Total Files**: 29
- **Identical**: 26 (90%)
- **Different**: 3 (10%)

---

## Functional Differences

### main.tsp
Differs in API versions defined. Private repository includes additional preview versions.

---

### ArcSetting.tsp

| Private Repository | Public Repository |
|--------------------|-------------------|
| Has `...ManagedServiceIdentityProperty` | No ManagedServiceIdentityProperty |

**Purpose**: Private preview includes support for managed identity on ArcSetting resource.

---

### models.tsp

| Feature | Private Repository | Public Repository |
|---------|-------------------|-------------------|
| **ArcSettingsPatch.identity** | ✅ Has `identity` property for managed service identity | ❌ Not present |
| **HciJobType union** | Has: `ConfigureArcGateway`, `GpuCreatePartition`, `GpuSwitchMode`, `ConfigureCVM`, `ConfigureSdnIntegration` | Has: `ConfigureCVM`, `ConfigureSdnIntegration` |
| **HciConfigureArcGatewayJobProperties** | ✅ Present | ❌ Not present |
| **GpuCreatePartitionJobProperties** | ✅ Present | ❌ Not present |
| **GpuSwitchModeJobProperties** | ✅ Present | ❌ Not present |
| **GpuMode union** | ✅ Present (Unknown, GPUP, DDA) | ❌ Not present |

**Purpose**: Private preview includes GPU virtualization support (partitioning, mode switching) and ArcGateway configuration features that are not yet available in the public API.

---

## Private Preview Features

The private repository contains the following features not yet available in the public API:

1. **GPU Virtualization Support**
   - Create GPU partitions for virtualization workloads
   - Switch between GPU-P (Partitioned) and DDA (Direct Device Assignment) modes
   - GPU job management

2. **ArcGateway Configuration**
   - Configure Arc Gateway for cluster connectivity

3. **Managed Identity on ArcSettings**
   - Support for managed service identities on ArcSetting resources

---

## Maintenance Notes

When merging changes from public to private repository:
1. Preserve GPU-related job types and models
2. Preserve `HciConfigureArcGatewayJobProperties`
3. Preserve `identity` property on `ArcSettingsPatch`
4. Update version annotations as needed

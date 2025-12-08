# Duplicate Models Analysis Report
## Azure Stack HCI TypeSpec Project

### Executive Summary
This analysis examines duplicate model definitions found in the Azure Stack HCI TypeSpec project, excluding ProvisioningState which has been addressed. The analysis identifies parent resources, usage patterns, and compares TSP definitions with C# implementations to determine if these are true duplicates or legitimate variations.

---

## Duplicate Models Identified

### 1. **ReportedProperties**
**Files:** [`models.tsp:5839`](models.tsp:5839), [`edgeMachine.tsp:289`](edgeMachine.tsp:289)

**Usage Context:**
- **models.tsp**: Used in general HCI device contexts (`HciReportedProperties`, `HciEdgeDeviceProperties`)
- **edgeMachine.tsp**: Used specifically for EdgeMachine resource (`EdgeMachineProperties.reportedProperties`)

**Parent Resources:**
- models.tsp: Generic device reporting (HCI devices, edge devices)
- edgeMachine.tsp: EdgeMachine resource specifically

**Property Comparison:**
- **models.tsp**: Contains `deviceState`, `extensionProfile`
- **edgeMachine.tsp**: Contains `lastUpdated`, `networkProfile`, `osProfile`, `hardwareProfile`, `storageProfile`, `sbeDeploymentPackageInfo`, `extensionProfile`

**C# Implementation:** Found as `EdgeMachineReportedProperties` and `HciClusterReportedProperties` - different classes

**Assessment:** ❌ **TRUE DUPLICATE** - Different contexts require different reporting properties

---

### 2. **NicDetail**
**Files:** [`models.tsp:5201`](models.tsp:5201), [`edgeMachine.tsp:335`](edgeMachine.tsp:335)

**Usage Context:**
- **models.tsp**: Used in `DeviceConfiguration`, `HciNetworkProfile` (general HCI networking)
- **edgeMachine.tsp**: Used in `NetworkProfile` (EdgeMachine-specific networking)

**Parent Resources:**
- models.tsp: HCI devices, general device configuration
- edgeMachine.tsp: EdgeMachine resource

**Property Comparison:**
Both have nearly identical properties:
- `adapterName`, `interfaceDescription`, `componentId`, `driverVersion`
- `ip4Address`, `subnetMask`, `defaultGateway`, `dnsServers`
- `defaultIsolationId`, `macAddress`, `slot`, `switchName`
- `nicType`, `vlanId`, `nicStatus`, `rdmaCapability`

**C# Implementation:** Found as `NicDetails` class in EdgeCommon.cs

**Assessment:** ✅ **LEGITIMATE DUPLICATE** - Same structure, different contexts but could be unified

---

### 3. **SwitchDetail**
**Files:** [`models.tsp:5521`](models.tsp:5521), [`edgeMachine.tsp:435`](edgeMachine.tsp:435)

**Usage Context:**
- **models.tsp**: Used in general HCI networking contexts
- **edgeMachine.tsp**: Used in EdgeMachine NetworkProfile

**Parent Resources:**
- models.tsp: HCI devices
- edgeMachine.tsp: EdgeMachine resource

**Property Comparison:**
Both have identical properties:
- `switchName`, `switchType`, `extensions[]`

**C# Implementation:** Found as `SwitchDetail` class in EdgeCommon.cs

**Assessment:** ✅ **LEGITIMATE DUPLICATE** - Identical structure, can be unified

---

### 4. **SwitchExtension**
**Files:** [`models.tsp:5545`](models.tsp:5545), [`edgeMachine.tsp:460`](edgeMachine.tsp:460)

**Usage Context:**
- Both used within SwitchDetail models

**Property Comparison:**
Both have identical properties:
- `switchId`, `extensionName`, `extensionEnabled`

**Assessment:** ✅ **LEGITIMATE DUPLICATE** - Identical, can be unified

---

### 5. **RdmaCapability**
**Files:** [`models.tsp:1590`](models.tsp:1590), [`edgeMachine.tsp:538`](edgeMachine.tsp:538)

**Usage Context:**
- Both used in NicDetail models

**Property Comparison:**
Both have identical enum values:
- `Enabled`, `Disabled`

**Assessment:** ✅ **LEGITIMATE DUPLICATE** - Identical, should be unified

---

### 6. **SbeDeploymentPackageInfo**
**Files:** [`models.tsp:5794`](models.tsp:5794), [`edgeMachine.tsp:612`](edgeMachine.tsp:612)

**Usage Context:**
- **models.tsp**: Used in HciReportedProperties
- **edgeMachine.tsp**: Used in EdgeMachine ReportedProperties

**Property Comparison:**
Both have identical properties:
- `code`, `message`, `sbeManifest`

**C# Implementation:** Found as `SbeDeploymentPackage` class in EdgeCommon.cs

**Assessment:** ✅ **LEGITIMATE DUPLICATE** - Identical, can be unified

---

### 7. **ExtensionProfile**
**Files:** [`models.tsp:5320`](models.tsp:5320), [`edgeMachine.tsp:636`](edgeMachine.tsp:636)

**Usage Context:**
- **models.tsp**: Used in general device reporting
- **edgeMachine.tsp**: Used in EdgeMachine reporting

**Property Comparison:**
- **models.tsp**: Contains `HciEdgeDeviceArcExtension[]` 
- **edgeMachine.tsp**: Contains `Extension[]`

**C# Implementation:** Found as `ExtensionProfile` class in EdgeCommon.cs

**Assessment:** ❌ **TRUE DUPLICATE** - Different extension types, legitimate separation

---

### 8. **Extension** vs **HciEdgeDeviceArcExtension**
**Files:** [`Extension.tsp:18`](Extension.tsp:18), [`edgeMachine.tsp:649`](edgeMachine.tsp:649)

**Usage Context:**
- **Extension.tsp**: ARM resource for HCI cluster extensions
- **edgeMachine.tsp**: Extension info for EdgeMachine

**Property Comparison:**
- **Extension.tsp**: Full ARM resource with ExtensionProperties
- **edgeMachine.tsp**: Simple extension info with state and error details

**Assessment:** ❌ **TRUE DUPLICATE** - Different purposes (ARM resource vs. data model)

---

### 9. **ArcExtensionState**
**Files:** [`models.tsp:1533`](models.tsp:1533), [`edgeMachine.tsp:698`](edgeMachine.tsp:698)

**Usage Context:**
- Both used in extension state reporting

**Property Comparison:**
Both have identical enum values:
- `NotSpecified`, `Succeeded`, `Failed`, `Canceled`, `Accepted`
- `Creating`, `Updating`, `Moving`, `Deleting`, `Deleted`

**Assessment:** ✅ **LEGITIMATE DUPLICATE** - Identical, should be unified

---

### 10. **ExtensionManagedBy**
**Files:** [`models.tsp:1043`](models.tsp:1043), [`edgeMachine.tsp:768`](edgeMachine.tsp:768)

**Usage Context:**
- Both used in extension management contexts

**Property Comparison:**
Both have identical enum values:
- `User`, `Azure`

**Assessment:** ✅ **LEGITIMATE DUPLICATE** - Identical, should be unified

---

### 11. **JobStatus**
**Files:** [`models.tsp:1427`](models.tsp:1427), [`edgeMachineJobs.tsp:106`](edgeMachineJobs.tsp:106)

**Usage Context:**
- **models.tsp**: Used in general job contexts
- **edgeMachineJobs.tsp**: Used specifically for EdgeMachine jobs

**Property Comparison:**
Both have identical enum values:
- `NotSpecified`, `ValidationInProgress`, `ValidationSuccess`, `ValidationFailed`
- `DeploymentInProgress`, `DeploymentFailed`, `DeploymentSuccess`
- `Succeeded`, `Failed`, `Canceled`, `Paused`, `Scheduled`

**Assessment:** ✅ **LEGITIMATE DUPLICATE** - Identical, should be unified

---

### 12. Job-Related Models
**Files:** Various job property models across `models.tsp` and `edgeMachineJobs.tsp`

**Usage Context:**
- **models.tsp**: General job properties for HCI operations
- **edgeMachineJobs.tsp**: EdgeMachine-specific job operations

**Assessment:** ❌ **TRUE DUPLICATE** - Different job contexts require different properties

---

### 13. **DeploymentMode**
**Files:** [`models.tsp:730`](models.tsp:730), [`edgeMachineJobs.tsp:450`](edgeMachineJobs.tsp:450)

**Property Comparison:**
Both have identical enum values:
- `Validate`, `Deploy`

**Assessment:** ✅ **LEGITIMATE DUPLICATE** - Identical, should be unified

---

### 14. **Step**
**Files:** [`models.tsp:4085`](models.tsp:4085), [`edgeMachineJobs.tsp:462`](edgeMachineJobs.tsp:462)

**Property Comparison:**
Both have similar but slightly different properties for step reporting

**Assessment:** ❌ **TRUE DUPLICATE** - Different step reporting contexts

---

### 15. **DeviceConfiguration**
**Files:** [`models.tsp:5185`](models.tsp:5185), [`edgeMachineJobs.tsp:631`](edgeMachineJobs.tsp:631)

**Usage Context:**
- **models.tsp**: General device configuration
- **edgeMachineJobs.tsp**: Configuration for job provisioning

**Property Comparison:**
- **models.tsp**: Contains `nicDetails`, `deviceMetadata`
- **edgeMachineJobs.tsp**: Contains `network`, `hostName`, `webProxy`, `time`, `storage`

**Assessment:** ❌ **TRUE DUPLICATE** - Different configuration contexts

---

## Recommendations

### ✅ **Models to Unify (Legitimate Duplicates)**
These models are identical and should be moved to a common location:

1. **NicDetail** - Move to `commonModels.tsp`
2. **SwitchDetail** - Move to `commonModels.tsp`  
3. **SwitchExtension** - Move to `commonModels.tsp`
4. **RdmaCapability** - Move to `commonModels.tsp`
5. **SbeDeploymentPackageInfo** - Move to `commonModels.tsp`
6. **ArcExtensionState** - Move to `commonModels.tsp`
7. **ExtensionManagedBy** - Move to `commonModels.tsp`
8. **JobStatus** - Move to `commonModels.tsp`
9. **DeploymentMode** - Move to `commonModels.tsp`

### ❌ **Models to Keep Separate (True Duplicates)**
These models have different purposes and should remain separate:

1. **ReportedProperties** - Different contexts require different properties
2. **ExtensionProfile** - Different extension types for different resources
3. **Extension models** - ARM resource vs. data model
4. **Job Properties models** - Different job contexts
5. **Step** - Different step reporting requirements
6. **DeviceConfiguration** - Different configuration contexts

### 🔧 **Implementation Actions**

1. **Create unified models** in `commonModels.tsp` for legitimate duplicates
2. **Update imports** in `models.tsp`, `edgeMachine.tsp`, and `edgeMachineJobs.tsp`
3. **Remove duplicate definitions** after import updates
4. **Verify C# code generation** produces consistent results
5. **Update any dependent resources** that reference these models

---

## C# Implementation Alignment

The C# implementation in `EdgeCommon.cs` already uses unified models for:
- `NicDetails` (maps to NicDetail)
- `SwitchDetail` 
- `ExtensionProfile`
- `SbeDeploymentPackage` (maps to SbeDeploymentPackageInfo)

This confirms that unification is the correct approach for these models.

---

**Report Generated:** 2025-12-08  
**Analysis Scope:** Azure Stack HCI TypeSpec Project  
**Files Analyzed:** models.tsp, edgeMachine.tsp, edgeMachineJobs.tsp, Extension.tsp  
**C# Implementation:** EdgeCommon.cs, EdgeMachine.cs, HciCluster.cs
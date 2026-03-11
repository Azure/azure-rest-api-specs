# Model Validation Fixes - 2024-11-01-preview

## Overview

This document details the specific issues identified and resolved during model validation for the Azure Stack HCI API version 2024-11-01-preview on December 3, 2025.

## Initial Validation Results

Before fixes, validation failed with multiple errors related to:
- Missing required properties
- Missing x-ms-examples for operations
- Discriminator value mapping issues
- Invalid properties in examples
- Incorrect operation ID references

## Issues Fixed

### 1. Missing Required Properties

**Issue:** EdgeMachineGpus examples missing required `gpuId` property

**Files Fixed:**
- `examples/2024-11-01-preview/EdgeMachineGpus_List_MaximumSet_Gen.json`

**Solution:** Added complete GPU properties including:
```json
{
  "gpuId": "gpu-001",
  "manufacturer": "NVIDIA",
  "model": "GeForce RTX 4090",
  "status": "Available",
  "pciLocation": "0000:01:00.0",
  "assignable": true,
  "partitionable": true,
  "assignmentStatus": "Unassigned",
  "gpuMode": "Unknown",
  "provisioningState": "Succeeded"
}
```

### 2. Missing x-ms-examples

**Issue:** Several EdgeMachineGpu operations lacked example files

**Files Created:**
- `examples/2024-11-01-preview/EdgeMachineGpus_Get_MaximumSet_Gen.json`
- `examples/2024-11-01-preview/EdgeMachineGpus_CreateOrUpdate_MaximumSet_Gen.json`
- `examples/2024-11-01-preview/EdgeMachineGpus_Delete_MaximumSet_Gen.json`
- `examples/2024-11-01-preview/EdgeMachineGpuJobs_Get_MaximumSet_Gen.json`

### 3. Discriminator Value Mapping

**Issue:** EdgeMachineGpuJob discriminator types not properly defined

**File Modified:** `private-preview/edgemachinegpujobs-pvt.tsp`

**Solution:** Added concrete discriminated model classes:
```typescript
model CreatePartitionGpuJobProperties extends EdgeMachineGpuJobProperties {
  jobType: EdgeMachineGpuJobType.CreatePartition;
}

model SwitchModeGpuJobProperties extends EdgeMachineGpuJobProperties {
  jobType: EdgeMachineGpuJobType.SwitchMode;
}

model AssignPartitionGpuJobProperties extends EdgeMachineGpuJobProperties {
  jobType: EdgeMachineGpuJobType.AssignPartition;
}

model RemovePartitionGpuJobProperties extends EdgeMachineGpuJobProperties {
  jobType: EdgeMachineGpuJobType.RemovePartition;
}
```

### 4. Invalid Additional Properties

**Issue:** GPU job examples contained `fromDate` and `toDate` properties that belong to CollectLog jobs

**Files Fixed:**
- `examples/2024-11-01-preview/EdgeMachineGpuJobs_List_MaximumSet_Gen.json`
- `examples/2024-11-01-preview/EdgeMachineGpuJobs_CreateOrUpdate_AssignPartition.json`
- `examples/2024-11-01-preview/EdgeMachineGpuJobs_CreateOrUpdate_CreatePartition.json`
- `examples/2024-11-01-preview/EdgeMachineGpuJobs_CreateOrUpdate_RemovePartition.json`
- `examples/2024-11-01-preview/EdgeMachineGpuJobs_CreateOrUpdate_SwitchMode.json`

**Solution:** Removed `fromDate` and `toDate` properties from all GPU job examples.

### 5. Incorrect Operation ID References

**Issue:** GPU job Get examples referenced `EdgeMachineJobs_Get` instead of `EdgeMachineGpuJobs_Get`

**Files Fixed:**
- `examples/2024-11-01-preview/EdgeMachineGpuJobs_Get_AssignPartition.json`
- `examples/2024-11-01-preview/EdgeMachineGpuJobs_Get_CreatePartition.json`
- `examples/2024-11-01-preview/EdgeMachineGpuJobs_Get_RemovePartition.json`
- `examples/2024-11-01-preview/EdgeMachineGpuJobs_Get_SwitchMode.json`

**Solution:** Updated `operationId` from `EdgeMachineJobs_Get` to `EdgeMachineGpuJobs_Get` and removed invalid date properties.

### 6. Invalid `gpuName` Property (Second Fix Session)

**Issue:** EdgeMachineGpu examples contained `gpuName` property that is not defined in the [`EdgeMachineGpuProperties`](private-preview/edgemachinegpu-pvt.tsp:67) TypeSpec model

**Error Message:**
```
OBJECT_ADDITIONAL_PROPERTIES: Additional properties not allowed: gpuName
```

**Files Fixed:**
- `examples/2024-11-01-preview/EdgeMachineGpus_List_MaximumSet_Gen.json`
- `examples/2024-11-01-preview/EdgeMachineGpus_Get_MaximumSet_Gen.json`
- `examples/2024-11-01-preview/EdgeMachineGpus_CreateOrUpdate_MaximumSet_Gen.json`

**Root Cause:** The `gpuName` is a path parameter (resource identifier), not a response body property. The TypeSpec model only defines `gpuId` as a property.

**Solution:** Removed `gpuName` from the properties section of all EdgeMachineGpu response examples.

**Root Cause Analysis:** The TypeSpec compilation process copies source files from `examples/{API_VERSION}/` to `preview/{API_VERSION}/examples/`. The validation tool reads from the target directory, not the source files.

**Critical Learning:** Always run `tsp compile .` after modifying example files to ensure:
1. OpenAPI schema is regenerated: `preview/2024-11-01-preview/hci.json`
2. Source examples are copied to target: `examples/2024-11-01-preview/*.json` → `preview/2024-11-01-preview/examples/*.json`
3. Validation reads from updated target files

## Validation Commands Used

```bash
# Compile TypeSpec
tsp compile .

# Run validation
npx oav validate-example preview/2024-11-01-preview/hci.json
```

## Final Result

After applying all fixes:
- ✅ TypeSpec compilation successful
- ✅ Model validation passes without errors
- ✅ All required examples created
- ✅ All discriminated types properly defined

## Validation Output

```
Validation completes without errors.
```

## Files Summary

**Modified TypeSpec Files:**
- `private-preview/edgemachinegpujobs-pvt.tsp` - Added discriminated model classes

**Created Example Files:**
- `examples/2024-11-01-preview/EdgeMachineGpus_Get_MaximumSet_Gen.json`
- `examples/2024-11-01-preview/EdgeMachineGpus_CreateOrUpdate_MaximumSet_Gen.json`
- `examples/2024-11-01-preview/EdgeMachineGpus_Delete_MaximumSet_Gen.json`
- `examples/2024-11-01-preview/EdgeMachineGpuJobs_Get_MaximumSet_Gen.json`

**Modified Source Example Files:**
- `examples/2024-11-01-preview/EdgeMachineGpus_List_MaximumSet_Gen.json`
- `examples/2024-11-01-preview/EdgeMachineGpus_Get_MaximumSet_Gen.json`
- `examples/2024-11-01-preview/EdgeMachineGpus_CreateOrUpdate_MaximumSet_Gen.json`
- All EdgeMachineGpuJob examples (removed invalid properties and fixed operation IDs)

**Generated Target Files (copied during `tsp compile .`):**
- `preview/2024-11-01-preview/examples/EdgeMachineGpus_List_MaximumSet_Gen.json`
- `preview/2024-11-01-preview/examples/EdgeMachineGpus_Get_MaximumSet_Gen.json`
- `preview/2024-11-01-preview/examples/EdgeMachineGpus_CreateOrUpdate_MaximumSet_Gen.json`
- All corresponding EdgeMachineGpuJob target examples

## Lessons Learned

1. **Discriminated Types:** Always define concrete classes for discriminated union types
2. **Property Validation:** Ensure examples only include properties defined in their specific TypeSpec models
3. **Operation Mapping:** Verify example files reference the correct operation IDs
4. **Required Properties:** Include all required properties as defined in TypeSpec models
5. **Property vs Parameter:** Distinguish between path parameters (resource identifiers) and response body properties
6. **File Compilation Process:** Understand that you edit source files (`examples/{API_VERSION}/`) but validation runs against target files (`preview/{API_VERSION}/examples/`)
7. **Compilation Order:** **ALWAYS** run `tsp compile .` after ANY changes to example files or TypeSpec models to copy source files to target directory before validation
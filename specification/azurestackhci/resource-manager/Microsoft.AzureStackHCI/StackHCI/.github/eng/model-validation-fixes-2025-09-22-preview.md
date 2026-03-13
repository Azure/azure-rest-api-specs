# Model Validation Fixes - 2025-09-22-preview

## Overview

This document details the specific issues identified and resolved during model validation for the Azure Stack HCI API version 2025-09-22-preview on December 4, 2024.

## Initial Validation Results

Before fixes, validation failed with multiple errors related to:
- Missing required properties (`edgeDeviceName`)
- Discriminator value mapping issues for `ConfigureCVM` and `ConfigureSdnIntegration`
- Incorrect TypeSpec model structure
- File naming mismatch between import and actual file

## Issues Fixed

### 1. Incorrect Path Parameter in TypeSpec Model

**Issue:** The [`ClusterJob`](ClusterJobs.tsp:17) model was incorrectly defined with `edgeDeviceName` as the path parameter instead of `jobsName`.

**Root Cause:** The TypeSpec model structure was inconsistent with the expected ClusterJobs API pattern.

**Original Code:**
```typescript
@extensionResource
@parentResource(Cluster)
model ClusterJob is Azure.ResourceManager.ProxyResource<ClusterJobProperties> {
  @path
  @key("edgeDeviceName")
  @segment("edgeDevices")
  @pattern("^[a-zA-Z0-9-]{3,24}$")
  name: string = "default";
}
```

**Fixed Code:**
```typescript
@parentResource(Cluster)
model ClusterJob is Azure.ResourceManager.ProxyResource<ClusterJobProperties> {
  ...ResourceNameParameter<
    Resource = ClusterJob,
    KeyName = "jobsName",
    SegmentName = "jobs",
    NamePattern = "^[a-zA-Z0-9-]{3,24}$"
  >;
}
```

**Solution:** Updated the model to use the correct `jobsName` parameter and proper resource naming pattern.

### 2. File Naming Mismatch

**Issue:** [`main.tsp`](main.tsp:23) imported `"./ClusterJobs.tsp"` but the actual file was named `clusterJobs.tsp` (lowercase c).

**Solution:** Renamed `clusterJobs.tsp` to `ClusterJobs.tsp` to match the import statement.

**Command Used:**
```bash
ren clusterJobs.tsp ClusterJobs.tsp
```

### 3. Discriminator Value Not Found

**Issue:** Example files referenced discriminator values `ConfigureCVM` and `ConfigureSdnIntegration` that were not defined in the TypeSpec model.

**Error Messages:**
```
DISCRIMINATOR_VALUE_NOT_FOUND: Discriminator value "ConfigureCVM" not found
DISCRIMINATOR_VALUE_NOT_FOUND: Discriminator value "ConfigureSdnIntegration" not found
```

**Files Affected:**
- `examples/2025-09-22-preview/ClusterJobs_CreateOrUpdate_ConfigureCVM.json`
- `examples/2025-09-22-preview/ClusterJobs_CreateOrUpdate_ConfigureSdnIntegration_Enable.json`

**Solution:** Per user requirements, removed the unsupported job types and deleted the corresponding example files to focus only on supported operations.

### 4. Target File Cleanup - Critical Delete Scenario

**Issue:** Deleting source example files didn't automatically remove the corresponding target files in `preview/2025-09-22-preview/examples/`.

**Root Cause:** The TypeSpec compilation process (`tsp compile .`) copies source files from `examples/{API_VERSION}/` to `preview/{API_VERSION}/examples/` but does not automatically clean up deleted source files from the target directory.

**Delete Scenario Specifics:**
1. **Source File Deletion:** When you delete files from `examples/2025-09-22-preview/`, the next `tsp compile .` will NOT remove the corresponding files from `preview/2025-09-22-preview/examples/`
2. **Validation Impact:** The model validation command `npx oav validate-example preview/2025-09-22-preview/hci.json` reads from the target directory (`preview/2025-09-22-preview/examples/`), so it will continue to find and validate the old deleted examples
3. **Manual Cleanup Required:** You must manually delete the target files to ensure they are not included in validation

**Critical Learning for Delete Operations:**
- **Step 1:** Delete source files: `examples/{API_VERSION}/filename.json`
- **Step 2:** Delete corresponding target files: `preview/{API_VERSION}/examples/filename.json`
- **Step 3:** Run `tsp compile .` to ensure clean compilation
- **Step 4:** Run validation to confirm deleted files are no longer validated

**Commands Used:**
```bash
# Delete source files
del "examples/2025-09-22-preview/ClusterJobs_CreateOrUpdate_ConfigureCVM.json"
del "examples/2025-09-22-preview/ClusterJobs_CreateOrUpdate_ConfigureSdnIntegration_Enable.json"

# Critical: Also delete target files (validation reads from here)
del "preview/2025-09-22-preview/examples/ClusterJobs_CreateOrUpdate_ConfigureCVM.json"
del "preview/2025-09-22-preview/examples/ClusterJobs_CreateOrUpdate_ConfigureSdnIntegration_Enable.json"
```

**Why This Matters:** If you only delete source files and forget target files, validation will continue to fail on the old examples that still exist in the target directory, making it appear as if your TypeSpec fixes didn't work.

## Validation Commands Used

```bash
# Compile TypeSpec
tsp compile .

# Run validation
npx oav validate-example preview/2025-09-22-preview/hci.json
```

## Final Result

After applying all fixes:
- ✅ TypeSpec compilation successful
- ✅ Model validation passes without errors
- ✅ Correct path parameter structure
- ✅ File naming consistency
- ✅ All example files reference valid operation IDs

## Validation Output

```
Validation completes without errors.
```

## Files Summary

**Modified TypeSpec Files:**
- `ClusterJobs.tsp` (renamed from `clusterJobs.tsp`) - Fixed model structure and path parameters

**Deleted Source Example Files:**
- `examples/2025-09-22-preview/ClusterJobs_CreateOrUpdate_ConfigureCVM.json`
- `examples/2025-09-22-preview/ClusterJobs_CreateOrUpdate_ConfigureSdnIntegration_Enable.json`

**Deleted Target Example Files:**
- `preview/2025-09-22-preview/examples/ClusterJobs_CreateOrUpdate_ConfigureCVM.json`
- `preview/2025-09-22-preview/examples/ClusterJobs_CreateOrUpdate_ConfigureSdnIntegration_Enable.json`

**Remaining Valid Examples:**
- `examples/2025-09-22-preview/ClusterJobs_CreateOrUpdate_ConfigureArcGateway.json` ✅
- `examples/2025-09-22-preview/ClusterJobs_Get_ConfigureArcGatewayJob.json` ✅
- `examples/2025-09-22-preview/ClusterJobs_Delete.json` ✅
- `examples/2025-09-22-preview/ClusterJobs_List.json` ✅

## Current Supported ClusterJob Types

The 2025-09-22-preview API version currently supports:

```typescript
union HciJobType {
  string,

  /** Job to configure arc gateway for the cluster. */
  ConfigureArcGateway: "ConfigureArcGateway",
}
```

**Concrete Model:**
```typescript
model HciConfigureArcGatewayJobProperties extends ClusterJobProperties {
  jobType: HciJobType.ConfigureArcGateway;
}
```

## Lessons Learned

1. **File Naming Consistency:** Ensure TypeSpec file names exactly match import statements (case-sensitive)
2. **Path Parameter Accuracy:** Verify path parameters match the intended API resource structure
3. **Discriminator Type Management:** Only define discriminator values that are actually supported in the API
4. **Critical Delete Scenario:** When removing example files, **ALWAYS** delete both:
   - Source files: `examples/{API_VERSION}/filename.json`
   - Target files: `preview/{API_VERSION}/examples/filename.json`
   - Validation reads from target directory, so source-only deletion will not fix validation errors
5. **Compilation Order:** Always run `tsp compile .` after TypeSpec model changes before validation
6. **Scope Management:** Focus on supported operations rather than adding unsupported discriminator types
7. **Target Directory Understanding:** Remember that validation operates on `preview/{API_VERSION}/` files, not source `examples/{API_VERSION}/` files

## API Coverage

All ClusterJobs operations are covered with valid examples:
- ✅ `ClusterJobs_Get` - ConfigureArcGateway job type
- ✅ `ClusterJobs_CreateOrUpdate` - ConfigureArcGateway job type  
- ✅ `ClusterJobs_Delete` - Generic delete operation
- ✅ `ClusterJobs_List` - List all cluster jobs

The validation confirms that all required ClusterJobs operation IDs have corresponding example files and the TypeSpec models properly support the ConfigureArcGateway job type.
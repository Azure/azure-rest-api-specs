import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Azure.ClientGenerator.Core.Legacy;
using Microsoft.RecoveryServices;

// Restore the original 2023-01-15 discriminated-type nesting on the emitted wire.
// The variant models are declared in source as direct children of their @discriminator
// root (ProtectedItem / RecoveryPoint / RestoreRequest) so each - including the
// intermediate types - gets its own concrete x-ms-discriminator-value (TypeSpec cannot
// emit a value for an intermediate that itself carries @discriminator, and a child
// cannot override a parent's fixed-literal discriminator). @@hierarchyBuilding then
// re-parents the emitted `allOf` back to the original intermediate, reproducing the
// frozen swagger's nested hierarchy exactly. Mirrors the active-stamp (2025-01-01).
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Required to reproduce the frozen 2023-01-15 discriminated-type nesting."
@@hierarchyBuilding(
  AzureIaaSClassicComputeVMProtectedItem,
  AzureIaaSVMProtectedItem
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Required to reproduce the frozen 2023-01-15 discriminated-type nesting."
@@hierarchyBuilding(AzureIaaSComputeVMProtectedItem, AzureIaaSVMProtectedItem);

// AzureVmWorkloadProtectedItem family (ProtectedItem tree).
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Required to reproduce the frozen 2023-01-15 discriminated-type nesting."
@@hierarchyBuilding(
  AzureVmWorkloadSAPAseDatabaseProtectedItem,
  AzureVmWorkloadProtectedItem
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Required to reproduce the frozen 2023-01-15 discriminated-type nesting."
@@hierarchyBuilding(
  AzureVmWorkloadSAPHanaDatabaseProtectedItem,
  AzureVmWorkloadProtectedItem
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Required to reproduce the frozen 2023-01-15 discriminated-type nesting."
@@hierarchyBuilding(
  AzureVmWorkloadSQLDatabaseProtectedItem,
  AzureVmWorkloadProtectedItem
);

// AzureWorkloadRecoveryPoint family (RecoveryPoint tree).
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Required to reproduce the frozen 2023-01-15 discriminated-type nesting."
@@hierarchyBuilding(
  AzureWorkloadPointInTimeRecoveryPoint,
  AzureWorkloadRecoveryPoint
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Required to reproduce the frozen 2023-01-15 discriminated-type nesting."
@@hierarchyBuilding(
  AzureWorkloadSAPHanaRecoveryPoint,
  AzureWorkloadRecoveryPoint
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Required to reproduce the frozen 2023-01-15 discriminated-type nesting."
@@hierarchyBuilding(AzureWorkloadSQLRecoveryPoint, AzureWorkloadRecoveryPoint);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Required to reproduce the frozen 2023-01-15 discriminated-type nesting."
@@hierarchyBuilding(
  AzureWorkloadSAPHanaPointInTimeRecoveryPoint,
  AzureWorkloadPointInTimeRecoveryPoint
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Required to reproduce the frozen 2023-01-15 discriminated-type nesting."
@@hierarchyBuilding(
  AzureWorkloadSQLPointInTimeRecoveryPoint,
  AzureWorkloadSQLRecoveryPoint
);

// AzureWorkloadRestoreRequest family (RestoreRequest tree).
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Required to reproduce the frozen 2023-01-15 discriminated-type nesting."
@@hierarchyBuilding(
  AzureWorkloadPointInTimeRestoreRequest,
  AzureWorkloadRestoreRequest
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Required to reproduce the frozen 2023-01-15 discriminated-type nesting."
@@hierarchyBuilding(
  AzureWorkloadSAPHanaRestoreRequest,
  AzureWorkloadRestoreRequest
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Required to reproduce the frozen 2023-01-15 discriminated-type nesting."
@@hierarchyBuilding(
  AzureWorkloadSQLRestoreRequest,
  AzureWorkloadRestoreRequest
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Required to reproduce the frozen 2023-01-15 discriminated-type nesting."
@@hierarchyBuilding(
  AzureWorkloadSAPHanaPointInTimeRestoreRequest,
  AzureWorkloadSAPHanaRestoreRequest
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Required to reproduce the frozen 2023-01-15 discriminated-type nesting."
@@hierarchyBuilding(
  AzureWorkloadSQLPointInTimeRestoreRequest,
  AzureWorkloadSQLRestoreRequest
);

// The legacy CRR envelope model is named `Resource` to stay wire-faithful to the
// frozen 2023-01-15 swagger (definition name "Resource"). That name collides with
// the ARM common-types `Resource` in the SDK client scope (duplicate-client-name).
// Rename it consistently across all generated SDK languages (csharp, java, python,
// javascript, go). The autorest emitter is intentionally not in scope, so the
// emitted swagger definition remains "Resource".
@@clientName(Resource, "CrrResource", "csharp,java,python,javascript,go");

@@clientLocation(
  BackupResourceConfigResources.get,
  "BackupResourceStorageConfigs"
);
@@clientLocation(
  BackupResourceConfigResources.update,
  "BackupResourceStorageConfigs"
);
@@clientName(
  BackupResourceConfigResources.update::parameters.resource,
  "parameters"
);
@@clientLocation(
  BackupResourceConfigResources.patch,
  "BackupResourceStorageConfigs"
);
@@clientName(BackupResourceConfigResources.patch, "patch");
@@clientName(
  BackupResourceConfigResources.patch::parameters.properties,
  "parameters"
);

@@clientLocation(RecoveryPointResources.get, "RecoveryPointsCrr");
@@clientLocation(RecoveryPointResources.list, "RecoveryPointsCrr");
@@clientLocation(RecoveryPointGetAccessToken.getAccessToken, "RecoveryPoints");
@@clientName(
  RecoveryPointGetAccessToken.getAccessToken::parameters.body,
  "parameters"
);

@@clientLocation(
  BackupUsageSummariesCRROperationGroup.list,
  "BackupUsageSummariesCRR"
);

@@clientLocation(AadPropertiesOperationGroup.get, "AadProperties");

@@clientLocation(
  CrossRegionRestoreOperationGroup.trigger,
  "CrossRegionRestore"
);

@@clientLocation(BackupCrrJobDetailsOperationGroup.get, "BackupCrrJobDetails");

@@clientLocation(BackupCrrJobsOperationGroup.list, "BackupCrrJobs");

@@clientLocation(CrrOperationResultsOperationGroup.get, "CrrOperationResults");

@@clientLocation(CrrOperationStatusOperationGroup.get, "CrrOperationStatus");

@@clientLocation(
  BackupProtectedItemsCrrOperationGroup.list,
  "BackupProtectedItemsCrr"
);

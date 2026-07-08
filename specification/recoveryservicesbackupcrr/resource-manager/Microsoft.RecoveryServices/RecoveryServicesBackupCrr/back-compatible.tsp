import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.RecoveryServices;

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

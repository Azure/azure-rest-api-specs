import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.RecoveryServices;

@@clientLocation(RecoveryPointResources.get, "RecoveryPointsCrr");
@@clientLocation(RecoveryPointResources.list, "RecoveryPointsCrr");
@@clientLocation(RecoveryPointResources.getAccessToken, "RecoveryPoints");
@@clientName(
  RecoveryPointResources.getAccessToken::parameters.parameters,
  "parameters"
);

@@clientLocation(
  BackupResourceConfigResources.get,
  "BackupResourceStorageConfigs"
);
@@clientLocation(
  BackupResourceConfigResources.update,
  "BackupResourceStorageConfigs"
);
@@clientName(
  BackupResourceConfigResources.update::parameters.parameters,
  "parameters"
);
@@clientLocation(
  BackupResourceConfigResources.patch,
  "BackupResourceStorageConfigs"
);
@@clientName(BackupResourceConfigResources.patch, "patch");
@@clientName(
  BackupResourceConfigResources.patch::parameters.parameters,
  "parameters"
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

@@clientLocation(
  BackupUsageSummariesCRROperationGroup.list,
  "BackupUsageSummariesCRR"
);

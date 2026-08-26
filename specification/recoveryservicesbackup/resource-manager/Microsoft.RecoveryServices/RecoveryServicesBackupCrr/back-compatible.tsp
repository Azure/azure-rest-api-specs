import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.RecoveryServices;

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
@@clientLocation(RecoveryPointResources.getAccessToken, "RecoveryPoints");
@@clientName(
  RecoveryPointResources.getAccessToken::parameters.body,
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

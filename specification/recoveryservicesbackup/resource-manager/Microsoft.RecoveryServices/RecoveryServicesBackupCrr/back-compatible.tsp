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
@@clientName(
  CrossRegionRestoreOperationGroup.trigger::parameters.body,
  "parameters"
);

@@clientLocation(BackupCrrJobDetailsOperationGroup.get, "BackupCrrJobDetails");
@@clientName(
  BackupCrrJobDetailsOperationGroup.get::parameters.body,
  "parameters"
);

@@clientLocation(BackupCrrJobsOperationGroup.list, "BackupCrrJobs");
@@clientName(BackupCrrJobsOperationGroup.list::parameters.body, "parameters");

@@clientLocation(CrrOperationResultsOperationGroup.get, "CrrOperationResults");

@@clientLocation(CrrOperationStatusOperationGroup.get, "CrrOperationStatus");

@@clientLocation(
  BackupProtectedItemsCrrOperationGroup.list,
  "BackupProtectedItemsCrr"
);

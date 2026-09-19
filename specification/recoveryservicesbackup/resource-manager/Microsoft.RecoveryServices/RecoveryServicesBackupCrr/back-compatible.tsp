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
  BackupUsageSummariesCrrOperationGroup.list,
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

// Preserve original SDK model names after PascalCase spec renames (casing-style).
// Spec names favor standard TypeSpec casing; these mappings keep SDK/wire-adjacent
// names identical to the shipped RecoveryServicesBackup contract to avoid SDK breaks.
@@clientName(AadPropertiesResource, "AADPropertiesResource");
@@clientName(AadProperties, "AADProperties");
@@clientName(BmsBackupSummariesQueryObject, "BMSBackupSummariesQueryObject");
@@clientName(KpiResourceHealthDetails, "KPIResourceHealthDetails");
@@clientName(TargetAfsRestoreInfo, "TargetAFSRestoreInfo");
@@clientName(
  AzureIaasClassicComputeVmProtectedItem,
  "AzureIaaSClassicComputeVMProtectedItem"
);
@@clientName(AzureIaasVmHealthDetails, "AzureIaaSVMHealthDetails");
@@clientName(
  AzureIaasVmProtectedItemExtendedInfo,
  "AzureIaaSVMProtectedItemExtendedInfo"
);
@@clientName(AzureIaasComputeVmProtectedItem, "AzureIaaSComputeVMProtectedItem");
@@clientName(AzureIaasVmErrorInfo, "AzureIaaSVMErrorInfo");
@@clientName(AzureIaasVmJobExtendedInfo, "AzureIaaSVMJobExtendedInfo");
@@clientName(AzureIaasVmJobTaskDetails, "AzureIaaSVMJobTaskDetails");
@@clientName(
  AzureVmWorkloadSapAseDatabaseProtectedItem,
  "AzureVmWorkloadSAPAseDatabaseProtectedItem"
);
@@clientName(
  AzureVmWorkloadSapHanaDatabaseProtectedItem,
  "AzureVmWorkloadSAPHanaDatabaseProtectedItem"
);
@@clientName(
  AzureVmWorkloadSqlDatabaseProtectedItem,
  "AzureVmWorkloadSQLDatabaseProtectedItem"
);
@@clientName(
  AzureWorkloadSqlRecoveryPointExtendedInfo,
  "AzureWorkloadSQLRecoveryPointExtendedInfo"
);
@@clientName(SqlDataDirectory, "SQLDataDirectory");
@@clientName(SqlDataDirectoryMapping, "SQLDataDirectoryMapping");
@@clientName(BekDetails, "BEKDetails");
@@clientName(BmsrpQueryObject, "BMSRPQueryObject");
@@clientName(DpmProtectedItemExtendedInfo, "DPMProtectedItemExtendedInfo");
@@clientName(KekDetails, "KEKDetails");
@@clientName(BmsAadPropertiesQueryObject, "BMSAADPropertiesQueryObject");

// Group-2 models whose original name is also the wire x-ms-discriminator-value.
// The spec symbol is renamed to PascalCase; the discriminator string literals
// (objectType and x-ms-discriminator-value) are left verbatim, and these mappings
// keep the emitted definition key / SDK name identical to the original contract.
@@clientName(AzureIaasVmProtectedItem, "AzureIaaSVMProtectedItem");
@@clientName(DpmProtectedItem, "DPMProtectedItem");
@@clientName(IaasVmRecoveryPoint, "IaasVMRecoveryPoint");
@@clientName(IaasVmRestoreRequest, "IaasVMRestoreRequest");
@@clientName(
  OperationStatusProvisionIlrExtendedInfo,
  "OperationStatusProvisionILRExtendedInfo"
);
@@clientName(AzureWorkloadSapHanaRecoveryPoint, "AzureWorkloadSAPHanaRecoveryPoint");
@@clientName(
  AzureWorkloadSapHanaRestoreRequest,
  "AzureWorkloadSAPHanaRestoreRequest"
);
@@clientName(
  AzureWorkloadSapHanaPointInTimeRecoveryPoint,
  "AzureWorkloadSAPHanaPointInTimeRecoveryPoint"
);
@@clientName(
  AzureWorkloadSapHanaPointInTimeRestoreRequest,
  "AzureWorkloadSAPHanaPointInTimeRestoreRequest"
);
@@clientName(AzureWorkloadSqlRecoveryPoint, "AzureWorkloadSQLRecoveryPoint");
@@clientName(AzureWorkloadSqlRestoreRequest, "AzureWorkloadSQLRestoreRequest");
@@clientName(
  AzureWorkloadSqlPointInTimeRecoveryPoint,
  "AzureWorkloadSQLPointInTimeRecoveryPoint"
);
@@clientName(
  AzureWorkloadSqlPointInTimeRestoreRequest,
  "AzureWorkloadSQLPointInTimeRestoreRequest"
);

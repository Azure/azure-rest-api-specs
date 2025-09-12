import "@azure-tools/typespec-client-generator-core";
import "./main.tsp";

using Azure.ClientGenerator.Core;
using Microsoft.RecoveryServices;

@@clientLocation(BackupResourceStorageConfigsNonCRR.bmsPrepareDataMove,
  "Client",
  "go"
);
@@clientLocation(BackupResourceStorageConfigsNonCRR.bmsTriggerDataMove,
  "Client",
  "go"
);
@@clientLocation(BackupResourceConfigOperationStatuses.getOperationStatus,
  "Client",
  "go"
);

@@clientLocation(RecoveryPoints.moveRecoveryPoint, "Client", "go");

// Migration mappings added to mitigate Java SDK breaking changes after TypeSpec migration
@@clientName(Microsoft.RecoveryServices.IaaSVMContainer,
  "IaaSvmContainer",
  "java"
);
@@clientName(Microsoft.RecoveryServices.AzureIaaSVMProtectedItem,
  "AzureIaaSvmProtectedItem",
  "java"
);
@@alternateType(Microsoft.RecoveryServices.InquiryValidation.protectableItemCount,
  unknown,
  "java"
);
@@clientName(Microsoft.RecoveryServices.AzureIaaSVMJob,
  "AzureIaaSvmJob",
  "java"
);
@@clientName(Microsoft.RecoveryServices.AzureIaaSVMJobV2,
  "AzureIaaSvmJobV2",
  "java"
);
@@clientName(Microsoft.RecoveryServices.AzureIaaSVMJobExtendedInfo,
  "AzureIaaSvmJobExtendedInfo",
  "java"
);
@@clientName(Microsoft.RecoveryServices.AzureIaaSVMJobTaskDetails,
  "AzureIaaSvmJobTaskDetails",
  "java"
);
@@clientName(Microsoft.RecoveryServices.AzureIaaSVMErrorInfo,
  "AzureIaaSvmErrorInfo",
  "java"
);
@@clientName(Microsoft.RecoveryServices.AzureIaaSVMHealthDetails,
  "AzureIaaSvmHealthDetails",
  "java"
);
@@clientName(Microsoft.RecoveryServices.AzureIaaSVMProtectedItemExtendedInfo,
  "AzureIaaSvmProtectedItemExtendedInfo",
  "java"
);
@@clientName(Microsoft.RecoveryServices.AzureIaaSVMProtectionPolicy,
  "AzureIaaSvmProtectionPolicy",
  "java"
);
@@clientName(Microsoft.RecoveryServices.IaaSVMProtectableItem,
  "IaasVMProtectableItem",
  "java"
);
@@clientName(Microsoft.RecoveryServices.IaasVMILRRegistrationRequest,
  "IaasVmilrRegistrationRequest",
  "java"
);
@@clientName(Microsoft.RecoveryServices.IAASVMPolicyType,
  "IaasvmPolicyType",
  "java"
);

// Additional migrations for SQL/SAP related types
@@clientName(Microsoft.RecoveryServices.AzureWorkloadSQLAutoProtectionIntent,
  "AzureWorkloadSqlAutoProtectionIntent",
  "java"
);
@@clientName(Microsoft.RecoveryServices.AzureWorkloadSQLRecoveryPoint,
  "AzureWorkloadSqlRecoveryPoint",
  "java"
);
@@clientName(Microsoft.RecoveryServices.AzureWorkloadSQLPointInTimeRecoveryPoint,
  "AzureWorkloadSqlPointInTimeRecoveryPoint",
  "java"
);
@@clientName(Microsoft.RecoveryServices.AzureWorkloadSQLRestoreRequest,
  "AzureWorkloadSqlRestoreRequest",
  "java"
);
@@clientName(Microsoft.RecoveryServices.AzureWorkloadSQLRestoreWithRehydrateRequest,
  "AzureWorkloadSqlRestoreWithRehydrateRequest",
  "java"
);
@@clientName(Microsoft.RecoveryServices.AzureWorkloadSQLPointInTimeRestoreRequest,
  "AzureWorkloadSqlPointInTimeRestoreRequest",
  "java"
);
@@clientName(Microsoft.RecoveryServices.AzureWorkloadSQLPointInTimeRestoreWithRehydrateRequest,
  "AzureWorkloadSqlPointInTimeRestoreWithRehydrateRequest",
  "java"
);
@@clientName(Microsoft.RecoveryServices.AzureWorkloadSQLRecoveryPointExtendedInfo,
  "AzureWorkloadSqlRecoveryPointExtendedInfo",
  "java"
);

// SAP related mappings
@@clientName(Microsoft.RecoveryServices.AzureWorkloadSAPHanaRestoreRequest,
  "AzureWorkloadSapHanaRestoreRequest",
  "java"
);
@@clientName(Microsoft.RecoveryServices.AzureWorkloadSAPHanaRestoreWithRehydrateRequest,
  "AzureWorkloadSapHanaRestoreWithRehydrateRequest",
  "java"
);
@@clientName(Microsoft.RecoveryServices.AzureWorkloadSAPHanaPointInTimeRestoreRequest,
  "AzureWorkloadSapHanaPointInTimeRestoreRequest",
  "java"
);
@@clientName(Microsoft.RecoveryServices.AzureWorkloadSAPHanaPointInTimeRestoreWithRehydrateRequest,
  "AzureWorkloadSapHanaPointInTimeRestoreWithRehydrateRequest",
  "java"
);
@@clientName(Microsoft.RecoveryServices.AzureWorkloadSAPHanaRecoveryPoint,
  "AzureWorkloadSapHanaRecoveryPoint",
  "java"
);
@@clientName(Microsoft.RecoveryServices.AzureWorkloadSAPHanaPointInTimeRecoveryPoint,
  "AzureWorkloadSapHanaPointInTimeRecoveryPoint",
  "java"
);
@@clientName(Microsoft.RecoveryServices.AzureWorkloadSAPAseRecoveryPoint,
  "AzureWorkloadSapAseRecoveryPoint",
  "java"
);
@@clientName(Microsoft.RecoveryServices.AzureWorkloadSAPAseRestoreRequest,
  "AzureWorkloadSapAseRestoreRequest",
  "java"
);
@@clientName(Microsoft.RecoveryServices.AzureWorkloadSAPAsePointInTimeRecoveryPoint,
  "AzureWorkloadSapAsePointInTimeRecoveryPoint",
  "java"
);
@@clientName(Microsoft.RecoveryServices.AzureWorkloadSAPAsePointInTimeRestoreRequest,
  "AzureWorkloadSapAsePointInTimeRestoreRequest",
  "java"
);

// VM Workload related mappings
@@clientName(Microsoft.RecoveryServices.AzureVmWorkloadSQLDatabaseProtectedItem,
  "AzureVmWorkloadSqlDatabaseProtectedItem",
  "java"
);
@@clientName(Microsoft.RecoveryServices.AzureVmWorkloadSQLDatabaseProtectableItem,
  "AzureVmWorkloadSqlDatabaseProtectableItem",
  "java"
);
@@clientName(Microsoft.RecoveryServices.AzureVmWorkloadSQLDatabaseWorkloadItem,
  "AzureVmWorkloadSqlDatabaseWorkloadItem",
  "java"
);
@@clientName(Microsoft.RecoveryServices.AzureVmWorkloadSQLInstanceProtectableItem,
  "AzureVmWorkloadSqlInstanceProtectableItem",
  "java"
);
@@clientName(Microsoft.RecoveryServices.AzureVmWorkloadSQLInstanceWorkloadItem,
  "AzureVmWorkloadSqlInstanceWorkloadItem",
  "java"
);
@@clientName(Microsoft.RecoveryServices.AzureVmWorkloadSQLAvailabilityGroupProtectableItem,
  "AzureVmWorkloadSqlAvailabilityGroupProtectableItem",
  "java"
);
@@clientName(Microsoft.RecoveryServices.AzureVmWorkloadSAPHanaDatabaseProtectedItem,
  "AzureVmWorkloadSapHanaDatabaseProtectedItem",
  "java"
);
@@clientName(Microsoft.RecoveryServices.AzureVmWorkloadSAPHanaDatabaseProtectableItem,
  "AzureVmWorkloadSapHanaDatabaseProtectableItem",
  "java"
);
@@clientName(Microsoft.RecoveryServices.AzureVmWorkloadSAPHanaDatabaseWorkloadItem,
  "AzureVmWorkloadSapHanaDatabaseWorkloadItem",
  "java"
);
@@clientName(Microsoft.RecoveryServices.AzureVmWorkloadSAPHanaDBInstanceProtectedItem,
  "AzureVmWorkloadSapHanaDBInstanceProtectedItem",
  "java"
);
@@clientName(Microsoft.RecoveryServices.AzureVmWorkloadSAPHanaDBInstance,
  "AzureVmWorkloadSapHanaDBInstance",
  "java"
);
@@clientName(Microsoft.RecoveryServices.AzureVmWorkloadSAPHanaSystemProtectableItem,
  "AzureVmWorkloadSapHanaSystemProtectableItem",
  "java"
);
@@clientName(Microsoft.RecoveryServices.AzureVmWorkloadSAPHanaSystemWorkloadItem,
  "AzureVmWorkloadSapHanaSystemWorkloadItem",
  "java"
);
@@clientName(Microsoft.RecoveryServices.AzureVmWorkloadSAPHanaHSRProtectableItem,
  "AzureVmWorkloadSapHanaHsr",
  "java"
);
@@clientName(Microsoft.RecoveryServices.AzureVmWorkloadSAPAseDatabaseProtectedItem,
  "AzureVmWorkloadSapAseDatabaseProtectedItem",
  "java"
);
@@clientName(Microsoft.RecoveryServices.AzureVmWorkloadSAPAseDatabaseProtectableItem,
  "AzureVmWorkloadSapAseDatabaseProtectableItem",
  "java"
);
@@clientName(Microsoft.RecoveryServices.AzureVmWorkloadSAPAseDatabaseWorkloadItem,
  "AzureVmWorkloadSapAseDatabaseWorkloadItem",
  "java"
);
@@clientName(Microsoft.RecoveryServices.AzureVmWorkloadSAPAseSystemProtectableItem,
  "AzureVmWorkloadSapAseSystemProtectableItem",
  "java"
);
@@clientName(Microsoft.RecoveryServices.AzureVmWorkloadSAPAseSystemWorkloadItem,
  "AzureVmWorkloadSapAseSystemWorkloadItem",
  "java"
);

// SQL and other mappings
@@clientName(Microsoft.RecoveryServices.SQLDataDirectory,
  "SqlDataDirectory",
  "java"
);
@@clientName(Microsoft.RecoveryServices.SQLDataDirectoryType,
  "SqlDataDirectoryType",
  "java"
);
@@clientName(Microsoft.RecoveryServices.SQLDataDirectoryMapping,
  "SqlDataDirectoryMapping",
  "java"
);
@@clientName(Microsoft.RecoveryServices.AzureSQLAGWorkloadContainerProtectionContainer,
  "AzureSqlagWorkloadContainerProtectionContainer",
  "java"
);

// Storage and BMS related mappings
@@clientName(Microsoft.RecoveryServices.BMSPrepareDataMoveOperationResult,
  "BmsPrepareDataMoveOperationResult",
  "java"
);
@@clientName(Microsoft.RecoveryServices.BackupResourceStorageConfigsNonCRR,
  "BackupResourceStorageConfigsNonCrr",
  "java"
);

// Key/secret related mappings
@@clientName(Microsoft.RecoveryServices.KEKDetails, "KekDetails", "java");
@@clientName(Microsoft.RecoveryServices.BEKDetails, "BekDetails", "java");

// Target restore info mapping
@@clientName(Microsoft.RecoveryServices.TargetAFSRestoreInfo,
  "TargetAfsRestoreInfo",
  "java"
);

// Additional ILR related mappings
@@clientName(Microsoft.RecoveryServices.ILRRequest, "IlrRequest", "java");
@@clientName(Microsoft.RecoveryServices.ILRRequestResource,
  "IlrRequestResource",
  "java"
);
@@clientName(Microsoft.RecoveryServices.AzureFileShareProvisionILRRequest,
  "AzureFileShareProvisionIlrRequest",
  "java"
);
@@clientName(Microsoft.RecoveryServices.OperationStatusProvisionILRExtendedInfo,
  "OperationStatusProvisionIlrExtendedInfo",
  "java"
);

// DPM related mappings
@@clientName(Microsoft.RecoveryServices.DPMContainerExtendedInfo,
  "DpmContainerExtendedInfo",
  "java"
);
@@clientName(Microsoft.RecoveryServices.DPMProtectedItem,
  "DpmProtectedItem",
  "java"
);
@@clientName(Microsoft.RecoveryServices.DPMProtectedItemExtendedInfo,
  "DpmProtectedItemExtendedInfo",
  "java"
);

// MAB related mappings
@@clientName(Microsoft.RecoveryServices.MABContainerHealthDetails,
  "MabContainerHealthDetails",
  "java"
);

// KPI related mappings
@@clientName(Microsoft.RecoveryServices.KPIResourceHealthDetails,
  "KpiResourceHealthDetails",
  "java"
);

// ETag property mapping to preserve backward compatibility
@@clientName(Microsoft.RecoveryServices.Resource.eTag, "etag", "java");

// UTC/PIN/VM abbreviation fixes for backward compatibility
@@clientName(Microsoft.RecoveryServices.TokenInformation.securityPIN,
  "securityPin",
  "java"
);
@@clientName(Microsoft.RecoveryServices.SecuredVMDetails.securedVMOsDiskEncryptionSetId,
  "securedVmosDiskEncryptionSetId",
  "java"
);

// UTC property name fixes for backward compatibility
@@clientName(Microsoft.RecoveryServices.ProtectedItem.deferredDeleteTimeInUTC,
  "deferredDeleteTimeInUtc",
  "java"
);
@@clientName(Microsoft.RecoveryServices.AzureWorkloadRecoveryPoint.recoveryPointTimeInUTC,
  "recoveryPointTimeInUtc",
  "java"
);
@@clientName(Microsoft.RecoveryServices.MabFileFolderProtectedItem.deferredDeleteSyncTimeInUTC,
  "deferredDeleteSyncTimeInUtc",
  "java"
);
@@clientName(Microsoft.RecoveryServices.IaasVMBackupRequest.recoveryPointExpiryTimeInUTC,
  "recoveryPointExpiryTimeInUtc",
  "java"
);
@@clientName(Microsoft.RecoveryServices.AzureFileShareBackupRequest.recoveryPointExpiryTimeInUTC,
  "recoveryPointExpiryTimeInUtc",
  "java"
);
@@clientName(Microsoft.RecoveryServices.AzureWorkloadBackupRequest.recoveryPointExpiryTimeInUTC,
  "recoveryPointExpiryTimeInUtc",
  "java"
);
@@clientName(Microsoft.RecoveryServices.AzureWorkloadSQLRecoveryPointExtendedInfo.dataDirectoryTimeInUTC,
  "dataDirectoryTimeInUtc",
  "java"
);

// Service name management operations fixes
@@clientName(Microsoft.RecoveryServices.BackupResourceStorageConfigsNonCRR.bmsPrepareDataMove,
  "bmsPrepareDataMove",
  "java"
);
@@clientName(Microsoft.RecoveryServices.BackupResourceStorageConfigsNonCRR.bmsTriggerDataMove,
  "bmsTriggerDataMove",
  "java"
);

// Actions required property name fix
@@clientName(Microsoft.RecoveryServices.PrivateLinkServiceConnectionState.actionsRequired,
  "actionRequired",
  "java"
);

// IaaS VM protectable item fix
@@clientName(Microsoft.RecoveryServices.IaaSVMProtectableItem,
  "IaasVmProtectableItem",
  "java"
);

// Additional UTC property fixes for specific recovery point types
@@clientName(Microsoft.RecoveryServices.AzureWorkloadSQLPointInTimeRecoveryPoint.recoveryPointTimeInUTC,
  "recoveryPointTimeInUtc",
  "java"
);
@@clientName(Microsoft.RecoveryServices.AzureWorkloadPointInTimeRecoveryPoint.recoveryPointTimeInUTC,
  "recoveryPointTimeInUtc",
  "java"
);
@@clientName(Microsoft.RecoveryServices.AzureWorkloadSQLRecoveryPoint.recoveryPointTimeInUTC,
  "recoveryPointTimeInUtc",
  "java"
);
@@clientName(Microsoft.RecoveryServices.AzureWorkloadSAPHanaPointInTimeRecoveryPoint.recoveryPointTimeInUTC,
  "recoveryPointTimeInUtc",
  "java"
);
@@clientName(Microsoft.RecoveryServices.AzureWorkloadSAPAsePointInTimeRecoveryPoint.recoveryPointTimeInUTC,
  "recoveryPointTimeInUtc",
  "java"
);
@@clientName(Microsoft.RecoveryServices.AzureWorkloadSAPHanaRecoveryPoint.recoveryPointTimeInUTC,
  "recoveryPointTimeInUtc",
  "java"
);
@@clientName(Microsoft.RecoveryServices.AzureWorkloadSAPAseRecoveryPoint.recoveryPointTimeInUTC,
  "recoveryPointTimeInUtc",
  "java"
);

// Merge ResourceGuardProxies into ResourceGuardProxyOperation group
@@clientLocation(Microsoft.RecoveryServices.ResourceGuardProxies.get,
  "ResourceGuardProxyOperation",
  "java"
);
@@clientName(Microsoft.RecoveryServices.ResourceGuardProxies.get,
  "list",
  "java"
);
@@clientLocation(Microsoft.RecoveryServices.ResourceGuardProxies.get,
  "ResourceGuardProxyOperation",
  "java"
);
@@clientLocation(Microsoft.RecoveryServices.ResourceGuardProxy.delete,
  "ResourceGuardProxyOperation",
  "java"
);
@@clientLocation(Microsoft.RecoveryServices.ResourceGuardProxy.put,
  "ResourceGuardProxyOperation",
  "java"
);
@@clientLocation(Microsoft.RecoveryServices.ResourceGuardProxy.unlockDelete,
  "ResourceGuardProxyOperation",
  "java"
);

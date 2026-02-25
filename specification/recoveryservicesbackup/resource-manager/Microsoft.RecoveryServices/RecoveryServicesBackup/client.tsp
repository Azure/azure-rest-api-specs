import "@azure-tools/typespec-client-generator-core";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "./main.tsp";

using Azure.ClientGenerator.Core;
using Microsoft.RecoveryServices;
using Azure.ResourceManager;
using Http;

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
@@clientName(Microsoft.RecoveryServices.BackupEngineBaseResource.eTag,
  "etag",
  "java"
);
@@clientName(Microsoft.RecoveryServices.BackupResourceConfigResource.eTag,
  "etag",
  "java"
);
@@clientName(Microsoft.RecoveryServices.BackupResourceEncryptionConfigExtendedResource.eTag,
  "etag",
  "java"
);
@@clientName(Microsoft.RecoveryServices.BackupResourceEncryptionConfigResource.eTag,
  "etag",
  "java"
);
@@clientName(Microsoft.RecoveryServices.BackupResourceVaultConfigResource.eTag,
  "etag",
  "java"
);
@@clientName(Microsoft.RecoveryServices.JobResource.eTag, "etag", "java");
@@clientName(Microsoft.RecoveryServices.PrivateEndpointConnectionResource.eTag,
  "etag",
  "java"
);
@@clientName(Microsoft.RecoveryServices.ProtectedItemResource.eTag,
  "etag",
  "java"
);
@@clientName(Microsoft.RecoveryServices.ProtectionContainerResource.eTag,
  "etag",
  "java"
);
@@clientName(Microsoft.RecoveryServices.ProtectionIntentResource.eTag,
  "etag",
  "java"
);
@@clientName(Microsoft.RecoveryServices.ProtectionPolicyResource.eTag,
  "etag",
  "java"
);
@@clientName(Microsoft.RecoveryServices.RecoveryPointResource.eTag,
  "etag",
  "java"
);
@@clientName(Microsoft.RecoveryServices.ResourceGuardProxyBaseResource.eTag,
  "etag",
  "java"
);

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
@@clientLocation(Microsoft.RecoveryServices.ResourceGuardProxy.get,
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

@@clientName(Microsoft.RecoveryServices,
  "RecoveryServicesBackupClient",
  "javascript"
);

// Custom operations to reorder parameters (resourceGroupName after vaultName) for various operations

// BMSPrepareDataMoveOperationResult operations
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "customization"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
op bmsPrepareDataMoveOperationResultGet(
  ...ApiVersionParameter,
  ...SubscriptionIdParameter,
  ...Azure.ResourceManager.Legacy.Provider,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path
  vaultName: string,

  ...ResourceGroupParameter,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path
  backupStorageConfigName: "vaultstorageconfig",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path
  operationId: string,
): VaultStorageConfigOperationResultResponse;

@@override(BMSPrepareDataMoveOperationResult.get,
  bmsPrepareDataMoveOperationResultGet,
  "java,go,python,javascript"
);

// BackupEngines operations
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "customization"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
op backupEnginesGet(
  ...ApiVersionParameter,
  ...SubscriptionIdParameter,
  ...Azure.ResourceManager.Legacy.Provider,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path
  vaultName: string,

  ...ResourceGroupParameter,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path
  backupEngineName: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  $filter?: string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  $skipToken?: string,
): BackupEngineBaseResource;

@@override(BackupEngines.get, backupEnginesGet, "java,go,python,javascript");

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "customization"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
op backupEnginesList(
  ...ApiVersionParameter,
  ...SubscriptionIdParameter,
  ...Azure.ResourceManager.Legacy.Provider,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path
  vaultName: string,

  ...ResourceGroupParameter,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  $filter?: string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  $skipToken?: string,
): ArmResponse<BackupEngineBaseResourceList>;

@@override(BackupEngines.list, backupEnginesList, "java,go,python,javascript");

// BackupJobs operations
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "customization"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
op backupJobsList(
  ...ApiVersionParameter,
  ...SubscriptionIdParameter,
  ...Azure.ResourceManager.Legacy.Provider,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path
  vaultName: string,

  ...ResourceGroupParameter,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  $filter?: string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  $skipToken?: string,
): ArmResponse<JobResourceList>;

@@override(BackupJobs.list, backupJobsList, "java,go,python,javascript");

// BackupPolicies operations
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "customization"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
op backupPoliciesList(
  ...ApiVersionParameter,
  ...SubscriptionIdParameter,
  ...Azure.ResourceManager.Legacy.Provider,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path
  vaultName: string,

  ...ResourceGroupParameter,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  $filter?: string,
): ArmResponse<ProtectionPolicyResourceList>;

@@override(BackupPolicies.list,
  backupPoliciesList,
  "java,go,python,javascript"
);

// BackupResourceEncryptionConfigs operations
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "customization"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
op backupResourceEncryptionConfigsGet(
  ...ApiVersionParameter,
  ...SubscriptionIdParameter,
  ...Azure.ResourceManager.Legacy.Provider,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path
  vaultName: string,

  ...ResourceGroupParameter,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path
  backupEncryptionConfig: string,
): BackupResourceEncryptionConfigExtendedResource;

@@override(BackupResourceEncryptionConfigs.get,
  backupResourceEncryptionConfigsGet,
  "java,go,python,javascript"
);

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "customization"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
op backupResourceEncryptionConfigsUpdate(
  ...ApiVersionParameter,
  ...SubscriptionIdParameter,
  ...Azure.ResourceManager.Legacy.Provider,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path
  vaultName: string,

  ...ResourceGroupParameter,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path
  backupEncryptionConfig: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  parameters: BackupResourceEncryptionConfigResource,
): ArmResponse<BackupResourceEncryptionConfig>;

@@override(BackupResourceEncryptionConfigs.update,
  backupResourceEncryptionConfigsUpdate,
  "java,go,python,javascript"
);

// BackupResourceStorageConfigsNonCRR operations
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "customization"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
#suppress "@azure-tools/typespec-azure-core/casing-style" "override"
op backupResourceStorageConfigsNonCRRGet(
  ...ApiVersionParameter,
  ...SubscriptionIdParameter,
  ...Azure.ResourceManager.ProviderNamespace<BackupResourceConfigResource>,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path
  vaultName: string,

  ...ResourceGroupParameter,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path
  backupstorageconfig: string,
): BackupResourceConfigResource;

@@override(BackupResourceStorageConfigsNonCRR.get,
  backupResourceStorageConfigsNonCRRGet,
  "java,go,python,javascript"
);

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "customization"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
#suppress "@azure-tools/typespec-azure-core/casing-style" "override"
op backupResourceStorageConfigsNonCRRPatch(
  ...ApiVersionParameter,
  ...SubscriptionIdParameter,
  ...Azure.ResourceManager.ProviderNamespace<BackupResourceConfigResource>,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path
  vaultName: string,

  ...ResourceGroupParameter,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path
  backupstorageconfig: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  parameters: BackupResourceConfigResource,
): ArmNoContentResponse;

@@override(BackupResourceStorageConfigsNonCRR.patch,
  backupResourceStorageConfigsNonCRRPatch,
  "java,go,python,javascript"
);

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "customization"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
#suppress "@azure-tools/typespec-azure-core/casing-style" "override"
op backupResourceStorageConfigsNonCRRUpdate(
  ...ApiVersionParameter,
  ...SubscriptionIdParameter,
  ...Azure.ResourceManager.ProviderNamespace<BackupResourceConfigResource>,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path
  vaultName: string,

  ...ResourceGroupParameter,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path
  backupstorageconfig: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  parameters: BackupResourceConfigResource,
): ArmResourceUpdatedResponse<BackupResourceConfigResource>;

@@override(BackupResourceStorageConfigsNonCRR.update,
  backupResourceStorageConfigsNonCRRUpdate,
  "java,go,python,javascript"
);

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "customization"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
#suppress "@azure-tools/typespec-azure-core/casing-style" "override"
op backupResourceStorageConfigsNonCRRBmsPrepareDataMove(
  ...ApiVersionParameter,
  ...SubscriptionIdParameter,
  ...Azure.ResourceManager.ProviderNamespace<BackupResourceConfigResource>,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path
  vaultName: string,

  ...ResourceGroupParameter,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path
  backupstorageconfig: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  parameters: PrepareDataMoveRequest,
): ArmAcceptedLroResponse;

@@override(BackupResourceStorageConfigsNonCRR.bmsPrepareDataMove,
  backupResourceStorageConfigsNonCRRBmsPrepareDataMove,
  "java,go,python,javascript"
);

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "customization"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
#suppress "@azure-tools/typespec-azure-core/casing-style" "override"
op backupResourceStorageConfigsNonCRRBmsTriggerDataMove(
  ...ApiVersionParameter,
  ...SubscriptionIdParameter,
  ...Azure.ResourceManager.ProviderNamespace<BackupResourceConfigResource>,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path
  vaultName: string,

  ...ResourceGroupParameter,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path
  backupstorageconfig: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  parameters: TriggerDataMoveRequest,
): ArmAcceptedLroResponse;

@@override(BackupResourceStorageConfigsNonCRR.bmsTriggerDataMove,
  backupResourceStorageConfigsNonCRRBmsTriggerDataMove,
  "java,go,python,javascript"
);

// BackupResourceVaultConfigs operations
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "customization"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
op backupResourceVaultConfigsGet(
  ...ApiVersionParameter,
  ...SubscriptionIdParameter,
  ...Azure.ResourceManager.Legacy.Provider,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path
  vaultName: string,

  ...ResourceGroupParameter,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path
  backupconfig: string,
): BackupResourceVaultConfigResource;

@@override(BackupResourceVaultConfigs.get,
  backupResourceVaultConfigsGet,
  "java,go,python,javascript"
);

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "customization"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
op backupResourceVaultConfigsPut(
  ...ApiVersionParameter,
  ...SubscriptionIdParameter,
  ...Azure.ResourceManager.Legacy.Provider,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path
  vaultName: string,

  ...ResourceGroupParameter,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path
  backupconfig: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  parameters: BackupResourceVaultConfigResource,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  #suppress "@azure-tools/typespec-azure-core/casing-style" "override"
  `x-ms-authorization-auxiliary`?: string,
): ArmResourceUpdatedResponse<BackupResourceVaultConfigResource>;

@@override(BackupResourceVaultConfigs.put,
  backupResourceVaultConfigsPut,
  "java,go,python,javascript"
);

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "customization"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
op backupResourceVaultConfigsUpdate(
  ...ApiVersionParameter,
  ...SubscriptionIdParameter,
  ...Azure.ResourceManager.Legacy.Provider,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path
  vaultName: string,

  ...ResourceGroupParameter,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path
  backupconfig: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  parameters: BackupResourceVaultConfigResource,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  #suppress "@azure-tools/typespec-azure-core/casing-style" "override"
  `x-ms-authorization-auxiliary`?: string,
): ArmNoContentResponse;

@@override(BackupResourceVaultConfigs.update,
  backupResourceVaultConfigsUpdate,
  "java,go,python,javascript"
);

// BackupWorkloadItems operations
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "customization"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
op backupWorkloadItemsList(
  ...ApiVersionParameter,
  ...SubscriptionIdParameter,
  ...Azure.ResourceManager.Legacy.Provider,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path
  vaultName: string,

  ...ResourceGroupParameter,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path
  fabricName: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path
  containerName: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  $filter?: string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  $skipToken?: string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  body: void,
): ArmResponse<WorkloadItemResourceList>;

@@override(BackupWorkloadItems.list,
  backupWorkloadItemsList,
  "java,go,python,javascript"
);

// Backups operations
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "customization"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
op backupsTrigger(
  ...ApiVersionParameter,
  ...SubscriptionIdParameter,
  ...Azure.ResourceManager.Legacy.Provider,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path
  vaultName: string,

  ...ResourceGroupParameter,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path
  fabricName: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path
  containerName: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path
  protectedItemName: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  parameters: BackupRequestResource,
): void;

@@override(Backups.trigger, backupsTrigger, "java,go,python,javascript");

// RecoveryPoints operations
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "customization"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
op recoveryPointsGet(
  ...ApiVersionParameter,
  ...SubscriptionIdParameter,
  ...Azure.ResourceManager.Legacy.Provider,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path
  vaultName: string,

  ...ResourceGroupParameter,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path
  fabricName: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path
  containerName: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path
  protectedItemName: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path
  recoveryPointId: string,
): RecoveryPointResource;

@@override(RecoveryPoints.get, recoveryPointsGet, "java,go,python,javascript");

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "customization"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
op recoveryPointsList(
  ...ApiVersionParameter,
  ...SubscriptionIdParameter,
  ...Azure.ResourceManager.Legacy.Provider,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path
  vaultName: string,

  ...ResourceGroupParameter,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path
  fabricName: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path
  containerName: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path
  protectedItemName: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  $filter?: string,
): ArmResponse<RecoveryPointResourceList>;

@@override(RecoveryPoints.list,
  recoveryPointsList,
  "java,go,python,javascript"
);

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "customization"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
op recoveryPointsMoveRecoveryPoint(
  ...ApiVersionParameter,
  ...SubscriptionIdParameter,
  ...Azure.ResourceManager.Legacy.Provider,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path
  vaultName: string,

  ...ResourceGroupParameter,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path
  fabricName: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path
  containerName: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path
  protectedItemName: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path
  recoveryPointId: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  parameters: MoveRPAcrossTiersRequest,
): ArmAcceptedLroResponse;

@@override(RecoveryPoints.moveRecoveryPoint,
  recoveryPointsMoveRecoveryPoint,
  "java,go,python,javascript"
);

// RecoveryPointsRecommendedForMove operations
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "customization"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
op recoveryPointsRecommendedForMoveList(
  ...ApiVersionParameter,
  ...SubscriptionIdParameter,
  ...Azure.ResourceManager.Legacy.Provider,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path
  vaultName: string,

  ...ResourceGroupParameter,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path
  fabricName: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path
  containerName: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path
  protectedItemName: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  parameters: ListRecoveryPointsRecommendedForMoveRequest,
): ArmResponse<RecoveryPointResourceList>;

@@override(RecoveryPointsRecommendedForMove.list,
  recoveryPointsRecommendedForMoveList,
  "java,go,python,javascript"
);

// BackupResourceConfigOperationStatuses operations
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "customization"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
op backupResourceConfigOperationStatusesGetOperationStatus(
  ...ApiVersionParameter,
  ...SubscriptionIdParameter,
  ...Azure.ResourceManager.Legacy.Provider,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path
  vaultName: string,

  ...ResourceGroupParameter,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path
  backupStorageConfigName: "vaultstorageconfig",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path
  operationId: string,
): ArmResponse<OperationStatus>;

@@override(BackupResourceConfigOperationStatuses.getOperationStatus,
  backupResourceConfigOperationStatusesGetOperationStatus,
  "java,go,python,javascript"
);

// ExportJobsOperationResults operations
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "customization"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
op exportJobsOperationResultsGet(
  ...ApiVersionParameter,
  ...SubscriptionIdParameter,
  ...Azure.ResourceManager.Legacy.Provider,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path
  vaultName: string,

  ...ResourceGroupParameter,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path
  operationId: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  backupJobs: "backupJobs",
): OperationResultInfoBaseResource;

@@override(ExportJobsOperationResults.get,
  exportJobsOperationResultsGet,
  "java,go,python,javascript"
);

// ItemLevelRecoveryConnections operations
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "customization"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
op itemLevelRecoveryConnectionsProvision(
  ...ApiVersionParameter,
  ...SubscriptionIdParameter,
  ...Azure.ResourceManager.Legacy.Provider,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path
  vaultName: string,

  ...ResourceGroupParameter,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path
  fabricName: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path
  containerName: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path
  protectedItemName: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path
  recoveryPointId: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  parameters: ILRRequestResource,
): void;

@@override(ItemLevelRecoveryConnections.provision,
  itemLevelRecoveryConnectionsProvision,
  "java,go,python,javascript"
);

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "customization"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
op itemLevelRecoveryConnectionsRevoke(
  ...ApiVersionParameter,
  ...SubscriptionIdParameter,
  ...Azure.ResourceManager.Legacy.Provider,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path
  vaultName: string,

  ...ResourceGroupParameter,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path
  fabricName: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path
  containerName: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path
  protectedItemName: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path
  recoveryPointId: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  body: void,
): void;

@@override(ItemLevelRecoveryConnections.revoke,
  itemLevelRecoveryConnectionsRevoke,
  "java,go,python,javascript"
);

// JobCancellations operations
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "customization"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
op jobCancellationsTrigger(
  ...ApiVersionParameter,
  ...SubscriptionIdParameter,
  ...Azure.ResourceManager.Legacy.Provider,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path
  vaultName: string,

  ...ResourceGroupParameter,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path
  jobName: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  body: void,
): void;

@@override(JobCancellations.trigger,
  jobCancellationsTrigger,
  "java,go,python,javascript"
);

// JobDetails operations
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "customization"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
op jobDetailsGet(
  ...ApiVersionParameter,
  ...SubscriptionIdParameter,
  ...Azure.ResourceManager.Legacy.Provider,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path
  vaultName: string,

  ...ResourceGroupParameter,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path
  jobName: string,
): JobResource;

@@override(JobDetails.get, jobDetailsGet, "java,go,python,javascript");

// JobOperationResults operations
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "customization"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
op jobOperationResultsGet(
  ...ApiVersionParameter,
  ...SubscriptionIdParameter,
  ...Azure.ResourceManager.Legacy.Provider,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path
  vaultName: string,

  ...ResourceGroupParameter,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path
  jobName: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path
  operationId: string,
): JobResource;

@@override(JobOperationResults.get,
  jobOperationResultsGet,
  "java,go,python,javascript"
);

// PrivateEndpointConnectionResources operations
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "customization"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
op privateEndpointConnectionResourcesGet(
  ...ApiVersionParameter,
  ...SubscriptionIdParameter,
  ...Azure.ResourceManager.Legacy.Provider,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path
  vaultName: string,

  ...ResourceGroupParameter,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path
  privateEndpointConnectionName: string,
): Microsoft.RecoveryServices.PrivateEndpointConnectionResource;

@@override(PrivateEndpointConnectionResources.get,
  privateEndpointConnectionResourcesGet,
  "java,go,python,javascript"
);

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "customization"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
op privateEndpointConnectionResourcesPut(
  ...ApiVersionParameter,
  ...SubscriptionIdParameter,
  ...Azure.ResourceManager.Legacy.Provider,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path
  vaultName: string,

  ...ResourceGroupParameter,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path
  privateEndpointConnectionName: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  parameters: Microsoft.RecoveryServices.PrivateEndpointConnectionResource,
): Microsoft.RecoveryServices.PrivateEndpointConnectionResource | ArmAcceptedLroResponse;

@@override(PrivateEndpointConnectionResources.put,
  privateEndpointConnectionResourcesPut,
  "java,go,python,javascript"
);

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "customization"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
op privateEndpointConnectionResourcesDelete(
  ...ApiVersionParameter,
  ...SubscriptionIdParameter,
  ...Azure.ResourceManager.Legacy.Provider,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path
  vaultName: string,

  ...ResourceGroupParameter,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path
  privateEndpointConnectionName: string,
): ArmDeletedNoContentResponse;

@@override(PrivateEndpointConnectionResources.delete,
  privateEndpointConnectionResourcesDelete,
  "java,go,python,javascript"
);

// PrivateEndpointOperationStatuses operations
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "customization"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
op privateEndpointOperationStatusesGetOperationStatus(
  ...ApiVersionParameter,
  ...SubscriptionIdParameter,
  ...Azure.ResourceManager.Legacy.Provider,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path
  vaultName: string,

  ...ResourceGroupParameter,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path
  privateEndpointConnectionName: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path
  operationId: string,
): ArmResponse<OperationStatus>;

@@override(PrivateEndpointOperationStatuses.getOperationStatus,
  privateEndpointOperationStatusesGetOperationStatus,
  "java,go,python,javascript"
);

// ProtectedItemOperationResults operations
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "customization"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
op protectedItemOperationResultsGet(
  ...ApiVersionParameter,
  ...SubscriptionIdParameter,
  ...Azure.ResourceManager.Legacy.Provider,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path
  vaultName: string,

  ...ResourceGroupParameter,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path
  fabricName: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path
  containerName: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path
  protectedItemName: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path
  operationId: string,
): ProtectedItemResource;

@@override(ProtectedItemOperationResults.get,
  protectedItemOperationResultsGet,
  "java,go,python,javascript"
);

// ProtectedItemOperationStatuses operations
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "customization"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
op protectedItemOperationStatusesGet(
  ...ApiVersionParameter,
  ...SubscriptionIdParameter,
  ...Azure.ResourceManager.Legacy.Provider,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path
  vaultName: string,

  ...ResourceGroupParameter,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path
  fabricName: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path
  containerName: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path
  protectedItemName: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path
  operationId: string,
): ArmResponse<OperationStatus>;

@@override(ProtectedItemOperationStatuses.get,
  protectedItemOperationStatusesGet,
  "java,go,python,javascript"
);

// ProtectedItems operations
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "customization"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
op protectedItemsCreateOrUpdate(
  ...ApiVersionParameter,
  ...SubscriptionIdParameter,
  ...Azure.ResourceManager.Legacy.Provider,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path
  vaultName: string,

  ...ResourceGroupParameter,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path
  fabricName: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path
  containerName: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path
  protectedItemName: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  parameters: ProtectedItemResource,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  #suppress "@azure-tools/typespec-azure-core/casing-style" "override"
  `x-ms-authorization-auxiliary`?: string,
): ProtectedItemResource;

@@override(ProtectedItems.createOrUpdate,
  protectedItemsCreateOrUpdate,
  "java,go,python,javascript"
);

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "customization"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
op protectedItemsDelete(
  ...ApiVersionParameter,
  ...SubscriptionIdParameter,
  ...Azure.ResourceManager.Legacy.Provider,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path
  vaultName: string,

  ...ResourceGroupParameter,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path
  fabricName: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path
  containerName: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path
  protectedItemName: string,
): ArmDeletedNoContentResponse;

@@override(ProtectedItems.delete,
  protectedItemsDelete,
  "java,go,python,javascript"
);

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "customization"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
op protectedItemsGet(
  ...ApiVersionParameter,
  ...SubscriptionIdParameter,
  ...Azure.ResourceManager.Legacy.Provider,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path
  vaultName: string,

  ...ResourceGroupParameter,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path
  fabricName: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path
  containerName: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path
  protectedItemName: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  $filter?: string,
): ProtectedItemResource;

@@override(ProtectedItems.get, protectedItemsGet, "java,go,python,javascript");

// ProtectionContainerOperationResults operations
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "customization"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
op protectionContainerOperationResultsGet(
  ...ApiVersionParameter,
  ...SubscriptionIdParameter,
  ...Azure.ResourceManager.Legacy.Provider,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path
  vaultName: string,

  ...ResourceGroupParameter,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path
  fabricName: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path
  containerName: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path
  operationId: string,
): ProtectionContainerResource;

@@override(ProtectionContainerOperationResults.get,
  protectionContainerOperationResultsGet,
  "java,go,python,javascript"
);

// ProtectionContainers operations
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "customization"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
op protectionContainersRegister(
  ...ApiVersionParameter,
  ...SubscriptionIdParameter,
  ...Azure.ResourceManager.Legacy.Provider,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path
  vaultName: string,

  ...ResourceGroupParameter,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path
  fabricName: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path
  containerName: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  parameters: ProtectionContainerResource,
): ProtectionContainerResource;

@@override(ProtectionContainers.register,
  protectionContainersRegister,
  "java,go,python,javascript"
);

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "customization"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
op protectionContainersGet(
  ...ApiVersionParameter,
  ...SubscriptionIdParameter,
  ...Azure.ResourceManager.Legacy.Provider,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path
  vaultName: string,

  ...ResourceGroupParameter,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path
  fabricName: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path
  containerName: string,
): ProtectionContainerResource;

@@override(ProtectionContainers.get,
  protectionContainersGet,
  "java,go,python,javascript"
);

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "customization"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
op protectionContainersInquire(
  ...ApiVersionParameter,
  ...SubscriptionIdParameter,
  ...Azure.ResourceManager.Legacy.Provider,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path
  vaultName: string,

  ...ResourceGroupParameter,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path
  fabricName: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path
  containerName: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  $filter?: string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  body: void,
): void;

@@override(ProtectionContainers.inquire,
  protectionContainersInquire,
  "java,go,python,javascript"
);

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "customization"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
op protectionContainersUnregister(
  ...ApiVersionParameter,
  ...SubscriptionIdParameter,
  ...Azure.ResourceManager.Legacy.Provider,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path
  vaultName: string,

  ...ResourceGroupParameter,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path
  fabricName: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path
  containerName: string,
): void;

@@override(ProtectionContainers.unregister,
  protectionContainersUnregister,
  "java,go,python,javascript"
);

// ProtectionIntentResources operations
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "customization"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
op protectionIntentResourcesCreateOrUpdate(
  ...ApiVersionParameter,
  ...SubscriptionIdParameter,
  ...Azure.ResourceManager.Legacy.Provider,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path
  vaultName: string,

  ...ResourceGroupParameter,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path
  fabricName: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  intentObjectName: string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  parameters: ProtectionIntentResource,
): ProtectionIntentResource;

@@override(ProtectionIntentResources.createOrUpdate,
  protectionIntentResourcesCreateOrUpdate,
  "java,go,python,javascript"
);

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "customization"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
op protectionIntentResourcesDelete(
  ...ApiVersionParameter,
  ...SubscriptionIdParameter,
  ...Azure.ResourceManager.Legacy.Provider,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path
  vaultName: string,

  ...ResourceGroupParameter,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path
  fabricName: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  intentObjectName: string,
): ArmDeletedNoContentResponse;

@@override(ProtectionIntentResources.delete,
  protectionIntentResourcesDelete,
  "java,go,python,javascript"
);

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "customization"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
op protectionIntentResourcesGet(
  ...ApiVersionParameter,
  ...SubscriptionIdParameter,
  ...Azure.ResourceManager.Legacy.Provider,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path
  vaultName: string,

  ...ResourceGroupParameter,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path
  fabricName: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  intentObjectName: string,
): ProtectionIntentResource;

@@override(ProtectionIntentResources.get,
  protectionIntentResourcesGet,
  "java,go,python,javascript"
);

// ProtectionPolicies operations
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "customization"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
op protectionPoliciesGet(
  ...ApiVersionParameter,
  ...SubscriptionIdParameter,
  ...Azure.ResourceManager.Legacy.Provider,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path
  vaultName: string,

  ...ResourceGroupParameter,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path
  policyName: string,
): ProtectionPolicyResource;

@@override(ProtectionPolicies.get,
  protectionPoliciesGet,
  "java,go,python,javascript"
);

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "customization"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
op protectionPoliciesCreateOrUpdate(
  ...ApiVersionParameter,
  ...SubscriptionIdParameter,
  ...Azure.ResourceManager.Legacy.Provider,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path
  vaultName: string,

  ...ResourceGroupParameter,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path
  policyName: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  parameters: ProtectionPolicyResource,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  #suppress "@azure-tools/typespec-azure-core/casing-style" "override"
  `x-ms-authorization-auxiliary`?: string,
): ArmResourceUpdatedResponse<ProtectionPolicyResource>;

@@override(ProtectionPolicies.createOrUpdate,
  protectionPoliciesCreateOrUpdate,
  "java,go,python,javascript"
);

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "customization"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
op protectionPoliciesDelete(
  ...ApiVersionParameter,
  ...SubscriptionIdParameter,
  ...Azure.ResourceManager.Legacy.Provider,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path
  vaultName: string,

  ...ResourceGroupParameter,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path
  policyName: string,
): ArmDeletedNoContentResponse;

@@override(ProtectionPolicies.delete,
  protectionPoliciesDelete,
  "java,go,python,javascript"
);

// ProtectionPolicyOperationResults operations
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "customization"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
op protectionPolicyOperationResultsGet(
  ...ApiVersionParameter,
  ...SubscriptionIdParameter,
  ...Azure.ResourceManager.Legacy.Provider,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path
  vaultName: string,

  ...ResourceGroupParameter,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path
  policyName: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path
  operationId: string,
): ProtectionPolicyResource;

@@override(ProtectionPolicyOperationResults.get,
  protectionPolicyOperationResultsGet,
  "java,go,python,javascript"
);

// ResourceGuardProxies operations
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "customization"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
op resourceGuardProxiesGet(
  ...ApiVersionParameter,
  ...SubscriptionIdParameter,
  ...Azure.ResourceManager.Legacy.Provider,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path
  vaultName: string,

  ...ResourceGroupParameter,
): ArmResponse<ResourceGuardProxyBaseResourceList>;

@@override(ResourceGuardProxies.get,
  resourceGuardProxiesGet,
  "java,go,python,javascript"
);

// ResourceGuardProxy operations
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "customization"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
op resourceGuardProxyDelete(
  ...ApiVersionParameter,
  ...SubscriptionIdParameter,
  ...Azure.ResourceManager.Legacy.Provider,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path
  vaultName: string,

  ...ResourceGroupParameter,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path
  resourceGuardProxyName: string,
): ArmDeletedNoContentResponse;

@@override(ResourceGuardProxy.delete,
  resourceGuardProxyDelete,
  "java,go,python,javascript"
);

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "customization"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
op resourceGuardProxyGet(
  ...ApiVersionParameter,
  ...SubscriptionIdParameter,
  ...Azure.ResourceManager.Legacy.Provider,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path
  vaultName: string,

  ...ResourceGroupParameter,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path
  resourceGuardProxyName: string,
): ResourceGuardProxyBaseResource;

@@override(ResourceGuardProxy.get,
  resourceGuardProxyGet,
  "java,go,python,javascript"
);

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "customization"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
op resourceGuardProxyPut(
  ...ApiVersionParameter,
  ...SubscriptionIdParameter,
  ...Azure.ResourceManager.Legacy.Provider,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path
  vaultName: string,

  ...ResourceGroupParameter,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path
  resourceGuardProxyName: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  parameters: ResourceGuardProxyBaseResource,
): ResourceGuardProxyBaseResource;

@@override(ResourceGuardProxy.put,
  resourceGuardProxyPut,
  "java,go,python,javascript"
);

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "customization"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
op resourceGuardProxyUnlockDelete(
  ...ApiVersionParameter,
  ...SubscriptionIdParameter,
  ...Azure.ResourceManager.Legacy.Provider,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path
  vaultName: string,

  ...ResourceGroupParameter,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path
  resourceGuardProxyName: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  parameters: UnlockDeleteRequest,
): UnlockDeleteResponse;

@@override(ResourceGuardProxy.unlockDelete,
  resourceGuardProxyUnlockDelete,
  "java,go,python,javascript"
);

// Restores operations
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "customization"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
op restoresTrigger(
  ...ApiVersionParameter,
  ...SubscriptionIdParameter,
  ...Azure.ResourceManager.Legacy.Provider,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path
  vaultName: string,

  ...ResourceGroupParameter,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path
  fabricName: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path
  containerName: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path
  protectedItemName: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path
  recoveryPointId: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  parameters: RestoreRequestResource,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  #suppress "@azure-tools/typespec-azure-core/casing-style" "override"
  `x-ms-authorization-auxiliary`?: string,
): ArmAcceptedLroResponse;

@@override(Restores.trigger, restoresTrigger, "java,go,python,javascript");

// ProtectionPolicyOperationStatuses operations
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "customization"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
op protectionPolicyOperationStatusesGet(
  ...ApiVersionParameter,
  ...SubscriptionIdParameter,
  ...Azure.ResourceManager.Legacy.Provider,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path
  vaultName: string,

  ...ResourceGroupParameter,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path
  policyName: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path
  operationId: string,
): ArmAcceptedLroResponse;

@@override(ProtectionPolicyOperationStatuses.get,
  protectionPolicyOperationStatusesGet,
  "java,go,python,javascript"
);

import "@azure-tools/typespec-client-generator-core";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "./main.tsp";

using Azure.ClientGenerator.Core;
using Azure.Core;
using Azure.ResourceManager;
using Http;
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

@@clientName(HttpStatusCode.Continue, "CONTINUE_ENUM", "python");

// Migration mappings added to mitigate Java SDK breaking changes after TypeSpec migration
@@clientName(IaaSVMContainer, "IaaSvmContainer", "java");
@@clientName(AzureIaaSVMProtectedItem, "AzureIaaSvmProtectedItem", "java");
@@alternateType(InquiryValidation.protectableItemCount, unknown, "java");
@@clientName(AzureIaaSVMJob, "AzureIaaSvmJob", "java");
@@clientName(AzureIaaSVMJobV2, "AzureIaaSvmJobV2", "java");
@@clientName(AzureIaaSVMJobExtendedInfo, "AzureIaaSvmJobExtendedInfo", "java");
@@clientName(AzureIaaSVMJobTaskDetails, "AzureIaaSvmJobTaskDetails", "java");
@@clientName(AzureIaaSVMErrorInfo, "AzureIaaSvmErrorInfo", "java");
@@clientName(AzureIaaSVMHealthDetails, "AzureIaaSvmHealthDetails", "java");
@@clientName(AzureIaaSVMProtectedItemExtendedInfo,
  "AzureIaaSvmProtectedItemExtendedInfo",
  "java"
);
@@clientName(AzureIaaSVMProtectionPolicy,
  "AzureIaaSvmProtectionPolicy",
  "java"
);
@@clientName(IaaSVMProtectableItem, "IaasVMProtectableItem", "java");
@@clientName(IaasVMILRRegistrationRequest,
  "IaasVmilrRegistrationRequest",
  "java"
);
@@clientName(IAASVMPolicyType, "IaasvmPolicyType", "java");

// Additional migrations for SQL/SAP related types
@@clientName(AzureWorkloadSQLAutoProtectionIntent,
  "AzureWorkloadSqlAutoProtectionIntent",
  "java"
);
@@clientName(AzureWorkloadSQLRecoveryPoint,
  "AzureWorkloadSqlRecoveryPoint",
  "java"
);
@@clientName(AzureWorkloadSQLPointInTimeRecoveryPoint,
  "AzureWorkloadSqlPointInTimeRecoveryPoint",
  "java"
);
@@clientName(AzureWorkloadSQLRestoreRequest,
  "AzureWorkloadSqlRestoreRequest",
  "java"
);
@@clientName(AzureWorkloadSQLRestoreWithRehydrateRequest,
  "AzureWorkloadSqlRestoreWithRehydrateRequest",
  "java"
);
@@clientName(AzureWorkloadSQLPointInTimeRestoreRequest,
  "AzureWorkloadSqlPointInTimeRestoreRequest",
  "java"
);
@@clientName(AzureWorkloadSQLPointInTimeRestoreWithRehydrateRequest,
  "AzureWorkloadSqlPointInTimeRestoreWithRehydrateRequest",
  "java"
);
@@clientName(AzureWorkloadSQLRecoveryPointExtendedInfo,
  "AzureWorkloadSqlRecoveryPointExtendedInfo",
  "java"
);

// SAP related mappings
@@clientName(AzureWorkloadSAPHanaRestoreRequest,
  "AzureWorkloadSapHanaRestoreRequest",
  "java"
);
@@clientName(AzureWorkloadSAPHanaRestoreWithRehydrateRequest,
  "AzureWorkloadSapHanaRestoreWithRehydrateRequest",
  "java"
);
@@clientName(AzureWorkloadSAPHanaPointInTimeRestoreRequest,
  "AzureWorkloadSapHanaPointInTimeRestoreRequest",
  "java"
);
@@clientName(AzureWorkloadSAPHanaPointInTimeRestoreWithRehydrateRequest,
  "AzureWorkloadSapHanaPointInTimeRestoreWithRehydrateRequest",
  "java"
);
@@clientName(AzureWorkloadSAPHanaRecoveryPoint,
  "AzureWorkloadSapHanaRecoveryPoint",
  "java"
);
@@clientName(AzureWorkloadSAPHanaPointInTimeRecoveryPoint,
  "AzureWorkloadSapHanaPointInTimeRecoveryPoint",
  "java"
);
@@clientName(AzureWorkloadSAPAseRecoveryPoint,
  "AzureWorkloadSapAseRecoveryPoint",
  "java"
);
@@clientName(AzureWorkloadSAPAseRestoreRequest,
  "AzureWorkloadSapAseRestoreRequest",
  "java"
);
@@clientName(AzureWorkloadSAPAsePointInTimeRecoveryPoint,
  "AzureWorkloadSapAsePointInTimeRecoveryPoint",
  "java"
);
@@clientName(AzureWorkloadSAPAsePointInTimeRestoreRequest,
  "AzureWorkloadSapAsePointInTimeRestoreRequest",
  "java"
);

// VM Workload related mappings
@@clientName(AzureVmWorkloadSQLDatabaseProtectedItem,
  "AzureVmWorkloadSqlDatabaseProtectedItem",
  "java"
);
@@clientName(AzureVmWorkloadSQLDatabaseProtectableItem,
  "AzureVmWorkloadSqlDatabaseProtectableItem",
  "java"
);
@@clientName(AzureVmWorkloadSQLDatabaseWorkloadItem,
  "AzureVmWorkloadSqlDatabaseWorkloadItem",
  "java"
);
@@clientName(AzureVmWorkloadSQLInstanceProtectableItem,
  "AzureVmWorkloadSqlInstanceProtectableItem",
  "java"
);
@@clientName(AzureVmWorkloadSQLInstanceWorkloadItem,
  "AzureVmWorkloadSqlInstanceWorkloadItem",
  "java"
);
@@clientName(AzureVmWorkloadSQLAvailabilityGroupProtectableItem,
  "AzureVmWorkloadSqlAvailabilityGroupProtectableItem",
  "java"
);
@@clientName(AzureVmWorkloadSAPHanaDatabaseProtectedItem,
  "AzureVmWorkloadSapHanaDatabaseProtectedItem",
  "java"
);
@@clientName(AzureVmWorkloadSAPHanaDatabaseProtectableItem,
  "AzureVmWorkloadSapHanaDatabaseProtectableItem",
  "java"
);
@@clientName(AzureVmWorkloadSAPHanaDatabaseWorkloadItem,
  "AzureVmWorkloadSapHanaDatabaseWorkloadItem",
  "java"
);
@@clientName(AzureVmWorkloadSAPHanaDBInstanceProtectedItem,
  "AzureVmWorkloadSapHanaDBInstanceProtectedItem",
  "java"
);
@@clientName(AzureVmWorkloadSAPHanaDBInstance,
  "AzureVmWorkloadSapHanaDBInstance",
  "java"
);
@@clientName(AzureVmWorkloadSAPHanaSystemProtectableItem,
  "AzureVmWorkloadSapHanaSystemProtectableItem",
  "java"
);
@@clientName(AzureVmWorkloadSAPHanaSystemWorkloadItem,
  "AzureVmWorkloadSapHanaSystemWorkloadItem",
  "java"
);
@@clientName(AzureVmWorkloadSAPHanaHSRProtectableItem,
  "AzureVmWorkloadSapHanaHsr",
  "java"
);
@@clientName(AzureVmWorkloadSAPAseDatabaseProtectedItem,
  "AzureVmWorkloadSapAseDatabaseProtectedItem",
  "java"
);
@@clientName(AzureVmWorkloadSAPAseDatabaseProtectableItem,
  "AzureVmWorkloadSapAseDatabaseProtectableItem",
  "java"
);
@@clientName(AzureVmWorkloadSAPAseDatabaseWorkloadItem,
  "AzureVmWorkloadSapAseDatabaseWorkloadItem",
  "java"
);
@@clientName(AzureVmWorkloadSAPAseSystemProtectableItem,
  "AzureVmWorkloadSapAseSystemProtectableItem",
  "java"
);
@@clientName(AzureVmWorkloadSAPAseSystemWorkloadItem,
  "AzureVmWorkloadSapAseSystemWorkloadItem",
  "java"
);

// SQL and other mappings
@@clientName(SQLDataDirectory, "SqlDataDirectory", "java");
@@clientName(SQLDataDirectoryType, "SqlDataDirectoryType", "java");
@@clientName(SQLDataDirectoryMapping, "SqlDataDirectoryMapping", "java");
@@clientName(AzureSQLAGWorkloadContainerProtectionContainer,
  "AzureSqlagWorkloadContainerProtectionContainer",
  "java"
);

// Storage and BMS related mappings
@@clientName(BMSPrepareDataMoveOperationResult,
  "BmsPrepareDataMoveOperationResult",
  "java"
);
@@clientName(BackupResourceStorageConfigsNonCRR,
  "BackupResourceStorageConfigsNonCrr",
  "java"
);

// Key/secret related mappings
@@clientName(KEKDetails, "KekDetails", "java");
@@clientName(BEKDetails, "BekDetails", "java");

// Target restore info mapping
@@clientName(TargetAFSRestoreInfo, "TargetAfsRestoreInfo", "java");
@@alternateType(TargetAFSRestoreInfo.targetResourceId,
  armResourceIdentifier,
  "java"
);

// Additional ILR related mappings
@@clientName(ILRRequest, "IlrRequest", "java");
@@clientName(ILRRequestResource, "IlrRequestResource", "java");
@@clientName(AzureFileShareProvisionILRRequest,
  "AzureFileShareProvisionIlrRequest",
  "java"
);
@@clientName(OperationStatusProvisionILRExtendedInfo,
  "OperationStatusProvisionIlrExtendedInfo",
  "java"
);

// DPM related mappings
@@clientName(DPMContainerExtendedInfo, "DpmContainerExtendedInfo", "java");
@@clientName(DPMProtectedItem, "DpmProtectedItem", "java");
@@clientName(DPMProtectedItemExtendedInfo,
  "DpmProtectedItemExtendedInfo",
  "java"
);

// MAB related mappings
@@clientName(MABContainerHealthDetails, "MabContainerHealthDetails", "java");

// KPI related mappings
@@clientName(KPIResourceHealthDetails, "KpiResourceHealthDetails", "java");

// ETag property mapping to preserve backward compatibility
@@clientName(BackupEngineBaseResource.eTag, "etag", "java");
@@clientName(BackupResourceConfigResource.eTag, "etag", "java");
@@clientName(BackupResourceEncryptionConfigExtendedResource.eTag,
  "etag",
  "java"
);
@@clientName(BackupResourceEncryptionConfigResource.eTag, "etag", "java");
@@clientName(BackupResourceVaultConfigResource.eTag, "etag", "java");
@@clientName(JobResource.eTag, "etag", "java");
@@clientName(Microsoft.RecoveryServices.PrivateEndpointConnectionResource.eTag,
  "etag",
  "java"
);
@@clientName(ProtectedItemResource.eTag, "etag", "java");
@@clientName(ProtectionContainerResource.eTag, "etag", "java");
@@clientName(ProtectionIntentResource.eTag, "etag", "java");
@@clientName(ProtectionPolicyResource.eTag, "etag", "java");
@@clientName(RecoveryPointResource.eTag, "etag", "java");
@@clientName(ResourceGuardProxyBaseResource.eTag, "etag", "java");

// UTC/PIN/VM abbreviation fixes for backward compatibility
@@clientName(TokenInformation.securityPIN, "securityPin", "java");
@@clientName(SecuredVMDetails.securedVMOsDiskEncryptionSetId,
  "securedVmosDiskEncryptionSetId",
  "java"
);

// UTC property name fixes for backward compatibility
@@clientName(ProtectedItem.deferredDeleteTimeInUTC,
  "deferredDeleteTimeInUtc",
  "java"
);
@@clientName(AzureWorkloadRecoveryPoint.recoveryPointTimeInUTC,
  "recoveryPointTimeInUtc",
  "java"
);
@@clientName(MabFileFolderProtectedItem.deferredDeleteSyncTimeInUTC,
  "deferredDeleteSyncTimeInUtc",
  "java"
);
@@clientName(IaasVMBackupRequest.recoveryPointExpiryTimeInUTC,
  "recoveryPointExpiryTimeInUtc",
  "java"
);
@@clientName(AzureFileShareBackupRequest.recoveryPointExpiryTimeInUTC,
  "recoveryPointExpiryTimeInUtc",
  "java"
);
@@clientName(AzureWorkloadBackupRequest.recoveryPointExpiryTimeInUTC,
  "recoveryPointExpiryTimeInUtc",
  "java"
);
@@clientName(AzureWorkloadSQLRecoveryPointExtendedInfo.dataDirectoryTimeInUTC,
  "dataDirectoryTimeInUtc",
  "java"
);

// Service name management operations fixes
@@clientName(BackupResourceStorageConfigsNonCRR.bmsPrepareDataMove,
  "bmsPrepareDataMove",
  "java"
);
@@clientName(BackupResourceStorageConfigsNonCRR.bmsTriggerDataMove,
  "bmsTriggerDataMove",
  "java"
);

// Actions required property name fix
@@clientName(Microsoft.RecoveryServices.PrivateLinkServiceConnectionState.actionsRequired,
  "actionRequired",
  "java"
);

// IaaS VM protectable item fix
@@clientName(IaaSVMProtectableItem, "IaasVmProtectableItem", "java");

// Additional UTC property fixes for specific recovery point types
@@clientName(AzureWorkloadSQLPointInTimeRecoveryPoint.recoveryPointTimeInUTC,
  "recoveryPointTimeInUtc",
  "java"
);
@@clientName(AzureWorkloadPointInTimeRecoveryPoint.recoveryPointTimeInUTC,
  "recoveryPointTimeInUtc",
  "java"
);
@@clientName(AzureWorkloadSQLRecoveryPoint.recoveryPointTimeInUTC,
  "recoveryPointTimeInUtc",
  "java"
);
@@clientName(AzureWorkloadSAPHanaPointInTimeRecoveryPoint.recoveryPointTimeInUTC,
  "recoveryPointTimeInUtc",
  "java"
);
@@clientName(AzureWorkloadSAPAsePointInTimeRecoveryPoint.recoveryPointTimeInUTC,
  "recoveryPointTimeInUtc",
  "java"
);
@@clientName(AzureWorkloadSAPHanaRecoveryPoint.recoveryPointTimeInUTC,
  "recoveryPointTimeInUtc",
  "java"
);
@@clientName(AzureWorkloadSAPAseRecoveryPoint.recoveryPointTimeInUTC,
  "recoveryPointTimeInUtc",
  "java"
);

// Merge ResourceGuardProxies into ResourceGuardProxyOperation group
@@clientLocation(ResourceGuardProxies.get,
  "ResourceGuardProxyOperation",
  "java"
);
@@clientName(ResourceGuardProxies.get, "list", "java");
@@clientLocation(ResourceGuardProxy.get, "ResourceGuardProxyOperation", "java");
@@clientLocation(ResourceGuardProxy.delete,
  "ResourceGuardProxyOperation",
  "java"
);
@@clientLocation(ResourceGuardProxy.put, "ResourceGuardProxyOperation", "java");
@@clientLocation(ResourceGuardProxy.unlockDelete,
  "ResourceGuardProxyOperation",
  "java"
);

@@clientName(Microsoft.RecoveryServices,
  "RecoveryServicesBackupClient",
  "javascript,python"
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
  @path
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

// rename for duplicate model from Azure.ResourceManager.CommonTypes
@@clientName(Azure.ResourceManager.CommonTypes.ErrorDetail, "ArmErrorDetail");

// C# settings
@@alternateType(Azure.ResourceManager.CommonTypes.Resource.id,
  armResourceIdentifier,
  "csharp"
);
@@clientName(DayOfWeek, "BackupDayOfWeek", "csharp");
@@clientName(WeekOfMonth, "BackupWeekOfMonth", "csharp");
@@clientName(MonthOfYear, "BackupMonthOfYear", "csharp");
@@clientName(CreateMode, "BackupCreateMode", "csharp");
@@clientName(DataSourceType, "BackupDataSourceType", "csharp");
@@clientName(ProtectionState, "BackupProtectionState", "csharp");
@@clientName(FabricName, "BackupFabricName", "csharp");
@@clientName(ProtectionStatus, "BackupProtectionStatus", "csharp");
@@clientName(HealthStatus, "IaasVmProtectedItemHealthStatus", "csharp");
@@clientName(ProtectedItemHealthStatus,
  "VmWorkloadProtectedItemHealthStatus",
  "csharp"
);
@@clientName(TieringPolicy, "BackupTieringPolicy", "csharp");
@@clientName(BackupStatusResponse, "BackupStatusResult", "csharp");
@@alternateType(BackupStatusResponse.vaultId, armResourceIdentifier, "csharp");
@@clientName(ErrorDetail, "BackupErrorDetail", "csharp");
@@clientName(SecurityPinBase, "SecurityPinContent", "csharp");
@@clientName(ExtendedProperties, "IaasVmBackupExtendedProperties", "csharp");
@@clientName(RestoreRequestResource, "TriggerRestoreContent", "csharp");
@@clientName(RestoreRequest, "RestoreContent", "csharp");
@@clientName(BackupRequest, "BackupContent", "csharp");
@@clientName(AzureFileshareProtectedItem, "FileshareProtectedItem", "csharp");
@@clientName(AzureFileshareProtectedItemExtendedInfo,
  "FileshareProtectedItemExtendedInfo",
  "csharp"
);
@@clientName(AzureIaaSClassicComputeVMProtectedItem,
  "IaasClassicComputeVmProtectedItem",
  "csharp"
);
@@clientName(AzureIaaSComputeVMProtectedItem,
  "IaasComputeVmProtectedItem",
  "csharp"
);
@@clientName(AzureIaaSVMProtectedItem, "IaasVmProtectedItem", "csharp");
@@alternateType(AzureIaaSVMProtectedItem.virtualMachineId,
  armResourceIdentifier,
  "csharp"
);
@@clientName(AzureIaaSVMProtectedItemExtendedInfo,
  "IaasVmProtectedItemExtendedInfo",
  "csharp"
);
@@clientName(AzureIaaSVMProtectedItemExtendedInfo.newestRecoveryPointInArchive,
  "NewestRecoveryPointInArchive",
  "csharp"
);
@@clientName(AzureIaaSVMProtectedItemExtendedInfo.oldestRecoveryPointInVault,
  "OldestRecoveryPointInVault",
  "csharp"
);
@@clientName(AzureIaaSVMProtectedItemExtendedInfo.oldestRecoveryPointInArchive,
  "OldestRecoveryPointInArchive",
  "csharp"
);
@@clientName(AzureIaaSVMHealthDetails, "IaasVmHealthDetails", "csharp");
@@clientName(AzureSqlProtectedItem, "SqlProtectedItem", "csharp");
@@clientName(AzureSqlProtectedItemExtendedInfo,
  "SqlProtectedItemExtendedInfo",
  "csharp"
);
@@clientName(DPMProtectedItem, "DpmProtectedItem", "csharp");
@@clientName(DPMProtectedItemExtendedInfo,
  "DpmProtectedItemExtendedInfo",
  "csharp"
);
@@clientName(AzureVmWorkloadProtectableItem,
  "VmWorkloadProtectableItem",
  "csharp"
);
@@clientName(AzureVmWorkloadProtectedItem, "VmWorkloadProtectedItem", "csharp");
@@clientName(AzureVmWorkloadProtectedItemExtendedInfo,
  "VmWorkloadProtectedItemExtendedInfo",
  "csharp"
);
@@clientName(AzureVmWorkloadSAPAseDatabaseProtectedItem,
  "VmWorkloadSapAseDatabaseProtectedItem",
  "csharp"
);
@@clientName(AzureVmWorkloadSAPHanaDatabaseProtectedItem,
  "VmWorkloadSapHanaDatabaseProtectedItem",
  "csharp"
);
@@clientName(AzureVmWorkloadSAPHanaDBInstanceProtectedItem,
  "VmWorkloadSapHanaDBInstanceProtectedItem",
  "csharp"
);
@@clientName(AzureVmWorkloadSQLDatabaseProtectedItem,
  "VmWorkloadSqlDatabaseProtectedItem",
  "csharp"
);
@@clientName(KPIResourceHealthDetails, "KpiResourceHealthDetails", "csharp");
@@clientName(Settings, "BackupCommonSettings", "csharp");
@@clientName(Day, "BackupDay", "csharp");
@@clientName(HourlySchedule, "BackupHourlySchedule", "csharp");
@@clientName(WeeklySchedule, "BackupWeeklySchedule", "csharp");
@@clientName(IdentityInfo, "BackupIdentityInfo", "csharp");
@@alternateType(IdentityInfo.managedIdentityResourceId,
  armResourceIdentifier,
  "csharp"
);
@@clientName(NameInfo, "BackupNameInfo", "csharp");
@@clientName(UsagesUnit, "BackupUsagesUnit", "csharp");
@@clientName(RetentionPolicy, "BackupRetentionPolicy", "csharp");
@@clientName(SchedulePolicy, "BackupSchedulePolicy", "csharp");
@@clientName(TargetDiskNetworkAccessOption,
  "BackupTargetDiskNetworkAccessOption",
  "csharp"
);
@@clientName(TargetDiskNetworkAccessSettings,
  "BackupTargetDiskNetworkAccessSettings",
  "csharp"
);
@@alternateType(TargetDiskNetworkAccessSettings.targetDiskAccessId,
  armResourceIdentifier,
  "csharp"
);
@@clientName(Job, "BackupGenericJob", "csharp");
@@clientName(ProtectionContainer, "BackupGenericProtectionContainer", "csharp");
@@clientName(ProtectionIntent, "BackupGenericProtectionIntent", "csharp");
@@alternateType(ProtectionIntent.itemId, armResourceIdentifier, "csharp");
@@alternateType(ProtectionIntent.policyId, armResourceIdentifier, "csharp");
@@alternateType(ProtectionIntent.sourceResourceId,
  armResourceIdentifier,
  "csharp"
);
@@clientName(BackupResourceConfig, "BackupResourceConfigProperties", "csharp");
@@clientName(BackupResourceConfigResource, "BackupResourceConfig", "csharp");
@@clientName(BackupResourceEncryptionConfigExtended,
  "BackupResourceEncryptionConfigExtendedProperties",
  "csharp"
);
@@alternateType(BackupResourceEncryptionConfigExtended.userAssignedIdentity,
  armResourceIdentifier,
  "csharp"
);
@@clientName(BackupResourceEncryptionConfigExtendedResource,
  "BackupResourceEncryptionConfigExtended",
  "csharp"
);
@@clientName(BackupResourceVaultConfig,
  "BackupResourceVaultConfigProperties",
  "csharp"
);
@@clientName(BackupResourceVaultConfigResource,
  "BackupResourceVaultConfig",
  "csharp"
);
@@clientName(BackupStatusRequest, "BackupStatusContent", "csharp");
@@alternateType(BackupStatusRequest.resourceId,
  armResourceIdentifier,
  "csharp"
);
@@clientName(BackupRequestResource, "TriggerBackupContent", "csharp");
@@clientName(FeatureSupportRequest, "FeatureSupportContent", "csharp");
@@clientName(FetchTieringCostInfoRequest,
  "FetchTieringCostInfoContent",
  "csharp"
);
@@clientName(FetchTieringCostInfoForRehydrationRequest,
  "FetchTieringCostInfoForRehydrationContent",
  "csharp"
);
@@clientName(FetchTieringCostSavingsInfoForPolicyRequest,
  "FetchTieringCostSavingsInfoForPolicyContent",
  "csharp"
);
@@clientName(FetchTieringCostSavingsInfoForProtectedItemRequest,
  "FetchTieringCostSavingsInfoForProtectedItemContent",
  "csharp"
);
@@clientName(FetchTieringCostSavingsInfoForVaultRequest,
  "FetchTieringCostSavingsInfoForVaultContent",
  "csharp"
);
@@clientName(PrepareDataMoveRequest, "PrepareDataMoveContent", "csharp");
@@alternateType(PrepareDataMoveRequest.targetRegion, azureLocation, "csharp");
@@alternateType(PrepareDataMoveRequest.targetResourceId,
  armResourceIdentifier,
  "csharp"
);
@@clientName(TriggerDataMoveRequest, "TriggerDataMoveContent", "csharp");
@@alternateType(TriggerDataMoveRequest.sourceRegion, azureLocation, "csharp");
@@alternateType(TriggerDataMoveRequest.sourceResourceId,
  armResourceIdentifier,
  "csharp"
);
@@clientName(MoveRPAcrossTiersRequest, "MoveRPAcrossTiersContent", "csharp");
@@clientName(ListRecoveryPointsRecommendedForMoveRequest,
  "RecoveryPointsRecommendedForMoveContent",
  "csharp"
);
@@clientName(PreValidateEnableBackupRequest,
  "PreValidateEnableBackupContent",
  "csharp"
);
@@alternateType(PreValidateEnableBackupRequest.resourceId,
  armResourceIdentifier,
  "csharp"
);
@@alternateType(PreValidateEnableBackupRequest.vaultId,
  armResourceIdentifier,
  "csharp"
);
@@clientName(PreValidateEnableBackupResponse,
  "PreValidateEnableBackupResult",
  "csharp"
);
@@clientName(UnlockDeleteRequest, "UnlockDeleteContent", "csharp");
@@clientName(UnlockDeleteResponse, "UnlockDeleteResult", "csharp");
@@clientName(SnapshotRestoreParameters, "SnapshotRestoreContent", "csharp");
@@clientName(EncryptionDetails, "VmEncryptionDetails", "csharp");
@@alternateType(EncryptionDetails.kekUrl, url, "csharp");
@@alternateType(EncryptionDetails.secretKeyUrl, url, "csharp");
@@alternateType(EncryptionDetails.kekVaultId, armResourceIdentifier, "csharp");
@@alternateType(EncryptionDetails.secretKeyVaultId,
  armResourceIdentifier,
  "csharp"
);
@@clientName(ILRRequest, "IlrContent", "csharp");
@@clientName(ILRRequestResource, "ProvisionIlrConnectionContent", "csharp");
@@clientName(AzureBackupServerContainer, "BackupServerContainer", "csharp");
@@clientName(AzureBackupServerEngine, "BackupServerEngine", "csharp");
@@clientName(AzureBackupGoalFeatureSupportRequest,
  "BackupGoalFeatureSupportContent",
  "csharp"
);
@@clientName(IaaSVMContainer, "IaasVmContainer", "csharp");
@@alternateType(IaaSVMContainer.virtualMachineId,
  armResourceIdentifier,
  "csharp"
);
@@clientName(AzureIaaSClassicComputeVMContainer,
  "IaasClassicComputeVmContainer",
  "csharp"
);
@@clientName(AzureIaaSComputeVMContainer, "IaasComputeVmContainer", "csharp");
@@clientName(AzureSqlContainer, "SqlContainer", "csharp");
@@clientName(AzureSQLAGWorkloadContainerProtectionContainer,
  "SqlAvailabilityGroupWorkloadProtectionContainer",
  "csharp"
);
@@clientName(AzureStorageContainer, "StorageContainer", "csharp");
@@alternateType(AzureStorageContainer.sourceResourceId,
  armResourceIdentifier,
  "csharp"
);
@@clientName(AzureStorageErrorInfo, "StorageErrorInfo", "csharp");
@@clientName(AzureStorageProtectableContainer,
  "StorageProtectableContainer",
  "csharp"
);
@@clientName(AzureVMAppContainerProtectableContainer,
  "VmAppContainerProtectableContainer",
  "csharp"
);
@@clientName(AzureVMAppContainerProtectionContainer,
  "VmAppContainerProtectionContainer",
  "csharp"
);
@@clientName(AzureWorkloadContainer, "WorkloadContainer", "csharp");
@@alternateType(AzureWorkloadContainerProperties.sourceResourceId,
  armResourceIdentifier,
  "csharp"
);
@@clientName(AzureWorkloadContainerExtendedInfo,
  "WorkloadContainerExtendedInfo",
  "csharp"
);
@@clientName(AzureWorkloadContainerAutoProtectionIntent,
  "WorkloadContainerAutoProtectionIntent",
  "csharp"
);
@@clientName(AzureWorkloadErrorInfo, "WorkloadErrorInfo", "csharp");
@@clientName(InquiryInfo, "WorkloadContainerInquiryInfo", "csharp");
@@clientName(IaaSVMProtectableItem, "IaasVmProtectableItem", "csharp");
@@alternateType(IaaSVMProtectableItem.virtualMachineId,
  armResourceIdentifier,
  "csharp"
);
@@clientName(AzureIaaSClassicComputeVMProtectableItem,
  "IaasClassicComputeVmProtectableItem",
  "csharp"
);
@@clientName(AzureIaaSComputeVMProtectableItem,
  "IaasComputeVmProtectableItem",
  "csharp"
);
@@clientName(AzureFileShareProtectableItem,
  "FileShareProtectableItem",
  "csharp"
);
@@clientName(AzureIaaSVMProtectionPolicy, "IaasVmProtectionPolicy", "csharp");
@@clientName(AzureFileShareProtectionPolicy,
  "FileShareProtectionPolicy",
  "csharp"
);
@@clientName(AzureSqlProtectionPolicy, "SqlProtectionPolicy", "csharp");
@@clientName(AzureVmWorkloadProtectionPolicy,
  "VmWorkloadProtectionPolicy",
  "csharp"
);
@@clientName(AzureIaaSVMJob, "IaasVmBackupJob", "csharp");
@@clientName(AzureIaaSVMJobExtendedInfo,
  "IaasVmBackupJobExtendedInfo",
  "csharp"
);
@@clientName(AzureIaaSVMJobTaskDetails, "IaasVmBackupJobTaskDetails", "csharp");
@@clientName(AzureIaaSVMJobV2, "IaasVmBackupJobV2", "csharp");
@@clientName(AzureIaaSVMErrorInfo, "IaasVmErrorInfo", "csharp");
@@clientName(DpmJob, "DpmBackupJob", "csharp");
@@clientName(DpmJobExtendedInfo, "DpmBackupJobExtendedInfo", "csharp");
@@clientName(DpmJobTaskDetails, "DpmBackupJobTaskDetails", "csharp");
@@clientName(MabJob, "MabBackupJob", "csharp");
@@usage(MabJob, Usage.input | Usage.output, "csharp");
@@clientName(MabJobExtendedInfo, "MabBackupJobExtendedInfo", "csharp");
@@usage(MabJobExtendedInfo, Usage.input | Usage.output, "csharp");
@@clientName(MabJobTaskDetails, "MabBackupJobTaskDetails", "csharp");
@@usage(MabJobTaskDetails, Usage.input | Usage.output, "csharp");
@@clientName(AzureStorageJob, "StorageBackupJob", "csharp");
@@clientName(AzureStorageJobExtendedInfo,
  "StorageBackupJobExtendedInfo",
  "csharp"
);
@@clientName(AzureStorageJobTaskDetails,
  "StorageBackupJobTaskDetails",
  "csharp"
);
@@clientName(VaultJob, "VaultBackupJob", "csharp");
@@clientName(VaultJobErrorInfo, "VaultBackupJobErrorInfo", "csharp");
@@clientName(AzureWorkloadJob, "WorkloadBackupJob", "csharp");
@@clientName(AzureWorkloadJobExtendedInfo,
  "WorkloadBackupJobExtendedInfo",
  "csharp"
);
@@clientName(AzureWorkloadJobTaskDetails,
  "WorkloadBackupJobTaskDetails",
  "csharp"
);
@@clientName(AzureFileShareBackupRequest, "FileShareBackupContent", "csharp");
@@clientName(IaasVMBackupRequest, "IaasVmBackupContent", "csharp");
@@clientName(AzureWorkloadBackupRequest, "WorkloadBackupContent", "csharp");
@@clientName(AzureFileShareProvisionILRRequest,
  "FileShareProvisionIlrContent",
  "csharp"
);
@@alternateType(AzureFileShareProvisionILRRequest.sourceResourceId,
  armResourceIdentifier,
  "csharp"
);
@@clientName(IaasVMILRRegistrationRequest,
  "IaasVmIlrRegistrationContent",
  "csharp"
);
@@alternateType(IaasVMILRRegistrationRequest.virtualMachineId,
  armResourceIdentifier,
  "csharp"
);
@@clientName(AzureFileShareRestoreRequest, "FileShareRestoreContent", "csharp");
@@alternateType(AzureFileShareRestoreRequest.sourceResourceId,
  armResourceIdentifier,
  "csharp"
);
@@clientName(IaasVMRestoreRequest, "IaasVmRestoreContent", "csharp");
@@alternateType(IaasVMRestoreRequestProperties.extendedLocation,
  Azure.ResourceManager.CommonTypes.ExtendedLocation,
  "csharp"
);
@@alternateType(IaasVMRestoreRequestProperties.region, azureLocation, "csharp");
@@alternateType(IaasVMRestoreRequestProperties.sourceResourceId,
  armResourceIdentifier,
  "csharp"
);
@@alternateType(IaasVMRestoreRequestProperties.storageAccountId,
  armResourceIdentifier,
  "csharp"
);
@@alternateType(IaasVMRestoreRequestProperties.subnetId,
  armResourceIdentifier,
  "csharp"
);
@@alternateType(IaasVMRestoreRequestProperties.targetDomainNameId,
  armResourceIdentifier,
  "csharp"
);
@@alternateType(IaasVMRestoreRequestProperties.targetResourceGroupId,
  armResourceIdentifier,
  "csharp"
);
@@alternateType(IaasVMRestoreRequestProperties.targetVirtualMachineId,
  armResourceIdentifier,
  "csharp"
);
@@alternateType(IaasVMRestoreRequestProperties.virtualNetworkId,
  armResourceIdentifier,
  "csharp"
);
@@alternateType(IaasVMRecoveryPoint.extendedLocation,
  Azure.ResourceManager.CommonTypes.ExtendedLocation,
  "csharp"
);
@@alternateType(SecuredVMDetails.securedVMOsDiskEncryptionSetId,
  armResourceIdentifier,
  "csharp"
);
@@clientName(IaasVMRestoreWithRehydrationRequest,
  "IaasVmRestoreWithRehydrationContent",
  "csharp"
);
@@clientName(IaasVMRecoveryPoint, "IaasVmRecoveryPoint", "csharp");
@@clientName(AzureWorkloadRestoreRequest, "WorkloadRestoreContent", "csharp");
@@alternateType(AzureWorkloadRestoreRequestProperties.sourceResourceId,
  armResourceIdentifier,
  "csharp"
);
@@alternateType(AzureWorkloadRestoreRequestProperties.targetVirtualMachineId,
  armResourceIdentifier,
  "csharp"
);
@@clientName(AzureWorkloadPointInTimeRestoreRequest,
  "WorkloadPointInTimeRestoreContent",
  "csharp"
);
@@clientName(AzureFileShareRecoveryPoint, "FileShareRecoveryPoint", "csharp");
@@alternateType(AzureFileShareRecoveryPoint.fileShareSnapshotUri,
  url,
  "csharp"
);
@@clientName(AzureWorkloadRecoveryPoint, "WorkloadRecoveryPoint", "csharp");
@@clientName(AzureWorkloadRecoveryPoint.type, "RestorePointType", "csharp");
@@clientName(AzureWorkloadPointInTimeRecoveryPoint,
  "WorkloadPointInTimeRecoveryPoint",
  "csharp"
);
@@clientName(AzureWorkloadSAPAsePointInTimeRecoveryPoint,
  "WorkloadSapAsePointInTimeRecoveryPoint",
  "csharp"
);
@@clientName(AzureWorkloadSAPAseRecoveryPoint,
  "WorkloadSapAseRecoveryPoint",
  "csharp"
);
@@clientName(AzureWorkloadSAPAsePointInTimeRestoreRequest,
  "WorkloadSapAsePointInTimeRestoreContent",
  "csharp"
);
@@clientName(AzureWorkloadSAPAseRestoreRequest,
  "WorkloadSapAseRestoreContent",
  "csharp"
);
@@clientName(AzureWorkloadSAPHanaPointInTimeRecoveryPoint,
  "WorkloadSapHanaPointInTimeRecoveryPoint",
  "csharp"
);
@@clientName(AzureWorkloadSAPHanaRecoveryPoint,
  "WorkloadSapHanaRecoveryPoint",
  "csharp"
);
@@clientName(AzureWorkloadSAPHanaPointInTimeRestoreRequest,
  "WorkloadSapHanaPointInTimeRestoreContent",
  "csharp"
);
@@clientName(AzureWorkloadSAPHanaPointInTimeRestoreWithRehydrateRequest,
  "WorkloadSapHanaPointInTimeRestoreWithRehydrateContent",
  "csharp"
);
@@clientName(AzureWorkloadSAPHanaRestoreRequest,
  "WorkloadSapHanaRestoreContent",
  "csharp"
);
@@clientName(AzureWorkloadSAPHanaRestoreWithRehydrateRequest,
  "WorkloadSapHanaRestoreWithRehydrateContent",
  "csharp"
);
@@clientName(AzureWorkloadSQLAutoProtectionIntent,
  "WorkloadSqlAutoProtectionIntent",
  "csharp"
);
@@clientName(AzureWorkloadSQLPointInTimeRecoveryPoint,
  "WorkloadSqlPointInTimeRecoveryPoint",
  "csharp"
);
@@clientName(AzureWorkloadSQLRecoveryPoint,
  "WorkloadSqlRecoveryPoint",
  "csharp"
);
@@clientName(AzureWorkloadSQLRecoveryPointExtendedInfo,
  "WorkloadSqlRecoveryPointExtendedInfo",
  "csharp"
);
@@clientName(AzureWorkloadSQLPointInTimeRestoreRequest,
  "WorkloadSqlPointInTimeRestoreContent",
  "csharp"
);
@@clientName(AzureWorkloadSQLPointInTimeRestoreWithRehydrateRequest,
  "WorkloadSqlPointInTimeRestoreWithRehydrateContent",
  "csharp"
);
@@clientName(AzureWorkloadSQLRestoreRequest,
  "WorkloadSqlRestoreContent",
  "csharp"
);
@@clientName(AzureWorkloadSQLRestoreWithRehydrateRequest,
  "WorkloadSqlRestoreWithRehydrateContent",
  "csharp"
);
@@clientName(AzureVmWorkloadItem, "VmWorkloadItem", "csharp");
@@clientName(AzureVmWorkloadSAPAseDatabaseProtectableItem,
  "VmWorkloadSapAseDatabaseProtectableItem",
  "csharp"
);
@@clientName(AzureVmWorkloadSAPAseDatabaseWorkloadItem,
  "VmWorkloadSapAseDatabaseWorkloadItem",
  "csharp"
);
@@clientName(AzureVmWorkloadSAPAseSystemProtectableItem,
  "VmWorkloadSapAseSystemProtectableItem",
  "csharp"
);
@@clientName(AzureVmWorkloadSAPAseSystemWorkloadItem,
  "VmWorkloadSapAseSystemWorkloadItem",
  "csharp"
);
@@clientName(AzureVmWorkloadSAPHanaDatabaseProtectableItem,
  "VmWorkloadSapHanaDatabaseProtectableItem",
  "csharp"
);
@@clientName(AzureVmWorkloadSAPHanaDatabaseWorkloadItem,
  "VmWorkloadSapHanaDatabaseWorkloadItem",
  "csharp"
);
@@clientName(AzureVmWorkloadSAPHanaDBInstance,
  "VmWorkloadSapHanaDBInstance",
  "csharp"
);
@@clientName(AzureVmWorkloadSAPHanaHSRProtectableItem,
  "VmWorkloadSapHanaHsrProtectableItem",
  "csharp"
);
@@clientName(AzureVmWorkloadSAPHanaSystemProtectableItem,
  "VmWorkloadSapHanaSystemProtectableItem",
  "csharp"
);
@@clientName(AzureVmWorkloadSAPHanaSystemWorkloadItem,
  "VmWorkloadSapHanaSystemWorkloadItem",
  "csharp"
);
@@clientName(AzureVmWorkloadSQLAvailabilityGroupProtectableItem,
  "VmWorkloadSqlAvailabilityGroupProtectableItem",
  "csharp"
);
@@clientName(AzureVmWorkloadSQLDatabaseProtectableItem,
  "VmWorkloadSqlDatabaseProtectableItem",
  "csharp"
);
@@clientName(AzureVmWorkloadSQLDatabaseWorkloadItem,
  "VmWorkloadSqlDatabaseWorkloadItem",
  "csharp"
);
@@clientName(AzureVmWorkloadSQLInstanceProtectableItem,
  "VmWorkloadSqlInstanceProtectableItem",
  "csharp"
);
@@clientName(AzureVmWorkloadSQLInstanceWorkloadItem,
  "VmWorkloadSqlInstanceWorkloadItem",
  "csharp"
);
@@clientName(AzureVmWorkloadProtectionPolicy,
  "VmWorkloadProtectionPolicy",
  "csharp"
);
@@clientName(AzureWorkloadAutoProtectionIntent,
  "WorkloadAutoProtectionIntent",
  "csharp"
);
@@clientName(AzureRecoveryServiceVaultProtectionIntent,
  "RecoveryServiceVaultProtectionIntent",
  "csharp"
);
@@clientName(AzureResourceProtectionIntent,
  "ResourceProtectionIntent",
  "csharp"
);
@@clientName(AzureVMResourceFeatureSupportRequest,
  "VmResourceFeatureSupportContent",
  "csharp"
);
@@clientName(AzureVMResourceFeatureSupportResponse,
  "VmResourceFeatureSupportResult",
  "csharp"
);
@@clientName(BackupEngineBaseResource, "BackupEngine", "csharp");
@@clientName(JobResource, "BackupJob", "csharp");
@@clientName(Microsoft.RecoveryServices.PrivateEndpointConnectionResource,
  "BackupPrivateEndpointConnection",
  "csharp"
);
@@clientName(Microsoft.RecoveryServices.PrivateEndpointConnection,
  "BackupPrivateEndpointConnectionProperties",
  "csharp"
);
@@alternateType(Microsoft.RecoveryServices.PrivateEndpoint.id,
  armResourceIdentifier,
  "csharp"
);
@@clientName(ProtectedItemResource, "BackupProtectedItem", "csharp");
@@clientName(ProtectionContainerResource,
  "BackupProtectionContainer",
  "csharp"
);
@@clientName(ProtectionIntentResource, "BackupProtectionIntent", "csharp");
@@clientName(ProtectionPolicyResource, "BackupProtectionPolicy", "csharp");
@@clientName(RecoveryPointResource, "BackupRecoveryPoint", "csharp");
@@clientName(RecoveryPoint, "BackupGenericRecoveryPoint", "csharp");
@@clientName(ResourceGuardProxyBaseResource, "ResourceGuardProxy", "csharp");
@@clientName(ResourceGuardProxyBase, "ResourceGuardProxyProperties", "csharp");
@@clientName(ResourceGuardProxyBase.lastUpdatedTime, "LastUpdatedOn", "csharp");
@@alternateType(ResourceGuardProxyBase.lastUpdatedTime, utcDateTime, "csharp");
@@alternateType(ResourceGuardProxyBase.resourceGuardResourceId,
  armResourceIdentifier,
  "csharp"
);
@@clientName(EncryptionAtRestType, "BackupEncryptionAtRestType", "csharp");
@@clientName(AzureFileShareType, "BackupFileShareType", "csharp");
@@clientName(BackupEngineBase, "BackupGenericEngine", "csharp");
@@clientName(ProvisioningState,
  "BackupPrivateEndpointConnectionProvisioningState",
  "csharp"
);
@@clientName(StorageType, "BackupStorageType", "csharp");
@@clientName(StorageTypeState, "BackupStorageTypeState", "csharp");
@@clientName(ValidationStatus, "BackupValidationStatus", "csharp");
@@clientName(WorkloadType, "BackupWorkloadType", "csharp");
@@clientName(CopyOptions, "FileShareCopyOption", "csharp");
@@clientName(RecoveryType, "FileShareRecoveryType", "csharp");
@@clientName(RestoreRequestType, "FileShareRestoreType", "csharp");
@@clientName(IAASVMPolicyType, "IaasVmPolicyType", "csharp");
@@clientName(IaasVMSnapshotConsistencyType,
  "IaasVmSnapshotConsistencyType",
  "csharp"
);
@@clientName(OverwriteOptions, "RestoreOverwriteOption", "csharp");
@@clientName(PolicyType, "SubProtectionPolicyType", "csharp");
@@clientName(DedupState, "VaultDedupState", "csharp");
@@clientName(XcoolState, "VaultXcoolState", "csharp");
@@clientName(SupportStatus, "VmResourceFeatureSupportStatus", "csharp");
@@clientName(OperationType, "WorkloadOperationType", "csharp");
@@clientName(ProtectionPolicy, "BackupGenericProtectionPolicy", "csharp");
@@clientName(BEKDetails, "BekDetails", "csharp");
@@alternateType(BEKDetails.secretUrl, url, "csharp");
@@alternateType(BEKDetails.secretVaultId, armResourceIdentifier, "csharp");
@@clientName(KEKDetails, "KekDetails", "csharp");
@@alternateType(KEKDetails.keyUrl, url, "csharp");
@@alternateType(KEKDetails.keyVaultId, armResourceIdentifier, "csharp");
@@usage(KEKDetails, Usage.input | Usage.output, "csharp");
@@clientName(TargetAFSRestoreInfo, "TargetAfsRestoreInfo", "csharp");
@@alternateType(TargetAFSRestoreInfo.targetResourceId,
  armResourceIdentifier,
  "csharp"
);
@@clientName(Settings.issqlcompression, "IsSqlCompression", "csharp");
@@clientName(DataSourceType.AzureSqlDb, "AzureSqlDB", "csharp");
@@clientName(DataSourceType.SAPAseDatabase, "SapAseDatabase", "csharp");
@@clientName(DataSourceType.SAPHanaDBInstance, "SapHanaDBInstance", "csharp");
@@clientName(DataSourceType.SAPHanaDatabase, "SapHanaDatabase", "csharp");
@@clientName(DataSourceType.SQLDB, "SqlDB", "csharp");
@@clientName(DataSourceType.SQLDataBase, "SqlDatabase", "csharp");
@@clientName(DataSourceType.VM, "Vm", "csharp");
@@clientName(DataSourceType.VMwareVM, "VMwareVm", "csharp");
@@clientName(AzureFileShareType.XSMB, "Xsmb", "csharp");
@@clientName(BackupItemType.AzureSqlDb, "AzureSqlDB", "csharp");
@@clientName(BackupItemType.SAPAseDatabase, "SapAseDatabase", "csharp");
@@clientName(BackupItemType.SAPHanaDBInstance, "SapHanaDBInstance", "csharp");
@@clientName(BackupItemType.SAPHanaDatabase, "SapHanaDatabase", "csharp");
@@clientName(BackupItemType.SQLDB, "SqlDB", "csharp");
@@clientName(BackupItemType.SQLDataBase, "SqlDatabase", "csharp");
@@clientName(BackupItemType.VM, "Vm", "csharp");
@@clientName(BackupItemType.VMwareVM, "VMwareVm", "csharp");
@@clientName(BackupManagementType.AzureIaasVM, "AzureIaasVm", "csharp");
@@clientName(BackupManagementType.DPM, "Dpm", "csharp");
@@clientName(BackupManagementType.MAB, "Mab", "csharp");
@@clientName(WorkloadType.AzureSqlDb, "AzureSqlDB", "csharp");
@@clientName(WorkloadType.SAPAseDatabase, "SapAseDatabase", "csharp");
@@clientName(WorkloadType.SAPHanaDBInstance, "SapHanaDBInstance", "csharp");
@@clientName(WorkloadType.SAPHanaDatabase, "SapHanaDatabase", "csharp");
@@clientName(WorkloadType.SQLDB, "SqlDB", "csharp");
@@clientName(WorkloadType.SQLDataBase, "SqlDatabase", "csharp");
@@clientName(WorkloadType.VM, "Vm", "csharp");
@@clientName(WorkloadType.VMwareVM, "VMwareVm", "csharp");
@@clientName(AzureIaaSVMProtectionPolicy.instantRpRetentionRangeInDays,
  "InstantRPRetentionRangeInDays",
  "csharp"
);
@@clientName(IaasVMRecoveryPoint.isSourceVMEncrypted,
  "IsSourceVmEncrypted",
  "csharp"
);
@@clientName(IaasVMRecoveryPoint.osType, "OSType", "csharp");
@@clientName(IaasVMRecoveryPoint.sourceVMStorageType,
  "SourceVmStorageType",
  "csharp"
);
@@clientName(SecuredVMDetails.securedVMOsDiskEncryptionSetId,
  "SecuredVmOSDiskEncryptionSetId",
  "csharp"
);
@@clientName(MabServerType.DPMContainer, "DpmContainer", "csharp");
@@clientName(MabServerType.IaasVMContainer, "IaasVmContainer", "csharp");
@@clientName(MabServerType.IaasVMServiceContainer,
  "IaasVmServiceContainer",
  "csharp"
);
@@clientName(MabServerType.MABContainer, "MabContainer", "csharp");
@@clientName(MabServerType.VMAppContainer, "VmAppContainer", "csharp");
@@clientName(TokenInformation.securityPIN, "SecurityPin", "csharp");
@@clientName(SupportStatus.DefaultOFF, "DefaultOff", "csharp");
@@clientName(SupportStatus.DefaultON, "DefaultOn", "csharp");
@@clientName(AzureVmWorkloadItem.subinquireditemcount,
  "SubInquiredItemCount",
  "csharp"
);
@@clientName(AzureVmWorkloadProtectableItem.prebackupvalidation,
  "PreBackupValidation",
  "csharp"
);
@@clientName(AzureVmWorkloadProtectableItem.subinquireditemcount,
  "SubInquiredItemCount",
  "csharp"
);
@@clientName(AzureVmWorkloadProtectableItem.subprotectableitemcount,
  "SubProtectableItemCount",
  "csharp"
);
@@clientName(WorkloadItemType.SAPAseDatabase, "SapAseDatabase", "csharp");
@@clientName(WorkloadItemType.SAPAseSystem, "SapAseSystem", "csharp");
@@clientName(WorkloadItemType.SAPHanaDBInstance, "SapHanaDBInstance", "csharp");
@@clientName(WorkloadItemType.SAPHanaDatabase, "SapHanaDatabase", "csharp");
@@clientName(WorkloadItemType.SAPHanaSystem, "SapHanaSystem", "csharp");
@@clientName(WorkloadItemType.SQLDataBase, "SqlDatabase", "csharp");
@@clientName(WorkloadItemType.SQLInstance, "SqlInstance", "csharp");
@@clientName(AzureFileshareProtectedItemExtendedInfo.oldestRecoveryPoint,
  "OldestRecoverOn",
  "csharp"
);
@@clientName(AzureIaaSVMProtectedItemExtendedInfo.oldestRecoveryPoint,
  "OldestRecoverOn",
  "csharp"
);
@@clientName(AzureSqlProtectedItemExtendedInfo.oldestRecoveryPoint,
  "OldestRecoverOn",
  "csharp"
);
@@clientName(AzureVmWorkloadProtectedItemExtendedInfo.oldestRecoveryPoint,
  "OldestRecoverOn",
  "csharp"
);
@@clientName(MabFileFolderProtectedItemExtendedInfo.oldestRecoveryPoint,
  "OldestRecoverOn",
  "csharp"
);
@@clientName(AzureIaaSVMProtectedItemExtendedInfo.oldestRecoveryPointInVault,
  "OldestRecoverOnInVault",
  "csharp"
);
@@clientName(AzureVmWorkloadProtectedItemExtendedInfo.oldestRecoveryPointInVault,
  "OldestRecoverOnInVault",
  "csharp"
);
@@clientName(AzureIaaSVMProtectedItemExtendedInfo.oldestRecoveryPointInArchive,
  "OldestRecoverOnInArchive",
  "csharp"
);
@@clientName(AzureVmWorkloadProtectedItemExtendedInfo.oldestRecoveryPointInArchive,
  "OldestRecoverOnInArchive",
  "csharp"
);
@@clientName(AzureIaaSVMProtectedItemExtendedInfo.newestRecoveryPointInArchive,
  "NewestRecoverOnInArchive",
  "csharp"
);
@@clientName(AzureVmWorkloadProtectedItemExtendedInfo.newestRecoveryPointInArchive,
  "NewestRecoverOnInArchive",
  "csharp"
);
@@clientName(AzureFileShareBackupRequest.recoveryPointExpiryTimeInUTC,
  "RecoveryPointExpireOn",
  "csharp"
);
@@clientName(AzureWorkloadBackupRequest.recoveryPointExpiryTimeInUTC,
  "RecoveryPointExpireOn",
  "csharp"
);
@@clientName(IaasVMBackupRequest.recoveryPointExpiryTimeInUTC,
  "RecoveryPointExpireOn",
  "csharp"
);
@@clientName(RecoveryPointProperties.expiryTime, "ExpireOn", "csharp");
@@alternateType(RecoveryPointProperties.expiryTime, utcDateTime, "csharp");
@@clientName(UnlockDeleteResponse.unlockDeleteExpiryTime,
  "UnlockDeleteExpireOn",
  "csharp"
);
@@alternateType(UnlockDeleteResponse.unlockDeleteExpiryTime,
  utcDateTime,
  "csharp"
);
@@clientName(AzureFileShareRecoveryPoint.recoveryPointTime,
  "RecoveryPointOn",
  "csharp"
);
@@clientName(GenericRecoveryPoint.recoveryPointTime,
  "RecoveryPointOn",
  "csharp"
);
@@clientName(IaasVMRecoveryPoint.recoveryPointTime,
  "RecoveryPointOn",
  "csharp"
);
@@clientName(AzureWorkloadPointInTimeRecoveryPoint.recoveryPointTimeInUTC,
  "RecoveryPointCreatedOn",
  "csharp"
);
@@clientName(AzureWorkloadRecoveryPoint.recoveryPointTimeInUTC,
  "RecoveryPointCreatedOn",
  "csharp"
);
@@clientName(AzureWorkloadSAPHanaPointInTimeRecoveryPoint.recoveryPointTimeInUTC,
  "RecoveryPointCreatedOn",
  "csharp"
);
@@clientName(AzureWorkloadSAPHanaRecoveryPoint.recoveryPointTimeInUTC,
  "RecoveryPointCreatedOn",
  "csharp"
);
@@clientName(AzureWorkloadSAPAsePointInTimeRecoveryPoint.recoveryPointTimeInUTC,
  "RecoveryPointCreatedOn",
  "csharp"
);
@@clientName(AzureWorkloadSAPAseRecoveryPoint.recoveryPointTimeInUTC,
  "RecoveryPointCreatedOn",
  "csharp"
);
@@clientName(AzureWorkloadSQLPointInTimeRecoveryPoint.recoveryPointTimeInUTC,
  "RecoveryPointCreatedOn",
  "csharp"
);
@@clientName(AzureWorkloadSQLRecoveryPoint.recoveryPointTimeInUTC,
  "RecoveryPointCreatedOn",
  "csharp"
);
@@clientName(AzureWorkloadSQLRecoveryPointExtendedInfo.dataDirectoryTimeInUTC,
  "DataDirectoryInfoCapturedOn",
  "csharp"
);
@@clientName(TriggerDataMoveRequest.pauseGC, "DoesPauseGC", "csharp");
@@clientName(IaasVMRestoreRequest.createNewCloudService,
  "DoesCreateNewCloudService",
  "csharp"
);
@@clientName(IaasVMRestoreWithRehydrationRequest.createNewCloudService,
  "DoesCreateNewCloudService",
  "csharp"
);
@@clientName(IaasVMRestoreRequest.restoreWithManagedDisks,
  "DoesRestoreWithManagedDisks",
  "csharp"
);
@@clientName(IaasVMRestoreWithRehydrationRequest.restoreWithManagedDisks,
  "DoesRestoreWithManagedDisks",
  "csharp"
);
@@clientName(AzureVmWorkloadProtectionPolicy.makePolicyConsistent,
  "DoesMakePolicyConsistent",
  "csharp"
);
@@clientName(DpmContainer.upgradeAvailable, "IsUpgradeAvailable", "csharp");
@@clientName(AzureBackupServerContainer.upgradeAvailable,
  "IsUpgradeAvailable",
  "csharp"
);
@@clientName(EncryptionDetails.encryptionEnabled,
  "IsEncryptionEnabled",
  "csharp"
);
@@clientName(AzureIaaSVMProtectedItemExtendedInfo.policyInconsistent,
  "IsPolicyInconsistent",
  "csharp"
);
@@clientName(WorkloadInquiryDetails.type,
  "WorkloadInquiryDetailsType",
  "csharp"
);
@@clientName(SQLDataDirectory, "SqlDataDirectory", "csharp");
@@clientName(SQLDataDirectory.type, "DirectoryType", "csharp");
@@clientName(SQLDataDirectoryType, "SqlDataDirectoryType", "csharp");
@@clientName(RecoveryPointTierInformation.type, "TierType", "csharp");
@@clientName(AzureIaaSVMJobExtendedInfo.estimatedRemainingDuration,
  "EstimatedRemainingDurationValue",
  "csharp"
);
@@clientName(TieringPolicy.duration, "DurationValue", "csharp");
@@clientName(ResourceGuardOperationDetail.defaultResourceRequest,
  "DefaultResourceId",
  "csharp"
);
@@alternateType(ResourceGuardOperationDetail.defaultResourceRequest,
  armResourceIdentifier,
  "csharp"
);
@@clientName(BackupResourceConfig.crossRegionRestoreFlag,
  "EnableCrossRegionRestore",
  "csharp"
);
@@clientName(MabServerType.SQLAGWorkLoadContainer,
  "SqlAvailabilityGroupWorkLoadContainer",
  "csharp"
);
@@clientName(BackupResourceStorageConfigsNonCRR.bmsPrepareDataMove,
  "PrepareDataMove",
  "csharp"
);
@@clientName(BackupResourceStorageConfigsNonCRR.bmsTriggerDataMove,
  "TriggerDataMove",
  "csharp"
);

@@clientName(JobDetails, "BackupJob", "csharp");
@@clientName(ProtectedItem, "BackupGenericProtectedItem", "csharp");
@@clientName(ProtectedItem.deferredDeleteTimeInUTC,
  "DeferredDeletedOn",
  "csharp"
);
@@clientName(ProtectedItem.lastRecoveryPoint, "LastRecoverOn", "csharp");
@@alternateType(ProtectedItem.policyId, armResourceIdentifier, "csharp");
@@alternateType(ProtectedItem.sourceResourceId,
  armResourceIdentifier,
  "csharp"
);
@@alternateType(ContainerIdentityInfo.aadTenantId, uuid, "csharp");
@@clientName(DPMProtectedItemExtendedInfo.oldestRecoveryPoint,
  "OldestRecoverOn",
  "csharp"
);
@@clientName(DPMProtectedItemExtendedInfo.onPremiseOldestRecoveryPoint,
  "OnPremiseOldestRecoverOn",
  "csharp"
);
@@clientName(DPMProtectedItemExtendedInfo.onPremiseLatestRecoveryPoint,
  "OnPremiseLatestRecoverOn",
  "csharp"
);
@@clientName(DPMProtectedItemExtendedInfo.protected, "IsProtected", "csharp");
@@alternateType(IdentityBasedRestoreDetails.targetStorageAccountId,
  armResourceIdentifier,
  "csharp"
);
@@alternateType(RecoveryPointRehydrationInfo.rehydrationRetentionDuration,
  duration,
  "csharp"
);
@@alternateType(BackupEngineBaseResource.eTag, eTag, "csharp");
@@alternateType(BackupResourceConfigResource.eTag, eTag, "csharp");
@@alternateType(BackupResourceEncryptionConfigExtendedResource.eTag,
  eTag,
  "csharp"
);
@@alternateType(BackupResourceEncryptionConfigResource.eTag, eTag, "csharp");
@@alternateType(BackupResourceVaultConfigResource.eTag, eTag, "csharp");
@@alternateType(JobResource.eTag, eTag, "csharp");
@@alternateType(ResourceProperties.eTag, eTag, "csharp");
@@alternateType(Microsoft.RecoveryServices.PrivateEndpointConnectionResource.eTag,
  eTag,
  "csharp"
);
@@alternateType(ProtectedItemResource.eTag, eTag, "csharp");
@@alternateType(ProtectionContainerResource.eTag, eTag, "csharp");
@@alternateType(ProtectionIntentResource.eTag, eTag, "csharp");
@@alternateType(ProtectionPolicyResource.eTag, eTag, "csharp");
@@alternateType(RecoveryPointResource.eTag, eTag, "csharp");
@@alternateType(ResourceGuardProxyBaseResource.eTag, eTag, "csharp");
@@alternateType(UserAssignedManagedIdentityDetails.userAssignedIdentityProperties,
  Azure.ResourceManager.CommonTypes.UserAssignedIdentity,
  "csharp"
);
@@clientName(MABContainerHealthDetails, "MabContainerHealthDetails", "csharp");
@@clientName(SQLDataDirectoryMapping, "SqlDataDirectoryMapping", "csharp");
@@clientName(BackupProtectionIntent.list,
  "GetBackupProtectionIntents",
  "csharp"
);
@@clientName(BackupProtectedItems.list, "GetBackupProtectedItems", "csharp");
@@clientName(ProtectableContainers.list, "GetProtectableContainers", "csharp");
@@clientName(BackupProtectableItems.list,
  "GetBackupProtectableItems",
  "csharp"
);
@@clientName(DeletedProtectionContainers.list,
  "GetSoftDeletedProtectionContainers",
  "csharp"
);
@@clientName(BackupUsageSummaries.list, "GetBackupUsageSummaries", "csharp");
@@clientName(GetTieringCostOperationResult.get,
  "GetGetTieringCostOperationResult",
  "csharp"
);
@@clientName(RecoveryPointsRecommendedForMove.list,
  "GetRecoveryPointsRecommendedForMove",
  "csharp"
);
@@clientName(BackupWorkloadItems.list, "GetBackupWorkloadItems", "csharp");
@@clientName(JobCancellations.trigger, "TriggerJobCancellation", "csharp");
@@clientName(Backups.trigger, "TriggerBackup", "csharp");
@@clientName(Restores.trigger, "TriggerRestore", "csharp");
@@clientName(ItemLevelRecoveryConnections.provision,
  "ProvisionItemLevelRecoveryConnection",
  "csharp"
);
@@clientName(ItemLevelRecoveryConnections.revoke,
  "RevokeItemLevelRecoveryConnection",
  "csharp"
);
@@clientName(BackupResourceEncryptionConfigResource,
  "BackupResourceEncryptionConfigExtendedCreateOrUpdateContent",
  "csharp"
);
@@clientName(Jobs.export, "ExportJob", "csharp");
@@clientName(SecurityPINs.get, "GetSecurityPin", "csharp");
@@clientName(BackupStatus.get, "GetBackupStatus", "csharp");
@@clientName(BackupStatus.get::parameters.azureRegion, "location", "csharp");
@@alternateType(BackupStatus.get::parameters.azureRegion,
  azureLocation,
  "csharp"
);
@@clientName(BackupProtectionContainers.list,
  "GetBackupProtectionContainers",
  "csharp"
);
@@clientName(FetchTieringCost.post, "PostFetchTieringCost", "csharp");
@@clientName(ProtectionContainersOperationGroup.refresh,
  "RefreshProtectionContainer",
  "csharp"
);
@@clientName(FeatureSupport.validate, "ValidateFeatureSupport", "csharp");
@@clientName(FeatureSupport.validate::parameters.azureRegion,
  "location",
  "csharp"
);
@@alternateType(FeatureSupport.validate::parameters.azureRegion,
  azureLocation,
  "csharp"
);
@@clientName(ProtectionIntentOperationGroup.validate,
  "ValidateProtectionIntent",
  "csharp"
);
@@clientName(ProtectionIntentOperationGroup.validate::parameters.azureRegion,
  "location",
  "csharp"
);
@@alternateType(ProtectionIntentOperationGroup.validate::parameters.azureRegion,
  azureLocation,
  "csharp"
);
@@clientName(AzureVmWorkloadSAPHanaScaleoutProtectableItem,
  "VmWorkloadSapHanaScaleoutProtectableItem",
  "csharp"
);
@@alternateType(BackupResourceEncryptionConfig.keyUri, url, "csharp");
@@clientName(ThreatInfo, "RecoveryPointThreatInformation", "csharp");
@@clientName(DatabaseInRP, "BackupRecoveryPointDatabase", "csharp");
@@clientName(VMWorkloadPolicyType, "VmWorkloadPolicyType", "csharp");
@@clientName(ProtectionLevel, "BackupProtectionLevel", "csharp");
@@clientName(ThreatSeverity, "RecoveryPointThreatSeverity", "csharp");
@@clientName(ThreatState, "RecoveryPointThreatState", "csharp");
@@clientName(ThreatStatus, "RecoveryPointThreatStatus", "csharp");
@@clientName(SourceSideScanInfo, "BackupSourceSideScanInfo", "csharp");
@@clientName(SourceSideScanStatus, "BackupSourceSideScanStatus", "csharp");
@@clientName(SourceSideScanSummary, "BackupSourceSideScanSummary", "csharp");
@@clientName(AzureVmWorkloadSQLInstanceProtectedItem,
  "VmWorkloadSqlInstanceProtectedItem",
  "csharp"
);
@@clientName(InstanceProtectionReadiness,
  "BackupInstanceProtectionReadiness",
  "csharp"
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.hierarchyBuilding(BackupEngineBaseResource,
  Azure.ResourceManager.Foundations.TrackedResource,
  "csharp"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.hierarchyBuilding(BackupResourceConfigResource,
  Azure.ResourceManager.Foundations.TrackedResource,
  "csharp"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.hierarchyBuilding(BackupResourceEncryptionConfigExtendedResource,
  Azure.ResourceManager.Foundations.TrackedResource,
  "csharp"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.hierarchyBuilding(BackupResourceEncryptionConfigResource,
  Azure.ResourceManager.Foundations.TrackedResource,
  "csharp"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.hierarchyBuilding(BackupResourceVaultConfigResource,
  Azure.ResourceManager.Foundations.TrackedResource,
  "csharp"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.hierarchyBuilding(JobResource,
  Azure.ResourceManager.Foundations.TrackedResource,
  "csharp"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.hierarchyBuilding(Microsoft.RecoveryServices.PrivateEndpointConnectionResource,
  Azure.ResourceManager.Foundations.TrackedResource,
  "csharp"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.hierarchyBuilding(ProtectionContainerResource,
  Azure.ResourceManager.Foundations.TrackedResource,
  "csharp"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.hierarchyBuilding(ProtectedItemResource,
  Azure.ResourceManager.Foundations.TrackedResource,
  "csharp"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.hierarchyBuilding(ProtectionIntentResource,
  Azure.ResourceManager.Foundations.TrackedResource,
  "csharp"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.hierarchyBuilding(ProtectionPolicyResource,
  Azure.ResourceManager.Foundations.TrackedResource,
  "csharp"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.hierarchyBuilding(RecoveryPointResource,
  Azure.ResourceManager.Foundations.TrackedResource,
  "csharp"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.hierarchyBuilding(ResourceGuardProxyBaseResource,
  Azure.ResourceManager.Foundations.TrackedResource,
  "csharp"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.hierarchyBuilding(ProtectableContainerResource,
  Azure.ResourceManager.Foundations.TrackedResource,
  "csharp"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.hierarchyBuilding(BackupRequestResource,
  Azure.ResourceManager.Foundations.TrackedResource,
  "csharp"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.hierarchyBuilding(WorkloadItemResource,
  Azure.ResourceManager.Foundations.TrackedResource,
  "csharp"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.hierarchyBuilding(WorkloadProtectableItemResource,
  Azure.ResourceManager.Foundations.TrackedResource,
  "csharp"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.hierarchyBuilding(ILRRequestResource,
  Azure.ResourceManager.Foundations.TrackedResource,
  "csharp"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.hierarchyBuilding(RestoreRequestResource,
  Azure.ResourceManager.Foundations.TrackedResource,
  "csharp"
);

@@usage(BackupEngineExtendedInfo, Usage.input | Usage.output, "csharp");
@@usage(BackupEngineBase, Usage.input | Usage.output, "csharp");
@@usage(Job, Usage.input | Usage.output, "csharp");
@@usage(BackupResourceEncryptionConfig, Usage.input | Usage.output, "csharp");
@@usage(BackupResourceEncryptionConfigExtended,
  Usage.input | Usage.output,
  "csharp"
);
@@usage(BEKDetails, Usage.input | Usage.output, "csharp");
@@usage(DiskInformation, Usage.input | Usage.output, "csharp");
@@usage(DpmJob, Usage.input | Usage.output, "csharp");
@@usage(DpmJobExtendedInfo, Usage.input | Usage.output, "csharp");
@@usage(DpmJobTaskDetails, Usage.input | Usage.output, "csharp");
@@usage(DpmErrorInfo, Usage.input | Usage.output, "csharp");
@@usage(AzureFileShareProtectableItem, Usage.input | Usage.output, "csharp");
@@usage(AzureFileShareRecoveryPoint, Usage.input | Usage.output, "csharp");
@@usage(AzureIaaSVMJob, Usage.input | Usage.output, "csharp");
@@usage(AzureIaaSVMJobExtendedInfo, Usage.input | Usage.output, "csharp");
@@usage(AzureIaaSVMJobTaskDetails, Usage.input | Usage.output, "csharp");
@@usage(AzureIaaSVMJobV2, Usage.input | Usage.output, "csharp");
@@usage(IaaSVMProtectableItem, Usage.input | Usage.output, "csharp");
@@usage(IaasVMRecoveryPoint, Usage.input | Usage.output, "csharp");
@@usage(KeyAndSecretDetails, Usage.input | Usage.output, "csharp");
@@usage(PointInTimeRange, Usage.input | Usage.output, "csharp");
@@usage(PreBackupValidation, Usage.input | Usage.output, "csharp");
@@usage(ProtectableContainer, Usage.input | Usage.output, "csharp");
@@usage(ProtectableContainerResource, Usage.input | Usage.output, "csharp");
@@usage(RecoveryPointDiskConfiguration, Usage.input | Usage.output, "csharp");
@@usage(RecoveryPointMoveReadinessInfo, Usage.input | Usage.output, "csharp");
@@usage(RecoveryPointProperties, Usage.input | Usage.output, "csharp");
@@usage(RecoveryPointTierInformation, Usage.input | Usage.output, "csharp");
@@usage(SQLDataDirectory, Usage.input | Usage.output, "csharp");
@@usage(AzureStorageJob, Usage.input | Usage.output, "csharp");
@@usage(AzureStorageJobExtendedInfo, Usage.input | Usage.output, "csharp");
@@usage(AzureStorageJobTaskDetails, Usage.input | Usage.output, "csharp");
@@usage(AzureStorageErrorInfo, Usage.input | Usage.output, "csharp");
@@usage(VaultJob, Usage.input | Usage.output, "csharp");
@@usage(VaultJobErrorInfo, Usage.input | Usage.output, "csharp");
@@usage(AzureVmWorkloadItem, Usage.input | Usage.output, "csharp");
@@usage(AzureVmWorkloadProtectableItem, Usage.input | Usage.output, "csharp");
@@usage(AzureWorkloadJob, Usage.input | Usage.output, "csharp");
@@usage(AzureWorkloadJobExtendedInfo, Usage.input | Usage.output, "csharp");
@@usage(AzureWorkloadJobTaskDetails, Usage.input | Usage.output, "csharp");
@@usage(AzureWorkloadErrorInfo, Usage.input | Usage.output, "csharp");
@@usage(WorkloadItem, Usage.input | Usage.output, "csharp");
@@usage(WorkloadProtectableItem, Usage.input | Usage.output, "csharp");
@@usage(AzureWorkloadRecoveryPoint, Usage.input | Usage.output, "csharp");
@@usage(AzureWorkloadSQLRecoveryPoint, Usage.input | Usage.output, "csharp");
@@usage(AzureWorkloadSQLRecoveryPointExtendedInfo,
  Usage.input | Usage.output,
  "csharp"
);
@@usage(BackupEngineBaseResource, Usage.input | Usage.output, "csharp");
@@usage(JobResource, Usage.input | Usage.output, "csharp");
@@usage(RecoveryPointResource, Usage.input | Usage.output, "csharp");
@@usage(BackupResourceEncryptionConfigExtendedResource,
  Usage.input | Usage.output,
  "csharp"
);
@@usage(WorkloadItemResource, Usage.input | Usage.output, "csharp");
@@usage(WorkloadProtectableItemResource, Usage.input | Usage.output, "csharp");

// Remove this operation for backward compatibility.
@@scope(BackupResourceStorageConfigsNonCRR.patch, "!csharp");

// Exclude operation status related operations as they are supported by core SDK.
@@scope(PrivateEndpointOperationStatuses.getOperationStatus, "!csharp");
@@scope(ProtectedItemOperationResults.get, "!csharp");
@@scope(ProtectedItemOperationStatuses.get, "!csharp");
@@scope(ProtectionPolicyOperationResults.get, "!csharp");
@@scope(ProtectionPolicyOperationStatuses.get, "!csharp");
@@scope(BMSPrepareDataMoveOperationResult.get, "!csharp");
@@scope(BackupResourceConfigOperationStatuses.getOperationStatus, "!csharp");
@@scope(BackupOperationStatuses.get, "!csharp");
@@scope(TieringCostOperationStatus.get, "!csharp");
@@scope(BackupOperationResults.get, "!csharp");
@@scope(ValidateOperationResults.get, "!csharp");
@@scope(ValidateOperationStatuses.get, "!csharp");
@@scope(ExportJobsOperationResults.get, "!csharp");
@@scope(ProtectionContainerOperationResults.get, "!csharp");
@@scope(JobOperationResults.get, "!csharp");
@@scope(ProtectionContainerRefreshOperationResults.get, "!csharp");
@@scope(ValidateOperation.trigger, "!csharp");
@@scope(OperationOperationGroup.validate, "!csharp");

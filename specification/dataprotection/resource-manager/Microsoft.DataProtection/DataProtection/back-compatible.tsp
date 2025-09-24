import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.DataProtection;

// Recovery Points operations
@@clientLocation(AzureBackupRecoveryPointResources.get, "RecoveryPoints");
@@clientLocation(AzureBackupRecoveryPointResources.list, "RecoveryPoints");

// Jobs operations
@@clientLocation(AzureBackupJobResources.get, "Jobs");
@@clientLocation(AzureBackupJobResources.list, "Jobs");

// BackupVaults operations
@@clientLocation(BackupVaultResources.get, "BackupVaults");
@@clientLocation(BackupVaultResources.createOrUpdate, "BackupVaults");
@@clientLocation(BackupVaultResources.update, "BackupVaults");
@@clientLocation(BackupVaultResources.delete, "BackupVaults");
@@clientLocation(BackupVaultResources.getInSubscription, "BackupVaults");
@@clientLocation(BackupVaultResources.operationStatusBackupVaultContextGet,
  "OperationStatusBackupVaultContext"
);
@@clientLocation(BackupVaultResources.trigger, "ExportJobs");
@@clientLocation(BackupVaultOperationResults.getInResourceGroup,
  "BackupVaults"
);
@@clientLocation(BackupVaultsOperationGroup.checkNameAvailability,
  "BackupVaults"
);

// BackupPolicies operations
@@clientLocation(BaseBackupPolicyResources.get, "BackupPolicies");
@@clientLocation(BaseBackupPolicyResources.createOrUpdate, "BackupPolicies");
@@clientLocation(BaseBackupPolicyResources.delete, "BackupPolicies");
@@clientLocation(BaseBackupPolicyResources.list, "BackupPolicies");

// DeletedBackupInstances operations
@@clientLocation(DeletedBackupInstanceResources.get, "DeletedBackupInstances");
@@clientLocation(DeletedBackupInstanceResources.list, "DeletedBackupInstances");
@@clientLocation(DeletedBackupInstanceResources.undelete,
  "DeletedBackupInstances"
);

// BackupInstances operations
@@clientLocation(BackupInstanceResources.get, BackupInstances);
@@clientLocation(BackupInstanceResources.createOrUpdate, BackupInstances);
@@clientLocation(BackupInstanceResources.delete, BackupInstances);
@@clientLocation(BackupInstanceResources.adhocBackup, BackupInstances);
@@clientLocation(BackupInstanceResources.validateForModifyBackup,
  BackupInstances
);
@@clientLocation(BackupInstanceResources.triggerRehydrate, BackupInstances);
@@clientLocation(BackupInstanceResources.triggerRestore, BackupInstances);
@@clientLocation(BackupInstanceResources.resumeBackups, BackupInstances);
@@clientLocation(BackupInstanceResources.resumeProtection, BackupInstances);
@@clientLocation(BackupInstanceResources.stopProtection, BackupInstances);
@@clientLocation(BackupInstanceResources.suspendBackups, BackupInstances);
@@clientLocation(BackupInstanceResources.syncBackupInstance, BackupInstances);
@@clientLocation(BackupInstanceResources.validateForRestore, BackupInstances);
@@clientLocation(BackupInstanceResources.find, "RestorableTimeRanges");
@@clientLocation(BackupInstancesOperationGroup.triggerCrossRegionRestore,
  BackupInstances
);
@@clientLocation(BackupInstancesOperationGroup.validateCrossRegionRestore,
  BackupInstances
);
@@clientLocation(BackupVaultResources.validateForBackup, BackupInstances);
@@clientLocation(BackupVaultResources.exportJobsOperationResultGet,
  "ExportJobsOperationResult"
);
// ResourceGuards operations
@@clientLocation(ResourceGuardResources.get, ResourceGuards);
@@clientLocation(ResourceGuardResources.put, ResourceGuards);
@@clientLocation(ResourceGuardResources.patch, ResourceGuards);
@@clientLocation(ResourceGuardResources.delete, ResourceGuards);
@@clientLocation(ResourceGuardResources.getResourcesInResourceGroup,
  ResourceGuards
);
@@clientLocation(ResourceGuardResources.getResourcesInSubscription,
  ResourceGuards
);
@@clientLocation(DppBaseResourceOperationGroup.getDefaultDisableSoftDeleteRequestsObject,
  ResourceGuards
);
@@clientLocation(DppBaseResourceOperationGroup.getDisableSoftDeleteRequestsObjects,
  ResourceGuards
);
@@clientLocation(DppBaseResourceOperationGroup.getDefaultUpdateProtectedItemRequestsObject,
  ResourceGuards
);
@@clientLocation(DppBaseResourceOperationGroup.getUpdateProtectedItemRequestsObjects,
  ResourceGuards
);
@@clientLocation(DppBaseResourceOperationGroup.getDefaultUpdateProtectionPolicyRequestsObject,
  ResourceGuards
);
@@clientLocation(DppBaseResourceOperationGroup.getUpdateProtectionPolicyRequestsObjects,
  ResourceGuards
);
@@clientLocation(DppBaseResourceOperationGroup.getDefaultDeleteProtectedItemRequestsObject,
  ResourceGuards
);
@@clientLocation(DppBaseResourceOperationGroup.getDeleteProtectedItemRequestsObjects,
  ResourceGuards
);
@@clientLocation(DppBaseResourceOperationGroup.getDefaultBackupSecurityPINRequestsObject,
  ResourceGuards
);
@@clientLocation(DppBaseResourceOperationGroup.getBackupSecurityPINRequestsObjects,
  ResourceGuards
);

// ResourceGuardProxy operations
@@clientLocation(ResourceGuardProxyBaseResources.get, "DppResourceGuardProxy");
@@clientLocation(ResourceGuardProxyBaseResources.createOrUpdate,
  "DppResourceGuardProxy"
);
@@clientLocation(ResourceGuardProxyBaseResources.delete,
  "DppResourceGuardProxy"
);
@@clientLocation(ResourceGuardProxyBaseResources.list, "DppResourceGuardProxy");
@@clientLocation(ResourceGuardProxyBaseResources.unlockDelete,
  "DppResourceGuardProxy"
);

// Other operations
@@clientLocation(OperationResultOperationGroup.get, "OperationResult");
@@clientLocation(OperationStatusOperationGroup.get, "OperationStatus");
@@clientLocation(OperationStatusResourceGroupContextOperationGroup.get,
  "OperationStatusResourceGroupContext"
);
@@clientLocation(DataProtectionOperationGroup.checkFeatureSupport,
  "DataProtection"
);
@@clientLocation(FetchSecondaryRecoveryPointsOperationGroup.list,
  "FetchSecondaryRecoveryPoints"
);
@@clientLocation(FetchCrossRegionRestoreJobOperationGroup.get,
  "FetchCrossRegionRestoreJob"
);
@@clientLocation(FetchCrossRegionRestoreJobsOperationGroup.list,
  "FetchCrossRegionRestoreJobs"
);
@@clientLocation(BackupInstancesExtensionRoutingOperationGroup.list,
  "BackupInstancesExtensionRouting"
);

@@clientName(BackupVaultResources.exportJobsOperationResultGet, "Get");

@@clientName(BackupVaultResources.operationStatusBackupVaultContextGet, "Get");

@@clientName(BackupVaultResources.createOrUpdate::parameters.resource,
  "parameters"
);
@@clientName(BackupVaultResources.update::parameters.properties, "parameters");
@@clientName(BackupVaultResources.validateForBackup::parameters.body,
  "parameters"
);

@@clientName(BaseBackupPolicyResources.createOrUpdate::parameters.resource,
  "parameters"
);

@@clientName(BackupInstanceResources.createOrUpdate::parameters.resource,
  "parameters"
);
@@clientName(BackupInstanceResources.adhocBackup::parameters.body,
  "parameters"
);
@@clientName(BackupInstanceResources.validateForModifyBackup::parameters.body,
  "parameters"
);
@@clientName(BackupInstanceResources.triggerRehydrate::parameters.body,
  "parameters"
);
@@clientName(BackupInstanceResources.triggerRestore::parameters.body,
  "parameters"
);
@@clientName(BackupInstanceResources.syncBackupInstance::parameters.body,
  "parameters"
);
@@clientName(BackupInstanceResources.validateForRestore::parameters.body,
  "parameters"
);
@@clientName(BackupInstanceResources.find::parameters.body, "parameters");

@@clientName(ResourceGuardResources.put::parameters.resource, "parameters");
@@clientName(ResourceGuardResources.patch::parameters.properties, "parameters");

@@clientName(ResourceGuardProxyBaseResources.createOrUpdate::parameters.resource,
  "parameters"
);
@@clientName(ResourceGuardProxyBaseResources.unlockDelete::parameters.body,
  "parameters"
);
@@clientName(DataProtectionOperationGroup.checkFeatureSupport::parameters.body,
  "parameters"
);
@@clientName(Operations, "DataProtectionOperations");
@@clientName(EncryptionSettings, "encryptionSettings");
@@clientName(BackupInstanceResources.suspendBackups::parameters.body,
  "parameters"
);
@@clientName(BackupInstanceResources.stopProtection::parameters.body,
  "parameters"
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Azure.ClientGenerator.Core.Legacy.hierarchyBuilding(AzureBackupRestoreWithRehydrationRequest,
  AzureBackupRecoveryPointBasedRestoreRequest
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Azure.ClientGenerator.Core.Legacy.hierarchyBuilding(AdlsBlobBackupDatasourceParameters,
  BlobBackupDatasourceParameters
);

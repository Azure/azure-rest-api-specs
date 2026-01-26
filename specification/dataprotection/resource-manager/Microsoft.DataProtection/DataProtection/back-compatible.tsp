import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.DataProtection;

// Recovery Points operations
@@clientLocation(AzureBackupRecoveryPointResources.get,
  "RecoveryPoints",
  "!csharp"
);
@@clientLocation(AzureBackupRecoveryPointResources.list,
  "RecoveryPoints",
  "!csharp"
);

// Jobs operations
@@clientLocation(AzureBackupJobResources.get, "Jobs", "!csharp");
@@clientLocation(AzureBackupJobResources.list, "Jobs", "!csharp");

// BackupVaults operations
@@clientLocation(BackupVaultResources.get, "BackupVaults", "!csharp");
@@clientLocation(BackupVaultResources.createOrUpdate,
  "BackupVaults",
  "!csharp"
);
@@clientLocation(BackupVaultResources.update, "BackupVaults", "!csharp");
@@clientLocation(BackupVaultResources.delete, "BackupVaults", "!csharp");
@@clientLocation(BackupVaultResources.getInSubscription,
  "BackupVaults",
  "!csharp"
);
@@clientLocation(BackupVaultResources.operationStatusBackupVaultContextGet,
  "OperationStatusBackupVaultContext",
  "!csharp"
);
@@clientLocation(BackupVaultResources.trigger, "ExportJobs", "!csharp");
@@clientLocation(BackupVaultOperationResults.getInResourceGroup,
  "BackupVaults",
  "!csharp"
);
@@clientLocation(BackupVaultsOperationGroup.checkNameAvailability,
  "BackupVaults",
  "!csharp"
);

// BackupPolicies operations
@@clientLocation(BaseBackupPolicyResources.get, "BackupPolicies", "!csharp");
@@clientLocation(BaseBackupPolicyResources.createOrUpdate,
  "BackupPolicies",
  "!csharp"
);
@@clientLocation(BaseBackupPolicyResources.delete, "BackupPolicies", "!csharp");
@@clientLocation(BaseBackupPolicyResources.list, "BackupPolicies", "!csharp");

// DeletedBackupInstances operations
@@clientLocation(DeletedBackupInstanceResources.get,
  "DeletedBackupInstances",
  "!csharp"
);
@@clientLocation(DeletedBackupInstanceResources.list,
  "DeletedBackupInstances",
  "!csharp"
);
@@clientLocation(DeletedBackupInstanceResources.undelete,
  "DeletedBackupInstances",
  "!csharp"
);

// BackupInstances operations
@@clientLocation(BackupInstanceResources.get, BackupInstances, "!csharp");
@@clientLocation(BackupInstanceResources.createOrUpdate,
  BackupInstances,
  "!csharp"
);
@@clientLocation(BackupInstanceResources.delete, BackupInstances, "!csharp");
@@clientLocation(BackupInstanceResources.adhocBackup,
  BackupInstances,
  "!csharp"
);
@@clientLocation(BackupInstanceResources.validateForModifyBackup,
  BackupInstances,
  "!csharp"
);
@@clientLocation(BackupInstanceResources.triggerRehydrate,
  BackupInstances,
  "!csharp"
);
@@clientLocation(BackupInstanceResources.triggerRestore,
  BackupInstances,
  "!csharp"
);
@@clientLocation(BackupInstanceResources.resumeBackups,
  BackupInstances,
  "!csharp"
);
@@clientLocation(BackupInstanceResources.resumeProtection,
  BackupInstances,
  "!csharp"
);
@@clientLocation(BackupInstanceResources.stopProtection,
  BackupInstances,
  "!csharp"
);
@@clientLocation(BackupInstanceResources.suspendBackups,
  BackupInstances,
  "!csharp"
);
@@clientLocation(BackupInstanceResources.syncBackupInstance,
  BackupInstances,
  "!csharp"
);
@@clientLocation(BackupInstanceResources.validateForRestore,
  BackupInstances,
  "!csharp"
);
@@clientLocation(BackupInstanceResources.find,
  "RestorableTimeRanges",
  "!csharp"
);
@@clientLocation(BackupInstancesOperationGroup.triggerCrossRegionRestore,
  BackupInstances,
  "!csharp"
);
@@clientLocation(BackupInstancesOperationGroup.validateCrossRegionRestore,
  BackupInstances,
  "!csharp"
);
@@clientLocation(BackupVaultResources.validateForBackup,
  BackupInstances,
  "!csharp"
);
@@clientLocation(BackupVaultResources.exportJobsOperationResultGet,
  "ExportJobsOperationResult",
  "!csharp"
);
// ResourceGuards operations
@@clientLocation(ResourceGuardResources.get, ResourceGuards, "!csharp");
@@clientLocation(ResourceGuardResources.put, ResourceGuards, "!csharp");
@@clientLocation(ResourceGuardResources.patch, ResourceGuards, "!csharp");
@@clientLocation(ResourceGuardResources.delete, ResourceGuards, "!csharp");
@@clientLocation(ResourceGuardResources.getResourcesInResourceGroup,
  ResourceGuards,
  "!csharp"
);
@@clientLocation(ResourceGuardResources.getResourcesInSubscription,
  ResourceGuards,
  "!csharp"
);
@@clientLocation(DppBaseResourceOperationGroup.getDefaultDisableSoftDeleteRequestsObject,
  ResourceGuards,
  "!csharp"
);
@@clientLocation(DppBaseResourceOperationGroup.getDisableSoftDeleteRequestsObjects,
  ResourceGuards,
  "!csharp"
);
@@clientLocation(DppBaseResourceOperationGroup.getDefaultUpdateProtectedItemRequestsObject,
  ResourceGuards,
  "!csharp"
);
@@clientLocation(DppBaseResourceOperationGroup.getUpdateProtectedItemRequestsObjects,
  ResourceGuards,
  "!csharp"
);
@@clientLocation(DppBaseResourceOperationGroup.getDefaultUpdateProtectionPolicyRequestsObject,
  ResourceGuards,
  "!csharp"
);
@@clientLocation(DppBaseResourceOperationGroup.getUpdateProtectionPolicyRequestsObjects,
  ResourceGuards,
  "!csharp"
);
@@clientLocation(DppBaseResourceOperationGroup.getDefaultDeleteProtectedItemRequestsObject,
  ResourceGuards,
  "!csharp"
);
@@clientLocation(DppBaseResourceOperationGroup.getDeleteProtectedItemRequestsObjects,
  ResourceGuards,
  "!csharp"
);
@@clientLocation(DppBaseResourceOperationGroup.getDefaultBackupSecurityPINRequestsObject,
  ResourceGuards,
  "!csharp"
);
@@clientLocation(DppBaseResourceOperationGroup.getBackupSecurityPINRequestsObjects,
  ResourceGuards,
  "!csharp"
);

// ResourceGuardProxy operations
@@clientLocation(ResourceGuardProxyBaseResources.get,
  "DppResourceGuardProxy",
  "!csharp"
);
@@clientLocation(ResourceGuardProxyBaseResources.createOrUpdate,
  "DppResourceGuardProxy",
  "!csharp"
);
@@clientLocation(ResourceGuardProxyBaseResources.delete,
  "DppResourceGuardProxy",
  "!csharp"
);
@@clientLocation(ResourceGuardProxyBaseResources.list,
  "DppResourceGuardProxy",
  "!csharp"
);
@@clientLocation(ResourceGuardProxyBaseResources.unlockDelete,
  "DppResourceGuardProxy",
  "!csharp"
);

// Other operations
@@clientLocation(OperationResultOperationGroup.get,
  "OperationResult",
  "!csharp"
);
@@clientLocation(OperationStatusOperationGroup.get,
  "OperationStatus",
  "!csharp"
);
@@clientLocation(OperationStatusResourceGroupContextOperationGroup.get,
  "OperationStatusResourceGroupContext",
  "!csharp"
);
@@clientLocation(DataProtectionOperationGroup.checkFeatureSupport,
  "DataProtection",
  "!csharp"
);
@@clientLocation(FetchSecondaryRecoveryPointsOperationGroup.list,
  "FetchSecondaryRecoveryPoints",
  "!csharp"
);
@@clientLocation(FetchCrossRegionRestoreJobOperationGroup.get,
  "FetchCrossRegionRestoreJob",
  "!csharp"
);
@@clientLocation(FetchCrossRegionRestoreJobsOperationGroup.list,
  "FetchCrossRegionRestoreJobs",
  "!csharp"
);
@@clientLocation(BackupInstancesExtensionRoutingOperationGroup.list,
  "BackupInstancesExtensionRouting",
  "!csharp"
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

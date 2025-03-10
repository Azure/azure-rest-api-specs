import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";
import "@azure-tools/typespec-azure-core";

using Azure.ClientGenerator.Core;
using Microsoft.Storage;
using Azure.Core;

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(ListContainerItem.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(ImmutabilityPolicyProperties.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(FileShareItem.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(ListQueue.queueProperties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(StorageAccountCreateParameters.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(StorageAccountUpdateParameters.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(PrivateLinkResource.properties);

//@@clientName(BlobServicePropertiesOperationGroup, "BlobServiceProperties");
@@clientName(BlobServices.setServiceProperties::parameters.resource,
  "parameters"
);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(BlobServiceProperties.properties);

@@clientName(BlobContainers.create::parameters.resource, "blobContainer");
@@clientName(BlobContainers.update::parameters.properties, "blobContainer");
@@clientName(BlobContainers.setLegalHold::parameters.body, "LegalHold");
@@clientName(BlobContainers.clearLegalHold::parameters.body, "LegalHold");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(BlobContainer.properties);

@@clientName(ImmutabilityPolicies.createOrUpdateImmutabilityPolicy::parameters.resource,
  "parameters"
);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(ImmutabilityPolicy.properties);

// @@clientName(FileServicePropertiesOperationGroup, "FileServiceProperties");
@@clientName(FileServices.setServiceProperties::parameters.resource,
  "parameters"
);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(FileServiceProperties.properties);

@@clientName(FileShares.create::parameters.resource, "fileShare");
@@clientName(FileShares.update::parameters.properties, "fileShare");
@@clientName(FileShares.restore::parameters.body, "deletedShare");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(FileShare.properties);

// @@clientName(QueueServicePropertiesOperationGroup, "QueueServiceProperties");
@@clientName(QueueServices.setServiceProperties::parameters.resource,
  "parameters"
);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(QueueServiceProperties.properties);

@@clientName(StorageQueues.create::parameters.resource, "queue");
@@clientName(StorageQueues.update::parameters.properties, "queue");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(StorageQueue.properties);

@@clientName(StorageAccounts.create::parameters.resource, "parameters");
@@clientName(StorageAccounts.update::parameters.properties, "parameters");
@@clientName(StorageAccounts.regenerateKey::parameters.body, "regenerateKey");
@@clientName(StorageAccounts.listAccountSAS::parameters.body, "parameters");
@@clientName(StorageAccounts.listServiceSAS::parameters.body, "parameters");
@@clientName(StorageAccounts.customerInitiatedMigration::parameters.body,
  "parameters"
);
@@clientName(StorageAccounts.restoreBlobRanges::parameters.body, "parameters");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(StorageAccount.properties);

@@clientName(PrivateEndpointConnections.put::parameters.resource, "properties");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(PrivateEndpointConnection.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(DeletedAccount.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(StorageAccountMigration.properties);

@@clientName(ManagementPolicies.createOrUpdate::parameters.resource,
  "properties"
);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(ManagementPolicy.properties);
@@clientName(BlobInventoryPolicies.createOrUpdate, "AAAUpdate", "csharp"); //能更新orepationid， 但就更新不了方法名字。
@@clientName(BlobInventoryPolicies.createOrUpdate::parameters.resource,
  "properties"
);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(BlobInventoryPolicy.properties);

@@clientName(ObjectReplicationPolicyOperationGroup.createOrUpdate::parameters.resource,
  "properties"
);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(ObjectReplicationPolicy.properties);

@@clientName(LocalUserOperationGroup.createOrUpdate::parameters.resource,
  "properties"
);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(LocalUser.properties);

@@clientName(EncryptionScopes.put::parameters.resource, "encryptionScope");
@@clientName(EncryptionScopes.patch::parameters.properties, "encryptionScope");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(EncryptionScope.properties);

// @@clientName(TableServicePropertiesOperationGroup, "TableServiceProperties");
@@clientName(TableServices.setServiceProperties::parameters.resource,
  "parameters"
);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(TableServiceProperties.properties);

@@clientName(Tables.create::parameters.resource, "parameters");
@@clientName(Tables.update::parameters.properties, "parameters");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(Table.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(NetworkSecurityPerimeterConfiguration.properties);

@@clientName(StorageTaskAssignments.create::parameters.resource, "parameters");
@@clientName(StorageTaskAssignments.update::parameters.properties,
  "parameters"
);

@@clientName(StorageAccountsResourceGroup.checkNameAvailability::parameters.body,
  "accountName"
);
@@clientName(CorsRules, "StorageCorsRules", "csharp");
@@clientName(BlobContainers.objectLevelWorm,
  "EnableVersionLevelImmutability",
  "csharp"
);
@@alternateType(BlobContainer.etag, eTag, "csharp");
@@clientName(BlobServiceProperties, "BlobService", "csharp");
@@clientName(ContainerProperties.deleted, "IsDeleted", "csharp");
@@clientName(ContainerProperties.denyEncryptionScopeOverride,
  "PreventEncryptionScopeOverride ",
  "csharp"
);
@@clientName(ContainerProperties.deleted, "IsDeleted", "csharp");
@@clientName(PublicAccess, "StoragePublicAccessType", "csharp");
@@clientName(LeaseStatus, "StorageLeaseStatus", "csharp");
@@clientName(LeaseState, "StorageLeaseState", "csharp");
@@clientName(LeaseDuration, "StorageLeaseDurationType", "csharp");
@@clientName(ImmutabilityPolicyProperties,
  "BlobContainerImmutabilityPolicy",
  "csharp"
);
@@clientName(BlobInventoryPolicyProperties.policy, "PolicySchema", "csharp");
@@clientName(RestorePolicyProperties, "RestorePolicy", "csharp");
@@clientName(ChangeFeed, "BlobServiceChangeFeed ", "csharp");
@@clientName(BlobServicePropertiesProperties.automaticSnapshotPolicyEnabled,
  "IsAutomaticSnapshotPolicyEnabled ",
  "csharp"
);
@@clientName(DeletedAccountProperties.deletionTime, "DeletedOn", "csharp");
@@clientName(DeletedAccountProperties.creationTime, "CreatedOn", "csharp");
@@alternateType(DeletedAccountProperties.storageAccountResourceId,
  armResourceIdentifier,
  "csharp"
);
@@alternateType(DeletedAccountProperties.location, azureLocation, "csharp");
@@alternateType(DeletedAccountProperties.creationTime,
  offsetDateTime,
  "csharp"
);
@@alternateType(DeletedAccountProperties.deletionTime,
  offsetDateTime,
  "csharp"
);
@@clientName(CorsRules, "StorageCorsRules ", "csharp");
@@clientName(CorsRule, "StorageCorsRule", "csharp");
@@clientName(CustomDomain, "StorageCustomDomain", "csharp");
@@clientName(ListEncryptionScopesInclude,
  "EncryptionScopesIncludeType",
  "csharp"
);
@@clientName(BlobInventoryPolicyFilter.prefixMatch, "IncludePrefix", "csharp");
@@clientName(BlobInventoryPolicyRule.enabled, "IsEnabled", "csharp");
@@clientName(BlobInventoryPolicySchema.enabled, "IsEnabled", "csharp");
@@clientName(InventoryRuleType, "BlobInventoryRuleType", "csharp");
@@clientName(BlobInventoryPolicySchema.type, "RuleType", "csharp");
@@clientName(BlobRestoreParameters.timeToRestore, "timeToRestore", "csharp");
@@clientName(ChangeFeed.enabled, "IsEnabled", "csharp");
@@clientName(DefaultSharePermission.StorageFileDataSmbShareReader,
  "Reader",
  "csharp"
);
@@clientName(DefaultSharePermission.StorageFileDataSmbShareContributor,
  "Contributor",
  "csharp"
);
@@clientName(DefaultSharePermission.StorageFileDataSmbShareElevatedContributor,
  "ElevatedContributor",
  "csharp"
);
@@clientName(DeleteRetentionPolicy.enabled, "IsEnabled", "csharp");
@@clientName(DirectoryServiceOptions.AADDS, "Aadds", "csharp");
@@clientName(DirectoryServiceOptions.AADKERB, "Aadkerb", "csharp");
@@alternateType(EncryptionScopeKeyVaultProperties.keyUri, url, "csharp");
@@clientName(TriggerParameters.intervalUnit, "ExecutionIntervalUnit", "csharp");
@@clientName(TriggerParameters, "ExecutionTriggerParameters", "csharp");
@@clientName(TriggerType, "ExecutionTriggerType ", "csharp");
@@clientName(ExecutionTrigger.type, "triggerType", "csharp");
@@clientName(TriggerParametersUpdate,
  "ExecutionTriggerParametersUpdate ",
  "csharp"
);
@@clientName(TagProperty, "LegalHoldTag", "csharp");
@@clientName(AccountImmutabilityPolicyProperties,
  "AccountImmutabilityPolicy",
  "csharp"
);
@@clientName(ImmutableStorageAccount.enabled, "IsEnabled", "csharp");
@@clientName(ImmutableStorageWithVersioning.enabled, "IsEnabled", "csharp");
@@clientName(MigrationState,
  "ImmutableStorageWithVersioningMigrationState",
  "csharp"
);
@@clientName(LastAccessTimeTrackingPolicy.enable, "IsEnabled", "csharp");
@@clientName(LastAccessTimeTrackingPolicy.name,
  "LastAccessTimeTrackingPolicyName",
  "csharp"
);
@@clientName(Name, "LastAccessTimeTrackingPolicyName", "csharp");
@@clientName(LastAccessTimeTrackingPolicy.name, "name", "csharp");
@@clientName(LeaseContainerRequestAction, "LeaseContainerAction", "csharp");
@@alternateType(TagProperty.tenantId, uuid, "csharp");
@@alternateType(ListTableResource.nextLink, string, "csharp");
@@clientName(ListTableServices.value, "TableServiceData", "csharp");
@@alternateType(LocalUsers.nextLink, string, "csharp");
@@clientName(LocalUser, "StorageAccountLocalUser", "csharp");
@@clientName(TagFilter, "ManagementPolicyTagFilter", "csharp");
@@clientName(RuleType, "ManagementPolicyRuleType", "csharp");
@@clientName(ManagementPolicyRule.type, "ruleType", "csharp");
@@clientName(ManagementPolicyRule.enabled, "IsEnabled", "csharp");
@@clientName(TableSignedIdentifier, "StorageTableSignedIdentifier", "csharp");
@@clientName(TableServiceProperties, "TableService", "csharp");
@@alternateType(PrivateLinkResourceProperties.groupId,
  armResourceIdentifier,
  "csharp"
);
@@clientName(CustomDomain.useSubDomainName,
  "IsUseSubDomainNameEnabled",
  "csharp"
);
@@clientName(AllowedMethods, "CorsRuleAllowedMethod", "csharp");
@@clientName(SkuConversionStatus, "StorageAccountSkuConversionState", "csharp");
@@alternateType(StorageAccountSkuConversionStatus.startTime,
  offsetDateTime,
  "csharp"
);
@@alternateType(StorageAccountSkuConversionStatus.endTime,
  offsetDateTime,
  "csharp"
);
@@clientName(StorageAccountPropertiesUpdateParameters.enableExtendedGroups,
  "IsExtendedGroupEnabled",
  "csharp"
);
@@clientName(StorageAccountPropertiesUpdateParameters.defaultToOAuthAuthentication,
  "IsDefaultToOAuthAuthentication",
  "csharp"
);
@@clientName(Encryption, "StorageAccountEncryption", "csharp");
@@clientName(SasPolicy, "StorageAccountSasPolicy", "csharp");
@@clientName(AccessTier, "StorageAccountAccessTier", "csharp");
@@clientName(NetworkRuleSet, "StorageAccountNetworkRuleSet", "csharp");
@@clientName(KeyPolicy, "StorageAccountKeyPolicy", "csharp");
@@clientName(AzureFilesIdentityBasedAuthentication,
  "FilesIdentityBasedAuthentication",
  "csharp"
);
@@clientName(MinimumTlsVersion, "StorageMinimumTlsVersion", "csharp");
@@clientName(PublicNetworkAccess, "StoragePublicNetworkAccess", "csharp");
@@clientName(DnsEndpointType, "StorageDnsEndpointType", "csharp");
@@clientName(RoutingPreference, "StorageRoutingPreference", "csharp");
@@clientName(ListContainersInclude, "BlobContainerState", "csharp");
@@clientName(ManagementPolicy, "StorageAccountManagementPolicy", "csharp");
@@clientName(FileShareProperties.enabledProtocols, "enabledProtocol", "csharp");
@@clientName(FileShareProperties.deleted, "IsDeleted", "csharp");
@@alternateType(FileShare.etag, eTag, "csharp");
@@alternateType(ImmutabilityPolicy.etag, eTag, "csharp");
@@clientName(SignedIdentifier, "StorageSignedIdentifier", "csharp");
@@clientName(EnabledProtocols, "FileShareEnabledProtocol", "csharp");
@@clientName(ShareAccessTier, "FileShareAccessTier", "csharp");
@@clientName(SignedResource, "ServiceSasSignedResourceType", "csharp");
@@clientName(Permissions, "StorageAccountSasPermission", "csharp");
@@clientName(HttpProtocol, "StorageAccountHttpProtocol", "csharp");
@@clientName(Multichannel.enabled, "IsMultiChannelEnabled", "csharp");
@@clientName(StorageAccountProperties.enableExtendedGroups,
  "IsExtendedGroupEnabled",
  "csharp"
);
@@clientName(StorageAccountPropertiesUpdateParameters.enableExtendedGroups,
  "IsExtendedGroupEnabled",
  "csharp"
);
@@clientName(StorageAccountPropertiesCreateParameters.enableExtendedGroups,
  "IsExtendedGroupEnabled",
  "csharp"
);

@@clientName(StorageAccountProperties.enableNfsV3, "IsNfsV3Enabled", "csharp");
@@clientName(StorageAccountPropertiesCreateParameters.enableNfsV3,
  "IsNfsV3Enabled",
  "csharp"
);

@@clientName(StorageAccountProperties.defaultToOAuthAuthentication,
  "IsDefaultToOAuthAuthentication",
  "csharp"
);
@@clientName(StorageAccountPropertiesCreateParameters.defaultToOAuthAuthentication,
  "IsDefaultToOAuthAuthentication",
  "csharp"
);
@@clientName(StorageAccountPropertiesUpdateParameters.defaultToOAuthAuthentication,
  "IsDefaultToOAuthAuthentication",
  "csharp"
);
@@alternateType(StorageAccountCreateParameters.location,
  azureLocation,
  "csharp"
);
@@clientName(EncryptionServices, "StorageAccountEncryptionServices", "csharp");
@@clientName(KeySource, "StorageAccountKeySource", "csharp");
@@clientName(KeyVaultProperties, "StorageAccountKeyVaultProperties", "csharp");
@@clientName(EncryptionIdentity, "StorageAccountEncryptionIdentity", "csharp");
@@clientName(EncryptionService, "StorageEncryptionService", "csharp");

@@alternateType(StorageAccountInternetEndpoints.blob, url, "csharp");
@@alternateType(StorageAccountInternetEndpoints.file, url, "csharp");
@@alternateType(StorageAccountInternetEndpoints.web, url, "csharp");
@@alternateType(StorageAccountInternetEndpoints.dfs, url, "csharp");
@@clientName(StorageAccountInternetEndpoints.blob, "blobUri", "csharp");
@@clientName(StorageAccountInternetEndpoints.web, "webUri", "csharp");
@@clientName(StorageAccountInternetEndpoints.dfs, "dfsUri", "csharp");
@@clientName(StorageAccountInternetEndpoints.file, "fileUri", "csharp");
@@clientName(KeyPermission, "StorageAccountKeyPermission", "csharp");
@@alternateType(KeyVaultProperties.keyVaultUri, url, "csharp");

@@alternateType(StorageAccountMicrosoftEndpoints.blob, url, "csharp");
@@alternateType(StorageAccountMicrosoftEndpoints.queue, url, "csharp");
@@alternateType(StorageAccountMicrosoftEndpoints.table, url, "csharp");
@@alternateType(StorageAccountMicrosoftEndpoints.file, url, "csharp");
@@alternateType(StorageAccountMicrosoftEndpoints.web, url, "csharp");
@@alternateType(StorageAccountMicrosoftEndpoints.dfs, url, "csharp");

@@clientName(StorageAccountMicrosoftEndpoints.blob, "BlobUri", "csharp");
@@clientName(StorageAccountMicrosoftEndpoints.queue, "QueueUri", "csharp");
@@clientName(StorageAccountMicrosoftEndpoints.table, "TableUri", "csharp");
@@clientName(StorageAccountMicrosoftEndpoints.file, "FileUri", "csharp");
@@clientName(StorageAccountMicrosoftEndpoints.web, "WebUri", "csharp");
@@clientName(StorageAccountMicrosoftEndpoints.dfs, "DfsUri", "csharp");

@@clientName(EncryptionService.enabled, "IsEnabled", "csharp");
@@clientName(KeyType, "StorageEncryptionKeyType", "csharp");
@@clientName(PrivateEndpointConnectionProperties.privateLinkServiceConnectionState,
  "ConnectionState",
  "csharp"
);
@@clientName(MigrationName, "StorageAccountMigrationName", "csharp");
@@clientName(MigrationStatus, "StorageAccountMigrationStatus", "csharp");
@@clientName(LocalUserProperties.allowAclAuthorization,
  "IsAclAuthorizationAllowed",
  "csharp"
);

@@clientName(LocalUserProperties.isNFSv3Enabled, "IsNfsV3Enabled", "csharp");
@@clientName(SshPublicKey, "StorageSshPublicKey", "csharp");
@@clientName(PermissionScope, "StoragePermissionScope", "csharp");
@@clientName(StorageAccountProperties.failoverInProgress,
  "IsFailoverInProgress",
  "csharp"
);
@@clientName(AccountSasParameters.sharedAccessExpiryTime,
  "SharedAccessExpireOn",
  "csharp"
);
@@clientName(Services, "StorageAccountSasSignedService", "csharp");
@@clientName(SignedResourceTypes,
  "StorageAccountSasSignedResourceType",
  "csharp"
);
@@clientName(UpdateHistoryProperty, "UpdateHistoryEntry", "csharp");
@@clientName(Format, "BlobInventoryPolicyFormat", "csharp");
@@clientName(Schedule, "BlobInventoryPolicySchedule", "csharp");
@@clientName(ObjectType, "BlobInventoryPolicyObjectType", "csharp");
@@clientName(BlobRestoreParameters.timeToRestore, "timetoRestore", "csharp"); //不管用
@@clientName(AccountLimits, "FileServiceAccountLimits", "csharp");
@@clientName(AccountUsage, "FileServiceAccountUsage", "csharp");
@@clientName(ActiveDirectoryProperties,
  "StorageActiveDirectoryProperties",
  "csharp"
);
@@clientName(QueueServiceProperties, "QueueService", "csharp");

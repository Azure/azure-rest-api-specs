import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Azure.ClientGenerator.Core.Legacy;
using Microsoft.Storage;

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(ListContainerItem.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(ImmutabilityPolicyProperties.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(FileShareItem.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(ListQueue.properties);
@@clientName(ListQueue.properties, "QueueProperties");

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(Operation.properties);
@@clientName(Operation.properties, "operationProperties");

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(StorageAccountCreateParameters.properties);
@@clientName(StorageAccountPropertiesCreateParameters.isSftpEnabled,
  "IsSftpEnabled"
);
@@clientName(StorageAccountPropertiesCreateParameters.isLocalUserEnabled,
  "IsLocalUserEnabled"
);
@@clientName(StorageAccountPropertiesCreateParameters.isHnsEnabled,
  "IsHnsEnabled"
);

@@clientName(Encryption.keyvaultproperties, "KeyVaultProperties");
@@clientName(Encryption.identity, "EncryptionIdentity");
@@clientName(Encryption.requireInfrastructureEncryption,
  "RequireInfrastructureEncryption"
);

@@clientName(KeyVaultProperties.keyname, "KeyName");
@@clientName(KeyVaultProperties.keyversion, "KeyVersion");
@@clientName(KeyVaultProperties.keyvaulturi, "KeyVaultUri");
@@clientName(KeyVaultProperties.currentVersionedKeyIdentifier,
  "CurrentVersionedKeyIdentifier"
);
@@clientName(KeyVaultProperties.lastKeyRotationTimestamp,
  "LastKeyRotationTimestamp"
);
@@clientName(KeyVaultProperties.currentVersionedKeyExpirationTimestamp,
  "CurrentVersionedKeyExpirationTimestamp"
);

@@clientName(EncryptionIdentity.userAssignedIdentity,
  "EncryptionUserAssignedIdentity"
);
@@clientName(EncryptionIdentity.federatedIdentityClientId,
  "EncryptionFederatedIdentityClientId"
);

@@clientName(VirtualNetworkRule.id, "VirtualNetworkResourceId");

@@clientName(IPRule.value, "IPAddressOrRange", "!java, !javascript");

@@clientName(NetworkRuleSet.bypass, "Bypass");

@@clientName(StorageAccountProperties.supportsHttpsTrafficOnly,
  "EnableHttpsTrafficOnly"
);
@@clientName(StorageAccountProperties.networkAcls, "NetworkRuleSet");
@@clientName(StorageAccountProperties.isSftpEnabled, "IsSftpEnabled");
@@clientName(StorageAccountProperties.isLocalUserEnabled, "IsLocalUserEnabled");
@@clientName(StorageAccountProperties.isHnsEnabled, "IsHnsEnabled");
@@clientName(StorageAccountProperties.isNfsV3Enabled, "EnableNfsV3");
@@clientName(StorageAccountProperties.isSkuConversionBlocked,
  "IsSkuConversionBlocked"
);
@@clientName(StorageAccountProperties.enableExtendedGroups,
  "EnableExtendedGroups"
);
@@clientName(StorageAccountProperties.geoReplicationStats,
  "GeoReplicationStats"
);
@@clientName(StorageAccountProperties.failoverInProgress, "FailoverInProgress");
@@clientName(StorageAccountProperties.routingPreference, "RoutingPreference");
@@clientName(StorageAccountProperties.blobRestoreStatus, "BlobRestoreStatus");
@@clientName(StorageAccountProperties.allowBlobPublicAccess,
  "AllowBlobPublicAccess"
);
@@clientName(StorageAccountProperties.immutableStorageWithVersioning,
  "ImmutableStorageWithVersioning"
);
@@clientName(StorageAccountProperties.storageAccountSkuConversionStatus,
  "StorageAccountSkuConversionStatus"
);
@@clientName(StorageAccountProperties.accountMigrationInProgress,
  "AccountMigrationInProgress"
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(StorageAccountUpdateParameters.properties);

@@clientName(StorageAccountPropertiesUpdateParameters.supportsHttpsTrafficOnly,
  "EnableHttpsTrafficOnly"
);
@@clientName(StorageAccountPropertiesUpdateParameters.isSftpEnabled,
  "IsSftpEnabled"
);
@@clientName(StorageAccountPropertiesUpdateParameters.isLocalUserEnabled,
  "IsLocalUserEnabled"
);
@@clientName(StorageAccountPropertiesUpdateParameters.networkAcls,
  "NetworkRuleSet"
);
@@clientName(StorageAccountPropertiesUpdateParameters.enableExtendedGroups,
  "EnableExtendedGroups"
);
@@clientName(StorageAccountPropertiesUpdateParameters.routingPreference,
  "RoutingPreference"
);
@@clientName(StorageAccountPropertiesUpdateParameters.allowBlobPublicAccess,
  "AllowBlobPublicAccess"
);
@@clientName(StorageAccountPropertiesUpdateParameters.immutableStorageWithVersioning,
  "ImmutableStorageWithVersioning"
);

@@clientName(AccountSasParameters.signedServices, "Services");
@@clientName(AccountSasParameters.signedResourceTypes, "ResourceTypes");
@@clientName(AccountSasParameters.signedPermission, "Permissions");
@@clientName(AccountSasParameters.signedIp,
  "IPAddressOrRange",
  "!java, !javascript"
);
@@clientName(AccountSasParameters.signedProtocol, "Protocols");
@@clientName(AccountSasParameters.signedStart, "SharedAccessStartTime");
@@clientName(AccountSasParameters.signedExpiry, "SharedAccessExpiryTime");

@@clientName(ServiceSasParameters.signedResource, "Resource");
@@clientName(ServiceSasParameters.signedPermission, "Permissions");
@@clientName(ServiceSasParameters.signedIp,
  "IPAddressOrRange",
  "!java, !javascript"
);
@@clientName(ServiceSasParameters.signedProtocol, "Protocols");
@@clientName(ServiceSasParameters.signedStart, "SharedAccessStartTime");
@@clientName(ServiceSasParameters.signedExpiry, "SharedAccessExpiryTime");
@@clientName(ServiceSasParameters.signedIdentifier, "Identifier");
@@clientName(ServiceSasParameters.startPk, "PartitionKeyStart");
@@clientName(ServiceSasParameters.endPk, "PartitionKeyEnd");
@@clientName(ServiceSasParameters.startRk, "RowKeyStart");
@@clientName(ServiceSasParameters.endRk, "RowKeyEnd");
@@clientName(ServiceSasParameters.rscc, "CacheControl");
@@clientName(ServiceSasParameters.rscd, "ContentDisposition");
@@clientName(ServiceSasParameters.rsce, "ContentEncoding");
@@clientName(ServiceSasParameters.rscl, "ContentLanguage");
@@clientName(ServiceSasParameters.rsct, "ContentType");

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(PrivateLinkResource.properties);

@@clientName(BlobServices.setServiceProperties::parameters.resource,
  "parameters"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(BlobServiceProperties.properties);
@@clientName(BlobServiceProperties.properties, "BlobServiceProperties");

@@clientName(BlobContainers.create::parameters.resource, "blobContainer");
@@clientName(BlobContainers.update::parameters.properties, "blobContainer");
@@clientName(BlobContainers.setLegalHold::parameters.body, "LegalHold");
@@clientName(BlobContainers.clearLegalHold::parameters.body, "LegalHold");

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(BlobContainer.properties);
@@clientName(BlobContainer.properties, "ContainerProperties");

@@clientName(ContainerProperties.immutabilityPolicy, "ImmutabilityPolicy");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(ImmutabilityPolicy.properties);

@@clientName(FileServices.setServiceProperties::parameters.resource,
  "parameters"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(FileServiceProperties.properties);
@@clientName(FileServiceProperties.properties, "FileServiceProperties");

@@clientName(FileShares.create::parameters.resource, "fileShare");
@@clientName(FileShares.update::parameters.properties, "fileShare");
@@clientName(FileShares.restore::parameters.body, "deletedShare");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(FileShare.properties);
@@clientName(FileShare.properties, "FileShareProperties");

@@clientName(QueueServices.setServiceProperties::parameters.resource,
  "parameters"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(QueueServiceProperties.properties);
@@clientName(QueueServiceProperties.properties, "QueueServiceProperties");

@@clientName(StorageQueues.create::parameters.resource, "queue");
@@clientName(StorageQueues.update::parameters.properties, "queue");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(StorageQueue.properties);
@@clientName(StorageQueue.properties, "QueueProperties");

@@clientName(StorageAccounts.create::parameters.resource, "parameters");
@@clientName(StorageAccounts.update::parameters.properties, "parameters");
@@clientName(StorageAccounts.regenerateKey::parameters.body, "regenerateKey");
@@clientName(StorageAccounts.listAccountSAS::parameters.body, "parameters");
@@clientName(StorageAccounts.listServiceSAS::parameters.body, "parameters");
@@clientName(StorageAccounts.customerInitiatedMigration::parameters.body,
  "parameters"
);
@@clientName(StorageAccounts.restoreBlobRanges::parameters.body, "parameters");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(StorageAccount.properties);

@@clientName(PrivateEndpointConnections.put::parameters.resource, "properties");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(PrivateEndpointConnection.properties);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(DeletedAccount.properties);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(StorageAccountMigration.properties);
@@clientName(StorageAccountMigration.properties,
  "StorageAccountMigrationDetails"
);

@@clientName(ManagementPolicies.createOrUpdate::parameters.resource,
  "properties"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(ManagementPolicy.properties);

@@clientName(BlobInventoryPolicies.createOrUpdate::parameters.resource,
  "properties"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(BlobInventoryPolicy.properties);

@@clientName(ObjectReplicationPolicyOperationGroup.createOrUpdate::parameters.resource,
  "properties"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(ObjectReplicationPolicy.properties);

@@clientName(LocalUserOperationGroup.createOrUpdate::parameters.resource,
  "properties"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(LocalUser.properties);

@@clientName(EncryptionScopes.put::parameters.resource, "encryptionScope");
@@clientName(EncryptionScopes.patch::parameters.properties, "encryptionScope");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(EncryptionScope.properties);
@@clientName(EncryptionScope.properties, "EncryptionScopeProperties");

@@clientName(TableServices.setServiceProperties::parameters.resource,
  "parameters"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(TableServiceProperties.properties);
@@clientName(TableServiceProperties.properties, "TableServiceProperties");

@@clientName(Tables.create::parameters.resource, "parameters");
@@clientName(Tables.update::parameters.properties, "parameters");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(Table.properties);
@@clientName(Table.properties, "TableProperties");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(NetworkSecurityPerimeterConfiguration.properties);

@@clientName(StorageTaskAssignments.create::parameters.resource, "parameters");
@@clientName(StorageTaskAssignments.update::parameters.properties,
  "parameters"
);
@@visibility(FileShareItems.value, Lifecycle.Read);
@@visibility(ListContainerItems.value, Lifecycle.Read);
@@visibility(ListQueueResource.value, Lifecycle.Read);
@@visibility(ListTableResource.value, Lifecycle.Read);
@@visibility(NetworkSecurityPerimeterConfigurationList.value, Lifecycle.Read);
@@visibility(FileServiceUsages.value, Lifecycle.Read);
@@visibility(StorageTaskReportSummary.value, Lifecycle.Read);

@@clientName(StorageAccounts.checkNameAvailability::parameters.body,
  "accountName"
);
@@clientName(ImmutabilityPolicies.createOrUpdateImmutabilityPolicy::parameters.resource,
  "parameters"
);
@@clientName(StorageAccountPropertiesCreateParameters.enableExtendedGroups,
  "EnableExtendedGroups"
);
@@clientName(StorageAccountPropertiesCreateParameters.routingPreference,
  "RoutingPreference"
);
@@clientName(StorageAccountPropertiesCreateParameters.allowBlobPublicAccess,
  "AllowBlobPublicAccess"
);
@@clientName(StorageAccountPropertiesCreateParameters.immutableStorageWithVersioning,
  "ImmutableStorageWithVersioning"
);
@@clientName(StorageAccountPropertiesCreateParameters.networkAcls,
  "NetworkRuleSet"
);
@@clientName(StorageAccountPropertiesCreateParameters.supportsHttpsTrafficOnly,
  "EnableHttpsTrafficOnly"
);
@@clientName(StorageAccountPropertiesCreateParameters.isNfsV3Enabled,
  "EnableNfsV3"
);
@@visibility(StorageTaskAssignmentsList.value, Lifecycle.Read);

@@clientLocation(BlobServices.blobContainersList, BlobContainers);
@@clientName(BlobServices.blobContainersList, "List");
@@clientName(BlobContainers.lease::parameters.body, "parameters");
@@clientLocation(ImmutabilityPolicies.getImmutabilityPolicy, BlobContainers);
@@clientLocation(ImmutabilityPolicies.createOrUpdateImmutabilityPolicy,
  BlobContainers
);
@@clientName(ImmutabilityPolicies.createOrUpdateImmutabilityPolicy::parameters.resource,
  "parameters"
);
@@clientLocation(ImmutabilityPolicies.deleteImmutabilityPolicy, BlobContainers);
@@clientLocation(ImmutabilityPolicies.lockImmutabilityPolicy, BlobContainers);
@@clientLocation(ImmutabilityPolicies.extendImmutabilityPolicy, BlobContainers);
@@clientName(ImmutabilityPolicies.extendImmutabilityPolicy::parameters.body,
  "parameters"
);
@@clientLocation(FileServices.fileSharesList, FileShares);
@@clientName(FileServices.fileSharesList, "List");
@@clientLocation(FileServiceUsageOperationGroup.getServiceUsage, FileServices);
@@clientLocation(FileServiceUsageOperationGroup.listServiceUsages,
  FileServices
);
@@clientName(FileShares.lease::parameters.body, "parameters");
@@clientLocation(QueueServices.queueList, "Queue");
@@clientName(QueueServices.queueList, "List");
@@clientLocation(StorageQueues.get, "Queue");
@@clientLocation(StorageQueues.create, "Queue");
@@clientLocation(StorageQueues.update, "Queue");
@@clientLocation(StorageQueues.delete, "Queue");
@@clientLocation(StorageAccounts.listByStorageAccount, "PrivateLinkResources");
@@clientLocation(StorageAccounts.storageTaskAssignmentsInstancesReportList,
  "StorageTaskAssignmentsInstancesReport"
);
@@clientName(StorageAccounts.storageTaskAssignmentsInstancesReportList, "List");
@@clientLocation(StorageAccountMigrations.getCustomerInitiatedMigration,
  StorageAccounts
);
@@clientLocation(ObjectReplicationPolicyOperationGroup.get,
  "ObjectReplicationPolicies"
);
@@clientLocation(ObjectReplicationPolicyOperationGroup.createOrUpdate,
  "ObjectReplicationPolicies"
);
@@clientLocation(ObjectReplicationPolicyOperationGroup.delete,
  "ObjectReplicationPolicies"
);
@@clientLocation(ObjectReplicationPolicyOperationGroup.list,
  "ObjectReplicationPolicies"
);
@@clientLocation(LocalUserOperationGroup.get, "LocalUsers");
@@clientLocation(LocalUserOperationGroup.createOrUpdate, "LocalUsers");
@@clientLocation(LocalUserOperationGroup.delete, "LocalUsers");
@@clientLocation(LocalUserOperationGroup.list, "LocalUsers");
@@clientLocation(LocalUserOperationGroup.listKeys, "LocalUsers");
@@clientLocation(LocalUserOperationGroup.regeneratePassword, "LocalUsers");
@@clientLocation(Tables.get, "Table");
@@clientLocation(Tables.create, "Table");
@@clientLocation(Tables.update, "Table");
@@clientLocation(Tables.delete, "Table");
@@clientLocation(Tables.list, "Table");
@@clientLocation(StorageTaskAssignments.storageTaskAssignmentInstancesReportList,
  "StorageTaskAssignmentInstancesReport"
);
@@clientName(StorageTaskAssignments.storageTaskAssignmentInstancesReportList,
  "List"
);
@@clientLocation(SkusOperationGroup.list, "Skus");
@@clientLocation(DeletedAccountsOperationGroup.list, DeletedAccounts);
@@clientLocation(UsagesOperationGroup.listByLocation, "Usages");

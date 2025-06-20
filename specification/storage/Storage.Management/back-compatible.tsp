import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.Storage;

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(ListContainerItem.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(ImmutabilityPolicyProperties.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(FileShareItem.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(ListQueue.properties);
@@clientName(ListQueue.properties, "QueueProperties");

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(Operation.properties);
@@clientName(Operation.properties, "operationProperties");

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(StorageAccountCreateParameters.properties);

@@clientName(StorageAccountPropertiesCreateParameters.networkAcls,
  "networkRuleSet"
);
@@clientName(StorageAccountPropertiesCreateParameters.supportsHttpsTrafficOnly,
  "enableHttpsTrafficOnly"
);
@@clientName(StorageAccountPropertiesCreateParameters.isSftpEnabled,
  "IsSftpEnabled"
);
@@clientName(StorageAccountPropertiesCreateParameters.isLocalUserEnabled,
  "IsLocalUserEnabled"
);
@@clientName(StorageAccountPropertiesCreateParameters.isHnsEnabled,
  "IsHnsEnabled"
);
@@clientName(StorageAccountPropertiesCreateParameters.isNfsV3Enabled,
  "enableNfsV3"
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

@@clientName(IPRule.value, "IPAddressOrRange");

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

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
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
@@clientName(AccountSasParameters.signedIp, "IPAddressOrRange");
@@clientName(AccountSasParameters.signedProtocol, "Protocols");
@@clientName(AccountSasParameters.signedStart, "SharedAccessStartTime");
@@clientName(AccountSasParameters.signedExpiry, "SharedAccessExpiryTime");

@@clientName(ServiceSasParameters.signedResource, "Resource");
@@clientName(ServiceSasParameters.signedPermission, "Permissions");
@@clientName(ServiceSasParameters.signedIp, "IPAddressOrRange");
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

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(PrivateLinkResource.properties);

@@clientName(BlobServices.setServiceProperties::parameters.resource,
  "parameters"
);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(BlobServiceProperties.properties);
@@clientName(BlobServiceProperties.properties, "BlobServiceProperties");

@@clientName(BlobContainers.create::parameters.resource, "blobContainer");
@@clientName(BlobContainers.update::parameters.properties, "blobContainer");
@@clientName(BlobContainers.setLegalHold::parameters.body, "LegalHold");
@@clientName(BlobContainers.clearLegalHold::parameters.body, "LegalHold");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(BlobContainer.properties);
@@clientName(BlobContainer.properties, "ContainerProperties");

@@clientName(ContainerProperties.immutabilityPolicy, "ImmutabilityPolicy");

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(ImmutabilityPolicy.properties);

@@clientName(FileServices.setServiceProperties::parameters.resource,
  "parameters"
);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(FileServiceProperties.properties);
@@clientName(FileServiceProperties.properties, "FileServiceProperties");

@@clientName(FileShares.create::parameters.resource, "fileShare");
@@clientName(FileShares.update::parameters.properties, "fileShare");
@@clientName(FileShares.restore::parameters.body, "deletedShare");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(FileShare.properties);
@@clientName(FileShare.properties, "FileShareProperties");

@@clientName(QueueServices.setServiceProperties::parameters.resource,
  "parameters"
);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(QueueServiceProperties.properties);
@@clientName(QueueServiceProperties.properties, "QueueServiceProperties");

@@clientName(StorageQueues.create::parameters.resource, "queue");
@@clientName(StorageQueues.update::parameters.properties, "queue");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
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
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(StorageAccount.properties);

@@clientName(PrivateEndpointConnections.put::parameters.resource, "properties");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(PrivateEndpointConnection.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(DeletedAccount.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(StorageAccountMigration.properties);
@@clientName(StorageAccountMigration.properties,
  "StorageAccountMigrationDetails"
);

@@clientName(ManagementPolicies.createOrUpdate::parameters.resource,
  "properties"
);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(ManagementPolicy.properties);

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
@@clientName(EncryptionScope.properties, "EncryptionScopeProperties");

@@clientName(TableServices.setServiceProperties::parameters.resource,
  "parameters"
);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(TableServiceProperties.properties);
@@clientName(TableServiceProperties.properties, "TableServiceProperties");

@@clientName(Tables.create::parameters.resource, "parameters");
@@clientName(Tables.update::parameters.properties, "parameters");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(Table.properties);
@@clientName(Table.properties, "TableProperties");

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
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

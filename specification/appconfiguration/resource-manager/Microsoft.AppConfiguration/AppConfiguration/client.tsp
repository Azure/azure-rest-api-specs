import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Microsoft.AppConfiguration;
using Azure.ClientGenerator.Core;

// Fix the property name change in KeyValue model - eTag should remain as etag
@@clientName(
  Microsoft.AppConfiguration.KeyValueProperties.eTag,
  "etag",
  "java"
);

@@clientName(
  Microsoft.AppConfiguration,
  "AppConfigurationManagementClient",
  "javascript,python"
);

// Rename mappings for C#
@@clientName(ApiKey.lastModified, "LastModifiedOn", "csharp");
@@clientName(ApiKey.readOnly, "IsReadOnly", "csharp");
@@clientName(ApiKey, "AppConfigurationStoreApiKey", "csharp");
@@clientName(
  ApiKeyListResult,
  "AppConfigurationStoreApiKeyListResult",
  "csharp"
);
@@clientName(ActionsRequired, "AppConfigurationActionsRequired", "csharp");
@@clientName(AuthenticationMode, "DataPlaneProxyAuthenticationMode", "csharp");
@@clientName(CompositionType, "SnapshotCompositionType", "csharp");
@@clientName(
  DeletedConfigurationStoreProperties.purgeProtectionEnabled,
  "IsPurgeProtectionEnabled",
  "csharp"
);
@@clientName(NameAvailabilityStatus.nameAvailable, "IsNameAvailable", "csharp");
@@clientName(KeyValue, "AppConfigurationKeyValue", "csharp");
@@clientName(KeyValueProperties.lastModified, "LastModifiedOn", "csharp");
@@clientName(KeyValueProperties.locked, "IsLocked", "csharp");
@@clientName(KeyValueFilter, "SnapshotKeyValueFilter", "csharp");
@@clientName(
  KeyVaultProperties,
  "AppConfigurationKeyVaultProperties",
  "csharp"
);
@@clientName(
  CheckNameAvailabilityParameters,
  "AppConfigurationNameAvailabilityContent",
  "csharp"
);
@@clientName(CheckNameAvailabilityParameters.type, "ResourceType", "csharp");
@@clientName(CreateMode, "AppConfigurationCreateMode", "csharp");
@@clientName(
  ConfigurationResourceType,
  "AppConfigurationResourceType",
  "csharp"
);
@@clientName(ConfigurationStore, "AppConfigurationStore", "csharp");
@@clientName(
  ConnectionStatus,
  "AppConfigurationPrivateLinkServiceConnectionStatus",
  "csharp"
);
@@clientName(
  DataPlaneProxyProperties,
  "AppConfigurationDataPlaneProxyProperties",
  "csharp"
);
@@clientName(
  DeletedConfigurationStore,
  "DeletedAppConfigurationStore",
  "csharp"
);
@@clientName(
  EncryptionProperties,
  "AppConfigurationStoreEncryptionProperties",
  "csharp"
);
@@clientName(
  NameAvailabilityStatus,
  "AppConfigurationNameAvailabilityResult",
  "csharp"
);
@@clientName(
  PublicNetworkAccess,
  "AppConfigurationPublicNetworkAccess",
  "csharp"
);
@@clientName(
  PrivateLinkResource,
  "AppConfigurationPrivateLinkResource",
  "csharp"
);
@@clientName(PrivateLinkResources, "AppConfigurationPrivateLink", "csharp");
@@clientName(
  PrivateEndpointConnection,
  "AppConfigurationPrivateEndpointConnection",
  "csharp"
);
@@clientName(
  PrivateEndpointConnections,
  "AppConfigurationPrivateEndpointConnection",
  "csharp"
);
@@clientName(
  PrivateEndpointConnectionProperties.privateLinkServiceConnectionState,
  "ConnectionState",
  "csharp"
);
@@clientName(
  PrivateEndpointConnectionReference,
  "AppConfigurationPrivateEndpointConnectionReference",
  "csharp"
);
@@clientName(ProvisioningState, "AppConfigurationProvisioningState", "csharp");
@@clientName(
  PrivateLinkDelegation,
  "DataPlaneProxyPrivateLinkDelegation",
  "csharp"
);
@@clientName(
  RegenerateKeyParameters,
  "AppConfigurationRegenerateKeyContent",
  "csharp"
);
@@clientName(Replica, "AppConfigurationReplica", "csharp");
@@clientName(
  ReplicaProvisioningState,
  "AppConfigurationReplicaProvisioningState",
  "csharp"
);
@@clientName(SnapshotStatus, "AppConfigurationSnapshotStatus", "csharp");
@@clientName(Snapshot, "AppConfigurationSnapshot", "csharp");
@@clientName(SnapshotProperties.created, "CreatedOn", "csharp");
@@clientName(SnapshotProperties.expires, "ExpireOn", "csharp");
@@clientName(
  OperationsOperationGroup.checkNameAvailability,
  "CheckAppConfigurationNameAvailability",
  "csharp"
);
@@clientName(
  ConfigurationStoresOperationGroup.listDeleted,
  "GetDeletedAppConfigurationStores",
  "csharp"
);
@@clientName(
  OperationsOperationGroup.regionalCheckNameAvailability,
  "CheckAppConfigurationRegionalNameAvailability",
  "csharp"
);
@@clientName(
  NetworkSecurityPerimeterConfigurations.get,
  "GetNetworkSecurityPerimeterConfiguration",
  "csharp"
);
@@clientName(
  NetworkSecurityPerimeterConfigurations.listByConfigurationStore,
  "GetNetworkSecurityPerimeterConfigurations",
  "csharp"
);
@@alternateType(
  DeletedConfigurationStoreProperties.configurationStoreId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(
  DeletedConfigurationStoreProperties.location,
  Azure.Core.azureLocation,
  "csharp"
);
@@alternateType(
  ConfigurationStore.identity,
  Azure.ResourceManager.CommonTypes.ManagedServiceIdentity,
  "csharp"
);
@@alternateType(
  ConfigurationStoreUpdateParameters.identity,
  Azure.ResourceManager.CommonTypes.ManagedServiceIdentity,
  "csharp"
);
@@alternateType(Replica.location, Azure.Core.azureLocation, "csharp");
@@alternateType(PrivateEndpoint.id, Azure.Core.armResourceIdentifier, "csharp");
@@alternateType(
  KeyValueProperties.eTag,
  Azure.Core.EtagProperty.etag,
  "csharp"
);
@@alternateType(
  SnapshotProperties.etag,
  Azure.Core.EtagProperty.etag,
  "csharp"
);
@@alternateType(
  Azure.ResourceManager.CommonTypes.NetworkSecurityPerimeter.location,
  Azure.Core.azureLocation,
  "csharp"
);
@@clientName(
  Azure.ResourceManager.CommonTypes.ManagedOnBehalfOfConfiguration,
  "AppConfigurationManagedOnBehalfOfConfiguration",
  "csharp"
);
@@clientName(
  Azure.ResourceManager.CommonTypes.MoboBrokerResource,
  "AppConfigurationMoboBrokerResourceInfo",
  "csharp"
);
@@clientName(
  Azure.ResourceManager.CommonTypes.Severity,
  "AppConfigurationSeverity",
  "csharp"
);
@@clientName(
  Azure.ResourceManager.CommonTypes.IssueType,
  "AppConfigurationIssueType",
  "csharp"
);

// Preserve provisioning metadata from the reflection-based generator.
#suppress "@azure-tools/typespec-client-generator-core/client-option" "RBAC roles for provisioning compatibility"
#suppress "@azure-tools/typespec-client-generator-core/client-option-requires-scope" "RBAC roles for provisioning compatibility"
@@clientOption(
  ConfigurationStore,
  "resource-rbac-roles",
  #{
    AppConfigurationDataOwner: "5ae67dd6-50cb-40e7-96ff-dc2bfa4b606b",
    AppConfigurationDataReader: "516239f1-63e1-4d78-a4de-a74fb236a071",
  },
  "csharp"
);

#suppress "@azure-tools/typespec-client-generator-core/client-option" "Name constraints for provisioning compatibility"
#suppress "@azure-tools/typespec-client-generator-core/client-option-requires-scope" "Name constraints for provisioning compatibility"
@@clientOption(
  ConfigurationStore,
  "resource-name-constraint",
  #{ minLength: 5, maxLength: 50, pattern: "^[a-zA-Z0-9-]+$" },
  "csharp"
);

#suppress "@azure-tools/typespec-client-generator-core/client-option" "Name constraints for provisioning compatibility"
#suppress "@azure-tools/typespec-client-generator-core/client-option-requires-scope" "Name constraints for provisioning compatibility"
@@clientOption(
  Replica,
  "resource-name-constraint",
  #{ minLength: 1, maxLength: 50, pattern: "^[a-zA-Z0-9]+$" },
  "csharp"
);

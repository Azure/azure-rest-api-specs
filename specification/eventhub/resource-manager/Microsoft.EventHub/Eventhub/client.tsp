import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.EventHub;

@@clientName(Microsoft.EventHub,
  "EventHubManagementClient",
  "python,javascript,java"
);

// Fix TLS version naming changes for Go SDK backward compatibility
@@clientName(TlsVersion.`1.0`, "One0", "go");
@@clientName(TlsVersion.`1.1`, "One1", "go");
@@clientName(TlsVersion.`1.2`, "One2", "go");
@@clientName(TlsVersion.`1.3`, "One3", "go");

// Fix field naming changes for Go SDK backward compatibility
@@clientName(RetentionDescription.minCompactionLagTimeInMinutes,
  "MinCompactionLagInMins",
  "go"
);

// csharp configuration
@@clientName(Microsoft.EventHub.EventHubs,
  "EventHubAuthorizationRule",
  "csharp"
);
@@clientName(AuthorizationRules,
  "EventHubsNamespaceAuthorizationRule",
  "csharp"
);
@@clientName(DisasterRecoveryConfigs,
  "EventHubsDisasterRecoveryAuthorizationRule",
  "csharp"
);
@@clientName(PrivateEndpointConnection,
  "EventHubsPrivateEndpointConnection",
  "csharp"
);
@@clientName(Clusters.configurationGet, "GetConfiguration", "csharp");
@@clientName(EHNamespaces.privateLinkResourcesGet,
  "GetPrivateLinkResources",
  "csharp"
);
@@clientName(NetworkRuleSets.getNetworkRuleSet, "GetNetworkRuleSet", "csharp");
@@clientName(NetworkRuleSets.listNetworkRuleSet,
  "ListNetworkRuleSets",
  "csharp"
);
@@clientName(EHNamespaces.failover, "FailOver", "csharp");
@@clientName(EHNamespaces.checkNameAvailability,
  "CheckEventHubsDisasterRecoveryNameAvailability",
  "csharp"
);
@@clientName(NamespacesOperationGroup.checkNameAvailability,
  "CheckEventHubsNamespaceNameAvailability",
  "csharp"
);
@@clientName(ClustersOperationGroup.listAvailableClusterRegion,
  "GetAvailableClusterRegionClusters",
  "csharp"
);
@@clientName(Clusters.patch, "PatchConfiguration", "csharp");
@@clientName(CaptureIdentity.type, "IdentityType", "csharp");
@@clientName(NWRuleSetIpRules.ipMask, "IPMask", "csharp");
@@clientName(PrivateEndpointConnectionProperties.privateLinkServiceConnectionState,
  "ConnectionState",
  "csharp"
);
@@clientName(Encryption.keySource, "KeySource", "csharp");
@@clientName(SchemaType, "EventHubsSchemaType", "csharp");
@@clientName(SchemaCompatibility, "EventHubsSchemaCompatibility", "csharp");
@@clientName(ClusterProperties.createdAt, "CreatedOn", "csharp");
@@alternateType(ClusterProperties.createdAt, utcDateTime, "csharp");
@@clientName(ClusterProperties.updatedAt, "UpdatedOn", "csharp");
@@alternateType(ClusterProperties.updatedAt, utcDateTime, "csharp");
@@alternateType(EHNamespaceProperties.clusterArmId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@clientName(DefaultAction, "EventHubsNetworkRuleSetDefaultAction", "csharp");
@@clientName(PublicNetworkAccessFlag,
  "EventHubsPublicNetworkAccessFlag",
  "csharp"
);
@@clientName(NWRuleSetIpRules, "EventHubsNetworkRuleSetIPRules", "csharp");
@@clientName(NetworkRuleIPAction, "EventHubsNetworkRuleIPAction", "csharp");
@@clientName(NWRuleSetVirtualNetworkRules,
  "EventHubsNetworkRuleSetVirtualNetworkRules",
  "csharp"
);
@@clientName(EndPointProvisioningState,
  "EventHubsPrivateEndpointConnectionProvisioningState",
  "csharp"
);
@@clientName(ConnectionState,
  "EventHubsPrivateLinkServiceConnectionState",
  "csharp"
);
@@clientName(PrivateLinkConnectionStatus,
  "EventHubsPrivateLinkConnectionStatus",
  "csharp"
);
@@clientName(ProvisioningState, "EventHubsClusterProvisioningState", "csharp");
@@clientName(CleanupPolicyRetentionDescription.Compact, "Compaction", "csharp");
@@alternateType(NetworkSecurityPerimeterConfigurationProperties.sourceResourceId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@clientName(ApplicationGroupPolicy,
  "EventHubsApplicationGroupPolicy",
  "csharp"
);
@@clientName(ApplicationGroupPolicy.type,
  "ApplicationGroupPolicyType",
  "csharp"
);
@@clientName(RegenerateAccessKeyParameters,
  "EventHubsRegenerateAccessKeyContent",
  "csharp"
);
@@clientName(KeyType, "EventHubsAccessKeyType", "csharp");
@@clientName(ArmDisasterRecovery, "EventHubsDisasterRecovery", "csharp");
@@clientName(ProvisioningStateDR,
  "EventHubsDisasterRecoveryProvisioningState",
  "csharp"
);
@@clientName(RoleDisasterRecovery, "EventHubsDisasterRecoveryRole", "csharp");
@@clientName(Eventhub, "EventHub", "csharp");
@@clientName(Destination, "EventHubDestination", "csharp");
@@alternateType(DestinationProperties.storageAccountResourceId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@clientName(CheckNameAvailabilityParameter,
  "EventHubsNameAvailabilityContent",
  "csharp"
);
@@clientName(CheckNameAvailabilityResult,
  "EventHubsNameAvailabilityResult",
  "csharp"
);
@@clientName(UnavailableReason, "EventHubsNameUnavailableReason", "csharp");
@@clientName(FailOver, "EventHubsNamespaceFailover", "csharp");
@@clientName(GeoDataReplicationProperties,
  "EventHubsNamespaceGeoDataReplicationProperties",
  "csharp"
);
@@clientName(GeoDRRoleType, "EventHubsNamespaceGeoDRRoleType", "csharp");
@@alternateType(NamespaceReplicaLocation.clusterArmId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@clientName(Mode, "EventHubsConfidentialComputeMode", "csharp");
@@clientName(TimestampType, "EventHubsTimestampType", "csharp");
@@clientName(NamespaceReplicaLocation,
  "EventHubsNamespaceReplicaLocation",
  "csharp"
);
@@clientName(ErrorDetail, "EventHubsErrorDetail", "csharp");
@@clientName(ErrorDetail, "EventHubsErrorDetail", "java");
@@clientName(ErrorAdditionalInfo, "EventHubsErrorAdditionalInfo", "csharp");
@@clientName(ErrorAdditionalInfo, "EventHubsErrorAdditionalInfo", "java");
@@clientName(ErrorResponse, "EventHubsErrorResponse", "csharp");
@@clientName(ErrorResponse, "EventHubsErrorResponse", "java");

// java naming mitigations
@@clientName(NetworkRuleIPAction, "NetworkRuleIpAction", "java");
@@clientName(SchemaGroupProperties.eTag, "etag", "java");
@@clientLocation(NetworkSecurityPerimeterConfigurations.list,
  "NetworkSecurityPerimeterConfigurations",
  "java"
);

@@alternateType(DestinationProperties.dataLakeSubscriptionId,
  Azure.Core.uuid,
  "java"
);

@@clientName(TlsVersion, "EventHubsTlsVersion", "csharp");
@@clientName(TlsVersion.`1.0`, "Tls1_0", "csharp");
@@clientName(TlsVersion.`1.1`, "Tls1_1", "csharp");
@@clientName(TlsVersion.`1.2`, "Tls1_2", "csharp");
@@clientName(TlsVersion.`1.3`, "Tls1_3", "csharp");
@@clientName(PublicNetworkAccess, "EventHubsPublicNetworkAccess", "csharp");
@@clientName(ProvisioningIssueProperties,
  "EventHubsProvisioningIssueProperties",
  "csharp"
);
@@clientName(ProvisioningIssue, "EventHubsProvisioningIssue", "csharp");
@@usage(ProvisioningIssue, Usage.input, "csharp");
@@clientName(MetricId, "EventHubsMetricId", "csharp");
@@clientName(NetworkSecurityPerimeter,
  "EventHubsNetworkSecurityPerimeter",
  "csharp"
);
@@clientName(NetworkSecurityPerimeterConfiguration,
  "EventHubsNetworkSecurityPerimeterConfiguration",
  "csharp"
);
@@clientName(NetworkSecurityPerimeterConfigurationPropertiesProfile,
  "EventHubsNetworkSecurityPerimeterConfigurationPropertiesProfile",
  "csharp"
);
@@clientName(NetworkSecurityPerimeterConfigurationPropertiesResourceAssociation,
  "EventHubsNetworkSecurityPerimeterConfigurationPropertiesResourceAssociation",
  "csharp"
);
@@clientName(NetworkSecurityPerimeterConfigurationProvisioningState,
  "EventHubsNetworkSecurityPerimeterConfigurationProvisioningState",
  "csharp"
);
@@clientName(NspAccessRuleDirection,
  "EventHubsNspAccessRuleDirection",
  "csharp"
);
@@clientName(NspAccessRuleProperties,
  "EventHubsNspAccessRuleProperties",
  "csharp"
);
@@clientName(ResourceAssociationAccessMode,
  "EventHubsResourceAssociationAccessMode",
  "csharp"
);
@@clientName(ClusterSku, "EventHubsClusterSku", "csharp");
@@clientName(ClusterSkuName, "EventHubsClusterSkuName", "csharp");
@@clientName(NetworkRuleSet, "EventHubsNetworkRuleSet", "csharp");
@@clientName(Encryption, "EventHubsEncryption", "csharp");
@@clientName(KeyVaultProperties, "EventHubsKeyVaultProperties", "csharp");
@@clientName(CaptureIdentity, "EventHubsCaptureIdentity", "csharp");
@@clientName(CaptureIdentityType, "EventHubsCaptureIdentityType", "csharp");
@@clientName(ThrottlingPolicy, "EventHubsThrottlingPolicy", "csharp");
@@clientName(ApplicationGroup, "EventHubsApplicationGroup", "csharp");
@@clientName(AuthorizationRule, "EventHubsAuthorizationRule", "csharp");
@@clientName(AccessKeys, "EventHubsAccessKeys", "csharp");
@@clientName(AccessRights, "EventHubsAccessRight", "csharp");
@@clientName(ConsumerGroup, "EventHubsConsumerGroup", "csharp");
@@clientName(SchemaGroup, "EventHubsSchemaGroup", "csharp");
@@clientName(FailOverProperties.force, "IsForced", "csharp");
@@usage(ClusterQuotaConfigurationProperties, Usage.input, "csharp");
@@usage(CheckNameAvailabilityParameter, Usage.input | Usage.output, "csharp");
@@usage(FailOver, Usage.input | Usage.output, "csharp");
@@usage(NspAccessRulePropertiesSubscriptionsItem,
  Usage.input | Usage.output,
  "csharp"
);
// Mark list operations as pageable for C# backward compatibility
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Required for backward compatibility with pageable list operations"
@@Azure.ClientGenerator.Core.Legacy.markAsPageable(Clusters.listNamespaces,
  "csharp"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Required for backward compatibility with pageable list operations"
@@Azure.ClientGenerator.Core.Legacy.markAsPageable(ClustersOperationGroup.listAvailableClusterRegion,
  "csharp"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Required for backward compatibility with pageable list operations"
@@Azure.ClientGenerator.Core.Legacy.markAsPageable(EHNamespaces.privateLinkResourcesGet,
  "csharp"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Required for backward compatibility with pageable list operations"
@@Azure.ClientGenerator.Core.Legacy.markAsPageable(NetworkSecurityPerimeterConfigurations.list,
  "csharp"
);
@@clientLocation(AuthorizationRules.getAuthorizationRule,
  AuthorizationRules,
  "csharp"
);
@@clientLocation(AuthorizationRules.createOrUpdateAuthorizationRule,
  AuthorizationRules,
  "csharp"
);
@@clientLocation(AuthorizationRules.deleteAuthorizationRule,
  AuthorizationRules,
  "csharp"
);
@@clientLocation(AuthorizationRules.listAuthorizationRules,
  AuthorizationRules,
  "csharp"
);
@@clientLocation(AuthorizationRules.listKeys, AuthorizationRules, "csharp");
@@clientLocation(AuthorizationRules.regenerateKeys,
  AuthorizationRules,
  "csharp"
);
@@alternateType(AuthorizationRule.location, Azure.Core.azureLocation, "csharp");
@@alternateType(Cluster.location, Azure.Core.azureLocation, "csharp");
@@alternateType(EHNamespace.location, Azure.Core.azureLocation, "csharp");
@@alternateType(Eventhub.location, Azure.Core.azureLocation, "csharp");
@@alternateType(ConsumerGroup.location, Azure.Core.azureLocation, "csharp");
@@alternateType(ApplicationGroup.location, Azure.Core.azureLocation, "csharp");
@@alternateType(SchemaGroup.location, Azure.Core.azureLocation, "csharp");
@@alternateType(NetworkRuleSet.location, Azure.Core.azureLocation, "csharp");
@@alternateType(PrivateEndpointConnection.location,
  Azure.Core.azureLocation,
  "csharp"
);
@@alternateType(NetworkSecurityPerimeterConfiguration.location,
  Azure.Core.azureLocation,
  "csharp"
);
@@alternateType(AvailableCluster.location, Azure.Core.azureLocation, "csharp");
@@alternateType(NetworkSecurityPerimeter.location,
  Azure.Core.azureLocation,
  "csharp"
);
@@alternateType(ArmDisasterRecovery.location,
  Azure.Core.azureLocation,
  "csharp"
);
@@alternateType(EHNamespace.identity,
  Azure.ResourceManager.CommonTypes.ManagedServiceIdentity,
  "csharp"
);
@@alternateType(KeyVaultProperties.keyVaultUri, url, "csharp");
@@alternateType(DestinationProperties.dataLakeSubscriptionId,
  Azure.Core.uuid,
  "csharp"
);
@@alternateType(SchemaGroupProperties.eTag, Azure.Core.eTag, "csharp");
@@alternateType(FailOverProperties.primaryLocation,
  Azure.Core.azureLocation,
  "csharp"
);
@@alternateType(EHNamespaceIdListResult.value,
  Azure.ResourceManager.Models.SubResource[],
  "csharp"
);
@@clientName(NetworkRuleSetProperties.ipRules, "IPRules", "csharp");
@@clientName(NamespaceReplicaLocation.roleType, "RoleType", "csharp");
@@clientName(NspAccessRulePropertiesSubscriptionsItem,
  "EventHubsNspAccessRulePropertiesSubscriptionsItem",
  "csharp"
);
@@clientName(NspAccessRulePropertiesSubscriptionsItem.id,
  "SubscriptionId",
  "csharp"
);
@@alternateType(Azure.ResourceManager.CommonTypes.Resource.id,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(PrivateEndpoint.id, Azure.Core.armResourceIdentifier, "csharp");
@@alternateType(Subnet.id, Azure.Core.armResourceIdentifier, "csharp");
@@alternateType(NspAccessRuleProperties.subscriptions,
  Azure.ResourceManager.Models.SubResource[],
  "csharp"
);
@@alternateType(Cluster, EventHubsCluster, "csharp");
@@alternateType(EHNamespace, EventHubsNamespace, "csharp");
@@alternateType(EntityStatus, EventHubEntityStatus, "csharp");
@@alternateType(NspAccessRule, EventHubsNspAccessRule, "csharp");
@@alternateType(PrivateLinkResource,
  EventHubsPrivateLinkResourceData,
  "csharp"
);
@@alternateType(Encryption.keySource, EventHubsKeySource, "csharp");

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Required for backward compatibility - flatten properties for C# SDK"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(EventHubsCluster.properties,
  "csharp"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Required for backward compatibility - flatten properties for C# SDK"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(EventHubsNamespace.properties,
  "csharp"
);

// Custom models to ensure C# resource classes inherit TrackedResourceData
namespace Microsoft.EventHub {
  /**
   * Single Event Hubs Cluster resource in List or Get operations.
   */
  model EventHubsCluster
    is Azure.ResourceManager.TrackedResource<ClusterProperties> {
    ...Azure.ResourceManager.ResourceNameParameter<
      Resource = Cluster,
      KeyName = "clusterName",
      SegmentName = "clusters",
      NamePattern = ""
    >;
    ...OmitProperties<
      Cluster,
      "id" | "name" | "type" | "properties" | "location"
    >;
  }

  /**
   * Single Namespace item in List or Get Operation
   */
  model EventHubsNamespace
    is Azure.ResourceManager.TrackedResource<EHNamespaceProperties> {
    ...Azure.ResourceManager.ResourceNameParameter<
      Resource = EHNamespace,
      KeyName = "namespaceName",
      SegmentName = "namespaces",
      NamePattern = "^[a-zA-Z][a-zA-Z0-9-]{6,50}[a-zA-Z0-9]$"
    >;
    ...OmitProperties<
      Cluster,
      "id" | "name" | "type" | "properties" | "location" | "identity" | "sku"
    >;

    /**
     * Properties of sku resource
     */
    #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
    sku?: Sku;

    /**
     * Properties of BYOK Identity description
     */
    #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
    identity?: Azure.ResourceManager.CommonTypes.ManagedServiceIdentity;
  }

  /**
   * Information of Access Rule in Network Profile
   */
  #suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  model EventHubsNspAccessRule
    extends Azure.ResourceManager.CommonTypes.Resource {
    ...OmitProperties<NspAccessRule, "id" | "name" | "type">;
  }

  /**
   * Information of the private link resource.
   */
  #suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  model EventHubsPrivateLinkResourceData
    extends Azure.ResourceManager.CommonTypes.Resource {
    ...OmitProperties<PrivateLinkResource, "id" | "name" | "type">;
  }

  /**
   * Enumerates the possible values for the status of the Event Hub.
   */
  #suppress "@azure-tools/typespec-azure-core/no-enum" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  enum EventHubEntityStatus {
    /**
     * Unknown
     */
    Unknown,

    /**
     * Active
     */
    Active,

    /**
     * Disabled
     */
    Disabled,

    /**
     * Restoring
     */
    Restoring,

    /**
     * SendDisabled
     */
    SendDisabled,

    /**
     * ReceiveDisabled
     */
    ReceiveDisabled,

    /**
     * Creating
     */
    Creating,

    /**
     * Deleting
     */
    Deleting,

    /**
     * Renaming
     */
    Renaming,
  }

  /**
   * Enumerates the possible value of keySource for Encryption
   */
  union EventHubsKeySource {
    string,
    #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
    `Microsoft.KeyVault`: "Microsoft.KeyVault",
  }
}

// We add this model in this namespace in order to replace some models with this model via alternateType decorator
namespace Azure.ResourceManager.Models {
  /** Represents a reference to an existing resource by its id. */
  model SubResource {
    /** The resource id. */
    id?: Azure.Core.armResourceIdentifier;
  }
}

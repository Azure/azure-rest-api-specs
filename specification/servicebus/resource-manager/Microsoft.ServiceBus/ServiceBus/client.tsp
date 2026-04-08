import "@azure-tools/typespec-client-generator-core";
import "./main.tsp";
using Azure.ClientGenerator.Core;
using Azure.Core;
using Microsoft.ServiceBus;

@@clientName(Microsoft.ServiceBus, "ServiceBusManagementClient", "javascript");
@@clientName(Microsoft.ServiceBus, "ServiceBusManagementClient", "python");

@@clientName(NetworkRuleIPAction, "NetworkRuleIpAction", "java");

// Fix TLS version naming changes for Go SDK compatibility
@@clientName(TlsVersion.`1.0`, "One0", "go");
@@clientName(TlsVersion.`1.1`, "One1", "go");
@@clientName(TlsVersion.`1.2`, "One2", "go");
@@clientName(TlsVersion.`1.0`, "ONE0", "python");
@@clientName(TlsVersion.`1.1`, "ONE1", "python");
@@clientName(TlsVersion.`1.2`, "ONE2", "python");
@@clientName(TlsVersion.`1.3`, "ONE3", "python");

@@clientName(ErrorAdditionalInfo, "ServiceBusErrorAdditionalInfo", "csharp");
@@clientName(UnavailableReason, "ServiceBusNameUnavailableReason", "csharp");
@@clientName(EntityStatus, "ServiceBusMessagingEntityStatus", "csharp");
@@clientName(FilterType, "ServiceBusFilterType", "csharp");
@@clientName(SqlFilter, "ServiceBusSqlFilter", "csharp");
@@clientName(CorrelationFilter, "ServiceBusCorrelationFilter", "csharp");
@@clientName(PublicNetworkAccess, "ServiceBusPublicNetworkAccess", "csharp");
@@clientName(TlsVersion, "ServiceBusMinimumTlsVersion", "csharp");
@@clientName(MigrationConfigProperties, "MigrationConfiguration", "csharp");
@@clientName(KeyType, "ServiceBusAccessKeyType", "csharp");
@@clientName(RegenerateAccessKeyParameters,
  "ServiceBusRegenerateAccessKeyContent",
  "csharp"
);
@@clientName(ProvisioningStateDR,
  "ServiceBusDisasterRecoveryProvisioningState",
  "csharp"
);
@@clientName(RoleDisasterRecovery, "ServiceBusDisasterRecoveryRole", "csharp");
@@clientName(ArmDisasterRecovery, "ServiceBusDisasterRecovery", "csharp");
@@clientName(AccessKeys, "ServiceBusAccessKeys", "csharp");
@@clientName(AccessRights, "ServiceBusAccessRight", "csharp");
@@clientName(Rule, "ServiceBusRule", "csharp");
@@clientName(Action, "ServiceBusFilterAction", "csharp");
@@clientName(Encryption, "ServiceBusEncryption", "csharp");
@@clientName(ConnectionState,
  "ServiceBusPrivateLinkServiceConnectionState",
  "csharp"
);
@@clientName(PrivateLinkConnectionStatus,
  "ServiceBusPrivateLinkConnectionStatus",
  "csharp"
);
@@clientName(EndPointProvisioningState,
  "ServiceBusPrivateEndpointConnectionProvisioningState",
  "csharp"
);
@@clientName(PublicNetworkAccessFlag,
  "ServiceBusPublicNetworkAccessFlag",
  "csharp"
);
@@clientName(NWRuleSetIpRules, "ServiceBusNetworkRuleSetIPRules", "csharp");
@@clientName(NetworkRuleIPAction, "ServiceBusNetworkRuleIPAction", "csharp");
@@clientName(NWRuleSetVirtualNetworkRules,
  "ServiceBusNetworkRuleSetVirtualNetworkRules",
  "csharp"
);
@@clientName(DefaultAction, "ServiceBusNetworkRuleSetDefaultAction", "csharp");
@@clientName(SBTopic, "ServiceBusTopic", "csharp");
@@clientName(SBQueue, "ServiceBusQueue", "csharp");
@@clientName(SBSubscription, "ServiceBusSubscription", "csharp");
@@clientName(SBClientAffineProperties,
  "ServiceBusClientAffineProperties",
  "csharp"
);
@@clientName(KeyVaultProperties, "ServiceBusKeyVaultProperties", "csharp");
@@clientName(SBNamespace, "ServiceBusNamespace", "csharp");
@@clientName(SBSku, "ServiceBusSku", "csharp");
@@clientName(SBAuthorizationRule, "ServiceBusAuthorizationRule", "csharp");
@@clientName(CheckNameAvailability,
  "ServiceBusNameAvailabilityContent",
  "csharp"
);
@@clientName(CheckNameAvailabilityResult,
  "ServiceBusNameAvailabilityResult",
  "csharp"
);
@@clientName(NetworkRuleSet, "ServiceBusNetworkRuleSet", "csharp");
@@clientName(NamespaceReplicaLocation,
  "ServiceBusNamespaceReplicaLocation",
  "csharp"
);
@@clientName(NetworkSecurityPerimeter,
  "ServiceBusNetworkSecurityPerimeter",
  "csharp"
);
@@clientName(NetworkSecurityPerimeterConfiguration,
  "ServiceBusNetworkSecurityPerimeterConfiguration",
  "csharp"
);
@@clientName(NetworkSecurityPerimeterConfigurationPropertiesProfile,
  "ServiceBusNetworkSecurityPerimeterConfigurationPropertiesProfile",
  "csharp"
);
@@clientName(NetworkSecurityPerimeterConfigurationPropertiesResourceAssociation,
  "ServiceBusNetworkSecurityPerimeterConfigurationPropertiesResourceAssociation",
  "csharp"
);
@@clientName(NetworkSecurityPerimeterConfigurationProvisioningState,
  "ServiceBusNetworkSecurityPerimeterConfigurationProvisioningState",
  "csharp"
);
@@clientName(NspAccessRule, "ServiceBusNspAccessRule", "csharp");
@@clientName(NspAccessRuleDirection,
  "ServiceBusNspAccessRuleDirection",
  "csharp"
);
@@clientName(NspAccessRuleProperties,
  "ServiceBusNspAccessRuleProperties",
  "csharp"
);
@@clientName(ResourceAssociationAccessMode,
  "ServiceBusResourceAssociationAccessMode",
  "csharp"
);
@@clientName(Mode, "ServiceBusConfidentialComputeMode", "csharp");
@@clientName(ProvisioningIssue,
  "ServiceBusNspConfigurationProvisioningIssue",
  "csharp"
);
@@clientName(ProvisioningIssueProperties,
  "ServiceBusNspConfigurationProvisioningIssueProperties",
  "csharp"
);
@@clientName(FailOver, "ServiceBusNamespaceFailOver", "csharp");
@@clientName(SBNamespaces.privateLinkResourcesGet,
  "GetPrivateLinkResources",
  "csharp"
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Change the operation back to pageable for backward compatibility"
@@Azure.ClientGenerator.Core.Legacy.markAsPageable(SBNamespaces.privateLinkResourcesGet,
  "csharp"
);
@@clientName(NWRuleSetIpRules.ipMask, "IPMask", "csharp");
@@clientName(CorrelationFilter.properties, "ApplicationProperties", "csharp");
@@clientName(CorrelationFilter.to, "SendTo", "csharp");
@@clientName(CorrelationFilter.label, "Subject", "csharp");
@@clientName(SBNamespaceProperties.zoneRedundant, "IsZoneRedundant", "csharp");
@@clientName(NetworkRuleSetProperties.trustedServiceAccessEnabled,
  "IsTrustedServiceAccessEnabled",
  "csharp"
);
@@clientName(CheckNameAvailabilityResult.nameAvailable,
  "IsNameAvailable",
  "csharp"
);
@@clientName(MigrationConfigPropertiesProperties.targetNamespace,
  "TargetServiceBusNamespace",
  "csharp"
);
@@alternateType(MigrationConfigPropertiesProperties.targetNamespace,
  armResourceIdentifier,
  "csharp"
);
@@alternateType(Identity.tenantId, uuid, "csharp");
@@alternateType(KeyVaultProperties.keyVaultUri, url, "csharp");
@@alternateType(SBNamespace.identity,
  Azure.ResourceManager.CommonTypes.ManagedServiceIdentity,
  "csharp"
);
@@alternateType(SBNamespaceUpdateParameters.identity,
  Azure.ResourceManager.CommonTypes.ManagedServiceIdentity,
  "csharp"
);

// Step 6: Fix TLS version member names (MembersMustExist)
@@clientName(TlsVersion.`1.0`, "Tls1_0", "csharp");
@@clientName(TlsVersion.`1.1`, "Tls1_1", "csharp");
@@clientName(TlsVersion.`1.2`, "Tls1_2", "csharp");
@@clientName(TlsVersion.`1.3`, "Tls1_3", "csharp");

// Step 6: Avoid Windows filename collision between FailOverProperties.cs and FailoverProperties.cs
@@clientName(FailOverProperties, "ServiceBusFailOverDetail", "csharp");

// Step 6: Fix property names (MembersMustExist)
@@clientName(NetworkRuleSetProperties.ipRules, "IPRules", "csharp");
@@clientName(PrivateEndpointConnectionProperties.privateLinkServiceConnectionState,
  "ConnectionState",
  "csharp"
);
@@clientName(PrivateEndpointConnection,
  "ServiceBusPrivateEndpointConnection",
  "csharp"
);
@@clientName(NamespaceFailoverProperties, "FailoverProperties", "csharp");

// Step 6: Fix property types to ResourceIdentifier (MembersMustExist)
@@alternateType(Subnet.id, armResourceIdentifier, "csharp");
@@alternateType(PrivateEndpoint.id, armResourceIdentifier, "csharp");

// Step 6: Fix location types on resource models to AzureLocation (MembersMustExist)
@@alternateType(MigrationConfigProperties.location, azureLocation, "csharp");
@@alternateType(ArmDisasterRecovery.location, azureLocation, "csharp");
@@alternateType(NetworkRuleSet.location, azureLocation, "csharp");
@@alternateType(PrivateEndpointConnection.location, azureLocation, "csharp");
@@alternateType(SBQueue.location, azureLocation, "csharp");
@@alternateType(Rule.location, azureLocation, "csharp");
@@alternateType(SBSubscription.location, azureLocation, "csharp");
@@alternateType(SBTopic.location, azureLocation, "csharp");
@@alternateType(SBAuthorizationRule.location, azureLocation, "csharp");

// Step 6: Fix operation names (MembersMustExist)
@@clientName(NamespacesOperationGroup.checkNameAvailability,
  "CheckServiceBusNamespaceNameAvailability",
  "csharp"
);
@@clientName(SBNamespaces.checkNameAvailability,
  "CheckServiceBusDisasterRecoveryNameAvailability",
  "csharp"
);

// =============================================================================
// C# SDK backward-compatibility replacement models
// =============================================================================

namespace Microsoft.ServiceBus {
  /**
   * Parameters supplied to the Patch Namespace operation.
   */
  #suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "C# back-compat"
  #suppress "@azure-tools/typespec-azure-core/casing-style" "SB prefix matches existing ServiceBus naming convention"
  model SBNamespaceUpdateParametersReplacement
    extends Azure.ResourceManager.CommonTypes.TrackedResource {
    /** The namespace update properties. */
    properties?: SBNamespaceUpdateProperties;

    ...OmitProperties<
      SBNamespaceUpdateParameters,
      "location" | "tags" | "properties" | "id" | "name" | "type" | "systemData"
    >;
  }

  /**
   * A private link resource
   */
  #suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "C# back-compat"
  model PrivateLinkResourceReplacement
    extends Azure.ResourceManager.CommonTypes.Resource {
    /** The private link resource properties. */
    properties?: PrivateLinkResourceProperties;
  }
} // namespace Microsoft.ServiceBus

@@alternateType(SBNamespaceUpdateParameters,
  SBNamespaceUpdateParametersReplacement,
  "csharp"
);
@@clientName(SBNamespaceUpdateParametersReplacement,
  "ServiceBusNamespacePatch",
  "csharp"
);
@@usage(SBNamespaceUpdateParametersReplacement,
  Usage.input | Usage.output,
  "csharp"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(SBNamespaceUpdateParametersReplacement.properties
);

@@alternateType(PrivateLinkResource, PrivateLinkResourceReplacement, "csharp");
@@clientName(PrivateLinkResourceReplacement,
  "ServiceBusPrivateLinkResource",
  "csharp"
);
@@usage(PrivateLinkResourceReplacement, Usage.input | Usage.output, "csharp");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(PrivateLinkResourceReplacement.properties
);

import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.Relay;

// Preserve existing "WcfRelays" client name (was "WCFRelays" in TypeSpec)
@@clientName(WCFRelays, "WcfRelays", "java");

@@clientName(AuthorizationRule, "RelayAuthorizationRule", "csharp");
@@clientName(AccessRights, "RelayAccessRight", "csharp");
@@clientName(HybridConnectionProperties.requiresClientAuthorization,
  "IsClientAuthorizationRequired",
  "csharp"
);
@@clientName(AccessKeys, "RelayAccessKeys", "csharp");
@@clientName(RegenerateAccessKeyParameters,
  "RelayRegenerateAccessKeyContent",
  "csharp"
);
@@clientName(NetworkRuleSet, "RelayNetworkRuleSet", "csharp");
@@clientName(DefaultAction, "RelayNetworkRuleSetDefaultAction", "csharp");
@@clientName(NetworkRuleIPAction, "RelayNetworkRuleIPAction", "csharp");
@@clientName(PublicNetworkAccess, "RelayPublicNetworkAccess", "csharp");
@@clientName(ConnectionState,
  "RelayPrivateLinkServiceConnectionState",
  "csharp"
);
@@clientName(PrivateLinkConnectionStatus,
  "RelayPrivateLinkConnectionStatus",
  "csharp"
);
@@clientName(EndPointProvisioningState,
  "RelayPrivateEndpointConnectionProvisioningState",
  "csharp"
);
@@clientName(WcfRelayProperties.requiresClientAuthorization,
  "IsClientAuthorizationRequired",
  "csharp"
);
@@clientName(WcfRelayProperties.requiresTransportSecurity,
  "IsTransportSecurityRequired",
  "csharp"
);
@@clientName(Relaytype, "RelayType", "csharp");
@@clientName(CheckNameAvailability, "RelayNameAvailabilityContent", "csharp");
@@clientName(CheckNameAvailabilityResult,
  "RelayNameAvailabilityResult",
  "csharp"
);
@@clientName(CheckNameAvailabilityResult.nameAvailable,
  "IsNameAvailable",
  "csharp"
);
@@clientName(UnavailableReason, "RelayNameUnavailableReason", "csharp");
@@clientName(KeyType, "RelayAccessKeyType", "csharp");
@@clientName(HybridConnection, "RelayHybridConnection", "csharp");

// Acronym mapping: Ip -> IP (directive + acronym-mapping from autorest.md)
@@clientName(NWRuleSetIpRules, "RelayNetworkRuleSetIPRule", "csharp");
@@clientName(NWRuleSetIpRules.ipMask, "IPMask", "csharp");
@@clientName(NetworkRuleSetProperties.ipRules, "IPRules", "csharp");

@@alternateType(Azure.ResourceManager.CommonTypes.Resource.id,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@clientName(PrivateLinkResource, "RelayPrivateLinkResource", "csharp");
@@clientName(PrivateEndpointConnection,
  "RelayPrivateEndpointConnection",
  "csharp"
);

// Back-compat: location properties were AzureLocation? in the old autorest SDK
@@alternateType(AuthorizationRule.location, Azure.Core.azureLocation, "csharp");
@@alternateType(HybridConnection.location, Azure.Core.azureLocation, "csharp");
@@alternateType(PrivateEndpointConnection.location,
  Azure.Core.azureLocation,
  "csharp"
);
@@alternateType(WcfRelay.location, Azure.Core.azureLocation, "csharp");

// Back-compat: PrivateEndpoint.id was ResourceIdentifier in the old SDK
@@alternateType(PrivateEndpoint.id, Azure.Core.armResourceIdentifier, "csharp");

// Back-compat: property was named ConnectionState in the old SDK
@@clientName(PrivateEndpointConnectionProperties.privateLinkServiceConnectionState,
  "ConnectionState",
  "csharp"
);

/**
 * Description of a namespace resource.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model RelayUpdateParametersReplacement
  extends Azure.ResourceManager.CommonTypes.Resource {
  /**
   * SKU of the namespace.
   */
  sku?: Sku;

  /**
   * Description of Relay namespace.
   */
  #suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @Azure.ClientGenerator.Core.Legacy.flattenProperty
  properties?: RelayNamespaceProperties;

  /**
   * Resource tags.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  tags?: Record<string>;
}

@@alternateType(RelayUpdateParameters,
  RelayUpdateParametersReplacement,
  "csharp"
);
@@clientName(RelayUpdateParameters, "RelayUpdateParametersTemp", "csharp");
@@clientName(RelayUpdateParametersReplacement,
  "RelayUpdateParameters",
  "csharp"
);

// Back-compat: operation was named CheckRelayNamespaceNameAvailability in the old SDK
@@clientName(NamespacesOperationGroup.checkNameAvailability,
  "CheckRelayNamespaceNameAvailability",
  "csharp"
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back-compat"
@@Azure.ClientGenerator.Core.Legacy.markAsPageable(PrivateLinkResources.list,
  "csharp"
);

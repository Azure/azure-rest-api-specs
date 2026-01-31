import "@azure-tools/typespec-client-generator-core";
import "./main.tsp";

using Azure.ClientGenerator.Core;
using Azure.Core;
using Azure.ResourceManager.Foundations;
using Microsoft.Relay;

@@clientName(HybridConnection, "RelayHybridConnection", "csharp");
@@clientName(NetworkRuleSet, "RelayNetworkRuleSet", "csharp");
@@clientName(PrivateLinkResource, "RelayPrivateLinkResource", "csharp");
@@clientName(PrivateEndpointConnection,
  "RelayPrivateEndpointConnection",
  "csharp"
);
@@clientName(Relaytype, "RelayType", "csharp");
@@clientName(EndPointProvisioningState,
  "RelayPrivateEndpointConnectionProvisioningState",
  "csharp"
);
@@clientName(RegenerateAccessKeyParameters,
  "RelayRegenerateAccessKeyContent",
  "csharp"
);
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
@@clientName(AccessRights, "RelayAccessRight", "csharp");
@@clientName(AccessKeys, "RelayAccessKeys", "csharp");
@@clientName(DefaultAction, "RelayNetworkRuleSetDefaultAction", "csharp");
@@clientName(PublicNetworkAccess, "RelayPublicNetworkAccess", "csharp");
@@clientName(ConnectionState,
  "RelayPrivateLinkServiceConnectionState",
  "csharp"
);
@@clientName(NetworkRuleIPAction, "RelayNetworkRuleIPAction", "csharp");
@@clientName(PrivateLinkConnectionStatus,
  "RelayPrivateLinkConnectionStatus",
  "csharp"
);
@@clientName(KeyType, "RelayAccessKeyType", "csharp");
@@clientName(NWRuleSetIpRules, "RelayNetworkRuleSetIPRule", "csharp");

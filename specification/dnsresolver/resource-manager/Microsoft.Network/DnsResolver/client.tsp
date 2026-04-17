import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.Network;

@@clientName(Microsoft.Network,
  "DnsResolverManagementClient",
  "javascript, python"
);
@@clientName(ProvisioningState, "DnsResolverProvisioningState", "csharp");
@@clientName(ForwardingRule, "DnsForwardingRule", "csharp");
@@clientName(ForwardingRuleState, "DnsForwardingRuleState", "csharp");
@@clientName(ForwardingRuleProperties.forwardingRuleState,
  "DnsForwardingRuleState",
  "csharp"
);
@@clientName(ForwardingRulePatchProperties.forwardingRuleState,
  "DnsForwardingRuleState",
  "csharp"
);
@@clientName(InboundEndpoint, "DnsResolverInboundEndpoint", "csharp");
@@clientName(IpConfiguration, "InboundEndpointIPConfiguration", "csharp");
@@clientName(IpAllocationMethod, "InboundEndpointIPAllocationMethod", "csharp");
@@clientName(OutboundEndpoint, "DnsResolverOutboundEndpoint", "csharp");
@@clientName(VirtualNetworkLink,
  "DnsForwardingRulesetVirtualNetworkLink",
  "csharp"
);
@@clientName(ActionType, "DnsSecurityRuleActionType", "csharp");
@@clientName(Action, "DnsResolverDomainListBulkAction", "csharp");
@@clientName(DnsForwardingRuleset.name, "rulesetName", "csharp");

@@clientName(DnsResolversOperationGroup.listByVirtualNetwork,
  "getDnsResolversByVirtualNetwork",
  "csharp"
);
@@clientName(DnsForwardingRulesetsOperationGroup.listByVirtualNetwork,
  "getDnsForwardingRulesetsByVirtualNetwork",
  "csharp"
);
@@clientName(DnsResolverPoliciesOperationGroup.listByVirtualNetwork,
  "getDnsResolverPoliciesByVirtualNetwork",
  "csharp"
);

// Preserve IP casing from old AutoRest API surface
@@clientName(IpConfiguration.privateIpAddress, "PrivateIPAddress", "csharp");
@@clientName(IpConfiguration.privateIpAllocationMethod,
  "PrivateIPAllocationMethod",
  "csharp"
);
@@clientName(TargetDnsServer.ipAddress, "IPAddress", "csharp");
@@clientName(InboundEndpointProperties.ipConfigurations,
  "IPConfigurations",
  "csharp"
);

@@alternateType(Azure.ResourceManager.Legacy.EntityTagProperty.etag,
  Azure.Core.eTag,
  "csharp"
);
@@alternateType(DnsResolverProperties.resourceGuid, Azure.Core.uuid, "csharp");
@@alternateType(DnsForwardingRulesetProperties.resourceGuid,
  Azure.Core.uuid,
  "csharp"
);
@@alternateType(DnsResolverDomainListProperties.domainsUrl, url, "csharp");
@@alternateType(DnsResolverDomainListProperties.resourceGuid,
  Azure.Core.uuid,
  "csharp"
);
@@alternateType(InboundEndpointProperties.resourceGuid,
  Azure.Core.uuid,
  "csharp"
);
@@alternateType(OutboundEndpointProperties.resourceGuid,
  Azure.Core.uuid,
  "csharp"
);
@@alternateType(DnsResolverPolicyProperties.resourceGuid,
  Azure.Core.uuid,
  "csharp"
);
@@alternateType(DnsResolverDomainListBulkProperties.storageUrl, url, "csharp");
@@alternateType(IpConfiguration.privateIpAddress,
  Azure.Core.ipV4Address,
  "csharp"
);
@@alternateType(TargetDnsServer.ipAddress, Azure.Core.ipV4Address, "csharp");
@@alternateType(SubResource.id, Azure.Core.armResourceIdentifier, "csharp");
@@alternateType(VirtualNetworkDnsForwardingRuleset.id,
  Azure.Core.armResourceIdentifier,
  "csharp"
);

// Define WritableSubResource in the ARM namespace to allow @@alternateType substitution
namespace Azure.ResourceManager.Models {
  model WritableSubResource {
    id?: Azure.Core.armResourceIdentifier;
  }
}

// Preserve WritableSubResource-based constructors/collections from old API surface
@@alternateType(DnsResolverProperties.virtualNetwork,
  Azure.ResourceManager.Models.WritableSubResource,
  "csharp"
);
@@alternateType(IpConfiguration.subnet,
  Azure.ResourceManager.Models.WritableSubResource,
  "csharp"
);
@@alternateType(OutboundEndpointProperties.subnet,
  Azure.ResourceManager.Models.WritableSubResource,
  "csharp"
);
@@alternateType(VirtualNetworkLinkProperties.virtualNetwork,
  Azure.ResourceManager.Models.WritableSubResource,
  "csharp"
);
@@alternateType(DnsResolverPolicyVirtualNetworkLinkProperties.virtualNetwork,
  Azure.ResourceManager.Models.WritableSubResource,
  "csharp"
);
@@alternateType(DnsForwardingRulesetProperties.dnsResolverOutboundEndpoints,
  Azure.ResourceManager.Models.WritableSubResource[],
  "csharp"
);
@@alternateType(DnsForwardingRulesetPatch.dnsResolverOutboundEndpoints,
  Azure.ResourceManager.Models.WritableSubResource[],
  "csharp"
);
@@alternateType(DnsSecurityRuleProperties.dnsResolverDomainLists,
  Azure.ResourceManager.Models.WritableSubResource[],
  "csharp"
);
@@alternateType(DnsSecurityRulePatchProperties.dnsResolverDomainLists,
  Azure.ResourceManager.Models.WritableSubResource[],
  "csharp"
);

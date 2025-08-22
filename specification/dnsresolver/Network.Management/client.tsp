import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.Network;

@@clientName(Microsoft.Network, "DnsResolverManagementClient", "javascript");

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
@@clientName(IpConfiguration, "InboundEndpointIpConfiguration", "csharp");
@@clientName(IpAllocationMethod, "InboundEndpointIpAllocationMethod", "csharp");
@@clientName(OutboundEndpoint, "DnsResolverOutboundEndpoint", "csharp");
@@clientName(VirtualNetworkLink,
  "DnsForwardingRulesetVirtualNetworkLink",
  "csharp"
);
@@clientName(ActionType, "DnsSecurityRuleActionType", "csharp");
@@clientName(Action, "DnsResolverDomainListBulkAction", "csharp");
@@clientName(DnsForwardingRuleset.name, "rulesetName", "csharp");

@@alternateType(DnsForwardingRuleset.etag, Azure.Core.eTag);
@@alternateType(DnsResolverProperties.resourceGuid, Azure.Core.uuid);
@@alternateType(DnsForwardingRulesetProperties.resourceGuid, Azure.Core.uuid);
@@alternateType(DnsResolverDomainListProperties.domainsUrl, url);
@@alternateType(DnsResolverDomainListProperties.resourceGuid, Azure.Core.uuid);
@@alternateType(InboundEndpointProperties.resourceGuid, Azure.Core.uuid);
@@alternateType(OutboundEndpointProperties.resourceGuid, Azure.Core.uuid);
@@alternateType(DnsResolverPolicyProperties.resourceGuid, Azure.Core.uuid);
@@alternateType(DnsResolverDomainListBulkProperties.storageUrl, url);
@@alternateType(IpConfiguration.privateIpAddress, Azure.Core.ipV4Address);
@@alternateType(TargetDnsServer.ipAddress, Azure.Core.ipV4Address);
@@alternateType(VirtualNetworkDnsForwardingRuleset.id,
  Azure.Core.armResourceIdentifier
);

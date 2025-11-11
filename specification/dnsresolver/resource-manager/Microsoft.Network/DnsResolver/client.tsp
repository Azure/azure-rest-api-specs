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
@@alternateType(VirtualNetworkDnsForwardingRuleset.id,
  Azure.Core.armResourceIdentifier,
  "csharp"
);

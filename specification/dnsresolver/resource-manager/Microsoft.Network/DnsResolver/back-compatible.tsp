import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.Network;

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(ForwardingRulePatch.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(VirtualNetworkLinkPatch.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(VirtualNetworkDnsForwardingRuleset.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(DnsSecurityRulePatch.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(DnsResolverDomainListPatch.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(DnsResolverDomainListBulk.properties);

@@clientName(DnsResolvers.createOrUpdate::parameters.resource, "parameters");
@@clientName(DnsResolvers.update::parameters.properties, "parameters");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(DnsResolver.properties);

@@clientName(InboundEndpoints.createOrUpdate::parameters.resource,
  "parameters"
);
@@clientName(InboundEndpoints.update::parameters.properties, "parameters");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(InboundEndpoint.properties);

@@clientName(OutboundEndpoints.createOrUpdate::parameters.resource,
  "parameters"
);
@@clientName(OutboundEndpoints.update::parameters.properties, "parameters");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(OutboundEndpoint.properties);

@@clientName(DnsForwardingRulesets.createOrUpdate::parameters.resource,
  "parameters"
);
@@clientName(DnsForwardingRulesets.update::parameters.properties, "parameters");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(DnsForwardingRuleset.properties);

@@clientName(ForwardingRules.createOrUpdate::parameters.resource, "parameters");
@@clientName(ForwardingRules.update::parameters.properties, "parameters");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(ForwardingRule.properties);

@@clientName(VirtualNetworkLinks.createOrUpdate::parameters.resource,
  "parameters"
);
@@clientName(VirtualNetworkLinks.update::parameters.properties, "parameters");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(VirtualNetworkLink.properties);

@@clientName(DnsResolverPolicies.createOrUpdate::parameters.resource,
  "parameters"
);
@@clientName(DnsResolverPolicies.update::parameters.properties, "parameters");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(DnsResolverPolicy.properties);

@@clientName(DnsSecurityRules.createOrUpdate::parameters.resource,
  "parameters"
);
@@clientName(DnsSecurityRules.update::parameters.properties, "parameters");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(DnsSecurityRule.properties);

@@clientName(DnsResolverPolicyVirtualNetworkLinks.createOrUpdate::parameters.resource,
  "parameters"
);
@@clientName(DnsResolverPolicyVirtualNetworkLinks.update::parameters.properties,
  "parameters"
);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(DnsResolverPolicyVirtualNetworkLink.properties);

@@clientName(DnsResolverDomainLists.createOrUpdate::parameters.resource,
  "parameters"
);
@@clientName(DnsResolverDomainLists.update::parameters.properties,
  "parameters"
);
@@clientName(DnsResolverDomainLists.bulk::parameters.body, "parameters");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(DnsResolverDomainList.properties);

@@clientLocation(DnsResolversOperationGroup.listByVirtualNetwork, DnsResolvers);
@@clientLocation(DnsForwardingRulesetsOperationGroup.listByVirtualNetwork,
  DnsForwardingRulesets
);
@@clientLocation(DnsResolverPoliciesOperationGroup.listByVirtualNetwork,
  DnsResolverPolicies
);

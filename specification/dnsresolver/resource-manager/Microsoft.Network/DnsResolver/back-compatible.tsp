import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.Network;

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "@flattenProperty decorator is not recommended to use."
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(ForwardingRulePatch.properties
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "@flattenProperty decorator is not recommended to use."
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(VirtualNetworkLinkPatch.properties
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "@flattenProperty decorator is not recommended to use."
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(VirtualNetworkDnsForwardingRuleset.properties
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "@flattenProperty decorator is not recommended to use."
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(DnsSecurityRulePatch.properties
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "@flattenProperty decorator is not recommended to use."
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(DnsResolverDomainListPatch.properties
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "@flattenProperty decorator is not recommended to use."
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(DnsResolverDomainListBulk.properties
);

@@clientName(DnsResolvers.createOrUpdate::parameters.resource, "parameters");
@@clientName(DnsResolvers.update::parameters.properties, "parameters");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "@flattenProperty decorator is not recommended to use."
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(DnsResolver.properties);

@@clientName(InboundEndpoints.createOrUpdate::parameters.resource,
  "parameters"
);
@@clientName(InboundEndpoints.update::parameters.properties, "parameters");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "@flattenProperty decorator is not recommended to use."
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(InboundEndpoint.properties);

@@clientName(OutboundEndpoints.createOrUpdate::parameters.resource,
  "parameters"
);
@@clientName(OutboundEndpoints.update::parameters.properties, "parameters");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "@flattenProperty decorator is not recommended to use."
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(OutboundEndpoint.properties
);

@@clientName(DnsForwardingRulesets.createOrUpdate::parameters.resource,
  "parameters"
);
@@clientName(DnsForwardingRulesets.update::parameters.properties, "parameters");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "@flattenProperty decorator is not recommended to use."
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(DnsForwardingRuleset.properties
);

@@clientName(ForwardingRules.createOrUpdate::parameters.resource, "parameters");
@@clientName(ForwardingRules.update::parameters.properties, "parameters");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "@flattenProperty decorator is not recommended to use."
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(ForwardingRule.properties);

@@clientName(VirtualNetworkLinks.createOrUpdate::parameters.resource,
  "parameters"
);
@@clientName(VirtualNetworkLinks.update::parameters.properties, "parameters");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "@flattenProperty decorator is not recommended to use."
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(VirtualNetworkLink.properties
);

@@clientName(DnsResolverPolicies.createOrUpdate::parameters.resource,
  "parameters"
);
@@clientName(DnsResolverPolicies.update::parameters.properties, "parameters");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "@flattenProperty decorator is not recommended to use."
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(DnsResolverPolicy.properties
);

@@clientName(DnsSecurityRules.createOrUpdate::parameters.resource,
  "parameters"
);
@@clientName(DnsSecurityRules.update::parameters.properties, "parameters");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "@flattenProperty decorator is not recommended to use."
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(DnsSecurityRule.properties);

@@clientName(DnsResolverPolicyVirtualNetworkLinks.createOrUpdate::parameters.resource,
  "parameters"
);
@@clientName(DnsResolverPolicyVirtualNetworkLinks.update::parameters.properties,
  "parameters"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "@flattenProperty decorator is not recommended to use."
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(DnsResolverPolicyVirtualNetworkLink.properties
);

@@clientName(DnsResolverDomainLists.createOrUpdate::parameters.resource,
  "parameters"
);
@@clientName(DnsResolverDomainLists.update::parameters.properties,
  "parameters"
);
@@clientName(DnsResolverDomainLists.bulk::parameters.body, "parameters");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "@flattenProperty decorator is not recommended to use."
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(DnsResolverDomainList.properties
);

@@clientLocation(DnsResolversOperationGroup.listByVirtualNetwork, DnsResolvers);
@@clientLocation(DnsForwardingRulesetsOperationGroup.listByVirtualNetwork,
  DnsForwardingRulesets
);
@@clientLocation(DnsResolverPoliciesOperationGroup.listByVirtualNetwork,
  DnsResolverPolicies
);

import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;

namespace DnsResolverManagementClient;

interface DnsResolversOperations {
  @doc("Creates or updates a DNS resolver.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/dnsResolvers/{dnsResolverName}")
  @put
  CreateOrUpdate is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of the DNS resolver.")
      @path
      dnsResolverName: string;

      @doc("""
ETag of the resource. Omit this value to always overwrite the current resource.
Specify the last-seen ETag value to prevent accidentally overwriting any
concurrent changes.
""")
      @header
      `If-Match`: string;

      @doc("""
Set to '*' to allow a new resource to be created, but to prevent updating an
existing resource. Other values will be ignored.
""")
      @header
      `If-None-Match`: string;

      @doc("Parameters supplied to the CreateOrUpdate operation.")
      @body
      parameters: DnsResolver;
    },
    DnsResolver | void
  >;

  @doc("Updates a DNS resolver.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/dnsResolvers/{dnsResolverName}")
  @patch
  Update is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of the DNS resolver.")
      @path
      dnsResolverName: string;

      @doc("""
ETag of the resource. Omit this value to always overwrite the current resource.
Specify the last-seen ETag value to prevent accidentally overwriting any
concurrent changes.
""")
      @header
      `If-Match`: string;

      @doc("Parameters supplied to the Update operation.")
      @body
      parameters: DnsResolverPatch;
    },
    DnsResolver | void
  >;

  @doc("Deletes a DNS resolver. WARNING: This operation cannot be undone.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/dnsResolvers/{dnsResolverName}")
  @delete
  Delete is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of the DNS resolver.")
      @path
      dnsResolverName: string;

      @doc("""
ETag of the resource. Omit this value to always overwrite the current resource.
Specify the last-seen ETag value to prevent accidentally overwriting any
concurrent changes.
""")
      @header
      `If-Match`: string;
    },
    void
  >;

  @doc("Gets properties of a DNS resolver.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/dnsResolvers/{dnsResolverName}")
  @get
  Get is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of the DNS resolver.")
      @path
      dnsResolverName: string;
    },
    DnsResolver
  >;

  @doc("Lists DNS resolvers within a resource group.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/dnsResolvers")
  @get
  ListByResourceGroup is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("""
The maximum number of results to return. If not specified, returns up to 100
results.
""")
      @query
      $top: int32;
    },
    DnsResolverListResult
  >;

  @doc("Lists DNS resolvers in all resource groups of a subscription.")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.Network/dnsResolvers")
  @get
  List is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("""
The maximum number of results to return. If not specified, returns up to 100
results.
""")
      @query
      $top: int32;
    },
    DnsResolverListResult
  >;

  @doc("Lists DNS resolver resource IDs linked to a virtual network.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/virtualNetworks/{virtualNetworkName}/listDnsResolvers")
  @post
  ListByVirtualNetwork is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of the virtual network.")
      @path
      virtualNetworkName: string;

      @doc("""
The maximum number of results to return. If not specified, returns up to 100
results.
""")
      @query
      $top: int32;
    },
    SubResourceListResult
  >;
}

interface InboundEndpointsOperations {
  @doc("Creates or updates an inbound endpoint for a DNS resolver.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/dnsResolvers/{dnsResolverName}/inboundEndpoints/{inboundEndpointName}")
  @put
  CreateOrUpdate is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of the DNS resolver.")
      @path
      dnsResolverName: string;

      @doc("The name of the inbound endpoint for the DNS resolver.")
      @path
      inboundEndpointName: string;

      @doc("""
ETag of the resource. Omit this value to always overwrite the current resource.
Specify the last-seen ETag value to prevent accidentally overwriting any
concurrent changes.
""")
      @header
      `If-Match`: string;

      @doc("""
Set to '*' to allow a new resource to be created, but to prevent updating an
existing resource. Other values will be ignored.
""")
      @header
      `If-None-Match`: string;

      @doc("Parameters supplied to the CreateOrUpdate operation.")
      @body
      parameters: InboundEndpoint;
    },
    InboundEndpoint | void
  >;

  @doc("Updates an inbound endpoint for a DNS resolver.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/dnsResolvers/{dnsResolverName}/inboundEndpoints/{inboundEndpointName}")
  @patch
  Update is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of the DNS resolver.")
      @path
      dnsResolverName: string;

      @doc("The name of the inbound endpoint for the DNS resolver.")
      @path
      inboundEndpointName: string;

      @doc("""
ETag of the resource. Omit this value to always overwrite the current resource.
Specify the last-seen ETag value to prevent accidentally overwriting any
concurrent changes.
""")
      @header
      `If-Match`: string;

      @doc("Parameters supplied to the Update operation.")
      @body
      parameters: InboundEndpointPatch;
    },
    InboundEndpoint | void
  >;

  @doc("""
Deletes an inbound endpoint for a DNS resolver. WARNING: This operation cannot
be undone.
""")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/dnsResolvers/{dnsResolverName}/inboundEndpoints/{inboundEndpointName}")
  @delete
  Delete is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of the DNS resolver.")
      @path
      dnsResolverName: string;

      @doc("The name of the inbound endpoint for the DNS resolver.")
      @path
      inboundEndpointName: string;

      @doc("""
ETag of the resource. Omit this value to always overwrite the current resource.
Specify the last-seen ETag value to prevent accidentally overwriting any
concurrent changes.
""")
      @header
      `If-Match`: string;
    },
    void
  >;

  @doc("Gets properties of an inbound endpoint for a DNS resolver.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/dnsResolvers/{dnsResolverName}/inboundEndpoints/{inboundEndpointName}")
  @get
  Get is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of the DNS resolver.")
      @path
      dnsResolverName: string;

      @doc("The name of the inbound endpoint for the DNS resolver.")
      @path
      inboundEndpointName: string;
    },
    InboundEndpoint
  >;

  @doc("Lists inbound endpoints for a DNS resolver.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/dnsResolvers/{dnsResolverName}/inboundEndpoints")
  @get
  List is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of the DNS resolver.")
      @path
      dnsResolverName: string;

      @doc("""
The maximum number of results to return. If not specified, returns up to 100
results.
""")
      @query
      $top: int32;
    },
    InboundEndpointListResult
  >;
}

interface OutboundEndpointsOperations {
  @doc("Creates or updates an outbound endpoint for a DNS resolver.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/dnsResolvers/{dnsResolverName}/outboundEndpoints/{outboundEndpointName}")
  @put
  CreateOrUpdate is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of the DNS resolver.")
      @path
      dnsResolverName: string;

      @doc("The name of the outbound endpoint for the DNS resolver.")
      @path
      outboundEndpointName: string;

      @doc("""
ETag of the resource. Omit this value to always overwrite the current resource.
Specify the last-seen ETag value to prevent accidentally overwriting any
concurrent changes.
""")
      @header
      `If-Match`: string;

      @doc("""
Set to '*' to allow a new resource to be created, but to prevent updating an
existing resource. Other values will be ignored.
""")
      @header
      `If-None-Match`: string;

      @doc("Parameters supplied to the CreateOrUpdate operation.")
      @body
      parameters: OutboundEndpoint;
    },
    OutboundEndpoint | void
  >;

  @doc("Updates an outbound endpoint for a DNS resolver.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/dnsResolvers/{dnsResolverName}/outboundEndpoints/{outboundEndpointName}")
  @patch
  Update is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of the DNS resolver.")
      @path
      dnsResolverName: string;

      @doc("The name of the outbound endpoint for the DNS resolver.")
      @path
      outboundEndpointName: string;

      @doc("""
ETag of the resource. Omit this value to always overwrite the current resource.
Specify the last-seen ETag value to prevent accidentally overwriting any
concurrent changes.
""")
      @header
      `If-Match`: string;

      @doc("Parameters supplied to the Update operation.")
      @body
      parameters: OutboundEndpointPatch;
    },
    OutboundEndpoint | void
  >;

  @doc("""
Deletes an outbound endpoint for a DNS resolver. WARNING: This operation cannot
be undone.
""")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/dnsResolvers/{dnsResolverName}/outboundEndpoints/{outboundEndpointName}")
  @delete
  Delete is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of the DNS resolver.")
      @path
      dnsResolverName: string;

      @doc("The name of the outbound endpoint for the DNS resolver.")
      @path
      outboundEndpointName: string;

      @doc("""
ETag of the resource. Omit this value to always overwrite the current resource.
Specify the last-seen ETag value to prevent accidentally overwriting any
concurrent changes.
""")
      @header
      `If-Match`: string;
    },
    void
  >;

  @doc("Gets properties of an outbound endpoint for a DNS resolver.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/dnsResolvers/{dnsResolverName}/outboundEndpoints/{outboundEndpointName}")
  @get
  Get is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of the DNS resolver.")
      @path
      dnsResolverName: string;

      @doc("The name of the outbound endpoint for the DNS resolver.")
      @path
      outboundEndpointName: string;
    },
    OutboundEndpoint
  >;

  @doc("Lists outbound endpoints for a DNS resolver.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/dnsResolvers/{dnsResolverName}/outboundEndpoints")
  @get
  List is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of the DNS resolver.")
      @path
      dnsResolverName: string;

      @doc("""
The maximum number of results to return. If not specified, returns up to 100
results.
""")
      @query
      $top: int32;
    },
    OutboundEndpointListResult
  >;
}

interface DnsForwardingRulesetsOperations {
  @doc("Creates or updates a DNS forwarding ruleset.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/dnsForwardingRulesets/{dnsForwardingRulesetName}")
  @put
  CreateOrUpdate is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of the DNS forwarding ruleset.")
      @path
      dnsForwardingRulesetName: string;

      @doc("""
ETag of the resource. Omit this value to always overwrite the current resource.
Specify the last-seen ETag value to prevent accidentally overwriting any
concurrent changes.
""")
      @header
      `If-Match`: string;

      @doc("""
Set to '*' to allow a new resource to be created, but to prevent updating an
existing resource. Other values will be ignored.
""")
      @header
      `If-None-Match`: string;

      @doc("Parameters supplied to the CreateOrUpdate operation.")
      @body
      parameters: DnsForwardingRuleset;
    },
    DnsForwardingRuleset | void
  >;

  @doc("Updates a DNS forwarding ruleset.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/dnsForwardingRulesets/{dnsForwardingRulesetName}")
  @patch
  Update is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of the DNS forwarding ruleset.")
      @path
      dnsForwardingRulesetName: string;

      @doc("""
ETag of the resource. Omit this value to always overwrite the current resource.
Specify the last-seen ETag value to prevent accidentally overwriting any
concurrent changes.
""")
      @header
      `If-Match`: string;

      @doc("Parameters supplied to the Update operation.")
      @body
      parameters: DnsForwardingRulesetPatch;
    },
    DnsForwardingRuleset | void
  >;

  @doc("""
Deletes a DNS forwarding ruleset. WARNING: This operation cannot be undone. All
forwarding rules within the ruleset will be deleted.
""")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/dnsForwardingRulesets/{dnsForwardingRulesetName}")
  @delete
  Delete is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of the DNS forwarding ruleset.")
      @path
      dnsForwardingRulesetName: string;

      @doc("""
ETag of the resource. Omit this value to always overwrite the current resource.
Specify the last-seen ETag value to prevent accidentally overwriting any
concurrent changes.
""")
      @header
      `If-Match`: string;
    },
    void
  >;

  @doc("Gets a DNS forwarding ruleset properties.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/dnsForwardingRulesets/{dnsForwardingRulesetName}")
  @get
  Get is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of the DNS forwarding ruleset.")
      @path
      dnsForwardingRulesetName: string;
    },
    DnsForwardingRuleset
  >;

  @doc("Lists DNS forwarding rulesets within a resource group.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/dnsForwardingRulesets")
  @get
  ListByResourceGroup is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("""
The maximum number of results to return. If not specified, returns up to 100
results.
""")
      @query
      $top: int32;
    },
    DnsForwardingRulesetListResult
  >;

  @doc("Lists DNS forwarding rulesets in all resource groups of a subscription.")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.Network/dnsForwardingRulesets")
  @get
  List is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("""
The maximum number of results to return. If not specified, returns up to 100
results.
""")
      @query
      $top: int32;
    },
    DnsForwardingRulesetListResult
  >;

  @doc("Lists DNS forwarding ruleset resource IDs attached to a virtual network.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/virtualNetworks/{virtualNetworkName}/listDnsForwardingRulesets")
  @post
  ListByVirtualNetwork is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of the virtual network.")
      @path
      virtualNetworkName: string;

      @doc("""
The maximum number of results to return. If not specified, returns up to 100
results.
""")
      @query
      $top: int32;
    },
    VirtualNetworkDnsForwardingRulesetListResult
  >;
}

interface ForwardingRulesOperations {
  @doc("Creates or updates a forwarding rule in a DNS forwarding ruleset.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/dnsForwardingRulesets/{dnsForwardingRulesetName}/forwardingRules/{forwardingRuleName}")
  @put
  CreateOrUpdate is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of the DNS forwarding ruleset.")
      @path
      dnsForwardingRulesetName: string;

      @doc("The name of the forwarding rule.")
      @path
      forwardingRuleName: string;

      @doc("""
ETag of the resource. Omit this value to always overwrite the current resource.
Specify the last-seen ETag value to prevent accidentally overwriting any
concurrent changes.
""")
      @header
      `If-Match`: string;

      @doc("""
Set to '*' to allow a new resource to be created, but to prevent updating an
existing resource. Other values will be ignored.
""")
      @header
      `If-None-Match`: string;

      @doc("Parameters supplied to the CreateOrUpdate operation.")
      @body
      parameters: ForwardingRule;
    },
    ForwardingRule
  >;

  @doc("Updates a forwarding rule in a DNS forwarding ruleset.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/dnsForwardingRulesets/{dnsForwardingRulesetName}/forwardingRules/{forwardingRuleName}")
  @patch
  Update is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of the DNS forwarding ruleset.")
      @path
      dnsForwardingRulesetName: string;

      @doc("The name of the forwarding rule.")
      @path
      forwardingRuleName: string;

      @doc("""
ETag of the resource. Omit this value to always overwrite the current resource.
Specify the last-seen ETag value to prevent accidentally overwriting any
concurrent changes.
""")
      @header
      `If-Match`: string;

      @doc("Parameters supplied to the Update operation.")
      @body
      parameters: ForwardingRulePatch;
    },
    ForwardingRule
  >;

  @doc("""
Deletes a forwarding rule in a DNS forwarding ruleset. WARNING: This operation
cannot be undone.
""")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/dnsForwardingRulesets/{dnsForwardingRulesetName}/forwardingRules/{forwardingRuleName}")
  @delete
  Delete is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of the DNS forwarding ruleset.")
      @path
      dnsForwardingRulesetName: string;

      @doc("The name of the forwarding rule.")
      @path
      forwardingRuleName: string;

      @doc("""
ETag of the resource. Omit this value to always overwrite the current resource.
Specify the last-seen ETag value to prevent accidentally overwriting any
concurrent changes.
""")
      @header
      `If-Match`: string;
    },
    void
  >;

  @doc("Gets properties of a forwarding rule in a DNS forwarding ruleset.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/dnsForwardingRulesets/{dnsForwardingRulesetName}/forwardingRules/{forwardingRuleName}")
  @get
  Get is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of the DNS forwarding ruleset.")
      @path
      dnsForwardingRulesetName: string;

      @doc("The name of the forwarding rule.")
      @path
      forwardingRuleName: string;
    },
    ForwardingRule
  >;

  @doc("Lists forwarding rules in a DNS forwarding ruleset.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/dnsForwardingRulesets/{dnsForwardingRulesetName}/forwardingRules")
  @get
  List is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of the DNS forwarding ruleset.")
      @path
      dnsForwardingRulesetName: string;

      @doc("""
The maximum number of results to return. If not specified, returns up to 100
results.
""")
      @query
      $top: int32;
    },
    ForwardingRuleListResult
  >;
}

interface VirtualNetworkLinksOperations {
  @doc("Creates or updates a virtual network link to a DNS forwarding ruleset.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/dnsForwardingRulesets/{dnsForwardingRulesetName}/virtualNetworkLinks/{virtualNetworkLinkName}")
  @put
  CreateOrUpdate is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of the DNS forwarding ruleset.")
      @path
      dnsForwardingRulesetName: string;

      @doc("The name of the virtual network link.")
      @path
      virtualNetworkLinkName: string;

      @doc("""
ETag of the resource. Omit this value to always overwrite the current resource.
Specify the last-seen ETag value to prevent accidentally overwriting any
concurrent changes.
""")
      @header
      `If-Match`: string;

      @doc("""
Set to '*' to allow a new resource to be created, but to prevent updating an
existing resource. Other values will be ignored.
""")
      @header
      `If-None-Match`: string;

      @doc("Parameters supplied to the CreateOrUpdate operation.")
      @body
      parameters: VirtualNetworkLink;
    },
    VirtualNetworkLink | void
  >;

  @doc("Updates a virtual network link to a DNS forwarding ruleset.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/dnsForwardingRulesets/{dnsForwardingRulesetName}/virtualNetworkLinks/{virtualNetworkLinkName}")
  @patch
  Update is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of the DNS forwarding ruleset.")
      @path
      dnsForwardingRulesetName: string;

      @doc("The name of the virtual network link.")
      @path
      virtualNetworkLinkName: string;

      @doc("""
ETag of the resource. Omit this value to always overwrite the current resource.
Specify the last-seen ETag value to prevent accidentally overwriting any
concurrent changes.
""")
      @header
      `If-Match`: string;

      @doc("Parameters supplied to the Update operation.")
      @body
      parameters: VirtualNetworkLinkPatch;
    },
    VirtualNetworkLink | void
  >;

  @doc("""
Deletes a virtual network link to a DNS forwarding ruleset. WARNING: This
operation cannot be undone.
""")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/dnsForwardingRulesets/{dnsForwardingRulesetName}/virtualNetworkLinks/{virtualNetworkLinkName}")
  @delete
  Delete is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of the DNS forwarding ruleset.")
      @path
      dnsForwardingRulesetName: string;

      @doc("The name of the virtual network link.")
      @path
      virtualNetworkLinkName: string;

      @doc("""
ETag of the resource. Omit this value to always overwrite the current resource.
Specify the last-seen ETag value to prevent accidentally overwriting any
concurrent changes.
""")
      @header
      `If-Match`: string;
    },
    void
  >;

  @doc("Gets properties of a virtual network link to a DNS forwarding ruleset.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/dnsForwardingRulesets/{dnsForwardingRulesetName}/virtualNetworkLinks/{virtualNetworkLinkName}")
  @get
  Get is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of the DNS forwarding ruleset.")
      @path
      dnsForwardingRulesetName: string;

      @doc("The name of the virtual network link.")
      @path
      virtualNetworkLinkName: string;
    },
    VirtualNetworkLink
  >;

  @doc("Lists virtual network links to a DNS forwarding ruleset.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/dnsForwardingRulesets/{dnsForwardingRulesetName}/virtualNetworkLinks")
  @get
  List is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of the DNS forwarding ruleset.")
      @path
      dnsForwardingRulesetName: string;

      @doc("""
The maximum number of results to return. If not specified, returns up to 100
results.
""")
      @query
      $top: int32;
    },
    VirtualNetworkLinkListResult
  >;
}

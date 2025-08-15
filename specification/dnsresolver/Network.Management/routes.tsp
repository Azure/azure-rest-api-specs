// FIXME: Operations in this file are not detected as a resource operation, please confirm the conversion result manually

import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using TypeSpec.OpenAPI;

namespace Microsoft.Network;

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
interface DnsResolversOperationGroup {
  /**
   * Lists DNS resolver resource IDs linked to a virtual network.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("DnsResolvers_ListByVirtualNetwork")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/virtualNetworks/{virtualNetworkName}/listDnsResolvers")
  @post
  listByVirtualNetwork(
    ...ApiVersionParameter,
    ...SubscriptionIdParameter,
    ...ResourceGroupParameter,

    /**
     * The name of the virtual network.
     */
    @path
    virtualNetworkName: string,

    /**
     * The maximum number of results to return. If not specified, returns up to 100 results.
     */
    @query("$top")
    $top?: int32,
  ): ArmResponse<SubResourceListResult> | CloudError;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
interface DnsForwardingRulesetsOperationGroup {
  /**
   * Lists DNS forwarding ruleset resource IDs attached to a virtual network.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("DnsForwardingRulesets_ListByVirtualNetwork")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/virtualNetworks/{virtualNetworkName}/listDnsForwardingRulesets")
  @post
  listByVirtualNetwork(
    ...ApiVersionParameter,
    ...SubscriptionIdParameter,
    ...ResourceGroupParameter,

    /**
     * The name of the virtual network.
     */
    @path
    virtualNetworkName: string,

    /**
     * The maximum number of results to return. If not specified, returns up to 100 results.
     */
    @query("$top")
    $top?: int32,
  ): ArmResponse<VirtualNetworkDnsForwardingRulesetListResult> | CloudError;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
interface DnsResolverPoliciesOperationGroup {
  /**
   * Lists DNS resolver policy resource IDs linked to a virtual network.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("DnsResolverPolicies_ListByVirtualNetwork")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/virtualNetworks/{virtualNetworkName}/listDnsResolverPolicies")
  @post
  listByVirtualNetwork(
    ...ApiVersionParameter,
    ...SubscriptionIdParameter,
    ...ResourceGroupParameter,

    /**
     * The name of the virtual network.
     */
    @path
    virtualNetworkName: string,
  ): ArmResponse<SubResourceListResult> | ErrorResponse;
}

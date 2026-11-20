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

/** Externally defined VirtualNetwork */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-custom-resource-usage-discourage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@armVirtualResource
@Azure.ResourceManager.Legacy.customAzureResource
model VirtualNetwork {
  ...ResourceNameParameter<
    VirtualNetwork,
    KeyName = "virtualNetworkName",
    SegmentName = "virtualNetworks",
    NamePattern = ""
  >;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
interface DnsResolversOperationGroup {
  /**
   * Lists DNS resolver resource IDs linked to a virtual network.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @action("listDnsResolvers")
  @list
  listByVirtualNetwork is ArmResourceActionSync<
    VirtualNetwork,
    void,
    SubResourceListResult,
    Parameters = {
      /**
       * The maximum number of results to return. If not specified, returns up to 100 results.
       */
      @query("$top")
      $top?: int32;
    },
    Error = CloudError
  >;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
interface DnsForwardingRulesetsOperationGroup {
  /**
   * Lists DNS forwarding ruleset resource IDs attached to a virtual network.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @action("listDnsForwardingRulesets")
  @list
  listByVirtualNetwork is ArmResourceActionSync<
    VirtualNetwork,
    void,
    VirtualNetworkDnsForwardingRulesetListResult,
    Parameters = {
      /**
       * The maximum number of results to return. If not specified, returns up to 100 results.
       */
      @query("$top")
      $top?: int32;
    },
    Error = CloudError
  >;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
interface DnsResolverPoliciesOperationGroup {
  /**
   * Lists DNS resolver policy resource IDs linked to a virtual network.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @action("listDnsResolverPolicies")
  @list
  listByVirtualNetwork is ArmResourceActionSync<
    VirtualNetwork,
    void,
    SubResourceListResult
  >;
}

import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "../Common/OutboundRule.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using Microsoft.Common;

namespace Microsoft.Network;

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.loadBalancer)
@armResourceOperations(#{ omitTags: true })
interface OutboundRules {
  /**
   * Gets the specified load balancer outbound rule.
   */
  @tag("LoadBalancers")
  get is ArmResourceRead<OutboundRule, Error = CloudError>;

  /**
   * Gets all the outbound rules in a load balancer.
   */
  @tag("LoadBalancers")
  list is ArmResourceListByParent<
    OutboundRule,
    Response = LoadBalancerOutboundRuleListResult,
    Error = CloudError
  >;
}

@@doc(OutboundRule.name, "The name of the outbound rule.");
@@doc(OutboundRule.properties, "Properties of load balancer outbound rule.");

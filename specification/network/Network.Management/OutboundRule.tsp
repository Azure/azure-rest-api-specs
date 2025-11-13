import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./LoadBalancer.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Network;
/**
 * Outbound rule of the load balancer.
 */
@parentResource(LoadBalancer)
model OutboundRule
  is Azure.ResourceManager.ProxyResource<OutboundRulePropertiesFormat> {
  ...ResourceNameParameter<
    Resource = OutboundRule,
    KeyName = "outboundRuleName",
    SegmentName = "outboundRules",
    NamePattern = ""
  >;
  ...Azure.ResourceManager.Legacy.EntityTagProperty;
}

@armResourceOperations
interface OutboundRules {
  /**
   * Gets the specified load balancer outbound rule.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("LoadBalancerOutboundRules_Get")
  get is ArmResourceRead<OutboundRule>;

  /**
   * Gets all the outbound rules in a load balancer.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("LoadBalancerOutboundRules_List")
  list is ArmResourceListByParent<OutboundRule>;
}

@@doc(OutboundRule.name, "The name of the outbound rule.");
@@doc(OutboundRule.properties, "Properties of load balancer outbound rule.");

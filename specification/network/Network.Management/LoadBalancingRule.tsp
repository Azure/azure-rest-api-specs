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
 * A load balancing rule for a load balancer.
 */
@parentResource(LoadBalancer)
model LoadBalancingRule
  is Azure.ResourceManager.ProxyResource<LoadBalancingRulePropertiesFormat> {
  ...ResourceNameParameter<
    Resource = LoadBalancingRule,
    KeyName = "loadBalancingRuleName",
    SegmentName = "loadBalancingRules",
    NamePattern = ""
  >;
  ...Azure.ResourceManager.Legacy.EntityTagProperty;
}

@armResourceOperations
interface LoadBalancingRules {
  /**
   * Gets the specified load balancer load balancing rule.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("LoadBalancerLoadBalancingRules_Get")
  get is ArmResourceRead<LoadBalancingRule>;

  /**
   * Gets all the load balancing rules in a load balancer.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("LoadBalancerLoadBalancingRules_List")
  list is ArmResourceListByParent<LoadBalancingRule>;

  /**
   * Get health details of a load balancing rule.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("LoadBalancerLoadBalancingRules_Health")
  health is ArmResourceActionAsync<
    LoadBalancingRule,
    void,
    ArmResponse<LoadBalancerHealthPerRule>,
    Parameters = {
      /**
       * The name of the resource group.
       */
      @pattern("^[a-zA-Z0-9_.-]*$")
      @path
      groupName: string;
    }
  >;
}

@@doc(LoadBalancingRule.name, "The name of the load balancing rule.");
@@doc(LoadBalancingRule.properties,
  "Properties of load balancer load balancing rule."
);

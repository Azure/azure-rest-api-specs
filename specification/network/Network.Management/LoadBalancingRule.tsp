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

alias LoadBalancerLoadBalancingRuleOps = Azure.ResourceManager.Legacy.LegacyOperations<
  {
    ...ApiVersionParameter;
    ...SubscriptionIdParameter;

    @path
    @segment("resourceGroups")
    groupName: string;

    ...Azure.ResourceManager.Legacy.Provider;

    /** The name of the load balancer. */
    @path
    @segment("loadBalancers")
    @key
    loadBalancerName: string;
  },
  {
    /** The name of the load balancing rule. */
    @path
    @segment("loadBalancingRules")
    @key
    loadBalancingRuleName: string;
  }
>;

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
  health is LoadBalancerLoadBalancingRuleOps.ActionAsync<
    LoadBalancingRule,
    void,
    ArmResponse<LoadBalancerHealthPerRule>
  >;
}

@@doc(LoadBalancingRule.name, "The name of the load balancing rule.");
@@doc(LoadBalancingRule.properties,
  "Properties of load balancer load balancing rule."
);

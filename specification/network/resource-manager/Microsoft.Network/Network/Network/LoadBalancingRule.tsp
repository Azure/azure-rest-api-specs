import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "../Common/LoadBalancingRule.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using Common;

namespace Microsoft.Network;

alias LoadBalancerLoadBalancingRuleOps = Azure.ResourceManager.Legacy.LegacyOperations<
  {
    ...ApiVersionParameter;
    ...SubscriptionIdParameter;

    #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
    @path
    @segment("resourceGroups")
    @pattern("^[a-zA-Z0-9_.-]*$")
    groupName: string;

    ...Azure.ResourceManager.Legacy.Provider;

    /** The name of the load balancer. */
    @path
    @segment("loadBalancers")
    @key
    @pattern("^[a-zA-Z0-9_.-]*$")
    loadBalancerName: string;
  },
  {
    /** The name of the load balancing rule. */
    @path
    @segment("loadBalancingRules")
    @key
    @pattern("^[a-zA-Z0-9_.-]*$")
    loadBalancingRuleName: string;
  }
>;

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.loadBalancer)
@armResourceOperations(#{ omitTags: true })
interface LoadBalancingRules {
  /**
   * Gets the specified load balancer load balancing rule.
   */
  @tag("LoadBalancers")
  get is ArmResourceRead<LoadBalancingRule, Error = CloudError>;

  /**
   * Gets all the load balancing rules in a load balancer.
   */
  @tag("LoadBalancers")
  list is ArmResourceListByParent<
    LoadBalancingRule,
    Response = LoadBalancerLoadBalancingRuleListResult,
    Error = CloudError
  >;

  /**
   * Get health details of a load balancing rule.
   */
  @tag("LoadBalancers")
  health is LoadBalancerLoadBalancingRuleOps.ActionAsync<
    LoadBalancingRule,
    void,
    LoadBalancerHealthPerRule,
    OverrideErrorType = CloudError
  >;
}

@@doc(LoadBalancingRule.name, "The name of the load balancing rule.");
@@doc(LoadBalancingRule.properties,
  "Properties of load balancer load balancing rule."
);

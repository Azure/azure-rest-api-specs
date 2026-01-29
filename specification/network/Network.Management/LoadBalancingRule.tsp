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
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-private-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-custom-resource-usage-discourage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.loadBalancer)
@parentResource(LoadBalancer)
@Http.Private.includeInapplicableMetadataInPayload(false)
model LoadBalancingRule extends SubResourceModel {
  properties?: LoadBalancingRulePropertiesFormat;

  @visibility(Lifecycle.Read)
  @path
  @key("loadBalancingRuleName")
  @segment("loadBalancingRules")
  name: string;

  /** A unique read-only string that changes whenever the resource is updated. */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  etag?: string;
}

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

@armResourceOperations
interface LoadBalancingRules {
  /**
   * Gets the specified load balancer load balancing rule.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("LoadBalancerLoadBalancingRules_Get")
  get is ArmResourceRead<LoadBalancingRule, Error = CloudError>;

  /**
   * Gets all the load balancing rules in a load balancer.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("LoadBalancerLoadBalancingRules_List")
  list is ArmResourceListByParent<
    LoadBalancingRule,
    Response = LoadBalancerLoadBalancingRuleListResult,
    Error = CloudError
  >;

  /**
   * Get health details of a load balancing rule.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("LoadBalancerLoadBalancingRules_Health")
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

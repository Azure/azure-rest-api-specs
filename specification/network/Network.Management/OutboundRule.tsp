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
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-private-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-custom-resource-usage-discourage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.loadBalancer)
@parentResource(LoadBalancer)
@Http.Private.includeInapplicableMetadataInPayload(false)
model OutboundRule extends SubResourceModel {
  properties?: OutboundRulePropertiesFormat;

  @visibility(Lifecycle.Read)
  @path
  @key("outboundRuleName")
  @segment("outboundRules")
  name: string;

  /**
   * A unique read-only string that changes whenever the resource is updated.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  etag?: string;
}

@@doc(OutboundRule.name,
  "The name of the resource that is unique within the set of outbound rules used by the load balancer. This name can be used to access the resource."
);

@armResourceOperations
interface OutboundRules {
  /**
   * Gets the specified load balancer outbound rule.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("LoadBalancerOutboundRules_Get")
  get is ArmResourceRead<OutboundRule, Error = CloudError>;

  /**
   * Gets all the outbound rules in a load balancer.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("LoadBalancerOutboundRules_List")
  list is ArmResourceListByParent<
    OutboundRule,
    Response = LoadBalancerOutboundRuleListResult,
    Error = CloudError
  >;
}

@@doc(OutboundRule.name, "The name of the outbound rule.");
@@doc(OutboundRule.properties, "Properties of load balancer outbound rule.");

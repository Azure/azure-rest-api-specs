import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./LoadBalancer.tsp";
import "../Common/InboundNatRule.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using Microsoft.Common;

namespace Microsoft.Network;

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.loadBalancer)
@armResourceOperations(#{ omitTags: true })
interface InboundNatRules {
  /**
   * Gets the specified load balancer inbound NAT rule.
   */
  @tag("LoadBalancers")
  get is ArmResourceRead<
    InboundNatRule,
    Parameters = {
      /**
       * Expands referenced resources.
       */
      @query("$expand")
      $expand?: string;
    },
    Error = CloudError
  >;

  /**
   * Creates or updates a load balancer inbound NAT rule.
   */
  @tag("LoadBalancers")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    InboundNatRule,
    Error = CloudError
  >;

  /**
   * Deletes the specified load balancer inbound NAT rule.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @tag("LoadBalancers")
  delete is ArmResourceDeleteWithoutOkAsync<
    InboundNatRule,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse,
    Error = CloudError
  >;

  /**
   * Gets all the inbound NAT rules in a load balancer.
   */
  @tag("LoadBalancers")
  list is ArmResourceListByParent<InboundNatRule, Error = CloudError>;
}

@@doc(InboundNatRule.name, "The name of the inbound NAT rule.");
@@doc(InboundNatRule.properties,
  "Properties of load balancer inbound NAT rule."
);
@@doc(InboundNatRules.createOrUpdate::parameters.resource,
  "Parameters supplied to the create or update inbound NAT rule operation."
);

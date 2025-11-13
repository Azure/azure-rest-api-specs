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
 * Inbound NAT rule of the load balancer.
 */
@parentResource(LoadBalancer)
model InboundNatRule
  is Azure.ResourceManager.ProxyResource<InboundNatRulePropertiesFormat> {
  ...ResourceNameParameter<
    Resource = InboundNatRule,
    KeyName = "inboundNatRuleName",
    SegmentName = "inboundNatRules",
    NamePattern = ""
  >;
  ...Azure.ResourceManager.Legacy.EntityTagProperty;
}

@armResourceOperations
interface InboundNatRules {
  /**
   * Gets the specified load balancer inbound NAT rule.
   */
  get is ArmResourceRead<
    InboundNatRule,
    Parameters = {
      /**
       * Expands referenced resources.
       */
      @query("$expand")
      $expand?: string;
    }
  >;

  /**
   * Creates or updates a load balancer inbound NAT rule.
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<InboundNatRule>;

  /**
   * Deletes the specified load balancer inbound NAT rule.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  delete is ArmResourceDeleteWithoutOkAsync<
    InboundNatRule,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse
  >;

  /**
   * Gets all the inbound NAT rules in a load balancer.
   */
  list is ArmResourceListByParent<InboundNatRule>;
}

@@doc(InboundNatRule.name, "The name of the inbound NAT rule.");
@@doc(InboundNatRule.properties,
  "Properties of load balancer inbound NAT rule."
);
@@doc(InboundNatRules.createOrUpdate::parameters.resource,
  "Parameters supplied to the create or update inbound NAT rule operation."
);

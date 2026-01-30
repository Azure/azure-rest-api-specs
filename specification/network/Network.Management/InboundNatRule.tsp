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
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-private-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-custom-resource-usage-discourage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.loadBalancer)
@parentResource(LoadBalancer)
@Http.Private.includeInapplicableMetadataInPayload(false)
model InboundNatRule extends SubResourceModel {
  properties?: InboundNatRulePropertiesFormat;

  @visibility(Lifecycle.Read)
  @path
  @key("inboundNatRuleName")
  @segment("inboundNatRules")
  name: string;

  /** A unique read-only string that changes whenever the resource is updated. */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  etag?: string;
}

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.loadBalancer)
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
    },
    Error = CloudError
  >;

  /**
   * Creates or updates a load balancer inbound NAT rule.
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    InboundNatRule,
    Error = CloudError
  >;

  /**
   * Deletes the specified load balancer inbound NAT rule.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  delete is ArmResourceDeleteWithoutOkAsync<
    InboundNatRule,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse,
    Error = CloudError
  >;

  /**
   * Gets all the inbound NAT rules in a load balancer.
   */
  list is ArmResourceListByParent<InboundNatRule, Error = CloudError>;
}

@@doc(InboundNatRule.name, "The name of the inbound NAT rule.");
@@doc(InboundNatRule.properties,
  "Properties of load balancer inbound NAT rule."
);
@@doc(InboundNatRules.createOrUpdate::parameters.resource,
  "Parameters supplied to the create or update inbound NAT rule operation."
);

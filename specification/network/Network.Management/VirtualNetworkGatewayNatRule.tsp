import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./VirtualNetworkGateway.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Network;
/**
 * VirtualNetworkGatewayNatRule Resource.
 */
#suppress "@azure-tools/typespec-azure-core/no-private-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-custom-resource-usage-discourage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.networkGateway)
@parentResource(VirtualNetworkGateway)
@Http.Private.includeInapplicableMetadataInPayload(false)
model VirtualNetworkGatewayNatRule extends SubResourceModel {
  properties?: VirtualNetworkGatewayNatRuleProperties;

  /**
   * The name of the resource that is unique within a resource group. This name can be used to access the resource.
   */
  @visibility(Lifecycle.Read)
  @path
  @key("natRuleName")
  @segment("natRules")
  name: string;

  /**
   * A unique read-only string that changes whenever the resource is updated.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  etag?: string;
}

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.networkGateway)
@armResourceOperations
interface VirtualNetworkGatewayNatRules {
  /**
   * Retrieves the details of a nat rule.
   */
  get is ArmResourceRead<VirtualNetworkGatewayNatRule, Error = CloudError>;

  /**
   * Creates a nat rule to a scalable virtual network gateway if it doesn't exist else updates the existing nat rules.
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    VirtualNetworkGatewayNatRule,
    Error = CloudError
  >;

  /**
   * Deletes a nat rule.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  delete is ArmResourceDeleteWithoutOkAsync<
    VirtualNetworkGatewayNatRule,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse,
    Error = CloudError
  >;

  /**
   * Retrieves all nat rules for a particular virtual network gateway.
   */
  listByVirtualNetworkGateway is ArmResourceListByParent<
    VirtualNetworkGatewayNatRule,
    Response = ArmResponse<ListVirtualNetworkGatewayNatRulesResult>,
    Error = CloudError
  >;
}

@@doc(VirtualNetworkGatewayNatRule.name,
  "The name of the resource that is unique within a resource group. This name can be used to access the resource."
);
@@doc(VirtualNetworkGatewayNatRule.properties,
  "Properties of the Virtual Network Gateway NAT rule."
);
@@doc(VirtualNetworkGatewayNatRules.createOrUpdate::parameters.resource,
  "Parameters supplied to create or Update a Nat Rule."
);

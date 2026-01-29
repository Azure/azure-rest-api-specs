import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./VpnGateway.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Network;
/**
 * VpnGatewayNatRule Resource.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-private-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-custom-resource-usage-discourage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.virtualWAN)
@parentResource(VpnGateway)
@Http.Private.includeInapplicableMetadataInPayload(false)
model VpnGatewayNatRule extends SubResourceModel {
  properties?: VpnGatewayNatRuleProperties;

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

@armResourceOperations
interface VpnGatewayNatRules {
  /**
   * Retrieves the details of a nat ruleGet.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("NatRules_Get")
  get is ArmResourceRead<VpnGatewayNatRule, Error = CloudError>;

  /**
   * Creates a nat rule to a scalable vpn gateway if it doesn't exist else updates the existing nat rules.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("NatRules_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    VpnGatewayNatRule,
    Error = CloudError
  >;

  /**
   * Deletes a nat rule.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("NatRules_Delete")
  delete is ArmResourceDeleteWithoutOkAsync<
    VpnGatewayNatRule,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse,
    Error = CloudError
  >;

  /**
   * Retrieves all nat rules for a particular virtual wan vpn gateway.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("NatRules_ListByVpnGateway")
  listByVpnGateway is ArmResourceListByParent<
    VpnGatewayNatRule,
    Response = ArmResponse<ListVpnGatewayNatRulesResult>,
    Error = CloudError
  >;
}

@@doc(VpnGatewayNatRule.name,
  "The name of the resource that is unique within a resource group. This name can be used to access the resource."
);
@@doc(VpnGatewayNatRule.properties, "Properties of the VpnGateway NAT rule.");
@@doc(VpnGatewayNatRules.createOrUpdate::parameters.resource,
  "Parameters supplied to create or Update a Nat Rule."
);

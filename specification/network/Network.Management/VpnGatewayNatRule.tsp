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
@parentResource(VpnGateway)
model VpnGatewayNatRule
  is Azure.ResourceManager.ProxyResource<VpnGatewayNatRuleProperties> {
  ...ResourceNameParameter<
    Resource = VpnGatewayNatRule,
    KeyName = "natRuleName",
    SegmentName = "natRules",
    NamePattern = ""
  >;
  ...Azure.ResourceManager.Legacy.EntityTagProperty;
}

@armResourceOperations
interface VpnGatewayNatRules {
  /**
   * Retrieves the details of a nat ruleGet.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("NatRules_Get")
  get is ArmResourceRead<VpnGatewayNatRule>;

  /**
   * Creates a nat rule to a scalable vpn gateway if it doesn't exist else updates the existing nat rules.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("NatRules_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<VpnGatewayNatRule>;

  /**
   * Deletes a nat rule.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  @operationId("NatRules_Delete")
  delete is ArmResourceDeleteWithoutOkAsync<
    VpnGatewayNatRule,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse
  >;

  /**
   * Retrieves all nat rules for a particular virtual wan vpn gateway.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("NatRules_ListByVpnGateway")
  listByVpnGateway is ArmResourceListByParent<
    VpnGatewayNatRule,
    Response = ArmResponse<ListVpnGatewayNatRulesResult>
  >;
}

@@doc(VpnGatewayNatRule.name, "The name of the nat rule.");
@@doc(VpnGatewayNatRule.properties, "Properties of the VpnGateway NAT rule.");
@@doc(VpnGatewayNatRules.createOrUpdate::parameters.resource,
  "Parameters supplied to create or Update a Nat Rule."
);

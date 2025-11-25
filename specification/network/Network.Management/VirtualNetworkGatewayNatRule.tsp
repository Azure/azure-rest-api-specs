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
@parentResource(VirtualNetworkGateway)
model VirtualNetworkGatewayNatRule
  is Azure.ResourceManager.ProxyResource<VirtualNetworkGatewayNatRuleProperties> {
  ...ResourceNameParameter<
    Resource = VirtualNetworkGatewayNatRule,
    KeyName = "natRuleName",
    SegmentName = "natRules",
    NamePattern = ""
  >;
  ...Azure.ResourceManager.Legacy.EntityTagProperty;
}

@armResourceOperations
interface VirtualNetworkGatewayNatRules {
  /**
   * Retrieves the details of a nat rule.
   */
  get is ArmResourceRead<VirtualNetworkGatewayNatRule, Error = CloudError>;

  /**
   * Creates a nat rule to a scalable virtual network gateway if it doesn't exist else updates the existing nat rules.
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<VirtualNetworkGatewayNatRule, Error = CloudError>;

  /**
   * Deletes a nat rule.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  delete is ArmResourceDeleteWithoutOkAsync<VirtualNetworkGatewayNatRule,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse,  Error = CloudError>;

  /**
   * Retrieves all nat rules for a particular virtual network gateway.
   */
  listByVirtualNetworkGateway is ArmResourceListByParent<VirtualNetworkGatewayNatRule,
    Response = ArmResponse<ListVirtualNetworkGatewayNatRulesResult>
  , Error = CloudError>;
}

@@doc(VirtualNetworkGatewayNatRule.name, "The name of the nat rule.");
@@doc(VirtualNetworkGatewayNatRule.properties,
  "Properties of the Virtual Network Gateway NAT rule."
);
@@doc(VirtualNetworkGatewayNatRules.createOrUpdate::parameters.resource,
  "Parameters supplied to create or Update a Nat Rule."
);

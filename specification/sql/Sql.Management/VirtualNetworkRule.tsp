import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Server.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Sql;
/**
 * A virtual network rule.
 */
@parentResource(Server)
model VirtualNetworkRule
  is Azure.ResourceManager.ProxyResource<VirtualNetworkRuleProperties> {
  ...ResourceNameParameter<
    Resource = VirtualNetworkRule,
    KeyName = "virtualNetworkRuleName",
    SegmentName = "virtualNetworkRules",
    NamePattern = ""
  >;
}

@armResourceOperations
interface VirtualNetworkRules {
  /**
   * Gets a virtual network rule.
   */
  get is ArmResourceRead<VirtualNetworkRule>;

  /**
   * Creates or updates an existing virtual network rule.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "For backward compatibility"
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    VirtualNetworkRule,
    Response = ArmResourceUpdatedResponse<VirtualNetworkRule> | ArmResourceCreatedResponse<
      VirtualNetworkRule,
      ArmLroLocationHeader<FinalResult = VirtualNetworkRule> &
        Azure.Core.Foundations.RetryAfterHeader
    > | ArmAcceptedLroResponse
  >;

  /**
   * Deletes the virtual network rule with the given name.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  delete is ArmResourceDeleteWithoutOkAsync<
    VirtualNetworkRule,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse
  >;

  /**
   * Gets a list of virtual network rules in a server.
   */
  listByServer is ArmResourceListByParent<VirtualNetworkRule>;
}

@@doc(VirtualNetworkRule.name, "The name of the virtual network rule.");
@@doc(VirtualNetworkRule.properties, "Resource properties.");
@@doc(VirtualNetworkRules.createOrUpdate::parameters.resource,
  "The requested virtual Network Rule Resource state."
);

import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./DataLakeStoreAccount.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.DataLakeStore;
/**
 * Data Lake Store virtual network rule information.
 */
@parentResource(DataLakeStoreAccount)
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
   * Gets the specified Data Lake Store virtual network rule.
   */
  get is ArmResourceRead<VirtualNetworkRule>;

  /**
   * Creates or updates the specified virtual network rule. During update, the virtual network rule with the specified name will be replaced with this new virtual network rule.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "For backward compatibility"
  createOrUpdate is ArmResourceCreateOrReplaceSync<
    VirtualNetworkRule,
    Response = ArmResourceUpdatedResponse<VirtualNetworkRule>
  >;

  /**
   * Updates the specified virtual network rule.
   */
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchSync<
    VirtualNetworkRule,
    PatchModel = UpdateVirtualNetworkRuleParameters
  >;

  /**
   * Deletes the specified virtual network rule from the specified Data Lake Store account.
   */
  delete is ArmResourceDeleteSync<VirtualNetworkRule>;

  /**
   * Lists the Data Lake Store virtual network rules within the specified Data Lake Store account.
   */
  listByAccount is ArmResourceListByParent<VirtualNetworkRule>;
}

@@doc(VirtualNetworkRule.name,
  "The name of the virtual network rule to retrieve."
);
@@doc(VirtualNetworkRule.properties, "The virtual network rule properties.");
@@doc(VirtualNetworkRules.createOrUpdate::parameters.resource,
  "Parameters supplied to create or update the virtual network rule."
);
@@doc(VirtualNetworkRules.update::parameters.properties,
  "Parameters supplied to update the virtual network rule."
);

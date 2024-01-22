import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./DataLakeStoreAccount.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.DataLakeStore;
/**
 * Data Lake Store virtual network rule information.
 */
@parentResource(DataLakeStoreAccount)
model VirtualNetworkRule is ProxyResource<VirtualNetworkRuleProperties> {
  /**
   * The name of the virtual network rule to retrieve.
   */
  @path
  @key("virtualNetworkRuleName")
  @segment("virtualNetworkRules")
  name: string;
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
  createOrUpdate is ArmResourceCreateOrReplaceSync<VirtualNetworkRule>;

  /**
   * Updates the specified virtual network rule.
   */
  @parameterVisibility("read")
  update is ArmCustomPatchSync<
    VirtualNetworkRule,
    UpdateVirtualNetworkRuleParameters
  >;

  /**
   * Deletes the specified virtual network rule from the specified Data Lake Store account.
   */
  delete is ArmResourceDeleteSync<VirtualNetworkRule>;

  /**
   * Lists the Data Lake Store virtual network rules within the specified Data Lake Store account.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("VirtualNetworkRules_ListByAccount")
  listByAccount is ArmResourceListByParent<VirtualNetworkRule>;
}

@@projectedName(VirtualNetworkRules.createOrUpdate::parameters.resource,
  "json",
  "parameters"
);
@@extension(VirtualNetworkRules.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "parameters"
);
@@doc(VirtualNetworkRules.createOrUpdate::parameters.resource,
  "Parameters supplied to create or update the virtual network rule."
);
@@projectedName(VirtualNetworkRules.update::parameters.properties,
  "json",
  "parameters"
);
@@extension(VirtualNetworkRules.update::parameters.properties,
  "x-ms-client-name",
  "parameters"
);
@@doc(VirtualNetworkRules.update::parameters.properties,
  "Parameters supplied to update the virtual network rule."
);

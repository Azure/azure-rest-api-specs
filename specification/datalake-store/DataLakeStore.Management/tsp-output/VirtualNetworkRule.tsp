import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./DataLakeStoreAccount.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.DataLakeStore;
@doc("Data Lake Store virtual network rule information.")
@parentResource(DataLakeStoreAccount)
model VirtualNetworkRule is ProxyResource<VirtualNetworkRuleProperties> {
  @doc("The name of the virtual network rule to retrieve.")
  @path
  @key("virtualNetworkRuleName")
  @segment("virtualNetworkRules")
  name: string;
}

@armResourceOperations
interface VirtualNetworkRules {
  @doc("Gets the specified Data Lake Store virtual network rule.")
  get is ArmResourceRead<VirtualNetworkRule>;
  @doc("Creates or updates the specified virtual network rule. During update, the virtual network rule with the specified name will be replaced with this new virtual network rule.")
  createOrUpdate is ArmResourceCreateOrReplaceSync<VirtualNetworkRule>;
  @doc("Updates the specified virtual network rule.")
  update is ArmResourcePatchSync<
    VirtualNetworkRule,
    VirtualNetworkRuleProperties
  >;
  @doc("Deletes the specified virtual network rule from the specified Data Lake Store account.")
  delete is ArmResourceDeleteSync<VirtualNetworkRule>;
  @doc("Lists the Data Lake Store virtual network rules within the specified Data Lake Store account.")
  listByAccount is ArmResourceListByParent<VirtualNetworkRule>;
}

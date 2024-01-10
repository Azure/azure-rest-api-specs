import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./Server.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Microsoft.Sql;
@doc("A virtual network rule.")
@parentResource(Server)
model VirtualNetworkRule is ProxyResource<VirtualNetworkRuleProperties> {
  @doc("The name of the virtual network rule.")
  @key("virtualNetworkRuleName")
  @segment("virtualNetworkRules")
  name: string;
}

@armResourceOperations
interface VirtualNetworkRules {
  @doc("Gets a virtual network rule.")
  get is ArmResourceRead<VirtualNetworkRule>;

  @doc("Creates or updates an existing virtual network rule.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<VirtualNetworkRule>;

  @doc("Deletes the virtual network rule with the given name.")
  delete is ArmResourceDeleteAsync<VirtualNetworkRule>;

  @doc("Gets a list of virtual network rules in a server.")
  listByServer is ArmResourceListByParent<VirtualNetworkRule>;
}

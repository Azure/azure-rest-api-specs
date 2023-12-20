import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./SqlServer.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.Sql;
@doc("A virtual network rule.")
@parentResource(SqlServer)
model SqlServerVirtualNetworkRule
  is ProxyResource<VirtualNetworkRuleProperties> {
  @doc("The name of the virtual network rule.")
  @path
  @key("virtualNetworkRuleName")
  @segment("virtualNetworkRules")
  name: string;
}

@armResourceOperations
interface SqlServerVirtualNetworkRules {
  @doc("Gets a virtual network rule.")
  get is ArmResourceRead<SqlServerVirtualNetworkRule>;
  @doc("Creates or updates an existing virtual network rule.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<SqlServerVirtualNetworkRule>;
  @doc("Deletes the virtual network rule with the given name.")
  delete is ArmResourceDeleteAsync<SqlServerVirtualNetworkRule>;
  @doc("Gets a list of virtual network rules in a server.")
  listByServer is ArmResourceListByParent<SqlServerVirtualNetworkRule>;
}

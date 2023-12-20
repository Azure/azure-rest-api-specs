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
@doc("A server connection policy")
@parentResource(SqlServer)
model SqlServerConnectionPolicy
  is ProxyResource<ServerConnectionPolicyProperties> {
  @doc("The name of the connection policy.")
  @path
  @key("connectionPolicyName")
  @segment("connectionPolicies")
  name: ConnectionPolicyName;

  ...Azure.ResourceManager.ResourceKind;
}

@armResourceOperations
interface SqlServerConnectionPolicies {
  @doc("Gets a server connection policy")
  get is ArmResourceRead<SqlServerConnectionPolicy>;
  @doc("Updates a server connection policy")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<SqlServerConnectionPolicy>;
  @doc("Lists connection policy")
  listByServer is ArmResourceListByParent<SqlServerConnectionPolicy>;
}

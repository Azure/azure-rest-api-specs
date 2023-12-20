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
@doc("A server key.")
@parentResource(SqlServer)
model SqlServerKey is ProxyResource<ServerKeyProperties> {
  @doc("The name of the server key to be retrieved.")
  @path
  @key("keyName")
  @segment("keys")
  name: string;

  ...Azure.ResourceManager.ResourceKind;
}

@armResourceOperations
interface SqlServerKeys {
  @doc("Gets a server key.")
  get is ArmResourceRead<SqlServerKey>;
  @doc("Creates or updates a server key.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<SqlServerKey>;
  @doc("Deletes the server key with the given name.")
  delete is ArmResourceDeleteAsync<SqlServerKey>;
  @doc("Gets a list of server keys.")
  listByServer is ArmResourceListByParent<SqlServerKey>;
}

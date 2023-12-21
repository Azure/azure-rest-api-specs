import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./Server.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.Sql;
@doc("A server key.")
@parentResource(Server)
model ServerKey is ProxyResource<ServerKeyProperties> {
  @doc("The name of the server key to be retrieved.")
  @path
  @key("keyName")
  @segment("keys")
  name: string;

  ...Azure.ResourceManager.ResourceKind;
}

@armResourceOperations
interface ServerKeys {
  @doc("Gets a server key.")
  get is ArmResourceRead<ServerKey>;
  @doc("Creates or updates a server key.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<ServerKey>;
  @doc("Deletes the server key with the given name.")
  delete is ArmResourceDeleteAsync<ServerKey>;
  @doc("Gets a list of server keys.")
  listByServer is ArmResourceListByParent<ServerKey>;
}

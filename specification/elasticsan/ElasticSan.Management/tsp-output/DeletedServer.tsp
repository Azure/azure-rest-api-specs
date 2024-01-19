import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Sql;
@doc("A deleted server.")
@locationResource
model DeletedServer is ProxyResource<DeletedServerProperties> {
  @doc("The name of the deleted server.")
  @path
  @key("deletedServerName")
  @segment("deletedServers")
  name: string;
}

@armResourceOperations
interface DeletedServers {
  @doc("Gets a deleted server.")
  get is ArmResourceRead<DeletedServer>;

  @doc("Gets a list of deleted servers for a location.")
  listByLocation is ArmResourceListByParent<DeletedServer>;

  @doc("Gets a list of all deleted servers in a subscription.")
  list is ArmListBySubscription<DeletedServer>;

  @doc("Recovers a deleted server.")
  recover is ArmResourceActionAsync<DeletedServer, void, DeletedServer>;
}

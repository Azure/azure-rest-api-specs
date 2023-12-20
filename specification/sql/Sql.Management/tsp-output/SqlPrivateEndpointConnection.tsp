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
@doc("A private endpoint connection")
@parentResource(SqlServer)
model SqlPrivateEndpointConnection
  is ProxyResource<PrivateEndpointConnectionProperties> {
  @doc("The name of the private endpoint connection.")
  @path
  @key("privateEndpointConnectionName")
  @segment("privateEndpointConnections")
  name: string;
}

@armResourceOperations
interface SqlPrivateEndpointConnections {
  @doc("Gets a private endpoint connection.")
  get is ArmResourceRead<SqlPrivateEndpointConnection>;
  @doc("Approve or reject a private endpoint connection with a given name.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<SqlPrivateEndpointConnection>;
  @doc("Deletes a private endpoint connection with a given name.")
  delete is ArmResourceDeleteAsync<SqlPrivateEndpointConnection>;
  @doc("Gets all private endpoint connections on a server.")
  listByServer is ArmResourceListByParent<SqlPrivateEndpointConnection>;
}

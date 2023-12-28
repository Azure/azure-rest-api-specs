import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./ManagedInstance.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.Sql;
@doc("A private endpoint connection")
@parentResource(ManagedInstance)
model ManagedInstancePrivateEndpointConnection
  is ProxyResource<ManagedInstancePrivateEndpointConnectionProperties> {
  @doc("The name of the private endpoint connection.")
  @key("privateEndpointConnectionName")
  @segment("privateEndpointConnections")
  name: string;
}

@armResourceOperations
interface ManagedInstancePrivateEndpointConnections {
  @doc("Gets a private endpoint connection.")
  get is ArmResourceRead<ManagedInstancePrivateEndpointConnection>;
  @doc("Approve or reject a private endpoint connection with a given name.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<ManagedInstancePrivateEndpointConnection>;
  @doc("Deletes a private endpoint connection with a given name.")
  delete is ArmResourceDeleteAsync<ManagedInstancePrivateEndpointConnection>;
  @doc("Gets all private endpoint connections on a server.")
  listByManagedInstance is ArmResourceListByParent<ManagedInstancePrivateEndpointConnection>;
}

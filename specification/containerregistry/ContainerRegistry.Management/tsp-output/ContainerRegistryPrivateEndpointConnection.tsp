import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./ContainerRegistry.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.ContainerRegistry;
@doc("An object that represents a private endpoint connection for a container registry.")
@parentResource(ContainerRegistry)
model ContainerRegistryPrivateEndpointConnection
  is ProxyResource<PrivateEndpointConnectionProperties> {
  @doc("The name of the private endpoint connection.")
  @path
  @key("privateEndpointConnectionName")
  @segment("privateEndpointConnections")
  name: string;
}

@armResourceOperations
interface ContainerRegistryPrivateEndpointConnections {
  @doc("Get the specified private endpoint connection associated with the container registry.")
  get is ArmResourceRead<ContainerRegistryPrivateEndpointConnection>;
  @doc("Update the state of specified private endpoint connection associated with the container registry.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<ContainerRegistryPrivateEndpointConnection>;
  @doc("Deletes the specified private endpoint connection associated with the container registry.")
  delete is ArmResourceDeleteAsync<ContainerRegistryPrivateEndpointConnection>;
  @doc("List all private endpoint connections in a container registry.")
  list is ArmResourceListByParent<ContainerRegistryPrivateEndpointConnection>;
}

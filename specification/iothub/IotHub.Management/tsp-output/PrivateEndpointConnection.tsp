import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./IotHubDescription.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.IotHub;
@doc("The private endpoint connection of an IotHub")
@parentResource(IotHubDescription)
model PrivateEndpointConnection
  is ProxyResource<PrivateEndpointConnectionProperties> {
  @doc("The name of the private endpoint connection")
  @path
  @key("privateEndpointConnectionName")
  @segment("privateEndpointConnections")
  name: string;
}

@armResourceOperations
interface PrivateEndpointConnections {
  @doc("Get private endpoint connection properties")
  get is ArmResourceRead<PrivateEndpointConnection>;
  @doc("Update the status of a private endpoint connection with the specified name")
  update is ArmResourceCreateOrUpdateAsync<PrivateEndpointConnection>;
  @doc("Delete private endpoint connection with the specified name")
  delete is ArmResourceDeleteAsync<PrivateEndpointConnection>;
  @doc("List private endpoint connection properties")
  list is ArmResourceListByParent<PrivateEndpointConnection>;
}

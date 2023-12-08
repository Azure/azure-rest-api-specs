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
model IotHubPrivateEndpointConnection
  is ProxyResource<PrivateEndpointConnectionProperties> {
  @doc("The name of the private endpoint connection")
  @path
  @key("privateEndpointConnectionName")
  @segment("privateEndpointConnections")
  name: string;
}

@armResourceOperations
interface IotHubPrivateEndpointConnections {
  @doc("Get private endpoint connection properties")
  get is ArmResourceRead<IotHubPrivateEndpointConnection>;
  @doc("Update the status of a private endpoint connection with the specified name")
  update is ArmResourceCreateOrUpdateAsync<IotHubPrivateEndpointConnection>;
  @doc("Delete private endpoint connection with the specified name")
  delete is ArmResourceDeleteAsync<IotHubPrivateEndpointConnection>;
  @doc("List private endpoint connection properties")
  list is ArmResourceListByParent<IotHubPrivateEndpointConnection>;
}

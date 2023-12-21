import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./SignalRResource.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.SignalR;
@doc("A private endpoint connection to an azure resource")
@parentResource(SignalRResource)
model PrivateEndpointConnection
  is ProxyResource<PrivateEndpointConnectionProperties> {
  @doc("The name of the private endpoint connection")
  @path
  @key("privateEndpointConnectionName")
  @segment("privateEndpointConnections")
  name: string;
}

@armResourceOperations
interface SignalRPrivateEndpointConnections {
  @doc("Get the specified private endpoint connection")
  get is ArmResourceRead<PrivateEndpointConnection>;
  @doc("Update the state of specified private endpoint connection")
  update is ArmResourceCreateOrReplaceSync<PrivateEndpointConnection>;
  @doc("Delete the specified private endpoint connection")
  delete is ArmResourceDeleteAsync<PrivateEndpointConnection>;
  @doc("List private endpoint connections")
  list is ArmResourceListByParent<PrivateEndpointConnection>;
}

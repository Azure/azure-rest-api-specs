import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./SignalR.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.SignalR;
@doc("A private endpoint connection to an azure resource")
@parentResource(SignalR)
model SignalRPrivateEndpointConnection
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
  get is ArmResourceRead<SignalRPrivateEndpointConnection>;
  @doc("Update the state of specified private endpoint connection")
  update is ArmResourceCreateOrReplaceSync<SignalRPrivateEndpointConnection>;
  @doc("Delete the specified private endpoint connection")
  delete is ArmResourceDeleteAsync<SignalRPrivateEndpointConnection>;
  @doc("List private endpoint connections")
  list is ArmResourceListByParent<SignalRPrivateEndpointConnection>;
}

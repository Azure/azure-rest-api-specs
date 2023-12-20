import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./WebPubSub.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.WebPubSub;
@doc("A private endpoint connection to an azure resource")
@parentResource(WebPubSub)
model WebPubSubPrivateEndpointConnection
  is ProxyResource<PrivateEndpointConnectionProperties> {
  @doc("The name of the private endpoint connection")
  @path
  @key("privateEndpointConnectionName")
  @segment("privateEndpointConnections")
  name: string;
}

@armResourceOperations
interface WebPubSubPrivateEndpointConnections {
  @doc("Get the specified private endpoint connection")
  get is ArmResourceRead<WebPubSubPrivateEndpointConnection>;
  @doc("Update the state of specified private endpoint connection")
  update is ArmResourceCreateOrReplaceSync<WebPubSubPrivateEndpointConnection>;
  @doc("Delete the specified private endpoint connection")
  delete is ArmResourceDeleteAsync<WebPubSubPrivateEndpointConnection>;
  @doc("List private endpoint connections")
  list is ArmResourceListByParent<WebPubSubPrivateEndpointConnection>;
}

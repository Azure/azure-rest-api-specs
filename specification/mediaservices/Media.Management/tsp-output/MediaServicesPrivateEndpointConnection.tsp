import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./MediaServicesAccount.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.Media;
@doc("The Private Endpoint Connection resource.")
@parentResource(MediaServicesAccount)
model MediaServicesPrivateEndpointConnection
  is ProxyResource<PrivateEndpointConnectionProperties> {
  @path
  @key("name")
  @segment("privateEndpointConnections")
  name: string;
}

@armResourceOperations
interface MediaServicesPrivateEndpointConnections {
  @doc("Get the details of a private endpoint connection.")
  get is ArmResourceRead<MediaServicesPrivateEndpointConnection>;
  @doc("Update an existing private endpoint connection.")
  createOrUpdate is ArmResourceCreateOrReplaceSync<MediaServicesPrivateEndpointConnection>;
  @doc("Deletes a private endpoint connection.")
  delete is ArmResourceDeleteSync<MediaServicesPrivateEndpointConnection>;
  @doc("List all private endpoint connections.")
  list is ArmResourceListByParent<MediaServicesPrivateEndpointConnection>;
}

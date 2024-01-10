import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./MediaService.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Microsoft.Media;
@doc("The Private Endpoint Connection resource.")
@parentResource(MediaService)
model PrivateEndpointConnection
  is ProxyResource<PrivateEndpointConnectionProperties> {
  @key("name")
  @segment("privateEndpointConnections")
  name: string;
}

@armResourceOperations
interface PrivateEndpointConnections {
  @doc("Get the details of a private endpoint connection.")
  get is ArmResourceRead<PrivateEndpointConnection>;

  @doc("Update an existing private endpoint connection.")
  createOrUpdate is ArmResourceCreateOrReplaceSync<PrivateEndpointConnection>;

  @doc("Deletes a private endpoint connection.")
  delete is ArmResourceDeleteSync<PrivateEndpointConnection>;

  @doc("List all private endpoint connections.")
  list is ArmResourceListByParent<PrivateEndpointConnection>;
}

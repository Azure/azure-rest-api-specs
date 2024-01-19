import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./IotHubDescription.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Devices;
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

@@projectedName(PrivateEndpointConnections.update::parameters.resource,
  "json",
  "privateEndpointConnection"
);
@@extension(PrivateEndpointConnections.update::parameters.resource,
  "x-ms-client-name",
  "privateEndpointConnection"
);
@@doc(PrivateEndpointConnections.update::parameters.resource,
  "The private endpoint connection with updated properties"
);

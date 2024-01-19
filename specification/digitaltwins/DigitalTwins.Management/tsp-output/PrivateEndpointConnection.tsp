import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./DigitalTwinsDescription.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.DigitalTwins;
@doc("The private endpoint connection of a Digital Twin.")
@parentResource(DigitalTwinsDescription)
model PrivateEndpointConnection is ProxyResource<ConnectionProperties> {
  @doc("The name of the private endpoint connection.")
  @path
  @key("privateEndpointConnectionName")
  @segment("privateEndpointConnections")
  name: string;
}

@armResourceOperations
interface PrivateEndpointConnections {
  @doc("Get private endpoint connection properties for the given private endpoint.")
  get is ArmResourceRead<PrivateEndpointConnection>;

  @doc("Update the status of a private endpoint connection with the given name.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<PrivateEndpointConnection>;

  @doc("Delete private endpoint connection with the specified name.")
  delete is ArmResourceDeleteAsync<PrivateEndpointConnection>;

  @doc("List private endpoint connection properties.")
  list is ArmResourceListByParent<PrivateEndpointConnection>;
}

@@projectedName(PrivateEndpointConnections.createOrUpdate::parameters.resource,
  "json",
  "privateEndpointConnection"
);
@@extension(PrivateEndpointConnections.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "privateEndpointConnection"
);
@@doc(PrivateEndpointConnections.createOrUpdate::parameters.resource,
  "The private endpoint connection with updated properties."
);

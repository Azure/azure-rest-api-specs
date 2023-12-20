import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./DigitalTwinsDescription.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.DigitalTwins;
@doc("The private endpoint connection of a Digital Twin.")
@parentResource(DigitalTwinsDescription)
model DigitalTwinsPrivateEndpointConnection
  is ProxyResource<ConnectionProperties> {
  @doc("The name of the private endpoint connection.")
  @path
  @key("privateEndpointConnectionName")
  @segment("privateEndpointConnections")
  name: string;
}

@armResourceOperations
interface DigitalTwinsPrivateEndpointConnections {
  @doc("Get private endpoint connection properties for the given private endpoint.")
  get is ArmResourceRead<DigitalTwinsPrivateEndpointConnection>;
  @doc("Update the status of a private endpoint connection with the given name.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<DigitalTwinsPrivateEndpointConnection>;
  @doc("Delete private endpoint connection with the specified name.")
  delete is ArmResourceDeleteAsync<DigitalTwinsPrivateEndpointConnection>;
  @doc("List private endpoint connection properties.")
  list is ArmResourceListByParent<DigitalTwinsPrivateEndpointConnection>;
}

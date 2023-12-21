import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./App.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.IotCentral;
@doc("The private endpoint connection resource.")
@parentResource(App)
model PrivateEndpointConnection
  is ProxyResource<PrivateEndpointConnectionProperties> {
  @doc("The private endpoint connection name.")
  @path
  @key("privateEndpointConnectionName")
  @segment("privateEndpointConnections")
  name: string;
}

@armResourceOperations
interface PrivateEndpointConnections {
  @doc("Get the metadata of a private endpoint connection for the IoT Central Application.")
  get is ArmResourceRead<PrivateEndpointConnection>;
  @doc("Update a private endpoint connection.")
  create is ArmResourceCreateOrUpdateAsync<PrivateEndpointConnection>;
  @doc("Deletes a private endpoint connection from the IoT Central Application.")
  delete is ArmResourceDeleteWithoutOkAsync<PrivateEndpointConnection>;
  @doc("Get all private endpoint connections of a IoT Central Application.")
  list is ArmResourceListByParent<PrivateEndpointConnection>;
}

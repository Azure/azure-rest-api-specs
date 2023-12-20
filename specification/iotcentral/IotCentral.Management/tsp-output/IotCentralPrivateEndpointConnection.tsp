import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./IotCentralApp.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.IotCentral;
@doc("The private endpoint connection resource.")
@parentResource(IotCentralApp)
model IotCentralPrivateEndpointConnection
  is ProxyResource<PrivateEndpointConnectionProperties> {
  @doc("The private endpoint connection name.")
  @path
  @key("privateEndpointConnectionName")
  @segment("privateEndpointConnections")
  name: string;
}

@armResourceOperations
interface IotCentralPrivateEndpointConnections {
  @doc("Get the metadata of a private endpoint connection for the IoT Central Application.")
  get is ArmResourceRead<IotCentralPrivateEndpointConnection>;
  @doc("Update a private endpoint connection.")
  create is ArmResourceCreateOrUpdateAsync<IotCentralPrivateEndpointConnection>;
  @doc("Deletes a private endpoint connection from the IoT Central Application.")
  delete is ArmResourceDeleteWithoutOkAsync<IotCentralPrivateEndpointConnection>;
  @doc("Get all private endpoint connections of a IoT Central Application.")
  list is ArmResourceListByParent<IotCentralPrivateEndpointConnection>;
}

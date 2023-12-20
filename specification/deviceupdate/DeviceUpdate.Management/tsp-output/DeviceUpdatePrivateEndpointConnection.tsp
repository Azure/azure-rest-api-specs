import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./DeviceUpdateAccount.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.DeviceUpdate;
@doc("The Private Endpoint Connection resource.")
@parentResource(DeviceUpdateAccount)
model DeviceUpdatePrivateEndpointConnection
  is ProxyResource<PrivateEndpointConnectionProperties> {
  @doc("The name of the private endpoint connection associated with the Azure resource")
  @path
  @key("privateEndpointConnectionName")
  @segment("privateEndpointConnections")
  name: string;
}

@armResourceOperations
interface DeviceUpdatePrivateEndpointConnections {
  @doc("Get the specified private endpoint connection associated with the device update account.")
  get is ArmResourceRead<DeviceUpdatePrivateEndpointConnection>;
  @doc("Update the state of specified private endpoint connection associated with the device update account.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<DeviceUpdatePrivateEndpointConnection>;
  @doc("Deletes the specified private endpoint connection associated with the device update account.")
  delete is ArmResourceDeleteAsync<DeviceUpdatePrivateEndpointConnection>;
  @doc("List all private endpoint connections in a device update account.")
  listByAccount is ArmResourceListByParent<DeviceUpdatePrivateEndpointConnection>;
}

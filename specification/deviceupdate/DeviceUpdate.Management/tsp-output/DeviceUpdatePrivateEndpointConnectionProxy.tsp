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
@doc("Private endpoint connection proxy details.")
@parentResource(DeviceUpdateAccount)
model DeviceUpdatePrivateEndpointConnectionProxy
  is ProxyResource<PrivateEndpointConnectionProxyProperties> {
  @doc("The ID of the private endpoint connection proxy object.")
  @path
  @key("privateEndpointConnectionProxyId")
  @segment("privateEndpointConnectionProxies")
  name: string;
}

@armResourceOperations
interface DeviceUpdatePrivateEndpointConnectionProxies {
  @doc("(INTERNAL - DO NOT USE) Get the specified private endpoint connection proxy associated with the device update account.")
  get is ArmResourceRead<DeviceUpdatePrivateEndpointConnectionProxy>;
  @doc("(INTERNAL - DO NOT USE) Creates or updates the specified private endpoint connection proxy resource associated with the device update account.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<DeviceUpdatePrivateEndpointConnectionProxy>;
  @doc("(INTERNAL - DO NOT USE) Deletes the specified private endpoint connection proxy associated with the device update account.")
  delete is ArmResourceDeleteAsync<DeviceUpdatePrivateEndpointConnectionProxy>;
  @doc("(INTERNAL - DO NOT USE) List all private endpoint connection proxies in a device update account.")
  listByAccount is ArmResourceListByParent<DeviceUpdatePrivateEndpointConnectionProxy>;
  @doc("(INTERNAL - DO NOT USE) Validates a private endpoint connection proxy object.")
  validate is ArmResourceActionSync<
    DeviceUpdatePrivateEndpointConnectionProxy,
    DeviceUpdatePrivateEndpointConnectionProxy,
    {}
  >;
  @doc("(INTERNAL - DO NOT USE) Updates a private endpoint inside the private endpoint connection proxy object.")
  updatePrivateEndpointProperties is ArmResourceActionSync<
    DeviceUpdatePrivateEndpointConnectionProxy,
    PrivateEndpointUpdate,
    {}
  >;
}

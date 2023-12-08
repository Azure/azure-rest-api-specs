import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./DeviceProvisioningService.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.DeviceProvisioningServices;
@doc("The private endpoint connection of a provisioning service")
@parentResource(DeviceProvisioningService)
model DeviceProvisioningServicesPrivateEndpointConnection
  is ProxyResource<PrivateEndpointConnectionProperties> {
  @doc("The name of the private endpoint connection")
  @path
  @key("privateEndpointConnectionName")
  @segment("privateEndpointConnections")
  name: string;
}

@armResourceOperations
interface DeviceProvisioningServicesPrivateEndpointConnections {
  @doc("Get private endpoint connection properties")
  getPrivateEndpointConnection is ArmResourceRead<DeviceProvisioningServicesPrivateEndpointConnection>;
  @doc("Create or update the status of a private endpoint connection with the specified name")
  createOrUpdatePrivateEndpointConnection is ArmResourceCreateOrUpdateAsync<DeviceProvisioningServicesPrivateEndpointConnection>;
  @doc("Delete private endpoint connection with the specified name")
  deletePrivateEndpointConnection is ArmResourceDeleteAsync<DeviceProvisioningServicesPrivateEndpointConnection>;
  @doc("List private endpoint connection properties")
  listPrivateEndpointConnections is ArmResourceListByParent<DeviceProvisioningServicesPrivateEndpointConnection>;
}

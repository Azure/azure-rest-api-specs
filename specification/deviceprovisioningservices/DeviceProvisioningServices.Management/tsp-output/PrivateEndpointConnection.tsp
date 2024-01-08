import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./ProvisioningServiceDescription.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.DeviceProvisioningServices;
@doc("The private endpoint connection of a provisioning service")
@parentResource(ProvisioningServiceDescription)
model PrivateEndpointConnection
  is ProxyResource<PrivateEndpointConnectionProperties> {
  @doc("The name of the private endpoint connection")
  @key("privateEndpointConnectionName")
  @segment("privateEndpointConnections")
  name: string;
}

@armResourceOperations
interface XXXIotDpsResource {
  @doc("Get private endpoint connection properties")
  getPrivateEndpointConnection is ArmResourceRead<PrivateEndpointConnection>;
  @doc("Create or update the status of a private endpoint connection with the specified name")
  createOrUpdatePrivateEndpointConnection is ArmResourceCreateOrUpdateAsync<PrivateEndpointConnection>;
  @doc("Delete private endpoint connection with the specified name")
  deletePrivateEndpointConnection is ArmResourceDeleteAsync<PrivateEndpointConnection>;
  @doc("List private endpoint connection properties")
  listPrivateEndpointConnections is ArmResourceListByParent<PrivateEndpointConnection>;
}

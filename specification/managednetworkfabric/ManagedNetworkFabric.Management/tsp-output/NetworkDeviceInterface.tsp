import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./NetworkDevice.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.ManagedNetworkFabric;
@doc("Defines the NetworkInterface resource.")
@parentResource(NetworkDevice)
model NetworkDeviceInterface is ProxyResource<NetworkInterfaceProperties> {
  @doc("Name of the Network Interface.")
  @path
  @key("networkInterfaceName")
  @segment("networkInterfaces")
  name: string;
}

@armResourceOperations
interface NetworkDeviceInterfaces {
  @doc("Get the Network Interface resource details.")
  get is ArmResourceRead<NetworkDeviceInterface>;
  @doc("Create a Network Interface resource.")
  create is ArmResourceCreateOrUpdateAsync<NetworkDeviceInterface>;
  @doc("Update certain properties of the Network Interface resource.")
  update is ArmResourcePatchAsync<
    NetworkDeviceInterface,
    NetworkInterfaceProperties
  >;
  @doc("Delete the Network Interface resource.")
  delete is ArmResourceDeleteWithoutOkAsync<NetworkDeviceInterface>;
  @doc("List all the Network Interface resources in a given resource group.")
  listByNetworkDevice is ArmResourceListByParent<NetworkDeviceInterface>;
  @doc("Update the admin state of the Network Interface.")
  updateAdministrativeState is ArmResourceActionAsync<
    NetworkDeviceInterface,
    UpdateAdministrativeState,
    CommonPostActionResponseForStateUpdate
  >;
}

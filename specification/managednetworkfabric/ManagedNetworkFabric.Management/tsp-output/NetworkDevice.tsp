import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.ManagedNetworkFabric;
@doc("The Network Device resource definition.")
model NetworkDevice is TrackedResource<NetworkDeviceProperties> {
  @doc("Name of the Network Device.")
  @path
  @key("networkDeviceName")
  @segment("networkDevices")
  name: string;
}

@armResourceOperations
interface NetworkDevices {
  @doc("Gets the Network Device resource details.")
  get is ArmResourceRead<NetworkDevice>;
  @doc("Create a Network Device resource")
  create is ArmResourceCreateOrUpdateAsync<NetworkDevice>;
  @doc("Update certain properties of the Network Device resource.")
  update is ArmResourcePatchAsync<NetworkDevice, NetworkDeviceProperties>;
  @doc("Delete the Network Device resource.")
  delete is ArmResourceDeleteWithoutOkAsync<NetworkDevice>;
  @doc("List all the Network Device resources in a given resource group.")
  listByResourceGroup is ArmResourceListByParent<NetworkDevice>;
  @doc("List all the Network Device resources in a given subscription.")
  listBySubscription is ArmListBySubscription<NetworkDevice>;
  @doc("Reboot the Network Device.")
  reboot is ArmResourceActionAsync<
    NetworkDevice,
    RebootProperties,
    CommonPostActionResponseForStateUpdate
  >;
  @doc("Refreshes the configuration the Network Device.")
  refreshConfiguration is ArmResourceActionAsync<
    NetworkDevice,
    {},
    CommonPostActionResponseForStateUpdate
  >;
  @doc("Updates the Administrative state of the Network Device.")
  updateAdministrativeState is ArmResourceActionAsync<
    NetworkDevice,
    UpdateDeviceAdministrativeState,
    CommonPostActionResponseForStateUpdate
  >;
  @doc("Upgrades the version of the Network Device.")
  upgrade is ArmResourceActionAsync<
    NetworkDevice,
    UpdateVersion,
    CommonPostActionResponseForStateUpdate
  >;
}

import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.ManagedNetworkFabric;
@doc("The Network Tap resource definition.")
model NetworkTap is TrackedResource<NetworkTapProperties> {
  @doc("Name of the Network Tap.")
  @path
  @key("networkTapName")
  @segment("networkTaps")
  name: string;
}

@armResourceOperations
interface NetworkTaps {
  @doc("Retrieves details of this Network Tap.")
  get is ArmResourceRead<NetworkTap>;
  @doc("Creates a Network Tap.")
  create is ArmResourceCreateOrUpdateAsync<NetworkTap>;
  @doc("API to update certain properties of the Network Tap resource.")
  update is ArmResourcePatchAsync<NetworkTap, NetworkTapProperties>;
  @doc("Deletes Network Tap.")
  delete is ArmResourceDeleteWithoutOkAsync<NetworkTap>;
  @doc("Displays Network Taps list by resource group GET method.")
  listByResourceGroup is ArmResourceListByParent<NetworkTap>;
  @doc("Displays Network Taps list by subscription GET method.")
  listBySubscription is ArmListBySubscription<NetworkTap>;
  @doc("Implements the operation to the underlying resources.")
  updateAdministrativeState is ArmResourceActionAsync<
    NetworkTap,
    UpdateAdministrativeState,
    CommonPostActionResponseForDeviceUpdate
  >;
  @doc("Implements the operation to the underlying resources.")
  resync is ArmResourceActionAsync<
    NetworkTap,
    {},
    CommonPostActionResponseForStateUpdate
  >;
}

import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Microsoft.HybridContainerService;
@doc("The Virtual Network resource definition.")
model VirtualNetwork is TrackedResource<VirtualNetworkProperties> {
  @doc("Parameter for the name of the virtual network")
  @maxLength(64)
  @minLength(3)
  @pattern("^[a-zA-Z0-9]$|^[a-zA-Z0-9][-_a-zA-Z0-9]{0,61}[a-zA-Z0-9]$")
  @key("virtualNetworkName")
  @segment("virtualNetworks")
  name: string;

  @doc("Extended location pointing to the underlying infrastructure")
  extendedLocation?: VirtualNetworkExtendedLocation;
}

@armResourceOperations
@projectedName("client", "virtualNetworks")
interface VirtualNetworksToVirtualNetworks {
  @doc("Gets the specified virtual network resource")
  retrieve is ArmResourceRead<VirtualNetwork>;

  @doc("Creates or updates the virtual network resource")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<VirtualNetwork>;

  @doc("Patches the virtual network resource")
  update is ArmCustomPatchAsync<VirtualNetwork, VirtualNetworksPatch>;

  @doc("Deletes the specified virtual network resource")
  delete is ArmResourceDeleteWithoutOkAsync<VirtualNetwork>;

  @doc("Lists the virtual networks in the specified resource group")
  listByResourceGroup is ArmResourceListByParent<VirtualNetwork>;

  @doc("Lists the virtual networks in the specified subscription")
  listBySubscription is ArmListBySubscription<VirtualNetwork>;
}

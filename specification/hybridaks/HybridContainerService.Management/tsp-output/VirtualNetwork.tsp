import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Microsoft.HybridContainerService;
@doc("The virtualNetworks resource definition.")
model VirtualNetwork is TrackedResource<VirtualNetworksProperties> {
  @doc("Parameter for the name of the virtual network")
  @maxLength(64)
  @minLength(3)
  @path
  @key("virtualNetworksName")
  @segment("virtualNetworks")
  name: string;

  extendedLocation?: VirtualNetworksExtendedLocation;
}

@armResourceOperations
interface VirtualNetworks {
  @doc("Gets the Hybrid AKS virtual network")
  retrieve is ArmResourceRead<VirtualNetwork>;
  @doc("Puts the Hybrid AKS virtual network")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<VirtualNetwork>;
  @doc("Patches the Hybrid AKS virtual network")
  update is ArmTagsPatchAsync<VirtualNetwork>;
  @doc("Deletes the Hybrid AKS virtual network")
  delete is ArmResourceDeleteSync<VirtualNetwork>;
  @doc("Lists the Hybrid AKS virtual networks by resource group")
  listByResourceGroup is ArmResourceListByParent<VirtualNetwork>;
  @doc("Lists the Hybrid AKS virtual networks by subscription")
  listBySubscription is ArmListBySubscription<VirtualNetwork>;
}

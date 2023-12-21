import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.HybridContainerService;
@doc("The virtualNetworks resource definition.")
model VirtualNetworks is TrackedResource<VirtualNetworksProperties> {
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
interface virtualNetworks {
  @doc("Gets the Hybrid AKS virtual network")
  retrieve is ArmResourceRead<VirtualNetworks>;
  @doc("Puts the Hybrid AKS virtual network")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<VirtualNetworks>;
  @doc("Patches the Hybrid AKS virtual network")
  update is ArmTagsPatchAsync<VirtualNetworks>;
  @doc("Deletes the Hybrid AKS virtual network")
  delete is ArmResourceDeleteSync<VirtualNetworks>;
  @doc("Lists the Hybrid AKS virtual networks by resource group")
  listByResourceGroup is ArmResourceListByParent<VirtualNetworks>;
  @doc("Lists the Hybrid AKS virtual networks by subscription")
  listBySubscription is ArmListBySubscription<VirtualNetworks>;
}

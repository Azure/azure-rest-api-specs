import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.ManagedNetworkFabric;
@doc("Defines the Neighbor Group.")
model NetworkFabricNeighborGroup is TrackedResource<NeighborGroupProperties> {
  @doc("Name of the Neighbor Group.")
  @path
  @key("neighborGroupName")
  @segment("neighborGroups")
  name: string;
}

@armResourceOperations
interface NetworkFabricNeighborGroups {
  @doc("Gets the Neighbor Group.")
  get is ArmResourceRead<NetworkFabricNeighborGroup>;
  @doc("Implements the Neighbor Group PUT method.")
  create is ArmResourceCreateOrUpdateAsync<NetworkFabricNeighborGroup>;
  @doc("Updates the Neighbor Group.")
  update is ArmResourcePatchAsync<
    NetworkFabricNeighborGroup,
    NeighborGroupProperties
  >;
  @doc("Implements Neighbor Group DELETE method.")
  delete is ArmResourceDeleteWithoutOkAsync<NetworkFabricNeighborGroup>;
  @doc("Displays NeighborGroups list by resource group GET method.")
  listByResourceGroup is ArmResourceListByParent<NetworkFabricNeighborGroup>;
  @doc("Displays NeighborGroups list by subscription GET method.")
  listBySubscription is ArmListBySubscription<NetworkFabricNeighborGroup>;
}

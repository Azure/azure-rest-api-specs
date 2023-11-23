import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Microsoft.ManagedNetworkFabric;
@doc("Defines the Neighbor Group.")
model NeighborGroup is TrackedResource<NeighborGroupProperties> {
  @doc("Name of the Neighbor Group.")
  @path
  @key("neighborGroupName")
  @segment("neighborGroups")
  name: string;
}

@armResourceOperations
interface NeighborGroups {
  @doc("Gets the Neighbor Group.")
  get is ArmResourceRead<NeighborGroup>;
  @doc("Implements the Neighbor Group PUT method.")
  create is ArmResourceCreateOrUpdateAsync<NeighborGroup>;
  @doc("Updates the Neighbor Group.")
  update is ArmResourcePatchAsync<NeighborGroup, NeighborGroupProperties>;
  @doc("Implements Neighbor Group DELETE method.")
  delete is ArmResourceDeleteWithoutOkAsync<NeighborGroup>;
  @doc("Displays NeighborGroups list by resource group GET method.")
  listByResourceGroup is ArmResourceListByParent<NeighborGroup>;
  @doc("Displays NeighborGroups list by subscription GET method.")
  listBySubscription is ArmListBySubscription<NeighborGroup>;
}

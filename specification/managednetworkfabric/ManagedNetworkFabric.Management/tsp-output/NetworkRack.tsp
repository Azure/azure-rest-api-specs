import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Microsoft.ManagedNetworkFabric;
@doc("The Network Rack resource definition.")
model NetworkRack is TrackedResource<NetworkRackProperties> {
  @doc("Name of the Network Rack.")
  @key("networkRackName")
  @segment("networkRacks")
  name: string;
}

@armResourceOperations
interface NetworkRacks {
  @doc("Get Network Rack resource details.")
  get is ArmResourceRead<NetworkRack>;

  @doc("Create Network Rack resource.")
  create is ArmResourceCreateOrUpdateAsync<NetworkRack>;

  @doc("Update certain properties of the Network Rack resource.")
  update is ArmCustomPatchAsync<NetworkRack, TagsUpdate>;

  @doc("Delete Network Rack resource.")
  delete is ArmResourceDeleteWithoutOkAsync<NetworkRack>;

  @doc("List all Network Rack resources in the given resource group.")
  listByResourceGroup is ArmResourceListByParent<NetworkRack>;

  @doc("List all Network Rack resources in the given subscription")
  listBySubscription is ArmListBySubscription<NetworkRack>;
}

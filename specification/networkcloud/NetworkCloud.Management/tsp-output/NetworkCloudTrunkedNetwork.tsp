import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.NetworkCloud;
@doc("TrunkedNetwork represents a network that utilizes multiple isolation domains and specified VLANs to create a trunked network.")
model NetworkCloudTrunkedNetwork is TrackedResource<TrunkedNetworkProperties> {
  @doc("The name of the trunked network.")
  @pattern("^([a-zA-Z0-9][a-zA-Z0-9-_]{0,28}[a-zA-Z0-9])$")
  @path
  @key("trunkedNetworkName")
  @segment("trunkedNetworks")
  name: string;

  @doc("The extended location of the cluster associated with the resource.")
  extendedLocation: ExtendedLocation;
}

@armResourceOperations
interface NetworkCloudTrunkedNetworks {
  @doc("Get properties of the provided trunked network.")
  get is ArmResourceRead<NetworkCloudTrunkedNetwork>;
  @doc("Create a new trunked network or update the properties of the existing trunked network.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<NetworkCloudTrunkedNetwork>;
  @doc("Update tags associated with the provided trunked network.")
  update is ArmTagsPatchSync<NetworkCloudTrunkedNetwork>;
  @doc("Delete the provided trunked network.")
  delete is ArmResourceDeleteAsync<NetworkCloudTrunkedNetwork>;
  @doc("Get a list of trunked networks in the provided resource group.")
  listByResourceGroup is ArmResourceListByParent<NetworkCloudTrunkedNetwork>;
  @doc("Get a list of trunked networks in the provided subscription.")
  listBySubscription is ArmListBySubscription<NetworkCloudTrunkedNetwork>;
}

import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./NetworkCloudCluster.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.NetworkCloud;
@doc("BareMetalMachineKeySet represents the bare metal machine key set.")
@parentResource(NetworkCloudCluster)
model NetworkCloudBareMetalMachineKeySet
  is TrackedResource<BareMetalMachineKeySetProperties> {
  @doc("The name of the bare metal machine key set.")
  @pattern("^([a-zA-Z0-9][a-zA-Z0-9-_]{0,28}[a-zA-Z0-9])$")
  @path
  @key("bareMetalMachineKeySetName")
  @segment("bareMetalMachineKeySets")
  name: string;

  @doc("The extended location of the cluster associated with the resource.")
  extendedLocation: ExtendedLocation;
}

@armResourceOperations
interface NetworkCloudBareMetalMachineKeySets {
  @doc("Get bare metal machine key set of the provided cluster.")
  get is ArmResourceRead<NetworkCloudBareMetalMachineKeySet>;
  @doc("Create a new bare metal machine key set or update the existing one for the provided cluster.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<NetworkCloudBareMetalMachineKeySet>;
  @doc("Patch properties of bare metal machine key set for the provided cluster, or update the tags associated with it. Properties and tag updates can be done independently.")
  update is ArmResourcePatchAsync<
    NetworkCloudBareMetalMachineKeySet,
    BareMetalMachineKeySetProperties
  >;
  @doc("Delete the bare metal machine key set of the provided cluster.")
  delete is ArmResourceDeleteAsync<NetworkCloudBareMetalMachineKeySet>;
  @doc("Get a list of bare metal machine key sets for the provided cluster.")
  listByCluster is ArmResourceListByParent<NetworkCloudBareMetalMachineKeySet>;
}

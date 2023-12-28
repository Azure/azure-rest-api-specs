import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./Cluster.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.NetworkCloud;
@doc("BmcKeySet represents the baseboard management controller key set.")
@parentResource(Cluster)
model BmcKeySet is TrackedResource<BmcKeySetProperties> {
  @doc("The name of the baseboard management controller key set.")
  @pattern("^([a-zA-Z0-9][a-zA-Z0-9-_]{0,28}[a-zA-Z0-9])$")
  @key("bmcKeySetName")
  @segment("bmcKeySets")
  name: string;

  @doc("The extended location of the cluster associated with the resource.")
  extendedLocation: ExtendedLocation;
}

@armResourceOperations
interface BmcKeySets {
  @doc("Get baseboard management controller key set of the provided cluster.")
  get is ArmResourceRead<BmcKeySet>;
  @doc("Create a new baseboard management controller key set or update the existing one for the provided cluster.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<BmcKeySet>;
  @doc("Patch properties of baseboard management controller key set for the provided cluster, or update the tags associated with it. Properties and tag updates can be done independently.")
  update is ArmCustomPatchAsync<BmcKeySet, BmcKeySetPatchParameters>;
  @doc("Delete the baseboard management controller key set of the provided cluster.")
  delete is ArmResourceDeleteAsync<BmcKeySet>;
  @doc("Get a list of baseboard management controller key sets for the provided cluster.")
  listByCluster is ArmResourceListByParent<BmcKeySet>;
}

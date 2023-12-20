import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.NetworkCloud;
@doc("""
Upon creation, the additional services that are provided by the platform will be allocated and
represented in the status of this resource. All resources associated with this cloud services network will be part
of the same layer 2 (L2) isolation domain. At least one service network must be created but may be reused across many
virtual machines and/or Hybrid AKS clusters.
""")
model NetworkCloudCloudServicesNetwork
  is TrackedResource<CloudServicesNetworkProperties> {
  @doc("The name of the cloud services network.")
  @pattern("^([a-zA-Z0-9][a-zA-Z0-9-_]{0,28}[a-zA-Z0-9])$")
  @path
  @key("cloudServicesNetworkName")
  @segment("cloudServicesNetworks")
  name: string;

  @doc("The extended location of the cluster associated with the resource.")
  extendedLocation: ExtendedLocation;
}

@armResourceOperations
interface NetworkCloudCloudServicesNetworks {
  @doc("Get properties of the provided cloud services network.")
  get is ArmResourceRead<NetworkCloudCloudServicesNetwork>;
  @doc("Create a new cloud services network or update the properties of the existing cloud services network.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<NetworkCloudCloudServicesNetwork>;
  @doc("Update properties of the provided cloud services network, or update the tags associated with it. Properties and tag updates can be done independently.")
  update is ArmResourcePatchAsync<
    NetworkCloudCloudServicesNetwork,
    CloudServicesNetworkProperties
  >;
  @doc("Delete the provided cloud services network.")
  delete is ArmResourceDeleteAsync<NetworkCloudCloudServicesNetwork>;
  @doc("Get a list of cloud services networks in the provided resource group.")
  listByResourceGroup is ArmResourceListByParent<NetworkCloudCloudServicesNetwork>;
  @doc("Get a list of cloud services networks in the provided subscription.")
  listBySubscription is ArmListBySubscription<NetworkCloudCloudServicesNetwork>;
}

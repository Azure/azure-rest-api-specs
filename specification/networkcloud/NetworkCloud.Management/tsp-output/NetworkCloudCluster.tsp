import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.NetworkCloud;
@doc("Cluster represents the on-premises Network Cloud cluster.")
model NetworkCloudCluster is TrackedResource<ClusterProperties> {
  @doc("The name of the cluster.")
  @pattern("^([a-zA-Z0-9][a-zA-Z0-9-_]{0,28}[a-zA-Z0-9])$")
  @path
  @key("clusterName")
  @segment("clusters")
  name: string;

  @doc("The extended location of the cluster manager associated with the cluster.")
  extendedLocation: ExtendedLocation;
}

@armResourceOperations
interface NetworkCloudClusters {
  @doc("Get properties of the provided cluster.")
  get is ArmResourceRead<NetworkCloudCluster>;
  @doc("Create a new cluster or update the properties of the cluster if it exists.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<NetworkCloudCluster>;
  @doc("Patch the properties of the provided cluster, or update the tags associated with the cluster. Properties and tag updates can be done independently.")
  update is ArmResourcePatchAsync<NetworkCloudCluster, ClusterProperties>;
  @doc("Delete the provided cluster.")
  delete is ArmResourceDeleteAsync<NetworkCloudCluster>;
  @doc("Get a list of clusters in the provided resource group.")
  listByResourceGroup is ArmResourceListByParent<NetworkCloudCluster>;
  @doc("Get a list of clusters in the provided subscription.")
  listBySubscription is ArmListBySubscription<NetworkCloudCluster>;
  @doc("Deploy the cluster to the provided rack.")
  deploy is ArmResourceActionNoResponseContentAsync<
    NetworkCloudCluster,
    ClusterDeployParameters
  >;
  @doc("Update the version of the provided cluster to one of the available supported versions.")
  updateVersion is ArmResourceActionNoResponseContentAsync<
    NetworkCloudCluster,
    ClusterUpdateVersionParameters
  >;
}

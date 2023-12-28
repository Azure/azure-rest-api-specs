import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.NetworkCloud;
@doc("ClusterManager represents a control-plane to manage one or more on-premises clusters.")
model ClusterManager is TrackedResource<ClusterManagerProperties> {
  @doc("The name of the cluster manager.")
  @pattern("^([a-zA-Z0-9][a-zA-Z0-9-_]{0,28}[a-zA-Z0-9])$")
  @key("clusterManagerName")
  @segment("clusterManagers")
  name: string;
}

@armResourceOperations
interface ClusterManagers {
  @doc("Get the properties of the provided cluster manager.")
  get is ArmResourceRead<ClusterManager>;
  @doc("Create a new cluster manager or update properties of the cluster manager if it exists.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<ClusterManager>;
  @doc("Patch properties of the provided cluster manager, or update the tags assigned to the cluster manager. Properties and tag updates can be done independently.")
  update is ArmCustomPatchSync<ClusterManager, ClusterManagerPatchParameters>;
  @doc("Delete the provided cluster manager.")
  delete is ArmResourceDeleteAsync<ClusterManager>;
  @doc("Get a list of cluster managers in the provided resource group.")
  listByResourceGroup is ArmResourceListByParent<ClusterManager>;
  @doc("Get a list of cluster managers in the provided subscription.")
  listBySubscription is ArmListBySubscription<ClusterManager>;
}

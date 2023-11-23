import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Microsoft.HDInsight;
@doc("Cluster pool.")
model ClusterPool is TrackedResource<ClusterPoolResourceProperties> {
  @doc("The name of the cluster pool.")
  @path
  @key("clusterPoolName")
  @segment("clusterpools")
  name: string;
}

@armResourceOperations
interface ClusterPools {
  @doc("Gets a cluster pool.")
  get is ArmResourceRead<ClusterPool>;
  @doc("Creates or updates a cluster pool.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<ClusterPool>;
  @doc("Updates an existing Cluster Pool Tags.")
  updateTags is ArmTagsPatchAsync<ClusterPool>;
  @doc("Deletes a Cluster Pool.")
  delete is ArmResourceDeleteAsync<ClusterPool>;
  @doc("Lists the HDInsight cluster pools under a resource group.")
  listByResourceGroup is ArmResourceListByParent<ClusterPool>;
  @doc("Gets the list of Cluster Pools within a Subscription.")
  listBySubscription is ArmListBySubscription<ClusterPool>;
}

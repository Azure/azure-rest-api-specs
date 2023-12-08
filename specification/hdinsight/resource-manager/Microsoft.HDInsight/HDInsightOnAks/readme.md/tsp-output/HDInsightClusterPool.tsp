import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.HDInsight.Containers;
@doc("Cluster pool.")
model HDInsightClusterPool is TrackedResource<ClusterPoolResourceProperties> {
  @doc("The name of the cluster pool.")
  @path
  @key("clusterPoolName")
  @segment("clusterpools")
  name: string;
}

@armResourceOperations
interface HDInsightClusterPools {
  @doc("Gets a cluster pool.")
  get is ArmResourceRead<HDInsightClusterPool>;
  @doc("Creates or updates a cluster pool.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<HDInsightClusterPool>;
  @doc("Updates an existing Cluster Pool Tags.")
  updateTags is ArmTagsPatchAsync<HDInsightClusterPool>;
  @doc("Deletes a Cluster Pool.")
  delete is ArmResourceDeleteAsync<HDInsightClusterPool>;
  @doc("Lists the HDInsight cluster pools under a resource group.")
  listByResourceGroup is ArmResourceListByParent<HDInsightClusterPool>;
  @doc("Gets the list of Cluster Pools within a Subscription.")
  listBySubscription is ArmListBySubscription<HDInsightClusterPool>;
}

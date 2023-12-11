import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.OperationalInsights;
@doc("The top level Log Analytics cluster resource container.")
model OperationalInsightsCluster is TrackedResource<ClusterProperties> {
  @doc("Name of the Log Analytics Cluster.")
  @path
  @key("clusterName")
  @segment("clusters")
  name: string;

  ...Azure.ResourceManager.ManagedServiceIdentity;
  ...Azure.ResourceManager.ResourceSku;
}

@armResourceOperations
interface OperationalInsightsClusters {
  @doc("Gets a Log Analytics cluster instance.")
  get is ArmResourceRead<OperationalInsightsCluster>;
  @doc("Create or update a Log Analytics cluster.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<OperationalInsightsCluster>;
  @doc("Updates a Log Analytics cluster.")
  update is ArmResourcePatchAsync<
    OperationalInsightsCluster,
    ClusterProperties
  >;
  @doc("Deletes a cluster instance.")
  delete is ArmResourceDeleteAsync<OperationalInsightsCluster>;
  @doc("Gets Log Analytics clusters in a resource group.")
  listByResourceGroup is ArmResourceListByParent<OperationalInsightsCluster>;
  @doc("Gets the Log Analytics clusters in a subscription.")
  list is ArmListBySubscription<OperationalInsightsCluster>;
}

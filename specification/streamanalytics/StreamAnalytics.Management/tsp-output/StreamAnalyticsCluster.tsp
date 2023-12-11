import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.StreamAnalytics;
@doc("A Stream Analytics Cluster object")
model StreamAnalyticsCluster is TrackedResource<ClusterProperties> {
  @doc("The name of the cluster.")
  @path
  @key("clusterName")
  @segment("clusters")
  name: string;

  ...Azure.ResourceManager.ResourceSku;
}

@armResourceOperations
interface StreamAnalyticsClusters {
  @doc("Gets information about the specified cluster.")
  get is ArmResourceRead<StreamAnalyticsCluster>;
  @doc("Creates a Stream Analytics Cluster or replaces an already existing cluster.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<
    StreamAnalyticsCluster,
    {
      ...BaseParameters<StreamAnalyticsCluster>;

      @doc("The ETag of the resource. Omit this value to always overwrite the current record set. Specify the last-seen ETag value to prevent accidentally overwriting concurrent changes.")
      @header
      `If-Match`?: string;

      @doc("Set to '*' to allow a new resource to be created, but to prevent updating an existing record set. Other values will result in a 412 Pre-condition Failed response.")
      @header
      `If-None-Match`?: string;
    }
  >;
  @doc("Updates an existing cluster. This can be used to partially update (ie. update one or two properties) a cluster without affecting the rest of the cluster definition.")
  update is ArmResourcePatchAsync<
    StreamAnalyticsCluster,
    ClusterProperties,
    {
      ...BaseParameters<StreamAnalyticsCluster>;

      @doc("The ETag of the resource. Omit this value to always overwrite the current record set. Specify the last-seen ETag value to prevent accidentally overwriting concurrent changes.")
      @header
      `If-Match`?: string;
    }
  >;
  @doc("Deletes the specified cluster.")
  delete is ArmResourceDeleteAsync<StreamAnalyticsCluster>;
  @doc("Lists all of the clusters in the given resource group.")
  listByResourceGroup is ArmResourceListByParent<StreamAnalyticsCluster>;
  @doc("Lists all of the clusters in the given subscription.")
  listBySubscription is ArmListBySubscription<StreamAnalyticsCluster>;
  @doc("Lists all of the streaming jobs in the given cluster.")
  listStreamingJobs is ArmResourceActionSync<
    StreamAnalyticsCluster,
    {},
    ClusterJobListResult
  >;
}

import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.StreamAnalytics;
@doc("A Stream Analytics Cluster object")
model Cluster is TrackedResource<ClusterProperties> {
  @doc("The name of the cluster.")
  @path
  @key("clusterName")
  @segment("clusters")
  name: string;

  @doc("The current entity tag for the cluster. This is an opaque string. You can use it to detect whether the resource has changed between requests. You can also use it in the If-Match or If-None-Match headers for write operations for optimistic concurrency.")
  @visibility("read")
  etag?: string;

  ...Azure.ResourceManager.ResourceSku;
}

@armResourceOperations
interface Clusters {
  @doc("Gets information about the specified cluster.")
  get is ArmResourceRead<Cluster>;

  @doc("Creates a Stream Analytics Cluster or replaces an already existing cluster.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<
    Cluster,
    {
      ...BaseParameters<Cluster>;

      @doc("The ETag of the resource. Omit this value to always overwrite the current record set. Specify the last-seen ETag value to prevent accidentally overwriting concurrent changes.")
      @header
      `If-Match`?: string;

      @doc("Set to '*' to allow a new resource to be created, but to prevent updating an existing record set. Other values will result in a 412 Pre-condition Failed response.")
      @header
      `If-None-Match`?: string;
    }
  >;

  @doc("Updates an existing cluster. This can be used to partially update (ie. update one or two properties) a cluster without affecting the rest of the cluster definition.")
  update is ArmCustomPatchAsync<
    Cluster,
    Cluster,
    {
      ...BaseParameters<Cluster>;

      @doc("The ETag of the resource. Omit this value to always overwrite the current record set. Specify the last-seen ETag value to prevent accidentally overwriting concurrent changes.")
      @header
      `If-Match`?: string;
    }
  >;

  @doc("Deletes the specified cluster.")
  delete is ArmResourceDeleteAsync<Cluster>;

  @doc("Lists all of the clusters in the given resource group.")
  listByResourceGroup is ArmResourceListByParent<Cluster>;

  @doc("Lists all of the clusters in the given subscription.")
  listBySubscription is ArmListBySubscription<Cluster>;

  @doc("Lists all of the streaming jobs in the given cluster.")
  listStreamingJobs is ArmResourceActionSync<
    Cluster,
    void,
    ClusterJobListResult
  >;
}

@@projectedName(Clusters.createOrUpdate::parameters.resource,
  "json",
  "cluster"
);
@@extension(Clusters.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "cluster"
);
@@doc(Clusters.createOrUpdate::parameters.resource,
  "The definition of the cluster that will be used to create a new cluster or replace the existing one."
);
@@projectedName(Clusters.update::parameters.properties, "json", "cluster");
@@extension(Clusters.update::parameters.properties,
  "x-ms-client-name",
  "cluster"
);
@@doc(Clusters.update::parameters.properties,
  "The properties specified here will overwrite the corresponding properties in the existing cluster (ie. Those properties will be updated)."
);

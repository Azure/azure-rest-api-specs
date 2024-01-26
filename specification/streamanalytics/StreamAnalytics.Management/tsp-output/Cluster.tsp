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
/**
 * A Stream Analytics Cluster object
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@includeInapplicableMetadataInPayload(false)
model Cluster extends TrackedResource {
  /**
   * The name of the cluster.
   */
  @path
  @key("clusterName")
  @segment("clusters")
  @visibility("read")
  name: string;

  /**
   * The SKU of the cluster. This determines the size/capacity of the cluster. Required on PUT (CreateOrUpdate) requests.
   */
  sku?: ClusterSku;

  /**
   * The current entity tag for the cluster. This is an opaque string. You can use it to detect whether the resource has changed between requests. You can also use it in the If-Match or If-None-Match headers for write operations for optimistic concurrency.
   */
  @visibility("read")
  etag?: string;

  /**
   * The properties associated with a Stream Analytics cluster.
   */
  @extension("x-ms-client-flatten", true)
  properties?: ClusterProperties;
}

@armResourceOperations
interface Clusters {
  /**
   * Gets information about the specified cluster.
   */
  get is ArmResourceRead<Cluster>;

  /**
   * Creates a Stream Analytics Cluster or replaces an already existing cluster.
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    Cluster,
    {
      ...BaseParameters<Cluster>;

      /**
       * The ETag of the resource. Omit this value to always overwrite the current record set. Specify the last-seen ETag value to prevent accidentally overwriting concurrent changes.
       */
      @header
      `If-Match`?: string;

      /**
       * Set to '*' to allow a new resource to be created, but to prevent updating an existing record set. Other values will result in a 412 Pre-condition Failed response.
       */
      @header
      `If-None-Match`?: string;
    }
  >;

  /**
   * Updates an existing cluster. This can be used to partially update (ie. update one or two properties) a cluster without affecting the rest of the cluster definition.
   */
  @parameterVisibility("read")
  update is ArmCustomPatchAsync<
    Cluster,
    Cluster,
    {
      ...BaseParameters<Cluster>;

      /**
       * The ETag of the resource. Omit this value to always overwrite the current record set. Specify the last-seen ETag value to prevent accidentally overwriting concurrent changes.
       */
      @header
      `If-Match`?: string;
    }
  >;

  /**
   * Deletes the specified cluster.
   */
  delete is ArmResourceDeleteAsync<Cluster>;

  /**
   * Lists all of the clusters in the given resource group.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Clusters_ListByResourceGroup")
  listByResourceGroup is ArmResourceListByParent<Cluster>;

  /**
   * Lists all of the clusters in the given subscription.
   */
  listBySubscription is ArmListBySubscription<Cluster>;

  /**
   * Lists all of the streaming jobs in the given cluster.
   */
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

import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.StreamAnalytics;
/**
 * A Stream Analytics Cluster object
 */
model Cluster is Azure.ResourceManager.TrackedResource<ClusterProperties> {
  ...ResourceNameParameter<
    Resource = Cluster,
    KeyName = "clusterName",
    SegmentName = "clusters",
    NamePattern = ""
  >;

  /**
   * The SKU of the cluster. This determines the size/capacity of the cluster. Required on PUT (CreateOrUpdate) requests.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  sku?: ClusterSku;

  ...Azure.ResourceManager.EntityTagProperty;
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
    Parameters = {
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
    },
    LroHeaders = ArmLroLocationHeader & Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Updates an existing cluster. This can be used to partially update (ie. update one or two properties) a cluster without affecting the rest of the cluster definition.
   */
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchAsync<
    Cluster,
    PatchModel = Cluster,
    Parameters = {
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
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  delete is ArmResourceDeleteWithoutOkAsync<
    Cluster,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse
  >;

  /**
   * Lists all of the clusters in the given resource group.
   */
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
    ArmResponse<ClusterJobListResult>
  >;
}

@@doc(Cluster.name, "The name of the cluster.");
@@encodedName(Cluster.eTag, "application/json", "etag");
@@doc(Cluster.properties,
  "The properties associated with a Stream Analytics cluster."
);
@@doc(Clusters.createOrUpdate::parameters.resource,
  "The definition of the cluster that will be used to create a new cluster or replace the existing one."
);
@@doc(Clusters.update::parameters.properties,
  "The properties specified here will overwrite the corresponding properties in the existing cluster (ie. Those properties will be updated)."
);

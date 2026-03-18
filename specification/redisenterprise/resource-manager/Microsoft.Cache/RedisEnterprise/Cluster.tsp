import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Cache;
/**
 * Describes the Redis Enterprise cluster
 */
model Cluster
  is Azure.ResourceManager.TrackedResource<ClusterCreateProperties> {
  ...ResourceNameParameter<
    Resource = Cluster,
    KeyName = "clusterName",
    SegmentName = "redisEnterprise",
    NamePattern = "^(?=.{1,60}$)[A-Za-z0-9]+(-[A-Za-z0-9]+)*$"
  >;

  /**
   * Distinguishes the kind of cluster. Read-only.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  kind?: Kind;

  /**
   * The SKU to create, which affects price, performance, and features.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  sku: Sku;

  ...Azure.ResourceManager.AvailabilityZonesProperty;

  /**
   * The identity of the resource.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  identity?: Azure.ResourceManager.CommonTypes.ManagedServiceIdentity;
}

@armResourceOperations
interface Clusters {
  /**
   * Gets information about a Redis Enterprise cluster
   */
  get is ArmResourceRead<Cluster>;

  /**
   * Creates or updates an existing (overwrite/recreate, with potential downtime) cache cluster
   */
  @Azure.Core.useFinalStateVia("original-uri")
  create is ArmResourceCreateOrReplaceAsync<Cluster>;

  /**
   * Updates an existing Redis Enterprise cluster
   */
  @Azure.Core.useFinalStateVia("azure-async-operation")
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchAsync<
    Cluster,
    PatchModel = ClusterUpdate,
    LroHeaders = ArmCombinedLroHeaders<FinalResult = Cluster> &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Deletes a Redis Enterprise cache cluster.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/lro-location-header" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @Azure.Core.useFinalStateVia("azure-async-operation")
  delete is ArmResourceDeleteWithoutOkAsync<
    Cluster,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse<ArmCombinedLroHeaders &
      Azure.Core.Foundations.RetryAfterHeader> | ArmDeletedNoContentResponse
  >;

  /**
   * Lists all Redis Enterprise clusters in a resource group.
   */
  listByResourceGroup is ArmResourceListByParent<
    Cluster,
    Response = ArmResponse<ClusterList>
  >;

  /**
   * Lists all Redis Enterprise clusters in the specified subscription.
   */
  list is ArmListBySubscription<Cluster, Response = ArmResponse<ClusterList>>;

  /**
   * Lists the available SKUs for scaling the Redis Enterprise cluster.
   */
  listSkusForScaling is ArmResourceActionSync<
    Cluster,
    void,
    ArmResponse<SkuDetailsList>
  >;

  /**
   * Gets the private link resources that need to be created for a Redis Enterprise cluster.
   */
  @list
  @get
  @action("privateLinkResources")
  listByCluster is ArmResourceActionSync<
    Cluster,
    void,
    ArmResponse<PrivateLinkResourceListResult>
  >;
}

@@doc(Cluster.name,
  "The name of the Redis Enterprise cluster. Name must be 1-60 characters long. Allowed characters(A-Z, a-z, 0-9) and hyphen(-). There can be no leading nor trailing nor consecutive hyphens"
);
@@doc(Cluster.properties, "Other properties of the cluster.");
@@doc(Clusters.create::parameters.resource,
  "Parameters supplied to the Create Redis Enterprise operation."
);
@@doc(Clusters.update::parameters.properties,
  "Parameters supplied to the Update Redis Enterprise operation."
);

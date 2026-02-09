import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.DocumentDB;
/**
 * Representation of a managed Cassandra cluster.
 */
model GarnetClusterResource
  is Azure.ResourceManager.TrackedResource<GarnetClusterProperties> {
  ...ResourceNameParameter<
    Resource = GarnetClusterResource,
    KeyName = "clusterName",
    SegmentName = "garnetClusters",
    NamePattern = ""
  >;

  /**
   * Identity for the resource.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  identity?: ManagedCassandraManagedServiceIdentity;
}

@armResourceOperations
interface GarnetClusters {
  /**
   * Get the properties of a Garnet cache cluster.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("GarnetClusters_Get")
  get is ArmResourceRead<GarnetClusterResource>;

  /**
   * Create or update a Garnet cache cluster. When updating, you must specify all writable properties.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("GarnetClusters_CreateUpdate")
  createUpdate is ArmResourceCreateOrReplaceAsync<
    GarnetClusterResource,
    LroHeaders = ArmLroLocationHeader<FinalResult = GarnetClusterResource> &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Updates some of the properties of a garnet cluster.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("GarnetClusters_Update")
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchAsync<
    GarnetClusterResource,
    PatchModel = ClusterResourcePatch
  >;

  /**
   * Deletes a Garnet cluster.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("GarnetClusters_Delete")
  delete is ArmResourceDeleteWithoutOkAsync<GarnetClusterResource>;

  /**
   * List all Garnet clusters in this resource group.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("GarnetClusters_ListByResourceGroup")
  listByResourceGroup is ArmResourceListByParent<
    GarnetClusterResource,
    Response = ArmResponse<ListClusters>
  >;

  /**
   * List all Garnet clusters in this subscription.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("GarnetClusters_ListBySubscription")
  listBySubscription is ArmListBySubscription<
    GarnetClusterResource,
    Response = ArmResponse<ListClusters>
  >;
}

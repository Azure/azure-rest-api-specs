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
 * Representation of a Garnet cache cluster.
 */
model GarnetClusterResource
  is Azure.ResourceManager.TrackedResource<GarnetClusterResourceProperties> {
  ...ResourceNameParameter<
    Resource = GarnetClusterResource,
    KeyName = "clusterName",
    SegmentName = "garnetClusters",
    NamePattern = "^[a-zA-Z0-9]+(-[a-zA-Z0-9]+)*$"
  >;

  /**
   * Identity for the resource.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  identity?: ManagedCassandraManagedServiceIdentity;
}

@armResourceOperations(#{ omitTags: true })
interface GarnetClusters {
  /**
   * Get the properties of a Garnet cache cluster.
   */
  get is ArmResourceRead<GarnetClusterResource>;

  /**
   * Create or update a Garnet cache cluster. When updating, you must specify all writable properties.
   */
  createUpdate is ArmResourceCreateOrReplaceAsync<
    GarnetClusterResource,
    LroHeaders = ArmLroLocationHeader<FinalResult = GarnetClusterResource> &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Updates some of the properties of a garnet cluster.
   */
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchAsync<
    GarnetClusterResource,
    PatchModel = GarnetClusterResourcePatch,
    Response = ArmResponse<GarnetClusterResource> | ArmAcceptedLroResponse<LroHeaders = ArmCombinedLroHeaders<FinalResult = GarnetClusterResource> &
      Azure.Core.Foundations.RetryAfterHeader>
  >;

  /**
   * Deletes a Garnet cluster.
   */
  delete is ArmResourceDeleteWithoutOkAsync<
    GarnetClusterResource,
    Response = ArmDeleteAcceptedLroResponse<LroHeaders = ArmCombinedLroHeaders &
      Azure.Core.Foundations.RetryAfterHeader> | ArmDeletedNoContentResponse
  >;

  /**
   * List all Garnet clusters in this resource group.
   */
  listByResourceGroup is ArmResourceListByParent<
    GarnetClusterResource,
    Response = ArmResponse<ListGarnetClusters>
  >;

  /**
   * List all Garnet clusters in this subscription.
   */
  listBySubscription is ArmListBySubscription<
    GarnetClusterResource,
    Response = ArmResponse<ListGarnetClusters>
  >;
}

@@maxLength(GarnetClusterResource.name, 100);
@@minLength(GarnetClusterResource.name, 1);

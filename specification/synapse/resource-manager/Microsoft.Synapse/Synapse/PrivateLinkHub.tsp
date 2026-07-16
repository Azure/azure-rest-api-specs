import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Synapse;
/**
 * A privateLinkHub
 */
model PrivateLinkHub
  is Azure.ResourceManager.TrackedResource<PrivateLinkHubProperties> {
  ...ResourceNameParameter<
    Resource = PrivateLinkHub,
    KeyName = "privateLinkHubName",
    SegmentName = "privateLinkHubs",
    NamePattern = ""
  >;
}

@armResourceOperations
interface PrivateLinkHubs {
  /**
   * Gets a privateLinkHub
   */
  get is ArmResourceRead<PrivateLinkHub>;

  /**
   * Creates or updates a privateLinkHub
   */
  createOrUpdate is ArmResourceCreateOrReplaceSync<PrivateLinkHub>;

  /**
   * Updates a privateLinkHub
   */
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchSync<
    PrivateLinkHub,
    PatchModel = PrivateLinkHubPatchInfo,
    Response =
      | ArmResponse<PrivateLinkHub>
      | ArmResourceCreatedSyncResponse<PrivateLinkHub>
  >;

  /**
   * Deletes a privateLinkHub
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/lro-location-header" "For backward compatibility"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  delete is ArmResourceDeleteWithoutOkAsync<
    PrivateLinkHub,
    Response =
      | ArmDeletedResponse
      | ArmDeleteAcceptedLroResponse<ArmAsyncOperationHeader &
          Azure.Core.Foundations.RetryAfterHeader>
      | ArmDeletedNoContentResponse
  >;

  /**
   * Returns a list of privateLinkHubs in a resource group
   */
  listByResourceGroup is ArmResourceListByParent<PrivateLinkHub>;

  /**
   * Returns a list of privateLinkHubs in a subscription
   */
  list is ArmListBySubscription<PrivateLinkHub>;
}

@@doc(PrivateLinkHub.name, "Name of the privateLinkHub");
@@doc(PrivateLinkHub.properties, "PrivateLinkHub resource properties");
@@doc(
  PrivateLinkHubs.createOrUpdate::parameters.resource,
  "PrivateLinkHub create or update request properties"
);
@@doc(
  PrivateLinkHubs.update::parameters.properties,
  "PrivateLinkHub patch request properties"
);

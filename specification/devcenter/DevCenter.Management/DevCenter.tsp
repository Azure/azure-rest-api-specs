import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.DevCenter;
/**
 * Represents a devcenter resource.
 */
model DevCenter is Azure.ResourceManager.TrackedResource<DevCenterProperties> {
  ...ResourceNameParameter<
    Resource = DevCenter,
    KeyName = "devCenterName",
    SegmentName = "devcenters",
    NamePattern = "^[a-zA-Z0-9][a-zA-Z0-9-]{2,25}$"
  >;

  /**
   * Managed identity properties
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  identity?: Azure.ResourceManager.CommonTypes.ManagedServiceIdentity;
}

@armResourceOperations
interface DevCenters {
  /**
   * Gets a devcenter.
   */
  get is ArmResourceRead<DevCenter>;

  /**
   * Creates or updates a devcenter resource
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<DevCenter>;

  /**
   * Partially updates a devcenter.
   */
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchAsync<
    DevCenter,
    PatchModel = DevCenterUpdate,
    LroHeaders = ArmAsyncOperationHeader &
      Azure.Core.Foundations.RetryAfterHeader,
    Response = DevCenter | ArmAcceptedLroResponse<
      "Resource update request accepted.",
      ArmAsyncOperationHeader<FinalResult = DevCenter>
    >
  >;

  /**
   * Deletes a devcenter
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/lro-location-header" "For backward compatibility"
  delete is ArmResourceDeleteWithoutOkAsync<
    DevCenter,
    LroHeaders = ArmAsyncOperationHeader &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Lists all devcenters in a resource group.
   */
  listByResourceGroup is ArmResourceListByParent<
    DevCenter,
    Parameters = {
      /**
       * The maximum number of resources to return from the operation. Example: '$top=10'.
       */
      @query("$top")
      $top?: int32;
    }
  >;

  /**
   * Lists all devcenters in a subscription.
   */
  listBySubscription is ArmListBySubscription<
    DevCenter,
    Parameters = {
      /**
       * The maximum number of resources to return from the operation. Example: '$top=10'.
       */
      @query("$top")
      $top?: int32;
    }
  >;

  /**
   * Lists images for a devcenter.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Images_ListByDevCenter")
  @get
  @action("images")
  listByDevCenter is ArmResourceActionSync<
    DevCenter,
    void,
    ArmResponse<ResourceListResult<Image>>,
    Parameters = {
      /**
       * The maximum number of resources to return from the operation. Example: '$top=10'.
       */
      @query("$top")
      $top?: int32;
    }
  >;
}

@@maxLength(DevCenter.name, 26);
@@minLength(DevCenter.name, 3);
@@doc(DevCenter.name, "The name of the devcenter.");
@@doc(DevCenter.properties, "DevCenter properties");
@@doc(DevCenters.createOrUpdate::parameters.resource,
  "Represents a devcenter."
);
@@doc(DevCenters.update::parameters.properties,
  "Updatable devcenter properties."
);

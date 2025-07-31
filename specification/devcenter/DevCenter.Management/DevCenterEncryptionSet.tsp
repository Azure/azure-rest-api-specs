import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./DevCenter.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.DevCenter;
/**
 * Represents a devcenter encryption set resource.
 */
@parentResource(DevCenter)
model DevCenterEncryptionSet
  is Azure.ResourceManager.TrackedResource<DevCenterEncryptionSetProperties> {
  ...ResourceNameParameter<
    Resource = DevCenterEncryptionSet,
    KeyName = "encryptionSetName",
    SegmentName = "encryptionSets",
    NamePattern = "^[a-zA-Z0-9][a-zA-Z0-9-]{2,25}$"
  >;

  /**
   * Managed identity properties
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  identity?: Azure.ResourceManager.CommonTypes.ManagedServiceIdentity;
}

@armResourceOperations
interface DevCenterEncryptionSets {
  /**
   * Gets a devcenter encryption set.
   */
  get is ArmResourceRead<DevCenterEncryptionSet>;

  /**
   * Creates or updates a devcenter encryption set resource
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<DevCenterEncryptionSet>;

  /**
   * Partially updates a devcenter encryption set.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/lro-location-header" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchAsync<
    DevCenterEncryptionSet,
    PatchModel = EncryptionSetUpdate,
    LroHeaders = ArmAsyncOperationHeader &
      Azure.Core.Foundations.RetryAfterHeader,
    Response = DevCenterEncryptionSet | ArmAcceptedLroResponse<
      "Resource update request accepted.",
      ArmAsyncOperationHeader<FinalResult = DevCenterEncryptionSet>
    >
  >;

  /**
   * Deletes a devcenter encryption set
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/lro-location-header" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  delete is ArmResourceDeleteWithoutOkAsync<
    DevCenterEncryptionSet,
    LroHeaders = ArmAsyncOperationHeader &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Lists all encryption sets in the devcenter.
   */
  list is ArmResourceListByParent<
    DevCenterEncryptionSet,
    Parameters = {
      /**
       * The maximum number of resources to return from the operation. Example: '$top=10'.
       */
      @query("$top")
      $top?: int32;
    },
    Response = EncryptionSetListResult
  >;
}

@@maxLength(DevCenterEncryptionSet.name, 63);
@@minLength(DevCenterEncryptionSet.name, 3);
@@doc(DevCenterEncryptionSet.name, "The name of the devcenter encryption set.");
@@doc(DevCenterEncryptionSet.properties,
  "Properties of a devcenter encryption set."
);
@@doc(DevCenterEncryptionSets.createOrUpdate::parameters.resource,
  "Represents a devcenter encryption set."
);
@@doc(DevCenterEncryptionSets.update::parameters.properties,
  "Updatable devcenter encryption set properties."
);

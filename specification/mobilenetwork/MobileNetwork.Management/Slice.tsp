import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./MobileNetwork.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.MobileNetwork;
/**
 * Network slice resource. Must be created in the same location as its parent mobile network.
 */
@parentResource(MobileNetwork)
model Slice
  is Azure.ResourceManager.TrackedResource<SlicePropertiesFormat, false> {
  ...ResourceNameParameter<
    Resource = Slice,
    KeyName = "sliceName",
    SegmentName = "slices",
    NamePattern = "^[a-zA-Z0-9][a-zA-Z0-9_-]*$"
  >;
}

@armResourceOperations
interface Slices {
  /**
   * Gets information about the specified network slice.
   */
  get is ArmResourceRead<Slice>;

  /**
   * Creates or updates a network slice. Must be created in the same location as its parent mobile network.
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<Slice>;

  /**
   * Updates slice tags.
   */
  @patch(#{ implicitOptionality: false })
  updateTags is ArmCustomPatchSync<Slice, PatchModel = TagsObject>;

  /**
   * Deletes the specified network slice.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  delete is ArmResourceDeleteWithoutOkAsync<
    Slice,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse
  >;

  /**
   * Lists all slices in the mobile network.
   */
  listByMobileNetwork is ArmResourceListByParent<Slice>;
}

@@maxLength(Slice.name, 64);
@@doc(Slice.name, "The name of the network slice.");
@@doc(Slice.properties, "Slice properties.");
@@doc(Slices.createOrUpdate::parameters.resource,
  "Parameters supplied to the create or update network slice operation."
);
@@doc(Slices.updateTags::parameters.properties,
  "Parameters supplied to update network slice tags."
);

import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Gallery.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Compute;
/**
 * Specifies information about the gallery inVMAccessControlProfile that you want to create or update.
 */
@parentResource(Gallery)
model GalleryInVMAccessControlProfile
  is Azure.ResourceManager.TrackedResource<GalleryInVMAccessControlProfileProperties> {
  ...ResourceNameParameter<
    Resource = GalleryInVMAccessControlProfile,
    KeyName = "inVMAccessControlProfileName",
    SegmentName = "inVMAccessControlProfiles",
    NamePattern = ""
  >;
}

@armResourceOperations
interface GalleryInVMAccessControlProfiles {
  /**
   * Retrieves information about a gallery inVMAccessControlProfile.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("GalleryInVMAccessControlProfiles_Get")
  get is ComputeResourceRead<GalleryInVMAccessControlProfile>;

  /**
   * Create or update a gallery inVMAccessControlProfile.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("GalleryInVMAccessControlProfiles_CreateOrUpdate")
  createOrUpdate is ComputeResourceCreateOrReplaceAsync<
    GalleryInVMAccessControlProfile,
    LroHeaders = ArmLroLocationHeader & Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Update a gallery inVMAccessControlProfile.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @patch(#{ implicitOptionality: false })
  @operationId("GalleryInVMAccessControlProfiles_Update")
  update is ComputeCustomPatchAsync<
    GalleryInVMAccessControlProfile,
    PatchModel = GalleryInVMAccessControlProfileUpdate,
    Response = ArmResponse<GalleryInVMAccessControlProfile> &
      ArmLroLocationHeader &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Delete a gallery inVMAccessControlProfile.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  @operationId("GalleryInVMAccessControlProfiles_Delete")
  delete is ComputeResourceDeleteAsync<
    GalleryInVMAccessControlProfile,
    Response = ArmDeleteAcceptedLroResponse<ArmLroLocationHeader &
      ArmAsyncOperationHeader> | ArmDeletedNoContentResponse
  >;

  /**
   * List gallery inVMAccessControlProfiles in a gallery.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("GalleryInVMAccessControlProfiles_ListByGallery")
  listByGallery is ComputeResourceListByParent<
    GalleryInVMAccessControlProfile,
    Response = ArmResponse<GalleryInVMAccessControlProfileList>
  >;
}

@@doc(GalleryInVMAccessControlProfile.name,
  "The name of the gallery inVMAccessControlProfile to be retrieved."
);
@@doc(GalleryInVMAccessControlProfile.properties,
  "Describes the properties of a gallery inVMAccessControlProfile."
);
@@doc(GalleryInVMAccessControlProfiles.createOrUpdate::parameters.resource,
  "Parameters supplied to the create or update gallery inVMAccessControlProfile operation."
);
@@doc(GalleryInVMAccessControlProfiles.update::parameters.properties,
  "Parameters supplied to the update gallery inVMAccessControlProfile operation."
);

import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./Gallery.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using Common;

namespace ComputeGallery;
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
  get is ComputeResourceRead<GalleryInVMAccessControlProfile>;

  /**
   * Create or update a gallery inVMAccessControlProfile.
   */
  createOrUpdate is ComputeResourceCreateOrReplaceAsync<
    GalleryInVMAccessControlProfile,
    LroHeaders = ArmLroLocationHeader<FinalResult = GalleryInVMAccessControlProfile> &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Update a gallery inVMAccessControlProfile.
   */
  @patch(#{ implicitOptionality: false })
  update is ComputeCustomPatchAsync<
    GalleryInVMAccessControlProfile,
    PatchModel = GalleryInVMAccessControlProfileUpdate,
    Response = ArmResponse<GalleryInVMAccessControlProfile> &
      ArmLroLocationHeader<FinalResult = GalleryInVMAccessControlProfile> &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Delete a gallery inVMAccessControlProfile.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  delete is ComputeResourceDeleteAsync<
    GalleryInVMAccessControlProfile,
    Response =
      | ArmDeleteAcceptedLroResponse<ArmLroLocationHeader &
          ArmAsyncOperationHeader>
      | ArmDeletedNoContentResponse
  >;

  /**
   * List gallery inVMAccessControlProfiles in a gallery.
   */
  listByGallery is ComputeResourceListByParent<
    GalleryInVMAccessControlProfile,
    Response = ArmResponse<GalleryInVMAccessControlProfileList>
  >;
}

@@doc(
  GalleryInVMAccessControlProfile.name,
  "The name of the gallery inVMAccessControlProfile to be retrieved."
);
@@doc(
  GalleryInVMAccessControlProfile.properties,
  "Describes the properties of a gallery inVMAccessControlProfile."
);
@@doc(
  GalleryInVMAccessControlProfiles.createOrUpdate::parameters.resource,
  "Parameters supplied to the create or update gallery inVMAccessControlProfile operation."
);
@@doc(
  GalleryInVMAccessControlProfiles.update::parameters.properties,
  "Parameters supplied to the update gallery inVMAccessControlProfile operation."
);

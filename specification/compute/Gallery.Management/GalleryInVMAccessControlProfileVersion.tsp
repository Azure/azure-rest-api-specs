import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./GalleryInVMAccessControlProfile.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Compute;
/**
 * Specifies information about the gallery inVMAccessControlProfile version that you want to create or update.
 */
@parentResource(GalleryInVMAccessControlProfile)
model GalleryInVMAccessControlProfileVersion
  is Azure.ResourceManager.TrackedResource<GalleryInVMAccessControlProfileVersionProperties> {
  ...ResourceNameParameter<
    Resource = GalleryInVMAccessControlProfileVersion,
    KeyName = "inVMAccessControlProfileVersionName",
    SegmentName = "versions",
    NamePattern = ""
  >;
}

@armResourceOperations
interface GalleryInVMAccessControlProfileVersions {
  /**
   * Retrieves information about a gallery inVMAccessControlProfile version.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("GalleryInVMAccessControlProfileVersions_Get")
  get is ComputeResourceRead<GalleryInVMAccessControlProfileVersion>;

  /**
   * Create or update a gallery inVMAccessControlProfile version.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("GalleryInVMAccessControlProfileVersions_CreateOrUpdate")
  createOrUpdate is ComputeResourceCreateOrReplaceAsync<
    GalleryInVMAccessControlProfileVersion,
    LroHeaders = ArmLroLocationHeader & Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Update a gallery inVMAccessControlProfile version.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @patch(#{ implicitOptionality: false })
  @operationId("GalleryInVMAccessControlProfileVersions_Update")
  update is ComputeCustomPatchAsync<
    GalleryInVMAccessControlProfileVersion,
    PatchModel = GalleryInVMAccessControlProfileVersionUpdate,
    Response = ArmResponse<GalleryInVMAccessControlProfileVersion> &
      ArmLroLocationHeader &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Delete a gallery inVMAccessControlProfile version.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  @operationId("GalleryInVMAccessControlProfileVersions_Delete")
  delete is ComputeResourceDeleteAsync<
    GalleryInVMAccessControlProfileVersion,
    Response = ArmDeleteAcceptedLroResponse<ArmLroLocationHeader &
      ArmAsyncOperationHeader> | ArmDeletedNoContentResponse
  >;

  /**
   * List gallery inVMAccessControlProfile versions in a gallery inVMAccessControlProfile
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("GalleryInVMAccessControlProfileVersions_ListByGalleryInVMAccessControlProfile")
  listByGalleryInVMAccessControlProfile is ComputeResourceListByParent<
    GalleryInVMAccessControlProfileVersion,
    Response = ArmResponse<GalleryInVMAccessControlProfileVersionList>
  >;
}

@@doc(GalleryInVMAccessControlProfileVersion.name,
  "The name of the gallery inVMAccessControlProfile version to be retrieved."
);
@@doc(GalleryInVMAccessControlProfileVersion.properties,
  "Describes the properties of an inVMAccessControlProfile version."
);
@@doc(GalleryInVMAccessControlProfileVersions.createOrUpdate::parameters.resource,
  "Parameters supplied to the create or update gallery inVMAccessControlProfile version operation."
);
@@doc(GalleryInVMAccessControlProfileVersions.update::parameters.properties,
  "Parameters supplied to the update gallery inVMAccessControlProfile version operation."
);

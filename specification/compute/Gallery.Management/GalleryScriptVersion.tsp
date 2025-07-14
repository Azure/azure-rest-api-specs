import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "@typespec/versioning";
import "./models.tsp";
import "./GalleryScript.tsp";
import "../Common.Management/operations.tsp";

using TypeSpec.Rest;
using Versioning;
using Azure.ResourceManager;
using TypeSpec.Http;

namespace Microsoft.Compute {
  /**
   * The List Gallery Script version operation response.
   */
  @added(Versions.v2025_03_03)
  model GalleryScriptVersionList is Azure.Core.Page<GalleryScriptVersion>;

  /**
   * Specifies information about the gallery Script Version that you want to create or update.
   */
  @added(Versions.v2025_03_03)
  @parentResource(GalleryScript)
  model GalleryScriptVersion
    is Azure.ResourceManager.TrackedResource<GalleryScriptVersionProperties> {
    ...ResourceNameParameter<
      Resource = GalleryScriptVersion,
      KeyName = "galleryScriptVersionName",
      SegmentName = "versions",
      NamePattern = ""
    >;
  }

  @armResourceOperations
  interface GalleryScriptVersions {
    /**
     * Retrieves information about a gallery Script Version.
     */
    @added(Versions.v2025_03_03)
    get is ComputeResourceRead<GalleryScriptVersion>;

    /**
     * Create or update a gallery Script Version. Script versions helps save different states/iterations of a Gallery script. They are referred in format: <MajorVersion>.<MinorVersion>.<Patch>
     */
    #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "For backward compatibility"
    #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "For backward compatibility"
    @added(Versions.v2025_03_03)
    createOrUpdate is ComputeResourceCreateOrReplaceAsync<
      GalleryScriptVersion,
      Response = ArmResourceUpdatedResponse<GalleryScriptVersion> | ArmResourceCreatedResponse<
        GalleryScriptVersion,
        ArmLroLocationHeader & Azure.Core.Foundations.RetryAfterHeader
      > | (ArmAcceptedLroResponse & {
        @bodyRoot
        @added(Versions.v2025_03_03)
        _: GalleryScriptVersion;
      })
    >;

    /**
     * Update a gallery Script Version.
     */
    @added(Versions.v2025_03_03)
    @patch(#{ implicitOptionality: false })
    update is ComputeCustomPatchAsync<
      GalleryScriptVersion,
      PatchModel = GalleryScriptVersionUpdate,
      Response = ArmResponse<GalleryScriptVersion> &
        ArmLroLocationHeader &
        Azure.Core.Foundations.RetryAfterHeader
    >;

    /**
     * Delete a gallery Script Version.
     */
    #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
    @added(Versions.v2025_03_03)
    delete is ComputeResourceDeleteAsync<
      GalleryScriptVersion,
      Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse
    >;

    /**
     * List gallery Script Versions in a gallery Script Definition.
     */
    #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-duplicate-property" "For backward compatibility"
    @added(Versions.v2025_03_03)
    listByGalleryScript is ComputeResourceListByParent<
      GalleryScriptVersion,
      Response = ArmResponse<GalleryScriptVersionList>
    >;
  }

  @@doc(GalleryScriptVersion.name,
    "The name of the gallery Script Version to be retrieved."
  );
  @@doc(GalleryScriptVersion.properties,
    "Describes the properties of a gallery Script Version."
  );
  @@doc(GalleryScriptVersions.createOrUpdate::parameters.resource,
    "Parameters supplied to the create or update gallery Script Version operation."
  );
  @@doc(GalleryScriptVersions.update::parameters.properties,
    "Parameters supplied to the update gallery Script Version operation."
  );
}

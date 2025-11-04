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
   * Gallery script version name with semantic version pattern validation
   */
  @pattern("^[0-9]+\\.[0-9]+\\.[0-9]+$")
  @doc("The name of the gallery Script Version to be created. Needs to follow semantic version name pattern: The allowed characters are digit and period. Digits must be within the range of a 32-bit integer. Format: <MajorVersion>.<MinorVersion>.<Patch>")
  scalar GalleryScriptVersionName extends string;

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
    @key("galleryScriptVersionName")
    @segment("versions")
    @path
    name: GalleryScriptVersionName;
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
        ArmAsyncOperationHeader<FinalResult = GalleryScriptVersion> & Azure.Core.Foundations.RetryAfterHeader
      >
    >;

    /**
     * Update a gallery Script Version.
     */
    @added(Versions.v2025_03_03)
    @patch(#{ implicitOptionality: false })
    update is ComputeCustomPatchAsync<
      GalleryScriptVersion,
      PatchModel = GalleryScriptVersionUpdate,
      // Include Azure-AsyncOperation (and keep Location for broader client compatibility) plus Retry-After
      LroHeaders = ArmAsyncOperationHeader<FinalResult = GalleryScriptVersion> &
        ArmLroLocationHeader &
        Azure.Core.Foundations.RetryAfterHeader,
      Response = ArmResponse<GalleryScriptVersion> | ArmAcceptedLroResponse<
        "Resource update request accepted.",
        LroHeaders
      >
    >;

    /**
     * Delete a gallery Script Version.
     */
    #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
    @added(Versions.v2025_03_03)
    delete is ComputeResourceDeleteAsync<
      GalleryScriptVersion,
      BaseParameters = Azure.ResourceManager.Foundations.DefaultBaseParameters<GalleryScriptVersion>,
      // Add Azure-AsyncOperation header (keep Location + Retry-After for compatibility)
      LroHeaders = ArmAsyncOperationHeader &
        ArmLroLocationHeader &
        Azure.Core.Foundations.RetryAfterHeader,
      Parameters = {},
      Response = ArmDeleteAcceptedLroResponse<LroHeaders> | ArmDeletedNoContentResponse
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

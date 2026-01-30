import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "@typespec/versioning";
import "./models.tsp";
import "./GalleryScript.tsp";
import "../Common.Management/operations.tsp";

using TypeSpec.Rest;
using Versioning;
using Azure.ResourceManager;
using TypeSpec.Http;
using Azure.Core; // Needed for @useFinalStateVia decorator

namespace Microsoft.Compute {
  @pattern("^[0-9]+\\.[0-9]+\\.[0-9]+$")
  @doc("The name of the gallery Script Version to be created. Needs to follow semantic version name pattern: The allowed characters are digit and period. Digits must be within the range of a 32-bit integer. Format: <MajorVersion>.<MinorVersion>.<Patch>")
  scalar GalleryScriptVersionName extends string;

  @added(Versions.v2025_03_03)
  model GalleryScriptVersionList is Azure.Core.Page<GalleryScriptVersion>;

  @added(Versions.v2025_03_03)
  @parentResource(GalleryScript)
  model GalleryScriptVersion
    is Azure.ResourceManager.TrackedResource<GalleryScriptVersionProperties> {
    @key("galleryScriptVersionName")
    @segment("versions")
    @path
    name: GalleryScriptVersionName;
  }

  /**
   * Common LRO headers (Azure-AsyncOperation required Jan 2025). Keep Location + Retry-After for backward compatibility.
   */
  alias GalleryScriptVersionLroHeaders = ArmAsyncOperationHeader<FinalResult = GalleryScriptVersion> &
    ArmLroLocationHeader &
    Azure.Core.Foundations.RetryAfterHeader;

  @armResourceOperations
  interface GalleryScriptVersions {
    @added(Versions.v2025_03_03)
    get is ComputeResourceRead<GalleryScriptVersion>;

    /**
     * Create or update a gallery Script Version.
     */
    #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "For backward compatibility"
    #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "For backward compatibility"
    @useFinalStateVia("azure-async-operation")
    @added(Versions.v2025_03_03)
    createOrUpdate is ComputeResourceCreateOrReplaceAsync<
      GalleryScriptVersion,
      Azure.ResourceManager.Foundations.DefaultBaseParameters<GalleryScriptVersion>,
      GalleryScriptVersionLroHeaders,
      {},
      ArmResourceUpdatedResponse<GalleryScriptVersion> | ArmResourceCreatedResponse<
        GalleryScriptVersion,
        GalleryScriptVersionLroHeaders
      >
    >;

    /**
     * Update a gallery Script Version.
     */
    @useFinalStateVia("azure-async-operation")
    @added(Versions.v2025_03_03)
    @patch(#{ implicitOptionality: false })
    update is ComputeCustomPatchAsync<
      GalleryScriptVersion,
      GalleryScriptVersionUpdate,
      Azure.ResourceManager.Foundations.DefaultBaseParameters<GalleryScriptVersion>,
      GalleryScriptVersionLroHeaders,
      {},
      ArmResponse<GalleryScriptVersion> | ArmAcceptedLroResponse<
        "Resource update request accepted.",
        GalleryScriptVersionLroHeaders
      >
    >;

    /**
     * Delete a gallery Script Version.
     */
    #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
    @useFinalStateVia("azure-async-operation")
    @added(Versions.v2025_03_03)
    delete is ComputeResourceDeleteAsync<
      GalleryScriptVersion,
      Azure.ResourceManager.Foundations.DefaultBaseParameters<GalleryScriptVersion>,
      GalleryScriptVersionLroHeaders,
      {},
      ArmDeleteAcceptedLroResponse<GalleryScriptVersionLroHeaders> | ArmDeletedNoContentResponse
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

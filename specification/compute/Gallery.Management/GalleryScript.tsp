import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "@typespec/versioning";
import "./models.tsp";
import "./Gallery.tsp";
import "../Common.Management/operations.tsp";

using TypeSpec.Rest;
using Versioning;
using Azure.ResourceManager;
using TypeSpec.Http;

namespace Microsoft.Compute;

/**
 * Gallery script name with pattern validation
 */
@pattern("^[a-zA-Z0-9]+([_]?[a-zA-Z0-9]+)*$")
@doc("The name of the gallery Script Definition in which the Script Version is to be created.")
scalar GalleryScriptName extends string;

/**
 * Specifies information about the gallery Script Definition that you want to create or update.
 */
@added(Versions.v2025_03_03)
@parentResource(Gallery)
model GalleryScript
  is Azure.ResourceManager.TrackedResource<GalleryScriptProperties> {
  @key("galleryScriptName")
  @segment("scripts")
  @path
  name: GalleryScriptName;
}

@armResourceOperations
interface GalleryScripts {
  /**
   * Retrieves information about a gallery script definition.
   */
  @added(Versions.v2025_03_03)
  get is ComputeResourceRead<GalleryScript>;

  /**
   * Create or update a Gallery Script Definition. Gallery scripts allow the storage, sharing and reuse of common scripts
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "For backward compatibility"
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "For backward compatibility"
  @added(Versions.v2025_03_03)
  createOrUpdate is ComputeResourceCreateOrReplaceAsync<
    GalleryScript,
    Response = ArmResourceUpdatedResponse<GalleryScript> | ArmResourceCreatedResponse<
      GalleryScript,
      ArmLroLocationHeader & Azure.Core.Foundations.RetryAfterHeader
    >
  >;

  /**
   * Update a gallery Script Definition.
   */
  @patch(#{ implicitOptionality: false })
  @added(Versions.v2025_03_03)
  update is ComputeCustomPatchAsync<
    GalleryScript,
    PatchModel = GalleryScriptUpdate,
    Response = ArmResponse<GalleryScript> | ArmAcceptedLroResponse
  >;

  /**
   * Delete a gallery Script Definition.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  @added(Versions.v2025_03_03)
  delete is ComputeResourceDeleteAsync<
    GalleryScript,
    Response = ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse
  >;

  /**
   * List gallery Script Definitions in a gallery.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-duplicate-property" "For backward compatibility"
  @added(Versions.v2025_03_03)
  listByGallery is ComputeResourceListByParent<
    GalleryScript,
    Response = ArmResponse<GalleryScriptList>
  >;
}

@@doc(GalleryScript.name,
  "The name of the gallery Script Definition to be retrieved."
);
@@doc(GalleryScript.properties,
  "Describes the properties of a gallery Script Definition."
);
@@doc(GalleryScripts.createOrUpdate::parameters.resource,
  "Parameters supplied to the create or update gallery Script operation."
);
@@doc(GalleryScripts.update::parameters.properties,
  "Parameters supplied to the update gallery Script operation."
);

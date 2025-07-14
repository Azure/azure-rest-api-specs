import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Gallery.tsp";
import "../Common.Management/operations.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;

namespace Microsoft.Compute;
/**
 * Specifies information about the gallery Script Definition that you want to create or update.
 */
@parentResource(Gallery)
model GalleryScript
  is Azure.ResourceManager.TrackedResource<GalleryScriptProperties> {
  ...ResourceNameParameter<
    Resource = GalleryScript,
    KeyName = "galleryScriptName",
    SegmentName = "scripts",
    NamePattern = ""
  >;
}

@armResourceOperations
interface GalleryScripts {
  /**
   * Retrieves information about a gallery script definition.
   */
  get is ComputeResourceRead<GalleryScript>;

  /**
   * Create or update a Gallery Script Definition. Gallery scripts allow the storage, sharing and reuse of common scripts
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "For backward compatibility"
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "For backward compatibility"
  createOrUpdate is ComputeResourceCreateOrReplaceAsync<
    GalleryScript,
    Response = ArmResourceUpdatedResponse<GalleryScript> | ArmResourceCreatedResponse<
      GalleryScript,
      ArmLroLocationHeader & Azure.Core.Foundations.RetryAfterHeader
    > | (ArmAcceptedLroResponse & {
      @bodyRoot
      _: GalleryScript;
    })
  >;

  /**
   * Update a gallery Script Definition.
   */
  @patch(#{ implicitOptionality: false })
  update is ComputeCustomPatchAsync<
    GalleryScript,
    PatchModel = GalleryScriptUpdate,
    Response = ArmResponse<GalleryScript> &
      ArmLroLocationHeader &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Delete a gallery Script Definition.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  delete is ComputeResourceDeleteAsync<
    GalleryScript,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse
  >;

  /**
   * List gallery Script Definitions in a gallery.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-duplicate-property" "For backward compatibility"
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

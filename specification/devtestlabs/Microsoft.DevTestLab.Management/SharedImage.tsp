import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.DevTestLab;
/**
 * Properties of a shared image
 */
model SharedImage
  is Azure.ResourceManager.TrackedResource<SharedImageProperties> {
  ...ResourceNameParameter<
    Resource = SharedImage,
    KeyName = "name",
    SegmentName = "sharedimages",
    NamePattern = ""
  >;
}

@armResourceOperations
interface SharedImages {
  /**
   * Get shared image.
   */
  get is ArmResourceRead<
    SharedImage,
    Parameters = {
      /**
       * Specify the $expand query. Example: 'properties($expand=versions)'
       */
      @query("$expand")
      $expand?: string;
    }
  >;

  /**
   * Create or replace an existing Shared Image.
   */
  createOrUpdate is ArmResourceCreateOrReplaceSync<SharedImage>;

  /**
   * Allows modifying tags of shared images. All other properties will be ignored.
   */
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchSync<SharedImage, PatchModel = SharedImageFragment>;

  /**
   * Delete shared image.
   */
  delete is ArmResourceDeleteSync<SharedImage>;

  /**
   * List shared images in a given shared gallery.
   */
  list is ArmResourceListByParent<
    SharedImage,
    Parameters = {
      /**
       * Specify the $expand query. Example: 'properties($expand=versions)'
       */
      @query("$expand")
      $expand?: string;

      /**
       * The filter to apply to the operation. Example: '$filter=contains(name,'myName')'
       */
      @query("$filter")
      $filter?: string;

      /**
       * The maximum number of resources to return from the operation. Example: '$top=10'
       */
      @query("$top")
      $top?: int32;

      /**
       * The ordering expression for the results, using OData notation. Example: '$orderby=name desc'
       */
      @query("$orderby")
      $orderby?: string;
    },
    Response = ArmResponse<SharedImageList>
  >;
}

@@doc(SharedImage.name, "The name of the shared image.");
@@doc(SharedImage.properties, "The properties of the resource.");
@@doc(SharedImages.createOrUpdate::parameters.resource,
  "Properties of a shared image"
);
@@doc(SharedImages.update::parameters.properties,
  "Allows modifying tags of shared images. All other properties will be ignored."
);

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
 * Properties of a shared gallery
 */
model SharedGallery
  is Azure.ResourceManager.TrackedResource<SharedGalleryProperties> {
  ...ResourceNameParameter<
    Resource = SharedGallery,
    KeyName = "name",
    SegmentName = "sharedgalleries",
    NamePattern = ""
  >;
}

@armResourceOperations
interface SharedGalleries {
  /**
   * Get shared gallery.
   */
  get is ArmResourceRead<
    SharedGallery,
    Parameters = {
      /**
       * Specify the $expand query. Example: 'properties($select=identity)'
       */
      @query("$expand")
      $expand?: string;
    }
  >;

  /**
   * Create or replace an existing Shared Gallery.
   */
  createOrUpdate is ArmResourceCreateOrReplaceSync<SharedGallery>;

  /**
   * Allows modifying tags of shared galleries. All other properties will be ignored.
   */
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchSync<
    SharedGallery,
    PatchModel = SharedGalleryFragment
  >;

  /**
   * Delete shared gallery.
   */
  delete is ArmResourceDeleteSync<SharedGallery>;

  /**
   * List shared galleries in a given lab.
   */
  list is ArmResourceListByParent<
    SharedGallery,
    Parameters = {
      /**
       * Specify the $expand query. Example: 'properties($select=identity)'
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
    Response = ArmResponse<SharedGalleryList>
  >;
}

@@doc(SharedGallery.name, "The name of the shared gallery.");
@@doc(SharedGallery.properties, "The properties of the resource.");
@@doc(SharedGalleries.createOrUpdate::parameters.resource,
  "Properties of a shared gallery"
);
@@doc(SharedGalleries.update::parameters.properties,
  "Allows modifying tags of shared galleries. All other properties will be ignored."
);

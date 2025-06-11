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
 * A gallery image.
 */
model GalleryImage
  is Azure.ResourceManager.TrackedResource<GalleryImageProperties, false> {
  ...ResourceNameParameter<
    Resource = GalleryImage,
    KeyName = "name",
    SegmentName = "galleryimages",
    NamePattern = ""
  >;
}

@armResourceOperations
interface GalleryImages {
  /**
   * Get gallery image.
   */
  get is ArmResourceRead<GalleryImage>;

  /**
   * List gallery images in a given lab.
   */
  list is ArmResourceListByParent<
    GalleryImage,
    Parameters = {
      /**
       * Specify the $expand query. Example: 'properties($select=author)'
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

      /**
       * A value indicating whether gallery images list should include images with same name and different generations. Example: 'withGeneration=true'
       */
      @query("withGeneration")
      withGeneration?: boolean;
    },
    Response = ArmResponse<GalleryImageList>
  >;
}

@@doc(GalleryImage.name, "The name of the gallery image.");
@@doc(GalleryImage.properties, "The properties of the resource.");

import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;

namespace Microsoft.DevTestLab;
/**
 * A gallery image.
 */
model GalleryImage
  is Azure.ResourceManager.ProxyResource<GalleryImageProperties> {
  ...ResourceNameParameter<
    Resource = GalleryImage,
    KeyName = "name",
    SegmentName = "galleryimages",
    NamePattern = ""
  >;
  ...Azure.ResourceManager.Foundations.ArmTagsProperty;

  /**
   * The geo-location where the resource lives
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "Day 0 Property"
  @visibility(Lifecycle.Create, Lifecycle.Read)
  location?: string;
}

@armResourceOperations
interface GalleryImageOps
  extends Azure.ResourceManager.Legacy.LegacyOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
        ...ResourceGroupParameter,
        ...Azure.ResourceManager.Legacy.Provider,

        /** The name of the lab. */
        @path @segment("labs") labName: string,
      },
      KeysOf<ResourceNameParameter<
        Resource = GalleryImage,
        KeyName = "name",
        SegmentName = "galleryimages",
        NamePattern = ""
      >>
    > {}

@armResourceOperations
interface GalleryImages {
  /**
   * List gallery images in a given lab.
   */
  list is GalleryImageOps.List<
    GalleryImage,
    Parameters = {
      /**
       * Specify the $expand query. Example: 'properties($select=displayName)'
       */
      @query("$expand")
      $expand?: string;

      /**
       * The filter to apply to the operation. Example: '$filter=contains(name,'myName')
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
    Response = ArmResponse<GalleryImageList>
  >;
}

@@doc(GalleryImage.name, "The name of the gallery image.");
@@doc(GalleryImage.properties, "The properties of the gallery image.");

import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Gallery.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.DevCenter;
/**
 * Represents an image.
 */
@parentResource(Gallery)
model Image is ProxyResource<ImageProperties> {
  /**
   * The name of the image.
   */
  @path
  @key("imageName")
  @segment("images")
  name: string;
}

@armResourceOperations
interface Images {
  /**
   * Gets a gallery image.
   */
  get is ArmResourceRead<Image>;

  /**
   * Lists images for a gallery.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Images_ListByGallery")
  listByGallery is ArmResourceListByParent<
    Image,
    {
      ...BaseParameters<Image>;

      /**
       * The maximum number of resources to return from the operation. Example: '$top=10'.
       */
      @query("$top")
      $top?: int32;
    }
  >;
}

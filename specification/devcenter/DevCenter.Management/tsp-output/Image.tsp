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
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@parentResource(Gallery)
@includeInapplicableMetadataInPayload(false)
@Azure.ResourceManager.Private.armResourceInternal(ImageProperties)
model Image extends ProxyResourceBase {
  /**
   * The name of the image.
   */
  @path
  @key("imageName")
  @segment("images")
  @visibility("read")
  name: string;

  /**
   * Image properties.
   */
  @extension("x-ms-client-flatten", true)
  properties?: ImageProperties;
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

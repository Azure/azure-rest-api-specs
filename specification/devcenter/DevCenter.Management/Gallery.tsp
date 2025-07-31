import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./DevCenter.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.DevCenter;
/**
 * Represents a gallery.
 */
@parentResource(DevCenter)
model Gallery is Azure.ResourceManager.ProxyResource<GalleryProperties> {
  ...ResourceNameParameter<
    Resource = Gallery,
    KeyName = "galleryName",
    SegmentName = "galleries",
    NamePattern = "^[a-zA-Z0-9][a-zA-Z0-9-_.]{2,62}$"
  >;
}

@armResourceOperations
interface Galleries {
  /**
   * Gets a gallery
   */
  get is ArmResourceRead<Gallery>;

  /**
   * Creates or updates a gallery.
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<Gallery>;

  /**
   * Deletes a gallery resource.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/lro-location-header" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  delete is ArmResourceDeleteWithoutOkAsync<
    Gallery,
    LroHeaders = ArmAsyncOperationHeader &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Lists galleries for a devcenter.
   */
  listByDevCenter is ArmResourceListByParent<
    Gallery,
    Parameters = {
      /**
       * The maximum number of resources to return from the operation. Example: '$top=10'.
       */
      @query("$top")
      $top?: int32;
    },
    Response = GalleryListResult
  >;
}

@@maxLength(Gallery.name, 63);
@@minLength(Gallery.name, 3);
@@doc(Gallery.name, "The name of the gallery.");
@@doc(Gallery.properties, "Gallery properties.");
@@doc(Galleries.createOrUpdate::parameters.resource, "Represents a gallery.");

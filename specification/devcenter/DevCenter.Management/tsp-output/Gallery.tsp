import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./DevCenter.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.DevCenter;
/**
 * Represents a gallery.
 */
@parentResource(DevCenter)
model Gallery is ProxyResource<GalleryProperties> {
  /**
   * The name of the gallery.
   */
  @path
  @key("galleryName")
  @segment("galleries")
  name: string;
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
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    Gallery,
    BaseParameters<Gallery>,
    ArmAsyncOperationHeader
  >;

  /**
   * Deletes a gallery resource.
   */
  delete is ArmResourceDeleteAsync<
    Gallery,
    BaseParameters<Gallery>,
    ArmAsyncOperationHeader
  >;

  /**
   * Lists galleries for a devcenter.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Galleries_ListByDevCenter")
  listByDevCenter is ArmResourceListByParent<
    Gallery,
    {
      ...BaseParameters<Gallery>;

      /**
       * The maximum number of resources to return from the operation. Example: '$top=10'.
       */
      @query("$top")
      $top?: int32;
    }
  >;
}

@@projectedName(Galleries.createOrUpdate::parameters.resource, "json", "body");
@@extension(Galleries.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "body"
);
@@doc(Galleries.createOrUpdate::parameters.resource, "Represents a gallery.");

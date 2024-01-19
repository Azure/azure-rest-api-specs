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
@doc("Represents a gallery.")
@parentResource(DevCenter)
model Gallery is ProxyResource<GalleryProperties> {
  @doc("The name of the gallery.")
  @path
  @key("galleryName")
  @segment("galleries")
  name: string;
}

@armResourceOperations
interface Galleries {
  @doc("Gets a gallery")
  get is ArmResourceRead<Gallery>;

  @doc("Creates or updates a gallery.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<
    Gallery,
    BaseParameters<Gallery>,
    ArmAsyncOperationHeader
  >;

  @doc("Deletes a gallery resource.")
  delete is ArmResourceDeleteAsync<
    Gallery,
    BaseParameters<Gallery>,
    ArmAsyncOperationHeader
  >;

  @doc("Lists galleries for a devcenter.")
  listByDevCenter is ArmResourceListByParent<
    Gallery,
    {
      ...BaseParameters<Gallery>;

      @doc("The maximum number of resources to return from the operation. Example: '$top=10'.")
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

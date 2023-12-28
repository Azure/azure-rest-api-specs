import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./DevCenter.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.DevCenter;
@doc("Represents a gallery.")
@parentResource(DevCenter)
model Gallery is ProxyResource<GalleryProperties> {
  @doc("The name of the gallery.")
  @key("galleryName")
  @segment("galleries")
  name: string;
}

@armResourceOperations
interface Galleries {
  @doc("Gets a gallery")
  get is ArmResourceRead<Gallery>;
  @doc("Creates or updates a gallery.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<Gallery>;
  @doc("Deletes a gallery resource.")
  delete is ArmResourceDeleteAsync<Gallery>;
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

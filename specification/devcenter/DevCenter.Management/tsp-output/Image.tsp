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
@doc("Represents an image.")
@parentResource(Gallery)
model Image is ProxyResource<ImageProperties> {
  @doc("The name of the image.")
  @path
  @key("imageName")
  @segment("images")
  name: string;
}

@armResourceOperations
interface Images {
  @doc("Gets a gallery image.")
  get is ArmResourceRead<Image>;

  @doc("Lists images for a gallery.")
  listByGallery is ArmResourceListByParent<
    Image,
    {
      ...BaseParameters<Image>;

      @doc("The maximum number of resources to return from the operation. Example: '$top=10'.")
      @query("$top")
      $top?: int32;
    }
  >;
}

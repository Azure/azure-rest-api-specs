import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./DevCenterGallery.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.DevCenter;
@doc("Represents an image.")
@parentResource(DevCenterGallery)
model DevCenterImage is ProxyResource<ImageProperties> {
  @doc("The name of the image.")
  @path
  @key("imageName")
  @segment("images")
  name: string;
}

@armResourceOperations
interface DevCenterImages {
  @doc("Gets a gallery image.")
  get is ArmResourceRead<DevCenterImage>;
  @doc("Lists images for a gallery.")
  listByGallery is ArmResourceListByParent<
    DevCenterImage,
    {
      ...BaseParameters<DevCenterImage>;

      @doc("The maximum number of resources to return from the operation. Example: '$top=10'.")
      @query("$top")
      $top?: int32;
    }
  >;
}

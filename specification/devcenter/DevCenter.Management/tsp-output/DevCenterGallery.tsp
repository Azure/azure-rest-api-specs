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
model DevCenterGallery is ProxyResource<GalleryProperties> {
  @doc("The name of the gallery.")
  @path
  @key("galleryName")
  @segment("galleries")
  name: string;
}

@armResourceOperations
interface DevCenterGalleries {
  @doc("Gets a gallery")
  get is ArmResourceRead<DevCenterGallery>;
  @doc("Creates or updates a gallery.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<DevCenterGallery>;
  @doc("Deletes a gallery resource.")
  delete is ArmResourceDeleteAsync<DevCenterGallery>;
  @doc("Lists galleries for a devcenter.")
  listByDevCenter is ArmResourceListByParent<
    DevCenterGallery,
    {
      ...BaseParameters<DevCenterGallery>;

      @doc("The maximum number of resources to return from the operation. Example: '$top=10'.")
      @query("$top")
      $top?: int32;
    }
  >;
}

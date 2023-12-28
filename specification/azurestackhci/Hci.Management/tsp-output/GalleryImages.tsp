import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.Hci;
@doc("The gallery images resource definition.")
model GalleryImages is TrackedResource<GalleryImageProperties> {
  @doc("Name of the gallery image")
  @maxLength(80)
  @minLength(1)
  @pattern("^[a-zA-Z0-9]$|^[a-zA-Z0-9][-._a-zA-Z0-9]{0,78}[a-zA-Z0-9]$")
  @key("galleryImageName")
  @segment("galleryImages")
  name: string;

  @doc("The extendedLocation of the resource.")
  extendedLocation?: ExtendedLocation;
}

@armResourceOperations
interface GalleryImages {
  @doc("Gets a gallery image")
  get is ArmResourceRead<GalleryImages>;
  @doc("The operation to create or update a gallery image. Please note some properties can be set only during gallery image creation.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<GalleryImages>;
  @doc("The operation to update a gallery image.")
  update is ArmCustomPatchAsync<GalleryImages, GalleryImagesUpdateRequest>;
  @doc("The operation to delete a gallery image.")
  delete is ArmResourceDeleteWithoutOkAsync<GalleryImages>;
  @doc("Lists all of the gallery images in the specified resource group. Use the nextLink property in the response to get the next page of gallery images.")
  list is ArmResourceListByParent<GalleryImages>;
  @doc("Lists all of the gallery images in the specified subscription. Use the nextLink property in the response to get the next page of gallery images.")
  listAll is ArmListBySubscription<GalleryImages>;
}

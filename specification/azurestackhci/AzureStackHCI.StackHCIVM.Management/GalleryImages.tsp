import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.AzureStackHCI;

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@doc("The gallery images resource definition.")
model GalleryImage is TrackedResource<GalleryImageProperties> {
  @doc("Name of the gallery image")
  @pattern("^[a-zA-Z0-9]$|^[a-zA-Z0-9][-._a-zA-Z0-9]{0,62}[a-zA-Z0-9]$")
  @path
  @key("galleryImageName")
  @segment("galleryImages")
  @visibility("read")
  name: string;

  @doc("The extendedLocation of the resource.")
  extendedLocation?: ExtendedLocation;
}

@armResourceOperations(GalleryImage)
interface GalleryImages {
  @doc("Gets a gallery image")
  get is ArmResourceRead<GalleryImage>;

  @doc("The operation to create or update a gallery image. Please note some properties can be set only during gallery image creation.")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<GalleryImage>;

  @doc("The operation to update a gallery image.")
  @parameterVisibility
  update is ArmCustomPatchAsync<GalleryImage>;

  @doc("The operation to delete a gallery image.")
  delete is ArmResourceDeleteWithoutOkAsync<GalleryImage>;

  @doc("Lists all of the gallery images in the specified resource group. Use the nextLink property in the response to get the next page of gallery images.")
  list is ArmResourceListByParent<GalleryImage>;

  @doc("Lists all of the gallery images in the specified subscription. Use the nextLink property in the response to get the next page of gallery images.")
  listAll is ArmListBySubscription<GalleryImage>;
}

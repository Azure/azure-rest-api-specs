import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@azure-tools/typespec-client-generator-core";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.AzureStackHCI;

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-core/no-openapi" "TODO - x-ms-azure-resource is this needed?"
@doc("The gallery images resource definition.")
@extension("x-ms-azure-resource", true)
model GalleryImage is TrackedResource<GalleryImageProperties> {
  @doc("Name of the gallery image")
  @pattern("^[a-zA-Z0-9]$|^[a-zA-Z0-9][-._a-zA-Z0-9]{0,62}[a-zA-Z0-9]$")
  @path
  @key("galleryImageName")
  @segment("galleryImages")
  @visibility(Lifecycle.Read)
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
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchAsync<GalleryImage>;

  @doc("The operation to delete a gallery image.")
  delete is ArmResourceDeleteWithoutOkAsync<GalleryImage>;

  @doc("Lists all of the gallery images in the specified resource group. Use the nextLink property in the response to get the next page of gallery images.")
  listByResourceGroup is ArmResourceListByParent<GalleryImage>;

  @doc("Lists all of the gallery images in the specified subscription. Use the nextLink property in the response to get the next page of gallery images.")
  listAll is ArmListBySubscription<GalleryImage>;
}

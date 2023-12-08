import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.Hci;
@doc("The marketplace gallery image resource definition.")
model MarketplaceGalleryImage
  is TrackedResource<MarketplaceGalleryImageProperties> {
  @doc("Name of the marketplace gallery image")
  @maxLength(80)
  @minLength(1)
  @pattern("^[a-zA-Z0-9]$|^[a-zA-Z0-9][-._a-zA-Z0-9]{0,78}[a-zA-Z0-9]$")
  @path
  @key("marketplaceGalleryImageName")
  @segment("marketplaceGalleryImages")
  name: string;

  @doc("The extendedLocation of the resource.")
  extendedLocation?: ExtendedLocation;
}

@armResourceOperations
interface MarketplaceGalleryImages {
  @doc("Gets a marketplace gallery image")
  get is ArmResourceRead<MarketplaceGalleryImage>;
  @doc("The operation to create or update a marketplace gallery image. Please note some properties can be set only during marketplace gallery image creation.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<MarketplaceGalleryImage>;
  @doc("The operation to update a marketplace gallery image.")
  update is ArmTagsPatchAsync<MarketplaceGalleryImage>;
  @doc("The operation to delete a marketplace gallery image.")
  delete is ArmResourceDeleteWithoutOkAsync<MarketplaceGalleryImage>;
  @doc("Lists all of the marketplace gallery images in the specified resource group. Use the nextLink property in the response to get the next page of marketplace gallery images.")
  list is ArmResourceListByParent<MarketplaceGalleryImage>;
  @doc("Lists all of the marketplace gallery images in the specified subscription. Use the nextLink property in the response to get the next page of marketplace gallery images.")
  listAll is ArmListBySubscription<MarketplaceGalleryImage>;
}

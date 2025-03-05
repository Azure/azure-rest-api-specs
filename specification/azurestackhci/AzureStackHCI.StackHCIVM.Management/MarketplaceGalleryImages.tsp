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
#suppress "@azure-tools/typespec-azure-core/no-openapi" "x-ms-azure-resource legacy"
@doc("The marketplace gallery image resource definition.")
@extension("x-ms-azure-resource", true)
model MarketplaceGalleryImage
  is TrackedResource<MarketplaceGalleryImageProperties> {
  @doc("Name of the marketplace gallery image")
  @pattern("^[a-zA-Z0-9]$|^[a-zA-Z0-9][-._a-zA-Z0-9]{0,62}[a-zA-Z0-9]$")
  @path
  @key("marketplaceGalleryImageName")
  @segment("marketplaceGalleryImages")
  @visibility("read")
  name: string;

  @doc("The extendedLocation of the resource.")
  extendedLocation?: ExtendedLocation;
}

@armResourceOperations
interface MarketplaceGalleryImages {
  @doc("Gets a marketplace gallery image")
  get is ArmResourceRead<MarketplaceGalleryImage>;

  #suppress "@azure-tools/typespec-azure-core/invalid-final-state" "MUST CHANGE ON NEXT UPDATE"
  @doc("The operation to create or update a marketplace gallery image. Please note some properties can be set only during marketplace gallery image creation.")
  @Azure.Core.useFinalStateVia("azure-async-operation")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    MarketplaceGalleryImage,
    LroHeaders = Azure.Core.Foundations.RetryAfterHeader
  >;

  @doc("The operation to update a marketplace gallery image.")
  @parameterVisibility
  update is ArmCustomPatchAsync<MarketplaceGalleryImage>;

  @doc("The operation to delete a marketplace gallery image.")
  delete is ArmResourceDeleteWithoutOkAsync<MarketplaceGalleryImage>;

  @doc("Lists all of the marketplace gallery images in the specified resource group. Use the nextLink property in the response to get the next page of marketplace gallery images.")
  listByResourceGroup is ArmResourceListByParent<MarketplaceGalleryImage>;

  @doc("Lists all of the marketplace gallery images in the specified subscription. Use the nextLink property in the response to get the next page of marketplace gallery images.")
  listAll is ArmListBySubscription<MarketplaceGalleryImage>;
}

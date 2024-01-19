import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.AzureStackHCI;
@doc("The marketplace gallery image resource definition.")
model MarketplaceGalleryImages
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
@projectedName("client", "MarketplaceGalleryImages")
interface MarketplaceGalleryImagesOperationGroup {
  @doc("Gets a marketplace gallery image")
  get is ArmResourceRead<MarketplaceGalleryImages>;

  @doc("The operation to create or update a marketplace gallery image. Please note some properties can be set only during marketplace gallery image creation.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<
    MarketplaceGalleryImages,
    BaseParameters<MarketplaceGalleryImages>,
    ArmAsyncOperationHeader
  >;

  @doc("The operation to update a marketplace gallery image.")
  update is ArmCustomPatchAsync<
    MarketplaceGalleryImages,
    MarketplaceGalleryImagesUpdateRequest,
    BaseParameters<MarketplaceGalleryImages>,
    ArmAsyncOperationHeader
  >;

  @doc("The operation to delete a marketplace gallery image.")
  delete is ArmResourceDeleteWithoutOkAsync<
    MarketplaceGalleryImages,
    BaseParameters<MarketplaceGalleryImages>,
    ArmAsyncOperationHeader
  >;

  @doc("Lists all of the marketplace gallery images in the specified resource group. Use the nextLink property in the response to get the next page of marketplace gallery images.")
  list is ArmResourceListByParent<MarketplaceGalleryImages>;

  @doc("Lists all of the marketplace gallery images in the specified subscription. Use the nextLink property in the response to get the next page of marketplace gallery images.")
  listAll is ArmListBySubscription<MarketplaceGalleryImages>;
}

@@projectedName(MarketplaceGalleryImagesOperationGroup.createOrUpdate::parameters.resource,
  "json",
  "marketplaceGalleryImages"
);
@@extension(MarketplaceGalleryImagesOperationGroup.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "marketplaceGalleryImages"
);
@@doc(MarketplaceGalleryImagesOperationGroup.createOrUpdate::parameters.resource,
  ""
);
@@projectedName(MarketplaceGalleryImagesOperationGroup.update::parameters.properties,
  "json",
  "marketplaceGalleryImages"
);
@@extension(MarketplaceGalleryImagesOperationGroup.update::parameters.properties,
  "x-ms-client-name",
  "marketplaceGalleryImages"
);
@@doc(MarketplaceGalleryImagesOperationGroup.update::parameters.properties, "");

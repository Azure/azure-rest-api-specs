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
/**
 * The marketplace gallery image resource definition.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@includeInapplicableMetadataInPayload(false)
@Azure.ResourceManager.Private.armResourceInternal(
  MarketplaceGalleryImageProperties
)
model MarketplaceGalleryImages extends TrackedResourceBase {
  /**
   * Name of the marketplace gallery image
   */
  @maxLength(80)
  @minLength(1)
  @pattern("^[a-zA-Z0-9]$|^[a-zA-Z0-9][-._a-zA-Z0-9]{0,78}[a-zA-Z0-9]$")
  @path
  @key("marketplaceGalleryImageName")
  @segment("marketplaceGalleryImages")
  @visibility("read")
  name: string;

  /**
   * The extendedLocation of the resource.
   */
  extendedLocation?: ExtendedLocation;

  /**
   * Properties under the marketplace gallery image resource
   */
  @extension("x-ms-client-flatten", true)
  properties?: MarketplaceGalleryImageProperties;
}

@armResourceOperations
@projectedName("client", "MarketplaceGalleryImages")
interface MarketplaceGalleryImagesOperationGroup {
  /**
   * Gets a marketplace gallery image
   */
  get is ArmResourceRead<MarketplaceGalleryImages>;

  /**
   * The operation to create or update a marketplace gallery image. Please note some properties can be set only during marketplace gallery image creation.
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    MarketplaceGalleryImages,
    BaseParameters<MarketplaceGalleryImages>,
    ArmAsyncOperationHeader
  >;

  /**
   * The operation to update a marketplace gallery image.
   */
  @parameterVisibility("read")
  update is ArmCustomPatchAsync<
    MarketplaceGalleryImages,
    MarketplaceGalleryImagesUpdateRequest,
    BaseParameters<MarketplaceGalleryImages>,
    ArmAsyncOperationHeader
  >;

  /**
   * The operation to delete a marketplace gallery image.
   */
  delete is ArmResourceDeleteWithoutOkAsync<
    MarketplaceGalleryImages,
    BaseParameters<MarketplaceGalleryImages>,
    ArmAsyncOperationHeader
  >;

  /**
   * Lists all of the marketplace gallery images in the specified resource group. Use the nextLink property in the response to get the next page of marketplace gallery images.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("MarketplaceGalleryImages_List")
  list is ArmResourceListByParent<MarketplaceGalleryImages>;

  /**
   * Lists all of the marketplace gallery images in the specified subscription. Use the nextLink property in the response to get the next page of marketplace gallery images.
   */
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

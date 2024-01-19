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
@doc("The gallery images resource definition.")
model GalleryImages is TrackedResource<GalleryImageProperties> {
  @doc("Name of the gallery image")
  @maxLength(80)
  @minLength(1)
  @pattern("^[a-zA-Z0-9]$|^[a-zA-Z0-9][-._a-zA-Z0-9]{0,78}[a-zA-Z0-9]$")
  @path
  @key("galleryImageName")
  @segment("galleryImages")
  name: string;

  @doc("The extendedLocation of the resource.")
  extendedLocation?: ExtendedLocation;
}

@armResourceOperations
@projectedName("client", "GalleryImages")
interface GalleryImagesOperationGroup {
  @doc("Gets a gallery image")
  get is ArmResourceRead<GalleryImages>;

  @doc("The operation to create or update a gallery image. Please note some properties can be set only during gallery image creation.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<
    GalleryImages,
    BaseParameters<GalleryImages>,
    ArmAsyncOperationHeader
  >;

  @doc("The operation to update a gallery image.")
  update is ArmCustomPatchAsync<
    GalleryImages,
    GalleryImagesUpdateRequest,
    BaseParameters<GalleryImages>,
    ArmAsyncOperationHeader
  >;

  @doc("The operation to delete a gallery image.")
  delete is ArmResourceDeleteWithoutOkAsync<
    GalleryImages,
    BaseParameters<GalleryImages>,
    ArmAsyncOperationHeader
  >;

  @doc("Lists all of the gallery images in the specified resource group. Use the nextLink property in the response to get the next page of gallery images.")
  list is ArmResourceListByParent<GalleryImages>;

  @doc("Lists all of the gallery images in the specified subscription. Use the nextLink property in the response to get the next page of gallery images.")
  listAll is ArmListBySubscription<GalleryImages>;
}

@@projectedName(GalleryImagesOperationGroup.createOrUpdate::parameters.resource,
  "json",
  "galleryImages"
);
@@extension(GalleryImagesOperationGroup.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "galleryImages"
);
@@doc(GalleryImagesOperationGroup.createOrUpdate::parameters.resource, "");
@@projectedName(GalleryImagesOperationGroup.update::parameters.properties,
  "json",
  "galleryImages"
);
@@extension(GalleryImagesOperationGroup.update::parameters.properties,
  "x-ms-client-name",
  "galleryImages"
);
@@doc(GalleryImagesOperationGroup.update::parameters.properties, "");

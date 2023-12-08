import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./MediaServicesAccount.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.Media;
@doc("An Account Filter.")
@parentResource(MediaServicesAccount)
model MediaServicesAccountFilter is ProxyResource<MediaFilterProperties> {
  @doc("The Account Filter name")
  @path
  @key("filterName")
  @segment("accountFilters")
  name: string;
}

@armResourceOperations
interface MediaServicesAccountFilters {
  @doc("Get the details of an Account Filter in the Media Services account.")
  get is ArmResourceRead<MediaServicesAccountFilter>;
  @doc("Creates or updates an Account Filter in the Media Services account.")
  createOrUpdate is ArmResourceCreateOrReplaceSync<MediaServicesAccountFilter>;
  @doc("Updates an existing Account Filter in the Media Services account.")
  update is ArmResourcePatchSync<
    MediaServicesAccountFilter,
    MediaFilterProperties
  >;
  @doc("Deletes an Account Filter in the Media Services account.")
  delete is ArmResourceDeleteSync<MediaServicesAccountFilter>;
  @doc("List Account Filters in the Media Services account.")
  list is ArmResourceListByParent<MediaServicesAccountFilter>;
}

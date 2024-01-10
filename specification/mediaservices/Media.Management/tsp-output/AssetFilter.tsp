import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./Asset.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Microsoft.Media;
@doc("An Asset Filter.")
@parentResource(Asset)
model AssetFilter is ProxyResource<MediaFilterProperties> {
  @doc("The Asset Filter name")
  @key("filterName")
  @segment("assetFilters")
  name: string;
}

@armResourceOperations
interface AssetFilters {
  @doc("Get the details of an Asset Filter associated with the specified Asset.")
  get is ArmResourceRead<AssetFilter>;

  @doc("Creates or updates an Asset Filter associated with the specified Asset.")
  createOrUpdate is ArmResourceCreateOrReplaceSync<AssetFilter>;

  @doc("Updates an existing Asset Filter associated with the specified Asset.")
  update is ArmCustomPatchSync<AssetFilter, AssetFilter>;

  @doc("Deletes an Asset Filter associated with the specified Asset.")
  delete is ArmResourceDeleteSync<AssetFilter>;

  @doc("List Asset Filters associated with the specified Asset.")
  list is ArmResourceListByParent<AssetFilter>;
}

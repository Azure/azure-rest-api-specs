import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Asset.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Media;
/**
 * An Asset Filter.
 */
@parentResource(Asset)
model AssetFilter
  is Azure.ResourceManager.ProxyResource<MediaFilterProperties> {
  ...ResourceNameParameter<
    Resource = AssetFilter,
    KeyName = "filterName",
    SegmentName = "assetFilters",
    NamePattern = ""
  >;
}

@armResourceOperations
interface AssetFilters {
  /**
   * Get the details of an Asset Filter associated with the specified Asset.
   */
  get is ArmResourceRead<AssetFilter>;

  /**
   * Creates or updates an Asset Filter associated with the specified Asset.
   */
  createOrUpdate is ArmResourceCreateOrReplaceSync<AssetFilter>;

  /**
   * Updates an existing Asset Filter associated with the specified Asset.
   */
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchSync<AssetFilter, PatchModel = AssetFilter>;

  /**
   * Deletes an Asset Filter associated with the specified Asset.
   */
  delete is ArmResourceDeleteSync<AssetFilter>;

  /**
   * List Asset Filters associated with the specified Asset.
   */
  list is ArmResourceListByParent<
    AssetFilter,
    Response = ArmResponse<AssetFilterCollection>
  >;
}

@@doc(AssetFilter.name, "The Asset Filter name");
@@doc(AssetFilter.properties, "The Media Filter properties.");
@@doc(AssetFilters.createOrUpdate::parameters.resource,
  "The request parameters"
);
@@doc(AssetFilters.update::parameters.properties, "The request parameters");

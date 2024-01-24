import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Asset.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Media;
/**
 * An Asset Filter.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@parentResource(Asset)
@Azure.ResourceManager.Private.armResourceInternal(MediaFilterProperties)
@includeInapplicableMetadataInPayload(false)
model AssetFilter extends ProxyResourceBase {
  /**
   * The Asset Filter name
   */
  @path
  @key("filterName")
  @segment("assetFilters")
  name: string;

  /**
   * The Media Filter properties.
   */
  @extension("x-ms-client-flatten", true)
  properties?: MediaFilterProperties;
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
  @parameterVisibility("read")
  update is ArmCustomPatchSync<AssetFilter, AssetFilter>;

  /**
   * Deletes an Asset Filter associated with the specified Asset.
   */
  delete is ArmResourceDeleteSync<AssetFilter>;

  /**
   * List Asset Filters associated with the specified Asset.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("AssetFilters_List")
  list is ArmResourceListByParent<AssetFilter>;
}

@@projectedName(AssetFilters.createOrUpdate::parameters.resource,
  "json",
  "parameters"
);
@@extension(AssetFilters.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "parameters"
);
@@doc(AssetFilters.createOrUpdate::parameters.resource,
  "The request parameters"
);
@@projectedName(AssetFilters.update::parameters.properties,
  "json",
  "parameters"
);
@@extension(AssetFilters.update::parameters.properties,
  "x-ms-client-name",
  "parameters"
);
@@doc(AssetFilters.update::parameters.properties, "The request parameters");

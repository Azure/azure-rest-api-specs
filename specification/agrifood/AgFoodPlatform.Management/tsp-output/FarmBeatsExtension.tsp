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

namespace Microsoft.AgFoodPlatform;
/**
 * FarmBeats extension resource.
 */
@tenantResource
model FarmBeatsExtension is ProxyResource<FarmBeatsExtensionProperties> {
  /**
   * farmBeatsExtensionId to be queried.
   */
  @pattern("^[a-zA-Z]{3,50}[.][a-zA-Z]{3,100}$")
  @path
  @key("farmBeatsExtensionId")
  @segment("farmBeatsExtensionDefinitions")
  name: string;
}

@armResourceOperations
interface FarmBeatsExtensions {
  /**
   * Get farmBeats extension.
   */
  get is ArmResourceRead<FarmBeatsExtension>;

  /**
   * Get list of farmBeats extension.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("FarmBeatsExtensions_List")
  list is ArmResourceListByParent<
    FarmBeatsExtension,
    {
      ...BaseParameters<FarmBeatsExtension>;

      /**
       * FarmBeatsExtension ids.
       */
      @query({
        name: "farmBeatsExtensionIds",
        format: "multi",
      })
      farmBeatsExtensionIds?: string[];

      /**
       * FarmBeats extension names.
       */
      @query({
        name: "farmBeatsExtensionNames",
        format: "multi",
      })
      farmBeatsExtensionNames?: string[];

      /**
       * Extension categories.
       */
      @query({
        name: "extensionCategories",
        format: "multi",
      })
      extensionCategories?: string[];

      /**
       * Publisher ids.
       */
      @query({
        name: "publisherIds",
        format: "multi",
      })
      publisherIds?: string[];

      /**
* Maximum number of items needed (inclusive).
Minimum = 10, Maximum = 1000, Default value = 50.
*/
      @maxValue(1000)
      @minValue(10)
      @query("$maxPageSize")
      $maxPageSize?: int32 = 50;
    }
  >;
}

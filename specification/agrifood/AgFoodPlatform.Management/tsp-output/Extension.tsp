import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./FarmBeats.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.AgFoodPlatform;
/**
 * Extension resource.
 */
@parentResource(FarmBeats)
model Extension is ProxyResource<ExtensionProperties> {
  /**
   * Id of extension resource.
   */
  @path
  @key("extensionId")
  @segment("extensions")
  name: string;

  ...Azure.ResourceManager.EntityTag;
}

@armResourceOperations
interface Extensions {
  /**
   * Get installed extension details by extension id.
   */
  get is ArmResourceRead<Extension>;

  /**
   * Install extension.
   */
  create is ArmResourceCreateOrReplaceSync<Extension>;

  // FIXME: (ArmResourcePatch): ArmResourcePatchSync/ArmResourcePatchAsync should have a body parameter with either properties property or tag property
  /**
   * Upgrade to latest extension.
   */
  @parameterVisibility("read")
  update is ArmCustomPatchSync<Extension, {}>;

  /**
   * Uninstall extension.
   */
  delete is ArmResourceDeleteSync<Extension>;

  /**
   * Get installed extensions details.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Extensions_ListByFarmBeats")
  listByFarmBeats is ArmResourceListByParent<
    Extension,
    {
      ...BaseParameters<Extension>;

      /**
       * Installed extension ids.
       */
      @query({
        name: "extensionIds",
        format: "multi",
      })
      extensionIds?: string[];

      /**
       * Installed extension categories.
       */
      @query({
        name: "extensionCategories",
        format: "multi",
      })
      extensionCategories?: string[];

      /**
* Maximum number of items needed (inclusive).
Minimum = 10, Maximum = 1000, Default value = 50.
*/
      @maxValue(1000)
      @minValue(10)
      @query("$maxPageSize")
      $maxPageSize?: int32 = 50;

      /**
       * Skip token for getting next set of results.
       */
      @query("$skipToken")
      $skipToken?: string;
    }
  >;
}

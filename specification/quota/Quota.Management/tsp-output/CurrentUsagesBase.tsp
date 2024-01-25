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

namespace Microsoft.Quota;
/**
 * Resource usage.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@extensionResource
@includeInapplicableMetadataInPayload(false)
model CurrentUsagesBase {
  /**
   * Resource name for a given resource provider. For example:
   * - SKU name for Microsoft.Compute
   * - SKU or TotalLowPriorityCores for Microsoft.MachineLearningServices
   *  For Microsoft.Network PublicIPAddresses.
   */
  @path
  @key("resourceName")
  @segment("usages")
  @visibility("read")
  name: string;

  /**
   * The resource ID.
   */
  @visibility("read")
  id?: string;

  /**
   * The resource type.
   */
  @visibility("read")
  type?: string;

  /**
   * Usage properties for the specified resource.
   */
  @extension("x-ms-client-flatten", true)
  properties?: UsagesProperties;
}

@armResourceOperations
interface CurrentUsagesBases {
  /**
   * Get the current usage of a resource.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Usages_Get")
  get is ArmResourceRead<CurrentUsagesBase>;

  /**
   * Get a list of current usage for all resources for the scope specified.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Usages_List")
  list is ArmResourceListByParent<CurrentUsagesBase>;
}

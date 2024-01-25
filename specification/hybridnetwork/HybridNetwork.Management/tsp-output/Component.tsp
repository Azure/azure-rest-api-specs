import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./NetworkFunction.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.HybridNetwork;
/**
 * The component sub resource.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@parentResource(NetworkFunction)
@includeInapplicableMetadataInPayload(false)
@Azure.ResourceManager.Private.armResourceInternal(ComponentProperties)
model Component extends ProxyResourceBase {
  /**
   * The name of the component.
   */
  @maxLength(64)
  @pattern("^[^\\s]*[^\\s]+[^\\s]*$")
  @path
  @key("componentName")
  @segment("components")
  @visibility("read")
  name: string;

  /**
   * The component properties.
   */
  @extension("x-ms-client-flatten", true)
  properties?: ComponentProperties;
}

@armResourceOperations
interface Components {
  /**
   * Gets information about the specified application instance resource.
   */
  get is ArmResourceRead<Component>;

  /**
   * Lists all the component resources in a network function.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Components_ListByNetworkFunction")
  listByNetworkFunction is ArmResourceListByParent<Component>;
}

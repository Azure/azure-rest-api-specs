import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./NetworkFunction.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.HybridNetwork;
/**
 * The component sub resource.
 */
@parentResource(NetworkFunction)
model Component is Azure.ResourceManager.ProxyResource<ComponentProperties> {
  ...ResourceNameParameter<
    Resource = Component,
    KeyName = "componentName",
    SegmentName = "components",
    NamePattern = "^[^\\s]*[^\\s]+[^\\s]*$"
  >;
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
  listByNetworkFunction is ArmResourceListByParent<Component>;
}

@@maxLength(Component.name, 64);
@@doc(Component.name, "The name of the component.");
@@doc(Component.properties, "The component properties.");

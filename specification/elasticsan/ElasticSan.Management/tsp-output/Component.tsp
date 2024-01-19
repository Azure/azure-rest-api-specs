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
@doc("The component sub resource.")
@parentResource(NetworkFunction)
model Component is ProxyResource<ComponentProperties> {
  @doc("The name of the component.")
  @maxLength(64)
  @pattern("^[^\\s]*[^\\s]+[^\\s]*$")
  @path
  @key("componentName")
  @segment("components")
  name: string;
}

@armResourceOperations
interface Components {
  @doc("Gets information about the specified application instance resource.")
  get is ArmResourceRead<Component>;

  @doc("Lists all the component resources in a network function.")
  listByNetworkFunction is ArmResourceListByParent<Component>;
}

import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./BuildService.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Microsoft.AppPlatform;
@doc("Supported stack resource payload")
@parentResource(BuildService)
model SupportedStackResource
  is ProxyResource<SupportedStackResourceProperties> {
  @doc("The name of the stack resource.")
  @key("stackName")
  @segment("supportedStacks")
  name: string;
}

@armResourceOperations
@projectedName("client", "BuildService")
interface SupportedStackResources_BuildService {
  @doc("Get the supported stack resource.")
  getSupportedStack is ArmResourceRead<SupportedStackResource>;

  @doc("Get all supported stacks.")
  listSupportedStacks is ArmResourceListByParent<SupportedStackResource>;
}

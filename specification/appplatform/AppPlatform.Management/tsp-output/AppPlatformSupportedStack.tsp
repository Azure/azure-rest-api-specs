import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./AppPlatformBuildService.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.AppPlatform;
@doc("Supported stack resource payload")
@parentResource(AppPlatformBuildService)
model AppPlatformSupportedStack
  is ProxyResource<SupportedStackResourceProperties> {
  @doc("The name of the stack resource.")
  @path
  @key("stackName")
  @segment("supportedStacks")
  name: string;
}

@armResourceOperations
interface AppPlatformSupportedStacks {
  @doc("Get the supported stack resource.")
  getSupportedStack is ArmResourceRead<AppPlatformSupportedStack>;
  @doc("Get all supported stacks.")
  listSupportedStacks is ArmResourceListByParent<AppPlatformSupportedStack>;
}

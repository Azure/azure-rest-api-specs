import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./BuildService.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.AppPlatform;
@doc("Supported stack resource payload")
@parentResource(BuildService)
model SupportedStackResource
  is ProxyResource<SupportedStackResourceProperties> {
  @doc("The name of the stack resource.")
  @path
  @key("stackName")
  @segment("supportedStacks")
  name: string;
}

@armResourceOperations
interface SupportedStackResources {
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Get the supported stack resource.")
  @operationId("BuildService_GetSupportedStack")
  getSupportedStack is ArmResourceRead<SupportedStackResource>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Get all supported stacks.")
  @operationId("BuildService_ListSupportedStacks")
  listSupportedStacks is ArmResourceListByParent<SupportedStackResource>;
}

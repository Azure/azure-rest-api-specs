import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./BuildService.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.AppPlatform;
/**
 * Supported stack resource payload
 */
@parentResource(BuildService)
model SupportedStackResource
  is Azure.ResourceManager.ProxyResource<SupportedStackResourceProperties> {
  ...ResourceNameParameter<
    Resource = SupportedStackResource,
    KeyName = "stackName",
    SegmentName = "supportedStacks",
    NamePattern = ""
  >;
}

@armResourceOperations
interface SupportedStackResources {
  /**
   * Get the supported stack resource.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("BuildService_GetSupportedStack")
  getSupportedStack is ArmResourceRead<SupportedStackResource>;

  /**
   * Get all supported stacks.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("BuildService_ListSupportedStacks")
  listSupportedStacks is ArmResourceListByParent<
    SupportedStackResource,
    Response = ArmResponse<SupportedStacksCollection>
  >;
}

@@doc(SupportedStackResource.name, "The name of the stack resource.");
@@doc(SupportedStackResource.properties, "Supported stack resource properties");

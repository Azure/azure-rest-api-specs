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
/**
 * Supported stack resource payload
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@parentResource(BuildService)
@Azure.ResourceManager.Private.armResourceInternal(
  SupportedStackResourceProperties
)
@includeInapplicableMetadataInPayload(false)
model SupportedStackResource extends ProxyResource {
  /**
   * The name of the stack resource.
   */
  @path
  @key("stackName")
  @segment("supportedStacks")
  name: string;

  /**
   * Supported stack resource properties
   */
  @extension("x-ms-client-flatten", true)
  properties?: SupportedStackResourceProperties;
}

@armResourceOperations
interface SupportedStackResources {
  /**
   * Get the supported stack resource.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("BuildService_GetSupportedStack")
  getSupportedStack is ArmResourceRead<SupportedStackResource>;

  /**
   * Get all supported stacks.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("BuildService_ListSupportedStacks")
  listSupportedStacks is ArmResourceListByParent<SupportedStackResource>;
}

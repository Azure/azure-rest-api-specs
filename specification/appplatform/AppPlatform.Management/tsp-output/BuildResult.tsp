import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Build.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.AppPlatform;
/**
 * Build result resource payload
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@parentResource(Build)
@includeInapplicableMetadataInPayload(false)
model BuildResult extends ProxyResource {
  /**
   * The name of the build result resource.
   */
  @path
  @key("buildResultName")
  @segment("results")
  @visibility("read")
  name: string;

  /**
   * Properties of the build result resource
   */
  @extension("x-ms-client-flatten", true)
  properties?: BuildResultProperties;
}

@armResourceOperations
interface BuildResults {
  /**
   * Get a KPack build result.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("BuildService_GetBuildResult")
  getBuildResult is ArmResourceRead<BuildResult>;

  /**
   * List KPack build results.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("BuildService_ListBuildResults")
  listBuildResults is ArmResourceListByParent<BuildResult>;

  /**
   * Get a KPack build result log download URL.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("BuildService_GetBuildResultLog")
  getBuildResultLog is ArmResourceActionSync<BuildResult, void, BuildResultLog>;
}

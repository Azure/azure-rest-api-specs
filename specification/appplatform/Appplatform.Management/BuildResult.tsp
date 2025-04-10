import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Build.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.AppPlatform;
/**
 * Build result resource payload
 */
@parentResource(Build)
model BuildResult
  is Azure.ResourceManager.ProxyResource<BuildResultProperties> {
  ...ResourceNameParameter<
    Resource = BuildResult,
    KeyName = "buildResultName",
    SegmentName = "results",
    NamePattern = ""
  >;
}

@armResourceOperations
interface BuildResults {
  /**
   * Get a KPack build result.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("BuildService_GetBuildResult")
  getBuildResult is ArmResourceRead<BuildResult>;

  /**
   * List KPack build results.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("BuildService_ListBuildResults")
  listBuildResults is ArmResourceListByParent<
    BuildResult,
    Response = ArmResponse<BuildResultCollection>
  >;

  /**
   * Get a KPack build result log download URL.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @action("getLogFileUrl")
  @operationId("BuildService_GetBuildResultLog")
  getBuildResultLog is ArmResourceActionSync<
    BuildResult,
    void,
    ArmResponse<BuildResultLog>
  >;
}

@@doc(BuildResult.name, "The name of the build result resource.");
@@doc(BuildResult.properties, "Properties of the build result resource");

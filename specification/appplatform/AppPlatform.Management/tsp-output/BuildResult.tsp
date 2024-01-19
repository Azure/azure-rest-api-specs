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
@doc("Build result resource payload")
@parentResource(Build)
model BuildResult is ProxyResource<BuildResultProperties> {
  @doc("The name of the build result resource.")
  @path
  @key("buildResultName")
  @segment("results")
  name: string;
}

@armResourceOperations
interface BuildResults {
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Get a KPack build result.")
  @operationId("BuildService_GetBuildResult")
  getBuildResult is ArmResourceRead<BuildResult>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("List KPack build results.")
  @operationId("BuildService_ListBuildResults")
  listBuildResults is ArmResourceListByParent<BuildResult>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Get a KPack build result log download URL.")
  @operationId("BuildService_GetBuildResultLog")
  getBuildResultLog is ArmResourceActionSync<BuildResult, void, BuildResultLog>;
}

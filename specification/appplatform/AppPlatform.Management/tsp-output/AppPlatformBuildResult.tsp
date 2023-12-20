import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./AppPlatformBuild.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.AppPlatform;
@doc("Build result resource payload")
@parentResource(AppPlatformBuild)
model AppPlatformBuildResult is ProxyResource<BuildResultProperties> {
  @doc("The name of the build result resource.")
  @path
  @key("buildResultName")
  @segment("results")
  name: string;
}

@armResourceOperations
interface AppPlatformBuildResults {
  @doc("Get a KPack build result.")
  getBuildResult is ArmResourceRead<AppPlatformBuildResult>;
  @doc("List KPack build results.")
  listBuildResults is ArmResourceListByParent<AppPlatformBuildResult>;
  @doc("Get a KPack build result log download URL.")
  getBuildResultLog is ArmResourceActionSync<
    AppPlatformBuildResult,
    void,
    BuildResultLog
  >;
}

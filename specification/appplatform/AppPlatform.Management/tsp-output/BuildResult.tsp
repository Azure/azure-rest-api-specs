import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./Build.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.AppPlatform;
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
interface BuildService {
  @doc("Get a KPack build result.")
  getBuildResult is ArmResourceRead<BuildResult>;
  @doc("List KPack build results.")
  listBuildResults is ArmResourceListByParent<BuildResult>;
  @doc("Get a KPack build result log download URL.")
  getBuildResultLog is ArmResourceActionSync<BuildResult, void, BuildResultLog>;
}

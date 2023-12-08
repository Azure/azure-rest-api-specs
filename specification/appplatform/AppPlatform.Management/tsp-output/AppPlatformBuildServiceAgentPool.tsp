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
@doc("The build service agent pool resource")
@parentResource(AppPlatformBuildService)
model AppPlatformBuildServiceAgentPool
  is ProxyResource<BuildServiceAgentPoolProperties> {
  @doc("The name of the build service agent pool resource.")
  @path
  @key("agentPoolName")
  @segment("agentPools")
  name: string;
}

@armResourceOperations
interface AppPlatformBuildServiceAgentPools {
  @doc("Get build service agent pool.")
  get is ArmResourceRead<AppPlatformBuildServiceAgentPool>;
  @doc("Create or update build service agent pool.")
  updatePut is ArmResourceCreateOrUpdateAsync<AppPlatformBuildServiceAgentPool>;
  @doc("List build service agent pool.")
  list is ArmResourceListByParent<AppPlatformBuildServiceAgentPool>;
}

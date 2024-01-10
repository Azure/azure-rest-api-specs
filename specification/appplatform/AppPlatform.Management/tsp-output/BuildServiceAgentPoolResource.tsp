import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./BuildService.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Microsoft.AppPlatform;
@doc("The build service agent pool resource")
@parentResource(BuildService)
model BuildServiceAgentPoolResource
  is ProxyResource<BuildServiceAgentPoolProperties> {
  @doc("The name of the build service agent pool resource.")
  @key("agentPoolName")
  @segment("agentPools")
  name: string;
}

@armResourceOperations
@projectedName("client", "BuildServiceAgentPool")
interface BuildServiceAgentPoolResources_BuildServiceAgentPool {
  @doc("Get build service agent pool.")
  get is ArmResourceRead<BuildServiceAgentPoolResource>;

  @doc("Create or update build service agent pool.")
  updatePut is ArmResourceCreateOrUpdateAsync<BuildServiceAgentPoolResource>;

  @doc("List build service agent pool.")
  list is ArmResourceListByParent<BuildServiceAgentPoolResource>;
}

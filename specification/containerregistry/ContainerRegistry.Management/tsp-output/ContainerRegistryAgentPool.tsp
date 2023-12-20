import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./ContainerRegistry.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.ContainerRegistry;
@doc("""
The agentpool that has the ARM resource and properties. 
The agentpool will have all information to create an agent pool.
""")
@parentResource(ContainerRegistry)
model ContainerRegistryAgentPool is TrackedResource<AgentPoolProperties> {
  @doc("The name of the agent pool.")
  @maxLength(20)
  @minLength(3)
  @pattern("^[a-zA-Z0-9-]*$")
  @path
  @key("agentPoolName")
  @segment("agentPools")
  name: string;
}

@armResourceOperations
interface ContainerRegistryAgentPools {
  @doc("Gets the detailed information for a given agent pool.")
  get is ArmResourceRead<ContainerRegistryAgentPool>;
  @doc("Creates an agent pool for a container registry with the specified parameters.")
  create is ArmResourceCreateOrUpdateAsync<ContainerRegistryAgentPool>;
  @doc("Updates an agent pool with the specified parameters.")
  update is ArmResourcePatchAsync<
    ContainerRegistryAgentPool,
    AgentPoolProperties
  >;
  @doc("Deletes a specified agent pool resource.")
  delete is ArmResourceDeleteAsync<ContainerRegistryAgentPool>;
  @doc("Lists all the agent pools for a specified container registry.")
  list is ArmResourceListByParent<ContainerRegistryAgentPool>;
  @doc("Gets the count of queued runs for a given agent pool.")
  getQueueStatus is ArmResourceActionSync<
    ContainerRegistryAgentPool,
    void,
    AgentPoolQueueStatus
  >;
}

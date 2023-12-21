import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./ProvisionedClustersResponse.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.HybridContainerService;
@doc("The agentPool resource definition")
@parentResource(ProvisionedClustersResponse)
model AgentPool is TrackedResource<AgentPoolProperties> {
  @doc("Parameter for the name of the agent pool in the provisioned cluster")
  @maxLength(64)
  @minLength(3)
  @path
  @key("agentPoolName")
  @segment("agentPools")
  name: string;

  extendedLocation?: AgentPoolExtendedLocation;
}

@armResourceOperations
interface agentPool {
  @doc("Gets the agent pool in the Hybrid AKS provisioned cluster")
  get is ArmResourceRead<AgentPool>;
  @doc("Creates the agent pool in the Hybrid AKS provisioned cluster")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<AgentPool>;
  @doc("Updates the agent pool in the Hybrid AKS provisioned cluster")
  update is ArmResourcePatchSync<AgentPool, AgentPoolProperties>;
  @doc("Deletes the agent pool in the Hybrid AKS provisioned cluster")
  delete is ArmResourceDeleteSync<AgentPool>;
  @doc("Gets the agent pools in the Hybrid AKS provisioned cluster")
  listByProvisionedCluster is ArmResourceListByParent<AgentPool>;
}

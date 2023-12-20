import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./ProvisionedCluster.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.HybridContainerService;
@doc("The agentPool resource definition")
@parentResource(ProvisionedCluster)
model HybridContainerServiceAgentPool is TrackedResource<AgentPoolProperties> {
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
interface HybridContainerServiceAgentPools {
  @doc("Gets the agent pool in the Hybrid AKS provisioned cluster")
  get is ArmResourceRead<HybridContainerServiceAgentPool>;
  @doc("Creates the agent pool in the Hybrid AKS provisioned cluster")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<HybridContainerServiceAgentPool>;
  @doc("Updates the agent pool in the Hybrid AKS provisioned cluster")
  update is ArmResourcePatchSync<
    HybridContainerServiceAgentPool,
    AgentPoolProperties
  >;
  @doc("Deletes the agent pool in the Hybrid AKS provisioned cluster")
  delete is ArmResourceDeleteSync<HybridContainerServiceAgentPool>;
  @doc("Gets the agent pools in the Hybrid AKS provisioned cluster")
  listByProvisionedCluster is ArmResourceListByParent<HybridContainerServiceAgentPool>;
}

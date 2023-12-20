import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./ProvisionedCluster.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Microsoft.HybridContainerService;
@doc("The agentPool resource definition")
@parentResource(ProvisionedCluster)
model AgentPool is ProxyResource<AgentPoolProperties> {
  @doc("Parameter for the name of the agent pool in the provisioned cluster.")
  @maxLength(12)
  @minLength(3)
  @pattern("^[a-z][a-z0-9]{2,11}$")
  @path
  @key("agentPoolName")
  @segment("agentPools")
  name: string;

  @doc("Extended location pointing to the underlying infrastructure")
  extendedLocation?: ExtendedLocation;
}

@armResourceOperations
interface AgentPools {
  @doc("Gets the specified agent pool in the provisioned cluster")
  get is ArmResourceRead<AgentPool>;
  @doc("Creates or updates the agent pool in the provisioned cluster")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<AgentPool>;
  @doc("Deletes the specified agent pool in the provisioned cluster")
  delete is ArmResourceDeleteWithoutOkAsync<AgentPool>;
  @doc("Gets the list of agent pools in the specified provisioned cluster")
  listByProvisionedCluster is ArmResourceListByParent<AgentPool>;
}

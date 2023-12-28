import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./AgentPool.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.ContainerService;
@doc("The list of available upgrades for an agent pool.")
@singleton("default")
@parentResource(AgentPool)
model AgentPoolUpgradeProfile
  is ProxyResource<AgentPoolUpgradeProfileProperties> {
  @key("default")
  @segment("upgradeProfiles")
  name: string;
}

@armResourceOperations
interface AgentPools {
  @doc("Gets the upgrade profile for an agent pool.")
  getUpgradeProfile is ArmResourceRead<AgentPoolUpgradeProfile>;
}

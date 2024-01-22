import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./AgentPool.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.ContainerService;
/**
 * The list of available upgrades for an agent pool.
 */
@singleton("default")
@parentResource(AgentPool)
model AgentPoolUpgradeProfile
  is ProxyResource<AgentPoolUpgradeProfileProperties> {
  @key("upgradeProfile")
  @segment("upgradeProfiles")
  name: string;
}

@armResourceOperations
interface AgentPoolUpgradeProfiles {
  /**
   * Gets the upgrade profile for an agent pool.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("AgentPools_GetUpgradeProfile")
  getUpgradeProfile is ArmResourceRead<AgentPoolUpgradeProfile>;
}

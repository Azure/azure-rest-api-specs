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
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@singleton("default")
@parentResource(AgentPool)
@includeInapplicableMetadataInPayload(false)
@Azure.ResourceManager.Private.armResourceInternal(
  AgentPoolUpgradeProfileProperties
)
model AgentPoolUpgradeProfile extends ProxyResourceBase {
  @key("upgradeProfile")
  @segment("upgradeProfiles")
  @visibility("read")
  name: string;

  /**
   * The properties of the agent pool upgrade profile.
   */
  @extension("x-ms-client-flatten", true)
  properties: AgentPoolUpgradeProfileProperties;
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

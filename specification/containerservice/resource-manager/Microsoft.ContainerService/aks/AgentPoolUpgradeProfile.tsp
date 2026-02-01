import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./AgentPool.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;

namespace Microsoft.ContainerService;
/**
 * The list of available upgrades for an agent pool.
 */
@singleton("default")
@parentResource(AgentPool)
model AgentPoolUpgradeProfile
  is Azure.ResourceManager.ProxyResource<
    AgentPoolUpgradeProfileProperties,
    false
  > {
  ...ResourceNameParameter<
    Resource = AgentPoolUpgradeProfile,
    KeyName = "upgradeProfile",
    SegmentName = "upgradeProfiles",
    NamePattern = ""
  >;
}

@armResourceOperations(#{ omitTags: true })
interface AgentPoolUpgradeProfiles {
  /**
   * Gets the upgrade profile for an agent pool.
   */
  @tag("AgentPools")
  getUpgradeProfile is ArmResourceRead<AgentPoolUpgradeProfile>;
}

@@doc(AgentPoolUpgradeProfile.name, "");
@@doc(AgentPoolUpgradeProfile.properties,
  "The properties of the agent pool upgrade profile."
);

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
@doc("The list of available kubernetes version upgrades for the provisioned cluster.")
@parentResource(ProvisionedCluster)
@singleton("default")
model ProvisionedClusterUpgradeProfile
  is ProxyResource<ProvisionedClusterUpgradeProfileProperties> {
  @key("default")
  @segment("upgradeProfiles")
  name: string;
}

@armResourceOperations
interface ProvisionedClusterUpgradeProfiles {
  @doc("Gets the upgrade profile of a provisioned cluster")
  getUpgradeProfile is ArmResourceRead<ProvisionedClusterUpgradeProfile>;
}

import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./ProvisionedClustersResponse.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Microsoft.HybridContainerService;
@doc("The list of available upgrades for compute pools.")
@singleton("default")
@parentResource(ProvisionedClustersResponse)
model ProvisionedClusterUpgradeProfile
  is ProxyResource<ProvisionedClusterUpgradeProfileProperties> {
  @key("upgradeProfile")
  @segment("upgradeProfiles")
  name: string;
}

@armResourceOperations
@projectedName("client", "ProvisionedClusters")
interface ProvisionedClusterUpgradeProfiles_ProvisionedClusters {
  @doc("Gets the upgrade profile of a provisioned cluster.")
  getUpgradeProfile is ArmResourceRead<ProvisionedClusterUpgradeProfile>;
}

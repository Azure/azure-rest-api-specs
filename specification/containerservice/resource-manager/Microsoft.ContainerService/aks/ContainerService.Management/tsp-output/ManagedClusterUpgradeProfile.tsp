import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./ManagedCluster.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Microsoft.ContainerService;
@doc("The list of available upgrades for compute pools.")
@singleton("default")
@parentResource(ManagedCluster)
model ManagedClusterUpgradeProfile
  is ProxyResource<ManagedClusterUpgradeProfileProperties> {
  @key("upgradeProfile")
  @segment("upgradeProfiles")
  name: string;
}

@armResourceOperations
@projectedName("client", "ManagedClusters")
interface ManagedClusterUpgradeProfiles_ManagedClusters {
  @doc("Gets the upgrade profile of a managed cluster.")
  getUpgradeProfile is ArmResourceRead<ManagedClusterUpgradeProfile>;
}

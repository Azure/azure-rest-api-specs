import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./ManagedCluster.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.ContainerService;
/**
 * The list of available upgrades for compute pools.
 */
@singleton("default")
@parentResource(ManagedCluster)
model ManagedClusterUpgradeProfile
  is ProxyResource<ManagedClusterUpgradeProfileProperties> {
  @key("upgradeProfile")
  @segment("upgradeProfiles")
  name: string;
}

@armResourceOperations
interface ManagedClusterUpgradeProfiles {
  /**
   * Gets the upgrade profile of a managed cluster.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("ManagedClusters_GetUpgradeProfile")
  getUpgradeProfile is ArmResourceRead<ManagedClusterUpgradeProfile>;
}

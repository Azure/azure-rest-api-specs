import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./ProvisionedCluster.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.HybridContainerService;
/**
 * The list of available kubernetes version upgrades for the provisioned cluster.
 */
@singleton("default")
@parentResource(ProvisionedCluster)
model ProvisionedClusterUpgradeProfile
  is ProxyResource<ProvisionedClusterUpgradeProfileProperties> {
  ...ResourceNameParameter<
    ProvisionedClusterUpgradeProfile,
    "upgradeProfile",
    "upgradeProfiles"
  >;
}

@armResourceOperations
interface ProvisionedClusterUpgradeProfiles {
  /**
   * Gets the upgrade profile of a provisioned cluster
   */
  getUpgradeProfile is ArmResourceRead<
    ProvisionedClusterUpgradeProfile,
    BaseParameters = ConnectedClusterResourceUriParameters
  >;
}

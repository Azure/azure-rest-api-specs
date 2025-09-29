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
@parentResource(provisionedCluster)
model ProvisionedClusterUpgradeProfile
  is ProxyResource<ProvisionedClusterUpgradeProfileProperties> {
  ...ResourceNameParameter<
    Resource = ProvisionedClusterUpgradeProfile,
    KeyName = "upgradeProfile",
    SegmentName = "upgradeProfiles"
  >;
}

@armResourceOperations
interface ProvisionedClusterUpgradeProfiles {
  /**
   * Gets the upgrade profile of a provisioned cluster
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("provisionedClusterInstances_GetUpgradeProfile")
  getUpgradeProfile is ArmResourceRead<
    ProvisionedClusterUpgradeProfile,
    BaseParameters = ConnectedClusterResourceUriParameters
  >;
}

@@doc(ProvisionedClusterUpgradeProfile.name, "");
@@doc(ProvisionedClusterUpgradeProfile.properties,
  "The properties of the upgrade profile."
);

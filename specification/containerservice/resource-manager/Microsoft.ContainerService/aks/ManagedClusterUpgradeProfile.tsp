import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./ManagedCluster.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.ContainerService;
/**
 * The list of available upgrades for compute pools.
 */
@singleton("default")
@parentResource(ManagedCluster)
model ManagedClusterUpgradeProfile
  is Azure.ResourceManager.ProxyResource<
    ManagedClusterUpgradeProfileProperties,
    false
  > {
  ...ResourceNameParameter<
    Resource = ManagedClusterUpgradeProfile,
    KeyName = "upgradeProfile",
    SegmentName = "upgradeProfiles",
    NamePattern = ""
  >;
}

@armResourceOperations
interface ManagedClusterUpgradeProfiles {
  /**
   * Gets the upgrade profile of a managed cluster.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ManagedClusters_GetUpgradeProfile")
  getUpgradeProfile is ArmResourceRead<ManagedClusterUpgradeProfile>;
}

@@doc(ManagedClusterUpgradeProfile.name, "");
@@doc(ManagedClusterUpgradeProfile.properties,
  "The properties of the upgrade profile."
);

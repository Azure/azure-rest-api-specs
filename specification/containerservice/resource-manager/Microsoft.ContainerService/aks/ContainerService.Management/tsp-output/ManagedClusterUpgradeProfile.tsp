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
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@singleton("default")
@parentResource(ManagedCluster)
@Azure.ResourceManager.Private.armResourceInternal(
  ManagedClusterUpgradeProfileProperties
)
@includeInapplicableMetadataInPayload(false)
model ManagedClusterUpgradeProfile extends ProxyResourceBase {
  @key("upgradeProfile")
  @segment("upgradeProfiles")
  name: string;

  /**
   * The properties of the upgrade profile.
   */
  @extension("x-ms-client-flatten", true)
  properties: ManagedClusterUpgradeProfileProperties;
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

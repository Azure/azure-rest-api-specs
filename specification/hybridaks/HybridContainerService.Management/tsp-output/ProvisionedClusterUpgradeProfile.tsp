import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./ProvisionedCluster.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.HybridContainerService;
/**
 * The list of available kubernetes version upgrades for the provisioned cluster.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@singleton("default")
@parentResource(ProvisionedCluster)
@Azure.ResourceManager.Private.armResourceInternal(
  ProvisionedClusterUpgradeProfileProperties
)
@includeInapplicableMetadataInPayload(false)
model ProvisionedClusterUpgradeProfile extends ProxyResourceBase {
  @key("upgradeProfile")
  @segment("upgradeProfiles")
  name: string;

  /**
   * The properties of the upgrade profile.
   */
  @extension("x-ms-client-flatten", true)
  properties: ProvisionedClusterUpgradeProfileProperties;
}

@armResourceOperations
interface ProvisionedClusterUpgradeProfiles {
  /**
   * Gets the upgrade profile of a provisioned cluster
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("provisionedClusterInstances_GetUpgradeProfile")
  getUpgradeProfile is ArmResourceRead<ProvisionedClusterUpgradeProfile>;
}

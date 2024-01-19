import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./ProvisionedClusters.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.HybridContainerService;
@doc("The list of available upgrades for compute pools.")
@singleton("default")
@parentResource(ProvisionedClusters)
model ProvisionedClusterUpgradeProfile
  is ProxyResource<ProvisionedClusterUpgradeProfileProperties> {
  @key("upgradeProfile")
  @segment("upgradeProfiles")
  name: string;
}

@armResourceOperations
interface ProvisionedClusterUpgradeProfiles {
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Gets the upgrade profile of a provisioned cluster instance.")
  @operationId("provisionedClusterInstances_GetUpgradeProfile")
  getUpgradeProfile is ArmResourceRead<ProvisionedClusterUpgradeProfile>;
}

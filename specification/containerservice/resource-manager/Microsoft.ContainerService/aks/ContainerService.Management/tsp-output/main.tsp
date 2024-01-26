import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./models.tsp";
import "./OSOptionProfile.tsp";
import "./ManagedClusterUpgradeProfile.tsp";
import "./ManagedCluster.tsp";
import "./MeshRevisionProfile.tsp";
import "./MeshUpgradeProfile.tsp";
import "./MaintenanceConfiguration.tsp";
import "./AgentPool.tsp";
import "./AgentPoolUpgradeProfile.tsp";
import "./PrivateEndpointConnection.tsp";
import "./Snapshot.tsp";
import "./TrustedAccessRoleBinding.tsp";
import "./routes.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager.Foundations;
using Azure.Core;
using Azure.ResourceManager;
using TypeSpec.Versioning;
/**
 * The Container Service Client.
 */
@armProviderNamespace
@useAuth(AadOauth2Auth<["user_impersonation"]>)
@service({
  title: "ContainerServiceClient",
})
@versioned(Versions)
@armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v5)
namespace Microsoft.ContainerService;

/**
 * The available API versions.
 */
enum Versions {
  /**
   * The 2023-10-01 API version.
   */
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @useDependency(Azure.Core.Versions.v1_0_Preview_1)
  v2023_10_01: "2023-10-01",
}

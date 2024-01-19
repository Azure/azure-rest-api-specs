import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./models.tsp";
import "./OSOptionProfile.tsp";
import "./ManagedClusterUpgradeProfile.tsp";
import "./ManagedCluster.tsp";
import "./MaintenanceConfiguration.tsp";
import "./AgentPool.tsp";
import "./AgentPoolUpgradeProfile.tsp";
import "./PrivateEndpointConnection.tsp";
import "./Snapshot.tsp";
import "./ManagedClusterSnapshot.tsp";
import "./TrustedAccessRoleBinding.tsp";
import "./Fleet.tsp";
import "./FleetMember.tsp";
import "./routes.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager.Foundations;
using Azure.Core;
using Azure.ResourceManager;
using TypeSpec.Versioning;
@armProviderNamespace
@service({
  title: "ContainerServiceClient",
})
@versioned(Versions)
@armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v3)
@doc("The Container Service Client.")
namespace Microsoft.ContainerService;

@doc("The available API versions.")
enum Versions {
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @useDependency(Azure.Core.Versions.v1_0_Preview_1)
  @doc("The 2022-11-02-preview API version.")
  v2022_11_02_preview: "2022-11-02-preview",

  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @useDependency(Azure.Core.Versions.v1_0_Preview_1)
  @doc("The 2022-09-02-preview API version.")
  v2022_09_02_preview: "2022-09-02-preview",
}

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
@armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v3)
@doc("The Container Service Client.")
namespace Azure.ResourceManager.ContainerService;

import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./models.tsp";
import "./AttachedDataNetwork.tsp";
import "./DataNetwork.tsp";
import "./DiagnosticsPackage.tsp";
import "./MobileNetwork.tsp";
import "./PacketCapture.tsp";
import "./PacketCoreControlPlane.tsp";
import "./PacketCoreControlPlaneVersion.tsp";
import "./PacketCoreControlPlaneVersion.tsp";
import "./PacketCoreDataPlane.tsp";
import "./Service.tsp";
import "./Sim.tsp";
import "./SimGroup.tsp";
import "./SimPolicy.tsp";
import "./Site.tsp";
import "./Slice.tsp";
import "./routes.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager.Foundations;
using Azure.Core;
using Azure.ResourceManager;
using TypeSpec.Versioning;
@armProviderNamespace
@service({
  title: "MobileNetworkManagementClient",
})
@versioned(Versions)
@armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v3)
@doc("The resources in this API specification will be used to manage attached data network resources in mobile network attached to a particular packet core instance")
namespace Microsoft.MobileNetwork;

@doc("The available API versions.")
enum Versions {
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @useDependency(Azure.Core.Versions.v1_0_Preview_1)
  @doc("The 2023-09-01 API version.")
  v2023_09_01: "2023-09-01",
}

import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./models.tsp";
import "./MobileAttachedDataNetwork.tsp";
import "./MobileDataNetwork.tsp";
import "./MobileNetworkDiagnosticsPackage.tsp";
import "./MobileNetwork.tsp";
import "./MobileNetworkPacketCapture.tsp";
import "./PacketCoreControlPlane.tsp";
import "./TenantPacketCoreControlPlaneVersion.tsp";
import "./SubscriptionPacketCoreControlPlaneVersion.tsp";
import "./PacketCoreDataPlane.tsp";
import "./MobileNetworkService.tsp";
import "./MobileNetworkSim.tsp";
import "./MobileNetworkSimGroup.tsp";
import "./MobileNetworkSimPolicy.tsp";
import "./MobileNetworkSite.tsp";
import "./MobileNetworkSlice.tsp";
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
@doc("The resources in this API specification will be used to manage attached data network resources in mobile network attached to a particular packet core instance")
namespace Azure.ResourceManager.MobileNetwork;

@doc("The available API versions.")
enum Versions {
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @useDependency(Azure.Core.Versions.v1_0_Preview_1)
  v2023_09_01: "2023-09-01",
}

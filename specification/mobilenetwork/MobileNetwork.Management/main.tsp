import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

import "./apis/AttachedDataNetwork.tsp";
import "./apis/AttachedWifiSsid.tsp";
import "./apis/DataNetwork.tsp";
import "./apis/DiagnosticsPackage.tsp";
import "./apis/EdgeNetworkSecurityGroup.tsp";
import "./apis/EdgeVirtualNetwork.tsp";
import "./apis/MobileNetwork.tsp";
import "./apis/PacketCapture.tsp";
import "./apis/PacketCoreControlPlane.tsp";
import "./apis/RoutingInfo.tsp";
import "./apis/PacketCoreControlPlaneVersion.tsp";
import "./apis/PacketCoreDataPlane.tsp";
import "./apis/RadioAccessNetwork.tsp";
import "./apis/Service.tsp";
import "./apis/Sim.tsp";
import "./apis/SimGroup.tsp";
import "./apis/SimPolicy.tsp";
import "./apis/Site.tsp";
import "./apis/Slice.tsp";
import "./apis/ExtendedInformation.tsp";
import "./apis/WifiSsid.tsp";
import "./apis/Ues.tsp";

import "./apis/AmfDeployment.tsp";
import "./apis/ClusterService.tsp";
import "./apis/NnssfDeployment.tsp";
import "./apis/NrfDeployment.tsp";
import "./apis/ObservabilityService.tsp";
import "./apis/SmfDeployment.tsp";
import "./apis/UpfDeployment.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager.Foundations;
using Azure.Core;
using Azure.ResourceManager;
using TypeSpec.Versioning;

@doc("Mobile Network Management API")
@armProviderNamespace("Microsoft.MobileNetwork")
@armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v5)
@service({
  title: "MobileNetworkManagementClient",
})
@versioned(Versions)
namespace Microsoft.MobileNetwork;

interface Operations extends Azure.ResourceManager.Operations {}

@doc("The available API versions.")
enum Versions {
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @useDependency(Azure.Core.Versions.v1_0_Preview_1)
  @doc("May 01, 2024 Preview API Version")
  v2024_05_01_preview: "2024-05-01-preview",

  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @useDependency(Azure.Core.Versions.v1_0_Preview_1)
  @doc("June 01, 2024 Stable API Version")
  v2024_06_01: "2024-06-01",
}

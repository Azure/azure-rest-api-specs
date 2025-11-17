import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./models/common.tsp";
import "./models/AccessControlList.tsp";
import "./models/InternetGateway.tsp";
import "./models/InternetGatewayRule.tsp";
import "./models/NetworkFabric.tsp";
import "./models/NetworkToNetworkInterconnect.tsp";
import "./models/IpCommunity.tsp";
import "./models/IpExtendedCommunity.tsp";
import "./models/IpPrefix.tsp";
import "./models/L2IsolationDomain.tsp";
import "./models/L3IsolationDomain.tsp";
import "./models/InternalNetwork.tsp";
import "./models/ExternalNetwork.tsp";
import "./models/NeighborGroup.tsp";
import "./models/NetworkDevice.tsp";
import "./models/NetworkDeviceSku.tsp";
import "./models/NetworkInterface.tsp";
import "./models/NetworkFabricController.tsp";
import "./models/NetworkFabricSku.tsp";
import "./models/NetworkPacketBroker.tsp";
import "./models/NetworkRack.tsp";
import "./models/NetworkTapRule.tsp";
import "./models/NetworkTap.tsp";
import "./models/RoutePolicy.tsp";
import "./models/NetworkMonitor.tsp";
import "./resources/AccessControlList.tsp";
import "./resources/InternetGatewayRule.tsp";
import "./resources/InternetGateway.tsp";
import "./resources/IpCommunity.tsp";
import "./resources/IpExtendedCommunity.tsp";
import "./resources/IpPrefix.tsp";
import "./resources/L2IsolationDomain.tsp";
import "./resources/L3IsolationDomain.tsp";
import "./resources/InternalNetwork.tsp";
import "./resources/ExternalNetwork.tsp";
import "./resources/NeighborGroup.tsp";
import "./resources/NetworkDeviceSku.tsp";
import "./resources/NetworkDevice.tsp";
import "./resources/NetworkInterface.tsp";
import "./resources/NetworkFabricController.tsp";
import "./resources/NetworkFabricSku.tsp";
import "./resources/NetworkFabric.tsp";
import "./resources/NetworkToNetworkInterconnect.tsp";
import "./resources/NetworkPacketBroker.tsp";
import "./resources/NetworkRack.tsp";
import "./resources/NetworkTapRule.tsp";
import "./resources/NetworkTap.tsp";
import "./resources/RoutePolicy.tsp";
import "./resources/NetworkMonitor.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager.Foundations;
using Azure.Core;
using Azure.ResourceManager;
using TypeSpec.Versioning;

@doc("Self service experience for Azure Network Fabric API.")
@armProviderNamespace("Microsoft.ManagedNetworkFabric")
@armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v5)
@service(#{ title: "Azure Network Fabric Management Service API" })
@versioned(Versions)
namespace Microsoft.ManagedNetworkFabric;

@doc("API Versions")
enum Versions {
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v5)
  @doc("2024-02-15-preview")
  v2024_02_15_preview: "2024-02-15-preview",

  @doc("2024-06-15-preview")
  v2024_06_15_preview: "2024-06-15-preview",
}

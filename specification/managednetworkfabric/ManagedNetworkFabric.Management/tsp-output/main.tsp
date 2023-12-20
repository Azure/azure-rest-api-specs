import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./models.tsp";
import "./NetworkFabricAccessControlList.tsp";
import "./NetworkFabricInternetGateway.tsp";
import "./NetworkFabricInternetGatewayRule.tsp";
import "./NetworkFabricIPCommunity.tsp";
import "./NetworkFabricIPExtendedCommunity.tsp";
import "./NetworkFabricIPPrefix.tsp";
import "./NetworkFabricL2IsolationDomain.tsp";
import "./NetworkFabricL3IsolationDomain.tsp";
import "./NetworkFabricInternalNetwork.tsp";
import "./NetworkFabricExternalNetwork.tsp";
import "./NetworkFabricNeighborGroup.tsp";
import "./NetworkDeviceSku.tsp";
import "./NetworkDevice.tsp";
import "./NetworkDeviceInterface.tsp";
import "./NetworkFabricController.tsp";
import "./NetworkFabricSku.tsp";
import "./NetworkFabric.tsp";
import "./NetworkToNetworkInterconnect.tsp";
import "./NetworkPacketBroker.tsp";
import "./NetworkRack.tsp";
import "./NetworkTapRule.tsp";
import "./NetworkTap.tsp";
import "./NetworkFabricRoutePolicy.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager.Foundations;
using Azure.Core;
using Azure.ResourceManager;
using TypeSpec.Versioning;
@armProviderNamespace
@service({
  title: "Azure Network Fabric Management Service API",
})
@versioned(Versions)
@armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v5)
@doc("Self service experience for Azure Network Fabric API.")
namespace Azure.ResourceManager.ManagedNetworkFabric;

@doc("The available API versions.")
enum Versions {
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @useDependency(Azure.Core.Versions.v1_0_Preview_1)
  v2023_06_15: "2023-06-15",
}

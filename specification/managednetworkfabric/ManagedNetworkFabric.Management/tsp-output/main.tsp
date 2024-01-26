import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./models.tsp";
import "./AccessControlList.tsp";
import "./InternetGateway.tsp";
import "./InternetGatewayRule.tsp";
import "./IpCommunity.tsp";
import "./IpExtendedCommunity.tsp";
import "./IpPrefix.tsp";
import "./L2IsolationDomain.tsp";
import "./L3IsolationDomain.tsp";
import "./InternalNetwork.tsp";
import "./ExternalNetwork.tsp";
import "./NeighborGroup.tsp";
import "./NetworkDeviceSku.tsp";
import "./NetworkDevice.tsp";
import "./NetworkInterface.tsp";
import "./NetworkFabricController.tsp";
import "./NetworkFabricSku.tsp";
import "./NetworkFabric.tsp";
import "./NetworkToNetworkInterconnect.tsp";
import "./NetworkPacketBroker.tsp";
import "./NetworkRack.tsp";
import "./NetworkTapRule.tsp";
import "./NetworkTap.tsp";
import "./RoutePolicy.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager.Foundations;
using Azure.Core;
using Azure.ResourceManager;
using TypeSpec.Versioning;
/**
 * Self service experience for Azure Network Fabric API.
 */
@armProviderNamespace
@useAuth(AadOauth2Auth<["user_impersonation"]>)
@service({
  title: "Azure Network Fabric Management Service API",
})
@versioned(Versions)
@armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v5)
namespace Microsoft.ManagedNetworkFabric;

/**
 * The available API versions.
 */
enum Versions {
  /**
   * The 2023-06-15 API version.
   */
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @useDependency(Azure.Core.Versions.v1_0_Preview_1)
  v2023_06_15: "2023-06-15",
}

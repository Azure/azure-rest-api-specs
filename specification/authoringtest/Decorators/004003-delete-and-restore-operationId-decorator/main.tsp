import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "@typespec/versioning";
import "./BastionHost.tsp";
import "./BgpConnection.tsp";
import "./ExpressRouteGateway.tsp";
import "./ExpressRoutePort.tsp";
import "./ExpressRouteProviderPort.tsp";
import "./NetworkInterface.tsp";
import "./P2SVpnGateway.tsp";
import "./Route.tsp";
import "./VpnServerConfigurationPolicyGroup.tsp";
import "./VpnSiteLinkConnection.tsp";

using Azure.ResourceManager;
using TypeSpec.Versioning;

@Azure.ResourceManager.Legacy.features(Features)
@armProviderNamespace
@service(#{ title: "NetworkManagement" })
@versioned(Versions)
@armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v5)
namespace Microsoft.Network;

enum Versions {
  @useDependency(Azure.ResourceManager.CommonTypes.Versions.v5)
  v2025_05_01: "2025-05-01",
}

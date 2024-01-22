import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./models.tsp";
import "./PrivateCloud.tsp";
import "./Cluster.tsp";
import "./Datastore.tsp";
import "./HcxEnterpriseSite.tsp";
import "./ExpressRouteAuthorization.tsp";
import "./GlobalReachConnection.tsp";
import "./WorkloadNetwork.tsp";
import "./WorkloadNetworkSegment.tsp";
import "./WorkloadNetworkDhcp.tsp";
import "./WorkloadNetworkGateway.tsp";
import "./WorkloadNetworkPortMirroring.tsp";
import "./WorkloadNetworkVMGroup.tsp";
import "./WorkloadNetworkVirtualMachine.tsp";
import "./WorkloadNetworkDnsService.tsp";
import "./WorkloadNetworkDnsZone.tsp";
import "./WorkloadNetworkPublicIP.tsp";
import "./CloudLink.tsp";
import "./Addon.tsp";
import "./VirtualMachine.tsp";
import "./PlacementPolicy.tsp";
import "./ScriptPackage.tsp";
import "./ScriptCmdlet.tsp";
import "./ScriptExecution.tsp";
import "./routes.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager.Foundations;
using Azure.Core;
using Azure.ResourceManager;
using TypeSpec.Versioning;
/**
 * Azure VMware Solution API
 */
@armProviderNamespace
@service({
  title: "Azure VMware Solution API",
})
@versioned(Versions)
@armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v5)
namespace Microsoft.AVS;

/**
 * The available API versions.
 */
enum Versions {
  /**
   * The 2023-03-01 API version.
   */
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @useDependency(Azure.Core.Versions.v1_0_Preview_1)
  v2023_03_01: "2023-03-01",
}

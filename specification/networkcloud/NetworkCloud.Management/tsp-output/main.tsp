import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./models.tsp";
import "./BareMetalMachine.tsp";
import "./CloudServicesNetwork.tsp";
import "./ClusterManager.tsp";
import "./Cluster.tsp";
import "./KubernetesCluster.tsp";
import "./L2Network.tsp";
import "./L3Network.tsp";
import "./RackSku.tsp";
import "./Rack.tsp";
import "./StorageAppliance.tsp";
import "./TrunkedNetwork.tsp";
import "./VirtualMachine.tsp";
import "./Volume.tsp";
import "./BareMetalMachineKeySet.tsp";
import "./BmcKeySet.tsp";
import "./ClusterMetricsConfiguration.tsp";
import "./AgentPool.tsp";
import "./Console.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager.Foundations;
using Azure.Core;
using Azure.ResourceManager;
using TypeSpec.Versioning;
/**
 * The Network Cloud APIs provide management of the on-premises clusters and their resources, such as, racks, bare metal hosts, virtual machines, workload networks and more.
 */
@armProviderNamespace
@service({
  title: "NetworkCloud",
})
@versioned(Versions)
@armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v5)
namespace Microsoft.NetworkCloud;

/**
 * The available API versions.
 */
enum Versions {
  /**
   * The 2023-07-01 API version.
   */
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @useDependency(Azure.Core.Versions.v1_0_Preview_1)
  v2023_07_01: "2023-07-01",
}

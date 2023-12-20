import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./models.tsp";
import "./NetworkCloudBareMetalMachine.tsp";
import "./NetworkCloudCloudServicesNetwork.tsp";
import "./NetworkCloudClusterManager.tsp";
import "./NetworkCloudCluster.tsp";
import "./NetworkCloudKubernetesCluster.tsp";
import "./NetworkCloudL2Network.tsp";
import "./NetworkCloudL3Network.tsp";
import "./NetworkCloudRackSku.tsp";
import "./NetworkCloudRack.tsp";
import "./NetworkCloudStorageAppliance.tsp";
import "./NetworkCloudTrunkedNetwork.tsp";
import "./NetworkCloudVirtualMachine.tsp";
import "./NetworkCloudVolume.tsp";
import "./NetworkCloudBareMetalMachineKeySet.tsp";
import "./NetworkCloudBmcKeySet.tsp";
import "./NetworkCloudClusterMetricsConfiguration.tsp";
import "./NetworkCloudAgentPool.tsp";
import "./NetworkCloudVirtualMachineConsole.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager.Foundations;
using Azure.Core;
using Azure.ResourceManager;
using TypeSpec.Versioning;
@armProviderNamespace
@service({
  title: "NetworkCloud",
})
@versioned(Versions)
@armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v5)
@doc("The Network Cloud APIs provide management of the on-premises clusters and their resources, such as, racks, bare metal hosts, virtual machines, workload networks and more.")
namespace Azure.ResourceManager.NetworkCloud;

@doc("The available API versions.")
enum Versions {
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @useDependency(Azure.Core.Versions.v1_0_Preview_1)
  v2023_07_01: "2023-07-01",
}

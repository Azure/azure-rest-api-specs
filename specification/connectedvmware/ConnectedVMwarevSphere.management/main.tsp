import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./models.tsp";
import "./ResourcePool.tsp";
import "./Cluster.tsp";
import "./Host.tsp";
import "./Datastore.tsp";
import "./VCenter.tsp";
import "./VirtualMachineTemplate.tsp";
import "./VirtualNetwork.tsp";
import "./InventoryItem.tsp";
import "./VirtualMachineInstance.tsp";
import "./VmInstanceHybridIdentityMetadata.tsp";
import "./GuestAgent.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager.Foundations;
using Azure.Core;
using Azure.ResourceManager;
using TypeSpec.Versioning;
@armProviderNamespace
@service({
  title: "Azure Arc VMware Management Service API",
})
@versioned(Versions)
@doc("Self service experience for VMware.")
namespace Microsoft.ConnectedVMwarevSphere;

@doc("The available API versions.")
enum Versions {
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @useDependency(Azure.Core.Versions.v1_0_Preview_1)
  v2023_10_01: "2023-10-01",
}

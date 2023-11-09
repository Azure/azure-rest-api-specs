import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./models.tsp";
import "./VMMServer.tsp";
import "./Cloud.tsp";
import "./VirtualNetwork.tsp";
import "./VirtualMachineTemplate.tsp";
import "./AvailabilitySet.tsp";
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
  title: "SCVMM",
})
@versioned(Versions)
@doc("The Microsoft.ScVmm Rest API spec.")
namespace Microsoft.ScVmm;

@doc("The available API versions.")
enum Versions {
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @useDependency(Azure.Core.Versions.v1_0_Preview_1)
  v2023_10_07: "2023-10-07",
}

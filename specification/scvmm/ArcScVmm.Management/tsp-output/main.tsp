import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./models.tsp";
import "./VMMServer.tsp";
import "./Cloud.tsp";
import "./VirtualNetwork.tsp";
import "./VirtualMachine.tsp";
import "./VirtualMachineTemplate.tsp";
import "./AvailabilitySet.tsp";
import "./InventoryItem.tsp";

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
@armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v3)
@doc("The Microsoft.ScVmm Rest API spec.")
namespace Microsoft.ScVmm;

@doc("The available API versions.")
enum Versions {
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @useDependency(Azure.Core.Versions.v1_0_Preview_1)
  @doc("The 2020-06-05-preview API version.")
  v2020_06_05_preview: "2020-06-05-preview",
}

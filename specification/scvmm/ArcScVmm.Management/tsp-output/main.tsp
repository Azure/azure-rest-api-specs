import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./models.tsp";
import "./ScVmmServer.tsp";
import "./ScVmmCloud.tsp";
import "./ScVmmVirtualNetwork.tsp";
import "./ScVmmVirtualMachine.tsp";
import "./ScVmmVirtualMachineTemplate.tsp";
import "./ScVmmAvailabilitySet.tsp";
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
@doc("The Microsoft.ScVmm Rest API spec.")
namespace Azure.ResourceManager.ArcScVmm;

@doc("The available API versions.")
enum Versions {
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @useDependency(Azure.Core.Versions.v1_0_Preview_1)
  v2020_06_05_preview: "2020-06-05-preview",
}

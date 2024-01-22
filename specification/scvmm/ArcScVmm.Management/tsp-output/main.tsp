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
/**
 * The Microsoft.ScVmm Rest API spec.
 */
@armProviderNamespace
@service({
  title: "SCVMM",
})
@versioned(Versions)
@armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v3)
namespace Microsoft.ScVmm;

/**
 * The available API versions.
 */
enum Versions {
  /**
   * The 2020-06-05-preview API version.
   */
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @useDependency(Azure.Core.Versions.v1_0_Preview_1)
  v2020_06_05_preview: "2020-06-05-preview",
}

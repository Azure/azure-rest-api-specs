import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./models.tsp";
import "./VmmServer.tsp";
import "./Cloud.tsp";
import "./VirtualNetwork.tsp";
import "./VirtualMachineTemplate.tsp";
import "./AvailabilitySet.tsp";
import "./InventoryItem.tsp";
import "./VirtualMachineInstance.tsp";
import "./VmInstanceHybridIdentityMetadata.tsp";
import "./GuestAgent.tsp";
import "./BackCompat.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager.Foundations;
using Azure.Core;
using Azure.ResourceManager;
using TypeSpec.Versioning;
/** The Microsoft.ScVmm Rest API spec. */
@armProviderNamespace
@service(#{ title: "ScVmm" })
@versioned(Versions)
namespace Microsoft.ScVmm;

/** The available API versions. */
enum Versions {
  /** Service version 2023-10-07. */
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @useDependency(Azure.Core.Versions.v1_0_Preview_1)
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v5)
  v2023_10_07: "2023-10-07",

  /** Service version 2024-06-01. */
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @useDependency(Azure.Core.Versions.v1_0_Preview_1)
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v5)
  v2024_06_01: "2024-06-01",
}

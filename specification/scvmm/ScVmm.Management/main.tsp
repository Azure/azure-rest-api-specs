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
  /** Service version 2025-03-13. */
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v5)
  v2025_03_13: "2025-03-13",
}

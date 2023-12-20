import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./models.tsp";
import "./VMwareResourcePool.tsp";
import "./VMwareCluster.tsp";
import "./VMwareHost.tsp";
import "./VMwareDatastore.tsp";
import "./VMwareVCenter.tsp";
import "./VMwareVmTemplate.tsp";
import "./VMwareVirtualNetwork.tsp";
import "./VCenterInventoryItem.tsp";
import "./VMwareVmInstance.tsp";
import "./VmInstanceHybridIdentityMetadata.tsp";
import "./VmInstanceGuestAgent.tsp";

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
@armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v3)
@doc("Self service experience for VMware.")
namespace Azure.ResourceManager.ConnectedVMwarevSphere;

@doc("The available API versions.")
enum Versions {
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @useDependency(Azure.Core.Versions.v1_0_Preview_1)
  v2023_10_01: "2023-10-01",
}

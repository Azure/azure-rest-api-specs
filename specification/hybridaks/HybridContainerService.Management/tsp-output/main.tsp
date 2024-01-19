import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./models.tsp";
import "./ProvisionedClusters.tsp";
import "./ProvisionedClusterUpgradeProfile.tsp";
import "./HybridIdentityMetadata.tsp";
import "./AgentPool.tsp";
import "./KubernetesVersionProfile.tsp";
import "./VmSkuProfile.tsp";
import "./VirtualNetwork.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager.Foundations;
using Azure.Core;
using Azure.ResourceManager;
using TypeSpec.Versioning;
@armProviderNamespace
@service({
  title: "HybridContainerService",
})
@versioned(Versions)
@armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v5)
@doc("The Microsoft.HybridContainerService Rest API spec.")
namespace Microsoft.HybridContainerService;

@doc("The available API versions.")
enum Versions {
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @useDependency(Azure.Core.Versions.v1_0_Preview_1)
  @doc("The 2023-11-15-preview API version.")
  v2023_11_15_preview: "2023-11-15-preview",
}

import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./models.tsp";
import "./ProvisionedCluster.tsp";
import "./ProvisionedClusterUpgradeProfile.tsp";
import "./HybridIdentityMetadata.tsp";
import "./HybridContainerServiceAgentPool.tsp";
import "./StorageSpace.tsp";
import "./HybridContainerServiceVirtualNetwork.tsp";
import "./routes.tsp";

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
@armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v2)
@doc("The Microsoft.HybridContainerService Rest API spec.")
namespace Azure.ResourceManager.HybridContainerService;

@doc("The available API versions.")
enum Versions {
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @useDependency(Azure.Core.Versions.v1_0_Preview_1)
  v2022_09_01_preview: "2022-09-01-preview",
}

import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./models.tsp";
import "./ProvisionedCluster.tsp";
import "./ProvisionedClusterUpgradeProfile.tsp";
import "./HybridIdentityMetadata.tsp";
import "./AgentPool.tsp";
import "./KubernetesVersionProfile.tsp";
import "./VmSkuProfile.tsp";
import "./VirtualNetwork.tsp";
import "./back-compatible.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.Core;
using Azure.ResourceManager;
using TypeSpec.Versioning;
/**
 * The Microsoft.HybridContainerService Rest API spec.
 */
@armProviderNamespace
@service(#{ title: "HybridContainerService" })
@versioned(Versions)
@armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v5)
namespace Microsoft.HybridContainerService;

/**
 * The available API versions.
 */
enum Versions {
  /**
   * The 2025-09-01-preview API version.
   */
  v2025_09_01_preview: "2025-09-01-preview",
}

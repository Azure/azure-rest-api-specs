import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./models.tsp";
import "./Registry.tsp";
import "./PrivateLinkResource.tsp";
import "./PrivateEndpointConnection.tsp";
import "./Replication.tsp";
import "./ScopeMap.tsp";
import "./Token.tsp";
import "./Webhook.tsp";
import "./AgentPool.tsp";
import "./Run.tsp";
import "./TaskRun.tsp";
import "./Task.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager.Foundations;
using Azure.Core;
using Azure.ResourceManager;
using TypeSpec.Versioning;
/**
 * // FIXME: (missing-service-description) Add service description
 */
@armProviderNamespace
@service({
  title: "ContainerRegistryManagementClient",
})
@versioned(Versions)
@armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v4)
namespace Microsoft.ContainerRegistry;

/**
 * The available API versions.
 */
enum Versions {
  /**
   * The 2022-12-01 API version.
   */
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @useDependency(Azure.Core.Versions.v1_0_Preview_1)
  v2022_12_01: "2022-12-01",

  /**
   * The 2019-06-01-preview API version.
   */
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @useDependency(Azure.Core.Versions.v1_0_Preview_1)
  v2019_06_01_preview: "2019-06-01-preview",
}

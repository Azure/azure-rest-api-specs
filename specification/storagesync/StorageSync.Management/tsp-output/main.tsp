import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./models.tsp";
import "./StorageSyncService.tsp";
import "./PrivateEndpointConnection.tsp";
import "./SyncGroup.tsp";
import "./CloudEndpoint.tsp";
import "./ServerEndpoint.tsp";
import "./RegisteredServer.tsp";
import "./Workflow.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager.Foundations;
using Azure.Core;
using Azure.ResourceManager;
using TypeSpec.Versioning;
/**
 * Microsoft Storage Sync Service API
 */
@armProviderNamespace
@service({
  title: "Microsoft Storage Sync",
})
@versioned(Versions)
@armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v3)
namespace Microsoft.StorageSync;

/**
 * The available API versions.
 */
enum Versions {
  /**
   * The 2022-06-01 API version.
   */
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @useDependency(Azure.Core.Versions.v1_0_Preview_1)
  v2022_06_01: "2022-06-01",
}

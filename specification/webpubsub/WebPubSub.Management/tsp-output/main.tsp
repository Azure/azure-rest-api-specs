import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./models.tsp";
import "./WebPubSub.tsp";
import "./WebPubSubHub.tsp";
import "./PrivateEndpointConnection.tsp";
import "./WebPubSubSharedPrivateLink.tsp";
import "./routes.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager.Foundations;
using Azure.Core;
using Azure.ResourceManager;
using TypeSpec.Versioning;
/**
 * REST API for Azure WebPubSub Service
 */
@armProviderNamespace
@service({
  title: "WebPubSubManagementClient",
})
@versioned(Versions)
// FIXME: Common type version v2 is not supported for now.
// @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v2)
namespace Microsoft.SignalRService;

/**
 * The available API versions.
 */
enum Versions {
  /**
   * The 2021-10-01 API version.
   */
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @useDependency(Azure.Core.Versions.v1_0_Preview_1)
  v2021_10_01: "2021-10-01",
}

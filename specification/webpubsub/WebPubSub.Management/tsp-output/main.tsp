import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./models.tsp";
import "./WebPubSub.tsp";
import "./WebPubSubHub.tsp";
import "./WebPubSubPrivateEndpointConnection.tsp";
import "./WebPubSubSharedPrivateLink.tsp";
import "./routes.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager.Foundations;
using Azure.Core;
using Azure.ResourceManager;
using TypeSpec.Versioning;
@armProviderNamespace
@service({
  title: "WebPubSubManagementClient",
})
@versioned(Versions)
@doc("REST API for Azure WebPubSub Service")
namespace Azure.ResourceManager.WebPubSub;

@doc("The available API versions.")
enum Versions {
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @useDependency(Azure.Core.Versions.v1_0_Preview_1)
  v2021_10_01: "2021-10-01",
}

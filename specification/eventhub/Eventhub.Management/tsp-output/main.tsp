import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./models.tsp";
import "./EventHubsCluster.tsp";
import "./EventHubsNamespace.tsp";
import "./EventHubsNetworkRuleSet.tsp";
import "./EventHubsAuthorizationRule.tsp";
import "./EventHubsAuthorizationRule.tsp";
import "./EventHubsAuthorizationRule.tsp";
import "./PrivateEndpointConnection.tsp";
import "./EventHubsDisasterRecovery.tsp";
import "./EventHub.tsp";
import "./EventHubsConsumerGroup.tsp";
import "./EventHubsSchemaGroup.tsp";
import "./EventHubsApplicationGroup.tsp";
import "./routes.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager.Foundations;
using Azure.Core;
using Azure.ResourceManager;
using TypeSpec.Versioning;
@armProviderNamespace
@service({
  title: "EventHubManagementClient",
})
@versioned(Versions)
@doc("Azure Event Hubs client for managing Event Hubs Cluster, IPFilter Rules and VirtualNetworkRules resources.")
namespace Microsoft.EventHub;

@doc("The available API versions.")
enum Versions {
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @useDependency(Azure.Core.Versions.v1_0_Preview_1)
  @doc("The 2022-10-01-preview API version.")
  v2022_10_01_preview: "2022-10-01-preview",
}

import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./models.tsp";
import "./Cluster.tsp";
import "./EHNamespace.tsp";
import "./NetworkRuleSet.tsp";
import "./NamespaceAuthorizationRule.tsp";
import "./NamespaceDisasterRecoveryConfigAuthorizationRule.tsp";
import "./NamespaceEventhubAuthorizationRule.tsp";
import "./EventHubManagementClientPrivateEndpointConnection.tsp";
import "./ArmDisasterRecovery.tsp";
import "./Eventhub.tsp";
import "./ConsumerGroup.tsp";
import "./SchemaGroup.tsp";
import "./ApplicationGroup.tsp";
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
  v2022_10_01_preview: "2022-10-01-preview",
}

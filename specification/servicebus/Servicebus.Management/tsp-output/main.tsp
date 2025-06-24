import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./models.tsp";
import "./ServiceBusNamespace.tsp";
import "./ServiceBusNetworkRuleSet.tsp";
import "./PrivateEndpointConnection.tsp";
import "./ServiceBusDisasterRecovery.tsp";
import "./MigrationConfiguration.tsp";
import "./ServiceBusAuthorizationRule.tsp";
import "./ServiceBusAuthorizationRule.tsp";
import "./ServiceBusAuthorizationRule.tsp";
import "./ServiceBusAuthorizationRule.tsp";
import "./ServiceBusQueue.tsp";
import "./ServiceBusTopic.tsp";
import "./ServiceBusRule.tsp";
import "./ServiceBusSubscription.tsp";
import "./routes.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager.Foundations;
using Azure.Core;
using Azure.ResourceManager;
using TypeSpec.Versioning;
@armProviderNamespace
@service({
  title: "ServiceBusManagementClient",
})
@versioned(Versions)
@doc("Azure Service Bus client for managing Namespace")
namespace Microsoft.ServiceBus;

@doc("The available API versions.")
enum Versions {
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @useDependency(Azure.Core.Versions.v1_0_Preview_1)
  v2022_10_01_preview: "2022-10-01-preview",
}
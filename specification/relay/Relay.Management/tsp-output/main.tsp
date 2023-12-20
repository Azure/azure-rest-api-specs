import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./models.tsp";
import "./RelayNamespaceAuthorizationRule.tsp";
import "./RelayHybridConnectionAuthorizationRule.tsp";
import "./WcfRelayAuthorizationRule.tsp";
import "./RelayNamespace.tsp";
import "./RelayNetworkRuleSet.tsp";
import "./RelayHybridConnection.tsp";
import "./WcfRelay.tsp";
import "./RelayPrivateEndpointConnection.tsp";
import "./RelayPrivateLinkResource.tsp";
import "./routes.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager.Foundations;
using Azure.Core;
using Azure.ResourceManager;
using TypeSpec.Versioning;
@armProviderNamespace
@service({
  title: "Relay API",
})
@versioned(Versions)
@armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v3)
@doc("Use these API to manage Azure Relay resources through Azure Resource Manager.")
namespace Azure.ResourceManager.Relay;

@doc("The available API versions.")
enum Versions {
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @useDependency(Azure.Core.Versions.v1_0_Preview_1)
  v2021_11_01: "2021-11-01",
}

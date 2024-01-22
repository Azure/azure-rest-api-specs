import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./models.tsp";
import "./AuthorizationRule.tsp";
import "./AuthorizationRule.tsp";
import "./AuthorizationRule.tsp";
import "./RelayNamespace.tsp";
import "./NetworkRuleSet.tsp";
import "./HybridConnection.tsp";
import "./WcfRelay.tsp";
import "./PrivateEndpointConnection.tsp";
import "./PrivateLinkResource.tsp";
import "./routes.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager.Foundations;
using Azure.Core;
using Azure.ResourceManager;
using TypeSpec.Versioning;
/**
 * Use these API to manage Azure Relay resources through Azure Resource Manager.
 */
@armProviderNamespace
@service({
  title: "Relay API",
})
@versioned(Versions)
@armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v3)
namespace Microsoft.Relay;

/**
 * The available API versions.
 */
enum Versions {
  /**
   * The 2021-11-01 API version.
   */
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @useDependency(Azure.Core.Versions.v1_0_Preview_1)
  v2021_11_01: "2021-11-01",
}

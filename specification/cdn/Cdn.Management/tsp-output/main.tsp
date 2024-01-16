import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./models.tsp";
import "./AFDDomain.tsp";
import "./AFDEndpoint.tsp";
import "./AFDOriginGroup.tsp";
import "./AFDOrigin.tsp";
import "./FrontDoorRoute.tsp";
import "./FrontDoorRuleSet.tsp";
import "./FrontDoorRule.tsp";
import "./FrontDoorSecurityPolicy.tsp";
import "./FrontDoorSecret.tsp";
import "./Profile.tsp";
import "./CdnEndpoint.tsp";
import "./CdnOrigin.tsp";
import "./CdnOriginGroup.tsp";
import "./CdnCustomDomain.tsp";
import "./CdnWebApplicationFirewallPolicy.tsp";
import "./routes.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager.Foundations;
using Azure.Core;
using Azure.ResourceManager;
using TypeSpec.Versioning;
@armProviderNamespace
@service({
  title: "CdnManagementClient",
})
@versioned(Versions)
@doc("Cdn Management Client")
namespace Microsoft.Cdn;

@doc("The available API versions.")
enum Versions {
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @useDependency(Azure.Core.Versions.v1_0_Preview_1)
  @doc("The 2021-06-01 API version.")
  v2021_06_01: "2021-06-01",
}

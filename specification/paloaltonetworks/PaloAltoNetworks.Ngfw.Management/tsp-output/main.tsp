import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./models.tsp";
import "./GlobalRulestack.tsp";
import "./GlobalRulestackCertificateObject.tsp";
import "./GlobalRulestackFqdn.tsp";
import "./PostRulestackRule.tsp";
import "./GlobalRulestackPrefix.tsp";
import "./PreRulestackRule.tsp";
import "./PaloAltoNetworksFirewall.tsp";
import "./LocalRulestack.tsp";
import "./PaloAltoNetworksFirewallStatus.tsp";
import "./LocalRulestackCertificateObject.tsp";
import "./LocalRulestackFqdn.tsp";
import "./LocalRulestackRule.tsp";
import "./LocalRulestackPrefix.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager.Foundations;
using Azure.Core;
using Azure.ResourceManager;
using TypeSpec.Versioning;
@armProviderNamespace
@service({
  title: "PaloAltoNetworks.Cloudngfw",
})
@versioned(Versions)
@doc("// FIXME: (miissing-service-description) Add service description")
namespace Azure.ResourceManager.PaloAltoNetworks.Ngfw;

@doc("The available API versions.")
enum Versions {
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @useDependency(Azure.Core.Versions.v1_0_Preview_1)
  v2023_09_01: "2023-09-01",
}

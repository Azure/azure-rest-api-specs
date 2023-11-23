import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./models.tsp";
import "./GlobalRulestackResource.tsp";
import "./CertificateObjectGlobalRulestackResource.tsp";
import "./FqdnListGlobalRulestackResource.tsp";
import "./PostRulesResource.tsp";
import "./PrefixListGlobalRulestackResource.tsp";
import "./PreRulesResource.tsp";
import "./FirewallResource.tsp";
import "./LocalRulestackResource.tsp";
import "./FirewallStatusResource.tsp";
import "./CertificateObjectLocalRulestackResource.tsp";
import "./FqdnListLocalRulestackResource.tsp";
import "./LocalRulesResource.tsp";
import "./PrefixListResource.tsp";

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
namespace PaloAltoNetworks.Cloudngfw;

@doc("The available API versions.")
enum Versions {
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @useDependency(Azure.Core.Versions.v1_0_Preview_1)
  v2023_09_01: "2023-09-01",
}

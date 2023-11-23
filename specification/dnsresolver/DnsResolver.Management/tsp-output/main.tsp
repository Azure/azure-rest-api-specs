import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./models.tsp";
import "./DnsResolver.tsp";
import "./InboundEndpoint.tsp";
import "./OutboundEndpoint.tsp";
import "./DnsForwardingRuleset.tsp";
import "./ForwardingRule.tsp";
import "./VirtualNetworkLink.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager.Foundations;
using Azure.Core;
using Azure.ResourceManager;
using TypeSpec.Versioning;
@armProviderNamespace
@service({
  title: "DnsResolverManagementClient",
})
@versioned(Versions)
@doc("The DNS Resolver Management Client.")
namespace Microsoft.Network;

@doc("The available API versions.")
enum Versions {
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @useDependency(Azure.Core.Versions.v1_0_Preview_1)
  v2022_07_01: "2022-07-01",
}

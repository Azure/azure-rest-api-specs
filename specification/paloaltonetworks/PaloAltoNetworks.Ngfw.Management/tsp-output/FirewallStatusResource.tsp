import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./FirewallResource.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace PaloAltoNetworks.Cloudngfw;
@doc("Firewall Status")
@parentResource(FirewallResource)
@singleton("default")
model FirewallStatusResource is ProxyResource<FirewallStatusProperty> {
  @key("default")
  @segment("statuses")
  name: string;
}

@armResourceOperations
interface FirewallStatusResources {
  @doc("Get a FirewallStatusResource")
  get is ArmResourceRead<FirewallStatusResource>;
  @doc("List FirewallStatusResource resources by Firewalls")
  listByFirewall is ArmResourceListByParent<FirewallStatusResource>;
}

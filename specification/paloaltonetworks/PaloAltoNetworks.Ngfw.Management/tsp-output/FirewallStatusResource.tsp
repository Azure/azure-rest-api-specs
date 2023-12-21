import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./FirewallResource.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.PaloAltoNetworks.Ngfw;
@doc("Firewall Status")
@singleton("default")
@parentResource(FirewallResource)
model FirewallStatusResource is ProxyResource<FirewallStatusProperty> {
  @key("default")
  @segment("statuses")
  name: string;
}

@armResourceOperations
interface FirewallStatus {
  @doc("Get a FirewallStatusResource")
  get is ArmResourceRead<FirewallStatusResource>;
  @doc("List FirewallStatusResource resources by Firewalls")
  listByFirewalls is ArmResourceListByParent<FirewallStatusResource>;
}

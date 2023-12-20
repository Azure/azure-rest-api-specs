import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./PaloAltoNetworksFirewall.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.PaloAltoNetworks.Ngfw;
@doc("Firewall Status")
@parentResource(PaloAltoNetworksFirewall)
@singleton("default")
model PaloAltoNetworksFirewallStatus is ProxyResource<FirewallStatusProperty> {
  @key("default")
  @segment("statuses")
  name: string;
}

@armResourceOperations
interface PaloAltoNetworksFirewallStatuses {
  @doc("Get a FirewallStatusResource")
  get is ArmResourceRead<PaloAltoNetworksFirewallStatus>;
  @doc("List FirewallStatusResource resources by Firewalls")
  listByPaloAltoNetworksFirewall is ArmResourceListByParent<PaloAltoNetworksFirewallStatus>;
}

import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./Server.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.Sql;
@doc("An Azure SQL DB Server Outbound Firewall Rule.")
@parentResource(Server)
model OutboundFirewallRule is ProxyResource<OutboundFirewallRuleProperties> {
  @key("outboundRuleFqdn")
  @segment("outboundFirewallRules")
  name: string;
}

@armResourceOperations
interface OutboundFirewallRules {
  @doc("Gets an outbound firewall rule.")
  get is ArmResourceRead<OutboundFirewallRule>;
  @doc("Create a outbound firewall rule with a given name.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<OutboundFirewallRule>;
  @doc("Deletes a outbound firewall rule with a given name.")
  delete is ArmResourceDeleteAsync<OutboundFirewallRule>;
  @doc("Gets all outbound firewall rules on a server.")
  listByServer is ArmResourceListByParent<OutboundFirewallRule>;
}

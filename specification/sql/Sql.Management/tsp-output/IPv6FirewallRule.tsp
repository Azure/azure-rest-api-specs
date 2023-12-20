import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./SqlServer.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.Sql;
@doc("An IPv6 server firewall rule.")
@parentResource(SqlServer)
model IPv6FirewallRule is ProxyResource<IPv6ServerFirewallRuleProperties> {
  @doc("The name of the firewall rule.")
  @path
  @key("firewallRuleName")
  @segment("ipv6FirewallRules")
  name: string;
}

@armResourceOperations
interface IPv6FirewallRules {
  @doc("Gets an IPv6 firewall rule.")
  get is ArmResourceRead<IPv6FirewallRule>;
  @doc("Creates or updates an IPv6 firewall rule.")
  createOrUpdate is ArmResourceCreateOrReplaceSync<IPv6FirewallRule>;
  @doc("Deletes an IPv6 firewall rule.")
  delete is ArmResourceDeleteSync<IPv6FirewallRule>;
  @doc("Gets a list of IPv6 firewall rules.")
  listByServer is ArmResourceListByParent<IPv6FirewallRule>;
}

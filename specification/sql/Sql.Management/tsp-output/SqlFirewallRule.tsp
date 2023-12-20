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
@doc("A server firewall rule.")
@parentResource(SqlServer)
model SqlFirewallRule is ProxyResource<ServerFirewallRuleProperties> {
  @doc("The name of the firewall rule.")
  @path
  @key("firewallRuleName")
  @segment("firewallRules")
  name: string;
}

@armResourceOperations
interface SqlFirewallRules {
  @doc("Gets a firewall rule.")
  get is ArmResourceRead<SqlFirewallRule>;
  @doc("Creates or updates a firewall rule.")
  createOrUpdate is ArmResourceCreateOrReplaceSync<SqlFirewallRule>;
  @doc("Deletes a firewall rule.")
  delete is ArmResourceDeleteSync<SqlFirewallRule>;
  @doc("Gets a list of firewall rules.")
  listByServer is ArmResourceListByParent<SqlFirewallRule>;
}

import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./MongoCluster.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Microsoft.DocumentDB;
@doc("Represents a mongo cluster firewall rule.")
@parentResource(MongoCluster)
model FirewallRule is ProxyResource<FirewallRuleProperties> {
  @doc("The name of the mongo cluster firewall rule.")
  @maxLength(80)
  @minLength(1)
  @pattern("^[a-zA-Z0-9][-_.a-zA-Z0-9]*")
  @path
  @key("firewallRuleName")
  @segment("firewallRules")
  name: string;
}

@armResourceOperations
interface FirewallRules {
  @doc("Gets information about a mongo cluster firewall rule.")
  getFirewallRule is ArmResourceRead<FirewallRule>;
  @doc("Creates a new firewall rule or updates an existing firewall rule on a mongo cluster.")
  createOrUpdateFirewallRule is ArmResourceCreateOrUpdateAsync<FirewallRule>;
  @doc("Deletes a mongo cluster firewall rule.")
  deleteFirewallRule is ArmResourceDeleteWithoutOkAsync<FirewallRule>;
  @doc("List all the firewall rules in a given mongo cluster.")
  listFirewallRules is ArmResourceListByParent<FirewallRule>;
}

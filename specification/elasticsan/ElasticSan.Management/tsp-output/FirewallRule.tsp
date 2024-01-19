import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Server.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Sql;
@doc("A server firewall rule.")
@parentResource(Server)
model FirewallRule is ProxyResource<ServerFirewallRuleProperties> {
  @doc("The name of the firewall rule.")
  @path
  @key("firewallRuleName")
  @segment("firewallRules")
  name: string;
}

@armResourceOperations
interface FirewallRules {
  @doc("Gets a firewall rule.")
  get is ArmResourceRead<FirewallRule>;

  @doc("Creates or updates a firewall rule.")
  createOrUpdate is ArmResourceCreateOrReplaceSync<FirewallRule>;

  @doc("Deletes a firewall rule.")
  delete is ArmResourceDeleteSync<FirewallRule>;

  @doc("Gets a list of firewall rules.")
  listByServer is ArmResourceListByParent<FirewallRule>;
}

@@projectedName(FirewallRules.createOrUpdate::parameters.resource,
  "json",
  "parameters"
);
@@extension(FirewallRules.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "parameters"
);
@@doc(FirewallRules.createOrUpdate::parameters.resource,
  "The required parameters for creating or updating a firewall rule."
);

import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Server.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Sql;
/**
 * A server firewall rule.
 */
@parentResource(Server)
model FirewallRule
  is Azure.ResourceManager.ProxyResource<ServerFirewallRuleProperties> {
  ...ResourceNameParameter<
    Resource = FirewallRule,
    KeyName = "firewallRuleName",
    SegmentName = "firewallRules",
    NamePattern = ""
  >;
}

@armResourceOperations
interface FirewallRules {
  /**
   * Gets a firewall rule.
   */
  get is ArmResourceRead<FirewallRule>;

  /**
   * Creates or updates a firewall rule.
   */
  createOrUpdate is ArmResourceCreateOrReplaceSync<FirewallRule>;

  /**
   * Deletes a firewall rule.
   */
  delete is ArmResourceDeleteSync<FirewallRule>;

  /**
   * Gets a list of firewall rules.
   */
  listByServer is ArmResourceListByParent<FirewallRule>;
}

@@doc(FirewallRule.name, "The name of the firewall rule.");
@@doc(FirewallRule.properties, "Resource properties.");
@@doc(FirewallRules.createOrUpdate::parameters.resource,
  "The required parameters for creating or updating a firewall rule."
);

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
 * An IPv6 server firewall rule.
 */
@parentResource(Server)
model IPv6FirewallRule
  is Azure.ResourceManager.ProxyResource<IPv6ServerFirewallRuleProperties> {
  ...ResourceNameParameter<
    Resource = IPv6FirewallRule,
    KeyName = "firewallRuleName",
    SegmentName = "ipv6FirewallRules",
    NamePattern = ""
  >;
}

@armResourceOperations
interface IPv6FirewallRules {
  /**
   * Gets an IPv6 firewall rule.
   */
  get is ArmResourceRead<IPv6FirewallRule>;

  /**
   * Creates or updates an IPv6 firewall rule.
   */
  createOrUpdate is ArmResourceCreateOrReplaceSync<IPv6FirewallRule>;

  /**
   * Deletes an IPv6 firewall rule.
   */
  delete is ArmResourceDeleteSync<IPv6FirewallRule>;

  /**
   * Gets a list of IPv6 firewall rules.
   */
  listByServer is ArmResourceListByParent<IPv6FirewallRule>;
}

@@doc(IPv6FirewallRule.name, "The name of the firewall rule.");
@@doc(IPv6FirewallRule.properties, "Resource properties.");
@@doc(IPv6FirewallRules.createOrUpdate::parameters.resource,
  "The required parameters for creating or updating an IPv6 firewall rule."
);

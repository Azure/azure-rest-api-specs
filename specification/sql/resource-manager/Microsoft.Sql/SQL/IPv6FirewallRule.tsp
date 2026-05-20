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
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-custom-resource-usage-discourage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-custom-resource-no-key" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@parentResource(Server)
model IPv6FirewallRule extends ProxyResourceWithWritableName {
  /**
   * The properties of the IPv6 firewall rule.
   */
  properties?: IPv6ServerFirewallRuleProperties;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@armResourceOperations
interface IPv6FirewallRules {
  /**
   * Gets an IPv6 firewall rule.
   */
  get is ArmResourceRead<
    IPv6FirewallRule,
    Parameters = {
      /**
       * The name of the firewall rule.
       */
      @segment("ipv6FirewallRules")
      @path
      firewallRuleName: string;
    }
  >;

  /**
   * Creates or updates an IPv6 firewall rule.
   */
  createOrUpdate is ArmResourceCreateOrReplaceSync<
    IPv6FirewallRule,
    Parameters = {
      /**
       * The name of the firewall rule.
       */
      @segment("ipv6FirewallRules")
      @path
      @key
      firewallRuleName: string;
    }
  >;

  /**
   * Deletes an IPv6 firewall rule.
   */
  delete is ArmResourceDeleteSync<
    IPv6FirewallRule,
    Parameters = {
      /**
       * The name of the firewall rule.
       */
      @segment("ipv6FirewallRules")
      @path
      firewallRuleName: string;
    }
  >;

  /**
   * Gets a list of IPv6 firewall rules.
   */
  @action("ipv6FirewallRules")
  listByServer is ArmResourceListByParent<IPv6FirewallRule>;
}

@@doc(IPv6FirewallRule.properties, "Resource properties.");
@@doc(IPv6FirewallRules.createOrUpdate::parameters.resource,
  "The required parameters for creating or updating an IPv6 firewall rule."
);

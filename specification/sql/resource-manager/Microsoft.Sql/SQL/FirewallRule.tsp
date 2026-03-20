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
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-custom-resource-usage-discourage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-custom-resource-no-key" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@parentResource(Server)
model FirewallRule extends ProxyResourceWithWritableName {
  /**
   * Resource properties.
   */
  properties?: ServerFirewallRuleProperties;
}

@armResourceOperations
interface FirewallRules {
  /**
   * Gets a firewall rule.
   */
  get is ArmResourceRead<
    FirewallRule,
    Parameters = {
      /**
       * The name of the firewall rule.
       */
      @segment("firewallRules")
      @path
      firewallRuleName: string;
    }
  >;

  /**
   * Creates or updates a firewall rule.
   */
  createOrUpdate is ArmResourceCreateOrReplaceSync<
    FirewallRule,
    Parameters = {
      /**
       * The name of the firewall rule.
       */
      @segment("firewallRules")
      @path
      firewallRuleName: string;
    }
  >;

  /**
   * Deletes a firewall rule.
   */
  delete is ArmResourceDeleteSync<
    FirewallRule,
    Parameters = {
      /**
       * The name of the firewall rule.
       */
      @segment("firewallRules")
      @path
      firewallRuleName: string;
    }
  >;

  /**
   * Gets a list of firewall rules.
   */
  @action("firewallRules")
  listByServer is ArmResourceListByParent<FirewallRule>;
}

@@doc(FirewallRule.properties, "Resource properties.");
@@doc(FirewallRules.createOrUpdate::parameters.resource,
  "The required parameters for creating or updating a firewall rule."
);

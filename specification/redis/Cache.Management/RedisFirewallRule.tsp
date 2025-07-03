import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;

namespace Microsoft.Cache;
/**
 * A firewall rule on a redis cache has a name, and describes a contiguous range of IP addresses permitted to connect
 */
@parentResource(RedisResource)
model RedisFirewallRule
  is Azure.ResourceManager.ProxyResource<RedisFirewallRuleProperties, false> {
  ...ResourceNameParameter<
    Resource = RedisFirewallRule,
    KeyName = "ruleName",
    SegmentName = "firewallRules",
    NamePattern = ""
  >;
}

@armResourceOperations
interface RedisFirewallRules {
  /**
   * Gets a single firewall rule in a specified redis cache.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  get is ArmResourceRead<RedisFirewallRule>;

  /**
   * Create or update a redis cache firewall rule
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  createOrUpdate is ArmResourceCreateOrReplaceSync<RedisFirewallRule>;

  /**
   * Deletes a single firewall rule in a specified redis cache.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  delete is ArmResourceDeleteSync<RedisFirewallRule>;

  /**
   * Gets all firewall rules in the specified redis cache.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  list is ArmResourceListByParent<RedisFirewallRule>;
}

@@doc(RedisFirewallRule.name, "The name of the firewall rule.");
@@doc(RedisFirewallRule.properties, "redis cache firewall rule properties");
@@doc(RedisFirewallRules.createOrUpdate::parameters.resource,
  "Parameters supplied to the create or update redis firewall rule operation."
);

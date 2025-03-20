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
/**
 * An IPv6 server firewall rule.
 */
@parentResource(Server)
model IPv6FirewallRule is ProxyResource<IPv6ServerFirewallRuleProperties> {
  /**
   * The name of the firewall rule.
   */
  @path
  @key("firewallRuleName")
  @segment("ipv6FirewallRules")
  name: string;
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
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("IPv6FirewallRules_ListByServer")
  listByServer is ArmResourceListByParent<IPv6FirewallRule>;
}

@@projectedName(IPv6FirewallRules.createOrUpdate::parameters.resource,
  "json",
  "parameters"
);
@@extension(IPv6FirewallRules.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "parameters"
);
@@doc(IPv6FirewallRules.createOrUpdate::parameters.resource,
  "The required parameters for creating or updating an IPv6 firewall rule."
);

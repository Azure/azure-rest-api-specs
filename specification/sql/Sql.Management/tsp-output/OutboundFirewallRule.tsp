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
 * An Azure SQL DB Server Outbound Firewall Rule.
 */
@parentResource(Server)
model OutboundFirewallRule is ProxyResource<OutboundFirewallRuleProperties> {
  @path
  @key("outboundRuleFqdn")
  @segment("outboundFirewallRules")
  name: string;
}

@armResourceOperations
interface OutboundFirewallRules {
  /**
   * Gets an outbound firewall rule.
   */
  get is ArmResourceRead<OutboundFirewallRule>;

  /**
   * Create a outbound firewall rule with a given name.
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<OutboundFirewallRule>;

  /**
   * Deletes a outbound firewall rule with a given name.
   */
  delete is ArmResourceDeleteAsync<OutboundFirewallRule>;

  /**
   * Gets all outbound firewall rules on a server.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("OutboundFirewallRules_ListByServer")
  listByServer is ArmResourceListByParent<OutboundFirewallRule>;
}

@@projectedName(OutboundFirewallRules.createOrUpdate::parameters.resource,
  "json",
  "parameters"
);
@@extension(OutboundFirewallRules.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "parameters"
);
@@doc(OutboundFirewallRules.createOrUpdate::parameters.resource, "");

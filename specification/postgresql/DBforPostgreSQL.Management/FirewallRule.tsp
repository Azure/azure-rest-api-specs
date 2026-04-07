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

namespace Microsoft.DBforPostgreSQL;
/**
 * Firewall rule.
 */
@parentResource(Server)
model FirewallRule
  is Azure.ResourceManager.ProxyResource<FirewallRuleProperties, false> {
  ...ResourceNameParameter<
    Resource = FirewallRule,
    KeyName = "firewallRuleName",
    SegmentName = "firewallRules",
    NamePattern = "^[a-zA-Z0-9][-_a-zA-Z0-9]{0,79}(?<!-)$"
  >;
}

@armResourceOperations
interface FirewallRules {
  /**
   * Gets information about a firewall rule in a server.
   */
  get is ArmResourceRead<FirewallRule>;

  /**
   * Creates a new firewall rule or updates an existing firewall rule.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @Azure.Core.useFinalStateVia("azure-async-operation")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    FirewallRule,
    Response = ArmAcceptedLroResponse<LroHeaders = ArmCombinedLroHeaders<FinalResult = FirewallRule> &
      Azure.Core.Foundations.RetryAfterHeader>
  >;

  /**
   * Deletes an existing firewall rule.
   */
  delete is ArmResourceDeleteWithoutOkAsync<
    FirewallRule,
    Response = ArmDeleteAcceptedLroResponse<LroHeaders = ArmCombinedLroHeaders &
      Azure.Core.Foundations.RetryAfterHeader> | ArmDeletedNoContentResponse
  >;

  /**
   * Lists information about all firewall rules in a server.
   */
  listByServer is ArmResourceListByParent<
    FirewallRule,
    Response = ArmResponse<FirewallRuleList>
  >;
}

@@maxLength(FirewallRule.name, 80);
@@minLength(FirewallRule.name, 1);
@@doc(FirewallRule.name, "Name of the firewall rule.");
@@doc(FirewallRule.properties, "Properties of a firewall rule.");
@@doc(FirewallRules.createOrUpdate::parameters.resource,
  "Parameters required for creating or updating a firewall rule."
);

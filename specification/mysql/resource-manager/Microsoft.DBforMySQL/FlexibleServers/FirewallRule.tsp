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

namespace Microsoft.DBforMySQL;
/**
 * Represents a server firewall rule.
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
   * Gets information about a server firewall rule.
   */
  get is ArmResourceRead<FirewallRule>;

  /**
   * Creates a new firewall rule or updates an existing firewall rule.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    FirewallRule,
    Response = ArmResourceUpdatedResponse<FirewallRule> | ArmResourceCreatedResponse<
      FirewallRule,
      ArmLroLocationHeader<FinalResult = FirewallRule> &
        Azure.Core.Foundations.RetryAfterHeader
    > | ArmAcceptedLroResponse
  >;

  /**
   * Deletes a firewall rule.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  delete is ArmResourceDeleteWithoutOkAsync<
    FirewallRule,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse
  >;

  /**
   * List all the firewall rules in a given server.
   */
  listByServer is ArmResourceListByParent<
    FirewallRule,
    Response = ArmResponse<FirewallRuleListResult>
  >;
}

@@doc(FirewallRule.name, "The name of the server firewall rule.");
@@doc(FirewallRule.properties, "The properties of a firewall rule.");
@@doc(FirewallRules.createOrUpdate::parameters.resource,
  "The required parameters for creating or updating a firewall rule."
);

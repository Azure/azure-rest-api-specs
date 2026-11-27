import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./shared.tsp";
import "./Server.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

using TypeSpec.Versioning;

using Azure.Core;

namespace Microsoft.DBforPostgreSQL;

/**
 * Properties of a firewall rule.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model FirewallRuleProperties {
  /**
   * IP address defining the start of the range of addresses of a firewall rule. Must be expressed in IPv4 format.
   */
  @pattern("^(([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])\\.){3}([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])$")
  startIpAddress: string;

  /**
   * IP address defining the end of the range of addresses of a firewall rule. Must be expressed in IPv4 format.
   */
  @pattern("^(([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])\\.){3}([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])$")
  endIpAddress: string;
}

/**
 * List of firewall rules.
 */
model FirewallRuleList is Azure.Core.Page<FirewallRule>;

/**
 * Firewall rule.
 */
@parentResource(Server)
model FirewallRule is Azure.ResourceManager.ProxyResource<
  FirewallRuleProperties,
  false
> {
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
    Response =
      | ArmDeleteAcceptedLroResponse<LroHeaders = ArmCombinedLroHeaders &
          Azure.Core.Foundations.RetryAfterHeader>
      | ArmDeletedNoContentResponse
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
@@doc(
  FirewallRules.createOrUpdate::parameters.resource,
  "Parameters required for creating or updating a firewall rule."
);

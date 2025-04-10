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
 * Represents a server firewall rule.
 */
@parentResource(Server)
model FirewallRule
  is Azure.ResourceManager.ProxyResource<FirewallRuleProperties, false> {
  ...ResourceNameParameter<
    Resource = FirewallRule,
    KeyName = "firewallRuleName",
    SegmentName = "firewallRules",
    NamePattern = "^[-\\w\\._]+$"
  >;
}

@armResourceOperations
interface FirewallRules {
  /**
   * List all the firewall rules in a given server.
   */
  get is ArmResourceRead<FirewallRule>;

  /**
   * Creates a new firewall rule or updates an existing firewall rule.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "For backward compatibility"
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    FirewallRule,
    Response = ArmResourceUpdatedResponse<FirewallRule> | ArmResourceCreatedResponse<FirewallRule> | ArmAcceptedLroResponse
  >;

  /**
   * Deletes a PostgreSQL server firewall rule.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  delete is ArmResourceDeleteWithoutOkAsync<
    FirewallRule,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse
  >;

  /**
   * List all the firewall rules in a given PostgreSQL server.
   */
  listByServer is ArmResourceListByParent<FirewallRule>;
}

@@minLength(FirewallRule.name, 1);
@@doc(FirewallRule.name, "The name of the server firewall rule.");
@@doc(FirewallRule.properties, "The properties of a firewall rule.");
@@doc(FirewallRules.createOrUpdate::parameters.resource,
  "The required parameters for creating or updating a firewall rule."
);

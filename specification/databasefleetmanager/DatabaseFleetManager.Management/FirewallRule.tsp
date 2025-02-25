import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Fleetspace.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using TypeSpec.Versioning;

namespace Microsoft.DatabaseFleetManager;
/**
 * A firewall rule.
 */
@parentResource(Fleetspace)
model FirewallRule
  is Azure.ResourceManager.ProxyResource<FirewallRuleProperties> {
  ...ResourceNameParameter<
    Resource = FirewallRule,
    KeyName = "firewallRuleName",
    SegmentName = "firewallRules",
    NamePattern = "^.+$"
  >;
}

@armResourceOperations
interface FirewallRules {
  /**
   * Gets a firewall rule.
   */
  get is ArmResourceRead<FirewallRule>;

  /**
   * Creates or updates a firewall rule.
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<FirewallRule>;

  /**
   * Deletes a firewall rule.
   */
  delete is ArmResourceDeleteWithoutOkAsync<FirewallRule>;

  /**
   * Gets all firewall rules in a fleetspace.
   */
  listByFleetspace is ArmResourceListByParent<
    FirewallRule,
    Parameters = {
      /**
       * The number of elements in the collection to skip.
       */
      @query("$skip")
      $skip?: int64;

      /**
       * The number of elements to return from the collection.
       */
      @query("$top")
      $top?: int64;

      /**
       * An opaque token that identifies a starting point in the collection.
       */
      @query("$skiptoken")
      $skiptoken?: string;
    }
  >;
}

@@doc(FirewallRule.name, "Name of the firewall rule.");
@@doc(FirewallRule.properties, "A Firewall rule properties.");
@@doc(FirewallRules.createOrUpdate::parameters.resource,
  "The firewall rule object to create or update."
);

import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./DataLakeStoreAccount.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.DataLakeStore;
/**
 * Data Lake Store firewall rule information.
 */
@parentResource(DataLakeStoreAccount)
model FirewallRule
  is Azure.ResourceManager.ProxyResource<FirewallRuleProperties> {
  ...ResourceNameParameter<
    Resource = FirewallRule,
    KeyName = "firewallRuleName",
    SegmentName = "firewallRules",
    NamePattern = ""
  >;
}

@armResourceOperations
interface FirewallRules {
  /**
   * Gets the specified Data Lake Store firewall rule.
   */
  get is ArmResourceRead<FirewallRule>;

  /**
   * Creates or updates the specified firewall rule. During update, the firewall rule with the specified name will be replaced with this new firewall rule.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "For backward compatibility"
  createOrUpdate is ArmResourceCreateOrReplaceSync<
    FirewallRule,
    Response = ArmResourceUpdatedResponse<FirewallRule>
  >;

  /**
   * Updates the specified firewall rule.
   */
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchSync<
    FirewallRule,
    PatchModel = UpdateFirewallRuleParameters
  >;

  /**
   * Deletes the specified firewall rule from the specified Data Lake Store account.
   */
  delete is ArmResourceDeleteSync<FirewallRule>;

  /**
   * Lists the Data Lake Store firewall rules within the specified Data Lake Store account.
   */
  listByAccount is ArmResourceListByParent<FirewallRule>;
}

@@doc(FirewallRule.name, "The name of the firewall rule to retrieve.");
@@doc(FirewallRule.properties, "The firewall rule properties.");
@@doc(FirewallRules.createOrUpdate::parameters.resource,
  "Parameters supplied to create or update the firewall rule."
);
@@doc(FirewallRules.update::parameters.properties,
  "Parameters supplied to update the firewall rule."
);

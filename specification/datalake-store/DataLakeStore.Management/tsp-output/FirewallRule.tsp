import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./DataLakeStoreAccount.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.DataLakeStore;
/**
 * Data Lake Store firewall rule information.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@parentResource(DataLakeStoreAccount)
@includeInapplicableMetadataInPayload(false)
model FirewallRule extends SubResource {
  /**
   * The name of the firewall rule to retrieve.
   */
  @path
  @key("firewallRuleName")
  @segment("firewallRules")
  @visibility("read")
  name: string;

  /**
   * The firewall rule properties.
   */
  @extension("x-ms-client-flatten", true)
  properties?: FirewallRuleProperties;
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
  createOrUpdate is ArmResourceCreateOrReplaceSync<FirewallRule>;

  /**
   * Updates the specified firewall rule.
   */
  @parameterVisibility("read")
  update is ArmCustomPatchSync<FirewallRule, UpdateFirewallRuleParameters>;

  /**
   * Deletes the specified firewall rule from the specified Data Lake Store account.
   */
  delete is ArmResourceDeleteSync<FirewallRule>;

  /**
   * Lists the Data Lake Store firewall rules within the specified Data Lake Store account.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("FirewallRules_ListByAccount")
  listByAccount is ArmResourceListByParent<FirewallRule>;
}

@@projectedName(FirewallRules.createOrUpdate::parameters.resource,
  "json",
  "parameters"
);
@@extension(FirewallRules.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "parameters"
);
@@doc(FirewallRules.createOrUpdate::parameters.resource,
  "Parameters supplied to create or update the firewall rule."
);
@@projectedName(FirewallRules.update::parameters.properties,
  "json",
  "parameters"
);
@@extension(FirewallRules.update::parameters.properties,
  "x-ms-client-name",
  "parameters"
);
@@doc(FirewallRules.update::parameters.properties,
  "Parameters supplied to update the firewall rule."
);

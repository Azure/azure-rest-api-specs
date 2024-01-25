import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Database.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Sql;
/**
 * A database security alert policy.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@parentResource(Database)
@includeInapplicableMetadataInPayload(false)
model DatabaseSecurityAlertPolicy extends ProxyResource {
  /**
   * The name of the security alert policy.
   */
  @path
  @key("securityAlertPolicyName")
  @segment("securityAlertPolicies")
  @visibility("read")
  name: SecurityAlertPolicyName;

  /**
   * SystemData of SecurityAlertPolicyResource.
   */
  @visibility("read")
  systemData?: SystemData;

  /**
   * Resource properties.
   */
  @extension("x-ms-client-flatten", true)
  properties?: SecurityAlertsPolicyProperties;
}

@armResourceOperations
interface DatabaseSecurityAlertPolicies {
  /**
   * Gets a database's security alert policy.
   */
  get is ArmResourceRead<DatabaseSecurityAlertPolicy>;

  /**
   * Creates or updates a database's security alert policy.
   */
  createOrUpdate is ArmResourceCreateOrReplaceSync<DatabaseSecurityAlertPolicy>;

  /**
   * Gets a list of database's security alert policies.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("DatabaseSecurityAlertPolicies_ListByDatabase")
  listByDatabase is ArmResourceListByParent<DatabaseSecurityAlertPolicy>;
}

@@projectedName(DatabaseSecurityAlertPolicies.createOrUpdate::parameters.resource,
  "json",
  "parameters"
);
@@extension(DatabaseSecurityAlertPolicies.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "parameters"
);
@@doc(DatabaseSecurityAlertPolicies.createOrUpdate::parameters.resource,
  "The database security alert policy."
);

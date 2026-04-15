import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Database.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Sql;
/**
 * A database security alert policy.
 */
@parentResource(Database)
model DatabaseSecurityAlertPolicy
  is Azure.ResourceManager.ProxyResource<SecurityAlertsPolicyProperties> {
  ...ResourceNameParameter<
    Resource = DatabaseSecurityAlertPolicy,
    KeyName = "securityAlertPolicyName",
    SegmentName = "securityAlertPolicies",
    NamePattern = "",
    Type = SecurityAlertPolicyName
  >;
}

#suppress "@azure-tools/typespec-azure-resource-manager/no-resource-delete-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
  listByDatabase is ArmResourceListByParent<
    DatabaseSecurityAlertPolicy,
    Response = DatabaseSecurityAlertListResult
  >;
}

@@doc(DatabaseSecurityAlertPolicy.name,
  "The name of the security alert policy."
);
@@doc(DatabaseSecurityAlertPolicy.properties, "Resource properties.");
@@doc(DatabaseSecurityAlertPolicies.createOrUpdate::parameters.resource,
  "The database security alert policy."
);

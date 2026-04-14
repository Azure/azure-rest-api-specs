import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./ManagedDatabase.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Sql;
/**
 * A managed database security alert policy.
 */
@parentResource(ManagedDatabase)
model ManagedDatabaseSecurityAlertPolicy
  is Azure.ResourceManager.ProxyResource<SecurityAlertPolicyProperties> {
  ...ResourceNameParameter<
    Resource = ManagedDatabaseSecurityAlertPolicy,
    KeyName = "securityAlertPolicyName",
    SegmentName = "securityAlertPolicies",
    NamePattern = "",
    Type = SecurityAlertPolicyName
  >;
}

#suppress "@azure-tools/typespec-azure-resource-manager/no-resource-delete-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@armResourceOperations
interface ManagedDatabaseSecurityAlertPolicies {
  /**
   * Gets a managed database's security alert policy.
   */
  get is ArmResourceRead<ManagedDatabaseSecurityAlertPolicy>;

  /**
   * Creates or updates a database's security alert policy.
   */
  createOrUpdate is ArmResourceCreateOrReplaceSync<ManagedDatabaseSecurityAlertPolicy>;

  /**
   * Gets a list of managed database's security alert policies.
   */
  listByDatabase is ArmResourceListByParent<ManagedDatabaseSecurityAlertPolicy>;
}

@@doc(ManagedDatabaseSecurityAlertPolicy.name,
  "The name of the security alert policy."
);
@@doc(ManagedDatabaseSecurityAlertPolicy.properties, "Resource properties.");
@@doc(ManagedDatabaseSecurityAlertPolicies.createOrUpdate::parameters.resource,
  "The database security alert policy."
);

import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./ManagedDatabase.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Sql;
/**
 * A managed database security alert policy.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@parentResource(ManagedDatabase)
@Azure.ResourceManager.Private.armResourceInternal(
  SecurityAlertPolicyProperties
)
@includeInapplicableMetadataInPayload(false)
model ManagedDatabaseSecurityAlertPolicy extends ProxyResource {
  /**
   * The name of the security alert policy.
   */
  @path
  @key("securityAlertPolicyName")
  @segment("securityAlertPolicies")
  name: SecurityAlertPolicyName;

  /**
   * Resource properties.
   */
  @extension("x-ms-client-flatten", true)
  properties?: SecurityAlertPolicyProperties;
}

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
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("ManagedDatabaseSecurityAlertPolicies_ListByDatabase")
  listByDatabase is ArmResourceListByParent<ManagedDatabaseSecurityAlertPolicy>;
}

@@projectedName(ManagedDatabaseSecurityAlertPolicies.createOrUpdate::parameters.resource,
  "json",
  "parameters"
);
@@extension(ManagedDatabaseSecurityAlertPolicies.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "parameters"
);
@@doc(ManagedDatabaseSecurityAlertPolicies.createOrUpdate::parameters.resource,
  "The database security alert policy."
);

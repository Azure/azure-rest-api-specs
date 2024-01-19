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
@doc("A database security alert policy.")
@parentResource(Database)
model DatabaseSecurityAlertPolicy
  is ProxyResource<SecurityAlertsPolicyProperties> {
  @doc("The name of the security alert policy.")
  @path
  @key("securityAlertPolicyName")
  @segment("securityAlertPolicies")
  name: SecurityAlertPolicyName;
}

@armResourceOperations
interface DatabaseSecurityAlertPolicies {
  @doc("Gets a database's security alert policy.")
  get is ArmResourceRead<DatabaseSecurityAlertPolicy>;

  @doc("Creates or updates a database's security alert policy.")
  createOrUpdate is ArmResourceCreateOrReplaceSync<DatabaseSecurityAlertPolicy>;

  @doc("Gets a list of database's security alert policies.")
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

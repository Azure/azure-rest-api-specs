import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./ManagedDatabase.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.Sql;
@doc("A managed database security alert policy.")
@parentResource(ManagedDatabase)
model ManagedDatabaseSecurityAlertPolicy
  is ProxyResource<SecurityAlertPolicyProperties> {
  @doc("The name of the security alert policy.")
  @key("securityAlertPolicyName")
  @segment("securityAlertPolicies")
  name: SecurityAlertPolicyName;
}

@armResourceOperations
interface ManagedDatabaseSecurityAlertPolicies {
  @doc("Gets a managed database's security alert policy.")
  get is ArmResourceRead<ManagedDatabaseSecurityAlertPolicy>;
  @doc("Creates or updates a database's security alert policy.")
  createOrUpdate is ArmResourceCreateOrReplaceSync<ManagedDatabaseSecurityAlertPolicy>;
  @doc("Gets a list of managed database's security alert policies.")
  listByDatabase is ArmResourceListByParent<ManagedDatabaseSecurityAlertPolicy>;
}

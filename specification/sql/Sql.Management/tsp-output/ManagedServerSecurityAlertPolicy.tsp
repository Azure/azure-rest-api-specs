import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./ManagedInstance.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.Sql;
@doc("A managed server security alert policy.")
@parentResource(ManagedInstance)
model ManagedServerSecurityAlertPolicy
  is ProxyResource<SecurityAlertsPolicyProperties> {
  @doc("The name of the security alert policy.")
  @key("securityAlertPolicyName")
  @segment("securityAlertPolicies")
  name: SecurityAlertPolicyName;
}

@armResourceOperations
interface ManagedServerSecurityAlertPolicies {
  @doc("Get a managed server's threat detection policy.")
  get is ArmResourceRead<ManagedServerSecurityAlertPolicy>;
  @doc("Creates or updates a threat detection policy.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<ManagedServerSecurityAlertPolicy>;
  @doc("Get the managed server's threat detection policies.")
  listByInstance is ArmResourceListByParent<ManagedServerSecurityAlertPolicy>;
}

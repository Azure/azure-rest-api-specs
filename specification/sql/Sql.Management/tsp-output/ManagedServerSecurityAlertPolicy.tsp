import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./ManagedInstance.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Sql;
/**
 * A managed server security alert policy.
 */
@parentResource(ManagedInstance)
model ManagedServerSecurityAlertPolicy
  is ProxyResource<SecurityAlertsPolicyProperties> {
  /**
   * The name of the security alert policy.
   */
  @path
  @key("securityAlertPolicyName")
  @segment("securityAlertPolicies")
  name: SecurityAlertPolicyName;
}

@armResourceOperations
interface ManagedServerSecurityAlertPolicies {
  /**
   * Get a managed server's threat detection policy.
   */
  get is ArmResourceRead<ManagedServerSecurityAlertPolicy>;

  /**
   * Creates or updates a threat detection policy.
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<ManagedServerSecurityAlertPolicy>;

  /**
   * Get the managed server's threat detection policies.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("ManagedServerSecurityAlertPolicies_ListByInstance")
  listByInstance is ArmResourceListByParent<ManagedServerSecurityAlertPolicy>;
}

@@projectedName(ManagedServerSecurityAlertPolicies.createOrUpdate::parameters.resource,
  "json",
  "parameters"
);
@@extension(ManagedServerSecurityAlertPolicies.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "parameters"
);
@@doc(ManagedServerSecurityAlertPolicies.createOrUpdate::parameters.resource,
  "The managed server security alert policy."
);

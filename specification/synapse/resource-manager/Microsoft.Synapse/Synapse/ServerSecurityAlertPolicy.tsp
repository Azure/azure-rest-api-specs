import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Workspace.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Synapse;
/**
 * Workspace managed Sql server security alert policy.
 */
@parentResource(Workspace)
model ServerSecurityAlertPolicy
  is Azure.ResourceManager.ProxyResource<ServerSecurityAlertPolicyProperties> {
  ...ResourceNameParameter<
    Resource = ServerSecurityAlertPolicy,
    KeyName = "securityAlertPolicyName",
    SegmentName = "securityAlertPolicies",
    NamePattern = "",
    Type = SqlServerSecurityAlertPolicyName
  >;
}

@armResourceOperations
interface ServerSecurityAlertPolicies {
  /**
   * Get a workspace managed sql server's security alert policy.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("WorkspaceManagedSqlServerSecurityAlertPolicy_Get")
  get is ArmResourceRead<ServerSecurityAlertPolicy>;

  /**
   * Create or Update a workspace managed sql server's threat detection policy.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "For backward compatibility"
  @operationId("WorkspaceManagedSqlServerSecurityAlertPolicy_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    ServerSecurityAlertPolicy,
    Response =
      | ArmResourceUpdatedResponse<ServerSecurityAlertPolicy>
      | ArmAcceptedLroResponse,
    LroHeaders = ArmLroLocationHeader & Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Get workspace managed sql server's threat detection policies.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("WorkspaceManagedSqlServerSecurityAlertPolicy_List")
  list is ArmResourceListByParent<ServerSecurityAlertPolicy>;
}

@@doc(ServerSecurityAlertPolicy.name, "The name of the security alert policy.");
@@doc(ServerSecurityAlertPolicy.properties, "Resource properties.");
@@doc(
  ServerSecurityAlertPolicies.createOrUpdate::parameters.resource,
  "The workspace managed sql server security alert policy."
);

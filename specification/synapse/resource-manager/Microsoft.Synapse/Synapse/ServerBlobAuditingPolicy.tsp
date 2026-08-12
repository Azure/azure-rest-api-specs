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
 * A server blob auditing policy.
 */
@parentResource(Workspace)
model ServerBlobAuditingPolicy
  is Azure.ResourceManager.ProxyResource<ServerBlobAuditingPolicyProperties> {
  ...ResourceNameParameter<
    Resource = ServerBlobAuditingPolicy,
    KeyName = "blobAuditingPolicyName",
    SegmentName = "auditingSettings",
    NamePattern = "",
    Type = BlobAuditingPolicyName
  >;
}

@armResourceOperations
interface ServerBlobAuditingPolicies {
  /**
   * Get a workspace managed sql server's blob auditing policy.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("WorkspaceManagedSqlServerBlobAuditingPolicies_Get")
  get is ArmResourceRead<ServerBlobAuditingPolicy>;

  /**
   * Create or Update a workspace managed sql server's blob auditing policy.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "For backward compatibility"
  @operationId("WorkspaceManagedSqlServerBlobAuditingPolicies_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    ServerBlobAuditingPolicy,
    Response =
      | ArmResourceUpdatedResponse<ServerBlobAuditingPolicy>
      | ArmAcceptedLroResponse,
    LroHeaders = ArmLroLocationHeader & Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * List workspace managed sql server's blob auditing policies.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("WorkspaceManagedSqlServerBlobAuditingPolicies_ListByWorkspace")
  listByWorkspace is ArmResourceListByParent<ServerBlobAuditingPolicy>;
}

@@doc(ServerBlobAuditingPolicy.name, "The name of the blob auditing policy.");
@@doc(ServerBlobAuditingPolicy.properties, "Resource properties.");
@@doc(
  ServerBlobAuditingPolicies.createOrUpdate::parameters.resource,
  "Properties of extended blob auditing policy."
);

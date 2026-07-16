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
 * An extended server blob auditing policy.
 */
@parentResource(Workspace)
model ExtendedServerBlobAuditingPolicy
  is Azure.ResourceManager.ProxyResource<ExtendedServerBlobAuditingPolicyProperties> {
  ...ResourceNameParameter<
    Resource = ExtendedServerBlobAuditingPolicy,
    KeyName = "blobAuditingPolicyName",
    SegmentName = "extendedAuditingSettings",
    NamePattern = "",
    Type = BlobAuditingPolicyName
  >;
}

@armResourceOperations
interface ExtendedServerBlobAuditingPolicies {
  /**
   * Get a workspace SQL server's extended blob auditing policy.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("WorkspaceManagedSqlServerExtendedBlobAuditingPolicies_Get")
  get is ArmResourceRead<ExtendedServerBlobAuditingPolicy>;

  /**
   * Create or Update a workspace managed sql server's extended blob auditing policy.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "For backward compatibility"
  @operationId("WorkspaceManagedSqlServerExtendedBlobAuditingPolicies_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    ExtendedServerBlobAuditingPolicy,
    Response =
      | ArmResourceUpdatedResponse<ExtendedServerBlobAuditingPolicy>
      | ArmAcceptedLroResponse,
    LroHeaders = ArmLroLocationHeader & Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * List workspace managed sql server's extended blob auditing policies.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("WorkspaceManagedSqlServerExtendedBlobAuditingPolicies_ListByWorkspace")
  listByWorkspace is ArmResourceListByParent<ExtendedServerBlobAuditingPolicy>;
}

@@doc(
  ExtendedServerBlobAuditingPolicy.name,
  "The name of the blob auditing policy."
);
@@doc(ExtendedServerBlobAuditingPolicy.properties, "Resource properties.");
@@doc(
  ExtendedServerBlobAuditingPolicies.createOrUpdate::parameters.resource,
  "Properties of extended blob auditing policy."
);

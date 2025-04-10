import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.RecoveryServices;
/**
 * Protection profile details.
 */
model Policy is Azure.ResourceManager.ProxyResource<PolicyProperties> {
  ...ResourceNameParameter<
    Resource = Policy,
    KeyName = "policyName",
    SegmentName = "replicationPolicies",
    NamePattern = ""
  >;
}

@armResourceOperations
interface Policies {
  /**
   * Gets the details of a replication policy.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ReplicationPolicies_Get")
  get is ArmResourceRead<Policy>;

  /**
   * The operation to create a replication policy.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "For backward compatibility"
  @operationId("ReplicationPolicies_Create")
  create is ArmResourceCreateOrReplaceAsync<
    Policy,
    Response = ArmResourceUpdatedResponse<Policy> | ArmAcceptedLroResponse,
    LroHeaders = ArmLroLocationHeader & Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * The operation to update a replication policy.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @patch(#{ implicitOptionality: false })
  @operationId("ReplicationPolicies_Update")
  update is ArmCustomPatchAsync<Policy, PatchModel = UpdatePolicyInput>;

  /**
   * The operation to delete a replication policy.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ReplicationPolicies_Delete")
  delete is ArmResourceDeleteWithoutOkAsync<Policy>;

  /**
   * Lists the replication policies for a vault.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ReplicationPolicies_List")
  list is ArmResourceListByParent<
    Policy,
    Response = ArmResponse<PolicyCollection>
  >;
}

@@doc(Policy.name, "Replication policy name.");
@@doc(Policy.properties, "The custom data.");
@@doc(Policies.create::parameters.resource, "Create policy input.");
@@doc(Policies.update::parameters.properties, "Update Policy Input.");

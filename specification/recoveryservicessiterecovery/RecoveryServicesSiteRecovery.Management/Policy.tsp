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
@parentResource(Vault)
model Policy is Azure.ResourceManager.ProxyResource<PolicyProperties> {
  ...ResourceNameParameter<
    Resource = Policy,
    KeyName = "policyName",
    SegmentName = "replicationPolicies",
    NamePattern = ""
  >;

  /**
   * Resource Location
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  location?: string;
}

@armResourceOperations
interface Policies {
  /**
   * Gets the details of a replication policy.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @summary("Gets the requested policy.")
  get is ArmResourceRead<Policy, Error = never>;

  /**
   * The operation to create a replication policy.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @summary("Creates the policy.")
  create is Azure.ResourceManager.Legacy.CreateOrUpdateAsync<
    Policy,
    Request = CreatePolicyInput,
    Response = ArmResourceUpdatedResponse<Policy> | ArmAcceptedLroResponse<LroHeaders = ArmLroLocationHeader<FinalResult = Policy> &
      Azure.Core.Foundations.RetryAfterHeader>,
    Error = never
  >;

  /**
   * The operation to update a replication policy.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @patch(#{ implicitOptionality: false })
  @summary("Updates the policy.")
  update is ArmCustomPatchAsync<
    Policy,
    PatchModel = UpdatePolicyInput,
    Error = never
  >;

  /**
   * The operation to delete a replication policy.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @summary("Delete the policy.")
  delete is ArmResourceDeleteWithoutOkAsync<Policy, Error = never>;

  /**
   * Lists the replication policies for a vault.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @summary("Gets the list of replication policies.")
  list is ArmResourceListByParent<
    Policy,
    Response = ArmResponse<PolicyCollection>,
    Error = never
  >;
}

@@doc(Policy.name, "Replication policy name.");
@@doc(Policy.properties, "The custom data.");
@@doc(Policies.create::parameters.resource, "Create policy input.");
@@doc(Policies.update::parameters.properties, "Update Policy Input.");

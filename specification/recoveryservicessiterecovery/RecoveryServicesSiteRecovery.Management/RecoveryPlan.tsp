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
 * Recovery plan details.
 */
@parentResource(Vault)
model RecoveryPlan
  is Azure.ResourceManager.ProxyResource<RecoveryPlanProperties> {
  ...ResourceNameParameter<
    Resource = RecoveryPlan,
    KeyName = "recoveryPlanName",
    SegmentName = "replicationRecoveryPlans",
    NamePattern = ""
  >;

  /**
   * Resource Location
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  location?: string;
}

alias RecoveryPlanAcceptedLroResponse = ArmAcceptedLroResponse<LroHeaders = ArmLroLocationHeader<FinalResult = RecoveryPlan> &
  Azure.Core.Foundations.RetryAfterHeader>;

@armResourceOperations
interface RecoveryPlans {
  /**
   * Gets the details of the recovery plan.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @summary("Gets the requested recovery plan.")
  get is ArmResourceRead<RecoveryPlan, Error = never>;

  /**
   * The operation to create a recovery plan.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @summary("Creates a recovery plan with the given details.")
  create is Azure.ResourceManager.Legacy.CreateOrUpdateAsync<
    RecoveryPlan,
    Request = CreateRecoveryPlanInput,
    Response = ArmResourceUpdatedResponse<RecoveryPlan> | ArmAcceptedLroResponse<LroHeaders = ArmLroLocationHeader<FinalResult = RecoveryPlan> &
      Azure.Core.Foundations.RetryAfterHeader>,
    Error = never
  >;

  /**
   * The operation to update a recovery plan.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @patch(#{ implicitOptionality: false })
  @summary("Updates the given recovery plan.")
  update is ArmCustomPatchAsync<
    RecoveryPlan,
    PatchModel = UpdateRecoveryPlanInput,
    Error = never
  >;

  /**
   * Delete a recovery plan.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @summary("Deletes the specified recovery plan.")
  delete is ArmResourceDeleteWithoutOkAsync<RecoveryPlan, Error = never>;

  /**
   * Lists the recovery plans in the vault.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @summary("Gets the list of recovery plans.")
  list is ArmResourceListByParent<
    RecoveryPlan,
    Response = ArmResponse<RecoveryPlanCollection>,
    Error = never
  >;

  /**
   * The operation to cancel the failover of a recovery plan.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-post-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @summary("Execute cancel failover of the recovery plan.")
  failoverCancel is ArmResourceActionAsyncBase<
    RecoveryPlan,
    void,
    ArmResponse<RecoveryPlan> | RecoveryPlanAcceptedLroResponse,
    Azure.ResourceManager.Foundations.DefaultBaseParameters<RecoveryPlan>,
    Error = never
  >;

  /**
   * The operation to commit the failover of a recovery plan.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-post-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @summary("Execute commit failover of the recovery plan.")
  failoverCommit is ArmResourceActionAsyncBase<
    RecoveryPlan,
    void,
    ArmResponse<RecoveryPlan> | RecoveryPlanAcceptedLroResponse,
    Azure.ResourceManager.Foundations.DefaultBaseParameters<RecoveryPlan>,
    Error = never
  >;

  /**
   * The operation to start the planned failover of a recovery plan.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-post-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @summary("Execute planned failover of the recovery plan.")
  plannedFailover is ArmResourceActionAsyncBase<
    RecoveryPlan,
    RecoveryPlanPlannedFailoverInput,
    ArmResponse<RecoveryPlan> | RecoveryPlanAcceptedLroResponse,
    Azure.ResourceManager.Foundations.DefaultBaseParameters<RecoveryPlan>,
    Error = never
  >;

  /**
   * The operation to reprotect(reverse replicate) a recovery plan. This api is for deprecated scenarios and no longer works.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-post-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @action("reProtect")
  @summary("Execute reprotect of the recovery plan.")
  reprotect is ArmResourceActionAsyncBase<
    RecoveryPlan,
    void,
    ArmResponse<RecoveryPlan> | RecoveryPlanAcceptedLroResponse,
    Azure.ResourceManager.Foundations.DefaultBaseParameters<RecoveryPlan>,
    Error = never
  >;

  /**
   * The operation to start the test failover of a recovery plan.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-post-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @summary("Execute test failover of the recovery plan.")
  testFailover is ArmResourceActionAsyncBase<
    RecoveryPlan,
    RecoveryPlanTestFailoverInput,
    ArmResponse<RecoveryPlan> | RecoveryPlanAcceptedLroResponse,
    Azure.ResourceManager.Foundations.DefaultBaseParameters<RecoveryPlan>,
    Error = never
  >;

  /**
   * The operation to cleanup test failover of a recovery plan.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-post-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @summary("Execute test failover cleanup of the recovery plan.")
  testFailoverCleanup is ArmResourceActionAsyncBase<
    RecoveryPlan,
    RecoveryPlanTestFailoverCleanupInput,
    ArmResponse<RecoveryPlan> | RecoveryPlanAcceptedLroResponse,
    Azure.ResourceManager.Foundations.DefaultBaseParameters<RecoveryPlan>,
    Error = never
  >;

  /**
   * The operation to start the unplanned failover of a recovery plan.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-post-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @summary("Execute unplanned failover of the recovery plan.")
  unplannedFailover is ArmResourceActionAsyncBase<
    RecoveryPlan,
    RecoveryPlanUnplannedFailoverInput,
    ArmResponse<RecoveryPlan> | RecoveryPlanAcceptedLroResponse,
    Azure.ResourceManager.Foundations.DefaultBaseParameters<RecoveryPlan>,
    Error = never
  >;
}

@@doc(RecoveryPlan.name, "Name of the recovery plan.");
@@doc(RecoveryPlan.properties, "The custom details.");
@@doc(RecoveryPlans.create::parameters.resource,
  "Recovery Plan creation input."
);
@@doc(RecoveryPlans.update::parameters.properties,
  "Update recovery plan input."
);
@@doc(RecoveryPlans.plannedFailover::parameters.body, "Failover input.");
@@doc(RecoveryPlans.testFailover::parameters.body,
  "Recovery plan test failover input."
);
@@doc(RecoveryPlans.testFailoverCleanup::parameters.body,
  "Recovery plan test failover cleanup input."
);
@@doc(RecoveryPlans.unplannedFailover::parameters.body,
  "Recovery plan unplanned failover input."
);

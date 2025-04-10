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
model RecoveryPlan
  is Azure.ResourceManager.ProxyResource<RecoveryPlanProperties> {
  ...ResourceNameParameter<
    Resource = RecoveryPlan,
    KeyName = "recoveryPlanName",
    SegmentName = "replicationRecoveryPlans",
    NamePattern = ""
  >;
}

@armResourceOperations
interface RecoveryPlans {
  /**
   * Gets the details of the recovery plan.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ReplicationRecoveryPlans_Get")
  get is ArmResourceRead<RecoveryPlan>;

  /**
   * The operation to create a recovery plan.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "For backward compatibility"
  @operationId("ReplicationRecoveryPlans_Create")
  create is ArmResourceCreateOrReplaceAsync<
    RecoveryPlan,
    Response = ArmResourceUpdatedResponse<RecoveryPlan> | ArmAcceptedLroResponse,
    LroHeaders = ArmLroLocationHeader & Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * The operation to update a recovery plan.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @patch(#{ implicitOptionality: false })
  @operationId("ReplicationRecoveryPlans_Update")
  update is ArmCustomPatchAsync<
    RecoveryPlan,
    PatchModel = UpdateRecoveryPlanInput
  >;

  /**
   * Delete a recovery plan.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ReplicationRecoveryPlans_Delete")
  delete is ArmResourceDeleteWithoutOkAsync<RecoveryPlan>;

  /**
   * Lists the recovery plans in the vault.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ReplicationRecoveryPlans_List")
  list is ArmResourceListByParent<
    RecoveryPlan,
    Response = ArmResponse<RecoveryPlanCollection>
  >;

  /**
   * The operation to cancel the failover of a recovery plan.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ReplicationRecoveryPlans_FailoverCancel")
  failoverCancel is ArmResourceActionAsync<
    RecoveryPlan,
    void,
    ArmResponse<RecoveryPlan>
  >;

  /**
   * The operation to commit the failover of a recovery plan.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ReplicationRecoveryPlans_FailoverCommit")
  failoverCommit is ArmResourceActionAsync<
    RecoveryPlan,
    void,
    ArmResponse<RecoveryPlan>
  >;

  /**
   * The operation to start the planned failover of a recovery plan.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ReplicationRecoveryPlans_PlannedFailover")
  plannedFailover is ArmResourceActionAsync<
    RecoveryPlan,
    RecoveryPlanPlannedFailoverInput,
    ArmResponse<RecoveryPlan>
  >;

  /**
   * The operation to reprotect(reverse replicate) a recovery plan. This api is for deprecated scenarios and no longer works.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @action("reProtect")
  @operationId("ReplicationRecoveryPlans_Reprotect")
  reprotect is ArmResourceActionAsync<
    RecoveryPlan,
    void,
    ArmResponse<RecoveryPlan>
  >;

  /**
   * The operation to start the test failover of a recovery plan.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ReplicationRecoveryPlans_TestFailover")
  testFailover is ArmResourceActionAsync<
    RecoveryPlan,
    RecoveryPlanTestFailoverInput,
    ArmResponse<RecoveryPlan>
  >;

  /**
   * The operation to cleanup test failover of a recovery plan.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ReplicationRecoveryPlans_TestFailoverCleanup")
  testFailoverCleanup is ArmResourceActionAsync<
    RecoveryPlan,
    RecoveryPlanTestFailoverCleanupInput,
    ArmResponse<RecoveryPlan>
  >;

  /**
   * The operation to start the unplanned failover of a recovery plan.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ReplicationRecoveryPlans_UnplannedFailover")
  unplannedFailover is ArmResourceActionAsync<
    RecoveryPlan,
    RecoveryPlanUnplannedFailoverInput,
    ArmResponse<RecoveryPlan>
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

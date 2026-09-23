import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

import "./models/common/common.tsp";
import "./models/common/Job.tsp";
import "./models/common/JobResource.tsp";
import "./models/common/ChildJob.tsp";
import "./models/recoveryPlan/recoveryPlan.tsp";
import "./models/recoveryPlan/recoveryGroup.tsp";
import "./models/recoveryPlan/recoveryResource.tsp";
import "./models/recoveryPlan/recoveryActions.tsp";
import "./models/recoveryPlan/recoveryJob.tsp";
import "./models/recoveryPlan/recoveryChildJob.tsp";
import "./models/recoveryPlan/recoveryJobResource.tsp";
import "./main.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;
using Azure.Core;
using Azure.ResourceManager.CommonTypes;
using Azure.ResourceManager.Foundations;
using TypeSpec.OpenAPI;

@armProviderNamespace("Microsoft.AzureResilienceManagement")
namespace Microsoft.AzureResilienceManagement;

@armResourceOperations
@doc("Operations for managing Recovery Orchestration Plans.")
@removed(Versions.v2026_09_30_preview)
@renamedFrom(Versions.v2026_09_30_preview, "RecoveryPlans")
interface RecoveryPlansOld {
  #deprecated "API versions 2025-02-01-preview through 2026-08-31-preview are deprecated. Use 2026-09-30-preview or a later supported API version."
  @route(ServiceGroupRoute)
  @summary("Deprecated API version. Use 2026-09-30-preview or a later supported API version.")
  @sharedRoute
  get is ArmResourceRead<RecoveryPlan, ServiceGroupParameters>;

  #deprecated "API versions 2025-02-01-preview through 2026-08-31-preview are deprecated. Use 2026-09-30-preview or a later supported API version."
  @route(ServiceGroupRoute)
  @summary("Deprecated API version. Use 2026-09-30-preview or a later supported API version.")
  @sharedRoute
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    RecoveryPlan,
    ServiceGroupParameters
  >;

  #deprecated "API versions 2025-02-01-preview through 2026-08-31-preview are deprecated. Use 2026-09-30-preview or a later supported API version."
  @route(ServiceGroupRoute)
  @summary("Deprecated API version. Use 2026-09-30-preview or a later supported API version.")
  @sharedRoute
  update is ArmResourcePatchAsync<
    RecoveryPlan,
    RecoveryPlanProperties,
    ServiceGroupParameters
  >;

  #deprecated "API versions 2025-02-01-preview through 2026-08-31-preview are deprecated. Use 2026-09-30-preview or a later supported API version."
  @route(ServiceGroupRoute)
  @summary("Deprecated API version. Use 2026-09-30-preview or a later supported API version.")
  @sharedRoute
  delete is ArmResourceDeleteWithoutOkAsync<
    RecoveryPlan,
    ServiceGroupParameters
  >;

  #deprecated "API versions 2025-02-01-preview through 2026-08-31-preview are deprecated. Use 2026-09-30-preview or a later supported API version."
  @route(ServiceGroupRoute)
  @summary("Deprecated API version. Use 2026-09-30-preview or a later supported API version.")
  @sharedRoute
  list is ArmResourceListByParent<
    RecoveryPlan,
    ServiceGroupTenantParameters,
    Response = ArmResponse<RecoveryPlanListResult>
  >;
}

@armResourceOperations
@doc("Operations for managing Recovery Orchestration Plans.")
@added(Versions.v2026_09_30_preview)
interface RecoveryPlans {
  @route(ServiceGroupRoute)
  @sharedRoute
  get is ArmResourceRead<RecoveryPlan, ServiceGroupParameters>;

  @route(ServiceGroupRoute)
  @sharedRoute
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    RecoveryPlan,
    ServiceGroupParameters
  >;

  @route(ServiceGroupRoute)
  @sharedRoute
  update is ArmResourcePatchAsync<
    RecoveryPlan,
    RecoveryPlanProperties,
    ServiceGroupParameters
  >;

  @route(ServiceGroupRoute)
  @sharedRoute
  delete is ArmResourceDeleteWithoutOkAsync<
    RecoveryPlan,
    ServiceGroupParameters
  >;

  @route(ServiceGroupRoute)
  @sharedRoute
  list is ArmResourceListByParent<
    RecoveryPlan,
    ServiceGroupTenantParameters,
    Response = ArmResponse<RecoveryPlanListResult>
  >;
}

model RecoveryPlanListResult is ResourceListResult<RecoveryPlan>;
@@identifiers(RecoveryPlanListResult.value, #["id"]);

@armResourceOperations
@doc("Actions for managing Recovery Orchestration Plans.")
@removed(Versions.v2026_09_30_preview)
@renamedFrom(Versions.v2026_09_30_preview, "RecoveryPlanActions")
interface RecoveryPlanActionsOld {
  #deprecated "API versions 2025-02-01-preview through 2026-08-31-preview are deprecated. Use 2026-09-30-preview or a later supported API version."
  @route(ServiceGroupRoute)
  @post
  @doc("This action finalizes the recovery orchestration plan, ensuring all necessary configurations are in place.")
  @summary("Deprecated API version. Use 2026-09-30-preview or a later supported API version.")
  @sharedRoute
  finalize is ArmResourceActionAsync<
    RecoveryPlan,
    void,
    ArmResponse<Azure.ResourceManager.ErrorResponse>,
    ServiceGroupAndRequestHeadersParameters
  >;

  #deprecated "API versions 2025-02-01-preview through 2026-08-31-preview are deprecated. Use 2026-09-30-preview or a later supported API version."
  @route(ServiceGroupRoute)
  @post
  @doc("This action adds or updates the resources to be included in the recovery orchestration plan.")
  @summary("Deprecated API version. Use 2026-09-30-preview or a later supported API version.")
  @sharedRoute
  updateResources is ArmResourceActionAsync<
    RecoveryPlan,
    UpdateRecoveryResourcesRequest,
    UpdateRecoveryResourcesResponse,
    ServiceGroupAndRequestHeadersParameters
  >;

  #deprecated "API versions 2025-02-01-preview through 2026-08-31-preview are deprecated. Use 2026-09-30-preview or a later supported API version."
  @route(ServiceGroupRoute)
  @post
  @doc("This action checks if the recovery orchestration plan is eligible for operations like failover and reprotect, ensuring it meets the necessary criteria.")
  @summary("Deprecated API version. Use 2026-09-30-preview or a later supported API version.")
  @sharedRoute
  validateForOperation is ArmResourceActionAsync<
    RecoveryPlan,
    ValidateForOperationRequest,
    ArmResponse<Azure.ResourceManager.ErrorResponse>,
    ServiceGroupAndRequestHeadersParameters
  >;

  #deprecated "API versions 2025-02-01-preview through 2026-08-31-preview are deprecated. Use 2026-09-30-preview or a later supported API version."
  @route(ServiceGroupRoute)
  @post
  @doc("This action checks if the recovery orchestration plan is eligible for failover operation, ensuring it meets the necessary criteria and provides a list of qualified and unqualified resources.")
  @summary("Deprecated API version. Use 2026-09-30-preview or a later supported API version.")
  @sharedRoute
  validateForFailover is ArmResourceActionAsync<
    RecoveryPlan,
    FailoverRequest,
    ValidateForRecoveryOperationBaseResponse,
    ServiceGroupAndRequestHeadersParameters
  >;

  #deprecated "API versions 2025-02-01-preview through 2026-08-31-preview are deprecated. Use 2026-09-30-preview or a later supported API version."
  @route(ServiceGroupRoute)
  @post
  @doc("This action checks if the recovery orchestration plan is eligible for failover commit operation, ensuring it meets the necessary criteria and provides a list of qualified and unqualified resources.")
  @summary("Deprecated API version. Use 2026-09-30-preview or a later supported API version.")
  @sharedRoute
  validateForFailoverCommit is ArmResourceActionAsync<
    RecoveryPlan,
    void,
    ValidateForRecoveryOperationBaseResponse,
    ServiceGroupAndRequestHeadersParameters
  >;

  #deprecated "API versions 2025-02-01-preview through 2026-08-31-preview are deprecated. Use 2026-09-30-preview or a later supported API version."
  @route(ServiceGroupRoute)
  @post
  @doc("This action checks if the recovery orchestration plan is eligible for test failover operation, ensuring it meets the necessary criteria and provides a list of qualified and unqualified resources.")
  @summary("Deprecated API version. Use 2026-09-30-preview or a later supported API version.")
  @sharedRoute
  validateForTestFailover is ArmResourceActionAsync<
    RecoveryPlan,
    FailoverRequest,
    ValidateForRecoveryOperationBaseResponse,
    ServiceGroupAndRequestHeadersParameters
  >;

  #deprecated "API versions 2025-02-01-preview through 2026-08-31-preview are deprecated. Use 2026-09-30-preview or a later supported API version."
  @route(ServiceGroupRoute)
  @post
  @doc("This action checks if the recovery orchestration plan is eligible for test failover cleanup operation, ensuring it meets the necessary criteria and provides a list of qualified and unqualified resources.")
  @summary("Deprecated API version. Use 2026-09-30-preview or a later supported API version.")
  @sharedRoute
  validateForTestFailoverCleanup is ArmResourceActionAsync<
    RecoveryPlan,
    void,
    ValidateForRecoveryOperationBaseResponse,
    ServiceGroupAndRequestHeadersParameters
  >;

  #deprecated "API versions 2025-02-01-preview through 2026-08-31-preview are deprecated. Use 2026-09-30-preview or a later supported API version."
  @route(ServiceGroupRoute)
  @post
  @doc("This action checks if the recovery orchestration plan is eligible for reprotect operation, ensuring it meets the necessary criteria and provides a list of qualified and unqualified resources.")
  @removed(Versions.v2026_03_01_preview)
  @renamedFrom(Versions.v2026_03_01_preview, "validateForReprotect")
  @sharedRoute
  @summary("Deprecated API version. Use 2026-09-30-preview or a later supported API version.")
  validateForReprotectOld is ArmResourceActionAsync<
    RecoveryPlan,
    void,
    ValidateForRecoveryOperationBaseResponse,
    ServiceGroupAndRequestHeadersParameters
  >;

  #deprecated "API versions 2025-02-01-preview through 2026-08-31-preview are deprecated. Use 2026-09-30-preview or a later supported API version."
  @route(ServiceGroupRoute)
  @post
  @doc("This action checks if the recovery orchestration plan is eligible for reprotect operation, ensuring it meets the necessary criteria and provides a list of qualified and unqualified resources.")
  @added(Versions.v2026_03_01_preview)
  @sharedRoute
  @summary("Deprecated API version. Use 2026-09-30-preview or a later supported API version.")
  validateForReprotect is ArmResourceActionAsync<
    RecoveryPlan,
    ReprotectRequest,
    ValidateForRecoveryOperationBaseResponse,
    ServiceGroupAndRequestHeadersParameters,
    OptionalRequestBody = true
  >;

  #deprecated "API versions 2025-02-01-preview through 2026-08-31-preview are deprecated. Use 2026-09-30-preview or a later supported API version."
  @route(ServiceGroupRoute)
  @post
  @doc("This action performs the necessary readiness check on the recovery orchestration plan to ensure it is in the desired state and eligible for all recovery actions, including all protected resources.")
  @summary("Deprecated API version. Use 2026-09-30-preview or a later supported API version.")
  @sharedRoute
  checkReadiness is ArmResourceActionAsync<
    RecoveryPlan,
    void,
    RecoveryPlanActionBaseResponse,
    ServiceGroupAndRequestHeadersParameters,
    LroHeaders = ArmAsyncOperationHeader &
      ArmLroLocationHeader &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  #deprecated "API versions 2025-02-01-preview through 2026-08-31-preview are deprecated. Use 2026-09-30-preview or a later supported API version."
  @route(ServiceGroupRoute)
  @post
  @doc("This action triggers the failover operation on the recovery orchestration plan for the qualified resources.")
  @summary("Deprecated API version. Use 2026-09-30-preview or a later supported API version.")
  @sharedRoute
  failover is ArmResourceActionAsync<
    RecoveryPlan,
    FailoverRequest,
    RecoveryPlanActionBaseResponse,
    ServiceGroupAndRequestHeadersParameters
  >;

  #deprecated "API versions 2025-02-01-preview through 2026-08-31-preview are deprecated. Use 2026-09-30-preview or a later supported API version."
  @route(ServiceGroupRoute)
  @post
  @doc("This action triggers the failover commit operation on the recovery orchestration plan for the qualified resources.")
  @summary("Deprecated API version. Use 2026-09-30-preview or a later supported API version.")
  @sharedRoute
  failoverCommit is ArmResourceActionAsync<
    RecoveryPlan,
    void,
    RecoveryPlanActionBaseResponse,
    ServiceGroupAndRequestHeadersParameters
  >;

  #deprecated "API versions 2025-02-01-preview through 2026-08-31-preview are deprecated. Use 2026-09-30-preview or a later supported API version."
  @route(ServiceGroupRoute)
  @post
  @doc("This action triggers the reprotect operation on the recovery orchestration plan for the qualified resources.")
  @removed(Versions.v2026_03_01_preview)
  @renamedFrom(Versions.v2026_03_01_preview, "reprotect")
  @sharedRoute
  @summary("Deprecated API version. Use 2026-09-30-preview or a later supported API version.")
  reprotectOld is ArmResourceActionAsync<
    RecoveryPlan,
    void,
    RecoveryPlanActionBaseResponse,
    ServiceGroupAndRequestHeadersParameters
  >;

  #deprecated "API versions 2025-02-01-preview through 2026-08-31-preview are deprecated. Use 2026-09-30-preview or a later supported API version."
  @route(ServiceGroupRoute)
  @post
  @doc("This action triggers the reprotect operation on the recovery orchestration plan for the qualified resources.")
  @added(Versions.v2026_03_01_preview)
  @sharedRoute
  @summary("Deprecated API version. Use 2026-09-30-preview or a later supported API version.")
  reprotect is ArmResourceActionAsync<
    RecoveryPlan,
    ReprotectRequest,
    RecoveryPlanActionBaseResponse,
    ServiceGroupAndRequestHeadersParameters,
    OptionalRequestBody = true
  >;

  #deprecated "API versions 2025-02-01-preview through 2026-08-31-preview are deprecated. Use 2026-09-30-preview or a later supported API version."
  @route(ServiceGroupRoute)
  @post
  @doc("This action triggers the test failover operation on the recovery orchestration plan for the qualified resources.")
  @summary("Deprecated API version. Use 2026-09-30-preview or a later supported API version.")
  @sharedRoute
  testFailover is ArmResourceActionAsync<
    RecoveryPlan,
    FailoverRequest,
    RecoveryPlanActionBaseResponse,
    ServiceGroupAndRequestHeadersParameters
  >;

  #deprecated "API versions 2025-02-01-preview through 2026-08-31-preview are deprecated. Use 2026-09-30-preview or a later supported API version."
  @route(ServiceGroupRoute)
  @post
  @doc("This action triggers the test failover cleanup operation on the recovery orchestration plan for the qualified resources.")
  @summary("Deprecated API version. Use 2026-09-30-preview or a later supported API version.")
  @sharedRoute
  testFailoverCleanup is ArmResourceActionAsync<
    RecoveryPlan,
    TestFailoverCleanupRequest,
    RecoveryPlanActionBaseResponse,
    ServiceGroupAndRequestHeadersParameters
  >;
}

@armResourceOperations
@doc("Actions for managing Recovery Orchestration Plans.")
@added(Versions.v2026_09_30_preview)
interface RecoveryPlanActions {
  @route(ServiceGroupRoute)
  @post
  @doc("This action finalizes the recovery orchestration plan, ensuring all necessary configurations are in place.")
  @sharedRoute
  finalize is ArmResourceActionAsync<
    RecoveryPlan,
    void,
    ArmResponse<Azure.ResourceManager.ErrorResponse>,
    ServiceGroupAndRequestHeadersParameters
  >;

  @route(ServiceGroupRoute)
  @post
  @doc("This action adds or updates the resources to be included in the recovery orchestration plan.")
  @sharedRoute
  updateResources is ArmResourceActionAsync<
    RecoveryPlan,
    UpdateRecoveryResourcesRequest,
    UpdateRecoveryResourcesResponse,
    ServiceGroupAndRequestHeadersParameters
  >;

  @route(ServiceGroupRoute)
  @post
  @doc("This action checks if the recovery orchestration plan is eligible for operations like failover and reprotect, ensuring it meets the necessary criteria.")
  @sharedRoute
  validateForOperation is ArmResourceActionAsync<
    RecoveryPlan,
    ValidateForOperationRequest,
    ArmResponse<Azure.ResourceManager.ErrorResponse>,
    ServiceGroupAndRequestHeadersParameters
  >;

  @route(ServiceGroupRoute)
  @post
  @doc("This action checks if the recovery orchestration plan is eligible for failover operation, ensuring it meets the necessary criteria and provides a list of qualified and unqualified resources.")
  @sharedRoute
  validateForFailover is ArmResourceActionAsync<
    RecoveryPlan,
    FailoverRequest,
    ValidateForRecoveryOperationBaseResponse,
    ServiceGroupAndRequestHeadersParameters
  >;

  @route(ServiceGroupRoute)
  @post
  @doc("This action checks if the recovery orchestration plan is eligible for failover commit operation, ensuring it meets the necessary criteria and provides a list of qualified and unqualified resources.")
  @sharedRoute
  validateForFailoverCommit is ArmResourceActionAsync<
    RecoveryPlan,
    void,
    ValidateForRecoveryOperationBaseResponse,
    ServiceGroupAndRequestHeadersParameters
  >;

  @route(ServiceGroupRoute)
  @post
  @doc("This action checks if the recovery orchestration plan is eligible for test failover operation, ensuring it meets the necessary criteria and provides a list of qualified and unqualified resources.")
  @sharedRoute
  validateForTestFailover is ArmResourceActionAsync<
    RecoveryPlan,
    FailoverRequest,
    ValidateForRecoveryOperationBaseResponse,
    ServiceGroupAndRequestHeadersParameters
  >;

  @route(ServiceGroupRoute)
  @post
  @doc("This action checks if the recovery orchestration plan is eligible for test failover cleanup operation, ensuring it meets the necessary criteria and provides a list of qualified and unqualified resources.")
  @sharedRoute
  validateForTestFailoverCleanup is ArmResourceActionAsync<
    RecoveryPlan,
    void,
    ValidateForRecoveryOperationBaseResponse,
    ServiceGroupAndRequestHeadersParameters
  >;

  @route(ServiceGroupRoute)
  @post
  @doc("This action checks if the recovery orchestration plan is eligible for reprotect operation, ensuring it meets the necessary criteria and provides a list of qualified and unqualified resources.")
  @sharedRoute
  validateForReprotect is ArmResourceActionAsync<
    RecoveryPlan,
    ReprotectRequest,
    ValidateForRecoveryOperationBaseResponse,
    ServiceGroupAndRequestHeadersParameters,
    OptionalRequestBody = true
  >;

  @route(ServiceGroupRoute)
  @post
  @doc("This action performs the necessary readiness check on the recovery orchestration plan to ensure it is in the desired state and eligible for all recovery actions, including all protected resources.")
  @sharedRoute
  checkReadiness is ArmResourceActionAsync<
    RecoveryPlan,
    void,
    RecoveryPlanActionBaseResponse,
    ServiceGroupAndRequestHeadersParameters,
    LroHeaders = ArmAsyncOperationHeader &
      ArmLroLocationHeader &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  @route(ServiceGroupRoute)
  @post
  @doc("This action triggers the failover operation on the recovery orchestration plan for the qualified resources.")
  @sharedRoute
  failover is ArmResourceActionAsync<
    RecoveryPlan,
    FailoverRequest,
    RecoveryPlanActionBaseResponse,
    ServiceGroupAndRequestHeadersParameters
  >;

  @route(ServiceGroupRoute)
  @post
  @doc("This action triggers the failover commit operation on the recovery orchestration plan for the qualified resources.")
  @sharedRoute
  failoverCommit is ArmResourceActionAsync<
    RecoveryPlan,
    void,
    RecoveryPlanActionBaseResponse,
    ServiceGroupAndRequestHeadersParameters
  >;

  @route(ServiceGroupRoute)
  @post
  @doc("This action triggers the reprotect operation on the recovery orchestration plan for the qualified resources.")
  @sharedRoute
  reprotect is ArmResourceActionAsync<
    RecoveryPlan,
    ReprotectRequest,
    RecoveryPlanActionBaseResponse,
    ServiceGroupAndRequestHeadersParameters,
    OptionalRequestBody = true
  >;

  @route(ServiceGroupRoute)
  @post
  @doc("This action triggers the test failover operation on the recovery orchestration plan for the qualified resources.")
  @sharedRoute
  testFailover is ArmResourceActionAsync<
    RecoveryPlan,
    FailoverRequest,
    RecoveryPlanActionBaseResponse,
    ServiceGroupAndRequestHeadersParameters
  >;

  @route(ServiceGroupRoute)
  @post
  @doc("This action triggers the test failover cleanup operation on the recovery orchestration plan for the qualified resources.")
  @sharedRoute
  testFailoverCleanup is ArmResourceActionAsync<
    RecoveryPlan,
    TestFailoverCleanupRequest,
    RecoveryPlanActionBaseResponse,
    ServiceGroupAndRequestHeadersParameters
  >;
}

@armResourceOperations
@doc("Operations for managing recovery resources.")
@removed(Versions.v2026_09_30_preview)
@renamedFrom(Versions.v2026_09_30_preview, "RecoveryResources")
interface RecoveryResourcesOld {
  // ONLY Get and List are exposed to the user.

  #deprecated "API versions 2025-02-01-preview through 2026-08-31-preview are deprecated. Use 2026-09-30-preview or a later supported API version."
  @route(ServiceGroupRoute)
  @summary("Deprecated API version. Use 2026-09-30-preview or a later supported API version.")
  @sharedRoute
  get is ArmResourceRead<RecoveryResource, ServiceGroupParameters>;

  #deprecated "API versions 2025-02-01-preview through 2026-08-31-preview are deprecated. Use 2026-09-30-preview or a later supported API version."
  @route(ServiceGroupRoute)
  @summary("Deprecated API version. Use 2026-09-30-preview or a later supported API version.")
  @sharedRoute
  list is ArmResourceListByParent<RecoveryResource, ServiceGroupParameters>;
}

@armResourceOperations
@doc("Operations for managing recovery resources.")
@added(Versions.v2026_09_30_preview)
interface RecoveryResources {
  // ONLY Get and List are exposed to the user.

  @route(ServiceGroupRoute)
  @sharedRoute
  get is ArmResourceRead<RecoveryResource, ServiceGroupParameters>;

  @route(ServiceGroupRoute)
  @sharedRoute
  list is ArmResourceListByParent<RecoveryResource, ServiceGroupParameters>;
}

@armResourceOperations
@doc("Operations for managing recovery jobs.")
@removed(Versions.v2026_09_30_preview)
@renamedFrom(Versions.v2026_09_30_preview, "RecoveryJobs")
interface RecoveryJobsOld {
  #deprecated "API versions 2025-02-01-preview through 2026-08-31-preview are deprecated. Use 2026-09-30-preview or a later supported API version."
  @route(ServiceGroupRoute)
  @summary("Deprecated API version. Use 2026-09-30-preview or a later supported API version.")
  @sharedRoute
  get is ArmResourceRead<RecoveryJob, ServiceGroupParameters>;

  #deprecated "API versions 2025-02-01-preview through 2026-08-31-preview are deprecated. Use 2026-09-30-preview or a later supported API version."
  @route(ServiceGroupRoute)
  @summary("Deprecated API version. Use 2026-09-30-preview or a later supported API version.")
  @sharedRoute
  list is ArmResourceListByParent<RecoveryJob, ServiceGroupParameters>;

  #deprecated "API versions 2025-02-01-preview through 2026-08-31-preview are deprecated. Use 2026-09-30-preview or a later supported API version."
  @route(ServiceGroupRoute)
  @post
  @doc("This action attempts to cancel the ongoing recovery orchestration job.")
  @removed(Versions.v2026_03_01_preview)
  @renamedFrom(Versions.v2026_03_01_preview, "cancel")
  @sharedRoute
  @summary("Deprecated API version. Use 2026-09-30-preview or a later supported API version.")
  cancelOld is ArmResourceActionAsync<
    RecoveryJob,
    void,
    ArmResponse<Azure.ResourceManager.ErrorResponse>,
    ServiceGroupAndRequestHeadersParameters
  >;

  #deprecated "API versions 2025-02-01-preview through 2026-08-31-preview are deprecated. Use 2026-09-30-preview or a later supported API version."
  @route(ServiceGroupRoute)
  @post
  @doc("This action attempts to cancel the ongoing recovery orchestration job.")
  @added(Versions.v2026_03_01_preview)
  @sharedRoute
  @summary("Deprecated API version. Use 2026-09-30-preview or a later supported API version.")
  cancel is ArmResourceActionAsync<
    RecoveryJob,
    RecoveryActionRequest,
    ArmResponse<Azure.ResourceManager.ErrorResponse>,
    ServiceGroupAndRequestHeadersParameters
  >;

  #deprecated "API versions 2025-02-01-preview through 2026-08-31-preview are deprecated. Use 2026-09-30-preview or a later supported API version."
  @route(ServiceGroupRoute)
  @post
  @doc("This action resumes the ongoing recovery orchestration job that was paused for required user intervention.")
  @removed(Versions.v2026_03_01_preview)
  @renamedFrom(Versions.v2026_03_01_preview, "resume")
  @sharedRoute
  @summary("Deprecated API version. Use 2026-09-30-preview or a later supported API version.")
  resumeOld is ArmResourceActionAsync<
    RecoveryJob,
    void,
    ArmResponse<Azure.ResourceManager.ErrorResponse>,
    ServiceGroupAndRequestHeadersParameters
  >;

  #deprecated "API versions 2025-02-01-preview through 2026-08-31-preview are deprecated. Use 2026-09-30-preview or a later supported API version."
  @route(ServiceGroupRoute)
  @post
  @doc("This action resumes the ongoing recovery orchestration job that was paused for required user intervention.")
  @added(Versions.v2026_03_01_preview)
  @sharedRoute
  @summary("Deprecated API version. Use 2026-09-30-preview or a later supported API version.")
  resume is ArmResourceActionAsync<
    RecoveryJob,
    RecoveryActionRequest,
    ArmResponse<Azure.ResourceManager.ErrorResponse>,
    ServiceGroupAndRequestHeadersParameters
  >;

  #deprecated "API versions 2025-02-01-preview through 2026-08-31-preview are deprecated. Use 2026-09-30-preview or a later supported API version."
  @route(ServiceGroupRoute)
  @post
  @doc("This action retries the ongoing recovery orchestration job for resources that failed in previous attempts.")
  @summary("Deprecated API version. Use 2026-09-30-preview or a later supported API version.")
  @sharedRoute
  retry is ArmResourceActionAsync<
    RecoveryJob,
    void,
    ArmResponse<Azure.ResourceManager.ErrorResponse>,
    ServiceGroupAndRequestHeadersParameters
  >;
}

@armResourceOperations
@doc("Operations for managing recovery jobs.")
@added(Versions.v2026_09_30_preview)
interface RecoveryJobs {
  @route(ServiceGroupRoute)
  @sharedRoute
  get is ArmResourceRead<RecoveryJob, ServiceGroupParameters>;

  @route(ServiceGroupRoute)
  @sharedRoute
  list is ArmResourceListByParent<RecoveryJob, ServiceGroupParameters>;

  @route(ServiceGroupRoute)
  @post
  @doc("This action attempts to cancel the ongoing recovery orchestration job.")
  @sharedRoute
  cancel is ArmResourceActionAsync<
    RecoveryJob,
    RecoveryActionRequest,
    ArmResponse<Azure.ResourceManager.ErrorResponse>,
    ServiceGroupAndRequestHeadersParameters
  >;

  @route(ServiceGroupRoute)
  @post
  @doc("This action resumes the ongoing recovery orchestration job that was paused for required user intervention.")
  @sharedRoute
  resume is ArmResourceActionAsync<
    RecoveryJob,
    RecoveryActionRequest,
    ArmResponse<Azure.ResourceManager.ErrorResponse>,
    ServiceGroupAndRequestHeadersParameters
  >;

  @route(ServiceGroupRoute)
  @post
  @doc("This action retries the ongoing recovery orchestration job for resources that failed in previous attempts.")
  @sharedRoute
  retry is ArmResourceActionAsync<
    RecoveryJob,
    void,
    ArmResponse<Azure.ResourceManager.ErrorResponse>,
    ServiceGroupAndRequestHeadersParameters
  >;
}

@armResourceOperations
@doc("Operations for managing recovery child jobs.")
@removed(Versions.v2026_04_01_preview)
interface RecoveryChildJobs {
  #deprecated "RecoveryChildJob is deprecated and removed in 2026-04-01-preview."
  @doc("Gets a recovery child job. Deprecated: the RecoveryChildJob resource type is deprecated and is removed in 2026-04-01-preview. Use the recoveryJobResources child of the recovery job (RecoveryJobResources) instead.")
  @route(ServiceGroupRoute)
  @summary("Deprecated. Use RecoveryJobResources instead.")
  get is ArmResourceRead<RecoveryChildJob, ServiceGroupParameters>;

  #deprecated "RecoveryChildJob is deprecated and removed in 2026-04-01-preview."
  @doc("Lists the recovery child jobs of a recovery job. Deprecated: the RecoveryChildJob resource type is deprecated and is removed in 2026-04-01-preview. Use the recoveryJobResources child of the recovery job (RecoveryJobResources) instead.")
  @route(ServiceGroupRoute)
  @summary("Deprecated. Use RecoveryJobResources instead.")
  list is ArmResourceListByParent<RecoveryChildJob, ServiceGroupParameters>;
}

@armResourceOperations
@doc("Operations for managing recovery job resources.")
@removed(Versions.v2026_09_30_preview)
@renamedFrom(Versions.v2026_09_30_preview, "RecoveryJobResources")
interface RecoveryJobResourcesOld {
  #deprecated "API versions 2025-02-01-preview through 2026-08-31-preview are deprecated. Use 2026-09-30-preview or a later supported API version."
  @route(ServiceGroupRoute)
  @summary("Deprecated API version. Use 2026-09-30-preview or a later supported API version.")
  @sharedRoute
  get is ArmResourceRead<RecoveryJobResource, ServiceGroupParameters>;

  #deprecated "API versions 2025-02-01-preview through 2026-08-31-preview are deprecated. Use 2026-09-30-preview or a later supported API version."
  @route(ServiceGroupRoute)
  @summary("Deprecated API version. Use 2026-09-30-preview or a later supported API version.")
  @sharedRoute
  list is ArmResourceListByParent<RecoveryJobResource, ServiceGroupParameters>;
}

@armResourceOperations
@doc("Operations for managing recovery job resources.")
@added(Versions.v2026_09_30_preview)
interface RecoveryJobResources {
  @route(ServiceGroupRoute)
  @sharedRoute
  get is ArmResourceRead<RecoveryJobResource, ServiceGroupParameters>;

  @route(ServiceGroupRoute)
  @sharedRoute
  list is ArmResourceListByParent<RecoveryJobResource, ServiceGroupParameters>;
}

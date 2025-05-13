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
interface RecoveryPlans {
  @route(ServiceGroupRoute)
  get is ArmResourceRead<RecoveryPlan, ServiceGroupParameters>;

  @route(ServiceGroupRoute)
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    RecoveryPlan,
    ServiceGroupParameters
  >;

  @route(ServiceGroupRoute)
  update is ArmResourcePatchAsync<
    RecoveryPlan,
    RecoveryPlanProperties,
    ServiceGroupParameters
  >;

  @route(ServiceGroupRoute)
  delete is ArmResourceDeleteWithoutOkAsync<
    RecoveryPlan,
    ServiceGroupParameters
  >;

  @route(ServiceGroupRoute)
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
interface RecoveryPlanActions {
  @route(ServiceGroupRoute)
  @post
  @doc("This action finalizes the recovery orchestration plan, ensuring all necessary configurations are in place.")
  finalize is ArmResourceActionAsync<
    RecoveryPlan,
    void,
    ArmResponse<Azure.ResourceManager.ErrorResponse>,
    ServiceGroupAndRequestHeadersParameters
  >;

  @route(ServiceGroupRoute)
  @post
  @doc("This action adds or updates the resources to be included in the recovery orchestration plan.")
  updateResources is ArmResourceActionAsync<
    RecoveryPlan,
    UpdateRecoveryResourcesRequest,
    UpdateRecoveryResourcesResponse,
    ServiceGroupAndRequestHeadersParameters
  >;

  @route(ServiceGroupRoute)
  @post
  @doc("This action checks if the recovery orchestration plan is eligible for operations like failover and reprotect, ensuring it meets the necessary criteria.")
  validateForOperation is ArmResourceActionAsync<
    RecoveryPlan,
    ValidateForOperationRequest,
    ArmResponse<Azure.ResourceManager.ErrorResponse>,
    ServiceGroupAndRequestHeadersParameters
  >;

  @route(ServiceGroupRoute)
  @post
  @doc("This action checks if the recovery orchestration plan is eligible for failover operation, ensuring it meets the necessary criteria and provides a list of qualified and unqualified resources.")
  validateForFailover is ArmResourceActionAsync<
    RecoveryPlan,
    FailoverRequest,
    ValidateForRecoveryOperationBaseResponse,
    ServiceGroupAndRequestHeadersParameters
  >;

  @route(ServiceGroupRoute)
  @post
  @doc("This action checks if the recovery orchestration plan is eligible for failover commit operation, ensuring it meets the necessary criteria and provides a list of qualified and unqualified resources.")
  validateForFailoverCommit is ArmResourceActionAsync<
    RecoveryPlan,
    void,
    ValidateForRecoveryOperationBaseResponse,
    ServiceGroupAndRequestHeadersParameters
  >;

  @route(ServiceGroupRoute)
  @post
  @doc("This action checks if the recovery orchestration plan is eligible for test failover operation, ensuring it meets the necessary criteria and provides a list of qualified and unqualified resources.")
  validateForTestFailover is ArmResourceActionAsync<
    RecoveryPlan,
    FailoverRequest,
    ValidateForRecoveryOperationBaseResponse,
    ServiceGroupAndRequestHeadersParameters
  >;

  @route(ServiceGroupRoute)
  @post
  @doc("This action checks if the recovery orchestration plan is eligible for test failover cleanup operation, ensuring it meets the necessary criteria and provides a list of qualified and unqualified resources.")
  validateForTestFailoverCleanup is ArmResourceActionAsync<
    RecoveryPlan,
    void,
    ValidateForRecoveryOperationBaseResponse,
    ServiceGroupAndRequestHeadersParameters
  >;

  @route(ServiceGroupRoute)
  @post
  @doc("This action checks if the recovery orchestration plan is eligible for reprotect operation, ensuring it meets the necessary criteria and provides a list of qualified and unqualified resources.")
  validateForReprotect is ArmResourceActionAsync<
    RecoveryPlan,
    void,
    ValidateForRecoveryOperationBaseResponse,
    ServiceGroupAndRequestHeadersParameters
  >;

  @route(ServiceGroupRoute)
  @post
  @doc("This action performs the necessary readiness check on the recovery orchestration plan to ensure it is in the desired state and eligible for all recovery actions, including all protected resources.")
  checkReadiness is ArmResourceActionSync<
    RecoveryPlan,
    void,
    RecoveryPlanActionBaseResponse,
    ServiceGroupAndRequestHeadersParameters
  >;

  @route(ServiceGroupRoute)
  @post
  @doc("This action triggers the failover operation on the recovery orchestration plan for the qualified resources.")
  failover is ArmResourceActionAsync<
    RecoveryPlan,
    FailoverRequest,
    RecoveryPlanActionBaseResponse,
    ServiceGroupAndRequestHeadersParameters
  >;

  @route(ServiceGroupRoute)
  @post
  @doc("This action triggers the failover commit operation on the recovery orchestration plan for the qualified resources.")
  failoverCommit is ArmResourceActionAsync<
    RecoveryPlan,
    void,
    RecoveryPlanActionBaseResponse,
    ServiceGroupAndRequestHeadersParameters
  >;

  @route(ServiceGroupRoute)
  @post
  @doc("This action triggers the reprotect operation on the recovery orchestration plan for the qualified resources.")
  reprotect is ArmResourceActionAsync<
    RecoveryPlan,
    void,
    RecoveryPlanActionBaseResponse,
    ServiceGroupAndRequestHeadersParameters
  >;

  @route(ServiceGroupRoute)
  @post
  @doc("This action triggers the test failover operation on the recovery orchestration plan for the qualified resources.")
  testFailover is ArmResourceActionAsync<
    RecoveryPlan,
    FailoverRequest,
    RecoveryPlanActionBaseResponse,
    ServiceGroupAndRequestHeadersParameters
  >;

  @route(ServiceGroupRoute)
  @post
  @doc("This action triggers the test failover cleanup operation on the recovery orchestration plan for the qualified resources.")
  testFailoverCleanup is ArmResourceActionAsync<
    RecoveryPlan,
    TestFailoverCleanupRequest,
    RecoveryPlanActionBaseResponse,
    ServiceGroupAndRequestHeadersParameters
  >;
}

@armResourceOperations
@doc("Operations for managing recovery resources.")
interface RecoveryResources {
  // ONLY Get and List are exposed to the user.

  @route(ServiceGroupRoute)
  get is ArmResourceRead<RecoveryResource, ServiceGroupParameters>;

  @route(ServiceGroupRoute)
  list is ArmResourceListByParent<RecoveryResource, ServiceGroupParameters>;
}

@armResourceOperations
@doc("Operations for managing recovery jobs.")
interface RecoveryJobs {
  @route(ServiceGroupRoute)
  get is ArmResourceRead<RecoveryJob, ServiceGroupParameters>;

  @route(ServiceGroupRoute)
  list is ArmResourceListByParent<RecoveryJob, ServiceGroupParameters>;

  @route(ServiceGroupRoute)
  @post
  @doc("This action attempts to cancel the ongoing recovery orchestration job.")
  cancel is ArmResourceActionAsync<
    RecoveryJob,
    void,
    ArmResponse<Azure.ResourceManager.ErrorResponse>,
    ServiceGroupAndRequestHeadersParameters
  >;

  @route(ServiceGroupRoute)
  @post
  @doc("This action resumes the ongoing recovery orchestration job that was paused for required user intervention.")
  resume is ArmResourceActionAsync<
    RecoveryJob,
    void,
    ArmResponse<Azure.ResourceManager.ErrorResponse>,
    ServiceGroupAndRequestHeadersParameters
  >;

  @route(ServiceGroupRoute)
  @post
  @doc("This action retries the ongoing recovery orchestration job for resources that failed in previous attempts.")
  retry is ArmResourceActionAsync<
    RecoveryJob,
    void,
    ArmResponse<Azure.ResourceManager.ErrorResponse>,
    ServiceGroupAndRequestHeadersParameters
  >;
}

@armResourceOperations
@doc("Operations for managing recovery child jobs.")
interface RecoveryChildJobs {
  @route(ServiceGroupRoute)
  get is ArmResourceRead<RecoveryChildJob, ServiceGroupParameters>;

  @route(ServiceGroupRoute)
  list is ArmResourceListByParent<RecoveryChildJob, ServiceGroupParameters>;
}

@armResourceOperations
@doc("Operations for managing recovery job resources.")
interface RecoveryJobResources {
  @route(ServiceGroupRoute)
  get is ArmResourceRead<RecoveryJobResource, ServiceGroupParameters>;

  @route(ServiceGroupRoute)
  list is ArmResourceListByParent<RecoveryJobResource, ServiceGroupParameters>;
}

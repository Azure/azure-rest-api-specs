import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

import "./models/drill/drillRun.models.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;
using Azure.Core;
using Azure.ResourceManager.CommonTypes;
using Azure.ResourceManager.Foundations;
using TypeSpec.OpenAPI;

namespace Microsoft.AzureResilienceManagement;

@armResourceOperations(DrillRun)
interface DrillRuns {
  // ONLY Get and POST actions are exposed to the user.

  @route(ServiceGroupRoute)
  get is ArmResourceRead<DrillRun, ServiceGroupParameters>;

  @route(ServiceGroupRoute)
  list is ArmResourceListByParent<DrillRun, ServiceGroupParameters>;

  /**
  POST Actions
  */
  @route(ServiceGroupRoute)
  @armResourceAction(DrillRun)
  @post
  @doc("This initiates a new Failover operation on this Drill Run.")
  failOver is ArmResourceActionAsync<
    DrillRun,
    DrillRunFailoverRequest,
    DrillRunActionResponse,
    ServiceGroupAndRequestHeadersParameters,
    LroHeaders = ArmAsyncOperationHeader &
      ArmLroLocationHeader &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  @route(ServiceGroupRoute)
  @removed(Versions.v2026_04_01_preview)
  @armResourceAction(DrillRun)
  @post
  @doc("This initiates a new Test-Failover operation on this Drill Run.")
  testFailOver is ArmResourceActionAsync<
    DrillRun,
    DrillRunTestFailoverRequest,
    DrillRunActionResponse,
    ServiceGroupAndRequestHeadersParameters,
    LroHeaders = ArmAsyncOperationHeader &
      ArmLroLocationHeader &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  @route(ServiceGroupRoute)
  @removed(Versions.v2026_04_01_preview)
  @armResourceAction(DrillRun)
  @post
  @doc("This initiates a new Test-Failover Cleanup operation on this Drill Run.")
  testFailOverCleanup is ArmResourceActionAsync<
    DrillRun,
    DrillRunTestFailoverCleanupRequest,
    DrillRunActionResponse,
    ServiceGroupAndRequestHeadersParameters,
    LroHeaders = ArmAsyncOperationHeader &
      ArmLroLocationHeader &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  @route(ServiceGroupRoute)
  @armResourceAction(DrillRun)
  @post
  @doc("This initiates a new Reprotect operation on this Drill Run.")
  reprotect is ArmResourceActionAsync<
    DrillRun,
    void,
    DrillRunActionResponse,
    ServiceGroupAndRequestHeadersParameters,
    LroHeaders = ArmAsyncOperationHeader &
      ArmLroLocationHeader &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  @route(ServiceGroupRoute)
  @armResourceAction(DrillRun)
  @post
  @doc("This enables the user to add notes on this Drill Run.")
  addNotes is ArmResourceActionAsync<
    DrillRun,
    DrillRunAddNotesRequest,
    DrillRunActionResponse,
    ServiceGroupAndRequestHeadersParameters,
    LroHeaders = ArmAsyncOperationHeader &
      ArmLroLocationHeader &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  @route(ServiceGroupRoute)
  @armResourceAction(DrillRun)
  @post
  @doc("This unblocks a Failover workflow that is paused after the Fault stage, to proceed to the Failover stage.")
  resume is ArmResourceActionAsync<
    DrillRun,
    void,
    DrillRunActionResponse,
    ServiceGroupAndRequestHeadersParameters,
    LroHeaders = ArmAsyncOperationHeader &
      ArmLroLocationHeader &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  @route(ServiceGroupRoute)
  @armResourceAction(DrillRun)
  @post
  @doc("This enables the user to mark this stage as complete, disabling further retries on it.")
  markAsComplete is ArmResourceActionAsync<
    DrillRun,
    MarkAsCompleteRequest,
    MarkAsCompleteResponse,
    ServiceGroupAndRequestHeadersParameters,
    LroHeaders = ArmAsyncOperationHeader &
      ArmLroLocationHeader &
      Azure.Core.Foundations.RetryAfterHeader
  >;
}

@armResourceOperations
@doc("Operations for managing Drill Run child jobs.")
@removed(Versions.v2026_04_01_preview)
interface DrillRunChildJobs {
  @route(ServiceGroupRoute)
  get is ArmResourceRead<DrillRunChildJob, ServiceGroupParameters>;

  @route(ServiceGroupRoute)
  list is ArmResourceListByParent<DrillRunChildJob, ServiceGroupParameters>;
}

@armResourceOperations
@doc("Operations for managing Drill Run resources.")
interface DrillRunResources {
  @route(ServiceGroupRoute)
  get is ArmResourceRead<DrillRunResource, ServiceGroupParameters>;

  @route(ServiceGroupRoute)
  list is ArmResourceListByParent<DrillRunResource, ServiceGroupParameters>;
}

@armResourceOperations
@doc("Operations for managing Chaos jobs.")
@removed(Versions.v2026_04_01_preview)
interface ChaosJobs {
  @route(ServiceGroupRoute)
  get is ArmResourceRead<ChaosJob, ServiceGroupParameters>;

  @route(ServiceGroupRoute)
  list is ArmResourceListByParent<ChaosJob, ServiceGroupParameters>;
}

@armResourceOperations
@doc("Operations for managing Chaos job resources.")
@removed(Versions.v2026_04_01_preview)
interface ChaosJobResources {
  @route(ServiceGroupRoute)
  get is ArmResourceRead<ChaosJobResource, ServiceGroupParameters>;

  @route(ServiceGroupRoute)
  list is ArmResourceListByParent<ChaosJobResource, ServiceGroupParameters>;
}

@armResourceOperations
@doc("Operations for managing Chaos job child job.")
@removed(Versions.v2026_04_01_preview)
interface ChaosJobChildJobs {
  @route(ServiceGroupRoute)
  get is ArmResourceRead<ChaosJobChildJob, ServiceGroupParameters>;

  @route(ServiceGroupRoute)
  list is ArmResourceListByParent<ChaosJobChildJob, ServiceGroupParameters>;
}

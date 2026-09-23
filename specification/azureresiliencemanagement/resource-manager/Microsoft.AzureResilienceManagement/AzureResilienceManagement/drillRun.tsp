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
@removed(Versions.v2026_09_30_preview)
@renamedFrom(Versions.v2026_09_30_preview, "DrillRuns")
interface DrillRunsOld {
  // ONLY Get and POST actions are exposed to the user.

  @route(ServiceGroupRoute)
  #deprecated "API versions 2025-02-01-preview through 2026-08-31-preview are deprecated. Use 2026-09-30-preview or a later supported API version."
  @summary("Deprecated API version. Use 2026-09-30-preview or a later supported API version.")
  @sharedRoute
  get is ArmResourceRead<DrillRun, ServiceGroupParameters>;

  @route(ServiceGroupRoute)
  #deprecated "API versions 2025-02-01-preview through 2026-08-31-preview are deprecated. Use 2026-09-30-preview or a later supported API version."
  @summary("Deprecated API version. Use 2026-09-30-preview or a later supported API version.")
  @sharedRoute
  list is ArmResourceListByParent<DrillRun, ServiceGroupParameters>;

  /**
  POST Actions
  */
  @route(ServiceGroupRoute)
  @removed(Versions.v2026_06_01_preview)
  @renamedFrom(Versions.v2026_06_01_preview, "failOver")
  @sharedRoute
  @armResourceAction(DrillRun)
  @post
  @doc("This initiates a new Failover operation on this Drill Run.")
  #deprecated "API versions 2025-02-01-preview through 2026-08-31-preview are deprecated. Use 2026-09-30-preview or a later supported API version."
  @summary("Deprecated API version. Use 2026-09-30-preview or a later supported API version.")
  failOverOld is ArmResourceActionAsync<
    DrillRun,
    DrillRunFailoverRequest,
    DrillRunActionResponse,
    ServiceGroupAndRequestHeadersParameters,
    LroHeaders = ArmAsyncOperationHeader &
      ArmLroLocationHeader &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  @route(ServiceGroupRoute)
  @added(Versions.v2026_06_01_preview)
  @sharedRoute
  @armResourceAction(DrillRun)
  @post
  @doc("This initiates a new Failover operation on this Drill Run.")
  #deprecated "API versions 2025-02-01-preview through 2026-08-31-preview are deprecated. Use 2026-09-30-preview or a later supported API version."
  @summary("Deprecated API version. Use 2026-09-30-preview or a later supported API version.")
  failOver is ArmResourceActionAsync<
    DrillRun,
    DrillRunFailoverRequest,
    DrillRunActionResponse,
    ServiceGroupAndRequestHeadersParameters,
    LroHeaders = ArmAsyncOperationHeader &
      ArmLroLocationHeader &
      Azure.Core.Foundations.RetryAfterHeader,
    OptionalRequestBody = true
  >;

  @route(ServiceGroupRoute)
  @removed(Versions.v2026_04_01_preview)
  @armResourceAction(DrillRun)
  @post
  @doc("This initiates a new Test-Failover operation on this Drill Run.")
  #deprecated "The testFailOver operation is deprecated and has no direct replacement in 2026-09-30-preview. Clients must stop calling this operation."
  @summary("Deprecated with no direct replacement in 2026-09-30-preview.")
  @sharedRoute
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
  #deprecated "The testFailOverCleanup operation is deprecated and has no direct replacement in 2026-09-30-preview. Clients must stop calling this operation."
  @summary("Deprecated with no direct replacement in 2026-09-30-preview.")
  @sharedRoute
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
  @removed(Versions.v2026_06_01_preview)
  @renamedFrom(Versions.v2026_06_01_preview, "reprotect")
  @sharedRoute
  @armResourceAction(DrillRun)
  @post
  @doc("This initiates a new Reprotect operation on this Drill Run.")
  #deprecated "API versions 2025-02-01-preview through 2026-08-31-preview are deprecated. Use 2026-09-30-preview or a later supported API version."
  @summary("Deprecated API version. Use 2026-09-30-preview or a later supported API version.")
  reprotectOld is ArmResourceActionAsync<
    DrillRun,
    void,
    DrillRunActionResponse,
    ServiceGroupAndRequestHeadersParameters,
    LroHeaders = ArmAsyncOperationHeader &
      ArmLroLocationHeader &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  @route(ServiceGroupRoute)
  @added(Versions.v2026_06_01_preview)
  @sharedRoute
  @armResourceAction(DrillRun)
  @post
  @doc("This initiates a new Reprotect operation on this Drill Run.")
  #deprecated "API versions 2025-02-01-preview through 2026-08-31-preview are deprecated. Use 2026-09-30-preview or a later supported API version."
  @summary("Deprecated API version. Use 2026-09-30-preview or a later supported API version.")
  reprotect is ArmResourceActionAsync<
    DrillRun,
    DrillRunReprotectRequest,
    DrillRunActionResponse,
    ServiceGroupAndRequestHeadersParameters,
    LroHeaders = ArmAsyncOperationHeader &
      ArmLroLocationHeader &
      Azure.Core.Foundations.RetryAfterHeader,
    OptionalRequestBody = true
  >;

  @route(ServiceGroupRoute)
  @armResourceAction(DrillRun)
  @post
  @doc("This enables the user to add notes on this Drill Run.")
  #deprecated "API versions 2025-02-01-preview through 2026-08-31-preview are deprecated. Use 2026-09-30-preview or a later supported API version."
  @summary("Deprecated API version. Use 2026-09-30-preview or a later supported API version.")
  @sharedRoute
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
  #deprecated "API versions 2025-02-01-preview through 2026-08-31-preview are deprecated. Use 2026-09-30-preview or a later supported API version."
  @summary("Deprecated API version. Use 2026-09-30-preview or a later supported API version.")
  @sharedRoute
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
  #deprecated "API versions 2025-02-01-preview through 2026-08-31-preview are deprecated. Use 2026-09-30-preview or a later supported API version."
  @summary("Deprecated API version. Use 2026-09-30-preview or a later supported API version.")
  @sharedRoute
  markAsComplete is ArmResourceActionAsync<
    DrillRun,
    MarkAsCompleteRequest,
    MarkAsCompleteResponse,
    ServiceGroupAndRequestHeadersParameters,
    LroHeaders = ArmAsyncOperationHeader &
      ArmLroLocationHeader &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  @route(ServiceGroupRoute)
  @added(Versions.v2026_08_31_preview)
  @armResourceAction(DrillRun)
  @post
  @doc("This generates, or regenerates, the report for this Drill Run. The action is idempotent and is safe to call at any time: a call that arrives while a generation is already running joins it, and a call made after a failed attempt retries it. A report that has been finalized is never regenerated.")
  #deprecated "API versions 2025-02-01-preview through 2026-08-31-preview are deprecated. Use 2026-09-30-preview or a later supported API version."
  @summary("Deprecated API version. Use 2026-09-30-preview or a later supported API version.")
  @sharedRoute
  generateReport is ArmResourceActionAsync<
    DrillRun,
    void,
    DrillReportSummary,
    ServiceGroupAndRequestHeadersParameters,
    LroHeaders = ArmAsyncOperationHeader<FinalResult = DrillReportSummary> &
      ArmLroLocationHeader &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  @route(ServiceGroupRoute)
  @added(Versions.v2026_08_31_preview)
  @armResourceAction(DrillRun)
  @post
  @doc("This returns a short-lived, read-only URL to download the report for this Drill Run. The URL expires at the returned expiryTimestamp and grants access to that single report only.")
  #deprecated "API versions 2025-02-01-preview through 2026-08-31-preview are deprecated. Use 2026-09-30-preview or a later supported API version."
  @summary("Deprecated API version. Use 2026-09-30-preview or a later supported API version.")
  @sharedRoute
  listReportDownloadUrl is ArmResourceActionAsync<
    DrillRun,
    ListReportDownloadUrlRequest,
    ListReportDownloadUrlResponse,
    ServiceGroupAndRequestHeadersParameters,
    LroHeaders = ArmAsyncOperationHeader<FinalResult = ListReportDownloadUrlResponse> &
      ArmLroLocationHeader &
      Azure.Core.Foundations.RetryAfterHeader
  >;
}

@armResourceOperations(DrillRun)
@added(Versions.v2026_09_30_preview)
interface DrillRuns {
  // ONLY Get and POST actions are exposed to the user.

  @route(ServiceGroupRoute)
  @sharedRoute
  get is ArmResourceRead<DrillRun, ServiceGroupParameters>;

  @route(ServiceGroupRoute)
  @sharedRoute
  list is ArmResourceListByParent<DrillRun, ServiceGroupParameters>;


  @route(ServiceGroupRoute)
  @sharedRoute
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
      Azure.Core.Foundations.RetryAfterHeader,
    OptionalRequestBody = true
  >;




  @route(ServiceGroupRoute)
  @sharedRoute
  @armResourceAction(DrillRun)
  @post
  @doc("This initiates a new Reprotect operation on this Drill Run.")
  reprotect is ArmResourceActionAsync<
    DrillRun,
    DrillRunReprotectRequest,
    DrillRunActionResponse,
    ServiceGroupAndRequestHeadersParameters,
    LroHeaders = ArmAsyncOperationHeader &
      ArmLroLocationHeader &
      Azure.Core.Foundations.RetryAfterHeader,
    OptionalRequestBody = true
  >;

  @route(ServiceGroupRoute)
  @armResourceAction(DrillRun)
  @post
  @doc("This enables the user to add notes on this Drill Run.")
  @sharedRoute
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
  @sharedRoute
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
  @sharedRoute
  markAsComplete is ArmResourceActionAsync<
    DrillRun,
    MarkAsCompleteRequest,
    MarkAsCompleteResponse,
    ServiceGroupAndRequestHeadersParameters,
    LroHeaders = ArmAsyncOperationHeader &
      ArmLroLocationHeader &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  @route(ServiceGroupRoute)
  @armResourceAction(DrillRun)
  @post
  @doc("This generates, or regenerates, the report for this Drill Run. The action is idempotent and is safe to call at any time: a call that arrives while a generation is already running joins it, and a call made after a failed attempt retries it. A report that has been finalized is never regenerated.")
  @sharedRoute
  generateReport is ArmResourceActionAsync<
    DrillRun,
    void,
    DrillReportSummary,
    ServiceGroupAndRequestHeadersParameters,
    LroHeaders = ArmAsyncOperationHeader<FinalResult = DrillReportSummary> &
      ArmLroLocationHeader &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  @route(ServiceGroupRoute)
  @armResourceAction(DrillRun)
  @post
  @doc("This returns a short-lived, read-only URL to download the report for this Drill Run. The URL expires at the returned expiryTimestamp and grants access to that single report only.")
  @sharedRoute
  listReportDownloadUrl is ArmResourceActionAsync<
    DrillRun,
    ListReportDownloadUrlRequest,
    ListReportDownloadUrlResponse,
    ServiceGroupAndRequestHeadersParameters,
    LroHeaders = ArmAsyncOperationHeader<FinalResult = ListReportDownloadUrlResponse> &
      ArmLroLocationHeader &
      Azure.Core.Foundations.RetryAfterHeader
  >;
}

@armResourceOperations
@doc("Operations for managing Drill Run child jobs.")
@removed(Versions.v2026_04_01_preview)
interface DrillRunChildJobs {
  @route(ServiceGroupRoute)
  #deprecated "DrillRunChildJob operations are deprecated and removed in 2026-04-01-preview. They have no direct replacement in 2026-09-30-preview."
  @summary("Deprecated with no direct replacement in 2026-09-30-preview.")
  get is ArmResourceRead<DrillRunChildJob, ServiceGroupParameters>;

  @route(ServiceGroupRoute)
  #deprecated "DrillRunChildJob operations are deprecated and removed in 2026-04-01-preview. They have no direct replacement in 2026-09-30-preview."
  @summary("Deprecated with no direct replacement in 2026-09-30-preview.")
  list is ArmResourceListByParent<DrillRunChildJob, ServiceGroupParameters>;
}

@armResourceOperations
@doc("Operations for managing Drill Run resources.")
@removed(Versions.v2026_09_30_preview)
@renamedFrom(Versions.v2026_09_30_preview, "DrillRunResources")
interface DrillRunResourcesOld {
  @route(ServiceGroupRoute)
  #deprecated "API versions 2025-02-01-preview through 2026-08-31-preview are deprecated. Use 2026-09-30-preview or a later supported API version."
  @summary("Deprecated API version. Use 2026-09-30-preview or a later supported API version.")
  @sharedRoute
  get is ArmResourceRead<DrillRunResource, ServiceGroupParameters>;

  @route(ServiceGroupRoute)
  #deprecated "API versions 2025-02-01-preview through 2026-08-31-preview are deprecated. Use 2026-09-30-preview or a later supported API version."
  @summary("Deprecated API version. Use 2026-09-30-preview or a later supported API version.")
  @sharedRoute
  list is ArmResourceListByParent<DrillRunResource, ServiceGroupParameters>;
}

@armResourceOperations
@doc("Operations for managing Drill Run resources.")
@added(Versions.v2026_09_30_preview)
interface DrillRunResources {
  @route(ServiceGroupRoute)
  @sharedRoute
  get is ArmResourceRead<DrillRunResource, ServiceGroupParameters>;

  @route(ServiceGroupRoute)
  @sharedRoute
  list is ArmResourceListByParent<DrillRunResource, ServiceGroupParameters>;
}

@armResourceOperations
@doc("Operations for managing Chaos jobs.")
@removed(Versions.v2026_04_01_preview)
interface ChaosJobs {
  @route(ServiceGroupRoute)
  #deprecated "ChaosJob operations are deprecated and removed in 2026-04-01-preview. They have no direct replacement in 2026-09-30-preview."
  @summary("Deprecated with no direct replacement in 2026-09-30-preview.")
  get is ArmResourceRead<ChaosJob, ServiceGroupParameters>;

  @route(ServiceGroupRoute)
  #deprecated "ChaosJob operations are deprecated and removed in 2026-04-01-preview. They have no direct replacement in 2026-09-30-preview."
  @summary("Deprecated with no direct replacement in 2026-09-30-preview.")
  list is ArmResourceListByParent<ChaosJob, ServiceGroupParameters>;
}

@armResourceOperations
@doc("Operations for managing Chaos job resources.")
@removed(Versions.v2026_04_01_preview)
interface ChaosJobResources {
  @route(ServiceGroupRoute)
  #deprecated "ChaosJobResource operations are deprecated and removed in 2026-04-01-preview. They have no direct replacement in 2026-09-30-preview."
  @summary("Deprecated with no direct replacement in 2026-09-30-preview.")
  get is ArmResourceRead<ChaosJobResource, ServiceGroupParameters>;

  @route(ServiceGroupRoute)
  #deprecated "ChaosJobResource operations are deprecated and removed in 2026-04-01-preview. They have no direct replacement in 2026-09-30-preview."
  @summary("Deprecated with no direct replacement in 2026-09-30-preview.")
  list is ArmResourceListByParent<ChaosJobResource, ServiceGroupParameters>;
}

@armResourceOperations
@doc("Operations for managing Chaos job child job.")
@removed(Versions.v2026_04_01_preview)
interface ChaosJobChildJobs {
  @route(ServiceGroupRoute)
  #deprecated "ChaosJobChildJob operations are deprecated and removed in 2026-04-01-preview. They have no direct replacement in 2026-09-30-preview."
  @summary("Deprecated with no direct replacement in 2026-09-30-preview.")
  get is ArmResourceRead<ChaosJobChildJob, ServiceGroupParameters>;

  @route(ServiceGroupRoute)
  #deprecated "ChaosJobChildJob operations are deprecated and removed in 2026-04-01-preview. They have no direct replacement in 2026-09-30-preview."
  @summary("Deprecated with no direct replacement in 2026-09-30-preview.")
  list is ArmResourceListByParent<ChaosJobChildJob, ServiceGroupParameters>;
}

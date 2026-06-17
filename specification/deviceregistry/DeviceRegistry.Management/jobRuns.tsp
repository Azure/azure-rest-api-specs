import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@typespec/openapi";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./common/provisioningState.tsp";
import "./jobs.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using TypeSpec.OpenAPI;
using Azure.ResourceManager;

namespace Microsoft.DeviceRegistry;

@added(Versions.v2026_11_02_preview)
@parentResource(Job)
@doc("Job run definition.")
model JobRun is ProxyResource<JobRunProperties> {
  @doc("The name of the job run.")
  @key("runName")
  @segment("runs")
  @pattern("^[a-z0-9][a-z0-9-]*[a-z0-9]$")
  @path
  @minLength(3)
  @maxLength(64)
  name: string;
}

@added(Versions.v2026_11_02_preview)
@doc("The job run properties.")
model JobRunProperties {
  @doc("Globally unique, immutable, non-reusable ID.")
  @visibility(Lifecycle.Read)
  uuid?: string;

  @doc("The status of the job run.")
  @visibility(Lifecycle.Read)
  status?: JobRunStatus;

  @doc("The reason the run was canceled. Present only when status is Canceled.")
  @visibility(Lifecycle.Read)
  cancellationReason?: JobRunCancellationReason;

  @doc("The scheduled time for the job run.")
  @visibility(Lifecycle.Read)
  scheduledTime?: utcDateTime;

  @doc("The start time of the job run.")
  @visibility(Lifecycle.Read)
  startTime?: utcDateTime;

  @doc("The end time of the job run.")
  @visibility(Lifecycle.Read)
  endTime?: utcDateTime;

  @doc("The results summary of the job run.")
  @visibility(Lifecycle.Read)
  results?: JobRunResults;

  @doc("Provisioning state of the resource.")
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

@added(Versions.v2026_11_02_preview)
@doc("The status of a job run.")
union JobRunStatus {
  string,

  @doc("The job run is scheduled.")
  Scheduled: "Scheduled",

  @doc("The job run is queued for dispatch and is consuming concurrency quota.")
  Queued: "Queued",

  @doc("The job run is actively executing.")
  Active: "Active",

  @doc("The job run completed successfully.")
  Succeeded: "Succeeded",

  @doc("The job run failed.")
  Failed: "Failed",

  @doc("The job run timed out before completing. Action/State jobs only; not applicable to Update jobs.")
  TimedOut: "TimedOut",

  @doc("The job run was canceled. See `cancellationReason` for the cause.")
  Canceled: "Canceled",
}

@added(Versions.v2026_11_02_preview)
@doc("The reason a job run was canceled. Present only when status is Canceled.")
union JobRunCancellationReason {
  string,

  @doc("The customer canceled the run via the cancel action.")
  CanceledByCustomer: "CanceledByCustomer",

  @doc("The run was canceled because another job superseded it. For an Update job this happens when another Update job targeting the same group is scheduled; for a RecoveryUpdate job this happens when another RecoveryUpdate job for the same compatible devices is scheduled.")
  CanceledByAnotherJob: "CanceledByAnotherJob",

  @doc("The run was canceled because the target group was deleted. This reason does not apply to RecoveryUpdate jobs, which do not target a group.")
  CanceledByGroupDelete: "CanceledByGroupDelete",
}

@added(Versions.v2026_11_02_preview)
@doc("The results summary of a job run.")
model JobRunResults {
  @doc("Total number of targets.")
  total?: int32;

  @doc("Number of targets that succeeded.")
  succeeded?: int32;

  @doc("Number of targets that failed.")
  failed?: int32;

  @doc("Number of targets currently in progress.")
  inProgress?: int32;

  @doc("Number of targets pending execution.")
  pending?: int32;

  @doc("Number of targets whose execution was canceled.")
  canceled?: int32;

  @doc("Number of targets the operation does not apply to. Update jobs only; computed by ADR as total - (succeeded + failed + inProgress + canceled).")
  notApplied?: int32;
}

@added(Versions.v2026_11_02_preview)
@doc("A single device result entry from a job run.")
model JobRunResultItem {
  @doc("The device UUID. ADR returns the device's stable UUID identifier (ADU surfaces device UUIDs in its private API; ADR re-emits them under this name to align with ADR-wide identifier conventions).")
  deviceUuid?: string;

  @doc("The current per-device status for this run.")
  status?: JobRunResultItemStatus;

  @doc("Short, machine-readable diagnostic that pairs with status. Present only when status is Failed; an ADU-provided machine-readable code (e.g. DOWNLOAD_FAILED). Omitted for all other statuses, including Succeeded and InProgress.")
  reason?: string;
}

@added(Versions.v2026_11_02_preview)
@doc("The per-device status of a single job run result entry.")
union JobRunResultItemStatus {
  string,

  @doc("The operation succeeded on the device.")
  Succeeded: "Succeeded",

  @doc("The operation failed on the device. See `reason` for an ADU-provided code.")
  Failed: "Failed",

  @doc("The operation is currently in progress on the device.")
  InProgress: "InProgress",

  @doc("The operation was canceled for the device.")
  Canceled: "Canceled",

  @doc("The operation does not apply to the device.")
  NotApplied: "NotApplied",
}

// NOTE: ADU's backing API supports filtering device-level results by a
// single state value. `status` is therefore a single-valued, optional
// query parameter (equality match) passed through to ADU -- not an OData
// `$filter`. Omitting it returns all device results unfiltered.
//
// NOTE (for review): the filter is typed as `string` (not the
// `JobRunResultItemStatus` union) on purpose. typespec-autorest leaks an
// invalid `readOnly: true` onto query parameters that are typed with a named
// union/enum, which fails swagger validation. Accepted values mirror
// `JobRunResultItemStatus`; they are documented below and validated by ADU.
@added(Versions.v2026_11_02_preview)
@doc("Optional query parameters for browsing job run results.")
model JobRunResultsFilterParameters {
  @query("status")
  @doc("When set, returns only device result entries whose status equals this value. Accepted values mirror JobRunResultItemStatus: Succeeded, Failed, InProgress, Canceled, NotApplied.")
  statusFilter?: string;
}

@added(Versions.v2026_11_02_preview)
@doc("The response for listing job run results.")
model JobRunResultListResponse {
  @doc("The list of device result entries.")
  @identifiers(#[])
  value: JobRunResultItem[];

  @doc("The link to the next page of results.")
  nextLink?: string;
}

@added(Versions.v2026_11_02_preview)
@armResourceOperations
interface JobRuns {
  get is ArmResourceRead<JobRun>;
  listByJob is ArmResourceListByParent<JobRun>;

  @doc("Browse the results of a job run to find individual device statuses.")
  results is ArmResourceActionSync<
    JobRun,
    void,
    JobRunResultListResponse,
    Parameters = JobRunResultsFilterParameters
  >;
}

// NOTE: A namespace-scoped aggregate list of job runs across every job in
// the namespace. JobRun's @parentResource is Job, so the standard
// ArmResourceListByParent (list by Job) cannot express this grandparent
// scope -- its parent-key extraction always includes `jobName`. It is
// therefore modeled as an explicit @get list routed at the namespace
// scope, in a plain interface so the ARM resource auto-routing does not
// re-derive the path from the resource's parent chain. It still returns
// the standard paged JobRun envelope (x-ms-pageable via nextLink).
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "Grandparent-scoped aggregate list of JobRun; cannot use the standard ARM list-by-parent template because JobRun's parent is Job, not Namespace."
@added(Versions.v2026_11_02_preview)
interface JobRunsByNamespace {
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "Custom grandparent-scoped list; not expressible via ArmResourceListByParent because parent-key extraction always includes jobName."
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "Explicit operationId keeps this namespace-scoped list in the JobRuns SDK operation group instead of a separate JobRunsByNamespace group."
  @doc("List job runs by namespace, across all jobs in the namespace.")
  @operationId("JobRuns_ListByNamespace")
  @get
  @list
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.DeviceRegistry/namespaces/{namespaceName}/jobRuns")
  listByNamespace(
    ...ApiVersionParameter,
    ...SubscriptionIdParameter,
    ...ResourceGroupParameter,

    @doc("The name of the namespace.")
    @path
    @minLength(3)
    @maxLength(64)
    @pattern("^[a-z0-9][a-z0-9-]*[a-z0-9]$")
    namespaceName: string,
  ): ArmResponse<ResourceListResult<JobRun>> | ErrorResponse;
}

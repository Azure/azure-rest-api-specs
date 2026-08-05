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
  @visibility(Lifecycle.Create, Lifecycle.Read)
  scheduledTime?: utcDateTime;

  @doc("The start time of the job run.")
  @visibility(Lifecycle.Read)
  startTime?: utcDateTime;

  @doc("The end time of the job run.")
  @visibility(Lifecycle.Read)
  endTime?: utcDateTime;

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

  @doc("The job run timed out before completing. Action/State jobs only; not applicable to SoftwareUpdate jobs.")
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

  @doc("The run was canceled because the target group was deleted. This reason does not apply to OnboardingUpdate jobs, which do not target a group.")
  CanceledByGroupDelete: "CanceledByGroupDelete",
}

@added(Versions.v2026_11_02_preview)
@doc("The results summary of a job run.")
model JobRunSummary {
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

  @doc("Number of targets the operation does not apply to. SoftwareUpdate jobs only; computed by ADR as total - (succeeded + failed + inProgress + canceled).")
  notApplied?: int32;
}

@added(Versions.v2026_11_02_preview)
@doc("A single device result entry from a job run.")
model JobRunResultItem {
  @doc("The resource type of the target this result entry describes, which determines which identifier property is populated. `Microsoft.DeviceRegistry/namespaces/registryDevices` for a registered ADR device (SoftwareUpdate job runs), identified by `resourceUuid`; `Microsoft.DeviceRegistry/namespaces/onboardingDevices` for an onboarding device served by an OnboardingUpdate job run, identified by `resourceExternalId`. Note: `onboardingDevices` is not yet a provisioned resource type; the value follows the resource type naming pattern.")
  resourceType?: JobRunResultResourceType;

  @doc("The ADR resource's ID. Populated when `resourceType` is `Microsoft.DeviceRegistry/namespaces/registryDevices`.")
  resourceId?: string;

  @doc("The ADR resource's stable UUID. Populated when `resourceType` is `Microsoft.DeviceRegistry/namespaces/registryDevices`.")
  resourceUuid?: string;

  @doc("The onboarding device's external identifier (`externalDeviceId`). Populated when `resourceType` is `Microsoft.DeviceRegistry/namespaces/onboardingDevices`, because an onboarding device doesn't have an ADR resource yet and therefore no resource UUID.")
  resourceExternalId?: string;

  @doc("The current per-device status for this run. One of: Succeeded, Failed, InProgress, Canceled, NotApplied.")
  status?: JobRunResultItemStatus;

  @doc("Short, machine-readable diagnostic that pairs with status. Present only when status is Failed; an ADU-provided machine-readable code (e.g. DOWNLOAD_FAILED). Omitted for all other statuses, including Succeeded and InProgress.")
  reason?: string;

  @doc("The detailed result of the update install attempt on the device, as reported by the device update agent. Carries the full breakdown (terminal outcome, failure origin, result codes, and per-step results) so the cause of a failure can be inspected directly from the job run results. Present when the device has reported an install result; omitted while the operation is still pending.")
  installResult?: InstallResult;
}

// The Azure Device Update install-result models (InstallResult, UpdateStepResult,
// InstallResultOutcome, InstallResultFailureOrigin) are shared with the device attribute
// payload and are defined in specification/deviceregistry/common/deviceAttributeTypes.tsp.
@@added(InstallResult, Versions.v2026_11_02_preview);
@@added(UpdateStepResult, Versions.v2026_11_02_preview);
@@added(InstallResultOutcome, Versions.v2026_11_02_preview);
@@added(InstallResultFailureOrigin, Versions.v2026_11_02_preview);

// Step results carry no identifying key.
@@identifiers(InstallResult.stepResults, #[]);

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

@added(Versions.v2026_11_02_preview)
@doc("The resource type of a job run result entry's target, which determines which identifier property (`resourceUuid` or `resourceExternalId`) is populated.")
union JobRunResultResourceType {
  string,

  @doc("A registered ADR device, identified by its stable device UUID (`resourceUuid`).")
  RegistryDevices: "Microsoft.DeviceRegistry/namespaces/registryDevices",

  @doc("An onboarding device with no ADR resource, identified by its onboarding device identifier (`externalDeviceId`), surfaced as `resourceExternalId`. Used for OnboardingUpdate job runs. Note: this is not yet a provisioned resource type; the value follows the resource type naming pattern.")
  OnboardingDevices: "Microsoft.DeviceRegistry/namespaces/onboardingDevices",
}

// NOTE: ADU's backing API supports filtering device-level results by a
// single state value. The filter is therefore an OData-style boolean
// expression over the result `status` field (e.g. "status eq 'Failed'"),
// aligned with the Azure API Guidelines `filter` convention. Omitting it
// returns all device results unfiltered. It is carried in the POST request
// body (not a query parameter) because ARM forbids POST/action operations
// from declaring query parameters other than `api-version`.
//
// NOTE (for review): accepted `status` values mirror `JobRunResultItemStatus`
// (Succeeded, Failed, InProgress, Canceled, NotApplied) and are validated by ADU.
@added(Versions.v2026_11_02_preview)
@doc("Optional request body for browsing job run results.")
model JobRunResultsRequest {
  @doc("An OData-style filter expression that selects which device result entries to return, aligned with the Azure API Guidelines `filter` convention. Currently supports equality on the result status, e.g. \"status eq 'Failed'\". Accepted status values mirror JobRunResultItemStatus: Succeeded, Failed, InProgress, Canceled, NotApplied. When omitted, all device results are returned.")
  filter?: string;

  @doc("An OData order by expression to sort the results. For example, \"status asc\" or \"status desc\".")
  orderBy?: string;

  #suppress "@azure-tools/typespec-azure-resource-manager/secret-prop" "This is a paging cursor, not a credential or secret."
  @doc("Opaque continuation token from a previous listResults response.")
  skipToken?: string;
}

@added(Versions.v2026_11_02_preview)
@doc("The response for listing job run results.")
model JobRunResultListResponse {
  @doc("The list of device result entries.")
  @identifiers(#[])
  value: JobRunResultItem[];

  #suppress "@azure-tools/typespec-azure-resource-manager/secret-prop" "This is a paging cursor, not a credential or secret."
  @doc("Opaque continuation token to use in the next listResults request, if more results remain after the requested page.")
  skipToken?: string;
}

@added(Versions.v2026_11_02_preview)
@armResourceOperations
interface JobRuns {
  createOrReplace is ArmResourceCreateOrReplaceAsync<JobRun>;
  get is ArmResourceRead<JobRun>;
  delete is ArmResourceDeleteWithoutOkAsync<JobRun>;

  listByJob is ArmResourceListByParent<
    JobRun,
    Foundations.BaseParameters<JobRun>,
    "",
    "",
    {
      @doc("An OData filter expression to restrict results by job run status. Supports equality on the status property, e.g. \"status eq 'Active'\", and logical OR for multiple statuses, e.g. \"status eq 'Active' or status eq 'Scheduled'\". Accepted status values: Scheduled, Queued, Active, Succeeded, Failed, TimedOut, Canceled. When omitted, all job runs are returned.")
      @query("$filter")
      filter?: string;

      @doc("An OData order by expression to sort the results. For example, \"status asc\" or \"status desc\".")
      @query("$orderBy")
      orderBy?: string;
    }
  >;

  @doc("Get a summary of the progress of a job run.")
  getSummary is ArmResourceActionSync<JobRun, void, JobRunSummary>;

  @doc("Browse the results of a job run to find individual device statuses.")
  listResults is ArmResourceActionSync<
    JobRun,
    JobRunResultsRequest,
    JobRunResultListResponse
  >;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-post-operation-response-codes" "The final response has no content, so 204 is returned."
  @doc("Cancel a job run.")
  cancel is ArmResourceActionNoContentAsync<JobRun, void>;
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

    @doc("An OData filter expression to restrict results by job run status. Supports equality on the status property, e.g. \"status eq 'Active'\", and logical OR for multiple statuses, e.g. \"status eq 'Active' or status eq 'Scheduled'\". Accepted status values: Scheduled, Queued, Active, Succeeded, Failed, TimedOut, Canceled. When omitted, all job runs are returned.")
    @query("$filter")
    filter?: string,

    @doc("An OData order by expression to sort the results. For example, \"status asc\" or \"status desc\".")
    @query("$orderBy")
    orderBy?: string,
  ): ArmResponse<ResourceListResult<JobRun>> | ErrorResponse;
}

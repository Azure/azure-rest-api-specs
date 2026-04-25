import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./common/provisioningState.tsp";
import "./jobs.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
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

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record"
  @doc("Internal metadata used to track polling and execution state.")
  @visibility(Lifecycle.Read)
  internalMetadata?: Record<string>;

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

  @doc("The job run is queued.")
  Queued: "Queued",

  @doc("The job run is running.")
  Running: "Running",

  @doc("The job run completed successfully.")
  Completed: "Completed",

  @doc("The job run failed.")
  Failed: "Failed",
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

  @doc("Number of targets currently running.")
  running?: int32;

  @doc("Number of targets pending execution.")
  pending?: int32;
}

@added(Versions.v2026_11_02_preview)
@doc("A single device result entry from a job run.")
model JobRunResultItem {
  @doc("The external device identifier.")
  externalDeviceId?: string;

  @doc("The status of the device for this job run.")
  status?: string;

  @doc("The reason for the status, typically used for failures.")
  reason?: string;
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
  results is ArmResourceActionSync<JobRun, void, JobRunResultListResponse>;
}

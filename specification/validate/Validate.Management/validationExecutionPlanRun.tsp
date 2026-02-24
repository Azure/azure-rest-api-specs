import "./common.tsp";
import "./validationExecutionPlan.tsp";
import "./validationTestRun.tsp";

using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;

namespace Microsoft.Validate;

@doc("The properties of the execution plan run.")
@parentResource(ValidationExecutionPlan)
model ExecutionPlanRun is ProxyResource<ExecutionPlanRunProperties> {
  ...ResourceNameParameter<ExecutionPlanRun>;
}

@doc("The properties of the execution plan run.")
model ExecutionPlanRunProperties {
  @doc("The description of the resource.")
  description?: string;

  @doc("The status of the execution plan run.")
  @visibility(Lifecycle.Read)
  @madeOptional(Versions.v2026_01_01_preview)
  status?: ExecutionPlanRunStatus;

  @doc("Error details. Populated when status is Failed, Canceled, TimedOut, or Aborted.")
  @visibility(Lifecycle.Read)
  @added(Versions.v2026_03_01_preview)
  error?: Azure.ResourceManager.Foundations.ErrorDetail;

  @doc("The start time of the execution plan run.")
  @visibility(Lifecycle.Read)
  @madeOptional(Versions.v2026_01_01_preview)
  startTimestampInUtc?: utcDateTime;

  @doc("The end time of the execution plan run.")
  @visibility(Lifecycle.Read)
  endTimestampInUtc?: utcDateTime;

  @doc("The reported timestamp of the execution plan run.")
  @visibility(Lifecycle.Read)
  @madeOptional(Versions.v2026_01_01_preview)
  reportedTimestampInUtc?: utcDateTime;

  @doc("The test runs under this execution plan run.")
  @visibility(Lifecycle.Read)
  @madeOptional(Versions.v2026_01_01_preview)
  @identifiers(#[])
  @maxItems(100)
  @typeChangedFrom(Versions.v2026_02_01_preview, ValidationTestRun[])
  testRuns?: ValidationTestRunDetails[];

  @doc("The provisioning state of the execution plan run.")
  @visibility(Lifecycle.Read)
  @typeChangedFrom(Versions.v2026_03_01_preview, ResourceProvisioningState)
  provisioningState?: ExecutionPlanRunProvisioningState;
}

@doc("The provisioning state of the execution plan run.")
@lroStatus
union ExecutionPlanRunProvisioningState {
  ResourceProvisioningState,

  @doc("The execution plan run is in progress.")
  Creating: "Creating",

  @doc("The execution plan run is running.")
  Running: "Running",

  @doc("The execution plan run is waiting.")
  Waiting: "Waiting",

  @doc("The execution plan run is partially executed.")
  Processing: "Processing",

  string,
}

@doc("The status of the execution plan run.")
@lroStatus
union ExecutionPlanRunStatus {
  @doc("The execution plan run is succeeded.")
  Succeeded: "Succeeded",

  @doc("The execution plan run is running.")
  Running: "Running",

  @doc("The execution plan run is canceled.")
  Canceled: "Canceled",

  @doc("The execution plan run is failed.")
  Failed: "Failed",

  @doc("The execution plan run is waiting.")
  Waiting: "Waiting",

  @doc("The execution plan run is skipped.")
  Skipped: "Skipped",

  @doc("The execution plan run is paused.")
  Paused: "Paused",

  @doc("The execution plan run is suspended.")
  Suspended: "Suspended",

  @doc("The execution plan run is timed out.")
  TimedOut: "TimedOut",

  @doc("The execution plan run is aborted.")
  Aborted: "Aborted",

  @doc("The execution plan run is ignored.")
  Ignored: "Ignored",

  @doc("The execution plan run is unknown.")
  Unknown: "Unknown",

  string,
}

@armResourceOperations
@tag("Validation Execution Plan Run Interfaces")
interface ValidationExecutionPlanRuns {
  @doc("Get a Validation test execution plan run details")
  get is ArmResourceRead<ExecutionPlanRun>;

  @doc("Create or update a validation test execution plan")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<ExecutionPlanRun>;

  @doc("Delete a validation test execution plan run resource")
  delete is ArmResourceDeleteWithoutOkAsync<ExecutionPlanRun>;

  @doc("List Validation test execution plan runs for an execution plan")
  listByExecutionPlan is ArmResourceListByParent<
    ExecutionPlanRun,
    Parameters = StandardListQueryParameters &
      OrderByQueryParameter &
      FilterQueryParameter
  >;
}

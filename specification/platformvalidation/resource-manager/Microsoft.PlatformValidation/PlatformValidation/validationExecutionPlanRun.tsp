import "./common.tsp";
import "./validationExecutionPlan.tsp";
import "./validationTestRun.tsp";

using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;

namespace Microsoft.PlatformValidation;

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
  status?: ExecutionPlanRunStatus;

  @doc("Error details. Populated when status is Failed, TimedOut, or Unknown.")
  @visibility(Lifecycle.Read)
  error?: Azure.ResourceManager.Foundations.ErrorDetail;

  @doc("The start time of the execution plan run.")
  @visibility(Lifecycle.Read)
  startedAt?: utcDateTime;

  @doc("The completion time of the execution plan run.")
  @visibility(Lifecycle.Read)
  completedAt?: utcDateTime;

  @doc("The time at which the execution result was reported.")
  @visibility(Lifecycle.Read)
  reportedAt?: utcDateTime;

  @doc("Summary of tests executed for this run.")
  @visibility(Lifecycle.Read)
  testRunSummary?: TestRunSummary;

  @doc("Snapshot of the execution plan configuration captured at trigger time.")
  @visibility(Lifecycle.Read)
  planConfigurationSnapshot?: string;

  @doc("The ARM resource IDs of the validation test runs (ValidationTestRun resources) executed as part of this execution plan run.")
  @visibility(Lifecycle.Read)
  testRunIds?: armResourceIdentifier<[
    {
      type: "Microsoft.PlatformValidation/cloudValidations/validationExecutionPlans/executionPlanRuns/validationTestRuns";
    }
  ]>[];

  @doc("The provisioning state of the execution plan run.")
  @visibility(Lifecycle.Read)
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

  @doc("The execution plan run has been queued.")
  Queued: "Queued",

  @doc("The execution plan run is running.")
  Running: "Running",

  @doc("The execution plan run is completed.")
  Completed: "Completed",

  @doc("The execution plan run is failed.")
  Failed: "Failed",

  @doc("The execution plan run is timed out.")
  TimedOut: "TimedOut",

  @doc("The execution plan run is unknown.")
  Unknown: "Unknown",

  string,
}

@doc("Execution summary details for a validation test run collection.")
model TestRunSummary {
  @doc("Total number of tests executed.")
  totalTests?: int32;

  @doc("Number of passed tests.")
  passedTests?: int32;

  @doc("Number of failed tests.")
  failedTests?: int32;

  @doc("Number of skipped tests.")
  skippedTests?: int32;

  @doc("Overall result for the execution plan run.")
  overallResult?: TestRunOverallResult;

  @doc("Human-readable summary message.")
  message?: string;
}

@doc("The overall result of a validation test run collection.")
union TestRunOverallResult {
  @doc("All tests passed.")
  Passed: "Passed",

  @doc("One or more tests failed.")
  Failed: "Failed",

  @doc("Some tests passed and some failed.")
  PartiallyPassed: "PartiallyPassed",

  string,
}

@armResourceOperations
@tag("Execution Plan Run Interfaces")
interface ExecutionPlanRuns {
  @doc("Get a Validation test execution plan run details")
  get is ArmResourceRead<ExecutionPlanRun>;

  @doc("Create or update a validation test execution plan")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<ExecutionPlanRun>;

  @doc("Delete a validation test execution plan run resource")
  delete is ArmResourceDeleteWithoutOkAsync<ExecutionPlanRun>;

  @doc("List Validation test execution plan runs for an execution plan")
  listByExecutionPlan is ArmResourceListByParent<
    ExecutionPlanRun,
    Parameters = OdataFilterQueryParameter
  >;
}

import "./common.tsp";
import "./validationExecutionPlan.tsp";

using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;

namespace Microsoft.PlatformValidation;

@doc("Validation Test Run represents execution instance(s) of a Validation Test instance under execution plan.")
@parentResource(ExecutionPlanRun)
model ValidationTestRun is ProxyResource<ValidationTestRunProperties> {
  ...ResourceNameParameter<ValidationTestRun>;
}

@doc("Validation Test Run properties.")
model ValidationTestRunProperties {
  @doc("The overall status of the test run.")
  @visibility(Lifecycle.Read)
  status?: ValidationTestRunStatus;

  @doc("Error details. Populated when status is Error.")
  @visibility(Lifecycle.Read)
  error?: Azure.ResourceManager.Foundations.ErrorDetail;

  @doc("The state of the test run.")
  @visibility(Lifecycle.Read)
  provisioningState?: ValidationTestRunProvisioningState;

  @doc("The start time of the test run.")
  @visibility(Lifecycle.Read)
  startedAt?: utcDateTime;

  @doc("The completion time of the test run.")
  @visibility(Lifecycle.Read)
  completedAt?: utcDateTime;

  @doc("The time at which the test run result was reported.")
  @visibility(Lifecycle.Read)
  reportedAt?: utcDateTime;

  @doc("The name of the validation test (ValidationTest resource name, not an ARM resource ID) in the validation test catalog.")
  testId?: string;

  @doc("The names of the validation test categories (ValidationTestCategory resource names, not ARM resource IDs) associated with this test run.")
  testCategoryIds?: string[];

  @doc("""
    Validation test run inputs json, conforming to the input contract declared by `ValidationTestInput` on the corresponding validation test.
    This value is returned as-is in get responses, so it must not contain credentials or other secrets.
    """)
  inputsJson?: string;

  @doc("Detailed pass information when the test passes.")
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  @maxItems(100)
  passDetails?: ValidationTestPassDetails[];

  @doc("Detailed failure information when the test fails.")
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  @maxItems(100)
  failureDetails?: ValidationTestFailureDetails[];
}

@doc("The provisioning state of the validation test run.")
@lroStatus
union ValidationTestRunProvisioningState {
  ResourceProvisioningState,

  @doc("The validation test run is in progress.")
  Running: "Running",

  string,
}

@doc("The overall status of the test run.")
union ValidationTestRunStatus {
  @doc("The test run is not running.")
  NotRunning: "NotRunning",

  @doc("The test run is scheduled.")
  Scheduled: "Scheduled",

  @doc("The test run is ready.")
  Ready: "Ready",

  @doc("The test run is running.")
  Running: "Running",

  @doc("The test run is completed.")
  Completed: "Completed",

  @doc("The test run is stopped.")
  Stopped: "Stopped",

  @doc("The test run is errored out.")
  Error: "Error",

  string,
}

@doc("Detailed information about test pass.")
model ValidationTestPassDetails {
  @doc("Result code categorizing the type of pass.")
  @visibility(Lifecycle.Read)
  resultCode?: string;

  @doc("test name which passed.")
  @visibility(Lifecycle.Read)
  testName?: string;

  @doc("Detailed information about the passed test.")
  @visibility(Lifecycle.Read)
  resultDetails?: string;
}

@doc("Detailed information about test failure.")
model ValidationTestFailureDetails {
  @doc("Error code categorizing the type of failure.")
  @visibility(Lifecycle.Read)
  errorCode?: string;

  @doc("Human-readable error message describing the failure.")
  @visibility(Lifecycle.Read)
  errorMessage?: string;

  @doc("Detailed information about the failure.")
  @visibility(Lifecycle.Read)
  details?: string;

  @doc("Additional diagnostic information.")
  @visibility(Lifecycle.Read)
  diagnosticInfo?: string;

  @doc("Suggested remediation steps for the customer.")
  @visibility(Lifecycle.Read)
  recommendedActions?: string[];
}

@armResourceOperations
@tag("Validation Test Run Interfaces")
interface ValidationTestRuns {
  @doc("Get a validation test run details")
  get is ArmResourceRead<ValidationTestRun>;

  @doc("Create or update a validation test run")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<ValidationTestRun>;

  @doc("Delete a validation test run")
  delete is ArmResourceDeleteWithoutOkAsync<ValidationTestRun>;

  @doc("List validation test runs for an execution plan run")
  listByExecutionPlanRun is ArmResourceListByParent<ValidationTestRun>;
}

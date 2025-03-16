import "@typespec/rest";
import "@typespec/http";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "./../models/common.tsp";

using TypeSpec.Rest;

namespace MdsSolution.CopilotService.Models;

@doc("Validate job Request")
@resource("validationJob")
model QueryValidationJobRequest {
  @key
  @visibility(Lifecycle.Read)
  @doc("The unique identifier of the test.")
  testName: string;
}

@doc("Validate job Request body")
model QueryValidationJobRequestBody {
  @doc("The test cases for validation.")
  testCases: QueryValidationTestCase[];

  @doc("run in the conversation context")
  runInConversationContext: Choice;
}

@doc("Test Case for validation job")
model QueryValidationTestCase {
  @doc("The natural language input for the test case.")
  ask?: string;

  @doc("The expected kql query for the test case.")
  expectedKqlQuery?: string;

  @doc("skip the test run")
  skip: Choice;
}

@doc("Validate Response")
model QueryValidationJobScheduleConfirmation {
  @doc("Test Name")
  testName: string;

  @doc("Test Run Id")
  runId: string;

  @doc("Test Run Status")
  status: OperationStatus;

  @doc("creation date")
  createdAt: utcDateTime;

  @doc("created by")
  createdBy: string;
}

@doc("Test Details Response")
@resource("validationJobDetails")
model QueryValidationJobDetails {
  @doc("Test Id")
  @key
  @visibility(Lifecycle.Update)
  testId: string;

  @doc("Test Run Status")
  testRunStatus: OperationStatus;

  @doc("Test Results")
  testResults: QueryValidationTestCaseResult[];
}

@doc("Test Case Result")
model QueryValidationTestCaseResult {
  @doc("The query to be asked.")
  ask: string;

  @doc("The expected KQL query.")
  expectedKqlQuery: string;

  @doc("The consolidated score of the test case.")
  consolidatedScore: int64 = 0;

  @doc("The status of the operation.")
  status: OperationStatus;

  @doc("The error message, if any.")
  errorMessage?: string;
}

@doc("Validate Test Response")
@resource("validationJob/runs")
model QueryValidationJobRun {
  @key
  @visibility(Lifecycle.Update)
  @doc("The unique identifier of the test.")
  testId: string;

  @doc("Date of test run")
  createdAt: string;

  @doc("Test owner")
  createdBy: string;
}

@doc("Operation Status")
union OperationStatus {
  @doc("The operation is Accepted.")
  Accepted: "Accepted",

  @doc("The operation is in progress.")
  InProgress: "InProgress",

  @doc("The operation encountered a transient failure.")
  TransientFailure: "TransientFailure",

  @doc("The operation succeeded.")
  Succeeded: "Succeeded",

  @doc("The operation failed.")
  Failed: "Failed",

  @doc("The operation is being deleted.")
  Deleting: "Deleting",

  @doc("The operation was canceled.")
  Canceled: "Canceled",

  @doc("The status of the operation is unknown.")
  Unknown: "Unknown",

  @doc("The operation was skipped.")
  Skipped: "Skipped",

  string,
}

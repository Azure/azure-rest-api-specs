import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;

namespace Playwright;

@doc("Model of a test run used for tracking purposes.")
@resource("test-runs")
@parentResource(Workspace)
model TestRun {
  @key("runId")
  @doc("The test run ID in GUID format.")
  @minLength(3)
  @maxLength(36)
  @pattern("[A-Za-z0-9]+(-[A-Za-z0-9]+)+")
  @visibility(Lifecycle.Read)
  id: string;

  @doc("The test run display name.")
  @minLength(1)
  @maxLength(200)
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  displayName: string;

  @doc("The test run creator's ID.")
  @visibility(Lifecycle.Read)
  creatorId: string;

  @doc("The test run creator's name.")
  @visibility(Lifecycle.Read)
  creatorName?: string;

  @doc("The test run configuration.")
  @visibility(Lifecycle.Read, Lifecycle.Create)
  config?: RunConfig;

  @doc("The test run CI configuration.")
  @visibility(Lifecycle.Read, Lifecycle.Create)
  ciConfig?: CiConfig;

  @doc("The test run summary.")
  @visibility(Lifecycle.Read)
  summary: RunSummary;
}

@doc("The run configuration.")
model RunConfig {
  @doc("The framework used for the test run.")
  @visibility(Lifecycle.Read, Lifecycle.Create)
  framework?: RunFramework;

  @doc("The SDK language used for the test run.")
  @visibility(Lifecycle.Read, Lifecycle.Create)
  sdkLanguage?: SDKLanguage;

  @doc("The maximum number of workers required for the test run.")
  @visibility(Lifecycle.Read, Lifecycle.Create)
  @minValue(1)
  @maxValue(500)
  maxWorkers?: int64;
}

@doc("The SDK language used for the test run.")
union SDKLanguage {
  string,

  @doc("JavaScript SDK")
  JAVASCRIPT: "JAVASCRIPT",

  @doc("TypeScript SDK")
  TYPESCRIPT: "TYPESCRIPT",

  @doc("C# SDK")
  CSHARP: "CSHARP",
}

@doc("The test run framework information.")
model RunFramework {
  @doc("The framework name.")
  @visibility(Lifecycle.Read, Lifecycle.Create)
  name?: string;

  @doc("The framework version.")
  @visibility(Lifecycle.Read, Lifecycle.Create)
  version?: string;

  @doc("The framework runner name.")
  @visibility(Lifecycle.Read, Lifecycle.Create)
  runnerName?: string;
}

@doc("The test run CI configuration.")
model CiConfig {
  @doc("The CI provider name.")
  @visibility(Lifecycle.Read, Lifecycle.Create)
  providerName?: string;

  @doc("The CI branch name.")
  @visibility(Lifecycle.Read, Lifecycle.Create)
  branch?: string;

  @doc("The CI commit author.")
  @visibility(Lifecycle.Read, Lifecycle.Create)
  author?: string;

  @doc("The CI commit ID.")
  @visibility(Lifecycle.Read, Lifecycle.Create)
  commitId?: string;

  @doc("The CI revision URL.")
  @visibility(Lifecycle.Read, Lifecycle.Create)
  revisionUrl?: string;
}

@doc("The test run summary.")
model RunSummary {
  @doc("The test run status.")
  @visibility(Lifecycle.Read)
  status: RunStatus;

  @doc("The test run billable time in milliseconds.")
  @visibility(Lifecycle.Read)
  billableTime?: int64;

  @doc("The total number of browser sessions allocated to the test run.")
  @visibility(Lifecycle.Read)
  numBrowserSessions?: int64;

  @doc("The highest number of browser sessions that were running concurrently during the test run.")
  @visibility(Lifecycle.Read)
  maxConcurrentBrowserSessions?: int64;

  @doc("The test run start time in UTC.")
  @visibility(Lifecycle.Read)
  startTime: utcDateTime;

  @doc("The test run end time in UTC.")
  @visibility(Lifecycle.Read)
  endTime?: utcDateTime;

  @doc("The test run duration in milliseconds.")
  @visibility(Lifecycle.Read)
  duration?: int64;

  @doc("The list of error messages corresponding to the test run.")
  @visibility(Lifecycle.Read)
  errorMessages?: Array<string>;
}

@doc("The test run status.")
union RunStatus {
  string,

  @doc("The test run is currently running.")
  RUNNING: "RUNNING",

  @doc("The test run has completed on the client side.")
  CLIENT_COMPLETE: "CLIENT_COMPLETE",

  @doc("The test run has completed on the server side.")
  SERVER_COMPLETE: "SERVER_COMPLETE",
}

// Operations ////////////////////

interface TestRuns {
  // TestRun Operations
  @doc("Creates or updates a test run for the workspace with the specified test run ID. Requires Bearer JWT access token provided by Entra ID or Playwright Service.")
  createOrUpdate is Operations.ResourceCreateOrUpdate<TestRun>;

  @doc("Lists test runs for the specified workspace ID. Supports OData query parameters such as $filter and $top. Default page size is 10. Use nextLink in response to fetch additional results. Requires Bearer JWT access token provided by Entra ID or Playwright Service.")
  list is Operations.ResourceList<TestRun>;
}

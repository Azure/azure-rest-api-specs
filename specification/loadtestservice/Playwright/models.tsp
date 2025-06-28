import "@typespec/rest";

using TypeSpec.Rest;

namespace Playwright;

// Models ////////////////////

@doc("Model of an access-token linked to a workspace.")
@resource("access-tokens")
@parentResource(Workspace)
model AccessToken {
  @key("accessTokenId")
  @doc("The access-token id in GUID format.")
  @minLength(3)
  @maxLength(36)
  @pattern("[A-Za-z0-9]+(-[A-Za-z0-9]+)+")
  @visibility(Lifecycle.Read)
  id: string;

  // Standard Azure Resource Name parameter regex pattern - https://azure.github.io/typespec-azure/docs/libraries/azure-resource-manager/reference/data-types/#Azure.ResourceManager.ResourceNameParameter
  @minLength(3)
  @maxLength(24)
  @pattern("^[a-zA-Z0-9-]{3,24}$")
  @doc("The access-token name.")
  @visibility(Lifecycle.Read, Lifecycle.Create)
  name: string;

  @doc("The access-token value in JWT format.")
  @visibility(Lifecycle.Read)
  jwtToken?: string;

  @doc("The access-token createdAt utcDateTime.")
  @visibility(Lifecycle.Read)
  createdAt: utcDateTime;

  @doc("The access-token expiryAt utcDateTime.")
  @visibility(Lifecycle.Read, Lifecycle.Create)
  expiryAt: utcDateTime;

  @doc("The access-token state - Active | Expired.")
  @visibility(Lifecycle.Read)
  state: AccessTokenState;
}

@doc("The access-token state.")
union AccessTokenState {
  string,

  @doc("The access-token is Active.")
  Active: "Active",

  @doc("The access-token is Expired.")
  Expired: "Expired",
}

@doc("The os to configure for remote script runs.")
union OS {
  string,

  @doc("Linux OS.")
  Linux: "Linux",

  @doc("Windows OS.")
  Windows: "Windows",
}

@doc("Playwright workspace is the parent resource for most of the other service resources.")
@resource("playwrightworkspaces")
model Workspace {
  @key("workspaceId")
  @doc("The workspace id in GUID format.")
  @maxLength(36)
  @minLength(3)
  @pattern("[A-Za-z0-9]+(-[A-Za-z0-9]+)+")
  @visibility(Lifecycle.Read)
  id: string;
}

@doc("Model of a test-run used for tracking purpose.")
@resource("test-runs")
@parentResource(Workspace)
model TestRun {
  @key("runId")
  @doc("The test-run id in GUID format.")
  @minLength(3)
  @maxLength(36)
  @pattern("[A-Za-z0-9]+(-[A-Za-z0-9]+)+")
  @visibility(Lifecycle.Read)
  id: string;

  @doc("The test-run display name.")
  @minLength(1)
  @maxLength(200)
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  displayName: string;

  @doc("The test-run creator's id.")
  @visibility(Lifecycle.Read)
  creatorId: string;

  @doc("The test-run creator's name.")
  @visibility(Lifecycle.Read)
  creatorName?: string;

  @doc("The test-run config.")
  @visibility(Lifecycle.Read, Lifecycle.Create)
  config?: RunConfig;

  @doc("The test-run CI Config.")
  @visibility(Lifecycle.Read, Lifecycle.Create)
  ciConfig?: CiConfig;

  @doc("The test-run summary.")
  @visibility(Lifecycle.Read)
  summary: RunSummary;
}

@doc("The run config.")
model RunConfig {
  @doc("The framework used for run.")
  @visibility(Lifecycle.Read, Lifecycle.Create)
  framework?: RunFramework;

  @doc("The SDK Language used for run.")
  @visibility(Lifecycle.Read, Lifecycle.Create)
  sdkLanguage?: SDKLanguage;

  @doc("The maximum number of workers required for the run.")
  @visibility(Lifecycle.Read, Lifecycle.Create)
  @minValue(1)
  @maxValue(500)
  maxWorkers?: int64;
}

@doc("The SDK Language used for run.")
union SDKLanguage {
  string,

  @doc("JAVASCRIPT SDK")
  JAVASCRIPT: "JAVASCRIPT",

  @doc("TYPESCRIPT SDK")
  TYPESCRIPT: "TYPESCRIPT",

  @doc("CSHARP SDK")
  CSHARP: "CSHARP",
}

@doc("The run framework.")
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

@doc("The run CI config.")
model CiConfig {
  @doc("The CI provider name.")
  @visibility(Lifecycle.Read, Lifecycle.Create)
  providerName?: string;

  @doc("The CI branch.")
  @visibility(Lifecycle.Read, Lifecycle.Create)
  branch?: string;

  @doc("The CI author.")
  @visibility(Lifecycle.Read, Lifecycle.Create)
  author?: string;

  @doc("The CI commit id.")
  @visibility(Lifecycle.Read, Lifecycle.Create)
  commitId?: string;

  @doc("The CI revision URL.")
  @visibility(Lifecycle.Read, Lifecycle.Create)
  revisionUrl?: string;
}

@doc("The run summary.")
model RunSummary {
  @doc("The run status.")
  @visibility(Lifecycle.Read)
  status: RunStatus;

  @doc("The run billable time.")
  @visibility(Lifecycle.Read)
  billableTime?: int64;

  @doc("The total number of browser sessions allocated to the run.")
  @visibility(Lifecycle.Read)
  numBrowserSessions?: int64;

  @doc("The highest number of browser sessions that were running at the same time during the run.")
  @visibility(Lifecycle.Read)
  maxConcurrentBrowserSessions?: int64;

  @doc("The run start time as utcDateTime.")
  @visibility(Lifecycle.Read)
  startTime: utcDateTime;

  @doc("The run end time as utcDateTime.")
  @visibility(Lifecycle.Read)
  endTime?: utcDateTime;

  @doc("The run duration.")
  @visibility(Lifecycle.Read)
  duration?: int64;

  @doc("The list of error messages corresponding to the run.")
  @visibility(Lifecycle.Read)
  errorMessages?: Array<string>;
}

@doc("The run status.")
union RunStatus {
  string,

  @doc("The run status is RUNNING")
  RUNNING: "RUNNING",

  @doc("The run status is CLIENT_COMPLETE")
  CLIENT_COMPLETE: "CLIENT_COMPLETE",

  @doc("The run status is SERVER_COMPLETE")
  SERVER_COMPLETE: "SERVER_COMPLETE",
}

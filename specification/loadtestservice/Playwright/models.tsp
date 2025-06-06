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
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  displayName: string;

  @doc("The test-run creator's id.")
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  creatorId: string;

  @doc("The test-run creator's name.")
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  creatorName: string;

  @doc("The test-run config.")
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  config: RunConfig;

  @doc("The test-run CI Config.")
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  ciConfig: CiConfig;

  @doc("The test-run summary.")
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  summary: RunSummary;
}

@doc("The run config.")
model RunConfig {
  @doc("The framework used for run.")
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  framework: RunFramework;

  @doc("The SDK Language used for run.")
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  sdkLanguage: string;
}

@doc("The run framework.")
model RunFramework {
  @doc("The framework name.")
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  name: string;

  @doc("The framework version.")
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  version: string;

  @doc("The framework runner name.")
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  runnerName: string;
}

@doc("The run CI config.")
model CiConfig {
  @doc("The CI provider name.")
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  providerName: string;

  @doc("The CI branch.")
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  branch: string;

  @doc("The CI author.")
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  author: string;

  @doc("The CI commit id.")
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  commitId: string;

  @doc("The CI revision URL.")
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  revisionUrl: string;
}

@doc("The run summary.")
model RunSummary {
  @doc("The run status.")
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  status: string;

  @doc("The run billable time.")
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  billableTime: int32;

  @doc("The number of browser sessions corresponding to the run.")
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  numBrowserSessions: int32;

  @doc("The list of jobs corresponding to the run.")
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  jobs: Array<string>;

  @doc("The list of projects corresponding to the run.")
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  projects: Array<string>;

  @doc("The list of tags corresponding to the run.")
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  tags: Array<string>;

  @doc("The run start time as utcDateTime.")
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  startTime: utcDateTime;

  @doc("The run end time as utcDateTime.")
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  endTime: utcDateTime;

  @doc("The run duration.")
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  duration: int32;

  @doc("The list of error messages corresponding to the run.")
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  errorMessages: Array<string>;
}

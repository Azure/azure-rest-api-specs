import "@typespec/rest";
import "./models.tsp";
import "@typespec/versioning";

using TypeSpec.Versioning;
using TypeSpec.Rest;

namespace Playwright;

@doc("Model of a browser session used for tracking purposes.")
@resource("browser-sessions")
@parentResource(Workspace)
model BrowserSession {
  @key("sessionId")
  @doc("The browser session ID in GUID format.")
  @minLength(3)
  @maxLength(36)
  @pattern("[A-Za-z0-9]+(-[A-Za-z0-9]+)+")
  @visibility(Lifecycle.Read)
  id: string;

  @doc("The protocol for the browser session.")
  @added(Versions.v2026_06_01_preview)
  protocol: BrowserSessionProtocol;

  @doc("The browser session display name.")
  @minLength(1)
  @maxLength(200)
  displayName: string;

  @doc("The browser session creator's ID.")
  @visibility(Lifecycle.Read)
  @madeOptional(Versions.v2026_06_01_preview)
  creatorId?: string;

  @doc("The browser session start time in UTC.")
  @visibility(Lifecycle.Read)
  startTime?: utcDateTime;

  @doc("The browser session end time in UTC.")
  @visibility(Lifecycle.Read)
  endTime?: utcDateTime;

  @doc("The browser session duration in milliseconds.")
  @visibility(Lifecycle.Read)
  durationInMilliseconds?: int64;

  @doc("The browser session status.")
  @visibility(Lifecycle.Read)
  @madeOptional(Versions.v2026_06_01_preview)
  status?: BrowserSessionStatus;

  @doc("The browser session source details.")
  @visibility(Lifecycle.Read)
  @madeOptional(Versions.v2026_06_01_preview)
  source?: BrowserSessionSource;

  @doc("The browser session browser type.")
  @visibility(Lifecycle.Read)
  @madeOptional(Versions.v2026_06_01_preview)
  browserType?: BrowserType;

  @doc("The browser session operating system.")
  @madeOptional(Versions.v2026_06_01_preview)
  operatingSystem?: OS;

  @doc("The region where the provisioned browser container is located.")
  @visibility(Lifecycle.Read)
  @added(Versions.v2026_06_01_preview)
  browserRegion?: string;

  @doc("The websocket endpoint that can be used to connect to the browser session.")
  @visibility(Lifecycle.Read)
  @added(Versions.v2026_06_01_preview)
  browserEndpoint?: string;

  @doc("The URL to view the live browser session.")
  @visibility(Lifecycle.Read)
  @added(Versions.v2026_06_01_preview)
  liveViewUrl?: string;
}

@doc("The browser session source details.")
model BrowserSessionSource {
  @doc("The browser session source ID, would be same as runId for test-runs.")
  @visibility(Lifecycle.Read)
  id: string;

  @doc("The browser session source type.")
  @visibility(Lifecycle.Read)
  type: BrowserSessionSourceType = BrowserSessionSourceType.Others;
}

@doc("The browser session status.")
union BrowserSessionStatus {
  string,

  @doc("The browser session is created.")
  Created: "Created",

  @doc("The browser session is currently active.")
  Active: "Active",

  @doc("The browser session has completed.")
  Completed: "Completed",

  @doc("The browser session has failed.")
  Failed: "Failed",
}

@doc("The protocol for the browser session.")
@added(Versions.v2026_06_01_preview)
union BrowserSessionProtocol {
  string,

  @doc("Chrome DevTools Protocol.")
  CDP: "cdp",
}

@doc("The browser session source type.")
union BrowserSessionSourceType {
  string,

  @doc("The browser session source is a Playwright Workspaces test run.")
  PlaywrightWorkspacesTestRun: "PlaywrightWorkspacesTestRun",

  @doc("The browser session source is a browser automation tool.")
  BrowserAutomationTool: "BrowserAutomationTool",

  @doc("The browser session source is of other types.")
  Others: "Others",
}

// Operations ////////////////////

interface BrowserSessions {
  // BrowserSession Operations
  @added(Versions.v2026_04_01_preview)
  @doc("Get a browser session for the specified session and workspace ID. Requires Bearer JWT access token provided by Entra ID.")
  get is Operations.ResourceRead<BrowserSession>;

  @added(Versions.v2026_04_01_preview)
  @doc("Lists browser sessions for the specified workspace ID. Supports OData query parameters such as $filter and $top. Default page size is 10. Use nextLink in response to fetch additional results. Requires Bearer JWT access token provided by Entra ID.")
  list is Operations.ResourceList<BrowserSession>;

  @added(Versions.v2026_06_01_preview)
  @doc("Creates or updates a browser session for the specified session and workspace ID. The sourceId and sourceType are supplied through request headers. Requires Bearer JWT access token provided by Entra ID.")
  createOrUpdate is Operations.ResourceCreateOrUpdate<BrowserSession>;
}

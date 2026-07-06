import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "@typespec/versioning";
import "./models.tsp";
import "./ConnectorGateway.tsp";
import "./ConnectorGatewayMcpServerConfig.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using TypeSpec.Versioning;

namespace Microsoft.Web;

@added(Versions.v2026_05_01_preview)
@doc("The state of a trigger configuration.")
union ConnectorGatewayTriggerState {
  string,

  @doc("The trigger is enabled and will fire on its schedule.")
  Enabled: "Enabled",

  @doc("The trigger is disabled and will not fire.")
  Disabled: "Disabled",
}

@added(Versions.v2026_05_01_preview)
@doc("Connection reference for a trigger configuration.")
model ConnectorGatewayTriggerConnectionDetails {
  @doc("The connector name (e.g., office365).")
  connectorName?: string;

  @doc("The name of the connection to use.")
  connectionName?: string;
}

@added(Versions.v2026_05_01_preview)
@doc("HTTP method for trigger notification callbacks.")
union TriggerNotificationHttpMethod {
  string,

  @doc("HTTP GET method.")
  GET: "GET",

  @doc("HTTP POST method.")
  POST: "POST",

  @doc("HTTP PUT method.")
  PUT: "PUT",

  @doc("HTTP PATCH method.")
  PATCH: "PATCH",

  @doc("HTTP DELETE method.")
  DELETE: "DELETE",
}

@added(Versions.v2026_05_01_preview)
@doc("Callback configuration for push notifications fired by a trigger.")
model ConnectorGatewayTriggerNotificationDetails {
  @doc("Required. URL that receives push notifications.")
  callbackUrl?: string;

  @doc("HTTP method for the callback. Defaults to POST.")
  httpMethod?: TriggerNotificationHttpMethod;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Free-form authentication configuration; shape varies by callback target."
  @doc("Authentication configuration for the callback.")
  authentication?: Record<unknown>;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Free-form body template; shape varies by callback target."
  @doc("Optional body template for the callback.")
  body?: Record<unknown>;
}

@added(Versions.v2026_05_01_preview)
@doc("""
  Trigger type for standalone (non-connector) triggers. Use NotSpecified for
  connector-based triggers (the default).
  """)
union ConnectorGatewayTriggerType {
  string,

  @doc("Default value used by connector-based triggers.")
  NotSpecified: "NotSpecified",

  @doc("Recurrence trigger.")
  Recurrence: "Recurrence",

  @doc("Sliding-window trigger.")
  SlidingWindow: "SlidingWindow",
}

@added(Versions.v2026_05_01_preview)
@doc("How often a recurrence trigger fires.")
union TriggerRecurrenceFrequency {
  string,

  @doc("Frequency is not specified.")
  NotSpecified: "NotSpecified",

  @doc("Fire every N seconds.")
  Second: "Second",

  @doc("Fire every N minutes.")
  Minute: "Minute",

  @doc("Fire every N hours.")
  Hour: "Hour",

  @doc("Fire every N days.")
  Day: "Day",

  @doc("Fire every N weeks.")
  Week: "Week",

  @doc("Fire every N months.")
  Month: "Month",

  @doc("Fire every N years.")
  Year: "Year",
}

@added(Versions.v2026_05_01_preview)
@doc("Recurrence configuration for Recurrence and SlidingWindow trigger types.")
model TriggerRecurrence {
  @doc("How often the trigger fires.")
  frequency: TriggerRecurrenceFrequency;

  @doc("Number of frequency units between firings.")
  @minValue(1)
  interval: int32;

  @doc("IANA time zone name (e.g., America/Los_Angeles).")
  timeZone?: string;

  @doc("First firing time. Subsequent firings derived from frequency + interval.")
  startTime?: utcDateTime;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Free-form schedule shape mirroring Logic Apps JobRecurrenceSchedule."
  @doc("""
    Optional fine-grained recurrence schedule (hours, minutes, week days,
    etc.). Mirrors the Logic Apps JobRecurrenceSchedule.
    """)
  schedule?: Record<unknown>;
}

@added(Versions.v2026_05_01_preview)
@doc("A trigger condition expression.")
model TriggerCondition {
  @doc("""
    Workflow expression evaluated against trigger outputs. Must start with `@`.
    The trigger fires only when **all** conditions evaluate to true.
    """)
  expression: string;
}

@added(Versions.v2026_05_01_preview)
@doc("Trigger configuration settings.")
model TriggerConfigSettings {
  @doc("""
    When true, the runtime does not apply splitOn to batch trigger payloads —
    the entire payload is delivered as a single run. When false or null
    (default), the runtime auto-injects a splitOn expression derived from the
    swagger response schema so each element of the batch becomes its own run.
    """)
  disableSplitOn?: boolean;
}

@added(Versions.v2026_05_01_preview)
@doc("The properties of a trigger configuration.")
model ConnectorGatewayTriggerConfigProperties {
  @doc("The provisioning state of the trigger configuration.")
  @visibility(Lifecycle.Read)
  provisioningState?: Azure.ResourceManager.ResourceProvisioningState;

  @doc("The state of the trigger configuration.")
  state?: ConnectorGatewayTriggerState;

  @doc("Free-form description of the trigger configuration.")
  description?: string;

  @doc("Connection reference for the trigger.")
  connectionDetails?: ConnectorGatewayTriggerConnectionDetails;

  @doc("Trigger operation ID from the connector swagger.")
  operationName?: string;

  @doc("Operation-specific parameters.")
  @identifiers(#["name"])
  parameters?: OperationParameter[];

  @doc("Callback configuration for push notifications.")
  notificationDetails?: ConnectorGatewayTriggerNotificationDetails;

  @doc("Trigger type for standalone (non-connector) triggers.")
  triggerType?: ConnectorGatewayTriggerType;

  @doc("Recurrence configuration for Recurrence and SlidingWindow trigger types.")
  recurrence?: TriggerRecurrence;

  @doc("""
    Maximum delay before processing each time window. ISO-8601 duration
    (e.g., PT5M). Applies to SlidingWindow triggers.
    """)
  delay?: duration;

  @doc("Conditions evaluated against trigger outputs. All must be true for a run to be created.")
  @identifiers(#["expression"])
  conditions?: TriggerCondition[];

  @doc("Trigger configuration settings.")
  settings?: TriggerConfigSettings;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Free-form metadata payload; no schema enforced by the gateway."
  @doc("Arbitrary JSON metadata attached to the trigger configuration. No schema is enforced.")
  metadata?: Record<unknown>;
}

@added(Versions.v2026_05_01_preview)
@parentResource(ConnectorGateway)
@doc("A trigger configuration under a connector gateway.")
model ConnectorGatewayTriggerConfig
  is Azure.ResourceManager.ProxyResource<ConnectorGatewayTriggerConfigProperties> {
  @key("triggerConfigName")
  @segment("triggerConfigs")
  @doc("The name of the trigger configuration.")
  @path
  @pattern("^[a-zA-Z0-9_.()-]{1,79}$")
  name: string;
}

@added(Versions.v2026_05_01_preview)
@doc("""
  The status of a workflow run or trigger history entry. Maps 1:1 to the
  backend Microsoft.Azure.Workflows.Common.Entities.FlowStatus enum.
  """)
union FlowStatus {
  string,

  @doc("Status is not specified.")
  NotSpecified: "NotSpecified",

  @doc("The run is paused.")
  Paused: "Paused",

  @doc("The run is currently running.")
  Running: "Running",

  @doc("The run is waiting for input.")
  Waiting: "Waiting",

  @doc("The run completed successfully.")
  Succeeded: "Succeeded",

  @doc("The run was skipped.")
  Skipped: "Skipped",

  @doc("The run is suspended.")
  Suspended: "Suspended",

  @doc("The run was cancelled.")
  Cancelled: "Cancelled",

  @doc("The run failed.")
  Failed: "Failed",

  @doc("The run faulted.")
  Faulted: "Faulted",

  @doc("The run timed out.")
  TimedOut: "TimedOut",

  @doc("The run was aborted.")
  Aborted: "Aborted",

  @doc("The run was ignored.")
  Ignored: "Ignored",

  @doc("The run was deleted.")
  Deleted: "Deleted",

  @doc("The run was terminated.")
  Terminated: "Terminated",

  @doc("The run was handed off.")
  HandedOff: "HandedOff",
}

@added(Versions.v2026_05_01_preview)
@doc("A single workflow run created by a trigger configuration.")
model ConnectorGatewayRun {
  @doc("The run identifier (flow run sequence ID).")
  id?: string;

  @doc("When the run started.")
  startTime?: utcDateTime;

  @doc("When the run reached a terminal status. Null while the run is still in progress.")
  endTime?: utcDateTime;

  @doc("Current status of the run.")
  status?: FlowStatus;

  @doc("Status code reported by the run (e.g., HTTP status of the notification action).")
  statusCode?: string;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Free-form error payload from the failed run."
  @doc("Error payload from the failed run, when applicable. Free-form JSON.")
  error?: Record<unknown>;
}

@added(Versions.v2026_05_01_preview)
@doc("Trigger-side details for a run.")
model ConnectorGatewayRunTriggerDetails {
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Free-form trigger output payload; shape depends on the trigger operation."
  @doc("""
    The trigger output payload (free-form JSON). The headers property on the
    underlying outputs is stripped before being returned to avoid exposing
    internal HTTP headers.
    """)
  outputs?: Record<unknown>;
}

@added(Versions.v2026_05_01_preview)
@doc("Notification action details for a run.")
model ConnectorGatewayRunNotificationDetails {
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Free-form input payload from the notification action."
  @doc("The notification action input payload (free-form JSON).")
  inputs?: Record<unknown>;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Free-form output payload from the notification action."
  @doc("The notification action output payload (free-form JSON).")
  outputs?: Record<unknown>;
}

@added(Versions.v2026_05_01_preview)
@doc("Full details for a single trigger run.")
model ConnectorGatewayRunDetails {
  @doc("Trigger-side details for the run.")
  trigger?: ConnectorGatewayRunTriggerDetails;

  @doc("Notification action details. Null when no notification action ran for this run.")
  notification?: ConnectorGatewayRunNotificationDetails;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "Trigger runs are read-only execution records and intentionally omit provisioningState."
@added(Versions.v2026_05_01_preview)
@doc("Properties of a single trigger run.")
model ConnectorGatewayTriggerRunProperties {
  @doc("Run summary information.")
  summary?: ConnectorGatewayRun;

  @doc("Full run details. Returned by the GET operation.")
  details?: ConnectorGatewayRunDetails;
}

@added(Versions.v2026_05_01_preview)
@parentResource(ConnectorGatewayTriggerConfig)
@doc("A single execution (run) of a trigger configuration.")
model ConnectorGatewayTriggerRun
  is Azure.ResourceManager.ProxyResource<ConnectorGatewayTriggerRunProperties> {
  @key("runId")
  @segment("runs")
  @doc("The run identifier.")
  @path
  @pattern("^[a-zA-Z0-9_.()-]{1,79}$")
  name: string;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "Trigger status is a read-only diagnostic snapshot and intentionally omits provisioningState."
@added(Versions.v2026_05_01_preview)
@doc("Summary of the most recent execution of a trigger configuration's trigger.")
model ConnectorGatewayTriggerStatusProperties {
  @doc("When the last trigger execution started.")
  lastExecutionStartTime?: utcDateTime;

  @doc("When the last trigger execution reached a terminal status.")
  lastExecutionEndTime?: utcDateTime;

  @doc("Status of the last trigger execution.")
  lastExecutionStatus?: FlowStatus;

  @doc("Status code reported by the last trigger execution.")
  lastExecutionStatusCode?: string;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Free-form error payload from the last failed execution."
  @doc("Error payload from the last failed trigger execution. Free-form JSON.")
  lastExecutionError?: Record<unknown>;

  @doc("""
    Whether the last execution actually fired a workflow run. False if the
    trigger was skipped (no new data) or failed before producing a run.
    """)
  lastExecutionIsFired?: boolean;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Free-form trigger output payload from the last execution."
  @doc("""
    The trigger output payload from the last execution (free-form JSON). The
    headers property is stripped before being returned to avoid exposing
    internal HTTP headers.
    """)
  lastExecutionOutputs?: Record<unknown>;
}

@added(Versions.v2026_05_01_preview)
@parentResource(ConnectorGatewayTriggerConfig)
@doc("A trigger execution status entry for a connector gateway trigger configuration.")
model ConnectorGatewayTriggerStatus
  is Azure.ResourceManager.ProxyResource<ConnectorGatewayTriggerStatusProperties> {
  @key("triggerStatusName")
  @segment("triggerStatuses")
  @doc("The trigger status entry name.")
  @path
  @pattern("^[a-zA-Z0-9_.()-]{1,79}$")
  name: string;
}

@added(Versions.v2026_05_01_preview)
@armResourceOperations
@doc("The operations of connector gateway trigger configurations.")
interface ConnectorGatewayTriggerConfigs {
  get is ArmResourceRead<ConnectorGatewayTriggerConfig>;
  createOrUpdate is ArmResourceCreateOrReplaceSync<ConnectorGatewayTriggerConfig>;
  delete is ArmResourceDeleteSync<ConnectorGatewayTriggerConfig>;
  listByConnectorGateway is ArmResourceListByParent<ConnectorGatewayTriggerConfig>;
}

@added(Versions.v2026_05_01_preview)
@armResourceOperations
@doc("Read operations for trigger runs under a trigger configuration.")
interface ConnectorGatewayTriggerRuns {
  get is ArmResourceRead<ConnectorGatewayTriggerRun>;
  listByTriggerConfig is ArmResourceListByParent<ConnectorGatewayTriggerRun>;
}

@added(Versions.v2026_05_01_preview)
@armResourceOperations
@doc("Read operations for trigger execution status entries.")
interface ConnectorGatewayTriggerStatuses {
  get is ArmResourceRead<ConnectorGatewayTriggerStatus>;
  listByTriggerConfig is ArmResourceListByParent<ConnectorGatewayTriggerStatus>;
}

import "../common/models.tsp";
import "../servicepatterns.tsp";

using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Azure.AI.Projects;

const RoutineRequiredPreviews = #{
  conditional_previews: #[FoundryFeaturesOptInKeys.routines_v1_preview],
};

@doc("The discriminator values supported for routine triggers.")
@extension("x-ms-foundry-meta", RoutineRequiredPreviews)
union RoutineTriggerType {
  string,

  @doc("A custom routine trigger.")
  custom: "custom",

  @doc("A GitHub issue trigger.")
  github_issue: "github_issue",

  @doc("A recurring cron-based trigger.")
  schedule: "schedule",

  @doc("A one-shot timer trigger.")
  timer: "timer",
}

@doc("The GitHub issue events supported for routine triggers.")
@extension("x-ms-foundry-meta", RoutineRequiredPreviews)
union GitHubIssueEvent {
  string,

  @doc("Fires when an issue is opened.")
  opened: "opened",

  @doc("Fires when an issue is closed.")
  closed: "closed",
}

@doc("The discriminator values supported for routine actions.")
@extension("x-ms-foundry-meta", RoutineRequiredPreviews)
union RoutineActionType {
  string,

  @doc("Dispatches through the responses API.")
  invoke_agent_responses_api: "invoke_agent_responses_api",

  @doc("Dispatches through the raw invocations API.")
  invoke_agent_invocations_api: "invoke_agent_invocations_api",
}

@doc("The discriminator values supported for manual routine dispatch payloads.")
@extension("x-ms-foundry-meta", RoutineRequiredPreviews)
union RoutineDispatchPayloadType {
  string,

  @doc("A manual payload for a responses API routine dispatch.")
  invoke_agent_responses_api: "invoke_agent_responses_api",

  @doc("A manual payload for an invocations API routine dispatch.")
  invoke_agent_invocations_api: "invoke_agent_invocations_api",
}

@doc("Known source paths that can produce a routine run.")
@extension("x-ms-foundry-meta", RoutineRequiredPreviews)
union RoutineAttemptSource {
  string,

  @doc("A dispatch fired from an event delivery.")
  event_fire: "event_fire",

  @doc("A dispatch executed synchronously by a direct request.")
  manual_dispatch: "manual_dispatch",

  @doc("A dispatch executed asynchronously from the dispatch queue.")
  queued_dispatch: "queued_dispatch",

  @doc("A dispatch fired from a schedule delivery.")
  schedule_delivery: "schedule_delivery",

  @doc("A dispatch fired from a timer delivery.")
  timer_delivery: "timer_delivery",
}

@doc("Known lifecycle phases recorded for a routine run.")
@extension("x-ms-foundry-meta", RoutineRequiredPreviews)
union RoutineRunPhase {
  string,

  @doc("The run is queued for dispatch.")
  queued: "queued",

  @doc("The run is currently being dispatched.")
  dispatching: "dispatching",

  @doc("The run finished successfully.")
  completed: "completed",

  @doc("The run finished with an error.")
  failed: "failed",
}

alias RoutineTriggers = Record<RoutineTrigger>;

@doc("Base model for a routine trigger.")
@discriminator("type")
@extension("x-ms-foundry-meta", RoutineRequiredPreviews)
model RoutineTrigger {
  @doc("The trigger type.")
  type: RoutineTriggerType;
}

@doc("A recurring cron-based routine trigger.")
@extension("x-ms-foundry-meta", RoutineRequiredPreviews)
model ScheduleRoutineTrigger extends RoutineTrigger {
  @doc("The trigger type.")
  type: RoutineTriggerType.schedule;

  @doc("A 5-field cron expression. The service enforces a minimum interval of five minutes by default.")
  cron_expression: string;

  @doc("An IANA or Windows time zone identifier for the schedule.")
  time_zone: string;
}

@doc("A one-shot timer routine trigger.")
@extension("x-ms-foundry-meta", RoutineRequiredPreviews)
model TimerRoutineTrigger extends RoutineTrigger {
  @doc("The trigger type.")
  type: RoutineTriggerType.timer;

  @doc("A future timer expression. Supported values include an ISO-8601 timestamp with an explicit offset, a local timestamp paired with time_zone, or a positive duration from now.")
  in: string;

  @doc("An optional IANA or Windows time zone identifier when the timer uses a local timestamp.")
  time_zone?: string;
}

@doc("A GitHub issue routine trigger.")
@extension("x-ms-foundry-meta", RoutineRequiredPreviews)
model GitHubIssueRoutineTrigger extends RoutineTrigger {
  @doc("The trigger type.")
  type: RoutineTriggerType.github_issue;

  @doc("The workspace connection identifier that resolves the GitHub configuration for the trigger.")
  @maxLength(256)
  connection_id: string;

  @doc("The GitHub repository owner or organization that scopes which issues can fire the trigger.")
  @maxLength(128)
  owner: string;

  @doc("The GitHub repository filter that scopes which issues can fire the trigger.")
  @maxLength(128)
  repository: string;

  @doc("The GitHub issue event that can fire the trigger.")
  issue_event: GitHubIssueEvent;
}

@doc("A custom routine trigger.")
@extension("x-ms-foundry-meta", RoutineRequiredPreviews)
model CustomRoutineTrigger extends RoutineTrigger {
  @doc("The trigger type.")
  type: RoutineTriggerType.custom;

  @doc("The provider or source identifier for the custom trigger.")
  @maxLength(128)
  provider: string;

  @doc("An optional provider-specific event name for the custom trigger.")
  @maxLength(128)
  event_name?: string;

  @doc("Provider-specific parameters for the custom trigger.")
  parameters: Record<unknown>;
}

@doc("Base model for a routine action.")
@discriminator("type")
@extension("x-ms-foundry-meta", RoutineRequiredPreviews)
model RoutineAction {
  @doc("The action type.")
  type: RoutineActionType;
}

@doc("Dispatches a routine through the responses API. Exactly one of agent_name or agent_endpoint_id must be provided.")
@extension("x-ms-foundry-meta", RoutineRequiredPreviews)
model InvokeAgentResponsesApiRoutineAction extends RoutineAction {
  @doc("The action type.")
  type: RoutineActionType.invoke_agent_responses_api;

  @doc("The project-scoped agent name for responses API dispatch.")
  @maxLength(256)
  agent_name?: string;

  @doc("The endpoint-scoped agent identifier for responses API dispatch.")
  @maxLength(256)
  agent_endpoint_id?: string;

  @doc("An optional existing conversation identifier to continue during the downstream dispatch.")
  @maxLength(256)
  conversation?: string;
}

@doc("Dispatches a routine through the raw invocations API.")
@extension("x-ms-foundry-meta", RoutineRequiredPreviews)
model InvokeAgentInvocationsApiRoutineAction extends RoutineAction {
  @doc("The action type.")
  type: RoutineActionType.invoke_agent_invocations_api;

  @doc("The endpoint-scoped agent identifier for invocations API dispatch.")
  @maxLength(256)
  agent_endpoint_id: string;

  @doc("An optional existing hosted-agent session identifier to continue during the downstream dispatch.")
  @maxLength(256)
  session_id?: string;
}

@doc("A routine definition returned by the service.")
@extension("x-ms-foundry-meta", RoutineRequiredPreviews)
model Routine {
  @doc("The routine name.")
  @maxLength(128)
  name: string;

  @doc("A human-readable description of the routine.")
  @maxLength(1024)
  description?: string;

  @doc("Whether the routine is enabled.")
  enabled: boolean;

  @doc("The triggers configured for the routine.")
  triggers: RoutineTriggers;

  @doc("The action executed when the routine fires.")
  action: RoutineAction;

  @doc("The time when the routine was created.")
  created_at?: FoundryTimestamp;

  @doc("The time when the routine was last updated.")
  updated_at?: FoundryTimestamp;
}

@doc("The request body used to create or update a routine.")
@extension("x-ms-foundry-meta", RoutineRequiredPreviews)
model RoutineCreateOrUpdateRequest {
  @doc("A human-readable description of the routine.")
  @maxLength(1024)
  description?: string;

  @doc("Whether the routine is enabled.")
  enabled?: boolean;

  @doc("The triggers configured for the routine. In v1, exactly one trigger entry is supported.")
  triggers: RoutineTriggers;

  @doc("The action executed when the routine fires.")
  action: RoutineAction;
}

@doc("Base model for a manual dispatch payload.")
@discriminator("type")
@extension("x-ms-foundry-meta", RoutineRequiredPreviews)
model RoutineDispatchPayload {
  @doc("The manual dispatch payload type.")
  type: RoutineDispatchPayloadType;
}

@doc("A manual payload used to test a responses API routine dispatch.")
@extension("x-ms-foundry-meta", RoutineRequiredPreviews)
model InvokeAgentResponsesApiDispatchPayload extends RoutineDispatchPayload {
  @doc("The manual dispatch payload type.")
  type: RoutineDispatchPayloadType.invoke_agent_responses_api;

  @doc("The user input sent to the downstream responses target.")
  @maxLength(32768)
  input?: string;
}

@doc("A manual payload used to test an invocations API routine dispatch.")
@extension("x-ms-foundry-meta", RoutineRequiredPreviews)
model InvokeAgentInvocationsApiDispatchPayload extends RoutineDispatchPayload {
  @doc("The manual dispatch payload type.")
  type: RoutineDispatchPayloadType.invoke_agent_invocations_api;

  @doc("The raw input sent to the downstream invocations target.")
  @maxLength(32768)
  input?: string;
}

@doc("Request body for the public dispatch_async route.")
@extension("x-ms-foundry-meta", RoutineRequiredPreviews)
model DispatchRoutineRequest {
  @doc("A direct action-input override sent downstream when testing a routine.")
  payload?: RoutineDispatchPayload;
}

@doc("Identifiers returned after a routine dispatch is queued.")
@extension("x-ms-foundry-meta", RoutineRequiredPreviews)
model DispatchRoutineResponse {
  @doc("The dispatch identifier created for the routine dispatch.")
  dispatch_id?: string;

  @doc("A downstream action correlation identifier, when available.")
  action_correlation_id?: string;

  @doc("A workspace task identifier created for the dispatch, when available.")
  task_id?: string;
}

@doc("Paged response for listing routines.")
@extension("x-ms-foundry-meta", RoutineRequiredPreviews)
model RoutineListResponse {
  @doc("The current page of routines.")
  @pageItems
  value: Routine[];

  @doc("A continuation token for fetching the next page, when available.")
  @continuationToken
  continuationToken?: string;
}

@doc("Paged response for listing routine runs.")
@extension("x-ms-foundry-meta", RoutineRequiredPreviews)
model RoutineRunsResponse {
  @doc("The current page of routine runs.")
  @pageItems
  value: RoutineRun[];

  @doc("A continuation token for fetching the next page of run history, when available.")
  @continuationToken
  nextPageToken?: string;
}

@doc("Generic diagnostics captured on a routine run.")
@extension("x-ms-foundry-meta", RoutineRequiredPreviews)
model RoutineRunDiagnostics {
  @doc("MLflow parameters recorded on the run, keyed by parameter name.")
  parameters: Record<string>;

  @doc("MLflow tags recorded on the run, keyed by tag name.")
  tags: Record<string>;

  @doc("Latest MLflow metric values recorded on the run, keyed by metric name.")
  metrics: Record<float64>;
}

@doc("A single routine run returned from the run history API.")
@extension("x-ms-foundry-meta", RoutineRequiredPreviews)
model RoutineRun {
  @doc("The MLflow run identifier for the routine attempt.")
  id: string;

  @doc("The underlying MLflow run status.")
  status: string;

  @doc("The AgentExtensions lifecycle phase for the routine attempt.")
  phase?: RoutineRunPhase;

  @doc("The trigger type that produced the routine attempt.")
  trigger_type: RoutineTriggerType;

  @doc("The trigger name that produced the routine attempt.")
  trigger_name?: string;

  @doc("The source path that created the routine attempt.")
  attempt_source?: RoutineAttemptSource;

  @doc("The action type dispatched for the routine attempt.")
  action_type?: RoutineActionType;

  @doc("The project agent identifier targeted by the routine action, when applicable.")
  agent_id?: string;

  @doc("The agent endpoint identifier targeted by the routine action, when applicable.")
  agent_endpoint_id?: string;

  @doc("The responses conversation identifier supplied to the routine action, when applicable.")
  conversation_id?: string;

  @doc("The invocations session identifier supplied to the routine action, when applicable.")
  session_id?: string;

  @doc("The logical trigger time recorded for the routine attempt.")
  triggered_at?: FoundryTimestamp;

  @doc("The scheduled fire time for scheduler-backed attempts, when available.")
  scheduled_fire_at?: FoundryTimestamp;

  @doc("The trigger time zone from the routine definition, when available.")
  trigger_time_zone?: string;

  @doc("The time when the underlying run started.")
  started_at: FoundryTimestamp;

  @doc("The time when the underlying run reached a terminal state.")
  ended_at?: FoundryTimestamp;

  @doc("The dispatch identifier associated with the routine attempt.")
  dispatch_id?: string;

  @doc("The downstream action correlation identifier, when available.")
  action_correlation_id?: string;

  @doc("The downstream response or invocation identifier, when available.")
  response_id?: string;

  @doc("The workspace task identifier linked to the routine attempt, when available.")
  task_id?: string;

  @doc("The fully qualified error type captured for a failed attempt, when available.")
  error_type?: string;

  @doc("The downstream HTTP status code captured for a failed attempt, when available.")
  error_status_code?: int32;

  @doc("The truncated failure message captured for a failed attempt, when available.")
  error_message?: string;

  @doc("Diagnostic data captured for the routine attempt.")
  diagnostics?: RoutineRunDiagnostics;
}

@doc("Parameters for creating or updating a routine.")
model CreateOrUpdateRoutineParameters {
  @doc("The unique name of the routine.")
  @path
  @maxLength(128)
  routine_name: string;

  ...RoutineCreateOrUpdateRequest;
}

@doc("Parameters for retrieving a routine.")
model GetRoutineParameters {
  @doc("The unique name of the routine.")
  @path
  @maxLength(128)
  routine_name: string;
}

@doc("Parameters for enabling a routine.")
model EnableRoutineParameters {
  @doc("The unique name of the routine.")
  @path
  @maxLength(128)
  routine_name: string;
}

@doc("Parameters for disabling a routine.")
model DisableRoutineParameters {
  @doc("The unique name of the routine.")
  @path
  @maxLength(128)
  routine_name: string;
}

@doc("Parameters for listing routines.")
model ListRoutinesParameters {
  @doc("An optional continuation token from a previous routines list response.")
  @query
  continuationToken?: string;
}

@doc("Parameters for deleting a routine.")
model DeleteRoutineParameters {
  @doc("The unique name of the routine.")
  @path
  @maxLength(128)
  routine_name: string;
}

@doc("Parameters for listing runs for a routine.")
model ListRoutineRunsParameters {
  @doc("The unique name of the routine.")
  @path
  @maxLength(128)
  routine_name: string;

  @doc("An optional MLflow search-runs filter expression applied within the routine's experiment.")
  @query
  filter?: string;

  @doc("Optional MLflow ordering expressions.")
  @query
  orderBy?: string[];

  @doc("An optional maximum number of runs to return in this page.")
  @query
  maxResults?: int32;

  @doc("An optional continuation token from a previous routine runs response.")
  @query
  pageToken?: string;
}

@doc("Parameters for dispatching a routine asynchronously.")
model DispatchRoutineAsyncParameters {
  @doc("The unique name of the routine.")
  @path
  @maxLength(128)
  routine_name: string;

  ...DispatchRoutineRequest;
}

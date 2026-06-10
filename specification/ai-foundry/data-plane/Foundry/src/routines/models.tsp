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

  @doc("A custom event trigger.")
  custom: "custom",

  @doc("A GitHub issue trigger.")
  github_issue: "github_issue",

  @doc("A recurring cron-based trigger.")
  schedule: "schedule",

  @doc("A one-shot timer trigger.")
  timer: "timer",
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

@doc("Known GitHub issue events that can fire a routine.")
@extension("x-ms-foundry-meta", RoutineRequiredPreviews)
union GitHubIssueEvent {
  string,

  @doc("The routine fires when a GitHub issue is opened.")
  opened: "opened",

  @doc("The routine fires when a GitHub issue is closed.")
  closed: "closed",
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

@doc("The status of a routine run.")
@extension("x-ms-foundry-meta", RoutineRequiredPreviews)
union RoutineRunStatus {
  string,
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

  @doc("The UTC date and time at which the timer fires.")
  at?: utcDateTime;
}

@doc("A GitHub issue routine trigger.")
@extension("x-ms-foundry-meta", RoutineRequiredPreviews)
model GitHubIssueRoutineTrigger extends RoutineTrigger {
  @doc("The trigger type.")
  type: RoutineTriggerType.github_issue;

  @doc("The workspace connection identifier that resolves the GitHub configuration for the trigger.")
  @maxLength(256)
  connection_id: string;

  @doc("The GitHub owner or organization that scopes which issues can fire the trigger.")
  @maxLength(128)
  owner: string;

  @doc("The GitHub repository filter that scopes which issues can fire the trigger.")
  @maxLength(128)
  repository: string;

  @doc("The GitHub issue event that fires the routine.")
  issue_event: GitHubIssueEvent;
}

@doc("A custom event routine trigger.")
@extension("x-ms-foundry-meta", RoutineRequiredPreviews)
model CustomRoutineTrigger extends RoutineTrigger {
  @doc("The trigger type.")
  type: RoutineTriggerType.custom;

  @doc("The external provider that emits the custom event.")
  @maxLength(128)
  provider: string;

  @doc("The provider-specific event name that fires the routine.")
  @maxLength(256)
  event_name?: string;

  @doc("Provider-specific trigger parameters.")
  parameters: Record<unknown>;
}

@doc("Base model for a routine action.")
@discriminator("type")
@extension("x-ms-foundry-meta", RoutineRequiredPreviews)
model RoutineAction {
  @doc("The action type.")
  type: RoutineActionType;
}

alias InvokeAgentRoutineActionFields = {
  @doc("The project-scoped agent name for routine dispatch.")
  @maxLength(256)
  agent_name?: string;

  @doc("Legacy endpoint-scoped agent identifier for routine dispatch.")
  @maxLength(256)
  agent_endpoint_id?: string;

  @doc("Static JSON value sent as the complete downstream input when the routine fires. The value is passed through as-is; no templating is applied.")
  input?: unknown;
};

@doc("Dispatches a routine through the responses API. Exactly one of agent_name or agent_endpoint_id must be provided.")
@extension("x-ms-foundry-meta", RoutineRequiredPreviews)
model InvokeAgentResponsesApiRoutineAction extends RoutineAction {
  @doc("The action type.")
  type: RoutineActionType.invoke_agent_responses_api;

  ...InvokeAgentRoutineActionFields;

  @doc("An optional existing conversation identifier to continue during the downstream dispatch.")
  @maxLength(256)
  conversation?: string;
}

@doc("Dispatches a routine through the raw invocations API. Exactly one of agent_name or agent_endpoint_id must be provided.")
@extension("x-ms-foundry-meta", RoutineRequiredPreviews)
model InvokeAgentInvocationsApiRoutineAction extends RoutineAction {
  @doc("The action type.")
  type: RoutineActionType.invoke_agent_invocations_api;

  ...InvokeAgentRoutineActionFields;

  @doc("An optional existing hosted-agent session identifier to continue during the downstream dispatch.")
  @maxLength(256)
  session_id?: string;
}

@doc("A routine definition returned by the service.")
@extension("x-ms-foundry-meta", RoutineRequiredPreviews)
model Routine {
  @doc("The routine name.")
  @maxLength(128)
  name?: string;

  @doc("A human-readable description of the routine.")
  @maxLength(1024)
  description?: string;

  @doc("Whether the routine is enabled.")
  enabled: boolean;

  @doc("The triggers configured for the routine.")
  triggers?: RoutineTriggers;

  @doc("The action executed when the routine fires.")
  action?: RoutineAction;

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
  triggers?: RoutineTriggers;

  @doc("The action executed when the routine fires.")
  action?: RoutineAction;
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

  @doc("The JSON value sent as the complete downstream responses input. The value is passed through as-is and can be an object, string, number, boolean, array, or null.")
  input: unknown;
}

@doc("A manual payload used to test an invocations API routine dispatch.")
@extension("x-ms-foundry-meta", RoutineRequiredPreviews)
model InvokeAgentInvocationsApiDispatchPayload extends RoutineDispatchPayload {
  @doc("The manual dispatch payload type.")
  type: RoutineDispatchPayloadType.invoke_agent_invocations_api;

  @doc("The JSON value sent as the complete downstream invocations input. The value is passed through as-is and can be an object, string, number, boolean, array, or null.")
  input: unknown;
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

@doc("A single routine run returned from the run history API.")
@extension("x-ms-foundry-meta", RoutineRequiredPreviews)
model RoutineRun {
  @doc("The unique run identifier for the routine attempt.")
  @visibility(Lifecycle.Read)
  id: string;

  @doc("The run status.")
  status?: RoutineRunStatus;

  @doc("The AgentExtensions lifecycle phase for the routine attempt.")
  phase?: RoutineRunPhase;

  @doc("The trigger type that produced the routine attempt.")
  trigger_type?: RoutineTriggerType;

  @doc("The configured trigger name that produced the routine attempt.")
  trigger_name?: string;

  @doc("The source path that created the routine attempt.")
  attempt_source?: RoutineAttemptSource;

  @doc("The action type dispatched for the routine attempt.")
  action_type?: RoutineActionType;

  @doc("The project-scoped agent identifier recorded for the routine attempt.")
  agent_id?: string;

  @doc("The legacy endpoint-scoped agent identifier recorded for the routine attempt.")
  agent_endpoint_id?: string;

  @doc("The conversation identifier used by a responses API dispatch.")
  conversation_id?: string;

  @doc("The hosted-agent session identifier used by an invocations API dispatch.")
  session_id?: string;

  @doc("The logical trigger time recorded for the routine attempt.")
  triggered_at?: FoundryTimestamp;

  @doc("The scheduled fire time recorded for timer and schedule deliveries.")
  scheduled_fire_at?: FoundryTimestamp;

  @doc("The time when the underlying run started.")
  started_at?: FoundryTimestamp;

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

  @doc("The downstream error status code captured for a failed attempt, when available.")
  error_status_code?: int32;

  @doc("The fully qualified error type captured for a failed attempt, when available.")
  error_type?: string;

  @doc("The truncated failure message captured for a failed attempt, when available.")
  error_message?: string;
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
  @doc("The maximum number of routines to return.")
  @query
  limit?: int32;

  @doc("An opaque cursor returned as last_id by the previous list response.")
  @query
  @continuationToken
  after?: string;

  @doc("Unsupported. Reserved for future backward pagination support.")
  @query
  before?: string;

  @doc("The ordering direction. Supported values are asc and desc.")
  @query
  order?: string;
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

  @doc("The maximum number of runs to return.")
  @query
  limit?: int32;

  @doc("An opaque cursor returned as last_id by the previous list-runs response.")
  @query
  @continuationToken
  after?: string;

  @doc("Unsupported. Reserved for future backward pagination support.")
  @query
  before?: string;

  @doc("The ordering direction. Supported values are asc and desc.")
  @query
  order?: string;
}

@doc("Parameters for dispatching a routine asynchronously.")
model DispatchRoutineAsyncParameters {
  @doc("The unique name of the routine.")
  @path
  @maxLength(128)
  routine_name: string;

  ...DispatchRoutineRequest;
}

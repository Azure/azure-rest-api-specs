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

  @doc("A GitHub issue-opened trigger.")
  github_issue_opened: "github_issue_opened",

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
  cronExpression: string;

  @doc("An IANA or Windows time zone identifier for the schedule.")
  timeZone: string;
}

@doc("A one-shot timer routine trigger.")
@extension("x-ms-foundry-meta", RoutineRequiredPreviews)
model TimerRoutineTrigger extends RoutineTrigger {
  @doc("The trigger type.")
  type: RoutineTriggerType.timer;

  @doc("A future timer expression. Supported values include an ISO-8601 timestamp with an explicit offset, a local timestamp paired with timeZone, or a positive duration from now.")
  at: string;

  @doc("An optional IANA or Windows time zone identifier when the timer uses a local timestamp.")
  timeZone?: string;
}

@doc("A GitHub issue-opened routine trigger.")
@extension("x-ms-foundry-meta", RoutineRequiredPreviews)
model GitHubIssueOpenedRoutineTrigger extends RoutineTrigger {
  @doc("The trigger type.")
  type: RoutineTriggerType.github_issue_opened;

  @doc("The workspace connection identifier that resolves the GitHub configuration for the trigger.")
  @maxLength(256)
  connectionId: string;

  @doc("The GitHub assignee or organization filter that scopes which issues can fire the trigger.")
  @maxLength(128)
  assignee: string;

  @doc("The GitHub repository filter that scopes which issues can fire the trigger.")
  @maxLength(128)
  repository: string;
}

@doc("Base model for a routine action.")
@discriminator("type")
@extension("x-ms-foundry-meta", RoutineRequiredPreviews)
model RoutineAction {
  @doc("The action type.")
  type: RoutineActionType;
}

@doc("Dispatches a routine through the responses API. Exactly one of agentId or agentEndpointId must be provided.")
@extension("x-ms-foundry-meta", RoutineRequiredPreviews)
model InvokeAgentResponsesApiRoutineAction extends RoutineAction {
  @doc("The action type.")
  type: RoutineActionType.invoke_agent_responses_api;

  @doc("The project-scoped agent identifier for responses API dispatch.")
  @maxLength(256)
  agentId?: string;

  @doc("The endpoint-scoped agent identifier for responses API dispatch.")
  @maxLength(256)
  agentEndpointId?: string;

  @doc("An optional existing conversation identifier to continue during the downstream dispatch.")
  @maxLength(256)
  conversationId?: string;
}

@doc("Dispatches a routine through the raw invocations API.")
@extension("x-ms-foundry-meta", RoutineRequiredPreviews)
model InvokeAgentInvocationsApiRoutineAction extends RoutineAction {
  @doc("The action type.")
  type: RoutineActionType.invoke_agent_invocations_api;

  @doc("The endpoint-scoped agent identifier for invocations API dispatch.")
  @maxLength(256)
  agentEndpointId: string;

  @doc("An optional existing hosted-agent session identifier to continue during the downstream dispatch.")
  @maxLength(256)
  sessionId?: string;
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
  createdAt?: utcDateTime;

  @doc("The time when the routine was last updated.")
  updatedAt?: utcDateTime;
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

@doc("Request body for the public dispatchAsync route.")
@extension("x-ms-foundry-meta", RoutineRequiredPreviews)
model DispatchRoutineRequest {
  @doc("A direct action-input override sent downstream when testing a routine.")
  payload?: RoutineDispatchPayload;
}

@doc("Identifiers returned after a routine dispatch is queued.")
@extension("x-ms-foundry-meta", RoutineRequiredPreviews)
model DispatchRoutineResponse {
  @doc("The dispatch identifier created for the routine dispatch.")
  dispatchId?: string;

  @doc("A downstream action correlation identifier, when available.")
  actionCorrelationId?: string;

  @doc("A workspace task identifier created for the dispatch, when available.")
  taskId?: string;
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
  id?: string;

  @doc("The underlying MLflow run status.")
  status?: string;

  @doc("The AgentExtensions lifecycle phase for the routine attempt.")
  phase?: RoutineRunPhase;

  @doc("The trigger type that produced the routine attempt.")
  triggerType?: RoutineTriggerType;

  @doc("The source path that created the routine attempt.")
  attemptSource?: RoutineAttemptSource;

  @doc("The action type dispatched for the routine attempt.")
  actionType?: RoutineActionType;

  @doc("The logical trigger time recorded for the routine attempt.")
  triggeredAt?: utcDateTime;

  @doc("The time when the underlying run started.")
  startedAt?: utcDateTime;

  @doc("The time when the underlying run reached a terminal state.")
  endedAt?: utcDateTime;

  @doc("The dispatch identifier associated with the routine attempt.")
  dispatchId?: string;

  @doc("The downstream action correlation identifier, when available.")
  actionCorrelationId?: string;

  @doc("The downstream response or invocation identifier, when available.")
  responseId?: string;

  @doc("The workspace task identifier linked to the routine attempt, when available.")
  taskId?: string;

  @doc("The fully qualified error type captured for a failed attempt, when available.")
  errorType?: string;

  @doc("The truncated failure message captured for a failed attempt, when available.")
  errorMessage?: string;

  @doc("Diagnostic data captured for the routine attempt.")
  diagnostics?: RoutineRunDiagnostics;
}

@doc("A page of routines returned by the list operation.")
@extension("x-ms-foundry-meta", RoutineRequiredPreviews)
model RoutineListResponse {
  @doc("The current page of routines.")
  value: Routine[];

  @doc("The continuation token to use on the next list request, when more results are available.")
  @maxLength(4096)
  continuationToken?: string;
}

@doc("A page of routine runs returned by the run history API.")
@extension("x-ms-foundry-meta", RoutineRequiredPreviews)
model RoutineRunsResponse {
  @doc("The current page of routine runs.")
  value: RoutineRun[];

  @doc("The continuation token to use on the next run-history request, when more results are available.")
  @maxLength(4096)
  nextPageToken?: string;
}

@doc("Parameters for creating or updating a routine.")
model CreateOrUpdateRoutineParameters {
  @doc("The unique name of the routine.")
  @path
  @maxLength(128)
  routineName: string;

  ...RoutineCreateOrUpdateRequest;
}

@doc("Parameters for retrieving a routine.")
model GetRoutineParameters {
  @doc("The unique name of the routine.")
  @path
  @maxLength(128)
  routineName: string;
}

@doc("Parameters for listing routines.")
model ListRoutinesParameters {
  @doc("A continuation token returned from a previous list response.")
  @query
  @maxLength(4096)
  continuationToken?: string;
}

@doc("Parameters for deleting a routine.")
model DeleteRoutineParameters {
  @doc("The unique name of the routine.")
  @path
  @maxLength(128)
  routineName: string;
}

@doc("Parameters for listing runs for a routine.")
model ListRoutineRunsParameters {
  @doc("The unique name of the routine.")
  @path
  @maxLength(128)
  routineName: string;

  @doc("An optional MLflow search-runs filter expression applied within the routine's experiment.")
  @query
  filter?: string;

  @doc("Optional MLflow ordering expressions.")
  @query("orderBy")
  orderBy?: string[];

  @doc("The maximum number of routine runs to return when provided.")
  @query
  @minValue(1)
  maxResults?: int32;

  @doc("A continuation token returned from a previous run-history response.")
  @query
  @maxLength(4096)
  pageToken?: string;
}

@doc("Parameters for dispatching a routine asynchronously.")
model DispatchRoutineAsyncParameters {
  @doc("The unique name of the routine.")
  @path
  @maxLength(128)
  routineName: string;

  ...DispatchRoutineRequest;
}

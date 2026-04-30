import "../common/models.tsp";
import "../servicepatterns.tsp";

using TypeSpec.Rest;

namespace Azure.AI.Projects;

// ─────────────────────────────────────────────
// Trigger types
// ─────────────────────────────────────────────

@doc("Discriminator values for RoutineTrigger.type.")
union RoutineTriggerType {
  string,

  @doc("Cron-based recurring schedule trigger.")
  Schedule: "schedule",

  @doc("One-shot timer trigger.")
  Timer: "timer",

  @doc("GitHub issue event trigger.")
  GitHubIssue: "github_issue",
}


@doc("Base model for a Routine trigger. Discriminated by `type`.")
@discriminator("type")
model RoutineTrigger {
  @doc("Trigger type discriminator.")
  type: RoutineTriggerType;
}

@doc("Cron-based recurring schedule trigger.")
model ScheduleRoutineTrigger extends RoutineTrigger {
  @doc("Trigger type discriminator.")
  type: RoutineTriggerType.Schedule;

  @doc("Standard cron expression for the recurring schedule. Example: `\"0 8 * * *\"` for daily at 08:00.")
  cron_expression?: string;

  @doc("IANA/Windows time zone identifier. Example: `\"UTC\"` or `\"America/Los_Angeles\"`.")
  time_zone?: string;
}

@doc("One-shot timer trigger. Fires once at the configured time.")
model TimerRoutineTrigger extends RoutineTrigger {
  @doc("Trigger type discriminator.")
  type: RoutineTriggerType.Timer;

  @doc("One-shot fire time in ISO 8601 format. Example: `\"2030-01-02T03:04:05Z\"`.")
  at?: string;

  @doc("IANA/Windows time zone identifier. Example: `\"UTC\"` or `\"America/Los_Angeles\"`.")
  time_zone?: string;
}

@doc("GitHub issue event trigger backed by a workspace connection.")
model EventRoutineTrigger extends RoutineTrigger {
  type: RoutineTriggerType.GitHubIssue;

  @doc("ID of the workspace connection that owns the GitHub OAuth credentials.")
  connection_id?: string;

  @doc("GitHub repository owner or organization. Example: `\"contoso\"`.")
  owner?: string;

  @doc("GitHub repository name. Example: `\"contoso-app\"`.")
  repository?: string;

  @doc("GitHub issue actions to match. Example: `[\"opened\", \"reopened\"]`. When omitted all actions are accepted.")
  actions?: string[];
}

// ─────────────────────────────────────────────
// Action models
// ─────────────────────────────────────────────

@doc("Discriminator values for RoutineAction.type.")
union RoutineActionType {
  string,

  @doc("Invoke a published agent via the workspace responses API.")
  InvokeAgentResponsesApi: "invoke_agent_responses_api",

  @doc("Invoke a published agent via the endpoint invocations API.")
  InvokeAgentInvocationsApi: "invoke_agent_invocations_api",
}

@doc("Base model for a Routine action. Discriminated by `type`.")
@discriminator("type")
model RoutineAction {
  @doc("Action type discriminator.")
  type: RoutineActionType;
}

@doc("Action that invokes a published agent via the workspace responses API.")
model InvokeAgentResponsesApiRoutineAction extends RoutineAction {
  @doc("Action type discriminator.")
  type: RoutineActionType.InvokeAgentResponsesApi;

  @doc("Project-scoped agent ID used with the workspace `/openai/responses` route. Exactly one of `agent_id` or `agent_endpoint_id` must be provided.")
  agent_id?: string;

  @doc("Agent endpoint target for endpoint-scoped protocol routes. Exactly one of `agent_id` or `agent_endpoint_id` must be provided.")
  agent_endpoint_id?: string;

  @doc("Optional existing conversation ID to continue across scheduled fires.")
  conversation_id?: string;
}

@doc("Action that invokes a published agent via the endpoint invocations API.")
model InvokeAgentInvocationsApiRoutineAction extends RoutineAction {
  @doc("Action type discriminator.")
  type: RoutineActionType.InvokeAgentInvocationsApi;

  @doc("Agent endpoint target for the endpoint invocations route.")
  agent_endpoint_id: string;

  @doc("Optional existing hosted-agent session to continue.")
  session_id?: string;
}

// ─────────────────────────────────────────────
// Routine resource
// ─────────────────────────────────────────────

@doc("A workspace-scoped resource that pairs named trigger(s) with a single action, defining when and how a Foundry agent is invoked.")
@resource("routines")
model Routine {
  @doc("Unique name of the routine within the workspace.")
  @key("routine_name")
  @visibility(Lifecycle.Read)
  name: string;

  @doc("Human-readable description of the routine.")
  description?: string;

  @doc("Whether the trigger schedule is active. Defaults to `true` on creation.")
  enabled?: boolean = true;

  @doc("Named trigger configurations for this routine. The key is a user-defined trigger identifier.")
  triggers?: Record<RoutineTrigger>;

  @doc("Action to execute when a trigger fires.")
  action?: RoutineAction;

  @doc("UTC timestamp at which the routine was created.")
  @visibility(Lifecycle.Read)
  created_at?: utcDateTime;

  @doc("UTC timestamp at which the routine was last updated.")
  @visibility(Lifecycle.Read)
  updated_at?: utcDateTime;
}

@doc("Paginated list of routines.")
model RoutineListResult {
  @doc("Current page of routines.")
  value: Routine[];

  @doc("Continuation token for the next page. Omitted when there are no additional results.")
  continuation_token?: string;
}

// ─────────────────────────────────────────────
// Dispatch models
// ─────────────────────────────────────────────

@doc("Base class for a manual dispatch payload. Discriminated by `type`.")
@discriminator("type")
model RoutineDispatchPayload {
  @doc("Payload type discriminator, matching the routine's action type.")
  type: RoutineActionType;
}

@doc("Manual dispatch payload for `invoke_agent_responses_api` actions.")
model InvokeAgentResponsesApiDispatchPayload extends RoutineDispatchPayload {
  @doc("Payload type discriminator.")
  type: RoutineActionType.InvokeAgentResponsesApi;

  @doc("User message content to send to the agent. Example: `\"Summarize today's build failures.\"`")
  input?: string;
}

@doc("Manual dispatch payload for `invoke_agent_invocations_api` actions.")
model InvokeAgentInvocationsApiDispatchPayload extends RoutineDispatchPayload {
  @doc("Payload type discriminator.")
  type: RoutineActionType.InvokeAgentInvocationsApi;

  @doc("Raw input content to send to the agent endpoint.")
  input?: string;
}

@doc("Request body for manually dispatching a routine.")
model DispatchRoutineRequest {
  @doc("Optional payload to override the action's default input.")
  payload?: RoutineDispatchPayload;
}

@doc("Response returned by the dispatch and dispatchAsync operations.")
model DispatchRoutineResponse {
  @doc("Unique identifier for this dispatch event.")
  dispatch_id?: string;

  @doc("Correlation ID linking this dispatch to the resulting agent run.")
  action_correlation_id?: string;
}

// ─────────────────────────────────────────────
// Routine run models
// ─────────────────────────────────────────────

@doc("Compact record of a single routine trigger attempt.")
model RoutineRunDto {
  @doc("MLflow run identifier for this attempt.")
  id?: string;

  @doc("Underlying MLflow run status. Example values: `RUNNING`, `FINISHED`, `FAILED`.")
  status?: string;

  @doc("AgentExtensions lifecycle phase. Example values: `queued`, `dispatching`, `completed`, `failed`.")
  phase?: string;

  @doc("Trigger type that produced the attempt. Example values: `schedule`, `timer`, `github_issue`.")
  trigger_type?: string;

  @doc("Source path that created the attempt. Example values: `manual_dispatch`, `queued_dispatch`, `schedule_delivery`, `timer_delivery`.")
  attempt_source?: string;

  @doc("Action type dispatched for the attempt.")
  action_type?: string;

  @doc("Logical trigger time for the attempt.")
  triggered_at?: utcDateTime;

  @doc("Time the underlying MLflow run started.")
  started_at?: utcDateTime;

  @doc("Time the underlying MLflow run reached a terminal state.")
  ended_at?: utcDateTime;

  @doc("Dispatch identifier for the attempt.")
  dispatch_id?: string;

  @doc("Downstream action correlation identifier.")
  action_correlation_id?: string;

  @doc("Downstream response or invocation identifier, if available.")
  response_id?: string;

  @doc("Fully-qualified error type for a failed attempt, if available.")
  error_type?: string;

  @doc("Truncated failure message for a failed attempt, if available.")
  error_message?: string;
}

@doc("Paged response for routine run history.")
model RoutineRunsResponse {
  @doc("Current page of routine runs.")
  value: RoutineRunDto[];

  @doc("Continuation token for the next page. Omitted when there are no additional results.")
  next_page_token?: string;
}

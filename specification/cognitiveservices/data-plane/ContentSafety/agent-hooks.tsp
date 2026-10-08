import "@typespec/http";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-client-generator-core";

using TypeSpec.Http;
using TypeSpec.Versioning;
using Azure.ClientGenerator.Core;

namespace ContentSafety;

#suppress "@azure-tools/typespec-azure-core/no-closed-literal-union" "Agent Hooks 0.1 defines a closed set of interception points; unsupported points must fail validation."
@added(Versions.v2026_10_15_preview)
@doc("The closed set of Agent Hooks 0.1 interception points. The service never infers the point from the agent identifier.")
union AgentInterceptionPoint {
  @doc("Before the execution session starts.")
  AgentStartup: "agent_startup",

  @doc("Before accepting input.")
  Input: "input",

  @doc("Before dispatching a model request.")
  PreModelCall: "pre_model_call",

  @doc("After receiving a model response.")
  PostModelCall: "post_model_call",

  @doc("Before dispatching a tool invocation.")
  PreToolCall: "pre_tool_call",

  @doc("After receiving a tool result.")
  PostToolCall: "post_tool_call",

  @doc("Before releasing output.")
  Output: "output",

  @doc("When the execution session shuts down.")
  AgentShutdown: "agent_shutdown",
}

#suppress "@azure-tools/typespec-azure-core/bad-record-type" "Agent Hooks JSON objects permit native nested objects, arrays, primitives and null; a string-only map changes the wire contract."
@added(Versions.v2026_10_15_preview)
@doc("A native JSON object whose member values may be any JSON type, including null.")
model AgentJsonObject is Record<unknown>;

@added(Versions.v2026_10_15_preview)
@doc("Classifier subject roles used by existing AACS/AOAI flows. This is not actor identity or an authorization claim.")
union AacsSubjectRole {
  string,

  @doc("User-authored content.")
  User: "user",

  @doc("System-authored content.")
  System: "system",

  @doc("Assistant-authored content.")
  Assistant: "assistant",

  @doc("Tool-authored content.")
  Tool: "tool",

  @doc("Function-authored content.")
  Function: "function",
}

@added(Versions.v2026_10_15_preview)
@doc("Minimal AACS-specific request metadata for existing non-Hooks classification paths.")
model AacsContextExtension {
  @doc("Optional original classifier subject role for existing AACS prompt/completion/tool paths when the canonical payload cannot represent it. Canonical payload roles take precedence; contradictory claims, unsupported roles, and use at model/startup/shutdown points are rejected. Point-derived roles are defaults only. This does not authorize a caller or change the interception point.")
  role?: AacsSubjectRole;
}

#suppress "@azure-tools/typespec-azure-core/bad-record-type" "Agent Hooks extension namespaces retain arbitrary native JSON; a string-only map would regress the canonical context."
@added(Versions.v2026_10_15_preview)
@doc("Canonical namespaced extensions, including the optional AACS classifier-role bridge.")
model AgentContextExtensions {
  ...AgentJsonObject;

  @doc("Optional AACS-specific metadata; do not copy the legacy Unified Moderate body here.")
  aacs?: AacsContextExtension;
}

#suppress "@azure-tools/typespec-azure-core/no-closed-literal-union" "The external Agent Hooks 0.1 input role contract is closed."
@added(Versions.v2026_10_15_preview)
@doc("The closed Agent Hooks input-origin set.")
union AgentInputRole {
  @doc("User-provided input.")
  User: "user",

  @doc("System input.")
  System: "system",

  @doc("External input.")
  External: "external",
}

#suppress "@azure-tools/typespec-azure-core/no-closed-literal-union" "The external Agent Hooks 0.1 shutdown reason contract is closed."
@added(Versions.v2026_10_15_preview)
@doc("The closed Agent Hooks session-ending reasons.")
union AgentShutdownReason {
  @doc("The session completed.")
  Completed: "completed",

  @doc("The session ended with an error.")
  Error: "error",

  @doc("The session was cancelled.")
  Cancelled: "cancelled",
}

#suppress "@azure-tools/typespec-azure-core/no-closed-literal-union" "The external Agent Hooks 0.1 actor kind contract is closed."
@added(Versions.v2026_10_15_preview)
@doc("The closed Agent Hooks actor-kind set.")
union AgentActorKind {
  @doc("A human actor.")
  Human: "human",

  @doc("A service actor.")
  Service: "service",

  @doc("An agent actor.")
  Agent: "agent",
}

#suppress "@azure-tools/typespec-azure-core/no-closed-literal-union" "Agent Hooks 0.1 requires allow, deny or transform; an unknown decision must fail closed."
@added(Versions.v2026_10_15_preview)
@doc("The three canonical Agent Hooks decisions.")
union AgentDecision {
  @doc("Permit the original target.")
  Allow: "allow",

  @doc("Deny the action.")
  Deny: "deny",

  @doc("Permit after the host applies a transform.")
  Transform: "transform",
}

@added(Versions.v2026_10_15_preview)
@doc("Caller-supplied agent definition metadata. This metadata does not authorize policy selection or resource access.")
model AgentDefinition {
  @doc("Stable identifier of the agent definition, shared across its sessions.")
  @minLength(1)
  id: string;

  @doc("Lowercase framework identifier.")
  @pattern("^[a-z0-9_-]+$")
  framework: string;

  @doc("Optional display name.")
  name?: string;

  @doc("Optional agent definition version.")
  version?: string;
}

@added(Versions.v2026_10_15_preview)
@doc("Caller-supplied execution-session metadata.")
model AgentSession {
  @doc("Stable identifier of the run or conversation.")
  @minLength(1)
  id: string;

  @doc("Time the session started.")
  @encodedName("application/json", "started_at")
  startedAt?: utcDateTime;

  @doc("Non-negative turn number, when available.")
  @minValue(0)
  turn?: int64;
}

@added(Versions.v2026_10_15_preview)
@doc("The execution-session initialization payload.")
model AgentInitialization {
  @doc("Names of tools registered for this session.")
  @encodedName("application/json", "tools_registered")
  toolsRegistered: string[];
}

@added(Versions.v2026_10_15_preview)
@doc("An input payload. Content is native JSON, not a JSON-encoded string.")
model AgentInput {
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "Agent Hooks content is arbitrary native JSON; narrowing it would change the canonical contract."
  @doc("The input content as a native JSON value.")
  content: unknown;

  @doc("The input origin.")
  role: AgentInputRole;
}

@added(Versions.v2026_10_15_preview)
@doc("Metadata for a model request or response.")
model AgentModel {
  @doc("Logical model identifier.")
  id: string;

  @doc("Optional model vendor.")
  vendor?: string;

  #suppress "@azure-tools/typespec-azure-core/bad-record-type" "Canonical model parameters are a heterogeneous native JSON object."
  @doc("Optional model parameters as a JSON object.")
  params?: AgentJsonObject;
}

@added(Versions.v2026_10_15_preview)
@doc("One model message.")
model AgentMessage {
  @doc("The message role.")
  role: string;

  #suppress "@azure-tools/typespec-azure-core/no-unknown" "Agent Hooks message content must preserve every JSON value type."
  @doc("The message content as a native JSON value.")
  content: unknown;
}

@added(Versions.v2026_10_15_preview)
@doc("A tool call proposed by a model.")
model AgentModelToolCall {
  @doc("Optional model-supplied call identifier.")
  id?: string;

  @doc("The proposed tool name.")
  name: string;

  #suppress "@azure-tools/typespec-azure-core/bad-record-type" "Canonical model-proposed tool arguments retain their native JSON value types."
  @doc("Proposed arguments as a native JSON object.")
  args: AgentJsonObject;
}

@added(Versions.v2026_10_15_preview)
@doc("A completed model response. tool_calls is present even when it is an empty array.")
model AgentModelResult {
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "Canonical model response content includes native JSON and null, not JSON encoded inside strings."
  @doc("Response content as a native JSON value, including null.")
  content: unknown;

  @doc("Tool calls proposed by the model, or an empty array.")
  @encodedName("application/json", "tool_calls")
  toolCalls: AgentModelToolCall[];

  @doc("The model's finish reason.")
  @encodedName("application/json", "finish_reason")
  finishReason: string;
}

@added(Versions.v2026_10_15_preview)
@doc("Optional model token usage.")
model AgentModelUsage {
  @doc("Non-negative prompt token count.")
  @encodedName("application/json", "prompt_tokens")
  @minValue(0)
  promptTokens?: int64;

  @doc("Non-negative completion token count.")
  @encodedName("application/json", "completion_tokens")
  @minValue(0)
  completionTokens?: int64;
}

@added(Versions.v2026_10_15_preview)
@doc("A tool invocation. For a completed call, args contains the arguments actually dispatched after any host-applied transform.")
model AgentToolCall {
  @doc("Tool-call identifier.")
  @minLength(1)
  id: string;

  @doc("Tool name.")
  @minLength(1)
  name: string;

  #suppress "@azure-tools/typespec-azure-core/bad-record-type" "Canonical tool arguments cannot be narrowed to strings."
  @doc("Arguments as a native JSON object.")
  args: AgentJsonObject;

  @doc("Optional host-defined content hash, comparable only within that host.")
  @encodedName("application/json", "content_hash")
  @pattern("^sha256:[0-9a-f]{64}$")
  contentHash?: string;
}

@added(Versions.v2026_10_15_preview)
@doc("A completed tool result.")
model AgentToolResult {
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "Canonical tool results may be any JSON value including null."
  @doc("The native JSON result value, including null.")
  value: unknown;

  @doc("Whether the tool returned an error.")
  @encodedName("application/json", "is_error")
  isError: boolean;

  @doc("Optional non-negative call duration in milliseconds.")
  @encodedName("application/json", "duration_ms")
  @minValue(0)
  durationMs?: float64;
}

@added(Versions.v2026_10_15_preview)
@doc("A tool declaration available to the host.")
model AgentToolDeclaration {
  @doc("Tool name.")
  name: string;

  @doc("Optional tool description.")
  description?: string;

  #suppress "@azure-tools/typespec-azure-core/bad-record-type" "A tool JSON schema contains heterogeneous nested JSON values."
  @doc("Optional tool schema as a JSON object.")
  schema?: AgentJsonObject;
}

@added(Versions.v2026_10_15_preview)
@doc("Output that the host has not yet released.")
model AgentOutput {
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "Canonical output content must preserve arbitrary native JSON."
  @doc("Output content as a native JSON value.")
  content: unknown;
}

@added(Versions.v2026_10_15_preview)
@doc("Caller-reported execution-session summary. The evaluation service does not initiate shutdown or undo previous actions.")
model AgentSummary {
  @doc("Why the session ended.")
  reason: AgentShutdownReason;

  @doc("Optional non-negative tool-call count.")
  @encodedName("application/json", "tool_calls")
  @minValue(0)
  toolCalls?: int64;

  @doc("Optional non-negative error count.")
  @minValue(0)
  errors?: int64;

  @doc("Optional non-negative session duration in seconds.")
  @encodedName("application/json", "duration_seconds")
  @minValue(0)
  durationSeconds?: float64;
}

@added(Versions.v2026_10_15_preview)
@doc("Optional trace identifiers.")
model AgentTrace {
  @doc("Trace identifier.")
  @encodedName("application/json", "trace_id")
  traceId?: string;

  @doc("Span identifier.")
  @encodedName("application/json", "span_id")
  spanId?: string;
}

@added(Versions.v2026_10_15_preview)
@doc("Caller-reported tenant metadata, not an authorization fact.")
model AgentTenant {
  @doc("Optional tenant identifier.")
  id?: string;

  @doc("Optional tenant name.")
  name?: string;
}

@added(Versions.v2026_10_15_preview)
@doc("Caller-reported actor metadata, not an authorization fact.")
model AgentActor {
  @doc("Optional actor identifier.")
  id?: string;

  @doc("Optional actor kind.")
  kind?: AgentActorKind;
}

@added(Versions.v2026_10_15_preview)
@doc("Optional caller-reported budget counters.")
model AgentBudgets {
  @doc("Reported tool-call count.")
  @encodedName("application/json", "tool_call_count")
  toolCallCount?: float64;

  @doc("Reported token count.")
  @encodedName("application/json", "token_count")
  tokenCount?: float64;

  @doc("Reported elapsed seconds.")
  @encodedName("application/json", "elapsed_seconds")
  elapsedSeconds?: float64;

  @doc("Reported cost in US dollars.")
  @encodedName("application/json", "cost_usd")
  costUsd?: float64;
}

@added(Versions.v2026_10_15_preview)
@discriminator("interception_point")
@doc("Canonical Agent Hooks 0.1 context. The host supplies the exact point and a target equal to its point-specific payload. Authentication, policy selection and composition are transport or host configuration, not body fields. The service validates conditional payloads and target equality.")
model AgentContext {
  @doc("The supported Agent Hooks specification identifier.")
  spec: "agent-hooks/0.1";

  #suppress "@azure-tools/typespec-azure-core/casing-style" "The canonical discriminator must be interception_point on the wire; SDK names use interceptionPoint."
  @doc("The lifecycle point being evaluated.")
  @clientName("interceptionPoint")
  interception_point: AgentInterceptionPoint;

  @doc("UTC instant when the host constructed the context.")
  timestamp: utcDateTime;

  @doc("Strictly increasing, non-negative emission sequence within the session.")
  @minValue(0)
  sequence: int64;

  @doc("Agent definition metadata.")
  agent: AgentDefinition;

  @doc("Execution-session metadata.")
  session: AgentSession;

  #suppress "@azure-tools/typespec-azure-core/no-unknown" "Agent Hooks target is arbitrary native JSON, including objects, arrays, primitives and null."
  @doc("The native JSON value under evaluation. It must equal the corresponding point payload and is the root addressed by a transform.")
  target: unknown;

  @doc("Initialization payload when available; required at agent_startup.")
  @encodedName("application/json", "agent_init")
  agentInit?: AgentInitialization;

  @doc("Input payload when available; required at input.")
  input?: AgentInput;

  @doc("Model metadata when available; required at both model-call points.")
  `model`?: AgentModel;

  @doc("Model messages when available; required at pre_model_call.")
  messages?: AgentMessage[];

  @doc("Optional model-request correlation identifier.")
  @encodedName("application/json", "request_id")
  requestId?: string;

  @doc("Model response when available; required at post_model_call.")
  response?: AgentModelResult;

  @doc("Optional model token usage.")
  usage?: AgentModelUsage;

  @doc("Tool-call payload when available; required at both tool-call points.")
  @encodedName("application/json", "tool_call")
  toolCall?: AgentToolCall;

  @doc("Tool-result payload when available; required at post_tool_call.")
  @encodedName("application/json", "tool_result")
  toolResult?: AgentToolResult;

  @doc("Optional tools available to the host.")
  tools?: AgentToolDeclaration[];

  @doc("Output payload when available; required at output.")
  output?: AgentOutput;

  @doc("Session summary when available; required at agent_shutdown.")
  summary?: AgentSummary;

  @doc("Optional trace identifiers.")
  trace?: AgentTrace;

  @doc("Optional caller-reported tenant metadata.")
  tenant?: AgentTenant;

  @doc("Optional caller-reported actor metadata.")
  actor?: AgentActor;

  @doc("Optional caller-reported budget counters.")
  budgets?: AgentBudgets;

  #suppress "@azure-tools/typespec-azure-core/bad-record-type" "Agent Hooks extension namespaces retain arbitrary native JSON values."
  @doc("Namespaced extension values. Namespace keys match ^[a-z][a-z0-9_]*$. Values are native JSON; caller extensions cannot override trusted service annotations.")
  extensions?: AgentContextExtensions;
}

@added(Versions.v2026_10_15_preview)
@doc("Startup context. target equals agent_init; a host must reject startup transforms.")
model AgentStartupContext extends AgentContext {
  #suppress "@azure-tools/typespec-azure-core/casing-style" "Agent Hooks requires the same snake_case discriminator in every derived context."
  @clientName("interceptionPoint")
  interception_point: "agent_startup";

  @encodedName("application/json", "agent_init")
  agentInit: AgentInitialization;
}

@added(Versions.v2026_10_15_preview)
@doc("Input context. target equals the complete input object, not only its content.")
model AgentInputContext extends AgentContext {
  #suppress "@azure-tools/typespec-azure-core/casing-style" "Agent Hooks requires the same snake_case discriminator in every derived context."
  @clientName("interceptionPoint")
  interception_point: "input";

  input: AgentInput;
}

@added(Versions.v2026_10_15_preview)
@doc("Pre-model context. target equals the messages array actually proposed for dispatch.")
model AgentPreModelCallContext extends AgentContext {
  #suppress "@azure-tools/typespec-azure-core/casing-style" "Agent Hooks requires the same snake_case discriminator in every derived context."
  @clientName("interceptionPoint")
  interception_point: "pre_model_call";

  `model`: AgentModel;
  messages: AgentMessage[];
}

@added(Versions.v2026_10_15_preview)
@doc("Post-model context. target equals the complete response object; the service cannot undo the model call.")
model AgentPostModelCallContext extends AgentContext {
  #suppress "@azure-tools/typespec-azure-core/casing-style" "Agent Hooks requires the same snake_case discriminator in every derived context."
  @clientName("interceptionPoint")
  interception_point: "post_model_call";

  `model`: AgentModel;
  response: AgentModelResult;
}

@added(Versions.v2026_10_15_preview)
@doc("Pre-tool context. target equals tool_call.args.")
model AgentPreToolCallContext extends AgentContext {
  #suppress "@azure-tools/typespec-azure-core/casing-style" "Agent Hooks requires the same snake_case discriminator in every derived context."
  @clientName("interceptionPoint")
  interception_point: "pre_tool_call";

  @encodedName("application/json", "tool_call")
  toolCall: AgentToolCall;
}

@added(Versions.v2026_10_15_preview)
@doc("Post-tool context. target equals tool_result.value; the service cannot undo the tool call.")
model AgentPostToolCallContext extends AgentContext {
  #suppress "@azure-tools/typespec-azure-core/casing-style" "Agent Hooks requires the same snake_case discriminator in every derived context."
  @clientName("interceptionPoint")
  interception_point: "post_tool_call";

  @encodedName("application/json", "tool_call")
  toolCall: AgentToolCall;

  @encodedName("application/json", "tool_result")
  toolResult: AgentToolResult;
}

@added(Versions.v2026_10_15_preview)
@doc("Output context. target equals the complete output object.")
model AgentOutputContext extends AgentContext {
  #suppress "@azure-tools/typespec-azure-core/casing-style" "Agent Hooks requires the same snake_case discriminator in every derived context."
  @clientName("interceptionPoint")
  interception_point: "output";

  output: AgentOutput;
}

@added(Versions.v2026_10_15_preview)
@doc("Shutdown context. target equals summary; a host must reject shutdown transforms.")
model AgentShutdownContext extends AgentContext {
  #suppress "@azure-tools/typespec-azure-core/casing-style" "Agent Hooks requires the same snake_case discriminator in every derived context."
  @clientName("interceptionPoint")
  interception_point: "agent_shutdown";

  summary: AgentSummary;
}

@added(Versions.v2026_10_15_preview)
@doc("A non-blocking concern. Both reason and message are preserved when present.")
model AgentWarning {
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Agent Hooks explicitly permits both absent and null warning reasons."
  @doc("Optional machine-readable reason, excluding the host_error: namespace.")
  @pattern("^(?!host_error:).*")
  reason?: string | null;

  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Agent Hooks explicitly permits null warning messages."
  @doc("Optional human-readable message.")
  message?: string | null;
}

@added(Versions.v2026_10_15_preview)
@doc("An opaque offline-verifiable evidence pointer. The host must not automatically dereference verification pointers. Its canonical JSON representation is limited to 10,240 UTF-8 bytes.")
model AgentEvidence {
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Agent Hooks evidence permits a null artefact pointer."
  @doc("Optional content address or URI of an evidence artefact.")
  artefact?: string | null;

  @doc("Optional named verification pointers.")
  @encodedName("application/json", "verification_pointers")
  verificationPointers?: Record<string>;
}

@added(Versions.v2026_10_15_preview)
@doc("A replacement the host applies to its target, not a transform already applied by the service.")
model AgentTransform {
  @doc("Path rooted at $target using dot members, bracket indices or quoted members. The deprecated $policy_target alias is accepted by Agent Hooks 0.1. The host rejects unresolvable paths and startup/shutdown transforms.")
  @pattern("^\\$(target|policy_target)(\\.|\\[|$)")
  path: string;

  #suppress "@azure-tools/typespec-azure-core/no-unknown" "Agent Hooks transforms replace a target with any JSON value including null; preserving value type is required."
  @doc("Native JSON replacement value, including null. An absent member is equivalent to null; structured values are never JSON-encoded strings.")
  value?: unknown;
}

@added(Versions.v2026_10_15_preview)
@discriminator("decision")
@doc("Canonical Agent Hooks Verdict. HTTP 200 indicates evaluation completed, not permission to proceed. The host owns composition, transform application, enforcement, approvals, timeouts and audit. The service does not return an allowed/blocked wrapper, enforced content or harmResults. Unsupported members and invalid decision/approval/transform combinations are rejected.")
model AgentVerdict {
  @doc("Canonical decision: allow, deny or transform.")
  decision: AgentDecision;

  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Canonical Verdict distinguishes absent and explicit-null optional reasons."
  @doc("Optional machine-readable reason. host_error: is reserved for host-synthesized failures.")
  @pattern("^(?!host_error:).*")
  reason?: string | null;

  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Canonical Verdict allows explicit-null messages."
  @doc("Optional human-readable message.")
  message?: string | null;

  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Canonical Verdict allows absent or null warnings in addition to arrays."
  @doc("Optional structured, non-blocking warnings.")
  warnings?: AgentWarning[] | null;

  @doc("Optional opaque evidence pointer.")
  evidence?: AgentEvidence;

  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Canonical Verdict allows absent or null result labels in addition to arrays."
  @doc("Optional labels. The host persists labels with produced data only if the action proceeds and resurfaces them on later derived contexts.")
  @encodedName("application/json", "result_labels")
  resultLabels?: string[] | null;
}

@added(Versions.v2026_10_15_preview)
@doc("Permit the original target without mutation.")
model AgentAllowVerdict extends AgentVerdict {
  decision: "allow";
}

@added(Versions.v2026_10_15_preview)
@doc("Deny the action. Approval metadata makes a deny liftable only by the host's configured approval seam; without a resolver it remains denied. An unconditional mandatory deny cannot be lifted by another policy's approval.")
model AgentDenyVerdict extends AgentVerdict {
  decision: "deny";

  #suppress "@azure-tools/typespec-azure-core/bad-record-type" "The canonical approval object is opaque, heterogeneous JSON and may be empty."
  @doc("Optional complete approval metadata as a native JSON object, which may be empty.")
  approval?: AgentJsonObject;
}

@added(Versions.v2026_10_15_preview)
@doc("Permit only after the host applies the specified transform. The service does not apply it.")
model AgentTransformVerdict extends AgentVerdict {
  decision: "transform";

  @doc("Required transform metadata.")
  transform: AgentTransform;
}

@added(Versions.v2026_10_15_preview)
@error
@doc("A validation, authorization, throttling or operational failure. This is an HTTP error, never a successful allow verdict.")
model AgentEvaluationError {
  ...Azure.Core.Foundations.ErrorResponse;

  #suppress "@azure-tools/typespec-azure-core/no-closed-literal-union" "These literals declare HTTP transport status codes, not an extensible body enum."
  @statusCode
  @doc("The HTTP failure status.")
  statusCode: 400 | 401 | 403 | 429 | 500 | 503;
}

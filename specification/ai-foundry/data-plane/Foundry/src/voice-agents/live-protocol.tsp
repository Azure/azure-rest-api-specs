import "@azure-tools/typespec-client-generator-core";
import "@azure-tools/typespec-azure-core/experimental";
import "./live-models.tsp";

using Azure.ClientGenerator.Core;
using Azure.Core.Experimental;
using TypeSpec.OpenAPI;
namespace Azure.AI.Projects;

// Reuse native model identities. Foundry adds only the server-side correlation
// field and managed-delegation diagnostics below; sub_protocol stays on agents.
/** The native OpenAI Live client-event hierarchy. Foundry owns session.start; clients wait for session.started before sending the other supported native commands. */
alias VoiceAgentLiveClientEvent = OpenAI.LiveClientEvent;

/** OpenAI Live server events plus Foundry conversation correlation and managed-delegation diagnostics. */
alias VoiceAgentLiveServerEvent = OpenAI.LiveServerEvent;

// WebSocket frames are not HTTP request/response bodies. Mark their native roots
// explicitly so SDK generators retain the typed messages after the handshake.
@@usage(OpenAI.LiveClientEvent, Usage.input | Usage.json);
@@usage(OpenAI.LiveServerEvent, Usage.output | Usage.json);

@doc("Additional server-event types for Foundry managed prompt-agent delegation.")
@extension("x-ms-foundry-meta", VoiceAgentRequiredPreview)
union VoiceAgentLiveServerEventTypeExtension {
  managed_delegation_started: "session.managed_delegation.started",
  managed_delegation_progress: "session.managed_delegation.progress",
  managed_delegation_completed: "session.managed_delegation.completed",
  managed_delegation_failed: "session.managed_delegation.failed",
  managed_delegation_cancel: "session.managed_delegation.cancel",
}

#suppress "@azure-tools/typespec-azure-core/experimental-feature" "Register Foundry server events in the native discriminator, following the existing realtime protocol extension pattern."
@@copyVariants(
  OpenAI.LiveServerEventType,
  VoiceAgentLiveServerEventTypeExtension
);

#suppress "@azure-tools/typespec-azure-core/experimental-feature" "Add Foundry persistence correlation to the primary session-started event without replacing native session metadata."
@@copyProperties(
  OpenAI.LiveServerEventLiveSessionStarted,
  {
    @doc("The Foundry conversation ID, present when this connection's effective store setting is true. Use it with the existing voice conversation APIs. This is separate from session.id and does not enable native Live recording storage.")
    conversation_id?: string,
  }
);

@doc("Native context-append channels accepted from a managed prompt-agent result.")
union VoiceAgentLiveManagedAppendType {
  commentary: "session.commentary.append",
  thinking: "session.thinking.append",
}

@doc("An accepted native context append. This is a receipt, not proof that the Live model spoke the content or that the client played audio.")
@extension("x-ms-foundry-meta", VoiceAgentRequiredPreview)
model VoiceAgentLiveManagedAppend {
  @doc("The service-generated native append event ID, correlated with its acknowledgment.")
  event_id: string;

  @doc("The native context-append event type.")
  type: VoiceAgentLiveManagedAppendType;

  @doc("The validated commentary or background-context text accepted by Live. Background context is not private model reasoning.")
  content: string;

  @doc("Managed output diagnostics include only appends acknowledged as accepted.")
  status: "accepted";

  @doc("A correlated service error, when available. Omitted for successful receipts.")
  error?: string;
}

@doc("One validated assistant output item and its accepted native appends, in delivery order. Raw tool output is not included.")
@extension("x-ms-foundry-meta", VoiceAgentRequiredPreview)
model VoiceAgentLiveManagedOutput {
  @doc("The item's original index in the backend Responses output array.")
  @minValue(0)
  output_index: int32;

  @doc("Accepted native appends derived from this item.")
  @minItems(1)
  appends: VoiceAgentLiveManagedAppend[];
}

@doc("Outcome of injecting trusted failure context into Live; this never changes the failed delegation outcome.")
union VoiceAgentLiveFailureContextStatus {
  string,
  accepted: "accepted",
  rejected: "rejected",
  unconfirmed: "unconfirmed",
  skipped: "skipped",
}

@doc("Common metadata for advisory managed-delegation notifications. Correlate by delegation_id, not by a projected conversation turn. Notifications can be emitted without storing the voice conversation and are best-effort rather than a durable execution log.")
@extension("x-ms-foundry-meta", VoiceAgentRequiredPreview)
model VoiceAgentLiveManagedDelegationMetadata {
  @doc("The unique ID of this Foundry server event.")
  event_id: string;

  @doc("The original native Live delegation ID.")
  delegation_id: string;

  @doc("The same-project prompt-agent name.")
  agent_name: string;

  @doc("The target version pinned when this voice connection started.")
  agent_version: string;

  @doc("The configured managed prompt-agent result format.")
  result_format: VoiceAgentLiveManagedResultFormat;

  @doc("The backend response ID when available, otherwise null.")
  response_id: string | null;

  @doc("A content-free failure category, otherwise null. A partial_ prefix means earlier guidance was accepted before a later failure.")
  error_code: string | null;

  @doc("Whether the available validated result contains commentary. This does not assert speech or playback.")
  has_spoken_text: boolean;

  @doc("Whether the available validated result contains background context.")
  has_background_context: boolean;

  @doc("The number of completed MCP calls observed in the available backend result.")
  @minValue(0)
  mcp_call_count: int32;

  @doc("The managed backend invocation uses streaming.")
  stream: true;

  @doc("The originating native delegation's session-relative audio offset, in milliseconds.")
  offset_ms: int64;

  @doc("The backend Responses store value when reported. Omitted when unknown; independent of the voice agent's store setting.")
  backend_store?: boolean;
}

@doc("Accepted guidance reported by progress and completion notifications. Values are cumulative validated guidance, not transcript deltas or proof of spoken delivery.")
@extension("x-ms-foundry-meta", VoiceAgentRequiredPreview)
model VoiceAgentLiveManagedGuidance {
  @doc("Validated commentary text, or null when the result has no commentary.")
  spoken_text: string | null;

  @doc("Validated background-context text, or null. This is not private model reasoning.")
  background_context: string | null;
}

@doc("Optional cumulative accepted output items, including partial success before a later failure.")
@extension("x-ms-foundry-meta", VoiceAgentRequiredPreview)
model VoiceAgentLiveManagedOutputs {
  @doc("Validated assistant output items with accepted native appends. Omitted when there are none.")
  @minItems(1)
  output_items?: VoiceAgentLiveManagedOutput[];
}

@doc("Foundry has prepared valid context and is beginning a managed prompt-agent invocation.")
@extension("x-ms-foundry-meta", VoiceAgentRequiredPreview)
model VoiceAgentLiveManagedDelegationStartedEvent
  extends OpenAI.LiveServerEvent {
  type: "session.managed_delegation.started";
  ...VoiceAgentLiveManagedDelegationMetadata;
}

@doc("More validated managed output has been accepted by Live while the backend invocation is running.")
@extension("x-ms-foundry-meta", VoiceAgentRequiredPreview)
model VoiceAgentLiveManagedDelegationProgressEvent
  extends OpenAI.LiveServerEvent {
  type: "session.managed_delegation.progress";
  ...VoiceAgentLiveManagedDelegationMetadata;
  ...VoiceAgentLiveManagedGuidance;
  ...VoiceAgentLiveManagedOutputs;
}

@doc("The managed invocation and native result injection completed successfully. This does not mean Live speech or client playback has completed.")
@extension("x-ms-foundry-meta", VoiceAgentRequiredPreview)
model VoiceAgentLiveManagedDelegationCompletedEvent
  extends OpenAI.LiveServerEvent {
  type: "session.managed_delegation.completed";
  ...VoiceAgentLiveManagedDelegationMetadata;
  ...VoiceAgentLiveManagedGuidance;
  ...VoiceAgentLiveManagedOutputs;

  @doc("The backend agent's conversation ID when available, otherwise null. Distinct from the voice conversation_id and the native Live session.id.")
  backend_conversation_id: string | null;
}

@doc("The managed invocation or native result injection failed. Cancellation and supersession use the separate cancel notification. Accepted earlier output may be retained, but failed result text is not exposed as spoken_text or background_context.")
@extension("x-ms-foundry-meta", VoiceAgentRequiredPreview)
model VoiceAgentLiveManagedDelegationFailedEvent
  extends OpenAI.LiveServerEvent {
  type: "session.managed_delegation.failed";
  ...VoiceAgentLiveManagedDelegationMetadata;
  ...VoiceAgentLiveManagedOutputs;

  @doc("Whether trusted failure context reached Live: accepted, rejected, unconfirmed, or skipped; null if unavailable. Even accepted does not turn the failed invocation into success.")
  failure_context_status: VoiceAgentLiveFailureContextStatus | null;
}

@doc("Server notification that the managed invocation was cancelled or superseded. This is not a client cancellation command. Earlier accepted output may remain, but no new guidance or successful completion is implied.")
@extension("x-ms-foundry-meta", VoiceAgentRequiredPreview)
model VoiceAgentLiveManagedDelegationCancelEvent
  extends OpenAI.LiveServerEvent {
  type: "session.managed_delegation.cancel";
  ...VoiceAgentLiveManagedDelegationMetadata;
  ...VoiceAgentLiveManagedOutputs;
}

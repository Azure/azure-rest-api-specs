import "./live-protocol.tsp";

using TypeSpec.OpenAPI;
namespace Azure.AI.Projects;

#suppress "@azure-tools/typespec-client-generator-core/use-union-hierarchy" "A persistence-only union reuses native realtime items without adding Live-only item types to the realtime inference hierarchy."
@doc("An item returned by the shared voice conversation read APIs: a native realtime item or a persisted Live delegation. This union is not used by realtime or Live inference commands.")
@extension("x-ms-foundry-meta", VoiceAgentRequiredPreview)
@oneOf
union VoiceConversationItem {
  message: OpenAI.RealtimeConversationItemMessage,
  function_call: OpenAI.RealtimeConversationItemFunctionCall,
  function_call_output: OpenAI.RealtimeConversationItemFunctionCallOutput,
  mcp_list_tools: OpenAI.RealtimeMCPListTools,
  mcp_call: OpenAI.RealtimeMCPToolCall,
  mcp_approval_request: OpenAI.RealtimeMCPApprovalRequest,
  mcp_approval_response: OpenAI.RealtimeMCPApprovalResponse,
  live_delegation: VoiceLiveDelegationConversationItem,
}

@doc("The native delegation target. A Foundry-managed prompt agent uses native client delegation.")
union VoiceLiveDelegationTarget {
  responses: "responses",
  client: "client",
}

@doc("Observed delegation or backend execution status, independent of speech and playback.")
union VoiceLiveDelegationStatus {
  string,
  in_progress: "in_progress",
  completed: "completed",
  failed: "failed",
  incomplete: "incomplete",
  cancelled: "cancelled",
}

@doc("Whether the bounded capture retained all observed delegation data.")
union VoiceLiveDelegationCaptureStatus {
  string,
  complete: "complete",
  incomplete: "incomplete",
}

@doc("The source of captured delegation input, not an inferred native backend request.")
union VoiceLiveDelegationInputSource {
  string,
  live_transcript_context: "live_transcript_context",
  managed_responses_request: "managed_responses_request",
}

@doc("A durable Live-only delegation item. One item represents one native delegation ID and may link to a projected voice turn through response_id. This is not an assistant transcript, a native tool call, or an inference event. Available only when the voice conversation is stored.")
@extension("x-ms-foundry-meta", VoiceAgentRequiredPreview)
model VoiceLiveDelegationConversationItem {
  @doc("The persisted item discriminator.")
  type: "live_delegation";

  @doc("The Foundry conversation item ID, distinct from the native delegation ID.")
  id: string;

  @doc("The projected voice response/turn ID when association can be resolved; otherwise omitted.")
  response_id?: string;

  @doc("The service-observed creation time, encoded as Unix seconds.")
  created_at: FoundryTimestamp;

  @doc("The originating native Live delegation ID.")
  delegation_id: string;

  @doc("The native target. Managed prompt-agent executions are recorded under client.")
  target: VoiceLiveDelegationTarget;

  @doc("The native delegation's session-relative offset in milliseconds, when provided. This is not a WAV byte offset.")
  offset_ms?: int64;

  @doc("Observed backend/client completion, never completion of spoken audio.")
  status: VoiceLiveDelegationStatus;

  @doc("Whether all observed delegation data was retained within capture limits.")
  capture_status: VoiceLiveDelegationCaptureStatus;

  @doc("Why capture is incomplete, such as connection_lost, capture_limit, or delegation_event_missing.")
  capture_reason?: string;

  @doc("Available input provenance and bounded caption context.")
  input: VoiceLiveDelegationInput;

  @doc("Observed native backend responses, client append receipts, or managed-agent execution.")
  output: VoiceLiveDelegationOutput;
}

@doc("Captured input provenance. Caption-derived context does not claim to reconstruct the exact native backend request.")
@extension("x-ms-foundry-meta", VoiceAgentRequiredPreview)
model VoiceLiveDelegationInput {
  @doc("Where this recorded input came from.")
  source: VoiceLiveDelegationInputSource;

  @doc("Whether output.managed_prompt_agent.request contains the exact prepared backend request.")
  exact_backend_request_available: boolean;

  @doc("Whether the bounded context window omitted older transcript fragments.")
  truncated: boolean;

  @doc("Observed user/assistant captions up to the delegation boundary. Empty when the exact managed request is recorded instead.")
  messages: VoiceLiveDelegationContextMessage[];
}

@doc("A caption-derived context message, not a reconstructed native input item.")
@extension("x-ms-foundry-meta", VoiceAgentRequiredPreview)
model VoiceLiveDelegationContextMessage {
  @doc("The original speaker.")
  role: VoiceLiveDelegationContextRole;

  @doc("The original caption text.")
  text: string;
}

@doc("The speaker of a captured caption.")
union VoiceLiveDelegationContextRole {
  user: "user",
  assistant: "assistant",
}

@doc("Recorded output for native client/Responses delegation and Foundry-managed prompt agents.")
@extension("x-ms-foundry-meta", VoiceAgentRequiredPreview)
model VoiceLiveDelegationOutput {
  @doc("The managed execution, when Foundry executed a same-project prompt agent.")
  managed_prompt_agent?: VoiceLiveManagedPromptAgentExecution;

  @doc("One entry per observed backend response, including distinct tool continuations.")
  responses: VoiceLiveDelegationBackendResult[];

  @doc("Client append messages actually sent to Live and their separately observed acceptance.")
  client_messages: VoiceLiveDelegationClientMessage[];
}

@doc("A recorded managed prompt-agent execution. Null optional values are omitted, unlike the nullable fields of transient lifecycle notifications.")
@extension("x-ms-foundry-meta", VoiceAgentRequiredPreview)
model VoiceLiveManagedPromptAgentExecution {
  @doc("The exact prepared backend JSON request, when retained. This stored diagnostic is separate from the removed request notification and contains no HTTP headers or credentials.")
  request?: Record<unknown>;

  @doc("Validated assistant outputs whose native appends were accepted, in delivery order.")
  output_items?: VoiceAgentLiveManagedOutput[];

  @doc("The same-project target name.")
  agent_name: string;

  @doc("The target version pinned for the voice connection.")
  agent_version: string;

  @doc("The declared result interpretation.")
  result_format: VoiceAgentLiveManagedResultFormat;

  @doc("The independently executed backend response ID, when available.")
  response_id?: string;

  @doc("The execution/injection outcome, including cancelled when superseded.")
  status: VoiceLiveDelegationStatus;

  @doc("A content-free failure or cancellation category, when available.")
  error_code?: string;

  @doc("The native acceptance outcome for trusted failure context, when applicable.")
  failure_context_status?: VoiceAgentLiveFailureContextStatus;

  @doc("Validated commentary, not proof of speech or playback.")
  spoken_text?: string;

  @doc("Validated background facts, not private model reasoning.")
  background_context?: string;
}

@doc("A backend response reconstructed from observed public events. An empty terminal output array does not erase previously captured streamed output.")
@extension("x-ms-foundry-meta", VoiceAgentRequiredPreview)
model VoiceLiveDelegationBackendResult {
  @doc("The native backend response ID, when available.")
  id?: string;

  @doc("The model reported by the backend, not a guessed deployment name.")
  `model`?: string;

  @doc("The last observed response status.")
  status: VoiceLiveDelegationStatus;

  @doc("Text reconstructed from observed deltas or output items.")
  text: string;

  @doc("Observed heterogeneous Responses item objects, including tool arguments/results and partial captures. They are retained as received rather than forced into a completed-item schema.")
  output: Record<unknown>[];

  @doc("A reported backend error or incomplete reason, when available.")
  error?: string;
}

@doc("Native append commands that can supply client delegation context.")
union VoiceLiveDelegationClientMessageType {
  commentary: "session.commentary.append",
  thinking: "session.thinking.append",
  instructions: "session.instructions.append",
}

@doc("Observed native acceptance, independent of message submission.")
union VoiceLiveDelegationClientMessageStatus {
  accepted: "accepted",
  rejected: "rejected",
  unconfirmed: "unconfirmed",
}

@doc("A recorded client delegation result and its acknowledgment state, not an unapproved draft or a spoken transcript.")
@extension("x-ms-foundry-meta", VoiceAgentRequiredPreview)
model VoiceLiveDelegationClientMessage {
  @doc("The client event ID used for acknowledgment correlation.")
  event_id: string;

  @doc("The native context-append command.")
  type: VoiceLiveDelegationClientMessageType;

  @doc("The actual submitted content.")
  content: string;

  @doc("Whether Live accepted, rejected, or did not confirm the append.")
  status: VoiceLiveDelegationClientMessageStatus;

  @doc("A correlated service error, when present.")
  error?: string;
}

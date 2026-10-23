import "@typespec/http";
import "@typespec/openapi";
import "@azure-tools/openai-typespec/models/realtime";
import "@azure-tools/typespec-client-generator-core";
import "@azure-tools/typespec-azure-core";
import "../common/servicepatterns.tsp";
import "../agents/models.tsp";

using TypeSpec.Http;
using TypeSpec.OpenAPI;
using Azure.ClientGenerator.Core;

namespace Azure.AI.Projects;

const VoiceAgentHandoffRequiredPreview = #{
  required_previews: #[AgentDefinitionOptInKeys.voice_agents_v1_preview],
};

alias VoiceAgentHandoffServerEventUsage = Usage.output | Usage.json;

@doc("A case-sensitive identifier for an inlined subagent or handoff condition.")
@pattern("^[a-z][a-z0-9_-]{0,63}$")
scalar VoiceAgentHandoffId extends string;

@doc("A handoff node reference: either `$entrypoint` or a configured node identifier.")
@pattern("^(?:\\$entrypoint|[a-z][a-z0-9_-]{0,63})$")
scalar VoiceAgentHandoffNodeReference extends string;

@doc("Whether Voice Live automatically starts a response after a handoff target becomes active.")
@extension("x-ms-foundry-meta", VoiceAgentHandoffRequiredPreview)
union VoiceAgentHandoffTargetResponse {
  auto: "auto",
  none: "none",
}

@doc("Reasoning effort applied by a compatible handoff-node model.")
@extension("x-ms-foundry-meta", VoiceAgentHandoffRequiredPreview)
union VoiceAgentHandoffReasoningEffort {
  none: "none",
  minimal: "minimal",
  low: "low",
  medium: "medium",
  high: "high",
  xhigh: "xhigh",
}

@doc("A positive output-token limit for one handoff-node response.")
@minValue(1)
scalar VoiceAgentHandoffMaxOutputTokenCount extends int32;

@doc("The maximum output-token count or the literal `inf` for a handoff node.")
@extension("x-ms-foundry-meta", VoiceAgentHandoffRequiredPreview)
union VoiceAgentHandoffMaxOutputTokens {
  count: VoiceAgentHandoffMaxOutputTokenCount,
  unlimited: "inf",
}

@doc("Voice-optimized instruction adaptation applied while a handoff node is active.")
@extension("x-ms-foundry-meta", VoiceAgentHandoffRequiredPreview)
model VoiceAgentHandoffVoiceAdaptation {
  @doc("The adaptation strategy. Currently only `auto` is supported.")
  type: "auto";
}

@doc("One allowed outgoing handoff from an inline voice subagent.")
@extension("x-ms-foundry-meta", VoiceAgentHandoffRequiredPreview)
model VoiceAgentHandoffCondition {
  @doc("The handoff condition identifier.")
  id: VoiceAgentHandoffId;

  @doc("The target subagent identifier or `$entrypoint`. The containing subagent supplies the source.")
  target: VoiceAgentHandoffNodeReference;

  @doc("Natural-language routing guidance supplied alongside the active subagent instructions. This is not an executable Boolean predicate.")
  @minLength(1)
  @maxLength(500)
  condition: string;

  @doc("Whether user interruption before commit cancels the pending handoff. If omitted, the service defaults to false.")
  cancel_on_interruption?: boolean = false;

  @doc("The minimum delay before target activation, in milliseconds, from 0 through 10000. If omitted, the service defaults to 0.")
  @minValue(0)
  @maxValue(10000)
  delay_ms?: int32 = 0;

  @doc("""
    Optional deterministic source-voice announcement played before target activation. Supported by cascaded
    pipelines and realtime pipelines using local Azure TTS; model-native realtime voice requires omission or null.
    At most 500 characters. If omitted or null, no announcement is played.
    """)
  @maxLength(500)
  transfer_message?: string | null;

  @doc("Whether Voice Live automatically starts a response after target activation. If omitted, the service defaults to `auto`.")
  target_response?: VoiceAgentHandoffTargetResponse = VoiceAgentHandoffTargetResponse.auto;
}

@doc("One inline voice subagent owned and versioned with its parent Voice Agent, not a separate Agent resource.")
@extension("x-ms-foundry-meta", VoiceAgentHandoffRequiredPreview)
model InlineVoiceSubagent {
  @doc("The subagent identifier. New Handoff authoring requires `$entrypoint` as the first subagent; other values use the normal handoff ID grammar.")
  id: VoiceAgentHandoffNodeReference;

  @doc("The definition source. This phase supports only `inline`; referenced Agent resources are deferred.")
  source: "inline";

  @doc("The interaction interface. This phase supports only `voice`; text delegation is deferred.")
  `interface`: "voice";

  @doc("A display-only description of the specialist behavior. This value is not provided to the model.")
  @encodedName("application/json", "description")
  @minLength(1)
  display_description: string;

  @doc("The target model for a cascaded graph. Realtime graphs reject this property and retain the connection model.")
  `model`?: string;

  @doc("Subagent-specific instructions. With default inheritance, non-empty instructions follow the original top-level instructions. Omission, null, or an empty string adds nothing after that base. With inheritance disabled, only this value applies.")
  instructions?: string | null;

  @doc("Whether the subagent inherits the original top-level instructions before applying its own non-empty instructions. Defaults to true; set to false to opt out.")
  inherit_base_instructions?: boolean = true;

  @doc("Customer tools available to this subagent. Omission or null selects an empty customer tool set.")
  tools?: VoiceAgentTool[] | null;

  @doc("Tool-selection behavior for this subagent. Omission or null defaults to `auto`.")
  tool_choice?: VoiceAgentToolChoice | null;

  @doc("The voice activated for this subagent. Omission inherits the entrypoint voice; null clears it where supported.")
  voice?: VoiceAgentVoice | null;

  @doc("The sampling temperature for a compatible subagent model.")
  @minValue(0)
  @maxValue(2)
  temperature?: float32 | null;

  @doc("The maximum output-token count for one response while this subagent is active.")
  max_response_output_tokens?: VoiceAgentHandoffMaxOutputTokens | null;

  @doc("Reasoning effort for a compatible subagent model.")
  reasoning_effort?: VoiceAgentHandoffReasoningEffort | null;

  @doc("Voice-optimized instruction adaptation for this subagent. Null disables adaptation.")
  voice_adaptation?: VoiceAgentHandoffVoiceAdaptation | null;

  @doc("Interim-response settings for this subagent. Null disables interim responses.")
  interim_response?: VoiceAgentInterimResponseConfig | null;

  @doc("Whether this subagent may call customer tools in parallel. Subagents with outgoing handoff conditions must use `false`.")
  parallel_tool_calls?: boolean = false;

  @doc("Outgoing handoffs from this subagent. The containing subagent supplies each condition's source. The service permits at most 128 conditions across the entire Agent.")
  @maxItems(128)
  handoff_conditions?: VoiceAgentHandoffCondition[];
}

@doc("Session-wide limits shared by all handoff conditions in one Voice Agent session.")
@extension("x-ms-foundry-meta", VoiceAgentHandoffRequiredPreview)
model VoiceAgentHandoffPolicy {
  @doc("The maximum number of successfully completed handoffs in one session, from 1 through 100. If omitted, the service defaults to 16.")
  @minValue(1)
  @maxValue(100)
  max_transfers?: int32 = 16;

  @doc("The maximum number of attempted handoffs, from 1 through 100. If omitted, the service uses `max_transfers`. The service requires this value to be greater than or equal to `max_transfers`.")
  @minValue(1)
  @maxValue(100)
  max_attempts?: int32;
}

@doc("A typed voice configuration used by a voice-agent handoff node.")
@discriminator("type")
@extension("x-ms-foundry-meta", VoiceAgentHandoffRequiredPreview)
model VoiceAgentVoice {
  @doc("The voice implementation. Additional values may be added over time.")
  type: VoiceType;
}

@doc("An OpenAI built-in voice used by a handoff node.")
@extension("x-ms-foundry-meta", VoiceAgentHandoffRequiredPreview)
model OpenAIVoice extends VoiceAgentVoice {
  type: VoiceType.openai;

  @doc("The OpenAI built-in voice name.")
  @minLength(1)
  name: string;
}

@doc("Properties shared by Azure synthesized voices used by handoff nodes.")
@extension("x-ms-foundry-meta", VoiceAgentHandoffRequiredPreview)
model VoiceAgentAzureVoiceProperties {
  @doc("The synthesis temperature.")
  @minValue(0)
  @maxValue(1)
  temperature?: float32;

  @doc("The URL of a custom pronunciation lexicon.")
  custom_lexicon_url?: url;

  @doc("The URL of a custom text-normalization configuration.")
  custom_text_normalization_url?: url;

  @doc("Preferred BCP-47 locales for multilingual synthesis.")
  prefer_locales?: string[];

  @doc("The enforced BCP-47 output locale.")
  locale?: string;

  @doc("The voice speaking style.")
  style?: string;

  @doc("The SSML-compatible pitch adjustment.")
  pitch?: string;

  @doc("The SSML-compatible speaking-rate adjustment.")
  rate?: string;

  @doc("The SSML-compatible volume adjustment.")
  volume?: string;
}

@doc("An Azure standard neural voice used by a handoff node.")
@extension("x-ms-foundry-meta", VoiceAgentHandoffRequiredPreview)
model AzureStandardVoice extends VoiceAgentVoice {
  type: VoiceType.azure_standard;
  ...VoiceAgentAzureVoiceProperties;

  @doc("The Azure neural voice name.")
  @minLength(1)
  name: string;

  @doc("The speaker name used by a multi-talker voice.")
  multi_talker_speaker_name?: string;
}

@doc("An Azure custom neural voice used by a handoff node.")
@extension("x-ms-foundry-meta", VoiceAgentHandoffRequiredPreview)
model AzureCustomVoice extends VoiceAgentVoice {
  type: VoiceType.azure_custom;
  ...VoiceAgentAzureVoiceProperties;

  @doc("The custom voice name.")
  @minLength(1)
  name: string;

  @doc("The Azure Speech custom voice deployment endpoint identifier.")
  @minLength(1)
  endpoint_id: string;
}

@doc("An Azure personal voice used by a handoff node.")
@extension("x-ms-foundry-meta", VoiceAgentHandoffRequiredPreview)
model AzurePersonalVoice extends VoiceAgentVoice {
  type: VoiceType.azure_personal;
  ...VoiceAgentAzureVoiceProperties;

  @doc("The personal voice name.")
  @minLength(1)
  name: string;

  @doc("The neural model used by the personal voice.")
  @minLength(1)
  `model`: string;
}

@doc("An Azure avatar voice-synchronization configuration used by a handoff node.")
@extension("x-ms-foundry-meta", VoiceAgentHandoffRequiredPreview)
model AzureAvatarVoiceSyncVoice extends VoiceAgentVoice {
  type: VoiceType.avatar_voice_sync;
  ...VoiceAgentAzureVoiceProperties;

  @doc("The neural model used to synthesize the avatar voice.")
  @minLength(1)
  `model`: string;
}

@doc("An Azure realtime-native voice used by a handoff node.")
@extension("x-ms-foundry-meta", VoiceAgentHandoffRequiredPreview)
model AzureRealtimeNativeVoice extends VoiceAgentVoice {
  type: VoiceType.azure_realtime_native;

  @doc("The Azure realtime-native voice name.")
  @minLength(1)
  name: string;
}

@doc("The immutable pipeline family selected for a voice-agent handoff graph.")
@extension("x-ms-foundry-meta", VoiceAgentHandoffRequiredPreview)
union VoiceAgentHandoffPipelineFamily {
  cascaded: "cascaded",
  realtime: "realtime",
}

@doc("Non-sensitive topology metadata for one compiled handoff node.")
@extension("x-ms-foundry-meta", VoiceAgentHandoffRequiredPreview)
model VoiceAgentHandoffNodeState {
  @doc("The node identifier or `$entrypoint`.")
  id: VoiceAgentHandoffNodeReference;

  @doc("The display-only node description. This value is not provided to the model.")
  @encodedName("application/json", "description")
  display_description: string;

  @doc("Whether this is the implicit `$entrypoint` node.")
  implicit?: boolean = false;
}

@doc("Non-sensitive topology metadata for one compiled handoff edge.")
@extension("x-ms-foundry-meta", VoiceAgentHandoffRequiredPreview)
model VoiceAgentHandoffEdgeState {
  @doc("The edge identifier.")
  id: VoiceAgentHandoffId;

  @doc("The source node identifier or `$entrypoint`.")
  source: VoiceAgentHandoffNodeReference;

  @doc("The target node identifier or `$entrypoint`.")
  target: VoiceAgentHandoffNodeReference;

  @doc("Whether user interruption before commit cancels the pending handoff.")
  cancel_on_interruption?: boolean = false;

  @doc("The minimum delay before target activation, in milliseconds.")
  @minValue(0)
  @maxValue(10000)
  delay_ms?: int32 = 0;

  @doc("The deterministic source-voice announcement played before target activation.")
  @maxLength(500)
  transfer_message?: string | null;

  @doc("Whether Voice Live automatically starts a response after target activation.")
  target_response?: VoiceAgentHandoffTargetResponse = VoiceAgentHandoffTargetResponse.auto;
}

@doc("The effective topology and runtime state of a voice-agent handoff graph.")
@extension("x-ms-foundry-meta", VoiceAgentHandoffRequiredPreview)
model VoiceAgentHandoffState {
  @doc("The immutable execution pipeline family.")
  pipeline_family: VoiceAgentHandoffPipelineFamily;

  @doc("The currently committed node identifier or `$entrypoint`.")
  active_node_id: VoiceAgentHandoffNodeReference;

  @doc("The monotonically increasing generation of the committed active-node configuration.")
  @minValue(1)
  node_generation: int32;

  @doc("The number of successfully completed handoffs.")
  @minValue(0)
  transfer_count: int32;

  @doc("The number of unique reserved handoff attempts.")
  @minValue(0)
  attempt_count: int32;

  @doc("The edge identifiers currently available from the active node.")
  available_edge_ids: VoiceAgentHandoffId[];

  @doc("The generated handoff function visible to the active model, or null when no route is available.")
  transfer_tool: VoiceAgentFunctionTool | null;

  @doc("The compiled handoff nodes, including the implicit or explicit `$entrypoint`.")
  nodes: VoiceAgentHandoffNodeState[];

  @doc("The compiled handoff edges.")
  edges: VoiceAgentHandoffEdgeState[];
}

@doc("Fields shared by server events that report one server-managed handoff attempt.")
@extension("x-ms-foundry-meta", VoiceAgentHandoffRequiredPreview)
model VoiceAgentServerEventSessionHandoffLifecycle {
  @doc("The server-generated event identifier.")
  event_id: string;

  @doc("The server-generated handoff attempt identifier.")
  handoff_id: string;

  @doc("The configured edge selected for this handoff.")
  edge_id: VoiceAgentHandoffId;

  @doc("The source node identifier or `$entrypoint`.")
  from_node_id: VoiceAgentHandoffNodeReference;

  @doc("The target node identifier or `$entrypoint`.")
  to_node_id: VoiceAgentHandoffNodeReference;

  @doc("The model active before the handoff.")
  from_model: string;

  @doc("The model prepared for the target behavior.")
  to_model: string;

  @doc("The function-call identifier that initiated the handoff.")
  tool_call_id: string;

  @doc("The source generation for started or aborted events, and the committed target generation for completed events.")
  @minValue(1)
  node_generation: int32;
}

@doc("The `session.handoff.started` server event.")
@usage(VoiceAgentHandoffServerEventUsage)
@extension("x-ms-foundry-meta", VoiceAgentHandoffRequiredPreview)
model VoiceAgentServerEventSessionHandoffStarted
  extends OpenAI.RealtimeServerEvent {
  @doc("The event type. Always `session.handoff.started`.")
  type: "session.handoff.started";

  ...VoiceAgentServerEventSessionHandoffLifecycle;
}

@doc("The `session.handoff.completed` server event.")
@usage(VoiceAgentHandoffServerEventUsage)
@extension("x-ms-foundry-meta", VoiceAgentHandoffRequiredPreview)
model VoiceAgentServerEventSessionHandoffCompleted
  extends OpenAI.RealtimeServerEvent {
  @doc("The event type. Always `session.handoff.completed`.")
  type: "session.handoff.completed";

  ...VoiceAgentServerEventSessionHandoffLifecycle;

  @doc("The target-preparation duration.")
  prepare_duration_ms: FoundryDurationMilliseconds;

  @doc("The total handoff duration.")
  duration_ms: FoundryDurationMilliseconds;
}

@doc("Why a server-managed handoff ended before target commit.")
@extension("x-ms-foundry-meta", VoiceAgentHandoffRequiredPreview)
union VoiceAgentHandoffAbortReason {
  user_interruption: "user_interruption",
  error: "error",
}

@doc("The `session.handoff.aborted` server event.")
@usage(VoiceAgentHandoffServerEventUsage)
@extension("x-ms-foundry-meta", VoiceAgentHandoffRequiredPreview)
model VoiceAgentServerEventSessionHandoffAborted
  extends OpenAI.RealtimeServerEvent {
  @doc("The event type. Always `session.handoff.aborted`.")
  type: "session.handoff.aborted";

  ...VoiceAgentServerEventSessionHandoffLifecycle;

  @doc("Why the handoff ended before target commit.")
  reason: VoiceAgentHandoffAbortReason;

  @doc("The handoff failure detail when `reason` is `error`.")
  error?: OpenAI.RealtimeServerEventErrorError | null;
}

import "@typespec/http";
import "@typespec/openapi";
import "@typespec/versioning";
import "@azure-tools/openai-typespec/models/realtime";
import "../common/servicepatterns.tsp";
import "../agents/models.tsp";
import "../openai/responses/models.tsp";

using TypeSpec.Http;
using TypeSpec.OpenAPI;
using TypeSpec.Versioning;

namespace Azure.AI.Projects;

// ============================================================================
// Voice agent definition, configuration, resource, and request
// models. These are split out from the text `/agents` surface so that
// `/agents` carries only text agent kinds and `/voice_agents` carries only
// voice agents. Shared agent shapes (AgentObject,
// AgentVersionObject, request/response envelopes) are reused from
// `../agents/models.tsp` via property spreads to avoid drift.
// ============================================================================

const VoiceAgentRequiredPreview = #{
  required_previews: #[AgentDefinitionOptInKeys.voice_agents_v1_preview],
};

@doc("""
  The voice agent definition. Its configuration (model, instructions, audio, tools, and optional avatar) drives a
  managed speech-to-speech experience. The realtime voice session is established through a separate connect operation
  that is not defined in this specification. Every create or update produces a new immutable version.
  """)
@extension("x-ms-foundry-meta", VoiceAgentRequiredPreview)
model VoiceAgentDefinition {
  @doc("The kind discriminator for a voice agent definition. Always `voice`.")
  kind: "voice";

  @doc("Configuration for Responsible AI (RAI) content filtering and safety features.")
  rai_config?: RaiConfig;

  @doc("How the model backing this agent is served. Together with `model`, this selects the model up front. `managed` uses a service-managed model; `self_deployed` uses the customer's own Foundry deployment. This is independent of the architecture (realtime or cascaded), which the service derives from the selected model.")
  model_type: VoiceModelType;

  @doc("The model to use for this agent, paired with `model_type`: the service-managed model name when `model_type` is `managed`, or the customer's Foundry deployment name when `model_type` is `self_deployed`. The model must support realtime or cascaded voice. The service derives the architecture from the selected model.")
  `model`: string;

  @doc("A system (or developer) message inserted into the model's context. Supports template substitution via `structured_inputs`, rendered per session before the live session starts.")
  instructions?: string;

  @doc("Optional session-start greeting. Template mode speaks exact rendered text; LLM-generated mode asks the session model to author the opening response and may use configured tools.")
  greeting?: VoiceGreetingConfig;

  @doc("""
    The audio configuration, including input and output formats, voice, turn detection, noise reduction, and
    transcription. These values are session defaults; a client may override supported fields when connecting.
    """)
  audio?: VoiceAudioConfig;

  @doc("""
    The output modalities the agent produces. Defaults to `["audio"]`. `animation` and `avatar` are available
    when an avatar is configured.
    """)
  output_modalities?: VoiceOutputModality[] = #[VoiceOutputModality.audio];

  @doc("Optional avatar configuration. These values are session defaults and may be overridden when connecting.")
  avatar?: VoiceAvatarConfig;

  @doc("""
    The tools the voice agent may use. Supported tool kinds are `function` (executed by the client), `mcp`,
    `system` (service-managed session controls), and `toolbox`. Server-side tools such as `web_search`,
    `azure_ai_search`, and `openapi` are provided through a toolbox rather than declared directly.
    """)
  tools?: VoiceAgentTool[];

  @doc("""
    How the model chooses tools for generated responses. `none` prevents tool calls, `auto` lets the model decide,
    `required` requires at least one tool call, and a specific function or MCP tool can be selected with an object.
    Defaults to `auto`.
    """)
  tool_choice?: VoiceAgentToolChoice = OpenAI.ToolChoiceOptions.auto;

  @doc("""
    A customer-authored handoff graph. The voice agent definition is the implicit `$entrypoint`; configured nodes
    provide specialist behavior, and directed edges declare the server-managed transfer routes.
    """)
  handoff?: VoiceAgentHandoffGraphConfig;

  @doc("Set of structured inputs that participate in prompt template substitution, rendered per session before the live session starts.")
  structured_inputs?: Record<StructuredInputDefinition>;

  @doc("""
    Whether conversations with this agent are persisted. A single, all-or-nothing persistence switch that defaults to
    `false` (privacy-safe: off by default). When `true`, Foundry persists the full conversation — the transcript/event
    timeline and raw audio. When `false`, nothing is persisted and no conversation is surfaced. There is no separate
    audio-logging control; audio is persisted only as part of this switch. Latency/performance telemetry (e.g.
    time-to-first-audio, inter-token latency, interruption) is observability-only (customer trace / App Insights) and
    is not part of the persisted conversation content.
    """)
  store?: boolean = false;
}

@doc("Session-start greeting configuration for a voice agent.")
@discriminator("type")
@extension("x-ms-foundry-meta", VoiceAgentRequiredPreview)
model VoiceGreetingConfig {
  @doc("The greeting mode.")
  type: string;
}

@doc("A deterministic greeting rendered with the voice agent's structured inputs and synthesized without model-authored generation.")
@extension("x-ms-foundry-meta", VoiceAgentRequiredPreview)
model TemplateVoiceGreetingConfig extends VoiceGreetingConfig {
  type: "template";

  @doc("The Handlebars text template spoken at session start.")
  @minLength(1)
  text: string;
}

@doc("A greeting authored by the session model from a scoped opening-turn prompt.")
@extension("x-ms-foundry-meta", VoiceAgentRequiredPreview)
model LlmGeneratedVoiceGreetingConfig extends VoiceGreetingConfig {
  type: "llm_generated";

  @doc("The Handlebars prompt that guides the opening turn.")
  @minLength(1)
  prompt: string;

  @doc("The tool-selection policy for the opening response. Defaults to `none`.")
  tool_choice?: VoiceAgentToolChoice = OpenAI.ToolChoiceOptions.none;
}

@doc("""
  How the model backing a voice agent is served. This is independent of the architecture (realtime or cascaded),
  which the service derives from the selected model.
  """)
@extension("x-ms-foundry-meta", VoiceAgentRequiredPreview)
union VoiceModelType {
  string,

  @doc("The service hosts and manages the named model, for example `gpt-realtime`.")
  managed: "managed",

  @doc("The service uses the customer's own Foundry deployment named by `model`.")
  self_deployed: "self_deployed",
}

@doc("""
  A tool usable by a voice agent. Supported kinds are native `function` tools (executed by the client), `mcp`,
  service-managed `system` controls, and `toolbox` references. Server-side tools such as `web_search` and
  `azure_ai_search` are provided through a toolbox.
  """)
@extension("x-ms-foundry-meta", VoiceAgentRequiredPreview)
union VoiceAgentTool {
  @doc("A native function tool, executed by the client.")
  function: OpenAI.RealtimeFunctionTool,

  @doc("An MCP tool executed by the service. The agent resolves authentication, for example through a Foundry connection.")
  mcp: VoiceAgentMcpTool,

  @doc("A service-managed control that acts on the active voice session.")
  system: VoiceSystemTool,

  @doc("A reference to a Foundry toolbox executed through its MCP endpoint.")
  toolbox: VoiceToolboxTool,
}

#suppress "@azure-tools/typespec-autorest/union-unsupported" "Tool choice may be a mode, a forced function, or an MCP tool."
@doc("Tool-selection behavior for a voice agent.")
@oneOf
@extension("x-ms-foundry-meta", VoiceAgentRequiredPreview)
union VoiceAgentToolChoice {
  mode: OpenAI.ToolChoiceOptions,
  function: OpenAI.ToolChoiceFunction,
  mcp: OpenAI.ToolChoiceMCP,
}

/** A case-sensitive identifier for a configured handoff node or edge. */
@pattern("^[a-z][a-z0-9_-]{0,63}$")
scalar VoiceAgentHandoffId extends string;

@doc("A source or target in the handoff graph.")
@extension("x-ms-foundry-meta", VoiceAgentRequiredPreview)
union VoiceAgentHandoffEndpointId {
  @doc("A configured specialist node.")
  node: VoiceAgentHandoffId,

  @doc("The implicit node represented by the voice agent definition.")
  entrypoint: "$entrypoint",
}

/** A positive maximum output-token count. */
@minValue(1)
scalar VoiceAgentPositiveOutputTokenCount extends int32;

@doc("The maximum output-token count for a handoff target.")
@extension("x-ms-foundry-meta", VoiceAgentRequiredPreview)
union VoiceAgentMaxOutputTokens {
  @doc("A positive maximum output-token count.")
  count: VoiceAgentPositiveOutputTokenCount,

  @doc("No finite output-token limit.")
  unlimited: "inf",
}

@doc("Whether a handoff target automatically creates a response after transfer.")
@extension("x-ms-foundry-meta", VoiceAgentRequiredPreview)
union VoiceAgentHandoffTargetResponse {
  @doc("Create a response after activating the target.")
  auto: "auto",

  @doc("Do not create a response after activating the target.")
  none: "none",
}

@doc("Reasoning effort accepted by a handoff target.")
@extension("x-ms-foundry-meta", VoiceAgentRequiredPreview)
union VoiceAgentHandoffReasoningEffort {
  @doc("Disable reasoning effort.")
  none: "none",

  @doc("Use minimal reasoning effort.")
  minimal: "minimal",

  @doc("Use low reasoning effort.")
  low: "low",

  @doc("Use medium reasoning effort.")
  medium: "medium",

  @doc("Use high reasoning effort.")
  high: "high",

  @doc("Use extra-high reasoning effort.")
  xhigh: "xhigh",
}

@doc("Voice-optimized instruction adaptation settings.")
@extension("x-ms-foundry-meta", VoiceAgentRequiredPreview)
model VoiceAgentVoiceAdaptation {
  @doc("The adaptation strategy. Always `auto`.")
  type: "auto";
}

@doc("A condition that may trigger an interim response.")
@extension("x-ms-foundry-meta", VoiceAgentRequiredPreview)
union VoiceAgentInterimResponseTrigger {
  @doc("Trigger when response latency reaches the configured threshold.")
  latency: "latency",

  @doc("Trigger while a tool is executing.")
  tool: "tool",
}

@doc("Fields shared by interim-response configurations.")
@discriminator("type")
@extension("x-ms-foundry-meta", VoiceAgentRequiredPreview)
model VoiceAgentInterimResponseConfig {
  @doc("The interim-response implementation.")
  type: string;

  @doc("Conditions that may trigger one interim response.")
  triggers?: VoiceAgentInterimResponseTrigger[] = #[
    VoiceAgentInterimResponseTrigger.latency
  ];

  @doc("The latency threshold in milliseconds.")
  @minValue(0)
  latency_threshold_ms?: int32 = 2000;
}

@doc("A static interim response selected from configured text.")
@extension("x-ms-foundry-meta", VoiceAgentRequiredPreview)
model VoiceAgentStaticInterimResponseConfig
  extends VoiceAgentInterimResponseConfig {
  type: "static_interim_response";

  @doc("Candidate text values for the interim response.")
  texts?: string[];
}

@doc("An interim response generated by a language model.")
@extension("x-ms-foundry-meta", VoiceAgentRequiredPreview)
model VoiceAgentLlmInterimResponseConfig
  extends VoiceAgentInterimResponseConfig {
  type: "llm_interim_response";

  @doc("The model used to generate interim responses.")
  `model`?: string = "gpt-4.1-mini";

  @doc("Optional instructions for generating interim responses.")
  instructions?: string;

  @doc("The maximum completion-token count for an interim response.")
  @minValue(1)
  max_completion_tokens?: int32 = 50;
}

#suppress "@azure-tools/typespec-autorest/union-unsupported" "Interim response settings are selected by their `type` property."
@doc("Interim-response settings for latency and tool execution.")
@oneOf
@extension("x-ms-foundry-meta", VoiceAgentRequiredPreview)
union VoiceAgentInterimResponse {
  static: VoiceAgentStaticInterimResponseConfig,
  llm: VoiceAgentLlmInterimResponseConfig,
}

@doc("A configured handoff target and its node-scoped behavior.")
@extension("x-ms-foundry-meta", VoiceAgentRequiredPreview)
model VoiceAgentHandoffNodeConfig {
  @doc("The node identifier.")
  @key
  @visibility(Lifecycle.Create, Lifecycle.Read, Lifecycle.Update)
  id: VoiceAgentHandoffId;

  @doc("A non-empty description used to select this target.")
  @minLength(1)
  description: string;

  @doc("Session behavior applied after transferring to this node.")
  config: VoiceAgentHandoffNodeSessionConfig;
}

@doc("Session behavior applied at a handoff target.")
@extension("x-ms-foundry-meta", VoiceAgentRequiredPreview)
model VoiceAgentHandoffNodeSessionConfig {
  @doc("The target model, when different from the current node.")
  `model`?: string;

  @doc("Instructions applied at the target node.")
  instructions?: string;

  @doc("Tools available at the target node.")
  tools?: VoiceAgentTool[];

  @doc("Tool-selection behavior at the target node.")
  tool_choice?: VoiceAgentToolChoice;

  @doc("The target node's voice.")
  voice?: VoiceAgentVoice;

  @doc("The target node's sampling temperature.")
  @minValue(0)
  @maxValue(2)
  temperature?: float32;

  @doc("The target node's maximum output-token count.")
  max_response_output_tokens?: VoiceAgentMaxOutputTokens;

  @doc("The reasoning effort used at the target node.")
  reasoning_effort?: VoiceAgentHandoffReasoningEffort;

  @doc("Voice adaptation applied at the target node.")
  voice_adaptation?: VoiceAgentVoiceAdaptation;

  @doc("Interim-response settings applied at the target node.")
  interim_response?: VoiceAgentInterimResponse;

  @doc("Whether the target model may call multiple tools in parallel.")
  parallel_tool_calls?: boolean;
}

@doc("A directed transition between handoff nodes.")
@extension("x-ms-foundry-meta", VoiceAgentRequiredPreview)
model VoiceAgentHandoffEdgeConfig {
  @doc("The edge identifier.")
  @key
  @visibility(Lifecycle.Create, Lifecycle.Read, Lifecycle.Update)
  id: VoiceAgentHandoffId;

  @doc("The source node identifier.")
  source: VoiceAgentHandoffEndpointId;

  @doc("The target node identifier.")
  target: VoiceAgentHandoffEndpointId;

  @doc("A non-empty description used by the model to select this transition.")
  @minLength(1)
  @maxLength(500)
  description: string;

  @doc("Whether user interruption cancels the transition.")
  cancel_on_interruption?: boolean = false;

  @doc("The delay before the target behavior is committed, in milliseconds.")
  @minValue(0)
  @maxValue(10000)
  delay_ms?: int32 = 0;

  @doc("Optional text synthesized while transferring.")
  @maxLength(500)
  transfer_message?: string;

  @doc("Whether the target automatically creates a response after transfer.")
  target_response?: VoiceAgentHandoffTargetResponse = VoiceAgentHandoffTargetResponse.auto;
}

@doc("A customer-supplied handoff graph.")
@extension("x-ms-foundry-meta", VoiceAgentRequiredPreview)
model VoiceAgentHandoffGraphConfig {
  @doc("The maximum number of successful transfers in the session.")
  @minValue(1)
  @maxValue(100)
  max_transfers?: int32 = 16;

  @doc("The maximum number of transfer attempts in the session. When omitted, the service uses `max_transfers`; when provided, it must be greater than or equal to `max_transfers`.")
  @minValue(1)
  @maxValue(100)
  max_attempts?: int32;

  @doc("The explicitly configured handoff targets. The implicit `$entrypoint` is not repeated here.")
  @maxItems(31)
  nodes: VoiceAgentHandoffNodeConfig[];

  @doc("The directed transitions between handoff nodes.")
  @minItems(1)
  @maxItems(128)
  edges: VoiceAgentHandoffEdgeConfig[];
}

@doc("When an MCP invocation creates a follow-up response. Additional values may be added over time.")
@extension("x-ms-foundry-meta", VoiceAgentRequiredPreview)
union VoiceAgentMcpResponseScheduling {
  string,

  @doc("Do not create a follow-up response after the MCP invocation completes.")
  silent: "silent",

  @doc("Create a follow-up response when the conversation is idle.")
  when_idle: "when_idle",

  @doc("Interrupt the active response and create a follow-up response.")
  interrupt: "interrupt",

  @doc("Create a follow-up response only when no response is active.")
  skip_if_busy: "skip_if_busy",
}

@doc("An MCP tool available to a voice agent.")
@extension("x-ms-foundry-meta", VoiceAgentRequiredPreview)
model VoiceAgentMcpTool {
  ...OmitProperties<
    OpenAI.MCPTool,
    "authorization" | "connector_id" | "tunnel_id" | "server_url"
  >;

  @doc("The URL for the MCP server.")
  server_url?: url;

  @doc("When the MCP invocation creates a follow-up response. Defaults to `when_idle` so the agent continues after the tool call completes.")
  response_scheduling?: VoiceAgentMcpResponseScheduling = VoiceAgentMcpResponseScheduling.when_idle;
}

@doc("A service-managed control that acts on the active voice session without customer code or external authentication.")
@extension("x-ms-foundry-meta", VoiceAgentRequiredPreview)
model VoiceSystemTool {
  @doc("The type of the tool. Always `system`.")
  type: "system";

  @doc("The service-managed control action. Known values are stable; additional values may be added over time.")
  name: VoiceSystemToolName;

  @doc("An optional description of the system tool.")
  description?: string;
}

@doc("A service-managed voice-session control action. Known values are stable; additional values may be added over time.")
@extension("x-ms-foundry-meta", VoiceAgentRequiredPreview)
union VoiceSystemToolName {
  string,

  @doc("Ends the active conversation.")
  end_conversation: "end_conversation",
}

@doc("A reference to a Foundry toolbox, which is a versioned bundle of tools executed through its MCP endpoint.")
@extension("x-ms-foundry-meta", VoiceAgentRequiredPreview)
model VoiceToolboxTool {
  @doc("The type of the tool. Always `toolbox`.")
  type: "toolbox";

  @doc("The name of the toolbox to attach.")
  toolbox_name: string;

  @doc("The immutable version of the toolbox to attach.")
  toolbox_version: string;
}

@doc("""
  The audio configuration for a voice agent. These values are session defaults and may be overridden when connecting.
  """)
@extension("x-ms-foundry-meta", VoiceAgentRequiredPreview)
model VoiceAudioConfig {
  @doc("Input (microphone) audio configuration.")
  input?: VoiceAudioInputConfig;

  @doc("Output (agent speech) audio configuration.")
  output?: VoiceAudioOutputConfig;
}

@doc("Input audio configuration for a voice agent.")
@extension("x-ms-foundry-meta", VoiceAgentRequiredPreview)
model VoiceAudioInputConfig {
  @doc("The input audio format.")
  format?: VoiceAudioFormat;

  @doc("Input noise reduction. Set to null to disable.")
  noise_reduction?: VoiceNoiseReduction | null;

  @doc("Turn (end-of-speech) detection. Server-side turn detection is enabled by default; set to null to disable it, in which case the client must trigger responses manually.")
  turn_detection?: VoiceTurnDetection | null;

  @doc("Asynchronous input-audio transcription. Set to null to disable transcription.")
  transcription?: VoiceInputTranscription | null;
}

@doc("Output audio configuration for a voice agent.")
@extension("x-ms-foundry-meta", VoiceAgentRequiredPreview)
model VoiceAudioOutputConfig {
  @doc("The output audio format.")
  format?: VoiceAudioFormat;

  @doc("The typed voice configuration.")
  voice?: VoiceAgentVoice;

  @doc("""
    The OpenAI-compatible speaking speed multiplier, from 0.25 to 1.5. Defaults to 1.
    For Azure synthesized voices, use `audio.output.voice.rate` instead.
    """)
  @minValue(0.25)
  @maxValue(1.5)
  speed?: float32 = 1;

  @doc("Timestamp kinds to include with output audio.")
  output_audio_timestamp_types?: VoiceAudioTimestampType[];
}

@doc("An output-audio timestamp kind supported by a voice agent.")
@extension("x-ms-foundry-meta", VoiceAgentRequiredPreview)
union VoiceAudioTimestampType {
  @doc("Word-level timestamps.")
  word: "word",
}

@doc("An audio format. Follows the OpenAI Realtime session schema; `type` carries the media subtype.")
@extension("x-ms-foundry-meta", VoiceAgentRequiredPreview)
model VoiceAudioFormat {
  @doc("The audio format type, e.g. 'audio/pcm' (16-bit PCM), 'audio/pcmu' (G.711 mu-law), or 'audio/pcma' (G.711 A-law).")
  type: VoiceAudioFormatType;

  @doc("The sample rate in Hz. Applies to 'audio/pcm' (e.g. 24000); omit for telephony G.711 formats (8 kHz).")
  rate?: int32;
}

@doc("The audio format type. Values follow the OpenAI Realtime wire schema and are exempt from the snake_case enum-value rule.")
@extension("x-ms-foundry-meta", VoiceAgentRequiredPreview)
union VoiceAudioFormatType {
  string,

  @doc("16-bit PCM.")
  pcm: "audio/pcm",

  @doc("G.711 mu-law (telephony).")
  pcmu: "audio/pcmu",

  @doc("G.711 A-law (telephony).")
  pcma: "audio/pcma",
}

@doc("Input audio noise reduction configuration.")
@extension("x-ms-foundry-meta", VoiceAgentRequiredPreview)
model VoiceNoiseReduction {
  @doc("The noise reduction mode.")
  type: VoiceNoiseReductionType;
}

@doc("The input audio noise reduction mode.")
@extension("x-ms-foundry-meta", VoiceAgentRequiredPreview)
union VoiceNoiseReductionType {
  string,
  near_field: "near_field",
  far_field: "far_field",

  @doc("Azure deep noise suppression.")
  azure_deep_noise_suppression: "azure_deep_noise_suppression",
}

@doc("The turn-detection strategy. Additional values may be added over time.")
@extension("x-ms-foundry-meta", VoiceAgentRequiredPreview)
union VoiceTurnDetectionType {
  string,

  @doc("Server-side voice activity detection.")
  server_vad: "server_vad",

  @doc("Semantic voice activity detection.")
  semantic_vad: "semantic_vad",

  @doc("Azure semantic voice activity detection.")
  azure_semantic_vad: "azure_semantic_vad",

  @doc("English-optimized Azure semantic voice activity detection.")
  azure_semantic_vad_en: "azure_semantic_vad_en",

  @doc("Multilingual Azure semantic voice activity detection.")
  azure_semantic_vad_multilingual: "azure_semantic_vad_multilingual",
}

@doc("Turn-detection configuration for a voice agent.")
@discriminator("type")
@extension("x-ms-foundry-meta", VoiceAgentRequiredPreview)
model VoiceTurnDetection {
  @doc("The turn-detection strategy.")
  type: VoiceTurnDetectionType;
}

@doc("Server-side voice activity detection.")
@extension("x-ms-foundry-meta", VoiceAgentRequiredPreview)
model VoiceServerVadTurnDetection extends VoiceTurnDetection {
  ...OmitProperties<OpenAI.RealtimeTurnDetectionServerVad, "type">;
  type: VoiceTurnDetectionType.server_vad;
}

@doc("Semantic voice activity detection.")
@extension("x-ms-foundry-meta", VoiceAgentRequiredPreview)
model VoiceSemanticVadTurnDetection extends VoiceTurnDetection {
  ...OmitProperties<OpenAI.RealtimeTurnDetectionSemanticVad, "type">;
  type: VoiceTurnDetectionType.semantic_vad;
}

@doc("The semantic end-of-utterance detection model.")
@extension("x-ms-foundry-meta", VoiceAgentRequiredPreview)
union VoiceEndOfUtteranceDetectionModel {
  string,

  @doc("The default semantic detection model.")
  semantic_detection_v1: "semantic_detection_v1",

  @doc("The English-optimized semantic detection model.")
  semantic_detection_v1_en: "semantic_detection_v1_en",

  @doc("The multilingual semantic detection model.")
  semantic_detection_v1_multilingual: "semantic_detection_v1_multilingual",
}

@doc("The sensitivity threshold for semantic end-of-utterance detection.")
@extension("x-ms-foundry-meta", VoiceAgentRequiredPreview)
union VoiceEndOfUtteranceThresholdLevel {
  string,

  @doc("The low sensitivity threshold.")
  low: "low",

  @doc("The medium sensitivity threshold.")
  medium: "medium",

  @doc("The high sensitivity threshold.")
  high: "high",

  @doc("The service-selected sensitivity threshold.")
  default: "default",
}

#suppress "@azure-tools/typespec-azure-core/known-encoding" "The existing voice-agent wire contract requires integer-millisecond durations."
@doc("Semantic end-of-utterance detection configuration.")
@extension("x-ms-foundry-meta", VoiceAgentRequiredPreview)
model VoiceEndOfUtteranceDetection {
  @doc("The semantic detection model.")
  `model`: VoiceEndOfUtteranceDetectionModel;

  @doc("The sensitivity threshold.")
  threshold_level?: VoiceEndOfUtteranceThresholdLevel;

  @doc("The detection timeout in milliseconds.")
  @encode(DurationKnownEncoding.milliseconds, int32)
  @minValue(duration.fromISO("PT0S"))
  timeout_ms?: duration;
}

/** Options shared by Azure semantic voice activity detection configurations. */
#suppress "@azure-tools/typespec-azure-core/known-encoding" "The existing voice-agent wire contract requires integer-millisecond durations."
alias VoiceAzureSemanticVadOptions = {
  @doc("Activation threshold for voice activity detection, from 0 to 1.")
  @minValue(0)
  @maxValue(1)
  threshold?: float32;

  @doc("Audio to include before detected speech, in milliseconds.")
  @encode(DurationKnownEncoding.milliseconds, int32)
  @minValue(duration.fromISO("PT0S"))
  prefix_padding_ms?: duration;

  @doc("Silence required to end speech detection, in milliseconds.")
  @encode(DurationKnownEncoding.milliseconds, int32)
  @minValue(duration.fromISO("PT0S"))
  silence_duration_ms?: duration;

  @doc("Semantic end-of-utterance detection configuration.")
  end_of_utterance_detection?: VoiceEndOfUtteranceDetection;

  @doc("Minimum speech duration required to trigger detection, in milliseconds.")
  @encode(DurationKnownEncoding.milliseconds, int32)
  @minValue(duration.fromISO("PT0S"))
  speech_duration_ms?: duration;

  @doc("Whether filler words are removed from transcription.")
  remove_filler_words?: boolean = false;

  @doc("Whether the input audio buffer is truncated automatically when speech stops.")
  auto_truncate?: boolean = false;

  @doc("Whether a response is created automatically when speech stops.")
  create_response?: boolean = true;

  @doc("Whether user speech may interrupt the agent's response.")
  interrupt_response?: boolean = true;
};

@doc("Azure semantic voice activity detection.")
@extension("x-ms-foundry-meta", VoiceAgentRequiredPreview)
model VoiceAzureSemanticVadTurnDetection extends VoiceTurnDetection {
  type: VoiceTurnDetectionType.azure_semantic_vad;
  ...VoiceAzureSemanticVadOptions;

  @doc("BCP-47 language codes used for speech detection.")
  languages?: string[];
}

@doc("English-optimized Azure semantic voice activity detection.")
@extension("x-ms-foundry-meta", VoiceAgentRequiredPreview)
model VoiceAzureSemanticVadEnTurnDetection extends VoiceTurnDetection {
  type: VoiceTurnDetectionType.azure_semantic_vad_en;
  ...VoiceAzureSemanticVadOptions;
}

@doc("Multilingual Azure semantic voice activity detection.")
@extension("x-ms-foundry-meta", VoiceAgentRequiredPreview)
model VoiceAzureSemanticVadMultilingualTurnDetection
  extends VoiceTurnDetection {
  type: VoiceTurnDetectionType.azure_semantic_vad_multilingual;
  ...VoiceAzureSemanticVadOptions;

  @doc("BCP-47 language codes used for speech detection.")
  languages?: string[];
}

@doc("""
  The input-audio transcription model. Mirrors the transcription models supported by the managed
  voice backend, covering the OpenAI Realtime transcription models plus the Azure and MAI models.
  Additional values may be added over time.
  """)
@extension("x-ms-foundry-meta", VoiceAgentRequiredPreview)
union VoiceInputTranscriptionModel {
  string,

  @doc("OpenAI Whisper.")
  whisper_1: "whisper-1",

  @doc("OpenAI GPT Realtime Whisper.")
  gpt_realtime_whisper: "gpt-realtime-whisper",

  @doc("OpenAI GPT-4o transcribe.")
  gpt_4o_transcribe: "gpt-4o-transcribe",

  @doc("OpenAI GPT-4o mini transcribe.")
  gpt_4o_mini_transcribe: "gpt-4o-mini-transcribe",

  @doc("OpenAI GPT-4o transcribe with speaker diarization.")
  gpt_4o_transcribe_diarize: "gpt-4o-transcribe-diarize",

  @doc("OpenAI GPT Transcribe.")
  gpt_transcribe: "gpt-transcribe",

  @doc("OpenAI GPT Live Transcribe.")
  gpt_live_transcribe: "gpt-live-transcribe",

  @doc("MAI transcription.")
  mai_transcribe: "mai-transcribe",

  @doc("Azure AI Speech to text.")
  azure_speech: "azure-speech",
}

@doc("""
  Asynchronous input-audio transcription configuration. Extends the OpenAI Realtime transcription
  options with the Azure and MAI transcription models, custom speech models, and phrase hints.
  """)
@extension("x-ms-foundry-meta", VoiceAgentRequiredPreview)
model VoiceInputTranscription {
  ...OmitProperties<OpenAI.AudioTranscription, "model">;

  @doc("The transcription model to use.")
  `model`: VoiceInputTranscriptionModel;

  @doc("Optional custom speech model configuration, keyed by locale.")
  custom_speech?: Record<string>;

  @doc("Optional phrase hints that bias recognition toward domain terms.")
  phrase_list?: string[];
}

@doc("A typed voice configuration accepted by a voice agent.")
union VoiceAgentVoice {
  OpenAIVoice,
  AzureVoice,
  AzureRealtimeNativeVoice,
}

@doc("An OpenAI built-in voice configuration with an explicit type discriminator.")
model OpenAIVoice {
  @doc("The voice kind. Always `openai`.")
  type: "openai";

  @doc("The OpenAI built-in voice name.")
  name: OpenAI.VoiceIdsShared;
}

@doc("Base configuration shared by Azure synthesized voices.")
@discriminator("type")
@extension("x-ms-foundry-meta", VoiceAgentRequiredPreview)
model AzureVoice {
  @doc("The Azure voice kind.")
  type: AzureVoiceType;

  @doc("The synthesis temperature, from 0 to 1.")
  @minValue(0)
  @maxValue(1)
  temperature?: float32;

  @doc("The URL of a custom pronunciation lexicon.")
  custom_lexicon_url?: url;

  @doc("The URL of a custom text-normalization service.")
  custom_text_normalization_url?: url;

  @doc("Preferred BCP-47 locales that influence language accents.")
  prefer_locales?: string[];

  @doc("The enforced BCP-47 locale. When omitted, the language is detected from the text.")
  locale?: string;

  @doc("The speaking style, such as `cheerful` or `sad`.")
  style?: string;

  @doc("The SSML-compatible pitch adjustment, such as `+5%`.")
  pitch?: string;

  @doc("The SSML-compatible speaking-rate adjustment, such as `+10%`.")
  rate?: string;

  @doc("The SSML-compatible volume adjustment, such as `+10` or `-6dB`.")
  volume?: string;
}

@doc("The Azure synthesized voice kind. Additional values may be added over time.")
@extension("x-ms-foundry-meta", VoiceAgentRequiredPreview)
union AzureVoiceType {
  string,

  @doc("An Azure standard neural voice.")
  azure_standard: "azure-standard",

  @doc("An Azure custom neural voice.")
  azure_custom: "azure-custom",

  @doc("An Azure personal voice.")
  azure_personal: "azure-personal",

  @doc("An Azure avatar voice-synchronization voice.")
  avatar_voice_sync: "avatar-voice-sync",
}

@doc("An Azure standard neural voice configuration.")
model AzureStandardVoice extends AzureVoice {
  type: AzureVoiceType.azure_standard;

  @doc("The Azure neural voice name.")
  @minLength(1)
  name: string;

  @doc("The speaker name used by a multi-talker voice.")
  multi_talker_speaker_name?: string;
}

@doc("An Azure custom neural voice configuration.")
model AzureCustomVoice extends AzureVoice {
  type: AzureVoiceType.azure_custom;

  @doc("The custom voice name.")
  @minLength(1)
  name: string;

  @doc("The Azure Speech custom voice deployment endpoint ID.")
  @minLength(1)
  endpoint_id: string;
}

@doc("An Azure personal voice configuration.")
model AzurePersonalVoice extends AzureVoice {
  type: AzureVoiceType.azure_personal;

  @doc("The personal voice name.")
  @minLength(1)
  name: string;

  @doc("The neural model used by the personal voice.")
  `model`: PersonalVoiceModel;
}

@doc("An Azure avatar voice-synchronization configuration. The runtime derives its voice name from the avatar character and style.")
model AzureAvatarVoiceSyncVoice extends AzureVoice {
  type: AzureVoiceType.avatar_voice_sync;

  @doc("The neural model used to synthesize the avatar voice.")
  `model`: PersonalVoiceModel;
}

@doc("A known neural model for an Azure personal or avatar voice. Additional values may be added over time.")
union PersonalVoiceModel {
  string,

  @doc("The latest Dragon model.")
  dragon_latest_neural: "DragonLatestNeural",

  @doc("The latest Dragon HD Omni model.")
  dragon_hd_omni_latest_neural: "DragonHDOmniLatestNeural",

  @doc("The MAI-Voice model.")
  mai_voice: "MAI-Voice",
}

@doc("An Azure realtime-native voice configuration.")
model AzureRealtimeNativeVoice {
  @doc("The voice kind. Always `azure-realtime-native`.")
  type: "azure-realtime-native";

  @doc("The Azure realtime-native voice name.")
  @minLength(1)
  name: AzureRealtimeNativeVoiceName;
}

@doc("An Azure realtime-native voice name. Use one of the known names or another realtime-native voice supported by the selected model.")
union AzureRealtimeNativeVoiceName {
  string,

  @doc("The Aarti voice.")
  aarti: "aarti",

  @doc("The Alvaro voice.")
  alvaro: "alvaro",

  @doc("The Andrew voice.")
  andrew: "andrew",

  @doc("The Antonio voice.")
  antonio: "antonio",

  @doc("The Ava voice.")
  ava: "ava",

  @doc("The Clara voice.")
  clara: "clara",

  @doc("The Dalia voice.")
  dalia: "dalia",

  @doc("The Denise voice.")
  denise: "denise",

  @doc("The Diego voice.")
  diego: "diego",

  @doc("The Diya voice.")
  diya: "diya",

  @doc("The Elsa voice.")
  elsa: "elsa",

  @doc("The Emma voice.")
  emma: "emma",

  @doc("The Florian voice.")
  florian: "florian",

  @doc("The Francisca voice.")
  francisca: "francisca",

  @doc("The Hyunsu voice.")
  hyunsu: "hyunsu",

  @doc("The Jorge voice.")
  jorge: "jorge",

  @doc("The Keita voice.")
  keita: "keita",

  @doc("The Liam voice.")
  liam: "liam",

  @doc("The Meera voice.")
  meera: "meera",

  @doc("The Nanami voice.")
  nanami: "nanami",

  @doc("The Natasha voice.")
  natasha: "natasha",

  @doc("The Niwat voice.")
  niwat: "niwat",

  @doc("The Premwadee voice.")
  premwadee: "premwadee",

  @doc("The Remy voice.")
  remy: "remy",

  @doc("The Ryan voice.")
  ryan: "ryan",

  @doc("The Seraphina voice.")
  seraphina: "seraphina",

  @doc("The Sonia voice.")
  sonia: "sonia",

  @doc("The Sunhi voice.")
  sunhi: "sunhi",

  @doc("The Sylvie voice.")
  sylvie: "sylvie",

  @doc("The Thierry voice.")
  thierry: "thierry",

  @doc("The William voice.")
  william: "william",

  @doc("The Xiaoxiao voice.")
  xiaoxiao: "xiaoxiao",

  @doc("The Ximena voice.")
  ximena: "ximena",

  @doc("The Yunxi voice.")
  yunxi: "yunxi",
}

@doc("""
  Avatar configuration for a voice agent. These values are session defaults and may be overridden when connecting.
  """)
@extension("x-ms-foundry-meta", VoiceAgentRequiredPreview)
model VoiceAvatarConfig {
  @doc("The avatar type.")
  type: VoiceAvatarType;

  @doc("The avatar character identifier, e.g. 'lisa'.")
  character: string;

  @doc("The avatar style, e.g. 'casual-sitting'.")
  style?: string;

  @doc("Whether the avatar is a customer-customized avatar. Defaults to false.")
  customized?: boolean = false;

  @doc("The transport used to deliver the avatar video stream.")
  output_protocol?: VoiceAvatarOutputProtocol;
}

@doc("The avatar type.")
@extension("x-ms-foundry-meta", VoiceAgentRequiredPreview)
union VoiceAvatarType {
  string,
  video_avatar: "video_avatar",
  photo_avatar: "photo_avatar",
}

@doc("The transport used to deliver the avatar video stream.")
@extension("x-ms-foundry-meta", VoiceAgentRequiredPreview)
union VoiceAvatarOutputProtocol {
  string,
  webrtc: "webrtc",
  websocket: "websocket",
}

@doc("An output modality the agent may produce. `animation` and `avatar` are used when an avatar is configured.")
@extension("x-ms-foundry-meta", VoiceAgentRequiredPreview)
union VoiceOutputModality {
  string,
  text: "text",
  audio: "audio",
  animation: "animation",
  avatar: "avatar",
}

@doc("The persona/tone a guided-authoring request steers the generated voice agent toward.")
@extension("x-ms-foundry-meta", VoiceAgentRequiredPreview)
union VoiceAgentType {
  string,

  @doc("A personal-assistant persona.")
  personal: "personal",

  @doc("A business / professional persona.")
  business: "business",
}

@doc("""
  The scenario-template catalog entry a guided-authoring request specializes the generated voice agent for.
  Extensible: additional use cases may be added over time.
  """)
@extension("x-ms-foundry-meta", VoiceAgentRequiredPreview)
union VoiceAgentUseCase {
  string,
  customer_support: "customer_support",
  reception: "reception",
  sales: "sales",
  travel_assistant: "travel_assistant",
  outreach: "outreach",
  personal_assistant: "personal_assistant",
  learning: "learning",
  call_center: "call_center",
  in_car: "in_car",
}

// ============================================================================
// Voice agent resources and request/response envelopes.
//
// The persisted voice agent and its immutable versions mirror the shared
// AgentObject / AgentVersionObject shapes, but their `definition` is always a
// VoiceAgentDefinition. Shared fields are reused via OmitProperties so
// the voice surface stays in sync with the text surface.
// ============================================================================

@doc("A voice agent version. Mirrors `AgentVersionObject`, but its `definition` is always a `VoiceAgentDefinition`.")
@extension("x-ms-foundry-meta", VoiceAgentRequiredPreview)
model VoiceAgentVersionObject {
  ...OmitProperties<AgentVersionObject, "definition" | "error">;

  @doc("The voice agent definition for this version.")
  definition: VoiceAgentDefinition;
}

@doc("A voice agent. Mirrors `AgentObject`, but its latest version is a `VoiceAgentVersionObject`.")
@extension("x-ms-foundry-meta", VoiceAgentRequiredPreview)
model VoiceAgentObject {
  ...OmitProperties<AgentObject, "versions">;

  @doc("The latest version of the voice agent.")
  versions: {
    latest: VoiceAgentVersionObject;
  };
}

@doc("The request to create a new version of a voice agent.")
@extension("x-ms-foundry-meta", VoiceAgentRequiredPreview)
model CreateVoiceAgentVersionRequest {
  ...OmitProperties<CreateAgentVersionRequest, "definition">;

  @doc("The voice agent definition.")
  definition: VoiceAgentDefinition;
}

@doc("The request to create a voice agent.")
@extension("x-ms-foundry-meta", VoiceAgentRequiredPreview)
model CreateVoiceAgentRequest {
  @doc("""
    The unique name that identifies the agent. Name can be used to retrieve/update/delete the agent.
    - Must start and end with alphanumeric characters,
    - Can contain hyphens in the middle
    - Must not exceed 63 characters.
    """)
  @maxLength(63)
  name: string;

  @doc("The initial operational state of the agent. Defaults to 'enabled' if not specified.")
  state?: AgentState = AgentState.enabled;

  ...CreateVoiceAgentVersionRequest;

  @doc("An optional endpoint configuration. If not specified, a default endpoint configuration will be set for the agent")
  agent_endpoint?: AgentEndpointConfig;

  @doc("Optional agent card for the agent")
  agent_card?: AgentCard;
}

@doc("The request to update a voice agent by adding a new version.")
@extension("x-ms-foundry-meta", VoiceAgentRequiredPreview)
model UpdateVoiceAgentRequest {
  ...OmitProperties<CreateVoiceAgentVersionRequest, "draft">;
}

@doc("""
  The inputs for generating a voice agent. A few high-level inputs plus a natural-language `goal`
  are expanded into a full, editable `VoiceAgentDefinition`, which is then created via the standard voice
  agent create path. The generated `instructions` and audio/voice settings are stored as separate fields on the
  resulting agent definition, so the caller can edit or override any of them afterward via normal versioning.
  """)
@extension("x-ms-foundry-meta", VoiceAgentRequiredPreview)
model GenerateVoiceAgentRequest {
  @doc("The unique name for the agent to create.")
  @maxLength(63)
  name: string;

  @doc("How the model backing the generated agent is served: `managed` (service-managed) or `self_deployed` (the customer's own deployment). Carried through to the generated definition, not generated.")
  model_type: VoiceModelType;

  @doc("The model paired with `model_type`: the service-managed model name when `managed`, or the customer's Foundry deployment name when `self_deployed`. Carried through, not generated.")
  `model`: string;

  @doc("The persona/tone to steer generation.")
  agent_type: VoiceAgentType;

  @doc("The scenario-template catalog entry the generator specializes for.")
  use_case: VoiceAgentUseCase;

  @doc("A natural-language description of what the agent should do; the seed for the generated `instructions`.")
  goal: string;

  @doc("An optional description for the agent. Generated from `goal` when omitted.")
  description?: string;

  @doc("Optional tools carried through verbatim onto the generated agent (see `VoiceAgentTool`).")
  tools?: VoiceAgentTool[];

  @doc("(Preview) When `true`, the generated voice agent is created as a draft — an editable, unpublished version the caller can review and refine before publishing it via the standard create/version path. The service defaults to `false` if a value is not specified by the caller, in which case the agent is created and published normally.")
  @extension(
    "x-ms-foundry-meta",
    #{
      conditional_previews: #[AgentDefinitionOptInKeys.draft_agents_v1_preview],
    }
  )
  draft?: boolean = false;
}

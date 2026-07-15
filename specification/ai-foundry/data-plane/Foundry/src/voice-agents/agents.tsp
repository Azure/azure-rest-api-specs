import "@typespec/http";
import "@typespec/openapi";
import "@typespec/versioning";
import "../common/servicepatterns.tsp";
import "../agents/models.tsp";
import "../openai/responses/models.tsp";

using TypeSpec.Http;
using TypeSpec.OpenAPI;
using TypeSpec.Versioning;

namespace Azure.AI.Projects;

// ============================================================================
// Voice-first prompt agent definition, configuration, resource, and request
// models. These are split out from the text `/agents` surface so that
// `/agents` carries only text agent kinds and `/voice-agents` carries only
// voice-first prompt agents. Shared agent shapes (AgentObject,
// AgentVersionObject, request/response envelopes) are reused from
// `../agents/models.tsp` via property spreads to avoid drift.
// ============================================================================

const PromptVoiceAgentRequiredPreview = #{
  required_previews: #[AgentDefinitionOptInKeys.voice_agents_v1_preview],
};

@doc("""
  The voice-first prompt agent definition. A declarative agent kind whose configuration (model, prompt, audio stack,
  tools, optional avatar) drives a managed speech-to-speech experience powered by the managed Voice Live backend.
  The live realtime voice session — a service-terminated WebSocket bridged to Voice Live — is established through a
  separate realtime connect operation that is not defined in this spec; the realtime session/audio/event wire schema
  is owned by Voice Live. Like prompt agents, every create/update produces a new immutable version.
  """)
@extension("x-ms-foundry-meta", PromptVoiceAgentRequiredPreview)
model PromptVoiceAgentDefinition {
  @doc("The kind discriminator for a voice-first prompt agent definition. Always `prompt_voice`.")
  kind: "prompt_voice";

  @doc("Configuration for Responsible AI (RAI) content filtering and safety features.")
  rai_config?: RaiConfig;

  @doc("How the model backing this agent is served. Together with `model`, this selects the model up front. `managed` runs a Voice Live-hosted model; `self_deployed` (BYOM) uses the customer's own Foundry deployment. Orthogonal to the architecture (realtime vs cascaded), which Foundry derives from the selected model.")
  model_type: VoiceModelType;

  @doc("The model to use for this agent, paired with `model_type`: the Voice Live-hosted model name when `model_type` is `managed`, or the customer's Foundry deployment name when `model_type` is `self_deployed`. Must be a realtime- or cascaded-capable model; Foundry derives the architecture (realtime vs cascaded) from it, so there is no architecture field.")
  `model`: string;

  @doc("A system (or developer) message inserted into the model's context. Supports template substitution via `structured_inputs`, rendered per session before the live session starts.")
  instructions?: string | null;

  @doc("""
    The audio stack configuration (input/output format, voice, turn detection, noise reduction, transcription),
    following the OpenAI Realtime session schema that Voice Live implements and extends. Authored here as the
    control-plane defaults; a client may override the overridable fields per session at connect time.
    """)
  audio?: VoiceAudioConfig;

  @doc("""
    The output modalities the agent produces. Defaults to `["audio"]`. Voice Live adds `animation`/`avatar`
    when an avatar is configured.
    """)
  output_modalities?: VoiceOutputModality[];

  @doc("Optional avatar configuration (a Voice Live extension). Authored here as a control-plane default; overridable per session.")
  avatar?: VoiceAvatarConfig;

  @doc("""
    The tools the agent may use. A voice-first prompt agent supports exactly four tool kinds (see `VoiceAgentTool`):
    native `function` (executed by the client), `mcp`, `system` (Voice Live built-in control, e.g. end-call),
    and `toolbox`. Unlike prompt/hosted agents, server-side tools (e.g. `web_search`, `azure_ai_search`,
    `openapi`) are not declared directly on a voice agent; they are packaged in a toolbox and executed by Voice
    Live via the toolbox MCP endpoint.
    """)
  tools?: VoiceAgentTool[];

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

@doc("""
  How the model backing a voice-first prompt agent is served. Orthogonal to the architecture (realtime vs cascaded),
  which Foundry derives from the selected model.
  """)
@extension("x-ms-foundry-meta", PromptVoiceAgentRequiredPreview)
union VoiceModelType {
  string,

  @doc("Voice Live runs the named model on its own infrastructure, e.g. `gpt-realtime`.")
  managed: "managed",

  @doc("Bring your own model (BYOM): Voice Live calls the customer's own Foundry deployment named by `model`.")
  self_deployed: "self_deployed",
}

@doc("""
  A tool usable by a voice-first prompt agent. Exactly four kinds are supported: native `function` (executed by the
  client) and `mcp` reuse the OpenAI Realtime tool shapes; `system` and `toolbox` are Foundry voice extensions.
  The generic agent tool set (server-side tools such as `web_search` or `azure_ai_search`) is intentionally not
  allowed here — package those in a toolbox instead.
  """)
@extension("x-ms-foundry-meta", PromptVoiceAgentRequiredPreview)
union VoiceAgentTool {
  @doc("A native function tool, executed by the client.")
  function: OpenAI.FunctionTool,

  @doc("An MCP tool, executed by Voice Live; the agent resolves auth (e.g. via a Foundry connection).")
  mcp: OpenAI.MCPTool,

  @doc("A Voice Live built-in control tool, e.g. end-call.")
  system: VoiceSystemTool,

  @doc("A reference to a Foundry toolbox, executed by Voice Live via the toolbox MCP endpoint.")
  toolbox: VoiceToolboxTool,
}

@doc("A Voice Live built-in control (system) tool that acts on the live session itself, e.g. ending the call. Executed natively by Voice Live; no customer code or external auth.")
@extension("x-ms-foundry-meta", PromptVoiceAgentRequiredPreview)
model VoiceSystemTool {
  @doc("The type of the tool. Always `system`.")
  type: "system";

  @doc("The name of the built-in control action, e.g. `end_conversation`.")
  name: string;
}

@doc("A reference to a Foundry toolbox (a versioned bundle of tools). Voice Live calls the toolbox MCP endpoint and the Foundry tool server runs the tool. This is how a voice agent uses server-side tools (web search, Azure AI Search, OpenAPI, etc.) that it cannot declare directly.")
@extension("x-ms-foundry-meta", PromptVoiceAgentRequiredPreview)
model VoiceToolboxTool {
  @doc("The type of the tool. Always `toolbox`.")
  type: "toolbox";

  @doc("The name of the toolbox to attach.")
  toolbox_name: string;

  @doc("The immutable version of the toolbox to attach.")
  toolbox_version: string;
}

@doc("""
  The audio stack configuration for a voice-first prompt agent, following the OpenAI Realtime session schema (which
  Voice Live implements and extends). Authored as control-plane defaults; overridable per session at connect time.
  """)
@extension("x-ms-foundry-meta", PromptVoiceAgentRequiredPreview)
model VoiceAudioConfig {
  @doc("Input (microphone) audio configuration.")
  input?: VoiceAudioInputConfig;

  @doc("Output (agent speech) audio configuration.")
  output?: VoiceAudioOutputConfig;
}

@doc("Input (microphone) audio configuration for a voice-first prompt agent.")
@extension("x-ms-foundry-meta", PromptVoiceAgentRequiredPreview)
model VoiceAudioInputConfig {
  @doc("The input audio format.")
  format?: VoiceAudioFormat;

  @doc("Input noise reduction. Set to null to disable.")
  noise_reduction?: VoiceNoiseReduction | null;

  @doc("Turn (end-of-speech) detection. Set to null to disable server-side turn detection.")
  turn_detection?: VoiceTurnDetection | null;

  @doc("Optional asynchronous input-audio transcription configuration.")
  transcription?: VoiceInputTranscription;
}

@doc("Output (agent speech) audio configuration for a voice-first prompt agent.")
@extension("x-ms-foundry-meta", PromptVoiceAgentRequiredPreview)
model VoiceAudioOutputConfig {
  @doc("The output audio format.")
  format?: VoiceAudioFormat;

  #suppress "@azure-tools/typespec-azure-core/no-unnamed-union" "voice is an OpenAI Realtime built-in voice name (bare string) or an Azure Voice Live neural voice object."
  @doc("The voice. Either an OpenAI Realtime built-in voice name (e.g. 'alloy') or an Azure (Voice Live) neural voice object.")
  voice?: string | AzureVoice;

  @doc("The speaking speed multiplier, from 0.25 to 1.5. Defaults to 1.")
  @minValue(0.25)
  @maxValue(1.5)
  speed?: float32 = 1;
}

@doc("An audio format. Follows the OpenAI Realtime session schema; `type` carries the media subtype.")
@extension("x-ms-foundry-meta", PromptVoiceAgentRequiredPreview)
model VoiceAudioFormat {
  @doc("The audio format type, e.g. 'audio/pcm' (16-bit PCM), 'audio/pcmu' (G.711 mu-law), or 'audio/pcma' (G.711 A-law).")
  type: VoiceAudioFormatType;

  @doc("The sample rate in Hz. Applies to 'audio/pcm' (e.g. 24000); omit for telephony G.711 formats (8 kHz).")
  rate?: int32;
}

@doc("The audio format type. Values follow the OpenAI Realtime wire schema and are exempt from the snake_case enum-value rule.")
@extension("x-ms-foundry-meta", PromptVoiceAgentRequiredPreview)
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
@extension("x-ms-foundry-meta", PromptVoiceAgentRequiredPreview)
model VoiceNoiseReduction {
  @doc("The noise reduction mode.")
  type: VoiceNoiseReductionType;
}

@doc("The input audio noise reduction mode. 'near_field'/'far_field' follow the OpenAI Realtime schema; 'azure_deep_noise_suppression' is a Voice Live extension.")
@extension("x-ms-foundry-meta", PromptVoiceAgentRequiredPreview)
union VoiceNoiseReductionType {
  string,
  near_field: "near_field",
  far_field: "far_field",

  @doc("Azure Voice Live deep noise suppression (extension).")
  azure_deep_noise_suppression: "azure_deep_noise_suppression",
}

@doc("Turn (end-of-speech) detection configuration.")
@discriminator("type")
@extension("x-ms-foundry-meta", PromptVoiceAgentRequiredPreview)
model VoiceTurnDetection {
  @doc("The turn detection strategy.")
  type: VoiceTurnDetectionType;
}

@doc("The turn detection strategy. Values follow the OpenAI Realtime wire schema.")
@extension("x-ms-foundry-meta", PromptVoiceAgentRequiredPreview)
union VoiceTurnDetectionType {
  string,
  server_vad: "server_vad",
  semantic_vad: "semantic_vad",
}

@doc("Server-side voice activity detection (silence-based).")
@extension("x-ms-foundry-meta", PromptVoiceAgentRequiredPreview)
model ServerVadTurnDetection extends VoiceTurnDetection {
  type: VoiceTurnDetectionType.server_vad;

  @doc("Activation threshold (0-1). Higher requires louder audio to trigger.")
  @minValue(0)
  @maxValue(1)
  threshold?: float32;

  @doc("Audio (ms) to include before detected speech start.")
  prefix_padding_ms?: int32;

  @doc("Silence (ms) used to detect speech stop.")
  silence_duration_ms?: int32;

  @doc("Whether the server automatically creates a response when a turn ends. Defaults to true.")
  create_response?: boolean;
}

@doc("Semantic (model-based) turn detection.")
@extension("x-ms-foundry-meta", PromptVoiceAgentRequiredPreview)
model SemanticVadTurnDetection extends VoiceTurnDetection {
  type: VoiceTurnDetectionType.semantic_vad;

  @doc("How eagerly the model ends the user's turn.")
  eagerness?: VoiceTurnDetectionEagerness;
}

@doc("How eagerly semantic turn detection ends the user's turn.")
@extension("x-ms-foundry-meta", PromptVoiceAgentRequiredPreview)
union VoiceTurnDetectionEagerness {
  string,
  auto: "auto",
  low: "low",
  medium: "medium",
  high: "high",
}

@doc("Asynchronous input-audio transcription configuration.")
@extension("x-ms-foundry-meta", PromptVoiceAgentRequiredPreview)
model VoiceInputTranscription {
  @doc("The transcription model deployment to use.")
  `model`?: string;

  @doc("The expected input language as a BCP-47 code (e.g. 'en-US'). Auto-detected when omitted.")
  language?: string;

  @doc("Optional prompt to bias transcription toward domain terms.")
  prompt?: string;
}

@doc("""
  An Azure (Voice Live) neural voice with optional prosody. A Voice Live extension to the OpenAI Realtime voice
  field; OpenAI built-in voices are specified as a bare string instead.
  """)
@extension("x-ms-foundry-meta", PromptVoiceAgentRequiredPreview)
model AzureVoice {
  @doc("The Azure voice kind.")
  type: AzureVoiceType;

  @doc("The Azure neural voice name, e.g. 'en-US-AvaNeural'.")
  name: string;

  @doc("Optional speaking style, e.g. 'cheerful'.")
  style?: string;

  @doc("Optional pitch adjustment, e.g. '+5%'.")
  pitch?: string;

  @doc("Optional rate adjustment, e.g. '+10%'.")
  rate?: string;

  @doc("Optional BCP-47 locale override, e.g. 'en-US'.")
  locale?: string;
}

@doc("The Azure (Voice Live) voice kind.")
@extension("x-ms-foundry-meta", PromptVoiceAgentRequiredPreview)
union AzureVoiceType {
  string,
  azure_standard: "azure_standard",
  azure_custom: "azure_custom",
  azure_personal: "azure_personal",
  azure_avatar_voice_sync: "azure_avatar_voice_sync",
  azure_realtime_native: "azure_realtime_native",
}

@doc("""
  Avatar configuration for a voice-first prompt agent. A Voice Live extension (not part of the OpenAI Realtime schema).
  Authored as a control-plane default; overridable per session.
  """)
@extension("x-ms-foundry-meta", PromptVoiceAgentRequiredPreview)
model VoiceAvatarConfig {
  @doc("The avatar type. Values follow the Voice Live wire schema.")
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

@doc("The avatar type. Values follow the Voice Live wire schema.")
@extension("x-ms-foundry-meta", PromptVoiceAgentRequiredPreview)
union VoiceAvatarType {
  string,
  video_avatar: "video-avatar",
  photo_avatar: "photo-avatar",
}

@doc("The transport used to deliver the avatar video stream.")
@extension("x-ms-foundry-meta", PromptVoiceAgentRequiredPreview)
union VoiceAvatarOutputProtocol {
  string,
  webrtc: "webrtc",
  websocket: "websocket",
}

@doc("An output modality the agent may produce. 'animation'/'avatar' are Voice Live extensions used when an avatar is configured.")
@extension("x-ms-foundry-meta", PromptVoiceAgentRequiredPreview)
union VoiceOutputModality {
  string,
  text: "text",
  audio: "audio",
  animation: "animation",
  avatar: "avatar",
}

@doc("The persona/tone a guided-authoring request steers the generated voice agent toward.")
@extension("x-ms-foundry-meta", PromptVoiceAgentRequiredPreview)
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
@extension("x-ms-foundry-meta", PromptVoiceAgentRequiredPreview)
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
// PromptVoiceAgentDefinition. Shared fields are reused via OmitProperties so
// the voice surface stays in sync with the text surface.
// ============================================================================

@doc("A voice-first prompt agent version. Mirrors `AgentVersionObject`, but its `definition` is always a `PromptVoiceAgentDefinition`.")
@extension("x-ms-foundry-meta", PromptVoiceAgentRequiredPreview)
model VoiceAgentVersionObject {
  ...OmitProperties<AgentVersionObject, "definition" | "error">;

  @doc("The voice-first prompt agent definition for this version.")
  definition: PromptVoiceAgentDefinition;
}

@doc("A voice-first prompt agent. Mirrors `AgentObject`, but its latest version is a `VoiceAgentVersionObject`.")
@extension("x-ms-foundry-meta", PromptVoiceAgentRequiredPreview)
model VoiceAgentObject {
  ...OmitProperties<AgentObject, "versions">;

  @doc("The latest version of the voice agent.")
  versions: {
    latest: VoiceAgentVersionObject;
  };
}

@doc("The request to create a new version of a voice-first prompt agent.")
@extension("x-ms-foundry-meta", PromptVoiceAgentRequiredPreview)
model CreateVoiceAgentVersionRequest {
  ...OmitProperties<CreateAgentVersionRequest, "definition">;

  @doc("The voice-first prompt agent definition.")
  definition: PromptVoiceAgentDefinition;
}

@doc("The request to create a voice-first prompt agent.")
@extension("x-ms-foundry-meta", PromptVoiceAgentRequiredPreview)
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

@doc("The request to update a voice-first prompt agent by adding a new version.")
@extension("x-ms-foundry-meta", PromptVoiceAgentRequiredPreview)
model UpdateVoiceAgentRequest {
  ...OmitProperties<CreateVoiceAgentVersionRequest, "draft">;
}

@doc("""
  The inputs for generating a voice-first prompt agent. A few high-level inputs plus a natural-language `goal`
  are expanded into a full, editable `PromptVoiceAgentDefinition`, which is then created via the standard voice
  agent create path. The generated `instructions` and audio/voice settings are stored as separate fields on the
  resulting agent definition, so the caller can edit or override any of them afterward via normal versioning.
  """)
@extension("x-ms-foundry-meta", PromptVoiceAgentRequiredPreview)
model GenerateVoiceAgentRequest {
  @doc("The unique name for the agent to create.")
  @maxLength(63)
  name: string;

  @doc("How the model backing the generated agent is served: `managed` (Voice Live-hosted) or `self_deployed` (BYOM). Carried through to the generated definition, not generated.")
  model_type: VoiceModelType;

  @doc("The model paired with `model_type`: the Voice Live-hosted model name when `managed`, or the customer's Foundry deployment name when `self_deployed`. Carried through, not generated.")
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
    #{ conditional_previews: #[AgentDefinitionOptInKeys.draft_agents_v1_preview] }
  )
  draft?: boolean = false;
}

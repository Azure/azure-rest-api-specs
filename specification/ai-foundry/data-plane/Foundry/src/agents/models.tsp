import "../openai/responses/models.tsp";
import "../common/servicepatterns.tsp";

using TypeSpec.Http;
using TypeSpec.OpenAPI;
using TypeSpec.Versioning;

namespace Azure.AI.Projects;

const AllConditionalAgentDefinitionPreviews = #{
  conditional_previews: #[
    AgentDefinitionOptInKeys.workflow_agents_v1_preview,
    AgentDefinitionOptInKeys.external_agents_v1_preview,
    AgentDefinitionOptInKeys.draft_agents_v1_preview,
    AgentDefinitionOptInKeys.prompt_voice_agents_v1_preview
  ],
};

const PromptVoiceAgentRequiredPreview = #{
  required_previews: #[AgentDefinitionOptInKeys.prompt_voice_agents_v1_preview],
};

model CreateAgentVersionRequest {
  ...MetadataPropertyForRequest;

  @doc("A human-readable description of the agent.")
  @maxLength(512)
  description?: string;

  @doc("The agent definition. This can be a workflow, hosted agent, or a simple agent definition.")
  @extension("x-ms-foundry-meta", AllConditionalAgentDefinitionPreviews)
  definition: AgentDefinition;

  @doc("The blueprint reference for the agent.")
  blueprint_reference?: AgentBlueprintReference;

  @doc("(Preview) Whether this agent version is a draft (candidate) rather than a release. The service defaults to `false` if a value is not specified by the caller. Draft versions are recorded but excluded from default 'latest' resolution and are not auto-promoted.")
  @extension(
    "x-ms-foundry-meta",
    #{ conditional_previews: #[AgentDefinitionOptInKeys.draft_agents_v1_preview] }
  )
  draft?: boolean = false;
}

model CreateAgentVersionFromManifestRequest {
  ...MetadataPropertyForRequest;

  @doc("A human-readable description of the agent.")
  @maxLength(512)
  description?: string;

  @doc("The manifest ID to import the agent version from.")
  manifest_id: string;

  @doc("The inputs to the manifest that will result in a fully materialized Agent.")
  parameter_values: Record<unknown>;
}

model CreateAgentFromManifestRequest {
  @doc("""
    The unique name that identifies the agent. Name can be used to retrieve/update/delete the agent.
    - Must start and end with alphanumeric characters,
    - Can contain hyphens in the middle
    - Must not exceed 63 characters.
    """)
  @maxLength(63)
  name: string;

  ...CreateAgentVersionFromManifestRequest;
}

model UpdateAgentFromManifestRequest {
  ...CreateAgentVersionFromManifestRequest;
}

@extension("x-ms-foundry-meta", AllConditionalAgentDefinitionPreviews)
model CreateAgentRequest {
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

  ...CreateAgentVersionRequest;

  @doc("An optional endpoint configuration. If not specified, a default endpoint configuration will be set for the agent")
  agent_endpoint?: AgentEndpointConfig;

  @doc("Optional agent card for the agent")
  agent_card?: AgentCard;
}

@extension("x-ms-foundry-meta", AllConditionalAgentDefinitionPreviews)
model UpdateAgentRequest {
  ...OmitProperties<CreateAgentVersionRequest, "draft">;
}

model PatchAgentRequest {
  @doc("The endpoint configuration for the agent")
  agent_endpoint?: AgentEndpointConfig;

  @doc("Optional agent card for the agent")
  agent_card?: AgentCard;
}

union AgentObjectType {
  agent: "agent",
  agentVersion: "agent.version",
  agentDeleted: "agent.deleted",
  agentVersionDeleted: "agent.version.deleted",
  agentContainer: "agent.container",
}

@doc("The operational state of an agent.")
union AgentState {
  string,

  @doc("Agent endpoint accepts requests. This is the default state on creation.")
  enabled: "enabled",

  @doc("Agent endpoint rejects all requests.")
  disabled: "disabled",
}

model AgentObject {
  @doc("The object type, which is always 'agent'.")
  object: AgentObjectType.agent;

  @doc("The unique identifier of the agent.")
  id: string;

  @doc("The name of the agent.")
  @maxLength(63)
  name: string;

  @doc("The operational state of the agent. Controls whether the agent endpoint accepts or rejects requests.")
  @visibility(Lifecycle.Read)
  state: AgentState;

  @doc("The latest version of the agent.")
  versions: {
    latest: AgentVersionObject;
  };

  @doc("The endpoint configuration for the agent")
  agent_endpoint?: AgentEndpointConfig;

  @doc("The instance identity of the agent")
  @visibility(Lifecycle.Read)
  instance_identity?: AgentIdentity;

  @doc("The blueprint for the agent")
  @visibility(Lifecycle.Read)
  blueprint?: AgentIdentity;

  @doc("The blueprint for the agent")
  @visibility(Lifecycle.Read)
  blueprint_reference?: AgentBlueprintReference;

  agent_card?: AgentCard;
}

model AgentVersionObject {
  ...MetadataPropertyForResponse;

  @doc("The object type, which is always 'agent.version'.")
  object: AgentObjectType.agentVersion;

  @doc("The unique identifier of the agent version.")
  id: string;

  @doc("The name of the agent. Name can be used to retrieve/update/delete the agent.")
  @maxLength(256)
  name: string;

  @doc("The version identifier of the agent. Agents are immutable and every update creates a new version while keeping the name same.")
  version: string;

  @doc("A human-readable description of the agent.")
  @maxLength(512)
  description?: string;

  @doc("The Unix timestamp (seconds) when the agent was created.")
  created_at: FoundryTimestamp;

  definition: AgentDefinition;

  @doc("Whether this agent version is a draft (candidate) rather than a release. Draft versions are recorded but excluded from default 'latest' resolution and are not auto-promoted. Defaults to false.")
  @extension(
    "x-ms-foundry-meta",
    #{ conditional_previews: #[AgentDefinitionOptInKeys.draft_agents_v1_preview] }
  )
  draft?: boolean = false;

  @doc("The provisioning status of the agent version. Defaults to 'active' for non-hosted agents. For hosted agents, reflects infrastructure readiness.")
  status?: AgentVersionStatus;

  @removed(Versions.v1)
  @doc("Error details if the agent version provisioning failed.")
  error?: ApiError;

  @doc("The instance identity of the agent")
  @visibility(Lifecycle.Read)
  instance_identity?: AgentIdentity;

  @doc("The blueprint for the agent")
  @visibility(Lifecycle.Read)
  blueprint?: AgentIdentity;

  @doc("The blueprint for the agent")
  @visibility(Lifecycle.Read)
  blueprint_reference?: AgentBlueprintReference;

  @doc("The unique GUID identifier of the agent.")
  @visibility(Lifecycle.Read)
  agent_guid?: string;
}

@doc("The provisioning status of an agent version.")
union AgentVersionStatus {
  @doc("The agent version is being provisioned.")
  creating: "creating",

  @doc("The agent version is active and ready to serve requests.")
  active: "active",

  @doc("The agent version provisioning failed.")
  failed: "failed",

  @doc("The agent version is being deleted.")
  deleting: "deleting",

  @doc("The agent version has been deleted.")
  deleted: "deleted",
}

union AgentEndpointProtocol {
  string,
  activity: "activity",
  responses: "responses",
  a2a: "a2a",
  mcp: "mcp",
  invocations: "invocations",

  @doc("WebSocket-based protocol for hosted voice and real-time streaming agents.")
  invocations_ws: "invocations_ws",

  @doc("Voice-first speech-to-speech protocol for `prompt_voice` agents. The endpoint-scoped conversation and audio retrieval routes under `/agents/{agent_name}/endpoint/protocols/voice/conversations` are defined in this spec; the realtime voice session connect operation — a WebSocket upgrade at `/agents/{agent_name}/endpoint/protocols/voice`, bridged to the managed Voice Live backend — is deferred to a later change.")
  voice: "voice",
}

union AgentKind {
  string,
  prompt: "prompt",
  hosted: "hosted",
  workflow: "workflow",
  external: "external",
  prompt_voice: "prompt_voice",

  @removed(Versions.v1)
  container_app: "container_app",
}

@doc("Configuration for Responsible AI (RAI) content filtering and safety features.")
model RaiConfig {
  @doc("The name of the RAI policy to apply.")
  rai_policy_name: string;
}

@discriminator("kind")
model AgentDefinition {
  kind: AgentKind;

  @doc("Configuration for Responsible AI (RAI) content filtering and safety features.")
  rai_config?: RaiConfig;
}

@doc("The prompt agent definition")
model PromptAgentDefinition extends AgentDefinition {
  kind: AgentKind.prompt;

  @doc("The model deployment to use for this agent.")
  `model`: string;

  @doc("A system (or developer) message inserted into the model's context.")
  instructions?: string | null;

  @doc("""
    What sampling temperature to use, between 0 and 2. Higher values like 0.8 will make the output more random, while lower values like 0.2 will make it more focused and deterministic.
    We generally recommend altering this or `top_p` but not both. Defaults to `1`.
    """)
  @minValue(0)
  @maxValue(2)
  temperature?: float32 | null = 1;

  @doc("""
    An alternative to sampling with temperature, called nucleus sampling,
    where the model considers the results of the tokens with top_p probability
    mass. So 0.1 means only the tokens comprising the top 10% probability mass
    are considered. We generally recommend altering this or `temperature` but not both.
    Defaults to `1`.
    """)
  @minValue(0)
  @maxValue(1)
  top_p?: float32 | null = 1;

  reasoning?: OpenAI.Reasoning | null;

  @doc("""
    An array of tools the model may call while generating a response. You
    can specify which tool to use by setting the `tool_choice` parameter.
    """)
  tools?: OpenAI.Tool[];

  #suppress "@azure-tools/typespec-azure-core/no-unnamed-union" ""
  @doc("""
    How the model should select which tool (or tools) to use when generating a response.
    See the `tools` parameter to see how to specify which tools the model can call.
    """)
  tool_choice?: string | OpenAI.ToolChoiceParam;

  /**
   * Configuration options for a text response from the model. Can be plain text or structured JSON data.
   */
  text?: PromptAgentDefinitionTextOptions;

  @doc("Set of structured inputs that can participate in prompt template substitution or tool argument bindings.")
  structured_inputs?: Record<StructuredInputDefinition>;
}

/**
 * Configuration options for a text response from the model. Can be plain text or structured JSON data.
 */
model PromptAgentDefinitionTextOptions {
  format?: OpenAI.TextResponseFormatConfiguration;
}

@doc("""
  The voice-first prompt agent definition. A declarative agent kind whose configuration (model, prompt, audio stack,
  tools, optional avatar) drives a managed speech-to-speech experience powered by the managed Voice Live backend.
  The live realtime voice session — a service-terminated WebSocket bridged to Voice Live — is established through a
  separate realtime connect operation that is not defined in this spec; the realtime session/audio/event wire schema
  is owned by Voice Live. Like prompt agents, every create/update produces a new immutable version.
  """)
@extension("x-ms-foundry-meta", PromptVoiceAgentRequiredPreview)
model PromptVoiceAgentDefinition extends AgentDefinition {
  kind: AgentKind.prompt_voice;

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

@doc("""
  The request for guided agent authoring (`POST /agents:generate`). The `kind` discriminator selects the
  kind-specific generation inputs. Currently, only `prompt_voice` is supported.
  """)
@discriminator("kind")
model GenerateAgentRequest {
  @doc("The kind of agent to generate.")
  kind: AgentKind;

  @doc("The unique name for the agent to create.")
  name: string;
}

@doc("""
  The inputs for generating a voice-first prompt agent. A few high-level inputs plus a natural-language `goal`
  are expanded into a full, editable `PromptVoiceAgentDefinition`, which is then created via the standard agent
  create path. The generated `instructions` and audio/voice settings are stored as separate fields on the resulting
  agent definition, so the caller can edit or override any of them afterward via normal versioning.
  """)
@extension("x-ms-foundry-meta", PromptVoiceAgentRequiredPreview)
model GeneratePromptVoiceAgentRequest extends GenerateAgentRequest {
  @doc("The kind of agent to generate.")
  kind: AgentKind.prompt_voice;

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

  @doc("(Preview) When `true`, the generated `prompt_voice` agent is created as a draft — an editable, unpublished version the caller can review and refine before publishing it via the standard create/version path. The service defaults to `false` if a value is not specified by the caller, in which case the agent is created and published normally.")
  @extension(
    "x-ms-foundry-meta",
    #{ conditional_previews: #[AgentDefinitionOptInKeys.draft_agents_v1_preview] }
  )
  draft?: boolean = false;
}

@doc("The workflow agent definition.")
@extension(
  "x-ms-foundry-meta",
  #{ required_previews: #[AgentDefinitionOptInKeys.workflow_agents_v1_preview] }
)
model WorkflowAgentDefinition extends AgentDefinition {
  kind: AgentKind.workflow;

  @doc("The CSDL YAML definition of the workflow.")
  workflow?: string;
}

@doc("Container-based deployment configuration for a hosted agent.")
model ContainerConfiguration {
  @doc("The container image for the hosted agent.")
  @example("my-registry.azurecr.io/my-hosted-agent:latest")
  image: string;
}

@doc("Code-based deployment configuration for a hosted agent.")
model CodeConfiguration {
  @doc("The runtime identifier for code execution (e.g., 'python_3_11', 'python_3_12', 'python_3_13').")
  runtime: string;

  @doc("The entry point command and arguments for the code execution.")
  entry_point: string[];

  @doc("""
    How package dependencies are resolved at deployment time. Defaults to `bundled`,
    where the caller bundles all dependencies into the uploaded zip and the service
    performs no remote build. `remote_build` instructs the service to build
    dependencies remotely from the manifest included in the uploaded zip.
    """)
  dependency_resolution: CodeDependencyResolution = CodeDependencyResolution.bundled;

  @visibility(Lifecycle.Read)
  @doc("The SHA-256 hex digest of the uploaded code zip. Set by the service from the `x-ms-code-zip-sha256` request header; read-only in responses and never accepted in request payloads.")
  content_hash?: string;
}

@doc("How package dependencies are resolved at deployment time for a code-based hosted agent.")
union CodeDependencyResolution {
  string,

  @doc("The caller has bundled all dependencies into the uploaded zip; the service performs no remote build.")
  bundled: "bundled",

  @doc("The service builds dependencies remotely from the manifest included in the uploaded zip.")
  remote_build: "remote_build",
}

@doc("""
  The external agent definition. Represents a third-party agent hosted outside Foundry (for example, on GCP or AWS).
  Registration is metadata-only: Foundry records the agent definition to light up observability experiences (traces, evaluations)
  over customer-emitted OpenTelemetry data.
  """)
@extension(
  "x-ms-foundry-meta",
  #{ required_previews: #[AgentDefinitionOptInKeys.external_agents_v1_preview] }
)
model ExternalAgentDefinition extends AgentDefinition {
  kind: AgentKind.external;

  @doc("""
    The OpenTelemetry agent identifier used to attribute customer-emitted spans to this Foundry agent.
    Spans must include the attribute `gen_ai.agent.id = <otel_agent_id>` to appear under this registration.
    Defaults to the top-level agent name when omitted. Provide an explicit value only for migration scenarios
    where the running external agent already emits a stable id that differs from the Foundry agent name.
    The resolved value is always echoed on read.
    """)
  otel_agent_id?: string;
}

@doc("The hosted agent definition.")
model HostedAgentDefinition extends AgentDefinition {
  kind: AgentKind.hosted;

  /**
   * When specify the `cpu` and `memory`, the total CPU and memory allocated to all the containers in a container app must add up to one of the following combinations.
   * See [vCPU and memory allocation requirements](https://learn.microsoft.com/azure/container-apps/containers#allocations).
   */
  @doc("The CPU configuration for the hosted agent.")
  @example("0.25")
  cpu: string;

  @doc("The memory configuration for the hosted agent.")
  @example("0.5Gi")
  memory: string;

  @doc("Environment variables to set in the hosted agent container.")
  @example(#{ name: "LOG_LEVEL", value: "debug" })
  environment_variables?: Record<string>;

  @doc("Container-based deployment configuration. Provide this for image-based deployments. Mutually exclusive with code_configuration — the service validates that exactly one is set.")
  container_configuration?: ContainerConfiguration;

  @doc("The protocols that the agent supports for ingress communication.")
  @example(#[
    #{ protocol: "responses", version: "v0.1.1" },
    #{ protocol: "a2a", version: "v0.3.0" }
  ])
  protocol_versions?: ProtocolVersionRecord[];

  @doc("Code-based deployment configuration. Provide this for code-based deployments. Mutually exclusive with container_configuration — the service validates that exactly one is set.")
  code_configuration?: CodeConfiguration;

  @doc("Optional customer-supplied telemetry configuration for exporting container logs, traces, and metrics.")
  telemetry_config?: TelemetryConfig;
}

@doc("The container app agent definition.")
@extension(
  "x-ms-foundry-meta",
  #{
    required_previews: #[AgentDefinitionOptInKeys.container_agents_v1_preview],
  }
)
@removed(Versions.v1)
model ContainerAppAgentDefinition extends AgentDefinition {
  kind: AgentKind.container_app;

  @doc("The protocols that the agent supports for ingress communication of the containers.")
  @example(#[
    #{ protocol: "responses", version: "v0.1.1" },
    #{ protocol: "a2a", version: "v0.3.0" }
  ])
  container_protocol_versions: ProtocolVersionRecord[];

  @doc("The resource ID of the Azure Container App that hosts this agent. Not mutable across versions.")
  container_app_resource_id: string;

  @doc("The suffix to apply to the app subdomain when sending ingress to the agent. This can be a label (e.g., '---current'), a specific revision (e.g., '--0000001'), or empty to use the default endpoint for the container app.")
  @example("")
  @example("---current")
  @example("--0000001")
  ingress_subdomain_suffix: string;
}

@doc("A record mapping for a single protocol and its version.")
model ProtocolVersionRecord {
  @doc("The protocol type.")
  protocol: AgentEndpointProtocol;

  @doc("The version string for the protocol, e.g. 'v0.1.1'.")
  version: string;
}

alias ListAgentQueryParameters = {
  @query
  @doc("Filter agents by kind. If not provided, all agents are returned.")
  kind?: AgentKind;

  ...CommonPageQueryParameters;
};

@doc("A deleted agent Object")
model DeleteAgentResponse {
  @doc("The object type. Always 'agent.deleted'.")
  object: AgentObjectType.agentDeleted;

  @doc("The name of the agent.")
  name: string;

  @doc("Whether the agent was successfully deleted.")
  deleted: boolean;
}

@doc("A deleted agent version Object")
model DeleteAgentVersionResponse {
  @doc("The object type. Always 'agent.version.deleted'.")
  object: AgentObjectType.agentVersionDeleted;

  @doc("The name of the agent.")
  name: string;

  @doc("The version identifier of the agent.")
  version: string;

  @doc("Whether the agent was successfully deleted.")
  deleted: boolean;
}

@doc("An structured input that can participate in prompt template substitutions and tool argument binding.")
model StructuredInputDefinition {
  @doc("A human-readable description of the input.")
  description?: string;

  @doc("The default value for the input if no run-time value is provided.")
  default_value?: unknown;

  @doc("The JSON schema for the structured input (optional).")
  schema?: Record<unknown>;

  @doc("Whether the input property is required when the agent is invoked. The service defaults to `false` if a value is not specified by the caller.")
  required?: boolean = false;
}

model ToolArgumentBinding {
  @doc("The name of the tool to participate in the argument binding. If not provided, then all tools with matching arguments will participate in binding.")
  tool_name?: string;

  @doc("The name of the argument within the tool.")
  argument_name: string;
}

/** The type of logs to stream from a container. */
@extension(
  "x-ms-foundry-meta",
  #{
    required_previews: #[AgentDefinitionOptInKeys.container_agents_v1_preview],
  }
)
union ContainerLogKind {
  /** Console logs from the container. */
  console: "console",

  /** System logs from the container. */
  system: "system",
}

union VersionSelectorType {
  string,
  FixedRatio: "FixedRatio",
}

model VersionSelector {
  version_selection_rules: VersionSelectionRule[];
}

@discriminator("type")
model VersionSelectionRule {
  type: VersionSelectorType;

  @doc("The agent version to route traffic to")
  agent_version: string;
}

model FixedRatioVersionSelectionRule extends VersionSelectionRule {
  type: VersionSelectorType.FixedRatio;

  @doc("The percentage of traffic to route to the version. Must be between 0 and 100.")
  @minValue(0)
  @maxValue(100)
  traffic_percentage: int32;
}

@discriminator("type")
model AgentEndpointAuthorizationScheme {
  type: AgentEndpointAuthorizationSchemeType;
}

model EntraAuthorizationScheme extends AgentEndpointAuthorizationScheme {
  type: AgentEndpointAuthorizationSchemeType.Entra;
}

model BotServiceAuthorizationScheme extends AgentEndpointAuthorizationScheme {
  type: AgentEndpointAuthorizationSchemeType.BotService;
}

model BotServiceRbacAuthorizationScheme
  extends AgentEndpointAuthorizationScheme {
  type: AgentEndpointAuthorizationSchemeType.BotServiceRbac;
}

model BotServiceTenantAuthorizationScheme
  extends AgentEndpointAuthorizationScheme {
  type: AgentEndpointAuthorizationSchemeType.BotServiceTenant;
}

union AgentEndpointAuthorizationSchemeType {
  string,
  Entra: "Entra",
  BotService: "BotService",
  BotServiceRbac: "BotServiceRbac",
  BotServiceTenant: "BotServiceTenant",
}

@doc("Per-protocol configuration for the agent endpoint.")
model ProtocolConfiguration {
  @doc("Configuration for the activity protocol.")
  activity?: ActivityProtocolConfiguration;

  @doc("Configuration for the responses protocol.")
  responses?: ResponsesProtocolConfiguration;

  @doc("Configuration for the A2A protocol.")
  a2a?: A2AProtocolConfiguration;

  @doc("Configuration for the MCP protocol.")
  mcp?: McpProtocolConfiguration;

  @doc("Configuration for the invocations protocol.")
  invocations?: InvocationsProtocolConfiguration;

  @doc("Configuration for the WebSocket-based invocations protocol.")
  invocations_ws?: InvocationsWsProtocolConfiguration;
}

@doc("Configuration specific to the activity protocol.")
model ActivityProtocolConfiguration {
  @doc("Whether to enable the M365 public endpoint for the activity protocol.")
  enable_m365_public_endpoint?: boolean;
}

@doc("Configuration specific to the responses protocol.")
model ResponsesProtocolConfiguration {}

@doc("Configuration specific to the A2A protocol.")
model A2AProtocolConfiguration {}

@doc("Configuration specific to the MCP protocol.")
model McpProtocolConfiguration {}

@doc("Configuration specific to the invocations protocol.")
model InvocationsProtocolConfiguration {}

@doc("Configuration specific to the WebSocket-based invocations protocol.")
model InvocationsWsProtocolConfiguration {}

model AgentEndpointConfig {
  @doc("The version selector of the agent endpoint determines how traffic is routed to different versions of the agent.")
  version_selector?: VersionSelector;

  @removed(Versions.v1)
  @doc("Deprecated: Use protocol_configuration instead. The presence of a key in protocol_configuration declares the protocol is enabled.")
  protocols?: AgentEndpointProtocol[];

  @doc("Per-protocol configuration for the agent endpoint.")
  protocol_configuration?: ProtocolConfiguration;

  @doc("The authorization schemes supported by the agent endpoint")
  authorization_schemes?: AgentEndpointAuthorizationScheme[];
}

model AgentIdentity {
  @doc("The principal ID of the agent instance")
  principal_id: string;

  @doc("The client ID of the agent instance. Also referred to as the instance ID")
  client_id: string;

  @doc("The status of the agent identity. Present for both the agent instance identity and the agent blueprint.")
  status?: AgentIdentityStatus;
}

@doc("The status of an agent identity, applicable to both the agent instance identity and the agent blueprint.")
union AgentIdentityStatus {
  string,

  @doc("The agent identity is active and can be used to access resources.")
  active: "active",

  @doc("The agent identity is disabled and cannot be used to access resources.")
  disabled: "disabled",
}

union AgentBlueprintReferenceType {
  string,
  ManagedAgentIdentityBlueprint: "ManagedAgentIdentityBlueprint",
}

@discriminator("type")
model AgentBlueprintReference {
  type: AgentBlueprintReferenceType;
}

model ManagedAgentIdentityBlueprintReference extends AgentBlueprintReference {
  type: AgentBlueprintReferenceType.ManagedAgentIdentityBlueprint;

  @doc("The ID of the managed blueprint")
  blueprint_id: string;
}

/** A skill example string with a maximum length of 1024 characters. */
@maxLength(1024)
scalar AgentCardSkillExample extends string;

@maxLength(32)
scalar AgentCardSkillTag extends string;

model AgentCardSkill {
  @doc("a unique identifier for the skill")
  @maxLength(64)
  @minLength(1)
  id: string;

  @doc("The name of the skill")
  @maxLength(128)
  @minLength(1)
  name: string;

  @doc("A description of the skill")
  @maxLength(2048)
  description?: string;

  @doc("set of tagwords describing classes of capabilities for the skill")
  @maxItems(5)
  tags?: AgentCardSkillTag[];

  @doc("A list of example scenarios that the skill can perform.")
  @maxItems(5)
  examples?: AgentCardSkillExample[];
}

model AgentCard {
  @doc("The version of the agent card.")
  @maxLength(32)
  @minLength(1)
  version: string;

  @doc("The description of the agent card.")
  @maxLength(2048)
  description?: string;

  @doc("The set of skills that an agent can perform.")
  @maxItems(16)
  @minItems(1)
  skills: AgentCardSkill[];
}

/**
 * JSON metadata for code-based agent operations (create, update, create version).
 * The agent name comes from the URL path parameter or the `x-ms-agent-name` header,
 * so it is not included in this model.
 * The content hash (SHA-256 of the zip) is carried in the `x-ms-code-zip-sha256` header.
 */
model CreateAgentVersionFromCodeMetadata {
  @doc("A human-readable description of the agent.")
  @maxLength(512)
  description?: string;

  ...MetadataPropertyForRequest;

  @doc("The hosted agent definition including code_configuration (runtime, entry_point), cpu, memory, and protocol_versions.")
  definition: HostedAgentDefinition;
}

/** Multipart request body for updating or versioning a code-based agent (POST /agents/{name} and POST /agents/{name}/versions). */
model CreateAgentVersionFromCodeContent {
  /** JSON metadata including description and hosted definition. */
  metadata: HttpPart<CreateAgentVersionFromCodeMetadata>;

  /** The code zip file (max 250 MB). */
  code: HttpPart<bytes>;
}

/** Multipart request body for creating a new code-based agent (POST /agents). Inherits from CreateAgentVersionFromCodeContent for future extensibility. */
model CreateAgentFromCodeContent {
  ...CreateAgentVersionFromCodeContent;
}

/**
 * Response body for downloading a hosted agent's code zip.
 * Body is the raw zip bytes; `Content-Type` declares `application/zip` so clients
 * can route to a zip-aware handler. Streaming is preserved (`bytes` body) regardless
 * of the content-type label.
 */
model DownloadAgentCodeResponse {
  @doc("The media type of the returned package content.")
  @header("Content-Type")
  content_type: "application/zip";

  @doc("The version of the agent whose code zip is returned in the response body.")
  @header("x-ms-agent-version")
  agent_version: string;

  @doc("The zip code package content.")
  @body
  content: bytes;
}

// ══════════════════════════════════════════════════════════
// Session Lifecycle Management
// ══════════════════════════════════════════════════════════

// ── Session Status ──────────────────────────────────────

/** The status of an agent session. */
union AgentSessionStatus {
  string,

  /** Session initialization is in progress. */
  Creating: "creating",

  /** Session is running and operational. */
  Active: "active",

  /** Session sandbox is auto-suspended; resumes on next invocation. */
  Idle: "idle",

  /** Reserved for future session re-parenting flows. */
  Updating: "updating",

  /** Session initialization or lifecycle handling failed and requires delete to recover. */
  Failed: "failed",

  /** Session is being deleted (cleanup in progress). */
  Deleting: "deleting",

  /** Session has been explicitly deleted. */
  Deleted: "deleted",

  /** Session TTL exceeded (30 days from last activity). */
  Expired: "expired",
}

// ── Version Indicator ───────────────────────────────────

/** The type of version indicator used to determine the agent version backing a session. */
union VersionIndicatorType {
  string,

  /** Direct reference to a specific agent version. */
  VersionRef: "version_ref",
}

/** Base class for version indicators. Uses type discriminator for polymorphism. */
@doc("Version indicator determining which agent version backs the session.")
@discriminator("type")
model VersionIndicator {
  /** The type of version indicator. */
  type: VersionIndicatorType;
}

/** Version indicator that references a specific agent version by name. */
model VersionRefIndicator extends VersionIndicator {
  /** Discriminator value for version_ref. */
  type: VersionIndicatorType.VersionRef;

  /** The agent version identifier returned by the agent version APIs. */
  agent_version: string;
}

// ── Session Resource ────────────────────────────────────

/** Represents an agent session resource. */
@doc("An agent session providing a long-lived compute sandbox for hosted agent invocations.")
model AgentSessionResource {
  /** The session identifier. */
  agent_session_id: string;

  /** The version indicator determining which agent version backs this session. */
  version_indicator: VersionIndicator;

  /** The current status of the session. */
  status: AgentSessionStatus;

  /** The Unix timestamp (in seconds) when the session was created. */
  @encode("unixTimestamp", int64)
  @visibility(Lifecycle.Read)
  created_at: utcDateTime;

  /** The Unix timestamp (in seconds) when the session was last accessed. */
  @encode("unixTimestamp", int64)
  @visibility(Lifecycle.Read)
  last_accessed_at: utcDateTime;

  /** The Unix timestamp (in seconds) when the session expires (rolling, 30 days from last activity). */
  @encode("unixTimestamp", int64)
  @visibility(Lifecycle.Read)
  expires_at: utcDateTime;
}

// ── Session Request Models ──────────────────────────────

/** Request body for creating a new agent session. */
@doc("Request to create a new agent session.")
model CreateAgentSessionRequest {
  /** Optional caller-provided session ID. If specified, it must be unique within the agent endpoint. Auto-generated if omitted. */
  agent_session_id?: string;

  /** Determines which agent version backs the session. */
  version_indicator: VersionIndicator;
}

/**
 * Known SSE event types emitted by the hosted agent session log stream.
 * Additional event types may be introduced in future versions.
 */
union SessionLogEventType {
  string,

  @doc("A log line from the agent session container.")
  log: "log",
}

/**
 * A single Server-Sent Event frame emitted by the hosted agent session log stream.
 *
 * Each frame contains an `event` field identifying the event type and a `data`
 * field carrying the payload as plain text. Although the current `data` payload
 * is JSON-formatted, its schema is not contractual — additional keys may appear
 * and the format may change over time. Clients should treat `data` as an
 * opaque string and optionally attempt JSON parsing.
 *
 * New event types may be added in the future. Clients should gracefully
 * ignore unrecognized event types.
 *
 * Wire format:
 * ```
 * event: log
 * data: {"timestamp":"2026-03-10T09:33:17.121Z","stream":"stdout","message":"Starting server on port 18080"}
 *
 * event: log
 * data: {"timestamp":"2026-03-10T09:34:52.714Z","stream":"status","message":"Successfully connected to container"}
 * ```
 */
model SessionLogEvent {
  @doc("The SSE event type. Currently `log`, but additional event types may be added in the future. Clients should ignore unrecognized event types.")
  @example("log")
  event: SessionLogEventType;

  @doc("The event payload as plain text. Currently JSON-formatted but the schema is not contractual and may change.")
  @example("{\"timestamp\":\"2026-03-10T09:33:17.121467567+00:00\",\"stream\":\"stdout\",\"message\":\"Starting server on port 18080\"}")
  data: string;
}
// ── Telemetry Unions ────────────────────────────────────

@doc("The kind of telemetry export endpoint.")
union TelemetryEndpointKind {
  string,

  @doc("OpenTelemetry Protocol (OTLP) endpoint.")
  OTLP: "OTLP",
}

@doc("The type of telemetry data to export.")
union TelemetryDataKind {
  string,

  @doc("Container stdout and stderr logs.")
  ContainerStdoutStderr: "ContainerStdoutStderr",

  @doc("Container OpenTelemetry signals.")
  ContainerOtel: "ContainerOtel",

  @doc("Container metrics.")
  Metrics: "Metrics",
}

@doc("The transport protocol for telemetry export.")
union TelemetryTransportProtocol {
  string,

  @doc("HTTP transport protocol.")
  Http: "Http",

  @doc("gRPC transport protocol.")
  Grpc: "Grpc",
}

// ── Telemetry Auth (discriminated by "type") ────────────

@doc("The type of authentication for a telemetry endpoint.")
union TelemetryEndpointAuthType {
  string,

  @doc("Header-based secret authentication.")
  header: "header",
}

@doc("Authentication configuration for a telemetry endpoint.")
@discriminator("type")
model TelemetryEndpointAuth {
  @doc("The authentication type.")
  type: TelemetryEndpointAuthType;
}

@doc("Header-based secret authentication for a telemetry endpoint. The resolved secret value is injected as an HTTP header.")
model HeaderTelemetryEndpointAuth extends TelemetryEndpointAuth {
  @doc("The authentication type, always 'header' for header-based secret authentication.")
  type: TelemetryEndpointAuthType.header;

  @doc("The name of the HTTP header to inject the secret value into.")
  @example("X-Otlp-Api-Key")
  header_name: string;

  @doc("The identifier of the secret store or connection.")
  @example("my-secret-store")
  secret_id: string;

  @doc("The key within the secret to retrieve the authentication value.")
  @example("OTLP_KEY")
  secret_key: string;
}

// ── Telemetry Config & Endpoint (discriminated by "kind") ─

@doc("Customer-supplied telemetry configuration for exporting container logs, traces, and metrics.")
model TelemetryConfig {
  @doc("Customer-supplied telemetry export endpoint configurations.")
  @minItems(1)
  @maxItems(3)
  endpoints: TelemetryEndpoint[];
}

@doc("A telemetry export endpoint configuration.")
@discriminator("kind")
model TelemetryEndpoint {
  @doc("The telemetry export endpoint kind.")
  kind: TelemetryEndpointKind;

  @doc("Data types to export to this endpoint. Use an empty array to export no data.")
  @example(#["ContainerStdoutStderr", "ContainerOtel", "Metrics"])
  data: TelemetryDataKind[];

  @doc("Optional authentication configuration.")
  auth?: TelemetryEndpointAuth;
}

@doc("An OTLP (OpenTelemetry Protocol) telemetry export endpoint.")
model OtlpTelemetryEndpoint extends TelemetryEndpoint {
  @doc("The endpoint kind, always 'OTLP' for OpenTelemetry Protocol endpoints.")
  kind: TelemetryEndpointKind.OTLP;

  @doc("The OTLP collector endpoint URL.")
  @example("https://my-collector.example.com/otlp")
  endpoint: string;

  @doc("The transport protocol for the OTLP endpoint.")
  @example("Http")
  protocol: TelemetryTransportProtocol;
}

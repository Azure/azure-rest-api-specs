import "./managed-runtime-models.tsp";

using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Azure.AI.Projects;

const ManagedAgentsRequiredPreviews = #{
  required_previews: #[AgentDefinitionOptInKeys.managed_agents_v1_preview],
};

const ManagedAgentsConditionalPreviews = #{
  conditional_previews: #[AgentDefinitionOptInKeys.managed_agents_v1_preview],
};

/**
 * The complete Managed definition, using the existing Agent definition base.
 * Inline Sessions do not accept the version-only definition_source property.
 * Mappable model controls stay here. Provider-specific model controls belong in model_configurations;
 * execution-specific settings belong in harness. Shared placement does not guarantee backend support.
 */
@extension("x-ms-foundry-meta", ManagedAgentsRequiredPreviews)
model ManagedAgentDefinition extends AgentDefinition {
  /** The definition kind. */
  kind: AgentKind.managed;

  /** A model deployment compatible with the selected harness. */
  `model`: string;

  /** Typed harness-specific configuration. Private preview supports Microsoft Copilot. */
  harness: ManagedMicrosoftCopilotHarness;

  /** Instructions supplied to the harness. */
  instructions?: string;

  /** Shared reasoning settings, validated against the selected model and harness. */
  reasoning?: ManagedAgentReasoning;

  /** Shared output-format settings. Provider-specific verbosity belongs in model_configurations.text. */
  text?: TextConfig;

  /** Maximum generated tokens per model call, including reasoning/thinking, not a whole-turn budget. Validate the selected model's limits. */
  @minValue(1)
  max_output_tokens?: int32;

  /** Shared tool-selection intent. Forced choices require a supported model and an authorized declared function. */
  tool_choice?: ToolChoice;

  /** Whether a model response may contain multiple tool calls. False permits at most one; true does not require multiple calls or parallel execution. */
  parallel_tool_calls?: boolean;

  /** Flat provider-specific controls selected by model, not provider-keyed blocks or overrides of common fields. Reject unknown, misplaced, incompatible or unsupported settings. */
  model_configurations?: ModelConfigurations;

  /** Shared compaction settings, subject to harness support; no shared default is implied. */
  compaction?: Compaction | null;

  /** Shared subagent settings, subject to harness support; no shared default is implied. */
  multi_agent?: MultiAgent | null;

  /** Complete typed tool declarations. Toolbox access uses the existing MCP tool. */
  tools?: OpenAI.Tool[];

  /** Authorized versioned Foundry Skill references. */
  skills?: SkillReference[];
}

/** The complete Managed definition with the source declaration used only by saved versions. */
@extension("x-ms-foundry-meta", ManagedAgentsRequiredPreviews)
model ManagedAgentVersionDefinition {
  ...OmitProperties<ManagedAgentDefinition, "kind">;

  /** The definition kind, without adding a second Managed subtype to AgentDefinition. */
  kind: AgentKind.managed;

  /** The version supplies the full definition. Omission selects agent source. */
  definition_source?: "agent" = "agent";
}

/** A Managed version that requires a complete inline definition on every Session. No executable defaults are accepted. */
@extension("x-ms-foundry-meta", ManagedAgentsRequiredPreviews)
model ManagedAgentSessionSourceDefinition {
  /** The definition kind. */
  kind: AgentKind.managed;

  /** Every Session supplies its complete executable definition. */
  definition_source: "session";
}

/** The Managed Microsoft Copilot harness. Its discriminator matches the current Prompt preview; the definition kind and contract remain distinct. */
model ManagedMicrosoftCopilotHarness {
  /** The harness discriminator. */
  type: "microsoft_copilot_preview";
}

/** Reasoning settings supported by the selected model and Managed harness. */
model ManagedAgentReasoning {
  /** Requested relative effort, not a token budget. The model adapter must validate the selected deployment, provider API version and harness; reject unsupported values rather than translating them to an arbitrary budget or lower effort. Omission or null uses the selected model's default. */
  effort?: string | null;
}

/** Output controls with an OpenAI and Claude mapping. */
model TextConfig {
  /** Plain text or a supported JSON Schema. Reject a schema the selected model adapter cannot enforce. */
  format?: TextFormat;
}

/** Common text-output format discriminator. */
model TextFormatBase {
  /** The output-format discriminator. */
  type: string;
}

/** Common text-output format with each variant's required fields preserved. */
@discriminated(#{ envelope: "none", discriminatorPropertyName: "type" })
union TextFormat extends TextFormatBase {
  text: PlainTextFormat,
  json_schema: JsonSchemaFormat,
}

/** Unconstrained text output. The Claude adapter omits its structured-output format. */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "union-extends requires inherited variants; @discriminated on the union supplies the discriminator."
model PlainTextFormat extends TextFormatBase {
  /** The output-format discriminator. */
  type: "text";
}

/** Structured output using a schema supported by the selected provider and model. */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "union-extends requires inherited variants; @discriminated on the union supplies the discriminator."
model JsonSchemaFormat extends TextFormatBase {
  /** The output-format discriminator. */
  type: "json_schema";

  /** JSON Schema object. Provider schema restrictions still apply. */
  schema: Record<unknown>;
}

/** Common automatic, required, disabled or named-function tool selection. */
#suppress "@azure-tools/typespec-client-generator-core/use-union-hierarchy" "Tool selection accepts a string mode or a named-function object, not models sharing a discriminator."
union ToolChoice {
  /** Let the model choose whether to call tools. */
  auto: "auto",

  /** Require a tool call when supported by the selected model and thinking mode. */
  required: "required",

  /** Do not allow tool calls for the model response. */
  none: "none",

  /** Require a particular declared function when supported. */
  named_function: FunctionToolChoice,
}

/** A named function choice; provider-specific built-in tool selectors are not common choices. */
model FunctionToolChoice {
  /** The tool-choice discriminator. */
  type: "function";

  /** Name of an authorized function in the resolved tool set. */
  @minLength(1)
  name: string;
}

/** Flat model-specific settings. The deployment selects the provider; this object cannot override reasoning.effort, text.format, token limits, tool choice or compaction scheduling. */
model ModelConfigurations {
  /** OpenAI reasoning presentation, not shared effort. */
  reasoning?: ModelReasoningConfig;

  /** OpenAI text verbosity, not shared output format. */
  text?: ModelTextConfig;

  /** Claude thinking mode, presentation and optional manual budget. */
  thinking?: Thinking;

  /** Native provider service tier, validated against the selected model, provider API and harness. No cross-provider tier equivalence is implied. */
  service_tier?: string | null;

  /** Claude threshold-compaction pause control. Requires a supported threshold strategy and explicit compaction.async=false; it is not background scheduling. */
  pause_after_compaction?: boolean;
}

/** Provider-specific reasoning presentation. */
model ModelReasoningConfig {
  /** OpenAI summary presentation; no automatic translation to Claude thinking.display. */
  summary?: ReasoningSummary | null;
}

/** OpenAI reasoning-summary selections, subject to model support. */
union ReasoningSummary {
  /** Request a concise summary. */
  concise: "concise",

  /** Request a detailed summary. */
  detailed: "detailed",

  /** Let the provider select supported summary detail. */
  auto: "auto",
}

/** Provider-specific text presentation. */
model ModelTextConfig {
  /** OpenAI verbosity; not a substitute for effort or an output-token limit. */
  verbosity?: TextVerbosity;
}

/** OpenAI text-verbosity selections. */
union TextVerbosity {
  /** Request less output text. */
  low: "low",

  /** Request medium output text. */
  medium: "medium",

  /** Request more output text. */
  high: "high",
}

/** Claude thinking-mode discriminator. */
model ThinkingBase {
  /** The thinking-mode discriminator. */
  type: string;
}

/** Claude thinking configuration. Validate model/API/beta support and compatibility with common effort and tool choice. */
@discriminated(#{ envelope: "none", discriminatorPropertyName: "type" })
union Thinking extends ThinkingBase {
  adaptive: AdaptiveThinking,
  enabled: ManualThinking,
  disabled: DisabledThinking,
  between_tools: BetweenToolsThinking,
}

/** Model-selected thinking. */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "union-extends requires inherited variants; @discriminated on the union supplies the discriminator."
model AdaptiveThinking extends ThinkingBase {
  /** The thinking-mode discriminator. */
  type: "adaptive";

  /** Supported thinking presentation; updates requires provider beta support. */
  display?: ThinkingDisplay;
}

/** Manual thinking on a compatible Claude model. */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "union-extends requires inherited variants; @discriminated on the union supplies the discriminator."
model ManualThinking extends ThinkingBase {
  /** The thinking-mode discriminator. */
  type: "enabled";

  /** Thinking-token budget, at least 1024 and below the resolved per-call output-token limit. It is not inferred from reasoning.effort. */
  @minValue(1024)
  budget_tokens: int32;

  /** Supported thinking presentation; updates requires provider beta support. */
  display?: ThinkingDisplay;
}

/** Disabled thinking, without presentation or budget fields. */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "union-extends requires inherited variants; @discriminated on the union supplies the discriminator."
model DisabledThinking extends ThinkingBase {
  /** The thinking-mode discriminator. */
  type: "disabled";
}

/** Between-tools thinking on a model that supports it; no budget or display fields. */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "union-extends requires inherited variants; @discriminated on the union supplies the discriminator."
model BetweenToolsThinking extends ThinkingBase {
  /** The thinking-mode discriminator. */
  type: "between_tools";
}

/** Claude thinking presentation, not an OpenAI reasoning-summary enum. */
union ThinkingDisplay {
  /** Return summarized thinking when supported. */
  summarized: "summarized",

  /** Omit visible thinking while preserving provider state. */
  omitted: "omitted",

  /** Return progress updates when the provider beta is supported. */
  updates: "updates",
}

/** Shared harness orchestration, not a provider request body. Accept only modes the selected harness and model adapter implement. */
model Compaction {
  /** True requests background compaction; false requests blocking compaction, not disabled compaction. Provider threshold and pause controls are not equivalent. Omission and null do not imply a common harness default. */
  async?: boolean | null;

  /** Input-context token threshold for requesting compaction, measured with the selected model's tokenizer. Validate provider limits and scheduling support; this is not a hard context-size cap. */
  @minValue(1)
  token_threshold?: int32;
}

/** Shared subagent configuration. Unsupported modes or limits must be rejected. */
model MultiAgent {
  /** Whether subagents are enabled within the caller's authorized tools and resources. */
  enabled: boolean;

  /** Requested concurrent-subagent limit, subject to harness support. */
  max_concurrent_subagents?: int32;
}

/** Supported private-preview platform Environment allocation modes. */
union PlatformEnvironmentMode {
  /** Start preparing the platform Environment at Session creation. Creation success does not guarantee that the Environment is ready. */
  always: "always",

  /** Prepare the platform Environment on demand. */
  on_demand: "on_demand",

  /** Never allocate or execute in a platform Environment. Environment-dependent tools are unavailable. */
  `never`: "never",
}

/** A Session-level managed Environment selector, not live allocation state or an Agent definition kind. */
model PlatformEnvironment {
  /** Use the platform-provided Environment. */
  type: "managed";

  /** Explicit allocation mode when the Environment selector is supplied. */
  provisioning_mode: PlatformEnvironmentMode;
}

/** Content accepted in initial user messages, subject to model and harness support. */
@discriminator("type")
model SessionInputContent {
  /** The content discriminator. */
  type: string;
}

/** Text content in an initial user message. */
model SessionInputText extends SessionInputContent {
  /** The content discriminator. */
  type: "input_text";

  /** The user-supplied text. */
  text: string;
}

/** Image content in an initial user message. */
model SessionInputImage extends SessionInputContent {
  /** The content discriminator. */
  type: "input_image";

  /** The image URL or data URI. */
  image_url: string;
}

/** An initial user message. */
model SessionInputMessage {
  /** The input-item discriminator. */
  type?: "message" = "message";

  /** The message author. */
  role: "user";

  /** The message content. */
  content: SessionInputContent[];
}

/** Initial input for a Managed Session. */
#suppress "@azure-tools/typespec-client-generator-core/use-union-hierarchy" "The selected input accepts either a string or a message array, not variants with a shared model base."
union SessionInput {
  string,
  SessionInputMessage[],
}

/** Optional repeatability headers for Managed Session creation and event submission. Supply both headers or neither. */
model SessionRepeatabilityRequestHeaders {
  ...OmitProperties<
    Azure.Core.RepeatabilityRequestHeaders,
    "repeatabilityRequestId"
  >;

  /** Client-generated UUID for one logical request. Reuse it with the original Repeatability-First-Sent and body on retries. */
  @header("Repeatability-Request-ID")
  repeatabilityRequestId?: Azure.Core.uuid;
}

/** Creates a Managed Session using an explicit version reference under the route Agent. The service generates the Session ID; caller-supplied id and agent_session_id are rejected. */
@extension("x-ms-foundry-meta", ManagedAgentsRequiredPreviews)
model SessionCreateConfig {
  /** Required exact version of the route Agent, including a session-source version when supplying an inline definition. */
  version_indicator: VersionRefIndicator;

  /** Required for session-source versions and rejected for agent-source versions. No definition_source, partial override or merge is accepted here. */
  agent_definition?: ManagedAgentDefinition;

  /** Optional Environment selection. Omission is allowed; it does not inherit from the Agent or imply an allocation-mode default. */
  environment?: PlatformEnvironment;

  /** Optional initial input. Omission submits no work. Supplied input waits for required identity and Environment readiness. */
  input?: SessionInput;

  /** Descriptive Session labels, not copied version metadata or permission grants. */
  metadata?: Record<string>;
}

/** The owning Agent and exact requested version resolved once at Session creation. */
model SessionAgentReference {
  /** The owning Agent's project-local name. */
  name: string;

  /** The exact version selected by version_indicator, including for session-source creation. */
  version: string;
}

/** Managed Session lifecycle and work states. Includes Hosted lifecycle names without inheriting Hosted compute or expiry behavior. */
union SessionStatus {
  string,

  /** Session initialization is in progress. */
  creating: "creating",

  /** The Session is operational. This does not by itself indicate that a turn is running. */
  active: "active",

  /** No turn is currently running. */
  idle: "idle",

  /** A supported Session lifecycle update is in progress. This does not add a configuration-update operation. */
  updating: "updating",

  /** A turn is in progress. */
  in_progress: "in_progress",

  /** Client action is required before execution can continue. */
  requires_action: "requires_action",

  /** The Session failed. */
  failed: "failed",

  /** Session cleanup is in progress. The delete operation retains its synchronous response contract. */
  deleting: "deleting",

  /** The Session has been deleted. */
  deleted: "deleted",

  /** The Session has expired under its retention policy; no fixed lifetime is implied. */
  expired: "expired",
}

/** A Managed Session, returned by creation even when Environment preparation or a turn is still in progress. */
@extension("x-ms-foundry-meta", ManagedAgentsRequiredPreviews)
model Session {
  /** Service-generated opaque Session ID used unchanged as the existing session_id route parameter. Callers cannot select or reuse this ID at creation. */
  id: string;

  /** The owning Agent and resolved requested version. This is not a request selector. */
  agent_reference: SessionAgentReference;

  /** The complete effective executable definition, without the version-only definition_source. */
  agent_definition: ManagedAgentDefinition;

  /** The current state, independent of Environment allocation state. */
  status: SessionStatus;

  /** Pending client actions. When requires_action, inspect these before submitting callbacks; do not infer them from repeated stream events. */
  required_actions?: SessionRequiredAction[];

  /** Environment selection and current state, when recorded or available. */
  environment?: SessionEnvironmentState;

  /** Descriptive Session labels. */
  metadata?: Record<string>;

  /** The Unix timestamp in seconds when the Session was created. */
  @encode("unixTimestamp", int64)
  @visibility(Lifecycle.Read)
  created_at: utcDateTime;

  /** The Unix timestamp in seconds when the Session was last accessed. */
  @encode("unixTimestamp", int64)
  @visibility(Lifecycle.Read)
  last_accessed_at: utcDateTime;

  /** The Unix timestamp in seconds when the Session expires, when an expiry is recorded. Omission does not imply the Hosted rolling 30-day policy. */
  @encode("unixTimestamp", int64)
  @visibility(Lifecycle.Read)
  expires_at?: utcDateTime;
}

/** Existing Agent definitions and the two Managed version definition shapes. definition_source is Managed-version-only. */
#suppress "@azure-tools/typespec-client-generator-core/use-union-hierarchy" "The source-only variant must not inherit executable fields; preserve the existing AgentDefinition hierarchy and omitted agent-source discriminator."
union AgentVersionDefinition {
  AgentDefinition,
  ManagedAgentVersionDefinition,
  ManagedAgentSessionSourceDefinition,
}

/** The existing Hosted response or the Managed response selected by the owning Agent's definition kind. */
#suppress "@azure-tools/typespec-client-generator-core/use-union-hierarchy" "Hosted and Managed have different existing resource shapes; the route Agent selects them without a new wire discriminator or Hosted base-model change."
union AgentSession {
  AgentSessionResource,
  Session,
}

/** The request shape selected by the owning Agent's definition kind. */
#suppress "@azure-tools/typespec-client-generator-core/use-union-hierarchy" "The route Agent selects Hosted or Managed validation without a new wire discriminator; both require version_indicator and Hosted retains its existing model hierarchy."
union AgentSessionCreateContent {
  CreateAgentSessionRequest,
  SessionCreateConfig,
}

/** The existing 201 Session-create response with the Hosted or Managed body. */
model CreatedAgentSession {
  ...CreatedResponse;
  ...Azure.Core.RepeatabilityResponseHeaders;

  /** The created Session, not a provisioning job. */
  @body body: AgentSession;
}

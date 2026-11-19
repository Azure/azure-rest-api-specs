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
 * Executable fields shared by a saved Managed definition and a complete inline definition.
 * Mappable model controls stay here. Provider-specific model controls belong in model_configurations;
 * execution-specific settings belong in harness. Shared placement does not guarantee backend support.
 */
model ManagedAgentExecutableConfig {
  /** A model deployment compatible with the selected harness. */
  `model`: string;

  /** Typed harness-specific configuration. Private preview supports Microsoft Copilot. */
  harness: ManagedMicrosoftCopilotHarness;

  /** Instructions supplied to the harness. */
  instructions?: string;

  /** Shared reasoning settings, validated against the selected model and harness. */
  reasoning?: ManagedAgentReasoning;

  /** Shared output-format settings. Provider-specific verbosity belongs in model_configurations.text. */
  text?: ManagedAgentTextConfig;

  /** Maximum generated tokens per model call, including reasoning/thinking, not a whole-turn budget. Validate the selected model's limits. */
  @minValue(1)
  max_output_tokens?: int32;

  /** Shared tool-selection intent. Forced choices require a supported model and an authorized declared function. */
  tool_choice?: ManagedAgentToolChoice;

  /** Whether a model response may contain multiple tool calls. False permits at most one; true does not require multiple calls or parallel execution. */
  parallel_tool_calls?: boolean;

  /** Flat provider-specific controls selected by model, not provider-keyed blocks or overrides of common fields. Reject unknown, misplaced, incompatible or unsupported settings. */
  model_configurations?: ManagedAgentModelConfigurations;

  /** Shared compaction settings, subject to harness support; no shared default is implied. */
  compaction?: ManagedAgentCompaction | null;

  /** Shared subagent settings, subject to harness support; no shared default is implied. */
  multi_agent?: ManagedAgentMultiAgent | null;

  /** Complete typed tool declarations. Toolbox access uses the existing MCP tool. */
  tools?: OpenAI.Tool[];

  /** Authorized versioned Foundry Skill references. */
  skills?: SkillReference[];
}

/** The complete executable Managed definition. Inline Sessions do not accept definition_source. */
@extension("x-ms-foundry-meta", ManagedAgentsRequiredPreviews)
model ManagedAgentDefinition extends AgentDefinition {
  /** The definition kind. */
  kind: AgentKind.managed;

  ...ManagedAgentExecutableConfig;
}

/** Reusable executable configuration saved on an agent-source Managed version. */
@extension("x-ms-foundry-meta", ManagedAgentsRequiredPreviews)
model ManagedAgentVersionDefinition {
  /** The definition kind. */
  kind: AgentKind.managed;

  ...ManagedAgentExecutableConfig;

  /** Existing Agent-layer content-safety configuration. */
  rai_config?: RaiConfig;

  /** The version supplies the full definition. Omission selects agent source. */
  definition_source?: "agent" = "agent";
}

/** A Managed version that requires a complete inline definition on every Session. No executable defaults are accepted. */
@extension("x-ms-foundry-meta", ManagedAgentsRequiredPreviews)
model SessionSourceManagedAgentDefinition {
  /** The definition kind. */
  kind: AgentKind.managed;

  /** Every Session supplies its complete executable definition. */
  definition_source: "session";
}

/** Existing Agent definitions and the two Managed version definition shapes. definition_source is Managed-version-only. */
#suppress "@azure-tools/typespec-client-generator-core/use-union-hierarchy" "The source-only variant must not inherit executable fields; preserve the existing AgentDefinition hierarchy and omitted agent-source discriminator."
union AgentVersionDefinition {
  AgentDefinition,
  ManagedAgentVersionDefinition,
  SessionSourceManagedAgentDefinition,
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
model ManagedAgentTextConfig {
  /** Plain text or a supported JSON Schema. Reject a schema the selected model adapter cannot enforce. */
  format?: ManagedAgentTextFormat;
}

/** Common text-output format discriminator. */
model ManagedAgentTextFormatBase {
  /** The output-format discriminator. */
  type: string;
}

/** Common text-output format with each variant's required fields preserved. */
@discriminated(#{ envelope: "none", discriminatorPropertyName: "type" })
union ManagedAgentTextFormat extends ManagedAgentTextFormatBase {
  text: ManagedAgentPlainTextFormat,
  json_schema: ManagedAgentJsonSchemaFormat,
}

/** Unconstrained text output. The Claude adapter omits its structured-output format. */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "union-extends requires inherited variants; @discriminated on the union supplies the discriminator."
model ManagedAgentPlainTextFormat extends ManagedAgentTextFormatBase {
  /** The output-format discriminator. */
  type: "text";
}

/** Structured output using a schema supported by the selected provider and model. */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "union-extends requires inherited variants; @discriminated on the union supplies the discriminator."
model ManagedAgentJsonSchemaFormat extends ManagedAgentTextFormatBase {
  /** The output-format discriminator. */
  type: "json_schema";

  /** JSON Schema object. Provider schema restrictions still apply. */
  schema: Record<unknown>;
}

/** Common automatic, required, disabled or named-function tool selection. */
#suppress "@azure-tools/typespec-client-generator-core/use-union-hierarchy" "Tool selection accepts a string mode or a named-function object, not models sharing a discriminator."
union ManagedAgentToolChoice {
  /** Let the model choose whether to call tools. */
  auto: "auto",

  /** Require a tool call when supported by the selected model and thinking mode. */
  required: "required",

  /** Do not allow tool calls for the model response. */
  none: "none",

  /** Require a particular declared function when supported. */
  named_function: ManagedAgentFunctionToolChoice,
}

/** A named function choice; provider-specific built-in tool selectors are not common choices. */
model ManagedAgentFunctionToolChoice {
  /** The tool-choice discriminator. */
  type: "function";

  /** Name of an authorized function in the resolved tool set. */
  @minLength(1)
  name: string;
}

/** Flat model-specific settings. The deployment selects the provider; this object cannot override reasoning.effort, text.format, token limits, tool choice or compaction scheduling. */
model ManagedAgentModelConfigurations {
  /** OpenAI reasoning presentation, not shared effort. */
  reasoning?: ManagedAgentModelReasoningConfig;

  /** OpenAI text verbosity, not shared output format. */
  text?: ManagedAgentModelTextConfig;

  /** Claude thinking mode, presentation and optional manual budget. */
  thinking?: ManagedAgentThinking;

  /** Provider sampling temperature. Current Claude Messages 2026-10-21 rejects this field; OpenAI model support varies. */
  @minValue(0)
  @maxValue(2)
  temperature?: float32 | null;

  /** Provider nucleus-sampling probability. Current Claude Messages 2026-10-21 rejects this field; OpenAI model support varies. */
  @minValue(0)
  @maxValue(1)
  top_p?: float32 | null;

  /** Native provider service tier, validated against the selected model, provider API and harness. No cross-provider tier equivalence is implied. */
  service_tier?: string | null;

  /** Claude threshold-compaction pause control. Requires a supported threshold strategy and explicit compaction.async=false; it is not background scheduling. */
  pause_after_compaction?: boolean;
}

/** Provider-specific reasoning presentation. */
model ManagedAgentModelReasoningConfig {
  /** OpenAI summary presentation; no automatic translation to Claude thinking.display. */
  summary?: ManagedAgentReasoningSummary | null;
}

/** OpenAI reasoning-summary selections, subject to model support. */
union ManagedAgentReasoningSummary {
  /** Request a concise summary. */
  concise: "concise",

  /** Request a detailed summary. */
  detailed: "detailed",

  /** Let the provider select supported summary detail. */
  auto: "auto",
}

/** Provider-specific text presentation. */
model ManagedAgentModelTextConfig {
  /** OpenAI verbosity; not a substitute for effort or an output-token limit. */
  verbosity?: ManagedAgentTextVerbosity;
}

/** OpenAI text-verbosity selections. */
union ManagedAgentTextVerbosity {
  /** Request less output text. */
  low: "low",

  /** Request medium output text. */
  medium: "medium",

  /** Request more output text. */
  high: "high",
}

/** Claude thinking-mode discriminator. */
model ManagedAgentThinkingBase {
  /** The thinking-mode discriminator. */
  type: string;
}

/** Claude thinking configuration. Validate model/API/beta support and compatibility with common effort and tool choice. */
@discriminated(#{ envelope: "none", discriminatorPropertyName: "type" })
union ManagedAgentThinking extends ManagedAgentThinkingBase {
  adaptive: ManagedAgentAdaptiveThinking,
  enabled: ManagedAgentManualThinking,
  disabled: ManagedAgentDisabledThinking,
  between_tools: ManagedAgentBetweenToolsThinking,
}

/** Model-selected thinking. */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "union-extends requires inherited variants; @discriminated on the union supplies the discriminator."
model ManagedAgentAdaptiveThinking extends ManagedAgentThinkingBase {
  /** The thinking-mode discriminator. */
  type: "adaptive";

  /** Supported thinking presentation; updates requires provider beta support. */
  display?: ManagedAgentThinkingDisplay;
}

/** Manual thinking on a compatible Claude model. */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "union-extends requires inherited variants; @discriminated on the union supplies the discriminator."
model ManagedAgentManualThinking extends ManagedAgentThinkingBase {
  /** The thinking-mode discriminator. */
  type: "enabled";

  /** Thinking-token budget, at least 1024 and below the resolved per-call output-token limit. It is not inferred from reasoning.effort. */
  @minValue(1024)
  budget_tokens: int32;

  /** Supported thinking presentation; updates requires provider beta support. */
  display?: ManagedAgentThinkingDisplay;
}

/** Disabled thinking, without presentation or budget fields. */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "union-extends requires inherited variants; @discriminated on the union supplies the discriminator."
model ManagedAgentDisabledThinking extends ManagedAgentThinkingBase {
  /** The thinking-mode discriminator. */
  type: "disabled";
}

/** Between-tools thinking on a model that supports it; no budget or display fields. */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "union-extends requires inherited variants; @discriminated on the union supplies the discriminator."
model ManagedAgentBetweenToolsThinking extends ManagedAgentThinkingBase {
  /** The thinking-mode discriminator. */
  type: "between_tools";
}

/** Claude thinking presentation, not an OpenAI reasoning-summary enum. */
union ManagedAgentThinkingDisplay {
  /** Return summarized thinking when supported. */
  summarized: "summarized",

  /** Omit visible thinking while preserving provider state. */
  omitted: "omitted",

  /** Return progress updates when the provider beta is supported. */
  updates: "updates",
}

/** Shared harness orchestration, not a provider request body. Accept only modes the selected harness and model adapter implement. */
model ManagedAgentCompaction {
  /** True requests background compaction; false requests blocking compaction, not disabled compaction. Provider threshold and pause controls are not equivalent. Omission and null do not imply a common harness default. */
  async?: boolean | null;

  /** Input-context token threshold for requesting compaction, measured with the selected model's tokenizer. Validate provider limits and scheduling support; this is not a hard context-size cap. */
  @minValue(1)
  token_threshold?: int32;
}

/** Shared subagent configuration. Unsupported modes or limits must be rejected. */
model ManagedAgentMultiAgent {
  /** Whether subagents are enabled within the caller's authorized tools and resources. */
  enabled: boolean;

  /** Requested concurrent-subagent limit, subject to harness support. */
  max_concurrent_subagents?: int32;
}

/** Supported private-preview platform Environment allocation modes. */
union ManagedPlatformEnvironmentMode {
  /** Prepare the platform Environment for the Session. */
  always: "always",

  /** Prepare the platform Environment on demand. */
  on_demand: "on_demand",
}

/** A Session-level managed Environment selector, not live allocation state or an Agent definition kind. */
model ManagedPlatformEnvironment {
  /** Use the platform-provided Environment. */
  type: "managed";

  /** Explicit allocation mode when the Environment selector is supplied. */
  mode: ManagedPlatformEnvironmentMode;
}

/** Content accepted in initial user messages, subject to model and harness support. */
@discriminator("type")
model ManagedSessionInputContent {
  /** The content discriminator. */
  type: string;
}

/** Text content in an initial user message. */
model ManagedSessionInputText extends ManagedSessionInputContent {
  /** The content discriminator. */
  type: "input_text";

  /** The user-supplied text. */
  text: string;
}

/** Image content in an initial user message. */
model ManagedSessionInputImage extends ManagedSessionInputContent {
  /** The content discriminator. */
  type: "input_image";

  /** The image URL or data URI. */
  image_url: string;
}

/** An initial user message. */
model ManagedSessionInputMessage {
  /** The input-item discriminator. */
  type?: "message" = "message";

  /** The message author. */
  role: "user";

  /** The message content. */
  content: ManagedSessionInputContent[];
}

/** Initial input for a Managed Session. */
#suppress "@azure-tools/typespec-client-generator-core/use-union-hierarchy" "The selected input accepts either a string or a message array, not variants with a shared model base."
union ManagedSessionInput {
  string,
  ManagedSessionInputMessage[],
}

/** Creates a Managed Session using the Agent endpoint's configured version. */
@extension("x-ms-foundry-meta", ManagedAgentsRequiredPreviews)
model ManagedAgentSessionCreateConfig {
  /** Required for session-source versions and rejected for agent-source versions. No definition_source, partial override or merge is accepted here. */
  agent_definition?: ManagedAgentDefinition;

  /** Optional Environment selection. Omission is allowed; it does not inherit from the Agent or imply an allocation-mode default. */
  environment?: ManagedPlatformEnvironment;

  /** Optional initial input. Omission submits no work. Supplied input waits for required identity and Environment readiness. */
  input?: ManagedSessionInput;

  /** Descriptive Session labels, not copied version metadata or permission grants. */
  metadata?: Record<string>;
}

/** The owning Agent and exact configured version resolved once at Session creation. */
model ManagedSessionAgentReference {
  /** The owning Agent's project-local name. */
  name: string;

  /** The exact configured version, including for session-source creation. */
  version: string;
}

/** The current Managed Session state. */
union ManagedAgentSessionStatus {
  string,

  /** No turn is currently running. */
  idle: "idle",

  /** A turn is in progress. */
  in_progress: "in_progress",

  /** Client action is required before execution can continue. */
  requires_action: "requires_action",

  /** The Session failed. */
  failed: "failed",
}

/** A Managed Session, returned by creation even when Environment preparation or a turn is still in progress. */
@extension("x-ms-foundry-meta", ManagedAgentsRequiredPreviews)
model ManagedAgentSession {
  /** The resource discriminator. */
  object: "agent.session";

  /** Opaque Session ID used unchanged as the existing session_id route parameter. */
  id: string;

  /** The owning Agent and resolved configured version. This is not a request selector. */
  agent_reference: ManagedSessionAgentReference;

  /** The complete effective executable definition, without the version-only definition_source. */
  agent_definition: ManagedAgentDefinition;

  /** The current state, independent of Environment allocation state. */
  status: ManagedAgentSessionStatus;

  /** Pending client actions. When requires_action, inspect these before submitting callbacks; do not infer them from repeated stream events. */
  required_actions?: ManagedSessionRequiredAction[];

  /** Current allocated resource state, separate from Environment selection. */
  resources?: ManagedSessionResources;

  /** The recorded Environment selection when supplied, separate from allocation state. */
  environment?: ManagedPlatformEnvironment;

  /** Descriptive Session labels. */
  metadata?: Record<string>;
}

/** The existing Hosted response or the Managed response selected by the owning Agent's definition kind. */
#suppress "@azure-tools/typespec-client-generator-core/use-union-hierarchy" "Hosted and Managed have different existing resource shapes; the route Agent selects them without a new wire discriminator or Hosted base-model change."
union AgentSession {
  AgentSessionResource,
  ManagedAgentSession,
}

/** The request shape selected by the owning Agent's definition kind. */
#suppress "@azure-tools/typespec-client-generator-core/use-union-hierarchy" "Managed creation can use an empty object; Hosted retains its required version_indicator and existing model hierarchy."
union AgentSessionCreateContent {
  CreateAgentSessionRequest,
  ManagedAgentSessionCreateConfig,
}

/** The existing 201 Session-create response with the Hosted or Managed body. */
model CreatedAgentSession {
  ...CreatedResponse;

  /** The created Session, not a provisioning job. */
  @body body: AgentSession;
}

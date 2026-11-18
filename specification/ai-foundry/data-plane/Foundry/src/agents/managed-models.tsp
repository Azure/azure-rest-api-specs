using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Azure.AI.Projects;

const ManagedAgentsRequiredPreviews = #{
  required_previews: #[AgentDefinitionOptInKeys.managed_agents_v1_preview],
};

const ManagedAgentsConditionalPreviews = #{
  conditional_previews: #[AgentDefinitionOptInKeys.managed_agents_v1_preview],
};

/** Creates an Agent and its ready default identity without an executable version. */
@extension("x-ms-foundry-meta", ManagedAgentsRequiredPreviews)
model IdentityOnlyAgentCreateConfig {
  /** The project-local Agent name, using the existing Agent naming rules. */
  @maxLength(63)
  name: string;
}

/** An Agent whose identity is ready but which has no saved version or invocation endpoint. */
@extension("x-ms-foundry-meta", ManagedAgentsRequiredPreviews)
model IdentityOnlyAgentObject {
  ...OmitProperties<
    AgentObject,
    "versions" | "agent_endpoint" | "instance_identity"
  >;

  /** The ready default Agent identity. Identity provisioning failure fails creation. */
  @visibility(Lifecycle.Read)
  instance_identity: AgentIdentity;
}

/** Versioned Agents retain their existing shape; preview identity-only Agents omit versions and agent_endpoint. */
#suppress "@azure-tools/typespec-client-generator-core/use-union-hierarchy" "Preserve the existing AgentObject hierarchy; both variants use object=agent and cannot gain a new wire discriminator."
union AgentResource {
  AgentObject,
  IdentityOnlyAgentObject,
}

/** Executable fields shared by a saved Managed definition and a complete inline definition. */
model ManagedAgentExecutableConfig {
  /** A model deployment compatible with the selected harness. */
  `model`: string;

  /** The platform-managed harness. Private preview supports GitHub Copilot. */
  harness: ManagedGitHubCopilotHarness;

  /** Instructions supplied to the harness. */
  instructions?: string;

  /** Model-supported reasoning settings. */
  reasoning?: ManagedAgentReasoning;

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

/** The Managed GitHub Copilot harness, distinct from existing Prompt preview harness values. */
model ManagedGitHubCopilotHarness {
  /** The harness discriminator. */
  type: "github_copilot_harness";
}

/** Reasoning settings supported by the selected model and Managed harness. */
model ManagedAgentReasoning {
  /** Requested reasoning effort; validate it against the selected deployment and harness. */
  effort?: string | null;
}

/** Shared compaction configuration. Copilot behavior must be qualified before accepting a setting. */
model ManagedAgentCompaction {
  /** Whether compaction runs in the background. Omission and null do not imply a common harness default. */
  async?: boolean | null;
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

/** A Session-level platform Environment selector, not live allocation state. */
model ManagedPlatformEnvironment {
  /** Use the platform-provided Environment. */
  type: "platform_hosted";

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

  /** Existing project Connection IDs, never inline credentials or a reusable Group ID. */
  connection_group?: string[];

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

  /** The recorded Environment selection when supplied, separate from allocation state. */
  environment?: ManagedPlatformEnvironment;

  /** Selected project Connection IDs, without protected material. */
  connection_group?: string[];

  /** Descriptive Session labels. */
  metadata?: Record<string>;
}

/** The existing Hosted response or the Managed response selected by the owning Agent's definition kind. */
#suppress "@azure-tools/typespec-client-generator-core/use-union-hierarchy" "Hosted and Managed have different existing resource shapes; the route Agent selects them without a new wire discriminator or Hosted base-model change."
union AgentSession {
  AgentSessionResource,
  ManagedAgentSession,
}

/** Existing full Agent creation or preview identity-only creation. */
#suppress "@azure-tools/typespec-client-generator-core/use-union-hierarchy" "Preserve the existing full-create model and the name-only preview shape without changing the existing model hierarchy."
union AgentCreateContent {
  CreateAgentRequest,
  IdentityOnlyAgentCreateConfig,
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

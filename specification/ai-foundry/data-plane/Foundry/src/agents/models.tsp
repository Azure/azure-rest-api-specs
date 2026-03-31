import "../openai-responses/models.tsp";

using TypeSpec.Http;
using TypeSpec.OpenAPI;
using TypeSpec.Versioning;

namespace Azure.AI.Projects;

const AllConditionalAgentDefinitionPreviews = #{
  conditional_previews: #[
    AgentDefinitionOptInKeys.hosted_agents_v1_preview,
    AgentDefinitionOptInKeys.container_agents_v1_preview,
    AgentDefinitionOptInKeys.workflow_agents_v1_preview
  ],
};

@extension("x-ms-foundry-meta", AllConditionalAgentDefinitionPreviews)
model CreateAgentVersionRequest {
  ...MetadataPropertyForRequest;

  @doc("A human-readable description of the agent.")
  @maxLength(512)
  description?: string;

  @doc("The agent definition. This can be a workflow, hosted agent, or a simple agent definition.")
  @extension("x-ms-foundry-meta", AllConditionalAgentDefinitionPreviews)
  definition: AgentDefinition;

  @extension(
    "x-ms-foundry-meta",
    #{
      required_previews: #[AgentDefinitionOptInKeys.agent_endpoint_v1_preview],
    }
  )
  @doc("The blueprint reference for the agent.")
  blueprint_reference?: AgentBlueprintReference;
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

  ...CreateAgentVersionRequest;

  @extension(
    "x-ms-foundry-meta",
    #{
      required_previews: #[AgentDefinitionOptInKeys.agent_endpoint_v1_preview],
    }
  )
  @doc("An optional endpoint configuration. If not specified, a default endpoint configuration will be set for the agent")
  agent_endpoint?: AgentEndpoint;

  @extension(
    "x-ms-foundry-meta",
    #{
      required_previews: #[AgentDefinitionOptInKeys.agent_endpoint_v1_preview],
    }
  )
  @doc("Optional agent card for the agent")
  agent_card?: AgentCard;
}

model UpdateAgentRequest {
  ...CreateAgentVersionRequest;
}

@extension(
  "x-ms-foundry-meta",
  #{ required_previews: #[AgentDefinitionOptInKeys.agent_endpoint_v1_preview] }
)
model PatchAgentRequest {
  ...MetadataPropertyForRequest;

  @doc("A human-readable description of the agent.")
  @maxLength(512)
  description?: string;

  @doc("The endpoint configuration for the agent")
  agent_endpoint?: AgentEndpoint;

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

model AgentObject {
  @doc("The object type, which is always 'agent'.")
  object: AgentObjectType.agent;

  @doc("The unique identifier of the agent.")
  id: string;

  @doc("The name of the agent.")
  @maxLength(63)
  name: string;

  @doc("The latest version of the agent.")
  versions: {
    latest: AgentVersionObject;
  };

  @extension(
    "x-ms-foundry-meta",
    #{
      required_previews: #[AgentDefinitionOptInKeys.agent_endpoint_v1_preview],
    }
  )
  @doc("The endpoint configuration for the agent")
  endpoint?: AgentEndpoint;

  @extension(
    "x-ms-foundry-meta",
    #{
      required_previews: #[AgentDefinitionOptInKeys.agent_endpoint_v1_preview],
    }
  )
  @doc("The instance identity of the agent")
  instance_identity?: AgentIdentity;

  @extension(
    "x-ms-foundry-meta",
    #{
      required_previews: #[AgentDefinitionOptInKeys.agent_endpoint_v1_preview],
    }
  )
  @doc("The blueprint for the agent")
  blueprint?: AgentIdentity;

  @extension(
    "x-ms-foundry-meta",
    #{
      required_previews: #[AgentDefinitionOptInKeys.agent_endpoint_v1_preview],
    }
  )
  @doc("The blueprint for the agent")
  blueprint_reference?: AgentBlueprintReference;

  @extension(
    "x-ms-foundry-meta",
    #{
      required_previews: #[AgentDefinitionOptInKeys.agent_endpoint_v1_preview],
    }
  )
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
  @encode("unixTimestamp", int32)
  created_at: utcDateTime;

  definition: AgentDefinition;

  @removed(Versions.v1)
  @doc("The provisioning status of the agent version. Defaults to 'active' for non-hosted agents. For hosted agents, reflects infrastructure readiness.")
  status: AgentVersionStatus = AgentVersionStatus.active;

  @removed(Versions.v1)
  @doc("Error details if the agent version provisioning failed.")
  error?: ApiError;

  @extension(
    "x-ms-foundry-meta",
    #{
      required_previews: #[AgentDefinitionOptInKeys.agent_endpoint_v1_preview],
    }
  )
  @doc("The instance identity of the agent")
  @visibility(Lifecycle.Read)
  instance_identity?: AgentIdentity;

  @extension(
    "x-ms-foundry-meta",
    #{
      required_previews: #[AgentDefinitionOptInKeys.agent_endpoint_v1_preview],
    }
  )
  @doc("The blueprint for the agent")
  @visibility(Lifecycle.Read)
  blueprint?: AgentIdentity;

  @extension(
    "x-ms-foundry-meta",
    #{
      required_previews: #[AgentDefinitionOptInKeys.agent_endpoint_v1_preview],
    }
  )
  @doc("The blueprint for the agent")
  @visibility(Lifecycle.Read)
  blueprint_reference?: AgentBlueprintReference;
}

@removed(Versions.v1)
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

union AgentProtocol {
  string,
  activity_protocol: "activity_protocol",
  responses: "responses",

  @removed(Versions.v1)
  invocations: "invocations",
}

union AgentEndpointProtocol {
  string,
  activity: "activity",
  responses: "responses",
  a2a: "a2a",
  invocations: "invocations",
}

union AgentKind {
  string,
  prompt: "prompt",
  hosted: "hosted",
  workflow: "workflow",

  @removed(Versions.v1)
  container_app: "container_app",
}

@doc("Configuration for Responsible AI (RAI) content filtering and safety features.")
model RaiConfig {
  @doc("The name of the RAI policy to apply.")
  rai_policy_name: string;
}

@discriminator("kind")
@extension("x-ms-foundry-meta", AllConditionalAgentDefinitionPreviews)
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
    We generally recommend altering this or `top_p` but not both.
    """)
  @minValue(0)
  @maxValue(2)
  temperature?: float32 | null = 1;

  @doc("""
    An alternative to sampling with temperature, called nucleus sampling,
    where the model considers the results of the tokens with top_p probability
    mass. So 0.1 means only the tokens comprising the top 10% probability mass
    are considered.
    
    We generally recommend altering this or `temperature` but not both.
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

@doc("The hosted agent definition.")
@extension(
  "x-ms-foundry-meta",
  #{ required_previews: #[AgentDefinitionOptInKeys.hosted_agents_v1_preview] }
)
model HostedAgentDefinition extends AgentDefinition {
  kind: AgentKind.hosted;

  @doc("""
    An array of tools the hosted agent's model may call while generating a response. You
    can specify which tool to use by setting the `tool_choice` parameter.
    """)
  tools?: OpenAI.Tool[];

  @doc("The protocols that the agent supports for ingress communication of the containers.")
  @example(#[
    #{ protocol: "responses", version: "v0.1.1" },
    #{ protocol: "a2a", version: "v0.3.0" }
  ])
  container_protocol_versions: ProtocolVersionRecord[];

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

  @doc("The image ID for the agent, applicable to image-based hosted agents.")
  @example("my-registry.azurecr.io/my-hosted-agent:latest")
  image?: string;
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
  protocol: AgentProtocol;

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

  @doc("Whether the input property is required when the agent is invoked.")
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

@extension(
  "x-ms-foundry-meta",
  #{ required_previews: #[AgentDefinitionOptInKeys.agent_endpoint_v1_preview] }
)
union VersionSelectorType {
  string,
  FixedRatio: "FixedRatio",
}

@extension(
  "x-ms-foundry-meta",
  #{ required_previews: #[AgentDefinitionOptInKeys.agent_endpoint_v1_preview] }
)
model VersionSelector {
  version_selection_rules: VersionSelectionRule[];
}

@extension(
  "x-ms-foundry-meta",
  #{ required_previews: #[AgentDefinitionOptInKeys.agent_endpoint_v1_preview] }
)
@discriminator("type")
model VersionSelectionRule {
  type: VersionSelectorType;

  @doc("The agent version to route traffic to")
  agent_version: string;
}

@removed(Versions.v1)
@extension(
  "x-ms-foundry-meta",
  #{ required_previews: #[AgentDefinitionOptInKeys.agent_endpoint_v1_preview] }
)
model FixedRatioVersionSelectionRule extends VersionSelectionRule {
  type: VersionSelectorType.FixedRatio;

  @doc("The percentage of traffic to route to the version. Must be between 0 and 100.")
  @minValue(0)
  @maxValue(100)
  traffic_percentage: int32;
}

@extension(
  "x-ms-foundry-meta",
  #{ required_previews: #[AgentDefinitionOptInKeys.agent_endpoint_v1_preview] }
)
@discriminator("type")
model AgentEndpointAuthorizationScheme {
  type: AgentEndpointAuthorizationSchemeType;
}

@extension(
  "x-ms-foundry-meta",
  #{ required_previews: #[AgentDefinitionOptInKeys.agent_endpoint_v1_preview] }
)
model EntraAuthorizationScheme extends AgentEndpointAuthorizationScheme {
  type: AgentEndpointAuthorizationSchemeType.Entra;
  isolation_key_source: IsolationKeySource;
}

@extension(
  "x-ms-foundry-meta",
  #{ required_previews: #[AgentDefinitionOptInKeys.agent_endpoint_v1_preview] }
)
model BotServiceAuthorizationScheme extends AgentEndpointAuthorizationScheme {
  type: AgentEndpointAuthorizationSchemeType.BotService;
}

@extension(
  "x-ms-foundry-meta",
  #{ required_previews: #[AgentDefinitionOptInKeys.agent_endpoint_v1_preview] }
)
model BotServiceRbacAuthorizationScheme
  extends AgentEndpointAuthorizationScheme {
  type: AgentEndpointAuthorizationSchemeType.BotServiceRbac;
}

@discriminator("kind")
@extension(
  "x-ms-foundry-meta",
  #{ required_previews: #[AgentDefinitionOptInKeys.agent_endpoint_v1_preview] }
)
model IsolationKeySource {
  kind: IsolationKeySourceKind;
}

@extension(
  "x-ms-foundry-meta",
  #{ required_previews: #[AgentDefinitionOptInKeys.agent_endpoint_v1_preview] }
)
model EntraIsolationKeySource extends IsolationKeySource {
  kind: IsolationKeySourceKind.Entra;
}

@extension(
  "x-ms-foundry-meta",
  #{ required_previews: #[AgentDefinitionOptInKeys.agent_endpoint_v1_preview] }
)
model HeaderIsolationKeySource extends IsolationKeySource {
  kind: IsolationKeySourceKind.Header;

  @doc("The user isolation key header value")
  user_isolation_key: string;

  @doc("The chat isolation key header value")
  chat_isolation_key: string;
}

@extension(
  "x-ms-foundry-meta",
  #{ required_previews: #[AgentDefinitionOptInKeys.agent_endpoint_v1_preview] }
)
union AgentEndpointAuthorizationSchemeType {
  string,
  Entra: "Entra",
  BotService: "BotService",
  BotServiceRbac: "BotServiceRbac",
}

@extension(
  "x-ms-foundry-meta",
  #{ required_previews: #[AgentDefinitionOptInKeys.agent_endpoint_v1_preview] }
)
union IsolationKeySourceKind {
  string,
  Entra: "Entra",
  Header: "Header",
}

@extension(
  "x-ms-foundry-meta",
  #{ required_previews: #[AgentDefinitionOptInKeys.agent_endpoint_v1_preview] }
)
model AgentEndpoint {
  @doc("The version selector of the agent endpoint determines how traffic is routed to different versions of the agent.")
  version_selector?: VersionSelector;

  @doc("The protocols that the agent supports")
  protocols?: AgentEndpointProtocol[];

  @doc("The authorization schemes supported by the agent endpoint")
  authorization_schemes?: AgentEndpointAuthorizationScheme[];
}

@extension(
  "x-ms-foundry-meta",
  #{ required_previews: #[AgentDefinitionOptInKeys.agent_endpoint_v1_preview] }
)
model AgentIdentity {
  @doc("The principal ID of the agent instance")
  principal_id: string;

  @doc("The client ID of the agent instance. Also referred to as the instance ID")
  client_id: string;
}

@extension(
  "x-ms-foundry-meta",
  #{ required_previews: #[AgentDefinitionOptInKeys.agent_endpoint_v1_preview] }
)
union AgentBlueprintReferenceType {
  string,
  ManagedAgentIdentityBlueprint: "ManagedAgentIdentityBlueprint",
}

@extension(
  "x-ms-foundry-meta",
  #{ required_previews: #[AgentDefinitionOptInKeys.agent_endpoint_v1_preview] }
)
@discriminator("type")
model AgentBlueprintReference {
  type: AgentBlueprintReferenceType;
}

@extension(
  "x-ms-foundry-meta",
  #{ required_previews: #[AgentDefinitionOptInKeys.agent_endpoint_v1_preview] }
)
model ManagedAgentIdentityBlueprintReference extends AgentBlueprintReference {
  type: AgentBlueprintReferenceType.ManagedAgentIdentityBlueprint;

  @doc("The ID of the managed blueprint")
  blueprint_id: string;
}

/** A skill example string with a maximum length of 1024 characters. */
@extension(
  "x-ms-foundry-meta",
  #{ required_previews: #[AgentDefinitionOptInKeys.agent_endpoint_v1_preview] }
)
@maxLength(1024)
scalar AgentCardSkillExample extends string;

@extension(
  "x-ms-foundry-meta",
  #{ required_previews: #[AgentDefinitionOptInKeys.agent_endpoint_v1_preview] }
)
@maxLength(32)
scalar AgentCardSkillTag extends string;

@extension(
  "x-ms-foundry-meta",
  #{ required_previews: #[AgentDefinitionOptInKeys.agent_endpoint_v1_preview] }
)
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

@extension(
  "x-ms-foundry-meta",
  #{ required_previews: #[AgentDefinitionOptInKeys.agent_endpoint_v1_preview] }
)
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
  skills: AgentCardSkill[];
}

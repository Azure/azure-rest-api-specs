import "../openai-responses/models.tsp";

using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Azure.AI.Projects;

const AllConditionalAgentDefinitionPreviews = #{
  conditional_previews: #[
    FoundryFeaturesOptInKeys.hosted_agents_v1_preview,
    FoundryFeaturesOptInKeys.container_agents_v1_preview,
    FoundryFeaturesOptInKeys.workflow_agents_v1_preview
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
}

model UpdateAgentRequest {
  ...CreateAgentVersionRequest;
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
}

union AgentProtocol {
  string,
  activity_protocol: "activity_protocol",
  responses: "responses",
}

union AgentKind {
  string,
  prompt: "prompt",
  hosted: "hosted",
  container_app: "container_app",
  workflow: "workflow",
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
  #{ required_previews: #[FoundryFeaturesOptInKeys.workflow_agents_v1_preview] }
)
model WorkflowAgentDefinition extends AgentDefinition {
  kind: AgentKind.workflow;

  @doc("The CSDL YAML definition of the workflow.")
  workflow?: string;
}

@doc("The hosted agent definition.")
@extension(
  "x-ms-foundry-meta",
  #{ required_previews: #[FoundryFeaturesOptInKeys.hosted_agents_v1_preview] }
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
    required_previews: #[FoundryFeaturesOptInKeys.container_agents_v1_preview],
  }
)
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
    required_previews: #[FoundryFeaturesOptInKeys.container_agents_v1_preview],
  }
)
union ContainerLogKind {
  /** Console logs from the container. */
  console: "console",

  /** System logs from the container. */
  system: "system",
}

import "@typespec/http";
import "@typespec/openapi";
import "@azure-tools/typespec-azure-core";

import "../openai-responses/models.tsp";

using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Azure.AI.Projects;

const AllConditionalAgentDefinitionPreviews = #{
  conditional_previews: #[
    FoundryPreviewOptInKeys.hosted_agents_v1,
    FoundryPreviewOptInKeys.container_agents_v1,
    FoundryPreviewOptInKeys.workflow_agents_v1,
    FoundryPreviewOptInKeys.memory_stores_v1
  ],
};

const MemoryStoreConditionalPreviews = #{
  conditional_previews: #[FoundryPreviewOptInKeys.memory_stores_v1],
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

@extension("x-ms-foundry-meta", MemoryStoreConditionalPreviews)
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

@extension("x-ms-foundry-meta", MemoryStoreConditionalPreviews)
model UpdateAgentRequest {
  ...CreateAgentVersionRequest;
}

model AgentObject {
  @doc("The object type, which is always 'agent'.")
  object: "agent";

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
  object: "agent.version";

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
  #{ required_previews: #[FoundryPreviewOptInKeys.workflow_agents_v1] }
)
model WorkflowAgentDefinition extends AgentDefinition {
  kind: AgentKind.workflow;

  @doc("The CSDL YAML definition of the workflow.")
  workflow?: string;
}

@doc("The hosted agent definition.")
@discriminator("kind")
@extension(
  "x-ms-foundry-meta",
  #{ required_previews: #[FoundryPreviewOptInKeys.hosted_agents_v1] }
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
  #{ required_previews: #[FoundryPreviewOptInKeys.container_agents_v1] }
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
  object: "agent.deleted";

  @doc("The name of the agent.")
  name: string;

  @doc("Whether the agent was successfully deleted.")
  deleted: boolean;
}

@doc("A deleted agent version Object")
model DeleteAgentVersionResponse {
  @doc("The object type. Always 'agent.deleted'.")
  object: "agent.version.deleted";

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
  default_value?: Record<unknown>;

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

@doc("The details of the container of a specific version of an agent.")
@extension(
  "x-ms-foundry-meta",
  #{ required_previews: #[FoundryPreviewOptInKeys.container_agents_v1] }
)
model AgentContainerObject {
  @doc("The object type, which is always 'agent.container'.")
  @visibility(Lifecycle.Read)
  object: "agent.container";

  @doc("The identifier of the container.")
  @visibility(Lifecycle.Read)
  id?: string;

  @doc("The status of the container of a specific version of an agent.")
  @visibility(Lifecycle.Read)
  status: AgentContainerStatus;

  @doc("The maximum number of replicas for the container. Default is 1.")
  @example(10)
  max_replicas?: int32;

  @doc("The minimum number of replicas for the container. Default is 1.")
  @example(1)
  min_replicas?: int32;

  @doc("The error message if the container failed to operate, if any.")
  @visibility(Lifecycle.Read)
  error_message?: string;

  @doc("The creation time of the container.")
  @visibility(Lifecycle.Read)
  created_at: utcDateTime;

  @doc("The last update time of the container.")
  @visibility(Lifecycle.Read)
  updated_at: utcDateTime;

  @doc("The detailed container information.")
  @visibility(Lifecycle.Read)
  container?: ContainerDetails;
}

@doc("Detailed information about the container.")
@extension(
  "x-ms-foundry-meta",
  #{ required_previews: #[FoundryPreviewOptInKeys.container_agents_v1] }
)
model ContainerDetails {
  @doc("The provisioning state of the container.")
  provisioning_state: string;

  @doc("The provisioning error of the container, if any.")
  provisioning_error?: string;

  @doc("The state of the container.")
  state: string;

  @doc("The health state of the container.")
  health_state: string;

  @doc("The list of replicas in the container.")
  replicas: ContainerReplica[];

  @doc("The last update time of the container.")
  updated_on: utcDateTime;
}

@doc("Information about a container replica.")
@extension(
  "x-ms-foundry-meta",
  #{ required_previews: #[FoundryPreviewOptInKeys.container_agents_v1] }
)
model ContainerReplica {
  @doc("The name of the replica.")
  name: string;

  @doc("The state of the replica.")
  state: string;

  @doc("The container state of the replica.")
  container_state: string;
}

@doc("Status of the container of a specific version of an agent.")
@extension(
  "x-ms-foundry-meta",
  #{ required_previews: #[FoundryPreviewOptInKeys.container_agents_v1] }
)
union AgentContainerStatus {
  @doc("The container is starting.")
  Starting: "Starting",

  @doc("The container is running.")
  Running: "Running",

  @doc("The container is stopping.")
  Stopping: "Stopping",

  @doc("The container is stopped.")
  Stopped: "Stopped",

  @doc("The container has failed.")
  Failed: "Failed",

  @doc("The container is deleting.")
  Deleting: "Deleting",

  @doc("The container is deleted.")
  Deleted: "Deleted",

  @doc("The container is updating.")
  Updating: "Updating",
}

@doc("The container operation for a specific version of an agent.")
@extension(
  "x-ms-foundry-meta",
  #{ required_previews: #[FoundryPreviewOptInKeys.container_agents_v1] }
)
model AgentContainerOperationObject {
  @doc("The ID of the container operation. This id is unique identifier across the system.")
  id: string;

  @doc("The ID of the agent.")
  agent_id: string;

  @doc("The ID of the agent version.")
  agent_version_id: string;

  @doc("The status of the container operation.")
  status: AgentContainerOperationStatus;

  @doc("The error of the container operation, if any.")
  error?: AgentContainerOperationError;

  @doc("The container of the specific version of an agent.")
  container?: AgentContainerObject;
}

@doc("The error details of the container operation, if any.")
@extension(
  "x-ms-foundry-meta",
  #{ required_previews: #[FoundryPreviewOptInKeys.container_agents_v1] }
)
model AgentContainerOperationError {
  @doc("The error code of the container operation, if any.")
  code: string;

  @doc("The error type of the container operation, if any.")
  type: string;

  @doc("The error message of the container operation, if any.")
  message: string;
}

@doc("Status of the container operation for a specific version of an agent.")
@extension(
  "x-ms-foundry-meta",
  #{ required_previews: #[FoundryPreviewOptInKeys.container_agents_v1] }
)
union AgentContainerOperationStatus {
  @doc("The container operation is not started.")
  NotStarted: "NotStarted",

  @doc("The container operation is in progress.")
  InProgress: "InProgress",

  @doc("The container operation has succeeded.")
  Succeeded: "Succeeded",

  @doc("The container operation has failed.")
  Failed: "Failed",
}

@extension(
  "x-ms-foundry-meta",
  #{ required_previews: #[FoundryPreviewOptInKeys.container_agents_v1] }
)
model AcceptedAgentContainerOperation {
  @statusCode
  code: 202;

  @header("Operation-Location")
  location: url;

  @body
  body: AgentContainerOperationObject;
}

/** The type of logs to stream from a container. */
@extension(
  "x-ms-foundry-meta",
  #{ required_previews: #[FoundryPreviewOptInKeys.container_agents_v1] }
)
union ContainerLogKind {
  /** Console logs from the container. */
  console: "console",

  /** System logs from the container. */
  system: "system",
}

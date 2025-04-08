import "@typespec/versioning";
import "./messages/messages.tsp";
import "./tools/tools.tsp";
import "./model-options/openai.tsp";
import "./model-options/azure.tsp";
import "../main.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using TypeSpec.Versioning;

namespace Azure.AI.Projects;

@doc("A JSON-compatible type that can be a primitive, object, or array.")
model JSONAny {
  @doc("A string value, if present.")
  stringValue?: string;

  @doc("A 64-bit integer value, if present.")
  intValue?: int64;

  @doc("A floating-point (double precision) value, if present.")
  floatValue?: float64;

  @doc("A boolean value, if present.")
  boolValue?: boolean;

  @doc("Indicates this represents a JSON null if set to true.")
  nullValue?: boolean;

  @doc("A JSON array, if present, expressed as an array of JSONAny elements.")
  arrayValue?: JSONAny[];

  @doc("A JSON object, if present, expressed as a dictionary from string to JSONAny.")
  objectValue?: Record<JSONAny>;
}

@doc("Options used when completing a run.")
model AgentConfigurationOptions {
  @doc("The model definition for this agent. This is optional (not needed) when doing a run using persistent agent.")
  agentModel?: AgentModel;

  @doc("Instructions provided to guide how this agent operates.")
  instructions?: string;

  @doc("A list of tool definitions available to the agent.")
  tools?: AgentToolDefinition[];

  @doc("How the agent should choose among provided tools.")
  toolChoice?: ToolChoiceBehavior;
}

@doc("Options used when creating or updating an agent.")
model AgentCreationOptions {
  @doc("The name of the agent; used for display purposes and sent to the LLM to identify the agent.")
  name: string;

  @doc("Configuation options for the agent.")
  configurationOptions: AgentConfigurationOptions;
}

@Rest.resource("agents")
@doc("Represents an AI agent with configuration, instructions, and tool access.")
model Agent {
  @key
  @doc("A unique identifier for the agent.")
  @visibility(Lifecycle.Read)
  agentId: string;

  @doc("A description of the agent; used for display purposes and to describe the agent.")
  description?: string;

  @doc("Arbitrary metadata associated with this agent.")
  metadata?: Record<string>;

  @doc("Options that were used to create this agent.")
  creationOptions: AgentCreationOptions;
}

@discriminator("provider")
@doc("Represents the model or provider-specific data used by the agent.")
model AgentModel {
  @doc("A unique model or deployment ID for this agent model.")
  id: string;

  @doc("The name of the provider for this model (e.g., 'openai').")
  provider?: string;

  @doc("An endpoint where the provider can be reached, if applicable.")
  endpoint?: string;

  @doc("Provider-specific configuration and options (JSON-like structure).")
  options?: JSONAny;
}

@discriminator("type")
@doc("The base behavior for how an agent chooses among available tools.")
model ToolChoiceBehavior {
  @doc("The kind of tool-choice strategy.")
  type: string;
}

@doc("Behavior specifying an automatic choice among the given tools.")
model AutoToolChoiceBehavior extends ToolChoiceBehavior {
  @doc("Indicates this behavior is 'auto'.")
  type: "auto";

  @doc("The tool names from which the agent can automatically choose.")
  toolNames: string[];
}

@doc("Behavior specifying that the agent must always use the listed tools.")
model RequiredToolChoiceBehavior extends ToolChoiceBehavior {
  @doc("Indicates this behavior is 'required'.")
  type: "required";

  @doc("The tool names that the agent must use.")
  toolNames: string[];
}

@doc("Behavior specifying that no tools may be chosen.")
model NoneToolChoiceBehavior extends ToolChoiceBehavior {
  @doc("Indicates this behavior is 'none'.")
  type: "none";
}

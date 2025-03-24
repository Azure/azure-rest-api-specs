import "@typespec/versioning";
import "./messages/messages.tsp";
import "./tools/tools.tsp";
import "./model-options/openai.tsp";
import "./model-options/azure.tsp";
import "../main.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using TypeSpec.Versioning;

namespace Azure.AI.Projects.Agents;

/**
 * A JSON-compatible type that can be a primitive, object, or array.
 * By using optional fields, this model can represent many forms of JSON data
 * without creating a strict, self-referential union.
 */
@doc("A JSON-compatible type that can be a primitive, object, or array.")
model JSONAny {
  /**
   * A string value, if present.
   */
  @doc("A string value, if present.")
  stringValue?: string;

  /**
   * A 64-bit integer value, if present.
   */
  @doc("A 64-bit integer value, if present.")
  intValue?: int64;

  /**
   * A floating-point (double precision) value, if present.
   */
  @doc("A floating-point (double precision) value, if present.")
  floatValue?: float64;

  /**
   * A boolean value, if present.
   */
  @doc("A boolean value, if present.")
  boolValue?: boolean;

  /**
   * Indicates this represents a JSON null if set to true.
   */
  @doc("Indicates this represents a JSON null if set to true.")
  nullValue?: boolean;

  /**
   * A JSON array, if present, expressed as an array of JSONAny elements.
   */
  @doc("A JSON array, if present, expressed as an array of JSONAny elements.")
  arrayValue?: JSONAny[];

  /**
   * A JSON object, if present, expressed as a dictionary from string to JSONAny.
   */
  @doc("A JSON object, if present, expressed as a dictionary from string to JSONAny.")
  objectValue?: Record<JSONAny>;
}

/**
 * Properties shared by "Agent" and "AgentOptions".
 */
alias AgentCompletionProperties = {
  /**
   * The name of the agent; used for display purposes and sent to the LLM to identify the agent.
   */
  @doc("The name of the agent; used for display purposes and sent to the LLM to identify the agent.")
  name?: string;

  /**
   * The model definition for this agent.
   */
  @doc("The model definition for this agent.")
  agentModel: AgentModel;

  /**
   * Instructions (e.g., system messages) that are provided to guide how this agent operates.
   */
  @doc("Instructions provided to guide how this agent operates.")
  instructions?: ChatMessage[];

  // TODO: Add when supported
  //closingInstructions?: ChatMessage[];

  /**
   * A list of tool definitions available to the agent.
   */
  @doc("A list of tool definitions available to the agent.")
  tools?: AgentToolDefinition[];

  /**
   * How the agent should choose among provided tools.
   */
  @doc("How the agent should choose among provided tools.")
  toolChoice?: ToolChoiceBehavior;
};

/**
 * An agent resource containing properties for AI project agents.
 */
@Rest.resource("agents")
@doc("Represents an AI agent with configuration, instructions, and tool access.")
model Agent {
  /**
   * A unique identifier for the agent.
   */
  @key
  @visibility(Lifecycle.Read)
  agentId: string;

  /**
   * A description of the agent; used for display purposes and
   * sent to the LLM to describe the agent.
   */
  @doc("A description of the agent; used for display purposes and to describe the agent.")
  description?: string;

  /**
   * Arbitrary metadata associated with this agent.
   */
  @doc("Arbitrary metadata associated with this agent.")
  metadata?: Record<string>;

  ...AgentCompletionProperties;
}

/**
 * Options used when creating or updating an Agent.
 */
@doc("Options used when creating or updating an Agent.")
model AgentOptions {
  ...AgentCompletionProperties;
}

/**
 * Represents the model or provider-specific data used by the agent.
 */
@discriminator("provider")
@doc("Represents the model or provider-specific data used by the agent.")
model AgentModel {
  /**
   * A unique model or deployment ID for this agent model.
   */
  @doc("A unique model or deployment ID for this agent model.")
  id: string;

  /**
   * The name of the provider for this model (e.g., 'openai').
   */
  @doc("The name of the provider for this model (e.g., 'openai').")
  provider?: string;

  /**
   * An endpoint where the provider can be reached, if applicable.
   */
  @doc("An endpoint where the provider can be reached, if applicable.")
  endpoint?: string;

  /**
   * Provider-specific configuration and options (JSON-like structure).
   */
  @doc("Provider-specific configuration and options (JSON-like structure).")
  options?: JSONAny;
}

/**
 * The base behavior for how an agent chooses among available tools.
 */
@discriminator("type")
@doc("The base behavior for how an agent chooses among available tools.")
model ToolChoiceBehavior {
  /**
   * The kind of tool-choice strategy.
   */
  @doc("The kind of tool-choice strategy.")
  type: string;
}

/**
 * Behavior specifying an automatic choice among the given tools.
 */
@doc("Behavior specifying an automatic choice among the given tools.")
model AutoToolChoiceBehavior extends ToolChoiceBehavior {
  @doc("Indicates this behavior is 'auto'.")
  type: "auto";

  /**
   * The tool names from which the agent can automatically choose.
   */
  @doc("The tool names from which the agent can automatically choose.")
  toolNames: string[];
}

/**
 * Behavior specifying that the agent must always use the listed tools.
 */
@doc("Behavior specifying that the agent must always use the listed tools.")
model RequiredToolChoiceBehavior extends ToolChoiceBehavior {
  @doc("Indicates this behavior is 'required'.")
  type: "required";

  /**
   * The tool names that the agent must use.
   */
  @doc("The tool names that the agent must use.")
  toolNames: string[];
}

/**
 * Behavior specifying that no tools may be chosen.
 */
@doc("Behavior specifying that no tools may be chosen.")
model NoneToolChoiceBehavior extends ToolChoiceBehavior {
  @doc("Indicates this behavior is 'none'.")
  type: "none";
}

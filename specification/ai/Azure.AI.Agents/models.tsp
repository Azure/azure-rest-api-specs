import "@typespec/versioning";
import "./common/models.tsp";
import "./tools/models.tsp";
import "./tools/tool_resources.tsp";
import "./main.tsp";

using TypeSpec.Http;
using TypeSpec.Versioning;

namespace Azure.AI.Agents;

@doc("Represents an agent that can call the model and use tools.")
@added(Versions.v2025_05_01)
model Agent {
  @doc("The identifier, which can be referenced in API endpoints.")
  id: string;

  @doc("The object type, which is always assistant.")
  object: "assistant";

  @encodedName("application/json", "created_at")
  @encode(DateTimeKnownEncoding.unixTimestamp, int32)
  @doc("The Unix timestamp, in seconds, representing when this object was created.")
  createdAt: utcDateTime;

  #suppress "@azure-tools/typespec-azure-core/no-nullable" "OpenAI uses explicit nullability, distinct from optionality"
  @doc("The name of the agent.")
  name: string | null;

  #suppress "@azure-tools/typespec-azure-core/no-nullable" "OpenAI uses explicit nullability, distinct from optionality"
  @doc("The description of the agent.")
  description: string | null;

  @doc("The ID of the model to use.")
  `model`: string;

  #suppress "@azure-tools/typespec-azure-core/no-nullable" "OpenAI uses explicit nullability, distinct from optionality"
  @doc("The system instructions for the agent to use.")
  instructions: string | null;

  @doc("The collection of tools enabled for the agent.")
  tools: ToolDefinition[] = #[];

  /**
   * A set of resources that are used by the agent's tools. The resources are specific to the type of tool. For example, the `code_interpreter`
   * tool requires a list of file IDs, while the `file_search` tool requires a list of vector store IDs.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "OpenAI uses explicit nullability, distinct from optionality"
  @encodedName("application/json", "tool_resources")
  toolResources: ToolResources | null;

  /**
   * What sampling temperature to use, between 0 and 2. Higher values like 0.8 will make the output more random,
   * while lower values like 0.2 will make it more focused and deterministic.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "OpenAI uses explicit nullability, distinct from optionality"
  @minValue(0)
  @maxValue(2)
  temperature: float32 | null = 1;

  /**
   * An alternative to sampling with temperature, called nucleus sampling, where the model considers the results of the tokens with top_p probability mass.
   * So 0.1 means only the tokens comprising the top 10% probability mass are considered.
   *
   * We generally recommend altering this or temperature but not both.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "OpenAI uses explicit nullability, distinct from optionality"
  @minValue(0)
  @maxValue(1)
  @encodedName("application/json", "top_p")
  topP: float32 | null = 1;

  /** The response format of the tool calls used by this agent. */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "OpenAI uses explicit nullability, distinct from optionality"
  @encodedName("application/json", "response_format")
  responseFormat?: AgentsResponseFormatOption | null;

  ...RequiredNullableMetadata;
}

@doc("The request details to use when creating a new agent.")
@added(Versions.v2025_05_01)
model CreateAgentOptions {
  @doc("The ID of the model to use.")
  `model`: string;

  #suppress "@azure-tools/typespec-azure-core/no-nullable" "OpenAI uses explicit nullability, distinct from optionality"
  @doc("The name of the new agent.")
  name?: string | null;

  #suppress "@azure-tools/typespec-azure-core/no-nullable" "OpenAI uses explicit nullability, distinct from optionality"
  @doc("The description of the new agent.")
  description?: string | null;

  #suppress "@azure-tools/typespec-azure-core/no-nullable" "OpenAI uses explicit nullability, distinct from optionality"
  @doc("The system instructions for the new agent to use.")
  instructions?: string | null;

  #suppress "@azure-tools/typespec-azure-core/no-nullable" "OpenAI uses explicit nullability, distinct from optionality"
  @doc("The collection of tools to enable for the new agent.")
  tools?: ToolDefinition[] = #[];

  /**
   * A set of resources that are used by the agent's tools. The resources are specific to the type of tool. For example, the `code_interpreter`
   * tool requires a list of file IDs, while the `file_search` tool requires a list of vector store IDs.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "OpenAI uses explicit nullability, distinct from optionality"
  @encodedName("application/json", "tool_resources")
  toolResources?: ToolResources | null;

  /**
   * What sampling temperature to use, between 0 and 2. Higher values like 0.8 will make the output more random,
   * while lower values like 0.2 will make it more focused and deterministic.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "OpenAI uses explicit nullability, distinct from optionality"
  @minValue(0)
  @maxValue(2)
  temperature?: float32 | null = 1;

  /**
   * An alternative to sampling with temperature, called nucleus sampling, where the model considers the results of the tokens with top_p probability mass.
   * So 0.1 means only the tokens comprising the top 10% probability mass are considered.
   *
   * We generally recommend altering this or temperature but not both.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "OpenAI uses explicit nullability, distinct from optionality"
  @minValue(0)
  @maxValue(1)
  @encodedName("application/json", "top_p")
  topP?: float32 | null = 1;

  /** The response format of the tool calls used by this agent. */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "OpenAI uses explicit nullability, distinct from optionality"
  @encodedName("application/json", "response_format")
  responseFormat?: AgentsResponseFormatOption | null;

  ...OptionalNullableMetadata;
}

@doc("The request details to use when modifying an existing agent.")
@added(Versions.v2025_05_01)
model UpdateAgentOptions {
  @path
  @doc("The ID of the agent to modify.")
  assistantId: string;

  @doc("The ID of the model to use.")
  `model`?: string;

  #suppress "@azure-tools/typespec-azure-core/no-nullable" "OpenAI uses explicit nullability, distinct from optionality"
  @doc("The modified name for the agent to use.")
  name?: string | null;

  #suppress "@azure-tools/typespec-azure-core/no-nullable" "OpenAI uses explicit nullability, distinct from optionality"
  @doc("The modified description for the agent to use.")
  description?: string | null;

  #suppress "@azure-tools/typespec-azure-core/no-nullable" "OpenAI uses explicit nullability, distinct from optionality"
  @doc("The modified system instructions for the new agent to use.")
  instructions?: string | null;

  @doc("The modified collection of tools to enable for the agent.")
  tools?: ToolDefinition[] = #[];

  /**
   * A set of resources that are used by the agent's tools. The resources are specific to the type of tool. For example,
   * the `code_interpreter` tool requires a list of file IDs, while the `file_search` tool requires a list of vector store IDs.
   */
  @encodedName("application/json", "tool_resources")
  toolResources?: ToolResources;

  /**
   * What sampling temperature to use, between 0 and 2. Higher values like 0.8 will make the output more random,
   * while lower values like 0.2 will make it more focused and deterministic.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "OpenAI uses explicit nullability, distinct from optionality"
  @minValue(0)
  @maxValue(2)
  temperature?: float32 | null = 1;

  /**
   * An alternative to sampling with temperature, called nucleus sampling, where the model considers the results of the tokens with top_p probability mass.
   * So 0.1 means only the tokens comprising the top 10% probability mass are considered.
   *
   * We generally recommend altering this or temperature but not both.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "OpenAI uses explicit nullability, distinct from optionality"
  @minValue(0)
  @maxValue(1)
  @encodedName("application/json", "top_p")
  topP?: float32 | null = 1;

  /** The response format of the tool calls used by this agent. */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "OpenAI uses explicit nullability, distinct from optionality"
  @encodedName("application/json", "response_format")
  responseFormat?: AgentsResponseFormatOption | null;

  ...OptionalNullableMetadata;
}

@doc("The status of an agent deletion operation.")
@added(Versions.v2025_05_01)
model AgentDeletionStatus {
  ...DeletionStatus;

  @doc("The object type, which is always 'assistant.deleted'.")
  object: "assistant.deleted";
}

@doc("The request details to use when retrieving an agent.")
@added(Versions.v2025_05_01)
model GetAgentOptions {
  @doc("Identifier of the agent.")
  @path
  assistantId: string;
}

@doc("The request details to use when deleting an agent.")
@added(Versions.v2025_05_01)
model DeleteAgentOptions {
  @doc("Identifier of the agent.")
  @path
  assistantId: string;
}

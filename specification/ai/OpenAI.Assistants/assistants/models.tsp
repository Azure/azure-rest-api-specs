import "@typespec/versioning";

import "../common/models.tsp";
import "../tools/models.tsp";
import "../tools/tool_resources.tsp";
import "../main.tsp";

namespace Azure.AI.OpenAI.Assistants;

using TypeSpec.Http;
using TypeSpec.Versioning;

@doc("Represents an assistant that can call the model and use tools.")
@added(ServiceApiVersions.v2024_02_15_preview)
model Assistant {
  @doc("The identifier, which can be referenced in API endpoints.")
  id: string;

  @doc("The object type, which is always assistant.")
  object: "assistant";

  @encodedName("application/json", "created_at")
  @encode(DateTimeKnownEncoding.unixTimestamp, int32)
  @doc("The Unix timestamp, in seconds, representing when this object was created.")
  createdAt: utcDateTime;

  #suppress "@azure-tools/typespec-azure-core/no-nullable" "OpenAI uses explicit nullability, distinct from optionality"
  @doc("The name of the assistant.")
  name: string | null;

  #suppress "@azure-tools/typespec-azure-core/no-nullable" "OpenAI uses explicit nullability, distinct from optionality"
  @doc("The description of the assistant.")
  description: string | null;

  @doc("The ID of the model to use.")
  `model`: string;

  #suppress "@azure-tools/typespec-azure-core/no-nullable" "OpenAI uses explicit nullability, distinct from optionality"
  @doc("The system instructions for the assistant to use.")
  instructions: string | null;

  @doc("The collection of tools enabled for the assistant.")
  tools: ToolDefinition[] = [];

  /**
   * A set of resources that are used by the assistant's tools. The resources are specific to the type of tool. For example, the `code_interpreter`
   * tool requires a list of file IDs, while the `file_search` tool requires a list of vector store IDs.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "OpenAI uses explicit nullability, distinct from optionality"
  @encodedName("application/json", "tool_resources")
  @added(ServiceApiVersions.v2024_05_01_preview)
  toolResources: ToolResources | null;

  /**
   * What sampling temperature to use, between 0 and 2. Higher values like 0.8 will make the output more random,
   * while lower values like 0.2 will make it more focused and deterministic.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "OpenAI uses explicit nullability, distinct from optionality"
  @added(ServiceApiVersions.v2024_05_01_preview)
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
  @added(ServiceApiVersions.v2024_05_01_preview)
  @minValue(0)
  @maxValue(1)
  @encodedName("application/json", "top_p")
  topP: float32 | null = 1;

  /** The response format of the tool calls used by this assistant. */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "OpenAI uses explicit nullability, distinct from optionality"
  @encodedName("application/json", "response_format")
  @added(ServiceApiVersions.v2024_05_01_preview)
  responseFormat?: AssistantsApiResponseFormatOption | null;

  ...RequiredNullableMetadata;
}

@doc("The request details to use when creating a new assistant.")
@added(ServiceApiVersions.v2024_02_15_preview)
model AssistantCreationOptions {
  @doc("The ID of the model to use.")
  `model`: string;

  #suppress "@azure-tools/typespec-azure-core/no-nullable" "OpenAI uses explicit nullability, distinct from optionality"
  @doc("The name of the new assistant.")
  name?: string | null;

  #suppress "@azure-tools/typespec-azure-core/no-nullable" "OpenAI uses explicit nullability, distinct from optionality"
  @doc("The description of the new assistant.")
  description?: string | null;

  #suppress "@azure-tools/typespec-azure-core/no-nullable" "OpenAI uses explicit nullability, distinct from optionality"
  @doc("The system instructions for the new assistant to use.")
  instructions?: string | null;

  #suppress "@azure-tools/typespec-azure-core/no-nullable" "OpenAI uses explicit nullability, distinct from optionality"
  @doc("The collection of tools to enable for the new assistant.")
  tools?: ToolDefinition[] = [];

  /**
   * A set of resources that are used by the assistant's tools. The resources are specific to the type of tool. For example, the `code_interpreter`
   * tool requires a list of file IDs, while the `file_search` tool requires a list of vector store IDs.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "OpenAI uses explicit nullability, distinct from optionality"
  @encodedName("application/json", "tool_resources")
  @added(ServiceApiVersions.v2024_05_01_preview)
  toolResources?: CreateToolResourcesOptions | null;

  /**
   * What sampling temperature to use, between 0 and 2. Higher values like 0.8 will make the output more random,
   * while lower values like 0.2 will make it more focused and deterministic.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "OpenAI uses explicit nullability, distinct from optionality"
  @added(ServiceApiVersions.v2024_05_01_preview)
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
  @added(ServiceApiVersions.v2024_05_01_preview)
  @minValue(0)
  @maxValue(1)
  @encodedName("application/json", "top_p")
  topP: float32 | null = 1;

  /** The response format of the tool calls used by this assistant. */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "OpenAI uses explicit nullability, distinct from optionality"
  @encodedName("application/json", "response_format")
  @added(ServiceApiVersions.v2024_05_01_preview)
  responseFormat?: AssistantsApiResponseFormatOption | null;

  ...OptionalNullableMetadata;
}

@doc("The request details to use when modifying an existing assistant.")
@added(ServiceApiVersions.v2024_02_15_preview)
model UpdateAssistantOptions {
  @path
  @doc("The ID of the assistant to modify.")
  assistantId: string;

  @doc("The ID of the model to use.")
  `model`?: string;

  #suppress "@azure-tools/typespec-azure-core/no-nullable" "OpenAI uses explicit nullability, distinct from optionality"
  @doc("The modified name for the assistant to use.")
  name?: string | null;

  #suppress "@azure-tools/typespec-azure-core/no-nullable" "OpenAI uses explicit nullability, distinct from optionality"
  @doc("The modified description for the assistant to use.")
  description?: string | null;

  #suppress "@azure-tools/typespec-azure-core/no-nullable" "OpenAI uses explicit nullability, distinct from optionality"
  @doc("The modified system instructions for the new assistant to use.")
  instructions?: string | null;

  @doc("The modified collection of tools to enable for the assistant.")
  tools?: ToolDefinition[] = [];

  /**
   * A set of resources that are used by the assistant's tools. The resources are specific to the type of tool. For example,
   * the `code_interpreter` tool requires a list of file IDs, while the `file_search` tool requires a list of vector store IDs.
   */
  @encodedName("application/json", "tool_resources")
  @added(ServiceApiVersions.v2024_05_01_preview)
  toolResources?: UpdateToolResourcesOptions;

  /**
   * What sampling temperature to use, between 0 and 2. Higher values like 0.8 will make the output more random,
   * while lower values like 0.2 will make it more focused and deterministic.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "OpenAI uses explicit nullability, distinct from optionality"
  @added(ServiceApiVersions.v2024_05_01_preview)
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
  @added(ServiceApiVersions.v2024_05_01_preview)
  @minValue(0)
  @maxValue(1)
  @encodedName("application/json", "top_p")
  topP?: float32 | null = 1;

  /** The response format of the tool calls used by this assistant. */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "OpenAI uses explicit nullability, distinct from optionality"
  @encodedName("application/json", "response_format")
  @added(ServiceApiVersions.v2024_05_01_preview)
  responseFormat?: AssistantsApiResponseFormatOption | null;

  ...OptionalNullableMetadata;
}

@doc("The status of an assistant deletion operation.")
@added(ServiceApiVersions.v2024_02_15_preview)
model AssistantDeletionStatus {
  ...DeletionStatus;

  @doc("The object type, which is always 'assistant.deleted'.")
  object: "assistant.deleted";
}

import "@typespec/rest";
import "@azure-tools/typespec-autorest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@typespec/openapi";
import "@typespec/versioning";
import "../common.tsp";

using TypeSpec.OpenAPI;
using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.Core.Traits;

namespace Azure.AI.Client.Agents;

@doc("Represents an assistant that can call the model and use tools.")
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

  /** The response format of the tool calls used by this assistant. */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "OpenAI uses explicit nullability, distinct from optionality"
  @encodedName("application/json", "response_format")
  responseFormat?: AssistantsApiResponseFormatOption | null;

  ...RequiredNullableMetadata;
}

@doc("The request details to use when creating a new assistant.")
model CreateAssistantOptions {
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

  /** The response format of the tool calls used by this assistant. */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "OpenAI uses explicit nullability, distinct from optionality"
  @encodedName("application/json", "response_format")
  responseFormat?: AssistantsApiResponseFormatOption | null;

  ...OptionalNullableMetadata;
}

/**
 * Specifies the format that the model must output. Compatible with GPT-4 Turbo and all GPT-3.5 Turbo models since `gpt-3.5-turbo-1106`.
 *
 * Setting to `{ "type": "json_object" }` enables JSON mode, which guarantees the message the model generates is valid JSON.
 *
 * **Important:** when using JSON mode, you **must** also instruct the model to produce JSON yourself via a system or user message.
 * Without this, the model may generate an unending stream of whitespace until the generation reaches the token limit,
 * resulting in a long-running and seemingly "stuck" request. Also note that the message content may be partially cut off
 * if `finish_reason="length"`, which indicates the generation exceeded `max_tokens` or the conversation exceeded the max context length.
 */
#suppress "@azure-tools/typespec-autorest/union-unsupported" "This union is defined according to the OpenAI API"
union AssistantsApiResponseFormatOption {
  string,

  /** The model will handle the return format. */
  AssistantsApiResponseFormatMode,

  /** Sets the format of the output of the model when a ToolCall is returned. */
  AssistantsApiResponseFormat,
}

/** Represents the mode in which the model will handle the return format of a tool call. */
union AssistantsApiResponseFormatMode {
  string,

  /** Default value. Let the model handle the return format. */
  "auto",

  /** Setting the value to `none`, will result in a 400 Bad request. */
  "none",
}

/**
 * An object describing the expected output of the model. If `json_object` only `function` type `tools` are allowed to be passed to the Run.
 * If `text` the model can return text or any value needed.
 */
model AssistantsApiResponseFormat {
  /** Must be one of `text` or `json_object`. */
  type?: ApiResponseFormat = ApiResponseFormat.text;
}

/** Possible API response formats. */
union ApiResponseFormat {
  string,

  /** `text` format should be used for requests involving any sort of ToolCall. */
  text: "text",

  /** Using `json_object` format will limit the usage of ToolCall to only functions. */
  jsonObject: "json_object",
}

import "@typespec/openapi";
import "../common/models.tsp";
import "@typespec/http";
import "../conversations/custom.tsp";
import "../responses/models.tsp";
using TypeSpec.OpenAPI;
using TypeSpec.Http;
namespace OpenAI;
/** Constrains the tools available to the model to a pre-defined set. */
@summary("Allowed tools")
model ChatCompletionAllowedTools {
  /**Constrains the tools available to the model to a pre-defined set.

  `auto` allows the model to pick from among the allowed tools and generate a
  message.

  `required` requires the model to call one or more of the allowed tools.*/
  #suppress "@azure-tools/typespec-azure-core/no-closed-literal-union" "Auto-suppressed warnings non-applicable rules during import."
  mode: "auto" | "required";

  /**A list of tool definitions that the model should be allowed to call.

  For the Chat Completions API, the list of tool definitions might look like:
  ```json
  [
    { "type": "function", "function": { "name": "get_weather" } },
    { "type": "function", "function": { "name": "get_time" } }
  ]
  ```*/
  tools: Record<unknown>[];
}

/** Constrains the tools available to the model to a pre-defined set. */
@summary("Allowed tools")
model ChatCompletionAllowedToolsChoice {
  /** Allowed tool configuration type. Always `allowed_tools`. */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "Auto-suppressed warnings non-applicable rules during import."
  @extension("x-stainless-const", true)
  type: "allowed_tools";

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Auto-suppressed warnings non-applicable rules during import."
  #suppress "@azure-tools/typespec-azure-core/casing-style" "Auto-suppressed warnings non-applicable rules during import."
  allowed_tools: ChatCompletionAllowedTools;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Auto-suppressed warnings non-applicable rules during import."
model ChatCompletionDeleted {
  /** The type of object being deleted. */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "Auto-suppressed warnings non-applicable rules during import."
  @extension("x-stainless-const", true)
  object: "chat.completion.deleted";

  /** The ID of the chat completion that was deleted. */
  id: string;

  /** Whether the chat completion was deleted. */
  deleted: boolean;
}

/** Specifying a particular function via `{"name": "my_function"}` forces the model to call that function. */
#suppress "@azure-tools/typespec-azure-core/no-openapi" "Auto-suppressed warnings non-applicable rules during import."
@extension("x-stainless-variantName", "function_call_option")
model ChatCompletionFunctionCallOption {
  /** The name of the function to call. */
  name: string;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Auto-suppressed warnings non-applicable rules during import."
model ChatCompletionFunctions {
  /** A description of what the function does, used by the model to choose when and how to call the function. */
  description?: string;

  /** The name of the function to be called. Must be a-z, A-Z, 0-9, or contain underscores and dashes, with a maximum length of 64. */
  name: string;

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Auto-suppressed warnings non-applicable rules during import."
  parameters?: FunctionParameters;
}

/** An object representing a list of Chat Completions. */
#suppress "@azure-tools/typespec-azure-core/no-openapi" "Auto-suppressed warnings non-applicable rules during import."
@summary("ChatCompletionList")
@extension(
  "x-oaiMeta",
  #{
    name: "The chat completion list object",
    group: "chat",
    example: "{\n  \"object\": \"list\",\n  \"data\": [\n    {\n      \"object\": \"chat.completion\",\n      \"id\": \"chatcmpl-AyPNinnUqUDYo9SAdA52NobMflmj2\",\n      \"model\": \"gpt-4o-2024-08-06\",\n      \"created\": 1738960610,\n      \"request_id\": \"req_ded8ab984ec4bf840f37566c1011c417\",\n      \"tool_choice\": null,\n      \"usage\": {\n        \"total_tokens\": 31,\n        \"completion_tokens\": 18,\n        \"prompt_tokens\": 13\n      },\n      \"seed\": 4944116822809979520,\n      \"top_p\": 1.0,\n      \"temperature\": 1.0,\n      \"presence_penalty\": 0.0,\n      \"frequency_penalty\": 0.0,\n      \"system_fingerprint\": \"fp_50cad350e4\",\n      \"input_user\": null,\n      \"service_tier\": \"default\",\n      \"tools\": null,\n      \"metadata\": {},\n      \"choices\": [\n        {\n          \"index\": 0,\n          \"message\": {\n            \"content\": \"Mind of circuits hum,  \\nLearning patterns in silence—  \\nFuture's quiet spark.\",\n            \"role\": \"assistant\",\n            \"tool_calls\": null,\n            \"function_call\": null\n          },\n          \"finish_reason\": \"stop\",\n          \"logprobs\": null\n        }\n      ],\n      \"response_format\": null\n    }\n  ],\n  \"first_id\": \"chatcmpl-AyPNinnUqUDYo9SAdA52NobMflmj2\",\n  \"last_id\": \"chatcmpl-AyPNinnUqUDYo9SAdA52NobMflmj2\",\n  \"has_more\": false\n}\n",
  }
)
model ChatCompletionList {
  /** The type of this object. It is always set to "list". */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "Auto-suppressed warnings non-applicable rules during import."
  @extension("x-stainless-const", true)
  object: "list" = "list";

  /** An array of chat completion objects. */
  data: CreateChatCompletionResponse[];

  /** The identifier of the first chat completion in the data array. */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "Auto-suppressed warnings non-applicable rules during import."
  first_id: string;

  /** The identifier of the last chat completion in the data array. */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "Auto-suppressed warnings non-applicable rules during import."
  last_id: string;

  /** Indicates whether there are more Chat Completions available. */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "Auto-suppressed warnings non-applicable rules during import."
  has_more: boolean;
}

/** Represents a chat completion response returned by model, based on the provided input. */
#suppress "@azure-tools/typespec-azure-core/no-openapi" "Auto-suppressed warnings non-applicable rules during import."
@extension(
  "x-oaiMeta",
  #{
    name: "The chat completion object",
    group: "chat",
    example: "{\n  \"id\": \"chatcmpl-B9MHDbslfkBeAs8l4bebGdFOJ6PeG\",\n  \"object\": \"chat.completion\",\n  \"created\": 1741570283,\n  \"model\": \"gpt-4o-2024-08-06\",\n  \"choices\": [\n    {\n      \"index\": 0,\n      \"message\": {\n        \"role\": \"assistant\",\n        \"content\": \"The image shows a wooden boardwalk path running through a lush green field or meadow. The sky is bright blue with some scattered clouds, giving the scene a serene and peaceful atmosphere. Trees and shrubs are visible in the background.\",\n        \"refusal\": null,\n        \"annotations\": []\n      },\n      \"logprobs\": null,\n      \"finish_reason\": \"stop\"\n    }\n  ],\n  \"usage\": {\n    \"prompt_tokens\": 1117,\n    \"completion_tokens\": 46,\n    \"total_tokens\": 1163,\n    \"prompt_tokens_details\": {\n      \"cached_tokens\": 0,\n      \"audio_tokens\": 0\n    },\n    \"completion_tokens_details\": {\n      \"reasoning_tokens\": 0,\n      \"audio_tokens\": 0,\n      \"accepted_prediction_tokens\": 0,\n      \"rejected_prediction_tokens\": 0\n    }\n  },\n  \"service_tier\": \"default\",\n  \"system_fingerprint\": \"fp_fc9f1d7035\"\n}\n",
  }
)
model CreateChatCompletionResponse {
  /** A unique identifier for the chat completion. */
  id: string;

  /** A list of chat completion choices. Can be more than one if `n` is greater than 1. */
  choices: CreateChatCompletionResponseChoices[];

  /** The Unix timestamp (in seconds) of when the chat completion was created. */
  #suppress "@azure-tools/typespec-azure-core/no-generic-numeric" "Auto-suppressed warnings non-applicable rules during import."
  created: integer;

  /** The model used for the chat completion. */
  `model`: string;

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Auto-suppressed warnings non-applicable rules during import."
  #suppress "@azure-tools/typespec-azure-core/casing-style" "Auto-suppressed warnings non-applicable rules during import."
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Auto-suppressed warnings non-applicable rules during import."
  service_tier?: ServiceTier;

  /**This fingerprint represents the backend configuration that the model runs with.

  Can be used in conjunction with the `seed` request parameter to understand when backend changes have been made that might impact determinism.*/
  #suppress "@azure-tools/typespec-azure-core/casing-style" "Auto-suppressed warnings non-applicable rules during import."
  system_fingerprint?: string;

  /** The object type, which is always `chat.completion`. */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "Auto-suppressed warnings non-applicable rules during import."
  @extension("x-stainless-const", true)
  object: "chat.completion";

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Auto-suppressed warnings non-applicable rules during import."
  usage?: CompletionUsage;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Auto-suppressed warnings non-applicable rules during import."
model CreateChatCompletionResponseChoices {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Auto-suppressed warnings non-applicable rules during import."
  #suppress "@azure-tools/typespec-azure-core/casing-style" "Auto-suppressed warnings non-applicable rules during import."
  #suppress "@azure-tools/typespec-azure-core/no-closed-literal-union" "Auto-suppressed warnings non-applicable rules during import."
  finish_reason:
    | "stop"
    | "length"
    | "tool_calls"
    | "content_filter"
    | "function_call";
  #suppress "@azure-tools/typespec-azure-core/no-generic-numeric" "Auto-suppressed warnings non-applicable rules during import."
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Auto-suppressed warnings non-applicable rules during import."
  index: integer;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Auto-suppressed warnings non-applicable rules during import."
  message: ChatCompletionResponseMessage;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Auto-suppressed warnings non-applicable rules during import."
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Auto-suppressed warnings non-applicable rules during import."
  logprobs: CreateChatCompletionResponseChoicesLogprobs | null;
}

/** A chat completion message generated by the model. */
model ChatCompletionResponseMessage {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Auto-suppressed warnings non-applicable rules during import."
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Auto-suppressed warnings non-applicable rules during import."
  content: string | null;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Auto-suppressed warnings non-applicable rules during import."
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Auto-suppressed warnings non-applicable rules during import."
  refusal: string | null;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Auto-suppressed warnings non-applicable rules during import."
  #suppress "@azure-tools/typespec-azure-core/casing-style" "Auto-suppressed warnings non-applicable rules during import."
  tool_calls?: (ChatCompletionMessageToolCall | ChatCompletionMessageCustomToolCall)[];

  /**Annotations for the message, when applicable, as when using the
  [web search tool](https://platform.openai.com/docs/guides/tools-web-search?api-mode=chat).*/
  annotations?: ChatCompletionResponseMessageAnnotations[];

  /** The role of the author of this message. */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "Auto-suppressed warnings non-applicable rules during import."
  @extension("x-stainless-const", true)
  role: "assistant";

  /** Deprecated and replaced by `tool_calls`. The name and arguments of a function that should be called, as generated by the model. */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "Auto-suppressed warnings non-applicable rules during import."
  function_call?: ChatCompletionResponseMessageFunctionCall;

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Auto-suppressed warnings non-applicable rules during import."
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Auto-suppressed warnings non-applicable rules during import."
  audio?: ChatCompletionResponseMessageAudio | null;
}

/** The tool calls generated by the model, such as function calls. */
model ChatCompletionMessageToolCalls {}

/** A call to a function tool created by the model. */
@summary("Function tool call")
model ChatCompletionMessageToolCall {
  /** The ID of the tool call. */
  id: string;

  /** The type of the tool. Currently, only `function` is supported. */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "Auto-suppressed warnings non-applicable rules during import."
  @extension("x-stainless-const", true)
  type: "function";

  /** The function that the model called. */
  function: ChatCompletionMessageToolCallFunction;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Auto-suppressed warnings non-applicable rules during import."
model ChatCompletionMessageToolCallFunction {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Auto-suppressed warnings non-applicable rules during import."
  name: string;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Auto-suppressed warnings non-applicable rules during import."
  arguments: string;
}

/** A call to a custom tool created by the model. */
@summary("Custom tool call")
model ChatCompletionMessageCustomToolCall {
  /** The ID of the tool call. */
  id: string;

  /** The type of the tool. Always `custom`. */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "Auto-suppressed warnings non-applicable rules during import."
  @extension("x-stainless-const", true)
  type: "custom";

  /** The custom tool that the model called. */
  custom: ChatCompletionMessageCustomToolCallCustom;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Auto-suppressed warnings non-applicable rules during import."
model ChatCompletionMessageCustomToolCallCustom {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Auto-suppressed warnings non-applicable rules during import."
  name: string;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Auto-suppressed warnings non-applicable rules during import."
  input: string;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Auto-suppressed warnings non-applicable rules during import."
model ChatCompletionResponseMessageAnnotations {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Auto-suppressed warnings non-applicable rules during import."
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "Auto-suppressed warnings non-applicable rules during import."
  @extension("x-stainless-const", true)
  type: "url_citation";

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Auto-suppressed warnings non-applicable rules during import."
  #suppress "@azure-tools/typespec-azure-core/casing-style" "Auto-suppressed warnings non-applicable rules during import."
  url_citation: ChatCompletionResponseMessageAnnotationsUrlCitation;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Auto-suppressed warnings non-applicable rules during import."
model ChatCompletionResponseMessageAnnotationsUrlCitation {
  #suppress "@azure-tools/typespec-azure-core/no-generic-numeric" "Auto-suppressed warnings non-applicable rules during import."
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Auto-suppressed warnings non-applicable rules during import."
  #suppress "@azure-tools/typespec-azure-core/casing-style" "Auto-suppressed warnings non-applicable rules during import."
  end_index: integer;
  #suppress "@azure-tools/typespec-azure-core/no-generic-numeric" "Auto-suppressed warnings non-applicable rules during import."
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Auto-suppressed warnings non-applicable rules during import."
  #suppress "@azure-tools/typespec-azure-core/casing-style" "Auto-suppressed warnings non-applicable rules during import."
  start_index: integer;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Auto-suppressed warnings non-applicable rules during import."
  url: string;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Auto-suppressed warnings non-applicable rules during import."
  title: string;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Auto-suppressed warnings non-applicable rules during import."
model ChatCompletionResponseMessageFunctionCall {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Auto-suppressed warnings non-applicable rules during import."
  arguments: string;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Auto-suppressed warnings non-applicable rules during import."
  name: string;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Auto-suppressed warnings non-applicable rules during import."
model ChatCompletionResponseMessageAudio {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Auto-suppressed warnings non-applicable rules during import."
  id: string;
  #suppress "@azure-tools/typespec-azure-core/no-generic-numeric" "Auto-suppressed warnings non-applicable rules during import."
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Auto-suppressed warnings non-applicable rules during import."
  #suppress "@azure-tools/typespec-azure-core/casing-style" "Auto-suppressed warnings non-applicable rules during import."
  expires_at: integer;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Auto-suppressed warnings non-applicable rules during import."
  data: string;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Auto-suppressed warnings non-applicable rules during import."
  transcript: string;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Auto-suppressed warnings non-applicable rules during import."
model CreateChatCompletionResponseChoicesLogprobs {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Auto-suppressed warnings non-applicable rules during import."
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Auto-suppressed warnings non-applicable rules during import."
  content: ChatCompletionTokenLogprob[] | null;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Auto-suppressed warnings non-applicable rules during import."
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Auto-suppressed warnings non-applicable rules during import."
  refusal: ChatCompletionTokenLogprob[] | null;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Auto-suppressed warnings non-applicable rules during import."
model ChatCompletionTokenLogprob {
  /** The token. */
  token: string;

  /** The log probability of this token, if it is within the top 20 most likely tokens. Otherwise, the value `-9999.0` is used to signify that the token is very unlikely. */
  #suppress "@azure-tools/typespec-azure-core/no-generic-numeric" "Auto-suppressed warnings non-applicable rules during import."
  logprob: numeric;

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Auto-suppressed warnings non-applicable rules during import."
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Auto-suppressed warnings non-applicable rules during import."
  bytes: integer[] | null;

  /** List of the most likely tokens and their log probability, at this token position. In rare cases, there may be fewer than the number of requested `top_logprobs` returned. */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "Auto-suppressed warnings non-applicable rules during import."
  top_logprobs: ChatCompletionTokenLogprobTopLogprobs[];
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Auto-suppressed warnings non-applicable rules during import."
model ChatCompletionTokenLogprobTopLogprobs {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Auto-suppressed warnings non-applicable rules during import."
  token: string;
  #suppress "@azure-tools/typespec-azure-core/no-generic-numeric" "Auto-suppressed warnings non-applicable rules during import."
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Auto-suppressed warnings non-applicable rules during import."
  logprob: numeric;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Auto-suppressed warnings non-applicable rules during import."
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Auto-suppressed warnings non-applicable rules during import."
  bytes: integer[] | null;
}

/** An object representing a list of chat completion messages. */
#suppress "@azure-tools/typespec-azure-core/no-openapi" "Auto-suppressed warnings non-applicable rules during import."
@summary("ChatCompletionMessageList")
@extension(
  "x-oaiMeta",
  #{
    name: "The chat completion message list object",
    group: "chat",
    example: "{\n  \"object\": \"list\",\n  \"data\": [\n    {\n      \"id\": \"chatcmpl-AyPNinnUqUDYo9SAdA52NobMflmj2-0\",\n      \"role\": \"user\",\n      \"content\": \"write a haiku about ai\",\n      \"name\": null,\n      \"content_parts\": null\n    }\n  ],\n  \"first_id\": \"chatcmpl-AyPNinnUqUDYo9SAdA52NobMflmj2-0\",\n  \"last_id\": \"chatcmpl-AyPNinnUqUDYo9SAdA52NobMflmj2-0\",\n  \"has_more\": false\n}\n",
  }
)
model ChatCompletionMessageList {
  /** The type of this object. It is always set to "list". */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "Auto-suppressed warnings non-applicable rules during import."
  @extension("x-stainless-const", true)
  object: "list" = "list";

  /** An array of chat completion message objects. */
  data: ChatCompletionMessageListData[];

  /** The identifier of the first chat message in the data array. */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "Auto-suppressed warnings non-applicable rules during import."
  first_id: string;

  /** The identifier of the last chat message in the data array. */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "Auto-suppressed warnings non-applicable rules during import."
  last_id: string;

  /** Indicates whether there are more chat messages available. */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "Auto-suppressed warnings non-applicable rules during import."
  has_more: boolean;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Auto-suppressed warnings non-applicable rules during import."
model ChatCompletionMessageListData {
  ...ChatCompletionResponseMessage;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Auto-suppressed warnings non-applicable rules during import."
  id: string;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Auto-suppressed warnings non-applicable rules during import."
  #suppress "@azure-tools/typespec-azure-core/casing-style" "Auto-suppressed warnings non-applicable rules during import."
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Auto-suppressed warnings non-applicable rules during import."
  content_parts?: (ChatCompletionRequestMessageContentPartText | ChatCompletionRequestMessageContentPartImage)[] | null;
}

/** Learn about [text inputs](https://platform.openai.com/docs/guides/text-generation). */
#suppress "@azure-tools/typespec-azure-core/no-openapi" "Auto-suppressed warnings non-applicable rules during import."
@summary("Text content part")
@extension(
  "x-stainless-naming",
  #{ go: #{ variant_constructor: "TextContentPart" } }
)
model ChatCompletionRequestMessageContentPartText
  extends ChatCompletionRequestUserMessageContentPart {
  /** The type of the content part. */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "Auto-suppressed warnings non-applicable rules during import."
  @extension("x-stainless-const", true)
  type: "text";

  /** The text content. */
  text: string;
}

/** Learn about [image inputs](https://platform.openai.com/docs/guides/vision). */
#suppress "@azure-tools/typespec-azure-core/no-openapi" "Auto-suppressed warnings non-applicable rules during import."
@summary("Image content part")
@extension(
  "x-stainless-naming",
  #{ go: #{ variant_constructor: "ImageContentPart" } }
)
model ChatCompletionRequestMessageContentPartImage
  extends ChatCompletionRequestUserMessageContentPart {
  /** The type of the content part. */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "Auto-suppressed warnings non-applicable rules during import."
  @extension("x-stainless-const", true)
  type: "image_url";

  #suppress "@azure-tools/typespec-azure-core/casing-style" "Auto-suppressed warnings non-applicable rules during import."
  image_url: ChatCompletionRequestMessageContentPartImageImageUrl;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Auto-suppressed warnings non-applicable rules during import."
model ChatCompletionRequestMessageContentPartImageImageUrl {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Auto-suppressed warnings non-applicable rules during import."
  url: url;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Auto-suppressed warnings non-applicable rules during import."
  #suppress "@azure-tools/typespec-azure-core/no-closed-literal-union" "Auto-suppressed warnings non-applicable rules during import."
  detail?: "auto" | "low" | "high" = "auto";
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Auto-suppressed warnings non-applicable rules during import."
model ChatCompletionMessageToolCallChunk {
  #suppress "@azure-tools/typespec-azure-core/no-generic-numeric" "Auto-suppressed warnings non-applicable rules during import."
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Auto-suppressed warnings non-applicable rules during import."
  index: integer;

  /** The ID of the tool call. */
  id?: string;

  /** The type of the tool. Currently, only `function` is supported. */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "Auto-suppressed warnings non-applicable rules during import."
  @extension("x-stainless-const", true)
  type?: "function";

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Auto-suppressed warnings non-applicable rules during import."
  function?: ChatCompletionMessageToolCallChunkFunction;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Auto-suppressed warnings non-applicable rules during import."
model ChatCompletionMessageToolCallChunkFunction {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Auto-suppressed warnings non-applicable rules during import."
  name?: string;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Auto-suppressed warnings non-applicable rules during import."
  arguments?: string;
}

/** Specifies a tool the model should use. Use to force the model to call a specific function. */
@summary("Function tool choice")
model ChatCompletionNamedToolChoice {
  /** For function calling, the type is always `function`. */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "Auto-suppressed warnings non-applicable rules during import."
  @extension("x-stainless-const", true)
  type: "function";

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Auto-suppressed warnings non-applicable rules during import."
  function: ChatCompletionNamedToolChoiceFunction;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Auto-suppressed warnings non-applicable rules during import."
model ChatCompletionNamedToolChoiceFunction {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Auto-suppressed warnings non-applicable rules during import."
  name: string;
}

/** Specifies a tool the model should use. Use to force the model to call a specific custom tool. */
@summary("Custom tool choice")
model ChatCompletionNamedToolChoiceCustom {
  /** For custom tool calling, the type is always `custom`. */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "Auto-suppressed warnings non-applicable rules during import."
  @extension("x-stainless-const", true)
  type: "custom";

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Auto-suppressed warnings non-applicable rules during import."
  custom: ChatCompletionNamedToolChoiceCustomCustom;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Auto-suppressed warnings non-applicable rules during import."
model ChatCompletionNamedToolChoiceCustomCustom {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Auto-suppressed warnings non-applicable rules during import."
  name: string;
}

/** Messages sent by the model in response to user messages. */
#suppress "@azure-tools/typespec-azure-core/no-openapi" "Auto-suppressed warnings non-applicable rules during import."
@summary("Assistant message")
@extension("x-stainless-soft-required", #["content"])
model ChatCompletionRequestAssistantMessage
  extends ChatCompletionRequestMessage {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Auto-suppressed warnings non-applicable rules during import."
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Auto-suppressed warnings non-applicable rules during import."
  content?: string | ChatCompletionRequestAssistantMessageContentPart[] | null;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Auto-suppressed warnings non-applicable rules during import."
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Auto-suppressed warnings non-applicable rules during import."
  refusal?: string | null;

  /** The role of the messages author, in this case `assistant`. */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "Auto-suppressed warnings non-applicable rules during import."
  @extension("x-stainless-const", true)
  role: "assistant";

  /** An optional name for the participant. Provides the model information to differentiate between participants of the same role. */
  name?: string;

  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Auto-suppressed warnings non-applicable rules during import."
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Auto-suppressed warnings non-applicable rules during import."
  audio?: ChatCompletionRequestAssistantMessageAudio | null;
  #suppress "@azure-tools/typespec-azure-core/casing-style" "Auto-suppressed warnings non-applicable rules during import."
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Auto-suppressed warnings non-applicable rules during import."
  tool_calls?: (ChatCompletionMessageToolCall | ChatCompletionMessageCustomToolCall)[];
  #suppress "@azure-tools/typespec-azure-core/casing-style" "Auto-suppressed warnings non-applicable rules during import."
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Auto-suppressed warnings non-applicable rules during import."
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Auto-suppressed warnings non-applicable rules during import."
  function_call?: ChatCompletionRequestAssistantMessageFunctionCall | null;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Auto-suppressed warnings non-applicable rules during import."
@discriminator("type")
model ChatCompletionRequestAssistantMessageContentPart {
  #suppress "@azure-tools/typespec-azure-core/no-string-discriminator" "Auto-suppressed warnings non-applicable rules during import."
  type: string;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Auto-suppressed warnings non-applicable rules during import."
@summary("Refusal content part")
model ChatCompletionRequestMessageContentPartRefusal
  extends ChatCompletionRequestAssistantMessageContentPart {
  /** The type of the content part. */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "Auto-suppressed warnings non-applicable rules during import."
  @extension("x-stainless-const", true)
  type: "refusal";

  /** The refusal message generated by the model. */
  refusal: string;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Auto-suppressed warnings non-applicable rules during import."
model ChatCompletionRequestAssistantMessageAudio {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Auto-suppressed warnings non-applicable rules during import."
  id: string;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Auto-suppressed warnings non-applicable rules during import."
model ChatCompletionRequestAssistantMessageFunctionCall {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Auto-suppressed warnings non-applicable rules during import."
  arguments: string;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Auto-suppressed warnings non-applicable rules during import."
  name: string;
}

/**Developer-provided instructions that the model should follow, regardless of
messages sent by the user. With o1 models and newer, `developer` messages
replace the previous `system` messages.*/
#suppress "@azure-tools/typespec-azure-core/no-openapi" "Auto-suppressed warnings non-applicable rules during import."
@summary("Developer message")
@extension(
  "x-stainless-naming",
  #{ go: #{ variant_constructor: "DeveloperMessage" } }
)
model ChatCompletionRequestDeveloperMessage
  extends ChatCompletionRequestMessage {
  /** The contents of the developer message. */
  content: string | ChatCompletionRequestMessageContentPartText[];

  /** The role of the messages author, in this case `developer`. */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "Auto-suppressed warnings non-applicable rules during import."
  @extension("x-stainless-const", true)
  role: "developer";

  /** An optional name for the participant. Provides the model information to differentiate between participants of the same role. */
  name?: string;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Auto-suppressed warnings non-applicable rules during import."
@summary("Function message")
model ChatCompletionRequestFunctionMessage
  extends ChatCompletionRequestMessage {
  /** The role of the messages author, in this case `function`. */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "Auto-suppressed warnings non-applicable rules during import."
  @extension("x-stainless-const", true)
  role: "function";

  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Auto-suppressed warnings non-applicable rules during import."
  content: string | null;

  /** The name of the function to call. */
  name: string;
}

/**Developer-provided instructions that the model should follow, regardless of
messages sent by the user. With o1 models and newer, use `developer` messages
for this purpose instead.*/
#suppress "@azure-tools/typespec-azure-core/no-openapi" "Auto-suppressed warnings non-applicable rules during import."
@summary("System message")
@extension(
  "x-stainless-naming",
  #{ go: #{ variant_constructor: "SystemMessage" } }
)
model ChatCompletionRequestSystemMessage extends ChatCompletionRequestMessage {
  /** The contents of the system message. */
  content: string | ChatCompletionRequestSystemMessageContentPart[];

  /** The role of the messages author, in this case `system`. */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "Auto-suppressed warnings non-applicable rules during import."
  @extension("x-stainless-const", true)
  role: "system";

  /** An optional name for the participant. Provides the model information to differentiate between participants of the same role. */
  name?: string;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Auto-suppressed warnings non-applicable rules during import."
union ChatCompletionRequestSystemMessageContentPart {
  ChatCompletionRequestMessageContentPartText,
}

/**Messages sent by an end user, containing prompts or additional context
information.*/
#suppress "@azure-tools/typespec-azure-core/no-openapi" "Auto-suppressed warnings non-applicable rules during import."
@summary("User message")
@extension(
  "x-stainless-naming",
  #{ go: #{ variant_constructor: "UserMessage" } }
)
model ChatCompletionRequestUserMessage extends ChatCompletionRequestMessage {
  /** The contents of the user message. */
  content: string | ChatCompletionRequestUserMessageContentPart[];

  /** The role of the messages author, in this case `user`. */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "Auto-suppressed warnings non-applicable rules during import."
  @extension("x-stainless-const", true)
  role: "user";

  /** An optional name for the participant. Provides the model information to differentiate between participants of the same role. */
  name?: string;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Auto-suppressed warnings non-applicable rules during import."
@discriminator("type")
model ChatCompletionRequestUserMessageContentPart {
  #suppress "@azure-tools/typespec-azure-core/no-string-discriminator" "Auto-suppressed warnings non-applicable rules during import."
  type: string;
}

/** Learn about [audio inputs](https://platform.openai.com/docs/guides/audio). */
#suppress "@azure-tools/typespec-azure-core/no-openapi" "Auto-suppressed warnings non-applicable rules during import."
@summary("Audio content part")
@extension(
  "x-stainless-naming",
  #{ go: #{ variant_constructor: "InputAudioContentPart" } }
)
model ChatCompletionRequestMessageContentPartAudio
  extends ChatCompletionRequestUserMessageContentPart {
  /** The type of the content part. Always `input_audio`. */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "Auto-suppressed warnings non-applicable rules during import."
  @extension("x-stainless-const", true)
  type: "input_audio";

  #suppress "@azure-tools/typespec-azure-core/casing-style" "Auto-suppressed warnings non-applicable rules during import."
  input_audio: ChatCompletionRequestMessageContentPartAudioInputAudio;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Auto-suppressed warnings non-applicable rules during import."
model ChatCompletionRequestMessageContentPartAudioInputAudio {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Auto-suppressed warnings non-applicable rules during import."
  data: string;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Auto-suppressed warnings non-applicable rules during import."
  #suppress "@azure-tools/typespec-azure-core/no-closed-literal-union" "Auto-suppressed warnings non-applicable rules during import."
  format: "wav" | "mp3";
}

/** Learn about [file inputs](https://platform.openai.com/docs/guides/text) for text generation. */
#suppress "@azure-tools/typespec-azure-core/no-openapi" "Auto-suppressed warnings non-applicable rules during import."
@summary("File content part")
@extension(
  "x-stainless-naming",
  #{ go: #{ variant_constructor: "FileContentPart" } }
)
model ChatCompletionRequestMessageContentPartFile
  extends ChatCompletionRequestUserMessageContentPart {
  /** The type of the content part. Always `file`. */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "Auto-suppressed warnings non-applicable rules during import."
  @extension("x-stainless-const", true)
  type: "file";

  #suppress "@azure-tools/typespec-azure-core/no-openapi" "Auto-suppressed warnings non-applicable rules during import."
  @extension(
    "x-stainless-naming",
    #{
      java: #{ type_name: "FileObject" },
      kotlin: #{ type_name: "FileObject" },
    }
  )
  file: ChatCompletionRequestMessageContentPartFileFile;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Auto-suppressed warnings non-applicable rules during import."
model ChatCompletionRequestMessageContentPartFileFile {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Auto-suppressed warnings non-applicable rules during import."
  filename?: string;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Auto-suppressed warnings non-applicable rules during import."
  #suppress "@azure-tools/typespec-azure-core/casing-style" "Auto-suppressed warnings non-applicable rules during import."
  file_data?: string;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Auto-suppressed warnings non-applicable rules during import."
  #suppress "@azure-tools/typespec-azure-core/casing-style" "Auto-suppressed warnings non-applicable rules during import."
  file_id?: string;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Auto-suppressed warnings non-applicable rules during import."
#suppress "@azure-tools/typespec-azure-core/no-openapi" "Auto-suppressed warnings non-applicable rules during import."
@summary("Tool message")
@extension(
  "x-stainless-naming",
  #{ go: #{ variant_constructor: "ToolMessage" } }
)
model ChatCompletionRequestToolMessage extends ChatCompletionRequestMessage {
  /** The role of the messages author, in this case `tool`. */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "Auto-suppressed warnings non-applicable rules during import."
  @extension("x-stainless-const", true)
  role: "tool";

  /** The contents of the tool message. */
  content: string | ChatCompletionRequestToolMessageContentPart[];

  /** Tool call that this message is responding to. */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "Auto-suppressed warnings non-applicable rules during import."
  tool_call_id: string;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Auto-suppressed warnings non-applicable rules during import."
union ChatCompletionRequestToolMessageContentPart {
  ChatCompletionRequestMessageContentPartText,
}

/** A chat completion delta generated by streamed model responses. */
model ChatCompletionStreamResponseDelta {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Auto-suppressed warnings non-applicable rules during import."
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Auto-suppressed warnings non-applicable rules during import."
  content?: string | null;

  /** Deprecated and replaced by `tool_calls`. The name and arguments of a function that should be called, as generated by the model. */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "Auto-suppressed warnings non-applicable rules during import."
  function_call?: ChatCompletionStreamResponseDeltaFunctionCall;

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Auto-suppressed warnings non-applicable rules during import."
  #suppress "@azure-tools/typespec-azure-core/casing-style" "Auto-suppressed warnings non-applicable rules during import."
  tool_calls?: ChatCompletionMessageToolCallChunk[];

  /** The role of the author of this message. */
  #suppress "@azure-tools/typespec-azure-core/no-closed-literal-union" "Auto-suppressed warnings non-applicable rules during import."
  role?: "developer" | "system" | "user" | "assistant" | "tool";

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Auto-suppressed warnings non-applicable rules during import."
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Auto-suppressed warnings non-applicable rules during import."
  refusal?: string | null;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Auto-suppressed warnings non-applicable rules during import."
model ChatCompletionStreamResponseDeltaFunctionCall {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Auto-suppressed warnings non-applicable rules during import."
  arguments?: string;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Auto-suppressed warnings non-applicable rules during import."
  name?: string;
}

/** A function tool that can be used to generate a response. */
@summary("Function tool")
model ChatCompletionTool {
  /** The type of the tool. Currently, only `function` is supported. */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "Auto-suppressed warnings non-applicable rules during import."
  @extension("x-stainless-const", true)
  type: "function";

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Auto-suppressed warnings non-applicable rules during import."
  function: FunctionObject;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Auto-suppressed warnings non-applicable rules during import."
model CreateChatCompletionRequest {
  ...CreateModelResponseProperties;

  /**A list of messages comprising the conversation so far. Depending on the
  [model](https://platform.openai.com/docs/models) you use, different message types (modalities) are
  supported, like [text](https://platform.openai.com/docs/guides/text-generation),
  [images](https://platform.openai.com/docs/guides/vision), and [audio](https://platform.openai.com/docs/guides/audio).*/
  @minItems(1)
  messages: ChatCompletionRequestMessage[];

  /**Model ID used to generate the response, like `gpt-4o` or `o3`. OpenAI
  offers a wide range of models with different capabilities, performance
  characteristics, and price points. Refer to the [model guide](https://platform.openai.com/docs/models)
  to browse and compare available models.*/
  `model`: ModelIdsShared;

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Auto-suppressed warnings non-applicable rules during import."
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Auto-suppressed warnings non-applicable rules during import."
  modalities?: ResponseModalities;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Auto-suppressed warnings non-applicable rules during import."
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Auto-suppressed warnings non-applicable rules during import."
  verbosity?: Verbosity;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Auto-suppressed warnings non-applicable rules during import."
  #suppress "@azure-tools/typespec-azure-core/casing-style" "Auto-suppressed warnings non-applicable rules during import."
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Auto-suppressed warnings non-applicable rules during import."
  reasoning_effort?: ReasoningEffort;

  /** An upper bound for the number of tokens that can be generated for a completion, including visible output tokens and [reasoning tokens](https://platform.openai.com/docs/guides/reasoning). */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "Auto-suppressed warnings non-applicable rules during import."
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Auto-suppressed warnings non-applicable rules during import."
  max_completion_tokens?: integer | null;

  /**Number between -2.0 and 2.0. Positive values penalize new tokens based on
  their existing frequency in the text so far, decreasing the model's
  likelihood to repeat the same line verbatim.*/
  #suppress "@azure-tools/typespec-azure-core/casing-style" "Auto-suppressed warnings non-applicable rules during import."
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Auto-suppressed warnings non-applicable rules during import."
  @maxValue(2)
  @minValue(-2)
  frequency_penalty?: numeric | null;

  /**Number between -2.0 and 2.0. Positive values penalize new tokens based on
  whether they appear in the text so far, increasing the model's likelihood
  to talk about new topics.*/
  #suppress "@azure-tools/typespec-azure-core/casing-style" "Auto-suppressed warnings non-applicable rules during import."
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Auto-suppressed warnings non-applicable rules during import."
  @maxValue(2)
  @minValue(-2)
  presence_penalty?: numeric | null;

  /**This tool searches the web for relevant results to use in a response.
  Learn more about the [web search tool](https://platform.openai.com/docs/guides/tools-web-search?api-mode=chat).*/
  #suppress "@azure-tools/typespec-azure-core/casing-style" "Auto-suppressed warnings non-applicable rules during import."
  @summary("Web search")
  web_search_options?: CreateChatCompletionRequestWebSearchOptions;

  /**An object specifying the format that the model must output.

  Setting to `{ "type": "json_schema", "json_schema": {...} }` enables
  Structured Outputs which ensures the model will match your supplied JSON
  schema. Learn more in the [Structured Outputs
  guide](https://platform.openai.com/docs/guides/structured-outputs).

  Setting to `{ "type": "json_object" }` enables the older JSON mode, which
  ensures the message the model generates is valid JSON. Using `json_schema`
  is preferred for models that support it.*/
  #suppress "@azure-tools/typespec-azure-core/casing-style" "Auto-suppressed warnings non-applicable rules during import."
  response_format?: ResponseFormatText | ResponseFormatJsonSchema | ResponseFormatJsonObject;

  /**Parameters for audio output. Required when audio output is requested with
  `modalities: ["audio"]`. [Learn more](https://platform.openai.com/docs/guides/audio).*/
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Auto-suppressed warnings non-applicable rules during import."
  audio?: CreateChatCompletionRequestAudio | null;

  /**Whether or not to store the output of this chat completion request for
  use in our [model distillation](https://platform.openai.com/docs/guides/distillation) or
  [evals](https://platform.openai.com/docs/guides/evals) products.

  Supports text and image inputs. Note: image inputs over 8MB will be dropped.*/
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Auto-suppressed warnings non-applicable rules during import."
  store?: boolean | null;

  /**If set to true, the model response data will be streamed to the client
  as it is generated using [server-sent events](https://developer.mozilla.org/en-US/docs/Web/API/Server-sent_events/Using_server-sent_events#Event_stream_format).
  See the [Streaming section below](https://platform.openai.com/docs/api-reference/chat/streaming)
  for more information, along with the [streaming responses](https://platform.openai.com/docs/guides/streaming-responses)
  guide for more information on how to handle the streaming events.*/
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Auto-suppressed warnings non-applicable rules during import."
  stream?: boolean | null;

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Auto-suppressed warnings non-applicable rules during import."
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Auto-suppressed warnings non-applicable rules during import."
  stop?: StopConfiguration;

  /**Modify the likelihood of specified tokens appearing in the completion.

  Accepts a JSON object that maps tokens (specified by their token ID in the
  tokenizer) to an associated bias value from -100 to 100. Mathematically,
  the bias is added to the logits generated by the model prior to sampling.
  The exact effect will vary per model, but values between -1 and 1 should
  decrease or increase likelihood of selection; values like -100 or 100
  should result in a ban or exclusive selection of the relevant token.*/
  #suppress "@azure-tools/typespec-azure-core/casing-style" "Auto-suppressed warnings non-applicable rules during import."
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Auto-suppressed warnings non-applicable rules during import."
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "Auto-suppressed warnings non-applicable rules during import."
  @extension("x-oaiTypeLabel", "map")
  logit_bias?: Record<integer> | null;

  /**Whether to return log probabilities of the output tokens or not. If true,
  returns the log probabilities of each output token returned in the
  `content` of `message`.*/
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Auto-suppressed warnings non-applicable rules during import."
  logprobs?: boolean | null;

  /**The maximum number of [tokens](/tokenizer) that can be generated in the
  chat completion. This value can be used to control
  [costs](https://openai.com/api/pricing/) for text generated via API.

  This value is now deprecated in favor of `max_completion_tokens`, and is
  not compatible with [o-series models](https://platform.openai.com/docs/guides/reasoning).*/
  #suppress "@azure-tools/typespec-azure-core/casing-style" "Auto-suppressed warnings non-applicable rules during import."
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Auto-suppressed warnings non-applicable rules during import."
  max_tokens?: integer | null;

  /** How many chat completion choices to generate for each input message. Note that you will be charged based on the number of generated tokens across all of the choices. Keep `n` as `1` to minimize costs. */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Auto-suppressed warnings non-applicable rules during import."
  @maxValue(128)
  @minValue(1)
  n?: integer | null = 1;

  /**Configuration for a [Predicted Output](https://platform.openai.com/docs/guides/predicted-outputs),
  which can greatly improve response times when large parts of the model
  response are known ahead of time. This is most common when you are
  regenerating a file with only minor changes to most of the content.*/
  prediction?: PredictionContent;

  /**This feature is in Beta.
  If specified, our system will make a best effort to sample deterministically, such that repeated requests with the same `seed` and parameters should return the same result.
  Determinism is not guaranteed, and you should refer to the `system_fingerprint` response parameter to monitor changes in the backend.*/
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Auto-suppressed warnings non-applicable rules during import."
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "Auto-suppressed warnings non-applicable rules during import."
  @maxValue(9223372036854776000)
  @minValue(-9223372036854776000)
  @extension("x-oaiMeta", #{ beta: true })
  seed?: integer | null;

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Auto-suppressed warnings non-applicable rules during import."
  #suppress "@azure-tools/typespec-azure-core/casing-style" "Auto-suppressed warnings non-applicable rules during import."
  stream_options?: ChatCompletionStreamOptions;

  /**A list of tools the model may call. You can provide either
  [custom tools](https://platform.openai.com/docs/guides/function-calling#custom-tools) or
  [function tools](https://platform.openai.com/docs/guides/function-calling).*/
  tools?: (ChatCompletionTool | CustomToolChatCompletions)[];

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Auto-suppressed warnings non-applicable rules during import."
  #suppress "@azure-tools/typespec-azure-core/casing-style" "Auto-suppressed warnings non-applicable rules during import."
  tool_choice?: ChatCompletionToolChoiceOption;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Auto-suppressed warnings non-applicable rules during import."
  #suppress "@azure-tools/typespec-azure-core/casing-style" "Auto-suppressed warnings non-applicable rules during import."
  parallel_tool_calls?: ParallelToolCalls;

  /**Deprecated in favor of `tool_choice`.

  Controls which (if any) function is called by the model.

  `none` means the model will not call a function and instead generates a
  message.

  `auto` means the model can pick between generating a message or calling a
  function.

  Specifying a particular function via `{"name": "my_function"}` forces the
  model to call that function.

  `none` is the default when no functions are present. `auto` is the default
  if functions are present.*/
  #suppress "@azure-tools/typespec-azure-core/casing-style" "Auto-suppressed warnings non-applicable rules during import."
  function_call?: "none" | "auto" | ChatCompletionFunctionCallOption;

  /**Deprecated in favor of `tools`.

  A list of functions the model may generate JSON inputs for.*/
  @maxItems(128)
  @minItems(1)
  functions?: ChatCompletionFunctions[];
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Auto-suppressed warnings non-applicable rules during import."
@discriminator("role")
model ChatCompletionRequestMessage {
  #suppress "@azure-tools/typespec-azure-core/no-string-discriminator" "Auto-suppressed warnings non-applicable rules during import."
  role: string;
}

#suppress "@azure-tools/typespec-azure-core/no-enum" "Auto-suppressed warnings non-applicable rules during import."
#suppress "@azure-tools/typespec-azure-core/no-openapi" "Auto-suppressed warnings non-applicable rules during import."
#suppress "@azure-tools/typespec-azure-core/documentation-required" "Auto-suppressed warnings non-applicable rules during import."
@extension("x-stainless-nominal", false)
enum ChatModel {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Auto-suppressed warnings non-applicable rules during import."
  `gpt-5`,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Auto-suppressed warnings non-applicable rules during import."
  `gpt-5-mini`,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Auto-suppressed warnings non-applicable rules during import."
  `gpt-5-nano`,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Auto-suppressed warnings non-applicable rules during import."
  `gpt-5-2025-08-07`,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Auto-suppressed warnings non-applicable rules during import."
  `gpt-5-mini-2025-08-07`,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Auto-suppressed warnings non-applicable rules during import."
  `gpt-5-nano-2025-08-07`,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Auto-suppressed warnings non-applicable rules during import."
  `gpt-5-chat-latest`,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Auto-suppressed warnings non-applicable rules during import."
  `gpt-4.1`,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Auto-suppressed warnings non-applicable rules during import."
  `gpt-4.1-mini`,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Auto-suppressed warnings non-applicable rules during import."
  `gpt-4.1-nano`,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Auto-suppressed warnings non-applicable rules during import."
  `gpt-4.1-2025-04-14`,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Auto-suppressed warnings non-applicable rules during import."
  `gpt-4.1-mini-2025-04-14`,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Auto-suppressed warnings non-applicable rules during import."
  `gpt-4.1-nano-2025-04-14`,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Auto-suppressed warnings non-applicable rules during import."
  `o4-mini`,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Auto-suppressed warnings non-applicable rules during import."
  `o4-mini-2025-04-16`,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Auto-suppressed warnings non-applicable rules during import."
  o3,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Auto-suppressed warnings non-applicable rules during import."
  `o3-2025-04-16`,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Auto-suppressed warnings non-applicable rules during import."
  `o3-mini`,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Auto-suppressed warnings non-applicable rules during import."
  `o3-mini-2025-01-31`,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Auto-suppressed warnings non-applicable rules during import."
  o1,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Auto-suppressed warnings non-applicable rules during import."
  `o1-2024-12-17`,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Auto-suppressed warnings non-applicable rules during import."
  `o1-preview`,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Auto-suppressed warnings non-applicable rules during import."
  `o1-preview-2024-09-12`,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Auto-suppressed warnings non-applicable rules during import."
  `o1-mini`,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Auto-suppressed warnings non-applicable rules during import."
  `o1-mini-2024-09-12`,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Auto-suppressed warnings non-applicable rules during import."
  `gpt-4o`,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Auto-suppressed warnings non-applicable rules during import."
  `gpt-4o-2024-11-20`,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Auto-suppressed warnings non-applicable rules during import."
  `gpt-4o-2024-08-06`,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Auto-suppressed warnings non-applicable rules during import."
  `gpt-4o-2024-05-13`,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Auto-suppressed warnings non-applicable rules during import."
  `gpt-4o-audio-preview`,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Auto-suppressed warnings non-applicable rules during import."
  `gpt-4o-audio-preview-2024-10-01`,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Auto-suppressed warnings non-applicable rules during import."
  `gpt-4o-audio-preview-2024-12-17`,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Auto-suppressed warnings non-applicable rules during import."
  `gpt-4o-audio-preview-2025-06-03`,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Auto-suppressed warnings non-applicable rules during import."
  `gpt-4o-mini-audio-preview`,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Auto-suppressed warnings non-applicable rules during import."
  `gpt-4o-mini-audio-preview-2024-12-17`,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Auto-suppressed warnings non-applicable rules during import."
  `gpt-4o-search-preview`,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Auto-suppressed warnings non-applicable rules during import."
  `gpt-4o-mini-search-preview`,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Auto-suppressed warnings non-applicable rules during import."
  `gpt-4o-search-preview-2025-03-11`,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Auto-suppressed warnings non-applicable rules during import."
  `gpt-4o-mini-search-preview-2025-03-11`,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Auto-suppressed warnings non-applicable rules during import."
  `chatgpt-4o-latest`,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Auto-suppressed warnings non-applicable rules during import."
  `codex-mini-latest`,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Auto-suppressed warnings non-applicable rules during import."
  `gpt-4o-mini`,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Auto-suppressed warnings non-applicable rules during import."
  `gpt-4o-mini-2024-07-18`,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Auto-suppressed warnings non-applicable rules during import."
  `gpt-4-turbo`,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Auto-suppressed warnings non-applicable rules during import."
  `gpt-4-turbo-2024-04-09`,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Auto-suppressed warnings non-applicable rules during import."
  `gpt-4-0125-preview`,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Auto-suppressed warnings non-applicable rules during import."
  `gpt-4-turbo-preview`,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Auto-suppressed warnings non-applicable rules during import."
  `gpt-4-1106-preview`,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Auto-suppressed warnings non-applicable rules during import."
  `gpt-4-vision-preview`,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Auto-suppressed warnings non-applicable rules during import."
  `gpt-4`,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Auto-suppressed warnings non-applicable rules during import."
  `gpt-4-0314`,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Auto-suppressed warnings non-applicable rules during import."
  `gpt-4-0613`,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Auto-suppressed warnings non-applicable rules during import."
  `gpt-4-32k`,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Auto-suppressed warnings non-applicable rules during import."
  `gpt-4-32k-0314`,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Auto-suppressed warnings non-applicable rules during import."
  `gpt-4-32k-0613`,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Auto-suppressed warnings non-applicable rules during import."
  `gpt-3.5-turbo`,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Auto-suppressed warnings non-applicable rules during import."
  `gpt-3.5-turbo-16k`,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Auto-suppressed warnings non-applicable rules during import."
  `gpt-3.5-turbo-0301`,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Auto-suppressed warnings non-applicable rules during import."
  `gpt-3.5-turbo-0613`,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Auto-suppressed warnings non-applicable rules during import."
  `gpt-3.5-turbo-1106`,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Auto-suppressed warnings non-applicable rules during import."
  `gpt-3.5-turbo-0125`,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Auto-suppressed warnings non-applicable rules during import."
  `gpt-3.5-turbo-16k-0613`,
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Auto-suppressed warnings non-applicable rules during import."
model CreateChatCompletionRequestWebSearchOptions {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Auto-suppressed warnings non-applicable rules during import."
  #suppress "@azure-tools/typespec-azure-core/casing-style" "Auto-suppressed warnings non-applicable rules during import."
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Auto-suppressed warnings non-applicable rules during import."
  user_location?: CreateChatCompletionRequestWebSearchOptionsUserLocation | null;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Auto-suppressed warnings non-applicable rules during import."
  #suppress "@azure-tools/typespec-azure-core/casing-style" "Auto-suppressed warnings non-applicable rules during import."
  search_context_size?: WebSearchContextSize;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Auto-suppressed warnings non-applicable rules during import."
model CreateChatCompletionRequestWebSearchOptionsUserLocation {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Auto-suppressed warnings non-applicable rules during import."
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "Auto-suppressed warnings non-applicable rules during import."
  @extension("x-stainless-const", true)
  type: "approximate";

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Auto-suppressed warnings non-applicable rules during import."
  approximate: WebSearchLocation;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Auto-suppressed warnings non-applicable rules during import."
model CreateChatCompletionRequestAudio {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Auto-suppressed warnings non-applicable rules during import."
  voice: VoiceIdsShared;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Auto-suppressed warnings non-applicable rules during import."
  #suppress "@azure-tools/typespec-azure-core/no-closed-literal-union" "Auto-suppressed warnings non-applicable rules during import."
  format: "wav" | "aac" | "mp3" | "flac" | "opus" | "pcm16";
}

/**Static predicted output content, such as the content of a text file that is
being regenerated.*/
@summary("Static Content")
model PredictionContent {
  /**The type of the predicted content you want to provide. This type is
  currently always `content`.*/
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "Auto-suppressed warnings non-applicable rules during import."
  @extension("x-stainless-const", true)
  type: "content";

  /**The content that should be matched when generating a model response.
  If generated tokens would match this content, the entire model response
  can be returned much more quickly.*/
  content: string | ChatCompletionRequestMessageContentPartText[];
}

/** A custom tool that processes input using a specified format. */
@summary("Custom tool")
model CustomToolChatCompletions {
  /** The type of the custom tool. Always `custom`. */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "Auto-suppressed warnings non-applicable rules during import."
  @extension("x-stainless-const", true)
  type: "custom";

  /** Properties of the custom tool. */
  @summary("Custom tool properties")
  custom: CustomToolChatCompletionsCustom;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Auto-suppressed warnings non-applicable rules during import."
model CustomToolChatCompletionsCustom {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Auto-suppressed warnings non-applicable rules during import."
  name: string;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Auto-suppressed warnings non-applicable rules during import."
  description?: string;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Auto-suppressed warnings non-applicable rules during import."
  format?: CustomToolChatCompletionsCustomFormatText | CustomToolChatCompletionsCustomFormatGrammar;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Auto-suppressed warnings non-applicable rules during import."
model CustomToolChatCompletionsCustomFormatText {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Auto-suppressed warnings non-applicable rules during import."
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "Auto-suppressed warnings non-applicable rules during import."
  @extension("x-stainless-const", true)
  type: "text";
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Auto-suppressed warnings non-applicable rules during import."
model CustomToolChatCompletionsCustomFormatGrammar {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Auto-suppressed warnings non-applicable rules during import."
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "Auto-suppressed warnings non-applicable rules during import."
  @extension("x-stainless-const", true)
  type: "grammar";

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Auto-suppressed warnings non-applicable rules during import."
  @summary("Grammar format")
  grammar: CustomToolChatCompletionsCustomFormatGrammarGrammar;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Auto-suppressed warnings non-applicable rules during import."
model CustomToolChatCompletionsCustomFormatGrammarGrammar {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Auto-suppressed warnings non-applicable rules during import."
  definition: string;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Auto-suppressed warnings non-applicable rules during import."
  #suppress "@azure-tools/typespec-azure-core/no-closed-literal-union" "Auto-suppressed warnings non-applicable rules during import."
  syntax: "lark" | "regex";
}

/**Controls which (if any) tool is called by the model.
`none` means the model will not call any tool and instead generates a message.
`auto` means the model can pick between generating a message or calling one or more tools.
`required` means the model must call one or more tools.
Specifying a particular tool via `{"type": "function", "function": {"name": "my_function"}}` forces the model to call that tool.

`none` is the default when no tools are present. `auto` is the default if tools are present.*/
#suppress "@azure-tools/typespec-azure-core/no-openapi" "Auto-suppressed warnings non-applicable rules during import."
@extension(
  "x-stainless-go-variant-constructor",
  #{ naming: "tool_choice_option_{variant}" }
)
union ChatCompletionToolChoiceOption {
  #suppress "@azure-tools/typespec-azure-core/no-closed-literal-union" "Auto-suppressed warnings non-applicable rules during import."
  "none" | "auto" | "required",
  ChatCompletionAllowedToolsChoice,
  ChatCompletionNamedToolChoice,
  ChatCompletionNamedToolChoiceCustom,
}

/**Represents a streamed chunk of a chat completion response returned
by the model, based on the provided input.
[Learn more](https://platform.openai.com/docs/guides/streaming-responses).*/
#suppress "@azure-tools/typespec-azure-core/no-openapi" "Auto-suppressed warnings non-applicable rules during import."
@extension(
  "x-oaiMeta",
  #{
    name: "The chat completion chunk object",
    group: "chat",
    example: "{\"id\":\"chatcmpl-123\",\"object\":\"chat.completion.chunk\",\"created\":1694268190,\"model\":\"gpt-4o-mini\", \"system_fingerprint\": \"fp_44709d6fcb\", \"choices\":[{\"index\":0,\"delta\":{\"role\":\"assistant\",\"content\":\"\"},\"logprobs\":null,\"finish_reason\":null}]}\n\n{\"id\":\"chatcmpl-123\",\"object\":\"chat.completion.chunk\",\"created\":1694268190,\"model\":\"gpt-4o-mini\", \"system_fingerprint\": \"fp_44709d6fcb\", \"choices\":[{\"index\":0,\"delta\":{\"content\":\"Hello\"},\"logprobs\":null,\"finish_reason\":null}]}\n\n....\n\n{\"id\":\"chatcmpl-123\",\"object\":\"chat.completion.chunk\",\"created\":1694268190,\"model\":\"gpt-4o-mini\", \"system_fingerprint\": \"fp_44709d6fcb\", \"choices\":[{\"index\":0,\"delta\":{},\"logprobs\":null,\"finish_reason\":\"stop\"}]}\n",
  }
)
model CreateChatCompletionStreamResponse {
  /** A unique identifier for the chat completion. Each chunk has the same ID. */
  id: string;

  /**A list of chat completion choices. Can contain more than one elements if `n` is greater than 1. Can also be empty for the
  last chunk if you set `stream_options: {"include_usage": true}`.*/
  choices: CreateChatCompletionStreamResponseChoices[];

  /** The Unix timestamp (in seconds) of when the chat completion was created. Each chunk has the same timestamp. */
  #suppress "@azure-tools/typespec-azure-core/no-generic-numeric" "Auto-suppressed warnings non-applicable rules during import."
  created: integer;

  /** The model to generate the completion. */
  `model`: string;

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Auto-suppressed warnings non-applicable rules during import."
  #suppress "@azure-tools/typespec-azure-core/casing-style" "Auto-suppressed warnings non-applicable rules during import."
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Auto-suppressed warnings non-applicable rules during import."
  service_tier?: ServiceTier;

  /**This fingerprint represents the backend configuration that the model runs with.
  Can be used in conjunction with the `seed` request parameter to understand when backend changes have been made that might impact determinism.*/
  #suppress "@azure-tools/typespec-azure-core/casing-style" "Auto-suppressed warnings non-applicable rules during import."
  system_fingerprint?: string;

  /** The object type, which is always `chat.completion.chunk`. */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "Auto-suppressed warnings non-applicable rules during import."
  @extension("x-stainless-const", true)
  object: "chat.completion.chunk";

  /**An optional field that will only be present when you set
  `stream_options: {"include_usage": true}` in your request. When present, it
  contains a null value **except for the last chunk** which contains the
  token usage statistics for the entire request.

  **NOTE:** If the stream is interrupted or cancelled, you may not
  receive the final usage chunk which contains the total token usage for
  the request.*/
  usage?: CompletionUsage;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Auto-suppressed warnings non-applicable rules during import."
model CreateChatCompletionStreamResponseChoices {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Auto-suppressed warnings non-applicable rules during import."
  delta: ChatCompletionStreamResponseDelta;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Auto-suppressed warnings non-applicable rules during import."
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Auto-suppressed warnings non-applicable rules during import."
  logprobs?: CreateChatCompletionStreamResponseChoicesLogprobs | null;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Auto-suppressed warnings non-applicable rules during import."
  #suppress "@azure-tools/typespec-azure-core/casing-style" "Auto-suppressed warnings non-applicable rules during import."
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Auto-suppressed warnings non-applicable rules during import."
  #suppress "@azure-tools/typespec-azure-core/no-closed-literal-union" "Auto-suppressed warnings non-applicable rules during import."
  finish_reason:
    | "stop"
    | "length"
    | "tool_calls"
    | "content_filter"
    | "function_call"
    | null;
  #suppress "@azure-tools/typespec-azure-core/no-generic-numeric" "Auto-suppressed warnings non-applicable rules during import."
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Auto-suppressed warnings non-applicable rules during import."
  index: integer;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Auto-suppressed warnings non-applicable rules during import."
model CreateChatCompletionStreamResponseChoicesLogprobs {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Auto-suppressed warnings non-applicable rules during import."
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Auto-suppressed warnings non-applicable rules during import."
  content: ChatCompletionTokenLogprob[] | null;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Auto-suppressed warnings non-applicable rules during import."
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Auto-suppressed warnings non-applicable rules during import."
  refusal: ChatCompletionTokenLogprob[] | null;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Auto-suppressed warnings non-applicable rules during import."
model CreateChatCompletionStreamingResponse {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Auto-suppressed warnings non-applicable rules during import."
  @header
  contentType: "text/event-stream";

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Auto-suppressed warnings non-applicable rules during import."
  @body
  body: CreateChatCompletionStreamResponse;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Auto-suppressed warnings non-applicable rules during import."
model UpdateChatCompletionParametersBody {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Auto-suppressed warnings non-applicable rules during import."
  metadata: Metadata;
}

/**Output types that you would like the model to generate for this request.
Most models are capable of generating text, which is the default:

`["text"]`

The `gpt-4o-audio-preview` model can also be used to [generate audio](https://platform.openai.com/docs/guides/audio). To
request that this model generate both text and audio responses, you can
use:

`["text", "audio"]`*/
union ChatCompletionModalities {
  #suppress "@azure-tools/typespec-azure-core/no-closed-literal-union" "Auto-suppressed warnings non-applicable rules during import."
  ("text" | "audio")[],
  null,
}

/** The role of the author of a message */
#suppress "@azure-tools/typespec-azure-core/no-enum" "Auto-suppressed warnings non-applicable rules during import."
enum ChatCompletionRole {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Auto-suppressed warnings non-applicable rules during import."
  developer,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Auto-suppressed warnings non-applicable rules during import."
  system,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Auto-suppressed warnings non-applicable rules during import."
  user,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Auto-suppressed warnings non-applicable rules during import."
  assistant,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Auto-suppressed warnings non-applicable rules during import."
  tool,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Auto-suppressed warnings non-applicable rules during import."
  function,
}

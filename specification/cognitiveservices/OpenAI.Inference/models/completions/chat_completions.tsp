import "@typespec/rest";
import "@typespec/http";
import "@typespec/versioning";
import "@azure-tools/typespec-client-generator-core";

import "./azure_chat_extensions.tsp";
import "./azure_content_filtering.tsp";
import "./chat_messages.tsp";
import "./common.tsp";
import "./functions.tsp";
import "./tools.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using TypeSpec.Versioning;
using Azure.ClientGenerator.Core;

namespace Azure.OpenAI;

@added(ServiceApiVersions.v2024_02_15_Preview)
@doc("""
  An abstract representation of a response format configuration usable by Chat Completions. Can be used to enable JSON
  mode.
  """)
@discriminator("type")
model ChatCompletionsResponseFormat {
  #suppress "@azure-tools/typespec-azure-core/no-string-discriminator" "Existing"
  @doc("The discriminated type for the response format.")
  type: string;
}

@doc("""
  The standard Chat Completions response format that can freely generate text and is not guaranteed to produce response
  content that adheres to a specific schema.
  """)
@added(ServiceApiVersions.v2024_02_15_Preview)
model ChatCompletionsTextResponseFormat extends ChatCompletionsResponseFormat {
  @doc("The discriminated object type, which is always 'text' for this format.")
  type: "text";
}

@doc("""
  A response format for Chat Completions that restricts responses to emitting valid JSON objects.
  """)
@added(ServiceApiVersions.v2024_02_15_Preview)
model ChatCompletionsJsonResponseFormat extends ChatCompletionsResponseFormat {
  @doc("The discriminated object type, which is always 'json_object' for this format.")
  type: "json_object";
}

@added(ServiceApiVersions.v2024_08_01_Preview)
@doc("""
  A response format for Chat Completions that restricts responses to emitting JSON that conforms to a provided JSON
  Schema for Structured Outputs.
  """)
model ChatCompletionsJsonSchemaResponseFormat
  extends ChatCompletionsResponseFormat {
  @doc("The discriminated object type, which is always 'json_schema' for this format.")
  type: "json_schema";

  #suppress "@azure-tools/typespec-azure-core/casing-style" "this represents the case-sensitive wire format"
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "OpenAI uses explicitly required, nullable types"
  json_schema: {
    /** A description of what the response format is for, used by the model to determine how to respond in the format. */
    description?: string;

    /** The name of the response format. Must be a-z, A-Z, 0-9, or contain underscores and dashes, with a maximum length of 64. */
    name: string;

    #suppress "@azure-tools/typespec-azure-core/no-unknown" "External API shape takes an arbitrary json"
    schema?: unknown;

    @doc("""
      Whether to enable strict schema adherence when generating the output. If set to true, the model will always follow the exact schema defined in the `schema` field. Only a subset of JSON Schema is supported when `strict` is `true`. To learn more, read the [Structured Outputs guide](/docs/guides/structured-outputs).
      """)
    strict?: boolean | null = false;
  };
}

/**
 * Options for streaming response. Only set this when you set `stream: true`.
 */
@added(ServiceApiVersions.v2024_09_01_Preview)
model ChatCompletionStreamOptions {
  /**
   * If set, an additional chunk will be streamed before the `data: [DONE]` message. The `usage` field on this chunk shows the token usage statistics for the entire request, and the `choices` field will always be an empty array. All other chunks will also include a `usage` field, but with a null value.
   */
  @encodedName("application/json", "include_usage")
  includeUsage?: boolean;
}

@doc("""
  The configuration information for a chat completions request.
  Completions support a wide variety of tasks and generate text that continues from or "completes"
  provided prompt data.
  """)
@added(ServiceApiVersions.v2023_05_15)
model ChatCompletionsOptions {
  @doc("""
    The collection of context messages associated with this chat completions request.
    Typical usage begins with a chat message for the System role that provides instructions for
    the behavior of the assistant, followed by alternating messages between the User and
    Assistant roles.
    """)
  messages: ChatRequestMessage[];

  @doc("A list of functions the model may generate JSON inputs for.")
  @added(ServiceApiVersions.v2023_07_01_Preview)
  functions?: FunctionDefinition[];

  @doc("""
    Controls how the model responds to function calls. "none" means the model does not call a function,
    and responds to the end-user. "auto" means the model can pick between an end-user or calling a function.
     Specifying a particular function via `{"name": "my_function"}` forces the model to call that function.
     "none" is the default when no functions are present. "auto" is the default if functions are present.
    """)
  @encodedName("application/json", "function_call")
  @added(ServiceApiVersions.v2023_07_01_Preview)
  functionCall?: FunctionCallConfig;

  /**
   * The maximum number of tokens allowed for the generated answer. By default, the number of tokens the model can return will be (4096 - prompt tokens).
   *
   * This value is now deprecated in favor of `max_completion_tokens`, and is not compatible with o1 series models.
   */
  #deprecated "Field deprecated since v2024-09-01-preview service version."
  @encodedName("application/json", "max_tokens")
  maxTokens?: int32;

  /**
   * An upper bound for the number of tokens that can be generated for a completion, including visible output tokens and reasoning tokens.
   */
  @encodedName("application/json", "max_completion_tokens")
  @added(ServiceApiVersions.v2024_09_01_Preview)
  maxCompletionTokens?: int32;

  @doc("""
    The sampling temperature to use that controls the apparent creativity of generated completions.
    Higher values will make output more random while lower values will make results more focused
    and deterministic.
    It is not recommended to modify temperature and top_p for the same completions request as the
    interaction of these two settings is difficult to predict.
    """)
  temperature?: float32;

  @doc("""
    An alternative to sampling with temperature called nucleus sampling. This value causes the
    model to consider the results of tokens with the provided probability mass. As an example, a
    value of 0.15 will cause only the tokens comprising the top 15% of probability mass to be
    considered.
    It is not recommended to modify temperature and top_p for the same completions request as the
    interaction of these two settings is difficult to predict.
    """)
  @encodedName("application/json", "top_p")
  @clientName("NucleusSamplingFactor", "csharp")
  topP?: float32;

  @doc("""
    A map between GPT token IDs and bias scores that influences the probability of specific tokens
    appearing in a completions response. Token IDs are computed via external tokenizer tools, while
    bias scores reside in the range of -100 to 100 with minimum and maximum values corresponding to
    a full ban or exclusive selection of a token, respectively. The exact behavior of a given bias
    score varies by model.
    """)
  @encodedName("application/json", "logit_bias")
  @clientName("TokenSelectionBiases", "csharp")
  logitBias?: Record<int32>;

  @doc("""
    An identifier for the caller or end user of the operation. This may be used for tracking
    or rate-limiting purposes.
    """)
  user?: string;

  @doc("""
    The number of chat completions choices that should be generated for a chat completions
    response.
    Because this setting can generate many completions, it may quickly consume your token quota.
    Use carefully and ensure reasonable settings for max_tokens and stop.
    """)
  @clientName("ChoiceCount", "csharp")
  n?: int32;

  @doc("""
    A collection of textual sequences that will end completions generation.
    """)
  @clientName("StopSequences", "csharp")
  stop?: string[];

  @doc("""
    A value that influences the probability of generated tokens appearing based on their existing
    presence in generated text.
    Positive values will make tokens less likely to appear when they already exist and increase the
    model's likelihood to output new topics.
    """)
  @encodedName("application/json", "presence_penalty")
  presencePenalty?: float32;

  @doc("""
    A value that influences the probability of generated tokens appearing based on their cumulative
    frequency in generated text.
    Positive values will make tokens less likely to appear as their frequency increases and
    decrease the likelihood of the model repeating the same statements verbatim.
    """)
  @encodedName("application/json", "frequency_penalty")
  frequencyPenalty?: float32;

  @doc("""
    A value indicating whether chat completions should be streamed for this request.
    """)
  @clientName("InternalShouldStreamResponse", "csharp")
  stream?: boolean;

  /**
   * Options for streaming response. Only set this when you set `stream: true`.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "OpenAI uses explicitly required, nullable types"
  @encodedName("application/json", "stream_options")
  @added(ServiceApiVersions.v2024_09_01_Preview)
  streamOptions?: ChatCompletionStreamOptions | null;

  @doc("""
    The model name to provide as part of this completions request.
    Not applicable to Azure OpenAI, where deployment information should be included in the Azure
    resource URI that's connected to.
    """)
  @clientName("DeploymentName", "csharp")
  `model`?: string;

  @doc("""
      The configuration entries for Azure OpenAI chat extensions that use them.
      This additional specification is only compatible with Azure OpenAI.
    """)
  // Note: client libraries should represent the `dataSources` information for Azure OpenAI chat extensions in a way
  //        that differs from the wire format. To wit: the array should appear on a custom sub-options type (as if
  //        the array were in an appropriate parent JSON object on the wire) and type/field names should converge on
  //        "extensions" instead of "data sources" for representing the additional configuration information. A future
  //        service API version will absorb these proposed changes and allow us to retire the extra complexity.
  @added(ServiceApiVersions.v2024_02_15_Preview)
  @encodedName("application/json", "data_sources")
  @clientName("InternalAzureExtensionsDataSources", "csharp")
  dataSources?: AzureChatExtensionConfiguration[];

  @added(ServiceApiVersions.v2024_02_15_Preview)
  @doc("If provided, the configuration options for available Azure OpenAI chat enhancements.")
  enhancements?: AzureChatEnhancementConfiguration;

  @added(ServiceApiVersions.v2024_02_15_Preview)
  @doc("""
    If specified, the system will make a best effort to sample deterministically such that repeated requests with the
    same seed and parameters should return the same result. Determinism is not guaranteed, and you should refer to the
    system_fingerprint response parameter to monitor changes in the backend."
    """)
  seed?: int64;

  #suppress "@azure-tools/typespec-azure-core/no-nullable" "OpenAI uses explicitly nullable types"
  @added(ServiceApiVersions.v2024_02_15_Preview)
  @doc("""
    Whether to return log probabilities of the output tokens or not. If true, returns the log probabilities of each output token returned in the `content` of `message`. This option is currently not available on the `gpt-4-vision-preview` model.
    """)
  logprobs?: boolean | null = false;

  #suppress "@azure-tools/typespec-azure-core/casing-style" "OpenAI uses wire-format snake_casing"
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "OpenAI uses explicitly required, nullable types"
  @added(ServiceApiVersions.v2024_02_15_Preview)
  @doc("""
    An integer between 0 and 5 specifying the number of most likely tokens to return at each token position, each with an associated log probability. `logprobs` must be set to `true` if this parameter is used.
    """)
  top_logprobs?: int32 | null;

  @encodedName("application/json", "response_format")
  @added(ServiceApiVersions.v2024_02_15_Preview)
  @doc("An object specifying the format that the model must output. Used to enable JSON mode.")
  responseFormat?: ChatCompletionsResponseFormat;

  @added(ServiceApiVersions.v2024_02_15_Preview)
  @doc("The available tool definitions that the chat completions request can use, including caller-defined functions.")
  tools?: ChatCompletionsToolDefinition[];

  #suppress "@azure-tools/typespec-azure-core/casing-style" "OpenAI uses wire-format snake_casing"
  @encodedName("application/json", "tool_choice")
  @added(ServiceApiVersions.v2024_02_15_Preview)
  @doc("""
    If specified, the model will configure which of the provided tools it can use for the chat completions response.
    """)
  toolChoice?: ChatCompletionsToolSelection;

  /**
   * Whether to enable parallel function calling during tool use.
   */
  @added(ServiceApiVersions.v2024_09_01_Preview)
  @encodedName("application/json", "parallel_tool_calls")
  parallelToolCalls?: boolean = true;
}

@doc("""
  The representation of a single prompt completion as part of an overall chat completions request.
  Generally, `n` choices are generated per provided prompt with a default value of 1.
  Token limits and other settings may limit the number of choices generated.
  """)
@added(ServiceApiVersions.v2023_05_15)
model ChatChoice {
  @doc("The chat message for a given chat completions prompt.")
  message?: ChatResponseMessage;

  #suppress "@azure-tools/typespec-azure-core/no-nullable" "OpenAI uses explicitly required, nullable types"
  @added(ServiceApiVersions.v2024_02_15_Preview)
  @doc("The log probability information for this choice, as enabled via the 'logprobs' request option.")
  logprobs: ChatChoiceLogProbabilityInfo | null;

  @doc("The ordered index associated with this chat completions choice.")
  index: int32;

  #suppress "@azure-tools/typespec-azure-core/no-nullable" "OpenAI uses explicitly required, nullable types"
  #suppress "@azure-tools/typespec-autorest/union-unsupported" "OpenAPI v2 support deferred"
  @doc("The reason that this chat completions choice completed its generated.")
  @encodedName("application/json", "finish_reason")
  finishReason: CompletionsFinishReason | null;

  // Note: this property was briefly present for gpt-4-vision-preview; it's retained here for posterity for the
  // lifetime of the service API versions impacted.

  @doc("""
    The reason the model stopped generating tokens, together with any applicable details.
    This structured representation replaces 'finish_reason' for some models.
    """)
  @added(ServiceApiVersions.v2024_02_15_Preview)
  @removed(ServiceApiVersions.v2024_07_01_Preview)
  @encodedName("application/json", "finish_details")
  finishDetails?: ChatFinishDetails;

  @doc("The delta message content for a streaming response.")
  @clientName("InternalStreamingDeltaMessage", "csharp")
  delta?: ChatResponseMessage;

  @doc("""
    Information about the content filtering category (hate, sexual, violence, self_harm), if it
    has been detected, as well as the severity level (very_low, low, medium, high-scale that
    determines the intensity and risk level of harmful content) and if it has been filtered or not.
    """)
  @added(ServiceApiVersions.v2023_06_01_Preview)
  @encodedName("application/json", "content_filter_results")
  contentFilterResults?: ContentFilterResultsForChoice;

  @added(ServiceApiVersions.v2024_02_15_Preview)
  @doc("""
    Represents the output results of Azure OpenAI enhancements to chat completions, as configured via the matching input
    provided in the request. This supplementary information is only available when using Azure OpenAI and only when the
    request is configured to use enhancements.
    """)
  enhancements?: AzureChatEnhancements;
}

@doc("""
  Representation of the response data from a chat completions request.
  Completions support a wide variety of tasks and generate text that continues from or "completes"
  provided prompt data.
  """)
@added(ServiceApiVersions.v2023_05_15)
model ChatCompletions {
  @doc("A unique identifier associated with this chat completions response.")
  id: string;

  @doc("""
    The first timestamp associated with generation activity for this completions response,
    represented as seconds since the beginning of the Unix epoch of 00:00 on 1 Jan 1970.
    """)
  @clientName("createdAt", "java")
  @encode(DateTimeKnownEncoding.unixTimestamp, int32)
  created: utcDateTime;

  @doc("""
    The collection of completions choices associated with this completions response.
    Generally, `n` choices are generated per provided prompt with a default value of 1.
    Token limits and other settings may limit the number of choices generated.
    """)
  choices: ChatChoice[];

  @doc("The model name used for this completions request.")
  `model`?: string;

  @doc("""
    Content filtering results for zero or more prompts in the request. In a streaming request,
    results for different prompts may arrive at different times or in different orders.
    """)
  @added(ServiceApiVersions.v2023_06_01_Preview)
  @encodedName("application/json", "prompt_filter_results")
  promptFilterResults?: ContentFilterResultsForPrompt[];

  @added(ServiceApiVersions.v2024_02_15_Preview)
  @encodedName("application/json", "system_fingerprint")
  @doc("""
    Can be used in conjunction with the `seed` request parameter to understand when backend changes have been made that
    might impact determinism.
    """)
  systemFingerprint?: string;

  @doc("""
    Usage information for tokens processed and generated as part of this completions operation.
    """)
  usage: CompletionsUsage;
}

@added(ServiceApiVersions.v2024_02_15_Preview)
@discriminator("type")
@doc("An abstract representation of structured information about why a chat completions response terminated.")
model ChatFinishDetails {
  #suppress "@azure-tools/typespec-azure-core/no-string-discriminator" "Existing"
  @doc("The object type.")
  type: string;
}

@doc("A structured representation of a stop reason that signifies natural termination by the model.")
@added(ServiceApiVersions.v2024_02_15_Preview)
model StopFinishDetails extends ChatFinishDetails {
  @doc("The object type, which is always 'stop' for this object.")
  type: "stop";

  @doc("The token sequence that the model terminated with.")
  stop: string;
}

@doc("""
  A structured representation of a stop reason that signifies a token limit was reached before the model could naturally
  complete.
  """)
@added(ServiceApiVersions.v2024_02_15_Preview)
model MaxTokensFinishDetails extends ChatFinishDetails {
  @doc("The object type, which is always 'max_tokens' for this object.")
  type: "max_tokens";
}

@added(ServiceApiVersions.v2024_02_15_Preview)
@doc("""
  Log probability information for a choice, as requested via 'logprobs' and 'top_logprobs'.
  """)
model ChatChoiceLogProbabilityInfo {
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "OpenAI uses explicitly required, nullable types"
  @doc("""
    The list of log probability information entries for the choice's message content tokens, as requested via the 'logprobs' option.
    """)
  content: ChatTokenLogProbabilityResult[] | null;

  #suppress "@azure-tools/typespec-azure-core/no-nullable" "OpenAI uses explicitly required, nullable types"
  @added(ServiceApiVersions.v2024_08_01_Preview)
  @doc("""
    The list of log probability information entries for the choice's message refusal message tokens, as requested via the 'logprobs' option.
    """)
  refusal: ChatTokenLogProbabilityResult[] | null;
}

@added(ServiceApiVersions.v2024_02_15_Preview)
@doc("""
  A representation of the log probability information for a single content token, including a list of most likely tokens if 'top_logprobs' were requested.
  """)
model ChatTokenLogProbabilityResult {
  ...ChatTokenLogProbabilityInfo;

  #suppress "@azure-tools/typespec-azure-core/no-nullable" "OpenAI uses explicitly required, nullable types"
  #suppress "@azure-tools/typespec-azure-core/casing-style" "OpenAI uses wire-format snake_casing"
  @doc("The list of most likely tokens and their log probability information, as requested via 'top_logprobs'.")
  top_logprobs: ChatTokenLogProbabilityInfo[] | null;
}

@added(ServiceApiVersions.v2024_02_15_Preview)
@doc("""
  A representation of the log probability information for a single message content token.
  """)
model ChatTokenLogProbabilityInfo {
  @doc("The message content token.")
  token: string;

  @doc("The log probability of the message content token.")
  logprob: float32;

  #suppress "@azure-tools/typespec-azure-core/no-nullable" "OpenAI uses explicitly required, nullable types"
  @doc("""
    A list of integers representing the UTF-8 bytes representation of the token. Useful in instances where characters are represented by multiple tokens and their byte representations must be combined to generate the correct text representation. Can be null if there is no bytes representation for the token.
    """)
  bytes: int32[] | null;
}

/**
 * Get chat completions request body.
 */
@added(ServiceApiVersions.v2023_05_15)
model GetChatCompletionsBody {
  /**
   * The configuration information for a chat completions request.
   * Completions support a wide variety of tasks and generate text that continues from or "completes"
   * provided prompt data.
   */
  @bodyRoot
  body: ChatCompletionsOptions;
}

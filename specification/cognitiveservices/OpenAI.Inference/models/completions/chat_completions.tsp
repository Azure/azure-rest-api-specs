import "@typespec/rest";
import "@typespec/http";
import "@typespec/versioning";

import "./azure_chat_extensions.tsp";
import "./azure_content_filtering.tsp";
import "./chat_messages.tsp";
import "./common.tsp";
import "./functions.tsp";
import "./tools.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using TypeSpec.Versioning;

namespace Azure.OpenAI;

@added(ServiceApiVersions.v2023_12_01_Preview)
@doc("""
An abstract representation of a response format configuration usable by Chat Completions. Can be used to enable JSON
mode.
""")
@discriminator("type")
model ChatCompletionsResponseFormat {
  @doc("The discriminated type for the response format.")
  type: string;
}

@doc("""
The standard Chat Completions response format that can freely generate text and is not guaranteed to produce response
content that adheres to a specific schema.
""")
@added(ServiceApiVersions.v2023_12_01_Preview)
model ChatCompletionsTextResponseFormat extends ChatCompletionsResponseFormat {
  @doc("The discriminated object type, which is always 'text' for this format.")
  type: "text";
}

@doc("""
A response format for Chat Completions that restricts responses to emitting valid JSON objects.
""")
@added(ServiceApiVersions.v2023_12_01_Preview)
model ChatCompletionsJsonResponseFormat extends ChatCompletionsResponseFormat {
  @doc("The discriminated object type, which is always 'json_object' for this format.")
  type: "json_object";
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
  @projectedName("json", "messages")
  messages: ChatRequestMessage[];

  @doc("A list of functions the model may generate JSON inputs for.")
  @added(ServiceApiVersions.v2023_07_01_Preview)
  @removed(ServiceApiVersions.v2023_12_01_Preview)
  functions?: FunctionDefinition[];

  @doc("""
    Controls how the model responds to function calls. "none" means the model does not call a function,
    and responds to the end-user. "auto" means the model can pick between an end-user or calling a function.
     Specifying a particular function via `{"name": "my_function"}` forces the model to call that function.
     "none" is the default when no functions are present. "auto" is the default if functions are present.
    """)
  @projectedName("json", "function_call")
  @added(ServiceApiVersions.v2023_07_01_Preview)
  @removed(ServiceApiVersions.v2023_12_01_Preview)
  functionCall?: FunctionCallConfig;

  @doc("The maximum number of tokens to generate.")
  @projectedName("json", "max_tokens")
  maxTokens?: int32;

  @doc("""
    The sampling temperature to use that controls the apparent creativity of generated completions.
    Higher values will make output more random while lower values will make results more focused
    and deterministic.
    It is not recommended to modify temperature and top_p for the same completions request as the
    interaction of these two settings is difficult to predict.
    """)
  @projectedName("json", "temperature")
  temperature?: float32;

  @doc("""
    An alternative to sampling with temperature called nucleus sampling. This value causes the
    model to consider the results of tokens with the provided probability mass. As an example, a
    value of 0.15 will cause only the tokens comprising the top 15% of probability mass to be
    considered.
    It is not recommended to modify temperature and top_p for the same completions request as the
    interaction of these two settings is difficult to predict.
    """)
  @projectedName("json", "top_p")
  @projectedName("csharp", "NucleusSamplingFactor")
  topP?: float32;

  @doc("""
    A map between GPT token IDs and bias scores that influences the probability of specific tokens
    appearing in a completions response. Token IDs are computed via external tokenizer tools, while
    bias scores reside in the range of -100 to 100 with minimum and maximum values corresponding to
    a full ban or exclusive selection of a token, respectively. The exact behavior of a given bias
    score varies by model.
    """)
  @projectedName("json", "logit_bias")
  @projectedName("csharp", "TokenSelectionBiases")
  logitBias?: Record<int32>;

  @doc("""
    An identifier for the caller or end user of the operation. This may be used for tracking
    or rate-limiting purposes.
    """)
  @projectedName("json", "user")
  user?: string;

  @doc("""
    The number of chat completions choices that should be generated for a chat completions
    response.
    Because this setting can generate many completions, it may quickly consume your token quota.
    Use carefully and ensure reasonable settings for max_tokens and stop.
    """)
  @projectedName("json", "n")
  @projectedName("csharp", "ChoiceCount")
  n?: int32;

  @doc("""
    A collection of textual sequences that will end completions generation.
    """)
  @projectedName("json", "stop")
  @projectedName("csharp", "StopSequences")
  stop?: string[];

  @doc("""
    A value that influences the probability of generated tokens appearing based on their existing
    presence in generated text.
    Positive values will make tokens less likely to appear when they already exist and increase the
    model's likelihood to output new topics.
    """)
  @projectedName("json", "presence_penalty")
  presencePenalty?: float32;

  @doc("""
    A value that influences the probability of generated tokens appearing based on their cumulative
    frequency in generated text.
    Positive values will make tokens less likely to appear as their frequency increases and
    decrease the likelihood of the model repeating the same statements verbatim.
    """)
  @projectedName("json", "frequency_penalty")
  frequencyPenalty?: float32;

  @doc("""
    A value indicating whether chat completions should be streamed for this request.
    """)
  @projectedName("json", "stream")
  @projectedName("csharp", "InternalShouldStreamResponse")
  stream?: boolean;

  @doc("""
    The model name to provide as part of this completions request.
    Not applicable to Azure OpenAI, where deployment information should be included in the Azure
    resource URI that's connected to.
    """)
  @projectedName("json", "model")
  @projectedName("csharp", "DeploymentName")
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
  @added(ServiceApiVersions.v2023_08_01_Preview)
  @projectedName("json", "dataSources")
  @projectedName("csharp", "InternalAzureExtensionsDataSources")
  dataSources?: AzureChatExtensionConfiguration[];

  @added(ServiceApiVersions.v2023_12_01_Preview)
  @doc("If provided, the configuration options for available Azure OpenAI chat enhancements.")
  enhancements?: AzureChatEnhancementConfiguration;

  @added(ServiceApiVersions.v2023_12_01_Preview)
  @doc("""
  If specified, the system will make a best effort to sample deterministically such that repeated requests with the
  same seed and parameters should return the same result. Determinism is not guaranteed, and you should refer to the
  system_fingerprint response parameter to monitor changes in the backend."
  """)
  seed?: int64;

  @projectedName("json", "response_format")
  @added(ServiceApiVersions.v2023_12_01_Preview)
  @doc("An object specifying the format that the model must output. Used to enable JSON mode.")
  responseFormat?: ChatCompletionsResponseFormat;

  @added(ServiceApiVersions.v2023_12_01_Preview)
  @doc("The available tool definitions that the chat completions request can use, including caller-defined functions.")
  tools?: ChatCompletionsToolDefinition[];

  @projectedName("json", "tool_choice")
  @added(ServiceApiVersions.v2023_12_01_Preview)
  @doc("""
  If specified, the model will configure which of the provided tools it can use for the chat completions response.
  """)
  toolChoice?: ChatCompletionsToolSelection;
}

@doc("""
The representation of a single prompt completion as part of an overall chat completions request.
Generally, `n` choices are generated per provided prompt with a default value of 1.
Token limits and other settings may limit the number of choices generated.
""")
@added(ServiceApiVersions.v2023_05_15)
model ChatChoice {
  @doc("The chat message for a given chat completions prompt.")
  @projectedName("json", "message")
  message?: ChatResponseMessage;

  @doc("The ordered index associated with this chat completions choice.")
  @projectedName("json", "index")
  index: int32;

  #suppress "@azure-tools/typespec-azure-core/no-nullable" "The operation already returns nulls"
  #suppress "@azure-tools/typespec-autorest/union-unsupported" "OpenAPI v2 support deferred"
  @doc("The reason that this chat completions choice completed its generated.")
  @projectedName("json", "finish_reason")
  finishReason: CompletionsFinishReason | null;

  // Note: this property is currently speculative via observation and not yet documented anywhere.
  @doc("""
  The reason the model stopped generating tokens, together with any applicable details.
  This structured representation replaces 'finish_reason' for some models.
  """)
  @added(ServiceApiVersions.v2023_12_01_Preview)
  @projectedName("json", "finish_details")
  finishDetails?: ChatFinishDetails;

  @doc("The delta message content for a streaming response.")
  @projectedName("json", "delta")
  @projectedName("csharp", "InternalStreamingDeltaMessage")
  delta?: ChatResponseMessage;

  @doc("""
    Information about the content filtering category (hate, sexual, violence, self_harm), if it
    has been detected, as well as the severity level (very_low, low, medium, high-scale that
    determines the intensity and risk level of harmful content) and if it has been filtered or not.
    """)
  @added(ServiceApiVersions.v2023_06_01_Preview)
  @projectedName("json", "content_filter_results")
  contentFilterResults?: ContentFilterResultsForChoice;

  @added(ServiceApiVersions.v2023_12_01_Preview)
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
  @projectedName("json", "id")
  id: string;

  @doc("""
    The first timestamp associated with generation activity for this completions response,
    represented as seconds since the beginning of the Unix epoch of 00:00 on 1 Jan 1970.
    """)
  @projectedName("json", "created")
  @projectedName("java", "createdAt")
  @encode(DateTimeKnownEncoding.unixTimestamp, int32)
  created: utcDateTime;

  @doc("""
    The collection of completions choices associated with this completions response.
    Generally, `n` choices are generated per provided prompt with a default value of 1.
    Token limits and other settings may limit the number of choices generated.
    """)
  @projectedName("json", "choices")
  choices: ChatChoice[];

  @doc("""
  Content filtering results for zero or more prompts in the request. In a streaming request,
  results for different prompts may arrive at different times or in different orders.
  """)
  @added(ServiceApiVersions.v2023_06_01_Preview)
  @projectedName("json", "prompt_filter_results")
  promptFilterResults?: ContentFilterResultsForPrompt[];

  @added(ServiceApiVersions.v2023_12_01_Preview)
  @projectedName("json", "system_fingerprint")
  @doc("""
  Can be used in conjunction with the `seed` request parameter to understand when backend changes have been made that
  might impact determinism.
  """)
  systemFingerprint?: string;

  @doc("""
    Usage information for tokens processed and generated as part of this completions operation.
    """)
  @projectedName("json", "usage")
  usage: CompletionsUsage;
}

@added(ServiceApiVersions.v2023_12_01_Preview)
@discriminator("type")
@doc("An abstract representation of structured information about why a chat completions response terminated.")
model ChatFinishDetails {
  @doc("The object type.")
  type: string;
}

@doc("A structured representation of a stop reason that signifies natural termination by the model.")
@added(ServiceApiVersions.v2023_12_01_Preview)
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
@added(ServiceApiVersions.v2023_12_01_Preview)
model MaxTokensFinishDetails extends ChatFinishDetails {
  @doc("The object type, which is always 'max_tokens' for this object.")
  type: "max_tokens";
}

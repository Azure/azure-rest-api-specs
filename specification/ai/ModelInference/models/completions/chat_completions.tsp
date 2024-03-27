import "@typespec/rest";
import "@typespec/http";
import "@typespec/versioning";

import "./chat_messages.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using TypeSpec.Versioning;

namespace ModelInference;

@doc("""
Representation of the token counts processed for a completions request.
Counts consider all tokens across prompts, choices, choice alternates, best_of generations, and
other consumers.
""")
model CompletionsUsage {
  @doc("The number of tokens generated across all completions emissions.")
  @projectedName("json", "completion_tokens")
  completionTokens: int32;

  @doc("The number of tokens in the provided prompts for the completions request.")
  @projectedName("json", "prompt_tokens")
  promptTokens: int32;

  @doc("The total number of tokens processed for the completions request and response.")
  @projectedName("json", "total_tokens")
  totalTokens: int32;
}

@doc("""
Representation of the manner in which a completions response concluded.
""")
enum CompletionsFinishReason {
  @doc("Completions ended normally and reached its end of token generation.")
  stopped: "stop",

  @doc("Completions exhausted available token limits before generation could complete.")
  tokenLimitReached: "length",

  @doc("""
    Completions generated a response that was identified as potentially sensitive per content
    moderation policies.
    """)
  contentFiltered: "content_filter",
}

@doc("A description of the intended purpose of a message within a chat completions interaction.")
enum ChatRole {
  @doc("The role that instructs or sets the behavior of the assistant.")
  system: "system",

  @doc("The role that provides responses to system-instructed, user-prompted input.")
  assistant: "assistant",

  @doc("The role that provides input for chat completions.")
  user: "user",
}

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
model ChatCompletionsTextResponseFormat extends ChatCompletionsResponseFormat {
  @doc("The discriminated object type, which is always 'text' for this format.")
  type: "text";
}

@doc("""
A response format for Chat Completions that restricts responses to emitting valid JSON objects.
""")
model ChatCompletionsJsonResponseFormat extends ChatCompletionsResponseFormat {
  @doc("The discriminated object type, which is always 'json_object' for this format.")
  type: "json_object";
}

@doc("""
The configuration information for a chat completions request.
Completions support a wide variety of tasks and generate text that continues from or "completes"
provided prompt data.
""")
model ChatCompletionsOptions {
  @doc("""
    The collection of context messages associated with this chat completions request.
    Typical usage begins with a chat message for the System role that provides instructions for
    the behavior of the assistant, followed by alternating messages between the User and
    Assistant roles.
    """)
  @projectedName("json", "messages")
  messages: ChatRequestMessage[];

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
  topP?: float32;

  @doc("""
    A collection of textual sequences that will end completions generation.
    """)
  @projectedName("json", "stop")
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
  stream?: boolean;

  @doc("""
  If specified, the system will make a best effort to sample deterministically such that repeated requests with the
  same seed and parameters should return the same result. Determinism is not guaranteed, and you should refer to the
  system_fingerprint response parameter to monitor changes in the backend."
  """)
  seed?: int64;

  @projectedName("json", "response_format")
  @doc("An object specifying the format that the model must output. Used to enable JSON mode.")
  responseFormat?: ChatCompletionsResponseFormat;
}

@doc("""
The representation of a single prompt completion as part of an overall chat completions request.
Generally, `n` choices are generated per provided prompt with a default value of 1.
Token limits and other settings may limit the number of choices generated.
""")
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
}

@doc("""
Representation of the response data from a chat completions request.
Completions support a wide variety of tasks and generate text that continues from or "completes"
provided prompt data.
""")
model ChatCompletions {
  @doc("A unique identifier associated with this chat completions response.")
  @projectedName("json", "id")
  id: string;

  @doc("""
    The first timestamp associated with generation activity for this completions response,
    represented as seconds since the beginning of the Unix epoch of 00:00 on 1 Jan 1970.
    """)
  @projectedName("json", "created")
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
  Usage information for tokens processed and generated as part of this completions operation.
  """)
  @projectedName("json", "usage")
  usage: CompletionsUsage;

  @doc("The response object type, which is always `chat.completion`.")
  @projectedName("json", "object")
  object: string;

  @doc("The model used for the chat completion.")
  @projectedName("json", "model")
  `model`: string;
}

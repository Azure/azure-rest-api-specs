import "@azure-tools/typespec-client-generator-core";
import "@typespec/rest";
import "@typespec/http";

using TypeSpec.Rest;
using TypeSpec.Http;

using Azure.ClientGenerator.Core;

namespace ModelInference;

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
  @minItems(1)
  messages: ChatRequestMessage[];

  @doc("""
    A value that influences the probability of generated tokens appearing based on their cumulative
    frequency in generated text.
    Positive values will make tokens less likely to appear as their frequency increases and
    decrease the likelihood of the model repeating the same statements verbatim.
    Supported range is [-2, 2].
    """)
  @maxValue(2.0)
  @minValue(-2.0)
  frequency_penalty?: float32 = 0.0;

  @doc("""
    A value indicating whether chat completions should be streamed for this request.
    """)
  @clientName("InternalShouldStreamResponse", "csharp")
  stream?: boolean;

  @doc("""
    A value that influences the probability of generated tokens appearing based on their existing
    presence in generated text.
    Positive values will make tokens less likely to appear when they already exist and increase the
    model's likelihood to output new topics.
    Supported range is [-2, 2].
    """)
  @maxValue(2.0)
  @minValue(-2.0)
  presence_penalty?: float32 = 0.0;

  @doc("""
    The sampling temperature to use that controls the apparent creativity of generated completions.
    Higher values will make output more random while lower values will make results more focused
    and deterministic.
    It is not recommended to modify temperature and top_p for the same completions request as the
    interaction of these two settings is difficult to predict.
    Supported range is [0, 1].
    """)
  @maxValue(1.0)
  @minValue(0.0)
  temperature?: float32 = 0.7;

  @doc("""
    An alternative to sampling with temperature called nucleus sampling. This value causes the
    model to consider the results of tokens with the provided probability mass. As an example, a
    value of 0.15 will cause only the tokens comprising the top 15% of probability mass to be
    considered.
    It is not recommended to modify temperature and top_p for the same completions request as the
    interaction of these two settings is difficult to predict.
    Supported range is [0, 1].
    """)
  @maxValue(1.0)
  @minValue(0.0)
  @clientName("NucleusSamplingFactor", "csharp")
  top_p?: float32 = 1.0;

  @doc("The maximum number of tokens to generate.")
  @minValue(0.0)
  max_tokens?: int32;

  @doc("""
    An object specifying the format that the model must output.
    
    Setting to `{ "type": "json_schema", "json_schema": {...} }` enables Structured Outputs which ensures the model will match your supplied JSON schema.
    
    Setting to `{ "type": "json_object" }` enables JSON mode, which ensures the message the model generates is valid JSON.
    
    **Important:** when using JSON mode, you **must** also instruct the model to produce JSON yourself via a system or user message. Without this, the model may generate an unending stream of whitespace until the generation reaches the token limit, resulting in a long-running and seemingly "stuck" request. Also note that the message content may be partially cut off if `finish_reason="length"`, which indicates the generation exceeded `max_tokens` or the conversation exceeded the max context length.
    """)
  response_format?: ChatCompletionsResponseFormat;

  @doc("""
    A collection of textual sequences that will end completions generation.
    """)
  @minItems(1)
  @clientName("StopSequences", "csharp")
  stop?: string[];

  @doc("""
    A list of tools the model may request to call. Currently, only functions are supported as a tool. The model
    may response with a function call request and provide the input arguments in JSON format for that function.
    """)
  @minItems(1)
  tools?: ChatCompletionsToolDefinition[];

  @encodedName("application/json", "tool_choice")
  @doc("""
    If specified, the model will configure which of the provided tools it can use for the chat completions response.
    """)
  toolChoice?: ChatCompletionsToolChoice;

  @doc("""
    If specified, the system will make a best effort to sample deterministically such that repeated requests with the
    same seed and parameters should return the same result. Determinism is not guaranteed.
    """)
  seed?: int64;

  @doc("""
    ID of the specific AI model to use, if more than one model is available on the endpoint.
    """)
  `model`?: string;

  @doc("""
    The modalities that the model is allowed to use for the chat completions response. The default modality
    is `text`. Indicating an unsupported modality combination results in an 422 error.
    """)
  modalities?: ChatCompletionsModality[];

  ...Record<unknown>;
}
@doc("The modalities that the model is allowed to use for the chat completions response.")
union ChatCompletionsModality {
  string,

  @doc("The model is only allowed to generate text.")
  text: "text",

  @doc("The model is allowed to generate audio.")
  audio: "audio",
}

alias ChatCompletionsCommon = {
  @doc("A unique identifier associated with this chat completions response.")
  id: string;

  @doc("The response object type, which is always `chat.completion`.")
  object: "chat.completion";

  #suppress "@microsoft/azure-openapi-validator/IntegerTypeMustHaveFormat" "Format is present but rule only allow int32 or int64."
  @doc("""
    The first timestamp associated with generation activity for this completions response,
    represented as seconds since the beginning of the Unix epoch of 00:00 on 1 Jan 1970.
    """)
  @encode(DateTimeKnownEncoding.unixTimestamp, int64)
  created: utcDateTime;

  @doc("The model used for the chat completion.")
  `model`: string;
};

@doc("""
  Representation of the response data from a chat completions request.
  Completions support a wide variety of tasks and generate text that continues from or "completes"
  provided prompt data.
  """)
model ChatCompletions {
  ...ChatCompletionsCommon;

  @doc("""
    The collection of completions choices associated with this completions response.
    Generally, `n` choices are generated per provided prompt with a default value of 1.
    Token limits and other settings may limit the number of choices generated.
    """)
  @minItems(1)
  choices: ChatChoice[];

  @doc("""
      Usage information for tokens processed and generated as part of this completions operation.
    """)
  usage: CompletionsUsage;
}

@doc("""
  Represents a response update to a chat completions request, when the service is streaming updates 
  using Server Sent Events (SSE).
  Completions support a wide variety of tasks and generate text that continues from or "completes"
  provided prompt data.
  """)
model StreamingChatCompletionsUpdate {
  ...ChatCompletionsCommon;

  @doc("""
    An update to the collection of completion choices associated with this completions response.
    Generally, `n` choices are generated per provided prompt with a default value of 1.
    Token limits and other settings may limit the number of choices generated.
    """)
  @minItems(1)
  choices: StreamingChatChoiceUpdate[];

  @doc("""
    Usage information for tokens processed and generated as part of this completions operation.
    """)
  usage?: CompletionsUsage;
}

@doc("""
  Representation of the token counts processed for a completions request.
  Counts consider all tokens across prompts, choices, choice alternates, best_of generations, and
  other consumers.
  """)
model CompletionsUsage {
  @doc("The number of tokens generated across all completions emissions.")
  completion_tokens: int32;

  @doc("The number of tokens in the provided prompts for the completions request.")
  prompt_tokens: int32;

  @doc("The total number of tokens processed for the completions request and response.")
  total_tokens: int32;

  @doc("Breakdown of tokens used in a completion.")
  completion_tokens_details?: CompletionsUsageDetails;

  @doc("Breakdown of tokens used in the prompt/chat history.")
  prompt_tokens_details?: PromptUsageDetails;
}

@doc("A breakdown of tokens used in a completion.")
model CompletionsUsageDetails {
  @doc("The number of tokens corresponding to audio input.")
  audio_tokens: int32;

  @doc("The total number of tokens processed for the completions request and response.")
  total_tokens: int32;
}

@doc("A breakdown of tokens used in the prompt/chat history.")
model PromptUsageDetails {
  @doc("The number of tokens corresponding to audio input.")
  audio_tokens: int32;

  @doc("The total number of tokens cached.")
  cached_tokens: int32;
}

@doc("""
  Representation of the manner in which a completions response concluded.
  """)
union CompletionsFinishReason {
  string,

  @doc("Completions ended normally and reached its end of token generation.")
  stopped: "stop",

  @doc("Completions exhausted available token limits before generation could complete.")
  tokenLimitReached: "length",

  @doc("""
    Completions generated a response that was identified as potentially sensitive per content
    moderation policies.
    """)
  contentFiltered: "content_filter",

  @doc("Completion ended with the model calling a provided tool for output.")
  toolCalls: "tool_calls",
}

@doc("A description of the intended purpose of a message within a chat completions interaction.")
union ChatRole {
  string,

  @doc("The role that instructs or sets the behavior of the assistant.")
  system: "system",

  @doc("The role that provides instructions to the model prioritized ahead of user messages.")
  developer: "developer",

  @doc("The role that provides input for chat completions.")
  user: "user",

  @doc("The role that provides responses to system-instructed, user-prompted input.")
  assistant: "assistant",

  @doc("The role that represents extension tool activity within a chat completions operation.")
  tool: "tool",
}

@doc("""
  Represents the format that the model must output. Use this to enable JSON mode instead of the default text mode.
  Note that to enable JSON mode, some AI models may also require you to instruct the model to produce JSON
  via a system or user message.
  """)
@discriminator("type")
model ChatCompletionsResponseFormat {
  @doc("The response format type to use for chat completions.")
  type: string;
}

@doc("""
  A response format for Chat Completions that emits text responses. This is the default response format.
  """)
model ChatCompletionsResponseFormatText extends ChatCompletionsResponseFormat {
  @doc("Response format type: always 'text' for this object.")
  type: "text";
}

@doc("""
  A response format for Chat Completions that restricts responses to emitting valid JSON objects.
  Note that to enable JSON mode, some AI models may also require you to instruct the model to produce JSON
  via a system or user message.
  """)
model ChatCompletionsResponseFormatJsonObject
  extends ChatCompletionsResponseFormat {
  @doc("Response format type: always 'json_object' for this object.")
  type: "json_object";
}

@doc("""
  The definition of the required JSON schema in the response, and associated metadata.
  """)
model ChatCompletionsResponseFormatJsonSchemaDefinition {
  /** The name of the response format. Must be a-z, A-Z, 0-9, or contain underscores and dashes, with a maximum length of 64. */
  name: string;

  /** The definition of the JSON schema */
  schema: Record<unknown>;

  /** A description of the response format, used by the AI model to determine how to generate responses in this format. */
  description?: string;

  @doc("""
    Whether to enable strict schema adherence when generating the output.
    If set to true, the model will always follow the exact schema defined in the `schema` field. Only a subset of
    JSON Schema is supported when `strict` is `true`.
    """)
  strict?: boolean = false;
}

@doc("""
  A response format for Chat Completions that restricts responses to emitting valid JSON objects, with a
  JSON schema specified by the caller.
  """)
model ChatCompletionsResponseFormatJsonSchema
  extends ChatCompletionsResponseFormat {
  @doc("""
    The type of response format being defined: `json_schema`
    """)
  type: "json_schema";

  /** The definition of the required JSON schema in the response, and associated metadata. */
  json_schema: ChatCompletionsResponseFormatJsonSchemaDefinition;
}

alias ChatChoiceCommon = {
  @doc("The ordered index associated with this chat completions choice.")
  index: int32;

  #suppress "@azure-tools/typespec-azure-core/no-nullable" "The operation already returns nulls"
  #suppress "@azure-tools/typespec-autorest/union-unsupported" "OpenAPI v2 support deferred"
  @doc("The reason that this chat completions choice completed its generated.")
  finish_reason: CompletionsFinishReason | null;
};

@doc("""
  The representation of a single prompt completion as part of an overall chat completions request.
  Generally, `n` choices are generated per provided prompt with a default value of 1.
  Token limits and other settings may limit the number of choices generated.
  """)
model ChatChoice {
  ...ChatChoiceCommon;

  @doc("The chat message for a given chat completions prompt.")
  message: ChatResponseMessage;
}

@doc("""
  Represents an update to a single prompt completion when the service is streaming updates 
  using Server Sent Events (SSE).
  Generally, `n` choices are generated per provided prompt with a default value of 1.
  Token limits and other settings may limit the number of choices generated.
  """)
model StreamingChatChoiceUpdate {
  ...ChatChoiceCommon;

  @doc("An update to the chat message for a given chat completions prompt.")
  delta: StreamingChatResponseMessageUpdate;
}

@discriminator("role")
@doc("An abstract representation of a chat message as provided in a request.")
model ChatRequestMessage {
  @doc("The chat role associated with this message.")
  role: ChatRole;
}

@doc("""
  A request chat message containing system instructions that influence how the model will generate a chat completions
  response.
  """)
model ChatRequestSystemMessage extends ChatRequestMessage {
  @doc("The chat role associated with this message, which is always 'system' for system messages.")
  role: ChatRole.system;

  @doc("The contents of the system message.")
  content: string;
}

@doc("A request chat message representing user input to the assistant.")
model ChatRequestUserMessage extends ChatRequestMessage {
  @doc("The chat role associated with this message, which is always 'user' for user messages.")
  role: ChatRole.user;

  #suppress "@azure-tools/typespec-autorest/union-unsupported" "External API shape is defined in OpenAPI 3.0 as oneOf."
  @doc("The contents of the user message, with available input types varying by selected model.")
  content: string | ChatMessageContentItem[];
}

@doc("A request chat message representing response or action from the assistant.")
model ChatRequestAssistantMessage extends ChatRequestMessage {
  @doc("The chat role associated with this message, which is always 'assistant' for assistant messages.")
  role: ChatRole.assistant;

  #suppress "@azure-tools/typespec-azure-core/no-nullable" "explicitly nullable in mirrored API"
  @doc("The content of the message.")
  content?: string;

  @encodedName("application/json", "tool_calls")
  @doc("""
    The tool calls that must be resolved and have their outputs appended to subsequent input messages for the chat
    completions request to resolve as configured.
    """)
  toolCalls?: ChatCompletionsToolCall[];

  @doc("""
      The audio generated by a previous response in a multi-turn conversation.
    """)
  audio?: ChatRequestAudioReference;
}

@doc("A reference to an audio response generated by the model.")
model ChatRequestAudioReference {
  @doc("""
      Unique identifier for the audio response. This value corresponds to the id of a previous audio completion.
    """)
  id: string;
}

@doc("A request chat message representing requested output from a configured tool.")
model ChatRequestToolMessage extends ChatRequestMessage {
  @doc("The chat role associated with this message, which is always 'tool' for tool messages.")
  role: ChatRole.tool;

  #suppress "@azure-tools/typespec-azure-core/no-nullable" "explicitly nullable in mirrored API"
  @doc("The content of the message.")
  content?: string;

  @encodedName("application/json", "tool_call_id")
  @doc("The ID of the tool call resolved by the provided content.")
  toolCallId: string;
}

@doc("A representation of a chat message update as received in a streaming response.")
model StreamingChatResponseMessageUpdate {
  @doc("The chat role associated with the message. If present, should always be 'assistant'")
  role?: ChatRole;

  //#suppress "@azure-tools/typespec-azure-core/no-nullable" "explicitly nullable in mirrored API"
  @doc("The content of the message.")
  content?: string;

  @encodedName("application/json", "tool_calls")
  @doc("""
    The tool calls that must be resolved and have their outputs appended to subsequent input messages for the chat
    completions request to resolve as configured.
    """)
  toolCalls?: StreamingChatResponseToolCallUpdate[];
}

@doc("A representation of a chat message as received in a response.")
model ChatResponseMessage {
  @doc("The chat role associated with the message.")
  role: ChatRole;

  #suppress "@azure-tools/typespec-azure-core/no-nullable" "explicitly nullable in mirrored API"
  @doc("The content of the message.")
  content: string | null;

  @encodedName("application/json", "tool_calls")
  @doc("""
    The tool calls that must be resolved and have their outputs appended to subsequent input messages for the chat
    completions request to resolve as configured.
    """)
  toolCalls?: ChatCompletionsToolCall[];

  @doc("""
      The audio generated by the model as a response to the messages if the model is configured to generate audio.
    """)
  audio?: ChatCompletionsAudio;
}

#suppress "@azure-tools/typespec-autorest/union-unsupported" "External API shape is defined in OpenAPI 3.0 as oneOf."
alias ChatCompletionsToolChoice = ChatCompletionsToolChoicePreset | ChatCompletionsNamedToolChoice;

@doc("Represents a generic policy for how a chat completions tool may be selected.")
union ChatCompletionsToolChoicePreset {
  string,

  @doc("""
    Specifies that the model may either use any of the tools provided in this chat completions request or
    instead return a standard chat completions response as if no tools were provided.
    """)
  auto: "auto",

  @doc("""
    Specifies that the model should not respond with a tool call and should instead provide a standard chat
    completions response. Response content may still be influenced by the provided tool definitions.
    """)
  none: "none",

  @doc("""
    Specifies that the model should respond with a call to one or more tools.
    """)
  required: "required",
}

@doc("A tool selection of a specific, named function tool that will limit chat completions to using the named function.")
model ChatCompletionsNamedToolChoice {
  @doc("The type of the tool. Currently, only `function` is supported.")
  type: "function";

  @doc("The function that should be called.")
  function: ChatCompletionsNamedToolChoiceFunction;
}

@doc("A tool selection of a specific, named function tool that will limit chat completions to using the named function.")
model ChatCompletionsNamedToolChoiceFunction {
  @doc("The name of the function that should be called.")
  name: string;
}

@doc("""
  The definition of a chat completions tool that can call a function.
  """)
model ChatCompletionsToolDefinition {
  @doc("The type of the tool. Currently, only `function` is supported.")
  type: "function";

  @doc("The function definition details for the function tool.")
  function: FunctionDefinition;
}

@doc("""
  The definition of a caller-specified function that chat completions may invoke in response to matching user input.
  """)
model FunctionDefinition {
  @doc("The name of the function to be called.")
  name: string;

  @doc("""
    A description of what the function does. The model will use this description when selecting the function and
    interpreting its parameters.
    """)
  description?: string;

  #suppress "@azure-tools/typespec-azure-core/no-unknown" "External API shape takes an arbitrary json"
  @doc("The parameters the function accepts, described as a JSON Schema object.")
  parameters?: Record<unknown>;
}

@doc("""
  An update to the function tool call information requested by the AI model.
  """)
model StreamingChatResponseToolCallUpdate {
  @doc("The ID of the tool call.")
  id: string;

  @doc("Updates to the function call requested by the AI model.")
  function: FunctionCall;
}

@doc("""
  A function tool call requested by the AI model.
  """)
model ChatCompletionsToolCall {
  @doc("The ID of the tool call.")
  id: string;

  @doc("The type of tool call. Currently, only `function` is supported.")
  type: "function";

  @doc("The details of the function call requested by the AI model.")
  function: FunctionCall;
}

@doc("The name and arguments of a function that should be called, as generated by the model.")
model FunctionCall {
  @doc("The name of the function to call.")
  name: string;

  @doc("""
    The arguments to call the function with, as generated by the model in JSON format.
    Note that the model does not always generate valid JSON, and may hallucinate parameters
    not defined by your function schema. Validate the arguments in your code before calling
    your function.
    """)
  arguments: string;
}

@doc("An abstract representation of a structured content item within a chat message.")
@discriminator("type")
model ChatMessageContentItem {
  @doc("The discriminated object type.")
  type: string;
}

@doc("A structured chat content item containing plain text.")
model ChatMessageTextContentItem extends ChatMessageContentItem {
  @doc("The discriminated object type: always 'text' for this type.")
  type: "text";

  @doc("The content of the message.")
  text: string;
}

@doc("A structured chat content item containing an image reference.")
model ChatMessageImageContentItem extends ChatMessageContentItem {
  @doc("The discriminated object type: always 'image_url' for this type.")
  type: "image_url";

  @doc("An internet location, which must be accessible to the model,from which the image may be retrieved.")
  @encodedName("application/json", "image_url")
  imageUrl: ChatMessageImageUrl;
}

@doc("An internet location from which the model may retrieve an image.")
model ChatMessageImageUrl {
  @doc("The URL of the image.")
  url: string;

  @doc("""
    The evaluation quality setting to use, which controls relative prioritization of speed, token consumption, and
    accuracy.
    """)
  detail?: ChatMessageImageDetailLevel;
}

@doc("A representation of the possible image detail levels for image-based chat completions message content.")
union ChatMessageImageDetailLevel {
  string,

  @doc("Specifies that the model should determine which detail level to apply using heuristics like image size.")
  auto: "auto",

  @doc("""
    Specifies that image evaluation should be constrained to the 'low-res' model that may be faster and consume fewer
    tokens but may also be less accurate for highly detailed images.
    """)
  low: "low",

  @doc("""
    Specifies that image evaluation should enable the 'high-res' model that may be more accurate for highly detailed
    images but may also be slower and consume more tokens.
    """)
  high: "high",
}

@doc("A structured chat content item containing an audio reference.")
model ChatMessageAudioContentItem extends ChatMessageContentItem {
  @doc("The discriminated object type: always 'image_url' for this type.")
  type: "audio_url";

  @doc("An internet location, which must be accessible to the model, from which the audio may be retrieved.")
  @encodedName("application/json", "audio_url")
  audioUrl: ChatMessageAudioUrl;
}

@doc("An internet location from which the model may retrieve an audio.")
model ChatMessageAudioUrl {
  @doc("The URL of the audio.")
  url: string;
}

@doc("A structured chat content item containing an audio content.")
model ChatMessageInputAudioContentItem extends ChatMessageContentItem {
  @doc("The discriminated object type: always 'input_audio' for this type.")
  type: "input_audio";

  @doc("The audio format of the audio reference.")
  format: AudioContentFormat;
}

@doc("The details of an audio chat message content part.")
model ChatMessageInputAudio {
  @doc("Base64 encoded audio data")
  data: string;

  @doc("The audio format of the audio content.")
  format: AudioContentFormat;
}

@doc("A representation of the possible audio formats for audio.")
union AudioContentFormat {
  string,

  @doc("Specifies audio in WAV format.")
  wav: "wav",

  @doc("Specifies audio in MP3 format.")
  mp3: "mp3",
}

@doc("A representation of the audio generated by the model.")
model ChatCompletionsAudio {
  @doc("""
      Unique identifier for the audio response. This value can be used in chat history messages instead of passing 
      the full audio object.
    """)
  id: string;

  @doc("""
    The Unix timestamp (in seconds) at which the audio piece expires and can't be any longer referenced by its ID in 
    multi-turn conversations.
    """)
  @encode(DateTimeKnownEncoding.unixTimestamp, int64)
  @encodedName("application/json", "expires_at")
  expiresAt: utcDateTime;

  @doc("Base64 encoded audio data")
  data: string;

  @doc("""
    The format of the audio content. If format is not provided, it will match the format used in the
    input audio request.
    """)
  format?: AudioContentFormat;

  @doc("The transcript of the audio file.")
  transcript: string;
}

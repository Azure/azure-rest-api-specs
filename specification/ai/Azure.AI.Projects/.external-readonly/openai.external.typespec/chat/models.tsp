/*
 * This file was automatically generated from an OpenAPI .yaml file.
 * Edits made directly to this file will be lost.
 */

import "../common";
import "./custom.tsp";

using TypeSpec.OpenAPI;

namespace OpenAI;

// Tool generated type. Extracts from CreateChatCompletionResponse.choices
alias CreateChatCompletionResponseChoice = {
  @doc("""
    The reason the model stopped generating tokens. This will be `stop` if the model hit a natural stop point or a provided stop sequence,
    `length` if the maximum number of tokens specified in the request was reached,
    `content_filter` if content was omitted due to a flag from our content filters,
    `tool_calls` if the model called a tool, or `function_call` (deprecated) if the model called a function.
    """)
  finish_reason:
    | "stop"
    | "length"
    | "tool_calls"
    | "content_filter"
    | "function_call";

  /** The index of the choice in the list of choices. */
  index: int32;

  message: ChatCompletionResponseMessage;

  /** Log probability information for the choice. */
  logprobs: {
    // Tool customization: Apply read-only visibility via annotation
    /** A list of message content tokens with log probability information. */
    @visibility(Lifecycle.Read)
    content: ChatCompletionTokenLogprob[] | null;

    // Tool customization: Apply read-only visibility via annotation
    /** A list of message refusal tokens with log probability information. */
    @visibility(Lifecycle.Read)
    refusal: ChatCompletionTokenLogprob[] | null;
  } | null;
};

// Tool generated type. Extracts from ChatCompletionResponseMessage.annotations
alias ChatCompletionResponseMessageAnnotation = {
  @doc("""
    The type of the URL citation. Always `url_citation`.
    """)
  type: "url_citation";

  /** A URL citation when using web search. */
  url_citation: {
    /** The index of the last character of the URL citation in the message. */
    end_index: int32;

    /** The index of the first character of the URL citation in the message. */
    start_index: int32;

    // Tool customization: url uses the url type
    /** The URL of the web resource. */
    url: url;

    /** The title of the web resource. */
    title: string;
  };
};

// Tool generated type. Extracts from ChatCompletionTokenLogprob.top_logprobs
alias ChatCompletionTokenLogprobTopLogprob = {
  /** The token. */
  token: string;

  @doc("""
    The log probability of this token, if it is within the top 20 most likely tokens. Otherwise, the value `-9999.0` is used to signify that the token is very unlikely.
    """)
  logprob: float32;

  @doc("""
    A list of integers representing the UTF-8 bytes representation of the token. Useful in instances where characters are represented by multiple tokens and their byte representations must be combined to generate the correct text representation. Can be `null` if there is no bytes representation for the token.
    """)
  bytes: int32[] | null;
};

// Tool generated type. Extracts from CreateChatCompletionStreamResponse.choices
alias CreateChatCompletionStreamResponseChoice = {
  delta: ChatCompletionStreamResponseDelta;

  /** Log probability information for the choice. */
  logprobs?: {
    // Tool customization: Apply read-only visibility via annotation
    /** A list of message content tokens with log probability information. */
    @visibility(Lifecycle.Read)
    content: ChatCompletionTokenLogprob[] | null;

    // Tool customization: Apply read-only visibility via annotation
    /** A list of message refusal tokens with log probability information. */
    @visibility(Lifecycle.Read)
    refusal: ChatCompletionTokenLogprob[] | null;
  } | null;

  @doc("""
    The reason the model stopped generating tokens. This will be `stop` if the model hit a natural stop point or a provided stop sequence,
    `length` if the maximum number of tokens specified in the request was reached,
    `content_filter` if content was omitted due to a flag from our content filters,
    `tool_calls` if the model called a tool, or `function_call` (deprecated) if the model called a function.
    """)
  finish_reason:
    | "stop"
    | "length"
    | "tool_calls"
    | "content_filter"
    | "function_call"
    | null;

  /** The index of the choice in the list of choices. */
  index: int32;
};

// Tool generated type. Extracts from ChatCompletionMessageList.data
alias ChatCompletionMessageListData = {
  ...ChatCompletionResponseMessage;

  /** The identifier of the chat message. */
  id: string;
};

// Tool customization: Remove redundant inclusion of 'top_logprobs' (from response properties)
model CreateChatCompletionRequest {
  ...ModelResponsePropertiesForRequest;

  /**
   * A list of messages comprising the conversation so far. Depending on the
   * [model](/docs/models) you use, different message types (modalities) are
   * supported, like [text](/docs/guides/text-generation),
   * [images](/docs/guides/vision), and [audio](/docs/guides/audio).
   */
  @minItems(1)
  messages: ChatCompletionRequestMessage[];

  @doc("""
    Model ID used to generate the response, like `gpt-4o` or `o3`. OpenAI
    offers a wide range of models with different capabilities, performance
    characteristics, and price points. Refer to the [model guide](/docs/models)
    to browse and compare available models.
    """)
  `model`: ModelIdsShared;

  modalities?: ResponseModalities | null;
  reasoning_effort?: ReasoningEffort | null = "medium";

  /** An upper bound for the number of tokens that can be generated for a completion, including visible output tokens and [reasoning tokens](/docs/guides/reasoning). */
  max_completion_tokens?: int32 | null;

  /**
   * Number between -2.0 and 2.0. Positive values penalize new tokens based on
   * their existing frequency in the text so far, decreasing the model's
   * likelihood to repeat the same line verbatim.
   */
  @minValue(-2)
  @maxValue(2)
  frequency_penalty?: float32 | null = 0;

  /**
   * Number between -2.0 and 2.0. Positive values penalize new tokens based on
   * whether they appear in the text so far, increasing the model's likelihood
   * to talk about new topics.
   */
  @minValue(-2)
  @maxValue(2)
  presence_penalty?: float32 | null = 0;

  /**
   * This tool searches the web for relevant results to use in a response.
   * Learn more about the [web search tool](/docs/guides/tools-web-search?api-mode=chat).
   */
  web_search_options?: {
    /** Approximate location parameters for the search. */
    user_location?: {
      @doc("""
        The type of location approximation. Always `approximate`.
        """)
      type: "approximate";

      approximate: WebSearchLocation;
    } | null;

    search_context_size?: WebSearchContextSize = "medium";
  };

  // Tool customization: apply a named union type
  @doc("""
    An object specifying the format that the model must output.
    
    Setting to `{ "type": "json_schema", "json_schema": {...} }` enables
    Structured Outputs which ensures the model will match your supplied JSON
    schema. Learn more in the [Structured Outputs
    guide](/docs/guides/structured-outputs).
    
    Setting to `{ "type": "json_object" }` enables the older JSON mode, which
    ensures the message the model generates is valid JSON. Using `json_schema`
    is preferred for models that support it.
    """)
  response_format?: ResponseFormat;

  @doc("""
    Parameters for audio output. Required when audio output is requested with
    `modalities: ["audio"]`. [Learn more](/docs/guides/audio).
    """)
  audio?: {
    @doc("""
      The voice the model uses to respond. Supported voices are
      `alloy`, `ash`, `ballad`, `coral`, `echo`, `fable`, `nova`, `onyx`, `sage`, and `shimmer`.
      """)
    voice: VoiceIdsShared;

    @doc("""
      Specifies the output audio format. Must be one of `wav`, `mp3`, `flac`,
      `opus`, or `pcm16`.
      """)
    format: "wav" | "aac" | "mp3" | "flac" | "opus" | "pcm16";
  } | null;

  /**
   * Whether or not to store the output of this chat completion request for
   * use in our [model distillation](/docs/guides/distillation) or
   * [evals](/docs/guides/evals) products.
   *
   * Supports text and image inputs. Note: image inputs over 10MB will be dropped.
   */
  store?: boolean | null = false;

  /**
   * If set to true, the model response data will be streamed to the client
   * as it is generated using [server-sent events](https://developer.mozilla.org/en-US/docs/Web/API/Server-sent_events/Using_server-sent_events#Event_stream_format).
   * See the [Streaming section below](/docs/api-reference/chat/streaming)
   * for more information, along with the [streaming responses](/docs/guides/streaming-responses)
   * guide for more information on how to handle the streaming events.
   */
  stream?: boolean | null = false;

  stop?: StopConfiguration | null = null;

  /**
   * Modify the likelihood of specified tokens appearing in the completion.
   *
   * Accepts a JSON object that maps tokens (specified by their token ID in the
   * tokenizer) to an associated bias value from -100 to 100. Mathematically,
   * the bias is added to the logits generated by the model prior to sampling.
   * The exact effect will vary per model, but values between -1 and 1 should
   * decrease or increase likelihood of selection; values like -100 or 100
   * should result in a ban or exclusive selection of the relevant token.
   */
  @extension("x-oaiTypeLabel", "map")
  logit_bias?: Record<int32> | null = null;

  @doc("""
    Whether to return log probabilities of the output tokens or not. If true,
    returns the log probabilities of each output token returned in the
    `content` of `message`.
    """)
  logprobs?: boolean | null = false;

  #suppress "deprecated" "Warning unnecessary for spec description of deprecation"
  #deprecated "This field is marked as deprecated."
  @doc("""
    The maximum number of [tokens](/tokenizer) that can be generated in the
    chat completion. This value can be used to control
    [costs](https://openai.com/api/pricing/) for text generated via API.
    
    This value is now deprecated in favor of `max_completion_tokens`, and is
    not compatible with [o-series models](/docs/guides/reasoning).
    """)
  max_tokens?: int32 | null;

  @doc("""
    How many chat completion choices to generate for each input message. Note that you will be charged based on the number of generated tokens across all of the choices. Keep `n` as `1` to minimize costs.
    """)
  @minValue(1)
  @maxValue(128)
  n?: int32 | null = 1;

  // Tool customization: Apply an implied base discriminated type to 'prediction'
  /**
   * Configuration for a [Predicted Output](/docs/guides/predicted-outputs),
   * which can greatly improve response times when large parts of the model
   * response are known ahead of time. This is most common when you are
   * regenerating a file with only minor changes to most of the content.
   */
  prediction?: ChatOutputPrediction | null;

  @doc("""
    This feature is in Beta.
    If specified, our system will make a best effort to sample deterministically, such that repeated requests with the same `seed` and parameters should return the same result.
    Determinism is not guaranteed, and you should refer to the `system_fingerprint` response parameter to monitor changes in the backend.
    """)
  @minValue(-9223372036854776000)
  @maxValue(9223372036854776000)
  seed?: int64 | null;

  stream_options?: ChatCompletionStreamOptions | null = null;

  /** A list of tools the model may call. Currently, only functions are supported as a tool. Use this to provide a list of functions the model may generate JSON inputs for. A max of 128 functions are supported. */
  tools?: ChatCompletionTool[];

  tool_choice?: ChatCompletionToolChoiceOption;
  parallel_tool_calls?: ParallelToolCalls = true;

  #suppress "deprecated" "Warning unnecessary for spec description of deprecation"
  #deprecated "This field is marked as deprecated."
  @doc("""
    Deprecated in favor of `tool_choice`.
    
    Controls which (if any) function is called by the model.
    
    `none` means the model will not call a function and instead generates a
    message.
    
    `auto` means the model can pick between generating a message or calling a
    function.
    
    Specifying a particular function via `{"name": "my_function"}` forces the
    model to call that function.
    
    `none` is the default when no functions are present. `auto` is the default
    if functions are present.
    """)
  function_call?: "none" | "auto" | ChatCompletionFunctionCallOption;

  #suppress "deprecated" "Warning unnecessary for spec description of deprecation"
  #deprecated "This field is marked as deprecated."
  @doc("""
    Deprecated in favor of `tools`.
    
    A list of functions the model may generate JSON inputs for.
    """)
  @minItems(1)
  @maxItems(128)
  functions?: ChatCompletionFunctions[];
}

/** Represents a chat completion response returned by model, based on the provided input. */
model CreateChatCompletionResponse {
  /** A unique identifier for the chat completion. */
  id: string;

  @doc("""
    A list of chat completion choices. Can be more than one if `n` is greater than 1.
    """)
  choices: CreateChatCompletionResponseChoice[];

  // Tool customization: 'created' and fields ending in '_at' are Unix encoded utcDateTime
  /** The Unix timestamp (in seconds) of when the chat completion was created. */
  @encode("unixTimestamp", int32)
  created: utcDateTime;

  /** The model used for the chat completion. */
  `model`: string;

  service_tier?: ServiceTier | null = "auto";

  @doc("""
    This fingerprint represents the backend configuration that the model runs with.
    
    Can be used in conjunction with the `seed` request parameter to understand when backend changes have been made that might impact determinism.
    """)
  system_fingerprint?: string;

  @doc("""
    The object type, which is always `chat.completion`.
    """)
  object: "chat.completion";

  usage?: CompletionUsage;
}

model ChatCompletionTool {
  @doc("""
    The type of the tool. Currently, only `function` is supported.
    """)
  type: "function";

  function: FunctionObject;
}

/** Specifies a tool the model should use. Use to force the model to call a specific function. */
model ChatCompletionNamedToolChoice {
  @doc("""
    The type of the tool. Currently, only `function` is supported.
    """)
  type: "function";

  function: {
    /** The name of the function to call. */
    name: string;
  };
}

@doc("""
  Controls which (if any) tool is called by the model.
  `none` means the model will not call any tool and instead generates a message.
  `auto` means the model can pick between generating a message or calling one or more tools.
  `required` means the model must call one or more tools.
  Specifying a particular tool via `{"type": "function", "function": {"name": "my_function"}}` forces the model to call that tool.
  
  `none` is the default when no tools are present. `auto` is the default if tools are present.
  """)
union ChatCompletionToolChoiceOption {
  "none" | "auto" | "required",
  ChatCompletionNamedToolChoice,
}

// Tool customization (apply_discriminator): apply custom, discriminated type base
/** Learn about [text inputs](/docs/guides/text-generation). */
model ChatCompletionRequestMessageContentPartText
  extends ChatCompletionRequestMessageContentPart {
  /** The type of the content part. */
  type: ChatCompletionRequestMessageContentPartType.text;

  /** The text content. */
  text: string;
}

// Tool customization (apply_discriminator): apply custom, discriminated type base
/** Learn about [image inputs](/docs/guides/vision). */
model ChatCompletionRequestMessageContentPartImage
  extends ChatCompletionRequestMessageContentPart {
  /** The type of the content part. */
  type: ChatCompletionRequestMessageContentPartType.image_url;

  image_url: {
    // Tool customization: url uses the url type
    /** Either a URL of the image or the base64 encoded image data. */
    url: url;

    /** Specifies the detail level of the image. Learn more in the [Vision guide](/docs/guides/vision#low-or-high-fidelity-image-understanding). */
    detail?: "auto" | "low" | "high" = "auto";
  };
}

// Tool customization (apply_discriminator): apply custom, discriminated type base
model ChatCompletionRequestMessageContentPartRefusal
  extends ChatCompletionRequestMessageContentPart {
  /** The type of the content part. */
  type: ChatCompletionRequestMessageContentPartType.refusal;

  /** The refusal message generated by the model. */
  refusal: string;
}

// Tool customization (apply_discriminator): apply custom, discriminated type base
/** Learn about [file inputs](/docs/guides/text) for text generation. */
model ChatCompletionRequestMessageContentPartFile
  extends ChatCompletionRequestMessageContentPart {
  @doc("""
    The type of the content part. Always `file`.
    """)
  type: ChatCompletionRequestMessageContentPartType.file;

  file: {
    /**
     * The name of the file, used when passing the file to the model as a
     * string.
     */
    filename?: string;

    /**
     * The base64 encoded file data, used when passing the file to the model
     * as a string.
     */
    file_data?: string;

    /** The ID of an uploaded file to use as input. */
    file_id?: string;
  };
}

model ChatCompletionMessageToolCall {
  /** The ID of the tool call. */
  id: string;

  @doc("""
    The type of the tool. Currently, only `function` is supported.
    """)
  type: "function";

  /** The function that the model called. */
  function: {
    /** The name of the function to call. */
    name: string;

    /** The arguments to call the function with, as generated by the model in JSON format. Note that the model does not always generate valid JSON, and may hallucinate parameters not defined by your function schema. Validate the arguments in your code before calling your function. */
    arguments: string;
  };
}

// Tool customization: convert to discriminated type
@discriminator("role")
model ChatCompletionRequestMessage {
  /** The role of the author of this message. */
  role: ChatCompletionRole;

  /** The content of the message. Valid content part types vary per message role. */
  content?: string | ChatCompletionRequestMessageContentPart[] | null;
}

// Tool customization (apply_discriminator): apply custom, discriminated type base
/** Learn about [audio inputs](/docs/guides/audio). */
model ChatCompletionRequestMessageContentPartAudio
  extends ChatCompletionRequestMessageContentPart {
  @doc("""
    The type of the content part. Always `input_audio`.
    """)
  type: ChatCompletionRequestMessageContentPartType.input_audio;

  input_audio: {
    // Tool customization: use encoded type for audio data
    /** Base64 encoded audio data. */
    @encode("base64")
    data: bytes;

    /** The format of the encoded audio data. Currently supports "wav" and "mp3". */
    format: "wav" | "mp3";
  };
}

union ChatCompletionRequestSystemMessageContentPart {
  ChatCompletionRequestMessageContentPartText,
}

union ChatCompletionRequestUserMessageContentPart {
  ChatCompletionRequestMessageContentPartText,
  ChatCompletionRequestMessageContentPartImage,
  ChatCompletionRequestMessageContentPartAudio,
  ChatCompletionRequestMessageContentPartFile,
}

union ChatCompletionRequestAssistantMessageContentPart {
  ChatCompletionRequestMessageContentPartText,
  ChatCompletionRequestMessageContentPartRefusal,
}

union ChatCompletionRequestToolMessageContentPart {
  ChatCompletionRequestMessageContentPartText,
}

// Tool customization (apply_discriminator): apply discriminated type base
@doc("""
  Developer-provided instructions that the model should follow, regardless of
  messages sent by the user. With o1 models and newer, use `developer` messages
  for this purpose instead.
  """)
model ChatCompletionRequestSystemMessage extends ChatCompletionRequestMessage {
  /** The contents of the system message. */
  content: string | ChatCompletionRequestSystemMessageContentPart[];

  @doc("""
    The role of the messages author, in this case `system`.
    """)
  role: ChatCompletionRole.system;

  /** An optional name for the participant. Provides the model information to differentiate between participants of the same role. */
  name?: string;
}

// Tool customization (apply_discriminator): apply discriminated type base
@doc("""
  Developer-provided instructions that the model should follow, regardless of
  messages sent by the user. With o1 models and newer, `developer` messages
  replace the previous `system` messages.
  """)
model ChatCompletionRequestDeveloperMessage
  extends ChatCompletionRequestMessage {
  /** The contents of the developer message. */
  content: string | ChatCompletionRequestMessageContentPartText[];

  @doc("""
    The role of the messages author, in this case `developer`.
    """)
  role: ChatCompletionRole.developer;

  /** An optional name for the participant. Provides the model information to differentiate between participants of the same role. */
  name?: string;
}

// Tool customization (apply_discriminator): apply discriminated type base
/**
 * Messages sent by an end user, containing prompts or additional context
 * information.
 */
model ChatCompletionRequestUserMessage extends ChatCompletionRequestMessage {
  /** The contents of the user message. */
  content: string | ChatCompletionRequestUserMessageContentPart[];

  @doc("""
    The role of the messages author, in this case `user`.
    """)
  role: ChatCompletionRole.user;

  /** An optional name for the participant. Provides the model information to differentiate between participants of the same role. */
  name?: string;
}

// Tool customization (apply_discriminator): apply discriminated type base
/** Messages sent by the model in response to user messages. */
model ChatCompletionRequestAssistantMessage
  extends ChatCompletionRequestMessage {
  @doc("""
    The contents of the assistant message. Required unless `tool_calls` or `function_call` is specified.
    """)
  content?: string | ChatCompletionRequestAssistantMessageContentPart[] | null;

  /** The refusal message by the assistant. */
  refusal?: string | null;

  @doc("""
    The role of the messages author, in this case `assistant`.
    """)
  role: ChatCompletionRole.assistant;

  /** An optional name for the participant. Provides the model information to differentiate between participants of the same role. */
  name?: string;

  /**
   * Data about a previous audio response from the model.
   * [Learn more](/docs/guides/audio).
   */
  audio?: {
    /** Unique identifier for a previous audio response from the model. */
    id: string;
  } | null;

  tool_calls?: ChatCompletionMessageToolCalls;

  // Tool customization: preserve earlier, more intuitive field order
  #suppress "deprecated" "Warning unnecessary for spec description of deprecation"
  #deprecated "This field is marked as deprecated."
  @doc("""
    Deprecated and replaced by `tool_calls`. The name and arguments of a function that should be called, as generated by the model.
    """)
  function_call?: {
    name: string;
    arguments: string;
  } | null;
}

// Tool customization (apply_discriminator): apply discriminated type base
model ChatCompletionRequestToolMessage extends ChatCompletionRequestMessage {
  @doc("""
    The role of the messages author, in this case `tool`.
    """)
  role: ChatCompletionRole.tool;

  /** The contents of the tool message. */
  content: string | ChatCompletionRequestToolMessageContentPart[];

  /** Tool call that this message is responding to. */
  tool_call_id: string;
}

// Tool customization (apply_discriminator): apply discriminated type base
#suppress "deprecated" "Warning unnecessary for spec description of deprecation"
#deprecated "This field is marked as deprecated."
model ChatCompletionRequestFunctionMessage
  extends ChatCompletionRequestMessage {
  @doc("""
    The role of the messages author, in this case `function`.
    """)
  role: ChatCompletionRole.function;

  /** The contents of the function message. */
  content: string | null;

  /** The name of the function to call. */
  name: string;
}

/** The tool calls generated by the model, such as function calls. */
model ChatCompletionMessageToolCalls is ChatCompletionMessageToolCall[];

@doc("""
  Output types that you would like the model to generate for this request.
  Most models are capable of generating text, which is the default:
  
  `["text"]`
  
  The `gpt-4o-audio-preview` model can also be used to [generate audio](/docs/guides/audio). To
  request that this model generate both text and audio responses, you can
  use:
  
  `["text", "audio"]`
  """)
model ChatCompletionModalities is ("text" | "audio")[];

// Tool customization: convert to enum
/** The role of the author of a message */
enum ChatCompletionRole {
  system,
  developer,
  user,
  assistant,
  tool,
  function,
}

/** A chat completion message generated by the model. */
model ChatCompletionResponseMessage {
  /** The contents of the message. */
  content: string | null;

  /** The refusal message generated by the model. */
  refusal: string | null;

  tool_calls?: ChatCompletionMessageToolCalls;

  /**
   * Annotations for the message, when applicable, as when using the
   * [web search tool](/docs/guides/tools-web-search?api-mode=chat).
   */
  annotations?: ChatCompletionResponseMessageAnnotation[];

  // Tool customization: use discriminated type base for role
  /** The role of the author of this message. */
  role: ChatCompletionRole.assistant;

  // Tool customization: preserve earlier, more intuitive field order
  #suppress "deprecated" "Warning unnecessary for spec description of deprecation"
  #deprecated "This field is marked as deprecated."
  @doc("""
    Deprecated and replaced by `tool_calls`. The name and arguments of a function that should be called, as generated by the model.
    """)
  function_call?: {
    name: string;
    arguments: string;
  };

  /**
   * If the audio output modality is requested, this object contains data
   * about the audio response from the model. [Learn more](/docs/guides/audio).
   */
  audio?: {
    /** Unique identifier for this audio response. */
    id: string;

    // Tool customization: 'created' and fields ending in '_at' are Unix encoded utcDateTime
    /**
     * The Unix timestamp (in seconds) for when this audio response will
     * no longer be accessible on the server for use in multi-turn
     * conversations.
     */
    @encode("unixTimestamp", int32)
    expires_at: utcDateTime;

    // Tool customization: use encoded type for audio data
    /**
     * Base64 encoded audio bytes generated by the model, in the format
     * specified in the request.
     */
    @encode("base64")
    data: bytes;

    /** Transcript of the audio generated by the model. */
    transcript: string;
  } | null;
}

model ChatCompletionTokenLogprob {
  /** The token. */
  token: string;

  @doc("""
    The log probability of this token, if it is within the top 20 most likely tokens. Otherwise, the value `-9999.0` is used to signify that the token is very unlikely.
    """)
  logprob: float32;

  @doc("""
    A list of integers representing the UTF-8 bytes representation of the token. Useful in instances where characters are represented by multiple tokens and their byte representations must be combined to generate the correct text representation. Can be `null` if there is no bytes representation for the token.
    """)
  bytes: int32[] | null;

  @doc("""
    List of the most likely tokens and their log probability, at this token position. In rare cases, there may be fewer than the number of requested `top_logprobs` returned.
    """)
  top_logprobs: ChatCompletionTokenLogprobTopLogprob[];
}

@doc("""
  Specifying a particular function via `{"name": "my_function"}` forces the model to call that function.
  """)
model ChatCompletionFunctionCallOption {
  /** The name of the function to call. */
  name: string;
}

#suppress "deprecated" "Warning unnecessary for spec description of deprecation"
#deprecated "This field is marked as deprecated."
model ChatCompletionFunctions {
  /** A description of what the function does, used by the model to choose when and how to call the function. */
  description?: string;

  /** The name of the function to be called. Must be a-z, A-Z, 0-9, or contain underscores and dashes, with a maximum length of 64. */
  name: string;

  ...FunctionParametersCommon;
}

// Tool customization: Add a missing "audio" to the chat streaming delta definition
/** A chat completion delta generated by streamed model responses. */
model ChatCompletionStreamResponseDelta {
  /** Response audio associated with the streaming chat delta payload. */
  audio?: ChatCompletionMessageAudioChunk;

  /** The contents of the chunk message. */
  content?: string | null;

  // Tool customization: preserve earlier, more intuitive field order
  #suppress "deprecated" "Warning unnecessary for spec description of deprecation"
  #deprecated "This field is marked as deprecated."
  @doc("""
    Deprecated and replaced by `tool_calls`. The name and arguments of a function that should be called, as generated by the model.
    """)
  function_call?: {
    name?: string;
    arguments?: string;
  };

  tool_calls?: ChatCompletionMessageToolCallChunk[];

  // Tool customization: use discriminated type base for role
  /** The role of the author of this message. */
  role?: ChatCompletionRole;

  /** The refusal message generated by the model. */
  refusal?: string | null;
}

model ChatCompletionMessageToolCallChunk {
  index: int32;

  /** The ID of the tool call. */
  id?: string;

  @doc("""
    The type of the tool. Currently, only `function` is supported.
    """)
  type?: "function";

  function?: {
    /** The name of the function to call. */
    name?: string;

    /** The arguments to call the function with, as generated by the model in JSON format. Note that the model does not always generate valid JSON, and may hallucinate parameters not defined by your function schema. Validate the arguments in your code before calling your function. */
    arguments?: string;
  };
}

/**
 * Represents a streamed chunk of a chat completion response returned
 * by the model, based on the provided input.
 * [Learn more](/docs/guides/streaming-responses).
 */
model CreateChatCompletionStreamResponse {
  /** A unique identifier for the chat completion. Each chunk has the same ID. */
  id: string;

  @doc("""
    A list of chat completion choices. Can contain more than one elements if `n` is greater than 1. Can also be empty for the
    last chunk if you set `stream_options: {"include_usage": true}`.
    """)
  choices: CreateChatCompletionStreamResponseChoice[];

  // Tool customization: 'created' and fields ending in '_at' are Unix encoded utcDateTime
  /** The Unix timestamp (in seconds) of when the chat completion was created. Each chunk has the same timestamp. */
  @encode("unixTimestamp", int32)
  created: utcDateTime;

  /** The model to generate the completion. */
  `model`: string;

  service_tier?: ServiceTier | null = "auto";

  @doc("""
    This fingerprint represents the backend configuration that the model runs with.
    Can be used in conjunction with the `seed` request parameter to understand when backend changes have been made that might impact determinism.
    """)
  system_fingerprint?: string;

  @doc("""
    The object type, which is always `chat.completion.chunk`.
    """)
  object: "chat.completion.chunk";

  @doc("""
    An optional field that will only be present when you set
    `stream_options: {"include_usage": true}` in your request. When present, it
    contains a null value **except for the last chunk** which contains the
    token usage statistics for the entire request.
    
    **NOTE:** If the stream is interrupted or cancelled, you may not
    receive the final usage chunk which contains the total token usage for
    the request.
    """)
  usage?: CompletionUsage | null;
}

// Tool customization (apply_discriminator): Apply an implied base discriminated type to 'prediction'
/**
 * Static predicted output content, such as the content of a text file that is
 * being regenerated.
 */
model ChatOutputPredictionContent extends ChatOutputPrediction {
  @doc("""
    The type of the predicted content you want to provide. This type is
    currently always `content`.
    """)
  type: ChatOutputPredictionType.static_content;

  /**
   * The content that should be matched when generating a model response.
   * If generated tokens would match this content, the entire model response
   * can be returned much more quickly.
   */
  content: string | ChatCompletionRequestMessageContentPartText[];
}

model ChatCompletionDeleted {
  /** The type of object being deleted. */
  object: "chat.completion.deleted";

  /** The ID of the chat completion that was deleted. */
  id: string;

  /** Whether the chat completion was deleted. */
  deleted: boolean;
}

/** An object representing a list of Chat Completions. */
model ChatCompletionList {
  /** The type of this object. It is always set to "list". */
  object: "list" = "list";

  /** An array of chat completion objects. */
  data: CreateChatCompletionResponse[];

  /** The identifier of the first chat completion in the data array. */
  first_id: string;

  /** The identifier of the last chat completion in the data array. */
  last_id: string;

  /** Indicates whether there are more Chat Completions available. */
  has_more: boolean;
}

/** An object representing a list of chat completion messages. */
model ChatCompletionMessageList {
  /** The type of this object. It is always set to "list". */
  object: "list" = "list";

  /** An array of chat completion message objects. */
  data: ChatCompletionMessageListData[];

  /** The identifier of the first chat message in the data array. */
  first_id: string;

  /** The identifier of the last chat message in the data array. */
  last_id: string;

  /** Indicates whether there are more chat messages available. */
  has_more: boolean;
}

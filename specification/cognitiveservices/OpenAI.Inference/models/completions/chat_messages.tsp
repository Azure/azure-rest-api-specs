import "@typespec/rest";
import "@typespec/http";
import "@typespec/versioning";

import "./azure_chat_extensions.tsp";
import "./common.tsp";
import "./functions.tsp";
import "./tools.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using TypeSpec.Versioning;

namespace Azure.OpenAI;

#suppress "@azure-tools/typespec-autorest/union-unsupported" "External API shape is defined in OpenAPI 3.0 as oneOf."
@removed(ServiceApiVersions.v2024_08_01_Preview)
@doc("The contents of the user message, with available input types varying by selected model.")
union ChatMessageContent {
  string,

  @added(ServiceApiVersions.v2024_02_15_Preview)
  ChatMessageContentItem[],
}

@added(ServiceApiVersions.v2024_02_15_Preview)
@doc("An abstract representation of a structured content item within a chat message.")
@discriminator("type")
model ChatMessageContentItem {
  #suppress "@azure-tools/typespec-azure-core/no-string-discriminator" "Existing"
  @doc("The discriminated object type.")
  type: string;
}

@added(ServiceApiVersions.v2024_02_15_Preview)
@doc("A structured chat content item containing plain text.")
model ChatMessageTextContentItem extends ChatMessageContentItem {
  @doc("The discriminated object type: always 'text' for this type.")
  type: "text";

  @doc("The content of the message.")
  text: string;
}

@added(ServiceApiVersions.v2024_08_01_Preview)
@doc("A structured chat content item containing model refusal information for a structured outputs request.")
model ChatMessageRefusalContentItem extends ChatMessageContentItem {
  @doc("The discriminated object type: always 'refusal' for this type.")
  type: "refusal";

  @doc("The refusal message.")
  refusal: string;
}

@added(ServiceApiVersions.v2024_02_15_Preview)
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

/** A structured chat content item containing an image reference. */
@added(ServiceApiVersions.v2024_02_15_Preview)
model ChatMessageImageContentItem extends ChatMessageContentItem {
  /** The discriminated object type: always 'image_url' for this type. */
  type: "image_url";

  @doc("An internet location, which must be accessible to the model,from which the image may be retrieved.")
  @encodedName("application/json", "image_url")
  imageUrl: ChatMessageImageUrl;
}

/** Values to describe the format of the input audio data. */
@added(ServiceApiVersions.v2024_02_15_Preview)
union InputAudioFormat {
  string,

  /** Specifies that the audio data is in the WAV format. */
  wav: "wav",

  /** Specifies that the audio data is in the MP3 format. */
  mp3: "mp3",
}

/**
 * A structured chat content item containing audio data.
 */
@added(ServiceApiVersions.v2025_01_01_Preview)
model InputAudioContent {
  /** Base64-encoded audio data. */
  data: string;

  /** The format of the audio data. */
  format: InputAudioFormat;
}

/** A structured chat content item containing audio data. */
@added(ServiceApiVersions.v2025_01_01_Preview)
model ChatMessageAudioContentItem extends ChatMessageContentItem {
  /** The type of the content part. Always `input_audio`. */
  type: "input_audio";

  /** The audio data. */
  @encodedName("application/json", "input_audio")
  inputAudio: InputAudioContent;
}

@doc("An internet location from which the model may retrieve an image.")
@added(ServiceApiVersions.v2024_02_15_Preview)
model ChatMessageImageUrl {
  @doc("The URL of the image.")
  url: url;

  @doc("""
    The evaluation quality setting to use, which controls relative prioritization of speed, token consumption, and
    accuracy.
    """)
  detail?: ChatMessageImageDetailLevel;
}

@discriminator("role")
@added(ServiceApiVersions.v2023_05_15)
@doc("An abstract representation of a chat message as provided in a request.")
model ChatRequestMessage {
  @doc("The chat role associated with this message.")
  role: ChatRole;
}

@added(ServiceApiVersions.v2023_05_15)
@doc("""
  A request chat message containing system instructions that influence how the model will generate a chat completions
  response.
  """)
model ChatRequestSystemMessage extends ChatRequestMessage {
  @doc("The chat role associated with this message, which is always 'system' for system messages.")
  role: ChatRole.system;

  #suppress "@azure-tools/typespec-autorest/union-unsupported" "OpenAPI v2 support deferred"
  #suppress "@azure-tools/typespec-client-generator-core/no-unnamed-types" "Backwards compatibility with existing clients."
  @doc("The contents of the system message.")
  @typeChangedFrom(ServiceApiVersions.v2024_08_01_Preview, string)
  content: string | ChatMessageTextContentItem[];

  @doc("An optional name for the participant.")
  name?: string;
}

/**
 * Developer-provided instructions that the model should follow, regardless of messages sent by the user.
 * With o1 models and newer, `developer` messages replace the previous `system` messages."
 */
@added(ServiceApiVersions.v2025_01_01_Preview)
model ChatRequestDeveloperMessage extends ChatRequestMessage {
  /** The role of the messages author, in this case `developer`. */
  role: ChatRole.developer;

  /** An array of content parts with a defined type. For developer messages, only type `text` is supported. */
  #suppress "@azure-tools/typespec-autorest/union-unsupported" "OpenAPI v2 support deferred"
  #suppress "@azure-tools/typespec-client-generator-core/no-unnamed-types" "Backwards compatibility with existing clients."
  content: string | ChatMessageTextContentItem[];

  /** An optional name for the participant. Provides the model information to differentiate between participants of the same role. */
  name?: string;
}

@added(ServiceApiVersions.v2023_05_15)
@doc("A request chat message representing user input to the assistant.")
model ChatRequestUserMessage extends ChatRequestMessage {
  @doc("The chat role associated with this message, which is always 'user' for user messages.")
  role: ChatRole.user;

  #suppress "@azure-tools/typespec-autorest/union-unsupported" "OpenAPI v2 support deferred"
  #suppress "@azure-tools/typespec-client-generator-core/no-unnamed-types" "Backwards compatibility with existing clients."
  @doc("The contents of the user message, with available input types varying by selected model.")
  @typeChangedFrom(ServiceApiVersions.v2024_08_01_Preview, ChatMessageContent)
  @typeChangedFrom(
    ServiceApiVersions.v2025_01_01_Preview,
    string | ChatMessageTextContentItem[] | ChatMessageImageContentItem[]
  )
  content: string | (ChatMessageTextContentItem | ChatMessageImageContentItem | ChatMessageAudioContentItem)[];

  @doc("An optional name for the participant.")
  name?: string;
}

@added(ServiceApiVersions.v2023_05_15)
@doc("A request chat message representing response or action from the assistant.")
model ChatRequestAssistantMessage extends ChatRequestMessage {
  @doc("The chat role associated with this message, which is always 'assistant' for assistant messages.")
  role: ChatRole.assistant;

  #suppress "@azure-tools/typespec-azure-core/no-nullable" "explicitly nullable in mirrored API"
  #suppress "@azure-tools/typespec-autorest/union-unsupported" "OpenAPI v2 support deferred"
  #suppress "@azure-tools/typespec-client-generator-core/no-unnamed-types" "Backwards compatibility with existing clients."
  @doc("The content of the message.")
  @typeChangedFrom(ServiceApiVersions.v2024_08_01_Preview, string | null)
  content:
    | string
    | ChatMessageTextContentItem[]
    | ChatMessageRefusalContentItem[]
    | null;

  @doc("An optional name for the participant.")
  name?: string;

  @encodedName("application/json", "tool_calls")
  @added(ServiceApiVersions.v2024_02_15_Preview)
  @doc("""
    The tool calls that must be resolved and have their outputs appended to subsequent input messages for the chat
    completions request to resolve as configured.
    """)
  toolCalls?: ChatCompletionsToolCall[];

  @added(ServiceApiVersions.v2023_07_01_Preview)
  @encodedName("application/json", "function_call")
  @doc("""
    The function call that must be resolved and have its output appended to subsequent input messages for the chat
    completions request to resolve as configured.
    """)
  functionCall?: FunctionCall;

  /**
   * The refusal message by the assistant.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "explicitly nullable in mirrored API"
  @added(ServiceApiVersions.v2024_08_01_Preview)
  refusal?: string | null;
}

@added(ServiceApiVersions.v2024_02_15_Preview)
@doc("A request chat message representing requested output from a configured tool.")
model ChatRequestToolMessage extends ChatRequestMessage {
  @doc("The chat role associated with this message, which is always 'tool' for tool messages.")
  role: ChatRole.tool;

  #suppress "@azure-tools/typespec-azure-core/no-nullable" "explicitly nullable in mirrored API"
  #suppress "@azure-tools/typespec-autorest/union-unsupported" "OpenAPI v2 support deferred"
  #suppress "@azure-tools/typespec-client-generator-core/no-unnamed-types" "Backwards compatibility with existing clients."
  @doc("The content of the message.")
  @typeChangedFrom(ServiceApiVersions.v2024_08_01_Preview, string | null)
  content: string | ChatMessageTextContentItem[] | null;

  @encodedName("application/json", "tool_call_id")
  @doc("The ID of the tool call resolved by the provided content.")
  toolCallId: string;
}

@added(ServiceApiVersions.v2023_07_01_Preview)
@doc("A request chat message representing requested output from a configured function.")
model ChatRequestFunctionMessage extends ChatRequestMessage {
  @doc("The chat role associated with this message, which is always 'function' for function messages.")
  role: ChatRole.function;

  @doc("The name of the function that was called to produce output.")
  name: string;

  #suppress "@azure-tools/typespec-azure-core/no-nullable" "OpenAI specification"
  @doc("The output of the function as requested by the function call.")
  content: string | null;
}

@added(ServiceApiVersions.v2023_05_15)
@doc("A representation of a chat message as received in a response.")
model ChatResponseMessage {
  @doc("The chat role associated with the message.")
  role: ChatRole;

  #suppress "@azure-tools/typespec-azure-core/no-nullable" "explicitly nullable in mirrored API"
  @added(ServiceApiVersions.v2024_08_01_Preview)
  @doc("The refusal message generated by the model.")
  refusal: string | null;

  #suppress "@azure-tools/typespec-azure-core/no-nullable" "explicitly nullable in mirrored API"
  @doc("The content of the message.")
  content: string | null;

  @added(ServiceApiVersions.v2024_02_15_Preview)
  @encodedName("application/json", "tool_calls")
  @doc("""
    The tool calls that must be resolved and have their outputs appended to subsequent input messages for the chat
    completions request to resolve as configured.
    """)
  toolCalls?: ChatCompletionsToolCall[];

  @added(ServiceApiVersions.v2023_07_01_Preview)
  @encodedName("application/json", "function_call")
  @doc("""
    The function call that must be resolved and have its output appended to subsequent input messages for the chat
    completions request to resolve as configured.
    """)
  functionCall?: FunctionCall;

  /**
   * If the audio output modality is requested, this object contains data
   * about the audio response from the model.
   */
  @added(ServiceApiVersions.v2025_01_01_Preview)
  audio?: AudioResponseData;

  @added(ServiceApiVersions.v2024_02_15_Preview)
  @doc("""
    If Azure OpenAI chat extensions are configured, this array represents the incremental steps performed by those
    extensions while processing the chat completions request.
    """)
  context?: AzureChatExtensionsMessageContext;
}

/**
 * Object containing audio response data and its metadata.
 */
@added(ServiceApiVersions.v2025_01_01_Preview)
model AudioResponseData {
  /** Unique identifier for this audio response. */
  id: string;

  /**
   * The Unix timestamp (in seconds) for when this audio response
   * will no longer be accessible on the server for use in multi-turn
   * conversations.
   */
  @encodedName("application/json", "expires_at")
  @encode("unixTimestamp", int32)
  expiresAt: utcDateTime;

  /**
   * Base64 encoded audio bytes generated by the model, in the format
   * specified in the request.
   */
  data: string;

  /** Transcript of the audio generated by the model. */
  transcript: string;
}

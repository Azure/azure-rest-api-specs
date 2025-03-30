import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "@typespec/streams";
import "@typespec/versioning";
import "../models.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;

namespace Azure.AI.Projects;

/**
 * An abstract representation of a structured content item within a chat message.
 */
@doc("An abstract representation of a structured content item within a chat message.")
@discriminator("type")
model AIContent {
  type: string;
}

/**
 * Annotations applied to parts of the message or content.
 */
@doc("Annotations applied to parts of the message or content.")
model Annotations {
  /**
   * The type of annotation.
   */
  type: string;

  /**
   * The tool call ID associated with the annotation.
   */
  ToolCallId?: string;

  /**
   * The JSON path associated with the annotation.
   */
  jsonPath?: string;

  /**
   * The URL associated with the annotation.
   */
  url?: string;

  /**
   * The start position of the annotation.
   */
  start?: int32;

  /**
   * The end position of the annotation.
   */
  end?: int32;
}

/**
 * A structured chat content item containing plain text.
 */
@doc("A structured chat content item containing plain text.")
model TextContent extends AIContent {
  type: "text";

  /**
   * The text content.
   */
  text: string;

  /**
   * A list of annotations in the text content.
   */
  annotations?: Annotations[];
}

/**
 * A structured chat content item containing model refusal information
 * for a structured outputs request.
 */
@doc("A structured chat content item containing model refusal information for a structured outputs request.")
model RefusalContent extends AIContent {
  type: "refusal";

  /**
   * Reason for refusal.
   */
  refusal: string;
}

/**
 * A structured chat content item containing a content filter.
 */
@doc("A structured chat content item containing a content filter.")
model ContentFilterContent extends AIContent {
  type: "contentFilter";

  /**
   * Content filter data.
   */
  contentFilter: string;

  /**
   * Whether content was flagged/detected.
   */
  detected: boolean;
}

/**
 * All binary types have a reference to the external data. As-is, we are under-specifying
 * the constraints here because presumably only one of uri, dataUri, or data should be present.
 *
 * We can create a union of types with exactly one property each, or we can add a `data` property
 * that is a discriminated union (or union) if we want to type it stronger. There is a trade-off
 * between the explosion of model types and strict typing here.
 */
@doc("A base content block for referencing file-like or binary data.")
model BinaryContent<Properties extends Reflection.Model> extends AIContent {
  ...Properties;

  /**
   * The file name for this binary content.
   */
  fileName?: string;

  /**
   * The MIME type for this binary content.
   */
  mimeType?: string;

  /**
   * URI where the binary content can be retrieved.
   */
  uri?: url;

  /**
   * Data URI containing the binary content inlined.
   */
  dataUri?: url;

  /**
   * Raw bytes for the binary content.
   */
  data?: bytes;
}

/**
 * A structured chat content item containing a file data item.
 */
@doc("A structured chat content item containing a file data item.")
model FileContent
  is BinaryContent<{
    type: "file";
  }>;

/**
 * A structured chat content item containing an image reference.
 */
@doc("A structured chat content item containing an image reference.")
model ImageContent
  is BinaryContent<{
    type: "image";

    /**
     * Width of the image in pixels (optional).
     */
    width?: int16;

    /**
     * Height of the image in pixels (optional).
     */
    height?: int16;
  }>;

/**
 * A structured chat content item containing an audio reference.
 */
@doc("A structured chat content item containing an audio reference.")
model AudioContent
  is BinaryContent<{
    type: "audio";

    /**
     * Duration of audio in seconds (optional).
     */
    duration?: int16;
  }>;

/**
 * A structured chat content item containing a video reference.
 */
@doc("A structured chat content item containing a video reference.")
model VideoContent
  is BinaryContent<{
    type: "video";

    /**
     * Duration of video in seconds (optional).
     */
    duration?: int16;

    /**
     * Width of video in pixels (optional).
     */
    width?: int16;

    /**
     * Height of video in pixels (optional).
     */
    height?: int16;
  }>;

/**
 * A structured chat content item describing a tool call request.
 */
@doc("A structured chat content item describing a tool call request.")
model ToolCallContent extends AIContent {
  type: "toolCall";

  /**
   * The name of the tool to call.
   */
  name: string;

  /**
   * The unique ID of the tool call.
   */
  toolCallId: string;

  /**
   * Arguments passed to this tool call, expressed as JSON-like data rather than `unknown`.
   */
  arguments?: JSONAny;
}

/**
 * A structured chat content item describing a tool result.
 */
@doc("A structured chat content item describing a tool result.")
model ToolResultContent extends AIContent {
  type: "toolResult";

  /**
   * The ID of the tool call to which this result pertains.
   */
  toolCallId: string;

  /**
   * The results returned from the tool, using JSONAny instead of `unknown`.
   */
  results?: JSONAny;
}

/**
 * Possible roles of the message author (open enum).
 */
@doc("Possible roles of the message author.")
union AuthorRole {
  user: "user",
  agent: "agent",
  system: "system",
  tool: "tool",
  developer: "developer",
  string,
}

/**
 * A base model for representing a chat message.
 */
@Rest.resource("message")
@Rest.parentResource(Thread)
@discriminator("role")
@doc("A base model for representing a chat message.")
model ChatMessage {
  /**
   * The ID of the user who created the message (if applicable).
   */
  @doc("The ID of the user who created the message (if applicable).")
  userId?: string;

  /**
   * The ID of the agent who created the message (if applicable).
   */
  @doc("The ID of the agent who created the message (if applicable).")
  agentId?: string;

  /**
   * A unique identifier for this message.
   */
  @doc("A unique identifier for this message.")
  @key
  @visibility(Lifecycle.Read)
  messageId: string;

  /**
   * A unique run ID, if this message was generated by a run process.
   */
  @doc("A unique run ID, if this message was generated by a run process.")
  agentRunId?: string;

  /**
   * The thread to which this message belongs.
   */
  @doc("The thread to which this message belongs.")
  @visibility(Lifecycle.Read)
  threadId: string;

  /**
   * The role of this message's author, defaults to `user`.
   */
  @doc("The role of this message's author.")
  role?: AuthorRole = "user";

  /**
   * The contents of the message.
   */
  @doc("The contents of the message.")
  content: AIContent[];

  /**
   * An optional display name for the author.
   */
  @doc("An optional display name for the author.")
  authorName?: string;

  /**
   * The timestamp (in Unix time) when this message was created.
   */
  @doc("The timestamp (in Unix time) when this message was created.")
  createdAt?: int64;

  /**
   * The timestamp (in Unix time) when this message was completed, if applicable.
   */
  @doc("The timestamp (in Unix time) when this message was completed, if applicable.")
  completedAt?: int64;
}

/**
 * A user message within a chat, always with the 'user' role.
 */
#suppress "@azure-tools/typespec-autorest/union-unsupported" "We intentionally use a union for OAS 3."
@doc("A user message within a chat, always with the 'user' role.")
model UserMessage extends ChatMessage {
  @doc("Always 'user' for user messages.")
  role: AuthorRole.user;

  /**
   * The contents of a user message, expressed as a single array of possible content types.
   * This avoids the "union of arrays" issue in OpenAPI v2.
   */
  @doc("The contents of the user message.")
  content: (
    | TextContent
    | ImageContent
    | AudioContent
    | VideoContent
    | FileContent)[];
}

/**
 * A developer message within a chat, always with the 'developer' role.
 */
@doc("A developer message within a chat, always with the 'developer' role.")
model DeveloperMessage extends ChatMessage {
  @doc("Always 'developer' for developer messages.")
  role: AuthorRole.developer;

  /**
   * The contents of a developer message, expressed as a single array of possible content types.
   */
  @doc("The contents of the developer message.")
  content: TextContent[];
}

/**
 * An agent message within a chat, always with the 'agent' role.
 */
#suppress "@azure-tools/typespec-autorest/union-unsupported" "We intentionally use a union for OAS 3."
@doc("An agent message within a chat, always with the 'agent' role.")
model AgentMessage extends ChatMessage {
  @doc("Always 'agent' for agent messages.")
  role: AuthorRole.agent;

  /**
   * The contents of the agent message, as a single array of possible content types.
   */
  @doc("The contents of the agent message.")
  content: (
    | TextContent
    | RefusalContent
    | ContentFilterContent
    | ImageContent
    | AudioContent
    | VideoContent
    | FileContent
    | ToolCallContent)[];
}

/**
 * A system message within a chat, always with the 'system' role.
 */
@doc("A system message within a chat, always with the 'system' role.")
model SystemMessage extends ChatMessage {
  @doc("Always 'system' for system messages.")
  role: AuthorRole.system;

  /**
   * The contents of the system message (only text allowed).
   */
  @doc("The contents of the system message.")
  content: TextContent[];
}

/**
 * A tool message within a chat, always with the 'tool' role.
 */
@doc("A tool message within a chat, always with the 'tool' role.")
model ToolMessage extends ChatMessage {
  @doc("Always 'tool' for tool messages.")
  role: AuthorRole.tool;

  /**
   * The contents of the tool message (only tool results allowed).
   */
  @doc("The contents of the tool message.")
  content: ToolResultContent[];
}

/**
 * Represents a chat thread, which can contain multiple messages.
 */
@doc("Represents a chat thread, which can contain multiple messages.")
@resource("threads")
model Thread {
  /**
   * A unique identifier for this thread.
   */
  @doc("A unique identifier for this thread.")
  @key
  @visibility(Lifecycle.Read)
  threadId: string;

  /**
   * A list of messages in this thread.
   */
  @doc("A list of messages in this thread.")
  messages: ChatMessage[];
}

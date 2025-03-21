import "@azure-tools/typespec-azure-core";

import "@typespec/rest";
import "@typespec/streams";
import "@typespec/versioning";

using TypeSpec.Rest;
using TypeSpec.Http;

@doc("An abstract representation of a structured content item within a chat message.")
@discriminator("type")
model AIContent {
  type: string;
}

model Annotations {
  type: string;
  ToolCallId?: string;
  jsonPath?: string;
  url?: string;
  start?: int32;
  end?: int32;
}

@doc("A structured chat content item containing plain text.")
model TextContent extends AIContent {
  type: "text";
  text: string;
  annotations: Annotations[];
}

@doc("A structured chat content item containing model refusal information for a structured outputs request.")
model RefusalContent extends AIContent {
  type: "refusal";
  refusal: string;
}

@doc("A structured chat content item containing a content filter.")
model ContentFilterContent extends AIContent {
  type: "contentFilter";
  contentFilter: string;
  detected: boolean;
}


/**
 * All binary types have a reference to the external data. As-is, we are under-specifying the constraints
 * here because presumably only one of uri, dataUri, or data should be present.
 *
 * We can create a union of types with exactly one property each, or we can add a `data` property
 * that is a discriminated union (or union) if we want to type it stronger. There is a trade-off
 * between the explosion of model types and strict typing here.
 */
model BinaryContent<Properties extends Reflection.Model> extends AIContent {
  ...Properties;
  fileName?: string;
  mimeType?: string;
  
  uri?: url;
  dataUri?: url;
  data?: bytes;
}

@doc("A structured chat content item containing a file data item.")
model FileContent
  is BinaryContent<{
    type: "file";
  }>;

@doc("A structured chat content item containing an image reference.")
model ImageContent
  is BinaryContent<{
    type: "image";
    width?: int16;
    height?: int16;
  }>;

model AudioContent
  is BinaryContent<{
    type: "audio";
    duration?: int16;
  }>;

model VideoContent
  is BinaryContent<{
    type: "video";
    duration?: int16;
    width?: int16;
    height?: int16;
  }>;

model ToolCallContent extends AIContent {
  type: "toolCall";
  name: string;
  toolCallId: string;
  arguments?: Record<unknown>;
}

model ToolResultContent extends AIContent {
  type: "toolResult";
  toolCallId: string;
  results?: unknown;
}

union AuthorRole {
  user: "user",
  agent: "agent",
  system: "system",
  tool: "tool",
  developer: "developer"
}

@Rest.resource("message")
@Rest.parentResource(Thread)
@discriminator("role")
model ChatMessage {
  userId?: string;
  agentId?: string;

  @key
  @visibility(Lifecycle.Read)
  messageId: string;

  completionId?: string;

  @visibility(Lifecycle.Read)
  threadId: string;
  role: AuthorRole;

  @doc("The contents of the message.")
  content: AIContent[];

  @doc("An optional name for the participant.")
  authorName?: string;

  @doc("The timestamp of the message.")
  createdAt?: int64;

  completedAt?: int64;
}
  

model UserMessage extends ChatMessage {
  @doc("The chat role associated with this message, which is always 'user' for user messages.")
  role: AuthorRole.user;

  @doc("The contents of the message.")
  content:
    | TextContent[]
    | ImageContent[]
    | AudioContent[]
    | VideoContent[]
    | FileContent[];
}
model DeveloperMessage extends ChatMessage {
  @doc("The chat role associated with this message, which is always 'developer' for developer messages.")
  role: AuthorRole.developer;

  @doc("The contents of the message.")
  content: TextContent[];
}

model AgentMessage extends ChatMessage {
  @doc("The chat role associated with this message, which is always 'agent' for agent messages.")
  role: AuthorRole.agent;

  @doc("The contents of the message.")
  content:
    | TextContent[]
    | RefusalContent[]
    | ContentFilterContent[]
    | ImageContent[]
    | AudioContent[]
    | VideoContent[]
    | FileContent[]
    | ToolCallContent[];
}

model SystemMessage extends ChatMessage {
  @doc("The chat role associated with this message, which is always 'system' for system messages.")
  role: AuthorRole.system;

  @doc("The contents of the message.")
  content: TextContent[];
}

model ToolMessage extends ChatMessage {
  @doc("The chat role associated with this message, which is always 'tool' for tool messages.")
  role: AuthorRole.tool;

  @doc("The contents of the message.")
  content: ToolResultContent[];
}

@resource("threads")
model Thread {
  @key
  threadId: string;

  messages: ChatMessage[];
}
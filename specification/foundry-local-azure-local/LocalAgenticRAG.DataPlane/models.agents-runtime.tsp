import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.Core;

namespace FoundryLocal.AgenticRAG;

// ──── Agents Runtime enums ────

/** The object type for thread resources. */
union ThreadObjectType {
  string,

  /** Indicates a thread object. */
  thread: "thread",
}

/** The role of a message author. */
union MessageRole {
  string,

  /** A message from the user. */
  user: "user",

  /** A message from the assistant. */
  assistant: "assistant",

  /** A system message. */
  system: "system",
}

/** The object type for message resources. */
union MessageObjectType {
  string,

  /** Indicates a thread message object. */
  `thread.message`: "thread.message",
}

/** The type of a content block within a message. */
union ContentBlockType {
  string,

  /** A text content block. */
  text: "text",

  /** An image URL content block. */
  image_url: "image_url",
}

/** The object type for run resources. */
union RunObjectType {
  string,

  /** Indicates a thread run object. */
  `thread.run`: "thread.run",
}

/** The execution status of a run. */
union RunStatus {
  string,

  /** The run is queued for execution. */
  queued: "queued",

  /** The run is currently in progress. */
  in_progress: "in_progress",

  /** The run completed successfully. */
  completed: "completed",

  /** The run failed. */
  failed: "failed",

  /** The run was cancelled. */
  cancelled: "cancelled",
}

/** The object type for run step resources. */
union RunStepObjectType {
  string,

  /** Indicates a thread run step object. */
  `thread.run.step`: "thread.run.step",
}

/** The type of a run step. */
union RunStepType {
  string,

  /** A message creation step. */
  message_creation: "message_creation",

  /** A tool calls step. */
  tool_calls: "tool_calls",

  /** An MCP call step. */
  mcp_call: "mcp_call",
}

// ──── Agents Runtime models ────

/** Request body for creating a new thread. */
model CreateThreadRequest {
  /** The title of the thread. */
  title?: string;

  /** Dictionary of <string> */
  metadata?: Record<string>;
}

/** Represents a conversation thread. */
model Thread {
  /** The unique identifier of the thread. */
  @visibility(Lifecycle.Read)
  id?: string;

  /** The object type of this resource. */
  object?: ThreadObjectType;

  /** Unix epoch timestamp. */
  @encodedName("application/json", "created_at")
  createdAt?: int64;

  /** The title of the thread. */
  title?: string;

  /** The identifier of the thread owner. */
  @encodedName("application/json", "owner_id")
  ownerId?: string;

  /** Dictionary of <string> */
  metadata?: Record<string>;
}

/** A paginated list of threads. */
model ThreadList {
  /** The object type of this response. */
  object?: ListObjectType;

  /** The list of threads. */
  @pageItems
  data?: Thread[];

  /** The identifier of the first thread in the list. */
  @encodedName("application/json", "first_id")
  firstId?: string;

  /** The identifier of the last thread in the list. */
  @encodedName("application/json", "last_id")
  lastId?: string;

  /** Whether there are more threads available. */
  @encodedName("application/json", "has_more")
  hasMore?: boolean;
}

/** Request body for modifying an existing thread. */
model ModifyThreadRequest {
  /** The updated title of the thread. */
  title?: string;

  /** Dictionary of <string> */
  metadata?: Record<string>;
}

/** Request body for creating a new message in a thread. */
model CreateMessageRequest {
  /** The role of the message author. */
  role: MessageRole;

  /** Content of the message. Can be a string or content blocks array. */
  content: string;

  /** Dictionary of <string> */
  metadata?: Record<string>;

  /** File or tool attachments for the message. */
  attachments?: Record<string>[];
}

/** Represents a message within a thread. */
model Message {
  /** The unique identifier of the message. */
  @visibility(Lifecycle.Read)
  id?: string;

  /** The object type of this resource. */
  object?: MessageObjectType;

  /** Unix epoch timestamp of when the message was created. */
  @encodedName("application/json", "created_at")
  createdAt?: int64;

  /** The identifier of the thread this message belongs to. */
  @encodedName("application/json", "thread_id")
  threadId?: string;

  /** The role of the message author. */
  role?: MessageRole;

  /** The content blocks of the message. */
  content?: ContentBlock[];

  /** The identifier of the agent that created the message. */
  @encodedName("application/json", "agent_id")
  agentId?: string;

  /** The identifier of the run that created the message. */
  @encodedName("application/json", "run_id")
  runId?: string;

  /** File or tool attachments for the message. */
  attachments?: Record<string>[];

  /** Dictionary of <string> */
  metadata?: Record<string>;
}

/** A block of content within a message. */
model ContentBlock {
  /** The type of this content block. */
  type?: ContentBlockType;

  /** The text content, present when type is text. */
  text?: ContentBlockText;

  /** The image URL content, present when type is image_url. */
  @encodedName("application/json", "image_url")
  imageUrl?: ContentBlockImageUrl;
}

/** Text content within a content block. */
model ContentBlockText {
  /** The text value. */
  value?: string;

  /** Annotations on the text content. */
  annotations?: Record<string>[];
}

/** Image URL content within a content block. */
model ContentBlockImageUrl {
  /** The URL of the image. */
  url?: string;

  /** The detail level for the image. */
  detail?: string;
}

/** A paginated list of messages. */
model MessageList {
  /** The object type of this response. */
  object?: ListObjectType;

  /** The list of messages. */
  @pageItems
  data?: Message[];

  /** The identifier of the first message in the list. */
  @encodedName("application/json", "first_id")
  firstId?: string;

  /** The identifier of the last message in the list. */
  @encodedName("application/json", "last_id")
  lastId?: string;

  /** Whether there are more messages available. */
  @encodedName("application/json", "has_more")
  hasMore?: boolean;
}

/** Request body for creating a run on a thread. */
model CreateRunRequest {
  /** ID of the knowledge base (format: asst_{uuid}). */
  @encodedName("application/json", "agent_id")
  agentId: string;

  /** Instructions for the agent to follow during the run. */
  instructions?: string;

  /** Additional messages to include in the run. */
  @encodedName("application/json", "additional_messages")
  additionalMessages?: CreateRunRequestAdditionalMessagesItem[];

  /** Dictionary of <string> */
  metadata?: Record<string>;
}

/** An additional message to include when creating a run. */
model CreateRunRequestAdditionalMessagesItem {
  /** The role of the message author. */
  role: string;

  /** The content of the message. */
  content: string;
}

/** Represents an execution run on a thread. */
model Run {
  /** The unique identifier of the run. */
  @visibility(Lifecycle.Read)
  id?: string;

  /** The object type of this resource. */
  object?: RunObjectType;

  /** Unix epoch timestamp of when the run was created. */
  @encodedName("application/json", "created_at")
  createdAt?: int64;

  /** The identifier of the thread this run belongs to. */
  @encodedName("application/json", "thread_id")
  threadId?: string;

  /** The identifier of the agent used for this run. */
  @encodedName("application/json", "agent_id")
  agentId?: string;

  /** The current status of the run. */
  status?: RunStatus;

  /** The instructions used for this run. */
  instructions?: string;

  /** The last error that occurred during the run, if any. */
  @encodedName("application/json", "last_error")
  lastError?: RunError;

  /** Token usage statistics for the run. */
  usage?: Usage;

  /** Dictionary of <string> */
  metadata?: Record<string>;

  /** Unix epoch timestamp of when the run started. */
  @encodedName("application/json", "started_at")
  startedAt?: int64;

  /** Unix epoch timestamp of when the run completed. */
  @encodedName("application/json", "completed_at")
  completedAt?: int64;

  /** Unix epoch timestamp of when the run failed. */
  @encodedName("application/json", "failed_at")
  failedAt?: int64;

  /** Unix epoch timestamp of when the run was cancelled. */
  @encodedName("application/json", "cancelled_at")
  cancelledAt?: int64;
}

/** Token usage statistics for a run. */
model Usage {
  /** The number of prompt tokens used. */
  @encodedName("application/json", "prompt_tokens")
  promptTokens?: int32;

  /** The number of completion tokens generated. */
  @encodedName("application/json", "completion_tokens")
  completionTokens?: int32;

  /** The total number of tokens used. */
  @encodedName("application/json", "total_tokens")
  totalTokens?: int32;
}

/** A paginated list of run steps. */
model RunStepList {
  /** The object type of this response. */
  object?: ListObjectType;

  /** The list of run steps. */
  @pageItems
  data?: RunStep[];

  /** The identifier of the first run step in the list. */
  @encodedName("application/json", "first_id")
  firstId?: string;

  /** The identifier of the last run step in the list. */
  @encodedName("application/json", "last_id")
  lastId?: string;

  /** Whether there are more run steps available. */
  @encodedName("application/json", "has_more")
  hasMore?: boolean;
}

/** Represents a single step within a run. */
model RunStep {
  /** The unique identifier of the run step. */
  @visibility(Lifecycle.Read)
  id?: string;

  /** The object type of this resource. */
  object?: RunStepObjectType;

  /** Unix epoch timestamp of when the step was created. */
  @encodedName("application/json", "created_at")
  createdAt?: int64;

  /** The identifier of the run this step belongs to. */
  @encodedName("application/json", "run_id")
  runId?: string;

  /** The identifier of the thread this step belongs to. */
  @encodedName("application/json", "thread_id")
  threadId?: string;

  /** The type of this run step. */
  type?: RunStepType;

  /** Details vary by step type. Contains step-specific structured data. */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "Step details are polymorphic and vary by step type"
  #suppress "@azure-tools/typespec-azure-core/bad-record-type" "Step details are polymorphic and vary by step type"
  @encodedName("application/json", "step_details")
  stepDetails?: Record<unknown>;

  /** Unix epoch timestamp of when the step completed. */
  @encodedName("application/json", "completed_at")
  completedAt?: int64;
}

/** Represents an error that occurred during a run. */
model RunError {
  /** The error code. */
  code?: string;

  /** A human-readable error message. */
  message?: string;
}

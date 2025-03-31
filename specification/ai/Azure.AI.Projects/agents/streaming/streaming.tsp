namespace Azure.AI.Projects;

/**
 * Represents an operation to update a specific JSON path with streamed data.
 */
@discriminator("op")
@doc("Represents an operation to update a specific JSON path with streamed data.")
model StreamingOperation {
  /**
   * The JSON path to the operation.
   */
  @doc("The JSON path to the operation.")
  jsonPath: string;

  /**
   * The type of operation being performed.
   */
  @doc("The type of operation being performed.")
  type: "append" | "remove" | "replace" | "set" | string;
}

/**
 * Sets (overwrites) the value at a JSON path.
 */
@doc("Sets (overwrites) the value at a JSON path.")
model SetStreamingOperation extends StreamingOperation {
  `op`: "set";

  /**
   * The value to apply to the operation, expressed as a JSON-compatible type.
   *
   * Here we use JSONAny from models.tsp to ensure we don't use 'unknown'.
   */
  @doc("The value to apply to the operation, expressed as a JSON-compatible type.")
  value?: JSONAny;
}

/**
 * Appends a value to a list at a JSON path.
 */
@doc("Appends a value to a list at a JSON path.")
model AppendStreamingOperation extends StreamingOperation {
  `op`: "append";

  /**
   * The value to apply to the operation, expressed as a JSON-compatible type.
   *
   * Here we use JSONAny from models.tsp to ensure we don't use 'unknown'.
   */
  @doc("The value to apply to the operation, expressed as a JSON-compatible type.")
  value?: JSONAny;
}

/**
 * Replaces part of a string value at a JSON path.
 */
@doc("Replaces part of a string value at a JSON path.")
model ReplaceStreamingOperation extends StreamingOperation {
  `op`: "replace";

  /**
   * The new string value.
   */
  @doc("The new string value.")
  v: string;

  /**
   * Start index of the replacement.
   */
  @doc("Start index of the replacement.")
  s: int32;

  /**
   * End index of the replacement.
   */
  @doc("End index of the replacement.")
  e: int32;
}

/**
 * Removes part of a value at a JSON path.
 */
@doc("Removes part of a value at a JSON path.")
model RemoveStreamingOperation extends StreamingOperation {
  `op`: "remove";

  /**
   * Start index of the removal.
   */
  @doc("Start index of the removal.")
  s: int32;

  /**
   * End index of the removal.
   */
  @doc("End index of the removal.")
  e: int32;
}

/**
 * The delta operation applied to the resource.
 */
@discriminator("type")
model StreamingUpdate {
  /**
   * The delta operation applied to the resource.
   */
  @doc("The delta operation applied to the resource.")
  d?: StreamingOperation;

  /**
   * The type of the streaming update.
   */
  @doc("The type of the streaming update.")
  type: "run" | "thread" | "chat_message" | "ai_content" | string;
}

/**
 * Streaming update for a run.
 */
@doc("Streaming update for a run.")
model RunUpdate extends StreamingUpdate {
  /**
   * The delta operation applied to the resource.
   */
  @doc("The update type for the streaming payload.")
  type: "run";

  /**
   * The run ID.
   */
  @doc("The run ID.")
  rId: string;

  /**
   * The thread ID.
   */
  @doc("The thread ID.")
  tId: string;

  /**
   * The delta operation applied to the run.
   */
  @doc("The delta operation applied to the run.")
  d?: StreamingOperation;

  /**
   * Usage metrics update.
   */
  @doc("Usage metrics update.")
  u?: CompletionUsage;
}

/**
 * Streaming update for a thread.
 */
@doc("Streaming update for a thread.")
model ThreadUpdate extends StreamingUpdate {
  /**
   * The update type for the streaming payload.
   */
  @doc("The update type for the streaming payload.")
  type: "thread";

  /**
   * The thread ID.
   */
  @doc("The thread ID.")
  tId: string;

  /**
   * The delta operation applied to the thread.
   */
  @doc("The delta operation applied to the thread.")
  d?: StreamingOperation;

  /**
   * Usage metrics update.
   */
  @doc("Usage metrics update.")
  u?: CompletionUsage;
}

/**
 * Streaming update for a chat message.
 */
@doc("Streaming update for a chat message.")
model ChatMessageUpdate extends StreamingUpdate {
  /**
   * The update type for the streaming payload.
   */
  @doc("The update type for the streaming payload.")
  type: "chat_message";

  /**
   * The message ID.
   */
  @doc("The message ID.")
  mId: string;

  /**
   * The thread ID.
   */
  @doc("The thread ID.")
  tId: string;

  /**
   * The delta operation applied to the message.
   */
  @doc("The delta operation applied to the message.")
  d?: StreamingOperation;

  /**
   * Usage metrics update.
   */
  @doc("Usage metrics update.")
  u?: CompletionUsage;
}

/**
 * Streaming update for AI content in a message.
 */
@doc("Streaming update for AI content in a message.")
model AIContentUpdate extends StreamingUpdate {
  /**
   * The update type for the streaming payload.
   */
  @doc("The update type for the streaming payload.")
  type: "ai_content";

  /**
   * The message ID.
   */
  @doc("The message ID.")
  mId: string;

  /**
   * The index in the content list.
   */
  @doc("The index in the content list.")
  i: int32;

  /**
   * The delta operation applied to the AI content.
   */
  @doc("The delta operation applied to the AI content.")
  d?: StreamingOperation;
}

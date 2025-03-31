namespace Azure.AI.Projects;

@discriminator("op")
@doc("Represents an operation to update a specific JSON path with streamed data.")
model StreamingOperation {
  @doc("The JSON path to the operation.")
  jsonPath: string;

  @doc("The type of operation being performed.")
  type: "append" | "remove" | "replace" | "set" | string;
}

@doc("Sets (overwrites) the value at a JSON path.")
model SetStreamingOperation extends StreamingOperation {
  `op`: "set";

  @doc("The value to apply to the operation, expressed as a JSON-compatible type.")
  value?: JSONAny;
}

@doc("Appends a value to a list at a JSON path.")
model AppendStreamingOperation extends StreamingOperation {
  `op`: "append";

  @doc("The value to apply to the operation, expressed as a JSON-compatible type.")
  value?: JSONAny;
}

@doc("Replaces part of a string value at a JSON path.")
model ReplaceStreamingOperation extends StreamingOperation {
  `op`: "replace";

  @doc("The new string value.")
  v: string;

  @doc("Start index of the replacement.")
  s: int32;

  @doc("End index of the replacement.")
  e: int32;
}

@doc("Removes part of a value at a JSON path.")
model RemoveStreamingOperation extends StreamingOperation {
  `op`: "remove";

  @doc("Start index of the removal.")
  s: int32;

  @doc("End index of the removal.")
  e: int32;
}

@doc("The delta operation applied to the resource.")
@discriminator("type")
model StreamingUpdate {
  @doc("The delta operation applied to the resource.")
  d?: StreamingOperation;

  @doc("The type of the streaming update.")
  type: "run" | "thread" | "chat_message" | "ai_content" | string;
}

@doc("Streaming update for a run.")
model RunUpdate extends StreamingUpdate {
  @doc("The update type for the streaming payload.")
  type: "run";

  @doc("The run ID.")
  rId: string;

  @doc("The thread ID.")
  tId: string;

  @doc("The delta operation applied to the run.")
  d?: StreamingOperation;

  @doc("Usage metrics update.")
  u?: CompletionUsage;
}

@doc("Streaming update for a thread.")
model ThreadUpdate extends StreamingUpdate {
  @doc("The update type for the streaming payload.")
  type: "thread";

  @doc("The thread ID.")
  tId: string;

  @doc("The delta operation applied to the thread.")
  d?: StreamingOperation;

  @doc("Usage metrics update.")
  u?: CompletionUsage;
}

@doc("Streaming update for a chat message.")
model ChatMessageUpdate extends StreamingUpdate {
  @doc("The update type for the streaming payload.")
  type: "chat_message";

  @doc("The message ID.")
  mId: string;

  @doc("The thread ID.")
  tId: string;

  @doc("The delta operation applied to the message.")
  d?: StreamingOperation;

  @doc("Usage metrics update.")
  u?: CompletionUsage;
}

@doc("Streaming update for AI content in a message.")
model AIContentUpdate extends StreamingUpdate {
  @doc("The update type for the streaming payload.")
  type: "ai_content";

  @doc("The message ID.")
  mId: string;

  @doc("The index in the content list.")
  i: int32;

  @doc("The delta operation applied to the AI content.")
  d?: StreamingOperation;
}

import "@typespec/versioning";

using TypeSpec.Versioning;

namespace Azure.AI.OpenAI.Assistants;

@doc("""
  Each event in a server-sent events stream has an `event` and `data` property:
  
  ```
  event: thread.created
  data: {"id": "thread_123", "object": "thread", ...}
  ```
  
  We emit events whenever a new object is created, transitions to a new state, or is being
  streamed in parts (deltas). For example, we emit `thread.run.created` when a new run
  is created, `thread.run.completed` when a run completes, and so on. When an Assistant chooses
  to create a message during a run, we emit a `thread.message.created event`, a
  `thread.message.in_progress` event, many `thread.message.delta` events, and finally a
  `thread.message.completed` event.
  
  We may add additional events over time, so we recommend handling unknown events gracefully
  in your code.
  """)
union AssistantStreamEvent {
  string,
  ThreadStreamEvent,
  RunStreamEvent,
  RunStepStreamEvent,
  MessageStreamEvent,
  ErrorEvent,
  DoneEvent,
}

/** Thread operation related streaming events */
union ThreadStreamEvent {
  string,

  /** Event sent when a new thread is created. The data of this event is of type AssistantThread */
  ThreadCreated: "thread.created",
}

/** Run operation related streaming events */
@added(ServiceApiVersions.v2024_02_15_preview)
union RunStreamEvent {
  string,

  /** Event sent when a new run is created. The data of this event is of type ThreadRun */
  @added(ServiceApiVersions.v2024_02_15_preview)
  ThreadRunCreated: "thread.run.created",

  /** Event sent when a run moves to `queued` status. The data of this event is of type ThreadRun */
  @added(ServiceApiVersions.v2024_02_15_preview)
  ThreadRunQueued: "thread.run.queued",

  /** Event sent when a run moves to `in_progress` status. The data of this event is of type ThreadRun */
  @added(ServiceApiVersions.v2024_02_15_preview)
  ThreadRunInProgress: "thread.run.in_progress",

  /** Event sent when a run moves to `requires_action` status. The data of this event is of type ThreadRun */
  @added(ServiceApiVersions.v2024_02_15_preview)
  ThreadRunRequiresAction: "thread.run.requires_action",

  /** Event sent when a run is completed. The data of this event is of type ThreadRun */
  @added(ServiceApiVersions.v2024_02_15_preview)
  ThreadRunCompleted: "thread.run.completed",

  /** Event sent when a run fails. The data of this event is of type ThreadRun */
  @added(ServiceApiVersions.v2024_02_15_preview)
  ThreadRunFailed: "thread.run.failed",

  /** Event sent when a run moves to `cancelling` status. The data of this event is of type ThreadRun */
  @added(ServiceApiVersions.v2024_02_15_preview)
  ThreadRunCancelling: "thread.run.cancelling",

  /** Event sent when a run is cancelled. The data of this event is of type ThreadRun */
  @added(ServiceApiVersions.v2024_02_15_preview)
  ThreadRunCancelled: "thread.run.cancelled",

  /** Event sent when a run is expired. The data of this event is of type ThreadRun */
  @added(ServiceApiVersions.v2024_02_15_preview)
  ThreadRunExpired: "thread.run.expired",
}

/** Run step operation related streaming events */
@added(ServiceApiVersions.v2024_02_15_preview)
union RunStepStreamEvent {
  string,

  /** Event sent when a new thread run step is created. The data of this event is of type RunStep */
  @added(ServiceApiVersions.v2024_02_15_preview)
  ThreadRunStepCreated: "thread.run.step.created",

  /** Event sent when a run step moves to `in_progress` status. The data of this event is of type RunStep */
  @added(ServiceApiVersions.v2024_02_15_preview)
  ThreadRunStepInProgress: "thread.run.step.in_progress",

  /** Event sent when a run stepis being streamed. The data of this event is of type RunStepDeltaChunk */
  @added(ServiceApiVersions.v2024_02_15_preview)
  ThreadRunStepDelta: "thread.run.step.delta",

  /** Event sent when a run step is completed. The data of this event is of type RunStep */
  @added(ServiceApiVersions.v2024_02_15_preview)
  ThreadRunStepCompleted: "thread.run.step.completed",

  /** Event sent when a run step fails. The data of this event is of type RunStep */
  @added(ServiceApiVersions.v2024_02_15_preview)
  ThreadRunStepFailed: "thread.run.step.failed",

  /** Event sent when a run step is cancelled. The data of this event is of type RunStep */
  @added(ServiceApiVersions.v2024_02_15_preview)
  ThreadRunStepCancelled: "thread.run.step.cancelled",

  /** Event sent when a run step is expired. The data of this event is of type RunStep */
  @added(ServiceApiVersions.v2024_02_15_preview)
  ThreadRunStepExpired: "thread.run.step.expired",
}

/** Message operation related streaming events */
@added(ServiceApiVersions.v2024_02_15_preview)
union MessageStreamEvent {
  string,

  /** Event sent when a new message is created. The data of this event is of type ThreadMessage */
  @added(ServiceApiVersions.v2024_02_15_preview)
  ThreadMessageCreated: "thread.message.created",

  /** Event sent when a message moves to `in_progress` status. The data of this event is of type ThreadMessage */
  @added(ServiceApiVersions.v2024_02_15_preview)
  ThreadMessageInProgress: "thread.message.in_progress",

  /** Event sent when a message is being streamed. The data of this event is of type MessageDeltaChunk */
  @added(ServiceApiVersions.v2024_02_15_preview)
  ThreadMessageDelta: "thread.message.delta",

  /** Event sent when a message is completed. The data of this event is of type ThreadMessage */
  @added(ServiceApiVersions.v2024_02_15_preview)
  ThreadMessageCompleted: "thread.message.completed",

  /** Event sent before a message is completed. The data of this event is of type ThreadMessage */
  @added(ServiceApiVersions.v2024_02_15_preview)
  ThreadMessageIncomplete: "thread.message.incomplete",
}

/** Terminal event indicating a server side error while streaming. */
@added(ServiceApiVersions.v2024_02_15_preview)
union ErrorEvent {
  string,

  /** Event sent when an error occurs, such as an internal server error or a timeout. */
  @added(ServiceApiVersions.v2024_02_15_preview)
  Error: "error",
}

/** Terminal event indicating the successful end of a stream. */
@added(ServiceApiVersions.v2024_02_15_preview)
union DoneEvent {
  string,

  /** Event sent when the stream is done. */
  @added(ServiceApiVersions.v2024_02_15_preview)
  Done: "done",
}

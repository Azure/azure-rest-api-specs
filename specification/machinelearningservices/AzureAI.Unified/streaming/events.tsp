import "@typespec/versioning";

using TypeSpec.Versioning;

namespace Microsoft.MachineLearningServices;

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

    | ThreadStreamEvent
    | RunStreamEvent
    | RunStepStreamEvent
    | MessageStreamEvent
    | ErrorEvent
    | DoneEvent,
}

@doc("Thread operation related streaming events")
union ThreadStreamEvent {
  string,

  @doc("Event sent when a new thread is created. The data of this event is of type AssistantThread")
  ThreadCreated: "thread.created",
}

@doc("Run operation related streaming events")
union RunStreamEvent {
  string,

  @doc("Event sent when a new run is created. The data of this event is of type ThreadRun")
  ThreadRunCreated: "thread.run.created",

  @doc("Event sent when a run moves to `queued` status. The data of this event is of type ThreadRun")
  ThreadRunQueued: "thread.run.queued",

  @doc("Event sent when a run moves to `in_progress` status. The data of this event is of type ThreadRun")
  ThreadRunInProgress: "thread.run.in_progress",

  @doc("Event sent when a run moves to `requires_action` status. The data of this event is of type ThreadRun")
  ThreadRunRequiresAction: "thread.run.requires_action",

  @doc("Event sent when a run is completed. The data of this event is of type ThreadRun")
  ThreadRunCompleted: "thread.run.completed",

  @doc("Event sent when a run fails. The data of this event is of type ThreadRun")
  ThreadRunFailed: "thread.run.failed",

  @doc("Event sent when a run moves to `cancelling` status. The data of this event is of type ThreadRun")
  ThreadRunCancelling: "thread.run.cancelling",

  @doc("Event sent when a run is cancelled. The data of this event is of type ThreadRun")
  ThreadRunCancelled: "thread.run.cancelled",

  @doc("Event sent when a run is expired. The data of this event is of type ThreadRun")
  ThreadRunExpired: "thread.run.expired",
}

@doc("Run step operation related streaming events")
union RunStepStreamEvent {
  string,

  @doc("Event sent when a new thread run step is created. The data of this event is of type RunStep")
  ThreadRunStepCreated: "thread.run.step.created",

  @doc("Event sent when a run step moves to `in_progress` status. The data of this event is of type RunStep")
  ThreadRunStepInProgress: "thread.run.step.in_progress",

  @doc("Event sent when a run step is being streamed. The data of this event is of type RunStepDeltaChunk")
  ThreadRunStepDelta: "thread.run.step.delta",

  @doc("Event sent when a run step is completed. The data of this event is of type RunStep")
  ThreadRunStepCompleted: "thread.run.step.completed",

  @doc("Event sent when a run step fails. The data of this event is of type RunStep")
  ThreadRunStepFailed: "thread.run.step.failed",

  @doc("Event sent when a run step is cancelled. The data of this event is of type RunStep")
  ThreadRunStepCancelled: "thread.run.step.cancelled",

  @doc("Event sent when a run step is expired. The data of this event is of type RunStep")
  ThreadRunStepExpired: "thread.run.step.expired",
}

@doc("Message operation related streaming events")
union MessageStreamEvent {
  string,

  @doc("Event sent when a new message is created. The data of this event is of type ThreadMessage")
  ThreadMessageCreated: "thread.message.created",

  @doc("Event sent when a message moves to `in_progress` status. The data of this event is of type ThreadMessage")
  ThreadMessageInProgress: "thread.message.in_progress",

  @doc("Event sent when a message is being streamed. The data of this event is of type MessageDeltaChunk")
  ThreadMessageDelta: "thread.message.delta",

  @doc("Event sent when a message is completed. The data of this event is of type ThreadMessage")
  ThreadMessageCompleted: "thread.message.completed",

  @doc("Event sent before a message is completed. The data of this event is of type ThreadMessage")
  ThreadMessageIncomplete: "thread.message.incomplete",
}

@doc("Terminal event indicating a server side error while streaming.")
union ErrorEvent {
  string,

  @doc("Event sent when an error occurs, such as an internal server error or a timeout.")
  Error: "error",
}

@doc("Terminal event indicating the successful end of a stream.")
union DoneEvent {
  string,

  @doc("Event sent when the stream is done.")
  Done: "done",
}

import "@typespec/versioning";

using TypeSpec.Versioning;

namespace Azure.AI.OpenAI.Assistants;

union AssistantStreamEvent { ThreadStreamEvent | RunStreamEvent | RunStepStreamEvent | MessageStreamEvent | ErrorEvent | DoneEvent }

/** Thread operation related streaming events */
union ThreadStreamEvent {
    string,

    /** Event sent when a new thread is created. The data of this event is of type AssistantThread */
    ThreadCreated : "thread.created",
}

/** Run operation related streaming events */
@added(ServiceApiVersions.vFuturePlaceholder)
union RunStreamEvent {
    string, 
    /** Event sent when a new run is created. The data of this event is of type ThreadRun */
    @added(ServiceApiVersions.vFuturePlaceholder)
    ThreadRunCreated: "thread.run.created",

    /** Event sent when a run moves to `queued` status. The data of this event is of type ThreadRun */
    @added(ServiceApiVersions.vFuturePlaceholder)
    ThreadRunQueued: "thread.run.queued",

    /** Event sent when a run moves to `in_progress` status. The data of this event is of type ThreadRun */
    @added(ServiceApiVersions.vFuturePlaceholder)
    ThreadRunInProgress: "thread.run.in_progress",

    /** Event sent when a run moves to `requires_action` status. The data of this event is of type ThreadRun */
    @added(ServiceApiVersions.vFuturePlaceholder)
    ThreadRunRequiresAction: "thread.run.requires_action",

    /** Event sent when a run is completed. The data of this event is of type ThreadRun */
    @added(ServiceApiVersions.vFuturePlaceholder)
    ThreadRunCompleted: "thread.run.completed",

    /** Event sent when a run fails. The data of this event is of type ThreadRun */
    @added(ServiceApiVersions.vFuturePlaceholder)
    ThreadRunFailed: "thread.run.failed",

    /** Event sent when a run moves to `cancelling` status. The data of this event is of type ThreadRun */
    @added(ServiceApiVersions.vFuturePlaceholder)
    ThreadRunCancelling: "thread.run.cancelling",

    /** Event sent when a run is cancelled. The data of this event is of type ThreadRun */
    @added(ServiceApiVersions.vFuturePlaceholder)
    ThreadRunCancelled: "thread.run.cancelled",

    /** Event sent when a run is expired. The data of this event is of type ThreadRun */
    @added(ServiceApiVersions.vFuturePlaceholder)
    ThreadRunExpired: "thread.run.expired",
}

/** Run step operation related streaming events */
@added(ServiceApiVersions.vFuturePlaceholder)
union RunStepStreamEvent {
    string,

    /** Event sent when a new thread run step is created. The data of this event is of type RunStep */
    @added(ServiceApiVersions.vFuturePlaceholder)
    ThreadRunStepCreated: "thread.run.step.created",

    /** Event sent when a run step moves to `in_progress` status. The data of this event is of type RunStep */
    @added(ServiceApiVersions.vFuturePlaceholder)
    ThreadRunStepInProgress: "thread.run.step.in_progress",

    /** Event sent when a run stepis being streamed. The data of this event is of type RunStepDelta */
    @added(ServiceApiVersions.vFuturePlaceholder)
    ThreadRunStepDelta: "thread.run.step.delta",

    /** Event sent when a run step is completed. The data of this event is of type RunStep */
    @added(ServiceApiVersions.vFuturePlaceholder)
    ThreadRunStepCompleted: "thread.run.step.completed",

    /** Event sent when a run step fails. The data of this event is of type RunStep */
    @added(ServiceApiVersions.vFuturePlaceholder)
    ThreadRunStepFailed: "thread.run.step.failed",

    /** Event sent when a run step is cancelled. The data of this event is of type RunStep */
    @added(ServiceApiVersions.vFuturePlaceholder)
    ThreadRunStepCancelled: "thread.run.step.cancelled",

    /** Event sent when a run step is expired. The data of this event is of type RunStep */
    @added(ServiceApiVersions.vFuturePlaceholder)
    ThreadRunStepExpired: "thread.run.step.expired",
}

/** Message operation related streaming events */
@added(ServiceApiVersions.vFuturePlaceholder)
union MessageStreamEvent {
    string,

    /** Event sent when a new message is created. The data of this event is of type ThreadMessage */
    @added(ServiceApiVersions.vFuturePlaceholder)
    ThreadMessageCreated: "thread.message.created",

    /** Event sent when a message moves to `in_progress` status. The data of this event is of type ThreadMessage */
    @added(ServiceApiVersions.vFuturePlaceholder)
    ThreadMessageInProgress: "thread.message.in_progress",

    /** Event sent when a message is being streamed. The data of this event is of type MessageDelta */
    @added(ServiceApiVersions.vFuturePlaceholder)
    ThreadMessageDelta: "thread.message.delta",

    /** Event sent when a message is completed. The data of this event is of type ThreadMessage */
    @added(ServiceApiVersions.vFuturePlaceholder)
    ThreadMessageCompleted: "thread.message.completed",

    /** Event sent before a message is completed. The data of this event is of type ThreadMessage */
    @added(ServiceApiVersions.vFuturePlaceholder)
    ThreadMessageIncomplete: "thread.message.incomplete",
}

@added(ServiceApiVersions.vFuturePlaceholder)
union ErrorEvent {
    string,

    /** Event sent when an error occurs, such as an internal server error or a timeout. */
    @added(ServiceApiVersions.vFuturePlaceholder)
    Error: "error"
}

@added(ServiceApiVersions.vFuturePlaceholder)
union DoneEvent {
    string,

    /** Event sent when the stream is done. */
    @added(ServiceApiVersions.vFuturePlaceholder)
    Done: "done"
}

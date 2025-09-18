import "@typespec/openapi";
import "../threads/models.tsp";
import "../runs/models.tsp";
import "../messages/models.tsp";
import "../common/models.tsp";
using TypeSpec.OpenAPI;
namespace OpenAI;
/** Occurs when a new [thread](https://platform.openai.com/docs/api-reference/threads/object) is created. */
@extension(
  "x-oaiMeta",
  #{
    dataDescription: "`data` is a [thread](/docs/api-reference/threads/object)",
  }
)
model ThreadStreamEvent {
  /** Whether to enable input audio transcription. */
  enabled?: boolean;

  @extension("x-stainless-const", true)
  event: "thread.created";

  data: ThreadObject;
}

@discriminator("event")
model RunStreamEvent {
  @extension("x-stainless-const", true)
  event?: "thread.run.created";

  data?: RunObject;
}

@discriminator("event")
model RunStepStreamEvent {
  @extension("x-stainless-const", true)
  event?: "thread.run.step.created";

  data?: RunStepObject;
}

@discriminator("event")
model MessageStreamEvent {
  @extension("x-stainless-const", true)
  event?: "thread.message.created";

  data?: MessageObject;
}

/** Occurs when an [error](https://platform.openai.com/docs/guides/error-codes#api-errors) occurs. This can happen due to an internal server error or a timeout. */
@extension(
  "x-oaiMeta",
  #{
    dataDescription: "`data` is an [error](/docs/guides/error-codes#api-errors)",
  }
)
model ErrorEvent {
  @extension("x-stainless-const", true)
  event: "error";

  data: Error;
}

/** Occurs when a stream ends. */
@extension("x-oaiMeta", #{ dataDescription: "`data` is `[DONE]`" })
model DoneEvent {
  @extension("x-stainless-const", true)
  event: "done";

  @extension("x-stainless-const", true)
  data: "[DONE]";
}

/**Represents an event emitted when streaming a Run.

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
in your code. See the [Assistants API quickstart](https://platform.openai.com/docs/assistants/overview) to learn how to
integrate the Assistants API with streaming.*/
@discriminated(#{ envelope: "none", discriminatorPropertyName: "event" })
@extension("x-oaiMeta", #{ name: "Assistant stream events", beta: true })
union AssistantStreamEvent {
  `thread.created`: ThreadStreamEvent,
  `thread.run.created`: RunStreamEvent,
  `thread.run.step.created`: RunStepStreamEvent,
  `thread.message.created`: MessageStreamEvent,
  error: ErrorEvent,
}

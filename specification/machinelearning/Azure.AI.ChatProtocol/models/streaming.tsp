import "./common.tsp";

namespace Azure.AI.ChatProtocol;

@doc("The representation of a delta message received in a streaming completion.")
model ChatMessageDelta<TState> {
  @doc("An incremental part of the text associated with the message.")
  content?: string;

  @doc("The role associated with the message.")
  role?: ChatRole;

  ...StateProperty<TState>;
}

@doc("The representation of an incremental choice received in a streaming completion.")
model ChoiceDelta<TState, TContext> {
  @doc("The index of the of the chat choice, relative to the other choices in the same completion.")
  index: safeint;

  @doc("The partial message received for this choice.")
  delta: ChatMessageDelta<TState>;

  ...StateProperty<TState>;
  ...ContextProperty<TContext>;

  @doc("The reason this chat completion completed its generation.")
  @projectedName("json", "finish_reason")
  finishReason?: FinishReason;
}

@doc("A single response to a streaming completion request.")
model ChatCompletionChunk<TState, TContext> {
  @doc("The collection of choice deltas received in this chunk.")
  choices: ChoiceDelta<TState, TContext>[];
}

@doc("The configuration for a streaming chat completion request.")
model StreamingChatCompletionOptions<TState, TContext> {
  @doc("The collection of context messages associated with this completion request.")
  messages: ChatMessage<TState>[];

  @doc("Indicates whether the completion is a streaming or non-streaming completion.")
  stream: true;

  ...StateProperty<TState>;
  ...ContextProperty<TContext>;
}

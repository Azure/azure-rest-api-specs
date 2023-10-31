import "./common.tsp";

namespace Azure.AI.ChatProtocol;

@doc("The representation of a single generated completion.")
model ChatChoice<TState, TContext> {
  @doc("The index of the of the chat choice, relative to the other choices in the same completion.")
  index: safeint;

  @doc("The chat message for a given chat completion.")
  message: ChatMessage<TState>;

  ...StateProperty<TState>;
  ...ContextProperty<TContext>;

  @doc("The reason this chat completion completed its generation.")
  finishReason: FinishReason;
}
@doc("Representation of the response to a chat completion request.")
model ChatCompletion<TState, TContext> {
  @doc("The collection of generated completions.")
  choices: ChatChoice<TState, TContext>[];
}

@doc("The configuration for a chat completion request.")
model ChatCompletionOptions<TState, TContext> {
  @doc("The collection of context messages associated with this completion request.")
  messages: ChatMessage<TState>[];

  @doc("Indicates whether the completion is a streaming or non-streaming completion.")
  stream: false;

  ...StateProperty<TState>;
  ...ContextProperty<TContext>;
}

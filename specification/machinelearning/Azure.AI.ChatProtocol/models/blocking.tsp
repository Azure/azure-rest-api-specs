import "./common.tsp";

namespace Azure.AI.ChatProtocol;

@doc("The representation of a single generated completion.")
model ChatChoice<StateModel, ContextModel> {
  @doc("The index of the of the chat choice, relative to the other choices in the same completion.")
  index: safeint;

  @doc("The chat message for a given chat completion.")
  message: ChatMessage<StateModel>;

  ...StateProperty<StateModel>;
  ...ContextProperty<ContextModel>;

  @doc("The reason this chat completion completed its generation.")
  @projectedName("json", "finish_reason")
  finishReason: FinishReason;
}
@doc("Representation of the response to a chat completion request.")
model ChatCompletion<StateModel, ContextModel> {
  @doc("The collection of generated completions.")
  choices: ChatChoice<StateModel, ContextModel>[];
}

@doc("The configuration for a chat completion request.")
model ChatCompletionOptions<StateModel, ContextModel> {
  @doc("The collection of context messages associated with this completion request.")
  messages: ChatMessage<StateModel>[];

  @doc("Indicates whether the completion is a streaming or non-streaming completion.")
  stream: false;

  ...StateProperty<StateModel>;
  ...ContextProperty<ContextModel>;
}

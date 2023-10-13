import "./common.tsp";

namespace Azure.AI.ChatProtocol;

@doc("placeholder")
model ChatChoice<StateModel, ContextModel> {
  @doc("placeholder")
  index: safeint;

  @doc("placeholder")
  message: ChatMessage<StateModel>;

  ...StateProperty<StateModel>;
  ...ContextProperty<ContextModel>;

  @doc("placeholder")
  @projectedName("json", "finish_reason")
  finishReason: FinishReason;
}
@doc("placeholder")
model ChatCompletion<StateModel, ContextModel> {
  @doc("placeholder")
  choices: ChatChoice<StateModel, ContextModel>[];
}

model ChatCompletionOptions<StateModel, ContextModel> {
  @doc("placeholder")
  messages: ChatMessage<StateModel>[];

  @doc("placeholder")
  stream: false;

  ...StateProperty<StateModel>;
  ...ContextProperty<ContextModel>;
}

import "./common.tsp";

namespace Azure.AI.Chat;

@doc("placeholder")
model ChatChoice<StateModel, ArgumentsModel> {
  @doc("placeholder")
  index: safeint;

  @doc("placeholder")
  message: ChatMessage<StateModel>;

  ...StateProperty<StateModel>;
  ...ExtraArgumentsProperty<ArgumentsModel>;

  @doc("placeholder")
  @projectedName("json", "finish_reason")
  finishReason: FinishReason;
}
@doc("placeholder")
model ChatCompletion<StateModel, ArgumentsModel> {
  @doc("placeholder")
  choices: ChatChoice<StateModel, ArgumentsModel>[];
}

model ChatCompletionOptions<StateModel, ArgumentsModel> {
  @doc("placeholder")
  messages: ChatMessage<StateModel>[];

  @doc("placeholder")
  stream: false;

  ...StateProperty<StateModel>;
  ...ExtraArgumentsProperty<ArgumentsModel>;
}

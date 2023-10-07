import "./common.tsp";

namespace Azure.AI.Chat;

@doc("placeholder")
model ChatMessageDelta {
  @doc("placeholder")
  content?: string;

  @doc("placeholder")
  role?: ChatRole;

  @doc("placeholder")
  @projectedName("json", "session_state")
  sessionState?: unknown;
}

@doc("placeholder")
model ChoiceDelta<StateModel, ArgumentsModel> {
  @doc("placeholder")
  index: safeint;

  @doc("placeholder")
  delta: ChatMessageDelta;

  ...StateProperty<StateModel>;
  ...ExtraArgumentsProperty<ArgumentsModel>;

  @doc("placeholder")
  @projectedName("json", "finish_reason")
  finishReason?: FinishReason;
}

@doc("placeholder")
model ChatCompletionChunk<StateModel, ArgumentsModel> {
  @doc("placeholder")
  choices: ChoiceDelta<StateModel, ArgumentsModel>[];
}

@doc("placeholder")
model StreamingChatCompletionOptions<StateModel, ArgumentsModel> {
  @doc("placeholder")
  messages: ChatMessage<StateModel>[];

  @doc("placeholder")
  stream: true;

  ...StateProperty<StateModel>;
  ...ExtraArgumentsProperty<ArgumentsModel>;
}

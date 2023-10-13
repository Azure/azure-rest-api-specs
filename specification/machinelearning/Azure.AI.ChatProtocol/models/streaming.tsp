import "./common.tsp";

namespace Azure.AI.ChatProtocol;

@doc("placeholder")
model ChatMessageDelta<StateModel> {
  @doc("placeholder")
  content?: string;

  @doc("placeholder")
  role?: ChatRole;

  ...StateProperty<StateModel>;
}

@doc("placeholder")
model ChoiceDelta<StateModel, ContextModel> {
  @doc("placeholder")
  index: safeint;

  @doc("placeholder")
  delta: ChatMessageDelta<StateModel>;

  ...StateProperty<StateModel>;
  ...ContextProperty<ContextModel>;

  @doc("placeholder")
  @projectedName("json", "finish_reason")
  finishReason?: FinishReason;
}

@doc("placeholder")
model ChatCompletionChunk<StateModel, ContextModel> {
  @doc("placeholder")
  choices: ChoiceDelta<StateModel, ContextModel>[];
}

@doc("placeholder")
model StreamingChatCompletionOptions<StateModel, ContextModel> {
  @doc("placeholder")
  messages: ChatMessage<StateModel>[];

  @doc("placeholder")
  stream: true;

  ...StateProperty<StateModel>;
  ...ContextProperty<ContextModel>;
}

import "./common.tsp";

namespace Azure.AI.ChatProtocol;

@doc("The representation of a delta message received in a streaming completion.")
model ChatMessageDelta {
  @doc("An incremental part of the text associated with the message.")
  content?: string;

  @doc("The role associated with the message.")
  role?: ChatRole;

  ...StateProperty;
}

@doc("The representation of an incremental choice received in a streaming completion.")
model ChoiceDelta {
  @doc("The index of the of the chat choice, relative to the other choices in the same completion.")
  index: safeint;

  @doc("The partial message received for this choice.")
  delta: ChatMessageDelta;

  ...StateProperty;
  ...ContextProperty;

  @doc("The reason this chat completion completed its generation.")
  finishReason?: FinishReason;
}

@doc("A single response to a streaming completion request.")
model ChatCompletionChunk {
  @doc("The collection of choice deltas received in this chunk.")
  choices: ChoiceDelta[];
}

@doc("The configuration for a streaming chat completion request.")
model StreamingChatCompletionOptions {
  @doc("The collection of context messages associated with this completion request.")
  messages: ChatMessage[];

  @doc("Indicates whether the completion is a streaming or non-streaming completion.")
  stream: true;

  ...StateProperty;
  ...ContextProperty;
}

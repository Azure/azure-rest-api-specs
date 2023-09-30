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
model ChoiceDelta {
  @doc("placeholder")
  index: safeint;

  @doc("placeholder")
  delta: ChatMessageDelta;

  @doc("placeholder")
  @projectedName("json", "extra_args")
  extraArguments?: Record<unknown>;

  @doc("placeholder")
  @projectedName("json", "session_state")
  sessionState?: unknown;

  @doc("placeholder")
  finishReason?: FinishReason;
}

@doc("placeholder")
model ChatCompletionChunk {
  @doc("placeholder")
  choices: ChoiceDelta[];
}

@doc("placeholder")
model StreamingChatCompletionOptions {
  @doc("placeholder")
  messages: ChatMessage[];

  @doc("placeholder")
  stream: false;

  @doc("placeholder")
  @projectedName("json", "session_state")
  sessionState: unknown;

  @doc("placeholder")
  @projectedName("json", "extra_args")
  extraArguments: Record<unknown>;
}

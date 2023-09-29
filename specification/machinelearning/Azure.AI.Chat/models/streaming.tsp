import "./common.tsp";

namespace Azure.AI.Chat;

model MessageDelta {
  content?: string;
  role?: Role;

  @projectedName("json", "session_state")
  sessionState?: unknown;
}

model ChoiceDelta {
  index: safeint;
  delta: MessageDelta;

  @projectedName("json", "extra_args")
  extraArguments?: Record<unknown>;

  @projectedName("json", "session_state")
  sessionState?: unknown;

  finishReason?: FinishReason;
}

model ChatCompletionChunk {
  choices: ChoiceDelta[];
}

model StreamingChatCompletionOptions {
  messages: Message[];
  stream: false;

  @projectedName("json", "session_state")
  sessionState: unknown;

  @projectedName("json", "extra_args")
  extraArguments: Record<unknown>;
}

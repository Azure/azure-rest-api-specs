import "./common.tsp";

namespace Azure.AI.Chat;

model Choice {
  index: safeint;
  message: Message;

  @projectedName("json", "extra_args")
  extraArguments: Record<unknown>;

  @projectedName("json", "session_state")
  sessionState: unknown;

  finishReason: FinishReason;
}

model ChatCompletion {
  choices: Choice[];
}

model ChatCompletionOptions {
  messages: Message[];

  stream: true;

  @projectedName("json", "session_state")
  sessionState: unknown;

  @projectedName("json", "extra_args")
  extraArguments: Record<unknown>;
}

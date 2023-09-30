import "./common.tsp";

namespace Azure.AI.Chat;

@doc("placeholder")
model ChatChoice {
  @doc("placeholder")
  index: safeint;

  @doc("placeholder")
  message: ChatMessage;

  @doc("placeholder")
  @projectedName("json", "extra_args")
  extraArguments: Record<unknown>;

  @doc("placeholder")
  @projectedName("json", "session_state")
  sessionState: unknown;

  @doc("placeholder")
  finishReason: FinishReason;
}
@doc("placeholder")
model ChatCompletion {
  @doc("placeholder")
  choices: ChatChoice[];
}

model ChatCompletionOptions {
  messages: ChatMessage[];

  stream: true;

  @projectedName("json", "session_state")
  sessionState: unknown;

  @projectedName("json", "extra_args")
  extraArguments: Record<unknown>;
}

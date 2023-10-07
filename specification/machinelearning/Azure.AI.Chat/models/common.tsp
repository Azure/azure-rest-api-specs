namespace Azure.AI.Chat;

@doc("placeholder")
enum FinishReason {
  @doc("placeholder")
  stopped: "stop",

  @doc("placeholder")
  tokenLimitReached: "length",

  @doc("placeholder")
  contentFiltered: "content_filter",

  @doc("placeholder")
  functionCall: "function_call",
}

@doc("placeholder")
enum ChatRole {
  @doc("placeholder")
  user: "user",

  @doc("placeholder")
  system: "system",

  @doc("placeholder")
  assistant: "assistant",
}

@doc("placeholder")
model ExtraArgumentsProperty<ArgumentsModel> {
  @doc("placeholder")
  @projectedName("json", "extra_args")
  extraArguments?: ArgumentsModel;
}

@doc("placeholder")
model StateProperty<StateModel> {
  @doc("placeholder")
  @projectedName("json", "session_state")
  sessionState?: StateModel;
}

@doc("placeholder")
model ChatMessage<StateModel> {
  @doc("placeholder")
  content: string;

  @doc("placeholder")
  role: ChatRole;

  ...StateProperty<StateModel>;
}

import "@typespec/http";

namespace Azure.AI.Chat;

using TypeSpec.Http;

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
model ContextProperty<ContextModel> {
  #suppress "@azure-tools/typespec-azure-core/bad-record-type" "Protocol defines the type as Record<any>"
  @doc("placeholder")
  context?: ContextModel;
}

@doc("placeholder")
model StateProperty<StateModel> {
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "The protocol defines these as any (object/scalar) for now"
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

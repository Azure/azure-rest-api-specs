import "@typespec/http";

namespace Azure.AI.ChatProtocol;

using TypeSpec.Http;

@doc("Representation of the reason why a chat session has finished processing.")
enum FinishReason {
  @doc("Completion ended normally.")
  stopped: "stop",

  @doc("The completion exhausted available tokens before generation could complete.")
  tokenLimitReached: "length",
}

@doc("A representation of the intended purpose of a message.")
enum ChatRole {
  @doc("The role that provides input to the completion.")
  user: "user",

  @doc("The role that instructs or configures the behavior of the assistant.")
  system: "system",

  @doc("The role that provides responses to the system-instructed, user-prompted input.")
  assistant: "assistant",
}

@doc("A property that represents backend-specific context or arguments.")
model ContextProperty<ContextModel> {
  #suppress "@azure-tools/typespec-azure-core/bad-record-type" "Protocol defines the type as Record<any>"
  @doc("Backend-specific context or arguments.")
  context?: ContextModel;
}

@doc("A property that represents backend-specific information for the tracking of a session.")
model StateProperty<StateModel> {
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "The protocol defines these as any (object/scalar) for now"
  @doc("Backend-specific information for the tracking of a session.")
  @projectedName("json", "session_state")
  sessionState?: StateModel;
}

@doc("A single, role-attributed message within a chat completion interaction.")
model ChatMessage<StateModel> {
  @doc("The text associated with the message.")
  content: string;

  @doc("The role associated with the message.")
  role: ChatRole;

  ...StateProperty<StateModel>;
}

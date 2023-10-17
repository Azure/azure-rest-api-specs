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
  @doc("""
  Context allows the chat app to receive extra parameters from the client, such as temperature, functions, or
  customer_info. These parameters are specific to the chat app and not understood by the generic clients.
  """)
  context?: ContextModel;
}

@doc("A property that represents backend-specific information for the tracking of a session.")
model StateProperty<StateModel> {
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "The protocol defines these as any (object/scalar) for now"
  @doc("""
  Field that allows the chat app to store and retrieve data, the structure of such data is dependant on the backend
  being used. The client must send back the data in this field unchanged in subsequent requests, until the chat app
  sends a new one. The data in this field can be used to implement stateful services, such as remembering previous
  conversations or user preferences.
  """)
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

import "@typespec/http";

namespace Azure.AI.ChatProtocol;

using TypeSpec.Http;

@doc("Representation of the reason why a chat session has finished processing.")
union FinishReason {
  string,

  @doc("Completion ended normally.")
  stopped: "stop",

  @doc("The completion exhausted available tokens before generation could complete.")
  tokenLimitReached: "length",
}

@doc("A representation of the intended purpose of a message.")
union ChatRole {
  string,

  @doc("The role that provides input to the completion.")
  user: "user",

  @doc("The role that instructs or configures the behavior of the assistant.")
  system: "system",

  @doc("The role that provides responses to the system-instructed, user-prompted input.")
  assistant: "assistant",
}

@doc("A property that represents backend-specific context or arguments.")
model ContextProperty {
  #suppress "@azure-tools/typespec-azure-core/bad-record-type" "Protocol defines the type as Record<any>"
  @doc("""
  Context allows the chat app to receive extra parameters from the client, such as temperature, functions, or
  customer_info. These parameters are specific to the chat app and not understood by the generic clients.
  """)
  context?: Record<unknown>;
}

@doc("A property that represents backend-specific information for the tracking of a session.")
model StateProperty {
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "The protocol defines these as any (object/scalar) for now"
  @doc("""
  Field that allows the chat app to store and retrieve data, the structure of such data is dependant on the backend
  being used. The client must send back the data in this field unchanged in subsequent requests, until the chat app
  sends a new one. The data in this field can be used to implement stateful services, such as remembering previous
  conversations or user preferences.
  """)
  sessionState?: unknown;
}

@doc("Identifies the type of a message.")
union MessageKind {
  string,

  @doc("The message context is text.")
  text: "text",
}

@doc("A single, role-attributed message within a chat completion interaction.")
@discriminator("kind")
model ChatMessage {
  @doc("The type of the message. If not specified, the message is assumed to be text.")
  kind: MessageKind;

  @doc("The role associated with the message.")
  role: ChatRole;

  ...StateProperty;
}

@doc("A single, role-attributed text message within a chat completion interaction.")
model TextChatMessage extends ChatMessage {
  @doc("The type of the message.")
  kind: MessageKind.text;

  @doc("The text associated with the message.")
  content: string;
}

@doc("Parameter that describes the route of the operation to be performed.")
model OperationRouteParam {
  @doc("The route where the endpoint exposes the chat operations.")
  @path
  operationRoute: string = "chat";
}

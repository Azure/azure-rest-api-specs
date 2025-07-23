import "./content_parts.tsp";

using TypeSpec.OpenAPI;

namespace VoiceLive;

@discriminator("type")
model VoiceLiveConversationRequestItem {
  ...VoiceLiveConversationItemBase;
  type: VoiceLiveItemType;
  id?: string;
}

@discriminator("role")
model VoiceLiveRequestMessageItem extends VoiceLiveConversationRequestItem {
  type: VoiceLiveItemType.message;
  role: VoiceLiveMessageRole;
  status?: VoiceLiveItemStatus;
}

model VoiceLiveRequestSystemMessageItem extends VoiceLiveRequestMessageItem {
  role: VoiceLiveMessageRole.system;
  content: VoiceLiveRequestTextContentPart[];
}

model VoiceLiveRequestUserMessageItem extends VoiceLiveRequestMessageItem {
  role: VoiceLiveMessageRole.user;
  content: (VoiceLiveRequestTextContentPart | VoiceLiveRequestAudioContentPart)[];
}

model VoiceLiveRequestAssistantMessageItem extends VoiceLiveRequestMessageItem {
  role: VoiceLiveMessageRole.assistant;
  content: VoiceLiveRequestTextContentPart[];
}

model VoiceLiveRequestFunctionCallItem extends VoiceLiveConversationRequestItem {
  type: VoiceLiveItemType.function_call;
  name: string;
  call_id: string;
  arguments: string;
  status?: VoiceLiveItemStatus;
}

model VoiceLiveRequestFunctionCallOutputItem
  extends VoiceLiveConversationRequestItem {
  type: VoiceLiveItemType.function_call_output;
  call_id: string;
  output: string;
}

// TODO: representation of a doubly-discriminated type with an absent second discriminator
//   (first discriminator: type = message; second discriminator: no role present)

model VoiceLiveRequestMessageReferenceItem { // extends VoiceLiveConversationRequestItem {
  type: VoiceLiveItemType.message;
  id: string;
}

@discriminator("type")
model VoiceLiveConversationResponseItem {
  ...VoiceLiveConversationItemBase;
  object?: "realtime.item";
  type?: VoiceLiveItemType;
  id?: string;
}

model VoiceLiveResponseMessageItem extends VoiceLiveConversationResponseItem {
  type: VoiceLiveItemType.message;
  role: VoiceLiveMessageRole;
  content: VoiceLiveContentPart[];
  status: VoiceLiveItemStatus;
}

model VoiceLiveResponseFunctionCallItem
  extends VoiceLiveConversationResponseItem {
  type: VoiceLiveItemType.function_call;
  name: string;
  call_id: string;
  arguments: string;
  status: VoiceLiveItemStatus;
}

model VoiceLiveResponseFunctionCallOutputItem
  extends VoiceLiveConversationResponseItem {
  type: VoiceLiveItemType.function_call_output;
  call_id: string;
  output: string;
}

union VoiceLiveItemType {
  string,
  message: "message",
  function_call: "function_call",
  function_call_output: "function_call_output",
}

union VoiceLiveItemStatus {
  string,
  in_progress: "in_progress",
  completed: "completed",
  incomplete: "incomplete",
}

union VoiceLiveMessageRole {
  string,
  system: "system",
  user: "user",
  assistant: "assistant",
}

// Tool generated type. Extracts from VoiceLiveConversationItemWithReference.content
alias VoiceLiveConversationItemWithReferenceContent = {
  @doc("""
    The content type (`input_text`, `input_audio`, `item_reference`, `text`).
    """)
  type?: "input_audio" | "input_text" | "item_reference" | "text";

  @doc("""
    The text content, used for `input_text` and `text` content types.
    """)
  text?: string;

  @doc("""
    ID of a previous conversation item to reference (for `item_reference`
    content types in `response.create` events). These can reference both
    client and server created items.
    """)
  id?: string;

  @doc("""
    Base64-encoded audio bytes, used for `input_audio` content type.
    """)
  audio?: string;

  @doc("""
    The transcript of the audio, used for `input_audio` content type.
    """)
  transcript?: string;
};
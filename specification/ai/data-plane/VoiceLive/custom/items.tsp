import "./content_parts.tsp";

using TypeSpec.OpenAPI;

namespace VoiceLive;

@discriminator("type")
model ConversationRequestItem {
  ...ConversationItemBase;
  type: ItemType;
  id?: string;
}

@discriminator("role")
model RequestMessageItem extends ConversationRequestItem {
  type: ItemType.message;
  role: MessageRole;
  status?: ItemStatus;
}

model RequestSystemMessageItem extends RequestMessageItem {
  role: MessageRole.system;
  content: RequestTextContentPart[];
}

model RequestUserMessageItem extends RequestMessageItem {
  role: MessageRole.user;
  content: (RequestTextContentPart | RequestAudioContentPart)[];
}

model RequestAssistantMessageItem extends RequestMessageItem {
  role: MessageRole.assistant;
  content: RequestTextContentPart[];
}

model RequestFunctionCallItem extends ConversationRequestItem {
  type: ItemType.function_call;
  name: string;
  call_id: string;
  arguments: string;
  status?: ItemStatus;
}

model RequestFunctionCallOutputItem
  extends ConversationRequestItem {
  type: ItemType.function_call_output;
  call_id: string;
  output: string;
}

// TODO: representation of a doubly-discriminated type with an absent second discriminator
//   (first discriminator: type = message; second discriminator: no role present)

model RequestMessageReferenceItem { // extends ConversationRequestItem {
  type: ItemType.message;
  id: string;
}

@discriminator("type")
model ConversationResponseItem {
  ...ConversationItemBase;
  object?: "realtime.item";
  type: ItemType;
  id?: string;
}

model ResponseMessageItem extends ConversationResponseItem {
  type: ItemType.message;
  role: MessageRole;
  content: ContentPart[];
  status: ItemStatus;
}

model ResponseFunctionCallItem
  extends ConversationResponseItem {
  type: ItemType.function_call;
  name: string;
  call_id: string;
  arguments: string;
  status: ItemStatus;
}

model ResponseFunctionCallOutputItem
  extends ConversationResponseItem {
  type: ItemType.function_call_output;
  call_id: string;
  output: string;
}

union ItemType {
  string,
  message: "message",
  function_call: "function_call",
  function_call_output: "function_call_output",
}

union ItemStatus {
  string,
  in_progress: "in_progress",
  completed: "completed",
  incomplete: "incomplete",
}

union MessageRole {
  string,
  system: "system",
  user: "user",
  assistant: "assistant",
}

// Tool generated type. Extracts from ConversationItemWithReference.content
alias ConversationItemWithReferenceContent = {
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
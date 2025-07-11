import "./content_parts.tsp";

using TypeSpec.OpenAPI;

namespace OpenAI;

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
  object: "voicelive.item";
  type: VoiceLiveItemType;
  id: string | null;
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

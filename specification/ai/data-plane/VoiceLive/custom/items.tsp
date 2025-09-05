import "./content_parts.tsp";

using TypeSpec.OpenAPI;

namespace VoiceLive;

union ItemType {
  string,
  message: "message",
  function_call: "function_call",
  function_call_output: "function_call_output",
}

// Base for user content parts
@discriminator("type")
model UserContentPart {
  type: string;
}

// Variants
model InputTextContentPart extends UserContentPart {
  type: "input_text";
  text: string;
}

model InputAudioContentPart extends UserContentPart {
  type: "input_audio";
  audio: string;
  transcript?: string;
}

@doc("Output text content part.")
model OutputTextContentPart {
  type: "text";
  text: string;
}

// Status enum
enum ItemParamStatus {
  completed: "completed",
  incomplete: "incomplete",
}

@doc("Base for any response item; discriminated by `type`.")
@discriminator("type")
model ConversationRequestItem {
  type: ItemType;
  id?: string;
}

// ----- Message Items -----
@discriminator("role")
model MessageItem extends ConversationRequestItem {
  type: ItemType.message;
  role: string;
  status?: ItemParamStatus;
}

model SystemMessageItem extends MessageItem {
  role: "system";
  content: InputTextContentPart[];
}

model UserMessageItem extends MessageItem {
  role: "user";
  content: UserContentPart[];
}

model AssistantMessageItem extends MessageItem {
  role: "assistant";
  content: OutputTextContentPart[];
}

// ----- Function Call Items -----
model FunctionCallItem extends ConversationRequestItem {
  type: ItemType.function_call;
  name: string;
  call_id: string;
  arguments: string;
  status?: ItemParamStatus;
}

model FunctionCallOutputItem extends ConversationRequestItem {
  type: ItemType.function_call_output;
  call_id: string;
  output: string;
  status?: ItemParamStatus;
}

@discriminator("type")
model ResponseItem {
  // must stay here, required, broad type
  type: ItemType;
  id?: string;
  object?: "realtime.item";
}

model ResponseMessageItem extends ResponseItem {
  type: ItemType.message;
  role: MessageRole;
  content: ContentPart[];
  status: ResponseItemStatus;
}

model ResponseFunctionCallItem
  extends ResponseItem {
  type: ItemType.function_call;
  name: string;
  call_id: string;
  arguments: string;
  status: ResponseItemStatus;
}

model ResponseFunctionCallOutputItem
  extends ResponseItem {
  type: ItemType.function_call_output;
  call_id: string;
  output: string;
}

union ResponseItemStatus {
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

@doc("Terminal status of a response.")
enum ResponseStatus {
  completed: "completed",
  cancelled: "cancelled",
  failed: "failed",
  incomplete: "incomplete",
  in_progress: "in_progress",
}

@doc("Base for all non-success response details.")
@discriminator("type")  // or just @discriminator("type") if imported unqualified
model ResponseStatusDetails {
  // Required discriminator key on the base; keep it as a broad string.
  type: string;
}

@doc("Details for a cancelled response.")
model ResponseCancelledDetails extends ResponseStatusDetails {
  // Narrow the discriminator to a literal in each child:
  type: "cancelled";
  reason: "turn_detected" | "client_cancelled";
}

@doc("Details for an incomplete response.")
model ResponseIncompleteDetails extends ResponseStatusDetails {
  type: "incomplete";
  reason: "max_output_tokens" | "content_filter";
}

@doc("Details for a failed response.")
model ResponseFailedDetails extends ResponseStatusDetails {
  type: "failed";
  error: unknown;
}

@doc("Details of input token usage.")
model InputTokenDetails {
  @doc("Number of cached tokens used in the input.")
  cached_tokens: int32;

  @doc("Number of text tokens used in the input.")
  text_tokens: int32;

  @doc("Number of audio tokens used in the input.")
  audio_tokens: int32;
}

@doc("Details of output token usage.")
model OutputTokenDetails {
  @doc("Number of text tokens generated in the output.")
  text_tokens: int32;

  @doc("Number of audio tokens generated in the output.")
  audio_tokens: int32;
}

@doc("Overall usage statistics for a response.")
model Usage {
  @doc("Total number of tokens (input + output).")
  total_tokens: int32;

  @doc("Number of input tokens.")
  input_tokens: int32;

  @doc("Number of output tokens.")
  output_tokens: int32;

  @doc("Detailed breakdown of input tokens.")
  input_token_details: InputTokenDetails;

  @doc("Detailed breakdown of output tokens.")
  output_token_details: OutputTokenDetails;
}

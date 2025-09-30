import "./content_parts.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;

namespace VoiceLive;

union ItemType {
  string,
  message: "message",
  function_call: "function_call",
  function_call_output: "function_call_output",
}

// Base for user content parts
@discriminator("type")
@usage(RequestUsage)
@doc("Base for any message content part; discriminated by `type`.")
model MessageContentPart {
  @doc("The type of the content part.")
  type: ContentPartType;
}

// Variants
@usage(RequestUsage)
@doc("Input text content part.")
model InputTextContentPart extends MessageContentPart {
  type: ContentPartType.input_text;
  text: string;
}

@usage(RequestUsage)
@doc("Input audio content part.")
model InputAudioContentPart extends MessageContentPart {
  type: ContentPartType.input_audio;
  audio: string;
  transcript?: string;
}

@doc("Output text content part.")
@usage(ResponseUsage)
model OutputTextContentPart extends MessageContentPart {
  @doc("The type of the content part.")
  type: ContentPartType.text;
  @doc("The text content.")
  text: string;
}

// Status enum
@doc("Indicates the processing status of an item or parameter.")
union ItemParamStatus {
  string,
  @doc("Item or parameter is still being processed.")
  completed: "completed",
  @doc("Item or parameter is not yet complete.")
  incomplete: "incomplete",
}

@doc("Base for any response item; discriminated by `type`.")
@discriminator("type")
@usage(RequestUsage)
model ConversationRequestItem {
  type: ItemType;
  id?: string;
}

// ----- Message Items -----
@discriminator("role")
@usage(RequestUsage)
@doc("A message item within a conversation.")
#suppress "@azure-tools/typespec-azure-core/no-multiple-discriminator"
model MessageItem extends ConversationRequestItem {
  @doc("The type of the item; must be 'message' for message items.")
  type: ItemType.message;
  @doc("The role of the message origionator.")
  role: MessageRole;
  @doc("The content parts of the message.")
  content: MessageContentPart[];
  @doc("Processing status of the message item.")
  status?: ItemParamStatus;
}

@usage(RequestUsage)
#suppress "@azure-tools/typespec-azure-core/no-multiple-discriminator"
@doc("A system message item within a conversation.")
model SystemMessageItem extends MessageItem {
  role: MessageRole.system;
}

@usage(RequestUsage)
#suppress "@azure-tools/typespec-azure-core/no-multiple-discriminator"
@doc("A user message item within a conversation.")
model UserMessageItem extends MessageItem {
  role: MessageRole.user;
}

@usage(DualUsage)
#suppress "@azure-tools/typespec-azure-core/no-multiple-discriminator"
@doc("An assistant message item within a conversation.")
model AssistantMessageItem extends MessageItem {
  role: MessageRole.assistant;
}

// ----- Function Call Items -----
@usage(RequestUsage)
@doc("A function call item within a conversation.")
#suppress "@azure-tools/typespec-azure-core/casing-style"
model FunctionCallItem extends ConversationRequestItem {
  type: ItemType.function_call;
  name: string;
  call_id: string;
  arguments: string;
  status?: ItemParamStatus;
}

@usage(RequestUsage)
@doc("A function call output item within a conversation.")
#suppress "@azure-tools/typespec-azure-core/casing-style"
model FunctionCallOutputItem extends ConversationRequestItem {
  type: ItemType.function_call_output;
  call_id: string;
  output: string;
  status?: ItemParamStatus;
}

@discriminator("type")
@doc("Base for any response item; discriminated by `type`.")
@usage(ResponseUsage)
model ResponseItem {
  // must stay here, required, broad type
  type: ItemType;
  id?: string;
  object?: "realtime.item";
}

@usage(ResponseUsage)
@doc("Base type for message item within a conversation.")
model ResponseMessageItem extends ResponseItem {
  type: ItemType.message;
  role: MessageRole;
  content: ContentPart[];
  status: ResponseItemStatus;
}

@usage(ResponseUsage)
@doc("A function call item within a conversation.")
#suppress "@azure-tools/typespec-azure-core/casing-style"
model ResponseFunctionCallItem
  extends ResponseItem {
  type: ItemType.function_call;
  name: string;
  call_id: string;
  arguments: string;
  status: ResponseItemStatus;
}

@usage(ResponseUsage)
@doc("A function call output item within a conversation.")
#suppress "@azure-tools/typespec-azure-core/casing-style"
model ResponseFunctionCallOutputItem
  extends ResponseItem {
  type: ItemType.function_call_output;
  call_id: string;
  output: string;
}

@usage(ResponseUsage)
#suppress "@azure-tools/typespec-azure-core/casing-style"
@doc("Indicates the processing status of a response item.")
union ResponseItemStatus {
  string,
  @doc("Item that is in progress.")
  in_progress: "in_progress",
  @doc("Item has been fully processed and is complete.")
  completed: "completed",
  @doc("Item has been processed but is incomplete.")
  incomplete: "incomplete",
}

union MessageRole {
  string,
  system: "system",
  user: "user",
  assistant: "assistant",
}

@doc("Terminal status of a response.")
union ResponseStatus {
  string,
  completed: "completed",
  cancelled: "cancelled",
  failed: "failed",
  incomplete: "incomplete",
  in_progress: "in_progress",
}

@doc("Base for all non-success response details.")
@discriminator("type")  // or just @discriminator("type") if imported unqualified
@usage(ResponseUsage)
model ResponseStatusDetails {
  // Required discriminator key on the base; keep it as a broad string.
  type: ResponseStatus;
}

@doc("Details for a cancelled response.")
@usage(ResponseUsage)
model ResponseCancelledDetails extends ResponseStatusDetails {
  // Narrow the discriminator to a literal in each child:
  type: "cancelled";
  reason: "turn_detected" | "client_cancelled" | string;
}

@doc("Details for an incomplete response.")
@usage(ResponseUsage)
model ResponseIncompleteDetails extends ResponseStatusDetails {
  type: "incomplete";
  reason: "max_output_tokens" | "content_filter" | string;
}

@doc("Details for a failed response.")
@usage(ResponseUsage)
#suppress "@azure-tools/typespec-azure-core/no-unknown"
model ResponseFailedDetails extends ResponseStatusDetails {
  type: "failed";
  error: unknown;
}

@doc("Details of input token usage.")
@usage(ResponseUsage)
#suppress "@azure-tools/typespec-azure-core/casing-style"
model InputTokenDetails {
  @doc("Number of cached tokens used in the input.")
  cached_tokens: int32;

  @doc("Number of text tokens used in the input.")
  text_tokens: int32;

  @doc("Number of audio tokens used in the input.")
  audio_tokens: int32;

  @doc("Details of cached token usage.")
  cached_tokens_details: CachedTokenDetails;
}

@doc("Details of output token usage.")
@usage(ResponseUsage)
#suppress "@azure-tools/typespec-azure-core/casing-style"
model OutputTokenDetails {
  @doc("Number of text tokens generated in the output.")
  text_tokens: int32;

  @doc("Number of audio tokens generated in the output.")
  audio_tokens: int32;
}

@doc("Details of output token usage.")
@usage(ResponseUsage)
#suppress "@azure-tools/typespec-azure-core/casing-style"
model CachedTokenDetails {
  @doc("Number of cached text tokens.")
  text_tokens: int32;

  @doc("Number of cached audio tokens.")
  audio_tokens: int32;
}

@doc("Overall usage statistics for a response.")
@usage(ResponseUsage)
#suppress "@azure-tools/typespec-azure-core/casing-style"
model TokenUsage {
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

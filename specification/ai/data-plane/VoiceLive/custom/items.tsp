import "./content_parts.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
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
@usage(RequestUsage)
model UserContentPart {
  type: string;
}

// Variants
@usage(RequestUsage)
model InputTextContentPart extends UserContentPart {
  type: "input_text";
  text: string;
}

@usage(RequestUsage)
model InputAudioContentPart extends UserContentPart {
  type: "input_audio";
  audio: string;
  transcript?: string;
}

@doc("Output text content part.")
@usage(ResponseUsage)
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
@usage(RequestUsage)
model ConversationRequestItem {
  type: ItemType;
  id?: string;
}

// ----- Message Items -----
@discriminator("role")
@usage(RequestUsage)
model MessageItem extends ConversationRequestItem {
  type: ItemType.message;
  role: string;
  status?: ItemParamStatus;
}

@usage(RequestUsage)
model SystemMessageItem extends MessageItem {
  role: "system";
  content: InputTextContentPart[];
}

@usage(RequestUsage)
model UserMessageItem extends MessageItem {
  role: "user";
  content: UserContentPart[];
}

@usage(RequestUsage)
model AssistantMessageItem extends MessageItem {
  role: "assistant";
  content: OutputTextContentPart[];
}

// ----- Function Call Items -----
@usage(RequestUsage)
model FunctionCallItem extends ConversationRequestItem {
  type: ItemType.function_call;
  name: string;
  call_id: string;
  arguments: string;
  status?: ItemParamStatus;
}

@usage(RequestUsage)
model FunctionCallOutputItem extends ConversationRequestItem {
  type: ItemType.function_call_output;
  call_id: string;
  output: string;
  status?: ItemParamStatus;
}

@discriminator("type")
@usage(ResponseUsage)
model ResponseItem {
  // must stay here, required, broad type
  type: ItemType;
  id?: string;
  object?: "realtime.item";
}

@usage(ResponseUsage)
model ResponseMessageItem extends ResponseItem {
  type: ItemType.message;
  role: MessageRole;
  content: ContentPart[];
  status: ResponseItemStatus;
}

@usage(ResponseUsage)
model ResponseFunctionCallItem
  extends ResponseItem {
  type: ItemType.function_call;
  name: string;
  call_id: string;
  arguments: string;
  status: ResponseItemStatus;
}

@usage(ResponseUsage)
model ResponseFunctionCallOutputItem
  extends ResponseItem {
  type: ItemType.function_call_output;
  call_id: string;
  output: string;
}

@usage(ResponseUsage)
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
  reason: "turn_detected" | "client_cancelled";
}

@doc("Details for an incomplete response.")
@usage(ResponseUsage)
model ResponseIncompleteDetails extends ResponseStatusDetails {
  type: "incomplete";
  reason: "max_output_tokens" | "content_filter";
}

@doc("Details for a failed response.")
@usage(ResponseUsage)
model ResponseFailedDetails extends ResponseStatusDetails {
  type: "failed";
  error: unknown;
}

@doc("Details of input token usage.")
@usage(ResponseUsage)
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
model OutputTokenDetails {
  @doc("Number of text tokens generated in the output.")
  text_tokens: int32;

  @doc("Number of audio tokens generated in the output.")
  audio_tokens: int32;
}

@doc("Details of output token usage.")
@usage(ResponseUsage)
model CachedTokenDetails {
  @doc("Number of cached text tokens.")
  text_tokens: int32;

  @doc("Number of cached audio tokens.")
  audio_tokens: int32;
}

@doc("Overall usage statistics for a response.")
@usage(ResponseUsage)
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

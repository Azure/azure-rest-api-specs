import "./content_parts.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using TypeSpec.Versioning;

namespace VoiceLive;

union ItemType {
  string,
  message: "message",
  function_call: "function_call",
  function_call_output: "function_call_output",

  @added(Versions.v2026_01_01_preview)
  mcp_list_tools: "mcp_list_tools",

  @added(Versions.v2026_01_01_preview)
  mcp_call: "mcp_call",

  @added(Versions.v2026_01_01_preview)
  mcp_approval_request: "mcp_approval_request",

  @added(Versions.v2026_01_01_preview)
  mcp_approval_response: "mcp_approval_response",

  /** Web search call item. */
  @added(Versions.v2026_04_10)
  web_search_call: "web_search_call",

  /** File search call item. */
  @added(Versions.v2026_04_10)
  file_search_call: "file_search_call",
}

// Base for user content parts
/** Base for any message content part; discriminated by `type`. */
@discriminator("type")
@usage(RequestUsage)
model MessageContentPart {
  /** The type of the content part. */
  type: ContentPartType;
}

// Variants
/** Input text content part. */
@usage(RequestUsage)
model InputTextContentPart extends MessageContentPart {
  type: ContentPartType.input_text;
  text: string;
}

/** Input audio content part. */
@usage(RequestUsage)
model InputAudioContentPart extends MessageContentPart {
  type: ContentPartType.input_audio;
  audio: string;
  transcript?: string;
}

/** Input image content part. */
@added(Versions.v2026_01_01_preview)
@usage(RequestUsage)
model RequestImageContentPart extends ContentPart {
  type: ContentPartType.input_image;
  url?: string;
  detail?: RequestImageContentPartDetail;
}

/** Specifies an image's detail level. Can be 'auto', 'low', 'high', or an unknown future value. */
@added(Versions.v2026_01_01_preview)
union RequestImageContentPartDetail {
  string,

  /** Automatically select an appropriate detail level. */
  auto: "auto",

  /** Use a lower detail level to reduce bandwidth or cost. */
  low: "low",

  /** Use a higher detail level—potentially more resource-intensive. */
  high: "high",
}

/** Output text content part. */
@usage(ResponseUsage)
model OutputTextContentPart extends MessageContentPart {
  /** The type of the content part. */
  type: ContentPartType.text;

  /** The text content. */
  text: string;
}

// Status enum
/** Indicates the processing status of an item or parameter. */
union ItemParamStatus {
  string,

  /** Item or parameter is still being processed. */
  completed: "completed",

  /** Item or parameter is not yet complete. */
  incomplete: "incomplete",
}

/** Base for any response item; discriminated by `type`. */
@discriminator("type")
@usage(RequestUsage)
model ConversationRequestItem {
  type: ItemType;
  id?: string;
}

// ----- Message Items -----
/** A message item within a conversation. */
#suppress "@azure-tools/typespec-azure-core/no-multiple-discriminator" // The messages have multiple discriminators, but this is intentional. This follows the OpenAI style.
@discriminator("role")
@usage(RequestUsage)
model MessageItem extends ConversationRequestItem {
  /** The type of the item; must be 'message' for message items. */
  type: ItemType.message;

  /** The role of the message origionator. */
  role: MessageRole;

  /** The content parts of the message. */
  content: MessageContentPart[];

  /** Processing status of the message item. */
  status?: ItemParamStatus;
}

/** A system message item within a conversation. */
#suppress "@azure-tools/typespec-azure-core/no-multiple-discriminator" // The messages have multiple discriminators, but this is intentional. This follows the OpenAI style.
@usage(RequestUsage)
model SystemMessageItem extends MessageItem {
  role: MessageRole.system;
}

/** A user message item within a conversation. */
#suppress "@azure-tools/typespec-azure-core/no-multiple-discriminator" // The messages have multiple discriminators, but this is intentional. This follows the OpenAI style.
@usage(RequestUsage)
model UserMessageItem extends MessageItem {
  role: MessageRole.user;
}

/** An assistant message item within a conversation. */
#suppress "@azure-tools/typespec-azure-core/no-multiple-discriminator" // The messages have multiple discriminators, but this is intentional. This follows the OpenAI style.
@usage(DualUsage)
model AssistantMessageItem extends MessageItem {
  role: MessageRole.assistant;
}

// ----- Function Call Items -----
/** A function call item within a conversation. */
#suppress "@azure-tools/typespec-azure-core/casing-style" // Service message format is snake_case to remain close to OpenAI style.
@usage(RequestUsage)
model FunctionCallItem extends ConversationRequestItem {
  type: ItemType.function_call;
  name: string;
  call_id: string;
  arguments: string;
  status?: ItemParamStatus;
}

/** A function call output item within a conversation. */
#suppress "@azure-tools/typespec-azure-core/casing-style" // Service message format is snake_case to remain close to OpenAI style.
@usage(RequestUsage)
model FunctionCallOutputItem extends ConversationRequestItem {
  type: ItemType.function_call_output;
  call_id: string;
  output: string;
  status?: ItemParamStatus;
}

/** Base for any response item; discriminated by `type`. */
@discriminator("type")
@usage(ResponseUsage)
model ResponseItem {
  // must stay here, required, broad type
  type: ItemType;

  id?: string;
  object?: "realtime.item";
}

/** Base type for message item within a conversation. */
@usage(ResponseUsage)
model ResponseMessageItem extends ResponseItem {
  type: ItemType.message;
  role: MessageRole;
  content: ContentPart[];
  status: ResponseItemStatus;
}

/** A function call item within a conversation. */
#suppress "@azure-tools/typespec-azure-core/casing-style" // Service message format is snake_case to remain close to OpenAI style.
@usage(ResponseUsage)
model ResponseFunctionCallItem extends ResponseItem {
  type: ItemType.function_call;
  name: string;
  call_id: string;
  arguments: string;
  status: ResponseItemStatus;
}

/** A function call output item within a conversation. */
#suppress "@azure-tools/typespec-azure-core/casing-style" // Service message format is snake_case to remain close to OpenAI style.
@usage(ResponseUsage)
model ResponseFunctionCallOutputItem extends ResponseItem {
  type: ItemType.function_call_output;
  call_id: string;
  output: string;
}

/** Indicates the processing status of a response item. */
#suppress "@azure-tools/typespec-azure-core/casing-style" // Service message format is snake_case to remain close to OpenAI style.
@usage(ResponseUsage)
union ResponseItemStatus {
  string,

  /** Item that is in progress. */
  in_progress: "in_progress",

  /** Item has been fully processed and is complete. */
  completed: "completed",

  /** Item has been processed but is incomplete. */
  incomplete: "incomplete",
}

union MessageRole {
  string,
  system: "system",
  user: "user",
  assistant: "assistant",
}

/** Terminal status of a response. */
union ResponseStatus {
  string,
  completed: "completed",
  cancelled: "cancelled",
  failed: "failed",
  incomplete: "incomplete",
  in_progress: "in_progress",
}

/** Base for all non-success response details. */
@discriminator("type") // or just @discriminator("type") if imported unqualified
@usage(ResponseUsage)
model ResponseStatusDetails {
  // Required discriminator key on the base; keep it as a broad string.
  type: ResponseStatus;
}

/** Details for a cancelled response. */
@usage(ResponseUsage)
model ResponseCancelledDetails extends ResponseStatusDetails {
  // Narrow the discriminator to a literal in each child:
  type: "cancelled";

  #suppress "@azure-tools/typespec-azure-core/no-unnamed-union" "Keeping inline union to avoid breaking changes."
  reason: "turn_detected" | "client_cancelled" | string;
}

/** Details for an incomplete response. */
@usage(ResponseUsage)
model ResponseIncompleteDetails extends ResponseStatusDetails {
  type: "incomplete";
  #suppress "@azure-tools/typespec-azure-core/no-unnamed-union" "Keeping inline union to avoid breaking changes."
  reason: "max_output_tokens" | "content_filter" | string;
}

/** Details for a failed response. */
#suppress "@azure-tools/typespec-azure-core/no-unknown" // The error can be of any type, depending on the failure.
@usage(ResponseUsage)
model ResponseFailedDetails extends ResponseStatusDetails {
  type: "failed";
  error: unknown;
}

/** Details of input token usage. */
#suppress "@azure-tools/typespec-azure-core/casing-style" // Service message format is snake_case to remain close to OpenAI style.
@usage(ResponseUsage)
model InputTokenDetails {
  /** Number of cached tokens used in the input. */
  cached_tokens: int32;

  /** Number of text tokens used in the input. */
  text_tokens: int32;

  /** Number of audio tokens used in the input. */
  audio_tokens: int32;

  /** Number of image tokens used in the input. */
  image_tokens: int32;

  /** Details of cached token usage. */
  cached_tokens_details: CachedTokenDetails;
}

/** Details of output token usage. */
#suppress "@azure-tools/typespec-azure-core/casing-style" // Service message format is snake_case to remain close to OpenAI style.
@usage(ResponseUsage)
model OutputTokenDetails {
  /** Number of text tokens generated in the output. */
  text_tokens: int32;

  /** Number of audio tokens generated in the output. */
  audio_tokens: int32;

  /** Number of reasoning tokens generated in the output. */
  @added(Versions.v2026_04_10)
  reasoning_tokens?: int32;
}

/** Details of output token usage. */
#suppress "@azure-tools/typespec-azure-core/casing-style" // Service message format is snake_case to remain close to OpenAI style.
@usage(ResponseUsage)
model CachedTokenDetails {
  /** Number of cached text tokens. */
  text_tokens: int32;

  /** Number of cached audio tokens. */
  audio_tokens: int32;

  /** Number of cached image tokens. */
  image_tokens: int32;
}

/** Overall usage statistics for a response. */
#suppress "@azure-tools/typespec-azure-core/casing-style" // Service message format is snake_case to remain close to OpenAI style.
@usage(ResponseUsage)
model TokenUsage {
  /** Total number of tokens (input + output). */
  total_tokens: int32;

  /** Number of input tokens. */
  input_tokens: int32;

  /** Number of output tokens. */
  output_tokens: int32;

  /** Detailed breakdown of input tokens. */
  input_token_details: InputTokenDetails;

  /** Detailed breakdown of output tokens. */
  output_token_details: OutputTokenDetails;
}

/** Represents a mcp tool definition. */
#suppress "@azure-tools/typespec-azure-core/casing-style" // Service message format is snake_case to remain close to OpenAI style.
#suppress "@azure-tools/typespec-azure-core/no-unknown" // The input_schema and annotations can be of any type according to OpenAI response.
@added(Versions.v2026_01_01_preview)
@usage(ResponseUsage)
model MCPTool {
  /** The name of the tool. */
  name: string;

  /** The description of the tool. */
  description?: string;

  /** The input schema for the tool. */
  input_schema: unknown;

  /** The annotations for the tool. */
  annotations?: unknown;
}

/** A response item that lists the tools available on an MCP server. */
#suppress "@azure-tools/typespec-azure-core/casing-style" // Service message format is snake_case to remain close to OpenAI style.
@added(Versions.v2026_01_01_preview)
@usage(ResponseUsage)
model ResponseMCPListToolItem extends ResponseItem {
  /** The type of the item. */
  type: ItemType.mcp_list_tools;

  /** The tools available on the server. */
  tools: MCPTool[];

  /** The label of the server that provides the tools. */
  server_label: string;
}

/** A response item that represents a call to an MCP tool. */
#suppress "@azure-tools/typespec-azure-core/casing-style" // Service message format is snake_case to remain close to OpenAI style.
#suppress "@azure-tools/typespec-azure-core/no-unknown" // The error can be of any type according to OpenAI response.
@added(Versions.v2026_01_01_preview)
@usage(ResponseUsage)
model ResponseMCPCallItem extends ResponseItem {
  /** The type of the item. */
  type: ItemType.mcp_call;

  /** The ID of the approval request, if any. */
  approval_request_id?: string;

  /** The arguments for the tool call. */
  arguments: string;

  /** The label of the server that provides the tool. */
  server_label: string;

  /** The name of the tool to call. */
  name: string;

  /** The output of the tool call. */
  output?: string;

  /** The error, if any, from the tool call. */
  error?: unknown;
}

/** A response item that represents a request for approval to call an MCP tool. */
#suppress "@azure-tools/typespec-azure-core/casing-style" // Service message format is snake_case to remain close to OpenAI style.
@added(Versions.v2026_01_01_preview)
@usage(ResponseUsage)
model ResponseMCPApprovalRequestItem extends ResponseItem {
  /** The type of the item. */
  type: ItemType.mcp_approval_request;

  /** The arguments for the tool call. */
  arguments?: string;

  /** The name of the tool to call. */
  name: string;

  /** The label of the server that provides the tool. */
  server_label: string;
}

/** A response item that represents a response to an MCP approval request. */
#suppress "@azure-tools/typespec-azure-core/casing-style" // Service message format is snake_case to remain close to OpenAI style.
@added(Versions.v2026_01_01_preview)
@usage(ResponseUsage)
model ResponseMCPApprovalResponseItem extends ResponseItem {
  /** The type of the item. */
  type: ItemType.mcp_approval_response;

  /** The ID of the approval request. */
  approval_request_id: string;

  /** Whether the tool call was approved. */
  approve: boolean;

  /** The reason for the approval decision. */
  reason?: string;
}

/** A request item that represents a response to an MCP approval request. */
#suppress "@azure-tools/typespec-azure-core/casing-style" // Service message format is snake_case to remain close to OpenAI style.
@added(Versions.v2026_01_01_preview)
@usage(RequestUsage)
model MCPApprovalResponseRequestItem extends ConversationRequestItem {
  /** The type of the item. */
  type: ItemType.mcp_approval_response;

  /** The ID of the approval request. */
  approval_request_id: string;

  /** Whether the tool call was approved. */
  approve: boolean;
}

// -----------------------------------------------------------------------
// New item types added in v2026_04_10
// -----------------------------------------------------------------------

/** A search action source URL. */
#suppress "@azure-tools/typespec-azure-core/casing-style" // Service message format is snake_case to remain close to OpenAI style.
@added(Versions.v2026_04_10)
@usage(ResponseUsage)
model ActionSearchSource {
  /** The type of source. Always 'url'. */
  type: "url";

  /** The URL of the source. */
  url: string;
}

/** A web search action. */
#suppress "@azure-tools/typespec-azure-core/casing-style" // Service message format is snake_case to remain close to OpenAI style.
@added(Versions.v2026_04_10)
@usage(ResponseUsage)
model ActionSearch {
  /** The search query. */
  query?: string;

  /** The action type. Always 'search'. */
  type: "search";

  /** The sources used in the search. */
  sources?: ActionSearchSource[];
}

/** An open page action. */
#suppress "@azure-tools/typespec-azure-core/casing-style" // Service message format is snake_case to remain close to OpenAI style.
@added(Versions.v2026_04_10)
@usage(ResponseUsage)
model ActionOpenPage {
  /** The action type. Always 'open_page'. */
  type: "open_page";

  /** The URL opened by the model. */
  url: string;
}

/** A find action to search text within a page. */
#suppress "@azure-tools/typespec-azure-core/casing-style" // Service message format is snake_case to remain close to OpenAI style.
@added(Versions.v2026_04_10)
@usage(ResponseUsage)
model ActionFind {
  /** The pattern or text to search for within the page. */
  pattern: string;

  /** The action type. Always 'find'. */
  type: "find";

  /** The URL of the page searched for the pattern. */
  url: string;
}

/** A response item that represents a web search call. */
#suppress "@azure-tools/typespec-azure-core/casing-style" // Service message format is snake_case to remain close to OpenAI style.
@added(Versions.v2026_04_10)
@usage(ResponseUsage)
model ResponseWebSearchCallItem extends ResponseItem {
  /** The type of the item. Always 'web_search_call'. */
  type: ItemType.web_search_call;

  /** The unique ID of the web search tool call. */
  id?: string;

  /** The status of the web search tool call. */
  #suppress "@azure-tools/typespec-azure-core/no-unnamed-union" "Keeping inline union to match source."
  status: "in_progress" | "searching" | "completed" | "failed" | string;
}

/** A file search result entry. */
#suppress "@azure-tools/typespec-azure-core/casing-style" // Service message format is snake_case to remain close to OpenAI style.
@added(Versions.v2026_04_10)
@usage(ResponseUsage)
model FileSearchResult {
  /** Key-value pairs for filtering file search results. */
  attributes?: Record<string>;

  /** The unique ID of the file. */
  file_id?: string;

  /** The name of the file. */
  filename?: string;

  /** The relevance score of the file search result. */
  score?: float32;

  /** The text content of the file that matched the query. */
  text?: string;
}

/** A response item that represents a file search call. */
#suppress "@azure-tools/typespec-azure-core/casing-style" // Service message format is snake_case to remain close to OpenAI style.
@added(Versions.v2026_04_10)
@usage(ResponseUsage)
model ResponseFileSearchCallItem extends ResponseItem {
  /** The type of the item. Always 'file_search_call'. */
  type: ItemType.file_search_call;

  /** The unique ID of the file search tool call. */
  id?: string;

  /** The queries used for the file search. */
  queries?: string[];

  /** The status of the file search tool call. */
  #suppress "@azure-tools/typespec-azure-core/no-unnamed-union" "Keeping inline union to match source."
  status: "in_progress" | "searching" | "completed" | "incomplete" | "failed" | string;

  /** The results of the file search. */
  results?: FileSearchResult[];
}

import "./content_parts.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using TypeSpec.Versioning;
using TypeSpec.OpenAPI;

namespace VoiceLive;

// Message, function-call, and MCP item types are consumed from OpenAI GA
// Realtime; preview-only Azure web/file search item types remain here.
union ItemType {
  string,

  /** Web search call item. */
  @removed(Versions.v1)
  web_search_call: "web_search_call",

  /** File search call item. */
  @removed(Versions.v1)
  file_search_call: "file_search_call",
}

// Message content parts are consumed from OpenAI GA Realtime: message items
// (`RealtimeConversationItemMessage{System,User,Assistant}`) carry their own
// per-role inline content (`RealtimeConversationItemMessage{Role}Content`), so
// VoiceLive no longer defines its own message content-part hierarchy.

/**
 * A conversation item supplied by the client. Message, function-call, and MCP
 * request items are all consumed from OpenAI's GA Realtime models.
 */
@oneOf
union ConversationRequestItem {
  /** Message item (OpenAI GA Realtime; system/user/assistant). */
  OpenAI.RealtimeConversationItemMessage,

  /** Function call item (OpenAI GA Realtime). */
  OpenAI.RealtimeConversationItemFunctionCall,

  /** Function call output item (OpenAI GA Realtime). */
  OpenAI.RealtimeConversationItemFunctionCallOutput,

  /** MCP approval response item (OpenAI GA Realtime). */
  OpenAI.RealtimeMCPApprovalResponse,
}

// ----- Message Items -----
// Consumed directly from OpenAI GA Realtime
// (`RealtimeConversationItemMessage{System,User,Assistant}`) via the
// ConversationRequestItem / ResponseItem `@oneOf` unions. No VoiceLive copy.

// ----- Function Call Items -----
// Consumed directly from OpenAI GA Realtime `RealtimeConversationItemFunctionCall`
// and `RealtimeConversationItemFunctionCallOutput` via the ConversationRequestItem
// and ResponseItem `@oneOf` unions above/below. No VoiceLive copy is maintained.

/** Base for any response item; discriminated by `type`. */
@discriminator("type")
@usage(ResponseUsage)
model AzureResponseItem {
  // must stay here, required, broad type
  type: ItemType;

  id?: string;
  object?: "realtime.item";
}

/**
 * A conversation item returned by the service. Message, function-call, and MCP
 * response items are consumed from OpenAI's GA Realtime models; the preview
 * channel additionally contributes web/file search items via `AzureResponseItem`.
 */
@oneOf
union ResponseItem {
  /** VoiceLive web/file search response items (Azure-specific). */
  @removed(Versions.v1)
  AzureResponseItem,

  /** Message item (OpenAI GA Realtime; system/user/assistant). */
  OpenAI.RealtimeConversationItemMessage,

  /** Function call item (OpenAI GA Realtime). */
  OpenAI.RealtimeConversationItemFunctionCall,

  /** Function call output item (OpenAI GA Realtime). */
  OpenAI.RealtimeConversationItemFunctionCallOutput,

  /** MCP tool call item (OpenAI GA Realtime). */
  OpenAI.RealtimeMCPToolCall,

  /** MCP list-tools item (OpenAI GA Realtime). */
  OpenAI.RealtimeMCPListTools,

  /** MCP approval request item (OpenAI GA Realtime). */
  OpenAI.RealtimeMCPApprovalRequest,

  /** MCP approval response item (OpenAI GA Realtime). */
  OpenAI.RealtimeMCPApprovalResponse,
}

// Response message items are consumed from OpenAI GA Realtime
// (`RealtimeConversationItemMessage{System,User,Assistant}`) via the ResponseItem
// `@oneOf` union; their status/role/content come from the GA models.

// ----- Response status -----
// Consumed from OpenAI GA Realtime: `Response` extends `OpenAI.RealtimeResponse`,
// inheriting its `status` and `status_details` (`RealtimeResponseStatusDetails`).

// ----- Token usage -----
// Consumed directly from OpenAI GA Realtime `RealtimeResponseUsage` and its
// nested `RealtimeResponseUsageInputTokenDetails` / `OutputTokenDetails` /
// `InputTokenDetailsCachedTokensDetails`. Referenced by `Response.usage`.
// (GA drops the beta `reasoning_tokens` output detail.)

// ----- MCP items -----
// Consumed directly from OpenAI GA Realtime `RealtimeMCPToolCall`,
// `RealtimeMCPListTools`, `RealtimeMCPApprovalRequest`, and
// `RealtimeMCPApprovalResponse` via the ResponseItem / ConversationRequestItem
// `@oneOf` unions. No VoiceLive copy is maintained.

// -----------------------------------------------------------------------
// Web/file search call item types
// -----------------------------------------------------------------------

/** A search action source URL. */
#suppress "@azure-tools/typespec-azure-core/casing-style" // Service message format is snake_case to remain close to OpenAI style.
@usage(ResponseUsage)
model ActionSearchSource {
  /** The type of source. Always 'url'. */
  type: "url";

  /** The URL of the source. */
  url: url;
}

/** A web search action. */
#suppress "@azure-tools/typespec-azure-core/casing-style" // Service message format is snake_case to remain close to OpenAI style.
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
@usage(ResponseUsage)
model ActionOpenPage {
  /** The action type. Always 'open_page'. */
  type: "open_page";

  /** The URL opened by the model. */
  url: url;
}

/** A find action to search text within a page. */
#suppress "@azure-tools/typespec-azure-core/casing-style" // Service message format is snake_case to remain close to OpenAI style.
@usage(ResponseUsage)
model ActionFind {
  /** The pattern or text to search for within the page. */
  pattern: string;

  /** The action type. Always 'find'. */
  type: "find";

  /** The URL of the page searched for the pattern. */
  url: url;
}

/** A response item that represents a web search call. */
#suppress "@azure-tools/typespec-azure-core/casing-style" // Service message format is snake_case to remain close to OpenAI style.
@removed(Versions.v1)
@usage(ResponseUsage)
model ResponseWebSearchCallItem extends AzureResponseItem {
  /** The type of the item. Always 'web_search_call'. */
  type: ItemType.web_search_call;

  /** The status of the web search tool call. */
  #suppress "@azure-tools/typespec-azure-core/no-unnamed-union" "Keeping inline union to match source."
  status: "in_progress" | "searching" | "completed" | "failed" | string;
}

/** A file search result entry. */
#suppress "@azure-tools/typespec-azure-core/casing-style" // Service message format is snake_case to remain close to OpenAI style.
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
@removed(Versions.v1)
@usage(ResponseUsage)
model ResponseFileSearchCallItem extends AzureResponseItem {
  /** The type of the item. Always 'file_search_call'. */
  type: ItemType.file_search_call;

  /** The queries used for the file search. */
  queries?: string[];

  /** The status of the file search tool call. */
  #suppress "@azure-tools/typespec-azure-core/no-unnamed-union" "Keeping inline union to match source."
  status:
    | "in_progress"
    | "searching"
    | "completed"
    | "incomplete"
    | "failed"
    | string;

  /** The results of the file search. */
  results?: FileSearchResult[];
}

import "../common/service.tsp";

using TypeSpec.Http;

namespace Azure.AI.Projects;

/**
 * A JSON-RPC request identifier.
 */
union MCPRequestId {
  string,
  int64,
}

/**
 * Supported toolbox MCP method names.
 */
union MCPMethodName {
  list: "tools/list",
  call: "tools/call",
}

/**
 * Generic metadata bag for MCP payloads.
 */
alias MCPMeta = Record<unknown>;

/**
 * Standard JSON-RPC error object.
 */
model MCPJsonRpcError {
  /**
   * The error code.
   */
  code: int32;

  /**
   * A short human-readable description of the error.
   */
  message: string;

  /**
   * Additional error data, if available.
   */
  data?: unknown;
}

/**
 * Base fields for a JSON-RPC request.
 */
model MCPJsonRpcRequestBase {
  /**
   * The JSON-RPC protocol version.
   */
  jsonrpc: "2.0";

  /**
   * The request identifier.
   */
  id: MCPRequestId;
}

/**
 * Pagination parameters for list requests.
 */
model MCPPaginatedRequestParams {
  /**
   * Optional metadata for protocol-level extensions.
   */
  _meta?: MCPMeta;

  /**
   * An opaque pagination cursor.
   */
  cursor?: string;
}

/**
 * Parameters for a tools/call request.
 */
model MCPCallToolRequestParams {
  /**
   * Optional metadata for protocol-level extensions.
   */
  _meta?: MCPMeta;

  /**
   * The name of the tool to call.
   */
  name: string;

  /**
   * Arguments to pass to the tool.
   */
  arguments?: Record<unknown>;
}

/**
 * JSON-RPC request for tools/list.
 */
model MCPListToolsRequest {
  ...MCPJsonRpcRequestBase;

  /**
   * The MCP method name.
   */
  method: "tools/list";

  /**
   * Optional pagination parameters.
   */
  params?: MCPPaginatedRequestParams;
}

/**
 * JSON-RPC request for tools/call.
 */
model MCPCallToolRequest {
  ...MCPJsonRpcRequestBase;

  /**
   * The MCP method name.
   */
  method: "tools/call";

  /**
   * Tool call request parameters.
   */
  params: MCPCallToolRequestParams;
}

/**
 * Supported JSON-RPC requests for toolbox MCP runtime.
 */
union MCPJsonRpcRequest {
  MCPListToolsRequest,
  MCPCallToolRequest,
}

/**
 * JSON schema object used for tool input/output shape.
 */
model MCPObjectSchema {
  /**
   * Optional JSON schema dialect URI.
   */
  $schema?: string;

  /**
   * The schema root type.
   */
  type: "object";

  /**
   * Optional object properties.
   */
  properties?: Record<Record<unknown>>;

  /**
   * Optional required property names.
   */
  required?: string[];
}

/**
 * Additional tool annotations.
 */
model MCPToolAnnotations {
  /**
   * Human-readable title for the tool.
   */
  title?: string;

  /**
   * Hint that tool is read-only.
   */
  readOnlyHint?: boolean;

  /**
   * Hint that tool may be destructive.
   */
  destructiveHint?: boolean;

  /**
   * Hint that repeated calls are idempotent.
   */
  idempotentHint?: boolean;

  /**
   * Hint that tool interacts with open-world systems.
   */
  openWorldHint?: boolean;
}

/**
 * A tool definition returned from tools/list.
 */
model MCPTool {
  /**
   * Programmatic tool name.
   */
  name: string;

  /**
   * Optional user-facing title.
   */
  title?: string;

  /**
   * Optional human-readable description.
   */
  description?: string;

  /**
   * JSON schema describing expected tool arguments.
   */
  inputSchema: MCPObjectSchema;

  /**
   * Optional JSON schema describing structured tool output.
   */
  outputSchema?: MCPObjectSchema;

  /**
   * Optional additional tool annotations.
   */
  annotations?: MCPToolAnnotations;

  /**
   * Optional metadata for protocol-level extensions.
   */
  _meta?: MCPMeta;
}

/**
 * Text content block.
 */
model MCPTextContent {
  /**
   * Content block type.
   */
  type: "text";

  /**
   * The text content value.
   */
  text: string;

  /**
   * Optional annotations.
   */
  annotations?: MCPMeta;

  /**
   * Optional metadata for protocol-level extensions.
   */
  _meta?: MCPMeta;
}

/**
 * Image content block.
 */
model MCPImageContent {
  /**
   * Content block type.
   */
  type: "image";

  /**
   * Base64-encoded image data.
   */
  data: string;

  /**
   * MIME type of the image payload.
   */
  mimeType: string;

  /**
   * Optional annotations.
   */
  annotations?: MCPMeta;

  /**
   * Optional metadata for protocol-level extensions.
   */
  _meta?: MCPMeta;
}

/**
 * Audio content block.
 */
model MCPAudioContent {
  /**
   * Content block type.
   */
  type: "audio";

  /**
   * Base64-encoded audio data.
   */
  data: string;

  /**
   * MIME type of the audio payload.
   */
  mimeType: string;

  /**
   * Optional annotations.
   */
  annotations?: MCPMeta;

  /**
   * Optional metadata for protocol-level extensions.
   */
  _meta?: MCPMeta;
}

/**
 * Resource-link content block.
 */
model MCPResourceLinkContent {
  /**
   * Content block type.
   */
  type: "resource_link";

  /**
   * Programmatic resource name.
   */
  name: string;

  /**
   * The resource URI.
   */
  uri: string;

  /**
   * Optional display title.
   */
  title?: string;

  /**
   * Optional human-readable description.
   */
  description?: string;

  /**
   * Optional MIME type hint.
   */
  mimeType?: string;

  /**
   * Optional annotations.
   */
  annotations?: MCPMeta;

  /**
   * Optional metadata for protocol-level extensions.
   */
  _meta?: MCPMeta;
}

/**
 * Embedded resource content block.
 */
model MCPEmbeddedResourceContent {
  /**
   * Content block type.
   */
  type: "resource";

  /**
   * Embedded resource payload.
   */
  resource: Record<unknown>;

  /**
   * Optional annotations.
   */
  annotations?: MCPMeta;

  /**
   * Optional metadata for protocol-level extensions.
   */
  _meta?: MCPMeta;
}

/**
 * Supported content blocks for tools/call results.
 */
union MCPContentBlock {
  MCPTextContent,
  MCPImageContent,
  MCPAudioContent,
  MCPResourceLinkContent,
  MCPEmbeddedResourceContent,
}

/**
 * Result payload for tools/list.
 */
model MCPListToolsResult {
  /**
   * Optional metadata for protocol-level extensions.
   */
  _meta?: MCPMeta;

  /**
   * Cursor to retrieve the next page.
   */
  nextCursor?: string;

  /**
   * Tools exposed by the server.
   */
  tools: MCPTool[];
}

/**
 * Result payload for tools/call.
 */
model MCPCallToolResult {
  /**
   * Optional metadata for protocol-level extensions.
   */
  _meta?: MCPMeta;

  /**
   * Unstructured content output from the tool.
   */
  content: MCPContentBlock[];

  /**
   * Optional structured result.
   */
  structuredContent?: Record<unknown>;

  /**
   * Indicates whether the tool call result represents an error.
   */
  isError?: boolean;
}

/**
 * Successful result payloads for supported MCP methods.
 */
union MCPJsonRpcResult {
  MCPListToolsResult,
  MCPCallToolResult,
}

/**
 * Successful JSON-RPC response.
 */
model MCPJsonRpcResultResponse {
  /**
   * The JSON-RPC protocol version.
   */
  jsonrpc: "2.0";

  /**
   * The request identifier.
   */
  id: MCPRequestId;

  /**
   * The successful method result payload.
   */
  result: MCPJsonRpcResult;
}

/**
 * Error JSON-RPC response.
 */
@error
model MCPJsonRpcErrorResponse {
  /**
   * The JSON-RPC protocol version.
   */
  jsonrpc: "2.0";

  /**
   * The request identifier, if available.
   */
  id?: MCPRequestId;

  /**
   * Error payload.
   */
  error: MCPJsonRpcError;
}

/**
 * JSON-RPC response payload.
 */
union MCPJsonRpcResponse {
  MCPJsonRpcResultResponse,
  MCPJsonRpcErrorResponse,
}

/**
 * JSON-RPC message payload for this endpoint.
 * Notifications are intentionally excluded.
 */
union MCPJsonRpcMessage {
  MCPJsonRpcRequest,
  MCPJsonRpcResponse,
}

/**
 * Method parameters accepted by the toolbox MCP endpoint.
 */
union MCPInvokeRequestParams {
  MCPPaginatedRequestParams,
  MCPCallToolRequestParams,
}

/**
 * HTTP request payload for toolbox MCP endpoint.
 */
model InvokeToolboxMcpRequest {
  /**
   * The name of the toolbox associated with this MCP request.
   */
  @path
  tool_box_name: string;

  /**
   * The JSON-RPC protocol version.
   */
  jsonrpc: "2.0";

  /**
   * The request identifier.
   */
  id: MCPRequestId;

  /**
   * Supported MCP method names.
   */
  method: MCPMethodName;

  /**
   * Method parameters for tools/list or tools/call.
   */
  params?: MCPInvokeRequestParams;
}

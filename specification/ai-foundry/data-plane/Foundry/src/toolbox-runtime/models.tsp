import "../common/service.tsp";

using TypeSpec.Http;

namespace Azure.AI.Projects;

/**
 * A JSON-RPC request identifier.
 */
union ToolsetMCPRequestId {
  string,
  int64,
}

/**
 * Supported toolset MCP method names.
 */
union ToolsetMCPMethodName {
  initialize: "initialize",
  initialized: "notifications/initialized",
  list: "tools/list",
  call: "tools/call",
}

/**
 * Generic metadata bag for MCP payloads.
 */
alias ToolsetMCPMeta = Record<unknown>;

/**
 * Standard JSON-RPC error object.
 */
model ToolsetMCPJsonRpcError {
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
 * Describes an MCP client or server implementation.
 */
model ToolsetMCPImplementation {
  /**
   * Programmatic name of the implementation.
   */
  name: string;

  /**
   * Version string of the implementation.
   */
  version: string;
}

/**
 * Tools capability declaration.
 */
model ToolsetMCPToolsCapability {
  /**
   * Whether the implementation supports notifications for changes to the tool list.
   */
  listChanged?: boolean;
}

/**
 * Capabilities that the client supports (tools-only subset).
 */
model ToolsetMCPClientCapabilities {
  /**
   * Present if the client supports tool-related capabilities.
   */
  tools?: ToolsetMCPToolsCapability;
}

/**
 * Capabilities that the server supports (tools-only subset).
 */
model ToolsetMCPServerCapabilities {
  /**
   * Present if the server offers any tools to call.
   */
  tools?: ToolsetMCPToolsCapability;
}

/**
 * Parameters for an initialize request.
 */
model ToolsetMCPInitializeRequestParams {
  /**
   * Optional metadata for protocol-level extensions.
   */
  _meta?: ToolsetMCPMeta;

  /**
   * The latest version of the Model Context Protocol that the client supports.
   */
  protocolVersion: string;

  /**
   * Capabilities that the client supports.
   */
  capabilities: ToolsetMCPClientCapabilities;

  /**
   * Information about the client implementation.
   */
  clientInfo: ToolsetMCPImplementation;
}

/**
 * Base fields for a JSON-RPC request.
 */
model ToolsetMCPJsonRpcRequestBase {
  /**
   * The JSON-RPC protocol version.
   */
  jsonrpc: "2.0";

  /**
   * The request identifier.
   */
  id: ToolsetMCPRequestId;
}

/**
 * Pagination parameters for list requests.
 */
model ToolsetMCPPaginatedRequestParams {
  /**
   * Optional metadata for protocol-level extensions.
   */
  _meta?: ToolsetMCPMeta;

  /**
   * An opaque pagination cursor.
   */
  cursor?: string;
}

/**
 * Parameters for a tools/call request.
 */
model ToolsetMCPCallToolRequestParams {
  /**
   * Optional metadata for protocol-level extensions.
   */
  _meta?: ToolsetMCPMeta;

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
 * JSON-RPC request for initialize.
 */
model ToolsetMCPInitializeRequest {
  ...ToolsetMCPJsonRpcRequestBase;

  /**
   * The MCP method name.
   */
  method: "initialize";

  /**
   * Initialize request parameters.
   */
  params: ToolsetMCPInitializeRequestParams;
}

/**
 * JSON-RPC request for tools/list.
 */
model ToolsetMCPListToolsRequest {
  ...ToolsetMCPJsonRpcRequestBase;

  /**
   * The MCP method name.
   */
  method: "tools/list";

  /**
   * Optional pagination parameters.
   */
  params?: ToolsetMCPPaginatedRequestParams;
}

/**
 * JSON-RPC request for tools/call.
 */
model ToolsetMCPCallToolRequest {
  ...ToolsetMCPJsonRpcRequestBase;

  /**
   * The MCP method name.
   */
  method: "tools/call";

  /**
   * Tool call request parameters.
   */
  params: ToolsetMCPCallToolRequestParams;
}

/**
 * Supported JSON-RPC requests for toolset MCP runtime.
 */
union ToolsetMCPJsonRpcRequest {
  ToolsetMCPInitializeRequest,
  ToolsetMCPListToolsRequest,
  ToolsetMCPCallToolRequest,
}

/**
 * JSON schema object used for tool input/output shape.
 */
model ToolsetMCPObjectSchema {
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
model ToolsetMCPToolAnnotations {
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
model ToolsetMCPTool {
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
  inputSchema: ToolsetMCPObjectSchema;

  /**
   * Optional JSON schema describing structured tool output.
   */
  outputSchema?: ToolsetMCPObjectSchema;

  /**
   * Optional additional tool annotations.
   */
  annotations?: ToolsetMCPToolAnnotations;

  /**
   * Optional metadata for protocol-level extensions.
   */
  _meta?: ToolsetMCPMeta;
}

/**
 * Text content block.
 */
model ToolsetMCPTextContent {
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
  annotations?: ToolsetMCPMeta;

  /**
   * Optional metadata for protocol-level extensions.
   */
  _meta?: ToolsetMCPMeta;
}

/**
 * Image content block.
 */
model ToolsetMCPImageContent {
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
  annotations?: ToolsetMCPMeta;

  /**
   * Optional metadata for protocol-level extensions.
   */
  _meta?: ToolsetMCPMeta;
}

/**
 * Audio content block.
 */
model ToolsetMCPAudioContent {
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
  annotations?: ToolsetMCPMeta;

  /**
   * Optional metadata for protocol-level extensions.
   */
  _meta?: ToolsetMCPMeta;
}

/**
 * Resource-link content block.
 */
model ToolsetMCPResourceLinkContent {
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
  annotations?: ToolsetMCPMeta;

  /**
   * Optional metadata for protocol-level extensions.
   */
  _meta?: ToolsetMCPMeta;
}

/**
 * Embedded resource content block.
 */
model ToolsetMCPEmbeddedResourceContent {
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
  annotations?: ToolsetMCPMeta;

  /**
   * Optional metadata for protocol-level extensions.
   */
  _meta?: ToolsetMCPMeta;
}

/**
 * Supported content blocks for tools/call results.
 */
union ToolsetMCPContentBlock {
  ToolsetMCPTextContent,
  ToolsetMCPImageContent,
  ToolsetMCPAudioContent,
  ToolsetMCPResourceLinkContent,
  ToolsetMCPEmbeddedResourceContent,
}

/**
 * Result payload for tools/list.
 */
model ToolsetMCPListToolsResult {
  /**
   * Optional metadata for protocol-level extensions.
   */
  _meta?: ToolsetMCPMeta;

  /**
   * Cursor to retrieve the next page.
   */
  nextCursor?: string;

  /**
   * Tools exposed by the server.
   */
  tools: ToolsetMCPTool[];
}

/**
 * Result payload for tools/call.
 */
model ToolsetMCPCallToolResult {
  /**
   * Optional metadata for protocol-level extensions.
   */
  _meta?: ToolsetMCPMeta;

  /**
   * Unstructured content output from the tool.
   */
  content: ToolsetMCPContentBlock[];

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
 * Result payload for initialize.
 */
model ToolsetMCPInitializeResult {
  /**
   * Optional metadata for protocol-level extensions.
   */
  _meta?: ToolsetMCPMeta;

  /**
   * The version of the Model Context Protocol that the server wants to use.
   */
  protocolVersion: string;

  /**
   * Capabilities that the server supports.
   */
  capabilities: ToolsetMCPServerCapabilities;

  /**
   * Information about the server implementation.
   */
  serverInfo: ToolsetMCPImplementation;

  /**
   * Instructions describing how to use the server and its features.
   */
  instructions?: string;
}

/**
 * Successful result payloads for supported MCP methods.
 */
union ToolsetMCPJsonRpcResult {
  ToolsetMCPInitializeResult,
  ToolsetMCPListToolsResult,
  ToolsetMCPCallToolResult,
}

/**
 * Successful JSON-RPC response.
 */
model ToolsetMCPJsonRpcResultResponse {
  /**
   * The JSON-RPC protocol version.
   */
  jsonrpc: "2.0";

  /**
   * The request identifier.
   */
  id: ToolsetMCPRequestId;

  /**
   * The successful method result payload.
   */
  result: ToolsetMCPJsonRpcResult;
}

/**
 * Error JSON-RPC response.
 */
@error
model ToolsetMCPJsonRpcErrorResponse {
  /**
   * The JSON-RPC protocol version.
   */
  jsonrpc: "2.0";

  /**
   * The request identifier, if available.
   */
  id?: ToolsetMCPRequestId;

  /**
   * Error payload.
   */
  error: ToolsetMCPJsonRpcError;
}

/**
 * JSON-RPC response payload.
 */
union ToolsetMCPJsonRpcResponse {
  ToolsetMCPJsonRpcResultResponse,
  ToolsetMCPJsonRpcErrorResponse,
}

/**
 * JSON-RPC notification for notifications/initialized.
 */
model ToolsetMCPInitializedNotification {
  /**
   * The JSON-RPC protocol version.
   */
  jsonrpc: "2.0";

  /**
   * The MCP method name.
   */
  method: "notifications/initialized";

  /**
   * Optional notification parameters.
   */
  params?: Record<unknown>;
}

/**
 * Supported JSON-RPC notifications for toolset MCP runtime.
 */
union ToolsetMCPJsonRpcNotification {
  ToolsetMCPInitializedNotification,
}

/**
 * JSON-RPC message payload for this endpoint.
 */
union ToolsetMCPJsonRpcMessage {
  ToolsetMCPJsonRpcRequest,
  ToolsetMCPJsonRpcNotification,
  ToolsetMCPJsonRpcResponse,
}

/**
 * Method parameters accepted by the toolset MCP endpoint.
 */
union ToolsetMCPInvokeRequestParams {
  ToolsetMCPInitializeRequestParams,
  ToolsetMCPPaginatedRequestParams,
  ToolsetMCPCallToolRequestParams,
}

/**
 * HTTP request payload for toolset MCP endpoint.
 */
alias ToolsetMCPInvokeRequest = {
  /**
   * The name of the toolset associated with this MCP request.
   */
  @path
  tool_set_name: string;

  /**
   * The JSON-RPC protocol version.
   */
  jsonrpc: "2.0";

  /**
   * The request identifier. Omitted for notifications.
   */
  id?: ToolsetMCPRequestId;

  /**
   * Supported MCP method names.
   */
  method: ToolsetMCPMethodName;

  /**
   * Method parameters for tools/list or tools/call.
   */
  params?: ToolsetMCPInvokeRequestParams;
};

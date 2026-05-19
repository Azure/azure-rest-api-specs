import "@azure-tools/typespec-azure-core";
import "@typespec/rest";

using TypeSpec.Rest;
using TypeSpec.Http;

namespace FoundryLocal.AgenticRAG;

/** Operations for the MCP JSON-RPC endpoint. */
interface McpOperationGroup {
  /**
   * Single endpoint for all MCP operations. Uses JSON-RPC 2.0 with methods:
   * initialize, tools/list, tools/call. Tools available: search_hybrid,
   * search_vector, search_text, search_image, search_multimodal,
   * get_available_collections.
   */
  @summary("MCP JSON-RPC Endpoint")
  @route("/edgeai/mcp")
  @post
  mcpRequest is Azure.Core.RpcOperation<
    {
      /** Session ID from initialize response. Required for tools/list and tools/call. */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "HTTP header name"
      @header
      `Mcp-Session-Id`?: string;

      /** The JSON-RPC request body. */
      @bodyRoot
      body: JsonRpcRequest;
    },
    JsonRpcResponse
  >;
}

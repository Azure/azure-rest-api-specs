import "../common/models.tsp";
import "./models.tsp";

using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Azure.AI.Projects;

@tag("Toolboxes")
interface ToolboxRuntime {
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "not yet an Azure operation"
  @doc("Invoke toolbox runtime MCP methods (tools/list and tools/call) using JSON-RPC 2.0 payloads.")
  @operationId("invokeToolboxMcp")
  @post
  @route("/toolbox/{tool_box_name}/mcp")
  invokeToolboxMcp is FoundryDataPlaneOperation<InvokeToolboxMcpRequest, MCPJsonRpcResponse>;
}

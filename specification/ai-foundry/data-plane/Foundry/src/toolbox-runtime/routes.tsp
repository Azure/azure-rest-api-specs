import "../common/models.tsp";
import "./models.tsp";

using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Azure.AI.Projects;

@tag("Toolsets")
interface ToolsetRuntime {
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "not yet an Azure operation"
  @doc("Invoke toolset runtime MCP methods (tools/list and tools/call) using JSON-RPC 2.0 payloads.")
  @operationId("toolsetMCPInvoke")
  @post
  @route("/toolset/{tool_set_name}/mcp")
  toolsetMCPInvoke is FoundryDataPlaneOperation<
    ToolsetMCPInvokeRequest,
    ToolsetMCPJsonRpcResponse
  >;
}

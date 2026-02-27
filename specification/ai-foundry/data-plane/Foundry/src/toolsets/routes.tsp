import "../common/models.tsp";
import "./models.tsp";

using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Azure.AI.Projects;

@tag("Toolsets")
interface Toolsets {
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "not yet an Azure operation"
  @doc("Create a toolset.")
  @operationId("createToolset")
  @post
  @route("/toolset")
  createToolset is FoundryDataPlaneOperation<CreateToolsetRequest, ToolsetObject>;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "not yet an Azure operation"
  @doc("Update a toolset.")
  @operationId("updateToolset")
  @post
  @route("/toolset/{tool_set_name}")
  updateToolset is FoundryDataPlaneOperation<UpdateToolsetRequest, ToolsetObject>;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "not yet an Azure operation"
  @doc("Retrieve a toolset.")
  @operationId("getToolset")
  @get
  @route("/toolset/{tool_set_name}")
  getToolset is FoundryDataPlaneOperation<GetToolsetRequest, ToolsetObject>;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "not yet an Azure operation"
  @doc("List all toolsets.")
  @operationId("listToolsets")
  @get
  @list
  @route("/toolset")
  listToolsets is FoundryDataPlaneOperation<ListToolsetsRequest, AgentsPagedResult<ToolsetObject>>;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "not yet an Azure operation"
  @doc("Delete a toolset.")
  @operationId("deleteToolset")
  @delete
  @route("/toolset/{tool_set_name}")
  deleteToolset is FoundryDataPlaneOperation<DeleteToolsetRequest, DeleteToolsetResponse>;
}

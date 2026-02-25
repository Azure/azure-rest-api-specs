import "../common/models.tsp";
import "./models.tsp";

using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Azure.AI.Projects;

@tag("Toolboxes")
interface Toolboxes {
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "not yet an Azure operation"
  @doc("Create a toolbox.")
  @operationId("createToolbox")
  @post
  @route("/toolbox")
  createToolbox is FoundryDataPlaneOperation<CreateToolboxRequest, ToolboxObject>;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "not yet an Azure operation"
  @doc("Update a toolbox.")
  @operationId("updateToolbox")
  @post
  @route("/toolbox/{tool_box_name}")
  updateToolbox is FoundryDataPlaneOperation<UpdateToolboxRequest, ToolboxObject>;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "not yet an Azure operation"
  @doc("Retrieve a toolbox.")
  @operationId("getToolbox")
  @get
  @route("/toolbox/{tool_box_name}")
  getToolbox is FoundryDataPlaneOperation<GetToolboxRequest, ToolboxObject>;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "not yet an Azure operation"
  @doc("List all toolboxes.")
  @operationId("listToolboxes")
  @get
  @list
  @route("/toolbox")
  listToolboxes is FoundryDataPlaneOperation<ListToolboxesRequest, AgentsPagedResult<ToolboxObject>>;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "not yet an Azure operation"
  @doc("Delete a toolbox.")
  @operationId("deleteToolbox")
  @delete
  @route("/toolbox/{tool_box_name}")
  deleteToolbox is FoundryDataPlaneOperation<DeleteToolboxRequest, DeleteToolboxResponse>;
}

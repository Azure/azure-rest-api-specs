import "../common/models.tsp";
import "../servicepatterns.tsp";
import "./models.tsp";

using TypeSpec.Http;
using TypeSpec.OpenAPI;
using Azure.ClientGenerator.Core;

namespace Azure.AI.Projects;

@@usage(UpdateToolboxRequest, Usage.input);
@@access(UpdateToolboxRequest, Access.public);

@tag("Toolboxes")
interface Toolboxes {
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "not yet an Azure operation"
  @doc("Create a new version of a toolbox. If the toolbox does not exist, it will be created.")
  @operationId("createToolboxVersion")
  @post
  @route("/toolboxes/{name}/versions")
  createToolboxVersion is FoundryDataPlaneOperation<
    CreateToolboxVersionRequest,
    ToolboxVersionObject
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "not yet an Azure operation"
  @doc("Retrieve a toolbox.")
  @operationId("getToolbox")
  @get
  @route("/toolboxes/{name}")
  getToolbox is FoundryDataPlaneOperation<
    GetToolboxRequest,
    ToolboxObject
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "not yet an Azure operation"
  @doc("List all toolboxes.")
  @operationId("listToolboxes")
  @get
  @list
  @route("/toolboxes")
  listToolboxes is FoundryDataPlaneOperation<
    ListToolboxesRequest,
    AgentsPagedResult<ToolboxObject>
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "not yet an Azure operation"
  @doc("List all versions of a toolbox.")
  @operationId("listToolboxVersions")
  @get
  @list
  @route("/toolboxes/{name}/versions")
  listToolboxVersions is FoundryDataPlaneOperation<
    ListToolboxVersionsRequest,
    AgentsPagedResult<ToolboxVersionObject>
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "not yet an Azure operation"
  @doc("Retrieve a specific version of a toolbox.")
  @operationId("getToolboxVersion")
  @get
  @route("/toolboxes/{name}/versions/{version}")
  getToolboxVersion is FoundryDataPlaneOperation<
    GetToolboxVersionRequest,
    ToolboxVersionObject
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "not yet an Azure operation"
  @doc("Update a toolbox to point to a specific version.")
  @operationId("updateToolbox")
  @patch
  @route("/toolboxes/{name}")
  updateToolbox is FoundryDataPlaneOperation<
    UpdateToolboxRequest,
    ToolboxObject
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "not yet an Azure operation"
  @doc("Delete a toolbox and all its versions.")
  @operationId("deleteToolbox")
  @delete
  @route("/toolboxes/{name}")
  deleteToolbox is FoundryDataPlaneOperation<
    DeleteToolboxRequest,
    void
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "not yet an Azure operation"
  @doc("Delete a specific version of a toolbox.")
  @operationId("deleteToolboxVersion")
  @delete
  @route("/toolboxes/{name}/versions/{version}")
  deleteToolboxVersion is FoundryDataPlaneOperation<
    DeleteToolboxVersionRequest,
    void
  >;
}

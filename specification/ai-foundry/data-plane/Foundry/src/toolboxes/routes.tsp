import "../common/models.tsp";
import "./models.tsp";

using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Azure.AI.Projects;

alias ToolboxesPreviewHeader = WithRequiredFoundryPreviewHeader<FoundryFeaturesOptInKeys.toolbox_v1_preview>;

@tag("Toolboxes")
interface Toolboxes {
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "not yet an Azure operation"
  @doc("Create a new version of a toolbox. If the toolbox does not exist, it will be created.")
  @operationId("createToolboxVersion")
  @post
  @route("/toolboxes/{toolbox_name}/versions")
  @extension("x-ms-foundry-meta", ToolboxesRequiredPreviews)
  createToolboxVersion is FoundryDataPlaneOperation<
    CreateToolboxVersionRequest & ToolboxesPreviewHeader,
    ToolboxVersionObject
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "not yet an Azure operation"
  @doc("Retrieve a toolbox.")
  @operationId("getToolbox")
  @get
  @route("/toolboxes/{toolbox_name}")
  @extension("x-ms-foundry-meta", ToolboxesRequiredPreviews)
  getToolbox is FoundryDataPlaneOperation<
    GetToolboxRequest & ToolboxesPreviewHeader,
    ToolboxObject
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "not yet an Azure operation"
  @doc("List all toolboxes.")
  @operationId("listToolboxes")
  @get
  @list
  @route("/toolboxes")
  @extension("x-ms-foundry-meta", ToolboxesRequiredPreviews)
  listToolboxes is FoundryDataPlaneOperation<
    ListToolboxesRequest & ToolboxesPreviewHeader,
    AgentsPagedResult<ToolboxObject>
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "not yet an Azure operation"
  @doc("List all versions of a toolbox.")
  @operationId("listToolboxVersions")
  @get
  @list
  @route("/toolboxes/{toolbox_name}/versions")
  @extension("x-ms-foundry-meta", ToolboxesRequiredPreviews)
  listToolboxVersions is FoundryDataPlaneOperation<
    ListToolboxVersionsRequest & ToolboxesPreviewHeader,
    AgentsPagedResult<ToolboxVersionObject>
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "not yet an Azure operation"
  @doc("Retrieve a specific version of a toolbox.")
  @operationId("getToolboxVersion")
  @get
  @route("/toolboxes/{toolbox_name}/versions/{version}")
  @extension("x-ms-foundry-meta", ToolboxesRequiredPreviews)
  getToolboxVersion is FoundryDataPlaneOperation<
    GetToolboxVersionRequest & ToolboxesPreviewHeader,
    ToolboxVersionObject
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "not yet an Azure operation"
  @doc("Update a toolbox to point to a specific version.")
  @operationId("updateToolbox")
  @patch
  @route("/toolboxes/{toolbox_name}")
  @extension("x-ms-foundry-meta", ToolboxesRequiredPreviews)
  updateToolbox is FoundryDataPlaneOperation<
    UpdateToolboxRequest & ToolboxesPreviewHeader,
    ToolboxObject
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "not yet an Azure operation"
  @doc("Delete a toolbox and all its versions.")
  @operationId("deleteToolbox")
  @delete
  @route("/toolboxes/{toolbox_name}")
  @extension("x-ms-foundry-meta", ToolboxesRequiredPreviews)
  deleteToolbox is FoundryDataPlaneOperation<
    DeleteToolboxRequest & ToolboxesPreviewHeader,
    DeleteToolboxResponse
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "not yet an Azure operation"
  @doc("Delete a specific version of a toolbox.")
  @operationId("deleteToolboxVersion")
  @delete
  @route("/toolboxes/{toolbox_name}/versions/{version}")
  @extension("x-ms-foundry-meta", ToolboxesRequiredPreviews)
  deleteToolboxVersion is FoundryDataPlaneOperation<
    DeleteToolboxVersionRequest & ToolboxesPreviewHeader,
    DeleteToolboxVersionResponse
  >;
}

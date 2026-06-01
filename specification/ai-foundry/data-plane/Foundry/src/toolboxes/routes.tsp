import "../common/models.tsp";
import "../servicepatterns.tsp";
import "./models.tsp";

using TypeSpec.Http;
using TypeSpec.OpenAPI;
using Azure.ClientGenerator.Core;

namespace Azure.AI.Projects;

@@usage(UpdateToolboxRequest, Usage.input);
@@access(UpdateToolboxRequest, Access.public);

alias ToolboxesPreviewHeader = WithRequiredFoundryPreviewHeader<FoundryFeaturesOptInKeys.toolboxes_v1_preview>;

@tag("Toolboxes")
interface Toolboxes {
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "not yet an Azure operation"
  @summary("Create a new version of a toolbox")
  @doc("Creates a new version of a toolbox. If the toolbox does not exist, it will be created.")
  @operationId("createToolboxVersion")
  @post
  @route("/toolboxes/{name}/versions")
  @extension("x-ms-foundry-meta", ToolboxesRequiredPreviews)
  createToolboxVersion is FoundryDataPlaneOperation<
    CreateToolboxVersionRequest & ToolboxesPreviewHeader,
    ToolboxVersionObject
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "not yet an Azure operation"
  @summary("Retrieve a toolbox")
  @doc("Retrieves a toolbox.")
  @operationId("getToolbox")
  @get
  @route("/toolboxes/{name}")
  @extension("x-ms-foundry-meta", ToolboxesRequiredPreviews)
  getToolbox is FoundryDataPlaneOperation<
    GetToolboxRequest & ToolboxesPreviewHeader,
    ToolboxObject
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "not yet an Azure operation"
  @summary("List all toolboxes")
  @doc("Lists all toolboxes.")
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
  @summary("List all versions of a toolbox")
  @doc("Lists all versions of a toolbox.")
  @operationId("listToolboxVersions")
  @get
  @list
  @route("/toolboxes/{name}/versions")
  @extension("x-ms-foundry-meta", ToolboxesRequiredPreviews)
  listToolboxVersions is FoundryDataPlaneOperation<
    ListToolboxVersionsRequest & ToolboxesPreviewHeader,
    AgentsPagedResult<ToolboxVersionObject>
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "not yet an Azure operation"
  @summary("Retrieve a specific version of a toolbox")
  @doc("Retrieves a specific version of a toolbox.")
  @operationId("getToolboxVersion")
  @get
  @route("/toolboxes/{name}/versions/{version}")
  @extension("x-ms-foundry-meta", ToolboxesRequiredPreviews)
  getToolboxVersion is FoundryDataPlaneOperation<
    GetToolboxVersionRequest & ToolboxesPreviewHeader,
    ToolboxVersionObject
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "not yet an Azure operation"
  @summary("Update a toolbox to point to a specific version")
  @doc("Updates a toolbox to point to a specific version.")
  @operationId("updateToolbox")
  @patch
  @route("/toolboxes/{name}")
  @extension("x-ms-foundry-meta", ToolboxesRequiredPreviews)
  updateToolbox is FoundryDataPlaneOperation<
    UpdateToolboxRequest & ToolboxesPreviewHeader,
    ToolboxObject
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "not yet an Azure operation"
  @summary("Delete a toolbox and all its versions")
  @doc("Deletes a toolbox and all its versions.")
  @operationId("deleteToolbox")
  @delete
  @route("/toolboxes/{name}")
  @extension("x-ms-foundry-meta", ToolboxesRequiredPreviews)
  deleteToolbox is FoundryDataPlaneOperation<
    DeleteToolboxRequest & ToolboxesPreviewHeader,
    void
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "not yet an Azure operation"
  @summary("Delete a specific version of a toolbox")
  @doc("Deletes a specific version of a toolbox.")
  @operationId("deleteToolboxVersion")
  @delete
  @route("/toolboxes/{name}/versions/{version}")
  @extension("x-ms-foundry-meta", ToolboxesRequiredPreviews)
  deleteToolboxVersion is FoundryDataPlaneOperation<
    DeleteToolboxVersionRequest & ToolboxesPreviewHeader,
    void
  >;
}

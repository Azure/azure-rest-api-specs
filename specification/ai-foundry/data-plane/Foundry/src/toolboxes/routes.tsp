import "../common/models.tsp";
import "../common/servicepatterns.tsp";
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
  /** Creates a new toolbox version, provisioning the toolbox itself if it does not already exist. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "not yet an Azure operation"
  @summary("Create a new version of a toolbox")
  @operationId("createToolboxVersion")
  @post
  @route("/toolboxes/{name}/versions")
  @extension("x-ms-foundry-meta", ToolboxesRequiredPreviews)
  createToolboxVersion is FoundryDataPlaneOperation<
    CreateToolboxVersionRequest & ToolboxesPreviewHeader,
    ToolboxVersionObject
  >;

  /** Retrieves the specified toolbox and its current configuration. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "not yet an Azure operation"
  @summary("Retrieve a toolbox")
  @operationId("getToolbox")
  @get
  @route("/toolboxes/{name}")
  @extension("x-ms-foundry-meta", ToolboxesRequiredPreviews)
  getToolbox is FoundryDataPlaneOperation<
    GetToolboxRequest & ToolboxesPreviewHeader,
    ToolboxObject
  >;

  /** Returns the toolboxes available in the current project. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "not yet an Azure operation"
  @summary("List toolboxes")
  @operationId("listToolboxes")
  @get
  @list
  @route("/toolboxes")
  @extension("x-ms-foundry-meta", ToolboxesRequiredPreviews)
  listToolboxes is FoundryDataPlaneOperation<
    ListToolboxesRequest & ToolboxesPreviewHeader,
    AgentsPagedResult<ToolboxObject>
  >;

  /** Returns the available versions for the specified toolbox. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "not yet an Azure operation"
  @summary("List toolbox versions")
  @operationId("listToolboxVersions")
  @get
  @list
  @route("/toolboxes/{name}/versions")
  @extension("x-ms-foundry-meta", ToolboxesRequiredPreviews)
  listToolboxVersions is FoundryDataPlaneOperation<
    ListToolboxVersionsRequest & ToolboxesPreviewHeader,
    AgentsPagedResult<ToolboxVersionObject>
  >;

  /** Retrieves the specified version of a toolbox by name and version identifier. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "not yet an Azure operation"
  @summary("Retrieve a specific version of a toolbox")
  @operationId("getToolboxVersion")
  @get
  @route("/toolboxes/{name}/versions/{version}")
  @extension("x-ms-foundry-meta", ToolboxesRequiredPreviews)
  getToolboxVersion is FoundryDataPlaneOperation<
    GetToolboxVersionRequest & ToolboxesPreviewHeader,
    ToolboxVersionObject
  >;

  /** Updates the toolbox's default version pointer to the specified version. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "not yet an Azure operation"
  @summary("Update a toolbox to point to a specific version")
  @operationId("updateToolbox")
  @patch
  @route("/toolboxes/{name}")
  @extension("x-ms-foundry-meta", ToolboxesRequiredPreviews)
  updateToolbox is FoundryDataPlaneOperation<
    UpdateToolboxRequest & ToolboxesPreviewHeader,
    ToolboxObject
  >;

  /** Removes the specified toolbox along with all of its versions. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "not yet an Azure operation"
  @summary("Delete a toolbox")
  @operationId("deleteToolbox")
  @delete
  @route("/toolboxes/{name}")
  @extension("x-ms-foundry-meta", ToolboxesRequiredPreviews)
  deleteToolbox is FoundryDataPlaneOperation<
    DeleteToolboxRequest & ToolboxesPreviewHeader,
    void
  >;

  /** Removes the specified version of a toolbox. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "not yet an Azure operation"
  @summary("Delete a specific version of a toolbox")
  @operationId("deleteToolboxVersion")
  @delete
  @route("/toolboxes/{name}/versions/{version}")
  @extension("x-ms-foundry-meta", ToolboxesRequiredPreviews)
  deleteToolboxVersion is FoundryDataPlaneOperation<
    DeleteToolboxVersionRequest & ToolboxesPreviewHeader,
    void
  >;
}

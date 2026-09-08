import "../common/models.tsp";
import "../common/servicepatterns.tsp";
import "./models.tsp";

using TypeSpec.Http;
using TypeSpec.OpenAPI;
using Azure.ClientGenerator.Core;

namespace Azure.AI.Projects;

@@usage(UpdateToolboxRequest, Usage.input);
@@access(UpdateToolboxRequest, Access.public);

@tag("Toolboxes")
interface Toolboxes {
  /** Creates a new toolbox version, provisioning the toolbox itself if it does not already exist. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "not yet an Azure operation"
  @summary("Create a new version of a toolbox")
  @operationId("createToolboxVersion")
  @post
  @route("/toolboxes/{name}/versions")
  createToolboxVersion is FoundryDataPlaneOperation<
    CreateToolboxVersionRequest,
    ToolboxVersionObject
  >;

  /** Retrieves the specified toolbox and its current configuration. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "not yet an Azure operation"
  @summary("Retrieve a toolbox")
  @operationId("getToolbox")
  @get
  @route("/toolboxes/{name}")
  getToolbox is FoundryDataPlaneOperation<GetToolboxRequest, ToolboxObject>;

  /** Returns the toolboxes available in the current project. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "not yet an Azure operation"
  @summary("List toolboxes")
  @operationId("listToolboxes")
  @get
  @list
  @route("/toolboxes")
  listToolboxes is FoundryDataPlaneOperation<
    ListToolboxesRequest,
    AgentsPagedResult<ToolboxObject>
  >;

  /** Returns the available versions for the specified toolbox. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "not yet an Azure operation"
  @summary("List toolbox versions")
  @operationId("listToolboxVersions")
  @get
  @list
  @route("/toolboxes/{name}/versions")
  listToolboxVersions is FoundryDataPlaneOperation<
    ListToolboxVersionsRequest,
    AgentsPagedResult<ToolboxVersionObject>
  >;

  /** Retrieves the specified version of a toolbox by name and version identifier. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "not yet an Azure operation"
  @summary("Retrieve a specific version of a toolbox")
  @operationId("getToolboxVersion")
  @get
  @route("/toolboxes/{name}/versions/{version}")
  getToolboxVersion is FoundryDataPlaneOperation<
    GetToolboxVersionRequest,
    ToolboxVersionObject
  >;

  /** Updates the toolbox's default version pointer to the specified version. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "not yet an Azure operation"
  @summary("Update a toolbox to point to a specific version")
  @operationId("updateToolbox")
  @patch
  @route("/toolboxes/{name}")
  updateToolbox is FoundryDataPlaneOperation<
    UpdateToolboxRequest,
    ToolboxObject
  >;

  /** Removes the specified toolbox along with all of its versions. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "not yet an Azure operation"
  @summary("Delete a toolbox")
  @operationId("deleteToolbox")
  @delete
  @route("/toolboxes/{name}")
  deleteToolbox is FoundryDataPlaneOperation<DeleteToolboxRequest, void>;

  /** Removes the specified version of a toolbox. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "not yet an Azure operation"
  @summary("Delete a specific version of a toolbox")
  @operationId("deleteToolboxVersion")
  @delete
  @route("/toolboxes/{name}/versions/{version}")
  deleteToolboxVersion is FoundryDataPlaneOperation<
    DeleteToolboxVersionRequest,
    void
  >;
}

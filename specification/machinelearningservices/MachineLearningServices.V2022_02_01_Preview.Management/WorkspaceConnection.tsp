import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Workspace.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.MachineLearningServices;
/**
 * Workspace connection.
 */
@parentResource(Workspace)
model WorkspaceConnection
  is Azure.ResourceManager.ProxyResource<WorkspaceConnectionProps> {
  ...ResourceNameParameter<
    Resource = WorkspaceConnection,
    KeyName = "connectionName",
    SegmentName = "connections",
    NamePattern = ""
  >;
}

@armResourceOperations
interface WorkspaceConnections {
  /**
   * Get the detail of a workspace connection.
   */
  get is ArmResourceRead<WorkspaceConnection>;

  /**
   * Add a new workspace connection.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "For backward compatibility"
  create is ArmResourceCreateOrReplaceSync<
    WorkspaceConnection,
    Response = ArmResourceUpdatedResponse<WorkspaceConnection>
  >;

  /**
   * Delete a workspace connection.
   */
  delete is ArmResourceDeleteSync<WorkspaceConnection>;

  /**
   * List all connections under a AML workspace.
   */
  list is ArmResourceListByParent<
    WorkspaceConnection,
    Parameters = {
      /**
       * Target of the workspace connection.
       */
      @query("target")
      target?: string;

      /**
       * Category of the workspace connection.
       */
      @query("category")
      category?: string;
    },
    Response = ArmResponse<PaginatedWorkspaceConnectionsList>
  >;
}

@@doc(WorkspaceConnection.name, "Friendly name of the workspace connection");
@@doc(WorkspaceConnection.properties, "Properties of workspace connection.");
@@doc(
  WorkspaceConnections.create::parameters.resource,
  "The object for creating or updating a new workspace connection"
);

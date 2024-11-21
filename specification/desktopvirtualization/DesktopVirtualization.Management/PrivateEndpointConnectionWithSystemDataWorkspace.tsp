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

namespace Microsoft.DesktopVirtualization;
/**
 * The Private Endpoint Connection resource.
 */
@parentResource(Workspace)
model PrivateEndpointConnectionOnWorkspaceWithSystemData
  is Azure.ResourceManager.ProxyResource<{}> {
  ...ResourceNameParameter<
    Resource = PrivateEndpointConnectionOnWorkspaceWithSystemData,
    KeyName = "privateEndpointConnectionName",
    SegmentName = "privateEndpointConnections",
    NamePattern = ""
  >;
}

@armResourceOperations
interface PrivateEndpointConnectionOnWorkspaceWithSystemDataOperationGroup {
  /**
   * Get a private endpoint connection.
   */
  getByWorkspace is ArmResourceRead<PrivateEndpointConnectionOnWorkspaceWithSystemData>;

  /**
   * Approve or reject a private endpoint connection.
   */
  updateByWorkspace is ArmResourceCreateOrReplaceSync<PrivateEndpointConnectionOnWorkspaceWithSystemData>;

  /**
   * Remove a connection.
   */
  deleteByWorkspace is ArmResourceDeleteSync<PrivateEndpointConnectionOnWorkspaceWithSystemData>;

  /**
   * List private endpoint connections associated with Workspace.
   */
  listByWorkspace is ArmResourceListByParent<
    PrivateEndpointConnectionOnWorkspaceWithSystemData,
    Parameters = {
      /**
       * Number of items per page.
       */
      @query("pageSize")
      pageSize?: int32;

      /**
       * Indicates whether the collection is descending.
       */
      @query("isDescending")
      isDescending?: boolean;

      /**
       * Initial number of items to skip.
       */
      @query("initialSkip")
      initialSkip?: int32;
    },
    Response = PrivateEndpointConnectionOnWorkspaceListResultWithSystemData
  >;
}

@@doc(PrivateEndpointConnectionOnWorkspaceWithSystemData.name,
  "The name of the private endpoint connection associated with the Azure resource."
);
@@doc(PrivateEndpointConnectionOnWorkspaceWithSystemDataOperationGroup.updateByWorkspace::parameters.resource,
  "Object containing the updated connection."
);

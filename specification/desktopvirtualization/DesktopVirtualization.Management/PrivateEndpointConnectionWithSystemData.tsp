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
// FIXME: PrivateEndpointConnectionWithSystemData has no properties property
/**
 * The Private Endpoint Connection resource.
 */
@parentResource(Workspace)
model PrivateEndpointConnectionWithSystemData
  is Azure.ResourceManager.ProxyResource<{}> {
  ...ResourceNameParameter<
    Resource = PrivateEndpointConnectionWithSystemData,
    KeyName = "privateEndpointConnectionName",
    SegmentName = "privateEndpointConnections",
    NamePattern = ""
  >;
}

@armResourceOperations
interface PrivateEndpointConnectionOps
  extends Azure.ResourceManager.Legacy.LegacyOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
        ...ResourceGroupParameter,
        ...Azure.ResourceManager.Legacy.Provider,
        ...KeysOf<ResourceNameParameter<
          Resource = Workspace,
          KeyName = "workspaceName",
          SegmentName = "workspaces",
          NamePattern = "^[A-Za-z0-9@.\\-_ ]*$"
        >>,
      },
      KeysOf<ResourceNameParameter<
        Resource = PrivateEndpointConnectionWithSystemData,
        KeyName = "privateEndpointConnectionName",
        SegmentName = "privateEndpointConnections",
        NamePattern = ""
      >>
    > {}

@armResourceOperations
interface PrivateEndpointConnections {
  /**
   * Get a private endpoint connection.
   */
  getByWorkspace is PrivateEndpointConnectionOps.Read<PrivateEndpointConnectionWithSystemData>;

  /**
   * Approve or reject a private endpoint connection.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "For backward compatibility"
  updateByWorkspace is PrivateEndpointConnectionOps.CreateOrUpdateSync<
    PrivateEndpointConnectionWithSystemData,
    Response = ArmResourceUpdatedResponse<PrivateEndpointConnectionWithSystemData>
  >;

  /**
   * Remove a connection.
   */
  deleteByWorkspace is PrivateEndpointConnectionOps.DeleteSync<PrivateEndpointConnectionWithSystemData>;

  /**
   * List private endpoint connections.
   */
  listByWorkspace is PrivateEndpointConnectionOps.List<
    PrivateEndpointConnectionWithSystemData,
    Response = ArmResponse<PrivateEndpointConnectionListResultWithSystemData>
  >;
}
@armResourceOperations
interface PrivateEndpointConnectionWithSystemDataOperationGroupOps
  extends Azure.ResourceManager.Legacy.LegacyOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
        ...ResourceGroupParameter,
        ...Azure.ResourceManager.Legacy.Provider,
        ...KeysOf<ResourceNameParameter<
          Resource = HostPool,
          KeyName = "hostPoolName",
          SegmentName = "hostPools",
          NamePattern = "^[A-Za-z0-9@.\\-_ ]*$"
        >>,
      },
      KeysOf<ResourceNameParameter<
        Resource = PrivateEndpointConnectionWithSystemData,
        KeyName = "privateEndpointConnectionName",
        SegmentName = "privateEndpointConnections",
        NamePattern = ""
      >>
    > {}

@armResourceOperations
interface PrivateEndpointConnectionWithSystemDataOperationGroup {
  /**
   * Get a private endpoint connection.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("PrivateEndpointConnections_GetByHostPool")
  getByHostPool is PrivateEndpointConnectionWithSystemDataOperationGroupOps.Read<PrivateEndpointConnectionWithSystemData>;

  /**
   * Approve or reject a private endpoint connection.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "For backward compatibility"
  @operationId("PrivateEndpointConnections_UpdateByHostPool")
  updateByHostPool is PrivateEndpointConnectionWithSystemDataOperationGroupOps.CreateOrUpdateSync<
    PrivateEndpointConnectionWithSystemData,
    Response = ArmResourceUpdatedResponse<PrivateEndpointConnectionWithSystemData>
  >;

  /**
   * Remove a connection.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("PrivateEndpointConnections_DeleteByHostPool")
  deleteByHostPool is PrivateEndpointConnectionWithSystemDataOperationGroupOps.DeleteSync<PrivateEndpointConnectionWithSystemData>;

  /**
   * List private endpoint connections associated with hostpool.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("PrivateEndpointConnections_ListByHostPool")
  listByHostPool is PrivateEndpointConnectionWithSystemDataOperationGroupOps.List<
    PrivateEndpointConnectionWithSystemData,
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
    Response = ArmResponse<PrivateEndpointConnectionListResultWithSystemData>
  >;
}

@@doc(PrivateEndpointConnectionWithSystemData.name,
  "The name of the private endpoint connection associated with the Azure resource."
);
@@doc(PrivateEndpointConnections.updateByWorkspace::parameters.resource,
  "Object containing the updated connection."
);
@@doc(PrivateEndpointConnectionWithSystemDataOperationGroup.updateByHostPool::parameters.resource,
  "Object containing the updated connection."
);

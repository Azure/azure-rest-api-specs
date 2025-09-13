import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./HostPool.tsp";
import "./Workspace.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;

namespace Microsoft.DesktopVirtualization;
/**
 * The Private Endpoint Connection resource.
 */
model PrivateEndpointConnectionWithSystemData
  is Azure.ResourceManager.ProxyResource<PrivateEndpointConnectionProperties> {
  ...ResourceNameParameter<Resource = PrivateEndpointConnectionWithSystemData>;
}

alias PrivateEndpointParameter = {
  /** The name parameter for private endpoint */
  @path
  @segment("privateEndpointConnections")
  @key
  privateEndpointConnectionName: string;
};

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Existing usage of legacy type"
@armResourceOperations
interface HostPoolOps
  extends Azure.ResourceManager.Legacy.LegacyOperations<
      ParentParameters = ResourceInstanceParameters<HostPool>,
      ResourceTypeParameter = PrivateEndpointParameter
    > {}

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Existing usage of legacy type"
@armResourceOperations
interface WorkspaceOps
  extends Azure.ResourceManager.Legacy.LegacyOperations<
      ParentParameters = ResourceInstanceParameters<Workspace>,
      ResourceTypeParameter = PrivateEndpointParameter
    > {}

@armResourceOperations
interface CustomPrivateEndpointConnection {
  getByHostPool is HostPoolOps.Read<PrivateEndpointConnectionWithSystemData>;

  /**
   * Approve or reject a private endpoint connection.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "Existing usage of status code"
  updateByHostPool is HostPoolOps.CreateOrUpdateSync<
    PrivateEndpointConnectionWithSystemData,
    Response = ArmResourceUpdatedResponse<PrivateEndpointConnectionWithSystemData>
  >;

  deleteByHostPool is HostPoolOps.DeleteSync<PrivateEndpointConnectionWithSystemData>;

  /**
   * List private endpoint connections associated with hostpool.
   */
  @segment("privateEndpointConnections")
  listByHostPool is HostPoolOps.List<
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
    Response = PrivateEndpointConnectionListResultWithSystemData
  >;

  getByWorkspace is WorkspaceOps.Read<PrivateEndpointConnectionWithSystemData>;

  /**
   * Approve or reject a private endpoint connection.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "Existing usage of status code"
  updateByWorkspace is WorkspaceOps.CreateOrUpdateSync<
    PrivateEndpointConnectionWithSystemData,
    Response = ArmResourceUpdatedResponse<PrivateEndpointConnectionWithSystemData>
  >;

  deleteByWorkspace is WorkspaceOps.DeleteSync<PrivateEndpointConnectionWithSystemData>;

  /**
   * List private endpoint connections associated with Workspace.
   */
  @segment("privateEndpointConnections")
  listByWorkspace is WorkspaceOps.List<
    PrivateEndpointConnectionWithSystemData,
    Response = PrivateEndpointConnectionListResultWithSystemData
  >;
}

import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./HostPool.tsp";
import "./Workspace.tsp";
import "./LegacyOperations.tsp";

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

@armResourceOperations
interface HostPoolOps
  extends Azure.ResourceManager.Legacy.LegacyOperations<
      ParentParameters = ResourceInstanceParameters<HostPool>,
      ResourceTypeParameter = PrivateEndpointParameter
    > {}

@armResourceOperations
interface WorkspaceOps
  extends Azure.ResourceManager.Legacy.LegacyOperations<
      ParentParameters = ResourceInstanceParameters<Workspace>,
      ResourceTypeParameter = PrivateEndpointParameter
    > {}

@armResourceOperations
interface CustomPrivateEndpointConnection {
  getByHostPool is HostPoolOps.Read<PrivateEndpointConnectionWithSystemData>;
  updateByHostPool is HostPoolOps.CreateOrUpdateSync<PrivateEndpointConnectionWithSystemData>;
  deleteByHostPool is HostPoolOps.DeleteSync<PrivateEndpointConnectionWithSystemData>;
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
  updateByWorkspace is WorkspaceOps.CreateOrUpdateSync<PrivateEndpointConnectionWithSystemData>;
  deleteByWorkspace is WorkspaceOps.DeleteSync<PrivateEndpointConnectionWithSystemData>;
  @segment("privateEndpointConnections")
  listByWorkspace is WorkspaceOps.List<
    PrivateEndpointConnectionWithSystemData,
    Response = PrivateEndpointConnectionListResultWithSystemData
  >;
}

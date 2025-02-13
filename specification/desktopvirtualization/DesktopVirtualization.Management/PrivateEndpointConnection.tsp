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
using TypeSpec.OpenAPI;

namespace Microsoft.DesktopVirtualization;
/**
 * The Private Endpoint Connection resource.
 */
model PrivateEndpointConnections
  is Azure.ResourceManager.ProxyResource<PrivateEndpointConnectionProperties> {
  ...ResourceNameParameter<Resource = PrivateEndpointConnections>;
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
  getByHostPool is HostPoolOps.Read<PrivateEndpointConnections>;
  updateByHostPool is HostPoolOps.CreateOrUpdateSync<PrivateEndpointConnections>;
  deleteByHostPool is HostPoolOps.DeleteSync<PrivateEndpointConnections>;
  listByHostPool is HostPoolOps.List<
    PrivateEndpointConnections,
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
    }
  >;
  getByWorkspace is WorkspaceOps.Read<PrivateEndpointConnections>;
  updateByWorkspace is WorkspaceOps.CreateOrUpdateSync<PrivateEndpointConnections>;
  deleteByWorkspace is WorkspaceOps.DeleteSync<PrivateEndpointConnections>;
  listByWorkspace is WorkspaceOps.List<PrivateEndpointConnections>;
}

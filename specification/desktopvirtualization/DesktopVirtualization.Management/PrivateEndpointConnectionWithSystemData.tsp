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
model PrivateEndpointConnectionWithSystemData
  is Azure.ResourceManager.TrackedResource<PrivateEndpointConnectionProperties> {
  ...ResourceNameParameter<Resource = PrivateEndpointConnection>;
  ...ManagedServiceIdentityProperty;
  ...EntityTagProperty;
  ...ResourceKindProperty;
  ...ManagedByProperty;
  ...ResourcePlanProperty;
  ...ResourceSkuProperty;
}

alias PrivateEndpointParameter = {
  /** The name parameter for private endpoint */
  @path
  @segment("privateEndpointConnections")
  @key
  privateEndpointConnectionName: string;
};

alias PrivateEndpointListParameter = {
  /**
   * The number of items to return per page
   */
  @query
  pageSize?: int32;

  /**
   * The number of items to skip before starting to return items.
   */
  @query
  initialSkip?: int32;

  /**
   * Indicates whether the collection is descending.
   */
  @query
  isDescending?: boolean;
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
interface HostPoolPrivateEndpointConnectionOperations {
  getByHostPool is HostPoolOps.Read<PrivateEndpointConnection>;
  updateByHostPool is HostPoolOps.CreateOrUpdateSync<PrivateEndpointConnection>;
  deleteByHostPool is HostPoolOps.DeleteSync<PrivateEndpointConnection>;
  @action("hostPool")
  listByHostPool is HostPoolOps.List<
    PrivateEndpointConnection,
    Parameters = PrivateEndpointListParameter
  >;
}

@armResourceOperations
interface WorkspacePrivateEndpointConnectionOperations {
  getByWorkspace is WorkspaceOps.Read<PrivateEndpointConnection>;
  updateByWorkspace is WorkspaceOps.CreateOrUpdateSync<PrivateEndpointConnection>;
  deleteByWorkspace is WorkspaceOps.DeleteSync<PrivateEndpointConnection>;
  @action("workspace")
  listByWorkspace is WorkspaceOps.List<
    PrivateEndpointConnection,
    Parameters = PrivateEndpointListParameter
  >;
}

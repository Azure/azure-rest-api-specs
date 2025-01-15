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
model CustomPrivateEndpointConnection
  is Azure.ResourceManager.TrackedResource<PrivateEndpointConnectionProperties> {
  ...ResourceNameParameter<Resource = CustomPrivateEndpointConnection>;
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
  @segment("PrivateEndpointConnections")
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
interface PrivateEndpointConnections {
  getByHostPool is HostPoolOps.Read<CustomPrivateEndpointConnection>;
  updateByHostPool is HostPoolOps.CreateOrUpdateSync<CustomPrivateEndpointConnection>;
  deleteByHostPool is HostPoolOps.DeleteSync<CustomPrivateEndpointConnection>;
  listByHostPool is HostPoolOps.List<
    CustomPrivateEndpointConnection,
    Parameters = PrivateEndpointListParameter
  >;
  getByWorkspace is WorkspaceOps.Read<CustomPrivateEndpointConnection>;
  updateByWorkspace is WorkspaceOps.CreateOrUpdateSync<CustomPrivateEndpointConnection>;
  deleteByWorkspace is WorkspaceOps.DeleteSync<CustomPrivateEndpointConnection>;
  listByWorkspace is WorkspaceOps.List<
    CustomPrivateEndpointConnection,
    Parameters = PrivateEndpointListParameter
  >;
}

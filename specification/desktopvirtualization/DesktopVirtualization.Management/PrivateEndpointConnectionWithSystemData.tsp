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
  is TrackedResource<PrivateEndpointConnectionProperties> {
  ...ResourceNameParameter<Resource = PrivateEndpointConnection>;
}

alias PrivateEndpointParameter = {
  /** The name parameter for private endpoint */
  @path
  @segment("privateEndpointConnections")
  privateEndpointName: string;
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
  listByHostPool is HostPoolOps.List<PrivateEndpointConnection>;
}

@armResourceOperations
interface WorkspacePrivateEndpointConnectionOperations {
  getByWorkspace is WorkspaceOps.Read<PrivateEndpointConnection>;
  updateByWorkspace is WorkspaceOps.CreateOrUpdateSync<PrivateEndpointConnection>;
  deleteByWorkspace is WorkspaceOps.DeleteSync<PrivateEndpointConnection>;
  listByWorkspace is WorkspaceOps.List<PrivateEndpointConnection>;
}

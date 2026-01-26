import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "@typespec/versioning";
import "./workspace.tsp";

using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;
using TypeSpec.Http;

namespace Microsoft.Discovery;

/**
 * The Private Endpoint Connection resource for Workspace.
 */
@added(Versions.v2026_02_01_preview)
@parentResource(Workspace)
model WorkspacePrivateEndpointConnection
  is Azure.ResourceManager.ProxyResource<Azure.ResourceManager.CommonTypes.PrivateEndpointConnectionProperties> {
  ...PrivateEndpointConnectionParameter;
}

@added(Versions.v2026_02_01_preview)
@armResourceOperations
interface WorkspacePrivateEndpointConnections {
  /**
   * Gets the specified private endpoint connection associated with the workspace.
   */
  get is ArmResourceRead<WorkspacePrivateEndpointConnection>;

  /**
   * Approves or updates the specified private endpoint connection.
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<WorkspacePrivateEndpointConnection>;

  /**
   * Deletes the specified private endpoint connection.
   */
  delete is ArmResourceDeleteWithoutOkAsync<WorkspacePrivateEndpointConnection>;

  /**
   * Lists all private endpoint connections for a workspace.
   */
  listByWorkspace is ArmResourceListByParent<WorkspacePrivateEndpointConnection>;
}

@@pattern(PrivateEndpointConnectionParameter.name, "^[a-z][a-zA-Z0-9]*");
@@minLength(PrivateEndpointConnectionParameter.name, 3);
@@maxLength(PrivateEndpointConnectionParameter.name, 63);

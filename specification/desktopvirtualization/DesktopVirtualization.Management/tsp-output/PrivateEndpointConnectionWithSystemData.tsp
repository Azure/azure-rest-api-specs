import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Workspace.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.DesktopVirtualization;
// FIXME: PrivateEndpointConnectionWithSystemData has no properties property
/**
 * The Private Endpoint Connection resource.
 */
@parentResource(Workspace)
model PrivateEndpointConnectionWithSystemData is ProxyResource<{}> {
  /**
   * The name of the private endpoint connection associated with the Azure resource
   */
  @path
  @key("privateEndpointConnectionName")
  @segment("privateEndpointConnections")
  @visibility("read")
  name: string;
}

@armResourceOperations
@projectedName("client", "PrivateEndpointConnectionWithSystemData")
interface PrivateEndpointConnectionWithSystemDataOperationGroup {
  /**
   * Get a private endpoint connection.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("PrivateEndpointConnections_GetByWorkspace")
  getByWorkspace is ArmResourceRead<PrivateEndpointConnectionWithSystemData>;

  /**
   * Approve or reject a private endpoint connection.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("PrivateEndpointConnections_UpdateByWorkspace")
  updateByWorkspace is ArmResourceCreateOrReplaceSync<PrivateEndpointConnectionWithSystemData>;

  /**
   * Remove a connection.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("PrivateEndpointConnections_DeleteByWorkspace")
  deleteByWorkspace is ArmResourceDeleteSync<PrivateEndpointConnectionWithSystemData>;

  /**
   * List private endpoint connections.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("PrivateEndpointConnections_ListByWorkspace")
  listByWorkspace is ArmResourceListByParent<PrivateEndpointConnectionWithSystemData>;
}

@@projectedName(PrivateEndpointConnectionWithSystemDataOperationGroup.updateByWorkspace::parameters.resource,
  "json",
  "connection"
);
@@extension(PrivateEndpointConnectionWithSystemDataOperationGroup.updateByWorkspace::parameters.resource,
  "x-ms-client-name",
  "connection"
);
@@doc(PrivateEndpointConnectionWithSystemDataOperationGroup.updateByWorkspace::parameters.resource,
  "Object containing the updated connection."
);

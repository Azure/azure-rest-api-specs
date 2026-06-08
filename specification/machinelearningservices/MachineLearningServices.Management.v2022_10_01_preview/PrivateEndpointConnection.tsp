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

namespace Microsoft.MachineLearningServices;
/**
 * The Private Endpoint Connection resource.
 */
@parentResource(Workspace)
model PrivateEndpointConnection
  is Azure.ResourceManager.Legacy.TrackedResourceWithOptionalLocation<PrivateEndpointConnectionProperties> {
  ...ResourceNameParameter<
    Resource = PrivateEndpointConnection,
    KeyName = "privateEndpointConnectionName",
    SegmentName = "privateEndpointConnections",
    NamePattern = ""
  >;
  ...Azure.ResourceManager.ManagedServiceIdentityProperty;
  ...Azure.ResourceManager.ResourceSkuProperty;
}

@armResourceOperations
interface PrivateEndpointConnections {
  /**
   * Gets the specified private endpoint connection associated with the workspace.
   */
  get is ArmResourceRead<PrivateEndpointConnection>;

  /**
   * Update the state of specified private endpoint connection associated with the workspace.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "For backward compatibility"
  createOrUpdate is ArmResourceCreateOrReplaceSync<
    PrivateEndpointConnection,
    Response = ArmResourceUpdatedResponse<PrivateEndpointConnection>
  >;

  /**
   * Deletes the specified private endpoint connection associated with the workspace.
   */
  delete is ArmResourceDeleteSync<PrivateEndpointConnection>;

  /**
   * List all the private endpoint connections associated with the workspace.
   */
  list is ArmResourceListByParent<
    PrivateEndpointConnection,
    Response = ArmResponse<PrivateEndpointConnectionListResult>
  >;
}

@@doc(
  PrivateEndpointConnection.name,
  "The name of the private endpoint connection associated with the workspace"
);
@@doc(PrivateEndpointConnection.properties, "Resource properties.");
@@doc(
  PrivateEndpointConnections.createOrUpdate::parameters.resource,
  "The private endpoint connection properties."
);

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

namespace Microsoft.Databricks;
/**
 * The private endpoint connection of a workspace.
 */
@parentResource(Workspace)
model PrivateEndpointConnection
  is Azure.ResourceManager.ProxyResource<
    PrivateEndpointConnectionProperties,
    false
  > {
  ...ResourceNameParameter<
    Resource = PrivateEndpointConnection,
    KeyName = "privateEndpointConnectionName",
    SegmentName = "privateEndpointConnections",
    NamePattern = ""
  >;
}

@armResourceOperations
interface PrivateEndpointConnections {
  /**
   * Get a private endpoint connection properties for a workspace
   */
  get is ArmResourceRead<PrivateEndpointConnection>;

  /**
   * Update the status of a private endpoint connection with the specified name
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "For backward compatibility"
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "For backward compatibility"
  create is ArmResourceCreateOrReplaceAsync<
    PrivateEndpointConnection,
    Response = ArmResourceUpdatedResponse<PrivateEndpointConnection> | (ArmAcceptedLroResponse & {
      @bodyRoot
      _: PrivateEndpointConnection;
    }),
    LroHeaders = ArmLroLocationHeader<FinalResult = PrivateEndpointConnection> &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Remove private endpoint connection with the specified name
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  delete is ArmResourceDeleteWithoutOkAsync<
    PrivateEndpointConnection,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse
  >;

  /**
   * List private endpoint connections of the workspace
   */
  list is ArmResourceListByParent<
    PrivateEndpointConnection,
    Response = ArmResponse<PrivateEndpointConnectionsList>
  >;
}

@@doc(PrivateEndpointConnection.name,
  "The name of the private endpoint connection"
);
@@doc(PrivateEndpointConnection.properties,
  "The private endpoint connection properties."
);
@@doc(PrivateEndpointConnections.create::parameters.resource,
  "The private endpoint connection with updated properties"
);

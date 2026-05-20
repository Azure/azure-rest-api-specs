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

@armResourceOperations(#{ omitTags: true })
interface PrivateEndpointConnections {
  /**
   * Get a private endpoint connection properties for a workspace
   */
  @tag("PrivateEndpointConnections")
  @summary("Get private endpoint connection")
  get is ArmResourceRead<PrivateEndpointConnection, Error = ErrorResponse>;

  /**
   * Update the status of a private endpoint connection with the specified name
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "For backward compatibility"
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "For backward compatibility"
  @tag("PUT")
  @tag("PrivateEndpointConnections")
  @summary("Update private endpoint connection status")
  create is ArmResourceCreateOrReplaceAsync<
    PrivateEndpointConnection,
    Response = ArmResourceUpdatedResponse<PrivateEndpointConnection> | (ArmAcceptedLroResponse<LroHeaders = ArmLroLocationHeader<FinalResult = PrivateEndpointConnection> &
      Azure.Core.Foundations.RetryAfterHeader> & {
      @bodyRoot
      _: PrivateEndpointConnection;
    }),
    Error = ErrorResponse
  >;

  /**
   * Remove private endpoint connection with the specified name
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  @tag("DELETE")
  @tag("PrivateEndpointConnections")
  @summary("Remove private endpoint connection")
  delete is ArmResourceDeleteWithoutOkAsync<
    PrivateEndpointConnection,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse,
    Error = ErrorResponse
  >;

  /**
   * List private endpoint connections of the workspace
   */
  @tag("PrivateEndpointConnections")
  @summary("List private endpoint connections")
  list is ArmResourceListByParent<
    PrivateEndpointConnection,
    Response = ArmResponse<PrivateEndpointConnectionsList>,
    Error = ErrorResponse
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

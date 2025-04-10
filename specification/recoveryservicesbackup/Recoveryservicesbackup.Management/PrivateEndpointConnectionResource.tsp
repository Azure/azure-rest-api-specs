import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.RecoveryServices;
/**
 * Private Endpoint Connection Response Properties
 */
model PrivateEndpointConnectionResource
  is Azure.ResourceManager.TrackedResource<PrivateEndpointConnection> {
  ...ResourceNameParameter<
    Resource = PrivateEndpointConnectionResource,
    KeyName = "privateEndpointConnectionName",
    SegmentName = "privateEndpointConnections",
    NamePattern = ""
  >;
}

@armResourceOperations
interface PrivateEndpointConnectionResources {
  /**
   * Get Private Endpoint Connection. This call is made by Backup Admin.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("PrivateEndpointConnection_Get")
  get is ArmResourceRead<PrivateEndpointConnectionResource>;

  /**
   * Approve or Reject Private Endpoint requests. This call is made by Backup Admin.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("PrivateEndpointConnection_Put")
  put is ArmResourceCreateOrReplaceAsync<
    PrivateEndpointConnectionResource,
    LroHeaders = ArmLroLocationHeader & Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Delete Private Endpoint requests. This call is made by Backup Admin.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  @operationId("PrivateEndpointConnection_Delete")
  delete is ArmResourceDeleteWithoutOkAsync<
    PrivateEndpointConnectionResource,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse
  >;

  /**
   * Gets the operation status for a private endpoint connection.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @get
  @action("{operationId}")
  @operationId("PrivateEndpoint_GetOperationStatus")
  getOperationStatus is ArmResourceActionSync<
    PrivateEndpointConnectionResource,
    void,
    ArmResponse<OperationStatus>,
    Parameters = {
      /**
       * Operation id
       */
      @path
      operationId: string;
    }
  >;
}

@@doc(PrivateEndpointConnectionResource.name,
  "The name of the private endpoint connection."
);
@@doc(PrivateEndpointConnectionResource.properties,
  "PrivateEndpointConnectionResource properties"
);
@@doc(PrivateEndpointConnectionResources.put::parameters.resource,
  "Request body for operation"
);

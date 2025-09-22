import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./BatchAccount.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Batch;
/**
 * Contains information about a private link resource.
 */
@parentResource(BatchAccount)
model PrivateEndpointConnection
  is Azure.ResourceManager.ProxyResource<PrivateEndpointConnectionProperties> {
  ...ResourceNameParameter<
    Resource = PrivateEndpointConnection,
    KeyName = "privateEndpointConnectionName",
    SegmentName = "privateEndpointConnections",
    NamePattern = "^[a-zA-Z0-9_-]+\\.?[a-fA-F0-9-]*$"
  >;
}

@armResourceOperations
interface PrivateEndpointConnections {
  /**
   * Gets information about the specified private endpoint connection.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("PrivateEndpointConnection_Get")
  get is ArmResourceRead<PrivateEndpointConnection>;

  /**
   * Updates the properties of an existing private endpoint connection.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("PrivateEndpointConnection_Update")
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchAsync<
    PrivateEndpointConnection,
    PatchModel = PrivateEndpointConnection,
    Parameters = {
      /**
       * The state (ETag) version of the private endpoint connection to update. This value can be omitted or set to "*" to apply the operation unconditionally.
       */
      @header
      `If-Match`?: string;
    },
    LroHeaders = ArmAsyncOperationHeader &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Deletes the specified private endpoint connection.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/lro-location-header" "For backward compatibility"
  @operationId("PrivateEndpointConnection_Delete")
  delete is ArmResourceDeleteWithoutOkAsync<
    PrivateEndpointConnection,
    LroHeaders = ArmAsyncOperationHeader &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Lists all of the private endpoint connections in the specified account.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("PrivateEndpointConnection_ListByBatchAccount")
  listByBatchAccount is ArmResourceListByParent<
    PrivateEndpointConnection,
    Parameters = {
      /**
       * The maximum number of items to return in the response.
       */
      @query("maxresults")
      maxresults?: int32;
    },
    Response = ArmResponse<ListPrivateEndpointConnectionsResult>
  >;
}

@@maxLength(PrivateEndpointConnection.name, 101);
@@minLength(PrivateEndpointConnection.name, 1);
@@doc(PrivateEndpointConnection.name,
  "The private endpoint connection name. This must be unique within the account."
);
@@doc(PrivateEndpointConnection.properties,
  "The properties associated with the private endpoint connection."
);
@@doc(PrivateEndpointConnections.update::parameters.properties,
  "PrivateEndpointConnection properties that should be updated. Properties that are supplied will be updated, any property not supplied will be unchanged."
);

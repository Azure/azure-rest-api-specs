import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Account.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Purview;
/**
 * A private endpoint connection class.
 */
@parentResource(Account)
model PrivateEndpointConnection
  is Azure.ResourceManager.ProxyResource<PrivateEndpointConnectionProperties> {
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
   * Get a private endpoint connection
   */
  @summary("Gets private endpoint connection information.")
  get is ArmResourceRead<PrivateEndpointConnection, Error = ErrorResponseModel>;

  /**
   * Create or update a private endpoint connection
   */
  @summary("Approves/Rejects private endpoint connection request.")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    PrivateEndpointConnection,
    LroHeaders = ArmLroLocationHeader<FinalResult = PrivateEndpointConnection> &
      Azure.Core.Foundations.RetryAfterHeader,
    Error = ErrorResponseModel
  >;

  /**
   * Delete a private endpoint connection
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @summary("Deletes private endpoint connection.")
  delete is ArmResourceDeleteWithoutOkAsync<
    PrivateEndpointConnection,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse,
    Error = ErrorResponseModel
  >;

  /**
   * Get private endpoint connections for account
   */
  @summary("Gets private endpoint connections.")
  listByAccount is ArmResourceListByParent<
    PrivateEndpointConnection,
    Parameters = {
      /**
       * The skip token.
       */
      @query("$skipToken")
      $skipToken?: string;
    },
    Response = ArmResponse<PrivateEndpointConnectionList>,
    Error = ErrorResponseModel
  >;
}

@@doc(PrivateEndpointConnection.name,
  "Name of the private endpoint connection."
);
@@doc(PrivateEndpointConnection.properties, "The connection identifier.");
@@doc(PrivateEndpointConnections.createOrUpdate::parameters.resource,
  "The request."
);

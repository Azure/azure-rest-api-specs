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
  get is ArmResourceRead<PrivateEndpointConnection>;

  /**
   * Create or update a private endpoint connection
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    PrivateEndpointConnection,
    LroHeaders = ArmLroLocationHeader<FinalResult = PrivateEndpointConnection> &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Delete a private endpoint connection
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  delete is ArmResourceDeleteWithoutOkAsync<
    PrivateEndpointConnection,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse
  >;

  /**
   * Get private endpoint connections for account
   */
  listByAccount is ArmResourceListByParent<
    PrivateEndpointConnection,
    Parameters = {
      /**
       * The skip token.
       */
      @query("$skipToken")
      $skipToken?: string;
    },
    Response = ArmResponse<PrivateEndpointConnectionList>
  >;
}

@@doc(PrivateEndpointConnection.name,
  "Name of the private endpoint connection."
);
@@doc(PrivateEndpointConnection.properties, "The connection identifier.");
@@doc(PrivateEndpointConnections.createOrUpdate::parameters.resource,
  "The request."
);

import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./MapsAccount.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Maps;
/**
 * The private endpoint connection resource.
 */
model PrivateEndpointConnection is PrivateEndpointConnectionResource;
alias PrivateEndpointOperations = PrivateEndpoints<PrivateEndpointConnection>;

@armResourceOperations
interface PrivateEndpointConnections {
  /**
   * Gets the specified private endpoint connection associated with the Maps Account.
   */
  get is PrivateEndpointOperations.Read<MapsAccount, PrivateEndpointConnection>;

  /**
   * Create or update the state of specified private endpoint connection associated with the Maps account.
   */
  create is PrivateEndpointOperations.CreateOrReplaceAsync<
    MapsAccount,
    PrivateEndpointConnection,
    LroHeaders = ArmAsyncOperationHeader<FinalResult = PrivateEndpointConnection> &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Deletes the specified private endpoint connection associated with the Maps Account.
   */
  delete is PrivateEndpointOperations.DeleteAsync<
    MapsAccount,
    PrivateEndpointConnection,
    LroHeaders = ArmCombinedLroHeaders & Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Get a private endpoint connections on the Maps Account.
   */
  listByAccount is PrivateEndpointOperations.ListByParent<
    MapsAccount,
    PrivateEndpointConnection,
    Response = ArmResponse<PrivateEndpointConnectionList>
  >;
}

@@maxLength(CommonTypes.PrivateEndpointConnection.name, 98);
@@minLength(CommonTypes.PrivateEndpointConnection.name, 3);
@@pattern(CommonTypes.PrivateEndpointConnection.name, "^[^%&:\\\\/#?]+$");

@@doc(PrivateEndpointConnection.properties, "Resource properties.");
@@doc(PrivateEndpointConnections.create::parameters.resource,
  "The private endpoint connection properties."
);

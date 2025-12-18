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

alias PrivateEndpointConnectionOps = Azure.ResourceManager.Legacy.LegacyOperations<
  {
    ...ApiVersionParameter;
    ...SubscriptionIdParameter;
    ...ResourceGroupParameter;
    ...Azure.ResourceManager.Legacy.Provider;

    /** Name of the Maps Account */
    @path
    @minLength(1)
    @segment("accounts")
    @pattern("^[^%&:\\\\/#?]+$")
    accountName: string;
  },
  {
    /** Name of the private endpoint connection */
    @path
    @minLength(3)
    @maxLength(98)
    @pattern("^[^%&:\\\\/#?]+$")
    @segment("privateEndpointConnections")
    privateEndpointConnectionName: string;
  }
>;

@armResourceOperations
interface PrivateEndpointConnections {
  /**
   * Gets the specified private endpoint connection associated with the Maps Account.
   */
  get is PrivateEndpointConnectionOps.Read<
    PrivateEndpointConnection,
    Response = PrivateEndpointConnection
  >;

  /**
   * Create or update the state of specified private endpoint connection associated with the Maps account.
   */
  #suppress "@azure-tools/typespec-azure-core/invalid-final-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @Azure.Core.useFinalStateVia("location")
  create is PrivateEndpointConnectionOps.CreateOrUpdateAsync<
    PrivateEndpointConnection,
    Response = PrivateEndpointConnection | ArmCreatedResponse<
      PrivateEndpointConnection,
      ExtraHeaders = ArmAsyncOperationHeader &
        Azure.Core.Foundations.RetryAfterHeader
    >,
    OverrideErrorType = ErrorResponse,
    Request = PrivateEndpointConnection
  >;

  /**
   * Deletes the specified private endpoint connection associated with the Maps Account.
   */
  delete is PrivateEndpointConnectionOps.DeleteWithoutOkAsync<
    PrivateEndpointConnection,
    Response = ArmNoContentResponse<"Resource does not exist."> | ArmAcceptedResponse<ExtraHeaders = ArmAsyncOperationHeader &
      Azure.Core.Foundations.RetryAfterHeader &
      ArmLroLocationHeader> | ErrorResponse
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

@@doc(PrivateEndpointConnection.properties, "Resource properties.");
@@doc(PrivateEndpointConnections.create::parameters.resource,
  "The private endpoint connection properties."
);

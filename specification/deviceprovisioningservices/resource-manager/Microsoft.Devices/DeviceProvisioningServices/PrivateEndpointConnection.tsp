import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;

namespace Microsoft.Devices;
/**
 * The private endpoint connection of a provisioning service
 */
@parentResource(ProvisioningServiceDescription)
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

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "This is a helper interface defining legacy operation signatures with a custom path parameter (resourceName). The @armResourceOperations decorator is applied to the PrivateEndpointConnections interface that consumes these operations."
interface PrivateEndpointConnectionsOps
  extends Azure.ResourceManager.Legacy.LegacyOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
        ...ResourceGroupParameter,
        ...Azure.ResourceManager.Legacy.Provider,

        /**
         * Name of the provisioning service to retrieve.
         */
        @path
        @segment("provisioningServices")
        resourceName: string,
      },
      {
        /**
         * The name of the private endpoint connection
         */
        @path
        @segment("privateEndpointConnections")
        privateEndpointConnectionName: string,
      },
      ErrorDetails
    > {}

@armResourceOperations
interface PrivateEndpointConnections {
  /**
   * Get private endpoint connection properties
   */
  getPrivateEndpointConnection is PrivateEndpointConnectionsOps.Read<PrivateEndpointConnection>;

  /**
   * Create or update the status of a private endpoint connection with the specified name
   */
  createOrUpdatePrivateEndpointConnection is PrivateEndpointConnectionsOps.CreateOrUpdateAsync<
    PrivateEndpointConnection,
    LroHeaders = ArmLroLocationHeader<FinalResult = PrivateEndpointConnection> &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Delete private endpoint connection with the specified name
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "The existing API returns 200, 202, and 204 for delete which differs from the standard ARM delete response codes. Keeping for backward compatibility."
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "The existing API returns the PrivateEndpointConnection resource in the 200 and 202 delete response bodies. Keeping for backward compatibility."
  deletePrivateEndpointConnection is PrivateEndpointConnectionsOps.DeleteWithoutOkAsync<
    PrivateEndpointConnection,
    Response = ArmResponse<PrivateEndpointConnection> | (ArmDeleteAcceptedLroResponse<LroHeaders = ArmLroLocationHeader<FinalResult = PrivateEndpointConnection> &
      Azure.Core.Foundations.RetryAfterHeader> & {
      @bodyRoot
      _: PrivateEndpointConnection;
    }) | ArmDeletedNoContentResponse
  >;

  /**
   * List private endpoint connection properties
   */
  listPrivateEndpointConnections is PrivateEndpointConnectionsOps.ListSinglePage<
    PrivateEndpointConnection,
    Response = ArmResponse<PrivateEndpointConnectionsList>
  >;
}

@@doc(PrivateEndpointConnection.name,
  "The name of the private endpoint connection"
);
@@doc(PrivateEndpointConnection.properties,
  "The properties of a private endpoint connection"
);
@@doc(PrivateEndpointConnections.createOrUpdatePrivateEndpointConnection::parameters.resource,
  "The private endpoint connection with updated properties"
);

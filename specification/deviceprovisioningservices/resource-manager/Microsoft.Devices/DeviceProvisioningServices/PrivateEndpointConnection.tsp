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

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
      {},
      ErrorDetails
    > {}

@armResourceOperations
interface PrivateEndpointConnections {
  /**
   * Get private endpoint connection properties
   */
  getPrivateEndpointConnection is PrivateEndpointConnectionsOps.Read<
    PrivateEndpointConnection,
    Parameters = {
      /**
       * The name of the private endpoint connection
       */
      @path
      @segment("privateEndpointConnections")
      privateEndpointConnectionName: string;
    },
    Response = ArmResponse<PrivateEndpointConnection>
  >;

  /**
   * Create or update the status of a private endpoint connection with the specified name
   */
  createOrUpdatePrivateEndpointConnection is PrivateEndpointConnectionsOps.CreateOrUpdateAsync<
    PrivateEndpointConnection,
    Parameters = {
      /**
       * The name of the private endpoint connection
       */
      @path
      @segment("privateEndpointConnections")
      privateEndpointConnectionName: string;
    },
    LroHeaders = ArmLroLocationHeader<FinalResult = PrivateEndpointConnection> &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Delete private endpoint connection with the specified name
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  deletePrivateEndpointConnection is PrivateEndpointConnectionsOps.DeleteWithoutOkAsync<
    PrivateEndpointConnection,
    Parameters = {
      /**
       * The name of the private endpoint connection
       */
      @path
      @segment("privateEndpointConnections")
      privateEndpointConnectionName: string;
    },
    Response = ArmResponse<PrivateEndpointConnection> | (ArmDeleteAcceptedLroResponse<LroHeaders = ArmLroLocationHeader<FinalResult = PrivateEndpointConnection> &
      Azure.Core.Foundations.RetryAfterHeader> & {
      @bodyRoot
      _: PrivateEndpointConnection;
    }) | ArmDeletedNoContentResponse
  >;

  /**
   * List private endpoint connection properties
   */
  @action("privateEndpointConnections")
  @get
  listPrivateEndpointConnections is ArmProviderActionSync<
    void,
    ArmResponse<PrivateEndpointConnectionsList>,
    {},
    {
      /** Name of the provisioning service to retrieve. */
      @path @segment("provisioningServices") resourceName: string;
    },
    ErrorDetails
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

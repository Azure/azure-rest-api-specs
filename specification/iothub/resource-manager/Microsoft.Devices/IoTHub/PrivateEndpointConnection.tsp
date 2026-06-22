import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./GroupIdInformation.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Devices;
/**
 * The private endpoint connection of an IotHub
 */
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

alias PrivateEndpointConnectionOps = Azure.ResourceManager.Legacy.LegacyOperations<
  {
    ...ApiVersionParameter;
    ...SubscriptionIdParameter;
    ...ResourceGroupParameter;
    ...Azure.ResourceManager.Legacy.Provider;

    /** The name of the IoT Hub */
    @path
    @key
    @segment("iotHubs")
    resourceName: string;
  },
  {
    /** The name of the private endpoint connection */
    @path
    @key
    @segment("privateEndpointConnections")
    privateEndpointConnectionName: string;
  },
  ErrorType = ErrorDetails
>;

@armResourceOperations(#{ omitTags: true })
interface PrivateEndpointConnections {
  /**
   * Get private endpoint connection properties
   */
  @summary("Get private endpoint connection")
  @tag("GET")
  get is PrivateEndpointConnectionOps.Read<PrivateEndpointConnection>;

  /**
   * Update the status of a private endpoint connection with the specified name
   */
  #suppress "@azure-tools/typespec-azure-core/invalid-final-state" "Final-state-via location is retained to match the published LRO behavior of this update operation."
  @summary("Update private endpoint connection")
  @tag("PUT")
  @Azure.Core.useFinalStateVia("location")
  update is PrivateEndpointConnectionOps.CreateOrUpdateAsync<
    PrivateEndpointConnection,
    LroHeaders = ArmAsyncOperationHeader<FinalResult = PrivateEndpointConnection> &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Delete private endpoint connection with the specified name
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "Delete response codes match the published API contract and are retained for backward compatibility."
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "The published API returns the deleted private endpoint connection in the body of the synchronous (200) delete response; retained to preserve backward compatibility."
  @summary("Delete private endpoint connection")
  @tag("DELETE")
  delete is PrivateEndpointConnectionOps.DeleteWithoutOkAsync<
    PrivateEndpointConnection,
    Response =
      | ArmResponse<PrivateEndpointConnection>
      | (ArmDeleteAcceptedLroResponse<ArmCombinedLroHeaders<FinalResult = PrivateEndpointConnection> &
          Azure.Core.Foundations.RetryAfterHeader> & {
          @bodyRoot
          _: PrivateEndpointConnection;
        })
      | ArmDeletedNoContentResponse
  >;

  /**
   * List private endpoint connection properties
   */
  @summary("List private endpoint connections")
  @tag("GET")
  list is PrivateEndpointConnectionOps.ListSinglePage<
    PrivateEndpointConnection,
    Response = ArmResponse<PrivateEndpointConnection[]>
  >;
}

@@doc(
  PrivateEndpointConnection.name,
  "The name of the private endpoint connection"
);
@@doc(
  PrivateEndpointConnection.properties,
  "The properties of a private endpoint connection"
);
@@doc(
  PrivateEndpointConnections.update::parameters.resource,
  "The private endpoint connection with updated properties"
);

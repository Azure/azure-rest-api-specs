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
@parentResource(IotHubDescriptionLowerCase)
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
   * Get private endpoint connection properties
   */
  @summary("Get private endpoint connection")
  @tag("GET")
  get is ArmResourceRead<PrivateEndpointConnection, Error = ErrorDetails>;

  /**
   * Update the status of a private endpoint connection with the specified name
   */
  #suppress "@azure-tools/typespec-azure-core/invalid-final-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @summary("Update private endpoint connection")
  @tag("PUT")
  @Azure.Core.useFinalStateVia("location")
  update is ArmResourceCreateOrReplaceAsync<
    PrivateEndpointConnection,
    LroHeaders = ArmAsyncOperationHeader<FinalResult = PrivateEndpointConnection> &
      Azure.Core.Foundations.RetryAfterHeader,
    Error = ErrorDetails
  >;

  /**
   * Delete private endpoint connection with the specified name
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @summary("Delete private endpoint connection")
  @tag("DELETE")
  delete is ArmResourceDeleteWithoutOkAsync<
    PrivateEndpointConnection,
    Response = ArmResponse<PrivateEndpointConnection> | (ArmDeleteAcceptedLroResponse<ArmCombinedLroHeaders<FinalResult = PrivateEndpointConnection> &
      Azure.Core.Foundations.RetryAfterHeader> & {
      @bodyRoot
      _: PrivateEndpointConnection;
    }) | ArmDeletedNoContentResponse,
    Error = ErrorDetails
  >;

  /**
   * List private endpoint connection properties
   */
  @summary("List private endpoint connections")
  @tag("GET")
  list is Azure.ResourceManager.Legacy.ArmListSinglePageByParent<
    PrivateEndpointConnection,
    Response = ArmResponse<PrivateEndpointConnection[]>,
    Error = ErrorDetails
  >;
}

@@doc(PrivateEndpointConnection.name,
  "The name of the private endpoint connection"
);
@@doc(PrivateEndpointConnection.properties,
  "The properties of a private endpoint connection"
);
@@doc(PrivateEndpointConnections.update::parameters.resource,
  "The private endpoint connection with updated properties"
);

import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./ApplicationGateway.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Network;
/**
 * Private Endpoint connection on an application gateway.
 */
#suppress "@azure-tools/typespec-azure-core/no-private-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-custom-resource-usage-discourage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.applicationGateway)
@parentResource(ApplicationGateway)
@Http.Private.includeInapplicableMetadataInPayload(false)
model ApplicationGatewayPrivateEndpointConnection extends SubResourceModel {
  properties?: ApplicationGatewayPrivateEndpointConnectionProperties;

  @visibility(Lifecycle.Read)
  @path
  @key("connectionName")
  @segment("privateEndpointConnections")
  name: string;

  /** A unique read-only string that changes whenever the resource is updated. */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  etag?: string;
}

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.applicationGateway)
@armResourceOperations
interface ApplicationGatewayPrivateEndpointConnections {
  /**
   * Gets the specified private endpoint connection on application gateway.
   */
  get is ArmResourceRead<
    ApplicationGatewayPrivateEndpointConnection,
    Error = CloudError
  >;

  /**
   * Updates the specified private endpoint connection on application gateway.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/lro-location-header" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  update is ArmResourceCreateOrReplaceAsync<
    ApplicationGatewayPrivateEndpointConnection,
    Response = ArmResourceUpdatedResponse<ApplicationGatewayPrivateEndpointConnection> | (ArmAcceptedLroResponse<LroHeaders = ArmAsyncOperationHeader> &
      Azure.Core.Foundations.RetryAfterHeader),
    Error = CloudError
  >;

  /**
   * Deletes the specified private endpoint connection on application gateway.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  delete is ArmResourceDeleteWithoutOkAsync<
    ApplicationGatewayPrivateEndpointConnection,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse,
    Error = CloudError
  >;

  /**
   * Lists all private endpoint connections on an application gateway.
   */
  list is ArmResourceListByParent<
    ApplicationGatewayPrivateEndpointConnection,
    Error = CloudError
  >;
}

@@doc(ApplicationGatewayPrivateEndpointConnection.name,
  "Name of the private endpoint connection on an application gateway."
);
@@doc(ApplicationGatewayPrivateEndpointConnection.properties,
  "Properties of the application gateway private endpoint connection."
);
@@doc(ApplicationGatewayPrivateEndpointConnections.update::parameters.resource,
  "Parameters supplied to update application gateway private endpoint connection operation."
);

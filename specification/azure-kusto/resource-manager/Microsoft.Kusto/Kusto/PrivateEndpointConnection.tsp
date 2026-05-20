import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Cluster.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Kusto;
/**
 * A private endpoint connection
 */
@parentResource(Cluster)
model PrivateEndpointConnection
  is Azure.ResourceManager.ProxyResource<PrivateEndpointConnectionProperties> {
  ...ResourceNameParameter<
    Resource = PrivateEndpointConnection,
    KeyName = "privateEndpointConnectionName",
    SegmentName = "privateEndpointConnections",
    NamePattern = "^.*$"
  >;
}

@armResourceOperations
interface PrivateEndpointConnections {
  /**
   * Gets a private endpoint connection.
   */
  get is ArmResourceRead<PrivateEndpointConnection>;

  /**
   * Approve or reject a private endpoint connection with a given name.
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    PrivateEndpointConnection,
    LroHeaders = ArmLroLocationHeader<FinalResult = PrivateEndpointConnection> &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Deletes a private endpoint connection with a given name.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  delete is ArmResourceDeleteWithoutOkAsync<
    PrivateEndpointConnection,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse<LroHeaders = ArmLroLocationHeader &
      ArmAsyncOperationHeader &
      Azure.Core.Foundations.RetryAfterHeader> | ArmDeletedNoContentResponse
  >;

  /**
   * Returns the list of private endpoint connections.
   */
  list is ArmResourceListByParent<
    PrivateEndpointConnection,
    Response = ArmResponse<PrivateEndpointConnectionListResult>
  >;
}

@@doc(PrivateEndpointConnection.name,
  "The name of the private endpoint connection."
);
@@doc(PrivateEndpointConnection.properties, "Resource properties.");
@@doc(PrivateEndpointConnections.createOrUpdate::parameters.resource, "");

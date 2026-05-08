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

namespace Microsoft.HDInsight;
/**
 * The private endpoint connection.
 */
@parentResource(Cluster)
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

@armResourceOperations
interface PrivateEndpointConnections {
  /**
   * Gets the specific private endpoint connection.
   */
  get is ArmResourceRead<PrivateEndpointConnection, Error = ErrorResponse>;

  /**
   * Approve or reject a private endpoint connection manually.
   */
  #suppress "@azure-tools/typespec-azure-core/invalid-final-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @Azure.Core.useFinalStateVia("azure-async-operation")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    PrivateEndpointConnection,
    LroHeaders = ArmLroLocationHeader<FinalResult = PrivateEndpointConnection> &
      Azure.Core.Foundations.RetryAfterHeader,
    Error = ErrorResponse
  >;

  /**
   * Deletes the specific private endpoint connection.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/lro-location-header" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  delete is ArmResourceDeleteWithoutOkAsync<
    PrivateEndpointConnection,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse<ArmAsyncOperationHeader &
      Azure.Core.Foundations.RetryAfterHeader> | ArmDeletedNoContentResponse,
    Error = ErrorResponse
  >;

  /**
   * Lists the private endpoint connections for a HDInsight cluster.
   */
  listByCluster is ArmResourceListByParent<
    PrivateEndpointConnection,
    Error = ErrorResponse
  >;
}

@@doc(PrivateEndpointConnection.name,
  "The name of the private endpoint connection."
);
@@doc(PrivateEndpointConnection.properties,
  "The private endpoint connection properties."
);
@@doc(PrivateEndpointConnections.createOrUpdate::parameters.resource,
  "The private endpoint connection create or update request."
);

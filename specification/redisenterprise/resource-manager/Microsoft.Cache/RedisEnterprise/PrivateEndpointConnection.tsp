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

namespace Microsoft.Cache;
/**
 * The Private Endpoint Connection resource.
 */
model PrivateEndpointConnection is PrivateEndpointConnectionResource;
alias PrivateEndpointOperations = PrivateEndpoints<PrivateEndpointConnection>;

@armResourceOperations
interface PrivateEndpointConnections {
  /**
   * Gets the specified private endpoint connection associated with the Redis Enterprise cluster.
   */
  get is PrivateEndpointOperations.Read<Cluster, PrivateEndpointConnection>;

  /**
   * Updates the state of the specified private endpoint connection associated with the Redis Enterprise cluster.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  put is PrivateEndpointOperations.CreateOrReplaceAsync<
    Cluster,
    PrivateEndpointConnection,
    Response = ArmResourceCreatedResponse<
      PrivateEndpointConnection,
      ArmLroLocationHeader<FinalResult = PrivateEndpointConnection> &
        Azure.Core.Foundations.RetryAfterHeader
    >
  >;

  /**
   * Deletes the specified private endpoint connection associated with the Redis Enterprise cluster.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  delete is PrivateEndpointOperations.DeleteAsync<
    Cluster,
    PrivateEndpointConnection,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse<LroHeaders = ArmCombinedLroHeaders> | ArmDeletedNoContentResponse
  >;

  /**
   * Lists all the private endpoint connections associated with the Redis Enterprise cluster.
   */
  list is PrivateEndpointOperations.ListByParent<
    Cluster,
    PrivateEndpointConnection
  >;
}

@@doc(PrivateEndpointConnection.properties, "Resource properties.");
@@doc(PrivateEndpointConnections.put::parameters.resource,
  "The private endpoint connection properties."
);

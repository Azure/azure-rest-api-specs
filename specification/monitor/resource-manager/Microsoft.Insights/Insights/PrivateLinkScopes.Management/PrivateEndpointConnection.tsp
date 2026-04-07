import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./AzureMonitorPrivateLinkScope.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Insights;
/**
 * The Private Endpoint Connection resource.
 */
model PrivateEndpointConnection is PrivateEndpointConnectionResource;
alias PrivateEndpointOperations = PrivateEndpoints<PrivateEndpointConnection>;

@armResourceOperations
interface PrivateEndpointConnections {
  /**
   * Gets a private endpoint connection.
   */
  get is PrivateEndpointOperations.Read<
    AzureMonitorPrivateLinkScope,
    PrivateEndpointConnection
  >;

  /**
   * Approve or reject a private endpoint connection with a given name.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "For backward compatibility"
  createOrUpdate is PrivateEndpointOperations.CreateOrReplaceAsync<
    AzureMonitorPrivateLinkScope,
    PrivateEndpointConnection,
    Response = ArmResourceUpdatedResponse<Azure.ResourceManager.CommonTypes.PrivateEndpointConnection> | ArmAcceptedLroResponse<LroHeaders = ArmLroLocationHeader<FinalResult = PrivateEndpointConnection> &
      Azure.Core.Foundations.RetryAfterHeader>
  >;

  /**
   * Deletes a private endpoint connection with a given name.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  delete is PrivateEndpointOperations.DeleteAsync<
    AzureMonitorPrivateLinkScope,
    PrivateEndpointConnection,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse
  >;

  /**
   * Gets all private endpoint connections on a private link scope.
   */
  listByPrivateLinkScope is PrivateEndpointOperations.ListByParent<
    AzureMonitorPrivateLinkScope,
    PrivateEndpointConnection,
    Response = ArmResponse<Azure.ResourceManager.CommonTypes.PrivateEndpointConnectionListResultV5>
  >;
}

@@doc(PrivateEndpointConnection.properties, "Resource properties.");
@@doc(PrivateEndpointConnections.createOrUpdate::parameters.resource, "");

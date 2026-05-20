import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Server.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using Azure.ResourceManager.Legacy;

namespace Microsoft.DBforMySQL;

model PrivateEndpointConnection is PrivateEndpointConnectionResource;
alias PrivateEndpointOperations = Azure.ResourceManager.PrivateEndpoints<PrivateEndpointConnection>;

@armResourceOperations
interface PrivateEndpointConnections {
  /**
   * Gets a private endpoint connection.
   */
  get is PrivateEndpointOperations.Read<Server>;

  /**
   * Approve or reject a private endpoint connection with a given name.
   */
  #suppress "@azure-tools/typespec-azure-core/invalid-final-state" "Fixme: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "Fixme: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @Azure.Core.useFinalStateVia("azure-async-operation")
  createOrUpdate is PrivateEndpointOperations.CreateOrUpdateAsync<
    Server,
    Response = ArmResourceUpdatedResponse<PrivateEndpointConnection> | ArmResourceCreatedResponse<PrivateEndpointConnection> | ArmAcceptedLroResponse<LroHeaders = ArmLroLocationHeader<FinalResult = PrivateEndpointConnection> &
      Azure.Core.Foundations.RetryAfterHeader>
  >;

  /**
   * Deletes a private endpoint connection with a given name.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "Fixme: Update justification, follow aka.ms/tsp/conversion-fix for details"
  delete is PrivateEndpointOperations.DeleteAsync<
    Server,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse
  >;

  /**
   * Gets all private endpoint connections on a server.
   */
  listByServer is Azure.ResourceManager.Legacy.PrivateEndpoints.ListSinglePageByParent<
    Server,
    PrivateEndpointConnection
  >;
}

@@doc(PrivateEndpointConnection.properties, "Resource properties.");

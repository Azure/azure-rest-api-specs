import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Cluster.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;

namespace Microsoft.DBforPostgreSQL;

model PrivateEndpointConnection is PrivateEndpointConnectionResource;
alias PrivateEndpointOperations = PrivateEndpoints<PrivateEndpointConnection>;

@armResourceOperations
interface PrivateEndpointConnections {
  /**
   * Gets private endpoint connection.
   */
  get is PrivateEndpointOperations.Read<Cluster>;

  /**
   * Approves or Rejects a private endpoint connection with a given name.
   */
  @Azure.Core.useFinalStateVia("azure-async-operation")
  createOrUpdate is PrivateEndpointOperations.CreateOrReplaceAsync<
    Cluster,
    LroHeaders = ArmAsyncOperationHeader<FinalResult = PrivateEndpointConnection> &
      ArmLroLocationHeader<FinalResult = PrivateEndpointConnection>
  >;

  /**
   * Deletes a private endpoint connection with a given name.
   */
  @Azure.Core.useFinalStateVia("location")
  delete is PrivateEndpointOperations.DeleteAsync<
    Cluster,
    LroHeaders = ArmAsyncOperationHeader & ArmLroLocationHeader
  >;

  /**
   * Gets list of private endpoint connections on a cluster.
   */
  listByCluster is PrivateEndpointOperations.ListByParent<Cluster>;
}

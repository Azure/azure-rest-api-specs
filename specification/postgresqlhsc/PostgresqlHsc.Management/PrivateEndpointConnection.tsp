import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Cluster.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;

namespace Microsoft.DBforPostgreSQL;
/**
 * The private endpoint connection resource.
 */
@parentResource(Cluster)
model PrivateEndpointConnection
  is Azure.ResourceManager.ProxyResource<PrivateEndpointConnectionProperties> {
  ...ResourceNameParameter<
    Resource = PrivateEndpointConnection,
    KeyName = "privateEndpointConnectionName",
    SegmentName = "privateEndpointConnections",
    NamePattern = "^[-\\w\\._]+$"
  >;
}

@armResourceOperations
interface PrivateEndpointConnections {
  /**
   * Gets private endpoint connection.
   */
  get is ArmResourceRead<PrivateEndpointConnection>;

  /**
   * Approves or Rejects a private endpoint connection with a given name.
   */
  @Azure.Core.useFinalStateVia("azure-async-operation")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    PrivateEndpointConnection,
    LroHeaders = ArmAsyncOperationHeader<FinalResult = PrivateEndpointConnection> &
      ArmLroLocationHeader<FinalResult = PrivateEndpointConnection>
  >;

  /**
   * Deletes a private endpoint connection with a given name.
   */
  @Azure.Core.useFinalStateVia("location")
  delete is ArmResourceDeleteWithoutOkAsync<
    PrivateEndpointConnection,
    LroHeaders = ArmAsyncOperationHeader & ArmLroLocationHeader
  >;

  /**
   * Gets list of private endpoint connections on a cluster.
   */
  listByCluster is ArmResourceListByParent<
    PrivateEndpointConnection,
    Response = ArmResponse<ResourceListResult<PrivateEndpointConnection>>
  >;
}

@@doc(PrivateEndpointConnection.name,
  "The name of the private endpoint connection associated with the cluster."
);
@@doc(PrivateEndpointConnection.properties, "Resource properties.");
@@doc(PrivateEndpointConnections.createOrUpdate::parameters.resource,
  "The required parameters for approving a private endpoint connection."
);

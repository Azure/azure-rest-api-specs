import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./ManagedCluster.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;

namespace Microsoft.ContainerService;
/**
 * A private endpoint connection
 */
@parentResource(ManagedCluster)
model PrivateEndpointConnection
  is Azure.ResourceManager.ProxyResource<PrivateEndpointConnectionProperties> {
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
   * To learn more about private clusters, see: https://docs.microsoft.com/azure/aks/private-clusters
   */
  @summary("Gets the specified private endpoint connection.")
  get is ArmResourceRead<PrivateEndpointConnection>;

  /**
   * Updates a private endpoint connection.
   */
  update is ArmResourceCreateOrReplaceSync<PrivateEndpointConnection>;

  /**
   * Deletes a private endpoint connection.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  delete is ArmResourceDeleteWithoutOkAsync<
    PrivateEndpointConnection,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse<ArmLroLocationHeader &
      Azure.Core.Foundations.RetryAfterHeader> | ArmDeletedNoContentResponse
  >;

  /**
   * To learn more about private clusters, see: https://docs.microsoft.com/azure/aks/private-clusters
   */
  @summary("Gets a list of private endpoint connections in the specified managed cluster.")
  list is PrivateEndpointConnectionsOps.ListSinglePage<
    PrivateEndpointConnection,
    Response = ArmResponse<PrivateEndpointConnectionListResult>
  >;
}

@armResourceOperations
interface PrivateEndpointConnectionsOps
  extends Azure.ResourceManager.Legacy.LegacyOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
        ...ResourceGroupParameter,
        ...Azure.ResourceManager.Legacy.Provider,
        ...ParentKeysOf<PrivateEndpointConnection>,
      },
      {
        ...ResourceNameParameter<
          Resource = PrivateEndpointConnection,
          KeyName = "privateEndpointConnectionName",
          SegmentName = "privateEndpointConnections",
          NamePattern = ""
        >,
      }
    > {}

@@doc(PrivateEndpointConnection.name,
  "The name of the private endpoint connection."
);
@@doc(PrivateEndpointConnection.properties,
  "The properties of a private endpoint connection."
);
@@doc(PrivateEndpointConnections.update::parameters.resource,
  "The updated private endpoint connection."
);

import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./CommonModels.tsp";
import "./ManagedCluster.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;

namespace Microsoft.ContainerService;

// =============================================================================
// PrivateEndpointConnection resource and operations
// =============================================================================

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

@@doc(PrivateEndpointConnection.name,
  "The name of the private endpoint connection."
);
@@doc(PrivateEndpointConnection.properties,
  "The properties of a private endpoint connection."
);
@@doc(PrivateEndpointConnections.update::parameters.resource,
  "The updated private endpoint connection."
);

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

// =============================================================================
// PrivateEndpointConnection models
// =============================================================================

/**
 * The current provisioning state.
 */
union PrivateEndpointConnectionProvisioningState {
  string,

  /** Private endpoint connection provisioning was canceled. */
  Canceled: "Canceled",

  /** Private endpoint connection is being created. */
  Creating: "Creating",

  /** Private endpoint connection is being deleted. */
  Deleting: "Deleting",

  /** Private endpoint connection provisioning failed. */
  Failed: "Failed",

  /** Private endpoint connection provisioning succeeded. */
  Succeeded: "Succeeded",
}

/**
 * The private link service connection status.
 */
union ConnectionStatus {
  string,

  /** Connection is pending approval. */
  Pending: "Pending",

  /** Connection is approved. */
  Approved: "Approved",

  /** Connection is rejected. */
  Rejected: "Rejected",

  /** Connection is disconnected. */
  Disconnected: "Disconnected",
}

/**
 * Properties of a private endpoint connection.
 */
model PrivateEndpointConnectionProperties {
  /**
   * The current provisioning state.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: PrivateEndpointConnectionProvisioningState;

  /**
   * The resource of private endpoint.
   */
  privateEndpoint?: PrivateEndpoint;

  /**
   * A collection of information about the state of the connection between service consumer and provider.
   */
  privateLinkServiceConnectionState: PrivateLinkServiceConnectionState;
}

/**
 * Private endpoint which a connection belongs to.
 */
model PrivateEndpoint {
  /**
   * The resource ID of the private endpoint
   */
  id?: string;
}

/**
 * A list of private endpoint connections
 */
model PrivateEndpointConnectionListResult {
  /**
   * The collection value.
   */
  @pageItems
  value?: PrivateEndpointConnection[];
}

/**
 * The state of a private link service connection.
 */
model PrivateLinkServiceConnectionState {
  /**
   * The private link service connection status.
   */
  status?: ConnectionStatus;

  /**
   * The private link service connection description.
   */
  description?: string;
}

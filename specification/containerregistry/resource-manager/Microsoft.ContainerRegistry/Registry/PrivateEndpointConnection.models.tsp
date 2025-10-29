namespace Microsoft.ContainerRegistry;

/**
 * The private link service connection status.
 */
union ConnectionStatus {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Approved: "Approved",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Pending: "Pending",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Rejected: "Rejected",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Disconnected: "Disconnected",
}

/**
 * A message indicating if changes on the service provider require any updates on the consumer.
 */
union ActionsRequired {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  None: "None",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Recreate: "Recreate",
}

/**
 * The properties of a private endpoint connection.
 */
model PrivateEndpointConnectionProperties {
  /**
   * The resource of private endpoint.
   */
  privateEndpoint?: PrivateEndpoint;

  /**
   * A collection of information about the state of the connection between service consumer and provider.
   */
  privateLinkServiceConnectionState?: PrivateLinkServiceConnectionState;

  /**
   * The provisioning state of private endpoint connection resource.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

/**
 * The Private Endpoint resource.
 */
model PrivateEndpoint {
  /**
   * This is private endpoint resource created with Microsoft.Network resource provider.
   */
  id?: string;
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
   * The description for connection status. For example if connection is rejected it can indicate reason for rejection.
   */
  description?: string;

  /**
   * A message indicating if changes on the service provider require any updates on the consumer.
   */
  actionsRequired?: ActionsRequired;
}

/**
 * The result of a request to list private endpoint connections for a container registry.
 */
model PrivateEndpointConnectionListResult {
  /**
   * The list of private endpoint connections. Since this list may be incomplete, the nextLink field should be used to request the next list of private endpoint connections.
   */
  @pageItems
  value?: PrivateEndpointConnection[];

  /**
   * The URI that can be used to request the next list of private endpoint connections.
   */
  @nextLink
  nextLink?: string;
}

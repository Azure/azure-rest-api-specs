namespace Microsoft.ContainerRegistry;

/**
 * The properties of a replication.
 */
model ReplicationProperties {
  /**
   * The provisioning state of the replication at the time the operation was called.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  /**
   * The status of the replication at the time the operation was called.
   */
  @visibility(Lifecycle.Read)
  status?: Status;

  /**
   * Specifies whether the replication's regional endpoint is enabled. Requests will not be routed to a replication whose regional endpoint is disabled, however its data will continue to be synced with other replications.
   */
  regionEndpointEnabled?: boolean = true;

  /**
   * Whether or not zone redundancy is enabled for this container registry replication
   */
  zoneRedundancy?: ZoneRedundancy = ZoneRedundancy.Disabled;
}

/**
 * The parameters for updating a replication.
 */
model ReplicationUpdateParameters {
  /**
   * The tags for the replication.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  tags?: Record<string>;

  /**
   * The parameters for updating a replication's properties
   */
  #suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @Azure.ClientGenerator.Core.Legacy.flattenProperty
  properties?: ReplicationUpdateParametersProperties;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model ReplicationUpdateParametersProperties {
  /**
   * Specifies whether the replication's regional endpoint is enabled. Requests will not be routed to a replication whose regional endpoint is disabled, however its data will continue to be synced with other replications.
   */
  regionEndpointEnabled?: boolean;
}

/**
 * The result of a request to list replications for a container registry.
 */
model ReplicationListResult {
  /**
   * The list of replications. Since this list may be incomplete, the nextLink field should be used to request the next list of replications.
   */
  @pageItems
  value?: Replication[];

  /**
   * The URI that can be used to request the next list of replications.
   */
  @nextLink
  nextLink?: string;
}

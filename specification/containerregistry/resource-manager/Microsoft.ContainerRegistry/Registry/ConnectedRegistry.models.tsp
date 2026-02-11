namespace Microsoft.ContainerRegistry;

using Azure.ResourceManager;

/**
 * The mode of the connected registry resource that indicates the permissions of the registry.
 */
union ConnectedRegistryMode {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  ReadWrite: "ReadWrite",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  ReadOnly: "ReadOnly",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Registry: "Registry",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Mirror: "Mirror",
}

/**
 * The current connection state of the connected registry.
 */
union ConnectionState {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Online: "Online",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Offline: "Offline",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Syncing: "Syncing",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Unhealthy: "Unhealthy",
}

/**
 * The activation status of the connected registry.
 */
union ActivationStatus {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Active: "Active",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Inactive: "Inactive",
}

/**
 * Indicates whether HTTPS is enabled for the login server.
 */
union TlsStatus {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Enabled: "Enabled",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Disabled: "Disabled",
}

/**
 * The type of certificate location.
 */
union CertificateType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  LocalDirectory: "LocalDirectory",
}

/**
 * The verbosity of logs persisted on the connected registry.
 */
union LogLevel {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Debug: "Debug",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Information: "Information",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Warning: "Warning",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Error: "Error",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  None: "None",
}

/**
 * Indicates whether audit logs are enabled on the connected registry.
 */
union AuditLogStatus {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Enabled: "Enabled",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Disabled: "Disabled",
}

/**
 * The properties of a connected registry.
 */
model ConnectedRegistryProperties {
  /**
   * Provisioning state of the resource.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  /**
   * The mode of the connected registry resource that indicates the permissions of the registry.
   */
  mode: ConnectedRegistryMode;

  /**
   * The current version of ACR runtime on the connected registry.
   */
  @visibility(Lifecycle.Read)
  version?: string;

  /**
   * The current connection state of the connected registry.
   */
  @visibility(Lifecycle.Read)
  connectionState?: ConnectionState;

  /**
   * The last activity time of the connected registry.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastActivityTime?: utcDateTime;

  /**
   * The activation properties of the connected registry.
   */
  @visibility(Lifecycle.Read)
  activation?: ActivationProperties;

  /**
   * The parent of the connected registry.
   */
  parent: ParentProperties;

  /**
   * The list of the ACR token resource IDs used to authenticate clients to the connected registry.
   */
  clientTokenIds?: string[];

  /**
   * The login server properties of the connected registry.
   */
  loginServer?: LoginServerProperties;

  /**
   * The logging properties of the connected registry.
   */
  logging?: LoggingProperties;

  /**
   * The list of current statuses of the connected registry.
   */
  @visibility(Lifecycle.Read)
  @identifiers(#["correlationId"])
  statusDetails?: StatusDetailProperties[];

  /**
   * The list of notifications subscription information for the connected registry.
   */
  notificationsList?: string[];

  /**
   * The garbage collection properties of the connected registry.
   */
  garbageCollection?: GarbageCollectionProperties;
}

/**
 * The activation properties of the connected registry.
 */
model ActivationProperties {
  /**
   * The activation status of the connected registry.
   */
  @visibility(Lifecycle.Read)
  status?: ActivationStatus;
}

/**
 * The properties of the connected registry parent.
 */
model ParentProperties {
  /**
   * The resource ID of the parent to which the connected registry will be associated.
   */
  id?: Azure.Core.armResourceIdentifier;

  /**
   * The sync properties of the connected registry with its parent.
   */
  syncProperties: SyncProperties;
}

/**
 * The sync properties of the connected registry with its parent.
 */
model SyncProperties {
  /**
   * The resource ID of the ACR token used to authenticate the connected registry to its parent during sync.
   */
  tokenId: string;

  /**
   * The cron expression indicating the schedule that the connected registry will sync with its parent.
   */
  schedule?: string;

  /**
   * The time window during which sync is enabled for each schedule occurrence. Specify the duration using the format P[n]Y[n]M[n]DT[n]H[n]M[n]S as per ISO8601.
   */
  syncWindow?: duration;

  /**
   * The period of time for which a message is available to sync before it is expired. Specify the duration using the format P[n]Y[n]M[n]DT[n]H[n]M[n]S as per ISO8601.
   */
  messageTtl: duration;

  /**
   * The last time a sync occurred between the connected registry and its parent.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastSyncTime?: utcDateTime;

  /**
   * The gateway endpoint used by the connected registry to communicate with its parent.
   */
  @visibility(Lifecycle.Read)
  gatewayEndpoint?: string;
}

/**
 * The login server properties of the connected registry.
 */
model LoginServerProperties {
  /**
   * The host of the connected registry. Can be FQDN or IP.
   */
  @visibility(Lifecycle.Read)
  host?: string;

  /**
   * The TLS properties of the connected registry login server.
   */
  @visibility(Lifecycle.Read)
  tls?: TlsProperties;
}

/**
 * The TLS properties of the connected registry login server.
 */
model TlsProperties {
  /**
   * Indicates whether HTTPS is enabled for the login server.
   */
  @visibility(Lifecycle.Read)
  status?: TlsStatus;

  /**
   * The certificate used to configure HTTPS for the login server.
   */
  @visibility(Lifecycle.Read)
  certificate?: TlsCertificateProperties;
}

/**
 * The TLS certificate properties of the connected registry login server.
 */
model TlsCertificateProperties {
  /**
   * The type of certificate location.
   */
  @visibility(Lifecycle.Read)
  type?: CertificateType;

  /**
   * Indicates the location of the certificates.
   */
  @visibility(Lifecycle.Read)
  location?: string;
}

/**
 * The logging properties of the connected registry.
 */
model LoggingProperties {
  /**
   * The verbosity of logs persisted on the connected registry.
   */
  logLevel?: LogLevel = LogLevel.Information;

  /**
   * Indicates whether audit logs are enabled on the connected registry.
   */
  auditLogStatus?: AuditLogStatus = AuditLogStatus.Disabled;
}

/**
 * The status detail properties of the connected registry.
 */
model StatusDetailProperties {
  /**
   * The component of the connected registry corresponding to the status.
   */
  @visibility(Lifecycle.Read)
  type?: string;

  /**
   * The HTTP status code.
   */
  @visibility(Lifecycle.Read)
  code?: string;

  /**
   * The description of the status.
   */
  @visibility(Lifecycle.Read)
  description?: string;

  /**
   * The timestamp of the status.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  timestamp?: utcDateTime;

  /**
   * The correlation ID of the status.
   */
  @visibility(Lifecycle.Read)
  correlationId?: string;
}

/**
 * The garbage collection properties of the connected registry.
 */
model GarbageCollectionProperties {
  /**
   * Indicates whether garbage collection is enabled for the connected registry.
   */
  enabled?: boolean;

  /**
   * The cron expression indicating the schedule that the connected registry will run garbage collection.
   */
  schedule?: string;
}

/**
 * The parameters for updating a connected registry.
 */
model ConnectedRegistryUpdateParameters {
  /**
   * The properties of the connected registry update parameters.
   */
  #suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @Azure.ClientGenerator.Core.Legacy.flattenProperty
  properties?: ConnectedRegistryUpdateProperties;
}

/**
 * The parameters for updating token properties.
 */
model ConnectedRegistryUpdateProperties {
  /**
   * The sync properties of the connected registry with its parent.
   */
  syncProperties?: SyncUpdateProperties;

  /**
   * The logging properties of the connected registry.
   */
  logging?: LoggingProperties;

  /**
   * The list of the ACR token resource IDs used to authenticate clients to the connected registry.
   */
  clientTokenIds?: string[];

  /**
   * The list of notifications subscription information for the connected registry.
   */
  notificationsList?: string[];

  /**
   * The garbage collection properties of the connected registry.
   */
  garbageCollection?: GarbageCollectionProperties;
}

/**
 * The parameters for updating the sync properties of the connected registry with its parent.
 */
model SyncUpdateProperties {
  /**
   * The cron expression indicating the schedule that the connected registry will sync with its parent.
   */
  schedule?: string;

  /**
   * The time window during which sync is enabled for each schedule occurrence. Specify the duration using the format P[n]Y[n]M[n]DT[n]H[n]M[n]S as per ISO8601.
   */
  syncWindow?: duration;

  /**
   * The period of time for which a message is available to sync before it is expired. Specify the duration using the format P[n]Y[n]M[n]DT[n]H[n]M[n]S as per ISO8601.
   */
  messageTtl?: duration;
}

/**
 * The result of a request to list connected registries for a container registry.
 */
model ConnectedRegistryListResult {
  /**
   * The list of connected registries. Since this list may be incomplete, the nextLink field should be used to request the next list of connected registries.
   */
  @pageItems
  value?: ConnectedRegistry[];

  /**
   * The URI that can be used to request the next list of connected registries.
   */
  @nextLink
  nextLink?: string;
}

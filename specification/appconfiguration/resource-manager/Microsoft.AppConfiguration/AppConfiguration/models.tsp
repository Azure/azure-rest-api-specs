import "@typespec/rest";
import "@typespec/http";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Versioning;
using Azure.ResourceManager;

namespace Microsoft.AppConfiguration;

/**
 * The type of managed identity used. The type 'SystemAssigned, UserAssigned' includes both an implicitly created identity and a set of user-assigned identities. The type 'None' will remove any identities.
 */
union IdentityType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  None: "None",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  SystemAssigned: "SystemAssigned",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  UserAssigned: "UserAssigned",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  `SystemAssigned, UserAssigned`: "SystemAssigned, UserAssigned",
}

/**
 * The provisioning state of the configuration store.
 */
union ProvisioningState {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Creating: "Creating",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Updating: "Updating",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Deleting: "Deleting",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Succeeded: "Succeeded",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Failed: "Failed",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Canceled: "Canceled",
}

/**
 * The private link service connection status.
 */
union ConnectionStatus {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Pending: "Pending",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Approved: "Approved",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Rejected: "Rejected",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Disconnected: "Disconnected",
}

/**
 * Any action that is required beyond basic workflow (approve/ reject/ disconnect)
 */
union ActionsRequired {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  None: "None",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Recreate: "Recreate",
}

/**
 * Control permission for data plane traffic coming from public networks while private endpoint is enabled.
 */
union PublicNetworkAccess {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Enabled: "Enabled",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Disabled: "Disabled",
}

/**
 * The data plane proxy authentication mode. This property manages the authentication mode of request to the data plane resources.
 */
union AuthenticationMode {
  string,

  /**
   * The local authentication mode. Users are not required to have data plane permissions if local authentication is not disabled.
   */
  Local: "Local",

  /**
   * The pass-through authentication mode. User identity will be passed through from ARM, requiring user to have data plane action permissions (Available via App Configuration Data Owner/ App Configuration Data Reader).
   */
  `Pass-through`: "Pass-through",
}

/**
 * The data plane proxy private link delegation. This property manages if a request from delegated ARM private link is allowed when the data plane resource requires private link.
 */
union PrivateLinkDelegation {
  string,

  /**
   * ARM private endpoint is required if the resource requires private link.
   */
  Enabled: "Enabled",

  /**
   * Request is denied if the resource requires private link.
   */
  Disabled: "Disabled",
}

/**
 * The type of identity that created the resource.
 */
union CreatedByType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  User: "User",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Application: "Application",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  ManagedIdentity: "ManagedIdentity",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Key: "Key",
}

/**
 * The resource type to check for name availability.
 */
union ConfigurationResourceType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  `Microsoft.AppConfiguration/configurationStores`: "Microsoft.AppConfiguration/configurationStores",
}

/**
 * The provisioning state of the replica.
 */
union ReplicaProvisioningState {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Creating: "Creating",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Succeeded: "Succeeded",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Deleting: "Deleting",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Failed: "Failed",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Canceled: "Canceled",
}

/**
 * The current status of the snapshot.
 */
union SnapshotStatus {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Provisioning: "Provisioning",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Ready: "Ready",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Archived: "Archived",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Failed: "Failed",
}

/**
 * The composition type describes how the key-values within the snapshot are composed. The 'key' composition type ensures there are no two key-values containing the same key. The 'key_label' composition type ensures there are no two key-values containing the same key and label.
 */
union CompositionType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Key: "Key",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Key_Label: "Key_Label",
}

/**
 * Indicates whether the configuration store need to be recovered.
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "For backward compatibility"
enum CreateMode {
  Recover,
  Default,
}

/**
 * An identity that can be associated with a resource.
 */
model ResourceIdentity {
  /**
   * The type of managed identity used. The type 'SystemAssigned, UserAssigned' includes both an implicitly created identity and a set of user-assigned identities. The type 'None' will remove any identities.
   */
  type?: IdentityType;

  /**
   * The list of user-assigned identities associated with the resource. The user-assigned identity dictionary keys will be ARM resource ids in the form: '/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ManagedIdentity/userAssignedIdentities/{identityName}'.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  userAssignedIdentities?: Record<UserIdentity>;

  /**
   * The principal id of the identity. This property will only be provided for a system-assigned identity.
   */
  @visibility(Lifecycle.Read)
  principalId?: string;

  /**
   * The tenant id associated with the resource's identity. This property will only be provided for a system-assigned identity.
   */
  @visibility(Lifecycle.Read)
  tenantId?: string;
}

/**
 * A resource identity that is managed by the user of the service.
 */
model UserIdentity {
  /**
   * The principal ID of the user-assigned identity.
   */
  @visibility(Lifecycle.Read)
  principalId?: string;

  /**
   * The client ID of the user-assigned identity.
   */
  @visibility(Lifecycle.Read)
  clientId?: string;
}

/**
 * The properties of a configuration store.
 */
model ConfigurationStoreProperties {
  /**
   * The provisioning state of the configuration store.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  /**
   * The creation date of configuration store.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  creationDate?: utcDateTime;

  /**
   * The DNS endpoint where the configuration store API will be available.
   */
  @visibility(Lifecycle.Read)
  endpoint?: string;

  /**
   * The encryption settings of the configuration store.
   */
  encryption?: EncryptionProperties;

  /**
   * The list of private endpoint connections that are set up for this resource.
   */
  @visibility(Lifecycle.Read)
  privateEndpointConnections?: PrivateEndpointConnectionReference[];

  /**
   * Control permission for data plane traffic coming from public networks while private endpoint is enabled.
   */
  publicNetworkAccess?: PublicNetworkAccess;

  /**
   * Disables all authentication methods other than AAD authentication.
   */
  disableLocalAuth?: boolean = false;

  /**
   * The amount of time in days that the configuration store will be retained when it is soft deleted.
   */
  softDeleteRetentionInDays?: int32 = 7;

  /**
   * The duration in seconds to retain new key value revisions. Defaults to 604800 (7 days) for Free SKU stores and 2592000 (30 days) for Standard SKU stores and Premium SKU stores.
   */
  defaultKeyValueRevisionRetentionPeriodInSeconds?: int64;

  /**
   * Property specifying whether protection against purge is enabled for this configuration store.
   */
  enablePurgeProtection?: boolean = false;

  /**
   * Property specifying the configuration of data plane proxy for Azure Resource Manager (ARM).
   */
  dataPlaneProxy?: DataPlaneProxyProperties;

  /**
   * Indicates whether the configuration store need to be recovered.
   */
  @visibility(Lifecycle.Create)
  createMode?: CreateMode;

  /**
   * Property specifying the configuration of telemetry for this configuration store
   */
  telemetry?: TelemetryProperties;

  /**
   * Managed On Behalf Of Configuration.
   */
  @visibility(Lifecycle.Read)
  managedOnBehalfOfConfiguration?: CommonTypes.ManagedOnBehalfOfConfiguration;

  /**
   * Property specifying the configuration of Azure Front Door for this configuration store
   */
  @added(Versions.v2025_06_01_preview)
  azureFrontDoor?: AzureFrontDoorProperties;
}

/**
 * The encryption settings for a configuration store.
 */
model EncryptionProperties {
  /**
   * Key vault properties.
   */
  keyVaultProperties?: KeyVaultProperties;
}

/**
 * Settings concerning key vault encryption for a configuration store.
 */
model KeyVaultProperties {
  /**
   * The URI of the key vault key used to encrypt data.
   */
  keyIdentifier?: string;

  /**
   * The client id of the identity which will be used to access key vault.
   */
  identityClientId?: string;
}

/**
 * A reference to a related private endpoint connection.
 */
model PrivateEndpointConnectionReference {
  /**
   * The resource ID.
   */
  @visibility(Lifecycle.Read)
  id?: string;

  /**
   * The name of the resource.
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * The type of the resource.
   */
  @visibility(Lifecycle.Read)
  type?: string;

  /**
   * The properties of a private endpoint connection.
   */
  #suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Backward compatibility"
  @Azure.ClientGenerator.Core.Legacy.flattenProperty
  properties?: PrivateEndpointConnectionProperties;
}

/**
 * Properties of a private endpoint connection.
 */
model PrivateEndpointConnectionProperties {
  /**
   * The provisioning status of the private endpoint connection.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

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
   * The resource Id for private endpoint
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
   * The private link service connection description.
   */
  description?: string;

  /**
   * Any action that is required beyond basic workflow (approve/ reject/ disconnect)
   */
  @visibility(Lifecycle.Read)
  actionsRequired?: ActionsRequired;
}

/**
 * The data plane proxy settings for a configuration store.
 */
model DataPlaneProxyProperties {
  /**
   * The data plane proxy authentication mode. This property manages the authentication mode of request to the data plane resources.
   */
  authenticationMode?: AuthenticationMode;

  /**
   * The data plane proxy private link delegation. This property manages if a request from delegated ARM private link is allowed when the data plane resource requires private link.
   */
  privateLinkDelegation?: PrivateLinkDelegation;
}

/**
 * Telemetry settings
 */
model TelemetryProperties {
  /**
   * Resource ID of a resource enabling telemetry collection
   */
  resourceId?: Azure.Core.armResourceIdentifier;
}

/**
 * Azure Front Door settings
 */
model AzureFrontDoorProperties {
  /**
   * Resource ID of an Azure Front Door profile
   */
  resourceId?: Azure.Core.armResourceIdentifier;
}

/**
 * Describes a configuration store SKU.
 */
model Sku {
  /**
   * The SKU name of the configuration store.
   */
  name: string;
}

/**
 * The parameters for updating a configuration store.
 */
model ConfigurationStoreUpdateParameters {
  /**
   * The properties for updating a configuration store.
   */
  #suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Backward compatibility"
  @Azure.ClientGenerator.Core.Legacy.flattenProperty
  properties?: ConfigurationStorePropertiesUpdateParameters;

  /**
   * The managed identity information for the configuration store.
   */
  identity?: ResourceIdentity;

  /**
   * The SKU of the configuration store.
   */
  sku?: Sku;

  /**
   * The ARM resource tags.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  tags?: Record<string>;
}

/**
 * The properties for updating a configuration store.
 */
model ConfigurationStorePropertiesUpdateParameters {
  /**
   * The encryption settings of the configuration store.
   */
  encryption?: EncryptionProperties;

  /**
   * Disables all authentication methods other than AAD authentication.
   */
  disableLocalAuth?: boolean;

  /**
   * Control permission for data plane traffic coming from public networks while private endpoint is enabled.
   */
  publicNetworkAccess?: PublicNetworkAccess;

  /**
   * Property specifying whether protection against purge is enabled for this configuration store.
   */
  enablePurgeProtection?: boolean;

  /**
   * Property specifying the configuration of data plane proxy for Azure Resource Manager (ARM).
   */
  dataPlaneProxy?: DataPlaneProxyProperties;

  /**
   * The duration in seconds to retain new key value revisions. Defaults to 604800 (7 days) for Free SKU stores and 2592000 (30 days) for Standard SKU stores and Premium SKU stores.
   */
  defaultKeyValueRevisionRetentionPeriodInSeconds?: int64;

  /**
   * Property specifying the configuration of telemetry to update for this configuration store
   */
  telemetry?: TelemetryProperties;

  /**
   * Property specifying the configuration of Azure Front Door for this configuration store
   */
  @added(Versions.v2025_06_01_preview)
  azureFrontDoor?: AzureFrontDoorProperties;
}

/**
 * Parameters used for checking whether a resource name is available.
 */
model CheckNameAvailabilityParameters {
  /**
   * The name to check for availability.
   */
  name: string;

  /**
   * The resource type to check for name availability.
   */
  type: ConfigurationResourceType;
}

/**
 * The result of a request to check the availability of a resource name.
 */
model NameAvailabilityStatus {
  /**
   * The value indicating whether the resource name is available.
   */
  @visibility(Lifecycle.Read)
  nameAvailable?: boolean;

  /**
   * If any, the error message that provides more detail for the reason that the name is not available.
   */
  @visibility(Lifecycle.Read)
  message?: string;

  /**
   * If any, the reason that the name is not available.
   */
  @visibility(Lifecycle.Read)
  reason?: string;
}

/**
 * The result of a request to list API keys.
 */
model ApiKeyListResult is Azure.Core.Page<ApiKey>;

/**
 * An API key used for authenticating with a configuration store endpoint.
 */
model ApiKey {
  /**
   * The key ID.
   */
  @visibility(Lifecycle.Read)
  id?: string;

  /**
   * A name for the key describing its usage.
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * The value of the key that is used for authentication purposes.
   */
  @visibility(Lifecycle.Read)
  value?: string;

  /**
   * A connection string that can be used by supporting clients for authentication.
   */
  @visibility(Lifecycle.Read)
  connectionString?: string;

  /**
   * The last time any of the key's properties were modified.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastModified?: utcDateTime;

  /**
   * Whether this key can only be used for read operations.
   */
  @visibility(Lifecycle.Read)
  readOnly?: boolean;
}

/**
 * The parameters used to regenerate an API key.
 */
model RegenerateKeyParameters {
  /**
   * The id of the key to regenerate.
   */
  id?: string;
}

/**
 * The definition of a configuration store operation.
 */
model OperationDefinition {
  /**
   * Operation name: {provider}/{resource}/{operation}.
   */
  name?: string;

  /**
   * Indicates whether the operation is a data action
   */
  isDataAction?: boolean;

  /**
   * The display information for the configuration store operation.
   */
  display?: OperationDefinitionDisplay;

  /**
   * Origin of the operation
   */
  origin?: string;

  /**
   * Properties of the operation
   */
  properties?: OperationProperties;
}

/**
 * The display information for a configuration store operation.
 */
model OperationDefinitionDisplay {
  /**
   * The resource provider name: Microsoft App Configuration."
   */
  @visibility(Lifecycle.Read)
  provider?: string;

  /**
   * The resource on which the operation is performed.
   */
  resource?: string;

  /**
   * The operation that users can perform.
   */
  operation?: string;

  /**
   * The description for the operation.
   */
  description?: string;
}

/**
 * Extra Operation properties
 */
model OperationProperties {
  /**
   * Service specifications of the operation
   */
  serviceSpecification?: ServiceSpecification;
}

/**
 * The result of a request to list configuration store operations.
 */
model OperationDefinitionListResult {
  /**
   * The collection value.
   */
  @identifiers(#["name"])
  @pageItems
  value?: OperationDefinition[];

  /**
   * The URI that can be used to request the next set of paged results.
   */
  @visibility(Lifecycle.Read)
  @nextLink
  nextLink?: string;
}

/**
 * Service specification payload
 */
model ServiceSpecification {
  /**
   * Specifications of the Log for Azure Monitoring
   */
  @identifiers(#["name"])
  logSpecifications?: LogSpecification[];

  /**
   * Specifications of the Metrics for Azure Monitoring
   */
  @identifiers(#["name"])
  metricSpecifications?: MetricSpecification[];
}

/**
 * Specifications of the Log for Azure Monitoring
 */
model LogSpecification {
  /**
   * Name of the log
   */
  name?: string;

  /**
   * Localized friendly display name of the log
   */
  displayName?: string;

  /**
   * Blob duration of the log
   */
  blobDuration?: string;
}

/**
 * Specifications of the Metrics for Azure Monitoring
 */
model MetricSpecification {
  /**
   * Name of the metric
   */
  name?: string;

  /**
   * Localized friendly display name of the metric
   */
  displayName?: string;

  /**
   * Localized friendly description of the metric
   */
  displayDescription?: string;

  /**
   * Unit that makes sense for the metric
   */
  unit?: string;

  /**
   * Only provide one value for this field. Valid values: Average, Minimum, Maximum, Total, Count.
   */
  aggregationType?: string;

  /**
   * Internal metric name.
   */
  internalMetricName?: string;

  /**
   * Dimensions of the metric
   */
  @identifiers(#["name"])
  dimensions?: MetricDimension[];

  /**
   * Optional. If set to true, then zero will be returned for time duration where no metric is emitted/published.
   */
  fillGapWithZero?: boolean;
}

/**
 * Specifications of the Dimension of metrics
 */
model MetricDimension {
  /**
   * Name of the dimension
   */
  name?: string;

  /**
   * Localized friendly display name of the dimension
   */
  displayName?: string;

  /**
   * Internal name of the dimension.
   */
  internalName?: string;
}

/**
 * Properties of a private link resource.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
model PrivateLinkResourceProperties {
  /**
   * The private link resource group id.
   */
  @visibility(Lifecycle.Read)
  groupId?: string;

  /**
   * The private link resource required member names.
   */
  @visibility(Lifecycle.Read)
  requiredMembers?: string[];

  /**
   * The list of required DNS zone names of the private link resource.
   */
  @visibility(Lifecycle.Read)
  requiredZoneNames?: string[];
}

/**
 * All key-value properties.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
model KeyValueProperties {
  /**
   * The primary identifier of a key-value.
   * The key is used in unison with the label to uniquely identify a key-value.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/secret-prop" "TODO: Check if this is a secret and add @secret or update reason"
  @visibility(Lifecycle.Read)
  key?: string;

  /**
   * A value used to group key-values.
   * The label is used in unison with the key to uniquely identify a key-value.
   */
  @visibility(Lifecycle.Read)
  label?: string;

  /**
   * The value of the key-value.
   */
  value?: string;

  /**
   * The content type of the key-value's value.
   * Providing a proper content-type can enable transformations of values when they are retrieved by applications.
   */
  contentType?: string;

  /**
   * An ETag indicating the state of a key-value within a configuration store.
   */
  @visibility(Lifecycle.Read)
  eTag?: string;

  /**
   * The last time a modifying operation was performed on the given key-value.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastModified?: utcDateTime;

  /**
   * A value indicating whether the key-value is locked.
   * A locked key-value may not be modified until it is unlocked.
   */
  @visibility(Lifecycle.Read)
  locked?: boolean;

  /**
   * A dictionary of tags that can help identify what a key-value may be applicable for.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  tags?: Record<string>;
}

/**
 * Properties of the deleted configuration store.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
model DeletedConfigurationStoreProperties {
  /**
   * The resource id of the original configuration store.
   */
  @visibility(Lifecycle.Read)
  configurationStoreId?: string;

  /**
   * The location of the original configuration store.
   */
  @visibility(Lifecycle.Read)
  location?: string;

  /**
   * The deleted date.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  deletionDate?: utcDateTime;

  /**
   * The scheduled purged date.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  scheduledPurgeDate?: utcDateTime;

  /**
   * Tags of the original configuration store.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  @visibility(Lifecycle.Read)
  tags?: Record<string>;

  /**
   * Purge protection status of the original configuration store.
   */
  @visibility(Lifecycle.Read)
  purgeProtectionEnabled?: boolean;
}

/**
 * All replica properties.
 */
model ReplicaProperties {
  /**
   * The URI of the replica where the replica API will be available.
   */
  @visibility(Lifecycle.Read)
  endpoint?: string;

  /**
   * The provisioning state of the replica.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ReplicaProvisioningState;
}

/**
 * All snapshot properties.
 */
model SnapshotProperties {
  /**
   * The provisioning state of the snapshot.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  /**
   * The current status of the snapshot.
   */
  @visibility(Lifecycle.Read)
  status?: SnapshotStatus;

  /**
   * A list of filters used to filter the key-values included in the snapshot.
   */
  @identifiers(#[])
  @minItems(1)
  @maxItems(3)
  filters: KeyValueFilter[];

  /**
   * The composition type describes how the key-values within the snapshot are composed. The 'key' composition type ensures there are no two key-values containing the same key. The 'key_label' composition type ensures there are no two key-values containing the same key and label.
   */
  compositionType?: CompositionType;

  /**
   * The time that the snapshot was created.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  created?: utcDateTime;

  /**
   * The time that the snapshot will expire.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  expires?: utcDateTime;

  /**
   * The amount of time, in seconds, that a snapshot will remain in the archived state before expiring. This property is only writable during the creation of a snapshot. If not specified, the default lifetime of key-value revisions will be used.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  @maxValue(7776000)
  @minValue(3600)
  retentionPeriod?: int64;

  /**
   * The size in bytes of the snapshot.
   */
  @visibility(Lifecycle.Read)
  size?: int64;

  /**
   * The amount of key-values in the snapshot.
   */
  @visibility(Lifecycle.Read)
  itemsCount?: int64;

  /**
   * The tags of the snapshot. NOTE: These are data plane tags, not ARM tags.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  tags?: Record<string>;

  /**
   * A value representing the current state of the snapshot.
   */
  @visibility(Lifecycle.Read)
  etag?: string;
}

/**
 * Enables filtering of key-values.
 */
model KeyValueFilter {
  /**
   * Filters key-values by their key field.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/secret-prop" "TODO: Check if this is a secret and add @secret or update reason"
  key: string;

  /**
   * Filters key-values by their label field.
   */
  label?: string;
}

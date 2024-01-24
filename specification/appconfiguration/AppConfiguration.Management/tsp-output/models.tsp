import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@typespec/openapi";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.Core;
using TypeSpec.OpenAPI;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Microsoft.AppConfiguration;

interface Operations extends Azure.ResourceManager.Operations {}

/**
 * The type of managed identity used. The type 'SystemAssigned, UserAssigned' includes both an implicitly created identity and a set of user-assigned identities. The type 'None' will remove any identities.
 */
enum IdentityType {
  None,
  SystemAssigned,
  UserAssigned,
  `SystemAssigned, UserAssigned`,
}

/**
 * The provisioning state of the configuration store.
 */
enum ProvisioningState {
  Creating,
  Updating,
  Deleting,
  Succeeded,
  Failed,
  Canceled,
}

/**
 * The private link service connection status.
 */
enum ConnectionStatus {
  Pending,
  Approved,
  Rejected,
  Disconnected,
}

/**
 * Any action that is required beyond basic workflow (approve/ reject/ disconnect)
 */
enum ActionsRequired {
  None,
  Recreate,
}

/**
 * Control permission for data plane traffic coming from public networks while private endpoint is enabled.
 */
enum PublicNetworkAccess {
  Enabled,
  Disabled,
}

/**
 * The resource type to check for name availability.
 */
enum ConfigurationResourceType {
  `Microsoft.AppConfiguration/configurationStores`,
}

/**
 * Indicates whether the configuration store need to be recovered.
 */
@fixed
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
  userAssignedIdentities?: Record<UserIdentity>;

  /**
   * The principal id of the identity. This property will only be provided for a system-assigned identity.
   */
  @visibility("read")
  principalId?: string;

  /**
   * The tenant id associated with the resource's identity. This property will only be provided for a system-assigned identity.
   */
  @visibility("read")
  tenantId?: string;
}

/**
 * A resource identity that is managed by the user of the service.
 */
model UserIdentity {
  /**
   * The principal ID of the user-assigned identity.
   */
  @visibility("read")
  principalId?: string;

  /**
   * The client ID of the user-assigned identity.
   */
  @visibility("read")
  clientId?: string;
}

/**
 * The properties of a configuration store.
 */
model ConfigurationStoreProperties {
  /**
   * The provisioning state of the configuration store.
   */
  @visibility("read")
  provisioningState?: ProvisioningState;

  /**
   * The creation date of configuration store.
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  creationDate?: utcDateTime;

  /**
   * The DNS endpoint where the configuration store API will be available.
   */
  @visibility("read")
  endpoint?: string;

  /**
   * The encryption settings of the configuration store.
   */
  encryption?: EncryptionProperties;

  /**
   * The list of private endpoint connections that are set up for this resource.
   */
  @visibility("read")
  privateEndpointConnections?: PrivateEndpointConnectionReference[];

  /**
   * Control permission for data plane traffic coming from public networks while private endpoint is enabled.
   */
  publicNetworkAccess?: PublicNetworkAccess;

  /**
   * Disables all authentication methods other than AAD authentication.
   */
  disableLocalAuth?: boolean;

  /**
   * The amount of time in days that the configuration store will be retained when it is soft deleted.
   */
  softDeleteRetentionInDays?: int32 = 7;

  /**
   * Property specifying whether protection against purge is enabled for this configuration store.
   */
  enablePurgeProtection?: boolean;

  /**
   * Indicates whether the configuration store need to be recovered.
   */
  @visibility("create")
  createMode?: CreateMode;
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
  @visibility("read")
  id?: string;

  /**
   * The name of the resource.
   */
  @visibility("read")
  name?: string;

  /**
   * The type of the resource.
   */
  @visibility("read")
  type?: string;

  /**
   * The properties of a private endpoint connection.
   */
  @extension("x-ms-client-flatten", true)
  properties?: PrivateEndpointConnectionProperties;
}

/**
 * Properties of a private endpoint connection.
 */
model PrivateEndpointConnectionProperties {
  /**
   * The provisioning status of the private endpoint connection.
   */
  @visibility("read")
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
  @visibility("read")
  actionsRequired?: ActionsRequired;
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
 * Common fields that are returned in the response for all Azure Resource Manager resources
 */
model Resource {
  /**
   * Fully qualified resource ID for the resource. Ex - /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/{resourceProviderNamespace}/{resourceType}/{resourceName}
   */
  @visibility("read")
  id?: string;

  /**
   * The name of the resource
   */
  @visibility("read")
  name?: string;

  /**
   * The type of the resource. E.g. "Microsoft.Compute/virtualMachines" or "Microsoft.Storage/storageAccounts"
   */
  @visibility("read")
  type?: string;
}

/**
 * The details of the error.
 */
model ErrorDetails {
  /**
   * Error code.
   */
  @visibility("read")
  code?: string;

  /**
   * Error message indicating why the operation failed.
   */
  @visibility("read")
  message?: string;

  /**
   * The error additional info.
   */
  @visibility("read")
  additionalInfo?: ErrorAdditionalInfo[];
}

/**
 * The parameters for updating a configuration store.
 */
model ConfigurationStoreUpdateParameters {
  /**
   * The properties for updating a configuration store.
   */
  @extension("x-ms-client-flatten", true)
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
  @visibility("read")
  nameAvailable?: boolean;

  /**
   * If any, the error message that provides more detail for the reason that the name is not available.
   */
  @visibility("read")
  message?: string;

  /**
   * If any, the reason that the name is not available.
   */
  @visibility("read")
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
  @visibility("read")
  id?: string;

  /**
   * A name for the key describing its usage.
   */
  @visibility("read")
  name?: string;

  /**
   * The value of the key that is used for authentication purposes.
   */
  @visibility("read")
  value?: string;

  /**
   * A connection string that can be used by supporting clients for authentication.
   */
  @visibility("read")
  connectionString?: string;

  /**
   * The last time any of the key's properties were modified.
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastModified?: utcDateTime;

  /**
   * Whether this key can only be used for read operations.
   */
  @visibility("read")
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
  @visibility("read")
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
 * Service specification payload
 */
model ServiceSpecification {
  /**
   * Specifications of the Log for Azure Monitoring
   */
  logSpecifications?: LogSpecification[];

  /**
   * Specifications of the Metrics for Azure Monitoring
   */
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
model PrivateLinkResourceProperties {
  /**
   * The private link resource group id.
   */
  @visibility("read")
  groupId?: string;

  /**
   * The private link resource required member names.
   */
  @visibility("read")
  requiredMembers?: string[];

  /**
   * The list of required DNS zone names of the private link resource.
   */
  @visibility("read")
  requiredZoneNames?: string[];
}

/**
 * All key-value properties.
 */
model KeyValueProperties {
  /**
   * The primary identifier of a key-value.
   * The key is used in unison with the label to uniquely identify a key-value.
   */
  @visibility("read")
  key?: string;

  /**
   * A value used to group key-values.
   * The label is used in unison with the key to uniquely identify a key-value.
   */
  @visibility("read")
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
  @visibility("read")
  eTag?: string;

  /**
   * The last time a modifying operation was performed on the given key-value.
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastModified?: utcDateTime;

  /**
   * A value indicating whether the key-value is locked.
   * A locked key-value may not be modified until it is unlocked.
   */
  @visibility("read")
  locked?: boolean;

  /**
   * A dictionary of tags that can help identify what a key-value may be applicable for.
   */
  tags?: Record<string>;
}

/**
 * Properties of the deleted configuration store.
 */
model DeletedConfigurationStoreProperties {
  /**
   * The resource id of the original configuration store.
   */
  @visibility("read")
  configurationStoreId?: string;

  /**
   * The location of the original configuration store.
   */
  @visibility("read")
  location?: string;

  /**
   * The deleted date.
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  deletionDate?: utcDateTime;

  /**
   * The scheduled purged date.
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  scheduledPurgeDate?: utcDateTime;

  /**
   * Tags of the original configuration store.
   */
  @visibility("read")
  tags?: Record<string>;

  /**
   * Purge protection status of the original configuration store.
   */
  @visibility("read")
  purgeProtectionEnabled?: boolean;
}

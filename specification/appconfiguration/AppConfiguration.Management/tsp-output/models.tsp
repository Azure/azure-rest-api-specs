import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.Core;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Microsoft.AppConfiguration;

interface Operations extends Azure.ResourceManager.Operations {}

@doc("The type of managed identity used. The type 'SystemAssigned, UserAssigned' includes both an implicitly created identity and a set of user-assigned identities. The type 'None' will remove any identities.")
enum IdentityType {
  None,
  SystemAssigned,
  UserAssigned,
  `SystemAssigned, UserAssigned`,
}

@doc("The provisioning state of the configuration store.")
enum ProvisioningState {
  Creating,
  Updating,
  Deleting,
  Succeeded,
  Failed,
  Canceled,
}

@doc("The private link service connection status.")
enum ConnectionStatus {
  Pending,
  Approved,
  Rejected,
  Disconnected,
}

@doc("Any action that is required beyond basic workflow (approve/ reject/ disconnect)")
enum ActionsRequired {
  None,
  Recreate,
}

@doc("Control permission for data plane traffic coming from public networks while private endpoint is enabled.")
enum PublicNetworkAccess {
  Enabled,
  Disabled,
}

@doc("The resource type to check for name availability.")
enum ConfigurationResourceType {
  `Microsoft.AppConfiguration/configurationStores`,
}

@doc("Indicates whether the configuration store need to be recovered.")
@fixed
enum CreateMode {
  Recover,
  Default,
}

@doc("An identity that can be associated with a resource.")
model ResourceIdentity {
  @doc("The type of managed identity used. The type 'SystemAssigned, UserAssigned' includes both an implicitly created identity and a set of user-assigned identities. The type 'None' will remove any identities.")
  type?: IdentityType;

  @doc("The list of user-assigned identities associated with the resource. The user-assigned identity dictionary keys will be ARM resource ids in the form: '/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ManagedIdentity/userAssignedIdentities/{identityName}'.")
  userAssignedIdentities?: Record<UserIdentity>;

  @doc("The principal id of the identity. This property will only be provided for a system-assigned identity.")
  @visibility("read")
  principalId?: string;

  @doc("The tenant id associated with the resource's identity. This property will only be provided for a system-assigned identity.")
  @visibility("read")
  tenantId?: string;
}

@doc("A resource identity that is managed by the user of the service.")
model UserIdentity {
  @doc("The principal ID of the user-assigned identity.")
  @visibility("read")
  principalId?: string;

  @doc("The client ID of the user-assigned identity.")
  @visibility("read")
  clientId?: string;
}

@doc("The properties of a configuration store.")
model ConfigurationStoreProperties {
  @doc("The provisioning state of the configuration store.")
  @visibility("read")
  provisioningState?: ProvisioningState;

  @doc("The creation date of configuration store.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  creationDate?: utcDateTime;

  @doc("The DNS endpoint where the configuration store API will be available.")
  @visibility("read")
  endpoint?: string;

  @doc("The encryption settings of the configuration store.")
  encryption?: EncryptionProperties;

  @doc("The list of private endpoint connections that are set up for this resource.")
  @visibility("read")
  privateEndpointConnections?: PrivateEndpointConnectionReference[];

  @doc("Control permission for data plane traffic coming from public networks while private endpoint is enabled.")
  publicNetworkAccess?: PublicNetworkAccess;

  @doc("Disables all authentication methods other than AAD authentication.")
  disableLocalAuth?: boolean;

  @doc("The amount of time in days that the configuration store will be retained when it is soft deleted.")
  softDeleteRetentionInDays?: int32;

  @doc("Property specifying whether protection against purge is enabled for this configuration store.")
  enablePurgeProtection?: boolean;

  @doc("Indicates whether the configuration store need to be recovered.")
  @visibility("create")
  createMode?: CreateMode;
}

@doc("The encryption settings for a configuration store.")
model EncryptionProperties {
  @doc("Key vault properties.")
  keyVaultProperties?: KeyVaultProperties;
}

@doc("Settings concerning key vault encryption for a configuration store.")
model KeyVaultProperties {
  @doc("The URI of the key vault key used to encrypt data.")
  keyIdentifier?: string;

  @doc("The client id of the identity which will be used to access key vault.")
  identityClientId?: string;
}

@doc("A reference to a related private endpoint connection.")
model PrivateEndpointConnectionReference {
  @doc("The resource ID.")
  @visibility("read")
  id?: string;

  @doc("The name of the resource.")
  @visibility("read")
  name?: string;

  @doc("The type of the resource.")
  @visibility("read")
  type?: string;

  @doc("The properties of a private endpoint connection.")
  properties?: PrivateEndpointConnectionProperties;
}

@doc("Properties of a private endpoint connection.")
model PrivateEndpointConnectionProperties {
  @doc("The provisioning status of the private endpoint connection.")
  @visibility("read")
  provisioningState?: ProvisioningState;

  @doc("The resource of private endpoint.")
  privateEndpoint?: PrivateEndpoint;

  @doc("A collection of information about the state of the connection between service consumer and provider.")
  privateLinkServiceConnectionState: PrivateLinkServiceConnectionState;
}

@doc("Private endpoint which a connection belongs to.")
model PrivateEndpoint {
  @doc("The resource Id for private endpoint")
  id?: string;
}

@doc("The state of a private link service connection.")
model PrivateLinkServiceConnectionState {
  @doc("The private link service connection status.")
  status?: ConnectionStatus;

  @doc("The private link service connection description.")
  description?: string;

  @doc("Any action that is required beyond basic workflow (approve/ reject/ disconnect)")
  @visibility("read")
  actionsRequired?: ActionsRequired;
}

@doc("Describes a configuration store SKU.")
model Sku {
  @doc("The SKU name of the configuration store.")
  name: string;
}

@doc("Common fields that are returned in the response for all Azure Resource Manager resources")
model Resource {
  @doc("Fully qualified resource ID for the resource. Ex - /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/{resourceProviderNamespace}/{resourceType}/{resourceName}")
  @visibility("read")
  id?: string;

  @doc("The name of the resource")
  @visibility("read")
  name?: string;

  @doc("The type of the resource. E.g. \"Microsoft.Compute/virtualMachines\" or \"Microsoft.Storage/storageAccounts\"")
  @visibility("read")
  type?: string;
}

@doc("The details of the error.")
model ErrorDetails {
  @doc("Error code.")
  @visibility("read")
  code?: string;

  @doc("Error message indicating why the operation failed.")
  @visibility("read")
  message?: string;

  @doc("The error additional info.")
  @visibility("read")
  additionalInfo?: ErrorAdditionalInfo[];
}

@doc("The parameters for updating a configuration store.")
model ConfigurationStoreUpdateParameters {
  @doc("The properties for updating a configuration store.")
  properties?: ConfigurationStorePropertiesUpdateParameters;

  @doc("The managed identity information for the configuration store.")
  identity?: ResourceIdentity;

  @doc("The SKU of the configuration store.")
  sku?: Sku;

  @doc("The ARM resource tags.")
  tags?: Record<string>;
}

@doc("The properties for updating a configuration store.")
model ConfigurationStorePropertiesUpdateParameters {
  @doc("The encryption settings of the configuration store.")
  encryption?: EncryptionProperties;

  @doc("Disables all authentication methods other than AAD authentication.")
  disableLocalAuth?: boolean;

  @doc("Control permission for data plane traffic coming from public networks while private endpoint is enabled.")
  publicNetworkAccess?: PublicNetworkAccess;

  @doc("Property specifying whether protection against purge is enabled for this configuration store.")
  enablePurgeProtection?: boolean;
}

@doc("Parameters used for checking whether a resource name is available.")
model CheckNameAvailabilityParameters {
  @doc("The name to check for availability.")
  name: string;

  @doc("The resource type to check for name availability.")
  type: ConfigurationResourceType;
}

@doc("The result of a request to check the availability of a resource name.")
model NameAvailabilityStatus {
  @doc("The value indicating whether the resource name is available.")
  @visibility("read")
  nameAvailable?: boolean;

  @doc("If any, the error message that provides more detail for the reason that the name is not available.")
  @visibility("read")
  message?: string;

  @doc("If any, the reason that the name is not available.")
  @visibility("read")
  reason?: string;
}

@doc("The result of a request to list API keys.")
model ApiKeyListResult is Azure.Core.Page<ApiKey>;

@doc("An API key used for authenticating with a configuration store endpoint.")
model ApiKey {
  @doc("The key ID.")
  @visibility("read")
  id?: string;

  @doc("A name for the key describing its usage.")
  @visibility("read")
  name?: string;

  @doc("The value of the key that is used for authentication purposes.")
  @visibility("read")
  value?: string;

  @doc("A connection string that can be used by supporting clients for authentication.")
  @visibility("read")
  connectionString?: string;

  @doc("The last time any of the key's properties were modified.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastModified?: utcDateTime;

  @doc("Whether this key can only be used for read operations.")
  @visibility("read")
  readOnly?: boolean;
}

@doc("The parameters used to regenerate an API key.")
model RegenerateKeyParameters {
  @doc("The id of the key to regenerate.")
  id?: string;
}

@doc("The definition of a configuration store operation.")
model OperationDefinition {
  @doc("Operation name: {provider}/{resource}/{operation}.")
  name?: string;

  @doc("Indicates whether the operation is a data action")
  isDataAction?: boolean;

  @doc("The display information for the configuration store operation.")
  display?: OperationDefinitionDisplay;

  @doc("Origin of the operation")
  origin?: string;

  @doc("Properties of the operation")
  properties?: OperationProperties;
}

@doc("The display information for a configuration store operation.")
model OperationDefinitionDisplay {
  @doc("The resource provider name: Microsoft App Configuration.\"")
  @visibility("read")
  provider?: string;

  @doc("The resource on which the operation is performed.")
  resource?: string;

  @doc("The operation that users can perform.")
  operation?: string;

  @doc("The description for the operation.")
  description?: string;
}

@doc("Extra Operation properties")
model OperationProperties {
  @doc("Service specifications of the operation")
  serviceSpecification?: ServiceSpecification;
}

@doc("Service specification payload")
model ServiceSpecification {
  @doc("Specifications of the Log for Azure Monitoring")
  logSpecifications?: LogSpecification[];

  @doc("Specifications of the Metrics for Azure Monitoring")
  metricSpecifications?: MetricSpecification[];
}

@doc("Specifications of the Log for Azure Monitoring")
model LogSpecification {
  @doc("Name of the log")
  name?: string;

  @doc("Localized friendly display name of the log")
  displayName?: string;

  @doc("Blob duration of the log")
  blobDuration?: string;
}

@doc("Specifications of the Metrics for Azure Monitoring")
model MetricSpecification {
  @doc("Name of the metric")
  name?: string;

  @doc("Localized friendly display name of the metric")
  displayName?: string;

  @doc("Localized friendly description of the metric")
  displayDescription?: string;

  @doc("Unit that makes sense for the metric")
  unit?: string;

  @doc("Only provide one value for this field. Valid values: Average, Minimum, Maximum, Total, Count.")
  aggregationType?: string;

  @doc("Internal metric name.")
  internalMetricName?: string;

  @doc("Dimensions of the metric")
  dimensions?: MetricDimension[];

  @doc("Optional. If set to true, then zero will be returned for time duration where no metric is emitted/published.")
  fillGapWithZero?: boolean;
}

@doc("Specifications of the Dimension of metrics")
model MetricDimension {
  @doc("Name of the dimension")
  name?: string;

  @doc("Localized friendly display name of the dimension")
  displayName?: string;

  @doc("Internal name of the dimension.")
  internalName?: string;
}

@doc("Properties of a private link resource.")
model PrivateLinkResourceProperties {
  @doc("The private link resource group id.")
  @visibility("read")
  groupId?: string;

  @doc("The private link resource required member names.")
  @visibility("read")
  requiredMembers?: string[];

  @doc("The list of required DNS zone names of the private link resource.")
  @visibility("read")
  requiredZoneNames?: string[];
}

@doc("All key-value properties.")
model KeyValueProperties {
  @doc("""
The primary identifier of a key-value.
The key is used in unison with the label to uniquely identify a key-value.
""")
  @visibility("read")
  key?: string;

  @doc("""
A value used to group key-values.
The label is used in unison with the key to uniquely identify a key-value.
""")
  @visibility("read")
  label?: string;

  @doc("The value of the key-value.")
  value?: string;

  @doc("""
The content type of the key-value's value.
Providing a proper content-type can enable transformations of values when they are retrieved by applications.
""")
  contentType?: string;

  @doc("An ETag indicating the state of a key-value within a configuration store.")
  @visibility("read")
  eTag?: string;

  @doc("The last time a modifying operation was performed on the given key-value.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastModified?: utcDateTime;

  @doc("""
A value indicating whether the key-value is locked.
A locked key-value may not be modified until it is unlocked.
""")
  @visibility("read")
  locked?: boolean;

  @doc("A dictionary of tags that can help identify what a key-value may be applicable for.")
  tags?: Record<string>;
}

@doc("Properties of the deleted configuration store.")
model DeletedConfigurationStoreProperties {
  @doc("The resource id of the original configuration store.")
  @visibility("read")
  configurationStoreId?: string;

  @doc("The location of the original configuration store.")
  @visibility("read")
  location?: string;

  @doc("The deleted date.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  deletionDate?: utcDateTime;

  @doc("The scheduled purged date.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  scheduledPurgeDate?: utcDateTime;

  @doc("Tags of the original configuration store.")
  @visibility("read")
  tags?: Record<string>;

  @doc("Purge protection status of the original configuration store.")
  @visibility("read")
  purgeProtectionEnabled?: boolean;
}

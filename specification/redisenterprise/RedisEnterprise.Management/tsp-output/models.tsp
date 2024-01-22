import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.Core;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Microsoft.Cache;

interface Operations extends Azure.ResourceManager.Operations {}

enum SkuName {
  Enterprise_E10,
  Enterprise_E20,
  Enterprise_E50,
  Enterprise_E100,
  EnterpriseFlash_F300,
  EnterpriseFlash_F700,
  EnterpriseFlash_F1500,
}

/**
 * Type of managed service identity (where both SystemAssigned and UserAssigned types are allowed).
 */
enum ManagedServiceIdentityType {
  None,
  SystemAssigned,
  UserAssigned,
  `SystemAssigned, UserAssigned`,
}

/**
 * The minimum TLS version for the cluster to support, e.g. '1.2'
 */
enum TlsVersion {
  `1.0`,
  `1.1`,
  `1.2`,
}

/**
 * Only userAssignedIdentity is supported in this API version; other types may be supported in the future
 */
enum CmkIdentityType {
  systemAssignedIdentity,
  userAssignedIdentity,
}

/**
 * Current provisioning status
 */
enum ProvisioningState {
  Succeeded,
  Failed,
  Canceled,
  Creating,
  Updating,
  Deleting,
}

/**
 * Current resource status
 */
enum ResourceState {
  Running,
  Creating,
  CreateFailed,
  Updating,
  UpdateFailed,
  Deleting,
  DeleteFailed,
  Enabling,
  EnableFailed,
  Disabling,
  DisableFailed,
  Disabled,
}

/**
 * The private endpoint connection status.
 */
enum PrivateEndpointServiceConnectionStatus {
  Pending,
  Approved,
  Rejected,
}

/**
 * The current provisioning state.
 */
enum PrivateEndpointConnectionProvisioningState {
  Succeeded,
  Creating,
  Deleting,
  Failed,
}

/**
 * Specifies whether redis clients can connect using TLS-encrypted or plaintext redis protocols. Default is TLS-encrypted.
 */
enum Protocol {
  Encrypted,
  Plaintext,
}

/**
 * Clustering policy - default is OSSCluster. Specified at create time.
 */
enum ClusteringPolicy {
  EnterpriseCluster,
  OSSCluster,
}

/**
 * Redis eviction policy - default is VolatileLRU
 */
enum EvictionPolicy {
  AllKeysLFU,
  AllKeysLRU,
  AllKeysRandom,
  VolatileLRU,
  VolatileLFU,
  VolatileTTL,
  VolatileRandom,
  NoEviction,
}

/**
 * Sets the frequency at which data is written to disk.
 */
enum AofFrequency {
  `1s`,
  always,
}

/**
 * Sets the frequency at which a snapshot of the database is created.
 */
enum RdbFrequency {
  `1h`,
  `6h`,
  `12h`,
}

/**
 * State of the link between the database resources.
 */
enum LinkState {
  Linked,
  Linking,
  Unlinking,
  LinkFailed,
  UnlinkFailed,
}

/**
 * Which access key to regenerate.
 */
@fixed
enum AccessKeyType {
  Primary,
  Secondary,
}

/**
 * The status of a long-running operation.
 */
model OperationStatus {
  /**
   * The operation's unique id.
   */
  id?: string;

  /**
   * The operation's name.
   */
  name?: string;

  /**
   * The start time of the operation.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startTime?: utcDateTime;

  /**
   * The end time of the operation.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  endTime?: utcDateTime;

  /**
   * The current status of the operation.
   */
  status?: string;

  /**
   * Error response describing why the operation failed.
   */
  @projectedName("json", "error")
  errorResponse?: ErrorResponse;
}

/**
 * SKU parameters supplied to the create RedisEnterprise operation.
 */
model Sku {
  /**
   * The type of RedisEnterprise cluster to deploy. Possible values: (Enterprise_E10, EnterpriseFlash_F300 etc.)
   */
  name: SkuName;

  /**
   * The size of the RedisEnterprise cluster. Defaults to 2 or 3 depending on SKU. Valid values are (2, 4, 6, ...) for Enterprise SKUs and (3, 9, 15, ...) for Flash SKUs.
   */
  capacity?: int32;
}

/**
 * Properties of RedisEnterprise clusters, as opposed to general resource properties like location, tags
 */
model ClusterProperties {
  /**
   * The minimum TLS version for the cluster to support, e.g. '1.2'
   */
  minimumTlsVersion?: TlsVersion;

  /**
   * Encryption-at-rest configuration for the cluster.
   */
  encryption?: ClusterPropertiesEncryption;

  /**
   * DNS name of the cluster endpoint
   */
  @visibility("read")
  hostName?: string;

  /**
   * Current provisioning status of the cluster
   */
  @visibility("read")
  provisioningState?: ProvisioningState;

  /**
   * Current resource status of the cluster
   */
  @visibility("read")
  resourceState?: ResourceState;

  /**
   * Version of redis the cluster supports, e.g. '6'
   */
  @visibility("read")
  redisVersion?: string;

  /**
   * List of private endpoint connections associated with the specified RedisEnterprise cluster
   */
  @visibility("read")
  privateEndpointConnections?: PrivateEndpointConnection[];
}

/**
 * Encryption-at-rest configuration for the cluster.
 */
model ClusterPropertiesEncryption {
  /**
   * All Customer-managed key encryption properties for the resource. Set this to an empty object to use Microsoft-managed key encryption.
   */
  customerManagedKeyEncryption?: ClusterPropertiesEncryptionCustomerManagedKeyEncryption;
}

/**
 * All Customer-managed key encryption properties for the resource. Set this to an empty object to use Microsoft-managed key encryption.
 */
model ClusterPropertiesEncryptionCustomerManagedKeyEncryption {
  /**
   * All identity configuration for Customer-managed key settings defining which identity should be used to auth to Key Vault.
   */
  keyEncryptionKeyIdentity?: ClusterPropertiesEncryptionCustomerManagedKeyEncryptionKeyEncryptionKeyIdentity;

  /**
   * Key encryption key Url, versioned only. Ex: https://contosovault.vault.azure.net/keys/contosokek/562a4bb76b524a1493a6afe8e536ee78
   */
  keyEncryptionKeyUrl?: string;
}

/**
 * All identity configuration for Customer-managed key settings defining which identity should be used to auth to Key Vault.
 */
model ClusterPropertiesEncryptionCustomerManagedKeyEncryptionKeyEncryptionKeyIdentity {
  /**
   * User assigned identity to use for accessing key encryption key Url. Ex: /subscriptions/<sub uuid>/resourceGroups/<resource group>/providers/Microsoft.ManagedIdentity/userAssignedIdentities/myId.
   */
  userAssignedIdentityResourceId?: string;

  /**
   * Only userAssignedIdentity is supported in this API version; other types may be supported in the future
   */
  identityType?: CmkIdentityType;
}

/**
 * Properties of the PrivateEndpointConnectProperties.
 */
model PrivateEndpointConnectionProperties {
  /**
   * The resource of private end point.
   */
  privateEndpoint?: PrivateEndpoint;

  /**
   * A collection of information about the state of the connection between service consumer and provider.
   */
  privateLinkServiceConnectionState: PrivateLinkServiceConnectionState;

  /**
   * The provisioning state of the private endpoint connection resource.
   */
  @visibility("read")
  provisioningState?: PrivateEndpointConnectionProvisioningState;
}

/**
 * The Private Endpoint resource.
 */
model PrivateEndpoint {
  /**
   * The ARM identifier for Private Endpoint
   */
  @visibility("read")
  id?: string;
}

/**
 * A collection of information about the state of the connection between service consumer and provider.
 */
model PrivateLinkServiceConnectionState {
  /**
   * Indicates whether the connection has been Approved/Rejected/Removed by the owner of the service.
   */
  status?: PrivateEndpointServiceConnectionStatus;

  /**
   * The reason for approval/rejection of the connection.
   */
  description?: string;

  /**
   * A message indicating if changes on the service provider require any updates on the consumer.
   */
  actionsRequired?: string;
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

  /**
   * Azure Resource Manager metadata containing createdBy and modifiedBy information.
   */
  @visibility("read")
  systemData?: SystemData;
}

/**
 * A partial update to the RedisEnterprise cluster
 */
model ClusterUpdate {
  /**
   * The SKU to create, which affects price, performance, and features.
   */
  sku?: Sku;

  /**
   * Other properties of the cluster.
   */
  properties?: ClusterProperties;

  /**
   * The identity of the resource.
   */
  identity?: ManagedServiceIdentity;

  /**
   * Resource tags.
   */
  @visibility("read", "create", "update")
  tags?: Record<string>;
}

/**
 * Properties of RedisEnterprise databases, as opposed to general resource properties like location, tags
 */
model DatabaseProperties {
  /**
   * Specifies whether redis clients can connect using TLS-encrypted or plaintext redis protocols. Default is TLS-encrypted.
   */
  clientProtocol?: Protocol;

  /**
   * TCP port of the database endpoint. Specified at create time. Defaults to an available port.
   */
  @visibility("read", "create")
  port?: int32;

  /**
   * Current provisioning status of the database
   */
  @visibility("read")
  provisioningState?: ProvisioningState;

  /**
   * Current resource status of the database
   */
  @visibility("read")
  resourceState?: ResourceState;

  /**
   * Clustering policy - default is OSSCluster. Specified at create time.
   */
  @visibility("read", "create")
  clusteringPolicy?: ClusteringPolicy;

  /**
   * Redis eviction policy - default is VolatileLRU
   */
  evictionPolicy?: EvictionPolicy;

  /**
   * Persistence settings
   */
  persistence?: Persistence;

  /**
   * Optional set of redis modules to enable in this database - modules can only be added at creation time.
   */
  @visibility("read", "create")
  modules?: Module[];

  /**
   * Optional set of properties to configure geo replication for this database.
   */
  @visibility("read", "create")
  geoReplication?: DatabasePropertiesGeoReplication;
}

/**
 * Persistence-related configuration for the RedisEnterprise database
 */
model Persistence {
  /**
   * Sets whether AOF is enabled.
   */
  aofEnabled?: boolean;

  /**
   * Sets whether RDB is enabled.
   */
  rdbEnabled?: boolean;

  /**
   * Sets the frequency at which data is written to disk.
   */
  aofFrequency?: AofFrequency;

  /**
   * Sets the frequency at which a snapshot of the database is created.
   */
  rdbFrequency?: RdbFrequency;
}

/**
 * Specifies configuration of a redis module
 */
model Module {
  /**
   * The name of the module, e.g. 'RedisBloom', 'RediSearch', 'RedisTimeSeries'
   */
  @visibility("read", "create")
  name: string;

  /**
   * Configuration options for the module, e.g. 'ERROR_RATE 0.01 INITIAL_SIZE 400'.
   */
  @visibility("read", "create")
  args?: string;

  /**
   * The version of the module, e.g. '1.0'.
   */
  @visibility("read")
  version?: string;
}

/**
 * Optional set of properties to configure geo replication for this database.
 */
model DatabasePropertiesGeoReplication {
  /**
   * Name for the group of linked database resources
   */
  @visibility("read", "create")
  groupNickname?: string;

  /**
   * List of database resources to link with this database
   */
  linkedDatabases?: LinkedDatabase[];
}

/**
 * Specifies details of a linked database resource.
 */
model LinkedDatabase {
  /**
   * Resource ID of a database resource to link with this database.
   */
  @visibility("read", "create")
  id?: string;

  /**
   * State of the link between the database resources.
   */
  @visibility("read")
  state?: LinkState;
}

/**
 * A partial update to the RedisEnterprise database
 */
model DatabaseUpdate {
  /**
   * Properties of the database.
   */
  properties?: DatabaseProperties;
}

/**
 * The secret access keys used for authenticating connections to redis
 */
model AccessKeys {
  /**
   * The current primary key that clients can use to authenticate
   */
  @visibility("read")
  primaryKey?: string;

  /**
   * The current secondary key that clients can use to authenticate
   */
  @visibility("read")
  secondaryKey?: string;
}

/**
 * Specifies which access keys to reset to a new random value.
 */
model RegenerateKeyParameters {
  /**
   * Which access key to regenerate.
   */
  keyType: AccessKeyType;
}

/**
 * Parameters for a Redis Enterprise import operation.
 */
model ImportClusterParameters {
  /**
   * SAS URIs for the target blobs to import from
   */
  sasUris: string[];
}

/**
 * Parameters for a Redis Enterprise export operation.
 */
model ExportClusterParameters {
  /**
   * SAS URI for the target directory to export to
   */
  sasUri: string;
}

/**
 * A list of private link resources
 */
@pagedResult
model PrivateLinkResourceListResult {
  /**
   * Array of private link resources
   */
  @items
  value?: PrivateLinkResource[];
}

/**
 * A private link resource
 */
model PrivateLinkResource extends Resource {
  /**
   * Resource properties.
   */
  properties?: PrivateLinkResourceProperties;
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
   * The private link resource Private link DNS zone name.
   */
  requiredZoneNames?: string[];
}

/**
 * Parameters for a Redis Enterprise Active Geo Replication Force Unlink operation.
 */
model ForceUnlinkParameters {
  /**
   * The resource IDs of the database resources to be unlinked.
   */
  ids: string[];
}

/**
 * Parameters for a Redis Enterprise active geo-replication flush operation.
 */
model FlushParameters {
  /**
   * The resource identifiers of all the other database resources in the georeplication group to be flushed
   */
  ids?: string[];
}

/**
 * List of details about all the available SKUs
 */
@pagedResult
model RegionSkuDetails {
  /**
   * List of Sku Detail
   */
  @items
  value?: RegionSkuDetail[];
}

/**
 * Details about the location requested and the available skus in the location
 */
model RegionSkuDetail {
  /**
   * Resource type which has the SKU, such as Microsoft.Cache/redisEnterprise
   */
  resourceType?: string;

  /**
   * Details about location and its capabilities
   */
  locationInfo?: LocationInfo;

  /**
   * Details about available skus
   */
  skuDetails?: SkuDetail;
}

/**
 * Information about location (for example: features that it supports)
 */
model LocationInfo {
  /**
   * Location name
   */
  location?: string;

  /**
   * List of capabilities
   */
  capabilities?: Capability[];
}

/**
 * Information about the features the location supports
 */
model Capability {
  /**
   * Feature name
   */
  name?: string;

  /**
   * Indicates whether feature is supported or not
   */
  value?: boolean;
}

/**
 * Information about Sku
 */
model SkuDetail {
  /**
   * The type of RedisEnterprise cluster to deploy. Possible values: (Enterprise_E10, EnterpriseFlash_F300 etc.)
   */
  name?: SkuName;
}

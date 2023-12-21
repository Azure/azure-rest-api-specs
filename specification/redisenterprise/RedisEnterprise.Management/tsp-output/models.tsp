import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.Core;
using Azure.ResourceManager;

namespace Azure.ResourceManager.RedisEnterprise;

interface Operations extends Azure.ResourceManager.Operations {}

enum Origin {
  user,
  system,
  `user,system`,
}

enum ActionType {
  Internal,
}

enum SkuName {
  Enterprise_E10,
  Enterprise_E20,
  Enterprise_E50,
  Enterprise_E100,
  EnterpriseFlash_F300,
  EnterpriseFlash_F700,
  EnterpriseFlash_F1500,
}

enum ManagedServiceIdentityType {
  None,
  SystemAssigned,
  UserAssigned,
  `SystemAssigned, UserAssigned`,
}

enum TlsVersion {
  `1.0`,
  `1.1`,
  `1.2`,
}

enum CmkIdentityType {
  systemAssignedIdentity,
  userAssignedIdentity,
}

enum ProvisioningState {
  Succeeded,
  Failed,
  Canceled,
  Creating,
  Updating,
  Deleting,
}

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

enum PrivateEndpointServiceConnectionStatus {
  Pending,
  Approved,
  Rejected,
}

enum PrivateEndpointConnectionProvisioningState {
  Succeeded,
  Creating,
  Deleting,
  Failed,
}

enum CreatedByType {
  User,
  Application,
  ManagedIdentity,
  Key,
}

enum Protocol {
  Encrypted,
  Plaintext,
}

enum ClusteringPolicy {
  EnterpriseCluster,
  OSSCluster,
}

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

enum AofFrequency {
  `1s`,
  always,
}

enum RdbFrequency {
  `1h`,
  `6h`,
  `12h`,
}

enum LinkState {
  Linked,
  Linking,
  Unlinking,
  LinkFailed,
  UnlinkFailed,
}
@Azure.Core.fixed
enum AccessKeyType {
  Primary,
  Secondary,
}

@doc("The status of a long-running operation.")
model OperationStatus {
  @doc("The operation's unique id.")
  id?: string;

  @doc("The operation's name.")
  name?: string;

  @doc("The start time of the operation.")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startTime?: utcDateTime;

  @doc("The end time of the operation.")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  endTime?: utcDateTime;

  @doc("The current status of the operation.")
  status?: string;

  @doc("Error response describing why the operation failed.")
  @projectedName("json", "error")
  errorResponse?: ErrorResponse;
}

@doc("SKU parameters supplied to the create RedisEnterprise operation.")
model Sku {
  @doc("The type of RedisEnterprise cluster to deploy. Possible values: (Enterprise_E10, EnterpriseFlash_F300 etc.)")
  name: SkuName;

  @doc("The size of the RedisEnterprise cluster. Defaults to 2 or 3 depending on SKU. Valid values are (2, 4, 6, ...) for Enterprise SKUs and (3, 9, 15, ...) for Flash SKUs.")
  capacity?: int32;
}

@doc("User assigned identity properties")
model UserAssignedIdentity {
  @doc("The principal ID of the assigned identity.")
  @visibility("read")
  principalId?: string;

  @doc("The client ID of the assigned identity.")
  @visibility("read")
  clientId?: string;
}

@doc("Properties of RedisEnterprise clusters, as opposed to general resource properties like location, tags")
model ClusterProperties {
  @doc("The minimum TLS version for the cluster to support, e.g. '1.2'")
  minimumTlsVersion?: TlsVersion;

  @doc("Encryption-at-rest configuration for the cluster.")
  encryption?: ClusterPropertiesEncryption;

  @doc("DNS name of the cluster endpoint")
  @visibility("read")
  hostName?: string;

  @doc("Current provisioning status of the cluster")
  @visibility("read")
  provisioningState?: ProvisioningState;

  @doc("Current resource status of the cluster")
  @visibility("read")
  resourceState?: ResourceState;

  @doc("Version of redis the cluster supports, e.g. '6'")
  @visibility("read")
  redisVersion?: string;

  @doc("List of private endpoint connections associated with the specified RedisEnterprise cluster")
  @visibility("read")
  privateEndpointConnections?: PrivateEndpointConnection[];
}

@doc("Encryption-at-rest configuration for the cluster.")
model ClusterPropertiesEncryption {
  @doc("All Customer-managed key encryption properties for the resource. Set this to an empty object to use Microsoft-managed key encryption.")
  customerManagedKeyEncryption?: ClusterPropertiesEncryptionCustomerManagedKeyEncryption;
}

@doc("All Customer-managed key encryption properties for the resource. Set this to an empty object to use Microsoft-managed key encryption.")
model ClusterPropertiesEncryptionCustomerManagedKeyEncryption {
  @doc("All identity configuration for Customer-managed key settings defining which identity should be used to auth to Key Vault.")
  keyEncryptionKeyIdentity?: ClusterPropertiesEncryptionCustomerManagedKeyEncryptionKeyEncryptionKeyIdentity;

  @doc("Key encryption key Url, versioned only. Ex: https://contosovault.vault.azure.net/keys/contosokek/562a4bb76b524a1493a6afe8e536ee78")
  keyEncryptionKeyUrl?: string;
}

@doc("All identity configuration for Customer-managed key settings defining which identity should be used to auth to Key Vault.")
model ClusterPropertiesEncryptionCustomerManagedKeyEncryptionKeyEncryptionKeyIdentity {
  @doc("User assigned identity to use for accessing key encryption key Url. Ex: /subscriptions/<sub uuid>/resourceGroups/<resource group>/providers/Microsoft.ManagedIdentity/userAssignedIdentities/myId.")
  userAssignedIdentityResourceId?: string;

  @doc("Only userAssignedIdentity is supported in this API version; other types may be supported in the future")
  identityType?: CmkIdentityType;
}

@doc("Properties of the PrivateEndpointConnectProperties.")
model PrivateEndpointConnectionProperties {
  @doc("The resource of private end point.")
  privateEndpoint?: PrivateEndpoint;

  @doc("A collection of information about the state of the connection between service consumer and provider.")
  privateLinkServiceConnectionState: PrivateLinkServiceConnectionState;

  @doc("The provisioning state of the private endpoint connection resource.")
  @visibility("read")
  provisioningState?: PrivateEndpointConnectionProvisioningState;
}

@doc("The Private Endpoint resource.")
model PrivateEndpoint {
  @doc("The ARM identifier for Private Endpoint")
  @visibility("read")
  id?: string;
}

@doc("A collection of information about the state of the connection between service consumer and provider.")
model PrivateLinkServiceConnectionState {
  @doc("Indicates whether the connection has been Approved/Rejected/Removed by the owner of the service.")
  status?: PrivateEndpointServiceConnectionStatus;

  @doc("The reason for approval/rejection of the connection.")
  description?: string;

  @doc("A message indicating if changes on the service provider require any updates on the consumer.")
  actionsRequired?: string;
}

@doc("Properties of RedisEnterprise databases, as opposed to general resource properties like location, tags")
model DatabaseProperties {
  @doc("Specifies whether redis clients can connect using TLS-encrypted or plaintext redis protocols. Default is TLS-encrypted.")
  clientProtocol?: Protocol;

  @doc("TCP port of the database endpoint. Specified at create time. Defaults to an available port.")
  @visibility("read", "create")
  port?: int32;

  @doc("Current provisioning status of the database")
  @visibility("read")
  provisioningState?: ProvisioningState;

  @doc("Current resource status of the database")
  @visibility("read")
  resourceState?: ResourceState;

  @doc("Clustering policy - default is OSSCluster. Specified at create time.")
  @visibility("read", "create")
  clusteringPolicy?: ClusteringPolicy;

  @doc("Redis eviction policy - default is VolatileLRU")
  evictionPolicy?: EvictionPolicy;

  @doc("Persistence settings")
  persistence?: Persistence;

  @doc("Optional set of redis modules to enable in this database - modules can only be added at creation time.")
  @visibility("read", "create")
  modules?: Module[];

  @doc("Optional set of properties to configure geo replication for this database.")
  @visibility("read", "create")
  geoReplication?: DatabasePropertiesGeoReplication;
}

@doc("Persistence-related configuration for the RedisEnterprise database")
model Persistence {
  @doc("Sets whether AOF is enabled.")
  aofEnabled?: boolean;

  @doc("Sets whether RDB is enabled.")
  rdbEnabled?: boolean;

  @doc("Sets the frequency at which data is written to disk.")
  aofFrequency?: AofFrequency;

  @doc("Sets the frequency at which a snapshot of the database is created.")
  rdbFrequency?: RdbFrequency;
}

@doc("Specifies configuration of a redis module")
model Module {
  @doc("The name of the module, e.g. 'RedisBloom', 'RediSearch', 'RedisTimeSeries'")
  @visibility("read", "create")
  name: string;

  @doc("Configuration options for the module, e.g. 'ERROR_RATE 0.01 INITIAL_SIZE 400'.")
  @visibility("read", "create")
  args?: string;

  @doc("The version of the module, e.g. '1.0'.")
  @visibility("read")
  version?: string;
}

@doc("Optional set of properties to configure geo replication for this database.")
model DatabasePropertiesGeoReplication {
  @doc("Name for the group of linked database resources")
  @visibility("read", "create")
  groupNickname?: string;

  @doc("List of database resources to link with this database")
  linkedDatabases?: LinkedDatabase[];
}

@doc("Specifies details of a linked database resource.")
model LinkedDatabase {
  @doc("Resource ID of a database resource to link with this database.")
  @visibility("read", "create")
  id?: string;

  @doc("State of the link between the database resources.")
  @visibility("read")
  state?: LinkState;
}

@doc("The secret access keys used for authenticating connections to redis")
model AccessKeys {
  @doc("The current primary key that clients can use to authenticate")
  @visibility("read")
  primaryKey?: string;

  @doc("The current secondary key that clients can use to authenticate")
  @visibility("read")
  secondaryKey?: string;
}

@doc("Specifies which access keys to reset to a new random value.")
model RegenerateKeyParameters {
  @doc("Which access key to regenerate.")
  keyType: AccessKeyType;
}

@doc("Parameters for a Redis Enterprise import operation.")
model ImportClusterParameters {
  @doc("SAS URIs for the target blobs to import from")
  sasUris: string[];
}

@doc("Parameters for a Redis Enterprise export operation.")
model ExportClusterParameters {
  @doc("SAS URI for the target directory to export to")
  sasUri: string;
}

@doc("A list of private link resources")
@pagedResult
model PrivateLinkResourceListResult {
  @doc("Array of private link resources")
  @items
  value?: PrivateLinkResource[];
}

@doc("A private link resource")
model PrivateLinkResource extends Resource {
  @doc("Resource properties.")
  properties?: PrivateLinkResourceProperties;
}

@doc("Properties of a private link resource.")
model PrivateLinkResourceProperties {
  @doc("The private link resource group id.")
  @visibility("read")
  groupId?: string;

  @doc("The private link resource required member names.")
  @visibility("read")
  requiredMembers?: string[];

  @doc("The private link resource Private link DNS zone name.")
  requiredZoneNames?: string[];
}

@doc("Parameters for a Redis Enterprise Active Geo Replication Force Unlink operation.")
model ForceUnlinkParameters {
  @doc("The resource IDs of the database resources to be unlinked.")
  ids: string[];
}

@doc("Parameters for a Redis Enterprise active geo-replication flush operation.")
model FlushParameters {
  @doc("The resource identifiers of all the other database resources in the georeplication group to be flushed")
  ids?: string[];
}

@doc("List of details about all the available SKUs")
@pagedResult
model RegionSkuDetails {
  @doc("List of Sku Detail")
  @items
  value?: RegionSkuDetail[];
}

@doc("Details about the location requested and the available skus in the location")
model RegionSkuDetail {
  @doc("Resource type which has the SKU, such as Microsoft.Cache/redisEnterprise")
  resourceType?: string;

  @doc("Details about location and its capabilities")
  locationInfo?: LocationInfo;

  @doc("Details about available skus")
  skuDetails?: SkuDetail;
}

@doc("Information about location (for example: features that it supports)")
model LocationInfo {
  @doc("Location name")
  location?: string;

  @doc("List of capabilities")
  capabilities?: Capability[];
}

@doc("Information about the features the location supports")
model Capability {
  @doc("Feature name")
  name?: string;

  @doc("Indicates whether feature is supported or not")
  value?: boolean;
}

@doc("Information about Sku")
model SkuDetail {
  @doc("The type of RedisEnterprise cluster to deploy. Possible values: (Enterprise_E10, EnterpriseFlash_F300 etc.)")
  name?: SkuName;
}

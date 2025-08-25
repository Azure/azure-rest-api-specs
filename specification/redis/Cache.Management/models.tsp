import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Microsoft.Cache;

/**
 * The type of Redis cache to deploy. Valid values: (Basic, Standard, Premium)
 */
union SkuName {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Basic: "Basic",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Standard: "Standard",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Premium: "Premium",
}

/**
 * The SKU family to use. Valid values: (C, P). (C = Basic/Standard, P = Premium).
 */
union SkuFamily {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  C: "C",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  P: "P",
}

/**
 * Optional: requires clients to use a specified TLS version (or higher) to connect (e,g, '1.0', '1.1', '1.2')
 */
union TlsVersion {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  `1.0`: "1.0",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  `1.1`: "1.1",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  `1.2`: "1.2",
}

/**
 * Whether or not public endpoint access is allowed for this cache.  Value is optional but if passed in, must be 'Enabled' or 'Disabled'. If 'Disabled', private endpoints are the exclusive access method. Default value is 'Enabled'
 */
union PublicNetworkAccess {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Enabled: "Enabled",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Disabled: "Disabled",
}

/**
 * Optional: Specifies the update channel for the monthly Redis updates your Redis Cache will receive. Caches using 'Preview' update channel get latest Redis updates at least 4 weeks ahead of 'Stable' channel caches. Default value is 'Stable'.
 */
union UpdateChannel {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Stable: "Stable",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Preview: "Preview",
}

/**
 * Optional: Specifies how availability zones are allocated to the Redis cache. 'Automatic' enables zone redundancy and Azure will automatically select zones based on regional availability and capacity. 'UserDefined' will select availability zones passed in by you using the 'zones' parameter. 'NoZones' will produce a non-zonal cache. If 'zonalAllocationPolicy' is not passed, it will be set to 'UserDefined' when zones are passed in, otherwise, it will be set to 'Automatic' in regions where zones are supported and 'NoZones' in regions where zones are not supported.
 */
union ZonalAllocationPolicy {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Automatic: "Automatic",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  UserDefined: "UserDefined",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  NoZones: "NoZones",
}

/**
 * Redis instance provisioning status.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
union ProvisioningState {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Creating: "Creating",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Deleting: "Deleting",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Disabled: "Disabled",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Failed: "Failed",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Linking: "Linking",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Provisioning: "Provisioning",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  RecoveringScaleFailure: "RecoveringScaleFailure",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Scaling: "Scaling",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Succeeded: "Succeeded",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Unlinking: "Unlinking",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Unprovisioning: "Unprovisioning",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Updating: "Updating",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  ConfiguringAAD: "ConfiguringAAD",
}

/**
 * Which Redis node(s) to reboot. Depending on this value data loss is possible.
 */
union RebootType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  PrimaryNode: "PrimaryNode",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  SecondaryNode: "SecondaryNode",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  AllNodes: "AllNodes",
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
union DefaultName {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  default: "default",
}

/**
 * Provisioning state of access policy
 */
union AccessPolicyProvisioningState {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Updating: "Updating",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Succeeded: "Succeeded",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Deleting: "Deleting",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Deleted: "Deleted",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Canceled: "Canceled",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Failed: "Failed",
}

/**
 * Built-In or Custom access policy
 */
union AccessPolicyType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Custom: "Custom",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  BuiltIn: "BuiltIn",
}

/**
 * Provisioning state of an access policy assignment set
 */
union AccessPolicyAssignmentProvisioningState {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Updating: "Updating",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Succeeded: "Succeeded",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Deleting: "Deleting",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Deleted: "Deleted",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Canceled: "Canceled",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Failed: "Failed",
}

/**
 * The Redis access key to regenerate.
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
enum RedisKeyType {
  Primary,
  Secondary,
}

/**
 * Day of the week when a cache can be patched.
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
enum DayOfWeek {
  Monday,
  Tuesday,
  Wednesday,
  Thursday,
  Friday,
  Saturday,
  Sunday,
  Everyday,
  Weekend,
}

/**
 * Role of the linked server.
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
enum ReplicationRole {
  Primary,
  Secondary,
}

/**
 * REST API operation
 */
model Operation {
  /**
   * Operation name: {provider}/{resource}/{operation}
   */
  name?: string;

  /**
   * The object that describes the operation.
   */
  display?: OperationDisplay;
}

/**
 * The object that describes the operation.
 */
model OperationDisplay {
  /**
   * Friendly name of the resource provider
   */
  provider?: string;

  /**
   * Operation type: read, write, delete, listKeys/action, etc.
   */
  operation?: string;

  /**
   * Resource type on which the operation is performed.
   */
  resource?: string;

  /**
   * Friendly name of the operation
   */
  description?: string;
}

/**
 * Parameters body to pass for resource name availability check.
 */
model CheckNameAvailabilityParameters {
  /**
   * Resource name.
   */
  name: string;

  /**
   * Resource type. The only legal value of this property for checking redis cache name availability is 'Microsoft.Cache/redis'.
   */
  type: string;
}

/**
 * The response of listUpgradeNotifications.
 */
model NotificationListResponse is Azure.Core.Page<UpgradeNotification>;

/**
 * Properties of upgrade notification.
 */
model UpgradeNotification {
  /**
   * Name of upgrade notification.
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * Timestamp when upgrade notification occurred.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  timestamp?: utcDateTime;

  /**
   * Details about this upgrade notification
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  upsellNotification?: Record<string>;
}

/**
 * Parameters supplied to the Create Redis operation.
 */
model RedisCreateParameters {
  /**
   * Redis cache properties.
   */
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  properties: RedisCreateProperties;

  /**
   * A list of availability zones denoting where the resource needs to come from.
   */
  zones?: string[];

  /**
   * The geo-location where the resource lives
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  location: string;

  /**
   * Resource tags.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  tags?: Record<string>;

  /**
   * The identity of the resource.
   */
  identity?: Azure.ResourceManager.CommonTypes.ManagedServiceIdentity;
}

/**
 * Properties supplied to Create Redis operation.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.armExternalType
model RedisCreateProperties extends RedisCommonProperties {
  /**
   * The SKU of the Redis cache to deploy.
   */
  sku: Sku;

  /**
   * The full resource ID of a subnet in a virtual network to deploy the Redis cache in. Example format: /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/Microsoft.{Network|ClassicNetwork}/VirtualNetworks/vnet1/subnets/subnet1
   */
  @pattern("^/subscriptions/[^/]*/resourceGroups/[^/]*/providers/Microsoft.(ClassicNetwork|Network)/virtualNetworks/[^/]*/subnets/[^/]*$")
  subnetId?: string;

  /**
   * Static IP address. Optionally, may be specified when deploying a Redis cache inside an existing Azure Virtual Network; auto assigned by default.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read, Lifecycle.Create)
  @pattern("^\\d+\\.\\d+\\.\\d+\\.\\d+$")
  staticIP?: string;
}

/**
 * SKU parameters supplied to the create Redis operation.
 */
model Sku {
  /**
   * The type of Redis cache to deploy. Valid values: (Basic, Standard, Premium)
   */
  name: SkuName;

  /**
   * The SKU family to use. Valid values: (C, P). (C = Basic/Standard, P = Premium).
   */
  family: SkuFamily;

  /**
   * The size of the Redis cache to deploy. Valid values: for C (Basic/Standard) family (0, 1, 2, 3, 4, 5, 6), for P (Premium) family (1, 2, 3, 4).
   */
  capacity: int32;
}

/**
 * Create/Update/Get common properties of the redis cache.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.armExternalType
model RedisCommonProperties {
  /**
   * All Redis Settings. Few possible keys: rdb-backup-enabled,rdb-storage-connection-string,rdb-backup-frequency,maxmemory-delta, maxmemory-policy,notify-keyspace-events, aof-backup-enabled, aof-storage-connection-string-0, aof-storage-connection-string-1 etc.
   */
  redisConfiguration?: RedisCommonPropertiesRedisConfiguration;

  /**
   * Redis version. This should be in the form 'major[.minor]' (only 'major' is required) or the value 'latest' which refers to the latest stable Redis version that is available. Supported versions: 4.0, 6.0 (latest). Default value is 'latest'.
   */
  redisVersion?: string;

  /**
   * Specifies whether the non-ssl Redis server port (6379) is enabled.
   */
  enableNonSslPort?: boolean = false;

  /**
   * The number of replicas to be created per primary.
   */
  replicasPerMaster?: int32;

  /**
   * The number of replicas to be created per primary.
   */
  replicasPerPrimary?: int32;

  /**
   * A dictionary of tenant settings
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  tenantSettings?: Record<string>;

  /**
   * The number of shards to be created on a Premium Cluster Cache.
   */
  shardCount?: int32;

  /**
   * Optional: requires clients to use a specified TLS version (or higher) to connect (e,g, '1.0', '1.1', '1.2')
   */
  minimumTlsVersion?: TlsVersion;

  /**
   * Whether or not public endpoint access is allowed for this cache.  Value is optional but if passed in, must be 'Enabled' or 'Disabled'. If 'Disabled', private endpoints are the exclusive access method. Default value is 'Enabled'
   */
  publicNetworkAccess?: PublicNetworkAccess = PublicNetworkAccess.Enabled;

  /**
   * Optional: Specifies the update channel for the monthly Redis updates your Redis Cache will receive. Caches using 'Preview' update channel get latest Redis updates at least 4 weeks ahead of 'Stable' channel caches. Default value is 'Stable'.
   */
  updateChannel?: UpdateChannel;

  /**
   * Authentication to Redis through access keys is disabled when set as true. Default value is false.
   */
  disableAccessKeyAuthentication?: boolean = false;

  /**
   * Optional: Specifies how availability zones are allocated to the Redis cache. 'Automatic' enables zone redundancy and Azure will automatically select zones based on regional availability and capacity. 'UserDefined' will select availability zones passed in by you using the 'zones' parameter. 'NoZones' will produce a non-zonal cache. If 'zonalAllocationPolicy' is not passed, it will be set to 'UserDefined' when zones are passed in, otherwise, it will be set to 'Automatic' in regions where zones are supported and 'NoZones' in regions where zones are not supported.
   */
  zonalAllocationPolicy?: ZonalAllocationPolicy;
}

/**
 * All Redis Settings. Few possible keys: rdb-backup-enabled,rdb-storage-connection-string,rdb-backup-frequency,maxmemory-delta, maxmemory-policy,notify-keyspace-events, aof-backup-enabled, aof-storage-connection-string-0, aof-storage-connection-string-1 etc.
 */
model RedisCommonPropertiesRedisConfiguration {
  ...Record<unknown>;

  /**
   * Specifies whether the rdb backup is enabled
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  `rdb-backup-enabled`?: string;

  /**
   * Specifies the frequency for creating rdb backup in minutes. Valid values: (15, 30, 60, 360, 720, 1440)
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  `rdb-backup-frequency`?: string;

  /**
   * Specifies the maximum number of snapshots for rdb backup
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  `rdb-backup-max-snapshot-count`?: string;

  /**
   * The storage account connection string for storing rdb file
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  `rdb-storage-connection-string`?: string;

  /**
   * Specifies whether the aof backup is enabled
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  `aof-backup-enabled`?: string;

  /**
   * First storage account connection string
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  `aof-storage-connection-string-0`?: string;

  /**
   * Second storage account connection string
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  `aof-storage-connection-string-1`?: string;

  /**
   * Value in megabytes reserved for fragmentation per shard
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  `maxfragmentationmemory-reserved`?: string;

  /**
   * The eviction strategy used when your data won't fit within its memory limit.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  `maxmemory-policy`?: string;

  /**
   * Value in megabytes reserved for non-cache usage per shard e.g. failover.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  `maxmemory-reserved`?: string;

  /**
   * Value in megabytes reserved for non-cache usage per shard e.g. failover.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  `maxmemory-delta`?: string;

  /**
   * The max clients config
   */
  @visibility(Lifecycle.Read)
  maxclients?: string;

  /**
   * The keyspace events which should be monitored.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  `notify-keyspace-events`?: string;

  /**
   * Preferred auth method to communicate to storage account used for data archive, specify SAS or ManagedIdentity, default value is SAS
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  `preferred-data-archive-auth-method`?: string;

  /**
   * Preferred auth method to communicate to storage account used for data persistence, specify SAS or ManagedIdentity, default value is SAS
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  `preferred-data-persistence-auth-method`?: string;

  /**
   * Zonal Configuration
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  `zonal-configuration`?: string;

  /**
   * Specifies whether the authentication is disabled. Setting this property is highly discouraged from security point of view.
   */
  authnotrequired?: string;

  /**
   * SubscriptionId of the storage account for persistence (aof/rdb) using ManagedIdentity.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  `storage-subscription-id`?: string;

  /**
   * Specifies whether AAD based authentication has been enabled or disabled for the cache
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  `aad-enabled`?: string;
}

/**
 * Properties of the redis cache.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.armExternalType
model RedisProperties extends RedisCreateProperties {
  /**
   * Redis instance provisioning status.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  /**
   * Redis host name.
   */
  @visibility(Lifecycle.Read)
  hostName?: string;

  /**
   * Redis non-SSL port.
   */
  @visibility(Lifecycle.Read)
  port?: int32;

  /**
   * Redis SSL port.
   */
  @visibility(Lifecycle.Read)
  sslPort?: int32;

  /**
   * The keys of the Redis cache - not set if this object is not the response to Create or Update redis cache
   */
  @visibility(Lifecycle.Read)
  accessKeys?: RedisAccessKeys;

  /**
   * List of the linked servers associated with the cache
   */
  @visibility(Lifecycle.Read)
  linkedServers?: RedisLinkedServer[];

  /**
   * List of the Redis instances associated with the cache
   */
  @visibility(Lifecycle.Read)
  @OpenAPI.extension("x-ms-identifiers", #["shardId"])
  instances?: RedisInstanceDetails[];

  /**
   * List of private endpoint connection associated with the specified redis cache
   */
  @visibility(Lifecycle.Read)
  privateEndpointConnections?: PrivateEndpointConnection[];
}

/**
 * Redis cache access keys.
 */
model RedisAccessKeys {
  /**
   * The current primary key that clients can use to authenticate with Redis cache.
   */
  @visibility(Lifecycle.Read)
  primaryKey?: string;

  /**
   * The current secondary key that clients can use to authenticate with Redis cache.
   */
  @visibility(Lifecycle.Read)
  secondaryKey?: string;
}

/**
 * Linked server Id
 */
model RedisLinkedServer {
  /**
   * Linked server Id.
   */
  @visibility(Lifecycle.Read)
  id?: string;
}

/**
 * Details of single instance of redis.
 */
model RedisInstanceDetails {
  /**
   * Redis instance SSL port.
   */
  @visibility(Lifecycle.Read)
  sslPort?: int32;

  /**
   * If enableNonSslPort is true, provides Redis instance Non-SSL port.
   */
  @visibility(Lifecycle.Read)
  nonSslPort?: int32;

  /**
   * If the Cache uses availability zones, specifies availability zone where this instance is located.
   */
  @visibility(Lifecycle.Read)
  zone?: string;

  /**
   * If clustering is enabled, the Shard ID of Redis Instance
   */
  @visibility(Lifecycle.Read)
  shardId?: int32;

  /**
   * Specifies whether the instance is a primary node.
   */
  @visibility(Lifecycle.Read)
  isMaster?: boolean;

  /**
   * Specifies whether the instance is a primary node.
   */
  @visibility(Lifecycle.Read)
  isPrimary?: boolean;
}

/**
 * Parameters supplied to the Update Redis operation.
 */
model RedisUpdateParameters {
  /**
   * Redis cache properties.
   */
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  properties?: RedisUpdateProperties;

  /**
   * Resource tags.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  tags?: Record<string>;

  /**
   * The identity of the resource.
   */
  identity?: Azure.ResourceManager.CommonTypes.ManagedServiceIdentity;
}

/**
 * Patchable properties of the redis cache.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.armExternalType
model RedisUpdateProperties extends RedisCommonProperties {
  /**
   * The SKU of the Redis cache to deploy.
   */
  sku?: Sku;
}

/**
 * Specifies which Redis access keys to reset.
 */
model RedisRegenerateKeyParameters {
  /**
   * The Redis access key to regenerate.
   */
  keyType: RedisKeyType;
}

/**
 * Specifies which Redis node(s) to reboot.
 */
model RedisRebootParameters {
  /**
   * Which Redis node(s) to reboot. Depending on this value data loss is possible.
   */
  rebootType?: RebootType;

  /**
   * If clustering is enabled, the ID of the shard to be rebooted.
   */
  shardId?: int32;

  /**
   * A list of redis instances to reboot, specified by per-instance SSL ports or non-SSL ports.
   */
  ports?: int32[];
}

/**
 * Response to force reboot for Redis cache.
 */
model RedisForceRebootResponse {
  /**
   * Status message
   */
  @visibility(Lifecycle.Read)
  message?: string;
}

/**
 * Parameters for Redis import operation.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model ImportRDBParameters {
  /**
   * File format.
   */
  format?: string;

  /**
   * files to import.
   */
  files: string[];

  /**
   * Preferred auth method to communicate to storage account used for data archive, specify SAS or ManagedIdentity, default value is SAS
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  `preferred-data-archive-auth-method`?: string;

  /**
   * Subscription id of the storage container containing files to import using Managed Identity.
   */
  `storage-subscription-id`?: string;
}

/**
 * Parameters for Redis export operation.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model ExportRDBParameters {
  /**
   * File format.
   */
  format?: string;

  /**
   * Prefix to use for exported files.
   */
  prefix: string;

  /**
   * Container name to export to.
   */
  container: string;

  /**
   * Preferred auth method to communicate to storage account used for data archive, specify SAS or ManagedIdentity, default value is SAS
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  `preferred-data-archive-auth-method`?: string;

  /**
   * Subscription id of the storage container for data to be exported using ManagedIdentity.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  `storage-subscription-id`?: string;
}

/**
 * Specifies a range of IP addresses permitted to connect to the cache
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model RedisFirewallRuleProperties {
  /**
   * lowest IP address included in the range
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  startIP: string;

  /**
   * highest IP address included in the range
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  endIP: string;
}

/**
 * List of patch schedules for a Redis cache.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model ScheduleEntries {
  /**
   * List of patch schedules for a Redis cache.
   */
  #suppress "@azure-tools/typespec-client-generator-core/property-name-conflict" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @OpenAPI.extension("x-ms-identifiers", #[])
  scheduleEntries: ScheduleEntry[];
}

/**
 * Patch schedule entry for a Premium Redis Cache.
 */
model ScheduleEntry {
  /**
   * Day of the week when a cache can be patched.
   */
  dayOfWeek: DayOfWeek;

  /**
   * Start hour after which cache patching can start.
   */
  startHourUtc: int32;

  /**
   * ISO8601 timespan specifying how much time cache patching can take.
   */
  maintenanceWindow?: duration;
}

/**
 * Parameter required for creating a linked server to redis cache.
 */
model RedisLinkedServerCreateParameters {
  /**
   * Properties required to create a linked server.
   */
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  properties: RedisLinkedServerCreateProperties;
}

/**
 * Create properties for a linked server
 */
model RedisLinkedServerCreateProperties {
  /**
   * Fully qualified resourceId of the linked redis cache.
   */
  linkedRedisCacheId: string;

  /**
   * Location of the linked redis cache.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  linkedRedisCacheLocation: string;

  /**
   * Role of the linked server.
   */
  serverRole: ReplicationRole;

  /**
   * The unchanging DNS name which will always point to current geo-primary cache among the linked redis caches for seamless Geo Failover experience.
   */
  @visibility(Lifecycle.Read)
  geoReplicatedPrimaryHostName?: string;

  /**
   * The changing DNS name that resolves to the current geo-primary cache among the linked redis caches before or after the Geo Failover.
   */
  @visibility(Lifecycle.Read)
  primaryHostName?: string;
}

/**
 * Properties of a linked server to be returned in get/put response
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model RedisLinkedServerProperties extends RedisLinkedServerCreateProperties {
  /**
   * Terminal state of the link between primary and secondary redis cache.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  provisioningState?: string;
}

/**
 * List of linked servers (with properties) of a Redis cache.
 */
model RedisLinkedServerWithPropertiesList
  is Azure.Core.Page<RedisLinkedServerWithProperties>;

/**
 * The response of list Redis operation.
 */
model RedisListResult is Azure.Core.Page<RedisResource>;

/**
 * Asynchronous operation status
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model OperationStatus
  extends Azure.ResourceManager.CommonTypes.OperationStatusResult {
  /**
   * Additional properties from RP, only when operation is successful
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  properties?: Record<unknown>;
}

/**
 * All properties of an access policy.
 */
model RedisCacheAccessPolicyProperties {
  /**
   * Provisioning state of access policy
   */
  @visibility(Lifecycle.Read)
  provisioningState?: AccessPolicyProvisioningState;

  /**
   * Built-In or Custom access policy
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-duplicate-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  type?: AccessPolicyType;

  /**
   * Permissions for the access policy. Learn how to configure permissions at https://aka.ms/redis/AADPreRequisites
   */
  permissions: string;
}

/**
 * List of access policies (with properties) of a Redis cache.
 */
model RedisCacheAccessPolicyList is Azure.Core.Page<RedisCacheAccessPolicy>;

/**
 * Properties for an access policy assignment
 */
model RedisCacheAccessPolicyAssignmentProperties {
  /**
   * Provisioning state of an access policy assignment set
   */
  @visibility(Lifecycle.Read)
  provisioningState?: AccessPolicyAssignmentProvisioningState;

  /**
   * Object Id to assign access policy to
   */
  objectId: string;

  /**
   * User friendly name for object id. Also represents username for token based authentication
   */
  objectIdAlias: string;

  /**
   * The name of the access policy that is being assigned
   */
  @pattern("^([a-zA-Z0-9][a-zA-Z0-9- ]*[a-zA-Z0-9]|[a-zA-Z0-9])$")
  accessPolicyName: string;
}

/**
 * List of access policies assignments (with properties) of a Redis cache.
 */
model RedisCacheAccessPolicyAssignmentList
  is Azure.Core.Page<RedisCacheAccessPolicyAssignment>;

/**
 * Parameters required for creating a firewall rule on redis cache. (Note, you can just use the FirewallRule type instead now.)
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/no-empty-model" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model RedisFirewallRuleCreateParameters extends RedisFirewallRule {}

/**
 * Result of the request to list REST API operations. It contains a list of operations and a URL nextLink to get the next set of results.
 */
model OperationListResult {
  /**
   * List of operations supported by the resource provider.
   */
  @pageItems
  @OpenAPI.extension("x-ms-identifiers", #["name"])
  value: Operation[];

  /**
   * URL to get the next set of operation list results if there are any.
   */
  @nextLink
  nextLink?: string;
}
@@OpenAPI.extension(NotificationListResponse.value,
  "x-ms-identifiers",
  #["name", "timestamp"]
);

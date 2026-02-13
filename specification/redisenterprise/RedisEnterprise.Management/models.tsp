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
 * The intended executor of the operation; as in Resource Based Access Control (RBAC) and audit logs UX. Default value is "user,system"
 */
union Origin {
  string,

  /**
   * user
   */
  User: "user",

  /**
   * system
   */
  System: "system",

  /**
   * user,system
   */
  UserSystem: "user,system",
}

/**
 * Enum. Indicates the action type. "Internal" refers to actions that are for internal only APIs.
 */
union ActionType {
  string,

  /**
   * Internal
   */
  Internal: "Internal",
}

/**
 * Distinguishes the kind of cluster. Read-only.
 */
union Kind {
  string,

  /**
   * v1
   */
  V1: "v1",

  /**
   * v2
   */
  V2: "v2",
}

/**
 * The level of Redis Enterprise cluster to deploy. Possible values: ('Balanced_B5', 'MemoryOptimized_M10', 'ComputeOptimized_X5', etc.). For more information on SKUs see the latest pricing documentation. Note that additional SKUs may become supported in the future.
 */
union SkuName {
  string,

  /**
   * Enterprise_E1
   */
  EnterpriseE1: "Enterprise_E1",

  /**
   * Enterprise_E5
   */
  EnterpriseE5: "Enterprise_E5",

  /**
   * Enterprise_E10
   */
  EnterpriseE10: "Enterprise_E10",

  /**
   * Enterprise_E20
   */
  EnterpriseE20: "Enterprise_E20",

  /**
   * Enterprise_E50
   */
  EnterpriseE50: "Enterprise_E50",

  /**
   * Enterprise_E100
   */
  EnterpriseE100: "Enterprise_E100",

  /**
   * Enterprise_E200
   */
  EnterpriseE200: "Enterprise_E200",

  /**
   * Enterprise_E400
   */
  EnterpriseE400: "Enterprise_E400",

  /**
   * EnterpriseFlash_F300
   */
  EnterpriseFlashF300: "EnterpriseFlash_F300",

  /**
   * EnterpriseFlash_F700
   */
  EnterpriseFlashF700: "EnterpriseFlash_F700",

  /**
   * EnterpriseFlash_F1500
   */
  EnterpriseFlashF1500: "EnterpriseFlash_F1500",

  /**
   * Balanced_B0
   */
  BalancedB0: "Balanced_B0",

  /**
   * Balanced_B1
   */
  BalancedB1: "Balanced_B1",

  /**
   * Balanced_B3
   */
  BalancedB3: "Balanced_B3",

  /**
   * Balanced_B5
   */
  BalancedB5: "Balanced_B5",

  /**
   * Balanced_B10
   */
  BalancedB10: "Balanced_B10",

  /**
   * Balanced_B20
   */
  BalancedB20: "Balanced_B20",

  /**
   * Balanced_B50
   */
  BalancedB50: "Balanced_B50",

  /**
   * Balanced_B100
   */
  BalancedB100: "Balanced_B100",

  /**
   * Balanced_B150
   */
  BalancedB150: "Balanced_B150",

  /**
   * Balanced_B250
   */
  BalancedB250: "Balanced_B250",

  /**
   * Balanced_B350
   */
  BalancedB350: "Balanced_B350",

  /**
   * Balanced_B500
   */
  BalancedB500: "Balanced_B500",

  /**
   * Balanced_B700
   */
  BalancedB700: "Balanced_B700",

  /**
   * Balanced_B1000
   */
  BalancedB1000: "Balanced_B1000",

  /**
   * MemoryOptimized_M10
   */
  MemoryOptimizedM10: "MemoryOptimized_M10",

  /**
   * MemoryOptimized_M20
   */
  MemoryOptimizedM20: "MemoryOptimized_M20",

  /**
   * MemoryOptimized_M50
   */
  MemoryOptimizedM50: "MemoryOptimized_M50",

  /**
   * MemoryOptimized_M100
   */
  MemoryOptimizedM100: "MemoryOptimized_M100",

  /**
   * MemoryOptimized_M150
   */
  MemoryOptimizedM150: "MemoryOptimized_M150",

  /**
   * MemoryOptimized_M250
   */
  MemoryOptimizedM250: "MemoryOptimized_M250",

  /**
   * MemoryOptimized_M350
   */
  MemoryOptimizedM350: "MemoryOptimized_M350",

  /**
   * MemoryOptimized_M500
   */
  MemoryOptimizedM500: "MemoryOptimized_M500",

  /**
   * MemoryOptimized_M700
   */
  MemoryOptimizedM700: "MemoryOptimized_M700",

  /**
   * MemoryOptimized_M1000
   */
  MemoryOptimizedM1000: "MemoryOptimized_M1000",

  /**
   * MemoryOptimized_M1500
   */
  MemoryOptimizedM1500: "MemoryOptimized_M1500",

  /**
   * MemoryOptimized_M2000
   */
  MemoryOptimizedM2000: "MemoryOptimized_M2000",

  /**
   * ComputeOptimized_X3
   */
  ComputeOptimizedX3: "ComputeOptimized_X3",

  /**
   * ComputeOptimized_X5
   */
  ComputeOptimizedX5: "ComputeOptimized_X5",

  /**
   * ComputeOptimized_X10
   */
  ComputeOptimizedX10: "ComputeOptimized_X10",

  /**
   * ComputeOptimized_X20
   */
  ComputeOptimizedX20: "ComputeOptimized_X20",

  /**
   * ComputeOptimized_X50
   */
  ComputeOptimizedX50: "ComputeOptimized_X50",

  /**
   * ComputeOptimized_X100
   */
  ComputeOptimizedX100: "ComputeOptimized_X100",

  /**
   * ComputeOptimized_X150
   */
  ComputeOptimizedX150: "ComputeOptimized_X150",

  /**
   * ComputeOptimized_X250
   */
  ComputeOptimizedX250: "ComputeOptimized_X250",

  /**
   * ComputeOptimized_X350
   */
  ComputeOptimizedX350: "ComputeOptimized_X350",

  /**
   * ComputeOptimized_X500
   */
  ComputeOptimizedX500: "ComputeOptimized_X500",

  /**
   * ComputeOptimized_X700
   */
  ComputeOptimizedX700: "ComputeOptimized_X700",

  /**
   * FlashOptimized_A250
   */
  FlashOptimizedA250: "FlashOptimized_A250",

  /**
   * FlashOptimized_A500
   */
  FlashOptimizedA500: "FlashOptimized_A500",

  /**
   * FlashOptimized_A700
   */
  FlashOptimizedA700: "FlashOptimized_A700",

  /**
   * FlashOptimized_A1000
   */
  FlashOptimizedA1000: "FlashOptimized_A1000",

  /**
   * FlashOptimized_A1500
   */
  FlashOptimizedA1500: "FlashOptimized_A1500",

  /**
   * FlashOptimized_A2000
   */
  FlashOptimizedA2000: "FlashOptimized_A2000",

  /**
   * FlashOptimized_A4500
   */
  FlashOptimizedA4500: "FlashOptimized_A4500",
}

/**
 * Whether or not public network traffic can access the Redis cluster. Only 'Enabled' or 'Disabled' can be set. null is returned only for clusters created using an old API version which do not have this property and cannot be set.
 */
union PublicNetworkAccess {
  string,

  /**
   * Enabled
   */
  Enabled: "Enabled",

  /**
   * Disabled
   */
  Disabled: "Disabled",
}

/**
 * Enabled by default. If highAvailability is disabled, the data set is not replicated. This affects the availability SLA, and increases the risk of data loss.
 */
union HighAvailability {
  string,

  /**
   * Enabled
   */
  Enabled: "Enabled",

  /**
   * Disabled
   */
  Disabled: "Disabled",
}

/**
 * The minimum TLS version for the cluster to support, e.g. '1.2'. Newer versions can be added in the future. Note that TLS 1.0 and TLS 1.1 are now completely obsolete -- you cannot use them. They are mentioned only for the sake of consistency with old API versions.
 */
union TlsVersion {
  string,

  /**
   * 1.0
   */
  One0: "1.0",

  /**
   * 1.1
   */
  One1: "1.1",

  /**
   * 1.2
   */
  One2: "1.2",
}

/**
 * Only userAssignedIdentity is supported in this API version; other types may be supported in the future
 */
union CmkIdentityType {
  string,

  /**
   * systemAssignedIdentity
   */
  SystemAssignedIdentity: "systemAssignedIdentity",

  /**
   * userAssignedIdentity
   */
  UserAssignedIdentity: "userAssignedIdentity",
}

/**
 * Current provisioning status
 */
union ProvisioningState {
  string,

  /**
   * Succeeded
   */
  Succeeded: "Succeeded",

  /**
   * Failed
   */
  Failed: "Failed",

  /**
   * Canceled
   */
  Canceled: "Canceled",

  /**
   * Creating
   */
  Creating: "Creating",

  /**
   * Updating
   */
  Updating: "Updating",

  /**
   * Deleting
   */
  Deleting: "Deleting",
}

/**
 * Explains the current redundancy strategy of the cluster, which affects the expected SLA.
 */
union RedundancyMode {
  string,

  /**
   * No redundancy. Availability loss will occur.
   */
  None: "None",

  /**
   * Local redundancy with high availability.
   */
  LR: "LR",

  /**
   * Zone redundant. Higher availability.
   */
  ZR: "ZR",
}

/**
 * Current resource status
 */
union ResourceState {
  string,

  /**
   * Running
   */
  Running: "Running",

  /**
   * Creating
   */
  Creating: "Creating",

  /**
   * CreateFailed
   */
  CreateFailed: "CreateFailed",

  /**
   * Updating
   */
  Updating: "Updating",

  /**
   * UpdateFailed
   */
  UpdateFailed: "UpdateFailed",

  /**
   * Deleting
   */
  Deleting: "Deleting",

  /**
   * DeleteFailed
   */
  DeleteFailed: "DeleteFailed",

  /**
   * Enabling
   */
  Enabling: "Enabling",

  /**
   * EnableFailed
   */
  EnableFailed: "EnableFailed",

  /**
   * Disabling
   */
  Disabling: "Disabling",

  /**
   * DisableFailed
   */
  DisableFailed: "DisableFailed",

  /**
   * Disabled
   */
  Disabled: "Disabled",

  /**
   * Scaling
   */
  Scaling: "Scaling",

  /**
   * ScalingFailed
   */
  ScalingFailed: "ScalingFailed",

  /**
   * Moving
   */
  Moving: "Moving",
}

/**
 * Specifies whether redis clients can connect using TLS-encrypted or plaintext redis protocols. Default is TLS-encrypted.
 */
union Protocol {
  string,

  /**
   * Encrypted
   */
  Encrypted: "Encrypted",

  /**
   * Plaintext
   */
  Plaintext: "Plaintext",
}

/**
 * Clustering policy - default is OSSCluster. This property can be updated only if the current value is NoCluster. If the value is OSSCluster or EnterpriseCluster, it cannot be updated without deleting the database.
 */
union ClusteringPolicy {
  string,

  /**
   * Enterprise clustering policy uses only the classic redis protocol, which does not support redis cluster commands.
   */
  EnterpriseCluster: "EnterpriseCluster",

  /**
   * OSS clustering policy follows the redis cluster specification, and requires all clients to support redis clustering.
   */
  OSSCluster: "OSSCluster",

  /**
   * The NoCluster policy is used for non-clustered Redis instances that do not require clustering features.
   */
  NoCluster: "NoCluster",
}

/**
 * Redis eviction policy - default is VolatileLRU
 */
union EvictionPolicy {
  string,

  /**
   * AllKeysLFU
   */
  AllKeysLFU: "AllKeysLFU",

  /**
   * AllKeysLRU
   */
  AllKeysLRU: "AllKeysLRU",

  /**
   * AllKeysRandom
   */
  AllKeysRandom: "AllKeysRandom",

  /**
   * VolatileLRU
   */
  VolatileLRU: "VolatileLRU",

  /**
   * VolatileLFU
   */
  VolatileLFU: "VolatileLFU",

  /**
   * VolatileTTL
   */
  VolatileTTL: "VolatileTTL",

  /**
   * VolatileRandom
   */
  VolatileRandom: "VolatileRandom",

  /**
   * NoEviction
   */
  NoEviction: "NoEviction",
}

/**
 * Sets the frequency at which data is written to disk. Defaults to '1s', meaning 'every second'. Note that the 'always' setting is deprecated, because of its performance impact.
 */
union AofFrequency {
  string,

  /**
   * 1s
   */
  OneS: "1s",

  /**
   * always
   */
  Always: "always",
}

/**
 * Sets the frequency at which a snapshot of the database is created.
 */
union RdbFrequency {
  string,

  /**
   * 1h
   */
  OneH: "1h",

  /**
   * 6h
   */
  SixH: "6h",

  /**
   * 12h
   */
  TwelveH: "12h",
}

/**
 * State of the link between the database resources.
 */
union LinkState {
  string,

  /**
   * Linked
   */
  Linked: "Linked",

  /**
   * Linking
   */
  Linking: "Linking",

  /**
   * Unlinking
   */
  Unlinking: "Unlinking",

  /**
   * LinkFailed
   */
  LinkFailed: "LinkFailed",

  /**
   * UnlinkFailed
   */
  UnlinkFailed: "UnlinkFailed",
}

/**
 * Option to defer upgrade when newest version is released - default is NotDeferred. Learn more: https://aka.ms/redisversionupgrade
 */
union DeferUpgradeSetting {
  string,

  /**
   * Deferred
   */
  Deferred: "Deferred",

  /**
   * NotDeferred
   */
  NotDeferred: "NotDeferred",
}

/**
 * This property can be Enabled/Disabled to allow or deny access with the current access keys. Can be updated even after database is created.
 */
union AccessKeysAuthentication {
  string,

  /**
   * Disabled
   */
  Disabled: "Disabled",

  /**
   * Enabled
   */
  Enabled: "Enabled",
}

/**
 * The type of identity that created the resource.
 */
union CreatedByType {
  string,

  /**
   * User
   */
  User: "User",

  /**
   * Application
   */
  Application: "Application",

  /**
   * ManagedIdentity
   */
  ManagedIdentity: "ManagedIdentity",

  /**
   * Key
   */
  Key: "Key",
}

/**
 * Describes the source of the migration operation.
 */
union SourceType {
  string,

  /**
   * Migration from Azure Cache for Redis to Redis Enterprise.
   */
  AzureCacheForRedis: "AzureCacheForRedis",
}

/**
 * Current provisioning status
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
union MigrationProvisioningState {
  string,

  /**
   * The request has been accepted and the migration operation is being initialized.
   */
  Accepted: "Accepted",

  /**
   * The migration operation is in progress.
   */
  InProgress: "InProgress",

  /**
   * The migration operation has completed transferring data and is ready for DNS switch.
   */
  ReadyForDnsSwitch: "ReadyForDnsSwitch",

  /**
   * The migration operation has completed successfully.
   */
  Succeeded: "Succeeded",

  /**
   * The migration operation has failed.
   */
  Failed: "Failed",

  /**
   * The migration operation is being cancelled.
   */
  Cancelling: "Cancelling",

  /**
   * The migration operation has been cancelled.
   */
  Cancelled: "Cancelled",
}

/**
 * Which access key to regenerate.
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
enum AccessKeyType {
  /**
   * Primary
   */
  Primary,

  /**
   * Secondary
   */
  Secondary,
}

/**
 * Localized display information for this particular operation.
 */
model OperationDisplay {
  /**
   * The localized friendly form of the resource provider name, e.g. "Microsoft Monitoring Insights" or "Microsoft Compute".
   */
  @visibility(Lifecycle.Read)
  provider?: string;

  /**
   * The localized friendly name of the resource type related to this operation. E.g. "Virtual Machines" or "Job Schedule Collections".
   */
  @visibility(Lifecycle.Read)
  resource?: string;

  /**
   * The concise, localized friendly name for the operation; suitable for dropdowns. E.g. "Create or Update Virtual Machine", "Restart Virtual Machine".
   */
  @visibility(Lifecycle.Read)
  operation?: string;

  /**
   * The short, localized friendly description of the operation; suitable for tool tips and detailed views.
   */
  @visibility(Lifecycle.Read)
  description?: string;
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
  startTime?: string;

  /**
   * The end time of the operation.
   */
  endTime?: string;

  /**
   * The current status of the operation.
   */
  status?: string;

  /**
   * Error response describing why the operation failed.
   */
  error?: Azure.ResourceManager.CommonTypes.ErrorResponse;
}

/**
 * SKU parameters supplied to the create Redis Enterprise cluster operation.
 */
model Sku {
  /**
   * The level of Redis Enterprise cluster to deploy. Possible values: ('Balanced_B5', 'MemoryOptimized_M10', 'ComputeOptimized_X5', etc.). For more information on SKUs see the latest pricing documentation. Note that additional SKUs may become supported in the future.
   */
  name: SkuName;

  /**
   * This property is only used with Enterprise and EnterpriseFlash SKUs. Determines the size of the cluster. Valid values are (2, 4, 6, ...) for Enterprise SKUs and (3, 9, 15, ...) for EnterpriseFlash SKUs.
   */
  capacity?: int32;
}

/**
 * Properties of Redis Enterprise clusters for create operations
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model ClusterCreateProperties extends ClusterProperties {
  /**
   * Whether or not public network traffic can access the Redis cluster. Only 'Enabled' or 'Disabled' can be set. null is returned only for clusters created using an old API version which do not have this property and cannot be set.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  publicNetworkAccess: PublicNetworkAccess | null;
}

/**
 * Properties of Redis Enterprise clusters, as opposed to general resource properties like location, tags
 */
model ClusterProperties {
  /**
   * Enabled by default. If highAvailability is disabled, the data set is not replicated. This affects the availability SLA, and increases the risk of data loss.
   */
  highAvailability?: HighAvailability;

  /**
   * The minimum TLS version for the cluster to support, e.g. '1.2'. Newer versions can be added in the future. Note that TLS 1.0 and TLS 1.1 are now completely obsolete -- you cannot use them. They are mentioned only for the sake of consistency with old API versions.
   */
  minimumTlsVersion?: TlsVersion;

  /**
   * Encryption-at-rest configuration for the cluster.
   */
  encryption?: ClusterPropertiesEncryption;

  /**
   * Cluster-level maintenance configuration.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  maintenanceConfiguration?: MaintenanceConfiguration;

  /**
   * DNS name of the cluster endpoint
   */
  @visibility(Lifecycle.Read)
  hostName?: string;

  /**
   * Current provisioning status of the cluster
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  /**
   * Explains the current redundancy strategy of the cluster, which affects the expected SLA.
   */
  @visibility(Lifecycle.Read)
  redundancyMode?: RedundancyMode;

  /**
   * Current resource status of the cluster
   */
  @visibility(Lifecycle.Read)
  resourceState?: ResourceState;

  /**
   * Version of redis the cluster supports, e.g. '6'
   */
  @visibility(Lifecycle.Read)
  redisVersion?: string;

  /**
   * List of private endpoint connections associated with the specified Redis Enterprise cluster
   */
  @visibility(Lifecycle.Read)
  privateEndpointConnections?: PrivateEndpointConnection[];
}

/** Cluster-level maintenance configuration. */
model MaintenanceConfiguration {
  /** Custom maintenance windows that apply to the cluster. */
  @identifiers(#[])
  maintenanceWindows?: MaintenanceWindow[];
}

/** A single custom maintenance window. */
model MaintenanceWindow {
  /** Maintenance window type. */
  type: MaintenanceWindowType;

  /** Duration in ISO-8601 format, for example 'PT5H'. */
  duration: string;

  /** Start hour (0-23) in UTC when the maintenance window begins. */
  @minValue(0)
  @maxValue(23)
  startHourUtc: int32;

  /** Recurring schedule for the maintenance window. */
  schedule: MaintenanceWindowSchedule;
}

/** Maintenance window type. */
union MaintenanceWindowType {
  string,

  /** Weekly maintenance window. */
  Weekly: "Weekly",
}

/** Schedule details for a maintenance window. */
model MaintenanceWindowSchedule {
  /** Day of week. Required when the maintenance window type is 'Weekly'. */
  dayOfWeek?: MaintenanceDayOfWeek;
}

/** Day of week. Required when the maintenance window type is 'Weekly'. */
union MaintenanceDayOfWeek {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Sunday: "Sunday",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Monday: "Monday",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Tuesday: "Tuesday",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Wednesday: "Wednesday",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Thursday: "Thursday",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Friday: "Friday",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Saturday: "Saturday",
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
  keyEncryptionKeyIdentity?: ClusterPropertiesEncryptionCustomerManagedKeyEncryptionKeyIdentity;

  /**
   * Key encryption key Url, versioned only. Ex: https://contosovault.vault.azure.net/keys/contosokek/562a4bb76b524a1493a6afe8e536ee78
   */
  keyEncryptionKeyUrl?: string;
}

/**
 * All identity configuration for Customer-managed key settings defining which identity should be used to auth to Key Vault.
 */
model ClusterPropertiesEncryptionCustomerManagedKeyEncryptionKeyIdentity {
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
 * A partial update to the Redis Enterprise cluster
 */
model ClusterUpdate {
  /**
   * The SKU to create, which affects price, performance, and features.
   */
  sku?: Sku;

  /**
   * Other properties of the cluster.
   */
  properties?: ClusterUpdateProperties;

  /**
   * The identity of the resource.
   */
  identity?: Azure.ResourceManager.CommonTypes.ManagedServiceIdentity;

  /**
   * Resource tags.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  tags?: Record<string>;
}

/**
 * Properties of Redis Enterprise clusters for update operations
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model ClusterUpdateProperties extends ClusterProperties {
  /**
   * Whether or not public network traffic can access the Redis cluster. Only 'Enabled' or 'Disabled' can be set. null is returned only for clusters created using an old API version which do not have this property and cannot be set.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  publicNetworkAccess?: PublicNetworkAccess | null;
}

/**
 * The response of a list-all operation.
 */
model ClusterList is Azure.Core.Page<Cluster>;

/**
 * The response of a list-all operation.
 */
model DatabaseList is Azure.Core.Page<Database>;

/**
 * Properties for creating Redis Enterprise databases
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model DatabaseCreateProperties extends DatabaseProperties {
  /**
   * This property can be Enabled/Disabled to allow or deny access with the current access keys. Can be updated even after database is created. Default is Disabled.
   */
  accessKeysAuthentication?: AccessKeysAuthentication = AccessKeysAuthentication.Disabled;
}

/**
 * Properties of Redis Enterprise databases, as opposed to general resource properties like location, tags
 */
model DatabaseProperties {
  /**
   * Specifies whether redis clients can connect using TLS-encrypted or plaintext redis protocols. Default is TLS-encrypted.
   */
  clientProtocol?: Protocol;

  /**
   * TCP port of the database endpoint. Specified at create time. Defaults to an available port.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  port?: int32;

  /**
   * Current provisioning status of the database
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  /**
   * Current resource status of the database
   */
  @visibility(Lifecycle.Read)
  resourceState?: ResourceState;

  /**
   * Clustering policy - default is OSSCluster. This property can be updated only if the current value is NoCluster. If the value is OSSCluster or EnterpriseCluster, it cannot be updated without deleting the database.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
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
  @visibility(Lifecycle.Read, Lifecycle.Create)
  @identifiers(#["name"])
  modules?: Module[];

  /**
   * Optional set of properties to configure geo replication for this database.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  geoReplication?: DatabasePropertiesGeoReplication;

  /**
   * Version of Redis the database is running on, e.g. '6.0'
   */
  @visibility(Lifecycle.Read)
  redisVersion?: string;

  /**
   * Option to defer upgrade when newest version is released - default is NotDeferred. Learn more: https://aka.ms/redisversionupgrade
   */
  deferUpgrade?: DeferUpgradeSetting;

  /**
   * This property can be Enabled/Disabled to allow or deny access with the current access keys. Can be updated even after database is created.
   */
  accessKeysAuthentication?: AccessKeysAuthentication;
}

/**
 * Persistence-related configuration for the Redis Enterprise database
 */
model Persistence {
  /**
   * Sets whether AOF is enabled. Note that at most one of AOF or RDB persistence may be enabled.
   */
  aofEnabled?: boolean;

  /**
   * Sets whether RDB is enabled. Note that at most one of AOF or RDB persistence may be enabled.
   */
  rdbEnabled?: boolean;

  /**
   * Sets the frequency at which data is written to disk. Defaults to '1s', meaning 'every second'. Note that the 'always' setting is deprecated, because of its performance impact.
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
  @visibility(Lifecycle.Read, Lifecycle.Create)
  name: string;

  /**
   * Configuration options for the module, e.g. 'ERROR_RATE 0.01 INITIAL_SIZE 400'.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  args?: string;

  /**
   * The version of the module, e.g. '1.0'.
   */
  @visibility(Lifecycle.Read)
  version?: string;
}

/**
 * Optional set of properties to configure geo replication for this database.
 */
model DatabasePropertiesGeoReplication {
  /**
   * Name for the group of linked database resources
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
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
  @visibility(Lifecycle.Read, Lifecycle.Create)
  id?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.Cache/redisEnterprise/databases";
    }
  ]>;

  /**
   * State of the link between the database resources.
   */
  @visibility(Lifecycle.Read)
  state?: LinkState;
}

/**
 * Common fields that are returned in the response for all Azure Resource Manager resources
 */
model ResourceAutoGenerated {
  /**
   * Fully qualified resource ID for the resource. Ex - /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/{resourceProviderNamespace}/{resourceType}/{resourceName}
   */
  @visibility(Lifecycle.Read)
  id?: string;

  /**
   * The name of the resource
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * The type of the resource. E.g. "Microsoft.Compute/virtualMachines" or "Microsoft.Storage/storageAccounts"
   */
  @visibility(Lifecycle.Read)
  type?: string;

  /**
   * Azure Resource Manager metadata containing createdBy and modifiedBy information.
   */
  @visibility(Lifecycle.Read)
  systemData?: SystemData;
}

/**
 * A partial update to the Redis Enterprise database
 */
model DatabaseUpdate {
  /**
   * Properties of the database.
   */
  properties?: DatabaseUpdateProperties;
}

/**
 * Properties for updating Redis Enterprise databases
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model DatabaseUpdateProperties extends DatabaseProperties {
  /**
   * This property can be Enabled/Disabled to allow or deny access with the current access keys. Can be updated even after database is created. Default is Disabled.
   */
  accessKeysAuthentication?: AccessKeysAuthentication;
}

/**
 * The secret access keys used for authenticating connections to redis
 */
model AccessKeys {
  /**
   * The current primary key that clients can use to authenticate
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/secret-prop" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  primaryKey?: string;

  /**
   * The current secondary key that clients can use to authenticate
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/secret-prop" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
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
  @secret
  sasUris: string[];
}

/**
 * Parameters for a Redis Enterprise export operation.
 */
model ExportClusterParameters {
  /**
   * SAS URI for the target directory to export to
   */
  @secret
  sasUri: string;
}

/**
 * Properties of Redis Enterprise database access policy assignment.
 */
model AccessPolicyAssignmentProperties {
  /**
   * Current provisioning status of the access policy assignment.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  /**
   * Name of access policy under specific access policy assignment. Only "default" policy is supported for now.
   */
  @pattern("^([a-zA-Z0-9][a-zA-Z0-9-]*[a-zA-Z0-9]|[a-zA-Z0-9])$")
  accessPolicyName: string;

  /**
   * The user associated with the access policy.
   */
  user: AccessPolicyAssignmentPropertiesUser;
}

/**
 * The user associated with the access policy.
 */
model AccessPolicyAssignmentPropertiesUser {
  /**
   * The object ID of the user.
   */
  objectId?: string;
}

/**
 * The response of a list-all operation.
 */
model AccessPolicyAssignmentList is Azure.Core.Page<AccessPolicyAssignment>;

/**
 * The response of a listSkusForScaling operation.
 */
model SkuDetailsList {
  /**
   * List of SKUS available to scale up or scale down.
   */
  skus?: SkuDetails[];
}

/**
 * Details of a Redis Enterprise cluster SKU.
 */
model SkuDetails {
  /**
   * The name of the SKU.
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * The cache size in GB.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  sizeInGB?: float32;
}

/**
 * Parameters for a Redis Enterprise Active Geo Replication Force Unlink operation.
 */
model ForceUnlinkParameters {
  /**
   * The resource IDs of the database resources to be unlinked.
   */
  ids: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.Cache/redisEnterprise/databases";
    }
  ]>[];
}

/**
 * Parameters for reconfiguring active geo-replication, of an existing database that was previously unlinked from a replication group.
 */
model ForceLinkParameters {
  /**
   * Properties to configure geo replication for this database.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  geoReplication: ForceLinkParametersGeoReplication;
}

/**
 * Properties to configure geo replication for this database.
 */
model ForceLinkParametersGeoReplication {
  /**
   * The name of the group of linked database resources. This should match the existing replication group name.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  groupNickname?: string;

  /**
   * The resource IDs of the databases that are expected to be linked and included in the replication group. This parameter is used to validate that the linking is to the expected (unlinked) part of the replication group, if it is splintered.
   */
  linkedDatabases?: LinkedDatabase[];
}

/**
 * Common error response for all Azure Resource Manager APIs to return error details for failed operations. (This also follows the OData error response format.).
 */
@error
model ErrorResponseAutoGenerated {
  /**
   * The error object.
   */
  error?: ErrorDetailAutoGenerated;
}

/**
 * The error detail.
 */
model ErrorDetailAutoGenerated {
  /**
   * The error code.
   */
  @visibility(Lifecycle.Read)
  code?: string;

  /**
   * The error message.
   */
  @visibility(Lifecycle.Read)
  message?: string;

  /**
   * The error target.
   */
  @visibility(Lifecycle.Read)
  target?: string;

  /**
   * The error details.
   */
  @visibility(Lifecycle.Read)
  @identifiers(#["message", "target"])
  details?: ErrorDetailAutoGenerated[];

  /**
   * The error additional info.
   */
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  additionalInfo?: ErrorAdditionalInfo[];
}

/**
 * Parameters for a Redis Enterprise active geo-replication flush operation
 */
model FlushParameters {
  /**
   * The identifiers of all the other database resources in the georeplication group to be flushed.
   */
  ids?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.Cache/redisEnterprise/databases";
    }
  ]>[];
}

/**
 * The response of a list-all migrations.
 */
model MigrationList is Azure.Core.Page<Migration>;

/**
 * Properties for Redis Enterprise migration operation.
 */
@discriminator("sourceType")
model MigrationProperties {
  /**
   * Describes the source of the migration operation.
   */
  sourceType: SourceType;

  /**
   * The Azure resource ID of the Azure Managed Redis destination cache to migrate.
   */
  @visibility(Lifecycle.Read)
  targetResourceId?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.Cache/redisEnterprise";
    }
  ]>;

  /**
   * Current provisioning status of the migration
   */
  @visibility(Lifecycle.Read)
  provisioningState?: MigrationProvisioningState;

  /**
   * Additional details about the migration operation's status in free text format.
   */
  @visibility(Lifecycle.Read)
  statusDetails?: string;

  /**
   * The timestamp when the migration operation was created.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  creationTime?: utcDateTime;

  /**
   * The timestamp when the migration operation was last updated.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastModifiedTime?: utcDateTime;
}

/**
 * Properties for Redis Enterprise migration operation for Azure Cache for Redis.
 */
model AzureCacheForRedisMigrationProperties extends MigrationProperties {
  /**
   * The source resource ID to migrate from. This is the resource ID of the Azure Cache for Redis.
   */
  sourceResourceId: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.Cache/redis";
    }
  ]>;

  /**
   * Sets whether the DNS is switched automatically after the data is transferred from the source cache to the target cache. This property must be true during the preview.
   */
  switchDns: boolean;

  /**
   * Sets whether the data is migrated from source to target or not. This property must be true during the preview.
   */
  skipDataMigration: boolean;

  /**
   * Describes the source of the migration operation.
   */
  sourceType: "AzureCacheForRedis";
}

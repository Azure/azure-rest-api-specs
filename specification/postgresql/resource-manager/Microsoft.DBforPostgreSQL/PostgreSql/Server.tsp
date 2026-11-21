import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "@typespec/versioning";
import "./shared.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using TypeSpec.Versioning;

using Azure.Core;

namespace Microsoft.DBforPostgreSQL;

/**
 * Mode of high availability supported for this compute.
 */
union PostgreSqlFlexibleServerHighAvailabilityMode {
  string,

  /** High availability is disabled for the server. */
  Disabled: "Disabled",

  /** High availability is enabled for the server, with standby server in a different availability zone than that of the primary. */
  ZoneRedundant: "ZoneRedundant",

  /** High availability is enabled for the server, with standby server in the same availability zone as the primary. */
  SameZone: "SameZone",
}

/**
 * Types of identities associated with a server.
 */
union IdentityType {
  string,

  /** No managed identity is assigned to the server. */
  None: "None",

  /** One or more managed identities provided by the user are assigned to the server. */
  UserAssigned: "UserAssigned",

  /** Azure automatically creates and manages the identity associated to the lifecycle of the server. */
  SystemAssigned: "SystemAssigned",

  /** Both system-assigned and user-assigned identities are assigned to the server. */
  `SystemAssigned,UserAssigned`: "SystemAssigned,UserAssigned",
}

/**
 * State of a server.
 */
union ServerState {
  string,

  /** Server is healthy and not undergoing any operations at the management or control plane level. This doesn't mean that the server is fully operational at the data plane level. */
  Ready: "Ready",

  /** Server is being deleted. */
  Dropping: "Dropping",

  /** Server is disabled. Typical reasons include: the subscription on which the server is deployed is explicitly disabled or canceled by the administrator, the spending limit has been reached, or the bill is past due. May also happen when the server is being moved to another resource group or subscription. */
  Disabled: "Disabled",

  /** PostgreSQL database engine is being restarted. */
  Starting: "Starting",

  /** Compute resources associated with the server are being stopped and deallocated. If the server has high availability enabled, the compute resources of the standby server are also stopped and deallocated. */
  Stopping: "Stopping",

  /** Compute resources associated with the server are being stopped and deallocated. */
  Stopped: "Stopped",

  /** Server is undergoing some changes which may or may not impact the availability of the PostgreSQL database engine. For example, the compute resources of the server are being scaled up or down, which may cause temporary unavailability of the database engine. Or, for example, a firewall rule is being added or removed, which doesn't cause any unavailability of the database engine. */
  Updating: "Updating",

  /** PostgreSQL database engine is being restarted. */
  Restarting: "Restarting",

  /** Server isn't accessible, because the key provided to encrypt and decrypt the data is in invalid state. */
  Inaccessible: "Inaccessible",

  /** Server is in the process of being created. */
  Provisioning: "Provisioning",
}

/**
 * Indicates if the server is configured to automatically grow storage size when available space is nearing zero and conditions allow for automatic growing storage size.
 */
union StorageAutoGrow {
  string,

  /** Server should automatically grow storage size when available space is nearing zero and conditions allow for automatically growing storage size. */
  Enabled: "Enabled",

  /** Server should not automatically grow storage size when available space is nearing zero. */
  Disabled: "Disabled",
}

/**
 * Storage tier of a server.
 */
union AzureManagedDiskPerformanceTier {
  string,

  /** Entry-level SSD for minimal IOPS, ideal for light development or testing workloads. */
  P1: "P1",

  /** Slightly higher IOPS for small-scale applications needing consistent low latency. */
  P2: "P2",

  /** Balanced performance for basic production workloads with moderate throughput. */
  P3: "P3",

  /** Enhanced IOPS for growing apps with predictable performance needs. */
  P4: "P4",

  /** Mid-tier SSD for steady workloads requiring reliable throughput and latency. */
  P6: "P6",

  /** Popular choice for general-purpose production workloads with scalable performance. */
  P10: "P10",

  /** High IOPS tier for demanding apps with frequent read/write operations. */
  P15: "P15",

  /** Entry point for high-performance Solid State Disks (SSDs), suitable for small-scale I/O-intensive workloads. */
  P20: "P20",

  /** Balanced tier for moderate throughput and latency-sensitive applications. */
  P30: "P30",

  /** Enhanced performance for growing production workloads with consistent IOPS demands. */
  P40: "P40",

  /** Optimized for enterprise-grade applications needing sustained high throughput. */
  P50: "P50",

  /** High-capacity tier for large databases and analytics workloads with elevated IOPS. */
  P60: "P60",

  /** Designed for mission-critical systems requiring ultra-low latency and high concurrency. */
  P70: "P70",

  /** Top-tier SSD for maximum IOPS and throughput, ideal for the most demanding workloads. */
  P80: "P80",
}

/**
 * Type of storage assigned to a server. If not specified, it defaults to Premium_LRS.
 */
union StorageType {
  string,

  /** Standard Solid State Disk (SSD) backed storage offering consistent performance for general purpose workloads. */
  Premium_LRS: "Premium_LRS",

  /** Next generation Solid State Disk (SSD) storage with improved scalability and performance for demanding enterprise workloads. */
  PremiumV2_LRS: "PremiumV2_LRS",

  /** High-end Solid State Disk (SSD) storage designed for extreme IOPS and latency-sensitive applications. */
  UltraSSD_LRS: "UltraSSD_LRS",
}

/**
 * Indicates if the server supports Microsoft Entra authentication.
 */
union MicrosoftEntraAuth {
  string,

  /** Server supports Microsoft Entra authentication. */
  Enabled: "Enabled",

  /** Server does not support Microsoft Entra authentication. */
  Disabled: "Disabled",
}

/**
 * Indicates if the server supports password based authentication.
 */
union PasswordBasedAuth {
  string,

  /** Server supports password based authentication. */
  Enabled: "Enabled",

  /** Server does not support password based authentication. */
  Disabled: "Disabled",
}

/**
 * Data encryption type used by a server.
 */
union DataEncryptionType {
  string,

  /** Encryption managed by Azure using platform managed keys for simplicity and compliance. */
  SystemManaged: "SystemManaged",

  /** Encryption using customer managed keys stored in Azure Key Vault for enhanced control and security. */
  AzureKeyVault: "AzureKeyVault",
}

/**
 * Status of key used by a server configured with data encryption based on customer managed key, to encrypt the primary storage associated to the server.
 */
union EncryptionKeyStatus {
  string,

  /** Key is valid and can be used for encryption. */
  Valid: "Valid",

  /** Key is invalid and cannot be used for encryption. Possible causes include key deletion, permission changes, key being disabled, key type not supported, or current date being outside of validity period associated to the key. */
  Invalid: "Invalid",
}

/**
 * Indicates if the server is configured to create geographically redundant backups.
 */
union GeographicallyRedundantBackup {
  string,

  /** Server is configured to create geographically redundant backups. */
  Enabled: "Enabled",

  /** Server is not configured to create geographically redundant backups. */
  Disabled: "Disabled",
}

/**
 * Indicates if the server is configured to create immutable backups.
 */
@added(Versions.v2026_07_01)
union ImmutableBackup {
  string,

  /** Server is configured to create immutable backups. */
  Enabled: "Enabled",

  /** Server is not configured to create immutable backups. */
  Disabled: "Disabled",
}

/**
 * Indicates if FIPS (Federal Information Processing Standards) mode is enabled on the server.
 */
@added(Versions.v2026_07_01)
union FipsMode {
  string,

  /** FIPS mode is enabled on the server. */
  Enabled: "Enabled",

  /** FIPS mode is disabled on the server. */
  Disabled: "Disabled",
}

/**
 * Indicates if public network access is enabled or not.
 */
union ServerPublicNetworkAccessState {
  string,

  /** Public network access is enabled. This allows the server to be accessed from the public internet, provided the necessary firewall rule that allows incoming traffic originating from the connecting client is in place. This is compatible with the use of private endpoints to connect to this server. */
  Enabled: "Enabled",

  /** Public network access is disabled. This means the server cannot be accessed from the public internet, but only via private endpoints. */
  Disabled: "Disabled",
}

/**
 * Possible states of the standby server created when high availability is set to SameZone or ZoneRedundant.
 */
union HighAvailabilityState {
  string,

  /** High availability is not enabled for the server. */
  NotEnabled: "NotEnabled",

  /** Standby server is being created. */
  CreatingStandby: "CreatingStandby",

  /** Data is being replicated to the standby server. */
  ReplicatingData: "ReplicatingData",

  /** Failover operation to the standby server is in progress. */
  FailingOver: "FailingOver",

  /** Standby server is healthy and ready to take over in case of a failover. */
  Healthy: "Healthy",

  /** Standby server is being removed. */
  RemovingStandby: "RemovingStandby",

  /** Standby server is being recreated. */
  RecreatingStandby: "RecreatingStandby",

  /** Compute is being updated due to a failover. */
  ComputeUpdatingByFailover: "ComputeUpdatingByFailover",
}

/**
 * Role of the server in a replication set.
 */
union ReplicationRole {
  string,

  /** No replication role assigned; the server operates independently. */
  None: "None",

  /** Acts as the source server for replication to one or more replicas. */
  Primary: "Primary",

  /** Receives data asynchronously from a primary server within the same region. */
  AsyncReplica: "AsyncReplica",

  /** Receives data asynchronously from a primary server in a different region for geographical redundancy. */
  GeoAsyncReplica: "GeoAsyncReplica",
}

/**
 * Indicates the replication state of a read replica. This property is returned only when the target server is a read replica.
 */
union ReplicationState {
  string,

  /**
   * Read replica server is fully synchronized and actively replicating data from the primary server.
   */
  Active: "Active",

  /**
   * Read replica server is behind the primary server and is currently catching up with pending changes.
   */
  Catchup: "Catchup",

  /**
   * Read replica server is being created and is in process of getting initialized.
   */
  Provisioning: "Provisioning",

  /**
   * Read replica server is undergoing some changes it can be changing compute size of promoting it to primary server.
   */
  Updating: "Updating",

  /**
   * Replication has failed or been interrupted.
   */
  Broken: "Broken",

  /**
   * Read replica server is being reconfigured, possibly due to changes in source or settings.
   */
  Reconfiguring: "Reconfiguring",
}

/**
 * Type of operation to apply on the read replica. This property is write only.
 */
union ReadReplicaPromoteMode {
  string,

  /**
   * Read replica will become an independent server, and a completely independent entity from the replication set.
   */
  Standalone: "Standalone",

  /**
   * Read replica will swap roles with primary server.
   */
  Switchover: "Switchover",
}

/**
 * Data synchronization option to use when processing the operation specified in the promoteMode property. This property is write only.
 */
union ReadReplicaPromoteOption {
  string,

  /**
   * Wait for data in the read replica to be fully synchronized with its source server before it initiates the operation.
   */
  Planned: "Planned",

  /**
   * Initiate the operation immediately, without waiting for data in the read replica to be synchronized with its source server.
   */
  Forced: "Forced",
}

/**
 * Creation mode of a new server.
 */
union CreateMode {
  string,

  /** If the operation is triggered on a non-existing server, it's equivalent to 'Create'. If the operation is triggered on an existing server, it's equivalent to 'Update'. */
  Default: "Default",

  /** Operation creates a new server. */
  Create: "Create",

  /** Operation updates an existing server. */
  Update: "Update",

  /** Operation restores an existing backup of an existing server. This operation creates a new server, and then restores on it the backup of an existing server at a specific point in time. */
  PointInTimeRestore: "PointInTimeRestore",

  /** Operation restores an existing backup of an existing server, on the paired region of the existing server. This operation creates a new server on the paired region of the existing server, and then restores on it the backup of an existing server at a specific point in time, in a different region. This operation is only supported on existing servers that were created with geographically redundant backups enabled. */
  GeoRestore: "GeoRestore",

  /** Operation creates a replica of an existing server. This operation creates a new server, restores a base backup of the existing server (referred to as primary), and configures physical replication to asynchronously stream all changes which are recorded in the transaction log of the primary. */
  Replica: "Replica",

  /** Operation creates a new server, initialized with the backup of a server that was recently deleted. */
  ReviveDropped: "ReviveDropped",
}

/**
 * Update mode of an existing server.
 */
union CreateModeForPatch {
  string,

  /** It's equivalent to 'Update'. */
  Default: "Default",

  /** Operation updates an existing server. */
  Update: "Update",
}

/**
 * Failover mode.
 */
union FailoverMode {
  string,

  /** Trigger a failover from primary to standby without killing the primary database process first. This is a graceful failover that attempts to preserve data consistency. */
  PlannedFailover: "PlannedFailover",

  /** Terminate the primary database process first, then triggers the failover. This is more aggressive and used when the primary is unresponsive or in an unhealthy state. */
  ForcedFailover: "ForcedFailover",

  /** Similar to 'PlannedFailover' but prefers a switch over operation where roles are swapped between primary and standby. */
  PlannedSwitchover: "PlannedSwitchover",

  /** Terminate the primary database process first, and then triggers a switch over with role swapping. */
  ForcedSwitchover: "ForcedSwitchover",
}

/**
 * List of log files.
 */
model CapturedLogList is Azure.Core.Page<CapturedLog>;

/**
 * Log file.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model CapturedLog extends Azure.ResourceManager.CommonTypes.ProxyResource {
  /**
   * Properties of a log file.
   */
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  properties?: CapturedLogProperties;
}

/**
 * Properties of a log file.
 */
model CapturedLogProperties {
  /**
   * Creation timestamp of the log file.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  createdTime?: utcDateTime;

  /**
   * Last modified timestamp of the log file.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastModifiedTime?: utcDateTime;

  /**
   * Size (in KB) of the log file.
   */
  sizeInKb?: int64;

  /**
   * Type of log file. Can be 'ServerLogs' or 'UpgradeLogs'.
   */
  type?: string;

  /**
   * URL to download the log file from.
   */
  url?: string;
}

/**
 * A list of servers.
 */
model ServerList is Azure.Core.Page<Server>;

/**
 * Compute information of a server.
 */
model Sku {
  /**
   * Name by which is known a given compute size assigned to a server.
   */
  name: string;

  /**
   * Tier of the compute assigned to a server.
   */
  tier: SkuTier;
}

/**
 * Identities associated with a server.
 */
model UserAssignedIdentity {
  /**
   * Map of user assigned managed identities.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  userAssignedIdentities?: Record<UserIdentity>;

  /**
   * Identifier of the object of the service principal associated to the user assigned managed identity.
   */
  principalId?: string;

  /**
   * Types of identities associated with a server.
   */
  type: IdentityType;

  /**
   * Identifier of the tenant of a server.
   */
  @visibility(Lifecycle.Read)
  tenantId?: string;
}

/**
 * User assigned managed identity associated with a server.
 */
model UserIdentity {
  /**
   * Identifier of the object of the service principal associated to the user assigned managed identity.
   */
  principalId?: string;

  /**
   * Identifier of the client of the service principal associated to the user assigned managed identity.
   */
  clientId?: string;
}

/**
 * Properties of a server.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model ServerProperties {
  /**
   * Name of the login designated as the first password based administrator assigned to your instance of PostgreSQL. Must be specified the first time that you enable password based authentication on a server. Once set to a given value, it cannot be changed for the rest of the life of a server. If you disable password based authentication on a server which had it enabled, this password based role isn't deleted.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  administratorLogin?: string;

  /**
   * Password assigned to the administrator login. As long as password authentication is enabled, this password can be changed at any time.
   */
  @visibility(Lifecycle.Create, Lifecycle.Update)
  @secret
  administratorLoginPassword?: string;

  /**
   * Major version of PostgreSQL database engine.
   */
  @typeChangedFrom(Versions.v2026_10_01, PostgresMajorVersion)
  version?: string;

  /**
   * Minor version of PostgreSQL database engine.
   */
  @visibility(Lifecycle.Read)
  minorVersion?: string;

  /**
   * Possible states of a server.
   */
  @visibility(Lifecycle.Read)
  state?: ServerState;

  /**
   * Fully qualified domain name of a server.
   */
  @visibility(Lifecycle.Read)
  fullyQualifiedDomainName?: string;

  /**
   * Storage properties of a server.
   */
  storage?: Storage;

  /**
   * Authentication configuration properties of a server.
   */
  authConfig?: AuthConfig;

  /**
   * Data encryption properties of a server.
   */
  dataEncryption?: DataEncryption;

  /**
   * Backup properties of a server.
   */
  backup?: Backup;

  /**
   * Network properties of a server. Only required if you want your server to be integrated into a virtual network provided by customer.
   */
  network?: Network;

  /**
   * High availability properties of a server.
   */
  highAvailability?: HighAvailability;

  /**
   * Maintenance window properties of a server.
   */
  @visibility(Lifecycle.Read, Lifecycle.Update)
  maintenanceWindow?: MaintenanceWindow;

  /**
   * Identifier of the server to be used as the source of the new server. Required when 'createMode' is 'PointInTimeRestore', 'GeoRestore', 'Replica', or 'ReviveDropped'. This property is returned only when the target server is a read replica.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  sourceServerResourceId?: armResourceIdentifier<[
    {
      type: "Microsoft.DBforPostgreSQL/flexibleServers";
    }
  ]>;

  /**
   * Creation time (in ISO8601 format) of the backup which you want to restore in the new server. It's required when 'createMode' is 'PointInTimeRestore', 'GeoRestore', or 'ReviveDropped'.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Create)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  pointInTimeUTC?: utcDateTime;

  /**
   * Availability zone of a server.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  availabilityZone?: string = "";

  /**
   * Role of the server in a replication set.
   */
  replicationRole?: ReplicationRole;

  /**
   * Maximum number of read replicas allowed for a server.
   */
  @visibility(Lifecycle.Read)
  replicaCapacity?: int32;

  /**
   * Read replica properties of a server. Required only in case that you want to promote a server.
   */
  @visibility(Lifecycle.Read, Lifecycle.Update)
  replica?: Replica;

  /**
   * Creation mode of a new server.
   */
  @visibility(Lifecycle.Create, Lifecycle.Update)
  createMode?: CreateMode;

  /**
   * List of private endpoint connections associated with the specified server.
   */
  @visibility(Lifecycle.Read)
  privateEndpointConnections?: PrivateEndpointConnection[];

  /**
   * Cluster properties of a server.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  cluster?: Cluster;

  @doc("Indicates if FIPS (Federal Information Processing Standards) mode is enabled on the server. If not specified on create, it defaults to Disabled.")
  @added(Versions.v2026_07_01)
  fipsMode?: FipsMode = FipsMode.Disabled;
}

/**
 * Storage properties of a server.
 */
model Storage {
  /**
   * Size of storage assigned to a server.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  storageSizeGB?: int32;

  /**
   * Flag to enable or disable the automatic growth of storage size of a server when available space is nearing zero and conditions allow for automatically growing storage size.
   */
  autoGrow?: StorageAutoGrow;

  @doc("Maximum allocated storage size to which storage autogrow may grow, in MB. This value is not a disk-utilization trigger threshold and must be at least the effective current or requested storage size. Storage conversion uses 1 GB = 1,024 MB.")
  @added(Versions.v2026_07_01)
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  @minValue(1)
  @maxValue(67108864)
  autoGrowMaxThresholdMb?: int32;

  @doc("Storage autogrow increment as a percentage of the current allocated storage size. This value is not an absolute size increment or a utilization threshold.")
  @added(Versions.v2026_07_01)
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  @minValue(1)
  @maxValue(100)
  autoGrowIncrementPercent?: int32;

  /**
   * Storage tier of a server.
   */
  tier?: AzureManagedDiskPerformanceTier;

  /**
   * Maximum IOPS supported for storage. Required when type of storage is PremiumV2_LRS or UltraSSD_LRS.
   */
  iops?: int32;

  /**
   * Maximum throughput supported for storage. Required when type of storage is PremiumV2_LRS or UltraSSD_LRS.
   */
  throughput?: int32;

  /**
   * Type of storage assigned to a server. Allowed values are Premium_LRS, PremiumV2_LRS, or UltraSSD_LRS. If not specified, it defaults to Premium_LRS.
   */
  type?: StorageType;
}

/**
 * Authentication configuration properties of a server.
 */
model AuthConfig {
  /**
   * Indicates if the server supports Microsoft Entra authentication.
   */
  activeDirectoryAuth?: MicrosoftEntraAuth;

  /**
   * Indicates if the server supports password based authentication.
   */
  passwordAuth?: PasswordBasedAuth = PasswordBasedAuth.Enabled;

  /**
   * Identifier of the tenant of the delegated resource.
   */
  tenantId?: string = "";
}

/**
 * Data encryption properties of a server.
 */
model DataEncryption {
  /**
   * URI of the key in Azure Key Vault used for data encryption of the primary storage associated to a server.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  primaryKeyURI?: string;

  /**
   * Identifier of the user assigned managed identity used to access the key in Azure Key Vault for data encryption of the primary storage associated to a server.
   */
  primaryUserAssignedIdentityId?: string;

  /**
   * Identifier of the user assigned managed identity used to access the key in Azure Key Vault for data encryption of the geographically redundant storage associated to a server that is configured to support geographically redundant backups.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  geoBackupKeyURI?: string;

  /**
   * Identifier of the user assigned managed identity used to access the key in Azure Key Vault for data encryption of the geographically redundant storage associated to a server that is configured to support geographically redundant backups.
   */
  geoBackupUserAssignedIdentityId?: string;

  /**
   * Data encryption type used by a server.
   */
  type?: DataEncryptionType;

  /**
   * Status of key used by a server configured with data encryption based on customer managed key, to encrypt the primary storage associated to the server.
   */
  @visibility(Lifecycle.Read)
  primaryEncryptionKeyStatus?: EncryptionKeyStatus;

  /**
   * Status of key used by a server configured with data encryption based on customer managed key, to encrypt the geographically redundant storage associated to the server when it is configured to support geographically redundant backups.
   */
  @visibility(Lifecycle.Read)
  geoBackupEncryptionKeyStatus?: EncryptionKeyStatus;

  #suppress "azure-core/no-guid-usage" "The client id of primary federated identity is to be defined as GUID following recommendation by Azure Resource Manager guidelines."
  @doc("Client id of multi-tenant Microsoft Entra application.")
  @added(Versions.v2026_04_01)
  primaryFederatedIdentityClientId?: uuid;

  #suppress "azure-core/no-guid-usage" "The client id of backup federated identity is to be defined as GUID following recommendation by Azure Resource Manager guidelines."
  @doc("Client id of multi-tenant Microsoft Entra application for when it is configured to support geographically redundant backups.")
  @added(Versions.v2026_04_01)
  geoBackupFederatedIdentityClientId?: uuid;
}

/**
 * Backup properties of a server.
 */
model Backup {
  /**
   * Backup retention days for the server.
   */
  backupRetentionDays?: int32 = 7;

  /**
   * Indicates if the server is configured to create geographically redundant backups.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  geoRedundantBackup?: GeographicallyRedundantBackup = GeographicallyRedundantBackup.Disabled;

  /**
   * Indicates if the server is configured to create immutable backups.
   */
  @added(Versions.v2026_07_01)
  immutableBackup?: ImmutableBackup;

  /**
   * Earliest restore point time (ISO8601 format) for a server.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  earliestRestoreDate?: utcDateTime;
}

/**
 * Network properties of a server.
 */
model Network {
  /**
   * Indicates if public network access is enabled or not. This is only supported for servers that are not integrated into a virtual network which is owned and provided by customer when server is deployed.
   */
  publicNetworkAccess?: ServerPublicNetworkAccessState;

  /**
   * Resource identifier of the delegated subnet. Required during creation of a new server, in case you want the server to be integrated into your own virtual network. For an update operation, you only have to provide this property if you want to change the value assigned for the private DNS zone.
   */
  delegatedSubnetResourceId?: armResourceIdentifier<[
    {
      type: "Microsoft.Network/virtualNetworks/subnets";
    }
  ]>;

  /**
   * Identifier of the private DNS zone. Required during creation of a new server, in case you want the server to be integrated into your own virtual network. For an update operation, you only have to provide this property if you want to change the value assigned for the private DNS zone.
   */
  privateDnsZoneArmResourceId?: armResourceIdentifier<[
    {
      type: "Microsoft.Network/privateDnsZones";
    }
  ]>;
}

/**
 * High availability properties of a server.
 */
model HighAvailability {
  /**
   * High availability mode for a server.
   */
  mode?: PostgreSqlFlexibleServerHighAvailabilityMode = PostgreSqlFlexibleServerHighAvailabilityMode.Disabled;

  /**
   * Possible states of the standby server created when high availability is set to SameZone or ZoneRedundant.
   */
  @visibility(Lifecycle.Read)
  state?: HighAvailabilityState;

  /**
   * Availability zone associated to the standby server created when high availability is set to SameZone or ZoneRedundant.
   */
  standbyAvailabilityZone?: string = "";
}

/**
 * Maintenance window properties of a server.
 */
model MaintenanceWindow {
  /**
   * Indicates whether custom window is enabled or disabled.
   */
  customWindow?: string = "Disabled";

  /**
   * Start hour to be used for maintenance window.
   */
  startHour?: int32 = 0;

  /**
   * Start minute to be used for maintenance window.
   */
  startMinute?: int32 = 0;

  /**
   * Day of the week to be used for maintenance window.
   */
  dayOfWeek?: int32 = 0;
}

/**
 * Replica properties of a server.
 */
model Replica {
  /**
   * Role of the server in a replication set.
   */
  role?: ReplicationRole;

  /**
   * Maximum number of read replicas allowed for a server.
   */
  @visibility(Lifecycle.Read)
  capacity?: int32;

  /**
   * Indicates the replication state of a read replica. This property is returned only when the target server is a read replica. Possible  values are Active, Broken, Catchup, Provisioning, Reconfiguring, and Updating
   */
  @visibility(Lifecycle.Read)
  replicationState?: ReplicationState;

  /**
   * Type of operation to apply on the read replica. This property is write only. Standalone means that the read replica will be promoted to a standalone server, and will become a completely independent entity from the replication set. Switchover means that the read replica will roles with the primary server.
   */
  @visibility(Lifecycle.Update)
  promoteMode?: ReadReplicaPromoteMode;

  /**
   * Data synchronization option to use when processing the operation specified in the promoteMode property. This property is write only.
   */
  @visibility(Lifecycle.Update)
  promoteOption?: ReadReplicaPromoteOption;
}

/**
 * Cluster properties of a server.
 */
model Cluster {
  /**
   * Number of nodes assigned to the elastic cluster.
   */
  clusterSize?: int32 = 0;

  /**
   * Default database name for the elastic cluster.
   */
  defaultDatabaseName?: string;
}

/**
 * Represents a server to be updated.
 */
model ServerForPatch {
  /**
   * Compute tier and size of a server.
   */
  sku?: SkuForPatch;

  /**
   * Describes the identity of the application.
   */
  identity?: UserAssignedIdentity;

  /**
   * Properties of the server.
   */
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  properties?: ServerPropertiesForPatch;

  /**
   * Application-specific metadata in the form of key-value pairs.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  tags?: Record<string>;
}

/**
 * Compute information of a server.
 */
model SkuForPatch {
  /**
   * Name by which is known a given compute size assigned to a server.
   */
  name?: string;

  /**
   * Tier of the compute assigned to a server.
   */
  tier?: SkuTier;
}

/**
 * Properties of a server.
 */
model ServerPropertiesForPatch {
  /**
   * Name of the login designated as the first password based administrator assigned to your instance of PostgreSQL. Must be specified the first time that you enable password based authentication on a server. Once set to a given value, it cannot be changed for the rest of the life of a server. If you disable password based authentication on a server which had it enabled, this password based role isn't deleted.
   */
  @visibility(Lifecycle.Read)
  administratorLogin?: string;

  /**
   * Password assigned to the administrator login. As long as password authentication is enabled, this password can be changed at any time.
   */
  @visibility(Lifecycle.Update)
  @secret
  administratorLoginPassword?: string;

  /**
   * Major version of PostgreSQL database engine.
   */
  @typeChangedFrom(Versions.v2026_10_01, PostgresMajorVersion)
  version?: string;

  /**
   * Storage properties of a server.
   */
  storage?: Storage;

  /**
   * Backup properties of a server.
   */
  backup?: BackupForPatch;

  /**
   * High availability properties of a server.
   */
  highAvailability?: HighAvailabilityForPatch;

  /**
   * Maintenance window properties of a server.
   */
  @visibility(Lifecycle.Read, Lifecycle.Update)
  maintenanceWindow?: MaintenanceWindowForPatch;

  /**
   * Authentication configuration properties of a server.
   */
  authConfig?: AuthConfigForPatch;

  /**
   * Data encryption properties of a server.
   */
  dataEncryption?: DataEncryption;

  /**
   * Availability zone of a server.
   */
  availabilityZone?: string = "";

  /**
   * Update mode of an existing server.
   */
  @visibility(Lifecycle.Update)
  createMode?: CreateModeForPatch;

  /**
   * Identifier of the server to be used as the source of the new server.
   */
  @added(Versions.v2026_04_01)
  @visibility(Lifecycle.Update)
  sourceServerResourceId?: armResourceIdentifier<[
    {
      type: "Microsoft.DBforPostgreSQL/flexibleServers";
    }
  ]>;

  /**
   * Role of the server in a replication set.
   */
  replicationRole?: ReplicationRole;

  /**
   * Read replica properties of a server. Required only in case that you want to promote a server.
   */
  @visibility(Lifecycle.Read, Lifecycle.Update)
  replica?: Replica;

  /**
   * Network properties of a server. Only required if you want your server to be integrated into a virtual network provided by customer.
   */
  network?: Network;

  /**
   * Cluster properties of a server.
   */
  @visibility(Lifecycle.Read, Lifecycle.Update)
  cluster?: Cluster;

  @doc("Indicates if FIPS (Federal Information Processing Standards) mode is enabled on the server. If not specified, the current value is preserved.")
  @added(Versions.v2026_07_01)
  fipsMode?: FipsMode;
}

/**
 * Backup properties of a server.
 */
model BackupForPatch {
  /**
   * Backup retention days for the server.
   */
  backupRetentionDays?: int32;

  /**
   * Indicates if the server is configured to create geographically redundant backups.
   */
  @visibility(Lifecycle.Read)
  geoRedundantBackup?: GeographicallyRedundantBackup;

  /**
   * Indicates if the server is configured to create immutable backups.
   */
  @added(Versions.v2026_07_01)
  immutableBackup?: ImmutableBackup;

  /**
   * Earliest restore point time (ISO8601 format) for a server.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  earliestRestoreDate?: utcDateTime;
}

/**
 * High availability properties of a server.
 */
model HighAvailabilityForPatch {
  /**
   * High availability mode for a server.
   */
  mode?: PostgreSqlFlexibleServerHighAvailabilityMode;

  /**
   * Possible states of the standby server created when high availability is set to SameZone or ZoneRedundant.
   */
  @visibility(Lifecycle.Read)
  state?: HighAvailabilityState;

  /**
   * Availability zone associated to the standby server created when high availability is set to SameZone or ZoneRedundant.
   */
  standbyAvailabilityZone?: string = "";
}

/**
 * Maintenance window properties of a server.
 */
model MaintenanceWindowForPatch {
  /**
   * Indicates whether custom window is enabled or disabled.
   */
  customWindow?: string;

  /**
   * Start hour to be used for maintenance window.
   */
  startHour?: int32;

  /**
   * Start minute to be used for maintenance window.
   */
  startMinute?: int32;

  /**
   * Day of the week to be used for maintenance window.
   */
  dayOfWeek?: int32;
}

/**
 * Authentication configuration properties of a server.
 */
model AuthConfigForPatch {
  /**
   * Indicates if the server supports Microsoft Entra authentication.
   */
  activeDirectoryAuth?: MicrosoftEntraAuth;

  /**
   * Indicates if the server supports password based authentication.
   */
  passwordAuth?: PasswordBasedAuth;

  /**
   * Identifier of the tenant of the delegated resource.
   */
  tenantId?: string;
}

/**
 * PostgreSQL database engine restart parameters.
 */
model RestartParameter {
  /**
   * Indicates if restart the PostgreSQL database engine should failover or switch over from primary to standby. This only works if server has high availability enabled.
   */
  restartWithFailover?: boolean;

  /**
   * Failover mode.
   */
  failoverMode?: FailoverMode;
}

/**
 * Custom error response for the service.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-client-generator-core/csharp-model-suffix" "Name kept for backward compatibility"
@error
model CustomErrorResponse {
  @body
  error: Azure.ResourceManager.ErrorResponse;

  @header("x-ms-error-code")
  @doc("ErrorCode string in the event of a failure.")
  errorCode?: string;

  @header("x-ms-request-id")
  @doc("A unique ID for the current operation, service generated. All the resource providers must return this value in the response headers to facilitate debugging.")
  requestId?: string;
}

/**
 * State of the network migration operation.
 */
union NetworkMigrationState {
  string,

  /**
   * Network migration is pending.
   */
  Pending: "Pending",

  /**
   * Network migration is in progress.
   */
  InProgress: "InProgress",

  /**
   * Network migration succeeded.
   */
  Succeeded: "Succeeded",

  /**
   * Network migration failed.
   */
  Failed: "Failed",

  /**
   * Network migration cancellation is in progress.
   */
  CancelInProgress: "CancelInProgress",

  /**
   * Network migration was cancelled.
   */
  Cancelled: "Cancelled",
}

/**
 * Status of a network migration operation.
 */
#suppress "@azure-tools/typespec-client-generator-core/csharp-use-standard-acronyms" "Name kept for backward compatibility"
model MigrateNetworkStatus {
  /**
   * Identifier of the subscription.
   */
  subscriptionId?: string;

  /**
   * Name of the resource group.
   */
  resourceGroupName?: string;

  /**
   * Name of the server.
   */
  serverName?: string;

  /**
   * State of the network migration operation.
   */
  @visibility(Lifecycle.Read)
  state?: NetworkMigrationState;
}

/**
 * Properties of a server.
 */
model Server is Azure.ResourceManager.TrackedResource<ServerProperties> {
  ...ResourceNameParameter<
    Resource = Server,
    KeyName = "serverName",
    SegmentName = "flexibleServers",
    NamePattern = "^[a-zA-Z0-9]+(-[a-zA-Z0-9]+)*"
  >;

  /**
   * Compute tier and size of a server.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  sku?: Sku;

  /**
   * User assigned managed identities assigned to the server.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  identity?: UserAssignedIdentity;
}

alias RequestIdResponseHeader = {
  @header("x-ms-request-id")
  @doc("A unique ID for the current operation, service generated. All the resource providers must return this value in the response headers to facilitate debugging.")
  requestId?: string;
};

@armResourceOperations
interface Servers {
  /**
   * Gets information about an existing server.
   */
  get is ArmResourceRead<Server>;

  /**
   * Creates a new server.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @Azure.Core.useFinalStateVia("azure-async-operation")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    Server,
    Response = ArmAcceptedLroResponse<LroHeaders = ArmCombinedLroHeaders<FinalResult = Server> &
      Azure.Core.Foundations.RetryAfterHeader>
  >;

  /**
   * Updates an existing server. The request body can contain one or multiple of the properties present in the normal server definition.
   */
  @Azure.Core.useFinalStateVia("azure-async-operation")
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchAsync<
    Server,
    PatchModel = ServerForPatch,
    Response = ArmAcceptedLroResponse<LroHeaders = ArmCombinedLroHeaders<FinalResult = Server> &
      Azure.Core.Foundations.RetryAfterHeader>
  >;

  /**
   * Deletes or drops an existing server.
   */
  delete is ArmResourceDeleteWithoutOkAsync<
    Server,
    Response =
      | ArmDeleteAcceptedLroResponse<LroHeaders = ArmCombinedLroHeaders &
          Azure.Core.Foundations.RetryAfterHeader>
      | ArmDeletedNoContentResponse
  >;

  /**
   * Lists all servers in a resource group.
   */
  listByResourceGroup is ArmResourceListByParent<
    Server,
    Response = ArmResponse<ServerList>
  >;

  /**
   * Lists all servers in a subscription.
   */
  listBySubscription is ArmListBySubscription<
    Server,
    Response = ArmResponse<ServerList>
  >;

  /**
   * Lists the capabilities available for a given server.
   */
  @list
  @get
  @action("capabilities")
  list is ArmResourceActionSync<Server, void, ArmResponse<CapabilityList>>;

  /**
   * Lists all captured logs for download in a server.
   */
  @get
  @list
  @action("logFiles")
  listByServer is ArmResourceActionSync<
    Server,
    void,
    ArmResponse<CapturedLogList>
  >;

  /**
   * Performs all checks required for a long term retention backup operation to succeed.
   */
  @action("ltrPreBackup")
  checkPrerequisites is ArmResourceActionAsyncBase<
    Server,
    LtrPreBackupRequest,
    Response = LtrPreBackupResponse & RequestIdResponseHeader,
    BaseParameters = Azure.ResourceManager.Foundations.DefaultBaseParameters<Server>,
    Error = CustomErrorResponse
  >;

  /**
   * Initiates a long term retention backup.
   */
  @action("startLtrBackup")
  start is ArmResourceActionAsyncBase<
    Server,
    BackupsLongTermRetentionRequest,
    | (BackupsLongTermRetentionResponse & RequestIdResponseHeader)
    | (ArmAcceptedLroResponse<LroHeaders = ArmCombinedLroHeaders<FinalResult = BackupsLongTermRetentionResponse> &
        Azure.Core.Foundations.RetryAfterHeader> &
        RequestIdResponseHeader),
    BaseParameters = Azure.ResourceManager.Foundations.DefaultBaseParameters<Server>,
    Error = CustomErrorResponse
  >;

  /**
   * Checks if a proposed migration name is valid and available.
   */
  @action("checkMigrationNameAvailability")
  @summary("Check the validity and availability of the given name, to assign it to a new migration.")
  checkNameAvailability is ArmResourceActionSync<
    Server,
    MigrationNameAvailability,
    ArmResponse<MigrationNameAvailability>
  >;

  /**
   * Lists all read replicas of a server.
   */
  @get
  @list
  @action("replicas")
  replicasListByServer is ArmResourceActionSync<
    Server,
    void,
    ArmResponse<ServerList>
  >;

  /**
   * Restarts PostgreSQL database engine in a server.
   */
  restart is ArmResourceActionAsyncBase<
    Server,
    RestartParameter,
    ArmAcceptedLroResponse<LroHeaders = ArmCombinedLroHeaders &
      Azure.Core.Foundations.RetryAfterHeader>,
    BaseParameters = Azure.ResourceManager.Foundations.DefaultBaseParameters<Server>,
    OptionalRequestBody = true
  >;

  /**
   * Starts a stopped server.
   */
  @action("start")
  serversStart is ArmResourceActionAsyncBase<
    Server,
    void,
    ArmAcceptedLroResponse<LroHeaders = ArmCombinedLroHeaders &
      Azure.Core.Foundations.RetryAfterHeader>,
    BaseParameters = Azure.ResourceManager.Foundations.DefaultBaseParameters<Server>
  >;

  /**
   * Stops a server.
   */
  stop is ArmResourceActionAsyncBase<
    Server,
    void,
    ArmAcceptedLroResponse<LroHeaders = ArmCombinedLroHeaders &
      Azure.Core.Foundations.RetryAfterHeader>,
    BaseParameters = Azure.ResourceManager.Foundations.DefaultBaseParameters<Server>
  >;

  /**
   * Migrates an Azure Database for PostgreSQL server from VNet integration to a Private Link network model.
   */
  @added(Versions.v2026_01_01)
  @action("migrateNetwork")
  migrateNetworkMode is ArmResourceActionAsyncBase<
    Server,
    void,
    | (MigrateNetworkStatus & RequestIdResponseHeader)
    | (ArmAcceptedLroResponse<LroHeaders = ArmCombinedLroHeaders<FinalResult = MigrateNetworkStatus> &
        Azure.Core.Foundations.RetryAfterHeader> &
        RequestIdResponseHeader),
    BaseParameters = Azure.ResourceManager.Foundations.DefaultBaseParameters<Server>
  >;

  @doc("Start Major Version Upgrade Prechecks.")
  @added(Versions.v2026_04_01)
  @action("startMajorVersionUpgradePrecheck")
  startMajorVersionUpgradePrecheck is ArmResourceActionAsyncBase<
    Server,
    StartMajorVersionUpgradePrecheckRequest,
    | (StartMajorVersionUpgradePrecheckResponse & RequestIdResponseHeader)
    | ArmAcceptedLroResponse<LroHeaders = ArmCombinedLroHeaders<FinalResult = StartMajorVersionUpgradePrecheckResponse> &
        Azure.Core.Foundations.RetryAfterHeader>,
    BaseParameters = Azure.ResourceManager.Foundations.DefaultBaseParameters<Server>
  >;
}

@@maxLength(Server.name, 63);
@@minLength(Server.name, 3);
@@doc(Server.name, "The name of the server.");
@@doc(Server.properties, "Properties of a server.");
@@doc(
  Servers.createOrUpdate::parameters.resource,
  "Parameters required to create a new server or to update an existing server."
);
@@doc(
  Servers.update::parameters.properties,
  "Parameters required to update a server."
);
@@doc(
  Servers.checkPrerequisites::parameters.body,
  "Request body for operation"
);
@@doc(Servers.start::parameters.body, "Request body for operation");
@@doc(
  Servers.checkNameAvailability::parameters.body,
  "Parameters required to check if a migration name is valid and available."
);
@@doc(Servers.restart::parameters.body, "Parameters to restart a server.");
@@doc(
  Servers.migrateNetworkMode::parameters.body,
  "Parameters to migrate the network configuration of a server."
);

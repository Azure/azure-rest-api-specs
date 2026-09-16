import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@azure-tools/typespec-client-generator-core";
import "@typespec/openapi";
import "@azure-tools/typespec-azure-portal-core";
import "./shared.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using OpenAPI;
using Azure.ResourceManager;
using Azure.Portal;

#suppress "@azure-tools/typespec-azure-resource-manager/missing-operations-endpoint" "The Operations interface is defined once for the resource provider in ../GcpConnector/main.tsp (interface Operations extends Azure.ResourceManager.Operations); per-service projects intentionally do not redeclare it."
@armProviderNamespace
@service(#{ title: "Microsoft.GcpConnector" })
@doc("Microsoft.GcpConnector Resource Provider management API.")
@versioned(Versions)
@armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v6)
namespace Microsoft.GcpConnector;

/** Api versions */
enum Versions {
  /** 2027-01-01 api version */
  `2027-01-01`,
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Suppress casing style as the name is defined in GCP."
@about({
  displayNames: {
    singular: "SQLAdmin Instance",
    plural: "SQLAdmin Instances",
  },
  keywords: ["Microsoft.GcpConnector", "SQLAdmin", "Instance"],
})
@doc("A Microsoft.GcpConnector resource")
model SQLAdminInstance is TrackedResource<SQLAdminInstanceProperties> {
  @doc("Name of SQLAdminInstance")
  @pattern("^(?=.{0,259}[^\\s.]$)(?!.*[<>%&\\?/#])")
  @key("name")
  @path
  @segment("sqlAdminInstances")
  name: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Suppress casing style as the property name is defined in GCP."
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "GCPConnector will not generate SDK. So, Suppressing this error"
@doc("Definition of SQLAdminInstanceProperties")
model SQLAdminInstanceProperties {
  @doc("GCP Properties")
  gcpProperties?: GcpSqlAdminInstanceProperties;

  ...GcpCommonProperties;
}

/**
 * A Cloud SQL instance resource.
 */
model GcpSqlAdminInstanceProperties {
  /**
   * FIRST_GEN: First Generation instance. V1 is a legacy version and should not be used for new instances.
   */
  backendType?: string;

  /**
   * Connection name of the Cloud SQL instance used in connection strings.
   */
  connectionName?: string;

  /**
   * The time when the instance was created in RFC 3339 format.
   */
  createTime?: utcDateTime;

  /**
   * The database engine type and version.
   */
  databaseVersion?: string;

  /**
   * Disk encryption configuration specific to an instance.
   */
  diskEncryptionConfiguration?: DiskEncryptionConfiguration;

  /**
   * Disk encryption status specific to an instance.
   */
  diskEncryptionStatus?: DiskEncryptionStatus;

  /**
   * This field is deprecated and will be removed from a future version of the API.
   */
  etag?: string;

  /**
   * The name and status of the failover replica.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unnamed-types" "Mirrors the Google Cloud discovery document, which defines this nested object inline on its parent rather than as a named, independently referenced schema. Naming it here would introduce a type that has no counterpart in the Google API surface this resource projects."
  failoverReplica?: {
    /**
     * The availability status of the failover replica. A false status indicates that the failover replica is out of sync. The primary instance can only failover to the failover replica when the status is true.
     */
    available?: boolean;

    /**
     * The name of the failover replica. This property is applicable only if the instance has a failover replica.
     */
    name?: string;
  };

  /**
   * The Compute Engine zone that the instance is serving from.
   */
  gceZone?: string;

  /**
   * The instance type.
   */
  instanceType?: string;

  /**
   * The assigned IP addresses for the instance.
   */
  @identifiers(#[])
  ipAddresses?: IpMapping[];

  /**
   * The IPv6 address assigned to the instance.
   */
  ipv6Address?: string;

  /**
   * This is always sql#instance.
   */
  kind?: string;

  /**
   * The name of the instance which will act as primary in the replication setup.
   */
  masterInstanceName?: string;

  /**
   * The maximum disk size in bytes.
   */
  maxDiskSize?: string;

  /**
   * Name of the Cloud SQL instance.
   */
  name?: string;

  /**
   * The on-premises instance configuration.
   */
  onPremisesConfiguration?: OnPremisesConfiguration;

  /**
   * The project ID of the project containing the Cloud SQL instance.
   */
  project?: string;

  /**
   * The geographical region.
   */
  region?: string;

  /**
   * The replica configuration.
   */
  replicaConfiguration?: ReplicaConfiguration;

  /**
   * The replicas of the instance.
   */
  replicaNames?: string[];

  /**
   * Initial root password.
   */
  @secret
  rootPassword?: string;

  /**
   * The status indicating if instance satisfies physical zone separation.
   */
  satisfiesPzs?: boolean;

  /**
   * The scheduled maintenance for the instance.
   */
  scheduledMaintenance?: SqlScheduledMaintenance;

  /**
   * The Compute Engine zone that the failover instance is currently serving from.
   */
  secondaryGceZone?: string;

  /**
   * The URI of this resource.
   */
  selfLink?: string;

  /**
   * The server CA certificate used to connect to the instance via SSL.
   */
  serverCaCert?: SslCert;

  /**
   * The service account email address assigned to the instance.
   */
  serviceAccountEmailAddress?: string;

  /**
   * The settings for the instance.
   */
  settings?: Settings;

  /**
   * The current serving state of the Cloud SQL instance.
   */
  state?: string;

  /**
   * If the instance state is SUSPENDED, the reason for the suspension.
   */
  suspensionReason?: string[];

  /**
   * The database engine version currently installed on the instance.
   */
  databaseInstalledVersion?: string;

  /**
   * The current disk size of the instance in bytes.
   */
  currentDiskSize?: string;

  /**
   * List of maintenance versions available for this instance.
   */
  availableMaintenanceVersions?: string[];

  /**
   * The current software version on the instance.
   */
  maintenanceVersion?: string;

  /**
   * List of database versions to which this instance could be upgraded.
   */
  @identifiers(#[])
  upgradableDatabaseVersions?: AvailableDatabaseVersion[];

  /**
   * List of nodes in the instance.
   */
  nodes?: PoolNodeConfig[];

  /**
   * List of DNS mappings configured for the instance.
   */
  dnsNames?: DnsNameMapping[];

  /**
   * Report for out of disk conditions.
   */
  outOfDiskReport?: SqlOutOfDiskReport;

  /**
   * The network architecture of the instance.
   */
  sqlNetworkArchitecture?: string;

  /**
   * PSC service attachment link.
   */
  pscServiceAttachmentLink?: string;

  /**
   * DNS name of the instance.
   */
  dnsName?: string;

  /**
   * Primary DNS name of the instance.
   */
  primaryDnsName?: string;

  /**
   * Write endpoint for the instance.
   */
  writeEndpoint?: string;

  /**
   * Replication cluster configuration.
   */
  replicationCluster?: ReplicationCluster;

  /**
   * Gemini instance configuration.
   */
  geminiConfig?: GeminiInstanceConfig;

  /**
   * Whether transaction logs switch to cloud storage is enabled.
   */
  switchTransactionLogsToCloudStorageEnabled?: boolean;

  /**
   * Number of nodes in the instance.
   */
  nodeCount?: int32;
}

/**
 * Disk encryption configuration.
 */
model DiskEncryptionConfiguration {
  /**
   * KMS key resource name.
   */
  kmsKeyName?: string;

  /**
   * This is always sql#diskEncryptionConfiguration.
   */
  kind?: string;
}

/**
 * Disk encryption status.
 */
model DiskEncryptionStatus {
  /**
   * KMS key version used to encrypt the Cloud SQL instance.
   */
  kmsKeyVersionName?: string;

  /**
   * This is always sql#diskEncryptionStatus.
   */
  kind?: string;
}

/**
 * Database instance IP Mapping.
 */
model IpMapping {
  /**
   * The IP address assigned.
   */
  ipAddress?: string;

  /**
   * The due time for this IP to be retired in RFC 3339 format.
   */
  timeToRetire?: utcDateTime;

  /**
   * The type of this IP address.
   */
  type?: IpMappingType;
}

/**
 * On-premises instance configuration.
 */
model OnPremisesConfiguration {
  /**
   * PEM representation of the trusted CA's x509 certificate.
   */
  caCertificate?: string;

  /**
   * PEM representation of the replica's x509 certificate.
   */
  clientCertificate?: string;

  /**
   * PEM representation of the replica's private key.
   */
  @secret
  clientKey?: string;

  /**
   * The dump file to create the Cloud SQL replica.
   */
  dumpFilePath?: string;

  /**
   * The host and port of the on-premises instance in host:port format.
   */
  hostPort?: string;

  /**
   * This is always sql#onPremisesConfiguration.
   */
  kind?: string;

  /**
   * The password for connecting to on-premises instance.
   */
  @secret
  password?: string;

  /**
   * The username for connecting to on-premises instance.
   */
  username?: string;
}

/**
 * Read-replica configuration for connecting to the primary instance.
 */
model ReplicaConfiguration {
  /**
   * Whether this replica can be used as a failover target.
   */
  failoverTarget?: boolean;

  /**
   * This is always sql#replicaConfiguration.
   */
  kind?: string;

  /**
   * MySQL specific configuration when replicating from a MySQL primary instance.
   */
  mysqlReplicaConfiguration?: MySqlReplicaConfiguration;
}

/**
 * Database instance settings.
 */
model Settings {
  /**
   * The activation policy specifies when the instance is activated.
   */
  activationPolicy?: ActivationPolicy;

  /**
   * Active Directory configuration.
   */
  activeDirectoryConfig?: SqlActiveDirectoryConfig;

  /**
   * The App Engine app IDs that can access this instance.
   */
  authorizedGaeApplications?: string[];

  /**
   * Availability type.
   */
  availabilityType?: AvailabilityType;

  /**
   * Database instance backup configuration.
   */
  backupConfiguration?: BackupConfiguration;

  /**
   * The name of server Instance collation.
   */
  collation?: string;

  /**
   * Configuration specific to read replicas replication.
   */
  crashSafeReplicationEnabled?: boolean;

  /**
   * The size of data disk, in GB.
   */
  dataDiskSizeGb?: string;

  /**
   * The type of data disk.
   */
  dataDiskType?: DataDiskType;

  /**
   * The database flags passed to the instance at startup.
   */
  databaseFlags?: DatabaseFlags[];

  /**
   * The default IAM policy for new databases created in the instance.
   */
  ipConfiguration?: IpConfiguration;

  /**
   * This is always sql#settings.
   */
  kind?: string;

  /**
   * The location preference for the instance.
   */
  locationPreference?: LocationPreference;

  /**
   * Maintenance window for the instance.
   */
  maintenanceWindow?: MaintenanceWindow;

  /**
   * The pricing plan for this instance.
   */
  pricingPlan?: PricingPlan;

  /**
   * The type of replication this instance uses.
   */
  replicationType?: ReplicationType;

  /**
   * The version of instance settings.
   */
  settingsVersion?: string;

  /**
   * Configuration to increase storage size automatically.
   */
  storageAutoResize?: boolean;

  /**
   * The maximum size to which storage capacity can be automatically increased.
   */
  storageAutoResizeLimit?: string;

  /**
   * The tier of service for this instance.
   */
  tier?: string;

  /**
   * User-provided labels, represented as a dictionary.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Arbitrary user-defined key/value pairs assigned in GCP. Keys are chosen by the customer and cannot be enumerated in the specification."
  userLabels?: Record<string>;

  /**
   * The version of instance settings.
   */
  version?: int32;
}

/**
 * Database flags for Cloud SQL instances.
 */
model DatabaseFlags {
  /**
   * The name of the flag.
   */
  name?: string;

  /**
   * The value of the flag.
   */
  value?: string;
}

/**
 * Preferred location settings.
 */
model LocationPreference {
  /**
   * The App Engine application to follow.
   */
  followGaeApplication?: string;

  /**
   * This is always sql#locationPreference.
   */
  kind?: string;

  /**
   * The preferred Compute Engine zone for the secondary/failover.
   */
  secondaryZone?: string;

  /**
   * The preferred Compute Engine zone for the instance.
   */
  zone?: string;
}

/**
 * Maintenance window for Cloud SQL instances.
 */
model MaintenanceWindow {
  /**
   * Day of week (1-7), starting on Monday.
   */
  day?: int32;

  /**
   * Hour of day (0-23).
   */
  hour?: int32;

  /**
   * This is always sql#maintenanceWindow.
   */
  kind?: string;

  /**
   * Maintenance timing setting.
   */
  updateTrack?: UpdateTrack;
}

/**
 * SQL Server scheduled maintenance settings.
 */
model SqlScheduledMaintenance {
  /**
   * If the scheduled maintenance can be deferred.
   */
  canDefer?: boolean;

  /**
   * If the scheduled maintenance can be rescheduled.
   */
  canReschedule?: boolean;

  /**
   * The start time of any upcoming scheduled maintenance for this instance.
   */
  startTime?: utcDateTime;
}

/**
 * SSL certificate resource.
 */
model SslCert {
  /**
   * PEM representation of the X.509 certificate.
   */
  cert?: string;

  /**
   * Serial number, as extracted from the certificate.
   */
  certSerialNumber?: string;

  /**
   * User supplied name. Constrained to [a-zA-Z.-_ ]+.
   */
  commonName?: string;

  /**
   * The time when the certificate was created in RFC 3339 format.
   */
  createTime?: utcDateTime;

  /**
   * The time when the certificate expires in RFC 3339 format.
   */
  expirationTime?: utcDateTime;

  /**
   * Name of the database instance.
   */
  instance?: string;

  /**
   * This is always sql#sslCert.
   */
  kind?: string;

  /**
   * The URI of this resource.
   */
  selfLink?: string;

  /**
   * SHA-1 fingerprint of the certificate.
   */
  sha1Fingerprint?: string;
}

/**
 * Read-replica configuration specific to MySQL databases.
 */
model MySqlReplicaConfiguration {
  /**
   * PEM representation of the trusted CA's x509 certificate.
   */
  caCertificate?: string;

  /**
   * PEM representation of the replica's x509 certificate.
   */
  clientCertificate?: string;

  /**
   * PEM representation of the replica's private key.
   */
  @secret
  clientKey?: string;

  /**
   * Seconds to wait between connect retries.
   */
  connectRetryInterval?: int32;

  /**
   * Path to a SQL dump file in Google Cloud Storage.
   */
  dumpFilePath?: string;

  /**
   * This is always sql#mysqlReplicaConfiguration.
   */
  kind?: string;

  /**
   * Interval in milliseconds between replication heartbeats.
   */
  masterHeartbeatPeriod?: string;

  /**
   * The password for the replication connection.
   */
  @secret
  password?: string;

  /**
   * A list of permissible ciphers to use for SSL encryption.
   */
  sslCipher?: string;

  /**
   * The username for the replication connection.
   */
  username?: string;

  /**
   * Whether or not to check the primary instance's Common Name value.
   */
  verifyServerCertificate?: boolean;
}

/**
 * Active Directory configuration for SQL Server instances.
 */
model SqlActiveDirectoryConfig {
  /**
   * The name of the domain directory.
   */
  domain?: string;

  /**
   * This is always sql#activeDirectoryConfig.
   */
  kind?: string;
}

/**
 * Database instance backup configuration.
 */
model BackupConfiguration {
  /**
   * Backup retention settings.
   */
  backupRetentionSettings?: BackupRetentionSettings;

  /**
   * Whether backup configuration is enabled.
   */
  enabled?: boolean;

  /**
   * This is always sql#backupConfiguration.
   */
  kind?: string;

  /**
   * Location of the backup.
   */
  location?: string;

  /**
   * True if Point-in-time recovery is enabled.
   */
  pointInTimeRecoveryEnabled?: boolean;

  /**
   * Reserved for future use.
   */
  replicationLogArchivingEnabled?: boolean;

  /**
   * Start time for the daily backup configuration in UTC timezone.
   */
  startTime?: string;

  /**
   * The number of days of transaction logs we retain for point in time restore.
   */
  transactionLogRetentionDays?: int32;
}

/**
 * Backup retention settings.
 */
model BackupRetentionSettings {
  /**
   * Number of backup runs to retain.
   */
  retainedBackups?: int32;

  /**
   * The unit that 'retainedBackups' represents.
   */
  retentionUnit?: RetentionUnit;
}

/**
 * IP configuration for a Cloud SQL instance.
 */
model IpConfiguration {
  /**
   * The name of the allocated IP range for the private IP Cloud SQL instance.
   */
  allocatedIpRange?: string;

  /**
   * The list of external networks that are allowed to connect to the instance using the IP.
   */
  authorizedNetworks?: AclEntry[];

  /**
   * Whether the instance is assigned a public IP address or not.
   */
  ipv4Enabled?: boolean;

  /**
   * The resource link for the VPC network from which the Cloud SQL instance is accessible for private IP.
   */
  privateNetwork?: string;

  /**
   * Whether SSL connections over IP are enforced or not.
   */
  requireSsl?: boolean;
}

/**
 * An entry for an Access Control list.
 */
model AclEntry {
  /**
   * The time when this access control entry expires in RFC 3339 format.
   */
  expirationTime?: utcDateTime;

  /**
   * This is always sql#aclEntry.
   */
  kind?: string;

  /**
   * A label to identify this entry.
   */
  name?: string;

  /**
   * The allowlisted value for the access control list.
   */
  value?: string;
}

/**
 * An Operation resource.
 */
model Operation {
  /**
   * The name of this operation.
   */
  name?: string;

  /**
   * The type of the operation.
   */
  operationType?: OperationType;

  /**
   * The status of the operation.
   */
  status?: OperationStatus;

  /**
   * If errors occurred during processing of this operation, this field will be populated.
   */
  error?: OperationErrors;
}

/**
 * Database instance operation errors list wrapper.
 */
model OperationErrors {
  /**
   * The list of errors encountered while processing this operation.
   */
  @identifiers(#[])
  errors?: OperationError[];
}

/**
 * Database instance operation error.
 */
model OperationError {
  /**
   * Identifies the specific error that occurred.
   */
  code?: string;

  /**
   * This is always sql#operationError.
   */
  kind?: string;

  /**
   * Additional information about the error encountered.
   */
  message?: string;
}

/**
 * Database version that can be used for the instance.
 */
model AvailableDatabaseVersion {
  /**
   * The database engine version.
   */
  version?: string;

  /**
   * List of database editions supported.
   */
  supportedEditions?: string[];
}

/**
 * Configuration for a node in the instance pool.
 */
model PoolNodeConfig {
  /**
   * The ID of the node.
   */
  id?: string;

  /**
   * The name of the node.
   */
  name?: string;

  /**
   * The zone where the node is located.
   */
  zone?: string;

  /**
   * Current state of the node.
   */
  state?: PoolNodeState;

  /**
   * IP address of the node.
   */
  ipAddress?: string;
}

/**
 * DNS name mapping configuration.
 */
model DnsNameMapping {
  /**
   * The DNS record name.
   */
  name?: string;

  /**
   * The type of DNS record.
   */
  type?: string;

  /**
   * The value of the DNS record.
   */
  value?: string;
}

/**
 * Report about out of disk conditions.
 */
model SqlOutOfDiskReport {
  /**
   * Minimum recommended increase size in GB.
   */
  sqlMinRecommendedIncreaseSizeGb?: int32;

  /**
   * Current out of disk state.
   */
  sqlOutOfDiskState?: SqlOutOfDiskState;
}

/**
 * Configuration for replication cluster.
 */
model ReplicationCluster {
  /**
   * ID of the replication cluster.
   */
  clusterId?: string;

  /**
   * Status of the replication cluster.
   */
  status?: string;

  /**
   * Name of the leader instance.
   */
  leaderInstanceName?: string;
}

/**
 * Gemini instance configuration.
 */
model GeminiInstanceConfig {
  /**
   * The tier of the Gemini instance.
   */
  tier?: string;

  /**
   * Version of the configuration.
   */
  configVersion?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Suppress casing style as the name is defined in GCP."
@armResourceOperations
interface SQLAdminInstances {
  get is ArmResourceRead<SQLAdminInstance>;
  @doc("Create a SQL admin instance. Please note that end user resource creation is currently restricted, but it will be enabled in the future.")
  createOrReplace is ArmResourceCreateOrReplaceAsync<SQLAdminInstance>;
  update is ArmCustomPatchAsync<
    SQLAdminInstance,
    Azure.ResourceManager.Foundations.TagsUpdateModel<SQLAdminInstance>
  >;
  delete is ArmResourceDeleteWithoutOkAsync<SQLAdminInstance>;
  listByResourceGroup is ArmResourceListByParent<SQLAdminInstance>;
  listBySubscription is ArmListBySubscription<SQLAdminInstance>;
}

/**
 * Operation.operationType values, as defined by the Google Cloud API.
 */
union OperationType {
  string,

  /** Unknown operation type. */
  SQL_OPERATION_TYPE_UNSPECIFIED: "SQL_OPERATION_TYPE_UNSPECIFIED",

  /** Imports data into a Cloud SQL instance. */
  IMPORT: "IMPORT",

  /** Exports data from a Cloud SQL instance to a Cloud Storage bucket. */
  EXPORT: "EXPORT",

  /** Creates a new Cloud SQL instance. */
  CREATE: "CREATE",

  /** Updates the settings of a Cloud SQL instance. */
  UPDATE: "UPDATE",

  /** Deletes a Cloud SQL instance. */
  DELETE: "DELETE",

  /** Restarts the Cloud SQL instance. */
  RESTART: "RESTART",

  /** backup */
  BACKUP: "BACKUP",

  /** snapshot */
  SNAPSHOT: "SNAPSHOT",

  /** Performs instance backup. */
  BACKUP_VOLUME: "BACKUP_VOLUME",

  /** Deletes an instance backup. */
  DELETE_VOLUME: "DELETE_VOLUME",

  /** Restores an instance backup. */
  RESTORE_VOLUME: "RESTORE_VOLUME",

  /** Injects a privileged user in mysql for MOB instances. */
  INJECT_USER: "INJECT_USER",

  /** Clones a Cloud SQL instance. */
  CLONE: "CLONE",

  /** Stops replication on a Cloud SQL read replica instance. */
  STOP_REPLICA: "STOP_REPLICA",

  /** Starts replication on a Cloud SQL read replica instance. */
  START_REPLICA: "START_REPLICA",

  /** Promotes a Cloud SQL replica instance. */
  PROMOTE_REPLICA: "PROMOTE_REPLICA",

  /** Creates a Cloud SQL replica instance. */
  CREATE_REPLICA: "CREATE_REPLICA",

  /** Creates a new user in a Cloud SQL instance. */
  CREATE_USER: "CREATE_USER",

  /** Deletes a user from a Cloud SQL instance. */
  DELETE_USER: "DELETE_USER",

  /** Updates an existing user in a Cloud SQL instance. If a user with the specified username doesn't exist, a new user is created. */
  UPDATE_USER: "UPDATE_USER",

  /** Creates a database in the Cloud SQL instance. */
  CREATE_DATABASE: "CREATE_DATABASE",

  /** Deletes a database in the Cloud SQL instance. */
  DELETE_DATABASE: "DELETE_DATABASE",

  /** Updates a database in the Cloud SQL instance. */
  UPDATE_DATABASE: "UPDATE_DATABASE",

  /** Performs failover of an HA-enabled Cloud SQL failover replica. */
  FAILOVER: "FAILOVER",

  /** Deletes the backup taken by a backup run. */
  DELETE_BACKUP: "DELETE_BACKUP",

  /** recreate replica */
  RECREATE_REPLICA: "RECREATE_REPLICA",

  /** Truncates a general or slow log table in MySQL. */
  TRUNCATE_LOG: "TRUNCATE_LOG",

  /** Demotes the stand-alone instance to be a Cloud SQL read replica for an external database server. */
  DEMOTE_MASTER: "DEMOTE_MASTER",

  /** Indicates that the instance is currently in maintenance. Maintenance typically causes the instance to be unavailable for 1-3 minutes. */
  MAINTENANCE: "MAINTENANCE",

  /** This field is deprecated, and will be removed in future version of API. */
  ENABLE_PRIVATE_IP: "ENABLE_PRIVATE_IP",

  /** defer maintenance */
  DEFER_MAINTENANCE: "DEFER_MAINTENANCE",

  /** Creates clone instance. */
  CREATE_CLONE: "CREATE_CLONE",

  /** Reschedule maintenance to another time. */
  RESCHEDULE_MAINTENANCE: "RESCHEDULE_MAINTENANCE",

  /** Starts external sync of a Cloud SQL EM replica to an external primary instance. */
  START_EXTERNAL_SYNC: "START_EXTERNAL_SYNC",

  /** Recovers logs from an instance's old data disk. */
  LOG_CLEANUP: "LOG_CLEANUP",

  /** Performs auto-restart of an HA-enabled Cloud SQL database for auto recovery. */
  AUTO_RESTART: "AUTO_RESTART",

  /** Re-encrypts CMEK instances with latest key version. */
  REENCRYPT: "REENCRYPT",

  /** Switches the roles of the primary and replica pair. The target instance should be the replica. */
  SWITCHOVER: "SWITCHOVER",

  /** Update a backup. */
  UPDATE_BACKUP: "UPDATE_BACKUP",

  /** Acquire a lease for the setup of SQL Server Reporting Services (SSRS). */
  ACQUIRE_SSRS_LEASE: "ACQUIRE_SSRS_LEASE",

  /** Release a lease for the setup of SQL Server Reporting Services (SSRS). */
  RELEASE_SSRS_LEASE: "RELEASE_SSRS_LEASE",

  /** Reconfigures old primary after a promote replica operation. Effect of a promote operation to the old primary is executed in this operation, asynchronously from the promote replica operation executed to the replica. */
  RECONFIGURE_OLD_PRIMARY: "RECONFIGURE_OLD_PRIMARY",

  /** Indicates that the instance, its read replicas, and its cascading replicas are in maintenance. Maintenance typically gets initiated on groups of replicas first, followed by the primary instance. For each instance, maintenance typically causes the instance to be unavailable for 1-3 minutes. */
  CLUSTER_MAINTENANCE: "CLUSTER_MAINTENANCE",

  /** Indicates that the instance (and any of its replicas) are currently in maintenance. This is initiated as a self-service request by using SSM. Maintenance typically causes the instance to be unavailable for 1-3 minutes. */
  SELF_SERVICE_MAINTENANCE: "SELF_SERVICE_MAINTENANCE",

  /** Switches a primary instance to a replica. This operation runs as part of a switchover operation to the original primary instance. */
  SWITCHOVER_TO_REPLICA: "SWITCHOVER_TO_REPLICA",

  /** Updates the major version of a Cloud SQL instance. */
  MAJOR_VERSION_UPGRADE: "MAJOR_VERSION_UPGRADE",

  /** Deprecated: ADVANCED_BACKUP is deprecated. Use ENHANCED_BACKUP instead. */
  ADVANCED_BACKUP: "ADVANCED_BACKUP",

  /** Changes the BackupTier of a Cloud SQL instance. */
  MANAGE_BACKUP: "MANAGE_BACKUP",

  /** Creates a backup for an Enhanced BackupTier Cloud SQL instance. */
  ENHANCED_BACKUP: "ENHANCED_BACKUP",

  /** Repairs entire read pool or specified read pool nodes in the read pool. */
  REPAIR_READ_POOL: "REPAIR_READ_POOL",

  /** Creates a Cloud SQL read pool instance. */
  CREATE_READ_POOL: "CREATE_READ_POOL",

  /** Pre-checks the major version upgrade operation. */
  PRE_CHECK_MAJOR_VERSION_UPGRADE: "PRE_CHECK_MAJOR_VERSION_UPGRADE",

  /** This operation type represents individual steps in a multi-step setup migration workflow: including configuration, replication, switchover/back, and data reseeding, as defined by operation's intent. */
  SETUP_MIGRATION: "SETUP_MIGRATION",

  /** Creates a new Blue-Green deployment. */
  CREATE_BLUE_GREEN_DEPLOYMENT: "CREATE_BLUE_GREEN_DEPLOYMENT",

  /** Switches over a Blue-Green deployment. */
  SWITCHOVER_BLUE_GREEN_DEPLOYMENT: "SWITCHOVER_BLUE_GREEN_DEPLOYMENT",

  /** Deletes a Blue-Green deployment. */
  DELETE_BLUE_GREEN_DEPLOYMENT: "DELETE_BLUE_GREEN_DEPLOYMENT",
}

/**
 * Operation.status values, as defined by the Google Cloud API.
 */
union OperationStatus {
  string,

  /** The state of the operation is unknown. */
  SQL_OPERATION_STATUS_UNSPECIFIED: "SQL_OPERATION_STATUS_UNSPECIFIED",

  /** The operation has been queued, but has not started yet. */
  PENDING: "PENDING",

  /** The operation is running. */
  RUNNING: "RUNNING",

  /** The operation completed. */
  DONE: "DONE",
}

/**
 * IpMapping.type values, as defined by the Google Cloud API.
 */
union IpMappingType {
  string,

  /** This is an unknown IP address type. */
  SQL_IP_ADDRESS_TYPE_UNSPECIFIED: "SQL_IP_ADDRESS_TYPE_UNSPECIFIED",

  /** IP address the customer is supposed to connect to. Usually this is the load balancer's IP address */
  PRIMARY: "PRIMARY",

  /** Source IP address of the connection a read replica establishes to its external primary instance. This IP address can be allowlisted by the customer in case it has a firewall that filters incoming connection to its on premises primary instance. */
  OUTGOING: "OUTGOING",

  /** Private IP used when using private IPs and network peering. */
  PRIVATE: "PRIVATE",

  /** V1 IP of a migrated instance. We want the user to decommission this IP as soon as the migration is complete. Note: V1 instances with V1 ip addresses will be counted as PRIMARY. */
  MIGRATED_1ST_GEN: "MIGRATED_1ST_GEN",
}

/**
 * Settings.pricingPlan values, as defined by the Google Cloud API.
 */
union PricingPlan {
  string,

  /** This is an unknown pricing plan for this instance. */
  SQL_PRICING_PLAN_UNSPECIFIED: "SQL_PRICING_PLAN_UNSPECIFIED",

  /** The instance is billed at a monthly flat rate. */
  PACKAGE: "PACKAGE",

  /** The instance is billed per usage. */
  PER_USE: "PER_USE",
}

/**
 * Settings.replicationType values, as defined by the Google Cloud API.
 */
union ReplicationType {
  string,

  /** This is an unknown replication type for a Cloud SQL instance. */
  SQL_REPLICATION_TYPE_UNSPECIFIED: "SQL_REPLICATION_TYPE_UNSPECIFIED",

  /** The synchronous replication mode for First Generation instances. It is the default value. */
  SYNCHRONOUS: "SYNCHRONOUS",

  /** The asynchronous replication mode for First Generation instances. It provides a slight performance gain, but if an outage occurs while this option is set to asynchronous, you can lose up to a few seconds of updates to your data. */
  ASYNCHRONOUS: "ASYNCHRONOUS",
}

/**
 * Settings.availabilityType values, as defined by the Google Cloud API.
 */
union AvailabilityType {
  string,

  /** This is an unknown Availability type. */
  SQL_AVAILABILITY_TYPE_UNSPECIFIED: "SQL_AVAILABILITY_TYPE_UNSPECIFIED",

  /** Zonal available instance. */
  ZONAL: "ZONAL",

  /** Regional available instance. */
  REGIONAL: "REGIONAL",
}

/**
 * Settings.activationPolicy values, as defined by the Google Cloud API.
 */
union ActivationPolicy {
  string,

  /** Unknown activation plan. */
  SQL_ACTIVATION_POLICY_UNSPECIFIED: "SQL_ACTIVATION_POLICY_UNSPECIFIED",

  /** The instance is always up and running. */
  ALWAYS: "ALWAYS",

  /** The instance never starts. */
  NEVER: "NEVER",

  /** The instance starts upon receiving requests. */
  ON_DEMAND: "ON_DEMAND",
}

/**
 * Settings.dataDiskType values, as defined by the Google Cloud API.
 */
union DataDiskType {
  string,

  /** This is an unknown data disk type. */
  SQL_DATA_DISK_TYPE_UNSPECIFIED: "SQL_DATA_DISK_TYPE_UNSPECIFIED",

  /** An SSD data disk. */
  PD_SSD: "PD_SSD",

  /** An HDD data disk. */
  PD_HDD: "PD_HDD",

  /** This field is deprecated and will be removed from a future version of the API. */
  OBSOLETE_LOCAL_SSD: "OBSOLETE_LOCAL_SSD",

  /** A Hyperdisk Balanced data disk. */
  HYPERDISK_BALANCED: "HYPERDISK_BALANCED",
}

/**
 * MaintenanceWindow.updateTrack values, as defined by the Google Cloud API.
 */
union UpdateTrack {
  string,

  /** This is an unknown maintenance timing preference. */
  SQL_UPDATE_TRACK_UNSPECIFIED: "SQL_UPDATE_TRACK_UNSPECIFIED",

  /** For an instance with a scheduled maintenance window, this maintenance timing indicates that the maintenance update is scheduled 7 to 14 days after the notification is sent out. Also referred to as `Week 1` (Console) and `preview` (gcloud CLI). */
  canary: "canary",

  /** For an instance with a scheduled maintenance window, this maintenance timing indicates that the maintenance update is scheduled 15 to 21 days after the notification is sent out. Also referred to as `Week 2` (Console) and `production` (gcloud CLI). */
  stable: "stable",

  /** For instance with a scheduled maintenance window, this maintenance timing indicates that the maintenance update is scheduled 35 to 42 days after the notification is sent out. */
  week5: "week5",
}

/**
 * SqlOutOfDiskReport.sqlOutOfDiskState values, as defined by the Google Cloud API.
 */
union SqlOutOfDiskState {
  string,

  /** Unspecified state */
  SQL_OUT_OF_DISK_STATE_UNSPECIFIED: "SQL_OUT_OF_DISK_STATE_UNSPECIFIED",

  /** The instance has plenty space on data disk */
  NORMAL: "NORMAL",

  /** Data disk is almost used up. It is shutdown to prevent data corruption. */
  SOFT_SHUTDOWN: "SOFT_SHUTDOWN",
}

/**
 * BackupRetentionSettings.retentionUnit values, as defined by the Google Cloud API.
 */
union RetentionUnit {
  string,

  /** Backup retention unit is unspecified, will be treated as COUNT. */
  RETENTION_UNIT_UNSPECIFIED: "RETENTION_UNIT_UNSPECIFIED",

  /** Retention will be by count, eg. "retain the most recent 7 backups". */
  COUNT: "COUNT",
}

/**
 * PoolNodeConfig.state values, as defined by the Google Cloud API.
 */
union PoolNodeState {
  string,

  /** The state of the instance is unknown. */
  SQL_INSTANCE_STATE_UNSPECIFIED: "SQL_INSTANCE_STATE_UNSPECIFIED",

  /** The instance is running, or has been stopped by owner. */
  RUNNABLE: "RUNNABLE",

  /** The instance is not available, for example due to problems with billing. */
  SUSPENDED: "SUSPENDED",

  /** The instance is being deleted. */
  PENDING_DELETE: "PENDING_DELETE",

  /** The instance is being created. */
  PENDING_CREATE: "PENDING_CREATE",

  /** The instance is down for maintenance. */
  MAINTENANCE: "MAINTENANCE",

  /** The creation of the instance failed or a fatal error occurred during maintenance. */
  FAILED: "FAILED",

  /** Deprecated */
  ONLINE_MAINTENANCE: "ONLINE_MAINTENANCE",

  /** (Applicable to read pool nodes only.) The read pool node needs to be repaired. The database might be unavailable. */
  REPAIRING: "REPAIRING",
}

import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@azure-tools/typespec-client-generator-core";
import "@typespec/openapi";
import "@azure-tools/typespec-azure-portal-core";
import "../shared/main.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using OpenAPI;
using Azure.ResourceManager;
using Azure.Portal;

#suppress "@azure-tools/typespec-azure-resource-manager/missing-operations-endpoint" "Suppress missing operations endpoint as the same is defined ../operations/main.tsp."
@armProviderNamespace
@service(#{ title: "Microsoft.GcpConnector" })
@doc("Microsoft.GcpConnector Resource Provider management API.")
@versioned(Versions)
@armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v5)
namespace Microsoft.GcpConnector;

/** Api versions */
enum Versions {
  /** 2025-12-01-preview api version */
  `2025-12-01-preview`,
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
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Suppress no-unknown to handle the datatype object used in GCP"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Suppress arm-no-record to handle the datatype object used in GCP"
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
  @extension("x-ms-identifiers", #[])
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
  @extension("x-ms-identifiers", #[])
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
  type?: string;
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
  activationPolicy?: string;

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
  availabilityType?: string;

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
  dataDiskType?: string;

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
  pricingPlan?: string;

  /**
   * The type of replication this instance uses.
   */
  replicationType?: string;

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
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Suppress arm-no-record to handle the datatype object used in GCP"
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
  updateTrack?: string;
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
  retentionUnit?: string;
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
  operationType?: string;

  /**
   * The status of the operation.
   */
  status?: string;

  /**
   * If errors occurred during processing of this operation, this field will be populated.
   */
  error?: {
    @extension("x-ms-identifiers", #[])
    errors?: OperationError[];
  };
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
  state?: string;

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
  sqlOutOfDiskState?: string;
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

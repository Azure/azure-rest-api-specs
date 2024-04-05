import "./common.tsp";
import "./adbCommon.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;

namespace Oracle.Database;

//https://docs.oracle.com/en-us/iaas/api/#/en/database/20160918/AutonomousDatabase

@doc("AutonomousDatabaseLifecycleState enum")
enum AutonomousDatabaseLifecycleState {
  @doc("PROVISIONING value")
  Provisioning,
  @doc("AVAILABLE value")
  Available,
  @doc("STOPPING value")
  Stopping,
  @doc("STOPPED value")
  Stopped,
  @doc("STARTING value")
  Starting,
  @doc("TERMINATING value")
  Terminating,
  @doc("TERMINATED value")
  Terminated,
  @doc("UNAVAILABLE value")
  Unavailable,
  @doc("RESTORE_IN_PROGRESS value")
  RestoreInProgress,
  @doc("RESTORE_FAILED value")
  RestoreFailed,
  @doc("BACKUP_IN_PROGRESS value")
  BackupInProgress,
  @doc("SCALE_IN_PROGRESS value")
  ScaleInProgress,
  @doc("AVAILABLE_NEEDS_ATTENTION value")
  AvailableNeedsAttention,
  @doc("UPDATING value")
  Updating,
  @doc("MAINTENANCE_IN_PROGRESS value")
  MaintenanceInProgress,
  @doc("RESTARTING value")
  Restarting,
  @doc("RECREATING value")
  Recreating,
  @doc("ROLE_CHANGE_IN_PROGRESS value")
  RoleChangeInProgress,
  @doc("UPGRADING value")
  Upgrading,
  @doc("INACCESSIBLE value")
  Inaccessible,
  @doc("STANDBY value")
  Standby,
}

@doc("RefreshableModelType enum")
enum RefreshableModelType {
  @doc("AUTOMATIC value")
  Automatic,
  @doc("MANUAL value")
  Manual  
}

@doc("DataBaseType enum")
enum DataBaseType {
  @doc("REGULAR value")
  Regular,
  @doc("CLONE value")
  Clone  
}

@doc("ComputeModel enum")
enum ComputeModel {
  @doc("ECPU value")
  ECPU,
  @doc("OCPU value")
  OCPU,
}

@doc("CloneType enum")
enum CloneType {
  @doc("FULL value")
  Full,
  @doc("METADATA value")
  Metadata
}

@doc("AutonomousMaintenanceScheduleType enum.")
enum AutonomousMaintenanceScheduleType {
  @doc("EARLY value")
  Early,
  @doc("REGULAR value")
  Regular
}

@doc("SourceType enum.")
enum SourceType {
  @doc("NONE value")
  None,
  @doc("DATABASE value")
  Database,
  @doc("BACKUP_FROM_ID value")
  BackupFromId,
  @doc("BACKUP_FROM_TIMESTAMP value")
  BackupFromTimestamp,
  @doc("CLONE_TO_REFRESHABLE value")
  CloneToRefreshable,
  @doc("CROSS_REGION_DATAGUARD value")
  CrossRegionDataguard,
  @doc("CROSS_REGION_DISASTER_RECOVERY value")
  CrossRegionDisasterRecovery
}

@doc("TlsAuthenticationType enum.")
enum TlsAuthenticationType {
  @doc("SERVER value")
  Server,
  @doc("MUTUAL value")
  Mutual
}

@doc("SyntaxFormatType enum.")
enum SyntaxFormatType {
  @doc("LONG value")
  Long,
  @doc("EZCONNECT value")
  Ezconnect,
  @doc("EZCONNECTPLUS value")
  Ezconnectplus
}

@doc("SessionModeType enum.")
enum SessionModeType {
  @doc("DIRECT value")
  Direct,
  @doc("REDIRECT value")
  Redirect
}

@doc("ProtocolType enum.")
enum ProtocolType {
  @doc("TCP value")
  TCP,
  @doc("TCPS value")
  TCPS
}

@doc("HostFormatType enum.")
enum HostFormatType {
  @doc("FQDN value")
  Fqdn,
  @doc("IP value")
  Ip
}

@doc("ConsumerGroup enum.")
enum ConsumerGroup {
  @doc("HIGH value")
  High,
  @doc("MEDIUM value")
  Medium,
  @doc("LOW value")
  Low,
  @doc("TP value")
  Tp,
  @doc("TPURGENT value")
  Tpurgent,
}

@doc("DataSafeStatusType enum.")
enum DataSafeStatusType {
  @doc("REGISTERING value")
  Registering,
  @doc("REGISTERED value")
  Registered,
  @doc("DEREGISTERING value")
  Deregistering,
  @doc("NOT_REGISTERED value")
  NotRegistered,
  @doc("FAILED value")
  Failed
}

@doc("PermissionLevelType enum.")
enum PermissionLevelType {
  @doc("RESTRICTED value")
  Restricted,
  @doc("UNRESTRICTED value")
  Unrestricted
}

@doc("DatabaseEditionType enum.")
enum DatabaseEditionType {
  @doc("STANDARD_EDITION value")
  StandardEdition,
  @doc("ENTERPRISE_EDITION value")
  EnterpriseEdition
}

@doc("OpenModeType enum.")
enum OpenModeType {
  @doc("READ_ONLY value")
  ReadOnly,
  @doc("READ_WRITE value")
  ReadWrite
}

@doc("OperationsInsightsStatusType enum.")
enum OperationsInsightsStatusType {
  @doc("ENABLING value")
  Enabling,
  @doc("ENABLED value")
  Enabled,
  @doc("DISABLING value")
  Disabling,
  @doc("NOT_ENABLED value")
  NotEnabled,
  @doc("FAILED_ENABLING value")
  FailedEnabling,
  @doc("FAILED_DISABLING value")
  FailedDisabling
}

@doc("RoleType enum.")
enum RoleType {
  @doc("PRIMARY value")
  Primary,
  @doc("STANDBY value")
  Standby,
  @doc("DISABLED_STANDBY value")
  DisabledStandby,
  @doc("BACKUP_COPY value")
  BackupCopy,
  @doc("SNAPSHOT_STANDBY value")
  SnapshotStandby
}

@doc("RefreshableStatusType enum.")
enum RefreshableStatusType {
  @doc("REFRESHING value")
  Refreshing,
  @doc("NOT_REFRESHING value")
  NotRefreshing
}

@doc("DisasterRecoveryType enum.")
enum DisasterRecoveryType {
  @doc("ADG value")
  Adg,
  @doc("BACKUP_BASED value")
  BackupBased
}

@doc("PeerDb Details")
model PeerDbDetails {
  @doc("The database OCID of the Disaster Recovery peer database, which is located in a different region from the current peer database.")
  @minLength(1)
  @maxLength(255)
  peerDbId?: string;
}

@doc("Autonomous Disaster Recovery standby database details.")
model AutonomousDatabaseStandbySummary {
   @doc("The amount of time, in seconds, that the data of the standby database lags the data of the primary database. Can be used to determine the potential data loss in the event of a failover.")
   lagTimeInSeconds?: int32;
   @doc("The current state of the Autonomous Database.")
   lifecycleState?: AutonomousDatabaseLifecycleState;
   @doc("Additional information about the current lifecycle state.")
   lifecycleDetails?: string;
   @doc("The date and time the Autonomous Data Guard role was switched for the standby Autonomous Database.")
   timeDataGuardRoleChanged?: string;
   @doc("The date and time the Disaster Recovery role was switched for the standby Autonomous Database.")
   timeDisasterRecoveryRoleChanged?: string;
}

@doc("Information about Oracle APEX Application Development.")
model ApexDetailsType {
  @doc("The Oracle APEX Application Development version.")
  apexVersion?: string;
  @doc("The Oracle REST Data Services (ORDS) version.")
  ordsVersion?: string;
}

@doc("The connection string profile to allow clients to group, filter and select connection string values based on structured metadata.")
model AllConnectionStringType {
  @doc("The High database service provides the highest level of resources to each SQL statement resulting in the highest performance, but supports the fewest number of concurrent SQL statements.")
  @minLength(10)
  @maxLength(255)
  high?: string;

  @doc("The Low database service provides the least level of resources to each SQL statement, but supports the most number of concurrent SQL statements.")
  @minLength(10)
  @maxLength(255)
  low?: string;

  @doc("The Medium database service provides a lower level of resources to each SQL statement potentially resulting a lower level of performance, but supports more concurrent SQL statements.")
  @minLength(10)
  @maxLength(255)
  medium?: string;
}

@doc("The URLs for accessing Oracle Application Express (APEX) and SQL Developer Web with a browser from a Compute instance within your VCN or that has a direct connection to your VCN.")
model ConnectionUrlType {
  @doc("Oracle Application Express (APEX) URL.")
  @minLength(10)
  @maxLength(512)
  apexUrl?: string;

  @doc("The URL of the Database Transforms for the Autonomous Database.")
  @minLength(10)
  @maxLength(512)
  databaseTransformsUrl?: string;

  @doc("The URL of the Graph Studio for the Autonomous Database.")
  @minLength(10)
  @maxLength(512)
  graphStudioUrl?: string;

  @doc("The URL of the Oracle Machine Learning (OML) Notebook for the Autonomous Database.")
  @minLength(10)
  @maxLength(512)
  machineLearningNotebookUrl?: string;

  @doc("The URL of the MongoDB API for the Autonomous Database.")
  @minLength(10)
  @maxLength(512)
  mongoDbUrl?: string;

  @doc("The Oracle REST Data Services (ORDS) URL of the Web Access for the Autonomous Database.")
  @minLength(10)
  @maxLength(512)
  ordsUrl?: string;

  @doc("Oracle SQL Developer Web URL.")
  @minLength(10)
  @maxLength(512)
  sqlDevWebUrl?: string;
}

@doc("The connection string profile to allow clients to group, filter and select connection string values based on structured metadata.")
model ProfileType {
  @doc("Consumer group used by the connection.")
  consumerGroup?: ConsumerGroup;

  @doc("A user-friendly name for the connection.")
  @minLength(1)
  @maxLength(255)
  displayName: string;

  @doc("Host format used in connection string.")
  hostFormat: HostFormatType;
  
  @doc("True for a regional connection string, applicable to cross-region DG only.")
  isRegional?: boolean;
  
  @doc("Protocol used by the connection.")
  protocol: ProtocolType;

  @doc("Specifies whether the listener performs a direct hand-off of the session, or redirects the session.")
  sessionMode: SessionModeType;
  
  @doc("Specifies whether the connection string is using the long (LONG), Easy Connect (EZCONNECT), or Easy Connect Plus (EZCONNECTPLUS) format.")
  syntaxFormat: SyntaxFormatType;

  @doc("Specifies whether the TLS handshake is using one-way (SERVER) or mutual (MUTUAL) authentication.")
  tlsAuthentication?: TlsAuthenticationType;
  
  @doc("Connection string value.")
  value: string;
}

@doc("Connection strings to connect to an Oracle Autonomous Database.")
model ConnectionStringType {
  @doc("Returns all connection strings that can be used to connect to the Autonomous Database.")
  allConnectionStrings?: AllConnectionStringType;
  
  @doc("The database service provides the least level of resources to each SQL statement, but supports the most number of concurrent SQL statements.")
  @minLength(10)
  @maxLength(255)
  dedicated?: string;

  @doc("The High database service provides the highest level of resources to each SQL statement resulting in the highest performance, but supports the fewest number of concurrent SQL statements.")
  @minLength(10)
  @maxLength(255)
  high?: string;

  @doc("The Low database service provides the least level of resources to each SQL statement, but supports the most number of concurrent SQL statements.")
  @minLength(10)
  @maxLength(255)
  low?: string;

  @doc("The Medium database service provides a lower level of resources to each SQL statement potentially resulting a lower level of performance, but supports more concurrent SQL statements.")
  @minLength(10)
  @maxLength(255)
  medium?: string;

  @doc("A list of connection string profiles to allow clients to group, filter and select connection string values based on structured metadata.")
  profiles?: ProfileType[];
}

@doc("The list of scheduled operations.")
model ScheduledOperationsType {
  @doc("Day of week")
  dayOfWeek: DayOfWeek;

  @doc("auto start time. value must be of ISO-8601 format HH:mm")
  @minLength(1)
  @maxLength(50)
  scheduledStartTime?: string;

  @doc("auto stop time. value must be of ISO-8601 format HH:mm")
  @minLength(1)
  @maxLength(50)
  scheduledStopTime?: string;
}

@doc("Autonomous Database  resource model.")
model AutonomousDatabase is TrackedResource<AutonomousDatabaseBaseProperties> {
  @doc("The database name.")
  @key("autonomousdatabasename")
  @path
  @segment("autonomousDatabases")
  @minLength(1)
  @maxLength(30)
  name: string;
}

@doc("Autonomous Database resource model.")
model AutonomousDatabaseProperties extends AutonomousDatabaseBaseProperties {
  @doc("Database type to be created.")
  dataBaseType: DataBaseType.Regular;
}

@doc("Autonomous Database clone resource model.")
model AutonomousDatabaseCloneProperties extends AutonomousDatabaseBaseProperties {
  @doc("Database type to be created.")
  dataBaseType: DataBaseType.Clone;

  @doc("The source of the database.")
  @visibility("create")
  source?: SourceType;

  @doc("The Azure ID of the Autonomous Database that was cloned to create the current Autonomous Database.")
  @visibility("create","read") 
  sourceId: AutonomousDatabaseId;

  @doc("The Autonomous Database clone type.")
  @visibility("create")
  cloneType: CloneType;

  @doc("Indicates if the refreshable clone can be reconnected to its source database.")
  @visibility("read")
  isReconnectCloneEnabled?: boolean;

  @doc("Indicates if the Autonomous Database is a refreshable clone.")
  @visibility("read")
  isRefreshableClone?: boolean;

  @doc("The refresh mode of the clone.")
  @visibility("create")
  refreshableModel?: RefreshableModelType;

  @doc("The refresh status of the clone.")
  @visibility("read")
  refreshableStatus?: RefreshableStatusType;

  @doc("The time and date as an RFC3339 formatted string, e.g., 2022-01-01T12:00:00.000Z, to set the limit for a refreshable clone to be reconnected to its source database.")
  @visibility("read","update")
  timeUntilReconnectCloneEnabled?: string;
}

@discriminator("dataBaseType")
@doc("Autonomous Database base resource model.")
model AutonomousDatabaseBaseProperties {
  @doc("Admin password.")
  @visibility("create","update")
  @minLength(12)
  @maxLength(30)
  adminPassword?: Password;

  @doc("Database type to be created.")
  @visibility("create")
  dataBaseType: DataBaseType;

  @doc("The maintenance schedule type of the Autonomous Database Serverless.")
  @visibility("create","read","update")
  autonomousMaintenanceScheduleType?: AutonomousMaintenanceScheduleType;

  @doc("The character set for the autonomous database.")
  @visibility("create","read")
  @minLength(1)
  @maxLength(255)
  characterSet?: string;

  @doc("The compute amount (CPUs) available to the database.")
  @visibility("create","read","update")
  @minValue(0.1)
  @maxValue(512)
  computeCount?: float32;

  @doc("The compute model of the Autonomous Database.")
  @visibility("create","read")
  computeModel?: ComputeModel;

  @doc("The number of CPU cores to be made available to the database.")
  @visibility("create","read","update")
  @minValue(1)
  @maxValue(128)
  cpuCoreCount?: int32;

  @doc("Customer Contacts.")
  @visibility("create","read","update")
  customerContacts?: CustomerContact[];

  @doc("The quantity of data in the database, in terabytes.")
  @visibility("create","read","update")
  @minValue(1)
  @maxValue(384)
  dataStorageSizeInTbs?: int32;

  @doc("The size, in gigabytes, of the data volume that will be created and attached to the database.")
  @visibility("create","read","update")
  @minValue(20)
  @maxValue(393216)
  dataStorageSizeInGbs?: int32;

  @doc("A valid Oracle Database version for Autonomous Database.")
  @visibility("create","read")
  @minLength(1)
  @maxLength(255)
  dbVersion?: string;

  @doc("The Autonomous Database workload type")
  @visibility("create","read")
  dbWorkload?: WorkloadType;
  
  @doc("The user-friendly name for the Autonomous Database.")
  @visibility("create","read","update")
  @minLength(1)
  @maxLength(255)
  displayName?: string;

  @doc("Indicates if auto scaling is enabled for the Autonomous Database CPU core count.")
  @visibility("create","read","update")
  isAutoScalingEnabled?: boolean;

  @doc("Indicates if auto scaling is enabled for the Autonomous Database storage.")
  @visibility("create","read","update")
  isAutoScalingForStorageEnabled?: boolean;

  @doc("The list of [OCIDs](https://docs.oracle.com/iaas/Content/General/Concepts/identifiers.htm) of standby databases located in Autonomous Data Guard remote regions that are associated with the source database. Note that for Autonomous Database Serverless instances, standby databases located in the same region as the source primary database do not have OCIDs.")
  @visibility("read")
  peerDbIds?: string[];

  @doc("The database OCID of the Disaster Recovery peer database, which is located in a different region from the current peer database.")
  @visibility("update")
  @minLength(1)
  @maxLength(255)
  peerDbId?: string;

  @doc("Indicates whether the Autonomous Database has local or called in-region Data Guard enabled.")
  @visibility("create","read","update")
  isLocalDataGuardEnabled?: boolean;

  @doc("Indicates whether the Autonomous Database has Cross Region Data Guard enabled.")
  @visibility("read")
  isRemoteDataGuardEnabled?: boolean;

  @doc("Indicates the local disaster recovery (DR) type of the Autonomous Database Serverless instance.Autonomous Data Guard (ADG) DR type provides business critical DR with a faster recovery time objective (RTO) during failover or switchover.Backup-based DR type provides lower cost DR with a slower RTO during failover or switchover.")
  @visibility("read")
  localDisasterRecoveryType?: DisasterRecoveryType;

  @doc("Local Autonomous Disaster Recovery standby database details.")
  @visibility("read")
  localStandbyDb?: AutonomousDatabaseStandbySummary;

  @doc("Indicates the number of seconds of data loss for a Data Guard failover.")
  @visibility("read")
  failedDataRecoveryInSeconds?: int32;

  @doc("Specifies if the Autonomous Database requires mTLS connections.")
  @visibility("create","read","update")
  isMtlsConnectionRequired?: boolean;

  @doc("Specifies if the Autonomous Database preview version is being provisioned.")
  @visibility("create")
  isPreviewVersionWithServiceTermsAccepted?: boolean;

  @doc("The Oracle license model that applies to the Oracle Autonomous Database. The default is LICENSE_INCLUDED.")
  @visibility("create","read","update")
  licenseModel?: LicenseModel;

  @doc("The character set for the Autonomous Database.")
  @visibility("create","read")
  @minLength(1)
  @maxLength(255)
  ncharacterSet?: string;

  @doc("Additional information about the current lifecycle state.")
  @visibility("read")
  lifecycleDetails?: string;

  @doc("Azure resource provisioning state.")
  @visibility("read")
  provisioningState?: AzureResourceProvisioningState;

  @doc("Views lifecycleState")
  @visibility("read")
  lifecycleState?: AutonomousDatabaseLifecycleState;

  @doc("The list of scheduled operations.")
  @visibility("create","read","update")
  scheduledOperations?: ScheduledOperationsType;

  @doc("The private endpoint Ip address for the resource.")
  @visibility("create","read")
  privateEndpointIp?: string;

  @doc("The resource's private endpoint label.")
  @visibility("create","read")  
  privateEndpointLabel?: string;

  @doc("HTTPS link to OCI resources exposed to Azure Customer via Azure Interface.")
  @visibility("read")
  ociUrl?: string;

  @doc("Client subnet")
  @visibility("create","read")
  subnetId?: SubnetId;

  @doc("VNET for network connectivity")
  @visibility("create", "read")
  vnetId?: VnetId;

  @doc("The date and time that the database was created.")
  @visibility("read")
  timeCreated?: utcDateTime;

  @doc("The date and time when maintenance will begin.")
  @visibility("read")
  timeMaintenanceBegin?: utcDateTime;

  @doc("The date and time when maintenance will end.")
  @visibility("read")
  timeMaintenanceEnd?: utcDateTime;
  
  @doc("The current amount of storage in use for user and system data, in terabytes (TB).")
  @visibility("read")
  actualUsedDataStorageSizeInTbs?: int32;

  @doc("The amount of storage currently allocated for the database tables and billed for, rounded up.")
  @visibility("read")
  allocatedStorageSizeInTbs?: int32;

  @doc("Information about Oracle APEX Application Development.")
  @visibility("read")
  apexDetails?: ApexDetailsType;

  @doc("List of Oracle Database versions available for a database upgrade. If there are no version upgrades available, this list is empty.")
  @visibility("read")
  availableUpgradeVersions?: string[];

  @doc("The connection string used to connect to the Autonomous Database.")
  @visibility("read")
  connectionStrings?: ConnectionStringType;

  @doc("The URLs for accessing Oracle Application Express (APEX) and SQL Developer Web with a browser from a Compute instance within your VCN or that has a direct connection to your VCN. ")
  @visibility("read")
  connectionUrls?: ConnectionUrlType;

  @doc("Status of the Data Safe registration for this Autonomous Database.")
  @visibility("read")
  dataSafeStatus?: DataSafeStatusType;

  @doc("The Oracle Database Edition that applies to the Autonomous databases.")
  @visibility("create","read","update")
  databaseEdition?: DatabaseEditionType;

  @doc("Autonomous Database ID")
  @visibility("create", "read")
  autonomousDatabaseId?: AutonomousDatabaseId;

  @doc("The area assigned to In-Memory tables in Autonomous Database.")
  @visibility("read")
  inMemoryAreaInGbs?: int32;

  @doc("Indicates if the Autonomous Database version is a preview version.")
  @visibility("read")
  isPreview?: boolean;

  @doc("Parameter that allows users to select an acceptable maximum data loss limit in seconds, up to which Automatic Failover will be triggered when necessary for a Local Autonomous Data Guard")
  @visibility("update","read")
  @minValue(0)
  @maxValue(3600)
  localAdgAutoFailoverMaxDataLossLimit?: int32;

  @doc("The amount of memory (in GBs) enabled per ECPU or OCPU.")
  @visibility("read")
  memoryPerOracleComputeUnitInGbs?: int32;

  @doc("Indicates the Autonomous Database mode.")
  @visibility("update","read")
  openMode?: OpenModeType;

  @doc("Status of Operations Insights for this Autonomous Database.")
  @visibility("read")
  operationsInsightsStatus?: OperationsInsightsStatusType;

  @doc("The Autonomous Database permission level.")
  @visibility("read","update")
  permissionLevel?: PermissionLevelType;

  @doc("The private endpoint for the resource.")
  @visibility("read")
  privateEndpoint?: string;

  @doc("An array of CPU values that an Autonomous Database can be scaled to.")
  @visibility("read")
  provisionableCpus?: int32[];

  @doc("The Data Guard role of the Autonomous Container Database or Autonomous Database, if Autonomous Data Guard is enabled.")
  @visibility("read","update")
  role?: RoleType;

  @doc("The URL of the Service Console for the Autonomous Database.")
  @visibility("read")
  @minLength(10)
  @maxLength(255)
  serviceConsoleUrl?: string;

  @doc("The SQL Web Developer URL for the Oracle Autonomous Database.")
  @visibility("read")
  @minLength(10)
  @maxLength(2048)
  sqlWebDeveloperUrl?: string;

  @doc("The list of regions that support the creation of an Autonomous Database clone or an Autonomous Data Guard standby database.")
  @visibility("read")
  @maxItems(50)
  supportedRegionsToCloneTo?: string[];

  @doc("The date and time the Autonomous Data Guard role was switched for the Autonomous Database.")
  @visibility("read")
  timeDataGuardRoleChanged?: string;

  @doc("The date and time the Always Free database will be automatically deleted because of inactivity.")
  @visibility("read")
  timeDeletionOfFreeAutonomousDatabase?: string;

  @doc("The date and time that Autonomous Data Guard was enabled for an Autonomous Database where the standby was provisioned in the same region as the primary database.")
  @visibility("read")
  timeLocalDataGuardEnabled?: string;

  @doc("The timestamp of the last failover operation.")
  @visibility("read")
  timeOfLastFailover?: string;

  @doc("The date and time when last refresh happened.")
  @visibility("read")
  timeOfLastRefresh?: string;

  @doc("The refresh point timestamp (UTC).")
  @visibility("read")
  timeOfLastRefreshPoint?: string;

  @doc("The timestamp of the last switchover operation for the Autonomous Database.")
  @visibility("read")
  timeOfLastSwitchover?: string;

  @doc("The date and time the Always Free database will be stopped because of inactivity.")
  @visibility("read")
  timeReclamationOfFreeAutonomousDatabase?: string;

  @doc("The storage space consumed by Autonomous Database in GBs.")
  @visibility("read")
  usedDataStorageSizeInGbs?: int32;
  
  @doc("The amount of storage that has been used, in terabytes.")
  @visibility("read")
  usedDataStorageSizeInTbs?: int32;

  @doc("Database ocid")
  @visibility("read")
  ocid?: Ocid;

  @doc("Retention period, in days, for long-term backups")
  @visibility("create", "read", "update")
  backupRetentionPeriodInDays?: int32;
}

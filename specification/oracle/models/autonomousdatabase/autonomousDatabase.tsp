import "../common.tsp";
import "./adbCommon.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;

namespace Oracle.Database;

//https://docs.oracle.com/en-us/iaas/api/#/en/database/20160918/AutonomousDatabase

@minLength(1)
@maxLength(1024)
@doc("The client IP access control list (ACL). This is an array of CIDR notations and/or IP addresses. Values should be separate strings, separated by commas. Example: ['1.1.1.1','1.1.1.0/24','1.1.2.25']")
scalar aclString extends string;

@doc("Autonomous database lifecycle state enum")
union AutonomousDatabaseLifecycleState {
  @doc("Indicates that resource in Provisioning state")
  Provisioning: "Provisioning",

  @doc("Indicates that resource in Available state")
  Available: "Available",

  @doc("Indicates that resource in Stopping state")
  Stopping: "Stopping",

  @doc("Indicates that resource in Stopped state")
  Stopped: "Stopped",

  @doc("Indicates that resource in Starting state")
  Starting: "Starting",

  @doc("Indicates that resource in Terminating state")
  Terminating: "Terminating",

  @doc("Indicates that resource in Terminated state")
  Terminated: "Terminated",

  @doc("Indicates that resource in Unavailable state")
  Unavailable: "Unavailable",

  @doc("Indicates that resource in RestoreInProgress state")
  RestoreInProgress: "RestoreInProgress",

  @doc("Indicates that resource in RestoreFailed state")
  RestoreFailed: "RestoreFailed",

  @doc("Indicates that resource in BackupInProgress state")
  BackupInProgress: "BackupInProgress",

  @doc("Indicates that resource in ScaleInProgress state")
  ScaleInProgress: "ScaleInProgress",

  @doc("Indicates that resource is available but needs attention")
  AvailableNeedsAttention: "AvailableNeedsAttention",

  @doc("Indicates that resource in Updating state")
  Updating: "Updating",

  @doc("Indicates that resource maintenance in progress state")
  MaintenanceInProgress: "MaintenanceInProgress",

  @doc("Indicates that resource in Restarting state")
  Restarting: "Restarting",

  @doc("Indicates that resource in Recreating state")
  Recreating: "Recreating",

  @doc("Indicates that resource role change in progress state")
  RoleChangeInProgress: "RoleChangeInProgress",

  @doc("Indicates that resource in Upgrading state")
  Upgrading: "Upgrading",

  @doc("IIndicates that resource in Inaccessible state")
  Inaccessible: "Inaccessible",

  @doc("Indicates that resource in Standby state")
  Standby: "Standby",

  string,
}

@doc("Refreshable model type enum")
union RefreshableModelType {
  @doc("Automatic refreshable model type")
  Automatic: "Automatic",

  @doc("Manual refreshable model type")
  Manual: "Manual",

  string,
}

@doc("Repeat cadence type enum")
union RepeatCadenceType {
  @doc("Repeat one time")
  OneTime: "OneTime",

  @doc("Repeat weekly")
  Weekly: "Weekly",

  @doc("Repeat monthly")
  Monthly: "Monthly",

  @doc("Repeat yearly")
  Yearly: "Yearly",

  string,
}

@doc("Database type enum")
union DataBaseType {
  @doc("Regular DB")
  Regular: "Regular",

  @doc("Clone DB")
  Clone: "Clone",

  @added(Versions.v20240801_preview)
  @doc("Clone DB from backup timestamp")
  CloneFromBackupTimestamp: "CloneFromBackupTimestamp",

  @added(Versions.v20241001_preview)
  @doc("Cross Region Disaster Recovery")
  CrossRegionDisasterRecovery: "CrossRegionDisasterRecovery",

  string,
}

@doc("Compute model enum")
union ComputeModel {
  @doc("ECPU model type")
  ECPU: "ECPU",

  @doc("OCPU model type")
  OCPU: "OCPU",

  string,
}

@doc("Clone type enum")
union CloneType {
  @doc("Full clone")
  Full: "Full",

  @doc("Metadata only")
  Metadata: "Metadata",

  string,
}

@doc("Autonomous database maintenance schedule type enum.")
union AutonomousMaintenanceScheduleType {
  @doc("Early maintenance schedule")
  Early: "Early",

  @doc("Regular maintenance schedule")
  Regular: "Regular",

  string,
}

@doc("Source type enum.")
union SourceType {
  @doc("None source")
  None: "None",

  @doc("Database source")
  Database: "Database",

  @doc("Backup from ID source")
  BackupFromId: "BackupFromId",

  @doc("Backup from timestamp source")
  BackupFromTimestamp: "BackupFromTimestamp",

  @doc("Clone to refreshable source")
  CloneToRefreshable: "CloneToRefreshable",

  @doc("Cross region dataguard source")
  CrossRegionDataguard: "CrossRegionDataguard",

  @doc("cross region disaster recovery source")
  CrossRegionDisasterRecovery: "CrossRegionDisasterRecovery",

  string,
}

@doc("TLS authentication type enum.")
union TlsAuthenticationType {
  @doc("Server authentication")
  Server: "Server",

  @doc("Mutual TLS")
  Mutual: "Mutual",

  string,
}

@doc("Syntax format type enum.")
union SyntaxFormatType {
  @doc("Long format")
  Long: "Long",

  @doc("Ezconnect format")
  Ezconnect: "Ezconnect",

  @doc("Ezconnectplus format")
  Ezconnectplus: "Ezconnectplus",

  string,
}

@doc("Session mode type enum.")
union SessionModeType {
  @doc("Direct session mode")
  Direct: "Direct",

  @doc("Redirect session mode")
  Redirect: "Redirect",

  string,
}

@doc("Protocol type enum.")
union ProtocolType {
  @doc("TCP protocol")
  TCP: "TCP",

  @doc("TCPS protocol")
  TCPS: "TCPS",

  string,
}

@doc("Host format type enum.")
union HostFormatType {
  @doc("FQDN format")
  Fqdn: "Fqdn",

  @doc("IP format")
  Ip: "Ip",

  string,
}

@doc("Consumer group enum.")
union ConsumerGroup {
  @doc("High group")
  High: "High",

  @doc("Medium group")
  Medium: "Medium",

  @doc("Low group")
  Low: "Low",

  @doc("TP group")
  Tp: "Tp",

  @doc("TPurgent group")
  Tpurgent: "Tpurgent",

  string,
}

@doc("DataSafe status type enum.")
union DataSafeStatusType {
  @doc("Registering status")
  Registering: "Registering",

  @doc("Registered status")
  Registered: "Registered",

  @doc("Deregistering status")
  Deregistering: "Deregistering",

  @doc("NotRegistered status")
  NotRegistered: "NotRegistered",

  @doc("Failed status")
  Failed: "Failed",

  string,
}

@doc("Permission level type enum.")
union PermissionLevelType {
  @doc("Restricted permission level")
  Restricted: "Restricted",

  @doc("Unrestricted permission level")
  Unrestricted: "Unrestricted",

  string,
}

@doc("Database edition type enum.")
union DatabaseEditionType {
  @doc("Standard edition")
  StandardEdition: "StandardEdition",

  @doc("Enterprise edition")
  EnterpriseEdition: "EnterpriseEdition",

  string,
}

@doc("Open mode type enum.")
union OpenModeType {
  @doc("ReadOnly mode")
  ReadOnly: "ReadOnly",

  @doc("ReadWrite mode")
  ReadWrite: "ReadWrite",

  string,
}

@doc("Operations Insights status type enum.")
union OperationsInsightsStatusType {
  @doc("Enabling status")
  Enabling: "Enabling",

  @doc("Enabled status")
  Enabled: "Enabled",

  @doc("Disabling status")
  Disabling: "Disabling",

  @doc("NotEnabled status")
  NotEnabled: "NotEnabled",

  @doc("FailedEnabling status")
  FailedEnabling: "FailedEnabling",

  @doc("FailedDisabling status")
  FailedDisabling: "FailedDisabling",

  string,
}

@doc("Role type enum.")
union RoleType {
  @doc("Primary role")
  Primary: "Primary",

  @doc("Standby role")
  Standby: "Standby",

  @doc("DisabledStandby role")
  DisabledStandby: "DisabledStandby",

  @doc("BackupCopy role")
  BackupCopy: "BackupCopy",

  @doc("SnapshotStandby role")
  SnapshotStandby: "SnapshotStandby",

  string,
}

@doc("Refreshable status type enum.")
union RefreshableStatusType {
  @doc("Refreshing status")
  Refreshing: "Refreshing",

  @doc("NotRefreshing status")
  NotRefreshing: "NotRefreshing",

  string,
}

@doc("Disaster recovery type enum.")
union DisasterRecoveryType {
  @doc("ADG type")
  Adg: "Adg",

  @doc("Backup based type")
  BackupBased: "BackupBased",

  string,
}

@doc("Generate type enum")
union GenerateType {
  @doc("Generate single")
  Single: "Single",

  @doc("Generate all")
  All: "All",

  string,
}

@doc("PeerDb Details")
model PeerDbDetails {
  @doc("The Azure resource ID of the Disaster Recovery peer database, which is located in a different region from the current peer database.")
  @minLength(1)
  @maxLength(255)
  peerDbId?: string;

  @added(Versions.v20241001_preview)
  @doc("Ocid of the Disaster Recovery peer database, which is located in a different region from the current peer database.")
  peerDbOcid?: string;

  @added(Versions.v20241001_preview)
  @doc("The location of the Disaster Recovery peer database.")
  peerDbLocation?: string;
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

@doc("Details for the long-term backup schedule.")
model LongTermBackUpScheduleDetails {
  @doc("The frequency of the long-term backup schedule")
  repeatCadence?: RepeatCadenceType;

  @doc("The timestamp for the long-term backup schedule. For a MONTHLY cadence, months having fewer days than the provided date will have the backup taken on the last day of that month.")
  timeOfBackup?: utcDateTime;

  @doc("Retention period, in days, for backups.")
  retentionPeriodInDays?: RetentionPeriod;

  @doc("Indicates if the long-term backup schedule should be deleted. The default value is `FALSE`.")
  isDisabled?: boolean;
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
  @OpenAPI.extension("x-ms-identifiers", #[])
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
  @pattern(".*")
  name: string;
}

@doc("Autonomous Database resource model.")
model AutonomousDatabaseProperties extends AutonomousDatabaseBaseProperties {
  @doc("Database type to be created.")
  dataBaseType: DataBaseType.Regular;
}

@doc("Autonomous Database clone resource model.")
model AutonomousDatabaseCloneProperties
  extends AutonomousDatabaseBaseProperties {
  @doc("Database type to be created.")
  dataBaseType: DataBaseType.Clone;

  @doc("The source of the database.")
  @visibility(Lifecycle.Create)
  source?: SourceType;

  @doc("The Azure resource ID of the Autonomous Database that was cloned to create the current Autonomous Database.")
  @visibility(Lifecycle.Create, Lifecycle.Read)
  sourceId: AutonomousDatabaseId;

  @doc("The Autonomous Database clone type.")
  @visibility(Lifecycle.Create)
  cloneType: CloneType;

  @doc("Indicates if the refreshable clone can be reconnected to its source database.")
  @visibility(Lifecycle.Read)
  isReconnectCloneEnabled?: boolean;

  @doc("Indicates if the Autonomous Database is a refreshable clone.")
  @visibility(Lifecycle.Read)
  isRefreshableClone?: boolean;

  @doc("The refresh mode of the clone.")
  @visibility(Lifecycle.Create)
  refreshableModel?: RefreshableModelType;

  @doc("The refresh status of the clone.")
  @visibility(Lifecycle.Read)
  refreshableStatus?: RefreshableStatusType;

  @doc("The time and date as an RFC3339 formatted string, e.g., 2022-01-01T12:00:00.000Z, to set the limit for a refreshable clone to be reconnected to its source database.")
  @visibility(Lifecycle.Read, Lifecycle.Update)
  timeUntilReconnectCloneEnabled?: string;
}

@added(Versions.v20241001_preview)
@doc("Autonomous Database Cross Region Disaster Recovery resource model.")
model AutonomousDatabaseCrossRegionDisasterRecoveryProperties
  extends AutonomousDatabaseBaseProperties {
  @doc("Database type to be created.")
  dataBaseType: DataBaseType.CrossRegionDisasterRecovery;

  @doc("The source of the database.")
  @visibility(Lifecycle.Create)
  source: SourceType.CrossRegionDisasterRecovery;

  @doc("The Azure resource ID of the source Autonomous Database that will be used to create a new peer database for the DR association.")
  @visibility(Lifecycle.Create, Lifecycle.Read)
  sourceId: AutonomousDatabaseId;

  @doc("The name of the region where source Autonomous Database exists.")
  @visibility(Lifecycle.Create)
  sourceLocation?: string;

  @doc("The source database ocid")
  @visibility(Lifecycle.Create)
  @minLength(1)
  @maxLength(255)
  sourceOcid?: string;

  @doc("Indicates the cross-region disaster recovery (DR) type of the standby Autonomous Database Serverless instance. Autonomous Data Guard (ADG) DR type provides business critical DR with a faster recovery time objective (RTO) during failover or switchover. Backup-based DR type provides lower cost DR with a slower RTO during failover or switchover.")
  @visibility(Lifecycle.Create, Lifecycle.Read)
  remoteDisasterRecoveryType: DisasterRecoveryType;

  @doc("If true, 7 days worth of backups are replicated across regions for Cross-Region ADB or Backup-Based DR between Primary and Standby. If false, the backups taken on the Primary are not replicated to the Standby database.")
  @visibility(Lifecycle.Create, Lifecycle.Read)
  isReplicateAutomaticBackups?: boolean;
}

@added(Versions.v20240801_preview)
@doc("Autonomous Database From Backup Timestamp resource model.")
model AutonomousDatabaseFromBackupTimestampProperties
  extends AutonomousDatabaseBaseProperties {
  @doc("Database type to be created.")
  dataBaseType: DataBaseType.CloneFromBackupTimestamp;

  @doc("The source of the database.")
  @visibility(Lifecycle.Create)
  source: SourceType.BackupFromTimestamp;

  @doc("The ID of the source Autonomous Database that you will clone to create a new Autonomous Database.")
  @visibility(Lifecycle.Create, Lifecycle.Read)
  sourceId: AutonomousDatabaseId;

  @doc("The Autonomous Database clone type.")
  @visibility(Lifecycle.Create)
  cloneType: CloneType;

  @doc("The timestamp specified for the point-in-time clone of the source Autonomous Database. The timestamp must be in the past.")
  @visibility(Lifecycle.Create)
  timestamp?: utcDateTime;

  @doc("Clone from latest available backup timestamp.")
  @visibility(Lifecycle.Create)
  useLatestAvailableBackupTimeStamp?: boolean;
}

@discriminator("dataBaseType")
@doc("Autonomous Database base resource model.")
model AutonomousDatabaseBaseProperties {
  @doc("Admin password.")
  @visibility(Lifecycle.Create, Lifecycle.Update)
  @minLength(12)
  @maxLength(30)
  adminPassword?: Password;

  @doc("Database type to be created.")
  @visibility(Lifecycle.Create)
  dataBaseType: DataBaseType;

  @doc("The maintenance schedule type of the Autonomous Database Serverless.")
  @visibility(Lifecycle.Create, Lifecycle.Read, Lifecycle.Update)
  autonomousMaintenanceScheduleType?: AutonomousMaintenanceScheduleType;

  @doc("The character set for the autonomous database.")
  @visibility(Lifecycle.Create, Lifecycle.Read)
  @minLength(1)
  @maxLength(255)
  characterSet?: string;

  @doc("The compute amount (CPUs) available to the database.")
  @visibility(Lifecycle.Create, Lifecycle.Read, Lifecycle.Update)
  @minValue(0.1)
  @maxValue(512)
  computeCount?: float32;

  @doc("The compute model of the Autonomous Database.")
  @visibility(Lifecycle.Create, Lifecycle.Read)
  computeModel?: ComputeModel;

  @doc("The number of CPU cores to be made available to the database.")
  @visibility(Lifecycle.Create, Lifecycle.Read, Lifecycle.Update)
  @minValue(1)
  @maxValue(128)
  cpuCoreCount?: int32;

  @doc("Customer Contacts.")
  @visibility(Lifecycle.Create, Lifecycle.Read, Lifecycle.Update)
  @OpenAPI.extension("x-ms-identifiers", #[])
  customerContacts?: CustomerContact[];

  @doc("The quantity of data in the database, in terabytes.")
  @visibility(Lifecycle.Create, Lifecycle.Read, Lifecycle.Update)
  @minValue(1)
  @maxValue(384)
  dataStorageSizeInTbs?: int32;

  @doc("The size, in gigabytes, of the data volume that will be created and attached to the database.")
  @visibility(Lifecycle.Create, Lifecycle.Read, Lifecycle.Update)
  @minValue(20)
  @maxValue(393216)
  dataStorageSizeInGbs?: int32;

  @doc("A valid Oracle Database version for Autonomous Database.")
  @visibility(Lifecycle.Create, Lifecycle.Read)
  @minLength(1)
  @maxLength(255)
  dbVersion?: string;

  @doc("The Autonomous Database workload type")
  @visibility(Lifecycle.Create, Lifecycle.Read)
  dbWorkload?: WorkloadType;

  @doc("The user-friendly name for the Autonomous Database.")
  @visibility(Lifecycle.Create, Lifecycle.Read, Lifecycle.Update)
  @minLength(1)
  @maxLength(255)
  displayName?: string;

  @doc("Indicates if auto scaling is enabled for the Autonomous Database CPU core count.")
  @visibility(Lifecycle.Create, Lifecycle.Read, Lifecycle.Update)
  isAutoScalingEnabled?: boolean;

  @doc("Indicates if auto scaling is enabled for the Autonomous Database storage.")
  @visibility(Lifecycle.Create, Lifecycle.Read, Lifecycle.Update)
  isAutoScalingForStorageEnabled?: boolean;

  @doc("The list of Azure resource IDs of standby databases located in Autonomous Data Guard remote regions that are associated with the source database. Note that for Autonomous Database Serverless instances, standby databases located in the same region as the source primary database do not have Azure IDs.")
  @visibility(Lifecycle.Read)
  peerDbIds?: string[];

  @doc("The Azure resource ID of the Disaster Recovery peer database, which is located in a different region from the current peer database.")
  @visibility(Lifecycle.Update)
  @minLength(1)
  @maxLength(255)
  peerDbId?: string;

  @doc("Indicates whether the Autonomous Database has local or called in-region Data Guard enabled.")
  @visibility(Lifecycle.Create, Lifecycle.Read, Lifecycle.Update)
  isLocalDataGuardEnabled?: boolean;

  @doc("Indicates whether the Autonomous Database has Cross Region Data Guard enabled.")
  @visibility(Lifecycle.Read)
  isRemoteDataGuardEnabled?: boolean;

  @doc("Indicates the local disaster recovery (DR) type of the Autonomous Database Serverless instance.Autonomous Data Guard (ADG) DR type provides business critical DR with a faster recovery time objective (RTO) during failover or switchover.Backup-based DR type provides lower cost DR with a slower RTO during failover or switchover.")
  @visibility(Lifecycle.Read)
  localDisasterRecoveryType?: DisasterRecoveryType;

  @added(Versions.v20241001_preview)
  @doc("The date and time the Disaster Recovery role was switched for the standby Autonomous Database.")
  @visibility(Lifecycle.Read)
  timeDisasterRecoveryRoleChanged?: utcDateTime;

  @added(Versions.v20241001_preview)
  @doc("Indicates remote disaster recovery configuration")
  @visibility(Lifecycle.Read)
  remoteDisasterRecoveryConfiguration?: DisasterRecoveryConfigurationDetails;

  @doc("Local Autonomous Disaster Recovery standby database details.")
  @visibility(Lifecycle.Read)
  localStandbyDb?: AutonomousDatabaseStandbySummary;

  @doc("Indicates the number of seconds of data loss for a Data Guard failover.")
  @visibility(Lifecycle.Read)
  failedDataRecoveryInSeconds?: int32;

  @doc("Specifies if the Autonomous Database requires mTLS connections.")
  @visibility(Lifecycle.Create, Lifecycle.Read, Lifecycle.Update)
  isMtlsConnectionRequired?: boolean;

  @doc("Specifies if the Autonomous Database preview version is being provisioned.")
  @visibility(Lifecycle.Create)
  isPreviewVersionWithServiceTermsAccepted?: boolean;

  @doc("The Oracle license model that applies to the Oracle Autonomous Database. The default is LICENSE_INCLUDED.")
  @visibility(Lifecycle.Create, Lifecycle.Read, Lifecycle.Update)
  licenseModel?: LicenseModel;

  @doc("The character set for the Autonomous Database.")
  @visibility(Lifecycle.Create, Lifecycle.Read)
  @minLength(1)
  @maxLength(255)
  ncharacterSet?: string;

  @doc("Additional information about the current lifecycle state.")
  @visibility(Lifecycle.Read)
  lifecycleDetails?: string;

  @doc("Azure resource provisioning state.")
  @visibility(Lifecycle.Read)
  provisioningState?: AzureResourceProvisioningState;

  @doc("Views lifecycleState")
  @visibility(Lifecycle.Read)
  lifecycleState?: AutonomousDatabaseLifecycleState;

  @doc("The list of scheduled operations.")
  @visibility(Lifecycle.Create, Lifecycle.Read, Lifecycle.Update)
  scheduledOperations?: ScheduledOperationsType;

  @doc("The private endpoint Ip address for the resource.")
  @visibility(Lifecycle.Create, Lifecycle.Read)
  privateEndpointIp?: string;

  @doc("The resource's private endpoint label.")
  @visibility(Lifecycle.Create, Lifecycle.Read)
  privateEndpointLabel?: string;

  @doc("HTTPS link to OCI resources exposed to Azure Customer via Azure Interface.")
  @visibility(Lifecycle.Read)
  ociUrl?: string;

  @doc("Client subnet")
  @visibility(Lifecycle.Create, Lifecycle.Read)
  subnetId?: SubnetId;

  @doc("VNET for network connectivity")
  @visibility(Lifecycle.Create, Lifecycle.Read)
  vnetId?: VnetId;

  @doc("The date and time that the database was created.")
  @visibility(Lifecycle.Read)
  timeCreated?: utcDateTime;

  @doc("The date and time when maintenance will begin.")
  @visibility(Lifecycle.Read)
  timeMaintenanceBegin?: utcDateTime;

  @doc("The date and time when maintenance will end.")
  @visibility(Lifecycle.Read)
  timeMaintenanceEnd?: utcDateTime;

  @doc("The current amount of storage in use for user and system data, in terabytes (TB).")
  @visibility(Lifecycle.Read)
  actualUsedDataStorageSizeInTbs?: float64;

  @doc("The amount of storage currently allocated for the database tables and billed for, rounded up.")
  @visibility(Lifecycle.Read)
  allocatedStorageSizeInTbs?: float64;

  @doc("Information about Oracle APEX Application Development.")
  @visibility(Lifecycle.Read)
  apexDetails?: ApexDetailsType;

  @doc("List of Oracle Database versions available for a database upgrade. If there are no version upgrades available, this list is empty.")
  @visibility(Lifecycle.Read)
  availableUpgradeVersions?: string[];

  @doc("The connection string used to connect to the Autonomous Database.")
  @visibility(Lifecycle.Read)
  connectionStrings?: ConnectionStringType;

  @doc("The URLs for accessing Oracle Application Express (APEX) and SQL Developer Web with a browser from a Compute instance within your VCN or that has a direct connection to your VCN. ")
  @visibility(Lifecycle.Read)
  connectionUrls?: ConnectionUrlType;

  @doc("Status of the Data Safe registration for this Autonomous Database.")
  @visibility(Lifecycle.Read)
  dataSafeStatus?: DataSafeStatusType;

  @doc("The Oracle Database Edition that applies to the Autonomous databases.")
  @visibility(Lifecycle.Create, Lifecycle.Read, Lifecycle.Update)
  databaseEdition?: DatabaseEditionType;

  @doc("Autonomous Database ID")
  @visibility(Lifecycle.Create, Lifecycle.Read)
  autonomousDatabaseId?: AutonomousDatabaseId;

  @doc("The area assigned to In-Memory tables in Autonomous Database.")
  @visibility(Lifecycle.Read)
  inMemoryAreaInGbs?: int32;

  @doc("The date and time when the next long-term backup would be created.")
  @visibility(Lifecycle.Read)
  nextLongTermBackupTimeStamp?: utcDateTime;

  @doc("Details for the long-term backup schedule.")
  @visibility(Lifecycle.Read, Lifecycle.Update)
  longTermBackupSchedule?: LongTermBackUpScheduleDetails;

  @doc("Indicates if the Autonomous Database version is a preview version.")
  @visibility(Lifecycle.Read)
  isPreview?: boolean;

  @doc("Parameter that allows users to select an acceptable maximum data loss limit in seconds, up to which Automatic Failover will be triggered when necessary for a Local Autonomous Data Guard")
  @visibility(Lifecycle.Update, Lifecycle.Read)
  @minValue(0)
  @maxValue(3600)
  localAdgAutoFailoverMaxDataLossLimit?: int32;

  @doc("The amount of memory (in GBs) enabled per ECPU or OCPU.")
  @visibility(Lifecycle.Read)
  memoryPerOracleComputeUnitInGbs?: int32;

  @doc("Indicates the Autonomous Database mode.")
  @visibility(Lifecycle.Update, Lifecycle.Read)
  openMode?: OpenModeType;

  @doc("Status of Operations Insights for this Autonomous Database.")
  @visibility(Lifecycle.Read)
  operationsInsightsStatus?: OperationsInsightsStatusType;

  @doc("The Autonomous Database permission level.")
  @visibility(Lifecycle.Read, Lifecycle.Update)
  permissionLevel?: PermissionLevelType;

  @doc("The private endpoint for the resource.")
  @visibility(Lifecycle.Read)
  privateEndpoint?: string;

  @doc("An array of CPU values that an Autonomous Database can be scaled to.")
  @visibility(Lifecycle.Read)
  provisionableCpus?: int32[];

  @doc("The Data Guard role of the Autonomous Container Database or Autonomous Database, if Autonomous Data Guard is enabled.")
  @visibility(Lifecycle.Read, Lifecycle.Update)
  role?: RoleType;

  @doc("The URL of the Service Console for the Autonomous Database.")
  @visibility(Lifecycle.Read)
  @minLength(10)
  @maxLength(255)
  serviceConsoleUrl?: string;

  @doc("The SQL Web Developer URL for the Oracle Autonomous Database.")
  @visibility(Lifecycle.Read)
  @minLength(10)
  @maxLength(2048)
  sqlWebDeveloperUrl?: string;

  @doc("The list of regions that support the creation of an Autonomous Database clone or an Autonomous Data Guard standby database.")
  @visibility(Lifecycle.Read)
  @maxItems(50)
  supportedRegionsToCloneTo?: string[];

  @doc("The date and time the Autonomous Data Guard role was switched for the Autonomous Database.")
  @visibility(Lifecycle.Read)
  timeDataGuardRoleChanged?: string;

  @doc("The date and time the Always Free database will be automatically deleted because of inactivity.")
  @visibility(Lifecycle.Read)
  timeDeletionOfFreeAutonomousDatabase?: string;

  @doc("The date and time that Autonomous Data Guard was enabled for an Autonomous Database where the standby was provisioned in the same region as the primary database.")
  @visibility(Lifecycle.Read)
  timeLocalDataGuardEnabled?: string;

  @doc("The timestamp of the last failover operation.")
  @visibility(Lifecycle.Read)
  timeOfLastFailover?: string;

  @doc("The date and time when last refresh happened.")
  @visibility(Lifecycle.Read)
  timeOfLastRefresh?: string;

  @doc("The refresh point timestamp (UTC).")
  @visibility(Lifecycle.Read)
  timeOfLastRefreshPoint?: string;

  @doc("The timestamp of the last switchover operation for the Autonomous Database.")
  @visibility(Lifecycle.Read)
  timeOfLastSwitchover?: string;

  @doc("The date and time the Always Free database will be stopped because of inactivity.")
  @visibility(Lifecycle.Read)
  timeReclamationOfFreeAutonomousDatabase?: string;

  @doc("The storage space consumed by Autonomous Database in GBs.")
  @visibility(Lifecycle.Read)
  usedDataStorageSizeInGbs?: int32;

  @doc("The amount of storage that has been used, in terabytes.")
  @visibility(Lifecycle.Read)
  usedDataStorageSizeInTbs?: int32;

  @doc("Database ocid")
  @visibility(Lifecycle.Read)
  ocid?: Ocid;

  @doc("Retention period, in days, for long-term backups")
  @visibility(Lifecycle.Create, Lifecycle.Read, Lifecycle.Update)
  backupRetentionPeriodInDays?: int32;

  @doc("The client IP access control list (ACL). This is an array of CIDR notations and/or IP addresses. Values should be separate strings, separated by commas. Example: ['1.1.1.1','1.1.1.0/24','1.1.2.25']")
  @visibility(Lifecycle.Create, Lifecycle.Read, Lifecycle.Update)
  whitelistedIps?: aclString[];
}

@doc("Autonomous Database Generate Wallet resource model.")
model GenerateAutonomousDatabaseWalletDetails {
  @doc("The type of wallet to generate.")
  generateType?: GenerateType;

  @doc("True when requesting regional connection strings in PDB connect info, applicable to cross-region DG only.")
  isRegional?: boolean;

  @doc("The password to encrypt the keys inside the wallet")
  @minLength(8)
  password: Password;
}

@doc("Autonomous Database Wallet File resource model.")
model AutonomousDatabaseWalletFile {
  @doc("The base64 encoded wallet files")
  walletFiles: string;
}

@added(Versions.v20241001_preview)
@doc("Configurations of a Disaster Recovery Details")
model DisasterRecoveryConfigurationDetails {
  @doc("Indicates the disaster recovery (DR) type of the Autonomous Database Serverless instance. Autonomous Data Guard (ADG) DR type provides business critical DR with a faster recovery time objective (RTO) during failover or switchover. Backup-based DR type provides lower cost DR with a slower RTO during failover or switchover.")
  disasterRecoveryType?: DisasterRecoveryType;

  @doc("Time and date stored as an RFC 3339 formatted timestamp string. For example, 2022-01-01T12:00:00.000Z would set a limit for the snapshot standby to be converted back to a cross-region standby database.")
  timeSnapshotStandbyEnabledTill?: utcDateTime;

  @doc("Indicates if user wants to convert to a snapshot standby. For example, true would set a standby database to snapshot standby database. False would set a snapshot standby database back to regular standby database.")
  isSnapshotStandby?: boolean;

  @doc("If true, 7 days worth of backups are replicated across regions for Cross-Region ADB or Backup-Based DR between Primary and Standby. If false, the backups taken on the Primary are not replicated to the Standby database.")
  isReplicateAutomaticBackups?: boolean;
}

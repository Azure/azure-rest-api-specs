import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.Core;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Azure.ResourceManager.Sql;

interface Operations extends Azure.ResourceManager.Operations {}

enum GeoBackupPolicyName {
  Default,
}

enum UnitType {
  count,
  bytes,
  seconds,
  percent,
  countPerSecond,
  bytesPerSecond,
}

enum PrimaryAggregationType {
  None,
  Average,
  Count,
  Minimum,
  Maximum,
  Total,
}

enum UnitDefinitionType {
  Count,
  Bytes,
  Seconds,
  Percent,
  CountPerSecond,
  BytesPerSecond,
}

enum RecommendedActionCurrentState {
  Active,
  Pending,
  Executing,
  Verifying,
  PendingRevert,
  RevertCancelled,
  Reverting,
  Reverted,
  Ignored,
  Expired,
  Monitoring,
  Resolved,
  Success,
  Error,
}

enum ColumnDataType {
  image,
  text,
  uniqueidentifier,
  date,
  time,
  datetime2,
  datetimeoffset,
  tinyint,
  smallint,
  int,
  smalldatetime,
  real,
  money,
  datetime,
  float,
  sql_variant,
  ntext,
  bit,
  decimal,
  numeric,
  smallmoney,
  bigint,
  hierarchyid,
  geometry,
  geography,
  varbinary,
  varchar,
  binary,
  char,
  timestamp,
  nvarchar,
  nchar,
  xml,
  sysname,
}

enum TableTemporalType {
  NonTemporalTable,
  HistoryTable,
  SystemVersionedTemporalTable,
}

enum SecurityAlertPolicyName {
  Default,
}

enum CreatedByType {
  User,
  Application,
  ManagedIdentity,
  Key,
}

enum VulnerabilityAssessmentName {
  default,
}

enum VulnerabilityAssessmentScanTriggerType {
  OnDemand,
  Recurring,
}

enum VulnerabilityAssessmentScanState {
  Passed,
  Failed,
  FailedToRun,
  InProgress,
}

enum DataWarehouseUserActivityName {
  current,
}

enum ServerKeyType {
  ServiceManaged,
  AzureKeyVault,
}

enum EncryptionProtectorName {
  current,
}

enum InstancePoolLicenseType {
  LicenseIncluded,
  BasePrice,
}

enum JobAgentState {
  Creating,
  Ready,
  Updating,
  Deleting,
  Disabled,
}

enum JobExecutionLifecycle {
  Created,
  InProgress,
  WaitingForChildJobExecutions,
  WaitingForRetry,
  Succeeded,
  SucceededWithSkipped,
  Failed,
  TimedOut,
  Canceled,
  Skipped,
}

enum ProvisioningState {
  Created,
  InProgress,
  Succeeded,
  Failed,
  Canceled,
}

enum JobTargetType {
  TargetGroup,
  SqlDatabase,
  SqlElasticPool,
  SqlShardMap,
  SqlServer,
}

enum JobStepActionType {
  TSql,
}

enum JobStepActionSource {
  Inline,
}

enum JobStepOutputType {
  SqlDatabase,
}

enum CapabilityGroup {
  supportedEditions,
  supportedElasticPoolEditions,
  supportedManagedInstanceVersions,
  supportedInstancePoolEditions,
  supportedManagedInstanceEditions,
}

enum MaxSizeUnit {
  Megabytes,
  Gigabytes,
  Terabytes,
  Petabytes,
}

enum LogSizeUnit {
  Megabytes,
  Gigabytes,
  Terabytes,
  Petabytes,
  Percent,
}

enum PerformanceLevelUnit {
  DTU,
  VCores,
}

enum PauseDelayTimeUnit {
  Minutes,
}

enum StorageCapabilityStorageAccountType {
  GRS,
  LRS,
  ZRS,
}

enum LongTermRetentionPolicyName {
  default,
}

enum DayOfWeek {
  Sunday,
  Monday,
  Tuesday,
  Wednesday,
  Thursday,
  Friday,
  Saturday,
}

enum ManagedShortTermRetentionPolicyName {
  default,
}

enum QueryTimeGrainType {
  PT1H,
  P1D,
}

enum QueryMetricUnitType {
  percentage,
  KB,
  microseconds,
  count,
}

enum TransparentDataEncryptionName {
  current,
}

enum ManagedInstanceAdministratorType {
  ActiveDirectory,
}

enum AdministratorName {
  ActiveDirectory,
}

enum AuthenticationName {
  Default,
}

enum ManagedInstanceLongTermRetentionPolicyName {
  default,
}

enum ManagementOperationState {
  Pending,
  InProgress,
  Succeeded,
  Failed,
  CancelInProgress,
  Cancelled,
}

enum UpsertManagedServerOperationStepStatus {
  NotStarted,
  InProgress,
  SlowedDown,
  Completed,
  Failed,
  Canceled,
}

enum OperationOrigin {
  user,
  system,
}

enum PrivateLinkServiceConnectionStateStatus {
  Approved,
  Pending,
  Rejected,
  Disconnected,
}

enum PrivateLinkServiceConnectionStateActionsRequire {
  None,
}

enum PrivateEndpointProvisioningState {
  Approving,
  Ready,
  Dropping,
  Failed,
  Rejecting,
}

enum AdministratorType {
  ActiveDirectory,
}

enum ServerTrustGroupPropertiesTrustScopesItem {
  GlobalTransactions,
  ServiceBroker,
}

enum SqlAgentConfigurationPropertiesState {
  Enabled,
  Disabled,
}

enum SyncAgentState {
  Online,
  Offline,
  NeverConnected,
}

enum SyncMemberDbType {
  AzureSqlDatabase,
  SqlServerDatabase,
}

enum SyncGroupsType {
  All,
  Error,
  Warning,
  Success,
}

enum SyncGroupLogType {
  All,
  Error,
  Warning,
  Success,
}

enum SyncConflictResolutionPolicy {
  HubWin,
  MemberWin,
}

enum SyncGroupState {
  NotReady,
  Error,
  Warning,
  Progressing,
  Good,
}

enum SyncDirection {
  Bidirectional,
  OneWayMemberToHub,
  OneWayHubToMember,
}

enum SyncMemberState {
  SyncInProgress,
  SyncSucceeded,
  SyncFailed,
  DisabledTombstoneCleanup,
  DisabledBackupRestore,
  SyncSucceededWithWarnings,
  SyncCancelling,
  SyncCancelled,
  UnProvisioned,
  Provisioning,
  Provisioned,
  ProvisionFailed,
  DeProvisioning,
  DeProvisioned,
  DeProvisionFailed,
  Reprovisioning,
  ReprovisionFailed,
  UnReprovisioned,
}

enum VirtualNetworkRuleState {
  Initializing,
  InProgress,
  Ready,
  Failed,
  Deleting,
  Unknown,
}

enum ShortTermRetentionPolicyName {
  default,
}

enum DiffBackupIntervalInHours {
  `12`: 12,
  `24`: 24,
}

enum OperationMode {
  PolybaseImport,
}

enum StorageKeyType {
  SharedAccessKey,
  StorageAccessKey,
}

enum LedgerDigestUploadsName {
  current,
}

enum BackupStorageRedundancy {
  Geo,
  Local,
  Zone,
  GeoZone,
}

enum DatabaseState {
  All,
  Live,
  Deleted,
}

enum ConnectionPolicyName {
  default,
}

enum ServerConnectionType {
  Default,
  Redirect,
  Proxy,
}

enum ReplicationMode {
  Async,
  Sync,
}

enum BlobAuditingPolicyName {
  default,
}

enum AdvancedThreatProtectionName {
  Default,
}

enum ReplicationState {
  PENDING,
  SEEDING,
  CATCH_UP,
  SUSPENDED,
}

enum ReplicationLinkType {
  GEO,
  NAMED,
  STANDBY,
}

enum DtcName {
  current,
}

enum DNSRefreshOperationStatus {
  Succeeded,
  Failed,
  InProgress,
}

enum SecondaryInstanceType {
  Geo,
  Standby,
}

enum ReadWriteEndpointFailoverPolicy {
  Manual,
  Automatic,
}

enum ReadOnlyEndpointFailoverPolicy {
  Disabled,
  Enabled,
}

enum InstanceFailoverGroupReplicationRole {
  Primary,
  Secondary,
}

enum RestoreDetailsName {
  Default,
}

enum DatabaseIdentityType {
  None,
  UserAssigned,
}

enum CreateMode {
  Default,
  Copy,
  Secondary,
  PointInTimeRestore,
  Restore,
  Recovery,
  RestoreExternalBackup,
  RestoreExternalBackupSecondary,
  RestoreLongTermRetentionBackup,
  OnlineSecondary,
}

enum SampleName {
  AdventureWorksLT,
  WideWorldImportersStd,
  WideWorldImportersFull,
}

enum DatabaseStatus {
  Online,
  Restoring,
  RecoveryPending,
  Recovering,
  Suspect,
  Offline,
  Standby,
  Shutdown,
  EmergencyMode,
  AutoClosed,
  Copying,
  Creating,
  Inaccessible,
  OfflineSecondary,
  Pausing,
  Paused,
  Resuming,
  Scaling,
  OfflineChangingDwPerformanceTiers,
  OnlineChangingDwPerformanceTiers,
  Disabled,
  Stopping,
  Stopped,
  Starting,
}

enum CatalogCollationType {
  DATABASE_DEFAULT,
  SQL_Latin1_General_CP1_CI_AS,
}

enum DatabaseLicenseType {
  LicenseIncluded,
  BasePrice,
}

enum DatabaseReadScale {
  Enabled,
  Disabled,
}

enum SecondaryType {
  Geo,
  Named,
  Standby,
}

enum DatabaseKeyType {
  AzureKeyVault,
}

enum AlwaysEncryptedEnclaveType {
  Default,
  VBS,
}

enum FreeLimitExhaustionBehavior {
  AutoPause,
  BillOverUsage,
}

enum AvailabilityZoneType {
  NoPreference,
  `1`,
  `2`,
  `3`,
}

enum ReplicaType {
  Primary,
  ReadableSecondary,
}

enum ElasticPoolState {
  Creating,
  Ready,
  Disabled,
}

enum ElasticPoolLicenseType {
  LicenseIncluded,
  BasePrice,
}

enum ManagedDatabaseStatus {
  Online,
  Offline,
  Shutdown,
  Creating,
  Inaccessible,
  Restoring,
  Updating,
  Stopping,
  Stopped,
  Starting,
  DbMoving,
  DbCopying,
}

enum ManagedDatabaseCreateMode {
  Default,
  RestoreExternalBackup,
  PointInTimeRestore,
  Recovery,
  RestoreLongTermRetentionBackup,
}

enum MoveOperationMode {
  Move,
  Copy,
}

enum IdentityType {
  None,
  SystemAssigned,
  UserAssigned,
  `SystemAssigned,UserAssigned`,
}

enum ManagedInstancePropertiesProvisioningState {
  Creating,
  Deleting,
  Updating,
  Unknown,
  Succeeded,
  Failed,
  Accepted,
  Created,
  Deleted,
  Unrecognized,
  Running,
  Canceled,
  NotSpecified,
  Registering,
  TimedOut,
}

enum ManagedServerCreateMode {
  Default,
  PointInTimeRestore,
}

enum ManagedInstanceLicenseType {
  LicenseIncluded,
  BasePrice,
}

enum ManagedInstanceProxyOverride {
  Proxy,
  Redirect,
  Default,
}

enum PrincipalType {
  User,
  Group,
  Application,
}

enum ServicePrincipalType {
  None,
  SystemAssigned,
}

enum AggregationFunctionType {
  avg,
  min,
  max,
  stdev,
  sum,
}

enum MetricType {
  cpu,
  io,
  logIo,
  duration,
  dtu,
}

enum ManagedLedgerDigestUploadsState {
  Enabled,
  Disabled,
}

enum ManagedLedgerDigestUploadsName {
  current,
}

enum ServerConfigurationOptionName {
  allowPolybaseExport,
}

enum StartStopScheduleName {
  default,
}

enum BaselineName {
  default,
}

enum RuleStatus {
  NonFinding,
  Finding,
  InternalError,
}

enum RuleSeverity {
  High,
  Medium,
  Low,
  Informational,
  Obsolete,
}

enum RuleType {
  Binary,
  BaselineExpected,
  PositiveList,
  NegativeList,
}

enum ServerPublicNetworkAccessFlag {
  Enabled,
  Disabled,
  SecuredByPerimeter,
}

enum ServerWorkspaceFeature {
  Connected,
  Disconnected,
}

enum ServerNetworkAccessFlag {
  Enabled,
  Disabled,
  SecuredByPerimeter,
}

enum ExternalGovernanceStatus {
  Enabled,
  Disabled,
}

enum FailoverGroupReplicationRole {
  Primary,
  Secondary,
}

enum ServiceObjectiveName {
  System,
  System0,
  System1,
  System2,
  System3,
  System4,
  System2L,
  System3L,
  System4L,
  Free,
  Basic,
  S0,
  S1,
  S2,
  S3,
  S4,
  S6,
  S7,
  S9,
  S12,
  P1,
  P2,
  P3,
  P4,
  P6,
  P11,
  P15,
  PRS1,
  PRS2,
  PRS4,
  PRS6,
  DW100,
  DW200,
  DW300,
  DW400,
  DW500,
  DW600,
  DW1000,
  DW1200,
  DW1000c,
  DW1500,
  DW1500c,
  DW2000,
  DW2000c,
  DW3000,
  DW2500c,
  DW3000c,
  DW6000,
  DW5000c,
  DW6000c,
  DW7500c,
  DW10000c,
  DW15000c,
  DW30000c,
  DS100,
  DS200,
  DS300,
  DS400,
  DS500,
  DS600,
  DS1000,
  DS1200,
  DS1500,
  DS2000,
  ElasticPool,
}
@Azure.Core.fixed
enum DataMaskingState {
  Disabled,
  Enabled,
}
@Azure.Core.fixed
enum DataMaskingRuleState {
  Disabled,
  Enabled,
}
@Azure.Core.fixed
enum DataMaskingFunction {
  Default,
  CCN,
  Email,
  Number,
  SSN,
  Text,
}
@Azure.Core.fixed
enum GeoBackupPolicyState {
  Disabled,
  Enabled,
}
@Azure.Core.fixed
enum AdvisorStatus {
  GA,
  PublicPreview,
  LimitedPublicPreview,
  PrivatePreview,
}
@Azure.Core.fixed
enum AutoExecuteStatus {
  Enabled,
  Disabled,
  Default,
}
@Azure.Core.fixed
enum AutoExecuteStatusInheritedFrom {
  Default,
  Subscription,
  Server,
  ElasticPool,
  Database,
}
@Azure.Core.fixed
enum RecommendedActionInitiatedBy {
  User,
  System,
}
@Azure.Core.fixed
enum ImplementationMethod {
  TSql,
  AzurePowerShell,
}
@Azure.Core.fixed
enum IsRetryable {
  Yes,
  No,
}
@Azure.Core.fixed
enum AutomaticTuningMode {
  Inherit,
  Custom,
  Auto,
  Unspecified,
}
@Azure.Core.fixed
enum AutomaticTuningOptionModeDesired {
  Off,
  On,
  Default,
}
@Azure.Core.fixed
enum AutomaticTuningOptionModeActual {
  Off,
  On,
}
@Azure.Core.fixed
enum AutomaticTuningDisabledReason {
  Default,
  Disabled,
  AutoConfigured,
  InheritedFromServer,
  QueryStoreOff,
  QueryStoreReadOnly,
  NotSupported,
}
@Azure.Core.fixed
enum SecurityAlertsPolicyState {
  Enabled,
  Disabled,
}
@Azure.Core.fixed
enum VulnerabilityAssessmentPolicyBaselineName {
  master,
  default,
}
@Azure.Core.fixed
enum JobScheduleType {
  Once,
  Recurring,
}
@Azure.Core.fixed
enum JobTargetGroupMembershipType {
  Include,
  Exclude,
}
@Azure.Core.fixed
enum CapabilityStatus {
  Visible,
  Available,
  Default,
  Disabled,
}
@Azure.Core.fixed
enum SecurityAlertPolicyState {
  New,
  Enabled,
  Disabled,
}
@Azure.Core.fixed
enum SecurityEventType {
  Undefined,
  SqlInjectionVulnerability,
  SqlInjectionExploit,
}
@Azure.Core.fixed
enum TransparentDataEncryptionState {
  Enabled,
  Disabled,
}
@Azure.Core.fixed
enum RestorePointType {
  CONTINUOUS,
  DISCRETE,
}
@Azure.Core.fixed
enum AutomaticTuningServerMode {
  Custom,
  Auto,
  Unspecified,
}
@Azure.Core.fixed
enum AutomaticTuningServerReason {
  Default,
  Disabled,
  AutoConfigured,
}
@Azure.Core.fixed
enum BlobAuditingPolicyState {
  Enabled,
  Disabled,
}
@Azure.Core.fixed
enum LedgerDigestUploadsState {
  Enabled,
  Disabled,
}
@Azure.Core.fixed
enum SensitivityLabelSource {
  current,
  recommended,
}
@Azure.Core.fixed
enum SensitivityLabelRank {
  None,
  Low,
  Medium,
  High,
  Critical,
}
@Azure.Core.fixed
enum SensitivityLabelUpdateKind {
  set,
  remove,
}
@Azure.Core.fixed
enum RecommendedSensitivityLabelUpdateKind {
  enable,
  disable,
}
@Azure.Core.fixed
enum AdvancedThreatProtectionState {
  New,
  Enabled,
  Disabled,
}
@Azure.Core.fixed
enum ReplicationRole {
  Primary,
  Secondary,
  NonReadableSecondary,
  Source,
  Copy,
}
@Azure.Core.fixed
enum SqlVulnerabilityAssessmentState {
  Enabled,
  Disabled,
}
@Azure.Core.fixed
enum CheckNameAvailabilityReason {
  Invalid,
  AlreadyExists,
}

@doc("The properties of a database data masking policy.")
model DataMaskingPolicyProperties {
  @doc("The state of the data masking policy.")
  dataMaskingState: DataMaskingState;

  @doc("The list of the exempt principals. Specifies the semicolon-separated list of database users for which the data masking policy does not apply. The specified users receive data results without masking for all of the database queries.")
  exemptPrincipals?: string;

  @doc("The list of the application principals. This is a legacy parameter and is no longer used.")
  @visibility("read")
  applicationPrincipals?: string;

  @doc("The masking level. This is a legacy parameter and is no longer used.")
  @visibility("read")
  maskingLevel?: string;
}

@doc("ARM resource.")
model Resource {
  @doc("Resource ID.")
  @visibility("read")
  id?: string;

  @doc("Resource name.")
  @visibility("read")
  name?: string;

  @doc("Resource type.")
  @visibility("read")
  type?: string;
}

@doc("Represents a database data masking rule.")
model DataMaskingRule extends ProxyResource {
  @doc("The properties of the resource.")
  properties?: DataMaskingRuleProperties;

  @doc("The location of the data masking rule.")
  @visibility("read")
  location?: string;

  @doc("The kind of Data Masking Rule. Metadata, used for Azure portal.")
  @visibility("read")
  kind?: string;
}

@doc("The properties of a database data masking rule.")
model DataMaskingRuleProperties {
  @doc("The alias name. This is a legacy parameter and is no longer used.")
  aliasName?: string;

  @doc("The rule state. Used to delete a rule. To delete an existing rule, specify the schemaName, tableName, columnName, maskingFunction, and specify ruleState as disabled. However, if the rule doesn't already exist, the rule will be created with ruleState set to enabled, regardless of the provided value of ruleState.")
  ruleState?: DataMaskingRuleState;

  @doc("The schema name on which the data masking rule is applied.")
  schemaName: string;

  @doc("The table name on which the data masking rule is applied.")
  tableName: string;

  @doc("The column name on which the data masking rule is applied.")
  columnName: string;

  @doc("The masking function that is used for the data masking rule.")
  maskingFunction: DataMaskingFunction;

  @doc("The numberFrom property of the masking rule. Required if maskingFunction is set to Number, otherwise this parameter will be ignored.")
  numberFrom?: string;

  @doc("The numberTo property of the data masking rule. Required if maskingFunction is set to Number, otherwise this parameter will be ignored.")
  numberTo?: string;

  @doc("If maskingFunction is set to Text, the number of characters to show unmasked in the beginning of the string. Otherwise, this parameter will be ignored.")
  prefixSize?: string;

  @doc("If maskingFunction is set to Text, the number of characters to show unmasked at the end of the string. Otherwise, this parameter will be ignored.")
  suffixSize?: string;

  @doc("If maskingFunction is set to Text, the character to use for masking the unexposed part of the string. Otherwise, this parameter will be ignored.")
  replacementString?: string;
}

@doc("The response to a list data masking rules request.")
@pagedResult
model DataMaskingRuleListResult {
  @doc("The list of database data masking rules.")
  @items
  value?: DataMaskingRule[];
}

@doc("The properties of the geo backup policy.")
model GeoBackupPolicyProperties {
  @doc("The state of the geo backup policy.")
  state: GeoBackupPolicyState;

  @doc("The storage type of the geo backup policy.")
  @visibility("read")
  storageType?: string;
}

@doc("The response to a list database metrics request.")
@pagedResult
model MetricListResult {
  @doc("The list of metrics for the database.")
  @items
  value: Metric[];
}

@doc("Database metrics.")
model Metric {
  @doc("The start time for the metric (ISO-8601 format).")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startTime?: utcDateTime;

  @doc("The end time for the metric (ISO-8601 format).")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  endTime?: utcDateTime;

  @doc("The time step to be used to summarize the metric values.")
  @visibility("read")
  timeGrain?: string;

  @doc("The unit of the metric.")
  @visibility("read")
  unit?: UnitType;

  @doc("The name information for the metric.")
  @visibility("read")
  name?: MetricName;

  @doc("The metric values for the specified time window and timestep.")
  @visibility("read")
  metricValues?: MetricValue[];
}

@doc("A database metric name.")
model MetricName {
  @doc("The name of the database metric.")
  @visibility("read")
  value?: string;

  @doc("The friendly name of the database metric.")
  @visibility("read")
  localizedValue?: string;
}

@doc("Represents database metrics.")
model MetricValue {
  @doc("The number of values for the metric.")
  @visibility("read")
  count?: int32;

  @doc("The average value of the metric.")
  @visibility("read")
  average?: float32;

  @doc("The max value of the metric.")
  @visibility("read")
  maximum?: float32;

  @doc("The min value of the metric.")
  @visibility("read")
  minimum?: float32;

  @doc("The metric timestamp (ISO-8601 format).")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  timestamp?: utcDateTime;

  @doc("The total value of the metric.")
  @visibility("read")
  total?: float32;
}

@doc("The response to a list database metric definitions request.")
@pagedResult
model MetricDefinitionListResult {
  @doc("The list of metric definitions for the database.")
  @items
  value: MetricDefinition[];
}

@doc("A database metric definition.")
model MetricDefinition {
  @doc("The name information for the metric.")
  @visibility("read")
  name?: MetricName;

  @doc("The primary aggregation type defining how metric values are displayed.")
  @visibility("read")
  primaryAggregationType?: PrimaryAggregationType;

  @doc("The resource uri of the database.")
  @visibility("read")
  resourceUri?: string;

  @doc("The unit of the metric.")
  @visibility("read")
  unit?: UnitDefinitionType;

  @doc("The list of database metric availabilities for the metric.")
  @visibility("read")
  metricAvailabilities?: MetricAvailability[];
}

@doc("A metric availability value.")
model MetricAvailability {
  @doc("The length of retention for the database metric.")
  @visibility("read")
  retention?: string;

  @doc("The granularity of the database metric.")
  @visibility("read")
  timeGrain?: string;
}

@doc("The properties of a server communication link.")
model ServerCommunicationLinkProperties {
  @doc("The state.")
  @visibility("read")
  state?: string;

  @doc("The name of the partner server.")
  @visibility("read", "create")
  partnerServer: string;
}

@doc("Represents the properties of a database service objective.")
model ServiceObjectiveProperties {
  @doc("The name for the service objective.")
  @visibility("read")
  serviceObjectiveName?: string;

  @doc("Gets whether the service level objective is the default service objective.")
  @visibility("read")
  isDefault?: boolean;

  @doc("Gets whether the service level objective is a system service objective.")
  @visibility("read")
  isSystem?: boolean;

  @doc("The description for the service level objective.")
  @visibility("read")
  description?: string;

  @doc("Gets whether the service level objective is enabled.")
  @visibility("read")
  @projectedName("json", "enabled")
  IsEnabled?: boolean;
}

@doc("Represents the response to a list elastic pool activity request.")
@pagedResult
model ElasticPoolActivityListResult {
  @doc("The list of elastic pool activities.")
  @items
  value: ElasticPoolActivity[];
}

@doc("Represents the activity on an elastic pool.")
model ElasticPoolActivity extends ProxyResource {
  @doc("The geo-location where the resource lives")
  @visibility("read", "create")
  location?: string;

  @doc("The properties representing the resource.")
  properties?: ElasticPoolActivityProperties;
}

@doc("Represents the properties of an elastic pool.")
model ElasticPoolActivityProperties {
  @doc("The time the operation finished (ISO8601 format).")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  endTime?: utcDateTime;

  @doc("The error code if available.")
  @visibility("read")
  errorCode?: int32;

  @doc("The error message if available.")
  @visibility("read")
  errorMessage?: string;

  @doc("The error severity if available.")
  @visibility("read")
  errorSeverity?: int32;

  @doc("The operation name.")
  @visibility("read")
  operation?: string;

  @doc("The unique operation ID.")
  @visibility("read")
  operationId?: string;

  @doc("The percentage complete if available.")
  @visibility("read")
  percentComplete?: int32;

  @doc("The requested max DTU per database if available.")
  @visibility("read")
  requestedDatabaseDtuMax?: int32;

  @doc("The requested min DTU per database if available.")
  @visibility("read")
  requestedDatabaseDtuMin?: int32;

  @doc("The requested DTU for the pool if available.")
  @visibility("read")
  requestedDtu?: int32;

  @doc("The requested name for the elastic pool if available.")
  @visibility("read")
  requestedElasticPoolName?: string;

  @doc("The requested storage limit for the pool in GB if available.")
  @visibility("read")
  requestedStorageLimitInGB?: int32;

  @doc("The name of the elastic pool.")
  @visibility("read")
  elasticPoolName?: string;

  @doc("The name of the server the elastic pool is in.")
  @visibility("read")
  serverName?: string;

  @doc("The time the operation started (ISO8601 format).")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startTime?: utcDateTime;

  @doc("The current state of the operation.")
  @visibility("read")
  state?: string;

  @doc("The requested storage limit in MB.")
  @visibility("read")
  requestedStorageLimitInMB?: int32;

  @doc("The requested per database DTU guarantee.")
  @visibility("read")
  requestedDatabaseDtuGuarantee?: int32;

  @doc("The requested per database DTU cap.")
  @visibility("read")
  requestedDatabaseDtuCap?: int32;

  @doc("The requested DTU guarantee.")
  @visibility("read")
  requestedDtuGuarantee?: int32;
}

@doc("Represents the response to a list elastic pool database activity request.")
@pagedResult
model ElasticPoolDatabaseActivityListResult {
  @doc("The list of elastic pool database activities.")
  @items
  value: ElasticPoolDatabaseActivity[];
}

@doc("Represents the activity on an elastic pool.")
model ElasticPoolDatabaseActivity extends ProxyResource {
  @doc("The geo-location where the resource lives")
  @visibility("read", "create")
  location?: string;

  @doc("The properties representing the resource.")
  properties?: ElasticPoolDatabaseActivityProperties;
}

@doc("Represents the properties of an elastic pool database activity.")
model ElasticPoolDatabaseActivityProperties {
  @doc("The database name.")
  @visibility("read")
  databaseName?: string;

  @doc("The time the operation finished (ISO8601 format).")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  endTime?: utcDateTime;

  @doc("The error code if available.")
  @visibility("read")
  errorCode?: int32;

  @doc("The error message if available.")
  @visibility("read")
  errorMessage?: string;

  @doc("The error severity if available.")
  @visibility("read")
  errorSeverity?: int32;

  @doc("The operation name.")
  @visibility("read")
  operation?: string;

  @doc("The unique operation ID.")
  @visibility("read")
  operationId?: string;

  @doc("The percentage complete if available.")
  @visibility("read")
  percentComplete?: int32;

  @doc("The name for the elastic pool the database is moving into if available.")
  @visibility("read")
  requestedElasticPoolName?: string;

  @doc("The name of the current elastic pool the database is in if available.")
  @visibility("read")
  currentElasticPoolName?: string;

  @doc("The name of the current service objective if available.")
  @visibility("read")
  currentServiceObjective?: string;

  @doc("The name of the requested service objective if available.")
  @visibility("read")
  requestedServiceObjective?: string;

  @doc("The name of the server the elastic pool is in.")
  @visibility("read")
  serverName?: string;

  @doc("The time the operation started (ISO8601 format).")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startTime?: utcDateTime;

  @doc("The current state of the operation.")
  @visibility("read")
  state?: string;
}

@doc("Represents the response to a list server metrics request.")
@pagedResult
model ServerUsageListResult {
  @doc("The list of server metrics for the server.")
  @items
  value: ServerUsage[];
}

@doc("Represents server metrics.")
model ServerUsage {
  @doc("Name of the server usage metric.")
  @visibility("read")
  name?: string;

  @doc("The name of the resource.")
  @visibility("read")
  resourceName?: string;

  @doc("The metric display name.")
  @visibility("read")
  displayName?: string;

  @doc("The current value of the metric.")
  @visibility("read")
  currentValue?: float32;

  @doc("The current limit of the metric.")
  @visibility("read")
  limit?: float32;

  @doc("The units of the metric.")
  @visibility("read")
  unit?: string;

  @doc("The next reset time for the metric (ISO8601 format).")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  nextResetTime?: utcDateTime;
}

@doc("Properties for a Database, Server or Elastic Pool Advisor.")
model AdvisorProperties {
  @doc("Gets the status of availability of this advisor to customers. Possible values are 'GA', 'PublicPreview', 'LimitedPublicPreview' and 'PrivatePreview'.")
  @visibility("read")
  advisorStatus?: AdvisorStatus;

  @doc("Gets the auto-execute status (whether to let the system execute the recommendations) of this advisor. Possible values are 'Enabled' and 'Disabled'")
  autoExecuteStatus: AutoExecuteStatus;

  @doc("Gets the resource from which current value of auto-execute status is inherited. Auto-execute status can be set on (and inherited from) different levels in the resource hierarchy. Possible values are 'Subscription', 'Server', 'ElasticPool', 'Database' and 'Default' (when status is not explicitly set on any level).")
  @visibility("read")
  autoExecuteStatusInheritedFrom?: AutoExecuteStatusInheritedFrom;

  @doc("Gets that status of recommendations for this advisor and reason for not having any recommendations. Possible values include, but are not limited to, 'Ok' (Recommendations available),LowActivity (not enough workload to analyze), 'DbSeemsTuned' (Database is doing well), etc.")
  @visibility("read")
  recommendationsStatus?: string;

  @doc("Gets the time when the current resource was analyzed for recommendations by this advisor.")
  @visibility("read")
  @projectedName("json", "lastChecked")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastCheckedOn?: utcDateTime;

  @doc("Gets the recommended actions for this advisor.")
  @visibility("read")
  recommendedActions?: RecommendedAction[];
}

@doc("Properties for a Database, Server or Elastic Pool Recommended Action.")
model RecommendedActionProperties {
  @doc("Gets the reason for recommending this action. e.g., DuplicateIndex")
  @visibility("read")
  recommendationReason?: string;

  @doc("Gets the time since when this recommended action is valid.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  validSince?: utcDateTime;

  @doc("Gets time when this recommended action was last refreshed.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastRefresh?: utcDateTime;

  @doc("Gets the info of the current state the recommended action is in.")
  state: RecommendedActionStateInfo;

  @doc("Gets if this recommended action is actionable by user")
  @visibility("read")
  isExecutableAction?: boolean;

  @doc("Gets if changes applied by this recommended action can be reverted by user")
  @visibility("read")
  isRevertableAction?: boolean;

  @doc("Gets if this recommended action was suggested some time ago but user chose to ignore this and system added a new recommended action again.")
  @visibility("read")
  isArchivedAction?: boolean;

  @doc("Gets the time when system started applying this recommended action on the user resource. e.g., index creation start time")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  executeActionStartTime?: utcDateTime;

  @doc("Gets the time taken for applying this recommended action on user resource. e.g., time taken for index creation")
  @visibility("read")
  executeActionDuration?: duration;

  @doc("Gets the time when system started reverting changes of this recommended action on user resource. e.g., time when index drop is executed.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  revertActionStartTime?: utcDateTime;

  @doc("Gets the time taken for reverting changes of this recommended action on user resource. e.g., time taken for dropping the created index.")
  @visibility("read")
  revertActionDuration?: duration;

  @doc("Gets if approval for applying this recommended action was given by user/system.")
  @visibility("read")
  executeActionInitiatedBy?: RecommendedActionInitiatedBy;

  @doc("Gets the time when this recommended action was approved for execution.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  executeActionInitiatedTime?: utcDateTime;

  @doc("Gets if approval for reverting this recommended action was given by user/system.")
  @visibility("read")
  revertActionInitiatedBy?: RecommendedActionInitiatedBy;

  @doc("Gets the time when this recommended action was approved for revert.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  revertActionInitiatedTime?: utcDateTime;

  @doc("Gets the impact of this recommended action. Possible values are 1 - Low impact, 2 - Medium Impact and 3 - High Impact")
  @visibility("read")
  score?: int32;

  @doc("Gets the implementation details of this recommended action for user to apply it manually.")
  @visibility("read")
  implementationDetails?: RecommendedActionImplementationInfo;

  @doc("Gets the error details if and why this recommended action is put to error state.")
  @visibility("read")
  errorDetails?: RecommendedActionErrorInfo;

  @doc("Gets the estimated impact info for this recommended action e.g., Estimated CPU gain, Estimated Disk Space change")
  @visibility("read")
  estimatedImpact?: RecommendedActionImpactRecord[];

  @doc("Gets the observed/actual impact info for this recommended action e.g., Actual CPU gain, Actual Disk Space change")
  @visibility("read")
  observedImpact?: RecommendedActionImpactRecord[];

  @doc("Gets the time series info of metrics for this recommended action e.g., CPU consumption time series")
  @visibility("read")
  timeSeries?: RecommendedActionMetricInfo[];

  @doc("Gets the linked objects, if any.")
  @visibility("read")
  linkedObjects?: string[];

  @doc("Gets additional details specific to this recommended action.")
  @visibility("read")
  details?: Record<Record<unknown>>;
}

@doc("Contains information of current state for an Azure SQL Database, Server or Elastic Pool Recommended Action.")
model RecommendedActionStateInfo {
  @doc("Current state the recommended action is in. Some commonly used states are: Active      -> recommended action is active and no action has been taken yet. Pending     -> recommended action is approved for and is awaiting execution. Executing   -> recommended action is being applied on the user database. Verifying   -> recommended action was applied and is being verified of its usefulness by the system. Success     -> recommended action was applied and improvement found during verification. Pending Revert  -> verification found little or no improvement so recommended action is queued for revert or user has manually reverted. Reverting   -> changes made while applying recommended action are being reverted on the user database. Reverted    -> successfully reverted the changes made by recommended action on user database. Ignored     -> user explicitly ignored/discarded the recommended action. ")
  currentValue: RecommendedActionCurrentState;

  @doc("Gets who initiated the execution of this recommended action. Possible Value are: User    -> When user explicity notified system to apply the recommended action. System  -> When auto-execute status of this advisor was set to 'Enabled', in which case the system applied it.")
  @visibility("read")
  actionInitiatedBy?: RecommendedActionInitiatedBy;

  @doc("Gets the time when the state was last modified")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastModified?: utcDateTime;
}

@doc("Contains information for manual implementation for an Azure SQL Database, Server or Elastic Pool Recommended Action.")
model RecommendedActionImplementationInfo {
  @doc("Gets the method in which this recommended action can be manually implemented. e.g., TSql, AzurePowerShell.")
  @visibility("read")
  method?: ImplementationMethod;

  @doc("Gets the manual implementation script. e.g., T-SQL script that could be executed on the database.")
  @visibility("read")
  script?: string;
}

@doc("Contains error information for an Azure SQL Database, Server or Elastic Pool Recommended Action.")
model RecommendedActionErrorInfo {
  @doc("Gets the reason why the recommended action was put to error state. e.g., DatabaseHasQdsOff, IndexAlreadyExists")
  @visibility("read")
  errorCode?: string;

  @doc("Gets whether the error could be ignored and recommended action could be retried. Possible values are: Yes/No")
  @visibility("read")
  isRetryable?: IsRetryable;
}

@doc("Contains information of estimated or observed impact on various metrics for an Azure SQL Database, Server or Elastic Pool Recommended Action.")
model RecommendedActionImpactRecord {
  @doc("Gets the name of the impact dimension. e.g., CPUChange, DiskSpaceChange, NumberOfQueriesAffected.")
  @visibility("read")
  dimensionName?: string;

  @doc("Gets the name of the impact dimension. e.g., CPUChange, DiskSpaceChange, NumberOfQueriesAffected.")
  @visibility("read")
  unit?: string;

  @doc("Gets the absolute value of this dimension if applicable. e.g., Number of Queries affected")
  @visibility("read")
  absoluteValue?: float32;

  @doc("Gets the absolute change in the value of this dimension. e.g., Absolute Disk space change in Megabytes")
  @visibility("read")
  changeValueAbsolute?: float32;

  @doc("Gets the relative change in the value of this dimension. e.g., Relative Disk space change in Percentage")
  @visibility("read")
  changeValueRelative?: float32;
}

@doc("Contains time series of various impacted metrics for an Azure SQL Database, Server or Elastic Pool Recommended Action.")
model RecommendedActionMetricInfo {
  @doc("Gets the name of the metric. e.g., CPU, Number of Queries.")
  @visibility("read")
  metricName?: string;

  @doc("Gets the unit in which metric is measured. e.g., DTU, Frequency")
  @visibility("read")
  unit?: string;

  @doc("Gets the duration of time interval for the value given by this MetricInfo. e.g., PT1H (1 hour)")
  @visibility("read")
  timeGrain?: string;

  @doc("Gets the start time of time interval given by this MetricInfo.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startTime?: utcDateTime;

  @doc("Gets the value of the metric in the time interval given by this MetricInfo.")
  @visibility("read")
  value?: float32;
}

@doc("Database-level Automatic Tuning properties.")
model DatabaseAutomaticTuningProperties {
  @doc("Automatic tuning desired state.")
  desiredState?: AutomaticTuningMode;

  @doc("Automatic tuning actual state.")
  @visibility("read")
  actualState?: AutomaticTuningMode;

  @doc("Automatic tuning options definition.")
  options?: Record<AutomaticTuningOptions>;
}

@doc("Automatic tuning properties for individual advisors.")
model AutomaticTuningOptions {
  @doc("Automatic tuning option desired state.")
  desiredState?: AutomaticTuningOptionModeDesired;

  @doc("Automatic tuning option actual state.")
  @visibility("read")
  actualState?: AutomaticTuningOptionModeActual;

  @doc("Reason code if desired and actual state are different.")
  @visibility("read")
  reasonCode?: int32;

  @doc("Reason description if desired and actual state are different.")
  @visibility("read")
  reasonDesc?: AutomaticTuningDisabledReason;
}

@doc("Database column properties.")
model DatabaseColumnProperties {
  @doc("The column data type.")
  columnType?: ColumnDataType;

  @doc("The table temporal type.")
  temporalType?: TableTemporalType;

  @doc("Whether or not the column belongs to a memory optimized table.")
  @projectedName("json", "memoryOptimized")
  IsMemoryOptimized?: boolean;

  @doc("Whether or not the column is computed.")
  isComputed?: boolean;
}

@doc("Properties of a security alert policy.")
model SecurityAlertsPolicyProperties {
  @doc("Specifies the state of the policy, whether it is enabled or disabled or a policy has not been applied yet on the specific database.")
  state: SecurityAlertsPolicyState;

  @doc("Specifies an array of alerts that are disabled. Allowed values are: Sql_Injection, Sql_Injection_Vulnerability, Access_Anomaly, Data_Exfiltration, Unsafe_Action, Brute_Force")
  disabledAlerts?: string[];

  @doc("Specifies an array of e-mail addresses to which the alert is sent.")
  emailAddresses?: string[];

  @doc("Specifies that the alert is sent to the account administrators.")
  @projectedName("json", "emailAccountAdmins")
  sendToEmailAccountAdmins?: boolean;

  @doc("Specifies the blob storage endpoint (e.g. https://MyAccount.blob.core.windows.net). This blob storage will hold all Threat Detection audit logs.")
  storageEndpoint?: string;

  @doc("Specifies the identifier key of the Threat Detection audit storage account.")
  storageAccountAccessKey?: string;

  @doc("Specifies the number of days to keep in the Threat Detection audit logs.")
  retentionDays?: int32;

  @doc("Specifies the UTC creation time of the policy.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  creationTime?: utcDateTime;
}

@doc("Database table properties.")
model DatabaseTableProperties {
  @doc("The table temporal type.")
  temporalType?: TableTemporalType;

  @doc("Whether or not the table is memory optimized.")
  @projectedName("json", "memoryOptimized")
  IsMemoryOptimized?: boolean;
}

@doc("Properties of a database Vulnerability Assessment rule baseline.")
model DatabaseVulnerabilityAssessmentRuleBaselineProperties {
  @doc("The rule baseline result")
  baselineResults: DatabaseVulnerabilityAssessmentRuleBaselineItem[];
}

@doc("Properties for an Azure SQL Database Vulnerability Assessment rule baseline's result.")
model DatabaseVulnerabilityAssessmentRuleBaselineItem {
  @doc("The rule baseline result")
  result: string[];
}

@doc("Properties of a database Vulnerability Assessment.")
model DatabaseVulnerabilityAssessmentProperties {
  @doc("A blob storage container path to hold the scan results (e.g. https://myStorage.blob.core.windows.net/VaScans/).  It is required if server level vulnerability assessment policy doesn't set")
  @visibility("create", "update")
  storageContainerPath?: string;

  @doc("A shared access signature (SAS Key) that has write access to the blob container specified in 'storageContainerPath' parameter. If 'storageAccountAccessKey' isn't specified, StorageContainerSasKey is required.")
  @visibility("create", "update")
  storageContainerSasKey?: string;

  @doc("Specifies the identifier key of the storage account for vulnerability assessment scan results. If 'StorageContainerSasKey' isn't specified, storageAccountAccessKey is required.")
  @visibility("create", "update")
  storageAccountAccessKey?: string;

  @doc("The recurring scans settings")
  recurringScans?: VulnerabilityAssessmentRecurringScansProperties;
}

@doc("Properties of a Vulnerability Assessment recurring scans.")
model VulnerabilityAssessmentRecurringScansProperties {
  @doc("Recurring scans state.")
  isEnabled?: boolean;

  @doc("Specifies that the schedule scan notification will be is sent to the subscription administrators.")
  emailSubscriptionAdmins?: boolean;

  @doc("Specifies an array of e-mail addresses to which the scan notification is sent.")
  emails?: string[];
}

@doc("Properties of a vulnerability assessment scan record.")
model VulnerabilityAssessmentScanRecordProperties {
  @doc("The scan ID.")
  @visibility("read")
  scanId?: string;

  @doc("The scan trigger type.")
  @visibility("read")
  triggerType?: VulnerabilityAssessmentScanTriggerType;

  @doc("The scan status.")
  @visibility("read")
  state?: VulnerabilityAssessmentScanState;

  @doc("The scan start time (UTC).")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startTime?: utcDateTime;

  @doc("The scan end time (UTC).")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  endTime?: utcDateTime;

  @doc("The scan errors.")
  @visibility("read")
  errors?: VulnerabilityAssessmentScanError[];

  @doc("The scan results storage container path.")
  @visibility("read")
  storageContainerPath?: string;

  @doc("The number of failed security checks.")
  @visibility("read")
  numberOfFailedSecurityChecks?: int32;
}

@doc("Properties of a vulnerability assessment scan error.")
model VulnerabilityAssessmentScanError {
  @doc("The error code.")
  @visibility("read")
  code?: string;

  @doc("The error message.")
  @visibility("read")
  message?: string;
}

@doc("A database Vulnerability Assessment scan export resource.")
model DatabaseVulnerabilityAssessmentScansExport extends ProxyResource {
  @doc("Resource properties.")
  properties?: DatabaseVulnerabilityAssessmentScanExportProperties;
}

@doc("Properties of the export operation's result.")
model DatabaseVulnerabilityAssessmentScanExportProperties {
  @doc("Location of the exported report (e.g. https://myStorage.blob.core.windows.net/VaScans/scans/serverName/databaseName/scan_scanId.xlsx).")
  @visibility("read")
  exportedReportLocation?: string;
}

@doc("User activities of a data warehouse. This currently includes the count of running or suspended queries. For more information, please view the sys.dm_pdw_exec_requests dynamic management view (DMV).")
model DataWarehouseUserActivitiesProperties {
  @doc("Count of running and suspended queries.")
  @visibility("read")
  activeQueriesCount?: int32;
}

@doc("The properties of a deleted server.")
model DeletedServerProperties {
  @doc("The version of the deleted server.")
  @visibility("read")
  version?: string;

  @doc("The deletion time of the deleted server.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  deletionTime?: utcDateTime;

  @doc("The original ID of the server before deletion.")
  @visibility("read")
  originalId?: string;

  @doc("The fully qualified domain name of the server.")
  @visibility("read")
  fullyQualifiedDomainName?: string;
}

@doc("The response to a list elastic pool operations request")
model ElasticPoolOperationListResult is Azure.Core.Page<ElasticPoolOperation>;

@doc("A elastic pool operation.")
model ElasticPoolOperation extends ProxyResource {
  @doc("Resource properties.")
  properties?: ElasticPoolOperationProperties;
}

@doc("The properties of a elastic pool operation.")
model ElasticPoolOperationProperties {
  @doc("The name of the elastic pool the operation is being performed on.")
  @visibility("read")
  elasticPoolName?: string;

  @doc("The name of operation.")
  @visibility("read")
  operation?: string;

  @doc("The friendly name of operation.")
  @visibility("read")
  operationFriendlyName?: string;

  @doc("The percentage of the operation completed.")
  @visibility("read")
  percentComplete?: int32;

  @doc("The name of the server.")
  @visibility("read")
  serverName?: string;

  @doc("The operation start time.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startTime?: utcDateTime;

  @doc("The operation state.")
  @visibility("read")
  state?: string;

  @doc("The operation error code.")
  @visibility("read")
  errorCode?: int32;

  @doc("The operation error description.")
  @visibility("read")
  errorDescription?: string;

  @doc("The operation error severity.")
  @visibility("read")
  errorSeverity?: int32;

  @doc("Whether or not the error is a user error.")
  @visibility("read")
  isUserError?: boolean;

  @doc("The estimated completion time of the operation.")
  @visibility("read")
  @projectedName("json", "estimatedCompletionTime")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  estimatedCompleteOn?: utcDateTime;

  @doc("The operation description.")
  @visibility("read")
  description?: string;

  @doc("Whether the operation can be cancelled.")
  @visibility("read")
  isCancellable?: boolean;
}

@doc("Properties for an encryption protector execution.")
model EncryptionProtectorProperties {
  @doc("Subregion of the encryption protector.")
  @visibility("read")
  subregion?: string;

  @doc("The name of the server key.")
  serverKeyName?: string;

  @doc("The encryption protector type like 'ServiceManaged', 'AzureKeyVault'.")
  serverKeyType: ServerKeyType;

  @doc("The URI of the server key.")
  @visibility("read")
  uri?: string;

  @doc("Thumbprint of the server key.")
  @visibility("read")
  thumbprint?: string;

  @doc("Key auto rotation opt-in flag. Either true or false.")
  @projectedName("json", "autoRotationEnabled")
  IsAutoRotationEnabled?: boolean;
}

@doc("The properties of a server firewall rule.")
model ServerFirewallRuleProperties {
  @doc("The start IP address of the firewall rule. Must be IPv4 format. Use value '0.0.0.0' for all Azure-internal IP addresses.")
  startIpAddress?: string;

  @doc("The end IP address of the firewall rule. Must be IPv4 format. Must be greater than or equal to startIpAddress. Use value '0.0.0.0' for all Azure-internal IP addresses.")
  endIpAddress?: string;
}

@doc("ARM proxy resource.")
model ProxyResourceWithWritableName extends ResourceWithWritableName {}

@doc("ARM resource.")
model ResourceWithWritableName {
  @doc("Resource ID.")
  @visibility("read")
  id?: string;

  @doc("Resource name.")
  name?: string;

  @doc("Resource type.")
  @visibility("read")
  type?: string;
}

@doc("An ARM Resource SKU.")
model Sku {
  @doc("The name of the SKU, typically, a letter + Number code, e.g. P3.")
  name: string;

  @doc("The tier or edition of the particular SKU, e.g. Basic, Premium.")
  tier?: string;

  @doc("Size of the particular SKU")
  size?: string;

  @doc("If the service has different generations of hardware, for the same SKU, then that can be captured here.")
  family?: string;

  @doc("Capacity of the particular SKU.")
  capacity?: int32;
}

@doc("Properties of an instance pool.")
model InstancePoolProperties {
  @doc("Resource ID of the subnet to place this instance pool in.")
  @visibility("read", "create")
  subnetId: string;

  @doc("Count of vCores belonging to this instance pool.")
  @visibility("read", "create")
  vCores: int32;

  @doc("The license type. Possible values are 'LicenseIncluded' (price for SQL license is included) and 'BasePrice' (without SQL license price).")
  @visibility("read", "create")
  licenseType: InstancePoolLicenseType;
}

@doc("An update to an Instance pool.")
model InstancePoolUpdate {
  @doc("Resource tags.")
  tags?: Record<string>;
}

@doc("Properties of a job agent.")
model JobAgentProperties {
  @doc("Resource ID of the database to store job metadata in.")
  @visibility("read", "create")
  databaseId: string;

  @doc("The state of the job agent.")
  @visibility("read")
  state?: JobAgentState;
}

@doc("An update to an Azure SQL job agent.")
model JobAgentUpdate {
  @doc("Resource tags.")
  tags?: Record<string>;
}

@doc("Properties of a job credential.")
model JobCredentialProperties {
  @doc("The credential user name.")
  username: string;

  @doc("The credential password.")
  @visibility("create", "update")
  password: string;
}

@doc("Properties for an Azure SQL Database Elastic job execution.")
model JobExecutionProperties {
  @doc("The job version number.")
  @visibility("read")
  jobVersion?: int32;

  @doc("The job step name.")
  @visibility("read")
  stepName?: string;

  @doc("The job step id.")
  @visibility("read")
  stepId?: int32;

  @doc("The unique identifier of the job execution.")
  @visibility("read")
  jobExecutionId?: string;

  @doc("The detailed state of the job execution.")
  @visibility("read")
  lifecycle?: JobExecutionLifecycle;

  @doc("The ARM provisioning state of the job execution.")
  @visibility("read")
  provisioningState?: ProvisioningState;

  @doc("The time that the job execution was created.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  createTime?: utcDateTime;

  @doc("The time that the job execution started.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startTime?: utcDateTime;

  @doc("The time that the job execution completed.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  endTime?: utcDateTime;

  @doc("Number of times the job execution has been attempted.")
  currentAttempts?: int32;

  @doc("Start time of the current attempt.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  currentAttemptStartTime?: utcDateTime;

  @doc("The last status or error message.")
  @visibility("read")
  lastMessage?: string;

  @doc("The target that this execution is executed on.")
  @visibility("read")
  target?: JobExecutionTarget;
}

@doc("The target that a job execution is executed on.")
model JobExecutionTarget {
  @doc("The type of the target.")
  @visibility("read")
  type?: JobTargetType;

  @doc("The server name.")
  @visibility("read")
  serverName?: string;

  @doc("The database name.")
  @visibility("read")
  databaseName?: string;
}

@doc("Properties of a job.")
model JobProperties {
  @doc("User-defined description of the job.")
  description?: string;

  @doc("The job version number.")
  @visibility("read")
  version?: int32;

  @doc("Schedule properties of the job.")
  schedule?: JobSchedule;
}

@doc("Scheduling properties of a job.")
model JobSchedule {
  @doc("Schedule start time.")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startTime?: utcDateTime;

  @doc("Schedule end time.")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  endTime?: utcDateTime;

  @doc("Schedule interval type")
  type?: JobScheduleType;

  @doc("Whether or not the schedule is enabled.")
  @projectedName("json", "enabled")
  IsEnabled?: boolean;

  @doc("Value of the schedule's recurring interval, if the ScheduleType is recurring. ISO8601 duration format.")
  interval?: duration;
}

@doc("Properties of a job step.")
model JobStepProperties {
  @doc("The job step's index within the job. If not specified when creating the job step, it will be created as the last step. If not specified when updating the job step, the step id is not modified.")
  stepId?: int32;

  @doc("The resource ID of the target group that the job step will be executed on.")
  targetGroup: string;

  @doc("The resource ID of the job credential that will be used to connect to the targets.")
  credential: string;

  @doc("The action payload of the job step.")
  action: JobStepAction;

  @doc("Output destination properties of the job step.")
  output?: JobStepOutput;

  @doc("Execution options for the job step.")
  executionOptions?: JobStepExecutionOptions;
}

@doc("The action to be executed by a job step.")
model JobStepAction {
  @doc("Type of action being executed by the job step.")
  type?: JobStepActionType;

  @doc("The source of the action to execute.")
  source?: JobStepActionSource;

  @doc("The action value, for example the text of the T-SQL script to execute.")
  value: string;
}

@doc("The output configuration of a job step.")
model JobStepOutput {
  @doc("The output destination type.")
  type?: JobStepOutputType;

  @doc("The output destination subscription id.")
  subscriptionId?: string;

  @doc("The output destination resource group.")
  resourceGroupName?: string;

  @doc("The output destination server name.")
  serverName: string;

  @doc("The output destination database.")
  databaseName: string;

  @doc("The output destination schema.")
  schemaName?: string;

  @doc("The output destination table.")
  tableName: string;

  @doc("The resource ID of the credential to use to connect to the output destination.")
  credential: string;
}

@doc("The execution options of a job step.")
model JobStepExecutionOptions {
  @doc("Execution timeout for the job step.")
  timeoutSeconds?: int32;

  @doc("Maximum number of times the job step will be reattempted if the first attempt fails.")
  retryAttempts?: int32;

  @doc("Initial delay between retries for job step execution.")
  initialRetryIntervalSeconds?: int32;

  @doc("The maximum amount of time to wait between retries for job step execution.")
  maximumRetryIntervalSeconds?: int32;

  @doc("The backoff multiplier for the time between retries.")
  retryIntervalBackoffMultiplier?: float32;
}

@doc("Properties of job target group.")
model JobTargetGroupProperties {
  @doc("Members of the target group.")
  members: JobTarget[];
}

@doc("A job target, for example a specific database or a container of databases that is evaluated during job execution.")
model JobTarget {
  @doc("Whether the target is included or excluded from the group.")
  membershipType?: JobTargetGroupMembershipType;

  @doc("The target type.")
  type: JobTargetType;

  @doc("The target server name.")
  serverName?: string;

  @doc("The target database name.")
  databaseName?: string;

  @doc("The target elastic pool name.")
  elasticPoolName?: string;

  @doc("The target shard map.")
  shardMapName?: string;

  @doc("The resource ID of the credential that is used during job execution to connect to the target and determine the list of databases inside the target.")
  refreshCredential?: string;
}

@doc("The location capability.")
model LocationCapabilities {
  @doc("The location name.")
  @visibility("read")
  name?: string;

  @doc("The list of supported server versions.")
  @visibility("read")
  supportedServerVersions?: ServerVersionCapability[];

  @doc("The list of supported managed instance versions.")
  @visibility("read")
  supportedManagedInstanceVersions?: ManagedInstanceVersionCapability[];

  @doc("The status of the capability.")
  @visibility("read")
  status?: CapabilityStatus;

  @doc("The reason for the capability not being available.")
  reason?: string;
}

@doc("The server capability")
model ServerVersionCapability {
  @doc("The server version name.")
  @visibility("read")
  name?: string;

  @doc("The list of supported database editions.")
  @visibility("read")
  supportedEditions?: EditionCapability[];

  @doc("The list of supported elastic pool editions.")
  @visibility("read")
  supportedElasticPoolEditions?: ElasticPoolEditionCapability[];

  @doc("The status of the capability.")
  @visibility("read")
  status?: CapabilityStatus;

  @doc("The reason for the capability not being available.")
  reason?: string;
}

@doc("The edition capability.")
model EditionCapability {
  @doc("The database edition name.")
  @visibility("read")
  name?: string;

  @doc("The list of supported service objectives for the edition.")
  @visibility("read")
  supportedServiceLevelObjectives?: ServiceObjectiveCapability[];

  @doc("Whether or not zone redundancy is supported for the edition.")
  @visibility("read")
  @projectedName("json", "zoneRedundant")
  IsZoneRedundant?: boolean;

  @doc("The read scale capability for the edition.")
  @visibility("read")
  readScale?: ReadScaleCapability;

  @doc("The list of supported storage capabilities for this edition")
  @visibility("read")
  supportedStorageCapabilities?: StorageCapability[];

  @doc("The status of the capability.")
  @visibility("read")
  status?: CapabilityStatus;

  @doc("The reason for the capability not being available.")
  reason?: string;
}

@doc("The service objectives capability.")
model ServiceObjectiveCapability {
  @doc("The unique ID of the service objective.")
  @visibility("read")
  id?: string;

  @doc("The service objective name.")
  @visibility("read")
  name?: string;

  @doc("The list of supported maximum database sizes.")
  @visibility("read")
  supportedMaxSizes?: MaxSizeRangeCapability[];

  @doc("The performance level.")
  @visibility("read")
  performanceLevel?: PerformanceLevelCapability;

  @doc("The sku.")
  @visibility("read")
  sku?: Sku;

  @doc("List of supported license types.")
  @visibility("read")
  supportedLicenseTypes?: LicenseTypeCapability[];

  @doc("The included (free) max size.")
  @visibility("read")
  includedMaxSize?: MaxSizeCapability;

  @doc("Whether or not zone redundancy is supported for the service objective.")
  @visibility("read")
  @projectedName("json", "zoneRedundant")
  IsZoneRedundant?: boolean;

  @doc("Supported time range for auto pause delay")
  @visibility("read")
  supportedAutoPauseDelay?: AutoPauseDelayTimeRange;

  @doc("List of supported min capacities")
  @visibility("read")
  supportedMinCapacities?: MinCapacityCapability[];

  @doc("The compute model")
  @visibility("read")
  computeModel?: string;

  @doc("List of supported maintenance configurations")
  @visibility("read")
  supportedMaintenanceConfigurations?: MaintenanceConfigurationCapability[];

  @doc("The status of the capability.")
  @visibility("read")
  status?: CapabilityStatus;

  @doc("The reason for the capability not being available.")
  reason?: string;
}

@doc("The maximum size range capability.")
model MaxSizeRangeCapability {
  @doc("Minimum value.")
  @visibility("read")
  minValue?: MaxSizeCapability;

  @doc("Maximum value.")
  @visibility("read")
  maxValue?: MaxSizeCapability;

  @doc("Scale/step size for discrete values between the minimum value and the maximum value.")
  @visibility("read")
  scaleSize?: MaxSizeCapability;

  @doc("Size of transaction log.")
  @visibility("read")
  logSize?: LogSizeCapability;

  @doc("The status of the capability.")
  @visibility("read")
  status?: CapabilityStatus;

  @doc("The reason for the capability not being available.")
  reason?: string;
}

@doc("The maximum size capability.")
model MaxSizeCapability {
  @doc("The maximum size limit (see 'unit' for the units).")
  @visibility("read")
  limit?: int32;

  @doc("The units that the limit is expressed in.")
  @visibility("read")
  unit?: MaxSizeUnit;
}

@doc("The log size capability.")
model LogSizeCapability {
  @doc("The log size limit (see 'unit' for the units).")
  @visibility("read")
  limit?: int32;

  @doc("The units that the limit is expressed in.")
  @visibility("read")
  unit?: LogSizeUnit;
}

@doc("The performance level capability.")
model PerformanceLevelCapability {
  @doc("Performance level value.")
  @visibility("read")
  value?: float32;

  @doc("Unit type used to measure performance level.")
  @visibility("read")
  unit?: PerformanceLevelUnit;
}

@doc("The license type capability")
model LicenseTypeCapability {
  @doc("License type identifier.")
  @visibility("read")
  name?: string;

  @doc("The status of the capability.")
  @visibility("read")
  status?: CapabilityStatus;

  @doc("The reason for the capability not being available.")
  reason?: string;
}

@doc("Supported auto pause delay time range")
model AutoPauseDelayTimeRange {
  @doc("Minimum value")
  @visibility("read")
  minValue?: int32;

  @doc("Maximum value")
  @visibility("read")
  maxValue?: int32;

  @doc("Step value for discrete values between the minimum value and the maximum value.")
  @visibility("read")
  stepSize?: int32;

  @doc("Default value is no value is provided")
  @visibility("read")
  default?: int32;

  @doc("Unit of time that delay is expressed in")
  @visibility("read")
  unit?: PauseDelayTimeUnit;

  @doc("Value that is used to not pause (infinite delay before pause)")
  @visibility("read")
  doNotPauseValue?: int32;
}

@doc("The min capacity capability")
model MinCapacityCapability {
  @doc("Min capacity value")
  @visibility("read")
  value?: float32;

  @doc("The status of the capability.")
  @visibility("read")
  status?: CapabilityStatus;

  @doc("The reason for the capability not being available.")
  reason?: string;
}

@doc("The maintenance configuration capability")
model MaintenanceConfigurationCapability {
  @doc("Maintenance configuration name")
  @visibility("read")
  name?: string;

  @doc("Whether or not zone redundancy is supported for the maintenance configuration.")
  @visibility("read")
  @projectedName("json", "zoneRedundant")
  IsZoneRedundant?: boolean;

  @doc("The status of the capability.")
  @visibility("read")
  status?: CapabilityStatus;

  @doc("The reason for the capability not being available.")
  reason?: string;
}

@doc("The read scale capability.")
model ReadScaleCapability {
  @doc("The maximum number of read scale replicas.")
  @visibility("read")
  maxNumberOfReplicas?: int32;

  @doc("The status of the capability.")
  @visibility("read")
  status?: CapabilityStatus;

  @doc("The reason for the capability not being available.")
  reason?: string;
}

@doc("The storage account type capability.")
model StorageCapability {
  @doc("The storage account type for the database's backups.")
  @visibility("read")
  storageAccountType?: StorageCapabilityStorageAccountType;

  @doc("The status of the capability.")
  @visibility("read")
  status?: CapabilityStatus;

  @doc("The reason for the capability not being available.")
  reason?: string;
}

@doc("The elastic pool edition capability.")
model ElasticPoolEditionCapability {
  @doc("The elastic pool edition name.")
  @visibility("read")
  name?: string;

  @doc("The list of supported elastic pool DTU levels for the edition.")
  @visibility("read")
  supportedElasticPoolPerformanceLevels?: ElasticPoolPerformanceLevelCapability[];

  @doc("Whether or not zone redundancy is supported for the edition.")
  @visibility("read")
  @projectedName("json", "zoneRedundant")
  IsZoneRedundant?: boolean;

  @doc("The status of the capability.")
  @visibility("read")
  status?: CapabilityStatus;

  @doc("The reason for the capability not being available.")
  reason?: string;
}

@doc("The Elastic Pool performance level capability.")
model ElasticPoolPerformanceLevelCapability {
  @doc("The performance level for the pool.")
  @visibility("read")
  performanceLevel?: PerformanceLevelCapability;

  @doc("The sku.")
  @visibility("read")
  sku?: Sku;

  @doc("List of supported license types.")
  @visibility("read")
  supportedLicenseTypes?: LicenseTypeCapability[];

  @doc("The maximum number of databases supported.")
  @visibility("read")
  maxDatabaseCount?: int32;

  @doc("The included (free) max size for this performance level.")
  @visibility("read")
  includedMaxSize?: MaxSizeCapability;

  @doc("The list of supported max sizes.")
  @visibility("read")
  supportedMaxSizes?: MaxSizeRangeCapability[];

  @doc("The list of supported per database max sizes.")
  @visibility("read")
  supportedPerDatabaseMaxSizes?: MaxSizeRangeCapability[];

  @doc("The list of supported per database max performance levels.")
  @visibility("read")
  supportedPerDatabaseMaxPerformanceLevels?: ElasticPoolPerDatabaseMaxPerformanceLevelCapability[];

  @doc("Whether or not zone redundancy is supported for the performance level.")
  @visibility("read")
  @projectedName("json", "zoneRedundant")
  IsZoneRedundant?: boolean;

  @doc("List of supported maintenance configurations")
  @visibility("read")
  supportedMaintenanceConfigurations?: MaintenanceConfigurationCapability[];

  @doc("The status of the capability.")
  @visibility("read")
  status?: CapabilityStatus;

  @doc("The reason for the capability not being available.")
  reason?: string;
}

@doc("The max per-database performance level capability.")
model ElasticPoolPerDatabaseMaxPerformanceLevelCapability {
  @doc("The maximum performance level per database.")
  @visibility("read")
  limit?: float32;

  @doc("Unit type used to measure performance level.")
  @visibility("read")
  unit?: PerformanceLevelUnit;

  @doc("The list of supported min database performance levels.")
  @visibility("read")
  supportedPerDatabaseMinPerformanceLevels?: ElasticPoolPerDatabaseMinPerformanceLevelCapability[];

  @doc("The status of the capability.")
  @visibility("read")
  status?: CapabilityStatus;

  @doc("The reason for the capability not being available.")
  reason?: string;
}

@doc("The minimum per-database performance level capability.")
model ElasticPoolPerDatabaseMinPerformanceLevelCapability {
  @doc("The minimum performance level per database.")
  @visibility("read")
  limit?: float32;

  @doc("Unit type used to measure performance level.")
  @visibility("read")
  unit?: PerformanceLevelUnit;

  @doc("The status of the capability.")
  @visibility("read")
  status?: CapabilityStatus;

  @doc("The reason for the capability not being available.")
  reason?: string;
}

@doc("The managed instance capability")
model ManagedInstanceVersionCapability {
  @doc("The server version name.")
  @visibility("read")
  name?: string;

  @doc("The list of supported managed instance editions.")
  @visibility("read")
  supportedEditions?: ManagedInstanceEditionCapability[];

  @doc("The list of supported instance pool editions.")
  @visibility("read")
  supportedInstancePoolEditions?: InstancePoolEditionCapability[];

  @doc("The status of the capability.")
  @visibility("read")
  status?: CapabilityStatus;

  @doc("The reason for the capability not being available.")
  reason?: string;
}

@doc("The managed server capability")
model ManagedInstanceEditionCapability {
  @doc("The managed server version name.")
  @visibility("read")
  name?: string;

  @doc("The supported families.")
  @visibility("read")
  supportedFamilies?: ManagedInstanceFamilyCapability[];

  @doc("The list of supported storage capabilities for this edition")
  @visibility("read")
  supportedStorageCapabilities?: StorageCapability[];

  @doc("Whether or not zone redundancy is supported for the edition.")
  @visibility("read")
  @projectedName("json", "zoneRedundant")
  IsZoneRedundant?: boolean;

  @doc("The status of the capability.")
  @visibility("read")
  status?: CapabilityStatus;

  @doc("The reason for the capability not being available.")
  reason?: string;
}

@doc("The managed server family capability.")
model ManagedInstanceFamilyCapability {
  @doc("Family name.")
  @visibility("read")
  name?: string;

  @doc("SKU name.")
  @visibility("read")
  sku?: string;

  @doc("List of supported license types.")
  @visibility("read")
  supportedLicenseTypes?: LicenseTypeCapability[];

  @doc("List of supported virtual cores values.")
  @visibility("read")
  supportedVcoresValues?: ManagedInstanceVcoresCapability[];

  @doc("The status of the capability.")
  @visibility("read")
  status?: CapabilityStatus;

  @doc("The reason for the capability not being available.")
  reason?: string;
}

@doc("The managed instance virtual cores capability.")
model ManagedInstanceVcoresCapability {
  @doc("The virtual cores identifier.")
  @visibility("read")
  name?: string;

  @doc("The virtual cores value.")
  @visibility("read")
  value?: int32;

  @doc("Included size.")
  @visibility("read")
  includedMaxSize?: MaxSizeCapability;

  @doc("Storage size ranges.")
  @visibility("read")
  supportedStorageSizes?: MaxSizeRangeCapability[];

  @doc("True if this service objective is supported for managed instances in an instance pool.")
  @visibility("read")
  @projectedName("json", "instancePoolSupported")
  IsInstancePoolSupported?: boolean;

  @doc("True if this service objective is supported for standalone managed instances.")
  @visibility("read")
  @projectedName("json", "standaloneSupported")
  IsStandaloneSupported?: boolean;

  @doc("List of supported maintenance configurations")
  @visibility("read")
  supportedMaintenanceConfigurations?: ManagedInstanceMaintenanceConfigurationCapability[];

  @doc("The status of the capability.")
  @visibility("read")
  status?: CapabilityStatus;

  @doc("The reason for the capability not being available.")
  reason?: string;
}

@doc("The maintenance configuration capability")
model ManagedInstanceMaintenanceConfigurationCapability {
  @doc("Maintenance configuration name")
  @visibility("read")
  name?: string;

  @doc("The status of the capability.")
  @visibility("read")
  status?: CapabilityStatus;

  @doc("The reason for the capability not being available.")
  reason?: string;
}

@doc("The instance pool capability")
model InstancePoolEditionCapability {
  @doc("The instance pool version name.")
  @visibility("read")
  name?: string;

  @doc("The supported families.")
  @visibility("read")
  supportedFamilies?: InstancePoolFamilyCapability[];

  @doc("The status of the capability.")
  @visibility("read")
  status?: CapabilityStatus;

  @doc("The reason for the capability not being available.")
  reason?: string;
}

@doc("The instance pool family capability.")
model InstancePoolFamilyCapability {
  @doc("Family name.")
  @visibility("read")
  name?: string;

  @doc("List of supported license types.")
  @visibility("read")
  supportedLicenseTypes?: LicenseTypeCapability[];

  @doc("List of supported virtual cores values.")
  @visibility("read")
  supportedVcoresValues?: InstancePoolVcoresCapability[];

  @doc("The status of the capability.")
  @visibility("read")
  status?: CapabilityStatus;

  @doc("The reason for the capability not being available.")
  reason?: string;
}

@doc("The managed instance virtual cores capability.")
model InstancePoolVcoresCapability {
  @doc("The virtual cores identifier.")
  @visibility("read")
  name?: string;

  @doc("The virtual cores value.")
  @visibility("read")
  value?: int32;

  @doc("Storage limit.")
  @visibility("read")
  storageLimit?: MaxSizeCapability;

  @doc("The status of the capability.")
  @visibility("read")
  status?: CapabilityStatus;

  @doc("The reason for the capability not being available.")
  reason?: string;
}

@doc("Properties of a long term retention policy")
model BaseLongTermRetentionPolicyProperties {
  @doc("The weekly retention policy for an LTR backup in an ISO 8601 format.")
  weeklyRetention?: string;

  @doc("The monthly retention policy for an LTR backup in an ISO 8601 format.")
  monthlyRetention?: string;

  @doc("The yearly retention policy for an LTR backup in an ISO 8601 format.")
  yearlyRetention?: string;

  @doc("The week of year to take the yearly backup in an ISO 8601 format.")
  weekOfYear?: int32;
}

@doc("Maintenance window options properties.")
model MaintenanceWindowOptionsProperties {
  @doc("Whether maintenance windows are enabled for the database.")
  isEnabled?: boolean;

  @doc("Available maintenance cycles e.g. {Saturday, 0, 48*60}, {Wednesday, 0, 24*60}.")
  maintenanceWindowCycles?: MaintenanceWindowTimeRange[];

  @doc("Minimum duration of maintenance window.")
  minDurationInMinutes?: int32;

  @doc("Default duration for maintenance window.")
  defaultDurationInMinutes?: int32;

  @doc("Minimum number of maintenance windows cycles to be set on the database.")
  minCycles?: int32;

  @doc("Time granularity in minutes for maintenance windows.")
  timeGranularityInMinutes?: int32;

  @doc("Whether we allow multiple maintenance windows per cycle.")
  allowMultipleMaintenanceWindowsPerCycle?: boolean;
}

@doc("Maintenance window time range.")
model MaintenanceWindowTimeRange {
  @doc("Day of maintenance window.")
  dayOfWeek?: DayOfWeek;

  @doc("Start time minutes offset from 12am.")
  startTime?: string;

  @doc("Duration of maintenance window in minutes.")
  duration?: duration;
}

@doc("Maintenance windows resource properties.")
model MaintenanceWindowsProperties {
  timeRanges?: MaintenanceWindowTimeRange[];
}

@doc("Properties of a short term retention policy")
model ManagedBackupShortTermRetentionPolicyProperties {
  @doc("The backup retention period in days. This is how many days Point-in-Time Restore will be supported.")
  retentionDays?: int32;
}

@doc("Database query.")
model ManagedInstanceQuery extends ProxyResource {
  @doc("Resource properties.")
  properties?: QueryProperties;
}

@doc("Properties of a database query.")
model QueryProperties {
  @doc("Query text.")
  queryText?: string;
}

@doc("Execution statistics for one particular query")
model ManagedInstanceQueryStatistics is Azure.Core.Page<QueryStatistics>;

model QueryStatistics extends ProxyResource {
  @doc("Resource properties.")
  properties?: QueryStatisticsProperties;
}

@doc("Properties of a query execution statistics.")
model QueryStatisticsProperties {
  @doc("Database name of the database in which this query was executed.")
  @visibility("read")
  databaseName?: string;

  @doc("Unique query id (unique within one database).")
  @visibility("read")
  queryId?: string;

  @doc("The start time for the metric (ISO-8601 format).")
  @visibility("read")
  startTime?: string;

  @doc("The end time for the metric (ISO-8601 format).")
  @visibility("read")
  endTime?: string;

  @doc("List of intervals with appropriate metric data")
  intervals?: QueryMetricInterval[];
}

@doc("Properties of a query metrics interval.")
model QueryMetricInterval {
  @doc("The start time for the metric interval (ISO-8601 format).")
  @visibility("read")
  intervalStartTime?: string;

  @doc("Interval type (length).")
  @visibility("read")
  intervalType?: QueryTimeGrainType;

  @doc("Execution count of a query in this interval.")
  @visibility("read")
  executionCount?: int32;

  @doc("List of metric objects for this interval")
  metrics?: QueryMetricProperties[];
}

@doc("Properties of a topquery metric in one interval.")
model QueryMetricProperties {
  @doc("The name information for the metric.")
  @visibility("read")
  name?: string;

  @doc("The UI appropriate name for the metric.")
  @visibility("read")
  displayName?: string;

  @doc("The unit of the metric.")
  @visibility("read")
  unit?: QueryMetricUnitType;

  @doc("The value of the metric.")
  @visibility("read")
  value?: float32;

  @doc("Metric value when min() aggregate function is used over the interval.")
  @visibility("read")
  min?: float32;

  @doc("Metric value when max() aggregate function is used over the interval.")
  @visibility("read")
  max?: float32;

  @doc("Metric value when avg() aggregate function is used over the interval.")
  @visibility("read")
  avg?: float32;

  @doc("Metric value when sum() aggregate function is used over the interval.")
  @visibility("read")
  sum?: float32;

  @doc("Metric value when stdev aggregate function is used over the interval.")
  @visibility("read")
  stdev?: float32;
}

@doc("Properties of a security alert policy.")
model SecurityAlertPolicyProperties {
  @doc("Specifies the state of the policy, whether it is enabled or disabled or a policy has not been applied yet on the specific database.")
  state: SecurityAlertPolicyState;

  @doc("Specifies an array of alerts that are disabled. Allowed values are: Sql_Injection, Sql_Injection_Vulnerability, Access_Anomaly, Data_Exfiltration, Unsafe_Action, Brute_Force")
  disabledAlerts?: string[];

  @doc("Specifies an array of e-mail addresses to which the alert is sent.")
  emailAddresses?: string[];

  @doc("Specifies that the alert is sent to the account administrators.")
  @projectedName("json", "emailAccountAdmins")
  sendToEmailAccountAdmins?: boolean;

  @doc("Specifies the blob storage endpoint (e.g. https://MyAccount.blob.core.windows.net). This blob storage will hold all Threat Detection audit logs.")
  storageEndpoint?: string;

  @doc("Specifies the identifier key of the Threat Detection audit storage account.")
  storageAccountAccessKey?: string;

  @doc("Specifies the number of days to keep in the Threat Detection audit logs.")
  retentionDays?: int32;

  @doc("Specifies the UTC creation time of the policy.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  creationTime?: utcDateTime;
}

@doc("A list of security events.")
model SecurityEventCollection is Azure.Core.Page<SecurityEvent>;

@doc("A security event.")
model SecurityEvent extends ProxyResource {
  @doc("Resource properties.")
  properties?: SecurityEventProperties;
}

@doc("The properties of a security event.")
model SecurityEventProperties {
  @doc("The time when the security event occurred.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  eventTime?: utcDateTime;

  @doc("The type of the security event.")
  @visibility("read")
  securityEventType?: SecurityEventType;

  @doc("The subscription name")
  @visibility("read")
  subscription?: string;

  @doc("The server name")
  @visibility("read")
  server?: string;

  @doc("The database name")
  @visibility("read")
  database?: string;

  @doc("The IP address of the client who executed the statement.")
  @visibility("read")
  clientIp?: string;

  @doc("The application used to execute the statement.")
  @visibility("read")
  applicationName?: string;

  @doc("The principal user who executed the statement")
  @visibility("read")
  principalName?: string;

  @doc("The sql injection additional properties, populated only if the type of the security event is sql injection.")
  @visibility("read")
  securityEventSqlInjectionAdditionalProperties?: SecurityEventSqlInjectionAdditionalProperties;
}

@doc("The properties of a security event sql injection additional properties.")
model SecurityEventSqlInjectionAdditionalProperties {
  @doc("The threat ID.")
  @visibility("read")
  threatId?: string;

  @doc("The statement")
  @visibility("read")
  statement?: string;

  @doc("The statement highlight offset")
  @visibility("read")
  statementHighlightOffset?: int32;

  @doc("The statement highlight length")
  @visibility("read")
  statementHighlightLength?: int32;

  @doc("The sql error code")
  @visibility("read")
  errorCode?: int32;

  @doc("The sql error severity")
  @visibility("read")
  errorSeverity?: int32;

  @doc("The sql error message")
  @visibility("read")
  errorMessage?: string;
}

@doc("Properties of a transparent data encryption.")
model ManagedTransparentDataEncryptionProperties {
  @doc("Specifies the state of the transparent data encryption.")
  state: TransparentDataEncryptionState;
}

@doc("The properties of a managed instance administrator.")
model ManagedInstanceAdministratorProperties {
  @doc("Type of the managed instance administrator.")
  administratorType: ManagedInstanceAdministratorType;

  @doc("Login name of the managed instance administrator.")
  login: string;

  @doc("SID (object ID) of the managed instance administrator.")
  sid: string;

  @doc("Tenant ID of the managed instance administrator.")
  tenantId?: string;
}

@doc("Properties of a active directory only authentication for Managed Instance.")
model ManagedInstanceAzureADOnlyAuthProperties {
  @doc("Azure Active Directory only Authentication enabled.")
  azureADOnlyAuthentication: boolean;
}

@doc("Properties for an encryption protector execution.")
model ManagedInstanceEncryptionProtectorProperties {
  @doc("The name of the managed instance key.")
  serverKeyName?: string;

  @doc("The encryption protector type like 'ServiceManaged', 'AzureKeyVault'.")
  serverKeyType: ServerKeyType;

  @doc("The URI of the server key.")
  @visibility("read")
  uri?: string;

  @doc("Thumbprint of the server key.")
  @visibility("read")
  thumbprint?: string;

  @doc("Key auto rotation opt-in flag. Either true or false.")
  @projectedName("json", "autoRotationEnabled")
  IsAutoRotationEnabled?: boolean;
}

@doc("Properties for a key execution.")
model ManagedInstanceKeyProperties {
  @doc("The key type like 'ServiceManaged', 'AzureKeyVault'.")
  @visibility("create")
  serverKeyType: ServerKeyType;

  @doc("The URI of the key. If the ServerKeyType is AzureKeyVault, then the URI is required.")
  @visibility("create")
  uri?: string;

  @doc("Thumbprint of the key.")
  @visibility("read")
  thumbprint?: string;

  @doc("The key creation date.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  creationDate?: utcDateTime;

  @doc("Key auto rotation opt-in flag. Either true or false.")
  @visibility("read")
  @projectedName("json", "autoRotationEnabled")
  IsAutoRotationEnabled?: boolean;
}

@doc("The properties of a managed instance operation.")
model ManagedInstanceOperationProperties {
  @doc("The name of the managed instance the operation is being performed on.")
  @visibility("read")
  managedInstanceName?: string;

  @doc("The name of operation.")
  @visibility("read")
  operation?: string;

  @doc("The friendly name of operation.")
  @visibility("read")
  operationFriendlyName?: string;

  @doc("The percentage of the operation completed.")
  @visibility("read")
  percentComplete?: int32;

  @doc("The operation start time.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startTime?: utcDateTime;

  @doc("The operation state.")
  @visibility("read")
  state?: ManagementOperationState;

  @doc("The operation error code.")
  @visibility("read")
  errorCode?: int32;

  @doc("The operation error description.")
  @visibility("read")
  errorDescription?: string;

  @doc("The operation error severity.")
  @visibility("read")
  errorSeverity?: int32;

  @doc("Whether or not the error is a user error.")
  @visibility("read")
  isUserError?: boolean;

  @doc("The estimated completion time of the operation.")
  @visibility("read")
  @projectedName("json", "estimatedCompletionTime")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  estimatedCompleteOn?: utcDateTime;

  @doc("The operation description.")
  @visibility("read")
  description?: string;

  @doc("Whether the operation can be cancelled.")
  @visibility("read")
  isCancellable?: boolean;

  @doc("The operation parameters.")
  @visibility("read")
  operationParameters?: ManagedInstanceOperationParametersPair;

  @doc("The operation steps.")
  @visibility("read")
  operationSteps?: ManagedInstanceOperationSteps;
}

@doc("The parameters of a managed instance operation.")
model ManagedInstanceOperationParametersPair {
  @doc("The current parameters.")
  @visibility("read")
  currentParameters?: UpsertManagedServerOperationParameters;

  @doc("The requested parameters.")
  @visibility("read")
  requestedParameters?: UpsertManagedServerOperationParameters;
}

model UpsertManagedServerOperationParameters {
  family?: string;
  tier?: string;
  vCores?: int32;
  storageSizeInGB?: int32;
}

@doc("The steps of a managed instance operation.")
model ManagedInstanceOperationSteps {
  @doc("The total number of operation steps.")
  @visibility("read")
  totalSteps?: string;

  @doc("The number of current operation steps.")
  @visibility("read")
  currentStep?: int32;

  @doc("The operation steps list.")
  @visibility("read")
  stepsList?: UpsertManagedServerOperationStep[];
}

model UpsertManagedServerOperationStep {
  order?: int32;
  name?: string;
  status?: UpsertManagedServerOperationStepStatus;
}

@doc("Properties of a private endpoint connection.")
model ManagedInstancePrivateEndpointConnectionProperties {
  @doc("Private endpoint which the connection belongs to.")
  privateEndpoint?: ManagedInstancePrivateEndpointProperty;

  @doc("Connection State of the Private Endpoint Connection.")
  privateLinkServiceConnectionState?: ManagedInstancePrivateLinkServiceConnectionStateProperty;

  @doc("State of the Private Endpoint Connection.")
  @visibility("read")
  provisioningState?: string;
}

model ManagedInstancePrivateEndpointProperty {
  @doc("Resource id of the private endpoint.")
  id?: string;
}

model ManagedInstancePrivateLinkServiceConnectionStateProperty {
  @doc("The private link service connection status.")
  status: string;

  @doc("The private link service connection description.")
  description: string;

  @doc("The private link service connection description.")
  @visibility("read")
  actionsRequired?: string;
}

@doc("Properties of a private link resource.")
model ManagedInstancePrivateLinkProperties {
  @doc("The private link resource group id.")
  @visibility("read")
  groupId?: string;

  @doc("The private link resource required member names.")
  @visibility("read")
  requiredMembers?: string[];
}

@doc("A TDE certificate that can be uploaded into a server.")
model TdeCertificate extends ProxyResource {
  @doc("Resource properties.")
  properties?: TdeCertificateProperties;
}

@doc("Properties of a TDE certificate.")
model TdeCertificateProperties {
  @doc("The base64 encoded certificate private blob.")
  @visibility("create", "update")
  privateBlob: string;

  @doc("The certificate password.")
  @visibility("create", "update")
  certPassword?: string;
}

@doc("Properties of a managed instance vulnerability assessment.")
model ManagedInstanceVulnerabilityAssessmentProperties {
  @doc("A blob storage container path to hold the scan results (e.g. https://myStorage.blob.core.windows.net/VaScans/).")
  @visibility("create", "update")
  storageContainerPath: string;

  @doc("A shared access signature (SAS Key) that has write access to the blob container specified in 'storageContainerPath' parameter. If 'storageAccountAccessKey' isn't specified, StorageContainerSasKey is required. Applies only if the storage account is not behind a Vnet or a firewall")
  @visibility("create", "update")
  storageContainerSasKey?: string;

  @doc("Specifies the identifier key of the storage account for vulnerability assessment scan results. If 'StorageContainerSasKey' isn't specified, storageAccountAccessKey is required. Applies only if the storage account is not behind a Vnet or a firewall")
  @visibility("create", "update")
  storageAccountAccessKey?: string;

  @doc("The recurring scans settings")
  recurringScans?: VulnerabilityAssessmentRecurringScansProperties;
}

@doc("Properties of a private endpoint connection.")
model PrivateEndpointConnectionProperties {
  @doc("Private endpoint which the connection belongs to.")
  privateEndpoint?: PrivateEndpointProperty;

  @doc("Group IDs.")
  @visibility("read")
  groupIds?: string[];

  @doc("Connection state of the private endpoint connection.")
  privateLinkServiceConnectionState?: PrivateLinkServiceConnectionStateProperty;

  @doc("State of the private endpoint connection.")
  @visibility("read")
  provisioningState?: PrivateEndpointProvisioningState;
}

model PrivateEndpointProperty {
  @doc("Resource id of the private endpoint.")
  id?: string;
}

model PrivateLinkServiceConnectionStateProperty {
  @doc("The private link service connection status.")
  status: PrivateLinkServiceConnectionStateStatus;

  @doc("The private link service connection description.")
  description: string;

  @doc("The actions required for private link service connection.")
  @visibility("read")
  actionsRequired?: PrivateLinkServiceConnectionStateActionsRequire;
}

@doc("Properties of a private link resource.")
model PrivateLinkResourceProperties {
  @doc("The private link resource group id.")
  @visibility("read")
  groupId?: string;

  @doc("The private link resource required member names.")
  @visibility("read")
  requiredMembers?: string[];

  @doc("The private link resource required zone names.")
  @visibility("read")
  requiredZoneNames?: string[];
}

@doc("The recoverable managed database's properties.")
model RecoverableManagedDatabaseProperties {
  @doc("The last available backup date.")
  @visibility("read")
  lastAvailableBackupDate?: string;
}

@doc("Properties of a database restore point")
model RestorePointProperties {
  @doc("The type of restore point")
  @visibility("read")
  restorePointType?: RestorePointType;

  @doc("The earliest time to which this database can be restored")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  earliestRestoreDate?: utcDateTime;

  @doc("The time the backup was taken")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  restorePointCreationDate?: utcDateTime;

  @doc("The label of restore point for backup request by user")
  @visibility("read")
  restorePointLabel?: string;
}

@doc("Contains the information necessary to perform a create database restore point operation.")
model CreateDatabaseRestorePointDefinition {
  @doc("The restore point label to apply")
  restorePointLabel: string;
}

@doc("Server-level Automatic Tuning properties.")
model AutomaticTuningServerProperties {
  @doc("Automatic tuning desired state.")
  desiredState?: AutomaticTuningServerMode;

  @doc("Automatic tuning actual state.")
  @visibility("read")
  actualState?: AutomaticTuningServerMode;

  @doc("Automatic tuning options definition.")
  options?: Record<AutomaticTuningServerOptions>;
}

@doc("Automatic tuning properties for individual advisors.")
model AutomaticTuningServerOptions {
  @doc("Automatic tuning option desired state.")
  desiredState?: AutomaticTuningOptionModeDesired;

  @doc("Automatic tuning option actual state.")
  @visibility("read")
  actualState?: AutomaticTuningOptionModeActual;

  @doc("Reason code if desired and actual state are different.")
  @visibility("read")
  reasonCode?: int32;

  @doc("Reason description if desired and actual state are different.")
  @visibility("read")
  reasonDesc?: AutomaticTuningServerReason;
}

@doc("Properties of a active directory administrator.")
model AdministratorProperties {
  @doc("Type of the sever administrator.")
  administratorType: AdministratorType;

  @doc("Login name of the server administrator.")
  login: string;

  @doc("SID (object ID) of the server administrator.")
  sid: string;

  @doc("Tenant ID of the administrator.")
  tenantId?: string;

  @doc("Azure Active Directory only Authentication enabled.")
  @visibility("read")
  azureADOnlyAuthentication?: boolean;
}

@doc("Properties of a active directory only authentication.")
model AzureADOnlyAuthProperties {
  @doc("Azure Active Directory only Authentication enabled.")
  azureADOnlyAuthentication: boolean;
}

@doc("Properties of a server DevOps audit settings.")
model ServerDevOpsAuditSettingsProperties {
  @doc("""
Specifies whether DevOps audit events are sent to Azure Monitor. 
In order to send the events to Azure Monitor, specify 'State' as 'Enabled' and 'IsAzureMonitorTargetEnabled' as true.

When using REST API to configure DevOps audit, Diagnostic Settings with 'DevOpsOperationsAudit' diagnostic logs category on the master database should be also created.

Diagnostic Settings URI format:
PUT https://management.azure.com/subscriptions/{subscriptionId}/resourceGroups/{resourceGroup}/providers/Microsoft.Sql/servers/{serverName}/databases/master/providers/microsoft.insights/diagnosticSettings/{settingsName}?api-version=2017-05-01-preview

For more information, see [Diagnostic Settings REST API](https://go.microsoft.com/fwlink/?linkid=2033207)
or [Diagnostic Settings PowerShell](https://go.microsoft.com/fwlink/?linkid=2033043)

""")
  isAzureMonitorTargetEnabled?: boolean;

  @doc("Specifies whether Managed Identity is used to access blob storage")
  isManagedIdentityInUse?: boolean;

  @doc("Specifies the state of the audit. If state is Enabled, storageEndpoint or isAzureMonitorTargetEnabled are required.")
  state: BlobAuditingPolicyState;

  @doc("Specifies the blob storage endpoint (e.g. https://MyAccount.blob.core.windows.net). If state is Enabled, storageEndpoint or isAzureMonitorTargetEnabled is required.")
  storageEndpoint?: string;

  @doc("""
Specifies the identifier key of the auditing storage account. 
If state is Enabled and storageEndpoint is specified, not specifying the storageAccountAccessKey will use SQL server system-assigned managed identity to access the storage.
Prerequisites for using managed identity authentication:
1. Assign SQL Server a system-assigned managed identity in Azure Active Directory (AAD).
2. Grant SQL Server identity access to the storage account by adding 'Storage Blob Data Contributor' RBAC role to the server identity.
For more information, see [Auditing to storage using Managed Identity authentication](https://go.microsoft.com/fwlink/?linkid=2114355)
""")
  @visibility("create", "update")
  storageAccountAccessKey?: string;

  @doc("Specifies the blob storage subscription Id.")
  storageAccountSubscriptionId?: string;
}

@doc("Properties of a server DNS alias.")
model ServerDnsAliasProperties {
  @doc("The fully qualified DNS record for alias")
  @visibility("read")
  azureDnsRecord?: string;
}

@doc("A server dns alias acquisition request.")
model ServerDnsAliasAcquisition {
  @doc("The id of the server alias that will be acquired to point to this server instead.")
  oldServerDnsAliasId: string;
}

@doc("Properties for a server key execution.")
model ServerKeyProperties {
  @doc("Subregion of the server key.")
  @visibility("read")
  subregion?: string;

  @doc("The server key type like 'ServiceManaged', 'AzureKeyVault'.")
  @visibility("create")
  serverKeyType: ServerKeyType;

  @doc("The URI of the server key. If the ServerKeyType is AzureKeyVault, then the URI is required.")
  @visibility("create")
  uri?: string;

  @doc("Thumbprint of the server key.")
  @visibility("read")
  thumbprint?: string;

  @doc("The server key creation date.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  creationDate?: utcDateTime;

  @doc("Key auto rotation opt-in flag. Either true or false.")
  @visibility("read")
  @projectedName("json", "autoRotationEnabled")
  IsAutoRotationEnabled?: boolean;
}

@doc("The response to a list server operations request")
model ServerOperationListResult is Azure.Core.Page<ServerOperation>;

@doc("A server operation.")
model ServerOperation extends ProxyResource {
  @doc("Resource properties.")
  properties?: ServerOperationProperties;
}

@doc("The properties of a server operation.")
model ServerOperationProperties {
  @doc("The name of operation.")
  @visibility("read")
  operation?: string;

  @doc("The friendly name of operation.")
  @visibility("read")
  operationFriendlyName?: string;

  @doc("The percentage of the operation completed.")
  @visibility("read")
  percentComplete?: int32;

  @doc("The name of the server.")
  @visibility("read")
  serverName?: string;

  @doc("The operation start time.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startTime?: utcDateTime;

  @doc("The operation state.")
  @visibility("read")
  state?: ManagementOperationState;

  @doc("The operation error code.")
  @visibility("read")
  errorCode?: int32;

  @doc("The operation error description.")
  @visibility("read")
  errorDescription?: string;

  @doc("The operation error severity.")
  @visibility("read")
  errorSeverity?: int32;

  @doc("Whether or not the error is a user error.")
  @visibility("read")
  isUserError?: boolean;

  @doc("The estimated completion time of the operation.")
  @visibility("read")
  @projectedName("json", "estimatedCompletionTime")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  estimatedCompleteOn?: utcDateTime;

  @doc("The operation description.")
  @visibility("read")
  description?: string;

  @doc("Whether the operation can be cancelled.")
  @visibility("read")
  isCancellable?: boolean;
}

@doc("Properties of a server trust group.")
model ServerTrustGroupProperties {
  @doc("Group members information for the server trust group.")
  groupMembers: ServerInfo[];

  @doc("Trust scope of the server trust group.")
  trustScopes: ServerTrustGroupPropertiesTrustScopesItem[];
}

@doc("Server info for the server trust group.")
model ServerInfo {
  @doc("Server Id.")
  serverId: string;
}

@doc("Properties of a server Vulnerability Assessment.")
model ServerVulnerabilityAssessmentProperties {
  @doc("A blob storage container path to hold the scan results (e.g. https://myStorage.blob.core.windows.net/VaScans/).")
  @visibility("create", "update")
  storageContainerPath: string;

  @doc("A shared access signature (SAS Key) that has write access to the blob container specified in 'storageContainerPath' parameter. If 'storageAccountAccessKey' isn't specified, StorageContainerSasKey is required. Applies only if the storage account is not behind a Vnet or a firewall")
  @visibility("create", "update")
  storageContainerSasKey?: string;

  @doc("Specifies the identifier key of the storage account for vulnerability assessment scan results. If 'StorageContainerSasKey' isn't specified, storageAccountAccessKey is required. Applies only if the storage account is not behind a Vnet or a firewall")
  @visibility("create", "update")
  storageAccountAccessKey?: string;

  @doc("The recurring scans settings")
  recurringScans?: VulnerabilityAssessmentRecurringScansProperties;
}

@doc("Sql agent configuration properties.")
model SqlAgentConfigurationProperties {
  @doc("The state of Sql Agent.")
  state?: SqlAgentConfigurationPropertiesState;
}

@doc("Properties of a subscription usage.")
model SubscriptionUsageProperties {
  @doc("User-readable name of the metric.")
  @visibility("read")
  displayName?: string;

  @doc("Current value of the metric.")
  @visibility("read")
  currentValue?: float32;

  @doc("Boundary value of the metric.")
  @visibility("read")
  limit?: float32;

  @doc("Unit of the metric.")
  @visibility("read")
  unit?: string;
}

@doc("Properties of an Azure SQL Database sync agent.")
model SyncAgentProperties {
  @doc("ARM resource id of the sync database in the sync agent.")
  syncDatabaseId?: string;

  @doc("Last alive time of the sync agent.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastAliveTime?: utcDateTime;

  @doc("State of the sync agent.")
  @visibility("read")
  state?: SyncAgentState;

  @doc("If the sync agent version is up to date.")
  @visibility("read")
  isUpToDate?: boolean;

  @doc("Expiration time of the sync agent version.")
  @visibility("read")
  @projectedName("json", "expiryTime")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  expireOn?: utcDateTime;

  @doc("Version of the sync agent.")
  @visibility("read")
  version?: string;
}

@doc("Properties of an Azure SQL Database sync agent key.")
model SyncAgentKeyProperties {
  @doc("Key of sync agent.")
  @visibility("read")
  syncAgentKey?: string;
}

@doc("A list of sync agent linked databases.")
model SyncAgentLinkedDatabaseListResult
  is Azure.Core.Page<SyncAgentLinkedDatabase>;

@doc("An Azure SQL Database sync agent linked database.")
model SyncAgentLinkedDatabase extends ProxyResource {
  @doc("Resource properties.")
  properties?: SyncAgentLinkedDatabaseProperties;
}

@doc("Properties of an Azure SQL Database sync agent linked database.")
model SyncAgentLinkedDatabaseProperties {
  @doc("Type of the sync agent linked database.")
  @visibility("read")
  databaseType?: SyncMemberDbType;

  @doc("Id of the sync agent linked database.")
  @visibility("read")
  databaseId?: string;

  @doc("Description of the sync agent linked database.")
  @visibility("read")
  description?: string;

  @doc("Server name of the sync agent linked database.")
  @visibility("read")
  serverName?: string;

  @doc("Database name of the sync agent linked database.")
  @visibility("read")
  databaseName?: string;

  @doc("User name of the sync agent linked database.")
  @visibility("read")
  userName?: string;
}

@doc("Properties of the sync database id.")
model SyncDatabaseIdProperties {
  @doc("ARM resource id of sync database.")
  @visibility("read")
  id?: string;
}

@doc("A list of sync schema properties.")
model SyncFullSchemaPropertiesListResult
  is Azure.Core.Page<SyncFullSchemaProperties>;

@doc("Properties of the database full schema.")
model SyncFullSchemaProperties {
  @doc("List of tables in the database full schema.")
  @visibility("read")
  tables?: SyncFullSchemaTable[];

  @doc("Last update time of the database schema.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastUpdateTime?: utcDateTime;
}

@doc("Properties of the table in the database full schema.")
model SyncFullSchemaTable {
  @doc("List of columns in the table of database full schema.")
  @visibility("read")
  columns?: SyncFullSchemaTableColumn[];

  @doc("Error id of the table.")
  @visibility("read")
  errorId?: string;

  @doc("If there is error in the table.")
  @visibility("read")
  hasError?: boolean;

  @doc("Name of the table.")
  @visibility("read")
  name?: string;

  @doc("Quoted name of the table.")
  @visibility("read")
  quotedName?: string;
}

@doc("Properties of the column in the table of database full schema.")
model SyncFullSchemaTableColumn {
  @doc("Data size of the column.")
  @visibility("read")
  dataSize?: string;

  @doc("Data type of the column.")
  @visibility("read")
  dataType?: string;

  @doc("Error id of the column.")
  @visibility("read")
  errorId?: string;

  @doc("If there is error in the table.")
  @visibility("read")
  hasError?: boolean;

  @doc("If it is the primary key of the table.")
  @visibility("read")
  isPrimaryKey?: boolean;

  @doc("Name of the column.")
  @visibility("read")
  name?: string;

  @doc("Quoted name of the column.")
  @visibility("read")
  quotedName?: string;
}

@doc("A list of sync group log properties.")
model SyncGroupLogListResult is Azure.Core.Page<SyncGroupLogProperties>;

@doc("Properties of an Azure SQL Database sync group log.")
model SyncGroupLogProperties {
  @doc("Timestamp of the sync group log.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  timestamp?: utcDateTime;

  @doc("Type of the sync group log.")
  @visibility("read")
  type?: SyncGroupLogType;

  @doc("Source of the sync group log.")
  @visibility("read")
  source?: string;

  @doc("Details of the sync group log.")
  @visibility("read")
  details?: string;

  @doc("TracingId of the sync group log.")
  @visibility("read")
  tracingId?: string;

  @doc("OperationStatus of the sync group log.")
  @visibility("read")
  operationStatus?: string;
}

@doc("Properties of a sync group.")
model SyncGroupProperties {
  @doc("Sync interval of the sync group.")
  interval?: int32;

  @doc("Last sync time of the sync group.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastSyncTime?: utcDateTime;

  @doc("Conflict resolution policy of the sync group.")
  conflictResolutionPolicy?: SyncConflictResolutionPolicy;

  @doc("ARM resource id of the sync database in the sync group.")
  syncDatabaseId?: string;

  @doc("User name for the sync group hub database credential.")
  hubDatabaseUserName?: string;

  @doc("Password for the sync group hub database credential.")
  @visibility("create", "update")
  hubDatabasePassword?: string;

  @doc("Sync state of the sync group.")
  @visibility("read")
  syncState?: SyncGroupState;

  @doc("Sync schema of the sync group.")
  schema?: SyncGroupSchema;

  @doc("If conflict logging is enabled.")
  enableConflictLogging?: boolean;

  @doc("Conflict logging retention period.")
  conflictLoggingRetentionInDays?: int32;

  @doc("If use private link connection is enabled.")
  usePrivateLinkConnection?: boolean;

  @doc("Private endpoint name of the sync group if use private link connection is enabled.")
  @visibility("read")
  privateEndpointName?: string;
}

@doc("Properties of sync group schema.")
model SyncGroupSchema {
  @doc("List of tables in sync group schema.")
  tables?: SyncGroupSchemaTable[];

  @doc("Name of master sync member where the schema is from.")
  masterSyncMemberName?: string;
}

@doc("Properties of table in sync group schema.")
model SyncGroupSchemaTable {
  @doc("List of columns in sync group schema.")
  columns?: SyncGroupSchemaTableColumn[];

  @doc("Quoted name of sync group schema table.")
  quotedName?: string;
}

@doc("Properties of column in sync group table.")
model SyncGroupSchemaTableColumn {
  @doc("Quoted name of sync group table column.")
  quotedName?: string;

  @doc("Data size of the column.")
  dataSize?: string;

  @doc("Data type of the column.")
  dataType?: string;
}

@doc("Properties of a sync member.")
model SyncMemberProperties {
  @doc("Database type of the sync member.")
  databaseType?: SyncMemberDbType;

  @doc("ARM resource id of the sync agent in the sync member.")
  syncAgentId?: string;

  @doc("SQL Server database id of the sync member.")
  sqlServerDatabaseId?: string;

  @doc("ARM resource id of the sync member logical database, for sync members in Azure.")
  syncMemberAzureDatabaseResourceId?: string;

  @doc("Whether to use private link connection.")
  usePrivateLinkConnection?: boolean;

  @doc("Private endpoint name of the sync member if use private link connection is enabled, for sync members in Azure.")
  @visibility("read")
  privateEndpointName?: string;

  @doc("Server name of the member database in the sync member")
  serverName?: string;

  @doc("Database name of the member database in the sync member.")
  databaseName?: string;

  @doc("User name of the member database in the sync member.")
  userName?: string;

  @doc("Password of the member database in the sync member.")
  @visibility("create", "update")
  password?: string;

  @doc("Sync direction of the sync member.")
  syncDirection?: SyncDirection;

  @doc("Sync state of the sync member.")
  @visibility("read")
  syncState?: SyncMemberState;
}

@doc("The properties of a time zone.")
model TimeZoneProperties {
  @doc("The time zone id")
  @visibility("read")
  timeZoneId?: string;

  @doc("The time zone display name")
  @visibility("read")
  displayName?: string;
}

@doc("Properties of a virtual network rule.")
model VirtualNetworkRuleProperties {
  @doc("The ARM resource id of the virtual network subnet.")
  virtualNetworkSubnetId: string;

  @doc("Create firewall rule before the virtual network has vnet service endpoint enabled.")
  ignoreMissingVnetServiceEndpoint?: boolean;

  @doc("Virtual Network Rule State")
  @visibility("read")
  state?: VirtualNetworkRuleState;
}

@doc("Workload classifier definition. For more information look at sys.workload_management_workload_classifiers (DMV).")
model WorkloadClassifierProperties {
  @doc("The workload classifier member name.")
  memberName: string;

  @doc("The workload classifier label.")
  label?: string;

  @doc("The workload classifier context.")
  context?: string;

  @doc("The workload classifier start time for classification.")
  startTime?: string;

  @doc("The workload classifier end time for classification.")
  endTime?: string;

  @doc("The workload classifier importance.")
  importance?: string;
}

@doc("Workload group definition. For more information look at sys.workload_management_workload_groups (DMV).")
model WorkloadGroupProperties {
  @doc("The workload group minimum percentage resource.")
  minResourcePercent: int32;

  @doc("The workload group cap percentage resource.")
  maxResourcePercent: int32;

  @doc("The workload group request minimum grant percentage.")
  minResourcePercentPerRequest: float32;

  @doc("The workload group request maximum grant percentage.")
  maxResourcePercentPerRequest?: float32;

  @doc("The workload group importance level.")
  importance?: string;

  @doc("The workload group query execution timeout.")
  queryExecutionTimeout?: int32;
}

@doc("Properties of a short term retention policy")
model BackupShortTermRetentionPolicyProperties {
  @doc("The backup retention period in days. This is how many days Point-in-Time Restore will be supported.")
  retentionDays?: int32;

  @doc("The differential backup interval in hours. This is how many interval hours between each differential backup will be supported. This is only applicable to live databases but not dropped databases.")
  diffBackupIntervalInHours?: DiffBackupIntervalInHours;
}

@doc("An export managed database operation result resource.")
model DatabaseExtensions extends ProxyResource {
  @doc("Resource properties.")
  properties?: DatabaseExtensionsProperties;
}

@doc("Contains the database information after successful export.")
model DatabaseExtensionsProperties {
  @doc("Operation Mode.")
  @visibility("create")
  operationMode: OperationMode;

  @doc("Storage key type.")
  @visibility("create")
  storageKeyType: StorageKeyType;

  @doc("Storage key.")
  @visibility("create")
  storageKey: string;

  @doc("Storage Uri.")
  @visibility("create")
  storageUri: string;
}

@doc("An Extension operation result resource.")
model ImportExportExtensionsOperationResult extends ProxyResource {
  @doc("Resource properties.")
  properties?: ImportExportExtensionsOperationResultProperties;
}

@doc("Contains the operation result properties for import/export operation.")
model ImportExportExtensionsOperationResultProperties {
  @doc("Request Id.")
  @visibility("read")
  requestId?: string;

  @doc("Request type.")
  @visibility("read")
  requestType?: string;

  @doc("Last modified time.")
  @visibility("read")
  lastModifiedTime?: string;

  @doc("Server name.")
  @visibility("read")
  serverName?: string;

  @doc("Database name.")
  @visibility("read")
  databaseName?: string;

  @doc("Operation status.")
  @visibility("read")
  status?: string;

  @doc("Error message.")
  @visibility("read")
  errorMessage?: string;
}

@doc("Import export operation extensions list.")
model ImportExportExtensionsOperationListResult
  is Azure.Core.Page<ImportExportExtensionsOperationResult>;

@doc("The response to a list database operations request")
model DatabaseOperationListResult is Azure.Core.Page<DatabaseOperation>;

@doc("A database operation.")
model DatabaseOperation extends ProxyResource {
  @doc("Resource properties.")
  properties?: DatabaseOperationProperties;
}

@doc("The properties of a database operation.")
model DatabaseOperationProperties {
  @doc("The name of the database the operation is being performed on.")
  @visibility("read")
  databaseName?: string;

  @doc("The name of operation.")
  @visibility("read")
  operation?: string;

  @doc("The friendly name of operation.")
  @visibility("read")
  operationFriendlyName?: string;

  @doc("The percentage of the operation completed.")
  @visibility("read")
  percentComplete?: int32;

  @doc("The name of the server.")
  @visibility("read")
  serverName?: string;

  @doc("The operation start time.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startTime?: utcDateTime;

  @doc("The operation state.")
  @visibility("read")
  state?: ManagementOperationState;

  @doc("The operation error code.")
  @visibility("read")
  errorCode?: int32;

  @doc("The operation error description.")
  @visibility("read")
  errorDescription?: string;

  @doc("The operation error severity.")
  @visibility("read")
  errorSeverity?: int32;

  @doc("Whether or not the error is a user error.")
  @visibility("read")
  isUserError?: boolean;

  @doc("The estimated completion time of the operation.")
  @visibility("read")
  @projectedName("json", "estimatedCompletionTime")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  estimatedCompleteOn?: utcDateTime;

  @doc("The operation description.")
  @visibility("read")
  description?: string;

  @doc("Whether the operation can be cancelled.")
  @visibility("read")
  isCancellable?: boolean;
}

@doc("A list of database usage metrics.")
model DatabaseUsageListResult is Azure.Core.Page<DatabaseUsage>;

@doc("Usage metric of a database.")
model DatabaseUsage extends ProxyResource {
  @doc("Resource properties.")
  properties?: DatabaseUsageProperties;
}

@doc("Properties of a database usage.")
model DatabaseUsageProperties {
  @doc("User-readable name of the metric.")
  @visibility("read")
  displayName?: string;

  @doc("Current value of the metric.")
  @visibility("read")
  currentValue?: float32;

  @doc("Boundary value of the metric.")
  @visibility("read")
  limit?: float32;

  @doc("Unit of the metric.")
  @visibility("read")
  unit?: string;
}

@doc("The properties of a database ledger digest upload settings.")
model LedgerDigestUploadsProperties {
  @doc("The digest storage endpoint, which must be either an Azure blob storage endpoint or an URI for Azure Confidential Ledger.")
  digestStorageEndpoint?: string;

  @doc("Specifies the state of ledger digest upload.")
  @visibility("read")
  state?: LedgerDigestUploadsState;
}

@doc("The properties of an outbound firewall rule.")
model OutboundFirewallRuleProperties {
  @doc("The state of the outbound rule.")
  @visibility("read")
  provisioningState?: string;
}

@doc("A list of usages.")
model UsageListResult is Azure.Core.Page<Usage>;

@doc("ARM usage.")
model Usage {
  @doc("Resource ID.")
  @visibility("read")
  id?: string;

  @doc("Resource name.")
  @visibility("read")
  name?: Name;

  @doc("Resource type.")
  @visibility("read")
  type?: string;

  @doc("Usage unit.")
  @visibility("read")
  unit?: string;

  @doc("Usage current value.")
  @visibility("read")
  currentValue?: int32;

  @doc("Usage limit.")
  @visibility("read")
  limit?: int32;

  @doc("Usage requested limit.")
  @visibility("read")
  requestedLimit?: int32;
}

@doc("ARM Usage Name")
model Name {
  @doc("Usage name value")
  value?: string;

  @doc("Usage name localized value.")
  localizedValue?: string;
}

@doc("Contains the information necessary to perform long term retention backup copy operation.")
model CopyLongTermRetentionBackupParameters {
  @doc("Resource properties.")
  properties?: CopyLongTermRetentionBackupParametersProperties;
}

@doc("Contains the properties to perform long term retention backup copy operation.")
model CopyLongTermRetentionBackupParametersProperties {
  @doc("The subscription that owns the target server")
  @visibility("create")
  targetSubscriptionId?: string;

  @doc("The resource group that owns the target server")
  @visibility("create")
  targetResourceGroup?: string;

  @doc("The resource Id of the target server that owns the database")
  @visibility("create")
  targetServerResourceId?: string;

  @doc("The fully qualified domain name of the target server")
  @visibility("create")
  targetServerFullyQualifiedDomainName?: string;

  @doc("The name of the database owns the copied backup.")
  @visibility("create")
  targetDatabaseName?: string;

  @doc("The storage redundancy type of the copied backup")
  @visibility("create")
  targetBackupStorageRedundancy?: BackupStorageRedundancy;
}

@doc("A LongTermRetentionBackup operation result resource.")
model LongTermRetentionBackupOperationResult extends ProxyResource {
  @doc("Resource properties.")
  properties?: LongTermRetentionOperationResultProperties;
}

@doc("Contains the operation result properties for long term retention backup operation.")
model LongTermRetentionOperationResultProperties {
  @doc("Request Id.")
  @visibility("read")
  requestId?: string;

  @doc("Operation type.")
  @visibility("read")
  operationType?: string;

  @doc("Source backup resource id")
  @visibility("read")
  fromBackupResourceId?: string;

  @doc("Target backup resource id")
  @visibility("read")
  toBackupResourceId?: string;

  @doc("The storage redundancy type of the copied backup")
  @visibility("read")
  targetBackupStorageRedundancy?: BackupStorageRedundancy;

  @doc("Operation status")
  @visibility("read")
  status?: string;

  @doc("Progress message")
  @visibility("read")
  message?: string;
}

@doc("Contains the information necessary to perform long term retention backup update operation.")
model UpdateLongTermRetentionBackupParameters {
  @doc("Resource properties.")
  properties?: UpdateLongTermRetentionBackupParametersProperties;
}

@doc("Contains the properties to perform long term retention backup copy operation.")
model UpdateLongTermRetentionBackupParametersProperties {
  @doc("The storage redundancy type of the copied backup")
  @visibility("create")
  requestedBackupStorageRedundancy?: BackupStorageRedundancy;
}

@doc("Properties of a long term retention backup")
model LongTermRetentionBackupProperties {
  @doc("The server name that the backup database belong to.")
  @visibility("read")
  serverName?: string;

  @doc("The create time of the server.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  serverCreateTime?: utcDateTime;

  @doc("The name of the database the backup belong to")
  @visibility("read")
  databaseName?: string;

  @doc("The delete time of the database")
  @visibility("read")
  @projectedName("json", "databaseDeletionTime")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  databaseDeletedOn?: utcDateTime;

  @doc("The time the backup was taken")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  backupTime?: utcDateTime;

  @doc("The time the long term retention backup will expire.")
  @visibility("read")
  @projectedName("json", "backupExpirationTime")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  backupExpireOn?: utcDateTime;

  @doc("The storage redundancy type of the backup")
  @visibility("read")
  backupStorageRedundancy?: BackupStorageRedundancy;

  @doc("The storage redundancy type of the backup")
  @visibility("create", "update")
  requestedBackupStorageRedundancy?: BackupStorageRedundancy;
}

@doc("Properties of a long term retention backup")
model ManagedInstanceLongTermRetentionBackupProperties {
  @doc("The managed instance that the backup database belongs to.")
  @visibility("read")
  managedInstanceName?: string;

  @doc("The create time of the instance.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  managedInstanceCreateTime?: utcDateTime;

  @doc("The name of the database the backup belong to")
  @visibility("read")
  databaseName?: string;

  @doc("The delete time of the database")
  @visibility("read")
  @projectedName("json", "databaseDeletionTime")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  databaseDeletedOn?: utcDateTime;

  @doc("The time the backup was taken")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  backupTime?: utcDateTime;

  @doc("The time the long term retention backup will expire.")
  @visibility("read")
  @projectedName("json", "backupExpirationTime")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  backupExpireOn?: utcDateTime;

  @doc("The storage redundancy type of the backup")
  @visibility("read")
  backupStorageRedundancy?: BackupStorageRedundancy;
}

@doc("The restorable dropped managed database's properties.")
model RestorableDroppedManagedDatabaseProperties {
  @doc("The name of the database.")
  @visibility("read")
  databaseName?: string;

  @doc("The creation date of the database (ISO8601 format).")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  creationDate?: utcDateTime;

  @doc("The deletion date of the database (ISO8601 format).")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  deletionDate?: utcDateTime;

  @doc("The earliest restore date of the database (ISO8601 format).")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  earliestRestoreDate?: utcDateTime;
}

@doc("The properties of a server connection policy.")
model ServerConnectionPolicyProperties {
  @doc("The server connection type.")
  connectionType: ServerConnectionType;
}

@doc("The properties of a distributed availability group.")
model DistributedAvailabilityGroupProperties {
  @doc("The name of the target database")
  targetDatabase?: string;

  @doc("The source endpoint")
  sourceEndpoint?: string;

  @doc("The primary availability group name")
  primaryAvailabilityGroupName?: string;

  @doc("The secondary availability group name")
  secondaryAvailabilityGroupName?: string;

  @doc("The replication mode of a distributed availability group. Parameter will be ignored during link creation.")
  replicationMode?: ReplicationMode;

  @doc("The distributed availability group id")
  @visibility("read")
  distributedAvailabilityGroupId?: string;

  @doc("The source replica id")
  @visibility("read")
  sourceReplicaId?: string;

  @doc("The target replica id")
  @visibility("read")
  targetReplicaId?: string;

  @doc("The link state")
  @visibility("read")
  linkState?: string;

  @doc("The last hardened lsn")
  @visibility("read")
  lastHardenedLsn?: string;
}

@doc("The properties of a server trust certificate.")
model ServerTrustCertificateProperties {
  @doc("The certificate public blob")
  publicBlob?: string;

  @doc("The certificate thumbprint")
  @visibility("read")
  thumbprint?: string;

  @doc("The certificate name")
  @visibility("read")
  certificateName?: string;
}

@doc("The properties of an endpoint certificate.")
model EndpointCertificateProperties {
  @doc("The certificate public blob")
  publicBlob?: string;
}

@doc("Properties of a sensitivity label.")
model SensitivityLabelProperties {
  @doc("The schema name.")
  @visibility("read")
  schemaName?: string;

  @doc("The table name.")
  @visibility("read")
  tableName?: string;

  @doc("The column name.")
  @visibility("read")
  columnName?: string;

  @doc("The label name.")
  labelName?: string;

  @doc("The label ID.")
  labelId?: string;

  @doc("The information type.")
  informationType?: string;

  @doc("The information type ID.")
  informationTypeId?: string;

  @doc("Is sensitivity recommendation disabled. Applicable for recommended sensitivity label only. Specifies whether the sensitivity recommendation on this column is disabled (dismissed) or not.")
  @visibility("read")
  isDisabled?: boolean;

  rank?: SensitivityLabelRank;
}

@doc("A list of sensitivity labels.")
model SensitivityLabelListResult is Azure.Core.Page<SensitivityLabel>;

@doc("A list of sensitivity label update operations.")
model SensitivityLabelUpdateList {
  operations?: SensitivityLabelUpdate[];
}

@doc("A sensitivity label update operation.")
model SensitivityLabelUpdate extends ProxyResource {
  @doc("Resource properties.")
  properties?: SensitivityLabelUpdateProperties;
}

@doc("Properties of an operation executed on a sensitivity label.")
model SensitivityLabelUpdateProperties {
  `op`: SensitivityLabelUpdateKind;

  @doc("Schema name of the column to update.")
  schema: string;

  @doc("Table name of the column to update.")
  table: string;

  @doc("Column name to update.")
  column: string;

  @doc("The sensitivity label information to apply on a column.")
  sensitivityLabel?: SensitivityLabel;
}

@doc("A list of recommended sensitivity label update operations.")
model RecommendedSensitivityLabelUpdateList {
  operations?: RecommendedSensitivityLabelUpdate[];
}

@doc("A recommended sensitivity label update operation.")
model RecommendedSensitivityLabelUpdate extends ProxyResource {
  @doc("Resource properties.")
  properties?: RecommendedSensitivityLabelUpdateProperties;
}

@doc("Properties of an operation executed on a recommended sensitivity label.")
model RecommendedSensitivityLabelUpdateProperties {
  `op`: RecommendedSensitivityLabelUpdateKind;

  @doc("Schema name of the column to update.")
  schema: string;

  @doc("Table name of the column to update.")
  table: string;

  @doc("Column name to update.")
  column: string;
}

@doc("Properties of a server blob auditing policy.")
model ServerBlobAuditingPolicyProperties {
  @doc("""
Specifies the state of devops audit. If state is Enabled, devops logs will be sent to Azure Monitor.
In order to send the events to Azure Monitor, specify 'State' as 'Enabled', 'IsAzureMonitorTargetEnabled' as true and 'IsDevopsAuditEnabled' as true

When using REST API to configure auditing, Diagnostic Settings with 'DevOpsOperationsAudit' diagnostic logs category on the master database should also be created.

Diagnostic Settings URI format:
PUT https://management.azure.com/subscriptions/{subscriptionId}/resourceGroups/{resourceGroup}/providers/Microsoft.Sql/servers/{serverName}/databases/master/providers/microsoft.insights/diagnosticSettings/{settingsName}?api-version=2017-05-01-preview

For more information, see [Diagnostic Settings REST API](https://go.microsoft.com/fwlink/?linkid=2033207)
or [Diagnostic Settings PowerShell](https://go.microsoft.com/fwlink/?linkid=2033043)

""")
  isDevopsAuditEnabled?: boolean;

  @doc("Specifies the number of days to keep in the audit logs in the storage account.")
  retentionDays?: int32;

  @doc("""
Specifies the Actions-Groups and Actions to audit.

The recommended set of action groups to use is the following combination - this will audit all the queries and stored procedures executed against the database, as well as successful and failed logins:

BATCH_COMPLETED_GROUP,
SUCCESSFUL_DATABASE_AUTHENTICATION_GROUP,
FAILED_DATABASE_AUTHENTICATION_GROUP.

This above combination is also the set that is configured by default when enabling auditing from the Azure portal.

The supported action groups to audit are (note: choose only specific groups that cover your auditing needs. Using unnecessary groups could lead to very large quantities of audit records):

APPLICATION_ROLE_CHANGE_PASSWORD_GROUP
BACKUP_RESTORE_GROUP
DATABASE_LOGOUT_GROUP
DATABASE_OBJECT_CHANGE_GROUP
DATABASE_OBJECT_OWNERSHIP_CHANGE_GROUP
DATABASE_OBJECT_PERMISSION_CHANGE_GROUP
DATABASE_OPERATION_GROUP
DATABASE_PERMISSION_CHANGE_GROUP
DATABASE_PRINCIPAL_CHANGE_GROUP
DATABASE_PRINCIPAL_IMPERSONATION_GROUP
DATABASE_ROLE_MEMBER_CHANGE_GROUP
FAILED_DATABASE_AUTHENTICATION_GROUP
SCHEMA_OBJECT_ACCESS_GROUP
SCHEMA_OBJECT_CHANGE_GROUP
SCHEMA_OBJECT_OWNERSHIP_CHANGE_GROUP
SCHEMA_OBJECT_PERMISSION_CHANGE_GROUP
SUCCESSFUL_DATABASE_AUTHENTICATION_GROUP
USER_CHANGE_PASSWORD_GROUP
BATCH_STARTED_GROUP
BATCH_COMPLETED_GROUP
DBCC_GROUP
DATABASE_OWNERSHIP_CHANGE_GROUP
DATABASE_CHANGE_GROUP
LEDGER_OPERATION_GROUP

These are groups that cover all sql statements and stored procedures executed against the database, and should not be used in combination with other groups as this will result in duplicate audit logs.

For more information, see [Database-Level Audit Action Groups](https://docs.microsoft.com/en-us/sql/relational-databases/security/auditing/sql-server-audit-action-groups-and-actions#database-level-audit-action-groups).

For Database auditing policy, specific Actions can also be specified (note that Actions cannot be specified for Server auditing policy). The supported actions to audit are:
SELECT
UPDATE
INSERT
DELETE
EXECUTE
RECEIVE
REFERENCES

The general form for defining an action to be audited is:
{action} ON {object} BY {principal}

Note that <object> in the above format can refer to an object like a table, view, or stored procedure, or an entire database or schema. For the latter cases, the forms DATABASE::{db_name} and SCHEMA::{schema_name} are used, respectively.

For example:
SELECT on dbo.myTable by public
SELECT on DATABASE::myDatabase by public
SELECT on SCHEMA::mySchema by public

For more information, see [Database-Level Audit Actions](https://docs.microsoft.com/en-us/sql/relational-databases/security/auditing/sql-server-audit-action-groups-and-actions#database-level-audit-actions)
""")
  auditActionsAndGroups?: string[];

  @doc("Specifies whether storageAccountAccessKey value is the storage's secondary key.")
  isStorageSecondaryKeyInUse?: boolean;

  @doc("""
Specifies whether audit events are sent to Azure Monitor. 
In order to send the events to Azure Monitor, specify 'State' as 'Enabled' and 'IsAzureMonitorTargetEnabled' as true.

When using REST API to configure auditing, Diagnostic Settings with 'SQLSecurityAuditEvents' diagnostic logs category on the database should be also created.
Note that for server level audit you should use the 'master' database as {databaseName}.

Diagnostic Settings URI format:
PUT https://management.azure.com/subscriptions/{subscriptionId}/resourceGroups/{resourceGroup}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/providers/microsoft.insights/diagnosticSettings/{settingsName}?api-version=2017-05-01-preview

For more information, see [Diagnostic Settings REST API](https://go.microsoft.com/fwlink/?linkid=2033207)
or [Diagnostic Settings PowerShell](https://go.microsoft.com/fwlink/?linkid=2033043)

""")
  isAzureMonitorTargetEnabled?: boolean;

  @doc("""
Specifies the amount of time in milliseconds that can elapse before audit actions are forced to be processed.
The default minimum value is 1000 (1 second). The maximum is 2,147,483,647.
""")
  queueDelayMs?: int32;

  @doc("Specifies whether Managed Identity is used to access blob storage")
  isManagedIdentityInUse?: boolean;

  @doc("Specifies the state of the audit. If state is Enabled, storageEndpoint or isAzureMonitorTargetEnabled are required.")
  state: BlobAuditingPolicyState;

  @doc("Specifies the blob storage endpoint (e.g. https://MyAccount.blob.core.windows.net). If state is Enabled, storageEndpoint or isAzureMonitorTargetEnabled is required.")
  storageEndpoint?: string;

  @doc("""
Specifies the identifier key of the auditing storage account. 
If state is Enabled and storageEndpoint is specified, not specifying the storageAccountAccessKey will use SQL server system-assigned managed identity to access the storage.
Prerequisites for using managed identity authentication:
1. Assign SQL Server a system-assigned managed identity in Azure Active Directory (AAD).
2. Grant SQL Server identity access to the storage account by adding 'Storage Blob Data Contributor' RBAC role to the server identity.
For more information, see [Auditing to storage using Managed Identity authentication](https://go.microsoft.com/fwlink/?linkid=2114355)
""")
  @visibility("create", "update")
  storageAccountAccessKey?: string;

  @doc("Specifies the blob storage subscription Id.")
  storageAccountSubscriptionId?: string;
}

@doc("Properties of a database blob auditing policy.")
model DatabaseBlobAuditingPolicyProperties {
  @doc("Specifies the number of days to keep in the audit logs in the storage account.")
  retentionDays?: int32;

  @doc("""
Specifies the Actions-Groups and Actions to audit.

The recommended set of action groups to use is the following combination - this will audit all the queries and stored procedures executed against the database, as well as successful and failed logins:

BATCH_COMPLETED_GROUP,
SUCCESSFUL_DATABASE_AUTHENTICATION_GROUP,
FAILED_DATABASE_AUTHENTICATION_GROUP.

This above combination is also the set that is configured by default when enabling auditing from the Azure portal.

The supported action groups to audit are (note: choose only specific groups that cover your auditing needs. Using unnecessary groups could lead to very large quantities of audit records):

APPLICATION_ROLE_CHANGE_PASSWORD_GROUP
BACKUP_RESTORE_GROUP
DATABASE_LOGOUT_GROUP
DATABASE_OBJECT_CHANGE_GROUP
DATABASE_OBJECT_OWNERSHIP_CHANGE_GROUP
DATABASE_OBJECT_PERMISSION_CHANGE_GROUP
DATABASE_OPERATION_GROUP
DATABASE_PERMISSION_CHANGE_GROUP
DATABASE_PRINCIPAL_CHANGE_GROUP
DATABASE_PRINCIPAL_IMPERSONATION_GROUP
DATABASE_ROLE_MEMBER_CHANGE_GROUP
FAILED_DATABASE_AUTHENTICATION_GROUP
SCHEMA_OBJECT_ACCESS_GROUP
SCHEMA_OBJECT_CHANGE_GROUP
SCHEMA_OBJECT_OWNERSHIP_CHANGE_GROUP
SCHEMA_OBJECT_PERMISSION_CHANGE_GROUP
SUCCESSFUL_DATABASE_AUTHENTICATION_GROUP
USER_CHANGE_PASSWORD_GROUP
BATCH_STARTED_GROUP
BATCH_COMPLETED_GROUP
DBCC_GROUP
DATABASE_OWNERSHIP_CHANGE_GROUP
DATABASE_CHANGE_GROUP
LEDGER_OPERATION_GROUP

These are groups that cover all sql statements and stored procedures executed against the database, and should not be used in combination with other groups as this will result in duplicate audit logs.

For more information, see [Database-Level Audit Action Groups](https://docs.microsoft.com/en-us/sql/relational-databases/security/auditing/sql-server-audit-action-groups-and-actions#database-level-audit-action-groups).

For Database auditing policy, specific Actions can also be specified (note that Actions cannot be specified for Server auditing policy). The supported actions to audit are:
SELECT
UPDATE
INSERT
DELETE
EXECUTE
RECEIVE
REFERENCES

The general form for defining an action to be audited is:
{action} ON {object} BY {principal}

Note that <object> in the above format can refer to an object like a table, view, or stored procedure, or an entire database or schema. For the latter cases, the forms DATABASE::{db_name} and SCHEMA::{schema_name} are used, respectively.

For example:
SELECT on dbo.myTable by public
SELECT on DATABASE::myDatabase by public
SELECT on SCHEMA::mySchema by public

For more information, see [Database-Level Audit Actions](https://docs.microsoft.com/en-us/sql/relational-databases/security/auditing/sql-server-audit-action-groups-and-actions#database-level-audit-actions)
""")
  auditActionsAndGroups?: string[];

  @doc("Specifies whether storageAccountAccessKey value is the storage's secondary key.")
  isStorageSecondaryKeyInUse?: boolean;

  @doc("""
Specifies whether audit events are sent to Azure Monitor. 
In order to send the events to Azure Monitor, specify 'State' as 'Enabled' and 'IsAzureMonitorTargetEnabled' as true.

When using REST API to configure auditing, Diagnostic Settings with 'SQLSecurityAuditEvents' diagnostic logs category on the database should be also created.
Note that for server level audit you should use the 'master' database as {databaseName}.

Diagnostic Settings URI format:
PUT https://management.azure.com/subscriptions/{subscriptionId}/resourceGroups/{resourceGroup}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/providers/microsoft.insights/diagnosticSettings/{settingsName}?api-version=2017-05-01-preview

For more information, see [Diagnostic Settings REST API](https://go.microsoft.com/fwlink/?linkid=2033207)
or [Diagnostic Settings PowerShell](https://go.microsoft.com/fwlink/?linkid=2033043)

""")
  isAzureMonitorTargetEnabled?: boolean;

  @doc("""
Specifies the amount of time in milliseconds that can elapse before audit actions are forced to be processed.
The default minimum value is 1000 (1 second). The maximum is 2,147,483,647.
""")
  queueDelayMs?: int32;

  @doc("Specifies whether Managed Identity is used to access blob storage")
  isManagedIdentityInUse?: boolean;

  @doc("Specifies the state of the audit. If state is Enabled, storageEndpoint or isAzureMonitorTargetEnabled are required.")
  state: BlobAuditingPolicyState;

  @doc("Specifies the blob storage endpoint (e.g. https://MyAccount.blob.core.windows.net). If state is Enabled, storageEndpoint or isAzureMonitorTargetEnabled is required.")
  storageEndpoint?: string;

  @doc("""
Specifies the identifier key of the auditing storage account. 
If state is Enabled and storageEndpoint is specified, not specifying the storageAccountAccessKey will use SQL server system-assigned managed identity to access the storage.
Prerequisites for using managed identity authentication:
1. Assign SQL Server a system-assigned managed identity in Azure Active Directory (AAD).
2. Grant SQL Server identity access to the storage account by adding 'Storage Blob Data Contributor' RBAC role to the server identity.
For more information, see [Auditing to storage using Managed Identity authentication](https://go.microsoft.com/fwlink/?linkid=2114355)
""")
  @visibility("create", "update")
  storageAccountAccessKey?: string;

  @doc("Specifies the blob storage subscription Id.")
  storageAccountSubscriptionId?: string;
}

@doc("Properties of an extended database blob auditing policy.")
model ExtendedDatabaseBlobAuditingPolicyProperties {
  @doc("Specifies condition of where clause when creating an audit.")
  predicateExpression?: string;

  @doc("Specifies the number of days to keep in the audit logs in the storage account.")
  retentionDays?: int32;

  @doc("""
Specifies the Actions-Groups and Actions to audit.

The recommended set of action groups to use is the following combination - this will audit all the queries and stored procedures executed against the database, as well as successful and failed logins:

BATCH_COMPLETED_GROUP,
SUCCESSFUL_DATABASE_AUTHENTICATION_GROUP,
FAILED_DATABASE_AUTHENTICATION_GROUP.

This above combination is also the set that is configured by default when enabling auditing from the Azure portal.

The supported action groups to audit are (note: choose only specific groups that cover your auditing needs. Using unnecessary groups could lead to very large quantities of audit records):

APPLICATION_ROLE_CHANGE_PASSWORD_GROUP
BACKUP_RESTORE_GROUP
DATABASE_LOGOUT_GROUP
DATABASE_OBJECT_CHANGE_GROUP
DATABASE_OBJECT_OWNERSHIP_CHANGE_GROUP
DATABASE_OBJECT_PERMISSION_CHANGE_GROUP
DATABASE_OPERATION_GROUP
DATABASE_PERMISSION_CHANGE_GROUP
DATABASE_PRINCIPAL_CHANGE_GROUP
DATABASE_PRINCIPAL_IMPERSONATION_GROUP
DATABASE_ROLE_MEMBER_CHANGE_GROUP
FAILED_DATABASE_AUTHENTICATION_GROUP
SCHEMA_OBJECT_ACCESS_GROUP
SCHEMA_OBJECT_CHANGE_GROUP
SCHEMA_OBJECT_OWNERSHIP_CHANGE_GROUP
SCHEMA_OBJECT_PERMISSION_CHANGE_GROUP
SUCCESSFUL_DATABASE_AUTHENTICATION_GROUP
USER_CHANGE_PASSWORD_GROUP
BATCH_STARTED_GROUP
BATCH_COMPLETED_GROUP
DBCC_GROUP
DATABASE_OWNERSHIP_CHANGE_GROUP
DATABASE_CHANGE_GROUP
LEDGER_OPERATION_GROUP

These are groups that cover all sql statements and stored procedures executed against the database, and should not be used in combination with other groups as this will result in duplicate audit logs.

For more information, see [Database-Level Audit Action Groups](https://docs.microsoft.com/en-us/sql/relational-databases/security/auditing/sql-server-audit-action-groups-and-actions#database-level-audit-action-groups).

For Database auditing policy, specific Actions can also be specified (note that Actions cannot be specified for Server auditing policy). The supported actions to audit are:
SELECT
UPDATE
INSERT
DELETE
EXECUTE
RECEIVE
REFERENCES

The general form for defining an action to be audited is:
{action} ON {object} BY {principal}

Note that <object> in the above format can refer to an object like a table, view, or stored procedure, or an entire database or schema. For the latter cases, the forms DATABASE::{db_name} and SCHEMA::{schema_name} are used, respectively.

For example:
SELECT on dbo.myTable by public
SELECT on DATABASE::myDatabase by public
SELECT on SCHEMA::mySchema by public

For more information, see [Database-Level Audit Actions](https://docs.microsoft.com/en-us/sql/relational-databases/security/auditing/sql-server-audit-action-groups-and-actions#database-level-audit-actions)
""")
  auditActionsAndGroups?: string[];

  @doc("Specifies whether storageAccountAccessKey value is the storage's secondary key.")
  isStorageSecondaryKeyInUse?: boolean;

  @doc("""
Specifies whether audit events are sent to Azure Monitor. 
In order to send the events to Azure Monitor, specify 'State' as 'Enabled' and 'IsAzureMonitorTargetEnabled' as true.

When using REST API to configure auditing, Diagnostic Settings with 'SQLSecurityAuditEvents' diagnostic logs category on the database should be also created.
Note that for server level audit you should use the 'master' database as {databaseName}.

Diagnostic Settings URI format:
PUT https://management.azure.com/subscriptions/{subscriptionId}/resourceGroups/{resourceGroup}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/providers/microsoft.insights/diagnosticSettings/{settingsName}?api-version=2017-05-01-preview

For more information, see [Diagnostic Settings REST API](https://go.microsoft.com/fwlink/?linkid=2033207)
or [Diagnostic Settings PowerShell](https://go.microsoft.com/fwlink/?linkid=2033043)

""")
  isAzureMonitorTargetEnabled?: boolean;

  @doc("""
Specifies the amount of time in milliseconds that can elapse before audit actions are forced to be processed.
The default minimum value is 1000 (1 second). The maximum is 2,147,483,647.
""")
  queueDelayMs?: int32;

  @doc("Specifies whether Managed Identity is used to access blob storage")
  isManagedIdentityInUse?: boolean;

  @doc("Specifies the state of the audit. If state is Enabled, storageEndpoint or isAzureMonitorTargetEnabled are required.")
  state: BlobAuditingPolicyState;

  @doc("Specifies the blob storage endpoint (e.g. https://MyAccount.blob.core.windows.net). If state is Enabled, storageEndpoint or isAzureMonitorTargetEnabled is required.")
  storageEndpoint?: string;

  @doc("""
Specifies the identifier key of the auditing storage account. 
If state is Enabled and storageEndpoint is specified, not specifying the storageAccountAccessKey will use SQL server system-assigned managed identity to access the storage.
Prerequisites for using managed identity authentication:
1. Assign SQL Server a system-assigned managed identity in Azure Active Directory (AAD).
2. Grant SQL Server identity access to the storage account by adding 'Storage Blob Data Contributor' RBAC role to the server identity.
For more information, see [Auditing to storage using Managed Identity authentication](https://go.microsoft.com/fwlink/?linkid=2114355)
""")
  @visibility("create", "update")
  storageAccountAccessKey?: string;

  @doc("Specifies the blob storage subscription Id.")
  storageAccountSubscriptionId?: string;
}

@doc("Properties of an extended server blob auditing policy.")
model ExtendedServerBlobAuditingPolicyProperties {
  @doc("""
Specifies the state of devops audit. If state is Enabled, devops logs will be sent to Azure Monitor.
In order to send the events to Azure Monitor, specify 'State' as 'Enabled', 'IsAzureMonitorTargetEnabled' as true and 'IsDevopsAuditEnabled' as true

When using REST API to configure auditing, Diagnostic Settings with 'DevOpsOperationsAudit' diagnostic logs category on the master database should also be created.

Diagnostic Settings URI format:
PUT https://management.azure.com/subscriptions/{subscriptionId}/resourceGroups/{resourceGroup}/providers/Microsoft.Sql/servers/{serverName}/databases/master/providers/microsoft.insights/diagnosticSettings/{settingsName}?api-version=2017-05-01-preview

For more information, see [Diagnostic Settings REST API](https://go.microsoft.com/fwlink/?linkid=2033207)
or [Diagnostic Settings PowerShell](https://go.microsoft.com/fwlink/?linkid=2033043)

""")
  isDevopsAuditEnabled?: boolean;

  @doc("Specifies condition of where clause when creating an audit.")
  predicateExpression?: string;

  @doc("Specifies the number of days to keep in the audit logs in the storage account.")
  retentionDays?: int32;

  @doc("""
Specifies the Actions-Groups and Actions to audit.

The recommended set of action groups to use is the following combination - this will audit all the queries and stored procedures executed against the database, as well as successful and failed logins:

BATCH_COMPLETED_GROUP,
SUCCESSFUL_DATABASE_AUTHENTICATION_GROUP,
FAILED_DATABASE_AUTHENTICATION_GROUP.

This above combination is also the set that is configured by default when enabling auditing from the Azure portal.

The supported action groups to audit are (note: choose only specific groups that cover your auditing needs. Using unnecessary groups could lead to very large quantities of audit records):

APPLICATION_ROLE_CHANGE_PASSWORD_GROUP
BACKUP_RESTORE_GROUP
DATABASE_LOGOUT_GROUP
DATABASE_OBJECT_CHANGE_GROUP
DATABASE_OBJECT_OWNERSHIP_CHANGE_GROUP
DATABASE_OBJECT_PERMISSION_CHANGE_GROUP
DATABASE_OPERATION_GROUP
DATABASE_PERMISSION_CHANGE_GROUP
DATABASE_PRINCIPAL_CHANGE_GROUP
DATABASE_PRINCIPAL_IMPERSONATION_GROUP
DATABASE_ROLE_MEMBER_CHANGE_GROUP
FAILED_DATABASE_AUTHENTICATION_GROUP
SCHEMA_OBJECT_ACCESS_GROUP
SCHEMA_OBJECT_CHANGE_GROUP
SCHEMA_OBJECT_OWNERSHIP_CHANGE_GROUP
SCHEMA_OBJECT_PERMISSION_CHANGE_GROUP
SUCCESSFUL_DATABASE_AUTHENTICATION_GROUP
USER_CHANGE_PASSWORD_GROUP
BATCH_STARTED_GROUP
BATCH_COMPLETED_GROUP
DBCC_GROUP
DATABASE_OWNERSHIP_CHANGE_GROUP
DATABASE_CHANGE_GROUP
LEDGER_OPERATION_GROUP

These are groups that cover all sql statements and stored procedures executed against the database, and should not be used in combination with other groups as this will result in duplicate audit logs.

For more information, see [Database-Level Audit Action Groups](https://docs.microsoft.com/en-us/sql/relational-databases/security/auditing/sql-server-audit-action-groups-and-actions#database-level-audit-action-groups).

For Database auditing policy, specific Actions can also be specified (note that Actions cannot be specified for Server auditing policy). The supported actions to audit are:
SELECT
UPDATE
INSERT
DELETE
EXECUTE
RECEIVE
REFERENCES

The general form for defining an action to be audited is:
{action} ON {object} BY {principal}

Note that <object> in the above format can refer to an object like a table, view, or stored procedure, or an entire database or schema. For the latter cases, the forms DATABASE::{db_name} and SCHEMA::{schema_name} are used, respectively.

For example:
SELECT on dbo.myTable by public
SELECT on DATABASE::myDatabase by public
SELECT on SCHEMA::mySchema by public

For more information, see [Database-Level Audit Actions](https://docs.microsoft.com/en-us/sql/relational-databases/security/auditing/sql-server-audit-action-groups-and-actions#database-level-audit-actions)
""")
  auditActionsAndGroups?: string[];

  @doc("Specifies whether storageAccountAccessKey value is the storage's secondary key.")
  isStorageSecondaryKeyInUse?: boolean;

  @doc("""
Specifies whether audit events are sent to Azure Monitor. 
In order to send the events to Azure Monitor, specify 'State' as 'Enabled' and 'IsAzureMonitorTargetEnabled' as true.

When using REST API to configure auditing, Diagnostic Settings with 'SQLSecurityAuditEvents' diagnostic logs category on the database should be also created.
Note that for server level audit you should use the 'master' database as {databaseName}.

Diagnostic Settings URI format:
PUT https://management.azure.com/subscriptions/{subscriptionId}/resourceGroups/{resourceGroup}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/providers/microsoft.insights/diagnosticSettings/{settingsName}?api-version=2017-05-01-preview

For more information, see [Diagnostic Settings REST API](https://go.microsoft.com/fwlink/?linkid=2033207)
or [Diagnostic Settings PowerShell](https://go.microsoft.com/fwlink/?linkid=2033043)

""")
  isAzureMonitorTargetEnabled?: boolean;

  @doc("""
Specifies the amount of time in milliseconds that can elapse before audit actions are forced to be processed.
The default minimum value is 1000 (1 second). The maximum is 2,147,483,647.
""")
  queueDelayMs?: int32;

  @doc("Specifies whether Managed Identity is used to access blob storage")
  isManagedIdentityInUse?: boolean;

  @doc("Specifies the state of the audit. If state is Enabled, storageEndpoint or isAzureMonitorTargetEnabled are required.")
  state: BlobAuditingPolicyState;

  @doc("Specifies the blob storage endpoint (e.g. https://MyAccount.blob.core.windows.net). If state is Enabled, storageEndpoint or isAzureMonitorTargetEnabled is required.")
  storageEndpoint?: string;

  @doc("""
Specifies the identifier key of the auditing storage account. 
If state is Enabled and storageEndpoint is specified, not specifying the storageAccountAccessKey will use SQL server system-assigned managed identity to access the storage.
Prerequisites for using managed identity authentication:
1. Assign SQL Server a system-assigned managed identity in Azure Active Directory (AAD).
2. Grant SQL Server identity access to the storage account by adding 'Storage Blob Data Contributor' RBAC role to the server identity.
For more information, see [Auditing to storage using Managed Identity authentication](https://go.microsoft.com/fwlink/?linkid=2114355)
""")
  @visibility("create", "update")
  storageAccountAccessKey?: string;

  @doc("Specifies the blob storage subscription Id.")
  storageAccountSubscriptionId?: string;
}

@doc("Properties of an Advanced Threat Protection state.")
model AdvancedThreatProtectionProperties {
  @doc("Specifies the state of the Advanced Threat Protection, whether it is enabled or disabled or a state has not been applied yet on the specific database or server.")
  state: AdvancedThreatProtectionState;

  @doc("Specifies the UTC creation time of the policy.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  creationTime?: utcDateTime;
}

@doc("Properties of a managed server DNS alias.")
model ManagedServerDnsAliasProperties {
  @doc("The fully qualified DNS record for managed server alias")
  @visibility("read")
  azureDnsRecord?: string;

  @doc("The fully qualified public DNS record for managed server alias")
  @visibility("read")
  publicAzureDnsRecord?: string;
}

@doc("A managed server dns alias creation request.")
model ManagedServerDnsAliasCreation {
  @doc("Whether or not DNS record should be created for this alias.")
  createDnsRecord?: boolean;
}

@doc("A managed server DNS alias acquisition request.")
model ManagedServerDnsAliasAcquisition {
  @doc("The resource ID of the managed server DNS alias that will be acquired to point to this managed server instead.")
  oldManagedServerDnsAliasResourceId: string;
}

@doc("Properties of a replication link.")
model ReplicationLinkProperties {
  @doc("Resource partner server.")
  @visibility("read")
  partnerServer?: string;

  @doc("Resource partner database.")
  @visibility("read")
  partnerDatabase?: string;

  @doc("Resource partner location.")
  @visibility("read")
  partnerLocation?: string;

  @doc("Local replication role.")
  @visibility("read")
  role?: ReplicationRole;

  @doc("Partner replication role.")
  @visibility("read")
  partnerRole?: ReplicationRole;

  @doc("Replication mode.")
  @visibility("read")
  replicationMode?: string;

  @doc("Time at which the link was created.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startTime?: utcDateTime;

  @doc("Seeding completion percentage for the link.")
  @visibility("read")
  percentComplete?: int32;

  @doc("Replication state (PENDING, SEEDING, CATCHUP, SUSPENDED).")
  @visibility("read")
  replicationState?: ReplicationState;

  @doc("Whether the user is currently allowed to terminate the link.")
  @visibility("read")
  isTerminationAllowed?: boolean;

  @doc("Link type (GEO, NAMED, STANDBY).")
  @visibility("read")
  linkType?: ReplicationLinkType;
}

@doc("The properties of managed instance DTC.")
model ManagedInstanceDtcProperties {
  @doc("Active status of managed instance DTC.")
  dtcEnabled?: boolean;

  @doc("Security settings of managed instance DTC.")
  securitySettings?: ManagedInstanceDtcSecuritySettings;

  @doc("External dns suffix search list of managed instance DTC.")
  externalDnsSuffixSearchList?: string[];

  @doc("Host name dns suffix of managed instance DTC.")
  @visibility("read")
  dtcHostNameDnsSuffix?: string;

  @doc("Provisioning state of managed instance DTC.")
  @visibility("read")
  provisioningState?: ProvisioningState;
}

@doc("The Security Settings of managed instance DTC.")
model ManagedInstanceDtcSecuritySettings {
  @doc("Transaction Manager communication settings of managed instance DTC.")
  transactionManagerCommunicationSettings?: ManagedInstanceDtcTransactionManagerCommunicationSettings;

  @doc("Allow XA Transactions to managed instance DTC.")
  xaTransactionsEnabled?: boolean;

  @doc("Allow SNA LU 6.2 Transactions to managed instance DTC.")
  @projectedName("json", "snaLu6point2TransactionsEnabled")
  snaLu6Point2TransactionsEnabled?: boolean;

  @doc("Default timeout for XA Transactions (in seconds).")
  xaTransactionsDefaultTimeout?: int32;

  @doc("Maximum timeout for XA Transactions (in seconds).")
  xaTransactionsMaximumTimeout?: int32;
}

@doc("The Transaction Manager Communication Settings of managed instance DTC.")
model ManagedInstanceDtcTransactionManagerCommunicationSettings {
  @doc("Allow Inbound traffic to managed instance DTC.")
  allowInboundEnabled?: boolean;

  @doc("Allow Outbound traffic of managed instance DTC.")
  allowOutboundEnabled?: boolean;

  @doc("Authentication type of managed instance DTC.")
  authentication?: string;
}

@doc("A list of synapselink workspaces")
model SynapseLinkWorkspaceListResult is Azure.Core.Page<SynapseLinkWorkspace>;

@doc("Synapse link workspace resource")
model SynapseLinkWorkspace extends ProxyResource {
  @doc("Resource properties.")
  properties?: SynapseLinkWorkspaceProperties;
}

@doc("Properties of a Synapse link workspaces")
model SynapseLinkWorkspaceProperties {
  @doc("List of all synapselink workspaces")
  workspaces?: SynapseLinkWorkspaceInfoProperties[];
}

@doc("Properties of a Synapse link workspaces")
model SynapseLinkWorkspaceInfoProperties {
  @doc("Synapse link workspace id.")
  workspaceId?: string;

  @doc("Link connection name.")
  linkConnectionName?: string;
}

@doc("The properties of a virtual cluster.")
model VirtualClusterProperties {
  @doc("Subnet resource ID for the virtual cluster.")
  @visibility("read")
  subnetId?: string;

  @doc("Virtual cluster version.")
  version?: string;

  @doc("List of resources in this virtual cluster.")
  @visibility("read")
  childResources?: string[];
}

@doc("An update request for virtual cluster.")
model VirtualClusterUpdate {
  @doc("Resource properties.")
  properties?: VirtualClusterProperties;

  @doc("Resource tags.")
  tags?: Record<string>;
}

@doc("A refresh DNS servers operation.")
model UpdateVirtualClusterDnsServersOperation extends ProxyResource {
  @doc("Resource properties.")
  properties?: VirtualClusterDnsServersProperties;
}

@doc("The properties of dns servers on virtual cluster.")
model VirtualClusterDnsServersProperties {
  @doc("The status of the DNS refresh operation.")
  @visibility("read")
  status?: DNSRefreshOperationStatus;
}

@doc("Properties of a instance failover group.")
model InstanceFailoverGroupProperties {
  @doc("Type of the geo-secondary instance. Set 'Standby' if the instance is used as a DR option only.")
  secondaryType?: SecondaryInstanceType;

  @doc("Read-write endpoint of the failover group instance.")
  readWriteEndpoint: InstanceFailoverGroupReadWriteEndpoint;

  @doc("Read-only endpoint of the failover group instance.")
  readOnlyEndpoint?: InstanceFailoverGroupReadOnlyEndpoint;

  @doc("Local replication role of the failover group instance.")
  @visibility("read")
  replicationRole?: InstanceFailoverGroupReplicationRole;

  @doc("Replication state of the failover group instance.")
  @visibility("read")
  replicationState?: string;

  @doc("Partner region information for the failover group.")
  @visibility("read", "create")
  partnerRegions: PartnerRegionInfo[];

  @doc("List of managed instance pairs in the failover group.")
  managedInstancePairs: ManagedInstancePairInfo[];
}

@doc("Read-write endpoint of the failover group instance.")
model InstanceFailoverGroupReadWriteEndpoint {
  @doc("Failover policy of the read-write endpoint for the failover group. If failoverPolicy is Automatic then failoverWithDataLossGracePeriodMinutes is required.")
  failoverPolicy: ReadWriteEndpointFailoverPolicy;

  @doc("Grace period before failover with data loss is attempted for the read-write endpoint. If failoverPolicy is Automatic then failoverWithDataLossGracePeriodMinutes is required.")
  failoverWithDataLossGracePeriodMinutes?: int32;
}

@doc("Read-only endpoint of the failover group instance.")
model InstanceFailoverGroupReadOnlyEndpoint {
  @doc("Failover policy of the read-only endpoint for the failover group.")
  failoverPolicy?: ReadOnlyEndpointFailoverPolicy;
}

@doc("Partner region information for the failover group.")
model PartnerRegionInfo {
  @doc("Geo location of the partner managed instances.")
  location?: string;

  @doc("Replication role of the partner managed instances.")
  @visibility("read")
  replicationRole?: InstanceFailoverGroupReplicationRole;
}

@doc("Pairs of Managed Instances in the failover group.")
model ManagedInstancePairInfo {
  @doc("Id of Primary Managed Instance in pair.")
  primaryManagedInstanceId?: string;

  @doc("Id of Partner Managed Instance in pair.")
  partnerManagedInstanceId?: string;
}

@doc("The managed database's restore details properties.")
model ManagedDatabaseRestoreDetailsProperties {
  @doc("Restore type.")
  @visibility("read")
  type?: string;

  @doc("Restore status.")
  @visibility("read")
  status?: string;

  @doc("The reason why restore is in Blocked state.")
  @visibility("read")
  blockReason?: string;

  @doc("Last uploaded file name.")
  @visibility("read")
  lastUploadedFileName?: string;

  @doc("Last uploaded file time.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastUploadedFileTime?: utcDateTime;

  @doc("Last restored file name.")
  @visibility("read")
  lastRestoredFileName?: string;

  @doc("Last restored file time.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastRestoredFileTime?: utcDateTime;

  @doc("Percent completed.")
  @visibility("read")
  @projectedName("json", "percentCompleted")
  completedPercent?: int32;

  @doc("Current restored size MB.")
  @visibility("read")
  currentRestoredSizeMB?: int32;

  @doc("Current restore plan size MB.")
  @visibility("read")
  currentRestorePlanSizeMB?: int32;

  @doc("Current backup type.")
  @visibility("read")
  currentBackupType?: string;

  @doc("Current restoring file name.")
  @visibility("read")
  currentRestoringFileName?: string;

  @doc("Number of files detected.")
  @visibility("read")
  @projectedName("json", "numberOfFilesDetected")
  numberOfFilesFound?: int32;

  @doc("Number of files queued.")
  @visibility("read")
  numberOfFilesQueued?: int32;

  @doc("Number of files skipped.")
  @visibility("read")
  numberOfFilesSkipped?: int32;

  @doc("Number of files restoring.")
  @visibility("read")
  numberOfFilesRestoring?: int32;

  @doc("Number of files restored.")
  @visibility("read")
  numberOfFilesRestored?: int32;

  @doc("Number of files unrestorable.")
  @visibility("read")
  numberOfFilesUnrestorable?: int32;

  @doc("Full backup sets.")
  @visibility("read")
  fullBackupSets?: ManagedDatabaseRestoreDetailsBackupSetProperties[];

  @doc("Diff backup sets.")
  @visibility("read")
  diffBackupSets?: ManagedDatabaseRestoreDetailsBackupSetProperties[];

  @doc("Log backup sets.")
  @visibility("read")
  logBackupSets?: ManagedDatabaseRestoreDetailsBackupSetProperties[];

  @doc("Unrestorable files.")
  @visibility("read")
  @projectedName("json", "unrestorableFiles")
  unrestorableFileList?: ManagedDatabaseRestoreDetailsUnrestorableFileProperties[];
}

@doc("The managed database's restore details backup set properties.")
model ManagedDatabaseRestoreDetailsBackupSetProperties {
  @doc("Backup set status.")
  @visibility("read")
  status?: string;

  @doc("First stripe name.")
  @visibility("read")
  firstStripeName?: string;

  @doc("Number of stripes.")
  @visibility("read")
  numberOfStripes?: int32;

  @doc("Backup size.")
  @visibility("read")
  backupSizeMB?: int32;

  @doc("Last restored file time.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  restoreStartedTimestampUtc?: utcDateTime;

  @doc("Last restored file time.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  restoreFinishedTimestampUtc?: utcDateTime;
}

@doc("The managed database's restore details unrestorable file properties.")
model ManagedDatabaseRestoreDetailsUnrestorableFileProperties {
  @doc("File name.")
  @visibility("read")
  name?: string;
}

@doc("Azure Active Directory identity configuration for a resource.")
model DatabaseIdentity {
  @doc("The identity type")
  type?: DatabaseIdentityType;

  @doc("The Azure Active Directory tenant id.")
  @visibility("read")
  tenantId?: string;

  @doc("The resource ids of the user assigned identities to use")
  userAssignedIdentities?: Record<DatabaseUserIdentity>;
}

@doc("Azure Active Directory identity configuration for a resource.")
model DatabaseUserIdentity {
  @doc("The Azure Active Directory principal id.")
  @visibility("read")
  principalId?: string;

  @doc("The Azure Active Directory client id.")
  @visibility("read")
  clientId?: string;
}

@doc("The database's properties.")
model DatabaseProperties {
  @doc("""
Specifies the mode of database creation.

Default: regular database creation.

Copy: creates a database as a copy of an existing database. sourceDatabaseId must be specified as the resource ID of the source database.

Secondary: creates a database as a secondary replica of an existing database. sourceDatabaseId must be specified as the resource ID of the existing primary database.

PointInTimeRestore: Creates a database by restoring a point in time backup of an existing database. sourceDatabaseId must be specified as the resource ID of the existing database, and restorePointInTime must be specified.

Recovery: Creates a database by restoring a geo-replicated backup. sourceDatabaseId must be specified as the recoverable database resource ID to restore.

Restore: Creates a database by restoring a backup of a deleted database. sourceDatabaseId must be specified. If sourceDatabaseId is the database's original resource ID, then sourceDatabaseDeletionDate must be specified. Otherwise sourceDatabaseId must be the restorable dropped database resource ID and sourceDatabaseDeletionDate is ignored. restorePointInTime may also be specified to restore from an earlier point in time.

RestoreLongTermRetentionBackup: Creates a database by restoring from a long term retention vault. recoveryServicesRecoveryPointResourceId must be specified as the recovery point resource ID.

Copy, Secondary, and RestoreLongTermRetentionBackup are not supported for DataWarehouse edition.
""")
  @visibility("create")
  createMode?: CreateMode;

  @doc("The collation of the database.")
  @visibility("read", "create")
  collation?: string;

  @doc("The max size of the database expressed in bytes.")
  maxSizeBytes?: int32;

  @doc("The name of the sample schema to apply when creating this database.")
  @visibility("create")
  sampleName?: SampleName;

  @doc("The resource identifier of the elastic pool containing this database.")
  elasticPoolId?: ResourceIdentifier<[
    {
      type: "Microsoft.Sql/servers/elasticPools";
    }
  ]>;

  @doc("The resource identifier of the source database associated with create operation of this database.")
  @visibility("create")
  sourceDatabaseId?: ResourceIdentifier<[
    {
      type: "undefined";
    }
  ]>;

  @doc("The status of the database.")
  @visibility("read")
  status?: DatabaseStatus;

  @doc("The ID of the database.")
  @visibility("read")
  databaseId?: string;

  @doc("The creation date of the database (ISO8601 format).")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  creationDate?: utcDateTime;

  @doc("The current service level objective name of the database.")
  @visibility("read")
  currentServiceObjectiveName?: string;

  @doc("The requested service level objective name of the database.")
  @visibility("read")
  requestedServiceObjectiveName?: string;

  @doc("The default secondary region for this database.")
  @visibility("read")
  defaultSecondaryLocation?: string;

  @doc("Failover Group resource identifier that this database belongs to.")
  @visibility("read")
  failoverGroupId?: string;

  @doc("Specifies the point in time (ISO8601 format) of the source database that will be restored to create the new database.")
  @visibility("create")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  restorePointInTime?: utcDateTime;

  @doc("Specifies the time that the database was deleted.")
  @visibility("create")
  @projectedName("json", "sourceDatabaseDeletionDate")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  sourceDatabaseDeletedOn?: utcDateTime;

  @doc("The resource identifier of the recovery point associated with create operation of this database.")
  @visibility("create")
  recoveryServicesRecoveryPointId?: ResourceIdentifier<[
    {
      type: "undefined";
    }
  ]>;

  @doc("The resource identifier of the long term retention backup associated with create operation of this database.")
  @visibility("create")
  longTermRetentionBackupResourceId?: ResourceIdentifier<[
    {
      type: "Microsoft.Sql/locations/longTermRetentionBackups";
    }
  ]>;

  @doc("The resource identifier of the recoverable database associated with create operation of this database.")
  @visibility("create")
  recoverableDatabaseId?: ResourceIdentifier<[
    {
      type: "undefined";
    }
  ]>;

  @doc("The resource identifier of the restorable dropped database associated with create operation of this database.")
  @visibility("create")
  restorableDroppedDatabaseId?: ResourceIdentifier<[
    {
      type: "undefined";
    }
  ]>;

  @doc("Collation of the metadata catalog.")
  @visibility("read", "create")
  catalogCollation?: CatalogCollationType;

  @doc("Whether or not this database is zone redundant, which means the replicas of this database will be spread across multiple availability zones.")
  @projectedName("json", "zoneRedundant")
  IsZoneRedundant?: boolean;

  @doc("The license type to apply for this database. `LicenseIncluded` if you need a license, or `BasePrice` if you have a license and are eligible for the Azure Hybrid Benefit.")
  licenseType?: DatabaseLicenseType;

  @doc("The max log size for this database.")
  @visibility("read")
  maxLogSizeBytes?: int32;

  @doc("This records the earliest start date and time that restore is available for this database (ISO8601 format).")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  earliestRestoreDate?: utcDateTime;

  @doc("The state of read-only routing. If enabled, connections that have application intent set to readonly in their connection string may be routed to a readonly secondary replica in the same region. Not applicable to a Hyperscale database within an elastic pool.")
  @visibility("read", "update")
  readScale?: DatabaseReadScale;

  @doc("The number of secondary replicas associated with the database that are used to provide high availability. Not applicable to a Hyperscale database within an elastic pool.")
  highAvailabilityReplicaCount?: int32;

  @doc("The secondary type of the database if it is a secondary.  Valid values are Geo, Named and Standby.")
  secondaryType?: SecondaryType;

  @doc("The name and tier of the SKU.")
  @visibility("read")
  currentSku?: Sku;

  @doc("Time in minutes after which database is automatically paused. A value of -1 means that automatic pause is disabled")
  autoPauseDelay?: int32;

  @doc("The storage account type used to store backups for this database.")
  @visibility("read")
  currentBackupStorageRedundancy?: BackupStorageRedundancy;

  @doc("The storage account type to be used to store backups for this database.")
  requestedBackupStorageRedundancy?: BackupStorageRedundancy;

  @doc("Minimal capacity that database will always have allocated, if not paused")
  minCapacity?: float32;

  @doc("The date when database was paused by user configuration or action(ISO8601 format). Null if the database is ready.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  pausedDate?: utcDateTime;

  @doc("The date when database was resumed by user action or database login (ISO8601 format). Null if the database is paused.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  resumedDate?: utcDateTime;

  @doc("Maintenance configuration id assigned to the database. This configuration defines the period when the maintenance updates will occur.")
  maintenanceConfigurationId?: string;

  @doc("Whether or not this database is a ledger database, which means all tables in the database are ledger tables. Note: the value of this property cannot be changed after the database has been created.")
  isLedgerOn?: boolean;

  @doc("Infra encryption is enabled for this database.")
  @visibility("read")
  isInfraEncryptionEnabled?: boolean;

  @doc("The Client id used for cross tenant per database CMK scenario")
  federatedClientId?: string;

  @doc("The resource ids of the user assigned identities to use")
  keys?: Record<DatabaseKey>;

  @doc("The azure key vault URI of the database if it's configured with per Database Customer Managed Keys.")
  encryptionProtector?: string;

  @doc("Type of enclave requested on the database i.e. Default or VBS enclaves.")
  preferredEnclaveType?: AlwaysEncryptedEnclaveType;

  @doc("Whether or not the database uses free monthly limits. Allowed on one database in a subscription.")
  useFreeLimit?: boolean;

  @doc("""
Specifies the behavior when monthly free limits are exhausted for the free database.

AutoPause: The database will be auto paused upon exhaustion of free limits for remainder of the month.

BillForUsage: The database will continue to be online upon exhaustion of free limits and any overage will be billed.
""")
  freeLimitExhaustionBehavior?: FreeLimitExhaustionBehavior;

  @doc("""
The resource identifier of the source associated with the create operation of this database.

This property is only supported for DataWarehouse edition and allows to restore across subscriptions.

When sourceResourceId is specified, sourceDatabaseId, recoverableDatabaseId, restorableDroppedDatabaseId and sourceDatabaseDeletionDate must not be specified and CreateMode must be PointInTimeRestore, Restore or Recover.

When createMode is PointInTimeRestore, sourceResourceId must be the resource ID of the existing database or existing sql pool, and restorePointInTime must be specified.

When createMode is Restore, sourceResourceId must be the resource ID of restorable dropped database or restorable dropped sql pool.

When createMode is Recover, sourceResourceId must be the resource ID of recoverable database or recoverable sql pool.

When source subscription belongs to a different tenant than target subscription, “x-ms-authorization-auxiliary” header must contain authentication token for the source tenant. For more details about “x-ms-authorization-auxiliary” header see https://docs.microsoft.com/en-us/azure/azure-resource-manager/management/authenticate-multi-tenant 
""")
  @visibility("create")
  sourceResourceId?: ResourceIdentifier<[
    {
      type: "undefined";
    }
  ]>;

  @doc("""
Whether or not customer controlled manual cutover needs to be done during Update Database operation to Hyperscale tier.

This property is only applicable when scaling database from Business Critical/General Purpose/Premium/Standard tier to Hyperscale tier.

When manualCutover is specified, the scaling operation will wait for user input to trigger cutover to Hyperscale database.

To trigger cutover, please provide 'performCutover' parameter when the Scaling operation is in Waiting state.
""")
  manualCutover?: boolean;

  @doc("""
To trigger customer controlled manual cutover during the wait state while Scaling operation is in progress.

This property parameter is only applicable for scaling operations that are initiated along with 'manualCutover' parameter.

This property is only applicable when scaling database from Business Critical/General Purpose/Premium/Standard tier to Hyperscale tier is already in progress.

When performCutover is specified, the scaling operation will trigger cutover and perform role-change to Hyperscale database.
""")
  performCutover?: boolean;

  @doc("Specifies the availability zone the database is pinned to.")
  availabilityZone?: AvailabilityZoneType;

  @doc("The flag to enable or disable auto rotation of database encryption protector AKV key.")
  encryptionProtectorAutoRotation?: boolean;
}

@doc("Database level key used for encryption at rest.")
model DatabaseKey {
  @doc("The database key type. Only supported value is 'AzureKeyVault'.")
  @visibility("read")
  type?: DatabaseKeyType;

  @doc("Thumbprint of the database key.")
  @visibility("read")
  thumbprint?: string;

  @doc("The database key creation date.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  creationDate?: utcDateTime;

  @doc("Subregion of the server key.")
  @visibility("read")
  subregion?: string;
}

@doc("A database update resource.")
model DatabaseUpdate {
  @doc("The name and tier of the SKU.")
  sku?: Sku;

  @doc("Database identity")
  identity?: DatabaseIdentity;

  @doc("Resource properties.")
  properties?: DatabaseUpdateProperties;

  @doc("Resource tags.")
  tags?: Record<string>;
}

@doc("A database update properties.")
model DatabaseUpdateProperties {
  @doc("""
Specifies the mode of database creation.

Default: regular database creation.

Copy: creates a database as a copy of an existing database. sourceDatabaseId must be specified as the resource ID of the source database.

Secondary: creates a database as a secondary replica of an existing database. sourceDatabaseId must be specified as the resource ID of the existing primary database.

PointInTimeRestore: Creates a database by restoring a point in time backup of an existing database. sourceDatabaseId must be specified as the resource ID of the existing database, and restorePointInTime must be specified.

Recovery: Creates a database by restoring a geo-replicated backup. sourceDatabaseId must be specified as the recoverable database resource ID to restore.

Restore: Creates a database by restoring a backup of a deleted database. sourceDatabaseId must be specified. If sourceDatabaseId is the database's original resource ID, then sourceDatabaseDeletionDate must be specified. Otherwise sourceDatabaseId must be the restorable dropped database resource ID and sourceDatabaseDeletionDate is ignored. restorePointInTime may also be specified to restore from an earlier point in time.

RestoreLongTermRetentionBackup: Creates a database by restoring from a long term retention vault. recoveryServicesRecoveryPointResourceId must be specified as the recovery point resource ID.

Copy, Secondary, and RestoreLongTermRetentionBackup are not supported for DataWarehouse edition.
""")
  @visibility("create")
  createMode?: CreateMode;

  @doc("The collation of the database.")
  @visibility("read", "create")
  collation?: string;

  @doc("The max size of the database expressed in bytes.")
  maxSizeBytes?: int32;

  @doc("The name of the sample schema to apply when creating this database.")
  @visibility("create")
  sampleName?: SampleName;

  @doc("The resource identifier of the elastic pool containing this database.")
  elasticPoolId?: ResourceIdentifier<[
    {
      type: "Microsoft.Sql/servers/elasticPools";
    }
  ]>;

  @doc("The resource identifier of the source database associated with create operation of this database.")
  @visibility("create")
  sourceDatabaseId?: ResourceIdentifier<[
    {
      type: "undefined";
    }
  ]>;

  @doc("The status of the database.")
  @visibility("read")
  status?: DatabaseStatus;

  @doc("The ID of the database.")
  @visibility("read")
  databaseId?: string;

  @doc("The creation date of the database (ISO8601 format).")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  creationDate?: utcDateTime;

  @doc("The current service level objective name of the database.")
  @visibility("read")
  currentServiceObjectiveName?: string;

  @doc("The requested service level objective name of the database.")
  @visibility("read")
  requestedServiceObjectiveName?: string;

  @doc("The default secondary region for this database.")
  @visibility("read")
  defaultSecondaryLocation?: string;

  @doc("Failover Group resource identifier that this database belongs to.")
  @visibility("read")
  failoverGroupId?: string;

  @doc("Specifies the point in time (ISO8601 format) of the source database that will be restored to create the new database.")
  @visibility("create")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  restorePointInTime?: utcDateTime;

  @doc("Specifies the time that the database was deleted.")
  @visibility("create")
  @projectedName("json", "sourceDatabaseDeletionDate")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  sourceDatabaseDeletedOn?: utcDateTime;

  @doc("The resource identifier of the recovery point associated with create operation of this database.")
  @visibility("create")
  recoveryServicesRecoveryPointId?: ResourceIdentifier<[
    {
      type: "undefined";
    }
  ]>;

  @doc("The resource identifier of the long term retention backup associated with create operation of this database.")
  @visibility("create")
  longTermRetentionBackupResourceId?: ResourceIdentifier<[
    {
      type: "Microsoft.Sql/locations/longTermRetentionBackups";
    }
  ]>;

  @doc("The resource identifier of the recoverable database associated with create operation of this database.")
  @visibility("create")
  recoverableDatabaseId?: ResourceIdentifier<[
    {
      type: "undefined";
    }
  ]>;

  @doc("The resource identifier of the restorable dropped database associated with create operation of this database.")
  @visibility("create")
  restorableDroppedDatabaseId?: ResourceIdentifier<[
    {
      type: "undefined";
    }
  ]>;

  @doc("Collation of the metadata catalog.")
  @visibility("read", "create")
  catalogCollation?: CatalogCollationType;

  @doc("Whether or not this database is zone redundant, which means the replicas of this database will be spread across multiple availability zones.")
  @projectedName("json", "zoneRedundant")
  IsZoneRedundant?: boolean;

  @doc("The license type to apply for this database. `LicenseIncluded` if you need a license, or `BasePrice` if you have a license and are eligible for the Azure Hybrid Benefit.")
  licenseType?: DatabaseLicenseType;

  @doc("The max log size for this database.")
  @visibility("read")
  maxLogSizeBytes?: int32;

  @doc("This records the earliest start date and time that restore is available for this database (ISO8601 format).")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  earliestRestoreDate?: utcDateTime;

  @doc("The state of read-only routing. If enabled, connections that have application intent set to readonly in their connection string may be routed to a readonly secondary replica in the same region. Not applicable to a Hyperscale database within an elastic pool.")
  @visibility("read", "update")
  readScale?: DatabaseReadScale;

  @doc("The number of secondary replicas associated with the database that are used to provide high availability. Not applicable to a Hyperscale database within an elastic pool.")
  highAvailabilityReplicaCount?: int32;

  @doc("The secondary type of the database if it is a secondary.  Valid values are Geo, Named and Standby.")
  secondaryType?: SecondaryType;

  @doc("The name and tier of the SKU.")
  @visibility("read")
  currentSku?: Sku;

  @doc("Time in minutes after which database is automatically paused. A value of -1 means that automatic pause is disabled")
  autoPauseDelay?: int32;

  @doc("The storage account type used to store backups for this database.")
  @visibility("read")
  currentBackupStorageRedundancy?: BackupStorageRedundancy;

  @doc("The storage account type to be used to store backups for this database.")
  requestedBackupStorageRedundancy?: BackupStorageRedundancy;

  @doc("Minimal capacity that database will always have allocated, if not paused")
  minCapacity?: float32;

  @doc("The date when database was paused by user configuration or action(ISO8601 format). Null if the database is ready.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  pausedDate?: utcDateTime;

  @doc("The date when database was resumed by user action or database login (ISO8601 format). Null if the database is paused.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  resumedDate?: utcDateTime;

  @doc("Maintenance configuration id assigned to the database. This configuration defines the period when the maintenance updates will occur.")
  maintenanceConfigurationId?: string;

  @doc("Whether or not this database is a ledger database, which means all tables in the database are ledger tables. Note: the value of this property cannot be changed after the database has been created.")
  isLedgerOn?: boolean;

  @doc("Infra encryption is enabled for this database.")
  @visibility("read")
  isInfraEncryptionEnabled?: boolean;

  @doc("The Client id used for cross tenant per database CMK scenario")
  federatedClientId?: string;

  @doc("The resource ids of the user assigned identities to use")
  keys?: Record<DatabaseKey>;

  @doc("The azure key vault URI of the database if it's configured with per Database Customer Managed Keys.")
  encryptionProtector?: string;

  @doc("Type of enclave requested on the database i.e. Default or VBS enclaves.")
  preferredEnclaveType?: AlwaysEncryptedEnclaveType;

  @doc("Whether or not the database uses free monthly limits. Allowed on one database in a subscription.")
  useFreeLimit?: boolean;

  @doc("""
Specifies the behavior when monthly free limits are exhausted for the free database.

AutoPause: The database will be auto paused upon exhaustion of free limits for remainder of the month.

BillForUsage: The database will continue to be online upon exhaustion of free limits and any overage will be billed.
""")
  freeLimitExhaustionBehavior?: FreeLimitExhaustionBehavior;

  @doc("""
Whether or not customer controlled manual cutover needs to be done during Update Database operation to Hyperscale tier.

This property is only applicable when scaling database from Business Critical/General Purpose/Premium/Standard tier to Hyperscale tier.

When manualCutover is specified, the scaling operation will wait for user input to trigger cutover to Hyperscale database.

To trigger cutover, please provide 'performCutover' parameter when the Scaling operation is in Waiting state.
""")
  manualCutover?: boolean;

  @doc("""
To trigger customer controlled manual cutover during the wait state while Scaling operation is in progress.

This property parameter is only applicable for scaling operations that are initiated along with 'manualCutover' parameter.

This property is only applicable when scaling database from Business Critical/General Purpose/Premium/Standard tier to Hyperscale tier is already in progress.

When performCutover is specified, the scaling operation will trigger cutover and perform role-change to Hyperscale database.
""")
  performCutover?: boolean;

  @doc("The flag to enable or disable auto rotation of database encryption protector AKV key.")
  encryptionProtectorAutoRotation?: boolean;
}

@doc("Contains the information necessary to perform export database operation.")
model ExportDatabaseDefinition {
  @doc("Storage key type.")
  @visibility("create")
  storageKeyType: StorageKeyType;

  @doc("Storage key.")
  @visibility("create")
  storageKey: string;

  @doc("Storage Uri.")
  @visibility("create")
  storageUri: string;

  @doc("Administrator login name.")
  @visibility("create")
  administratorLogin: string;

  @doc("Administrator login password.")
  @visibility("create")
  administratorLoginPassword: string;

  @doc("Authentication type.")
  @visibility("create")
  authenticationType?: string;

  @doc("Optional resource information to enable network isolation for request.")
  @visibility("create")
  networkIsolation?: NetworkIsolationSettings;
}

@doc("Contains the ARM resources for which to create private endpoint connection.")
model NetworkIsolationSettings {
  @doc("The resource id for the storage account used to store BACPAC file. If set, private endpoint connection will be created for the storage account. Must match storage account used for StorageUri parameter.")
  @visibility("create")
  storageAccountResourceId?: ResourceIdentifier<[
    {
      type: "undefined";
    }
  ]>;

  @doc("The resource id for the SQL server which is the target of this request. If set, private endpoint connection will be created for the SQL server. Must match server which is target of the operation.")
  @visibility("create")
  sqlServerResourceId?: ResourceIdentifier<[
    {
      type: "undefined";
    }
  ]>;
}

@doc("An ImportExport operation result resource.")
model ImportExportOperationResult extends ProxyResource {
  @doc("Resource properties.")
  properties?: ImportExportOperationResultProperties;
}

@doc("Contains the operation result properties for import/export operation.")
model ImportExportOperationResultProperties {
  @doc("Request Id.")
  @visibility("read")
  requestId?: string;

  @doc("Request type.")
  @visibility("read")
  requestType?: string;

  @doc("Queued time.")
  @visibility("read")
  queuedTime?: string;

  @doc("Last modified time.")
  @visibility("read")
  lastModifiedTime?: string;

  @doc("Blob Uri.")
  @visibility("read")
  blobUri?: string;

  @doc("Server name.")
  @visibility("read")
  serverName?: string;

  @doc("Database name.")
  @visibility("read")
  databaseName?: string;

  @doc("Operation status.")
  @visibility("read")
  status?: string;

  @doc("Error message.")
  @visibility("read")
  errorMessage?: string;

  @doc("Gets the status of private endpoints associated with this request.")
  @visibility("read")
  privateEndpointConnections?: PrivateEndpointConnectionRequestStatus[];
}

@doc("Contains the private endpoint connection requests status.")
model PrivateEndpointConnectionRequestStatus {
  @doc("Resource id for which the private endpoint is created.")
  @visibility("read")
  privateLinkServiceId?: string;

  @doc("The connection name for the private endpoint.")
  @visibility("read")
  privateEndpointConnectionName?: string;

  @doc("Status of this private endpoint connection.")
  @visibility("read")
  status?: string;
}

@doc("Contains the information necessary to perform import operation for existing database.")
model ImportExistingDatabaseDefinition {
  @doc("Storage key type.")
  @visibility("create")
  storageKeyType: StorageKeyType;

  @doc("Storage key.")
  @visibility("create")
  storageKey: string;

  @doc("Storage Uri.")
  @visibility("create")
  storageUri: string;

  @doc("Administrator login name.")
  @visibility("create")
  administratorLogin: string;

  @doc("Administrator login password.")
  @visibility("create")
  administratorLoginPassword: string;

  @doc("Authentication type.")
  @visibility("create")
  authenticationType?: string;

  @doc("Optional resource information to enable network isolation for request.")
  @visibility("create")
  networkIsolation?: NetworkIsolationSettings;
}

@doc("Contains the information necessary to perform a resource move (rename).")
model ResourceMoveDefinition {
  @doc("The target ID for the resource")
  id: string;
}

@doc("Properties of an elastic pool")
model ElasticPoolProperties {
  @doc("The state of the elastic pool.")
  @visibility("read")
  state?: ElasticPoolState;

  @doc("The creation date of the elastic pool (ISO8601 format).")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  creationDate?: utcDateTime;

  @doc("The storage limit for the database elastic pool in bytes.")
  maxSizeBytes?: int32;

  @doc("Minimal capacity that serverless pool will not shrink below, if not paused")
  minCapacity?: float32;

  @doc("The per database settings for the elastic pool.")
  perDatabaseSettings?: ElasticPoolPerDatabaseSettings;

  @doc("Whether or not this elastic pool is zone redundant, which means the replicas of this elastic pool will be spread across multiple availability zones.")
  @projectedName("json", "zoneRedundant")
  IsZoneRedundant?: boolean;

  @doc("The license type to apply for this elastic pool.")
  licenseType?: ElasticPoolLicenseType;

  @doc("Maintenance configuration id assigned to the elastic pool. This configuration defines the period when the maintenance updates will will occur.")
  maintenanceConfigurationId?: string;

  @doc("The number of secondary replicas associated with the elastic pool that are used to provide high availability. Applicable only to Hyperscale elastic pools.")
  highAvailabilityReplicaCount?: int32;

  @doc("Type of enclave requested on the elastic pool.")
  preferredEnclaveType?: AlwaysEncryptedEnclaveType;

  @doc("Specifies the availability zone the pool's primary replica is pinned to.")
  availabilityZone?: AvailabilityZoneType;
}

@doc("Per database settings of an elastic pool.")
model ElasticPoolPerDatabaseSettings {
  @doc("The minimum capacity all databases are guaranteed.")
  minCapacity?: float32;

  @doc("The maximum capacity any one database can consume.")
  maxCapacity?: float32;
}

@doc("An elastic pool update.")
model ElasticPoolUpdate {
  @doc("An ARM Resource SKU.")
  sku?: Sku;

  @doc("Resource properties.")
  properties?: ElasticPoolUpdateProperties;

  @doc("Resource tags.")
  tags?: Record<string>;
}

@doc("Properties of an elastic pool")
model ElasticPoolUpdateProperties {
  @doc("The storage limit for the database elastic pool in bytes.")
  maxSizeBytes?: int32;

  @doc("Minimal capacity that serverless pool will not shrink below, if not paused")
  minCapacity?: float32;

  @doc("The per database settings for the elastic pool.")
  perDatabaseSettings?: ElasticPoolPerDatabaseSettings;

  @doc("Whether or not this elastic pool is zone redundant, which means the replicas of this elastic pool will be spread across multiple availability zones.")
  @projectedName("json", "zoneRedundant")
  IsZoneRedundant?: boolean;

  @doc("The license type to apply for this elastic pool.")
  licenseType?: ElasticPoolLicenseType;

  @doc("Maintenance configuration id assigned to the elastic pool. This configuration defines the period when the maintenance updates will will occur.")
  maintenanceConfigurationId?: string;

  @doc("The number of secondary replicas associated with the elastic pool that are used to provide high availability. Applicable only to Hyperscale elastic pools.")
  highAvailabilityReplicaCount?: int32;

  @doc("Type of enclave requested on the elastic pool.")
  preferredEnclaveType?: AlwaysEncryptedEnclaveType;

  @doc("Specifies the availability zone the pool's primary replica is pinned to.")
  availabilityZone?: AvailabilityZoneType;
}

@doc("The managed database's properties.")
model ManagedDatabaseProperties {
  @doc("Collation of the managed database.")
  @visibility("read", "create")
  collation?: string;

  @doc("Status of the database.")
  @visibility("read")
  status?: ManagedDatabaseStatus;

  @doc("Creation date of the database.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  creationDate?: utcDateTime;

  @doc("Earliest restore point in time for point in time restore.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  earliestRestorePoint?: utcDateTime;

  @doc("Conditional. If createMode is PointInTimeRestore, this value is required. Specifies the point in time (ISO8601 format) of the source database that will be restored to create the new database.")
  @visibility("create")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  restorePointInTime?: utcDateTime;

  @doc("Geo paired region.")
  @visibility("read")
  defaultSecondaryLocation?: string;

  @doc("Collation of the metadata catalog.")
  @visibility("read", "create")
  catalogCollation?: CatalogCollationType;

  @doc("Managed database create mode. PointInTimeRestore: Create a database by restoring a point in time backup of an existing database. SourceDatabaseName, SourceManagedInstanceName and PointInTime must be specified. RestoreExternalBackup: Create a database by restoring from external backup files. Collation, StorageContainerUri and StorageContainerSasToken must be specified. Recovery: Creates a database by restoring a geo-replicated backup. RecoverableDatabaseId must be specified as the recoverable database resource ID to restore. RestoreLongTermRetentionBackup: Create a database by restoring from a long term retention backup (longTermRetentionBackupResourceId required).")
  @visibility("create")
  createMode?: ManagedDatabaseCreateMode;

  @doc("Conditional. If createMode is RestoreExternalBackup, this value is required. Specifies the uri of the storage container where backups for this restore are stored.")
  @visibility("create")
  storageContainerUri?: string;

  @doc("The resource identifier of the source database associated with create operation of this database.")
  @visibility("create")
  sourceDatabaseId?: ResourceIdentifier;

  @doc("The resource identifier of the cross-subscription source database associated with create operation of this database.")
  @visibility("create")
  crossSubscriptionSourceDatabaseId?: ResourceIdentifier;

  @doc("The restorable dropped database resource id to restore when creating this database.")
  @visibility("create")
  restorableDroppedDatabaseId?: ResourceIdentifier;

  @doc("The restorable cross-subscription dropped database resource id to restore when creating this database.")
  @visibility("create")
  crossSubscriptionRestorableDroppedDatabaseId?: ResourceIdentifier;

  @doc("Conditional. If createMode is RestoreExternalBackup, this value is used. Specifies the identity used for storage container authentication. Can be 'SharedAccessSignature' or 'ManagedIdentity'; if not specified 'SharedAccessSignature' is assumed.")
  @visibility("create")
  storageContainerIdentity?: string;

  @doc("Conditional. If createMode is RestoreExternalBackup and storageContainerIdentity is not ManagedIdentity, this value is required. Specifies the storage container sas token.")
  @visibility("create")
  storageContainerSasToken?: string;

  @doc("Instance Failover Group resource identifier that this managed database belongs to.")
  @visibility("read")
  failoverGroupId?: string;

  @doc("The resource identifier of the recoverable database associated with create operation of this database.")
  @visibility("create")
  recoverableDatabaseId?: ResourceIdentifier;

  @doc("The name of the Long Term Retention backup to be used for restore of this managed database.")
  @visibility("create")
  longTermRetentionBackupResourceId?: ResourceIdentifier;

  @doc("Whether to auto complete restore of this managed database.")
  @visibility("create")
  autoCompleteRestore?: boolean;

  @doc("Last backup file name for restore of this managed database.")
  @visibility("create")
  lastBackupName?: string;

  @doc("Target managed instance id used in cross-subscription restore.")
  @visibility("create")
  crossSubscriptionTargetManagedInstanceId?: string;

  @doc("Whether or not this database is a ledger database, which means all tables in the database are ledger tables. Note: the value of this property cannot be changed after the database has been created.")
  @visibility("read", "create")
  isLedgerOn?: boolean;
}

@doc("An managed database update.")
model ManagedDatabaseUpdate {
  @doc("Resource properties.")
  properties?: ManagedDatabaseProperties;

  @doc("Resource tags.")
  tags?: Record<string>;
}

@doc("Contains the information necessary to perform a managed database move.")
model ManagedDatabaseMoveDefinition {
  @doc("The destination managed database ID")
  destinationManagedDatabaseId: ResourceIdentifier;
}

@doc("Contains the information necessary to perform a complete database restore operation.")
model CompleteDatabaseRestoreDefinition {
  @doc("The last backup name to apply")
  lastBackupName: string;
}

@doc("Contains the information necessary to start a managed database move.")
model ManagedDatabaseStartMoveDefinition {
  @doc("The destination managed database ID")
  destinationManagedDatabaseId: ResourceIdentifier;

  @doc("The move operation mode.")
  operationMode?: MoveOperationMode;
}

@doc("Azure Active Directory identity configuration for a resource.")
model ResourceIdentity {
  @doc("The resource ids of the user assigned identities to use")
  userAssignedIdentities?: Record<UserIdentity>;

  @doc("The Azure Active Directory principal id.")
  @visibility("read")
  principalId?: string;

  @doc("The identity type. Set this to 'SystemAssigned' in order to automatically create and assign an Azure Active Directory principal for the resource.")
  type?: IdentityType;

  @doc("The Azure Active Directory tenant id.")
  @visibility("read")
  tenantId?: string;
}

@doc("Azure Active Directory identity configuration for a resource.")
model UserIdentity {
  @doc("The Azure Active Directory principal id.")
  @visibility("read")
  principalId?: string;

  @doc("The Azure Active Directory client id.")
  @visibility("read")
  clientId?: string;
}

@doc("The properties of a managed instance.")
model ManagedInstanceProperties {
  @visibility("read")
  provisioningState?: ManagedInstancePropertiesProvisioningState;

  @doc("""
Specifies the mode of database creation.

Default: Regular instance creation.

Restore: Creates an instance by restoring a set of backups to specific point in time. RestorePointInTime and SourceManagedInstanceId must be specified.
""")
  @visibility("create")
  managedInstanceCreateMode?: ManagedServerCreateMode;

  @doc("The fully qualified domain name of the managed instance.")
  @visibility("read")
  fullyQualifiedDomainName?: string;

  @doc("Administrator username for the managed instance. Can only be specified when the managed instance is being created (and is required for creation).")
  @visibility("read", "create")
  administratorLogin?: string;

  @doc("The administrator login password (required for managed instance creation).")
  @visibility("create", "update")
  administratorLoginPassword?: string;

  @doc("Subnet resource ID for the managed instance.")
  subnetId?: ResourceIdentifier<[
    {
      type: "Microsoft.Network/virtualNetworks/subnets";
    }
  ]>;

  @doc("The state of the managed instance.")
  @visibility("read")
  state?: string;

  @doc("The license type. Possible values are 'LicenseIncluded' (regular price inclusive of a new SQL license) and 'BasePrice' (discounted AHB price for bringing your own SQL licenses).")
  licenseType?: ManagedInstanceLicenseType;

  @doc("The number of vCores. Allowed values: 8, 16, 24, 32, 40, 64, 80.")
  vCores?: int32;

  @doc("Storage size in GB. Minimum value: 32. Maximum value: 16384. Increments of 32 GB allowed only. Maximum value depends on the selected hardware family and number of vCores.")
  storageSizeInGB?: int32;

  @doc("Collation of the managed instance.")
  @visibility("read", "create")
  collation?: string;

  @doc("The Dns Zone that the managed instance is in.")
  @visibility("read")
  dnsZone?: string;

  @doc("The resource id of another managed instance whose DNS zone this managed instance will share after creation.")
  @visibility("create")
  dnsZonePartner?: ResourceIdentifier;

  @doc("Whether or not the public data endpoint is enabled.")
  @projectedName("json", "publicDataEndpointEnabled")
  IsPublicDataEndpointEnabled?: boolean;

  @doc("The resource identifier of the source managed instance associated with create operation of this instance.")
  @visibility("create")
  sourceManagedInstanceId?: ResourceIdentifier;

  @doc("Specifies the point in time (ISO8601 format) of the source database that will be restored to create the new database.")
  @visibility("create")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  restorePointInTime?: utcDateTime;

  @doc("Connection type used for connecting to the instance.")
  proxyOverride?: ManagedInstanceProxyOverride;

  @doc("""
Id of the timezone. Allowed values are timezones supported by Windows.
Windows keeps details on supported timezones, including the id, in registry under
KEY_LOCAL_MACHINE\\SOFTWARE\\Microsoft\\Windows NT\\CurrentVersion\\Time Zones.
You can get those registry values via SQL Server by querying SELECT name AS timezone_id FROM sys.time_zone_info.
List of Ids can also be obtained by executing [System.TimeZoneInfo]::GetSystemTimeZones() in PowerShell.
An example of valid timezone id is \"Pacific Standard Time\" or \"W. Europe Standard Time\".
""")
  @visibility("read", "create")
  timezoneId?: string;

  @doc("The Id of the instance pool this managed server belongs to.")
  instancePoolId?: string;

  @doc("Specifies maintenance configuration id to apply to this managed instance.")
  maintenanceConfigurationId?: string;

  @doc("List of private endpoint connections on a managed instance.")
  @visibility("read")
  privateEndpointConnections?: ManagedInstancePecProperty[];

  @doc("Minimal TLS version. Allowed values: 'None', '1.0', '1.1', '1.2'")
  minimalTlsVersion?: string;

  @doc("The storage account type used to store backups for this instance. The options are Local (LocallyRedundantStorage), Zone (ZoneRedundantStorage), Geo (GeoRedundantStorage) and GeoZone(GeoZoneRedundantStorage)")
  @visibility("read")
  currentBackupStorageRedundancy?: BackupStorageRedundancy;

  @doc("The storage account type to be used to store backups for this instance. The options are Local (LocallyRedundantStorage), Zone (ZoneRedundantStorage), Geo (GeoRedundantStorage) and GeoZone(GeoZoneRedundantStorage)")
  @visibility("read", "create")
  requestedBackupStorageRedundancy?: BackupStorageRedundancy;

  @doc("Whether or not the multi-az is enabled.")
  @projectedName("json", "zoneRedundant")
  IsZoneRedundant?: boolean;

  @doc("The resource id of a user assigned identity to be used by default.")
  primaryUserAssignedIdentityId?: ResourceIdentifier<[
    {
      type: "Microsoft.ManagedIdentity/userAssignedIdentities";
    }
  ]>;

  @doc("A CMK URI of the key to use for encryption.")
  @visibility("read", "create")
  keyId?: string;

  @doc("The Azure Active Directory administrator of the instance. This can only be used at instance create time. If used for instance update, it will be ignored or it will result in an error. For updates individual APIs will need to be used.")
  @visibility("read", "create")
  administrators?: ManagedInstanceExternalAdministrator;

  @doc("The managed instance's service principal.")
  servicePrincipal?: ServicePrincipal;
}

@doc("A private endpoint connection under a managed instance")
model ManagedInstancePecProperty {
  @doc("Resource ID.")
  @visibility("read")
  id?: string;

  @doc("Private endpoint connection properties")
  @visibility("read")
  properties?: ManagedInstancePrivateEndpointConnectionProperties;
}

@doc("Properties of a active directory administrator.")
model ManagedInstanceExternalAdministrator {
  @doc("Type of the sever administrator.")
  administratorType?: AdministratorType;

  @doc("Principal Type of the sever administrator.")
  principalType?: PrincipalType;

  @doc("Login name of the server administrator.")
  login?: string;

  @doc("SID (object ID) of the server administrator.")
  sid?: string;

  @doc("Tenant ID of the administrator.")
  tenantId?: string;

  @doc("Azure Active Directory only Authentication enabled.")
  azureADOnlyAuthentication?: boolean;
}

@doc("The managed instance's service principal configuration for a resource.")
model ServicePrincipal {
  @doc("The Azure Active Directory application object id.")
  @visibility("read")
  principalId?: string;

  @doc("The Azure Active Directory application client id.")
  @visibility("read")
  clientId?: string;

  @doc("The Azure Active Directory tenant id.")
  @visibility("read")
  tenantId?: string;

  @doc("Service principal type.")
  type?: ServicePrincipalType;
}

@doc("An update request for an Azure SQL Database managed instance.")
model ManagedInstanceUpdate {
  @doc("Managed instance sku")
  sku?: Sku;

  @doc("Managed instance identity")
  identity?: ResourceIdentity;

  @doc("Resource properties.")
  properties?: ManagedInstanceProperties;

  @doc("Resource tags.")
  tags?: Record<string>;
}

@doc("A collection of endpoints that the managed instance service requires outbound network access to.")
model OutboundEnvironmentEndpointCollection
  is Azure.Core.Page<OutboundEnvironmentEndpoint>;

@doc("An endpoint that the managed instance service requires outbound network access to.")
model OutboundEnvironmentEndpoint {
  @doc("The type of service accessed by the managed instance service, e.g., Azure Storage, Azure Active Directory, etc.")
  @visibility("read")
  category?: string;

  @doc("The endpoints that the managed instance service communicates with in order to function correctly.")
  @visibility("read")
  endpoints?: EndpointDependency[];
}

@doc("A domain name that the managed instance service needs to communicate with, along with additional details.")
model EndpointDependency {
  @doc("The domain name of the dependency.")
  @visibility("read")
  domainName?: string;

  @doc("The IP Addresses and Ports used when connecting to DomainName.")
  @visibility("read")
  endpointDetails?: EndpointDetail[];
}

@doc("A domain name that the managed instance service needs to communicate with, along with additional details.")
model EndpointDetail {
  @doc("The port an endpoint is connected to.")
  @visibility("read")
  port?: int32;
}

@doc("A list of top resource consuming queries on managed instance")
model TopQueriesListResult is Azure.Core.Page<TopQueries>;

model TopQueries {
  @doc("Requested number of top queries.")
  @visibility("read")
  numberOfQueries?: int32;

  @doc("Aggregation function used to calculate query metrics.")
  @visibility("read")
  aggregationFunction?: string;

  @doc("Metric used to rank queries.")
  @visibility("read")
  observationMetric?: string;

  @doc("Interval type (length).")
  @visibility("read")
  intervalType?: QueryTimeGrainType;

  @doc("The start time for the metric (ISO-8601 format).")
  @visibility("read")
  startTime?: string;

  @doc("The end time for the metric (ISO-8601 format).")
  @visibility("read")
  endTime?: string;

  @doc("List of top resource consuming queries with appropriate metric data")
  queries?: QueryStatisticsProperties[];
}

@doc("The properties of a database ledger digest upload settings.")
model ManagedLedgerDigestUploadsProperties {
  @doc("The digest storage endpoint, which must be either an Azure blob storage endpoint or an URI for Azure Confidential Ledger.")
  digestStorageEndpoint?: string;

  @doc("Specifies the state of ledger digest upload.")
  @visibility("read")
  state?: ManagedLedgerDigestUploadsState;
}

@doc("The recoverable database's properties.")
model RecoverableDatabaseProperties {
  @doc("The edition of the database.")
  @visibility("read")
  edition?: string;

  @doc("The service level objective name of the database.")
  @visibility("read")
  serviceLevelObjective?: string;

  @doc("The elastic pool name of the database")
  @visibility("read")
  elasticPoolName?: string;

  @doc("The last available backup date.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastAvailableBackupDate?: utcDateTime;

  @doc("The resource ids of the user assigned identities to use")
  keys?: Record<DatabaseKey>;
}

@doc("The restorable dropped database's properties.")
model RestorableDroppedDatabaseProperties {
  @doc("The name of the database.")
  @visibility("read")
  databaseName?: string;

  @doc("The max size of the database expressed in bytes.")
  @visibility("read")
  maxSizeBytes?: int32;

  @doc("The creation date of the database (ISO8601 format).")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  creationDate?: utcDateTime;

  @doc("The deletion date of the database (ISO8601 format).")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  deletionDate?: utcDateTime;

  @doc("The earliest restore date of the database (ISO8601 format).")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  earliestRestoreDate?: utcDateTime;

  @doc("The storage account type used to store backups for this database.")
  @visibility("read")
  backupStorageRedundancy?: BackupStorageRedundancy;

  @doc("The resource ids of the user assigned identities to use")
  keys?: Record<DatabaseKey>;
}

@doc("The properties of server configuration option.")
model ServerConfigurationOptionProperties {
  @doc("Value of the server configuration option.")
  @visibility("read", "update")
  serverConfigurationOptionValue: int32;

  @doc("Provisioning state of server configuration option.")
  @visibility("read")
  provisioningState?: ProvisioningState;
}

@doc("Properties of managed instance's Start/Stop schedule.")
model StartStopManagedInstanceScheduleProperties {
  @doc("The description of the schedule.")
  description?: string;

  @doc("The time zone of the schedule.")
  timeZoneId?: string;

  @doc("Schedule list.")
  scheduleList: ScheduleItem[];

  @doc("Next action to be executed (Start or Stop)")
  @visibility("read")
  nextRunAction?: string;

  @doc("Timestamp when the next action will be executed in the corresponding schedule time zone.")
  @visibility("read")
  nextExecutionTime?: string;
}

@doc("Schedule info describing when the server should be started or stopped.")
model ScheduleItem {
  @doc("Start day.")
  startDay: DayOfWeek;

  @doc("Start time.")
  startTime: string;

  @doc("Stop day.")
  stopDay: DayOfWeek;

  @doc("Stop time.")
  stopTime: string;
}

@doc("Properties of a transparent data encryption.")
model TransparentDataEncryptionProperties {
  @doc("Specifies the state of the transparent data encryption.")
  state: TransparentDataEncryptionState;
}

@doc("The properties of an IPv6 server firewall rule.")
model IPv6ServerFirewallRuleProperties {
  @doc("The start IP address of the firewall rule. Must be IPv6 format.")
  startIPv6Address?: string;

  @doc("The end IP address of the firewall rule. Must be IPv6 format. Must be greater than or equal to startIpv6Address.")
  endIPv6Address?: string;
}

@doc("Properties of a database Sql Vulnerability Assessment baseline set.")
model DatabaseSqlVulnerabilityAssessmentBaselineSetProperties {
  @doc("The baseline set result")
  results: Record<string[][]>;
}

@doc("A database sql vulnerability assessment rule baseline list input.")
model DatabaseSqlVulnerabilityAssessmentRuleBaselineListInput
  extends ProxyResource {
  @doc("SystemData of DatabaseSqlVulnerabilityAssessmentRuleBaselineListInputResource.")
  @visibility("read")
  systemData?: SystemData;

  @doc("Resource properties.")
  properties?: DatabaseSqlVulnerabilityAssessmentRuleBaselineListInputProperties;
}

@doc("Properties of a database Sql Vulnerability Assessment rule baseline.")
model DatabaseSqlVulnerabilityAssessmentRuleBaselineListInputProperties {
  @doc("The latest scan flag")
  latestScan: boolean;

  @doc("The rule baseline result list")
  results: Record<string[][]>;
}

@doc("Properties of a database Sql Vulnerability Assessment rule baseline.")
model DatabaseSqlVulnerabilityAssessmentRuleBaselineProperties {
  @doc("The rule baseline result")
  results: string[][];
}

@doc("A database sql vulnerability assessment rule baseline input.")
model DatabaseSqlVulnerabilityAssessmentRuleBaselineInput
  extends ProxyResource {
  @doc("SystemData of DatabaseSqlVulnerabilityAssessmentRuleBaselineInputResource.")
  @visibility("read")
  systemData?: SystemData;

  @doc("Resource properties.")
  properties?: DatabaseSqlVulnerabilityAssessmentRuleBaselineInputProperties;
}

@doc("Properties of a database Sql Vulnerability Assessment rule baseline.")
model DatabaseSqlVulnerabilityAssessmentRuleBaselineInputProperties {
  @doc("The latest scan flag")
  latestScan: boolean;

  @doc("The rule baseline result")
  results: string[][];
}

@doc("SQL Vulnerability Assessment scan result properties for a single rule.")
model SqlVulnerabilityAssessmentScanResultProperties {
  @doc("SQL Vulnerability Assessment rule Id.")
  @visibility("read")
  ruleId?: string;

  @doc("SQL Vulnerability Assessment rule result status.")
  @visibility("read")
  status?: RuleStatus;

  @doc("SQL Vulnerability Assessment error message.")
  @visibility("read")
  errorMessage?: string;

  @doc("SQL Vulnerability Assessment is the query results trimmed.")
  @visibility("read")
  isTrimmed?: boolean;

  @doc("SQL Vulnerability Assessment query results that was run.")
  @visibility("read")
  queryResults?: string[][];

  @doc("SQL Vulnerability Assessment the remediation details.")
  @visibility("read")
  remediation?: Remediation;

  @doc("SQL Vulnerability Assessment rule result adjusted with baseline.")
  @visibility("read")
  baselineAdjustedResult?: BaselineAdjustedResult;

  @doc("SQL Vulnerability Assessment rule metadata.")
  @visibility("read")
  ruleMetadata?: VaRule;
}

@doc("SQL Vulnerability Assessment remediation Details.")
model Remediation {
  @doc("SQL Vulnerability Assessment remediation description.")
  @visibility("read")
  description?: string;

  @doc("SQL Vulnerability Assessment remediation script.")
  @visibility("read")
  scripts?: string[];

  @doc("SQL Vulnerability Assessment is remediation automated.")
  @visibility("read")
  automated?: boolean;

  @doc("SQL Vulnerability Assessment optional link to remediate in Azure Portal.")
  @visibility("read")
  portalLink?: string;
}

@doc("SQL Vulnerability Assessment baseline adjusted results")
model BaselineAdjustedResult {
  @doc("SQL Vulnerability Assessment baseline details")
  @visibility("read")
  baseline?: Baseline;

  @doc("SQL Vulnerability Assessment baseline status")
  @visibility("read")
  status?: RuleStatus;

  @doc("SQL Vulnerability Assessment results that are not in baseline")
  @visibility("read")
  resultsNotInBaseline?: string[][];

  @doc("SQL Vulnerability Assessment results that are in baseline.")
  @visibility("read")
  resultsOnlyInBaseline?: string[][];
}

@doc("SQL Vulnerability Assessment baseline Details")
model Baseline {
  @doc("SQL Vulnerability Assessment baseline expected results")
  @visibility("read")
  expectedResults?: string[][];

  @doc("SQL Vulnerability Assessment baseline update time (UTC)")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  updatedTime?: utcDateTime;
}

@doc("SQL Vulnerability Assessment rule metadata details.")
model VaRule {
  @doc("SQL Vulnerability Assessment rule Id.")
  @visibility("read")
  ruleId?: string;

  @doc("SQL Vulnerability Assessment rule severity.")
  @visibility("read")
  severity?: RuleSeverity;

  @doc("SQL Vulnerability Assessment rule category.")
  @visibility("read")
  category?: string;

  @doc("SQL Vulnerability Assessment rule type.")
  @visibility("read")
  ruleType?: RuleType;

  @doc("SQL Vulnerability Assessment rule title.")
  @visibility("read")
  title?: string;

  @doc("SQL Vulnerability Assessment rule description.")
  @visibility("read")
  description?: string;

  @doc("SQL Vulnerability Assessment rule rationale.")
  @visibility("read")
  rationale?: string;

  @doc("SQL Vulnerability Assessment rule query details.")
  @visibility("read")
  queryCheck?: QueryCheck;

  @doc("SQL Vulnerability Assessment benchmark references.")
  @visibility("read")
  benchmarkReferences?: BenchmarkReference[];
}

@doc("SQL Vulnerability Assessment query check object.")
model QueryCheck {
  @doc("SQL Vulnerability Assessment rule query.")
  @visibility("read")
  query?: string;

  @doc("SQL Vulnerability Assessment query expected result.")
  @visibility("read")
  expectedResult?: string[][];

  @doc("SQL Vulnerability Assessment column names of query expected result.")
  @visibility("read")
  columnNames?: string[];
}

@doc("SQL Vulnerability Assessment benchmark reference")
model BenchmarkReference {
  @doc("SQL Vulnerability Assessment benchmark name")
  @visibility("read")
  benchmark?: string;

  @doc("SQL Vulnerability Assessment benchmark reference.")
  @visibility("read")
  reference?: string;
}

@doc("Properties of a vulnerability assessment scan record.")
model SqlVulnerabilityAssessmentScanRecordProperties {
  @doc("The scan ID.")
  @visibility("read")
  scanId?: string;

  @doc("The scan trigger type.")
  @visibility("read")
  triggerType?: VulnerabilityAssessmentScanTriggerType;

  @doc("The scan status.")
  @visibility("read")
  state?: VulnerabilityAssessmentScanState;

  @doc("The scan start time (UTC).")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startTime?: utcDateTime;

  @doc("The scan end time (UTC).")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  endTime?: utcDateTime;

  @doc("The scan errors.")
  @visibility("read")
  errors?: SqlVulnerabilityAssessmentScanError[];

  @doc("The server name.")
  @visibility("read")
  server?: string;

  @doc("The database name.")
  @visibility("read")
  database?: string;

  @doc("The SQL version.")
  @visibility("read")
  sqlVersion?: string;

  @doc("The number of failed rules with high severity.")
  @visibility("read")
  highSeverityFailedRulesCount?: int32;

  @doc("The number of failed rules with medium severity.")
  @visibility("read")
  mediumSeverityFailedRulesCount?: int32;

  @doc("The number of failed rules with low severity.")
  @visibility("read")
  lowSeverityFailedRulesCount?: int32;

  @doc("The number of total passed rules.")
  @visibility("read")
  totalPassedRulesCount?: int32;

  @doc("The number of total failed rules.")
  @visibility("read")
  totalFailedRulesCount?: int32;

  @doc("The number of total rules assessed.")
  @visibility("read")
  totalRulesCount?: int32;

  @doc("Baseline created for this database, and has one or more rules.")
  @visibility("read")
  isBaselineApplied?: boolean;

  @doc("The last scan time.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastScanTime?: utcDateTime;
}

@doc("Properties of a vulnerability assessment scan error.")
model SqlVulnerabilityAssessmentScanError {
  @doc("The error code.")
  @visibility("read")
  code?: string;

  @doc("The error message.")
  @visibility("read")
  message?: string;
}

model SqlVulnerabilityAssessmentPolicyProperties {
  @doc("Specifies the state of the SQL Vulnerability Assessment, whether it is enabled or disabled or a state has not been applied yet on the specific database or server.")
  state?: SqlVulnerabilityAssessmentState;
}

@doc("A request to check whether the specified name for a resource is available.")
model CheckNameAvailabilityRequest {
  name: string;
  type: "Microsoft.Sql/servers";
}

@doc("The result of a name availability check.")
model SqlNameAvailabilityResponse {
  @doc("The name whose availability was checked.")
  @visibility("read")
  name?: string;

  @doc("True if the name is available, otherwise false.")
  @visibility("read")
  @projectedName("json", "available")
  IsAvailable?: boolean;

  @doc("The reason code explaining why the name is unavailable. Will be undefined if the name is available.")
  @visibility("read")
  reason?: CheckNameAvailabilityReason;

  @doc("A message explaining why the name is unavailable. Will be undefined if the name is available.")
  @visibility("read")
  message?: string;
}

@doc("The properties of a server.")
model ServerProperties {
  @doc("Administrator username for the server. Once created it cannot be changed.")
  @visibility("read", "create")
  administratorLogin?: string;

  @doc("The administrator login password (required for server creation).")
  @visibility("create", "update")
  administratorLoginPassword?: string;

  @doc("The version of the server.")
  version?: string;

  @doc("The state of the server.")
  @visibility("read")
  state?: string;

  @doc("The fully qualified domain name of the server.")
  @visibility("read")
  fullyQualifiedDomainName?: string;

  @doc("List of private endpoint connections on a server")
  @visibility("read")
  privateEndpointConnections?: ServerPrivateEndpointConnection[];

  @doc("Minimal TLS version. Allowed values: 'None', '1.0', '1.1', '1.2'")
  minimalTlsVersion?: string;

  @doc("Whether or not public endpoint access is allowed for this server.  Value is optional but if passed in, must be 'Enabled' or 'Disabled' or 'SecuredByPerimeter'")
  publicNetworkAccess?: ServerPublicNetworkAccessFlag;

  @doc("Whether or not existing server has a workspace created and if it allows connection from workspace")
  @visibility("read")
  workspaceFeature?: ServerWorkspaceFeature;

  @doc("The resource id of a user assigned identity to be used by default.")
  primaryUserAssignedIdentityId?: ResourceIdentifier<[
    {
      type: "Microsoft.ManagedIdentity/userAssignedIdentities";
    }
  ]>;

  @doc("The Client id used for cross tenant CMK scenario")
  federatedClientId?: string;

  @doc("A CMK URI of the key to use for encryption.")
  keyId?: string;

  @doc("The Azure Active Directory administrator of the server. This can only be used at server create time. If used for server update, it will be ignored or it will result in an error. For updates individual APIs will need to be used.")
  @visibility("read", "create")
  administrators?: ServerExternalAdministrator;

  @doc("Whether or not to restrict outbound network access for this server.  Value is optional but if passed in, must be 'Enabled' or 'Disabled'")
  restrictOutboundNetworkAccess?: ServerNetworkAccessFlag;

  @doc("Whether or not to enable IPv6 support for this server.  Value is optional but if passed in, must be 'Enabled' or 'Disabled'")
  isIPv6Enabled?: ServerNetworkAccessFlag;

  @doc("Status of external governance.")
  @visibility("read")
  externalGovernanceStatus?: ExternalGovernanceStatus;
}

@doc("A private endpoint connection under a server")
model ServerPrivateEndpointConnection {
  @doc("Resource ID.")
  @visibility("read")
  id?: string;

  @doc("Private endpoint connection properties")
  @visibility("read")
  properties?: PrivateEndpointConnectionProperties;
}

@doc("Properties of a active directory administrator.")
model ServerExternalAdministrator {
  @doc("Type of the sever administrator.")
  administratorType?: AdministratorType;

  @doc("Principal Type of the sever administrator.")
  principalType?: PrincipalType;

  @doc("Login name of the server administrator.")
  login?: string;

  @doc("SID (object ID) of the server administrator.")
  sid?: string;

  @doc("Tenant ID of the administrator.")
  tenantId?: string;

  @doc("Azure Active Directory only Authentication enabled.")
  azureADOnlyAuthentication?: boolean;
}

@doc("An update request for an Azure SQL Database server.")
model ServerUpdate {
  @doc("Server identity")
  identity?: ResourceIdentity;

  @doc("Resource properties.")
  properties?: ServerProperties;

  @doc("Resource tags.")
  tags?: Record<string>;
}

@doc("Contains the information necessary to perform import operation for new database.")
model ImportNewDatabaseDefinition {
  @doc("Name of the import database.")
  @visibility("create")
  databaseName?: string;

  @doc("Edition of the import database.")
  @visibility("create")
  edition?: string;

  @doc("Service level objective name of the import database.")
  @visibility("create")
  serviceObjectiveName?: string;

  @doc("Max size in bytes for the import database.")
  @visibility("create")
  maxSizeBytes?: string;

  @doc("Storage key type.")
  @visibility("create")
  storageKeyType: StorageKeyType;

  @doc("Storage key.")
  @visibility("create")
  storageKey: string;

  @doc("Storage Uri.")
  @visibility("create")
  storageUri: string;

  @doc("Administrator login name.")
  @visibility("create")
  administratorLogin: string;

  @doc("Administrator login password.")
  @visibility("create")
  administratorLoginPassword: string;

  @doc("Authentication type.")
  @visibility("create")
  authenticationType?: string;

  @doc("Optional resource information to enable network isolation for request.")
  @visibility("create")
  networkIsolation?: NetworkIsolationSettings;
}

@doc("An RefreshExternalGovernanceStatus operation result resource.")
model RefreshExternalGovernanceStatusOperationResult extends ProxyResource {
  @doc("Resource properties.")
  properties?: RefreshExternalGovernanceStatusOperationResultProperties;
}

@doc("Contains the operation result properties for refresh external governance status operation.")
model RefreshExternalGovernanceStatusOperationResultProperties {
  @doc("Request Id.")
  @visibility("read")
  requestId?: string;

  @doc("Request type.")
  @visibility("read")
  requestType?: string;

  @doc("Queued time.")
  @visibility("read")
  queuedTime?: string;

  @doc("Server name.")
  @visibility("read")
  serverName?: string;

  @doc("Operation status.")
  @visibility("read")
  status?: string;

  @doc("Error message.")
  @visibility("read")
  errorMessage?: string;
}

@doc("Properties of a failover group.")
model FailoverGroupProperties {
  @doc("Read-write endpoint of the failover group instance.")
  readWriteEndpoint: FailoverGroupReadWriteEndpoint;

  @doc("Read-only endpoint of the failover group instance.")
  readOnlyEndpoint?: FailoverGroupReadOnlyEndpoint;

  @doc("Local replication role of the failover group instance.")
  @visibility("read")
  replicationRole?: FailoverGroupReplicationRole;

  @doc("Replication state of the failover group instance.")
  @visibility("read")
  replicationState?: string;

  @doc("List of partner server information for the failover group.")
  partnerServers: PartnerInfo[];

  @doc("List of databases in the failover group.")
  databases?: ResourceIdentifier<[
    {
      type: "Microsoft.Sql/servers/databases";
    }
  ]>[];
}

@doc("Read-write endpoint of the failover group instance.")
model FailoverGroupReadWriteEndpoint {
  @doc("Failover policy of the read-write endpoint for the failover group. If failoverPolicy is Automatic then failoverWithDataLossGracePeriodMinutes is required.")
  failoverPolicy: ReadWriteEndpointFailoverPolicy;

  @doc("Grace period before failover with data loss is attempted for the read-write endpoint. If failoverPolicy is Automatic then failoverWithDataLossGracePeriodMinutes is required.")
  failoverWithDataLossGracePeriodMinutes?: int32;
}

@doc("Read-only endpoint of the failover group instance.")
model FailoverGroupReadOnlyEndpoint {
  @doc("Failover policy of the read-only endpoint for the failover group.")
  failoverPolicy?: ReadOnlyEndpointFailoverPolicy;

  @doc("The target partner server where the read-only endpoint points to.")
  targetServer?: ResourceIdentifier<[
    {
      type: "Microsoft.Sql/servers";
    }
  ]>;
}

@doc("Partner server information for the failover group.")
model PartnerInfo {
  @doc("Resource identifier of the partner server.")
  id: ResourceIdentifier<[
    {
      type: "Microsoft.Sql/servers";
    }
  ]>;

  @doc("Geo location of the partner server.")
  @visibility("read")
  location?: string;

  @doc("Replication role of the partner server.")
  @visibility("read")
  replicationRole?: FailoverGroupReplicationRole;
}

@doc("A failover group update request.")
model FailoverGroupUpdate {
  @doc("Resource properties.")
  properties?: FailoverGroupUpdateProperties;

  @doc("Resource tags.")
  tags?: Record<string>;
}

@doc("Properties of a failover group update.")
model FailoverGroupUpdateProperties {
  @doc("Read-write endpoint of the failover group instance.")
  readWriteEndpoint?: FailoverGroupReadWriteEndpoint;

  @doc("Read-only endpoint of the failover group instance.")
  readOnlyEndpoint?: FailoverGroupReadOnlyEndpoint;

  @doc("List of databases in the failover group.")
  databases?: ResourceIdentifier<[
    {
      type: "Microsoft.Sql/servers/databases";
    }
  ]>[];

  @doc("List of partner server information for the failover group.")
  partnerServers?: PartnerInfo[];
}

@doc("A Slo Usage Metric.")
model SloUsageMetric {
  @doc("The serviceLevelObjective for SLO usage metric.")
  @visibility("read")
  serviceLevelObjective?: ServiceObjectiveName;

  @doc("The serviceLevelObjectiveId for SLO usage metric.")
  @visibility("read")
  serviceLevelObjectiveId?: string;

  @doc("Gets or sets inRangeTimeRatio for SLO usage metric.")
  @visibility("read")
  inRangeTimeRatio?: float32;
}

@doc("The impact of an operation, both in absolute and relative terms.")
model OperationImpact {
  @doc("The name of the impact dimension.")
  @visibility("read")
  name?: string;

  @doc("The unit in which estimated impact to dimension is measured.")
  @visibility("read")
  unit?: string;

  @doc("The absolute impact to dimension.")
  @visibility("read")
  changeValueAbsolute?: float32;

  @doc("The relative impact to dimension (null if not applicable)")
  @visibility("read")
  changeValueRelative?: float32;
}

@doc("A list of server firewall rules.")
model FirewallRuleList {
  values?: FirewallRule[];
}

@doc("The properties that are supported in the $filter operation.")
model SecurityEventsFilterParameters {
  @doc("Filter on the event time.")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  eventTime?: utcDateTime;

  @doc("Whether to show server records or not.")
  showServerRecords?: boolean;
}

@doc("List of managed database move operations.")
model ManagedDatabaseMoveOperationListResult {
  @doc("Array of results.")
  @visibility("read")
  value?: ManagedDatabaseMoveOperationResult[];

  @doc("Link to retrieve next page of results.")
  @visibility("read")
  nextLink?: string;
}

@doc("A managed database move operation.")
model ManagedDatabaseMoveOperationResult extends ProxyResource {
  @doc("Resource properties.")
  properties?: ManagedDatabaseMoveOperationResultProperties;
}

@doc("Contains the operation result properties for managed database move operation.")
model ManagedDatabaseMoveOperationResultProperties {
  @doc("The name of operation.")
  @visibility("read")
  operation?: string;

  @doc("The friendly name of operation.")
  @visibility("read")
  operationFriendlyName?: string;

  @doc("The operation start time.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startTime?: utcDateTime;

  @doc("The operation state.")
  @visibility("read")
  state?: ManagementOperationState;

  @doc("Operation mode.")
  @visibility("read")
  operationMode?: MoveOperationMode;

  @doc("Source Managed Instance name.")
  @visibility("read")
  sourceManagedInstanceName?: string;

  @doc("Target Managed Instance name.")
  @visibility("read")
  targetManagedInstanceName?: string;

  @doc("Source Managed Instance resource id.")
  @visibility("read")
  sourceManagedInstanceId?: string;

  @doc("Target Managed instance resource id.")
  @visibility("read")
  targetManagedInstanceId?: string;

  @doc("Source database name.")
  @visibility("read")
  sourceDatabaseName?: string;

  @doc("Target database name.")
  @visibility("read")
  targetDatabaseName?: string;

  @doc("Is move operation cancellable.")
  @visibility("read")
  isCancellable?: boolean;

  @doc("The operation error code.")
  @visibility("read")
  errorCode?: int32;

  @doc("The operation error description.")
  @visibility("read")
  errorDescription?: string;

  @doc("The operation error severity.")
  @visibility("read")
  errorSeverity?: int32;

  @doc("Whether or not the error is a user error.")
  @visibility("read")
  isUserError?: boolean;
}

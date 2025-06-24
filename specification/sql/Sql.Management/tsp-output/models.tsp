import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";


using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.Core;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;


namespace Microsoft.Sql;

interface Operations extends Azure.ResourceManager.Operations {} 


    enum GeoBackupPolicyName {
        "Default"
    }

/**
* The unit of the metric.
*/
    enum UnitType {
        "count", "bytes", "seconds", "percent", "countPerSecond", "bytesPerSecond"
    }

/**
* The primary aggregation type defining how metric values are displayed.
*/
    enum PrimaryAggregationType {
        "None", "Average", "Count", "Minimum", "Maximum", "Total"
    }

/**
* The unit of the metric.
*/
    enum UnitDefinitionType {
        "Count", "Bytes", "Seconds", "Percent", "CountPerSecond", "BytesPerSecond"
    }

/**
* Current state the recommended action is in. Some commonly used states are: Active      -> recommended action is active and no action has been taken yet. Pending     -> recommended action is approved for and is awaiting execution. Executing   -> recommended action is being applied on the user database. Verifying   -> recommended action was applied and is being verified of its usefulness by the system. Success     -> recommended action was applied and improvement found during verification. Pending Revert  -> verification found little or no improvement so recommended action is queued for revert or user has manually reverted. Reverting   -> changes made while applying recommended action are being reverted on the user database. Reverted    -> successfully reverted the changes made by recommended action on user database. Ignored     -> user explicitly ignored/discarded the recommended action. 
*/
    enum RecommendedActionCurrentState {
        "Active", "Pending", "Executing", "Verifying", "PendingRevert", "RevertCancelled", "Reverting", "Reverted", "Ignored", "Expired", "Monitoring", "Resolved", "Success", "Error"
    }

/**
* The column data type.
*/
    enum ColumnDataType {
        "image", "text", "uniqueidentifier", "date", "time", "datetime2", "datetimeoffset", "tinyint", "smallint", "int", "smalldatetime", "real", "money", "datetime", "float", "sql_variant", "ntext", "bit", "decimal", "numeric", "smallmoney", "bigint", "hierarchyid", "geometry", "geography", "varbinary", "varchar", "binary", "char", "timestamp", "nvarchar", "nchar", "xml", "sysname"
    }

/**
* The table temporal type.
*/
    enum TableTemporalType {
        "NonTemporalTable", "HistoryTable", "SystemVersionedTemporalTable"
    }


    enum SecurityAlertPolicyName {
        "Default"
    }


    enum VulnerabilityAssessmentName {
        "default"
    }

/**
* The scan trigger type.
*/
    enum VulnerabilityAssessmentScanTriggerType {
        "OnDemand", "Recurring"
    }

/**
* The scan status.
*/
    enum VulnerabilityAssessmentScanState {
        "Passed", "Failed", "FailedToRun", "InProgress"
    }


    enum DataWarehouseUserActivityName {
        "current"
    }

/**
* The encryption protector type like 'ServiceManaged', 'AzureKeyVault'.
*/
    enum ServerKeyType {
        "ServiceManaged", "AzureKeyVault"
    }


    enum EncryptionProtectorName {
        "current"
    }

/**
* The license type. Possible values are 'LicenseIncluded' (price for SQL license is included) and 'BasePrice' (without SQL license price).
*/
    enum InstancePoolLicenseType {
        "LicenseIncluded", "BasePrice"
    }

/**
* The state of the job agent.
*/
    enum JobAgentState {
        "Creating", "Ready", "Updating", "Deleting", "Disabled"
    }

/**
* The detailed state of the job execution.
*/
    enum JobExecutionLifecycle {
        "Created", "InProgress", "WaitingForChildJobExecutions", "WaitingForRetry", "Succeeded", "SucceededWithSkipped", "Failed", "TimedOut", "Canceled", "Skipped"
    }

/**
* The ARM provisioning state of the job execution.
*/
    enum ProvisioningState {
        "Created", "InProgress", "Succeeded", "Failed", "Canceled"
    }

/**
* The type of the target.
*/
    enum JobTargetType {
        "TargetGroup", "SqlDatabase", "SqlElasticPool", "SqlShardMap", "SqlServer"
    }

/**
* Type of action being executed by the job step.
*/
    enum JobStepActionType {
        "TSql"
    }

/**
* The source of the action to execute.
*/
    enum JobStepActionSource {
        "Inline"
    }

/**
* The output destination type.
*/
    enum JobStepOutputType {
        "SqlDatabase"
    }


    enum CapabilityGroup {
        "supportedEditions", "supportedElasticPoolEditions", "supportedManagedInstanceVersions", "supportedInstancePoolEditions", "supportedManagedInstanceEditions"
    }

/**
* The units that the limit is expressed in.
*/
    enum MaxSizeUnit {
        "Megabytes", "Gigabytes", "Terabytes", "Petabytes"
    }

/**
* The units that the limit is expressed in.
*/
    enum LogSizeUnit {
        "Megabytes", "Gigabytes", "Terabytes", "Petabytes", "Percent"
    }

/**
* Unit type used to measure performance level.
*/
    enum PerformanceLevelUnit {
        "DTU", "VCores"
    }

/**
* Unit of time that delay is expressed in
*/
    enum PauseDelayTimeUnit {
        "Minutes"
    }

/**
* The storage account type for the database's backups.
*/
    enum StorageCapabilityStorageAccountType {
        "GRS", "LRS", "ZRS"
    }


    enum LongTermRetentionPolicyName {
        "default"
    }

/**
* Day of maintenance window.
*/
    enum DayOfWeek {
        "Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"
    }


    enum ManagedShortTermRetentionPolicyName {
        "default"
    }

/**
* Interval type (length).
*/
    enum QueryTimeGrainType {
        "PT1H", "P1D"
    }

/**
* The unit of the metric.
*/
    enum QueryMetricUnitType {
        "percentage", "KB", "microseconds", "count"
    }


    enum TransparentDataEncryptionName {
        "current"
    }

/**
* Type of the managed instance administrator.
*/
    enum ManagedInstanceAdministratorType {
        "ActiveDirectory"
    }


    enum AdministratorName {
        "ActiveDirectory"
    }


    enum AuthenticationName {
        "Default"
    }


    enum ManagedInstanceLongTermRetentionPolicyName {
        "default"
    }

/**
* The operation state.
*/
    enum ManagementOperationState {
        "Pending", "InProgress", "Succeeded", "Failed", "CancelInProgress", "Cancelled"
    }


    enum UpsertManagedServerOperationStepStatus {
        "NotStarted", "InProgress", "SlowedDown", "Completed", "Failed", "Canceled"
    }

/**
* The intended executor of the operation.
*/
    enum OperationOrigin {
        "user", "system"
    }

/**
* The private link service connection status.
*/
    enum PrivateLinkServiceConnectionStateStatus {
        "Approved", "Pending", "Rejected", "Disconnected"
    }

/**
* The actions required for private link service connection.
*/
    enum PrivateLinkServiceConnectionStateActionsRequire {
        "None"
    }

/**
* State of the private endpoint connection.
*/
    enum PrivateEndpointProvisioningState {
        "Approving", "Ready", "Dropping", "Failed", "Rejecting"
    }

/**
* Type of the sever administrator.
*/
    enum AdministratorType {
        "ActiveDirectory"
    }


    enum ServerTrustGroupPropertiesTrustScopesItem {
        "GlobalTransactions", "ServiceBroker"
    }

/**
* The state of Sql Agent.
*/
    enum SqlAgentConfigurationPropertiesState {
        "Enabled", "Disabled"
    }

/**
* State of the sync agent.
*/
    enum SyncAgentState {
        "Online", "Offline", "NeverConnected"
    }

/**
* Type of the sync agent linked database.
*/
    enum SyncMemberDbType {
        "AzureSqlDatabase", "SqlServerDatabase"
    }


    enum SyncGroupsType {
        "All", "Error", "Warning", "Success"
    }

/**
* Type of the sync group log.
*/
    enum SyncGroupLogType {
        "All", "Error", "Warning", "Success"
    }

/**
* Conflict resolution policy of the sync group.
*/
    enum SyncConflictResolutionPolicy {
        "HubWin", "MemberWin"
    }

/**
* Sync state of the sync group.
*/
    enum SyncGroupState {
        "NotReady", "Error", "Warning", "Progressing", "Good"
    }

/**
* Sync direction of the sync member.
*/
    enum SyncDirection {
        "Bidirectional", "OneWayMemberToHub", "OneWayHubToMember"
    }

/**
* Sync state of the sync member.
*/
    enum SyncMemberState {
        "SyncInProgress", "SyncSucceeded", "SyncFailed", "DisabledTombstoneCleanup", "DisabledBackupRestore", "SyncSucceededWithWarnings", "SyncCancelling", "SyncCancelled", "UnProvisioned", "Provisioning", "Provisioned", "ProvisionFailed", "DeProvisioning", "DeProvisioned", "DeProvisionFailed", "Reprovisioning", "ReprovisionFailed", "UnReprovisioned"
    }

/**
* Virtual Network Rule State
*/
    enum VirtualNetworkRuleState {
        "Initializing", "InProgress", "Ready", "Failed", "Deleting", "Unknown"
    }


    enum ShortTermRetentionPolicyName {
        "default"
    }

/**
* The differential backup interval in hours. This is how many interval hours between each differential backup will be supported. This is only applicable to live databases but not dropped databases.
*/
    enum DiffBackupIntervalInHours {
        "12": 12, "24": 24
    }

/**
* Operation Mode.
*/
    enum OperationMode {
        "PolybaseImport"
    }

/**
* Storage key type.
*/
    enum StorageKeyType {
        "SharedAccessKey", "StorageAccessKey"
    }


    enum LedgerDigestUploadsName {
        "current"
    }

/**
* The storage redundancy type of the copied backup
*/
    enum BackupStorageRedundancy {
        "Geo", "Local", "Zone", "GeoZone"
    }


    enum DatabaseState {
        "All", "Live", "Deleted"
    }


    enum ConnectionPolicyName {
        "default"
    }

/**
* The server connection type.
*/
    enum ServerConnectionType {
        "Default", "Redirect", "Proxy"
    }

/**
* The replication mode of a distributed availability group. Parameter will be ignored during link creation.
*/
    enum ReplicationMode {
        "Async", "Sync"
    }


    enum BlobAuditingPolicyName {
        "default"
    }


    enum AdvancedThreatProtectionName {
        "Default"
    }

/**
* Replication state (PENDING, SEEDING, CATCHUP, SUSPENDED).
*/
    enum ReplicationState {
        "PENDING", "SEEDING", "CATCH_UP", "SUSPENDED"
    }

/**
* Link type (GEO, NAMED, STANDBY).
*/
    enum ReplicationLinkType {
        "GEO", "NAMED", "STANDBY"
    }


    enum DtcName {
        "current"
    }

/**
* The status of the DNS refresh operation.
*/
    enum DNSRefreshOperationStatus {
        "Succeeded", "Failed", "InProgress"
    }

/**
* Type of the geo-secondary instance. Set 'Standby' if the instance is used as a DR option only.
*/
    enum SecondaryInstanceType {
        "Geo", "Standby"
    }

/**
* Failover policy of the read-write endpoint for the failover group. If failoverPolicy is Automatic then failoverWithDataLossGracePeriodMinutes is required.
*/
    enum ReadWriteEndpointFailoverPolicy {
        "Manual", "Automatic"
    }

/**
* Failover policy of the read-only endpoint for the failover group.
*/
    enum ReadOnlyEndpointFailoverPolicy {
        "Disabled", "Enabled"
    }

/**
* Local replication role of the failover group instance.
*/
    enum InstanceFailoverGroupReplicationRole {
        "Primary", "Secondary"
    }


    enum RestoreDetailsName {
        "Default"
    }

/**
* The identity type
*/
    enum DatabaseIdentityType {
        "None", "UserAssigned"
    }

/**
* Specifies the mode of database creation.

Default: regular database creation.

Copy: creates a database as a copy of an existing database. sourceDatabaseId must be specified as the resource ID of the source database.

Secondary: creates a database as a secondary replica of an existing database. sourceDatabaseId must be specified as the resource ID of the existing primary database.

PointInTimeRestore: Creates a database by restoring a point in time backup of an existing database. sourceDatabaseId must be specified as the resource ID of the existing database, and restorePointInTime must be specified.

Recovery: Creates a database by restoring a geo-replicated backup. sourceDatabaseId must be specified as the recoverable database resource ID to restore.

Restore: Creates a database by restoring a backup of a deleted database. sourceDatabaseId must be specified. If sourceDatabaseId is the database's original resource ID, then sourceDatabaseDeletionDate must be specified. Otherwise sourceDatabaseId must be the restorable dropped database resource ID and sourceDatabaseDeletionDate is ignored. restorePointInTime may also be specified to restore from an earlier point in time.

RestoreLongTermRetentionBackup: Creates a database by restoring from a long term retention vault. recoveryServicesRecoveryPointResourceId must be specified as the recovery point resource ID.

Copy, Secondary, and RestoreLongTermRetentionBackup are not supported for DataWarehouse edition.
*/
    enum CreateMode {
        "Default", "Copy", "Secondary", "PointInTimeRestore", "Restore", "Recovery", "RestoreExternalBackup", "RestoreExternalBackupSecondary", "RestoreLongTermRetentionBackup", "OnlineSecondary"
    }

/**
* The name of the sample schema to apply when creating this database.
*/
    enum SampleName {
        "AdventureWorksLT", "WideWorldImportersStd", "WideWorldImportersFull"
    }

/**
* The status of the database.
*/
    enum DatabaseStatus {
        "Online", "Restoring", "RecoveryPending", "Recovering", "Suspect", "Offline", "Standby", "Shutdown", "EmergencyMode", "AutoClosed", "Copying", "Creating", "Inaccessible", "OfflineSecondary", "Pausing", "Paused", "Resuming", "Scaling", "OfflineChangingDwPerformanceTiers", "OnlineChangingDwPerformanceTiers", "Disabled", "Stopping", "Stopped", "Starting"
    }

/**
* Collation of the metadata catalog.
*/
    enum CatalogCollationType {
        "DATABASE_DEFAULT", "SQL_Latin1_General_CP1_CI_AS"
    }

/**
* The license type to apply for this database. `LicenseIncluded` if you need a license, or `BasePrice` if you have a license and are eligible for the Azure Hybrid Benefit.
*/
    enum DatabaseLicenseType {
        "LicenseIncluded", "BasePrice"
    }

/**
* The state of read-only routing. If enabled, connections that have application intent set to readonly in their connection string may be routed to a readonly secondary replica in the same region. Not applicable to a Hyperscale database within an elastic pool.
*/
    enum DatabaseReadScale {
        "Enabled", "Disabled"
    }

/**
* The secondary type of the database if it is a secondary.  Valid values are Geo, Named and Standby.
*/
    enum SecondaryType {
        "Geo", "Named", "Standby"
    }

/**
* The database key type. Only supported value is 'AzureKeyVault'.
*/
    enum DatabaseKeyType {
        "AzureKeyVault"
    }

/**
* Type of enclave requested on the elastic pool.
*/
    enum AlwaysEncryptedEnclaveType {
        "Default", "VBS"
    }

/**
* Specifies the behavior when monthly free limits are exhausted for the free database.

AutoPause: The database will be auto paused upon exhaustion of free limits for remainder of the month.

BillForUsage: The database will continue to be online upon exhaustion of free limits and any overage will be billed.
*/
    enum FreeLimitExhaustionBehavior {
        "AutoPause", "BillOverUsage"
    }

/**
* Specifies the availability zone the pool's primary replica is pinned to.
*/
    enum AvailabilityZoneType {
        "NoPreference", "1", "2", "3"
    }


    enum ReplicaType {
        "Primary", "ReadableSecondary"
    }

/**
* The state of the elastic pool.
*/
    enum ElasticPoolState {
        "Creating", "Ready", "Disabled"
    }

/**
* The license type to apply for this elastic pool.
*/
    enum ElasticPoolLicenseType {
        "LicenseIncluded", "BasePrice"
    }

/**
* Status of the database.
*/
    enum ManagedDatabaseStatus {
        "Online", "Offline", "Shutdown", "Creating", "Inaccessible", "Restoring", "Updating", "Stopping", "Stopped", "Starting", "DbMoving", "DbCopying"
    }

/**
* Managed database create mode. PointInTimeRestore: Create a database by restoring a point in time backup of an existing database. SourceDatabaseName, SourceManagedInstanceName and PointInTime must be specified. RestoreExternalBackup: Create a database by restoring from external backup files. Collation, StorageContainerUri and StorageContainerSasToken must be specified. Recovery: Creates a database by restoring a geo-replicated backup. RecoverableDatabaseId must be specified as the recoverable database resource ID to restore. RestoreLongTermRetentionBackup: Create a database by restoring from a long term retention backup (longTermRetentionBackupResourceId required).
*/
    enum ManagedDatabaseCreateMode {
        "Default", "RestoreExternalBackup", "PointInTimeRestore", "Recovery", "RestoreLongTermRetentionBackup"
    }

/**
* Operation mode.
*/
    enum MoveOperationMode {
        "Move", "Copy"
    }

/**
* The identity type. Set this to 'SystemAssigned' in order to automatically create and assign an Azure Active Directory principal for the resource.
*/
    enum IdentityType {
        "None", "SystemAssigned", "UserAssigned", "SystemAssigned,UserAssigned"
    }


    enum ManagedInstancePropertiesProvisioningState {
        "Creating", "Deleting", "Updating", "Unknown", "Succeeded", "Failed", "Accepted", "Created", "Deleted", "Unrecognized", "Running", "Canceled", "NotSpecified", "Registering", "TimedOut"
    }

/**
* Specifies the mode of database creation.

Default: Regular instance creation.

Restore: Creates an instance by restoring a set of backups to specific point in time. RestorePointInTime and SourceManagedInstanceId must be specified.
*/
    enum ManagedServerCreateMode {
        "Default", "PointInTimeRestore"
    }

/**
* The license type. Possible values are 'LicenseIncluded' (regular price inclusive of a new SQL license) and 'BasePrice' (discounted AHB price for bringing your own SQL licenses).
*/
    enum ManagedInstanceLicenseType {
        "LicenseIncluded", "BasePrice"
    }

/**
* Connection type used for connecting to the instance.
*/
    enum ManagedInstanceProxyOverride {
        "Proxy", "Redirect", "Default"
    }

/**
* Principal Type of the sever administrator.
*/
    enum PrincipalType {
        "User", "Group", "Application"
    }

/**
* Service principal type.
*/
    enum ServicePrincipalType {
        "None", "SystemAssigned"
    }


    enum AggregationFunctionType {
        "avg", "min", "max", "stdev", "sum"
    }


    enum MetricType {
        "cpu", "io", "logIo", "duration", "dtu"
    }

/**
* Specifies the state of ledger digest upload.
*/
    enum ManagedLedgerDigestUploadsState {
        "Enabled", "Disabled"
    }


    enum ManagedLedgerDigestUploadsName {
        "current"
    }


    enum ServerConfigurationOptionName {
        "allowPolybaseExport"
    }


    enum StartStopScheduleName {
        "default"
    }


    enum BaselineName {
        "default"
    }

/**
* SQL Vulnerability Assessment baseline status
*/
    enum RuleStatus {
        "NonFinding", "Finding", "InternalError"
    }

/**
* SQL Vulnerability Assessment rule severity.
*/
    enum RuleSeverity {
        "High", "Medium", "Low", "Informational", "Obsolete"
    }

/**
* SQL Vulnerability Assessment rule type.
*/
    enum RuleType {
        "Binary", "BaselineExpected", "PositiveList", "NegativeList"
    }

/**
* Whether or not public endpoint access is allowed for this server.  Value is optional but if passed in, must be 'Enabled' or 'Disabled' or 'SecuredByPerimeter'
*/
    enum ServerPublicNetworkAccessFlag {
        "Enabled", "Disabled", "SecuredByPerimeter"
    }

/**
* Whether or not existing server has a workspace created and if it allows connection from workspace
*/
    enum ServerWorkspaceFeature {
        "Connected", "Disconnected"
    }

/**
* Whether or not to restrict outbound network access for this server.  Value is optional but if passed in, must be 'Enabled' or 'Disabled'
*/
    enum ServerNetworkAccessFlag {
        "Enabled", "Disabled", "SecuredByPerimeter"
    }

/**
* Status of external governance.
*/
    enum ExternalGovernanceStatus {
        "Enabled", "Disabled"
    }

/**
* Local replication role of the failover group instance.
*/
    enum FailoverGroupReplicationRole {
        "Primary", "Secondary"
    }

/**
* The serviceLevelObjective for SLO usage metric.
*/
    enum ServiceObjectiveName {
        "System", "System0", "System1", "System2", "System3", "System4", "System2L", "System3L", "System4L", "Free", "Basic", "S0", "S1", "S2", "S3", "S4", "S6", "S7", "S9", "S12", "P1", "P2", "P3", "P4", "P6", "P11", "P15", "PRS1", "PRS2", "PRS4", "PRS6", "DW100", "DW200", "DW300", "DW400", "DW500", "DW600", "DW1000", "DW1200", "DW1000c", "DW1500", "DW1500c", "DW2000", "DW2000c", "DW3000", "DW2500c", "DW3000c", "DW6000", "DW5000c", "DW6000c", "DW7500c", "DW10000c", "DW15000c", "DW30000c", "DS100", "DS200", "DS300", "DS400", "DS500", "DS600", "DS1000", "DS1200", "DS1500", "DS2000", "ElasticPool"
    }

/**
* The state of the data masking policy.
*/@fixed
    enum DataMaskingState {
        "Disabled", "Enabled"
    }

/**
* The rule state. Used to delete a rule. To delete an existing rule, specify the schemaName, tableName, columnName, maskingFunction, and specify ruleState as disabled. However, if the rule doesn't already exist, the rule will be created with ruleState set to enabled, regardless of the provided value of ruleState.
*/@fixed
    enum DataMaskingRuleState {
        "Disabled", "Enabled"
    }

/**
* The masking function that is used for the data masking rule.
*/@fixed
    enum DataMaskingFunction {
        "Default", "CCN", "Email", "Number", "SSN", "Text"
    }

/**
* The state of the geo backup policy.
*/@fixed
    enum GeoBackupPolicyState {
        "Disabled", "Enabled"
    }

/**
* Gets the status of availability of this advisor to customers. Possible values are 'GA', 'PublicPreview', 'LimitedPublicPreview' and 'PrivatePreview'.
*/@fixed
    enum AdvisorStatus {
        "GA", "PublicPreview", "LimitedPublicPreview", "PrivatePreview"
    }

/**
* Gets the auto-execute status (whether to let the system execute the recommendations) of this advisor. Possible values are 'Enabled' and 'Disabled'
*/@fixed
    enum AutoExecuteStatus {
        "Enabled", "Disabled", "Default"
    }

/**
* Gets the resource from which current value of auto-execute status is inherited. Auto-execute status can be set on (and inherited from) different levels in the resource hierarchy. Possible values are 'Subscription', 'Server', 'ElasticPool', 'Database' and 'Default' (when status is not explicitly set on any level).
*/@fixed
    enum AutoExecuteStatusInheritedFrom {
        "Default", "Subscription", "Server", "ElasticPool", "Database"
    }

/**
* Gets if approval for applying this recommended action was given by user/system.
*/@fixed
    enum RecommendedActionInitiatedBy {
        "User", "System"
    }

/**
* Gets the method in which this recommended action can be manually implemented. e.g., TSql, AzurePowerShell.
*/@fixed
    enum ImplementationMethod {
        "TSql", "AzurePowerShell"
    }

/**
* Gets whether the error could be ignored and recommended action could be retried. Possible values are: Yes/No
*/@fixed
    enum IsRetryable {
        "Yes", "No"
    }

/**
* Automatic tuning desired state.
*/@fixed
    enum AutomaticTuningMode {
        "Inherit", "Custom", "Auto", "Unspecified"
    }

/**
* Automatic tuning option desired state.
*/@fixed
    enum AutomaticTuningOptionModeDesired {
        "Off", "On", "Default"
    }

/**
* Automatic tuning option actual state.
*/@fixed
    enum AutomaticTuningOptionModeActual {
        "Off", "On"
    }

/**
* Reason description if desired and actual state are different.
*/@fixed
    enum AutomaticTuningDisabledReason {
        "Default", "Disabled", "AutoConfigured", "InheritedFromServer", "QueryStoreOff", "QueryStoreReadOnly", "NotSupported"
    }

/**
* Specifies the state of the policy, whether it is enabled or disabled or a policy has not been applied yet on the specific database.
*/@fixed
    enum SecurityAlertsPolicyState {
        "Enabled", "Disabled"
    }

@fixed
    enum VulnerabilityAssessmentPolicyBaselineName {
        "master", "default"
    }

/**
* Schedule interval type
*/@fixed
    enum JobScheduleType {
        "Once", "Recurring"
    }

/**
* Whether the target is included or excluded from the group.
*/@fixed
    enum JobTargetGroupMembershipType {
        "Include", "Exclude"
    }

/**
* The status of the capability.
*/@fixed
    enum CapabilityStatus {
        "Visible", "Available", "Default", "Disabled"
    }

/**
* Specifies the state of the policy, whether it is enabled or disabled or a policy has not been applied yet on the specific database.
*/@fixed
    enum SecurityAlertPolicyState {
        "New", "Enabled", "Disabled"
    }

/**
* The type of the security event.
*/@fixed
    enum SecurityEventType {
        "Undefined", "SqlInjectionVulnerability", "SqlInjectionExploit"
    }

/**
* Specifies the state of the transparent data encryption.
*/@fixed
    enum TransparentDataEncryptionState {
        "Enabled", "Disabled"
    }

/**
* The type of restore point
*/@fixed
    enum RestorePointType {
        "CONTINUOUS", "DISCRETE"
    }

/**
* Automatic tuning desired state.
*/@fixed
    enum AutomaticTuningServerMode {
        "Custom", "Auto", "Unspecified"
    }

/**
* Reason description if desired and actual state are different.
*/@fixed
    enum AutomaticTuningServerReason {
        "Default", "Disabled", "AutoConfigured"
    }

/**
* Specifies the state of the audit. If state is Enabled, storageEndpoint or isAzureMonitorTargetEnabled are required.
*/@fixed
    enum BlobAuditingPolicyState {
        "Enabled", "Disabled"
    }

/**
* Specifies the state of ledger digest upload.
*/@fixed
    enum LedgerDigestUploadsState {
        "Enabled", "Disabled"
    }

@fixed
    enum SensitivityLabelSource {
        "current", "recommended"
    }

@fixed
    enum SensitivityLabelRank {
        "None", "Low", "Medium", "High", "Critical"
    }

@fixed
    enum SensitivityLabelUpdateKind {
        "set", "remove"
    }

@fixed
    enum RecommendedSensitivityLabelUpdateKind {
        "enable", "disable"
    }

/**
* Specifies the state of the Advanced Threat Protection, whether it is enabled or disabled or a state has not been applied yet on the specific database or server.
*/@fixed
    enum AdvancedThreatProtectionState {
        "New", "Enabled", "Disabled"
    }

/**
* Local replication role.
*/@fixed
    enum ReplicationRole {
        "Primary", "Secondary", "NonReadableSecondary", "Source", "Copy"
    }

/**
* Specifies the state of the SQL Vulnerability Assessment, whether it is enabled or disabled or a state has not been applied yet on the specific database or server.
*/@fixed
    enum SqlVulnerabilityAssessmentState {
        "Enabled", "Disabled"
    }




/**
* The properties of a database data masking policy.
*/
model DataMaskingPolicyProperties {
/**
* The state of the data masking policy.
*/
"dataMaskingState": DataMaskingState;
/**
* The list of the exempt principals. Specifies the semicolon-separated list of database users for which the data masking policy does not apply. The specified users receive data results without masking for all of the database queries.
*/
"exemptPrincipals"?: string;
/**
* The list of the application principals. This is a legacy parameter and is no longer used.
*/
@visibility("read")
"applicationPrincipals"?: string;
/**
* The masking level. This is a legacy parameter and is no longer used.
*/
@visibility("read")
"maskingLevel"?: string;
}

/**
* ARM resource.
*/
model Resource {
/**
* Resource ID.
*/
@visibility("read")
"id"?: string;
/**
* Resource name.
*/
@visibility("read")
"name"?: string;
/**
* Resource type.
*/
@visibility("read")
"type"?: string;
}

/**
* Represents a database data masking rule.
*/
model DataMaskingRule{
/**
* The properties of the resource.
*/
"properties"?: DataMaskingRuleProperties;
/**
* The location of the data masking rule.
*/
@visibility("read")
"location"?: string;
/**
* The kind of Data Masking Rule. Metadata, used for Azure portal.
*/
@visibility("read")
"kind"?: string;
}

/**
* The properties of a database data masking rule.
*/
model DataMaskingRuleProperties {
/**
* The alias name. This is a legacy parameter and is no longer used.
*/
"aliasName"?: string;
/**
* The rule state. Used to delete a rule. To delete an existing rule, specify the schemaName, tableName, columnName, maskingFunction, and specify ruleState as disabled. However, if the rule doesn't already exist, the rule will be created with ruleState set to enabled, regardless of the provided value of ruleState.
*/
"ruleState"?: DataMaskingRuleState;
/**
* The schema name on which the data masking rule is applied.
*/
"schemaName": string;
/**
* The table name on which the data masking rule is applied.
*/
"tableName": string;
/**
* The column name on which the data masking rule is applied.
*/
"columnName": string;
/**
* The masking function that is used for the data masking rule.
*/
"maskingFunction": DataMaskingFunction;
/**
* The numberFrom property of the masking rule. Required if maskingFunction is set to Number, otherwise this parameter will be ignored.
*/
"numberFrom"?: string;
/**
* The numberTo property of the data masking rule. Required if maskingFunction is set to Number, otherwise this parameter will be ignored.
*/
"numberTo"?: string;
/**
* If maskingFunction is set to Text, the number of characters to show unmasked in the beginning of the string. Otherwise, this parameter will be ignored.
*/
"prefixSize"?: string;
/**
* If maskingFunction is set to Text, the number of characters to show unmasked at the end of the string. Otherwise, this parameter will be ignored.
*/
"suffixSize"?: string;
/**
* If maskingFunction is set to Text, the character to use for masking the unexposed part of the string. Otherwise, this parameter will be ignored.
*/
"replacementString"?: string;
}

/**
* The response to a list data masking rules request.
*/
@pagedResult
model DataMaskingRuleListResult {
/**
* The list of database data masking rules.
*/
@items
"value"?: DataMaskingRule[];
}

/**
* The properties of the geo backup policy.
*/
model GeoBackupPolicyProperties {
/**
* The state of the geo backup policy.
*/
"state": GeoBackupPolicyState;
/**
* The storage type of the geo backup policy.
*/
@visibility("read")
"storageType"?: string;
}

/**
* The response to a list database metrics request.
*/
@pagedResult
model MetricListResult {
/**
* The list of metrics for the database.
*/
@items
"value": Metric[];
}

/**
* Database metrics.
*/
model Metric {
/**
* The start time for the metric (ISO-8601 format).
*/
@visibility("read")
// FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
"startTime"?: utcDateTime;
/**
* The end time for the metric (ISO-8601 format).
*/
@visibility("read")
// FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
"endTime"?: utcDateTime;
/**
* The time step to be used to summarize the metric values.
*/
@visibility("read")
"timeGrain"?: string;
/**
* The unit of the metric.
*/
@visibility("read")
"unit"?: UnitType;
/**
* The name information for the metric.
*/
@visibility("read")
"name"?: MetricName;
/**
* The metric values for the specified time window and timestep.
*/
@visibility("read")
"metricValues"?: MetricValue[];
}

/**
* A database metric name.
*/
model MetricName {
/**
* The name of the database metric.
*/
@visibility("read")
"value"?: string;
/**
* The friendly name of the database metric.
*/
@visibility("read")
"localizedValue"?: string;
}

/**
* Represents database metrics.
*/
model MetricValue {
/**
* The number of values for the metric.
*/
@visibility("read")
"count"?: int32;
/**
* The average value of the metric.
*/
@visibility("read")
"average"?: float64;
/**
* The max value of the metric.
*/
@visibility("read")
"maximum"?: float64;
/**
* The min value of the metric.
*/
@visibility("read")
"minimum"?: float64;
/**
* The metric timestamp (ISO-8601 format).
*/
@visibility("read")
// FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
"timestamp"?: utcDateTime;
/**
* The total value of the metric.
*/
@visibility("read")
"total"?: float64;
}

/**
* The response to a list database metric definitions request.
*/
@pagedResult
model MetricDefinitionListResult {
/**
* The list of metric definitions for the database.
*/
@items
"value": MetricDefinition[];
}

/**
* A database metric definition.
*/
model MetricDefinition {
/**
* The name information for the metric.
*/
@visibility("read")
"name"?: MetricName;
/**
* The primary aggregation type defining how metric values are displayed.
*/
@visibility("read")
"primaryAggregationType"?: PrimaryAggregationType;
/**
* The resource uri of the database.
*/
@visibility("read")
"resourceUri"?: string;
/**
* The unit of the metric.
*/
@visibility("read")
"unit"?: UnitDefinitionType;
/**
* The list of database metric availabilities for the metric.
*/
@visibility("read")
"metricAvailabilities"?: MetricAvailability[];
}

/**
* A metric availability value.
*/
model MetricAvailability {
/**
* The length of retention for the database metric.
*/
@visibility("read")
"retention"?: string;
/**
* The granularity of the database metric.
*/
@visibility("read")
"timeGrain"?: string;
}

/**
* The properties of a server communication link.
*/
model ServerCommunicationLinkProperties {
/**
* The state.
*/
@visibility("read")
"state"?: string;
/**
* The name of the partner server.
*/
@visibility("read", "create")
"partnerServer": string;
}

/**
* Represents the properties of a database service objective.
*/
model ServiceObjectiveProperties {
/**
* The name for the service objective.
*/
@visibility("read")
"serviceObjectiveName"?: string;
/**
* Gets whether the service level objective is the default service objective.
*/
@visibility("read")
"isDefault"?: boolean;
/**
* Gets whether the service level objective is a system service objective.
*/
@visibility("read")
"isSystem"?: boolean;
/**
* The description for the service level objective.
*/
@visibility("read")
"description"?: string;
/**
* Gets whether the service level objective is enabled.
*/
@visibility("read")
@projectedName("json", "enabled")
"IsEnabled"?: boolean;
}

/**
* Represents the response to a list elastic pool activity request.
*/
@pagedResult
model ElasticPoolActivityListResult {
/**
* The list of elastic pool activities.
*/
@items
"value": ElasticPoolActivity[];
}

/**
* Represents the activity on an elastic pool.
*/
model ElasticPoolActivity {
/**
* The geo-location where the resource lives
*/
@visibility("read", "create")
"location"?: string;
/**
* The properties representing the resource.
*/
"properties"?: ElasticPoolActivityProperties;
}

/**
* Represents the properties of an elastic pool.
*/
model ElasticPoolActivityProperties {
/**
* The time the operation finished (ISO8601 format).
*/
@visibility("read")
// FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
"endTime"?: utcDateTime;
/**
* The error code if available.
*/
@visibility("read")
"errorCode"?: int32;
/**
* The error message if available.
*/
@visibility("read")
"errorMessage"?: string;
/**
* The error severity if available.
*/
@visibility("read")
"errorSeverity"?: int32;
/**
* The operation name.
*/
@visibility("read")
"operation"?: string;
/**
* The unique operation ID.
*/
@visibility("read")
"operationId"?: string;
/**
* The percentage complete if available.
*/
@visibility("read")
"percentComplete"?: int32;
/**
* The requested max DTU per database if available.
*/
@visibility("read")
"requestedDatabaseDtuMax"?: int32;
/**
* The requested min DTU per database if available.
*/
@visibility("read")
"requestedDatabaseDtuMin"?: int32;
/**
* The requested DTU for the pool if available.
*/
@visibility("read")
"requestedDtu"?: int32;
/**
* The requested name for the elastic pool if available.
*/
@visibility("read")
"requestedElasticPoolName"?: string;
/**
* The requested storage limit for the pool in GB if available.
*/
@visibility("read")
"requestedStorageLimitInGB"?: int64;
/**
* The name of the elastic pool.
*/
@visibility("read")
"elasticPoolName"?: string;
/**
* The name of the server the elastic pool is in.
*/
@visibility("read")
"serverName"?: string;
/**
* The time the operation started (ISO8601 format).
*/
@visibility("read")
// FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
"startTime"?: utcDateTime;
/**
* The current state of the operation.
*/
@visibility("read")
"state"?: string;
/**
* The requested storage limit in MB.
*/
@visibility("read")
"requestedStorageLimitInMB"?: int32;
/**
* The requested per database DTU guarantee.
*/
@visibility("read")
"requestedDatabaseDtuGuarantee"?: int32;
/**
* The requested per database DTU cap.
*/
@visibility("read")
"requestedDatabaseDtuCap"?: int32;
/**
* The requested DTU guarantee.
*/
@visibility("read")
"requestedDtuGuarantee"?: int32;
}

/**
* Represents the response to a list elastic pool database activity request.
*/
@pagedResult
model ElasticPoolDatabaseActivityListResult {
/**
* The list of elastic pool database activities.
*/
@items
"value": ElasticPoolDatabaseActivity[];
}

/**
* Represents the activity on an elastic pool.
*/
model ElasticPoolDatabaseActivity{
/**
* The geo-location where the resource lives
*/
@visibility("read", "create")
"location"?: string;
/**
* The properties representing the resource.
*/
"properties"?: ElasticPoolDatabaseActivityProperties;
}

/**
* Represents the properties of an elastic pool database activity.
*/
model ElasticPoolDatabaseActivityProperties {
/**
* The database name.
*/
@visibility("read")
"databaseName"?: string;
/**
* The time the operation finished (ISO8601 format).
*/
@visibility("read")
// FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
"endTime"?: utcDateTime;
/**
* The error code if available.
*/
@visibility("read")
"errorCode"?: int32;
/**
* The error message if available.
*/
@visibility("read")
"errorMessage"?: string;
/**
* The error severity if available.
*/
@visibility("read")
"errorSeverity"?: int32;
/**
* The operation name.
*/
@visibility("read")
"operation"?: string;
/**
* The unique operation ID.
*/
@visibility("read")
"operationId"?: string;
/**
* The percentage complete if available.
*/
@visibility("read")
"percentComplete"?: int32;
/**
* The name for the elastic pool the database is moving into if available.
*/
@visibility("read")
"requestedElasticPoolName"?: string;
/**
* The name of the current elastic pool the database is in if available.
*/
@visibility("read")
"currentElasticPoolName"?: string;
/**
* The name of the current service objective if available.
*/
@visibility("read")
"currentServiceObjective"?: string;
/**
* The name of the requested service objective if available.
*/
@visibility("read")
"requestedServiceObjective"?: string;
/**
* The name of the server the elastic pool is in.
*/
@visibility("read")
"serverName"?: string;
/**
* The time the operation started (ISO8601 format).
*/
@visibility("read")
// FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
"startTime"?: utcDateTime;
/**
* The current state of the operation.
*/
@visibility("read")
"state"?: string;
}

/**
* Represents the response to a list server metrics request.
*/
@pagedResult
model ServerUsageListResult {
/**
* The list of server metrics for the server.
*/
@items
"value": ServerUsage[];
}

/**
* Represents server metrics.
*/
model ServerUsage {
/**
* Name of the server usage metric.
*/
@visibility("read")
"name"?: string;
/**
* The name of the resource.
*/
@visibility("read")
"resourceName"?: string;
/**
* The metric display name.
*/
@visibility("read")
"displayName"?: string;
/**
* The current value of the metric.
*/
@visibility("read")
"currentValue"?: float64;
/**
* The current limit of the metric.
*/
@visibility("read")
"limit"?: float64;
/**
* The units of the metric.
*/
@visibility("read")
"unit"?: string;
/**
* The next reset time for the metric (ISO8601 format).
*/
@visibility("read")
// FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
"nextResetTime"?: utcDateTime;
}

/**
* Properties for a Database, Server or Elastic Pool Advisor.
*/
model AdvisorProperties {
/**
* Gets the status of availability of this advisor to customers. Possible values are 'GA', 'PublicPreview', 'LimitedPublicPreview' and 'PrivatePreview'.
*/
@visibility("read")
"advisorStatus"?: AdvisorStatus;
/**
* Gets the auto-execute status (whether to let the system execute the recommendations) of this advisor. Possible values are 'Enabled' and 'Disabled'
*/
"autoExecuteStatus": AutoExecuteStatus;
/**
* Gets the resource from which current value of auto-execute status is inherited. Auto-execute status can be set on (and inherited from) different levels in the resource hierarchy. Possible values are 'Subscription', 'Server', 'ElasticPool', 'Database' and 'Default' (when status is not explicitly set on any level).
*/
@visibility("read")
"autoExecuteStatusInheritedFrom"?: AutoExecuteStatusInheritedFrom;
/**
* Gets that status of recommendations for this advisor and reason for not having any recommendations. Possible values include, but are not limited to, 'Ok' (Recommendations available),LowActivity (not enough workload to analyze), 'DbSeemsTuned' (Database is doing well), etc.
*/
@visibility("read")
"recommendationsStatus"?: string;
/**
* Gets the time when the current resource was analyzed for recommendations by this advisor.
*/
@visibility("read")
@projectedName("json", "lastChecked")
// FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
"lastCheckedOn"?: utcDateTime;
/**
* Gets the recommended actions for this advisor.
*/
@visibility("read")
"recommendedActions"?: RecommendedAction[];
}

/**
* Properties for a Database, Server or Elastic Pool Recommended Action.
*/
model RecommendedActionProperties {
/**
* Gets the reason for recommending this action. e.g., DuplicateIndex
*/
@visibility("read")
"recommendationReason"?: string;
/**
* Gets the time since when this recommended action is valid.
*/
@visibility("read")
// FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
"validSince"?: utcDateTime;
/**
* Gets time when this recommended action was last refreshed.
*/
@visibility("read")
// FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
"lastRefresh"?: utcDateTime;
/**
* Gets the info of the current state the recommended action is in.
*/
"state": RecommendedActionStateInfo;
/**
* Gets if this recommended action is actionable by user
*/
@visibility("read")
"isExecutableAction"?: boolean;
/**
* Gets if changes applied by this recommended action can be reverted by user
*/
@visibility("read")
"isRevertableAction"?: boolean;
/**
* Gets if this recommended action was suggested some time ago but user chose to ignore this and system added a new recommended action again.
*/
@visibility("read")
"isArchivedAction"?: boolean;
/**
* Gets the time when system started applying this recommended action on the user resource. e.g., index creation start time
*/
@visibility("read")
// FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
"executeActionStartTime"?: utcDateTime;
/**
* Gets the time taken for applying this recommended action on user resource. e.g., time taken for index creation
*/
@visibility("read")
"executeActionDuration"?: duration;
/**
* Gets the time when system started reverting changes of this recommended action on user resource. e.g., time when index drop is executed.
*/
@visibility("read")
// FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
"revertActionStartTime"?: utcDateTime;
/**
* Gets the time taken for reverting changes of this recommended action on user resource. e.g., time taken for dropping the created index.
*/
@visibility("read")
"revertActionDuration"?: duration;
/**
* Gets if approval for applying this recommended action was given by user/system.
*/
@visibility("read")
"executeActionInitiatedBy"?: RecommendedActionInitiatedBy;
/**
* Gets the time when this recommended action was approved for execution.
*/
@visibility("read")
// FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
"executeActionInitiatedTime"?: utcDateTime;
/**
* Gets if approval for reverting this recommended action was given by user/system.
*/
@visibility("read")
"revertActionInitiatedBy"?: RecommendedActionInitiatedBy;
/**
* Gets the time when this recommended action was approved for revert.
*/
@visibility("read")
// FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
"revertActionInitiatedTime"?: utcDateTime;
/**
* Gets the impact of this recommended action. Possible values are 1 - Low impact, 2 - Medium Impact and 3 - High Impact
*/
@visibility("read")
"score"?: int32;
/**
* Gets the implementation details of this recommended action for user to apply it manually.
*/
@visibility("read")
"implementationDetails"?: RecommendedActionImplementationInfo;
/**
* Gets the error details if and why this recommended action is put to error state.
*/
@visibility("read")
"errorDetails"?: RecommendedActionErrorInfo;
/**
* Gets the estimated impact info for this recommended action e.g., Estimated CPU gain, Estimated Disk Space change
*/
@visibility("read")
"estimatedImpact"?: RecommendedActionImpactRecord[];
/**
* Gets the observed/actual impact info for this recommended action e.g., Actual CPU gain, Actual Disk Space change
*/
@visibility("read")
"observedImpact"?: RecommendedActionImpactRecord[];
/**
* Gets the time series info of metrics for this recommended action e.g., CPU consumption time series
*/
@visibility("read")
"timeSeries"?: RecommendedActionMetricInfo[];
/**
* Gets the linked objects, if any.
*/
@visibility("read")
"linkedObjects"?: string[];
/**
* Gets additional details specific to this recommended action.
*/
@visibility("read")
"details"?: Record<Record<unknown>>;
}

/**
* Contains information of current state for an Azure SQL Database, Server or Elastic Pool Recommended Action.
*/
model RecommendedActionStateInfo {
/**
* Current state the recommended action is in. Some commonly used states are: Active      -> recommended action is active and no action has been taken yet. Pending     -> recommended action is approved for and is awaiting execution. Executing   -> recommended action is being applied on the user database. Verifying   -> recommended action was applied and is being verified of its usefulness by the system. Success     -> recommended action was applied and improvement found during verification. Pending Revert  -> verification found little or no improvement so recommended action is queued for revert or user has manually reverted. Reverting   -> changes made while applying recommended action are being reverted on the user database. Reverted    -> successfully reverted the changes made by recommended action on user database. Ignored     -> user explicitly ignored/discarded the recommended action. 
*/
"currentValue": RecommendedActionCurrentState;
/**
* Gets who initiated the execution of this recommended action. Possible Value are: User    -> When user explicity notified system to apply the recommended action. System  -> When auto-execute status of this advisor was set to 'Enabled', in which case the system applied it.
*/
@visibility("read")
"actionInitiatedBy"?: RecommendedActionInitiatedBy;
/**
* Gets the time when the state was last modified
*/
@visibility("read")
// FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
"lastModified"?: utcDateTime;
}

/**
* Contains information for manual implementation for an Azure SQL Database, Server or Elastic Pool Recommended Action.
*/
model RecommendedActionImplementationInfo {
/**
* Gets the method in which this recommended action can be manually implemented. e.g., TSql, AzurePowerShell.
*/
@visibility("read")
"method"?: ImplementationMethod;
/**
* Gets the manual implementation script. e.g., T-SQL script that could be executed on the database.
*/
@visibility("read")
"script"?: string;
}

/**
* Contains error information for an Azure SQL Database, Server or Elastic Pool Recommended Action.
*/
model RecommendedActionErrorInfo {
/**
* Gets the reason why the recommended action was put to error state. e.g., DatabaseHasQdsOff, IndexAlreadyExists
*/
@visibility("read")
"errorCode"?: string;
/**
* Gets whether the error could be ignored and recommended action could be retried. Possible values are: Yes/No
*/
@visibility("read")
"isRetryable"?: IsRetryable;
}

/**
* Contains information of estimated or observed impact on various metrics for an Azure SQL Database, Server or Elastic Pool Recommended Action.
*/
model RecommendedActionImpactRecord {
/**
* Gets the name of the impact dimension. e.g., CPUChange, DiskSpaceChange, NumberOfQueriesAffected.
*/
@visibility("read")
"dimensionName"?: string;
/**
* Gets the name of the impact dimension. e.g., CPUChange, DiskSpaceChange, NumberOfQueriesAffected.
*/
@visibility("read")
"unit"?: string;
/**
* Gets the absolute value of this dimension if applicable. e.g., Number of Queries affected
*/
@visibility("read")
"absoluteValue"?: float64;
/**
* Gets the absolute change in the value of this dimension. e.g., Absolute Disk space change in Megabytes
*/
@visibility("read")
"changeValueAbsolute"?: float64;
/**
* Gets the relative change in the value of this dimension. e.g., Relative Disk space change in Percentage
*/
@visibility("read")
"changeValueRelative"?: float64;
}

/**
* Contains time series of various impacted metrics for an Azure SQL Database, Server or Elastic Pool Recommended Action.
*/
model RecommendedActionMetricInfo {
/**
* Gets the name of the metric. e.g., CPU, Number of Queries.
*/
@visibility("read")
"metricName"?: string;
/**
* Gets the unit in which metric is measured. e.g., DTU, Frequency
*/
@visibility("read")
"unit"?: string;
/**
* Gets the duration of time interval for the value given by this MetricInfo. e.g., PT1H (1 hour)
*/
@visibility("read")
"timeGrain"?: string;
/**
* Gets the start time of time interval given by this MetricInfo.
*/
@visibility("read")
// FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
"startTime"?: utcDateTime;
/**
* Gets the value of the metric in the time interval given by this MetricInfo.
*/
@visibility("read")
"value"?: float64;
}

/**
* Database-level Automatic Tuning properties.
*/
model DatabaseAutomaticTuningProperties {
/**
* Automatic tuning desired state.
*/
"desiredState"?: AutomaticTuningMode;
/**
* Automatic tuning actual state.
*/
@visibility("read")
"actualState"?: AutomaticTuningMode;
/**
* Automatic tuning options definition.
*/
"options"?: Record<AutomaticTuningOptions>;
}

/**
* Automatic tuning properties for individual advisors.
*/
model AutomaticTuningOptions {
/**
* Automatic tuning option desired state.
*/
"desiredState"?: AutomaticTuningOptionModeDesired;
/**
* Automatic tuning option actual state.
*/
@visibility("read")
"actualState"?: AutomaticTuningOptionModeActual;
/**
* Reason code if desired and actual state are different.
*/
@visibility("read")
"reasonCode"?: int32;
/**
* Reason description if desired and actual state are different.
*/
@visibility("read")
"reasonDesc"?: AutomaticTuningDisabledReason;
}

/**
* Database column properties.
*/
model DatabaseColumnProperties {
/**
* The column data type.
*/
"columnType"?: ColumnDataType;
/**
* The table temporal type.
*/
"temporalType"?: TableTemporalType;
/**
* Whether or not the column belongs to a memory optimized table.
*/
@projectedName("json", "memoryOptimized")
"IsMemoryOptimized"?: boolean;
/**
* Whether or not the column is computed.
*/
"isComputed"?: boolean;
}

/**
* Properties of a security alert policy.
*/
model SecurityAlertsPolicyProperties {
/**
* Specifies the state of the policy, whether it is enabled or disabled or a policy has not been applied yet on the specific database.
*/
"state": SecurityAlertsPolicyState;
/**
* Specifies an array of alerts that are disabled. Allowed values are: Sql_Injection, Sql_Injection_Vulnerability, Access_Anomaly, Data_Exfiltration, Unsafe_Action, Brute_Force
*/
"disabledAlerts"?: string[];
/**
* Specifies an array of e-mail addresses to which the alert is sent.
*/
"emailAddresses"?: string[];
/**
* Specifies that the alert is sent to the account administrators.
*/
@projectedName("json", "emailAccountAdmins")
"sendToEmailAccountAdmins"?: boolean;
/**
* Specifies the blob storage endpoint (e.g. https://MyAccount.blob.core.windows.net). This blob storage will hold all Threat Detection audit logs.
*/
"storageEndpoint"?: string;
/**
* Specifies the identifier key of the Threat Detection audit storage account.
*/
"storageAccountAccessKey"?: string;
/**
* Specifies the number of days to keep in the Threat Detection audit logs.
*/
"retentionDays"?: int32;
/**
* Specifies the UTC creation time of the policy.
*/
@visibility("read")
// FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
"creationTime"?: utcDateTime;
}

/**
* Database table properties.
*/
model DatabaseTableProperties {
/**
* The table temporal type.
*/
"temporalType"?: TableTemporalType;
/**
* Whether or not the table is memory optimized.
*/
@projectedName("json", "memoryOptimized")
"IsMemoryOptimized"?: boolean;
}

/**
* Properties of a database Vulnerability Assessment rule baseline.
*/
model DatabaseVulnerabilityAssessmentRuleBaselineProperties {
/**
* The rule baseline result
*/
"baselineResults": DatabaseVulnerabilityAssessmentRuleBaselineItem[];
}

/**
* Properties for an Azure SQL Database Vulnerability Assessment rule baseline's result.
*/
model DatabaseVulnerabilityAssessmentRuleBaselineItem {
/**
* The rule baseline result
*/
"result": string[];
}

/**
* Properties of a database Vulnerability Assessment.
*/
model DatabaseVulnerabilityAssessmentProperties {
/**
* A blob storage container path to hold the scan results (e.g. https://myStorage.blob.core.windows.net/VaScans/).  It is required if server level vulnerability assessment policy doesn't set
*/
@visibility("create", "update")
"storageContainerPath"?: string;
/**
* A shared access signature (SAS Key) that has write access to the blob container specified in 'storageContainerPath' parameter. If 'storageAccountAccessKey' isn't specified, StorageContainerSasKey is required.
*/
@visibility("create", "update")
"storageContainerSasKey"?: string;
/**
* Specifies the identifier key of the storage account for vulnerability assessment scan results. If 'StorageContainerSasKey' isn't specified, storageAccountAccessKey is required.
*/
@visibility("create", "update")
"storageAccountAccessKey"?: string;
/**
* The recurring scans settings
*/
"recurringScans"?: VulnerabilityAssessmentRecurringScansProperties;
}

/**
* Properties of a Vulnerability Assessment recurring scans.
*/
model VulnerabilityAssessmentRecurringScansProperties {
/**
* Recurring scans state.
*/
"isEnabled"?: boolean;
/**
* Specifies that the schedule scan notification will be is sent to the subscription administrators.
*/
"emailSubscriptionAdmins"?: boolean = true;
/**
* Specifies an array of e-mail addresses to which the scan notification is sent.
*/
"emails"?: string[];
}

/**
* Properties of a vulnerability assessment scan record.
*/
model VulnerabilityAssessmentScanRecordProperties {
/**
* The scan ID.
*/
@visibility("read")
"scanId"?: string;
/**
* The scan trigger type.
*/
@visibility("read")
"triggerType"?: VulnerabilityAssessmentScanTriggerType;
/**
* The scan status.
*/
@visibility("read")
"state"?: VulnerabilityAssessmentScanState;
/**
* The scan start time (UTC).
*/
@visibility("read")
// FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
"startTime"?: utcDateTime;
/**
* The scan end time (UTC).
*/
@visibility("read")
// FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
"endTime"?: utcDateTime;
/**
* The scan errors.
*/
@visibility("read")
"errors"?: VulnerabilityAssessmentScanError[];
/**
* The scan results storage container path.
*/
@visibility("read")
"storageContainerPath"?: string;
/**
* The number of failed security checks.
*/
@visibility("read")
"numberOfFailedSecurityChecks"?: int32;
}

/**
* Properties of a vulnerability assessment scan error.
*/
model VulnerabilityAssessmentScanError {
/**
* The error code.
*/
@visibility("read")
"code"?: string;
/**
* The error message.
*/
@visibility("read")
"message"?: string;
}

/**
* A database Vulnerability Assessment scan export resource.
*/
model DatabaseVulnerabilityAssessmentScansExport {
/**
* Resource properties.
*/
"properties"?: DatabaseVulnerabilityAssessmentScanExportProperties;
}

/**
* Properties of the export operation's result.
*/
model DatabaseVulnerabilityAssessmentScanExportProperties {
/**
* Location of the exported report (e.g. https://myStorage.blob.core.windows.net/VaScans/scans/serverName/databaseName/scan_scanId.xlsx).
*/
@visibility("read")
"exportedReportLocation"?: string;
}

/**
* User activities of a data warehouse. This currently includes the count of running or suspended queries. For more information, please view the sys.dm_pdw_exec_requests dynamic management view (DMV).
*/
model DataWarehouseUserActivitiesProperties {
/**
* Count of running and suspended queries.
*/
@visibility("read")
"activeQueriesCount"?: int32;
}

/**
* The properties of a deleted server.
*/
model DeletedServerProperties {
/**
* The version of the deleted server.
*/
@visibility("read")
"version"?: string;
/**
* The deletion time of the deleted server.
*/
@visibility("read")
// FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
"deletionTime"?: utcDateTime;
/**
* The original ID of the server before deletion.
*/
@visibility("read")
"originalId"?: string;
/**
* The fully qualified domain name of the server.
*/
@visibility("read")
"fullyQualifiedDomainName"?: string;
}

/**
* The response to a list elastic pool operations request
*/
model ElasticPoolOperationListResult is Azure.Core.Page<ElasticPoolOperation> {
}

/**
* A elastic pool operation.
*/
model ElasticPoolOperation{
/**
* Resource properties.
*/
"properties"?: ElasticPoolOperationProperties;
}

/**
* The properties of a elastic pool operation.
*/
model ElasticPoolOperationProperties {
/**
* The name of the elastic pool the operation is being performed on.
*/
@visibility("read")
"elasticPoolName"?: string;
/**
* The name of operation.
*/
@visibility("read")
"operation"?: string;
/**
* The friendly name of operation.
*/
@visibility("read")
"operationFriendlyName"?: string;
/**
* The percentage of the operation completed.
*/
@visibility("read")
"percentComplete"?: int32;
/**
* The name of the server.
*/
@visibility("read")
"serverName"?: string;
/**
* The operation start time.
*/
@visibility("read")
// FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
"startTime"?: utcDateTime;
/**
* The operation state.
*/
@visibility("read")
"state"?: string;
/**
* The operation error code.
*/
@visibility("read")
"errorCode"?: int32;
/**
* The operation error description.
*/
@visibility("read")
"errorDescription"?: string;
/**
* The operation error severity.
*/
@visibility("read")
"errorSeverity"?: int32;
/**
* Whether or not the error is a user error.
*/
@visibility("read")
"isUserError"?: boolean;
/**
* The estimated completion time of the operation.
*/
@visibility("read")
@projectedName("json", "estimatedCompletionTime")
// FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
"estimatedCompleteOn"?: utcDateTime;
/**
* The operation description.
*/
@visibility("read")
"description"?: string;
/**
* Whether the operation can be cancelled.
*/
@visibility("read")
"isCancellable"?: boolean;
}

/**
* Properties for an encryption protector execution.
*/
model EncryptionProtectorProperties {
/**
* Subregion of the encryption protector.
*/
@visibility("read")
"subregion"?: string;
/**
* The name of the server key.
*/
"serverKeyName"?: string;
/**
* The encryption protector type like 'ServiceManaged', 'AzureKeyVault'.
*/
"serverKeyType": ServerKeyType;
/**
* The URI of the server key.
*/
@visibility("read")
"uri"?: string;
/**
* Thumbprint of the server key.
*/
@visibility("read")
"thumbprint"?: string;
/**
* Key auto rotation opt-in flag. Either true or false.
*/
@projectedName("json", "autoRotationEnabled")
"IsAutoRotationEnabled"?: boolean;
}

/**
* The properties of a server firewall rule.
*/
model ServerFirewallRuleProperties {
/**
* The start IP address of the firewall rule. Must be IPv4 format. Use value '0.0.0.0' for all Azure-internal IP addresses.
*/
"startIpAddress"?: string;
/**
* The end IP address of the firewall rule. Must be IPv4 format. Must be greater than or equal to startIpAddress. Use value '0.0.0.0' for all Azure-internal IP addresses.
*/
"endIpAddress"?: string;
}

/**
* ARM proxy resource.
*/
model ProxyResourceWithWritableName extends ResourceWithWritableName {
}

/**
* ARM resource.
*/
model ResourceWithWritableName {
/**
* Resource ID.
*/
@visibility("read")
"id"?: string;
/**
* Resource name.
*/
"name"?: string;
/**
* Resource type.
*/
@visibility("read")
"type"?: string;
}

/**
* An ARM Resource SKU.
*/
model Sku {
/**
* The name of the SKU, typically, a letter + Number code, e.g. P3.
*/
"name": string;
/**
* The tier or edition of the particular SKU, e.g. Basic, Premium.
*/
"tier"?: string;
/**
* Size of the particular SKU
*/
"size"?: string;
/**
* If the service has different generations of hardware, for the same SKU, then that can be captured here.
*/
"family"?: string;
/**
* Capacity of the particular SKU.
*/
"capacity"?: int32;
}

/**
* Properties of an instance pool.
*/
model InstancePoolProperties {
/**
* Resource ID of the subnet to place this instance pool in.
*/
@visibility("read", "create")
"subnetId": string;
/**
* Count of vCores belonging to this instance pool.
*/
@visibility("read", "create")
"vCores": int32;
/**
* The license type. Possible values are 'LicenseIncluded' (price for SQL license is included) and 'BasePrice' (without SQL license price).
*/
@visibility("read", "create")
"licenseType": InstancePoolLicenseType;
}

/**
* An update to an Instance pool.
*/
model InstancePoolUpdate {
/**
* Resource tags.
*/
"tags"?: Record<string>;
}

/**
* Properties of a job agent.
*/
model JobAgentProperties {
/**
* Resource ID of the database to store job metadata in.
*/
@visibility("read", "create")
"databaseId": string;
/**
* The state of the job agent.
*/
@visibility("read")
"state"?: JobAgentState;
}

/**
* An update to an Azure SQL job agent.
*/
model JobAgentUpdate {
/**
* Resource tags.
*/
"tags"?: Record<string>;
}

/**
* Properties of a job credential.
*/
model JobCredentialProperties {
/**
* The credential user name.
*/
"username": string;
/**
* The credential password.
*/
@visibility("create", "update")
"password": string;
}

/**
* Properties for an Azure SQL Database Elastic job execution.
*/
model JobExecutionProperties {
/**
* The job version number.
*/
@visibility("read")
"jobVersion"?: int32;
/**
* The job step name.
*/
@visibility("read")
"stepName"?: string;
/**
* The job step id.
*/
@visibility("read")
"stepId"?: int32;
/**
* The unique identifier of the job execution.
*/
@visibility("read")
"jobExecutionId"?: string;
/**
* The detailed state of the job execution.
*/
@visibility("read")
"lifecycle"?: JobExecutionLifecycle;
/**
* The ARM provisioning state of the job execution.
*/
@visibility("read")
"provisioningState"?: ProvisioningState;
/**
* The time that the job execution was created.
*/
@visibility("read")
// FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
"createTime"?: utcDateTime;
/**
* The time that the job execution started.
*/
@visibility("read")
// FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
"startTime"?: utcDateTime;
/**
* The time that the job execution completed.
*/
@visibility("read")
// FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
"endTime"?: utcDateTime;
/**
* Number of times the job execution has been attempted.
*/
"currentAttempts"?: int32;
/**
* Start time of the current attempt.
*/
@visibility("read")
// FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
"currentAttemptStartTime"?: utcDateTime;
/**
* The last status or error message.
*/
@visibility("read")
"lastMessage"?: string;
/**
* The target that this execution is executed on.
*/
@visibility("read")
"target"?: JobExecutionTarget;
}

/**
* The target that a job execution is executed on.
*/
model JobExecutionTarget {
/**
* The type of the target.
*/
@visibility("read")
"type"?: JobTargetType;
/**
* The server name.
*/
@visibility("read")
"serverName"?: string;
/**
* The database name.
*/
@visibility("read")
"databaseName"?: string;
}

/**
* Properties of a job.
*/
model JobProperties {
/**
* User-defined description of the job.
*/
"description"?: string;
/**
* The job version number.
*/
@visibility("read")
"version"?: int32;
/**
* Schedule properties of the job.
*/
"schedule"?: JobSchedule;
}

/**
* Scheduling properties of a job.
*/
model JobSchedule {
/**
* Schedule start time.
*/
// FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
"startTime"?: utcDateTime = utcDateTime.0001-01-01T00:00:00+00:00;
/**
* Schedule end time.
*/
// FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
"endTime"?: utcDateTime = utcDateTime.9999-12-31T11:59:59+00:00;
/**
* Schedule interval type
*/
"type"?: JobScheduleType = JobScheduleType.Once;
/**
* Whether or not the schedule is enabled.
*/
@projectedName("json", "enabled")
"IsEnabled"?: boolean;
/**
* Value of the schedule's recurring interval, if the ScheduleType is recurring. ISO8601 duration format.
*/
"interval"?: duration;
}

/**
* Properties of a job step.
*/
model JobStepProperties {
/**
* The job step's index within the job. If not specified when creating the job step, it will be created as the last step. If not specified when updating the job step, the step id is not modified.
*/
"stepId"?: int32;
/**
* The resource ID of the target group that the job step will be executed on.
*/
"targetGroup": string;
/**
* The resource ID of the job credential that will be used to connect to the targets.
*/
"credential": string;
/**
* The action payload of the job step.
*/
"action": JobStepAction;
/**
* Output destination properties of the job step.
*/
"output"?: JobStepOutput;
/**
* Execution options for the job step.
*/
"executionOptions"?: JobStepExecutionOptions;
}

/**
* The action to be executed by a job step.
*/
model JobStepAction {
/**
* Type of action being executed by the job step.
*/
"type"?: JobStepActionType = JobStepActionType.TSql;
/**
* The source of the action to execute.
*/
"source"?: JobStepActionSource = JobStepActionSource.Inline;
/**
* The action value, for example the text of the T-SQL script to execute.
*/
"value": string;
}

/**
* The output configuration of a job step.
*/
model JobStepOutput {
/**
* The output destination type.
*/
"type"?: JobStepOutputType = JobStepOutputType.SqlDatabase;
/**
* The output destination subscription id.
*/
"subscriptionId"?: string;
/**
* The output destination resource group.
*/
"resourceGroupName"?: string;
/**
* The output destination server name.
*/
"serverName": string;
/**
* The output destination database.
*/
"databaseName": string;
/**
* The output destination schema.
*/
"schemaName"?: string = "dbo";
/**
* The output destination table.
*/
"tableName": string;
/**
* The resource ID of the credential to use to connect to the output destination.
*/
"credential": string;
}

/**
* The execution options of a job step.
*/
model JobStepExecutionOptions {
/**
* Execution timeout for the job step.
*/
"timeoutSeconds"?: int32 = 43200;
/**
* Maximum number of times the job step will be reattempted if the first attempt fails.
*/
"retryAttempts"?: int32 = 10;
/**
* Initial delay between retries for job step execution.
*/
"initialRetryIntervalSeconds"?: int32 = 1;
/**
* The maximum amount of time to wait between retries for job step execution.
*/
"maximumRetryIntervalSeconds"?: int32 = 120;
/**
* The backoff multiplier for the time between retries.
*/
"retryIntervalBackoffMultiplier"?: float32 = 2;
}

/**
* Properties of job target group.
*/
model JobTargetGroupProperties {
/**
* Members of the target group.
*/
"members": JobTarget[];
}

/**
* A job target, for example a specific database or a container of databases that is evaluated during job execution.
*/
model JobTarget {
/**
* Whether the target is included or excluded from the group.
*/
"membershipType"?: JobTargetGroupMembershipType = JobTargetGroupMembershipType.Include;
/**
* The target type.
*/
"type": JobTargetType;
/**
* The target server name.
*/
"serverName"?: string;
/**
* The target database name.
*/
"databaseName"?: string;
/**
* The target elastic pool name.
*/
"elasticPoolName"?: string;
/**
* The target shard map.
*/
"shardMapName"?: string;
/**
* The resource ID of the credential that is used during job execution to connect to the target and determine the list of databases inside the target.
*/
"refreshCredential"?: string;
}

/**
* The location capability.
*/
model LocationCapabilities {
/**
* The location name.
*/
@visibility("read")
"name"?: string;
/**
* The list of supported server versions.
*/
@visibility("read")
"supportedServerVersions"?: ServerVersionCapability[];
/**
* The list of supported managed instance versions.
*/
@visibility("read")
"supportedManagedInstanceVersions"?: ManagedInstanceVersionCapability[];
/**
* The status of the capability.
*/
@visibility("read")
"status"?: CapabilityStatus;
/**
* The reason for the capability not being available.
*/
"reason"?: string;
}

/**
* The server capability
*/
model ServerVersionCapability {
/**
* The server version name.
*/
@visibility("read")
"name"?: string;
/**
* The list of supported database editions.
*/
@visibility("read")
"supportedEditions"?: EditionCapability[];
/**
* The list of supported elastic pool editions.
*/
@visibility("read")
"supportedElasticPoolEditions"?: ElasticPoolEditionCapability[];
/**
* The status of the capability.
*/
@visibility("read")
"status"?: CapabilityStatus;
/**
* The reason for the capability not being available.
*/
"reason"?: string;
}

/**
* The edition capability.
*/
model EditionCapability {
/**
* The database edition name.
*/
@visibility("read")
"name"?: string;
/**
* The list of supported service objectives for the edition.
*/
@visibility("read")
"supportedServiceLevelObjectives"?: ServiceObjectiveCapability[];
/**
* Whether or not zone redundancy is supported for the edition.
*/
@visibility("read")
@projectedName("json", "zoneRedundant")
"IsZoneRedundant"?: boolean;
/**
* The read scale capability for the edition.
*/
@visibility("read")
"readScale"?: ReadScaleCapability;
/**
* The list of supported storage capabilities for this edition
*/
@visibility("read")
"supportedStorageCapabilities"?: StorageCapability[];
/**
* The status of the capability.
*/
@visibility("read")
"status"?: CapabilityStatus;
/**
* The reason for the capability not being available.
*/
"reason"?: string;
}

/**
* The service objectives capability.
*/
model ServiceObjectiveCapability {
/**
* The unique ID of the service objective.
*/
@visibility("read")
"id"?: string;
/**
* The service objective name.
*/
@visibility("read")
"name"?: string;
/**
* The list of supported maximum database sizes.
*/
@visibility("read")
"supportedMaxSizes"?: MaxSizeRangeCapability[];
/**
* The performance level.
*/
@visibility("read")
"performanceLevel"?: PerformanceLevelCapability;
/**
* The sku.
*/
@visibility("read")
"sku"?: Sku;
/**
* List of supported license types.
*/
@visibility("read")
"supportedLicenseTypes"?: LicenseTypeCapability[];
/**
* The included (free) max size.
*/
@visibility("read")
"includedMaxSize"?: MaxSizeCapability;
/**
* Whether or not zone redundancy is supported for the service objective.
*/
@visibility("read")
@projectedName("json", "zoneRedundant")
"IsZoneRedundant"?: boolean;
/**
* Supported time range for auto pause delay
*/
@visibility("read")
"supportedAutoPauseDelay"?: AutoPauseDelayTimeRange;
/**
* List of supported min capacities
*/
@visibility("read")
"supportedMinCapacities"?: MinCapacityCapability[];
/**
* The compute model
*/
@visibility("read")
"computeModel"?: string;
/**
* List of supported maintenance configurations
*/
@visibility("read")
"supportedMaintenanceConfigurations"?: MaintenanceConfigurationCapability[];
/**
* The status of the capability.
*/
@visibility("read")
"status"?: CapabilityStatus;
/**
* The reason for the capability not being available.
*/
"reason"?: string;
}

/**
* The maximum size range capability.
*/
model MaxSizeRangeCapability {
/**
* Minimum value.
*/
@visibility("read")
"minValue"?: MaxSizeCapability;
/**
* Maximum value.
*/
@visibility("read")
"maxValue"?: MaxSizeCapability;
/**
* Scale/step size for discrete values between the minimum value and the maximum value.
*/
@visibility("read")
"scaleSize"?: MaxSizeCapability;
/**
* Size of transaction log.
*/
@visibility("read")
"logSize"?: LogSizeCapability;
/**
* The status of the capability.
*/
@visibility("read")
"status"?: CapabilityStatus;
/**
* The reason for the capability not being available.
*/
"reason"?: string;
}

/**
* The maximum size capability.
*/
model MaxSizeCapability {
/**
* The maximum size limit (see 'unit' for the units).
*/
@visibility("read")
"limit"?: int32;
/**
* The units that the limit is expressed in.
*/
@visibility("read")
"unit"?: MaxSizeUnit;
}

/**
* The log size capability.
*/
model LogSizeCapability {
/**
* The log size limit (see 'unit' for the units).
*/
@visibility("read")
"limit"?: int32;
/**
* The units that the limit is expressed in.
*/
@visibility("read")
"unit"?: LogSizeUnit;
}

/**
* The performance level capability.
*/
model PerformanceLevelCapability {
/**
* Performance level value.
*/
@visibility("read")
"value"?: float64;
/**
* Unit type used to measure performance level.
*/
@visibility("read")
"unit"?: PerformanceLevelUnit;
}

/**
* The license type capability
*/
model LicenseTypeCapability {
/**
* License type identifier.
*/
@visibility("read")
"name"?: string;
/**
* The status of the capability.
*/
@visibility("read")
"status"?: CapabilityStatus;
/**
* The reason for the capability not being available.
*/
"reason"?: string;
}

/**
* Supported auto pause delay time range
*/
model AutoPauseDelayTimeRange {
/**
* Minimum value
*/
@visibility("read")
"minValue"?: int32;
/**
* Maximum value
*/
@visibility("read")
"maxValue"?: int32;
/**
* Step value for discrete values between the minimum value and the maximum value.
*/
@visibility("read")
"stepSize"?: int32;
/**
* Default value is no value is provided
*/
@visibility("read")
"default"?: int32;
/**
* Unit of time that delay is expressed in
*/
@visibility("read")
"unit"?: PauseDelayTimeUnit;
/**
* Value that is used to not pause (infinite delay before pause)
*/
@visibility("read")
"doNotPauseValue"?: int32;
}

/**
* The min capacity capability
*/
model MinCapacityCapability {
/**
* Min capacity value
*/
@visibility("read")
"value"?: float64;
/**
* The status of the capability.
*/
@visibility("read")
"status"?: CapabilityStatus;
/**
* The reason for the capability not being available.
*/
"reason"?: string;
}

/**
* The maintenance configuration capability
*/
model MaintenanceConfigurationCapability {
/**
* Maintenance configuration name
*/
@visibility("read")
"name"?: string;
/**
* Whether or not zone redundancy is supported for the maintenance configuration.
*/
@visibility("read")
@projectedName("json", "zoneRedundant")
"IsZoneRedundant"?: boolean;
/**
* The status of the capability.
*/
@visibility("read")
"status"?: CapabilityStatus;
/**
* The reason for the capability not being available.
*/
"reason"?: string;
}

/**
* The read scale capability.
*/
model ReadScaleCapability {
/**
* The maximum number of read scale replicas.
*/
@visibility("read")
"maxNumberOfReplicas"?: int32;
/**
* The status of the capability.
*/
@visibility("read")
"status"?: CapabilityStatus;
/**
* The reason for the capability not being available.
*/
"reason"?: string;
}

/**
* The storage account type capability.
*/
model StorageCapability {
/**
* The storage account type for the database's backups.
*/
@visibility("read")
"storageAccountType"?: StorageCapabilityStorageAccountType;
/**
* The status of the capability.
*/
@visibility("read")
"status"?: CapabilityStatus;
/**
* The reason for the capability not being available.
*/
"reason"?: string;
}

/**
* The elastic pool edition capability.
*/
model ElasticPoolEditionCapability {
/**
* The elastic pool edition name.
*/
@visibility("read")
"name"?: string;
/**
* The list of supported elastic pool DTU levels for the edition.
*/
@visibility("read")
"supportedElasticPoolPerformanceLevels"?: ElasticPoolPerformanceLevelCapability[];
/**
* Whether or not zone redundancy is supported for the edition.
*/
@visibility("read")
@projectedName("json", "zoneRedundant")
"IsZoneRedundant"?: boolean;
/**
* The status of the capability.
*/
@visibility("read")
"status"?: CapabilityStatus;
/**
* The reason for the capability not being available.
*/
"reason"?: string;
}

/**
* The Elastic Pool performance level capability.
*/
model ElasticPoolPerformanceLevelCapability {
/**
* The performance level for the pool.
*/
@visibility("read")
"performanceLevel"?: PerformanceLevelCapability;
/**
* The sku.
*/
@visibility("read")
"sku"?: Sku;
/**
* List of supported license types.
*/
@visibility("read")
"supportedLicenseTypes"?: LicenseTypeCapability[];
/**
* The maximum number of databases supported.
*/
@visibility("read")
"maxDatabaseCount"?: int32;
/**
* The included (free) max size for this performance level.
*/
@visibility("read")
"includedMaxSize"?: MaxSizeCapability;
/**
* The list of supported max sizes.
*/
@visibility("read")
"supportedMaxSizes"?: MaxSizeRangeCapability[];
/**
* The list of supported per database max sizes.
*/
@visibility("read")
"supportedPerDatabaseMaxSizes"?: MaxSizeRangeCapability[];
/**
* The list of supported per database max performance levels.
*/
@visibility("read")
"supportedPerDatabaseMaxPerformanceLevels"?: ElasticPoolPerDatabaseMaxPerformanceLevelCapability[];
/**
* Whether or not zone redundancy is supported for the performance level.
*/
@visibility("read")
@projectedName("json", "zoneRedundant")
"IsZoneRedundant"?: boolean;
/**
* List of supported maintenance configurations
*/
@visibility("read")
"supportedMaintenanceConfigurations"?: MaintenanceConfigurationCapability[];
/**
* The status of the capability.
*/
@visibility("read")
"status"?: CapabilityStatus;
/**
* The reason for the capability not being available.
*/
"reason"?: string;
}

/**
* The max per-database performance level capability.
*/
model ElasticPoolPerDatabaseMaxPerformanceLevelCapability {
/**
* The maximum performance level per database.
*/
@visibility("read")
"limit"?: float64;
/**
* Unit type used to measure performance level.
*/
@visibility("read")
"unit"?: PerformanceLevelUnit;
/**
* The list of supported min database performance levels.
*/
@visibility("read")
"supportedPerDatabaseMinPerformanceLevels"?: ElasticPoolPerDatabaseMinPerformanceLevelCapability[];
/**
* The status of the capability.
*/
@visibility("read")
"status"?: CapabilityStatus;
/**
* The reason for the capability not being available.
*/
"reason"?: string;
}

/**
* The minimum per-database performance level capability.
*/
model ElasticPoolPerDatabaseMinPerformanceLevelCapability {
/**
* The minimum performance level per database.
*/
@visibility("read")
"limit"?: float64;
/**
* Unit type used to measure performance level.
*/
@visibility("read")
"unit"?: PerformanceLevelUnit;
/**
* The status of the capability.
*/
@visibility("read")
"status"?: CapabilityStatus;
/**
* The reason for the capability not being available.
*/
"reason"?: string;
}

/**
* The managed instance capability
*/
model ManagedInstanceVersionCapability {
/**
* The server version name.
*/
@visibility("read")
"name"?: string;
/**
* The list of supported managed instance editions.
*/
@visibility("read")
"supportedEditions"?: ManagedInstanceEditionCapability[];
/**
* The list of supported instance pool editions.
*/
@visibility("read")
"supportedInstancePoolEditions"?: InstancePoolEditionCapability[];
/**
* The status of the capability.
*/
@visibility("read")
"status"?: CapabilityStatus;
/**
* The reason for the capability not being available.
*/
"reason"?: string;
}

/**
* The managed server capability
*/
model ManagedInstanceEditionCapability {
/**
* The managed server version name.
*/
@visibility("read")
"name"?: string;
/**
* The supported families.
*/
@visibility("read")
"supportedFamilies"?: ManagedInstanceFamilyCapability[];
/**
* The list of supported storage capabilities for this edition
*/
@visibility("read")
"supportedStorageCapabilities"?: StorageCapability[];
/**
* Whether or not zone redundancy is supported for the edition.
*/
@visibility("read")
@projectedName("json", "zoneRedundant")
"IsZoneRedundant"?: boolean;
/**
* The status of the capability.
*/
@visibility("read")
"status"?: CapabilityStatus;
/**
* The reason for the capability not being available.
*/
"reason"?: string;
}

/**
* The managed server family capability.
*/
model ManagedInstanceFamilyCapability {
/**
* Family name.
*/
@visibility("read")
"name"?: string;
/**
* SKU name.
*/
@visibility("read")
"sku"?: string;
/**
* List of supported license types.
*/
@visibility("read")
"supportedLicenseTypes"?: LicenseTypeCapability[];
/**
* List of supported virtual cores values.
*/
@visibility("read")
"supportedVcoresValues"?: ManagedInstanceVcoresCapability[];
/**
* The status of the capability.
*/
@visibility("read")
"status"?: CapabilityStatus;
/**
* The reason for the capability not being available.
*/
"reason"?: string;
}

/**
* The managed instance virtual cores capability.
*/
model ManagedInstanceVcoresCapability {
/**
* The virtual cores identifier.
*/
@visibility("read")
"name"?: string;
/**
* The virtual cores value.
*/
@visibility("read")
"value"?: int32;
/**
* Included size.
*/
@visibility("read")
"includedMaxSize"?: MaxSizeCapability;
/**
* Storage size ranges.
*/
@visibility("read")
"supportedStorageSizes"?: MaxSizeRangeCapability[];
/**
* True if this service objective is supported for managed instances in an instance pool.
*/
@visibility("read")
@projectedName("json", "instancePoolSupported")
"IsInstancePoolSupported"?: boolean;
/**
* True if this service objective is supported for standalone managed instances.
*/
@visibility("read")
@projectedName("json", "standaloneSupported")
"IsStandaloneSupported"?: boolean;
/**
* List of supported maintenance configurations
*/
@visibility("read")
"supportedMaintenanceConfigurations"?: ManagedInstanceMaintenanceConfigurationCapability[];
/**
* The status of the capability.
*/
@visibility("read")
"status"?: CapabilityStatus;
/**
* The reason for the capability not being available.
*/
"reason"?: string;
}

/**
* The maintenance configuration capability
*/
model ManagedInstanceMaintenanceConfigurationCapability {
/**
* Maintenance configuration name
*/
@visibility("read")
"name"?: string;
/**
* The status of the capability.
*/
@visibility("read")
"status"?: CapabilityStatus;
/**
* The reason for the capability not being available.
*/
"reason"?: string;
}

/**
* The instance pool capability
*/
model InstancePoolEditionCapability {
/**
* The instance pool version name.
*/
@visibility("read")
"name"?: string;
/**
* The supported families.
*/
@visibility("read")
"supportedFamilies"?: InstancePoolFamilyCapability[];
/**
* The status of the capability.
*/
@visibility("read")
"status"?: CapabilityStatus;
/**
* The reason for the capability not being available.
*/
"reason"?: string;
}

/**
* The instance pool family capability.
*/
model InstancePoolFamilyCapability {
/**
* Family name.
*/
@visibility("read")
"name"?: string;
/**
* List of supported license types.
*/
@visibility("read")
"supportedLicenseTypes"?: LicenseTypeCapability[];
/**
* List of supported virtual cores values.
*/
@visibility("read")
"supportedVcoresValues"?: InstancePoolVcoresCapability[];
/**
* The status of the capability.
*/
@visibility("read")
"status"?: CapabilityStatus;
/**
* The reason for the capability not being available.
*/
"reason"?: string;
}

/**
* The managed instance virtual cores capability.
*/
model InstancePoolVcoresCapability {
/**
* The virtual cores identifier.
*/
@visibility("read")
"name"?: string;
/**
* The virtual cores value.
*/
@visibility("read")
"value"?: int32;
/**
* Storage limit.
*/
@visibility("read")
"storageLimit"?: MaxSizeCapability;
/**
* The status of the capability.
*/
@visibility("read")
"status"?: CapabilityStatus;
/**
* The reason for the capability not being available.
*/
"reason"?: string;
}

/**
* Properties of a long term retention policy
*/
model BaseLongTermRetentionPolicyProperties {
/**
* The weekly retention policy for an LTR backup in an ISO 8601 format.
*/
"weeklyRetention"?: string;
/**
* The monthly retention policy for an LTR backup in an ISO 8601 format.
*/
"monthlyRetention"?: string;
/**
* The yearly retention policy for an LTR backup in an ISO 8601 format.
*/
"yearlyRetention"?: string;
/**
* The week of year to take the yearly backup in an ISO 8601 format.
*/
"weekOfYear"?: int32;
}

/**
* Maintenance window options properties.
*/
model MaintenanceWindowOptionsProperties {
/**
* Whether maintenance windows are enabled for the database.
*/
"isEnabled"?: boolean;
/**
* Available maintenance cycles e.g. {Saturday, 0, 48*60}, {Wednesday, 0, 24*60}.
*/
"maintenanceWindowCycles"?: MaintenanceWindowTimeRange[];
/**
* Minimum duration of maintenance window.
*/
"minDurationInMinutes"?: int32;
/**
* Default duration for maintenance window.
*/
"defaultDurationInMinutes"?: int32;
/**
* Minimum number of maintenance windows cycles to be set on the database.
*/
"minCycles"?: int32;
/**
* Time granularity in minutes for maintenance windows.
*/
"timeGranularityInMinutes"?: int32;
/**
* Whether we allow multiple maintenance windows per cycle.
*/
"allowMultipleMaintenanceWindowsPerCycle"?: boolean;
}

/**
* Maintenance window time range.
*/
model MaintenanceWindowTimeRange {
/**
* Day of maintenance window.
*/
"dayOfWeek"?: DayOfWeek;
/**
* Start time minutes offset from 12am.
*/
"startTime"?: string;
/**
* Duration of maintenance window in minutes.
*/
"duration"?: duration;
}

/**
* Maintenance windows resource properties.
*/
model MaintenanceWindowsProperties {
"timeRanges"?: MaintenanceWindowTimeRange[];
}

/**
* Properties of a short term retention policy
*/
model ManagedBackupShortTermRetentionPolicyProperties {
/**
* The backup retention period in days. This is how many days Point-in-Time Restore will be supported.
*/
"retentionDays"?: int32;
}

/**
* Database query.
*/
model ManagedInstanceQuery {
/**
* Resource properties.
*/
"properties"?: QueryProperties;
}

/**
* Properties of a database query.
*/
model QueryProperties {
/**
* Query text.
*/
"queryText"?: string;
}

/**
* Execution statistics for one particular query
*/
model ManagedInstanceQueryStatistics is Azure.Core.Page<QueryStatistics> {
}


model QueryStatistics {
/**
* Resource properties.
*/
"properties"?: QueryStatisticsProperties;
}

/**
* Properties of a query execution statistics.
*/
model QueryStatisticsProperties {
/**
* Database name of the database in which this query was executed.
*/
@visibility("read")
"databaseName"?: string;
/**
* Unique query id (unique within one database).
*/
@visibility("read")
"queryId"?: string;
/**
* The start time for the metric (ISO-8601 format).
*/
@visibility("read")
"startTime"?: string;
/**
* The end time for the metric (ISO-8601 format).
*/
@visibility("read")
"endTime"?: string;
/**
* List of intervals with appropriate metric data
*/
"intervals"?: QueryMetricInterval[];
}

/**
* Properties of a query metrics interval.
*/
model QueryMetricInterval {
/**
* The start time for the metric interval (ISO-8601 format).
*/
@visibility("read")
"intervalStartTime"?: string;
/**
* Interval type (length).
*/
@visibility("read")
"intervalType"?: QueryTimeGrainType;
/**
* Execution count of a query in this interval.
*/
@visibility("read")
"executionCount"?: int64;
/**
* List of metric objects for this interval
*/
"metrics"?: QueryMetricProperties[];
}

/**
* Properties of a topquery metric in one interval.
*/
model QueryMetricProperties {
/**
* The name information for the metric.
*/
@visibility("read")
"name"?: string;
/**
* The UI appropriate name for the metric.
*/
@visibility("read")
"displayName"?: string;
/**
* The unit of the metric.
*/
@visibility("read")
"unit"?: QueryMetricUnitType;
/**
* The value of the metric.
*/
@visibility("read")
"value"?: float64;
/**
* Metric value when min() aggregate function is used over the interval.
*/
@visibility("read")
"min"?: float64;
/**
* Metric value when max() aggregate function is used over the interval.
*/
@visibility("read")
"max"?: float64;
/**
* Metric value when avg() aggregate function is used over the interval.
*/
@visibility("read")
"avg"?: float64;
/**
* Metric value when sum() aggregate function is used over the interval.
*/
@visibility("read")
"sum"?: float64;
/**
* Metric value when stdev aggregate function is used over the interval.
*/
@visibility("read")
"stdev"?: float64;
}

/**
* Properties of a security alert policy.
*/
model SecurityAlertPolicyProperties {
/**
* Specifies the state of the policy, whether it is enabled or disabled or a policy has not been applied yet on the specific database.
*/
"state": SecurityAlertPolicyState;
/**
* Specifies an array of alerts that are disabled. Allowed values are: Sql_Injection, Sql_Injection_Vulnerability, Access_Anomaly, Data_Exfiltration, Unsafe_Action, Brute_Force
*/
"disabledAlerts"?: string[];
/**
* Specifies an array of e-mail addresses to which the alert is sent.
*/
"emailAddresses"?: string[];
/**
* Specifies that the alert is sent to the account administrators.
*/
@projectedName("json", "emailAccountAdmins")
"sendToEmailAccountAdmins"?: boolean;
/**
* Specifies the blob storage endpoint (e.g. https://MyAccount.blob.core.windows.net). This blob storage will hold all Threat Detection audit logs.
*/
"storageEndpoint"?: string;
/**
* Specifies the identifier key of the Threat Detection audit storage account.
*/
"storageAccountAccessKey"?: string;
/**
* Specifies the number of days to keep in the Threat Detection audit logs.
*/
"retentionDays"?: int32;
/**
* Specifies the UTC creation time of the policy.
*/
@visibility("read")
// FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
"creationTime"?: utcDateTime;
}

/**
* A list of security events.
*/
model SecurityEventCollection is Azure.Core.Page<SecurityEvent> {
}

/**
* A security event.
*/
model SecurityEvent {
/**
* Resource properties.
*/
"properties"?: SecurityEventProperties;
}

/**
* The properties of a security event.
*/
model SecurityEventProperties {
/**
* The time when the security event occurred.
*/
@visibility("read")
// FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
"eventTime"?: utcDateTime;
/**
* The type of the security event.
*/
@visibility("read")
"securityEventType"?: SecurityEventType;
/**
* The subscription name
*/
@visibility("read")
"subscription"?: string;
/**
* The server name
*/
@visibility("read")
"server"?: string;
/**
* The database name
*/
@visibility("read")
"database"?: string;
/**
* The IP address of the client who executed the statement.
*/
@visibility("read")
"clientIp"?: string;
/**
* The application used to execute the statement.
*/
@visibility("read")
"applicationName"?: string;
/**
* The principal user who executed the statement
*/
@visibility("read")
"principalName"?: string;
/**
* The sql injection additional properties, populated only if the type of the security event is sql injection.
*/
@visibility("read")
"securityEventSqlInjectionAdditionalProperties"?: SecurityEventSqlInjectionAdditionalProperties;
}

/**
* The properties of a security event sql injection additional properties.
*/
model SecurityEventSqlInjectionAdditionalProperties {
/**
* The threat ID.
*/
@visibility("read")
"threatId"?: string;
/**
* The statement
*/
@visibility("read")
"statement"?: string;
/**
* The statement highlight offset
*/
@visibility("read")
"statementHighlightOffset"?: int32;
/**
* The statement highlight length
*/
@visibility("read")
"statementHighlightLength"?: int32;
/**
* The sql error code
*/
@visibility("read")
"errorCode"?: int32;
/**
* The sql error severity
*/
@visibility("read")
"errorSeverity"?: int32;
/**
* The sql error message
*/
@visibility("read")
"errorMessage"?: string;
}

/**
* Properties of a transparent data encryption.
*/
model ManagedTransparentDataEncryptionProperties {
/**
* Specifies the state of the transparent data encryption.
*/
"state": TransparentDataEncryptionState;
}

/**
* The properties of a managed instance administrator.
*/
model ManagedInstanceAdministratorProperties {
/**
* Type of the managed instance administrator.
*/
"administratorType": ManagedInstanceAdministratorType;
/**
* Login name of the managed instance administrator.
*/
"login": string;
/**
* SID (object ID) of the managed instance administrator.
*/
"sid": string;
/**
* Tenant ID of the managed instance administrator.
*/
"tenantId"?: string;
}

/**
* Properties of a active directory only authentication for Managed Instance.
*/
model ManagedInstanceAzureADOnlyAuthProperties {
/**
* Azure Active Directory only Authentication enabled.
*/
"azureADOnlyAuthentication": boolean;
}

/**
* Properties for an encryption protector execution.
*/
model ManagedInstanceEncryptionProtectorProperties {
/**
* The name of the managed instance key.
*/
"serverKeyName"?: string;
/**
* The encryption protector type like 'ServiceManaged', 'AzureKeyVault'.
*/
"serverKeyType": ServerKeyType;
/**
* The URI of the server key.
*/
@visibility("read")
"uri"?: string;
/**
* Thumbprint of the server key.
*/
@visibility("read")
"thumbprint"?: string;
/**
* Key auto rotation opt-in flag. Either true or false.
*/
@projectedName("json", "autoRotationEnabled")
"IsAutoRotationEnabled"?: boolean;
}

/**
* Properties for a key execution.
*/
model ManagedInstanceKeyProperties {
/**
* The key type like 'ServiceManaged', 'AzureKeyVault'.
*/
@visibility("create")
"serverKeyType": ServerKeyType;
/**
* The URI of the key. If the ServerKeyType is AzureKeyVault, then the URI is required.
*/
@visibility("create")
"uri"?: string;
/**
* Thumbprint of the key.
*/
@visibility("read")
"thumbprint"?: string;
/**
* The key creation date.
*/
@visibility("read")
// FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
"creationDate"?: utcDateTime;
/**
* Key auto rotation opt-in flag. Either true or false.
*/
@visibility("read")
@projectedName("json", "autoRotationEnabled")
"IsAutoRotationEnabled"?: boolean;
}

/**
* The properties of a managed instance operation.
*/
model ManagedInstanceOperationProperties {
/**
* The name of the managed instance the operation is being performed on.
*/
@visibility("read")
"managedInstanceName"?: string;
/**
* The name of operation.
*/
@visibility("read")
"operation"?: string;
/**
* The friendly name of operation.
*/
@visibility("read")
"operationFriendlyName"?: string;
/**
* The percentage of the operation completed.
*/
@visibility("read")
"percentComplete"?: int32;
/**
* The operation start time.
*/
@visibility("read")
// FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
"startTime"?: utcDateTime;
/**
* The operation state.
*/
@visibility("read")
"state"?: ManagementOperationState;
/**
* The operation error code.
*/
@visibility("read")
"errorCode"?: int32;
/**
* The operation error description.
*/
@visibility("read")
"errorDescription"?: string;
/**
* The operation error severity.
*/
@visibility("read")
"errorSeverity"?: int32;
/**
* Whether or not the error is a user error.
*/
@visibility("read")
"isUserError"?: boolean;
/**
* The estimated completion time of the operation.
*/
@visibility("read")
@projectedName("json", "estimatedCompletionTime")
// FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
"estimatedCompleteOn"?: utcDateTime;
/**
* The operation description.
*/
@visibility("read")
"description"?: string;
/**
* Whether the operation can be cancelled.
*/
@visibility("read")
"isCancellable"?: boolean;
/**
* The operation parameters.
*/
@visibility("read")
"operationParameters"?: ManagedInstanceOperationParametersPair;
/**
* The operation steps.
*/
@visibility("read")
"operationSteps"?: ManagedInstanceOperationSteps;
}

/**
* The parameters of a managed instance operation.
*/
model ManagedInstanceOperationParametersPair {
/**
* The current parameters.
*/
@visibility("read")
"currentParameters"?: UpsertManagedServerOperationParameters;
/**
* The requested parameters.
*/
@visibility("read")
"requestedParameters"?: UpsertManagedServerOperationParameters;
}


model UpsertManagedServerOperationParameters {
"family"?: string;
"tier"?: string;
"vCores"?: int32;
"storageSizeInGB"?: int32;
}

/**
* The steps of a managed instance operation.
*/
model ManagedInstanceOperationSteps {
/**
* The total number of operation steps.
*/
@visibility("read")
"totalSteps"?: string;
/**
* The number of current operation steps.
*/
@visibility("read")
"currentStep"?: int32;
/**
* The operation steps list.
*/
@visibility("read")
"stepsList"?: UpsertManagedServerOperationStep[];
}


model UpsertManagedServerOperationStep {
"order"?: int32;
"name"?: string;
"status"?: UpsertManagedServerOperationStepStatus;
}

/**
* Properties of a private endpoint connection.
*/
model ManagedInstancePrivateEndpointConnectionProperties {
/**
* Private endpoint which the connection belongs to.
*/
"privateEndpoint"?: ManagedInstancePrivateEndpointProperty;
/**
* Connection State of the Private Endpoint Connection.
*/
"privateLinkServiceConnectionState"?: ManagedInstancePrivateLinkServiceConnectionStateProperty;
/**
* State of the Private Endpoint Connection.
*/
@visibility("read")
"provisioningState"?: string;
}


model ManagedInstancePrivateEndpointProperty {
/**
* Resource id of the private endpoint.
*/
"id"?: string;
}


model ManagedInstancePrivateLinkServiceConnectionStateProperty {
/**
* The private link service connection status.
*/
"status": string;
/**
* The private link service connection description.
*/
"description": string;
/**
* The private link service connection description.
*/
@visibility("read")
"actionsRequired"?: string;
}

/**
* Properties of a private link resource.
*/
model ManagedInstancePrivateLinkProperties {
/**
* The private link resource group id.
*/
@visibility("read")
"groupId"?: string;
/**
* The private link resource required member names.
*/
@visibility("read")
"requiredMembers"?: string[];
}

/**
* A TDE certificate that can be uploaded into a server.
*/
model TdeCertificate {
/**
* Resource properties.
*/
"properties"?: TdeCertificateProperties;
}

/**
* Properties of a TDE certificate.
*/
model TdeCertificateProperties {
/**
* The base64 encoded certificate private blob.
*/
@visibility("create", "update")
"privateBlob": string;
/**
* The certificate password.
*/
@visibility("create", "update")
"certPassword"?: string;
}

/**
* Properties of a managed instance vulnerability assessment.
*/
model ManagedInstanceVulnerabilityAssessmentProperties {
/**
* A blob storage container path to hold the scan results (e.g. https://myStorage.blob.core.windows.net/VaScans/).
*/
@visibility("create", "update")
"storageContainerPath": string;
/**
* A shared access signature (SAS Key) that has write access to the blob container specified in 'storageContainerPath' parameter. If 'storageAccountAccessKey' isn't specified, StorageContainerSasKey is required. Applies only if the storage account is not behind a Vnet or a firewall
*/
@visibility("create", "update")
"storageContainerSasKey"?: string;
/**
* Specifies the identifier key of the storage account for vulnerability assessment scan results. If 'StorageContainerSasKey' isn't specified, storageAccountAccessKey is required. Applies only if the storage account is not behind a Vnet or a firewall
*/
@visibility("create", "update")
"storageAccountAccessKey"?: string;
/**
* The recurring scans settings
*/
"recurringScans"?: VulnerabilityAssessmentRecurringScansProperties;
}

/**
* Properties of a private endpoint connection.
*/
model PrivateEndpointConnectionProperties {
/**
* Private endpoint which the connection belongs to.
*/
"privateEndpoint"?: PrivateEndpointProperty;
/**
* Group IDs.
*/
@visibility("read")
"groupIds"?: string[];
/**
* Connection state of the private endpoint connection.
*/
"privateLinkServiceConnectionState"?: PrivateLinkServiceConnectionStateProperty;
/**
* State of the private endpoint connection.
*/
@visibility("read")
"provisioningState"?: PrivateEndpointProvisioningState;
}


model PrivateEndpointProperty {
/**
* Resource id of the private endpoint.
*/
"id"?: string;
}


model PrivateLinkServiceConnectionStateProperty {
/**
* The private link service connection status.
*/
"status": PrivateLinkServiceConnectionStateStatus;
/**
* The private link service connection description.
*/
"description": string;
/**
* The actions required for private link service connection.
*/
@visibility("read")
"actionsRequired"?: PrivateLinkServiceConnectionStateActionsRequire;
}

/**
* Properties of a private link resource.
*/
model PrivateLinkResourceProperties {
/**
* The private link resource group id.
*/
@visibility("read")
"groupId"?: string;
/**
* The private link resource required member names.
*/
@visibility("read")
"requiredMembers"?: string[];
/**
* The private link resource required zone names.
*/
@visibility("read")
"requiredZoneNames"?: string[];
}

/**
* The recoverable managed database's properties.
*/
model RecoverableManagedDatabaseProperties {
/**
* The last available backup date.
*/
@visibility("read")
"lastAvailableBackupDate"?: string;
}

/**
* Properties of a database restore point
*/
model RestorePointProperties {
/**
* The type of restore point
*/
@visibility("read")
"restorePointType"?: RestorePointType;
/**
* The earliest time to which this database can be restored
*/
@visibility("read")
// FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
"earliestRestoreDate"?: utcDateTime;
/**
* The time the backup was taken
*/
@visibility("read")
// FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
"restorePointCreationDate"?: utcDateTime;
/**
* The label of restore point for backup request by user
*/
@visibility("read")
"restorePointLabel"?: string;
}

/**
* Contains the information necessary to perform a create database restore point operation.
*/
model CreateDatabaseRestorePointDefinition {
/**
* The restore point label to apply
*/
"restorePointLabel": string;
}

/**
* Server-level Automatic Tuning properties.
*/
model AutomaticTuningServerProperties {
/**
* Automatic tuning desired state.
*/
"desiredState"?: AutomaticTuningServerMode;
/**
* Automatic tuning actual state.
*/
@visibility("read")
"actualState"?: AutomaticTuningServerMode;
/**
* Automatic tuning options definition.
*/
"options"?: Record<AutomaticTuningServerOptions>;
}

/**
* Automatic tuning properties for individual advisors.
*/
model AutomaticTuningServerOptions {
/**
* Automatic tuning option desired state.
*/
"desiredState"?: AutomaticTuningOptionModeDesired;
/**
* Automatic tuning option actual state.
*/
@visibility("read")
"actualState"?: AutomaticTuningOptionModeActual;
/**
* Reason code if desired and actual state are different.
*/
@visibility("read")
"reasonCode"?: int32;
/**
* Reason description if desired and actual state are different.
*/
@visibility("read")
"reasonDesc"?: AutomaticTuningServerReason;
}

/**
* Properties of a active directory administrator.
*/
model AdministratorProperties {
/**
* Type of the sever administrator.
*/
"administratorType": AdministratorType;
/**
* Login name of the server administrator.
*/
"login": string;
/**
* SID (object ID) of the server administrator.
*/
"sid": string;
/**
* Tenant ID of the administrator.
*/
"tenantId"?: string;
/**
* Azure Active Directory only Authentication enabled.
*/
@visibility("read")
"azureADOnlyAuthentication"?: boolean;
}

/**
* Properties of a active directory only authentication.
*/
model AzureADOnlyAuthProperties {
/**
* Azure Active Directory only Authentication enabled.
*/
"azureADOnlyAuthentication": boolean;
}

/**
* Properties of a server DevOps audit settings.
*/
model ServerDevOpsAuditSettingsProperties {
/**
* Specifies whether DevOps audit events are sent to Azure Monitor. 
In order to send the events to Azure Monitor, specify 'State' as 'Enabled' and 'IsAzureMonitorTargetEnabled' as true.

When using REST API to configure DevOps audit, Diagnostic Settings with 'DevOpsOperationsAudit' diagnostic logs category on the master database should be also created.

Diagnostic Settings URI format:
PUT https://management.azure.com/subscriptions/{subscriptionId}/resourceGroups/{resourceGroup}/providers/Microsoft.Sql/servers/{serverName}/databases/master/providers/microsoft.insights/diagnosticSettings/{settingsName}?api-version=2017-05-01-preview

For more information, see [Diagnostic Settings REST API](https://go.microsoft.com/fwlink/?linkid=2033207)
or [Diagnostic Settings PowerShell](https://go.microsoft.com/fwlink/?linkid=2033043)

*/
"isAzureMonitorTargetEnabled"?: boolean;
/**
* Specifies whether Managed Identity is used to access blob storage
*/
"isManagedIdentityInUse"?: boolean;
/**
* Specifies the state of the audit. If state is Enabled, storageEndpoint or isAzureMonitorTargetEnabled are required.
*/
"state": BlobAuditingPolicyState;
/**
* Specifies the blob storage endpoint (e.g. https://MyAccount.blob.core.windows.net). If state is Enabled, storageEndpoint or isAzureMonitorTargetEnabled is required.
*/
"storageEndpoint"?: string;
/**
* Specifies the identifier key of the auditing storage account. 
If state is Enabled and storageEndpoint is specified, not specifying the storageAccountAccessKey will use SQL server system-assigned managed identity to access the storage.
Prerequisites for using managed identity authentication:
1. Assign SQL Server a system-assigned managed identity in Azure Active Directory (AAD).
2. Grant SQL Server identity access to the storage account by adding 'Storage Blob Data Contributor' RBAC role to the server identity.
For more information, see [Auditing to storage using Managed Identity authentication](https://go.microsoft.com/fwlink/?linkid=2114355)
*/
@visibility("create", "update")
"storageAccountAccessKey"?: string;
/**
* Specifies the blob storage subscription Id.
*/
"storageAccountSubscriptionId"?: string;
}

/**
* Properties of a server DNS alias.
*/
model ServerDnsAliasProperties {
/**
* The fully qualified DNS record for alias
*/
@visibility("read")
"azureDnsRecord"?: string;
}

/**
* A server dns alias acquisition request.
*/
model ServerDnsAliasAcquisition {
/**
* The id of the server alias that will be acquired to point to this server instead.
*/
"oldServerDnsAliasId": string;
}

/**
* Properties for a server key execution.
*/
model ServerKeyProperties {
/**
* Subregion of the server key.
*/
@visibility("read")
"subregion"?: string;
/**
* The server key type like 'ServiceManaged', 'AzureKeyVault'.
*/
@visibility("create")
"serverKeyType": ServerKeyType;
/**
* The URI of the server key. If the ServerKeyType is AzureKeyVault, then the URI is required.
*/
@visibility("create")
"uri"?: string;
/**
* Thumbprint of the server key.
*/
@visibility("read")
"thumbprint"?: string;
/**
* The server key creation date.
*/
@visibility("read")
// FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
"creationDate"?: utcDateTime;
/**
* Key auto rotation opt-in flag. Either true or false.
*/
@visibility("read")
@projectedName("json", "autoRotationEnabled")
"IsAutoRotationEnabled"?: boolean;
}

/**
* The response to a list server operations request
*/
model ServerOperationListResult is Azure.Core.Page<ServerOperation> {
}

/**
* A server operation.
*/
model ServerOperation {
/**
* Resource properties.
*/
"properties"?: ServerOperationProperties;
}

/**
* The properties of a server operation.
*/
model ServerOperationProperties {
/**
* The name of operation.
*/
@visibility("read")
"operation"?: string;
/**
* The friendly name of operation.
*/
@visibility("read")
"operationFriendlyName"?: string;
/**
* The percentage of the operation completed.
*/
@visibility("read")
"percentComplete"?: int32;
/**
* The name of the server.
*/
@visibility("read")
"serverName"?: string;
/**
* The operation start time.
*/
@visibility("read")
// FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
"startTime"?: utcDateTime;
/**
* The operation state.
*/
@visibility("read")
"state"?: ManagementOperationState;
/**
* The operation error code.
*/
@visibility("read")
"errorCode"?: int32;
/**
* The operation error description.
*/
@visibility("read")
"errorDescription"?: string;
/**
* The operation error severity.
*/
@visibility("read")
"errorSeverity"?: int32;
/**
* Whether or not the error is a user error.
*/
@visibility("read")
"isUserError"?: boolean;
/**
* The estimated completion time of the operation.
*/
@visibility("read")
@projectedName("json", "estimatedCompletionTime")
// FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
"estimatedCompleteOn"?: utcDateTime;
/**
* The operation description.
*/
@visibility("read")
"description"?: string;
/**
* Whether the operation can be cancelled.
*/
@visibility("read")
"isCancellable"?: boolean;
}

/**
* Properties of a server trust group.
*/
model ServerTrustGroupProperties {
/**
* Group members information for the server trust group.
*/
"groupMembers": ServerInfo[];
/**
* Trust scope of the server trust group.
*/
"trustScopes": ServerTrustGroupPropertiesTrustScopesItem[];
}

/**
* Server info for the server trust group.
*/
model ServerInfo {
/**
* Server Id.
*/
"serverId": string;
}

/**
* Properties of a server Vulnerability Assessment.
*/
model ServerVulnerabilityAssessmentProperties {
/**
* A blob storage container path to hold the scan results (e.g. https://myStorage.blob.core.windows.net/VaScans/).
*/
@visibility("create", "update")
"storageContainerPath": string;
/**
* A shared access signature (SAS Key) that has write access to the blob container specified in 'storageContainerPath' parameter. If 'storageAccountAccessKey' isn't specified, StorageContainerSasKey is required. Applies only if the storage account is not behind a Vnet or a firewall
*/
@visibility("create", "update")
"storageContainerSasKey"?: string;
/**
* Specifies the identifier key of the storage account for vulnerability assessment scan results. If 'StorageContainerSasKey' isn't specified, storageAccountAccessKey is required. Applies only if the storage account is not behind a Vnet or a firewall
*/
@visibility("create", "update")
"storageAccountAccessKey"?: string;
/**
* The recurring scans settings
*/
"recurringScans"?: VulnerabilityAssessmentRecurringScansProperties;
}

/**
* Sql agent configuration properties.
*/
model SqlAgentConfigurationProperties {
/**
* The state of Sql Agent.
*/
"state"?: SqlAgentConfigurationPropertiesState;
}

/**
* Properties of a subscription usage.
*/
model SubscriptionUsageProperties {
/**
* User-readable name of the metric.
*/
@visibility("read")
"displayName"?: string;
/**
* Current value of the metric.
*/
@visibility("read")
"currentValue"?: float64;
/**
* Boundary value of the metric.
*/
@visibility("read")
"limit"?: float64;
/**
* Unit of the metric.
*/
@visibility("read")
"unit"?: string;
}

/**
* Properties of an Azure SQL Database sync agent.
*/
model SyncAgentProperties {
/**
* ARM resource id of the sync database in the sync agent.
*/
"syncDatabaseId"?: string;
/**
* Last alive time of the sync agent.
*/
@visibility("read")
// FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
"lastAliveTime"?: utcDateTime;
/**
* State of the sync agent.
*/
@visibility("read")
"state"?: SyncAgentState;
/**
* If the sync agent version is up to date.
*/
@visibility("read")
"isUpToDate"?: boolean;
/**
* Expiration time of the sync agent version.
*/
@visibility("read")
@projectedName("json", "expiryTime")
// FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
"expireOn"?: utcDateTime;
/**
* Version of the sync agent.
*/
@visibility("read")
"version"?: string;
}

/**
* Properties of an Azure SQL Database sync agent key.
*/
model SyncAgentKeyProperties {
/**
* Key of sync agent.
*/
@visibility("read")
"syncAgentKey"?: string;
}

/**
* A list of sync agent linked databases.
*/
model SyncAgentLinkedDatabaseListResult is Azure.Core.Page<SyncAgentLinkedDatabase> {
}

/**
* An Azure SQL Database sync agent linked database.
*/
model SyncAgentLinkedDatabase {
/**
* Resource properties.
*/
"properties"?: SyncAgentLinkedDatabaseProperties;
}

/**
* Properties of an Azure SQL Database sync agent linked database.
*/
model SyncAgentLinkedDatabaseProperties {
/**
* Type of the sync agent linked database.
*/
@visibility("read")
"databaseType"?: SyncMemberDbType;
/**
* Id of the sync agent linked database.
*/
@visibility("read")
"databaseId"?: string;
/**
* Description of the sync agent linked database.
*/
@visibility("read")
"description"?: string;
/**
* Server name of the sync agent linked database.
*/
@visibility("read")
"serverName"?: string;
/**
* Database name of the sync agent linked database.
*/
@visibility("read")
"databaseName"?: string;
/**
* User name of the sync agent linked database.
*/
@visibility("read")
"userName"?: string;
}

/**
* Properties of the sync database id.
*/
model SyncDatabaseIdProperties {
/**
* ARM resource id of sync database.
*/
@visibility("read")
"id"?: string;
}

/**
* A list of sync schema properties.
*/
model SyncFullSchemaPropertiesListResult is Azure.Core.Page<SyncFullSchemaProperties> {
}

/**
* Properties of the database full schema.
*/
model SyncFullSchemaProperties {
/**
* List of tables in the database full schema.
*/
@visibility("read")
"tables"?: SyncFullSchemaTable[];
/**
* Last update time of the database schema.
*/
@visibility("read")
// FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
"lastUpdateTime"?: utcDateTime;
}

/**
* Properties of the table in the database full schema.
*/
model SyncFullSchemaTable {
/**
* List of columns in the table of database full schema.
*/
@visibility("read")
"columns"?: SyncFullSchemaTableColumn[];
/**
* Error id of the table.
*/
@visibility("read")
"errorId"?: string;
/**
* If there is error in the table.
*/
@visibility("read")
"hasError"?: boolean;
/**
* Name of the table.
*/
@visibility("read")
"name"?: string;
/**
* Quoted name of the table.
*/
@visibility("read")
"quotedName"?: string;
}

/**
* Properties of the column in the table of database full schema.
*/
model SyncFullSchemaTableColumn {
/**
* Data size of the column.
*/
@visibility("read")
"dataSize"?: string;
/**
* Data type of the column.
*/
@visibility("read")
"dataType"?: string;
/**
* Error id of the column.
*/
@visibility("read")
"errorId"?: string;
/**
* If there is error in the table.
*/
@visibility("read")
"hasError"?: boolean;
/**
* If it is the primary key of the table.
*/
@visibility("read")
"isPrimaryKey"?: boolean;
/**
* Name of the column.
*/
@visibility("read")
"name"?: string;
/**
* Quoted name of the column.
*/
@visibility("read")
"quotedName"?: string;
}

/**
* A list of sync group log properties.
*/
model SyncGroupLogListResult is Azure.Core.Page<SyncGroupLogProperties> {
}

/**
* Properties of an Azure SQL Database sync group log.
*/
model SyncGroupLogProperties {
/**
* Timestamp of the sync group log.
*/
@visibility("read")
// FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
"timestamp"?: utcDateTime;
/**
* Type of the sync group log.
*/
@visibility("read")
"type"?: SyncGroupLogType;
/**
* Source of the sync group log.
*/
@visibility("read")
"source"?: string;
/**
* Details of the sync group log.
*/
@visibility("read")
"details"?: string;
/**
* TracingId of the sync group log.
*/
@visibility("read")
"tracingId"?: string;
/**
* OperationStatus of the sync group log.
*/
@visibility("read")
"operationStatus"?: string;
}

/**
* Properties of a sync group.
*/
model SyncGroupProperties {
/**
* Sync interval of the sync group.
*/
"interval"?: int32;
/**
* Last sync time of the sync group.
*/
@visibility("read")
// FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
"lastSyncTime"?: utcDateTime;
/**
* Conflict resolution policy of the sync group.
*/
"conflictResolutionPolicy"?: SyncConflictResolutionPolicy;
/**
* ARM resource id of the sync database in the sync group.
*/
"syncDatabaseId"?: string;
/**
* User name for the sync group hub database credential.
*/
"hubDatabaseUserName"?: string;
/**
* Password for the sync group hub database credential.
*/
@visibility("create", "update")
"hubDatabasePassword"?: string;
/**
* Sync state of the sync group.
*/
@visibility("read")
"syncState"?: SyncGroupState;
/**
* Sync schema of the sync group.
*/
"schema"?: SyncGroupSchema;
/**
* If conflict logging is enabled.
*/
"enableConflictLogging"?: boolean;
/**
* Conflict logging retention period.
*/
"conflictLoggingRetentionInDays"?: int32;
/**
* If use private link connection is enabled.
*/
"usePrivateLinkConnection"?: boolean;
/**
* Private endpoint name of the sync group if use private link connection is enabled.
*/
@visibility("read")
"privateEndpointName"?: string;
}

/**
* Properties of sync group schema.
*/
model SyncGroupSchema {
/**
* List of tables in sync group schema.
*/
"tables"?: SyncGroupSchemaTable[];
/**
* Name of master sync member where the schema is from.
*/
"masterSyncMemberName"?: string;
}

/**
* Properties of table in sync group schema.
*/
model SyncGroupSchemaTable {
/**
* List of columns in sync group schema.
*/
"columns"?: SyncGroupSchemaTableColumn[];
/**
* Quoted name of sync group schema table.
*/
"quotedName"?: string;
}

/**
* Properties of column in sync group table.
*/
model SyncGroupSchemaTableColumn {
/**
* Quoted name of sync group table column.
*/
"quotedName"?: string;
/**
* Data size of the column.
*/
"dataSize"?: string;
/**
* Data type of the column.
*/
"dataType"?: string;
}

/**
* Properties of a sync member.
*/
model SyncMemberProperties {
/**
* Database type of the sync member.
*/
"databaseType"?: SyncMemberDbType;
/**
* ARM resource id of the sync agent in the sync member.
*/
"syncAgentId"?: string;
/**
* SQL Server database id of the sync member.
*/
"sqlServerDatabaseId"?: string;
/**
* ARM resource id of the sync member logical database, for sync members in Azure.
*/
"syncMemberAzureDatabaseResourceId"?: string;
/**
* Whether to use private link connection.
*/
"usePrivateLinkConnection"?: boolean;
/**
* Private endpoint name of the sync member if use private link connection is enabled, for sync members in Azure.
*/
@visibility("read")
"privateEndpointName"?: string;
/**
* Server name of the member database in the sync member
*/
"serverName"?: string;
/**
* Database name of the member database in the sync member.
*/
"databaseName"?: string;
/**
* User name of the member database in the sync member.
*/
"userName"?: string;
/**
* Password of the member database in the sync member.
*/
@visibility("create", "update")
"password"?: string;
/**
* Sync direction of the sync member.
*/
"syncDirection"?: SyncDirection;
/**
* Sync state of the sync member.
*/
@visibility("read")
"syncState"?: SyncMemberState;
}

/**
* The properties of a time zone.
*/
model TimeZoneProperties {
/**
* The time zone id
*/
@visibility("read")
"timeZoneId"?: string;
/**
* The time zone display name
*/
@visibility("read")
"displayName"?: string;
}

/**
* Properties of a virtual network rule.
*/
model VirtualNetworkRuleProperties {
/**
* The ARM resource id of the virtual network subnet.
*/
"virtualNetworkSubnetId": string;
/**
* Create firewall rule before the virtual network has vnet service endpoint enabled.
*/
"ignoreMissingVnetServiceEndpoint"?: boolean;
/**
* Virtual Network Rule State
*/
@visibility("read")
"state"?: VirtualNetworkRuleState;
}

/**
* Workload classifier definition. For more information look at sys.workload_management_workload_classifiers (DMV).
*/
model WorkloadClassifierProperties {
/**
* The workload classifier member name.
*/
"memberName": string;
/**
* The workload classifier label.
*/
"label"?: string;
/**
* The workload classifier context.
*/
"context"?: string;
/**
* The workload classifier start time for classification.
*/
"startTime"?: string;
/**
* The workload classifier end time for classification.
*/
"endTime"?: string;
/**
* The workload classifier importance.
*/
"importance"?: string;
}

/**
* Workload group definition. For more information look at sys.workload_management_workload_groups (DMV).
*/
model WorkloadGroupProperties {
/**
* The workload group minimum percentage resource.
*/
"minResourcePercent": int32;
/**
* The workload group cap percentage resource.
*/
"maxResourcePercent": int32;
/**
* The workload group request minimum grant percentage.
*/
"minResourcePercentPerRequest": float64;
/**
* The workload group request maximum grant percentage.
*/
"maxResourcePercentPerRequest"?: float64;
/**
* The workload group importance level.
*/
"importance"?: string;
/**
* The workload group query execution timeout.
*/
"queryExecutionTimeout"?: int32;
}

/**
* Properties of a short term retention policy
*/
model BackupShortTermRetentionPolicyProperties {
/**
* The backup retention period in days. This is how many days Point-in-Time Restore will be supported.
*/
"retentionDays"?: int32;
/**
* The differential backup interval in hours. This is how many interval hours between each differential backup will be supported. This is only applicable to live databases but not dropped databases.
*/
"diffBackupIntervalInHours"?: DiffBackupIntervalInHours;
}

/**
* An export managed database operation result resource.
*/
model DatabaseExtensions {
/**
* Resource properties.
*/
"properties"?: DatabaseExtensionsProperties;
}

/**
* Contains the database information after successful export.
*/
model DatabaseExtensionsProperties {
/**
* Operation Mode.
*/
@visibility("create")
"operationMode": OperationMode;
/**
* Storage key type.
*/
@visibility("create")
"storageKeyType": StorageKeyType;
/**
* Storage key.
*/
@visibility("create")
"storageKey": string;
/**
* Storage Uri.
*/
@visibility("create")
"storageUri": string;
}

/**
* An Extension operation result resource.
*/
model ImportExportExtensionsOperationResult {
/**
* Resource properties.
*/
"properties"?: ImportExportExtensionsOperationResultProperties;
}

/**
* Contains the operation result properties for import/export operation.
*/
model ImportExportExtensionsOperationResultProperties {
/**
* Request Id.
*/
@visibility("read")
"requestId"?: string;
/**
* Request type.
*/
@visibility("read")
"requestType"?: string;
/**
* Last modified time.
*/
@visibility("read")
"lastModifiedTime"?: string;
/**
* Server name.
*/
@visibility("read")
"serverName"?: string;
/**
* Database name.
*/
@visibility("read")
"databaseName"?: string;
/**
* Operation status.
*/
@visibility("read")
"status"?: string;
/**
* Error message.
*/
@visibility("read")
"errorMessage"?: string;
}

/**
* Import export operation extensions list.
*/
model ImportExportExtensionsOperationListResult is Azure.Core.Page<ImportExportExtensionsOperationResult> {
}

/**
* The response to a list database operations request
*/
model DatabaseOperationListResult is Azure.Core.Page<DatabaseOperation> {
}

/**
* A database operation.
*/
model DatabaseOperation {
/**
* Resource properties.
*/
"properties"?: DatabaseOperationProperties;
}

/**
* The properties of a database operation.
*/
model DatabaseOperationProperties {
/**
* The name of the database the operation is being performed on.
*/
@visibility("read")
"databaseName"?: string;
/**
* The name of operation.
*/
@visibility("read")
"operation"?: string;
/**
* The friendly name of operation.
*/
@visibility("read")
"operationFriendlyName"?: string;
/**
* The percentage of the operation completed.
*/
@visibility("read")
"percentComplete"?: int32;
/**
* The name of the server.
*/
@visibility("read")
"serverName"?: string;
/**
* The operation start time.
*/
@visibility("read")
// FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
"startTime"?: utcDateTime;
/**
* The operation state.
*/
@visibility("read")
"state"?: ManagementOperationState;
/**
* The operation error code.
*/
@visibility("read")
"errorCode"?: int32;
/**
* The operation error description.
*/
@visibility("read")
"errorDescription"?: string;
/**
* The operation error severity.
*/
@visibility("read")
"errorSeverity"?: int32;
/**
* Whether or not the error is a user error.
*/
@visibility("read")
"isUserError"?: boolean;
/**
* The estimated completion time of the operation.
*/
@visibility("read")
@projectedName("json", "estimatedCompletionTime")
// FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
"estimatedCompleteOn"?: utcDateTime;
/**
* The operation description.
*/
@visibility("read")
"description"?: string;
/**
* Whether the operation can be cancelled.
*/
@visibility("read")
"isCancellable"?: boolean;
}

/**
* A list of database usage metrics.
*/
model DatabaseUsageListResult is Azure.Core.Page<DatabaseUsage> {
}

/**
* Usage metric of a database.
*/
model DatabaseUsage {
/**
* Resource properties.
*/
"properties"?: DatabaseUsageProperties;
}

/**
* Properties of a database usage.
*/
model DatabaseUsageProperties {
/**
* User-readable name of the metric.
*/
@visibility("read")
"displayName"?: string;
/**
* Current value of the metric.
*/
@visibility("read")
"currentValue"?: float64;
/**
* Boundary value of the metric.
*/
@visibility("read")
"limit"?: float64;
/**
* Unit of the metric.
*/
@visibility("read")
"unit"?: string;
}

/**
* The properties of a database ledger digest upload settings.
*/
model LedgerDigestUploadsProperties {
/**
* The digest storage endpoint, which must be either an Azure blob storage endpoint or an URI for Azure Confidential Ledger.
*/
"digestStorageEndpoint"?: string;
/**
* Specifies the state of ledger digest upload.
*/
@visibility("read")
"state"?: LedgerDigestUploadsState;
}

/**
* The properties of an outbound firewall rule.
*/
model OutboundFirewallRuleProperties {
/**
* The state of the outbound rule.
*/
@visibility("read")
"provisioningState"?: string;
}

/**
* A list of usages.
*/
model UsageListResult is Azure.Core.Page<Usage> {
}

/**
* ARM usage.
*/
model Usage {
/**
* Resource ID.
*/
@visibility("read")
"id"?: string;
/**
* Resource name.
*/
@visibility("read")
"name"?: Name;
/**
* Resource type.
*/
@visibility("read")
"type"?: string;
/**
* Usage unit.
*/
@visibility("read")
"unit"?: string;
/**
* Usage current value.
*/
@visibility("read")
"currentValue"?: int32;
/**
* Usage limit.
*/
@visibility("read")
"limit"?: int32;
/**
* Usage requested limit.
*/
@visibility("read")
"requestedLimit"?: int32;
}

/**
* ARM Usage Name
*/
model Name {
/**
* Usage name value
*/
"value"?: string;
/**
* Usage name localized value.
*/
"localizedValue"?: string;
}

/**
* Contains the information necessary to perform long term retention backup copy operation.
*/
model CopyLongTermRetentionBackupParameters {
/**
* Resource properties.
*/
"properties"?: CopyLongTermRetentionBackupParametersProperties;
}

/**
* Contains the properties to perform long term retention backup copy operation.
*/
model CopyLongTermRetentionBackupParametersProperties {
/**
* The subscription that owns the target server
*/
@visibility("create")
"targetSubscriptionId"?: string;
/**
* The resource group that owns the target server
*/
@visibility("create")
"targetResourceGroup"?: string;
/**
* The resource Id of the target server that owns the database
*/
@visibility("create")
"targetServerResourceId"?: string;
/**
* The fully qualified domain name of the target server
*/
@visibility("create")
"targetServerFullyQualifiedDomainName"?: string;
/**
* The name of the database owns the copied backup.
*/
@visibility("create")
"targetDatabaseName"?: string;
/**
* The storage redundancy type of the copied backup
*/
@visibility("create")
"targetBackupStorageRedundancy"?: BackupStorageRedundancy;
}

/**
* A LongTermRetentionBackup operation result resource.
*/
model LongTermRetentionBackupOperationResult {
/**
* Resource properties.
*/
"properties"?: LongTermRetentionOperationResultProperties;
}

/**
* Contains the operation result properties for long term retention backup operation.
*/
model LongTermRetentionOperationResultProperties {
/**
* Request Id.
*/
@visibility("read")
"requestId"?: string;
/**
* Operation type.
*/
@visibility("read")
"operationType"?: string;
/**
* Source backup resource id
*/
@visibility("read")
"fromBackupResourceId"?: string;
/**
* Target backup resource id
*/
@visibility("read")
"toBackupResourceId"?: string;
/**
* The storage redundancy type of the copied backup
*/
@visibility("read")
"targetBackupStorageRedundancy"?: BackupStorageRedundancy;
/**
* Operation status
*/
@visibility("read")
"status"?: string;
/**
* Progress message
*/
@visibility("read")
"message"?: string;
}

/**
* Contains the information necessary to perform long term retention backup update operation.
*/
model UpdateLongTermRetentionBackupParameters {
/**
* Resource properties.
*/
"properties"?: UpdateLongTermRetentionBackupParametersProperties;
}

/**
* Contains the properties to perform long term retention backup copy operation.
*/
model UpdateLongTermRetentionBackupParametersProperties {
/**
* The storage redundancy type of the copied backup
*/
@visibility("create")
"requestedBackupStorageRedundancy"?: BackupStorageRedundancy;
}

/**
* Properties of a long term retention backup
*/
model LongTermRetentionBackupProperties {
/**
* The server name that the backup database belong to.
*/
@visibility("read")
"serverName"?: string;
/**
* The create time of the server.
*/
@visibility("read")
// FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
"serverCreateTime"?: utcDateTime;
/**
* The name of the database the backup belong to
*/
@visibility("read")
"databaseName"?: string;
/**
* The delete time of the database
*/
@visibility("read")
@projectedName("json", "databaseDeletionTime")
// FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
"databaseDeletedOn"?: utcDateTime;
/**
* The time the backup was taken
*/
@visibility("read")
// FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
"backupTime"?: utcDateTime;
/**
* The time the long term retention backup will expire.
*/
@visibility("read")
@projectedName("json", "backupExpirationTime")
// FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
"backupExpireOn"?: utcDateTime;
/**
* The storage redundancy type of the backup
*/
@visibility("read")
"backupStorageRedundancy"?: BackupStorageRedundancy;
/**
* The storage redundancy type of the backup
*/
@visibility("create", "update")
"requestedBackupStorageRedundancy"?: BackupStorageRedundancy;
}

/**
* Properties of a long term retention backup
*/
model ManagedInstanceLongTermRetentionBackupProperties {
/**
* The managed instance that the backup database belongs to.
*/
@visibility("read")
"managedInstanceName"?: string;
/**
* The create time of the instance.
*/
@visibility("read")
// FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
"managedInstanceCreateTime"?: utcDateTime;
/**
* The name of the database the backup belong to
*/
@visibility("read")
"databaseName"?: string;
/**
* The delete time of the database
*/
@visibility("read")
@projectedName("json", "databaseDeletionTime")
// FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
"databaseDeletedOn"?: utcDateTime;
/**
* The time the backup was taken
*/
@visibility("read")
// FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
"backupTime"?: utcDateTime;
/**
* The time the long term retention backup will expire.
*/
@visibility("read")
@projectedName("json", "backupExpirationTime")
// FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
"backupExpireOn"?: utcDateTime;
/**
* The storage redundancy type of the backup
*/
@visibility("read")
"backupStorageRedundancy"?: BackupStorageRedundancy;
}

/**
* The restorable dropped managed database's properties.
*/
model RestorableDroppedManagedDatabaseProperties {
/**
* The name of the database.
*/
@visibility("read")
"databaseName"?: string;
/**
* The creation date of the database (ISO8601 format).
*/
@visibility("read")
// FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
"creationDate"?: utcDateTime;
/**
* The deletion date of the database (ISO8601 format).
*/
@visibility("read")
// FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
"deletionDate"?: utcDateTime;
/**
* The earliest restore date of the database (ISO8601 format).
*/
@visibility("read")
// FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
"earliestRestoreDate"?: utcDateTime;
}

/**
* The properties of a server connection policy.
*/
model ServerConnectionPolicyProperties {
/**
* The server connection type.
*/
"connectionType": ServerConnectionType;
}

/**
* The properties of a distributed availability group.
*/
model DistributedAvailabilityGroupProperties {
/**
* The name of the target database
*/
"targetDatabase"?: string;
/**
* The source endpoint
*/
"sourceEndpoint"?: string;
/**
* The primary availability group name
*/
"primaryAvailabilityGroupName"?: string;
/**
* The secondary availability group name
*/
"secondaryAvailabilityGroupName"?: string;
/**
* The replication mode of a distributed availability group. Parameter will be ignored during link creation.
*/
"replicationMode"?: ReplicationMode;
/**
* The distributed availability group id
*/
@visibility("read")
"distributedAvailabilityGroupId"?: string;
/**
* The source replica id
*/
@visibility("read")
"sourceReplicaId"?: string;
/**
* The target replica id
*/
@visibility("read")
"targetReplicaId"?: string;
/**
* The link state
*/
@visibility("read")
"linkState"?: string;
/**
* The last hardened lsn
*/
@visibility("read")
"lastHardenedLsn"?: string;
}

/**
* The properties of a server trust certificate.
*/
model ServerTrustCertificateProperties {
/**
* The certificate public blob
*/
"publicBlob"?: string;
/**
* The certificate thumbprint
*/
@visibility("read")
"thumbprint"?: string;
/**
* The certificate name
*/
@visibility("read")
"certificateName"?: string;
}

/**
* The properties of an endpoint certificate.
*/
model EndpointCertificateProperties {
/**
* The certificate public blob
*/
"publicBlob"?: string;
}

/**
* Properties of a sensitivity label.
*/
model SensitivityLabelProperties {
/**
* The schema name.
*/
@visibility("read")
"schemaName"?: string;
/**
* The table name.
*/
@visibility("read")
"tableName"?: string;
/**
* The column name.
*/
@visibility("read")
"columnName"?: string;
/**
* The label name.
*/
"labelName"?: string;
/**
* The label ID.
*/
"labelId"?: string;
/**
* The information type.
*/
"informationType"?: string;
/**
* The information type ID.
*/
"informationTypeId"?: string;
/**
* Is sensitivity recommendation disabled. Applicable for recommended sensitivity label only. Specifies whether the sensitivity recommendation on this column is disabled (dismissed) or not.
*/
@visibility("read")
"isDisabled"?: boolean;
"rank"?: SensitivityLabelRank;
}

/**
* A list of sensitivity labels.
*/
model SensitivityLabelListResult is Azure.Core.Page<SensitivityLabel> {
}

/**
* A list of sensitivity label update operations.
*/
model SensitivityLabelUpdateList {
"operations"?: SensitivityLabelUpdate[];
}

/**
* A sensitivity label update operation.
*/
model SensitivityLabelUpdate{
/**
* Resource properties.
*/
"properties"?: SensitivityLabelUpdateProperties;
}

/**
* Properties of an operation executed on a sensitivity label.
*/
model SensitivityLabelUpdateProperties {
"op": SensitivityLabelUpdateKind;
/**
* Schema name of the column to update.
*/
"schema": string;
/**
* Table name of the column to update.
*/
"table": string;
/**
* Column name to update.
*/
"column": string;
/**
* The sensitivity label information to apply on a column.
*/
"sensitivityLabel"?: SensitivityLabel;
}

/**
* A list of recommended sensitivity label update operations.
*/
model RecommendedSensitivityLabelUpdateList {
"operations"?: RecommendedSensitivityLabelUpdate[];
}

/**
* A recommended sensitivity label update operation.
*/
model RecommendedSensitivityLabelUpdate {
/**
* Resource properties.
*/
"properties"?: RecommendedSensitivityLabelUpdateProperties;
}

/**
* Properties of an operation executed on a recommended sensitivity label.
*/
model RecommendedSensitivityLabelUpdateProperties {
"op": RecommendedSensitivityLabelUpdateKind;
/**
* Schema name of the column to update.
*/
"schema": string;
/**
* Table name of the column to update.
*/
"table": string;
/**
* Column name to update.
*/
"column": string;
}

/**
* Properties of a server blob auditing policy.
*/
model ServerBlobAuditingPolicyProperties {
/**
* Specifies the state of devops audit. If state is Enabled, devops logs will be sent to Azure Monitor.
In order to send the events to Azure Monitor, specify 'State' as 'Enabled', 'IsAzureMonitorTargetEnabled' as true and 'IsDevopsAuditEnabled' as true

When using REST API to configure auditing, Diagnostic Settings with 'DevOpsOperationsAudit' diagnostic logs category on the master database should also be created.

Diagnostic Settings URI format:
PUT https://management.azure.com/subscriptions/{subscriptionId}/resourceGroups/{resourceGroup}/providers/Microsoft.Sql/servers/{serverName}/databases/master/providers/microsoft.insights/diagnosticSettings/{settingsName}?api-version=2017-05-01-preview

For more information, see [Diagnostic Settings REST API](https://go.microsoft.com/fwlink/?linkid=2033207)
or [Diagnostic Settings PowerShell](https://go.microsoft.com/fwlink/?linkid=2033043)

*/
"isDevopsAuditEnabled"?: boolean;
/**
* Specifies the number of days to keep in the audit logs in the storage account.
*/
"retentionDays"?: int32;
/**
* Specifies the Actions-Groups and Actions to audit.

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
*/
"auditActionsAndGroups"?: string[];
/**
* Specifies whether storageAccountAccessKey value is the storage's secondary key.
*/
"isStorageSecondaryKeyInUse"?: boolean;
/**
* Specifies whether audit events are sent to Azure Monitor. 
In order to send the events to Azure Monitor, specify 'State' as 'Enabled' and 'IsAzureMonitorTargetEnabled' as true.

When using REST API to configure auditing, Diagnostic Settings with 'SQLSecurityAuditEvents' diagnostic logs category on the database should be also created.
Note that for server level audit you should use the 'master' database as {databaseName}.

Diagnostic Settings URI format:
PUT https://management.azure.com/subscriptions/{subscriptionId}/resourceGroups/{resourceGroup}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/providers/microsoft.insights/diagnosticSettings/{settingsName}?api-version=2017-05-01-preview

For more information, see [Diagnostic Settings REST API](https://go.microsoft.com/fwlink/?linkid=2033207)
or [Diagnostic Settings PowerShell](https://go.microsoft.com/fwlink/?linkid=2033043)

*/
"isAzureMonitorTargetEnabled"?: boolean;
/**
* Specifies the amount of time in milliseconds that can elapse before audit actions are forced to be processed.
The default minimum value is 1000 (1 second). The maximum is 2,147,483,647.
*/
"queueDelayMs"?: int32;
/**
* Specifies whether Managed Identity is used to access blob storage
*/
"isManagedIdentityInUse"?: boolean;
/**
* Specifies the state of the audit. If state is Enabled, storageEndpoint or isAzureMonitorTargetEnabled are required.
*/
"state": BlobAuditingPolicyState;
/**
* Specifies the blob storage endpoint (e.g. https://MyAccount.blob.core.windows.net). If state is Enabled, storageEndpoint or isAzureMonitorTargetEnabled is required.
*/
"storageEndpoint"?: string;
/**
* Specifies the identifier key of the auditing storage account. 
If state is Enabled and storageEndpoint is specified, not specifying the storageAccountAccessKey will use SQL server system-assigned managed identity to access the storage.
Prerequisites for using managed identity authentication:
1. Assign SQL Server a system-assigned managed identity in Azure Active Directory (AAD).
2. Grant SQL Server identity access to the storage account by adding 'Storage Blob Data Contributor' RBAC role to the server identity.
For more information, see [Auditing to storage using Managed Identity authentication](https://go.microsoft.com/fwlink/?linkid=2114355)
*/
@visibility("create", "update")
"storageAccountAccessKey"?: string;
/**
* Specifies the blob storage subscription Id.
*/
"storageAccountSubscriptionId"?: string;
}

/**
* Properties of a database blob auditing policy.
*/
model DatabaseBlobAuditingPolicyProperties {
/**
* Specifies the number of days to keep in the audit logs in the storage account.
*/
"retentionDays"?: int32;
/**
* Specifies the Actions-Groups and Actions to audit.

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
*/
"auditActionsAndGroups"?: string[];
/**
* Specifies whether storageAccountAccessKey value is the storage's secondary key.
*/
"isStorageSecondaryKeyInUse"?: boolean;
/**
* Specifies whether audit events are sent to Azure Monitor. 
In order to send the events to Azure Monitor, specify 'State' as 'Enabled' and 'IsAzureMonitorTargetEnabled' as true.

When using REST API to configure auditing, Diagnostic Settings with 'SQLSecurityAuditEvents' diagnostic logs category on the database should be also created.
Note that for server level audit you should use the 'master' database as {databaseName}.

Diagnostic Settings URI format:
PUT https://management.azure.com/subscriptions/{subscriptionId}/resourceGroups/{resourceGroup}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/providers/microsoft.insights/diagnosticSettings/{settingsName}?api-version=2017-05-01-preview

For more information, see [Diagnostic Settings REST API](https://go.microsoft.com/fwlink/?linkid=2033207)
or [Diagnostic Settings PowerShell](https://go.microsoft.com/fwlink/?linkid=2033043)

*/
"isAzureMonitorTargetEnabled"?: boolean;
/**
* Specifies the amount of time in milliseconds that can elapse before audit actions are forced to be processed.
The default minimum value is 1000 (1 second). The maximum is 2,147,483,647.
*/
"queueDelayMs"?: int32;
/**
* Specifies whether Managed Identity is used to access blob storage
*/
"isManagedIdentityInUse"?: boolean;
/**
* Specifies the state of the audit. If state is Enabled, storageEndpoint or isAzureMonitorTargetEnabled are required.
*/
"state": BlobAuditingPolicyState;
/**
* Specifies the blob storage endpoint (e.g. https://MyAccount.blob.core.windows.net). If state is Enabled, storageEndpoint or isAzureMonitorTargetEnabled is required.
*/
"storageEndpoint"?: string;
/**
* Specifies the identifier key of the auditing storage account. 
If state is Enabled and storageEndpoint is specified, not specifying the storageAccountAccessKey will use SQL server system-assigned managed identity to access the storage.
Prerequisites for using managed identity authentication:
1. Assign SQL Server a system-assigned managed identity in Azure Active Directory (AAD).
2. Grant SQL Server identity access to the storage account by adding 'Storage Blob Data Contributor' RBAC role to the server identity.
For more information, see [Auditing to storage using Managed Identity authentication](https://go.microsoft.com/fwlink/?linkid=2114355)
*/
@visibility("create", "update")
"storageAccountAccessKey"?: string;
/**
* Specifies the blob storage subscription Id.
*/
"storageAccountSubscriptionId"?: string;
}

/**
* Properties of an extended database blob auditing policy.
*/
model ExtendedDatabaseBlobAuditingPolicyProperties {
/**
* Specifies condition of where clause when creating an audit.
*/
"predicateExpression"?: string;
/**
* Specifies the number of days to keep in the audit logs in the storage account.
*/
"retentionDays"?: int32;
/**
* Specifies the Actions-Groups and Actions to audit.

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
*/
"auditActionsAndGroups"?: string[];
/**
* Specifies whether storageAccountAccessKey value is the storage's secondary key.
*/
"isStorageSecondaryKeyInUse"?: boolean;
/**
* Specifies whether audit events are sent to Azure Monitor. 
In order to send the events to Azure Monitor, specify 'State' as 'Enabled' and 'IsAzureMonitorTargetEnabled' as true.

When using REST API to configure auditing, Diagnostic Settings with 'SQLSecurityAuditEvents' diagnostic logs category on the database should be also created.
Note that for server level audit you should use the 'master' database as {databaseName}.

Diagnostic Settings URI format:
PUT https://management.azure.com/subscriptions/{subscriptionId}/resourceGroups/{resourceGroup}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/providers/microsoft.insights/diagnosticSettings/{settingsName}?api-version=2017-05-01-preview

For more information, see [Diagnostic Settings REST API](https://go.microsoft.com/fwlink/?linkid=2033207)
or [Diagnostic Settings PowerShell](https://go.microsoft.com/fwlink/?linkid=2033043)

*/
"isAzureMonitorTargetEnabled"?: boolean;
/**
* Specifies the amount of time in milliseconds that can elapse before audit actions are forced to be processed.
The default minimum value is 1000 (1 second). The maximum is 2,147,483,647.
*/
"queueDelayMs"?: int32;
/**
* Specifies whether Managed Identity is used to access blob storage
*/
"isManagedIdentityInUse"?: boolean;
/**
* Specifies the state of the audit. If state is Enabled, storageEndpoint or isAzureMonitorTargetEnabled are required.
*/
"state": BlobAuditingPolicyState;
/**
* Specifies the blob storage endpoint (e.g. https://MyAccount.blob.core.windows.net). If state is Enabled, storageEndpoint or isAzureMonitorTargetEnabled is required.
*/
"storageEndpoint"?: string;
/**
* Specifies the identifier key of the auditing storage account. 
If state is Enabled and storageEndpoint is specified, not specifying the storageAccountAccessKey will use SQL server system-assigned managed identity to access the storage.
Prerequisites for using managed identity authentication:
1. Assign SQL Server a system-assigned managed identity in Azure Active Directory (AAD).
2. Grant SQL Server identity access to the storage account by adding 'Storage Blob Data Contributor' RBAC role to the server identity.
For more information, see [Auditing to storage using Managed Identity authentication](https://go.microsoft.com/fwlink/?linkid=2114355)
*/
@visibility("create", "update")
"storageAccountAccessKey"?: string;
/**
* Specifies the blob storage subscription Id.
*/
"storageAccountSubscriptionId"?: string;
}

/**
* Properties of an extended server blob auditing policy.
*/
model ExtendedServerBlobAuditingPolicyProperties {
/**
* Specifies the state of devops audit. If state is Enabled, devops logs will be sent to Azure Monitor.
In order to send the events to Azure Monitor, specify 'State' as 'Enabled', 'IsAzureMonitorTargetEnabled' as true and 'IsDevopsAuditEnabled' as true

When using REST API to configure auditing, Diagnostic Settings with 'DevOpsOperationsAudit' diagnostic logs category on the master database should also be created.

Diagnostic Settings URI format:
PUT https://management.azure.com/subscriptions/{subscriptionId}/resourceGroups/{resourceGroup}/providers/Microsoft.Sql/servers/{serverName}/databases/master/providers/microsoft.insights/diagnosticSettings/{settingsName}?api-version=2017-05-01-preview

For more information, see [Diagnostic Settings REST API](https://go.microsoft.com/fwlink/?linkid=2033207)
or [Diagnostic Settings PowerShell](https://go.microsoft.com/fwlink/?linkid=2033043)

*/
"isDevopsAuditEnabled"?: boolean;
/**
* Specifies condition of where clause when creating an audit.
*/
"predicateExpression"?: string;
/**
* Specifies the number of days to keep in the audit logs in the storage account.
*/
"retentionDays"?: int32;
/**
* Specifies the Actions-Groups and Actions to audit.

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
*/
"auditActionsAndGroups"?: string[];
/**
* Specifies whether storageAccountAccessKey value is the storage's secondary key.
*/
"isStorageSecondaryKeyInUse"?: boolean;
/**
* Specifies whether audit events are sent to Azure Monitor. 
In order to send the events to Azure Monitor, specify 'State' as 'Enabled' and 'IsAzureMonitorTargetEnabled' as true.

When using REST API to configure auditing, Diagnostic Settings with 'SQLSecurityAuditEvents' diagnostic logs category on the database should be also created.
Note that for server level audit you should use the 'master' database as {databaseName}.

Diagnostic Settings URI format:
PUT https://management.azure.com/subscriptions/{subscriptionId}/resourceGroups/{resourceGroup}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/providers/microsoft.insights/diagnosticSettings/{settingsName}?api-version=2017-05-01-preview

For more information, see [Diagnostic Settings REST API](https://go.microsoft.com/fwlink/?linkid=2033207)
or [Diagnostic Settings PowerShell](https://go.microsoft.com/fwlink/?linkid=2033043)

*/
"isAzureMonitorTargetEnabled"?: boolean;
/**
* Specifies the amount of time in milliseconds that can elapse before audit actions are forced to be processed.
The default minimum value is 1000 (1 second). The maximum is 2,147,483,647.
*/
"queueDelayMs"?: int32;
/**
* Specifies whether Managed Identity is used to access blob storage
*/
"isManagedIdentityInUse"?: boolean;
/**
* Specifies the state of the audit. If state is Enabled, storageEndpoint or isAzureMonitorTargetEnabled are required.
*/
"state": BlobAuditingPolicyState;
/**
* Specifies the blob storage endpoint (e.g. https://MyAccount.blob.core.windows.net). If state is Enabled, storageEndpoint or isAzureMonitorTargetEnabled is required.
*/
"storageEndpoint"?: string;
/**
* Specifies the identifier key of the auditing storage account. 
If state is Enabled and storageEndpoint is specified, not specifying the storageAccountAccessKey will use SQL server system-assigned managed identity to access the storage.
Prerequisites for using managed identity authentication:
1. Assign SQL Server a system-assigned managed identity in Azure Active Directory (AAD).
2. Grant SQL Server identity access to the storage account by adding 'Storage Blob Data Contributor' RBAC role to the server identity.
For more information, see [Auditing to storage using Managed Identity authentication](https://go.microsoft.com/fwlink/?linkid=2114355)
*/
@visibility("create", "update")
"storageAccountAccessKey"?: string;
/**
* Specifies the blob storage subscription Id.
*/
"storageAccountSubscriptionId"?: string;
}

/**
* Properties of an Advanced Threat Protection state.
*/
model AdvancedThreatProtectionProperties {
/**
* Specifies the state of the Advanced Threat Protection, whether it is enabled or disabled or a state has not been applied yet on the specific database or server.
*/
"state": AdvancedThreatProtectionState;
/**
* Specifies the UTC creation time of the policy.
*/
@visibility("read")
// FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
"creationTime"?: utcDateTime;
}

/**
* Properties of a managed server DNS alias.
*/
model ManagedServerDnsAliasProperties {
/**
* The fully qualified DNS record for managed server alias
*/
@visibility("read")
"azureDnsRecord"?: string;
/**
* The fully qualified public DNS record for managed server alias
*/
@visibility("read")
"publicAzureDnsRecord"?: string;
}

/**
* A managed server dns alias creation request.
*/
model ManagedServerDnsAliasCreation {
/**
* Whether or not DNS record should be created for this alias.
*/
"createDnsRecord"?: boolean = true;
}

/**
* A managed server DNS alias acquisition request.
*/
model ManagedServerDnsAliasAcquisition {
/**
* The resource ID of the managed server DNS alias that will be acquired to point to this managed server instead.
*/
"oldManagedServerDnsAliasResourceId": string;
}

/**
* Properties of a replication link.
*/
model ReplicationLinkProperties {
/**
* Resource partner server.
*/
@visibility("read")
"partnerServer"?: string;
/**
* Resource partner database.
*/
@visibility("read")
"partnerDatabase"?: string;
/**
* Resource partner location.
*/
@visibility("read")
"partnerLocation"?: string;
/**
* Local replication role.
*/
@visibility("read")
"role"?: ReplicationRole;
/**
* Partner replication role.
*/
@visibility("read")
"partnerRole"?: ReplicationRole;
/**
* Replication mode.
*/
@visibility("read")
"replicationMode"?: string;
/**
* Time at which the link was created.
*/
@visibility("read")
// FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
"startTime"?: utcDateTime;
/**
* Seeding completion percentage for the link.
*/
@visibility("read")
"percentComplete"?: int32;
/**
* Replication state (PENDING, SEEDING, CATCHUP, SUSPENDED).
*/
@visibility("read")
"replicationState"?: ReplicationState;
/**
* Whether the user is currently allowed to terminate the link.
*/
@visibility("read")
"isTerminationAllowed"?: boolean;
/**
* Link type (GEO, NAMED, STANDBY).
*/
@visibility("read")
"linkType"?: ReplicationLinkType;
}

/**
* The properties of managed instance DTC.
*/
model ManagedInstanceDtcProperties {
/**
* Active status of managed instance DTC.
*/
"dtcEnabled"?: boolean;
/**
* Security settings of managed instance DTC.
*/
"securitySettings"?: ManagedInstanceDtcSecuritySettings;
/**
* External dns suffix search list of managed instance DTC.
*/
"externalDnsSuffixSearchList"?: string[];
/**
* Host name dns suffix of managed instance DTC.
*/
@visibility("read")
"dtcHostNameDnsSuffix"?: string;
/**
* Provisioning state of managed instance DTC.
*/
@visibility("read")
"provisioningState"?: ProvisioningState;
}

/**
* The Security Settings of managed instance DTC.
*/
model ManagedInstanceDtcSecuritySettings {
/**
* Transaction Manager communication settings of managed instance DTC.
*/
"transactionManagerCommunicationSettings"?: ManagedInstanceDtcTransactionManagerCommunicationSettings;
/**
* Allow XA Transactions to managed instance DTC.
*/
"xaTransactionsEnabled"?: boolean;
/**
* Allow SNA LU 6.2 Transactions to managed instance DTC.
*/
@projectedName("json", "snaLu6point2TransactionsEnabled")
"snaLu6Point2TransactionsEnabled"?: boolean;
/**
* Default timeout for XA Transactions (in seconds).
*/
"xaTransactionsDefaultTimeout"?: int32;
/**
* Maximum timeout for XA Transactions (in seconds).
*/
"xaTransactionsMaximumTimeout"?: int32;
}

/**
* The Transaction Manager Communication Settings of managed instance DTC.
*/
model ManagedInstanceDtcTransactionManagerCommunicationSettings {
/**
* Allow Inbound traffic to managed instance DTC.
*/
"allowInboundEnabled"?: boolean;
/**
* Allow Outbound traffic of managed instance DTC.
*/
"allowOutboundEnabled"?: boolean;
/**
* Authentication type of managed instance DTC.
*/
"authentication"?: string;
}

/**
* A list of synapselink workspaces
*/
model SynapseLinkWorkspaceListResult is Azure.Core.Page<SynapseLinkWorkspace> {
}

/**
* Synapse link workspace resource
*/
model SynapseLinkWorkspace {
/**
* Resource properties.
*/
"properties"?: SynapseLinkWorkspaceProperties;
}

/**
* Properties of a Synapse link workspaces
*/
model SynapseLinkWorkspaceProperties {
/**
* List of all synapselink workspaces
*/
"workspaces"?: SynapseLinkWorkspaceInfoProperties[];
}

/**
* Properties of a Synapse link workspaces
*/
model SynapseLinkWorkspaceInfoProperties {
/**
* Synapse link workspace id.
*/
"workspaceId"?: string;
/**
* Link connection name.
*/
"linkConnectionName"?: string;
}

/**
* The properties of a virtual cluster.
*/
model VirtualClusterProperties {
/**
* Subnet resource ID for the virtual cluster.
*/
@visibility("read")
"subnetId"?: string;
/**
* Virtual cluster version.
*/
"version"?: string;
/**
* List of resources in this virtual cluster.
*/
@visibility("read")
"childResources"?: string[];
}

/**
* An update request for virtual cluster.
*/
model VirtualClusterUpdate {
/**
* Resource properties.
*/
"properties"?: VirtualClusterProperties;
/**
* Resource tags.
*/
"tags"?: Record<string>;
}

/**
* A refresh DNS servers operation.
*/
model UpdateVirtualClusterDnsServersOperation {
/**
* Resource properties.
*/
"properties"?: VirtualClusterDnsServersProperties;
}

/**
* The properties of dns servers on virtual cluster.
*/
model VirtualClusterDnsServersProperties {
/**
* The status of the DNS refresh operation.
*/
@visibility("read")
"status"?: DNSRefreshOperationStatus;
}

/**
* Properties of a instance failover group.
*/
model InstanceFailoverGroupProperties {
/**
* Type of the geo-secondary instance. Set 'Standby' if the instance is used as a DR option only.
*/
"secondaryType"?: SecondaryInstanceType;
/**
* Read-write endpoint of the failover group instance.
*/
"readWriteEndpoint": InstanceFailoverGroupReadWriteEndpoint;
/**
* Read-only endpoint of the failover group instance.
*/
"readOnlyEndpoint"?: InstanceFailoverGroupReadOnlyEndpoint;
/**
* Local replication role of the failover group instance.
*/
@visibility("read")
"replicationRole"?: InstanceFailoverGroupReplicationRole;
/**
* Replication state of the failover group instance.
*/
@visibility("read")
"replicationState"?: string;
/**
* Partner region information for the failover group.
*/
@visibility("read", "create")
"partnerRegions": PartnerRegionInfo[];
/**
* List of managed instance pairs in the failover group.
*/
"managedInstancePairs": ManagedInstancePairInfo[];
}

/**
* Read-write endpoint of the failover group instance.
*/
model InstanceFailoverGroupReadWriteEndpoint {
/**
* Failover policy of the read-write endpoint for the failover group. If failoverPolicy is Automatic then failoverWithDataLossGracePeriodMinutes is required.
*/
"failoverPolicy": ReadWriteEndpointFailoverPolicy;
/**
* Grace period before failover with data loss is attempted for the read-write endpoint. If failoverPolicy is Automatic then failoverWithDataLossGracePeriodMinutes is required.
*/
"failoverWithDataLossGracePeriodMinutes"?: int32;
}

/**
* Read-only endpoint of the failover group instance.
*/
model InstanceFailoverGroupReadOnlyEndpoint {
/**
* Failover policy of the read-only endpoint for the failover group.
*/
"failoverPolicy"?: ReadOnlyEndpointFailoverPolicy;
}

/**
* Partner region information for the failover group.
*/
model PartnerRegionInfo {
/**
* Geo location of the partner managed instances.
*/
"location"?: string;
/**
* Replication role of the partner managed instances.
*/
@visibility("read")
"replicationRole"?: InstanceFailoverGroupReplicationRole;
}

/**
* Pairs of Managed Instances in the failover group.
*/
model ManagedInstancePairInfo {
/**
* Id of Primary Managed Instance in pair.
*/
"primaryManagedInstanceId"?: string;
/**
* Id of Partner Managed Instance in pair.
*/
"partnerManagedInstanceId"?: string;
}

/**
* The managed database's restore details properties.
*/
model ManagedDatabaseRestoreDetailsProperties {
/**
* Restore type.
*/
@visibility("read")
"type"?: string;
/**
* Restore status.
*/
@visibility("read")
"status"?: string;
/**
* The reason why restore is in Blocked state.
*/
@visibility("read")
"blockReason"?: string;
/**
* Last uploaded file name.
*/
@visibility("read")
"lastUploadedFileName"?: string;
/**
* Last uploaded file time.
*/
@visibility("read")
// FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
"lastUploadedFileTime"?: utcDateTime;
/**
* Last restored file name.
*/
@visibility("read")
"lastRestoredFileName"?: string;
/**
* Last restored file time.
*/
@visibility("read")
// FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
"lastRestoredFileTime"?: utcDateTime;
/**
* Percent completed.
*/
@visibility("read")
@projectedName("json", "percentCompleted")
"completedPercent"?: int32;
/**
* Current restored size MB.
*/
@visibility("read")
"currentRestoredSizeMB"?: int32;
/**
* Current restore plan size MB.
*/
@visibility("read")
"currentRestorePlanSizeMB"?: int32;
/**
* Current backup type.
*/
@visibility("read")
"currentBackupType"?: string;
/**
* Current restoring file name.
*/
@visibility("read")
"currentRestoringFileName"?: string;
/**
* Number of files detected.
*/
@visibility("read")
@projectedName("json", "numberOfFilesDetected")
"numberOfFilesFound"?: int32;
/**
* Number of files queued.
*/
@visibility("read")
"numberOfFilesQueued"?: int32;
/**
* Number of files skipped.
*/
@visibility("read")
"numberOfFilesSkipped"?: int32;
/**
* Number of files restoring.
*/
@visibility("read")
"numberOfFilesRestoring"?: int32;
/**
* Number of files restored.
*/
@visibility("read")
"numberOfFilesRestored"?: int32;
/**
* Number of files unrestorable.
*/
@visibility("read")
"numberOfFilesUnrestorable"?: int32;
/**
* Full backup sets.
*/
@visibility("read")
"fullBackupSets"?: ManagedDatabaseRestoreDetailsBackupSetProperties[];
/**
* Diff backup sets.
*/
@visibility("read")
"diffBackupSets"?: ManagedDatabaseRestoreDetailsBackupSetProperties[];
/**
* Log backup sets.
*/
@visibility("read")
"logBackupSets"?: ManagedDatabaseRestoreDetailsBackupSetProperties[];
/**
* Unrestorable files.
*/
@visibility("read")
@projectedName("json", "unrestorableFiles")
"unrestorableFileList"?: ManagedDatabaseRestoreDetailsUnrestorableFileProperties[];
}

/**
* The managed database's restore details backup set properties.
*/
model ManagedDatabaseRestoreDetailsBackupSetProperties {
/**
* Backup set status.
*/
@visibility("read")
"status"?: string;
/**
* First stripe name.
*/
@visibility("read")
"firstStripeName"?: string;
/**
* Number of stripes.
*/
@visibility("read")
"numberOfStripes"?: int32;
/**
* Backup size.
*/
@visibility("read")
"backupSizeMB"?: int32;
/**
* Last restored file time.
*/
@visibility("read")
// FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
"restoreStartedTimestampUtc"?: utcDateTime;
/**
* Last restored file time.
*/
@visibility("read")
// FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
"restoreFinishedTimestampUtc"?: utcDateTime;
}

/**
* The managed database's restore details unrestorable file properties.
*/
model ManagedDatabaseRestoreDetailsUnrestorableFileProperties {
/**
* File name.
*/
@visibility("read")
"name"?: string;
}

/**
* Azure Active Directory identity configuration for a resource.
*/
model DatabaseIdentity {
/**
* The identity type
*/
"type"?: DatabaseIdentityType;
/**
* The Azure Active Directory tenant id.
*/
@visibility("read")
"tenantId"?: string;
/**
* The resource ids of the user assigned identities to use
*/
"userAssignedIdentities"?: Record<DatabaseUserIdentity>;
}

/**
* Azure Active Directory identity configuration for a resource.
*/
model DatabaseUserIdentity {
/**
* The Azure Active Directory principal id.
*/
@visibility("read")
"principalId"?: string;
/**
* The Azure Active Directory client id.
*/
@visibility("read")
"clientId"?: string;
}

/**
* The database's properties.
*/
model DatabaseProperties {
/**
* Specifies the mode of database creation.

Default: regular database creation.

Copy: creates a database as a copy of an existing database. sourceDatabaseId must be specified as the resource ID of the source database.

Secondary: creates a database as a secondary replica of an existing database. sourceDatabaseId must be specified as the resource ID of the existing primary database.

PointInTimeRestore: Creates a database by restoring a point in time backup of an existing database. sourceDatabaseId must be specified as the resource ID of the existing database, and restorePointInTime must be specified.

Recovery: Creates a database by restoring a geo-replicated backup. sourceDatabaseId must be specified as the recoverable database resource ID to restore.

Restore: Creates a database by restoring a backup of a deleted database. sourceDatabaseId must be specified. If sourceDatabaseId is the database's original resource ID, then sourceDatabaseDeletionDate must be specified. Otherwise sourceDatabaseId must be the restorable dropped database resource ID and sourceDatabaseDeletionDate is ignored. restorePointInTime may also be specified to restore from an earlier point in time.

RestoreLongTermRetentionBackup: Creates a database by restoring from a long term retention vault. recoveryServicesRecoveryPointResourceId must be specified as the recovery point resource ID.

Copy, Secondary, and RestoreLongTermRetentionBackup are not supported for DataWarehouse edition.
*/
@visibility("create")
"createMode"?: CreateMode;
/**
* The collation of the database.
*/
@visibility("read", "create")
"collation"?: string;
/**
* The max size of the database expressed in bytes.
*/
"maxSizeBytes"?: int64;
/**
* The name of the sample schema to apply when creating this database.
*/
@visibility("create")
"sampleName"?: SampleName;
/**
* The resource identifier of the elastic pool containing this database.
*/
"elasticPoolId"?: ResourceIdentifier<[{type: "Microsoft.Sql/servers/elasticPools";}]>;
/**
* The resource identifier of the source database associated with create operation of this database.
*/
@visibility("create")
"sourceDatabaseId"?: ResourceIdentifier<[{type: "undefined";}]>;
/**
* The status of the database.
*/
@visibility("read")
"status"?: DatabaseStatus;
/**
* The ID of the database.
*/
@visibility("read")
"databaseId"?: string;
/**
* The creation date of the database (ISO8601 format).
*/
@visibility("read")
// FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
"creationDate"?: utcDateTime;
/**
* The current service level objective name of the database.
*/
@visibility("read")
"currentServiceObjectiveName"?: string;
/**
* The requested service level objective name of the database.
*/
@visibility("read")
"requestedServiceObjectiveName"?: string;
/**
* The default secondary region for this database.
*/
@visibility("read")
"defaultSecondaryLocation"?: string;
/**
* Failover Group resource identifier that this database belongs to.
*/
@visibility("read")
"failoverGroupId"?: string;
/**
* Specifies the point in time (ISO8601 format) of the source database that will be restored to create the new database.
*/
@visibility("create")
// FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
"restorePointInTime"?: utcDateTime;
/**
* Specifies the time that the database was deleted.
*/
@visibility("create")
@projectedName("json", "sourceDatabaseDeletionDate")
// FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
"sourceDatabaseDeletedOn"?: utcDateTime;
/**
* The resource identifier of the recovery point associated with create operation of this database.
*/
@visibility("create")
"recoveryServicesRecoveryPointId"?: ResourceIdentifier<[{type: "undefined";}]>;
/**
* The resource identifier of the long term retention backup associated with create operation of this database.
*/
@visibility("create")
"longTermRetentionBackupResourceId"?: ResourceIdentifier<[{type: "Microsoft.Sql/locations/longTermRetentionBackups";}]>;
/**
* The resource identifier of the recoverable database associated with create operation of this database.
*/
@visibility("create")
"recoverableDatabaseId"?: ResourceIdentifier<[{type: "undefined";}]>;
/**
* The resource identifier of the restorable dropped database associated with create operation of this database.
*/
@visibility("create")
"restorableDroppedDatabaseId"?: ResourceIdentifier<[{type: "undefined";}]>;
/**
* Collation of the metadata catalog.
*/
@visibility("read", "create")
"catalogCollation"?: CatalogCollationType;
/**
* Whether or not this database is zone redundant, which means the replicas of this database will be spread across multiple availability zones.
*/
@projectedName("json", "zoneRedundant")
"IsZoneRedundant"?: boolean;
/**
* The license type to apply for this database. `LicenseIncluded` if you need a license, or `BasePrice` if you have a license and are eligible for the Azure Hybrid Benefit.
*/
"licenseType"?: DatabaseLicenseType;
/**
* The max log size for this database.
*/
@visibility("read")
"maxLogSizeBytes"?: int64;
/**
* This records the earliest start date and time that restore is available for this database (ISO8601 format).
*/
@visibility("read")
// FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
"earliestRestoreDate"?: utcDateTime;
/**
* The state of read-only routing. If enabled, connections that have application intent set to readonly in their connection string may be routed to a readonly secondary replica in the same region. Not applicable to a Hyperscale database within an elastic pool.
*/
@visibility("read", "update")
"readScale"?: DatabaseReadScale;
/**
* The number of secondary replicas associated with the database that are used to provide high availability. Not applicable to a Hyperscale database within an elastic pool.
*/
"highAvailabilityReplicaCount"?: int32;
/**
* The secondary type of the database if it is a secondary.  Valid values are Geo, Named and Standby.
*/
"secondaryType"?: SecondaryType;
/**
* The name and tier of the SKU.
*/
@visibility("read")
"currentSku"?: Sku;
/**
* Time in minutes after which database is automatically paused. A value of -1 means that automatic pause is disabled
*/
"autoPauseDelay"?: int32;
/**
* The storage account type used to store backups for this database.
*/
@visibility("read")
"currentBackupStorageRedundancy"?: BackupStorageRedundancy;
/**
* The storage account type to be used to store backups for this database.
*/
"requestedBackupStorageRedundancy"?: BackupStorageRedundancy;
/**
* Minimal capacity that database will always have allocated, if not paused
*/
"minCapacity"?: float64;
/**
* The date when database was paused by user configuration or action(ISO8601 format). Null if the database is ready.
*/
@visibility("read")
// FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
"pausedDate"?: utcDateTime;
/**
* The date when database was resumed by user action or database login (ISO8601 format). Null if the database is paused.
*/
@visibility("read")
// FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
"resumedDate"?: utcDateTime;
/**
* Maintenance configuration id assigned to the database. This configuration defines the period when the maintenance updates will occur.
*/
"maintenanceConfigurationId"?: string;
/**
* Whether or not this database is a ledger database, which means all tables in the database are ledger tables. Note: the value of this property cannot be changed after the database has been created.
*/
"isLedgerOn"?: boolean;
/**
* Infra encryption is enabled for this database.
*/
@visibility("read")
"isInfraEncryptionEnabled"?: boolean;
/**
* The Client id used for cross tenant per database CMK scenario
*/
"federatedClientId"?: string;
/**
* The resource ids of the user assigned identities to use
*/
"keys"?: Record<DatabaseKey>;
/**
* The azure key vault URI of the database if it's configured with per Database Customer Managed Keys.
*/
"encryptionProtector"?: string;
/**
* Type of enclave requested on the database i.e. Default or VBS enclaves.
*/
"preferredEnclaveType"?: AlwaysEncryptedEnclaveType;
/**
* Whether or not the database uses free monthly limits. Allowed on one database in a subscription.
*/
"useFreeLimit"?: boolean;
/**
* Specifies the behavior when monthly free limits are exhausted for the free database.

AutoPause: The database will be auto paused upon exhaustion of free limits for remainder of the month.

BillForUsage: The database will continue to be online upon exhaustion of free limits and any overage will be billed.
*/
"freeLimitExhaustionBehavior"?: FreeLimitExhaustionBehavior;
/**
* The resource identifier of the source associated with the create operation of this database.

This property is only supported for DataWarehouse edition and allows to restore across subscriptions.

When sourceResourceId is specified, sourceDatabaseId, recoverableDatabaseId, restorableDroppedDatabaseId and sourceDatabaseDeletionDate must not be specified and CreateMode must be PointInTimeRestore, Restore or Recover.

When createMode is PointInTimeRestore, sourceResourceId must be the resource ID of the existing database or existing sql pool, and restorePointInTime must be specified.

When createMode is Restore, sourceResourceId must be the resource ID of restorable dropped database or restorable dropped sql pool.

When createMode is Recover, sourceResourceId must be the resource ID of recoverable database or recoverable sql pool.

When source subscription belongs to a different tenant than target subscription, “x-ms-authorization-auxiliary” header must contain authentication token for the source tenant. For more details about “x-ms-authorization-auxiliary” header see https://docs.microsoft.com/en-us/azure/azure-resource-manager/management/authenticate-multi-tenant 
*/
@visibility("create")
"sourceResourceId"?: ResourceIdentifier<[{type: "undefined";}]>;
/**
* Whether or not customer controlled manual cutover needs to be done during Update Database operation to Hyperscale tier.

This property is only applicable when scaling database from Business Critical/General Purpose/Premium/Standard tier to Hyperscale tier.

When manualCutover is specified, the scaling operation will wait for user input to trigger cutover to Hyperscale database.

To trigger cutover, please provide 'performCutover' parameter when the Scaling operation is in Waiting state.
*/
"manualCutover"?: boolean;
/**
* To trigger customer controlled manual cutover during the wait state while Scaling operation is in progress.

This property parameter is only applicable for scaling operations that are initiated along with 'manualCutover' parameter.

This property is only applicable when scaling database from Business Critical/General Purpose/Premium/Standard tier to Hyperscale tier is already in progress.

When performCutover is specified, the scaling operation will trigger cutover and perform role-change to Hyperscale database.
*/
"performCutover"?: boolean;
/**
* Specifies the availability zone the database is pinned to.
*/
"availabilityZone"?: AvailabilityZoneType;
/**
* The flag to enable or disable auto rotation of database encryption protector AKV key.
*/
"encryptionProtectorAutoRotation"?: boolean;
}

/**
* Database level key used for encryption at rest.
*/
model DatabaseKey {
/**
* The database key type. Only supported value is 'AzureKeyVault'.
*/
@visibility("read")
"type"?: DatabaseKeyType;
/**
* Thumbprint of the database key.
*/
@visibility("read")
"thumbprint"?: string;
/**
* The database key creation date.
*/
@visibility("read")
// FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
"creationDate"?: utcDateTime;
/**
* Subregion of the server key.
*/
@visibility("read")
"subregion"?: string;
}

/**
* A database update resource.
*/
model DatabaseUpdate {
/**
* The name and tier of the SKU.
*/
"sku"?: Sku;
/**
* Database identity
*/
"identity"?: DatabaseIdentity;
/**
* Resource properties.
*/
"properties"?: DatabaseUpdateProperties;
/**
* Resource tags.
*/
"tags"?: Record<string>;
}

/**
* A database update properties.
*/
model DatabaseUpdateProperties {
/**
* Specifies the mode of database creation.

Default: regular database creation.

Copy: creates a database as a copy of an existing database. sourceDatabaseId must be specified as the resource ID of the source database.

Secondary: creates a database as a secondary replica of an existing database. sourceDatabaseId must be specified as the resource ID of the existing primary database.

PointInTimeRestore: Creates a database by restoring a point in time backup of an existing database. sourceDatabaseId must be specified as the resource ID of the existing database, and restorePointInTime must be specified.

Recovery: Creates a database by restoring a geo-replicated backup. sourceDatabaseId must be specified as the recoverable database resource ID to restore.

Restore: Creates a database by restoring a backup of a deleted database. sourceDatabaseId must be specified. If sourceDatabaseId is the database's original resource ID, then sourceDatabaseDeletionDate must be specified. Otherwise sourceDatabaseId must be the restorable dropped database resource ID and sourceDatabaseDeletionDate is ignored. restorePointInTime may also be specified to restore from an earlier point in time.

RestoreLongTermRetentionBackup: Creates a database by restoring from a long term retention vault. recoveryServicesRecoveryPointResourceId must be specified as the recovery point resource ID.

Copy, Secondary, and RestoreLongTermRetentionBackup are not supported for DataWarehouse edition.
*/
@visibility("create")
"createMode"?: CreateMode;
/**
* The collation of the database.
*/
@visibility("read", "create")
"collation"?: string;
/**
* The max size of the database expressed in bytes.
*/
"maxSizeBytes"?: int64;
/**
* The name of the sample schema to apply when creating this database.
*/
@visibility("create")
"sampleName"?: SampleName;
/**
* The resource identifier of the elastic pool containing this database.
*/
"elasticPoolId"?: ResourceIdentifier<[{type: "Microsoft.Sql/servers/elasticPools";}]>;
/**
* The resource identifier of the source database associated with create operation of this database.
*/
@visibility("create")
"sourceDatabaseId"?: ResourceIdentifier<[{type: "undefined";}]>;
/**
* The status of the database.
*/
@visibility("read")
"status"?: DatabaseStatus;
/**
* The ID of the database.
*/
@visibility("read")
"databaseId"?: string;
/**
* The creation date of the database (ISO8601 format).
*/
@visibility("read")
// FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
"creationDate"?: utcDateTime;
/**
* The current service level objective name of the database.
*/
@visibility("read")
"currentServiceObjectiveName"?: string;
/**
* The requested service level objective name of the database.
*/
@visibility("read")
"requestedServiceObjectiveName"?: string;
/**
* The default secondary region for this database.
*/
@visibility("read")
"defaultSecondaryLocation"?: string;
/**
* Failover Group resource identifier that this database belongs to.
*/
@visibility("read")
"failoverGroupId"?: string;
/**
* Specifies the point in time (ISO8601 format) of the source database that will be restored to create the new database.
*/
@visibility("create")
// FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
"restorePointInTime"?: utcDateTime;
/**
* Specifies the time that the database was deleted.
*/
@visibility("create")
@projectedName("json", "sourceDatabaseDeletionDate")
// FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
"sourceDatabaseDeletedOn"?: utcDateTime;
/**
* The resource identifier of the recovery point associated with create operation of this database.
*/
@visibility("create")
"recoveryServicesRecoveryPointId"?: ResourceIdentifier<[{type: "undefined";}]>;
/**
* The resource identifier of the long term retention backup associated with create operation of this database.
*/
@visibility("create")
"longTermRetentionBackupResourceId"?: ResourceIdentifier<[{type: "Microsoft.Sql/locations/longTermRetentionBackups";}]>;
/**
* The resource identifier of the recoverable database associated with create operation of this database.
*/
@visibility("create")
"recoverableDatabaseId"?: ResourceIdentifier<[{type: "undefined";}]>;
/**
* The resource identifier of the restorable dropped database associated with create operation of this database.
*/
@visibility("create")
"restorableDroppedDatabaseId"?: ResourceIdentifier<[{type: "undefined";}]>;
/**
* Collation of the metadata catalog.
*/
@visibility("read", "create")
"catalogCollation"?: CatalogCollationType;
/**
* Whether or not this database is zone redundant, which means the replicas of this database will be spread across multiple availability zones.
*/
@projectedName("json", "zoneRedundant")
"IsZoneRedundant"?: boolean;
/**
* The license type to apply for this database. `LicenseIncluded` if you need a license, or `BasePrice` if you have a license and are eligible for the Azure Hybrid Benefit.
*/
"licenseType"?: DatabaseLicenseType;
/**
* The max log size for this database.
*/
@visibility("read")
"maxLogSizeBytes"?: int64;
/**
* This records the earliest start date and time that restore is available for this database (ISO8601 format).
*/
@visibility("read")
// FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
"earliestRestoreDate"?: utcDateTime;
/**
* The state of read-only routing. If enabled, connections that have application intent set to readonly in their connection string may be routed to a readonly secondary replica in the same region. Not applicable to a Hyperscale database within an elastic pool.
*/
@visibility("read", "update")
"readScale"?: DatabaseReadScale;
/**
* The number of secondary replicas associated with the database that are used to provide high availability. Not applicable to a Hyperscale database within an elastic pool.
*/
"highAvailabilityReplicaCount"?: int32;
/**
* The secondary type of the database if it is a secondary.  Valid values are Geo, Named and Standby.
*/
"secondaryType"?: SecondaryType;
/**
* The name and tier of the SKU.
*/
@visibility("read")
"currentSku"?: Sku;
/**
* Time in minutes after which database is automatically paused. A value of -1 means that automatic pause is disabled
*/
"autoPauseDelay"?: int32;
/**
* The storage account type used to store backups for this database.
*/
@visibility("read")
"currentBackupStorageRedundancy"?: BackupStorageRedundancy;
/**
* The storage account type to be used to store backups for this database.
*/
"requestedBackupStorageRedundancy"?: BackupStorageRedundancy;
/**
* Minimal capacity that database will always have allocated, if not paused
*/
"minCapacity"?: float64;
/**
* The date when database was paused by user configuration or action(ISO8601 format). Null if the database is ready.
*/
@visibility("read")
// FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
"pausedDate"?: utcDateTime;
/**
* The date when database was resumed by user action or database login (ISO8601 format). Null if the database is paused.
*/
@visibility("read")
// FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
"resumedDate"?: utcDateTime;
/**
* Maintenance configuration id assigned to the database. This configuration defines the period when the maintenance updates will occur.
*/
"maintenanceConfigurationId"?: string;
/**
* Whether or not this database is a ledger database, which means all tables in the database are ledger tables. Note: the value of this property cannot be changed after the database has been created.
*/
"isLedgerOn"?: boolean;
/**
* Infra encryption is enabled for this database.
*/
@visibility("read")
"isInfraEncryptionEnabled"?: boolean;
/**
* The Client id used for cross tenant per database CMK scenario
*/
"federatedClientId"?: string;
/**
* The resource ids of the user assigned identities to use
*/
"keys"?: Record<DatabaseKey>;
/**
* The azure key vault URI of the database if it's configured with per Database Customer Managed Keys.
*/
"encryptionProtector"?: string;
/**
* Type of enclave requested on the database i.e. Default or VBS enclaves.
*/
"preferredEnclaveType"?: AlwaysEncryptedEnclaveType;
/**
* Whether or not the database uses free monthly limits. Allowed on one database in a subscription.
*/
"useFreeLimit"?: boolean;
/**
* Specifies the behavior when monthly free limits are exhausted for the free database.

AutoPause: The database will be auto paused upon exhaustion of free limits for remainder of the month.

BillForUsage: The database will continue to be online upon exhaustion of free limits and any overage will be billed.
*/
"freeLimitExhaustionBehavior"?: FreeLimitExhaustionBehavior;
/**
* Whether or not customer controlled manual cutover needs to be done during Update Database operation to Hyperscale tier.

This property is only applicable when scaling database from Business Critical/General Purpose/Premium/Standard tier to Hyperscale tier.

When manualCutover is specified, the scaling operation will wait for user input to trigger cutover to Hyperscale database.

To trigger cutover, please provide 'performCutover' parameter when the Scaling operation is in Waiting state.
*/
"manualCutover"?: boolean;
/**
* To trigger customer controlled manual cutover during the wait state while Scaling operation is in progress.

This property parameter is only applicable for scaling operations that are initiated along with 'manualCutover' parameter.

This property is only applicable when scaling database from Business Critical/General Purpose/Premium/Standard tier to Hyperscale tier is already in progress.

When performCutover is specified, the scaling operation will trigger cutover and perform role-change to Hyperscale database.
*/
"performCutover"?: boolean;
/**
* The flag to enable or disable auto rotation of database encryption protector AKV key.
*/
"encryptionProtectorAutoRotation"?: boolean;
}

/**
* Contains the information necessary to perform export database operation.
*/
model ExportDatabaseDefinition {
/**
* Storage key type.
*/
@visibility("create")
"storageKeyType": StorageKeyType;
/**
* Storage key.
*/
@visibility("create")
"storageKey": string;
/**
* Storage Uri.
*/
@visibility("create")
"storageUri": string;
/**
* Administrator login name.
*/
@visibility("create")
"administratorLogin": string;
/**
* Administrator login password.
*/
@visibility("create")
"administratorLoginPassword": string;
/**
* Authentication type.
*/
@visibility("create")
"authenticationType"?: string;
/**
* Optional resource information to enable network isolation for request.
*/
@visibility("create")
"networkIsolation"?: NetworkIsolationSettings;
}

/**
* Contains the ARM resources for which to create private endpoint connection.
*/
model NetworkIsolationSettings {
/**
* The resource id for the storage account used to store BACPAC file. If set, private endpoint connection will be created for the storage account. Must match storage account used for StorageUri parameter.
*/
@visibility("create")
"storageAccountResourceId"?: ResourceIdentifier<[{type: "undefined";}]>;
/**
* The resource id for the SQL server which is the target of this request. If set, private endpoint connection will be created for the SQL server. Must match server which is target of the operation.
*/
@visibility("create")
"sqlServerResourceId"?: ResourceIdentifier<[{type: "undefined";}]>;
}

/**
* An ImportExport operation result resource.
*/
model ImportExportOperationResult {
/**
* Resource properties.
*/
"properties"?: ImportExportOperationResultProperties;
}

/**
* Contains the operation result properties for import/export operation.
*/
model ImportExportOperationResultProperties {
/**
* Request Id.
*/
@visibility("read")
"requestId"?: string;
/**
* Request type.
*/
@visibility("read")
"requestType"?: string;
/**
* Queued time.
*/
@visibility("read")
"queuedTime"?: string;
/**
* Last modified time.
*/
@visibility("read")
"lastModifiedTime"?: string;
/**
* Blob Uri.
*/
@visibility("read")
"blobUri"?: string;
/**
* Server name.
*/
@visibility("read")
"serverName"?: string;
/**
* Database name.
*/
@visibility("read")
"databaseName"?: string;
/**
* Operation status.
*/
@visibility("read")
"status"?: string;
/**
* Error message.
*/
@visibility("read")
"errorMessage"?: string;
/**
* Gets the status of private endpoints associated with this request.
*/
@visibility("read")
"privateEndpointConnections"?: PrivateEndpointConnectionRequestStatus[];
}

/**
* Contains the private endpoint connection requests status.
*/
model PrivateEndpointConnectionRequestStatus {
/**
* Resource id for which the private endpoint is created.
*/
@visibility("read")
"privateLinkServiceId"?: string;
/**
* The connection name for the private endpoint.
*/
@visibility("read")
"privateEndpointConnectionName"?: string;
/**
* Status of this private endpoint connection.
*/
@visibility("read")
"status"?: string;
}

/**
* Contains the information necessary to perform import operation for existing database.
*/
model ImportExistingDatabaseDefinition {
/**
* Storage key type.
*/
@visibility("create")
"storageKeyType": StorageKeyType;
/**
* Storage key.
*/
@visibility("create")
"storageKey": string;
/**
* Storage Uri.
*/
@visibility("create")
"storageUri": string;
/**
* Administrator login name.
*/
@visibility("create")
"administratorLogin": string;
/**
* Administrator login password.
*/
@visibility("create")
"administratorLoginPassword": string;
/**
* Authentication type.
*/
@visibility("create")
"authenticationType"?: string;
/**
* Optional resource information to enable network isolation for request.
*/
@visibility("create")
"networkIsolation"?: NetworkIsolationSettings;
}

/**
* Contains the information necessary to perform a resource move (rename).
*/
model ResourceMoveDefinition {
/**
* The target ID for the resource
*/
"id": string;
}

/**
* Properties of an elastic pool
*/
model ElasticPoolProperties {
/**
* The state of the elastic pool.
*/
@visibility("read")
"state"?: ElasticPoolState;
/**
* The creation date of the elastic pool (ISO8601 format).
*/
@visibility("read")
// FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
"creationDate"?: utcDateTime;
/**
* The storage limit for the database elastic pool in bytes.
*/
"maxSizeBytes"?: int64;
/**
* Minimal capacity that serverless pool will not shrink below, if not paused
*/
"minCapacity"?: float64;
/**
* The per database settings for the elastic pool.
*/
"perDatabaseSettings"?: ElasticPoolPerDatabaseSettings;
/**
* Whether or not this elastic pool is zone redundant, which means the replicas of this elastic pool will be spread across multiple availability zones.
*/
@projectedName("json", "zoneRedundant")
"IsZoneRedundant"?: boolean;
/**
* The license type to apply for this elastic pool.
*/
"licenseType"?: ElasticPoolLicenseType;
/**
* Maintenance configuration id assigned to the elastic pool. This configuration defines the period when the maintenance updates will will occur.
*/
"maintenanceConfigurationId"?: string;
/**
* The number of secondary replicas associated with the elastic pool that are used to provide high availability. Applicable only to Hyperscale elastic pools.
*/
"highAvailabilityReplicaCount"?: int32;
/**
* Type of enclave requested on the elastic pool.
*/
"preferredEnclaveType"?: AlwaysEncryptedEnclaveType;
/**
* Specifies the availability zone the pool's primary replica is pinned to.
*/
"availabilityZone"?: AvailabilityZoneType;
}

/**
* Per database settings of an elastic pool.
*/
model ElasticPoolPerDatabaseSettings {
/**
* The minimum capacity all databases are guaranteed.
*/
"minCapacity"?: float64;
/**
* The maximum capacity any one database can consume.
*/
"maxCapacity"?: float64;
}

/**
* An elastic pool update.
*/
model ElasticPoolUpdate {
/**
* An ARM Resource SKU.
*/
"sku"?: Sku;
/**
* Resource properties.
*/
"properties"?: ElasticPoolUpdateProperties;
/**
* Resource tags.
*/
"tags"?: Record<string>;
}

/**
* Properties of an elastic pool
*/
model ElasticPoolUpdateProperties {
/**
* The storage limit for the database elastic pool in bytes.
*/
"maxSizeBytes"?: int64;
/**
* Minimal capacity that serverless pool will not shrink below, if not paused
*/
"minCapacity"?: float64;
/**
* The per database settings for the elastic pool.
*/
"perDatabaseSettings"?: ElasticPoolPerDatabaseSettings;
/**
* Whether or not this elastic pool is zone redundant, which means the replicas of this elastic pool will be spread across multiple availability zones.
*/
@projectedName("json", "zoneRedundant")
"IsZoneRedundant"?: boolean;
/**
* The license type to apply for this elastic pool.
*/
"licenseType"?: ElasticPoolLicenseType;
/**
* Maintenance configuration id assigned to the elastic pool. This configuration defines the period when the maintenance updates will will occur.
*/
"maintenanceConfigurationId"?: string;
/**
* The number of secondary replicas associated with the elastic pool that are used to provide high availability. Applicable only to Hyperscale elastic pools.
*/
"highAvailabilityReplicaCount"?: int32;
/**
* Type of enclave requested on the elastic pool.
*/
"preferredEnclaveType"?: AlwaysEncryptedEnclaveType;
/**
* Specifies the availability zone the pool's primary replica is pinned to.
*/
"availabilityZone"?: AvailabilityZoneType;
}

/**
* The managed database's properties.
*/
model ManagedDatabaseProperties {
/**
* Collation of the managed database.
*/
@visibility("read", "create")
"collation"?: string;
/**
* Status of the database.
*/
@visibility("read")
"status"?: ManagedDatabaseStatus;
/**
* Creation date of the database.
*/
@visibility("read")
// FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
"creationDate"?: utcDateTime;
/**
* Earliest restore point in time for point in time restore.
*/
@visibility("read")
// FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
"earliestRestorePoint"?: utcDateTime;
/**
* Conditional. If createMode is PointInTimeRestore, this value is required. Specifies the point in time (ISO8601 format) of the source database that will be restored to create the new database.
*/
@visibility("create")
// FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
"restorePointInTime"?: utcDateTime;
/**
* Geo paired region.
*/
@visibility("read")
"defaultSecondaryLocation"?: string;
/**
* Collation of the metadata catalog.
*/
@visibility("read", "create")
"catalogCollation"?: CatalogCollationType;
/**
* Managed database create mode. PointInTimeRestore: Create a database by restoring a point in time backup of an existing database. SourceDatabaseName, SourceManagedInstanceName and PointInTime must be specified. RestoreExternalBackup: Create a database by restoring from external backup files. Collation, StorageContainerUri and StorageContainerSasToken must be specified. Recovery: Creates a database by restoring a geo-replicated backup. RecoverableDatabaseId must be specified as the recoverable database resource ID to restore. RestoreLongTermRetentionBackup: Create a database by restoring from a long term retention backup (longTermRetentionBackupResourceId required).
*/
@visibility("create")
"createMode"?: ManagedDatabaseCreateMode;
/**
* Conditional. If createMode is RestoreExternalBackup, this value is required. Specifies the uri of the storage container where backups for this restore are stored.
*/
@visibility("create")
"storageContainerUri"?: string;
/**
* The resource identifier of the source database associated with create operation of this database.
*/
@visibility("create")
"sourceDatabaseId"?: ResourceIdentifier;
/**
* The resource identifier of the cross-subscription source database associated with create operation of this database.
*/
@visibility("create")
"crossSubscriptionSourceDatabaseId"?: ResourceIdentifier;
/**
* The restorable dropped database resource id to restore when creating this database.
*/
@visibility("create")
"restorableDroppedDatabaseId"?: ResourceIdentifier;
/**
* The restorable cross-subscription dropped database resource id to restore when creating this database.
*/
@visibility("create")
"crossSubscriptionRestorableDroppedDatabaseId"?: ResourceIdentifier;
/**
* Conditional. If createMode is RestoreExternalBackup, this value is used. Specifies the identity used for storage container authentication. Can be 'SharedAccessSignature' or 'ManagedIdentity'; if not specified 'SharedAccessSignature' is assumed.
*/
@visibility("create")
"storageContainerIdentity"?: string;
/**
* Conditional. If createMode is RestoreExternalBackup and storageContainerIdentity is not ManagedIdentity, this value is required. Specifies the storage container sas token.
*/
@visibility("create")
"storageContainerSasToken"?: string;
/**
* Instance Failover Group resource identifier that this managed database belongs to.
*/
@visibility("read")
"failoverGroupId"?: string;
/**
* The resource identifier of the recoverable database associated with create operation of this database.
*/
@visibility("create")
"recoverableDatabaseId"?: ResourceIdentifier;
/**
* The name of the Long Term Retention backup to be used for restore of this managed database.
*/
@visibility("create")
"longTermRetentionBackupResourceId"?: ResourceIdentifier;
/**
* Whether to auto complete restore of this managed database.
*/
@visibility("create")
"autoCompleteRestore"?: boolean;
/**
* Last backup file name for restore of this managed database.
*/
@visibility("create")
"lastBackupName"?: string;
/**
* Target managed instance id used in cross-subscription restore.
*/
@visibility("create")
"crossSubscriptionTargetManagedInstanceId"?: string;
/**
* Whether or not this database is a ledger database, which means all tables in the database are ledger tables. Note: the value of this property cannot be changed after the database has been created.
*/
@visibility("read", "create")
"isLedgerOn"?: boolean;
}

/**
* An managed database update.
*/
model ManagedDatabaseUpdate {
/**
* Resource properties.
*/
"properties"?: ManagedDatabaseProperties;
/**
* Resource tags.
*/
"tags"?: Record<string>;
}

/**
* Contains the information necessary to perform a managed database move.
*/
model ManagedDatabaseMoveDefinition {
/**
* The destination managed database ID
*/
"destinationManagedDatabaseId": ResourceIdentifier;
}

/**
* Contains the information necessary to perform a complete database restore operation.
*/
model CompleteDatabaseRestoreDefinition {
/**
* The last backup name to apply
*/
"lastBackupName": string;
}

/**
* Contains the information necessary to start a managed database move.
*/
model ManagedDatabaseStartMoveDefinition {
/**
* The destination managed database ID
*/
"destinationManagedDatabaseId": ResourceIdentifier;
/**
* The move operation mode.
*/
"operationMode"?: MoveOperationMode;
}

/**
* Azure Active Directory identity configuration for a resource.
*/
model ResourceIdentity {
/**
* The resource ids of the user assigned identities to use
*/
"userAssignedIdentities"?: Record<UserIdentity>;
/**
* The Azure Active Directory principal id.
*/
@visibility("read")
"principalId"?: string;
/**
* The identity type. Set this to 'SystemAssigned' in order to automatically create and assign an Azure Active Directory principal for the resource.
*/
"type"?: IdentityType;
/**
* The Azure Active Directory tenant id.
*/
@visibility("read")
"tenantId"?: string;
}

/**
* Azure Active Directory identity configuration for a resource.
*/
model UserIdentity {
/**
* The Azure Active Directory principal id.
*/
@visibility("read")
"principalId"?: string;
/**
* The Azure Active Directory client id.
*/
@visibility("read")
"clientId"?: string;
}

/**
* The properties of a managed instance.
*/
model ManagedInstanceProperties {
@visibility("read")
"provisioningState"?: ManagedInstancePropertiesProvisioningState;
/**
* Specifies the mode of database creation.

Default: Regular instance creation.

Restore: Creates an instance by restoring a set of backups to specific point in time. RestorePointInTime and SourceManagedInstanceId must be specified.
*/
@visibility("create")
"managedInstanceCreateMode"?: ManagedServerCreateMode;
/**
* The fully qualified domain name of the managed instance.
*/
@visibility("read")
"fullyQualifiedDomainName"?: string;
/**
* Administrator username for the managed instance. Can only be specified when the managed instance is being created (and is required for creation).
*/
@visibility("read", "create")
"administratorLogin"?: string;
/**
* The administrator login password (required for managed instance creation).
*/
@visibility("create", "update")
"administratorLoginPassword"?: string;
/**
* Subnet resource ID for the managed instance.
*/
"subnetId"?: ResourceIdentifier<[{type: "Microsoft.Network/virtualNetworks/subnets";}]>;
/**
* The state of the managed instance.
*/
@visibility("read")
"state"?: string;
/**
* The license type. Possible values are 'LicenseIncluded' (regular price inclusive of a new SQL license) and 'BasePrice' (discounted AHB price for bringing your own SQL licenses).
*/
"licenseType"?: ManagedInstanceLicenseType;
/**
* The number of vCores. Allowed values: 8, 16, 24, 32, 40, 64, 80.
*/
"vCores"?: int32;
/**
* Storage size in GB. Minimum value: 32. Maximum value: 16384. Increments of 32 GB allowed only. Maximum value depends on the selected hardware family and number of vCores.
*/
"storageSizeInGB"?: int32;
/**
* Collation of the managed instance.
*/
@visibility("read", "create")
"collation"?: string;
/**
* The Dns Zone that the managed instance is in.
*/
@visibility("read")
"dnsZone"?: string;
/**
* The resource id of another managed instance whose DNS zone this managed instance will share after creation.
*/
@visibility("create")
"dnsZonePartner"?: ResourceIdentifier;
/**
* Whether or not the public data endpoint is enabled.
*/
@projectedName("json", "publicDataEndpointEnabled")
"IsPublicDataEndpointEnabled"?: boolean;
/**
* The resource identifier of the source managed instance associated with create operation of this instance.
*/
@visibility("create")
"sourceManagedInstanceId"?: ResourceIdentifier;
/**
* Specifies the point in time (ISO8601 format) of the source database that will be restored to create the new database.
*/
@visibility("create")
// FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
"restorePointInTime"?: utcDateTime;
/**
* Connection type used for connecting to the instance.
*/
"proxyOverride"?: ManagedInstanceProxyOverride;
/**
* Id of the timezone. Allowed values are timezones supported by Windows.
Windows keeps details on supported timezones, including the id, in registry under
KEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Time Zones.
You can get those registry values via SQL Server by querying SELECT name AS timezone_id FROM sys.time_zone_info.
List of Ids can also be obtained by executing [System.TimeZoneInfo]::GetSystemTimeZones() in PowerShell.
An example of valid timezone id is "Pacific Standard Time" or "W. Europe Standard Time".
*/
@visibility("read", "create")
"timezoneId"?: string;
/**
* The Id of the instance pool this managed server belongs to.
*/
"instancePoolId"?: string;
/**
* Specifies maintenance configuration id to apply to this managed instance.
*/
"maintenanceConfigurationId"?: string;
/**
* List of private endpoint connections on a managed instance.
*/
@visibility("read")
"privateEndpointConnections"?: ManagedInstancePecProperty[];
/**
* Minimal TLS version. Allowed values: 'None', '1.0', '1.1', '1.2'
*/
"minimalTlsVersion"?: string;
/**
* The storage account type used to store backups for this instance. The options are Local (LocallyRedundantStorage), Zone (ZoneRedundantStorage), Geo (GeoRedundantStorage) and GeoZone(GeoZoneRedundantStorage)
*/
@visibility("read")
"currentBackupStorageRedundancy"?: BackupStorageRedundancy;
/**
* The storage account type to be used to store backups for this instance. The options are Local (LocallyRedundantStorage), Zone (ZoneRedundantStorage), Geo (GeoRedundantStorage) and GeoZone(GeoZoneRedundantStorage)
*/
@visibility("read", "create")
"requestedBackupStorageRedundancy"?: BackupStorageRedundancy;
/**
* Whether or not the multi-az is enabled.
*/
@projectedName("json", "zoneRedundant")
"IsZoneRedundant"?: boolean;
/**
* The resource id of a user assigned identity to be used by default.
*/
"primaryUserAssignedIdentityId"?: ResourceIdentifier<[{type: "Microsoft.ManagedIdentity/userAssignedIdentities";}]>;
/**
* A CMK URI of the key to use for encryption.
*/
@visibility("read", "create")
"keyId"?: string;
/**
* The Azure Active Directory administrator of the instance. This can only be used at instance create time. If used for instance update, it will be ignored or it will result in an error. For updates individual APIs will need to be used.
*/
@visibility("read", "create")
"administrators"?: ManagedInstanceExternalAdministrator;
/**
* The managed instance's service principal.
*/
"servicePrincipal"?: ServicePrincipal;
}

/**
* A private endpoint connection under a managed instance
*/
model ManagedInstancePecProperty {
/**
* Resource ID.
*/
@visibility("read")
"id"?: string;
/**
* Private endpoint connection properties
*/
@visibility("read")
"properties"?: ManagedInstancePrivateEndpointConnectionProperties;
}

/**
* Properties of a active directory administrator.
*/
model ManagedInstanceExternalAdministrator {
/**
* Type of the sever administrator.
*/
"administratorType"?: AdministratorType;
/**
* Principal Type of the sever administrator.
*/
"principalType"?: PrincipalType;
/**
* Login name of the server administrator.
*/
"login"?: string;
/**
* SID (object ID) of the server administrator.
*/
"sid"?: string;
/**
* Tenant ID of the administrator.
*/
"tenantId"?: string;
/**
* Azure Active Directory only Authentication enabled.
*/
"azureADOnlyAuthentication"?: boolean;
}

/**
* The managed instance's service principal configuration for a resource.
*/
model ServicePrincipal {
/**
* The Azure Active Directory application object id.
*/
@visibility("read")
"principalId"?: string;
/**
* The Azure Active Directory application client id.
*/
@visibility("read")
"clientId"?: string;
/**
* The Azure Active Directory tenant id.
*/
@visibility("read")
"tenantId"?: string;
/**
* Service principal type.
*/
"type"?: ServicePrincipalType;
}

/**
* An update request for an Azure SQL Database managed instance.
*/
model ManagedInstanceUpdate {
/**
* Managed instance sku
*/
"sku"?: Sku;
/**
* Managed instance identity
*/
"identity"?: ResourceIdentity;
/**
* Resource properties.
*/
"properties"?: ManagedInstanceProperties;
/**
* Resource tags.
*/
"tags"?: Record<string>;
}

/**
* A collection of endpoints that the managed instance service requires outbound network access to.
*/
model OutboundEnvironmentEndpointCollection is Azure.Core.Page<OutboundEnvironmentEndpoint> {
}

/**
* An endpoint that the managed instance service requires outbound network access to.
*/
model OutboundEnvironmentEndpoint {
/**
* The type of service accessed by the managed instance service, e.g., Azure Storage, Azure Active Directory, etc.
*/
@visibility("read")
"category"?: string;
/**
* The endpoints that the managed instance service communicates with in order to function correctly.
*/
@visibility("read")
"endpoints"?: EndpointDependency[];
}

/**
* A domain name that the managed instance service needs to communicate with, along with additional details.
*/
model EndpointDependency {
/**
* The domain name of the dependency.
*/
@visibility("read")
"domainName"?: string;
/**
* The IP Addresses and Ports used when connecting to DomainName.
*/
@visibility("read")
"endpointDetails"?: EndpointDetail[];
}

/**
* A domain name that the managed instance service needs to communicate with, along with additional details.
*/
model EndpointDetail {
/**
* The port an endpoint is connected to.
*/
@visibility("read")
"port"?: int32;
}

/**
* A list of top resource consuming queries on managed instance
*/
model TopQueriesListResult is Azure.Core.Page<TopQueries> {
}


model TopQueries {
/**
* Requested number of top queries.
*/
@visibility("read")
"numberOfQueries"?: int32;
/**
* Aggregation function used to calculate query metrics.
*/
@visibility("read")
"aggregationFunction"?: string;
/**
* Metric used to rank queries.
*/
@visibility("read")
"observationMetric"?: string;
/**
* Interval type (length).
*/
@visibility("read")
"intervalType"?: QueryTimeGrainType;
/**
* The start time for the metric (ISO-8601 format).
*/
@visibility("read")
"startTime"?: string;
/**
* The end time for the metric (ISO-8601 format).
*/
@visibility("read")
"endTime"?: string;
/**
* List of top resource consuming queries with appropriate metric data
*/
"queries"?: QueryStatisticsProperties[];
}

/**
* The properties of a database ledger digest upload settings.
*/
model ManagedLedgerDigestUploadsProperties {
/**
* The digest storage endpoint, which must be either an Azure blob storage endpoint or an URI for Azure Confidential Ledger.
*/
"digestStorageEndpoint"?: string;
/**
* Specifies the state of ledger digest upload.
*/
@visibility("read")
"state"?: ManagedLedgerDigestUploadsState;
}

/**
* The recoverable database's properties.
*/
model RecoverableDatabaseProperties {
/**
* The edition of the database.
*/
@visibility("read")
"edition"?: string;
/**
* The service level objective name of the database.
*/
@visibility("read")
"serviceLevelObjective"?: string;
/**
* The elastic pool name of the database
*/
@visibility("read")
"elasticPoolName"?: string;
/**
* The last available backup date.
*/
@visibility("read")
// FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
"lastAvailableBackupDate"?: utcDateTime;
/**
* The resource ids of the user assigned identities to use
*/
"keys"?: Record<DatabaseKey>;
}

/**
* The restorable dropped database's properties.
*/
model RestorableDroppedDatabaseProperties {
/**
* The name of the database.
*/
@visibility("read")
"databaseName"?: string;
/**
* The max size of the database expressed in bytes.
*/
@visibility("read")
"maxSizeBytes"?: int64;
/**
* The creation date of the database (ISO8601 format).
*/
@visibility("read")
// FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
"creationDate"?: utcDateTime;
/**
* The deletion date of the database (ISO8601 format).
*/
@visibility("read")
// FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
"deletionDate"?: utcDateTime;
/**
* The earliest restore date of the database (ISO8601 format).
*/
@visibility("read")
// FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
"earliestRestoreDate"?: utcDateTime;
/**
* The storage account type used to store backups for this database.
*/
@visibility("read")
"backupStorageRedundancy"?: BackupStorageRedundancy;
/**
* The resource ids of the user assigned identities to use
*/
"keys"?: Record<DatabaseKey>;
}

/**
* The properties of server configuration option.
*/
model ServerConfigurationOptionProperties {
/**
* Value of the server configuration option.
*/
@visibility("read", "update")
"serverConfigurationOptionValue": int32;
/**
* Provisioning state of server configuration option.
*/
@visibility("read")
"provisioningState"?: ProvisioningState;
}

/**
* Properties of managed instance's Start/Stop schedule.
*/
model StartStopManagedInstanceScheduleProperties {
/**
* The description of the schedule.
*/
"description"?: string;
/**
* The time zone of the schedule.
*/
"timeZoneId"?: string = "UTC";
/**
* Schedule list.
*/
"scheduleList": ScheduleItem[];
/**
* Next action to be executed (Start or Stop)
*/
@visibility("read")
"nextRunAction"?: string;
/**
* Timestamp when the next action will be executed in the corresponding schedule time zone.
*/
@visibility("read")
"nextExecutionTime"?: string;
}

/**
* Schedule info describing when the server should be started or stopped.
*/
model ScheduleItem {
/**
* Start day.
*/
"startDay": DayOfWeek;
/**
* Start time.
*/
"startTime": string;
/**
* Stop day.
*/
"stopDay": DayOfWeek;
/**
* Stop time.
*/
"stopTime": string;
}

/**
* Properties of a transparent data encryption.
*/
model TransparentDataEncryptionProperties {
/**
* Specifies the state of the transparent data encryption.
*/
"state": TransparentDataEncryptionState;
}

/**
* The properties of an IPv6 server firewall rule.
*/
model IPv6ServerFirewallRuleProperties {
/**
* The start IP address of the firewall rule. Must be IPv6 format.
*/
"startIPv6Address"?: string;
/**
* The end IP address of the firewall rule. Must be IPv6 format. Must be greater than or equal to startIpv6Address.
*/
"endIPv6Address"?: string;
}

/**
* Properties of a database Sql Vulnerability Assessment baseline set.
*/
model DatabaseSqlVulnerabilityAssessmentBaselineSetProperties {
/**
* The baseline set result
*/
"results": Record<string[][]>;
}

/**
* A database sql vulnerability assessment rule baseline list input.
*/
model DatabaseSqlVulnerabilityAssessmentRuleBaselineListInput {
/**
* SystemData of DatabaseSqlVulnerabilityAssessmentRuleBaselineListInputResource.
*/
@visibility("read")
"systemData"?: SystemData;
/**
* Resource properties.
*/
"properties"?: DatabaseSqlVulnerabilityAssessmentRuleBaselineListInputProperties;
}

/**
* Properties of a database Sql Vulnerability Assessment rule baseline.
*/
model DatabaseSqlVulnerabilityAssessmentRuleBaselineListInputProperties {
/**
* The latest scan flag
*/
"latestScan": boolean;
/**
* The rule baseline result list
*/
"results": Record<string[][]>;
}

/**
* Properties of a database Sql Vulnerability Assessment rule baseline.
*/
model DatabaseSqlVulnerabilityAssessmentRuleBaselineProperties {
/**
* The rule baseline result
*/
"results": string[][];
}

/**
* A database sql vulnerability assessment rule baseline input.
*/
model DatabaseSqlVulnerabilityAssessmentRuleBaselineInput {
/**
* SystemData of DatabaseSqlVulnerabilityAssessmentRuleBaselineInputResource.
*/
@visibility("read")
"systemData"?: SystemData;
/**
* Resource properties.
*/
"properties"?: DatabaseSqlVulnerabilityAssessmentRuleBaselineInputProperties;
}

/**
* Properties of a database Sql Vulnerability Assessment rule baseline.
*/
model DatabaseSqlVulnerabilityAssessmentRuleBaselineInputProperties {
/**
* The latest scan flag
*/
"latestScan": boolean;
/**
* The rule baseline result
*/
"results": string[][];
}

/**
* SQL Vulnerability Assessment scan result properties for a single rule.
*/
model SqlVulnerabilityAssessmentScanResultProperties {
/**
* SQL Vulnerability Assessment rule Id.
*/
@visibility("read")
"ruleId"?: string;
/**
* SQL Vulnerability Assessment rule result status.
*/
@visibility("read")
"status"?: RuleStatus;
/**
* SQL Vulnerability Assessment error message.
*/
@visibility("read")
"errorMessage"?: string;
/**
* SQL Vulnerability Assessment is the query results trimmed.
*/
@visibility("read")
"isTrimmed"?: boolean;
/**
* SQL Vulnerability Assessment query results that was run.
*/
@visibility("read")
"queryResults"?: string[][];
/**
* SQL Vulnerability Assessment the remediation details.
*/
@visibility("read")
"remediation"?: Remediation;
/**
* SQL Vulnerability Assessment rule result adjusted with baseline.
*/
@visibility("read")
"baselineAdjustedResult"?: BaselineAdjustedResult;
/**
* SQL Vulnerability Assessment rule metadata.
*/
@visibility("read")
"ruleMetadata"?: VaRule;
}

/**
* SQL Vulnerability Assessment remediation Details.
*/
model Remediation {
/**
* SQL Vulnerability Assessment remediation description.
*/
@visibility("read")
"description"?: string;
/**
* SQL Vulnerability Assessment remediation script.
*/
@visibility("read")
"scripts"?: string[];
/**
* SQL Vulnerability Assessment is remediation automated.
*/
@visibility("read")
"automated"?: boolean;
/**
* SQL Vulnerability Assessment optional link to remediate in Azure Portal.
*/
@visibility("read")
"portalLink"?: string;
}

/**
* SQL Vulnerability Assessment baseline adjusted results
*/
model BaselineAdjustedResult {
/**
* SQL Vulnerability Assessment baseline details
*/
@visibility("read")
"baseline"?: Baseline;
/**
* SQL Vulnerability Assessment baseline status
*/
@visibility("read")
"status"?: RuleStatus;
/**
* SQL Vulnerability Assessment results that are not in baseline
*/
@visibility("read")
"resultsNotInBaseline"?: string[][];
/**
* SQL Vulnerability Assessment results that are in baseline.
*/
@visibility("read")
"resultsOnlyInBaseline"?: string[][];
}

/**
* SQL Vulnerability Assessment baseline Details
*/
model Baseline {
/**
* SQL Vulnerability Assessment baseline expected results
*/
@visibility("read")
"expectedResults"?: string[][];
/**
* SQL Vulnerability Assessment baseline update time (UTC)
*/
@visibility("read")
// FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
"updatedTime"?: utcDateTime;
}

/**
* SQL Vulnerability Assessment rule metadata details.
*/
model VaRule {
/**
* SQL Vulnerability Assessment rule Id.
*/
@visibility("read")
"ruleId"?: string;
/**
* SQL Vulnerability Assessment rule severity.
*/
@visibility("read")
"severity"?: RuleSeverity;
/**
* SQL Vulnerability Assessment rule category.
*/
@visibility("read")
"category"?: string;
/**
* SQL Vulnerability Assessment rule type.
*/
@visibility("read")
"ruleType"?: RuleType;
/**
* SQL Vulnerability Assessment rule title.
*/
@visibility("read")
"title"?: string;
/**
* SQL Vulnerability Assessment rule description.
*/
@visibility("read")
"description"?: string;
/**
* SQL Vulnerability Assessment rule rationale.
*/
@visibility("read")
"rationale"?: string;
/**
* SQL Vulnerability Assessment rule query details.
*/
@visibility("read")
"queryCheck"?: QueryCheck;
/**
* SQL Vulnerability Assessment benchmark references.
*/
@visibility("read")
"benchmarkReferences"?: BenchmarkReference[];
}

/**
* SQL Vulnerability Assessment query check object.
*/
model QueryCheck {
/**
* SQL Vulnerability Assessment rule query.
*/
@visibility("read")
"query"?: string;
/**
* SQL Vulnerability Assessment query expected result.
*/
@visibility("read")
"expectedResult"?: string[][];
/**
* SQL Vulnerability Assessment column names of query expected result.
*/
@visibility("read")
"columnNames"?: string[];
}

/**
* SQL Vulnerability Assessment benchmark reference
*/
model BenchmarkReference {
/**
* SQL Vulnerability Assessment benchmark name
*/
@visibility("read")
"benchmark"?: string;
/**
* SQL Vulnerability Assessment benchmark reference.
*/
@visibility("read")
"reference"?: string;
}

/**
* Properties of a vulnerability assessment scan record.
*/
model SqlVulnerabilityAssessmentScanRecordProperties {
/**
* The scan ID.
*/
@visibility("read")
"scanId"?: string;
/**
* The scan trigger type.
*/
@visibility("read")
"triggerType"?: VulnerabilityAssessmentScanTriggerType;
/**
* The scan status.
*/
@visibility("read")
"state"?: VulnerabilityAssessmentScanState;
/**
* The scan start time (UTC).
*/
@visibility("read")
// FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
"startTime"?: utcDateTime;
/**
* The scan end time (UTC).
*/
@visibility("read")
// FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
"endTime"?: utcDateTime;
/**
* The scan errors.
*/
@visibility("read")
"errors"?: SqlVulnerabilityAssessmentScanError[];
/**
* The server name.
*/
@visibility("read")
"server"?: string;
/**
* The database name.
*/
@visibility("read")
"database"?: string;
/**
* The SQL version.
*/
@visibility("read")
"sqlVersion"?: string;
/**
* The number of failed rules with high severity.
*/
@visibility("read")
"highSeverityFailedRulesCount"?: int32;
/**
* The number of failed rules with medium severity.
*/
@visibility("read")
"mediumSeverityFailedRulesCount"?: int32;
/**
* The number of failed rules with low severity.
*/
@visibility("read")
"lowSeverityFailedRulesCount"?: int32;
/**
* The number of total passed rules.
*/
@visibility("read")
"totalPassedRulesCount"?: int32;
/**
* The number of total failed rules.
*/
@visibility("read")
"totalFailedRulesCount"?: int32;
/**
* The number of total rules assessed.
*/
@visibility("read")
"totalRulesCount"?: int32;
/**
* Baseline created for this database, and has one or more rules.
*/
@visibility("read")
"isBaselineApplied"?: boolean;
/**
* The last scan time.
*/
@visibility("read")
// FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
"lastScanTime"?: utcDateTime;
}

/**
* Properties of a vulnerability assessment scan error.
*/
model SqlVulnerabilityAssessmentScanError {
/**
* The error code.
*/
@visibility("read")
"code"?: string;
/**
* The error message.
*/
@visibility("read")
"message"?: string;
}


model SqlVulnerabilityAssessmentPolicyProperties {
/**
* Specifies the state of the SQL Vulnerability Assessment, whether it is enabled or disabled or a state has not been applied yet on the specific database or server.
*/
"state"?: SqlVulnerabilityAssessmentState;
}

/**
* A request to check whether the specified name for a resource is available.
*/
model CheckNameAvailabilityRequest {
"name": string;
"type": "Microsoft.Sql/servers";
}

/**
* The result of a name availability check.
*/
model SqlNameAvailabilityResponse {
/**
* The name whose availability was checked.
*/
@visibility("read")
"name"?: string;
/**
* True if the name is available, otherwise false.
*/
@visibility("read")
@projectedName("json", "available")
"IsAvailable"?: boolean;
/**
* The reason code explaining why the name is unavailable. Will be undefined if the name is available.
*/
@visibility("read")
"reason"?: CheckNameAvailabilityReason;
/**
* A message explaining why the name is unavailable. Will be undefined if the name is available.
*/
@visibility("read")
"message"?: string;
}

/**
* The properties of a server.
*/
model ServerProperties {
/**
* Administrator username for the server. Once created it cannot be changed.
*/
@visibility("read", "create")
"administratorLogin"?: string;
/**
* The administrator login password (required for server creation).
*/
@visibility("create", "update")
"administratorLoginPassword"?: string;
/**
* The version of the server.
*/
"version"?: string;
/**
* The state of the server.
*/
@visibility("read")
"state"?: string;
/**
* The fully qualified domain name of the server.
*/
@visibility("read")
"fullyQualifiedDomainName"?: string;
/**
* List of private endpoint connections on a server
*/
@visibility("read")
"privateEndpointConnections"?: ServerPrivateEndpointConnection[];
/**
* Minimal TLS version. Allowed values: 'None', '1.0', '1.1', '1.2'
*/
"minimalTlsVersion"?: string;
/**
* Whether or not public endpoint access is allowed for this server.  Value is optional but if passed in, must be 'Enabled' or 'Disabled' or 'SecuredByPerimeter'
*/
"publicNetworkAccess"?: ServerPublicNetworkAccessFlag;
/**
* Whether or not existing server has a workspace created and if it allows connection from workspace
*/
@visibility("read")
"workspaceFeature"?: ServerWorkspaceFeature;
/**
* The resource id of a user assigned identity to be used by default.
*/
"primaryUserAssignedIdentityId"?: ResourceIdentifier<[{type: "Microsoft.ManagedIdentity/userAssignedIdentities";}]>;
/**
* The Client id used for cross tenant CMK scenario
*/
"federatedClientId"?: string;
/**
* A CMK URI of the key to use for encryption.
*/
"keyId"?: string;
/**
* The Azure Active Directory administrator of the server. This can only be used at server create time. If used for server update, it will be ignored or it will result in an error. For updates individual APIs will need to be used.
*/
@visibility("read", "create")
"administrators"?: ServerExternalAdministrator;
/**
* Whether or not to restrict outbound network access for this server.  Value is optional but if passed in, must be 'Enabled' or 'Disabled'
*/
"restrictOutboundNetworkAccess"?: ServerNetworkAccessFlag;
/**
* Whether or not to enable IPv6 support for this server.  Value is optional but if passed in, must be 'Enabled' or 'Disabled'
*/
"isIPv6Enabled"?: ServerNetworkAccessFlag;
/**
* Status of external governance.
*/
@visibility("read")
"externalGovernanceStatus"?: ExternalGovernanceStatus;
}

/**
* A private endpoint connection under a server
*/
model ServerPrivateEndpointConnection {
/**
* Resource ID.
*/
@visibility("read")
"id"?: string;
/**
* Private endpoint connection properties
*/
@visibility("read")
"properties"?: PrivateEndpointConnectionProperties;
}

/**
* Properties of a active directory administrator.
*/
model ServerExternalAdministrator {
/**
* Type of the sever administrator.
*/
"administratorType"?: AdministratorType;
/**
* Principal Type of the sever administrator.
*/
"principalType"?: PrincipalType;
/**
* Login name of the server administrator.
*/
"login"?: string;
/**
* SID (object ID) of the server administrator.
*/
"sid"?: string;
/**
* Tenant ID of the administrator.
*/
"tenantId"?: string;
/**
* Azure Active Directory only Authentication enabled.
*/
"azureADOnlyAuthentication"?: boolean;
}

/**
* An update request for an Azure SQL Database server.
*/
model ServerUpdate {
/**
* Server identity
*/
"identity"?: ResourceIdentity;
/**
* Resource properties.
*/
"properties"?: ServerProperties;
/**
* Resource tags.
*/
"tags"?: Record<string>;
}

/**
* Contains the information necessary to perform import operation for new database.
*/
model ImportNewDatabaseDefinition {
/**
* Name of the import database.
*/
@visibility("create")
"databaseName"?: string;
/**
* Edition of the import database.
*/
@visibility("create")
"edition"?: string;
/**
* Service level objective name of the import database.
*/
@visibility("create")
"serviceObjectiveName"?: string;
/**
* Max size in bytes for the import database.
*/
@visibility("create")
"maxSizeBytes"?: string;
/**
* Storage key type.
*/
@visibility("create")
"storageKeyType": StorageKeyType;
/**
* Storage key.
*/
@visibility("create")
"storageKey": string;
/**
* Storage Uri.
*/
@visibility("create")
"storageUri": string;
/**
* Administrator login name.
*/
@visibility("create")
"administratorLogin": string;
/**
* Administrator login password.
*/
@visibility("create")
"administratorLoginPassword": string;
/**
* Authentication type.
*/
@visibility("create")
"authenticationType"?: string;
/**
* Optional resource information to enable network isolation for request.
*/
@visibility("create")
"networkIsolation"?: NetworkIsolationSettings;
}

/**
* An RefreshExternalGovernanceStatus operation result resource.
*/
model RefreshExternalGovernanceStatusOperationResult {
/**
* Resource properties.
*/
"properties"?: RefreshExternalGovernanceStatusOperationResultProperties;
}

/**
* Contains the operation result properties for refresh external governance status operation.
*/
model RefreshExternalGovernanceStatusOperationResultProperties {
/**
* Request Id.
*/
@visibility("read")
"requestId"?: string;
/**
* Request type.
*/
@visibility("read")
"requestType"?: string;
/**
* Queued time.
*/
@visibility("read")
"queuedTime"?: string;
/**
* Server name.
*/
@visibility("read")
"serverName"?: string;
/**
* Operation status.
*/
@visibility("read")
"status"?: string;
/**
* Error message.
*/
@visibility("read")
"errorMessage"?: string;
}

/**
* Properties of a failover group.
*/
model FailoverGroupProperties {
/**
* Read-write endpoint of the failover group instance.
*/
"readWriteEndpoint": FailoverGroupReadWriteEndpoint;
/**
* Read-only endpoint of the failover group instance.
*/
"readOnlyEndpoint"?: FailoverGroupReadOnlyEndpoint;
/**
* Local replication role of the failover group instance.
*/
@visibility("read")
"replicationRole"?: FailoverGroupReplicationRole;
/**
* Replication state of the failover group instance.
*/
@visibility("read")
"replicationState"?: string;
/**
* List of partner server information for the failover group.
*/
"partnerServers": PartnerInfo[];
/**
* List of databases in the failover group.
*/
"databases"?: ResourceIdentifier<[{type: "Microsoft.Sql/servers/databases";}]>[];
}

/**
* Read-write endpoint of the failover group instance.
*/
model FailoverGroupReadWriteEndpoint {
/**
* Failover policy of the read-write endpoint for the failover group. If failoverPolicy is Automatic then failoverWithDataLossGracePeriodMinutes is required.
*/
"failoverPolicy": ReadWriteEndpointFailoverPolicy;
/**
* Grace period before failover with data loss is attempted for the read-write endpoint. If failoverPolicy is Automatic then failoverWithDataLossGracePeriodMinutes is required.
*/
"failoverWithDataLossGracePeriodMinutes"?: int32;
}

/**
* Read-only endpoint of the failover group instance.
*/
model FailoverGroupReadOnlyEndpoint {
/**
* Failover policy of the read-only endpoint for the failover group.
*/
"failoverPolicy"?: ReadOnlyEndpointFailoverPolicy;
/**
* The target partner server where the read-only endpoint points to.
*/
"targetServer"?: ResourceIdentifier<[{type: "Microsoft.Sql/servers";}]>;
}

/**
* Partner server information for the failover group.
*/
model PartnerInfo {
/**
* Resource identifier of the partner server.
*/
"id": ResourceIdentifier<[{type: "Microsoft.Sql/servers";}]>;
/**
* Geo location of the partner server.
*/
@visibility("read")
"location"?: string;
/**
* Replication role of the partner server.
*/
@visibility("read")
"replicationRole"?: FailoverGroupReplicationRole;
}

/**
* A failover group update request.
*/
model FailoverGroupUpdate {
/**
* Resource properties.
*/
"properties"?: FailoverGroupUpdateProperties;
/**
* Resource tags.
*/
"tags"?: Record<string>;
}

/**
* Properties of a failover group update.
*/
model FailoverGroupUpdateProperties {
/**
* Read-write endpoint of the failover group instance.
*/
"readWriteEndpoint"?: FailoverGroupReadWriteEndpoint;
/**
* Read-only endpoint of the failover group instance.
*/
"readOnlyEndpoint"?: FailoverGroupReadOnlyEndpoint;
/**
* List of databases in the failover group.
*/
"databases"?: ResourceIdentifier<[{type: "Microsoft.Sql/servers/databases";}]>[];
/**
* List of partner server information for the failover group.
*/
"partnerServers"?: PartnerInfo[];
}

/**
* A Slo Usage Metric.
*/
model SloUsageMetric {
/**
* The serviceLevelObjective for SLO usage metric.
*/
@visibility("read")
"serviceLevelObjective"?: ServiceObjectiveName;
/**
* The serviceLevelObjectiveId for SLO usage metric.
*/
@visibility("read")
"serviceLevelObjectiveId"?: string;
/**
* Gets or sets inRangeTimeRatio for SLO usage metric.
*/
@visibility("read")
"inRangeTimeRatio"?: float64;
}

/**
* The impact of an operation, both in absolute and relative terms.
*/
model OperationImpact {
/**
* The name of the impact dimension.
*/
@visibility("read")
"name"?: string;
/**
* The unit in which estimated impact to dimension is measured.
*/
@visibility("read")
"unit"?: string;
/**
* The absolute impact to dimension.
*/
@visibility("read")
"changeValueAbsolute"?: float64;
/**
* The relative impact to dimension (null if not applicable)
*/
@visibility("read")
"changeValueRelative"?: float64;
}

/**
* A list of server firewall rules.
*/
model FirewallRuleList {
"values"?: FirewallRule[];
}

/**
* The properties that are supported in the $filter operation.
*/
model SecurityEventsFilterParameters {
/**
* Filter on the event time.
*/
// FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
"eventTime"?: utcDateTime;
/**
* Whether to show server records or not.
*/
"showServerRecords"?: boolean;
}

/**
* List of managed database move operations.
*/
model ManagedDatabaseMoveOperationListResult {
/**
* Array of results.
*/
@visibility("read")
"value"?: ManagedDatabaseMoveOperationResult[];
/**
* Link to retrieve next page of results.
*/
@visibility("read")
"nextLink"?: string;
}

/**
* A managed database move operation.
*/
model ManagedDatabaseMoveOperationResult {
/**
* Resource properties.
*/
"properties"?: ManagedDatabaseMoveOperationResultProperties;
}

/**
* Contains the operation result properties for managed database move operation.
*/
model ManagedDatabaseMoveOperationResultProperties {
/**
* The name of operation.
*/
@visibility("read")
"operation"?: string;
/**
* The friendly name of operation.
*/
@visibility("read")
"operationFriendlyName"?: string;
/**
* The operation start time.
*/
@visibility("read")
// FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
"startTime"?: utcDateTime;
/**
* The operation state.
*/
@visibility("read")
"state"?: ManagementOperationState;
/**
* Operation mode.
*/
@visibility("read")
"operationMode"?: MoveOperationMode;
/**
* Source Managed Instance name.
*/
@visibility("read")
"sourceManagedInstanceName"?: string;
/**
* Target Managed Instance name.
*/
@visibility("read")
"targetManagedInstanceName"?: string;
/**
* Source Managed Instance resource id.
*/
@visibility("read")
"sourceManagedInstanceId"?: string;
/**
* Target Managed instance resource id.
*/
@visibility("read")
"targetManagedInstanceId"?: string;
/**
* Source database name.
*/
@visibility("read")
"sourceDatabaseName"?: string;
/**
* Target database name.
*/
@visibility("read")
"targetDatabaseName"?: string;
/**
* Is move operation cancellable.
*/
@visibility("read")
"isCancellable"?: boolean;
/**
* The operation error code.
*/
@visibility("read")
"errorCode"?: int32;
/**
* The operation error description.
*/
@visibility("read")
"errorDescription"?: string;
/**
* The operation error severity.
*/
@visibility("read")
"errorSeverity"?: int32;
/**
* Whether or not the error is a user error.
*/
@visibility("read")
"isUserError"?: boolean;
}
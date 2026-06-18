import "@azure-tools/typespec-client-generator-core";
import "./main.tsp";

using Azure.ClientGenerator.Core;
using Azure.ClientGenerator.Core.Legacy;
using Azure.Core;
using Microsoft.Sql;

// TODO: remove this when breaking change is allowed
@@alternateType(
  SecurityAlertsPolicyProperties.state,
  SecurityAlertPolicyState,
  "java"
);
@@alternateType(
  ServerProperties.publicNetworkAccess,
  ServerNetworkAccessFlag,
  "java"
);

@@clientName(Microsoft.Sql, "SqlManagementClient", "java,javascript,python");

@@clientName(SyncAgentLinkedDatabaseProperties.userName, "username", "java");
@@clientName(SyncMemberProperties.userName, "username", "java");
@@clientName(
  SyncGroupProperties.hubDatabaseUserName,
  "hubDatabaseUsername",
  "java"
);

@@usage(ServerDnsAlias, Azure.ClientGenerator.Core.Usage.input, "java");

@@alternateType(
  CheckNameAvailabilityResourceType,
  "Microsoft.Sql/servers",
  "java"
);

@@alternateType(ServerProperties.minimalTlsVersion, string, "java");

@@clientName(
  DNSRefreshOperationStatus,
  "DnsRefreshConfigurationPropertiesStatus",
  "java"
);
@@clientName(ReplicationModeType, "ReplicationMode", "java");
@@clientName(
  UpsertManagedServerOperationStepWithEstimatesAndDurationStatus,
  "Status",
  "java"
);

@@clientName(
  SqlVulnerabilityAssessmentScanRecord,
  "VulnerabilityAssessmentScanRecordForSql",
  "go"
);
@@clientName(
  SqlVulnerabilityAssessmentScanRecordProperties,
  "VulnerabilityAssessmentScanRecordForSqlProperties",
  "go"
);
@@clientName(
  SqlVulnerabilityAssessmentScanError,
  "VulnerabilityAssessmentScanForSqlError",
  "go"
);

@@clientName(MinimalTlsVersion.`1.0`, "ONE0", "python");
@@clientName(MinimalTlsVersion.`1.1`, "ONE1", "python");
@@clientName(MinimalTlsVersion.`1.2`, "ONE2", "python");
@@clientName(MinimalTlsVersion.`1.3`, "ONE3", "python");

@@clientName(QueryTimeGrainType.PT1H, "PT1_H", "python");
@@clientName(QueryTimeGrainType.P1D, "P1_D", "python");

@@clientName(MinimalTlsVersion.`1.0`, "One0", "go");
@@clientName(MinimalTlsVersion.`1.1`, "One1", "go");
@@clientName(MinimalTlsVersion.`1.2`, "One2", "go");
@@clientName(MinimalTlsVersion.`1.3`, "One3", "go");

@@clientName(DiffBackupIntervalInHours.`12`, "Twelve", "go,javascript,python");
@@clientName(DiffBackupIntervalInHours.`24`, "TwentyFour", "go,javascript");
@@clientName(DiffBackupIntervalInHours.`24`, "Twenty_Four", "python");

@@clientName(AvailabilityZoneType.`1`, "One", "go,javascript");
@@clientName(AvailabilityZoneType.`2`, "Two", "go,javascript");
@@clientName(AvailabilityZoneType.`3`, "Three", "go,javascript");

@@clientName(AvailabilityZoneType.`1`, "ONE", "python");
@@clientName(AvailabilityZoneType.`2`, "TWO", "python");
@@clientName(AvailabilityZoneType.`3`, "THREE", "python");

@@alternateType(BlobAuditingPolicyName, "default", "go,javascript,python");
@@alternateType(DataMaskingPolicyName, "Default", "javascript,python");
@@alternateType(
  CurrentSensitivityLabelSource,
  "current",
  "go,javascript,python"
);
@@alternateType(
  RecommendedSensitivityLabelSource,
  "recommended",
  "go,javascript,python"
);
@@alternateType(
  VulnerabilityAssessmentSystemDatabaseName,
  "master",
  "go,javascript,python"
);
@@alternateType(
  CheckNameAvailabilityResourceType,
  "Microsoft.Sql/servers",
  "go"
);
@@clientName(
  SqlVulnerabilityAssessmentScanRecordListResult,
  "VulnerabilityAssessmentScanRecordForSQLListResult ",
  "go"
);

// C# resource and type mappings migrated from autorest.md.bak prepend-rp-prefix
@@clientName(DatabaseAutomaticTuning, "SqlDatabaseAutomaticTuning", "csharp");
@@clientName(
  DatabaseBlobAuditingPolicy,
  "SqlDatabaseBlobAuditingPolicy",
  "csharp"
);
@@clientName(
  DatabaseSecurityAlertPolicy,
  "SqlDatabaseSecurityAlertPolicy",
  "csharp"
);
@@clientName(TimeZone, "SqlTimeZone", "csharp");
@@clientName(Server, "SqlServer", "csharp");
@@clientName(ServerCreateMode, "SqlServerCreateMode", "csharp");
@@clientName(Database, "SqlDatabase", "csharp");
@@clientName(DayOfWeek, "SqlDayOfWeek", "csharp");
@@clientName(MetricType, "SqlMetricType", "csharp");
@@clientName(ServerAutomaticTuning, "SqlServerAutomaticTuning", "csharp");
@@clientName(
  ServerAzureADAdministrator,
  "SqlServerAzureADAdministrator",
  "csharp"
);
@@clientName(
  ServerAzureADOnlyAuthentication,
  "SqlServerAzureADOnlyAuthentication",
  "csharp"
);
@@clientName(ServerBlobAuditingPolicy, "SqlServerBlobAuditingPolicy", "csharp");
@@clientName(ServerConnectionPolicy, "SqlServerConnectionPolicy", "csharp");
@@clientName(ServerDnsAlias, "SqlServerDnsAlias", "csharp");
@@clientName(ServerKey, "SqlServerKey", "csharp");
@@clientName(
  ServerSecurityAlertPolicy,
  "SqlServerSecurityAlertPolicy",
  "csharp"
);
@@clientName(ServerTrustGroup, "SqlServerTrustGroup", "csharp");
@@clientName(
  ServerVulnerabilityAssessment,
  "SqlServerVulnerabilityAssessment",
  "csharp"
);
@@clientName(ServicePrincipal, "SqlServicePrincipal", "csharp");
@@clientName(ServicePrincipalType, "SqlServicePrincipalType", "csharp");
@@clientName(FirewallRule, "SqlFirewallRule", "csharp");
@@clientName(AdministratorName, "SqlAdministratorName", "csharp");
@@clientName(AdministratorType, "SqlAdministratorType", "csharp");
@@clientName(CapabilityGroup, "SqlCapabilityGroup", "csharp");
@@clientName(CapabilityStatus, "SqlCapabilityStatus", "csharp");
@@clientName(LocationCapabilities, "SqlLocationCapabilities", "csharp");
@@clientName(ColumnDataType, "SqlColumnDataType", "csharp");
@@clientName(DatabaseState, "SqlDatabaseState", "csharp");
@@clientName(DatabaseStatus, "SqlDatabaseStatus", "csharp");
@@clientName(ResourceMoveDefinition, "SqlResourceMoveDefinition", "csharp");
@@clientName(ServerUsage, "SqlServerUsage", "csharp");
@@clientName(AdvisorStatus, "SqlAdvisorStatus", "csharp");
@@clientName(Advisor, "SqlAdvisor", "csharp");

// C# model and enum mappings migrated from autorest.md.bak rename-mapping
@@clientName(
  CopyLongTermRetentionBackupParameters,
  "CopyLongTermRetentionBackupContent",
  "csharp"
);
@@clientName(
  UpdateLongTermRetentionBackupParameters,
  "UpdateLongTermRetentionBackupContent",
  "csharp"
);
@@clientName(Name, "InstancePoolUsageName", "csharp");
@@Azure.ClientGenerator.Core.clientName(
  global.Microsoft.Sql.Usage,
  "InstancePoolUsage",
  "csharp"
);
@@Azure.ClientGenerator.Core.clientName(
  global.Microsoft.Sql.Usage.type,
  "ResourceType",
  "csharp"
);
@@clientName(UsageListResult, "InstancePoolUsageListResult", "csharp");
@@clientName(SampleName, "SampleSchemaName", "csharp");
@@clientName(Job, "SqlServerJob", "csharp");
@@clientName(JobAgent, "SqlServerJobAgent", "csharp");
@@clientName(JobVersion, "SqlServerJobVersion", "csharp");
@@clientName(JobCredential, "SqlServerJobCredential", "csharp");
@@clientName(JobTargetGroup, "SqlServerJobTargetGroup", "csharp");
@@clientName(JobSchedule, "SqlServerJobSchedule", "csharp");
@@clientName(JobScheduleType, "SqlServerJobScheduleType", "csharp");
@@clientName(JobExecution, "SqlServerJobExecution", "csharp");
@@clientName(JobStep, "SqlServerJobStep", "csharp");
@@clientName(LedgerDigestUploads, "LedgerDigestUpload", "csharp");
@@clientName(
  ServerDevOpsAuditingSettings,
  "SqlServerDevOpsAuditingSetting",
  "csharp"
);
@@clientName(
  ManagedDatabaseRestoreDetailsResult,
  "ManagedDatabaseRestoreDetail",
  "csharp"
);
@@clientName(
  ManagedDatabaseRestoreDetailsBackupSetProperties,
  "ManagedDatabaseRestoreDetailBackupSetProperties",
  "csharp"
);
@@clientName(
  ManagedDatabaseRestoreDetailsUnrestorableFileProperties,
  "ManagedDatabaseRestoreDetailUnrestorableFileProperties",
  "csharp"
);
@@clientName(CheckNameAvailabilityReason, "SqlNameUnavailableReason", "csharp");
@@clientName(
  CheckNameAvailabilityRequest,
  "SqlNameAvailabilityContent",
  "csharp"
);
@@clientName(CreateMode, "SqlDatabaseCreateMode", "csharp");
@@clientName(OperationMode, "DatabaseExtensionOperationMode", "csharp");
@@clientName(ProvisioningState, "JobExecutionProvisioningState", "csharp");
@@clientName(PrincipalType, "SqlServerPrincipalType", "csharp");
@@clientName(IsRetryable, "ActionRetryableState", "csharp");
@@clientName(ExportDatabaseDefinition, "DatabaseExportDefinition", "csharp");
@@clientName(ImportNewDatabaseDefinition, "DatabaseImportDefinition", "csharp");
@@clientName(PartnerInfo, "PartnerServerInfo", "csharp");
@@clientName(ReplicationState, "ReplicationLinkState", "csharp");
@@clientName(ServerInfo, "ServerTrustGroupServerInfo", "csharp");
@@clientName(DatabaseExtensions, "SqlDatabaseExtension", "csharp");
@@clientName(DatabaseOperation, "DatabaseOperationData", "csharp");
@@clientName(ServerOperation, "ServerOperationData", "csharp");
@@clientName(ElasticPoolOperation, "ElasticPoolOperationData", "csharp");
@@clientName(
  UpdateVirtualClusterDnsServersOperation,
  "ManagedInstanceUpdateDnsServersOperationData",
  "csharp"
);
@@clientName(VirtualNetworkRule, "SqlServerVirtualNetworkRule", "csharp");
@@clientName(
  VirtualNetworkRuleState,
  "SqlServerVirtualNetworkRuleState",
  "csharp"
);
@@clientName(
  PrivateEndpointConnectionProperties,
  "ServerPrivateEndpointConnectionProperties",
  "csharp"
);
@@clientName(
  PrivateEndpointProvisioningState,
  "SqlPrivateEndpointProvisioningState",
  "csharp"
);
@@clientName(
  PrivateLinkServiceConnectionStateActionsRequire,
  "SqlPrivateLinkServiceConnectionActionsRequired",
  "csharp"
);
@@clientName(
  PrivateLinkServiceConnectionStateStatus,
  "SqlPrivateLinkServiceConnectionStatus",
  "csharp"
);
@@clientName(SecurityAlertPolicyName, "SqlSecurityAlertPolicyName", "csharp");
@@clientName(ServerKeyType, "SqlServerKeyType", "csharp");
@@clientName(
  ServerPrivateEndpointConnection,
  "SqlServerPrivateEndpointConnection",
  "csharp"
);
@@clientName(ReplicationLink, "SqlServerDatabaseReplicationLink", "csharp");
@@clientName(ReplicationRole, "SqlServerDatabaseReplicationRole", "csharp");
@@clientName(ServerVersionCapability, "SqlServerVersionCapability", "csharp");
@@clientName(RestorePoint, "SqlServerDatabaseRestorePoint", "csharp");
@@clientName(BackupStorageRedundancy, "SqlBackupStorageRedundancy", "csharp");
@@clientName(
  DNSRefreshOperationStatus,
  "DnsRefreshConfigurationPropertiesStatus",
  "csharp"
);
@@clientName(
  DatabaseSqlVulnerabilityAssessmentBaselineSet,
  "SqlVulnerabilityAssessmentBaseline",
  "csharp"
);
@@clientName(BaselineName, "SqlVulnerabilityAssessmentBaselineName", "csharp");
@@clientName(
  DatabaseSqlVulnerabilityAssessmentRuleBaselineListInput,
  "SqlVulnerabilityAssessmentBaselineCreateOrUpdateContent",
  "csharp"
);
@@clientName(
  DatabaseSqlVulnerabilityAssessmentRuleBaseline,
  "SqlVulnerabilityAssessmentBaselineRule",
  "csharp"
);
@@clientName(
  DatabaseSqlVulnerabilityAssessmentRuleBaselineInput,
  "SqlVulnerabilityAssessmentBaselineRuleCreateOrUpdateContent",
  "csharp"
);
@@clientName(
  SqlVulnerabilityAssessmentScanRecord,
  "SqlVulnerabilityAssessmentScan",
  "csharp"
);
@@clientName(
  AlwaysEncryptedEnclaveType,
  "SqlAlwaysEncryptedEnclaveType",
  "csharp"
);
@@clientName(SynapseLinkWorkspace, "SqlSynapseLinkWorkspace", "csharp");
@@clientName(
  BaselineAdjustedResult,
  "SqlVulnerabilityAssessmentBaselineAdjustedResult",
  "csharp"
);
@@clientName(Remediation, "SqlVulnerabilityAssessmentRemediation", "csharp");
@@clientName(VaRule, "SqlVulnerabilityAssessmentRuleMetadata", "csharp");
@@clientName(RuleStatus, "SqlVulnerabilityAssessmentRuleStatus", "csharp");
@@clientName(Baseline, "SqlVulnerabilityAssessmentBaselineDetails", "csharp");
@@clientName(
  BenchmarkReference,
  "SqlVulnerabilityAssessmentBenchmarkReference",
  "csharp"
);
@@clientName(MoveOperationMode, "ManagedDatabaseMoveOperationMode", "csharp");
@@clientName(QueryCheck, "SqlVulnerabilityAssessmentQueryCheck", "csharp");
@@clientName(RuleSeverity, "SqlVulnerabilityAssessmentRuleSeverity", "csharp");
@@clientName(RuleType, "SqlVulnerabilityAssessmentRuleType", "csharp");
@@clientName(
  SynapseLinkWorkspaceInfoProperties,
  "SqlSynapseLinkWorkspaceInfo",
  "csharp"
);
@@clientName(SecondaryInstanceType, "GeoSecondaryInstanceType", "csharp");
@@clientName(
  StartStopManagedInstanceSchedule,
  "ManagedInstanceStartStopSchedule",
  "csharp"
);
@@clientName(
  StartStopScheduleName,
  "ManagedInstanceStartStopScheduleName",
  "csharp"
);
@@clientName(DatabaseKey, "SqlDatabaseKey", "csharp");
@@clientName(DatabaseKeyType, "SqlDatabaseKeyType", "csharp");
@@clientName(AvailabilityZoneType, "SqlAvailabilityZoneType", "csharp");
@@clientName(EndpointDependency, "ManagedInstanceEndpointDependency", "csharp");
@@clientName(EndpointDetail, "ManagedInstanceEndpointDetail", "csharp");
@@clientName(ScheduleItem, "SqlScheduleItem", "csharp");
@@clientName(
  ServerConfigurationOptionName,
  "ManagedInstanceServerConfigurationOptionName",
  "csharp"
);
@@clientName(
  ServerConfigurationOption,
  "ManagedInstanceServerConfigurationOption",
  "csharp"
);
@@clientName(
  OutboundEnvironmentEndpoint,
  "SqlOutboundEnvironmentEndpoint",
  "csharp"
);
@@clientName(
  OutboundEnvironmentEndpointCollection,
  "SqlOutboundEnvironmentEndpointCollection",
  "csharp"
);
@@clientName(MinimalTlsVersion, "SqlMinimalTlsVersion", "csharp");
@@clientName(MinimalTlsVersion.None, "TlsNone", "csharp");
@@clientName(
  MinimalTlsVersion.`1.0`,
  Azure.ClientGenerator.Core.exact("Tls1_0"),
  "csharp"
);
@@clientName(
  MinimalTlsVersion.`1.1`,
  Azure.ClientGenerator.Core.exact("Tls1_1"),
  "csharp"
);
@@clientName(
  MinimalTlsVersion.`1.2`,
  Azure.ClientGenerator.Core.exact("Tls1_2"),
  "csharp"
);
@@clientName(
  MinimalTlsVersion.`1.3`,
  Azure.ClientGenerator.Core.exact("Tls1_3"),
  "csharp"
);
@@clientName(BackupStorageAccessTier, "SqlBackupStorageAccessTier", "csharp");
@@clientName(Phase, "DatabaseOperationPhase", "csharp");
@@clientName(PhaseDetails, "DatabaseOperationPhaseDetails", "csharp");
@@clientName(
  UpsertManagedServerOperationStepWithEstimatesAndDuration,
  "UpsertManagedServerOperationStep",
  "csharp"
);
@@clientName(
  DistributedAvailabilityGroup,
  "SqlDistributedAvailabilityGroup",
  "csharp"
);
@@clientName(
  NetworkSecurityPerimeterConfiguration,
  "SqlNetworkSecurityPerimeterConfiguration",
  "csharp"
);
@@clientName(CertificateInfo, "SqlServerCertificateInfo", "csharp");
@@clientName(FailoverModeType, "SqlServerFailoverModeType", "csharp");
@@clientName(FailoverType, "SqlServerFailoverType", "csharp");
@@clientName(
  InstanceRole,
  "DistributedAvailabilityGroupManagedInstanceRole",
  "csharp"
);
@@clientName(LinkRole, "SqlServerSideLinkRole", "csharp");
@@clientName(
  NSPConfigAccessRule,
  "SqlNetworkSecurityPerimeterConfigAccessRule",
  "csharp"
);
@@clientName(
  NSPConfigAccessRuleProperties,
  "SqlNetworkSecurityPerimeterConfigAccessRuleProperties",
  "csharp"
);
@@clientName(
  NSPConfigAssociation,
  "SqlNetworkSecurityPerimeterConfigAssociation",
  "csharp"
);
@@clientName(
  NSPConfigNetworkSecurityPerimeterRule,
  "SqlNetworkSecurityPerimeterConfigRule",
  "csharp"
);
@@clientName(
  NSPConfigPerimeter,
  "SqlNetworkSecurityPerimeterConfigPerimeter",
  "csharp"
);
@@clientName(
  NSPConfigProfile,
  "SqlNetworkSecurityPerimeterConfigProfile",
  "csharp"
);
@@clientName(
  NSPProvisioningIssue,
  "SqlNetworkSecurityPerimeterProvisioningIssue",
  "csharp"
);
@@clientName(
  NSPProvisioningIssueProperties,
  "SqlNetworkSecurityPerimeterProvisioningIssueProperties",
  "csharp"
);
@@clientName(PricingModel, "SqlManagedInstancePricingModel", "csharp");
@@clientName(
  RefreshExternalGovernanceStatusOperationResultMI,
  "SqlManagedInstanceRefreshExternalGovernanceStatusOperationResult",
  "csharp"
);
@@clientName(ReplicaConnectedState, "SqlReplicaConnectedState", "csharp");
@@clientName(
  ReplicaSynchronizationHealth,
  "SqlReplicaSynchronizationHealth",
  "csharp"
);
@@clientName(ReplicationModeType, "SqlReplicationModeType", "csharp");
@@clientName(
  RoleChangeType,
  "DistributedAvailabilityGroupRoleChangeType",
  "csharp"
);
@@clientName(InstancePoolOperation, "SqlInstancePoolOperation", "csharp");
@@clientName(ErrorType, "SqlInstancePoolOperationErrorType", "csharp");
@@clientName(
  InaccessibilityReason,
  "ManagedDatabaseInaccessibilityReason",
  "csharp"
);

@@alternateType(
  CopyLongTermRetentionBackupParametersProperties.targetServerResourceId,
  armResourceIdentifier,
  "csharp"
);
@@alternateType(
  DeletedServerProperties.originalId,
  armResourceIdentifier,
  "csharp"
);
@@alternateType(
  ElasticPoolProperties.maintenanceConfigurationId,
  armResourceIdentifier,
  "csharp"
);
@@alternateType(
  ElasticPoolUpdateProperties.maintenanceConfigurationId,
  armResourceIdentifier,
  "csharp"
);
@@alternateType(
  InstancePoolProperties.subnetId,
  armResourceIdentifier,
  "csharp"
);
@@alternateType(
  LongTermRetentionOperationResultProperties.fromBackupResourceId,
  armResourceIdentifier,
  "csharp"
);
@@alternateType(
  LongTermRetentionOperationResultProperties.toBackupResourceId,
  armResourceIdentifier,
  "csharp"
);
@@alternateType(
  ManagedDatabaseProperties.crossSubscriptionTargetManagedInstanceId,
  armResourceIdentifier,
  "csharp"
);
@@alternateType(
  ManagedDatabaseProperties.crossSubscriptionSourceDatabaseId,
  armResourceIdentifier,
  "csharp"
);
@@alternateType(
  ManagedDatabaseProperties.crossSubscriptionRestorableDroppedDatabaseId,
  armResourceIdentifier,
  "csharp"
);
@@alternateType(
  ManagedDatabaseProperties.failoverGroupId,
  armResourceIdentifier,
  "csharp"
);
@@alternateType(
  ManagedDatabaseProperties.longTermRetentionBackupResourceId,
  armResourceIdentifier,
  "csharp"
);
@@alternateType(
  ManagedDatabaseProperties.recoverableDatabaseId,
  armResourceIdentifier,
  "csharp"
);
@@alternateType(
  ManagedDatabaseProperties.sourceDatabaseId,
  armResourceIdentifier,
  "csharp"
);
@@alternateType(
  ManagedInstanceProperties.instancePoolId,
  armResourceIdentifier,
  "csharp"
);
@@alternateType(
  ManagedInstanceProperties.maintenanceConfigurationId,
  armResourceIdentifier,
  "csharp"
);
@@alternateType(
  ManagedInstanceProperties.virtualClusterId,
  armResourceIdentifier,
  "csharp"
);
@@alternateType(
  ManagedInstancePrivateEndpointProperty.id,
  armResourceIdentifier,
  "csharp"
);
@@alternateType(
  ManagedDatabaseMoveDefinition.destinationManagedDatabaseId,
  armResourceIdentifier,
  "csharp"
);
@@alternateType(
  ManagedDatabaseStartMoveDefinition.destinationManagedDatabaseId,
  armResourceIdentifier,
  "csharp"
);
@@alternateType(
  SynapseLinkWorkspaceInfoProperties.workspaceId,
  armResourceIdentifier,
  "csharp"
);
@@alternateType(PrivateEndpointProperty.id, armResourceIdentifier, "csharp");
@@alternateType(
  ServerProperties.primaryUserAssignedIdentityId,
  armResourceIdentifier,
  "csharp"
);
@@alternateType(
  VirtualNetworkRuleProperties.virtualNetworkSubnetId,
  armResourceIdentifier,
  "csharp"
);
@@alternateType(
  SyncAgentProperties.syncDatabaseId,
  armResourceIdentifier,
  "csharp"
);
@@alternateType(
  SyncGroupProperties.syncDatabaseId,
  armResourceIdentifier,
  "csharp"
);
@@alternateType(
  SyncMemberProperties.syncAgentId,
  armResourceIdentifier,
  "csharp"
);
@@alternateType(
  SyncMemberProperties.syncMemberAzureDatabaseResourceId,
  armResourceIdentifier,
  "csharp"
);
@@alternateType(
  VirtualClusterProperties.subnetId,
  armResourceIdentifier,
  "csharp"
);

@@alternateType(Advisor.location, azureLocation, "csharp");
@@alternateType(EncryptionProtector.location, azureLocation, "csharp");
@@alternateType(
  ManagedDatabaseProperties.defaultSecondaryLocation,
  azureLocation,
  "csharp"
);
@@alternateType(ServerConnectionPolicy.location, azureLocation, "csharp");
@@alternateType(
  ReplicationLinkProperties.partnerLocation,
  azureLocation,
  "csharp"
);
@@alternateType(RestorePoint.location, azureLocation, "csharp");
@@alternateType(ServerKey.location, azureLocation, "csharp");

@@alternateType(DatabaseExtensionsProperties.storageUri, url, "csharp");
@@alternateType(EncryptionProtectorProperties.uri, url, "csharp");
@@alternateType(
  ImportExportExtensionsOperationResultProperties.blobUri,
  url,
  "csharp"
);
@@alternateType(ImportExportOperationResultProperties.blobUri, url, "csharp");
@@alternateType(ManagedDatabaseProperties.storageContainerUri, url, "csharp");
@@alternateType(
  ManagedInstanceEncryptionProtectorProperties.uri,
  url,
  "csharp"
);
@@alternateType(ManagedInstanceKeyProperties.uri, url, "csharp");
@@alternateType(ManagedInstanceProperties.keyId, url, "csharp");
@@alternateType(ServerKeyProperties.uri, url, "csharp");
@@alternateType(ServerProperties.keyId, url, "csharp");

@@alternateType(SecurityEventProperties.clientIp, ipV4Address, "csharp");
@@alternateType(SyncAgentLinkedDatabaseProperties.databaseId, uuid, "csharp");
@@alternateType(
  ServerProperties.publicNetworkAccess,
  ServerNetworkAccessFlag,
  "csharp"
);

@@clientName(DatabaseIdentity.type, "IdentityType", "csharp");
@@clientName(JobAgentIdentity.type, "IdentityType", "csharp");
@@clientName(JobExecutionTarget.type, "TargetType", "csharp");
@@clientName(JobSchedule.type, "ScheduleType", "csharp");
@@clientName(JobStepAction.type, "ActionType", "csharp");
@@clientName(JobStepOutput.type, "OutputType", "csharp");
@@clientName(JobTarget.type, "TargetType", "csharp");
@@clientName(DatabaseKey.type, "KeyType", "csharp");
@@clientName(CheckNameAvailabilityRequest.type, "ResourceType", "csharp");
@@clientName(
  PrivateEndpointConnectionProperties.privateLinkServiceConnectionState,
  "ConnectionState",
  "csharp"
);
@@clientName(ServicePrincipal.type, "PrincipalType", "csharp");
@@clientName(SyncGroupLogProperties.type, "LogType", "csharp");
@@usage(QueryStatistics, Azure.ClientGenerator.Core.Usage.input, "csharp");

// C# alternate type mappings migrated from autorest.md.bak directive format transforms
@@alternateType(global.Microsoft.Sql.Usage.id, armResourceIdentifier, "csharp");
@@alternateType(global.Microsoft.Sql.Usage.type, armResourceType, "csharp");
@@alternateType(ResourceWithWritableName.id, armResourceIdentifier, "csharp");
@@alternateType(ManagedInstancePecProperty.id, armResourceIdentifier, "csharp");
@@alternateType(ResourceMoveDefinition.id, armResourceIdentifier, "csharp");
@@alternateType(PartnerInfo.id, armResourceIdentifier, "csharp");
@@alternateType(
  ServerPrivateEndpointConnection.id,
  armResourceIdentifier,
  "csharp"
);
@@alternateType(ServerInfo.serverId, armResourceIdentifier, "csharp");
@@alternateType(ServicePrincipal.principalId, uuid, "csharp");
@@alternateType(ServicePrincipal.clientId, uuid, "csharp");
@@alternateType(
  ManagedDatabaseProperties.restorableDroppedDatabaseId,
  armResourceIdentifier,
  "csharp"
);
@@alternateType(
  RecommendedActionProperties.executeActionDuration,
  duration,
  "csharp"
);
@@alternateType(
  RecommendedActionProperties.revertActionDuration,
  duration,
  "csharp"
);
@@alternateType(MaintenanceWindowTimeRange.duration, duration, "csharp");
@@alternateType(JobSchedule.interval, duration, "csharp");

@@clientName(
  ManagedDatabaseProperties.autoCompleteRestore,
  "AllowAutoCompleteRestore",
  "csharp"
);
@@clientName(
  DatabaseSqlVulnerabilityAssessmentRuleBaselineInputProperties.latestScan,
  "IsLatestScan",
  "csharp"
);
@@clientName(
  DatabaseSqlVulnerabilityAssessmentRuleBaselineListInputProperties.latestScan,
  "IsLatestScan",
  "csharp"
);
@@clientName(FailoverGroupProperties.databases, "FailoverDatabases", "csharp");
@@clientName(
  FailoverGroupUpdateProperties.databases,
  "FailoverDatabases",
  "csharp"
);
@@clientName(GeoBackupPolicyProperties.state, "GeoBackupPolicyState", "csharp");
@@clientName(
  ManagedDatabaseRestoreDetailsProperties.currentRestoredSizeMB,
  "CurrentRestoredSizeInMB",
  "csharp"
);
@@clientName(
  ManagedDatabaseRestoreDetailsProperties.currentRestorePlanSizeMB,
  "CurrentRestorePlanSizeInMB",
  "csharp"
);
@@clientName(
  ManagedDatabaseRestoreDetailsProperties.type,
  "RestoreType",
  "csharp"
);
@@clientName(
  ManagedDatabaseRestoreDetailsProperties.percentCompleted,
  "CompletedPercent",
  "csharp"
);
@@clientName(
  ManagedDatabaseRestoreDetailsProperties.numberOfFilesDetected,
  "NumberOfFilesFound",
  "csharp"
);
@@clientName(
  ManagedDatabaseRestoreDetailsProperties.unrestorableFiles,
  "UnrestorableFileList",
  "csharp"
);
@@clientName(
  ManagedDatabaseRestoreDetailsBackupSetProperties.backupSizeMB,
  "BackupSizeInMB",
  "csharp"
);
@@clientName(
  ManagedDatabaseRestoreDetailsBackupSetProperties.restoreStartedTimestampUtc,
  "RestoreStartedOn",
  "csharp"
);
@@clientName(
  ManagedDatabaseRestoreDetailsBackupSetProperties.restoreFinishedTimestampUtc,
  "RestoreFinishedOn",
  "csharp"
);
@@clientName(
  ManagedInstanceProperties.dnsZonePartner,
  "ManagedDnsZonePartner",
  "csharp"
);
@@clientName(
  ManagedInstanceExternalAdministrator.azureADOnlyAuthentication,
  "IsAzureADOnlyAuthenticationEnabled",
  "csharp"
);
@@clientName(
  ServerExternalAdministrator.azureADOnlyAuthentication,
  "IsAzureADOnlyAuthenticationEnabled",
  "csharp"
);
@@clientName(
  ManagedInstanceAzureADOnlyAuthProperties.azureADOnlyAuthentication,
  "IsAzureADOnlyAuthenticationEnabled",
  "csharp"
);
@@clientName(
  ManagedInstancePrivateEndpointConnectionProperties.privateLinkServiceConnectionState,
  "PrivateLinkServiceConnectionState",
  "csharp"
);
@@clientName(RecommendedActionProperties.details, "ActionDetails", "csharp");
@@clientName(
  RestorePointProperties.restorePointCreationDate,
  "restorePointCreatedOn",
  "csharp"
);
@@clientName(ServerProperties.minimalTlsVersion, "minTlsVersion", "csharp");
@@clientName(
  AdministratorProperties.azureADOnlyAuthentication,
  "IsAzureADOnlyAuthenticationEnabled",
  "csharp"
);
@@clientName(
  AzureADOnlyAuthProperties.azureADOnlyAuthentication,
  "IsAzureADOnlyAuthenticationEnabled",
  "csharp"
);
@@clientName(
  SyncGroupProperties.enableConflictLogging,
  "IsConflictLoggingEnabled",
  "csharp"
);
@@clientName(AlwaysEncryptedEnclaveType.VBS, "Vbs", "csharp");
@@clientName(Remediation.automated, "IsAutomated", "csharp");
@@clientName(
  ManagedInstanceDtcSecuritySettings.xaTransactionsDefaultTimeout,
  "XATransactionsDefaultTimeoutInSeconds",
  "csharp"
);
@@clientName(
  ManagedInstanceDtcSecuritySettings.xaTransactionsMaximumTimeout,
  "XATransactionsMaximumTimeoutInSeconds",
  "csharp"
);
@@clientName(
  ManagedInstanceDtcSecuritySettings.xaTransactionsEnabled,
  "IsXATransactionsEnabled",
  "csharp"
);
@@clientName(AuthMetadataLookupModes, "AuthMetadataLookupMode", "csharp");
@@clientName(AuthMetadataLookupModes.AzureAD, "Aad", "csharp");
@@clientName(ClientClassificationSource.MIP, "Mip", "csharp");
@@clientName(DataMaskingRuleProperties.id, "RuleId", "csharp");
@@clientName(ReplicaSynchronizationHealth.NOT_HEALTHY, "NotHealthy", "csharp");
@@clientName(
  ManagedInstanceVcoresCapability.supportedMemoryLimitsMB,
  "SupportedMemoryLimitsInMB",
  "csharp"
);

// C# client name mappings migrated from autorest.md.bak directive x-ms-client-name transforms
@@clientName(
  LongTermRetentionBackupProperties.backupExpirationTime,
  "backupExpireOn",
  "csharp"
);
@@clientName(
  ManagedInstanceLongTermRetentionBackupProperties.backupExpirationTime,
  "backupExpireOn",
  "csharp"
);
@@clientName(
  LongTermRetentionBackupProperties.databaseDeletionTime,
  "databaseDeletedOn",
  "csharp"
);
@@clientName(
  ManagedInstanceLongTermRetentionBackupProperties.databaseDeletionTime,
  "databaseDeletedOn",
  "csharp"
);
@@clientName(SyncAgentProperties.expiryTime, "ExpireOn", "csharp");
@@clientName(
  DatabaseProperties.sourceDatabaseDeletionDate,
  "sourceDatabaseDeletedOn",
  "csharp"
);
@@clientName(
  DatabaseUpdateProperties.sourceDatabaseDeletionDate,
  "sourceDatabaseDeletedOn",
  "csharp"
);
@@clientName(
  DatabaseOperationProperties.estimatedCompletionTime,
  "estimatedCompleteOn",
  "csharp"
);
@@clientName(
  ElasticPoolOperationProperties.estimatedCompletionTime,
  "estimatedCompleteOn",
  "csharp"
);
@@clientName(
  InstancePoolOperationProperties.estimatedCompletionTime,
  "estimatedCompleteOn",
  "csharp"
);
@@clientName(
  ManagedInstanceOperationProperties.estimatedCompletionTime,
  "estimatedCompleteOn",
  "csharp"
);
@@clientName(
  ServerOperationProperties.estimatedCompletionTime,
  "estimatedCompleteOn",
  "csharp"
);
@@clientName(
  SecurityAlertPolicyProperties.emailAccountAdmins,
  "SendToEmailAccountAdmins",
  "csharp"
);
@@clientName(
  SecurityAlertsPolicyProperties.emailAccountAdmins,
  "SendToEmailAccountAdmins",
  "csharp"
);
@@clientName(AdvisorProperties.lastChecked, "LastCheckedOn", "csharp");
@@clientName(
  DatabaseColumnProperties.memoryOptimized,
  "IsMemoryOptimized",
  "csharp"
);
@@clientName(
  DatabaseTableProperties.memoryOptimized,
  "IsMemoryOptimized",
  "csharp"
);
@@clientName(DatabaseProperties.zoneRedundant, "IsZoneRedundant", "csharp");
@@clientName(
  DatabaseUpdateProperties.zoneRedundant,
  "IsZoneRedundant",
  "csharp"
);
@@clientName(EditionCapability.zoneRedundant, "IsZoneRedundant", "csharp");
@@clientName(
  ElasticPoolEditionCapability.zoneRedundant,
  "IsZoneRedundant",
  "csharp"
);
@@clientName(
  ElasticPoolPerformanceLevelCapability.zoneRedundant,
  "IsZoneRedundant",
  "csharp"
);
@@clientName(ElasticPoolProperties.zoneRedundant, "IsZoneRedundant", "csharp");
@@clientName(
  ElasticPoolUpdateProperties.zoneRedundant,
  "IsZoneRedundant",
  "csharp"
);
@@clientName(
  MaintenanceConfigurationCapability.zoneRedundant,
  "IsZoneRedundant",
  "csharp"
);
@@clientName(
  ManagedInstanceFamilyCapability.zoneRedundant,
  "IsZoneRedundant",
  "csharp"
);
@@clientName(
  ManagedInstanceProperties.zoneRedundant,
  "IsZoneRedundant",
  "csharp"
);
@@clientName(
  ServiceObjectiveCapability.zoneRedundant,
  "IsZoneRedundant",
  "csharp"
);
@@clientName(
  EncryptionProtectorProperties.autoRotationEnabled,
  "IsAutoRotationEnabled",
  "csharp"
);
@@clientName(
  ManagedInstanceEncryptionProtectorProperties.autoRotationEnabled,
  "IsAutoRotationEnabled",
  "csharp"
);
@@clientName(
  ManagedInstanceKeyProperties.autoRotationEnabled,
  "IsAutoRotationEnabled",
  "csharp"
);
@@clientName(
  ServerKeyProperties.autoRotationEnabled,
  "IsAutoRotationEnabled",
  "csharp"
);
@@clientName(
  ManagedInstanceProperties.publicDataEndpointEnabled,
  "IsPublicDataEndpointEnabled",
  "csharp"
);
@@clientName(
  ManagedInstanceVcoresCapability.instancePoolSupported,
  "IsInstancePoolSupported",
  "csharp"
);
@@clientName(
  ManagedInstanceVcoresCapability.standaloneSupported,
  "IsStandaloneSupported",
  "csharp"
);
@@clientName(JobSchedule.enabled, "IsEnabled", "csharp");
@@clientName(CheckNameAvailabilityResponse.available, "IsAvailable", "csharp");

// C# operation name mappings migrated from autorest.md.bak override-operation-name
@@clientName(
  Microsoft.Sql.ManagedInstances.listByInstance,
  "GetSqlServerTrustGroups",
  "csharp"
);
@@clientName(ManagedInstances.listByManagedInstance, "GetTopQueries", "csharp");
@@clientName(
  ManagedInstances.listInaccessibleByInstance,
  "GetInaccessibleManagedDatabases",
  "csharp"
);
@@clientName(
  ManagedInstances.listOutboundNetworkDependenciesByManagedInstance,
  "GetOutboundNetworkDependencies",
  "csharp"
);
@@clientName(
  ManagedInstanceQueries.listByQuery,
  "GetQueryStatistics",
  "csharp"
);
@@clientName(
  CapabilitiesOperationGroup.listByLocation,
  "GetCapabilitiesByLocation",
  "csharp"
);
@@clientName(
  ServersOperationGroup.checkNameAvailability,
  "CheckSqlServerNameAvailability",
  "csharp"
);
@@clientName(
  LongTermRetentionBackupsOperationGroup.listByLocation,
  "GetLongTermRetentionBackupsWithLocation",
  "csharp"
);
@@clientName(
  LongTermRetentionBackupsOperationGroup.listByResourceGroupLocation,
  "GetLongTermRetentionBackupsWithResourceGroupLocation",
  "csharp"
);
@@clientName(
  LongTermRetentionBackupsOperationGroup.listByServer,
  "GetLongTermRetentionBackupsWithServer",
  "csharp"
);
@@clientName(
  LongTermRetentionBackupsOperationGroup.listByResourceGroupServer,
  "GetLongTermRetentionBackupsWithResourceGroupServer",
  "csharp"
);
@@clientName(
  LongTermRetentionManagedInstanceBackupsOperationGroup.listByInstance,
  "GetLongTermRetentionManagedInstanceBackupsWithInstance",
  "csharp"
);
@@clientName(
  LongTermRetentionManagedInstanceBackupsOperationGroup.listByResourceGroupInstance,
  "GetLongTermRetentionManagedInstanceBackupsWithResourceGroupInstance",
  "csharp"
);
@@clientName(
  LongTermRetentionManagedInstanceBackupsOperationGroup.listByLocation,
  "GetLongTermRetentionManagedInstanceBackupsWithLocation",
  "csharp"
);
@@clientName(
  LongTermRetentionManagedInstanceBackupsOperationGroup.listByResourceGroupLocation,
  "GetLongTermRetentionManagedInstanceBackupsWithResourceGroupLocation",
  "csharp"
);
@@clientName(SqlVulnerabilityAssessments.execute, "ExecuteScan", "csharp");
@@clientName(
  SqlVulnerabilityAssessmentsSettings.execute,
  "ExecuteScanSettings",
  "csharp"
);
@@clientName(
  SqlVulnerabilityAssessmentScanResults,
  "SqlVulnerabilityAssessmentScanResult",
  "csharp"
);
@@clientName(PrivateLinkResource, "SqlPrivateLinkResource", "csharp");
@@clientName(
  PrivateEndpointConnection,
  "SqlPrivateEndpointConnection",
  "csharp"
);
@@clientName(ManagedLedgerDigestUploads, "ManagedLedgerDigestUpload", "csharp");
@@clientName(MaintenanceWindowOptions, "MaintenanceWindowOption", "csharp");
@@clientName(
  DataWarehouseUserActivities,
  "DataWarehouseUserActivity",
  "csharp"
);
@@clientName(
  UpsertManagedServerOperationStepWithEstimatesAndDurationStatus,
  "UpsertManagedServerOperationStepStatus",
  "csharp"
);
@@clientName(
  CheckNameAvailabilityResponse,
  "SqlNameAvailabilityResponse",
  "csharp"
);
@@clientName(
  ManagedServerDnsAliasCreation,
  "ManagedServerDnsAliasCreateOrUpdateContent",
  "csharp"
);
@@clientName(
  ManagedInstanceValidateAzureKeyVaultEncryptionKeyRequest,
  "ManagedInstanceValidateAzureKeyVaultEncryptionKeyContent",
  "csharp"
);
@@clientName(
  ManagedInstanceValidateAzureKeyVaultEncryptionKeyRequest,
  "ManagedInstanceValidateAzureKeyVaultEncryptionKeyContent",
  "csharp"
);
@@clientName(
  DistributedAvailabilityGroupsFailoverRequest,
  "DistributedAvailabilityGroupsFailoverContent",
  "csharp"
);
@@clientName(SyncAgentProperties.name, "SyncAgentName", "csharp");
@@clientName(
  ManagedDatabases.managedDatabaseRecommendedSensitivityLabelsUpdate,
  "UpdateRecommendedManagedDatabaseSensitivityLabel",
  "csharp"
);
@@clientName(
  ManagedDatabases.listCurrentByDatabase,
  "GetCurrentManagedDatabaseSensitivityLabels",
  "csharp"
);
@@clientName(
  ManagedDatabases.listRecommendedByDatabase,
  "GetRecommendedManagedDatabaseSensitivityLabels",
  "csharp"
);
@@clientName(
  Databases.recommendedSensitivityLabelsUpdate,
  "UpdateRecommendedSensitivityLabel",
  "csharp"
);
@@clientName(
  DataMaskingPolicies.listByDatabase,
  "GetDataMaskingRules",
  "csharp"
);
@@clientName(
  Databases.databaseUsagesListByDatabase,
  "GetDatabaseUsages",
  "csharp"
);
@@clientName(
  Databases.synapseLinkWorkspacesListByDatabase,
  "GetSynapseLinkWorkspaces",
  "csharp"
);
@@clientName(
  ImportExportExtensionsOperationResults.listByDatabase,
  "GetDatabaseExtensions",
  "csharp"
);
@@clientName(ElasticPools.listByElasticPool, "GetDatabases", "csharp");
@@clientName(
  ElasticPools.elasticPoolOperationsListByElasticPool,
  "GetElasticPoolOperations",
  "csharp"
);
@@clientName(
  Servers.serverOperationsListByServer,
  "GetServerOperations",
  "csharp"
);
@@clientName(Servers.serverUsagesListByServer, "GetServerUsages", "csharp");

// Scope out any operation methods for csharp as they have been implemented in core lib
@@scope(ManagedDatabaseMoveOperationResults.get, "!csharp");
@@scope(ManagedDatabaseMoveOperationResults.listByLocation, "!csharp");
// This is temporary, to be removed when we find the owner of this feature
@@scope(JobPrivateEndpoints.get, "!csharp");
@@scope(JobPrivateEndpoints.createOrUpdate, "!csharp");
@@scope(JobPrivateEndpoints.delete, "!csharp");
@@scope(JobPrivateEndpoints.listByAgent, "!csharp");
// This operation is not supported
@@scope(ImportExportExtensionsOperationResults.get, "!csharp");
// This operation sends a list of rules but got a single rule in response, which is abnormal. Besides, using FirewallRules_CreateOrUpdate/FirewallRules_Delete multiple times could achieve the same goal.
@@scope(Servers.replace, "!csharp");

/**
 * Provisioning state of managed instance.
 */
union ManagedInstancePropertiesProvisioningState {
  string,

  /**
   * Created
   */
  Created: "Created",

  /**
   * InProgress
   */
  InProgress: "InProgress",

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
   * Deleting
   */
  Deleting: "Deleting",

  /**
   * Updating
   */
  Updating: "Updating",

  /**
   * Unknown
   */
  Unknown: "Unknown",

  /**
   * Accepted
   */
  Accepted: "Accepted",

  /**
   * Deleted
   */
  Deleted: "Deleted",

  /**
   * Unrecognized
   */
  Unrecognized: "Unrecognized",

  /**
   * Running
   */
  Running: "Running",

  /**
   * NotSpecified
   */
  NotSpecified: "NotSpecified",

  /**
   * Registering
   */
  Registering: "Registering",

  /**
   * TimedOut
   */
  TimedOut: "TimedOut",
}
// Inherited from the original autorest.md settings.
@@alternateType(
  ManagedInstanceProperties.provisioningState,
  ManagedInstancePropertiesProvisioningState,
  "csharp"
);

/**
 * Availability resource type.
 */
union SqlNameAvailabilityResourceType {
  string,

  /**
   * Microsoft.Sql/servers
   */
  MicrosoftSqlServers: "Microsoft.Sql/servers",
}
// Inherited from the original autorest.md settings. Change fixed enum to extensible enum.
@@alternateType(
  CheckNameAvailabilityRequest.type,
  SqlNameAvailabilityResourceType,
  "csharp"
);
@@usage(
  RecommendedSensitivityLabelUpdateProperties,

    | Azure.ClientGenerator.Core.Usage.input
    | Azure.ClientGenerator.Core.Usage.output,
  "csharp"
);
@@usage(
  RecommendedSensitivityLabelUpdate,

    | Azure.ClientGenerator.Core.Usage.input
    | Azure.ClientGenerator.Core.Usage.output,
  "csharp"
);
@@usage(EndpointCertificate, Azure.ClientGenerator.Core.Usage.input, "csharp");
@@usage(DatabaseColumn, Azure.ClientGenerator.Core.Usage.input, "csharp");
@@clientName(
  DatabaseColumnProperties.memoryOptimized,
  "IsMemoryOptimized",
  "csharp"
);
@@usage(DatabaseTable, Azure.ClientGenerator.Core.Usage.input, "csharp");
@@clientName(
  DatabaseTableProperties.memoryOptimized,
  "IsMemoryOptimized",
  "csharp"
);
@@alternateType(DataMaskingPolicy.location, azureLocation, "csharp");
@@clientName(
  DataMaskingPolicies.dataMaskingRulesCreateOrUpdate,
  "CreateOrUpdateDataMaskingRule",
  "csharp"
);
@@clientName(InstancePools.listByInstancePool, "GetManagedInstances", "csharp");
@@clientName(InstancePools.usagesListByInstancePool, "GetUsages", "csharp");
@@usage(
  LongTermRetentionBackup,
  Azure.ClientGenerator.Core.Usage.input,
  "csharp"
);
@@usage(
  MaintenanceWindowOptions,
  Azure.ClientGenerator.Core.Usage.input,
  "csharp"
);
@@clientName(
  SensitivityLabels.disableRecommendation,
  "DisableRecommendationManagedDatabaseSensitivityLabel",
  "csharp"
);
@@clientName(
  SensitivityLabels.enableRecommendation,
  "EnableRecommendationManagedDatabaseSensitivityLabel",
  "csharp"
);
@@clientName(
  ManagedDatabases.listCurrentByDatabase,
  "GetCurrentManagedDatabaseSensitivityLabels",
  "csharp"
);
@@clientName(
  ManagedDatabases.listRecommendedByDatabase,
  "GetRecommendedManagedDatabaseSensitivityLabels",
  "csharp"
);
@@clientName(
  ManagedDatabases.managedDatabaseSensitivityLabelsListByDatabase,
  "GetManagedDatabaseSensitivityLabelsByDatabase",
  "csharp"
);
@@clientName(
  ManagedDatabases.listByDatabase,
  "GetManagedDatabaseColumnsByDatabase",
  "csharp"
);
@@clientName(ManagedInstanceQueries.get, "GetManagedDatabaseQuery", "csharp");
@@clientName(
  ManagedDatabases.managedDatabaseSecurityEventsListByDatabase,
  "GetManagedDatabaseSecurityEventsByDatabase",
  "csharp"
);
@@clientName(
  ManagedInstanceQueries.listByQuery,
  "GetQueryStatistics",
  "csharp"
);
@@clientName(
  ManagedDatabases.managedDatabaseSensitivityLabelsUpdate,
  "UpdateManagedDatabaseSensitivityLabel",
  "csharp"
);
@@alternateType(ManagedInstanceOperation.name, uuid, "csharp");
@@alternateType(InstancePoolOperation.name, uuid, "csharp");
@@clientName(ElasticPools.cancel, "CancelElasticPoolOperation", "csharp");

@@clientName(
  ManagedInstances.create,
  "CreateManagedInstanceTdeCertificate",
  "csharp"
);
@@clientName(
  LongTermRetentionBackups.changeAccessTier::parameters.body,
  "content",
  "csharp"
);
@@clientName(
  LongTermRetentionBackupOperationGroup.changeAccessTierByResourceGroup::parameters.body,
  "content",
  "csharp"
);
@@clientName(ServerUsageProperties.nextResetTime, "NextResetOn", "csharp");
@@clientName(ResourceWithWritableName.type, "ResourceType", "csharp");
@@alternateType(ResourceWithWritableName.type, armResourceType, "csharp");

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.hierarchyBuilding(
  RestorableDroppedDatabase,
  Azure.ResourceManager.Foundations.TrackedResource,
  "csharp"
);

// --- Property type alternates (string -> ResourceIdentifier / AzureLocation) ---
@@alternateType(
  DatabaseProperties.failoverGroupId,
  armResourceIdentifier,
  "csharp"
);
@@alternateType(
  DatabaseProperties.maintenanceConfigurationId,
  armResourceIdentifier,
  "csharp"
);
@@alternateType(
  DatabaseProperties.defaultSecondaryLocation,
  azureLocation,
  "csharp"
);
@@alternateType(
  DatabaseUpdateProperties.failoverGroupId,
  armResourceIdentifier,
  "csharp"
);
@@alternateType(
  DatabaseUpdateProperties.maintenanceConfigurationId,
  armResourceIdentifier,
  "csharp"
);
@@alternateType(
  DatabaseUpdateProperties.defaultSecondaryLocation,
  azureLocation,
  "csharp"
);

// --- Enum value renames to match v1.4.0 contract ---
@@clientName(
  CatalogCollationType.DATABASE_DEFAULT,
  "DatabaseDefault",
  "csharp"
);
@@clientName(
  CatalogCollationType.SQL_Latin1_General_CP1_CI_AS,
  "SqlLatin1GeneralCp1CiAs",
  "csharp"
);

@@clientName(DiffBackupIntervalInHours.`12`, "Twelve", "csharp");
@@clientName(DiffBackupIntervalInHours.`24`, "TwentyFour", "csharp");

// =====================================================================
// Restore parameterless ctor + setters for output-only models
// (v1.4.0 ApiCompat mitigations)
//
// Marking these models as `Usage.input` makes the C# generator emit them
// as roundtrippable (Input | Output), which restores the public
// parameterless constructor and writable property setters that the
// v1.4.0 contract exposed.
// =====================================================================
@@usage(DatabaseOperation, Azure.ClientGenerator.Core.Usage.input, "csharp");
@@usage(DatabaseUsage, Azure.ClientGenerator.Core.Usage.input, "csharp");
@@usage(
  DatabaseVulnerabilityAssessmentScansExport,
  Azure.ClientGenerator.Core.Usage.input,
  "csharp"
);
@@usage(ElasticPoolOperation, Azure.ClientGenerator.Core.Usage.input, "csharp");
@@usage(
  ImportExportExtensionsOperationResult,
  Azure.ClientGenerator.Core.Usage.input,
  "csharp"
);
@@usage(
  ImportExportOperationResult,
  Azure.ClientGenerator.Core.Usage.input,
  "csharp"
);
@@usage(
  LongTermRetentionBackupOperationResult,
  Azure.ClientGenerator.Core.Usage.input,
  "csharp"
);
@@usage(
  UpdateVirtualClusterDnsServersOperation,
  Azure.ClientGenerator.Core.Usage.input,
  "csharp"
);
@@usage(
  RefreshExternalGovernanceStatusOperationResult,
  Azure.ClientGenerator.Core.Usage.input,
  "csharp"
);
@@usage(SecurityEvent, Azure.ClientGenerator.Core.Usage.input, "csharp");
@@usage(ServerOperation, Azure.ClientGenerator.Core.Usage.input, "csharp");
@@usage(
  InstancePoolOperation,
  Azure.ClientGenerator.Core.Usage.input,
  "csharp"
);
@@usage(
  RefreshExternalGovernanceStatusOperationResultMI,
  Azure.ClientGenerator.Core.Usage.input,
  "csharp"
);
@@usage(NSPConfigAccessRule, Azure.ClientGenerator.Core.Usage.input, "csharp");
@@usage(
  NSPConfigAccessRuleProperties,
  Azure.ClientGenerator.Core.Usage.input,
  "csharp"
);
@@usage(NSPConfigAssociation, Azure.ClientGenerator.Core.Usage.input, "csharp");
@@usage(NSPConfigPerimeter, Azure.ClientGenerator.Core.Usage.input, "csharp");
@@usage(NSPConfigProfile, Azure.ClientGenerator.Core.Usage.input, "csharp");
@@usage(
  NSPConfigNetworkSecurityPerimeterRule,
  Azure.ClientGenerator.Core.Usage.input,
  "csharp"
);
@@usage(
  NetworkSecurityPerimeterConfiguration,
  Azure.ClientGenerator.Core.Usage.input,
  "csharp"
);
@@usage(NSPProvisioningIssue, Azure.ClientGenerator.Core.Usage.input, "csharp");
@@usage(
  NSPProvisioningIssueProperties,
  Azure.ClientGenerator.Core.Usage.input,
  "csharp"
);
@@usage(PrivateLinkResource, Azure.ClientGenerator.Core.Usage.input, "csharp");
@@usage(RestorePoint, Azure.ClientGenerator.Core.Usage.input, "csharp");
@@usage(ServerDnsAlias, Azure.ClientGenerator.Core.Usage.input, "csharp");
@@usage(JobExecution, Azure.ClientGenerator.Core.Usage.input, "csharp");
@@usage(JobVersion, Azure.ClientGenerator.Core.Usage.input, "csharp");
@@usage(ServerUsage, Azure.ClientGenerator.Core.Usage.input, "csharp");
@@usage(SynapseLinkWorkspace, Azure.ClientGenerator.Core.Usage.input, "csharp");
@@usage(
  SynapseLinkWorkspaceInfoProperties,
  Azure.ClientGenerator.Core.Usage.input,
  "csharp"
);
@@usage(TimeZone, Azure.ClientGenerator.Core.Usage.input, "csharp");
@@usage(
  DatabaseSqlVulnerabilityAssessmentBaselineSet,
  Azure.ClientGenerator.Core.Usage.input,
  "csharp"
);
@@usage(
  DatabaseSqlVulnerabilityAssessmentRuleBaseline,
  Azure.ClientGenerator.Core.Usage.input,
  "csharp"
);
@@usage(
  SqlVulnerabilityAssessmentScanRecord,
  Azure.ClientGenerator.Core.Usage.input,
  "csharp"
);
@@usage(
  SqlVulnerabilityAssessmentScanResults,
  Azure.ClientGenerator.Core.Usage.input,
  "csharp"
);
@@usage(SubscriptionUsage, Azure.ClientGenerator.Core.Usage.input, "csharp");
@@usage(
  SyncAgentLinkedDatabase,
  Azure.ClientGenerator.Core.Usage.input,
  "csharp"
);
@@usage(
  VulnerabilityAssessmentScanRecord,
  Azure.ClientGenerator.Core.Usage.input,
  "csharp"
);
@@usage(
  RestorableDroppedDatabase,
  Azure.ClientGenerator.Core.Usage.input,
  "csharp"
);
@@usage(DatabaseExtensions, Azure.ClientGenerator.Core.Usage.input, "csharp");
@@usage(TdeCertificate, Azure.ClientGenerator.Core.Usage.input, "csharp");
@@usage(
  DatabaseSqlVulnerabilityAssessmentRuleBaselineListInput,
  Azure.ClientGenerator.Core.Usage.input,
  "csharp"
);
@@usage(
  DatabaseSqlVulnerabilityAssessmentRuleBaselineInput,
  Azure.ClientGenerator.Core.Usage.input,
  "csharp"
);

// Setter regressions vs v1.4.0: add Usage.input on the model and its inner *Properties bag
// so that flat-projected properties are emitted with public setters and list properties
// are emitted as IList<T> rather than IReadOnlyList<T>.
@@usage(
  RecommendedSensitivityLabelUpdate,
  Azure.ClientGenerator.Core.Usage.input,
  "csharp"
);
@@usage(
  RecommendedSensitivityLabelUpdateProperties,
  Azure.ClientGenerator.Core.Usage.input,
  "csharp"
);
@@usage(
  SensitivityLabelUpdate,
  Azure.ClientGenerator.Core.Usage.input,
  "csharp"
);
@@usage(
  SensitivityLabelUpdateProperties,
  Azure.ClientGenerator.Core.Usage.input,
  "csharp"
);
@@usage(
  DatabaseExtensionsProperties,
  Azure.ClientGenerator.Core.Usage.input,
  "csharp"
);
@@usage(
  DatabaseSqlVulnerabilityAssessmentRuleBaselineListInputProperties,
  Azure.ClientGenerator.Core.Usage.input,
  "csharp"
);
@@usage(
  DatabaseSqlVulnerabilityAssessmentRuleBaselineInputProperties,
  Azure.ClientGenerator.Core.Usage.input,
  "csharp"
);
@@usage(
  TdeCertificateProperties,
  Azure.ClientGenerator.Core.Usage.input,
  "csharp"
);
@@usage(
  QueryStatisticsProperties,
  Azure.ClientGenerator.Core.Usage.input,
  "csharp"
);
@@usage(QueryMetricInterval, Azure.ClientGenerator.Core.Usage.input, "csharp");

@@clientName(AvailabilityZoneType.`1`, "One", "csharp");
@@clientName(AvailabilityZoneType.`2`, "Two", "csharp");
@@clientName(AvailabilityZoneType.`3`, "Three", "csharp");

@@clientName(ManagedDatabaseStatus.DbCopying, "DBCopying", "csharp");
@@clientName(ManagedDatabaseStatus.DbMoving, "DBMoving", "csharp");

@@clientName(
  ManagedInstanceDatabaseFormat.SQLServer2022,
  "SqlServer2022",
  "csharp"
);
@@clientName(
  ManagedInstanceDatabaseFormat.SQLServer2025,
  "SqlServer2025",
  "csharp"
);

@@clientName(PerformanceLevelUnit.DTU, "Dtu", "csharp");

@@clientName(ReplicationState.PENDING, "Pending", "csharp");
@@clientName(ReplicationState.SEEDING, "Seeding", "csharp");
@@clientName(ReplicationState.CATCH_UP, "CatchUp", "csharp");
@@clientName(ReplicationState.SUSPENDED, "Suspended", "csharp");

@@clientName(ReplicationLinkType.GEO, "Geo", "csharp");
@@clientName(ReplicationLinkType.NAMED, "Named", "csharp");
@@clientName(ReplicationLinkType.STANDBY, "Standby", "csharp");

@@clientName(ColumnDataType.hierarchyid, "HierarchyId", "csharp");

@@clientName(ReplicaConnectedState.CONNECTED, "Connected", "csharp");
@@clientName(ReplicaConnectedState.DISCONNECTED, "Disconnected", "csharp");

@@clientName(ReplicaSynchronizationHealth.HEALTHY, "Healthy", "csharp");
@@clientName(
  ReplicaSynchronizationHealth.PARTIALLY_HEALTHY,
  "PartiallyHealthy",
  "csharp"
);

@@clientName(StorageCapabilityStorageAccountType.GRS, "Grs", "csharp");
@@clientName(StorageCapabilityStorageAccountType.LRS, "Lrs", "csharp");
@@clientName(StorageCapabilityStorageAccountType.ZRS, "Zrs", "csharp");
@@clientName(StorageCapabilityStorageAccountType.GZRS, "Gzrs", "csharp");

@@clientName(
  ServerFirewallRuleProperties.startIpAddress,
  "StartIPAddress",
  "csharp"
);
@@clientName(
  ServerFirewallRuleProperties.endIpAddress,
  "EndIPAddress",
  "csharp"
);
@@clientName(SecurityEventProperties.clientIp, "ClientIP", "csharp");
@@clientName(
  ManagedInstanceDtcSecuritySettings.snaLu6point2TransactionsEnabled,
  "SnaLu6Point2TransactionsEnabled",
  "csharp"
);
@@clientName(DeletedServersOperationGroup.list, "GetDeletedServers", "csharp");
@@clientName(
  SyncGroupsOperationGroup.listSyncDatabaseIds,
  "GetSyncDatabaseIdsSyncGroups",
  "csharp"
);

@@clientName(Databases.create, "CreateRestorePoint", "csharp");
@@clientName(
  Databases.listCurrentByDatabase,
  "GetCurrentSensitivityLabels",
  "csharp"
);
@@clientName(
  Databases.listRecommendedByDatabase,
  "GetRecommendedSensitivityLabels",
  "csharp"
);
@@clientName(
  Databases.sensitivityLabelsListByDatabase,
  "GetSensitivityLabels",
  "csharp"
);
@@clientName(
  Databases.sensitivityLabelsUpdate,
  "UpdateSensitivityLabel",
  "csharp"
);
@@clientName(Databases.cancel, "CancelDatabaseOperation", "csharp");
@@clientName(
  ImportExportExtensionsOperationResults.createOrUpdate,
  "CreateOrUpdateDatabaseExtension",
  "csharp"
);
@@clientName(Databases.listByDatabase, "GetDatabaseColumns", "csharp");
@@clientName(
  Databases.databaseOperationsListByDatabase,
  "GetDatabaseOperations",
  "csharp"
);
@@clientName(
  Databases.revalidate,
  "RevalidateDatabaseEncryptionProtector",
  "csharp"
);
@@clientName(Databases.revert, "RevertDatabaseEncryptionProtector", "csharp");
@@alternateType(
  SqlVulnerabilityAssessmentName,
  VulnerabilityAssessmentName,
  "csharp"
);
@@clientName(LegacyDataMaskingFunction.CCN, "Ccn", "csharp");
@@clientName(LegacyDataMaskingFunction.SSN, "Ssn", "csharp");
@@clientName(DataMaskingFunction.CCN, "Ccn", "csharp");
@@clientName(DataMaskingFunction.SSN, "Ssn", "csharp");
@@clientName(RestorePointType.CONTINUOUS, "Continuous", "csharp");
@@clientName(RestorePointType.DISCRETE, "Discrete", "csharp");

// we add this model in this namespace in order to replace some models with this model via alternateType decorator
namespace Azure.ResourceManager.Models {
  /** represents a reference to an existing resource by its id */
  model SubResource {
    /** the id */
    id?: armResourceIdentifier;
  }
}
@@alternateType(
  SyncDatabaseIdProperties,
  Azure.ResourceManager.Models.SubResource,
  "csharp"
);

// Change the BlobAuditingPolicyName from fixed enum to extensible enum
/**
 * The name of the blob auditing policy.
 */
union BlobAuditingPolicyNameType {
  BlobAuditingPolicyName,
  string,
}
@@alternateType(BlobAuditingPolicyName, BlobAuditingPolicyNameType, "csharp");
@@clientName(BlobAuditingPolicyNameType, "BlobAuditingPolicyName", "csharp");

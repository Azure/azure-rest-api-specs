import "@azure-tools/typespec-client-generator-core";

import "./Workspaces/main.tsp";
import "./SqlPools/main.tsp";
import "./BigDataPools/main.tsp";
import "./IntegrationRuntimes/main.tsp";
import "./KustoPools/main.tsp";

using Azure.ClientGenerator.Core;

/**
 * Azure Synapse Analytics management client. Combines the Synapse resource-manager
 * TypeSpec projects (each with its own API version) into the single SDK client
 * released from the `package-composite-v2` tag.
 */
@client({
  name: "SynapseManagementClient",
  service: [
    Workspaces,
    SqlPools,
    BigDataPools,
    IntegrationRuntimes,
    KustoPools
  ],
  autoMergeService: true,
})
namespace Microsoft.Synapse;

/** The type of resource, for Kusto pool name checks (C# only; released as an extensible enum). */
union KustoPoolType {
  string,

  /** Microsoft.Synapse/workspaces/kustoPools */
  MicrosoftSynapseWorkspacesKustoPools: "Microsoft.Synapse/workspaces/kustoPools",
}

/** The type of resource, for Kusto data connection name checks (C# only; released as an extensible enum). */
union SynapseDataConnectionType {
  string,

  /** Microsoft.Synapse/workspaces/kustoPools/databases/dataConnections */
  MicrosoftSynapseWorkspacesKustoPoolsDatabasesDataConnections: "Microsoft.Synapse/workspaces/kustoPools/databases/dataConnections",
}

/** The type of resource, for Kusto pool principal assignment name checks (C# only; released as an extensible enum). */
union SynapsePrincipalAssignmentType {
  string,

  /** Microsoft.Synapse/workspaces/kustoPools/principalAssignments */
  MicrosoftSynapseWorkspacesKustoPoolsPrincipalAssignments: "Microsoft.Synapse/workspaces/kustoPools/principalAssignments",
}

/** The type of resource, for Kusto database principal assignment name checks (C# only; released as an extensible enum). */
union SynapseDatabasePrincipalAssignmentType {
  string,

  /** Microsoft.Synapse/workspaces/kustoPools/databases/principalAssignments */
  MicrosoftSynapseWorkspacesKustoPoolsDatabasesPrincipalAssignments: "Microsoft.Synapse/workspaces/kustoPools/databases/principalAssignments",
}

// --- C# (csharp scope only; wire contract and other languages unchanged) ---
// Ported from the GA azure-sdk-for-net sdk/synapse/Azure.ResourceManager.Synapse/src/autorest.md
// (rename-mapping, prepend-rp-prefix, override-operation-name, remove-operation, directives) so the
// TypeSpec-generated .NET SDK keeps the released Azure.ResourceManager.Synapse surface. Type names are
// checked against the released public API listing.

// rename-mapping
@@clientName(
  Workspaces.AzureADOnlyAuthentication,
  "SynapseAadOnlyAuthentication",
  "csharp"
);
@@clientName(
  Workspaces.AzureADOnlyAuthenticationListResult,
  "SynapseAadOnlyAuthenticationListResult",
  "csharp"
);
@@clientName(
  Workspaces.AzureADOnlyAuthenticationName,
  "SynapseAadOnlyAuthenticationName",
  "csharp"
);
@@clientName(
  SqlPools.DedicatedSQLminimalTlsSettings,
  "SynapseDedicatedSqlMinimalTlsSetting",
  "csharp"
);
@@clientName(
  SqlPools.DedicatedSQLminimalTlsSettingsListResult,
  "SynapseDedicatedSqlMinimalTlsSettingListResult",
  "csharp"
);
@@clientName(
  SqlPools.DedicatedSQLMinimalTlsSettingsName,
  "SynapseDedicatedSqlMinimalTlsSettingName",
  "csharp"
);
@@clientName(
  BigDataPools.BigDataPoolResourceInfo,
  "SynapseBigDataPoolInfo",
  "csharp"
);
@@clientName(
  BigDataPools.BigDataPoolResourceInfoListResult,
  "SynapseBigDataPoolInfoListResult",
  "csharp"
);
@@clientName(
  IntegrationRuntimes.IntegrationRuntimeResource,
  "SynapseIntegrationRuntime",
  "csharp"
);
@@clientName(BigDataPools.LibraryResource, "SynapseLibrary", "csharp");
@@clientName(
  Workspaces.ManagedIdentitySqlControlSettingsModel,
  "SynapseManagedIdentitySqlControlSetting",
  "csharp"
);
@@clientName(
  Workspaces.ManagedIdentitySqlControlSettingsModelPropertiesGrantSqlControlToManagedIdentity,
  "SynapseGrantSqlControlToManagedIdentity",
  "csharp"
);
@@clientName(
  BigDataPools.SparkConfigurationResource,
  "SynapseSparkConfiguration",
  "csharp"
);
@@clientName(
  BigDataPools.ConfigurationType,
  "SynapseSparkConfigurationType",
  "csharp"
);
@@clientName(
  Workspaces.ActualState,
  "SynapseGrantSqlControlToManagedIdentityState",
  "csharp"
);
@@clientName(KustoPools.AzureCapacity, "SynapseDataSourceCapacity", "csharp");
@@clientName(KustoPools.AzureScaleType, "SynapseDataSourceScaleType", "csharp");
@@clientName(KustoPools.AzureSku, "SynapseDataSourceSku", "csharp");
@@clientName(
  KustoPools.AzureResourceSku,
  "SynapseDataSourceResourceSku",
  "csharp"
);
@@clientName(
  BigDataPools.AutoPauseProperties,
  "BigDataPoolAutoPauseProperties",
  "csharp"
);
@@clientName(
  BigDataPools.AutoScaleProperties,
  "BigDataPoolAutoScaleProperties",
  "csharp"
);
@@clientName(
  KustoPools.CheckNameResult,
  "KustoPoolNameAvailabilityResult",
  "csharp"
);
@@clientName(KustoPools.Reason, "KustoPoolNameUnavailableReason", "csharp");
@@clientName(
  KustoPools.DataConnectionCheckNameRequest,
  "KustoPoolDataConnectionNameAvailabilityContent",
  "csharp"
);
@@clientName(
  KustoPools.DatabasePrincipalAssignmentCheckNameRequest,
  "KustoPoolDatabasePrincipalAssignmentNameAvailabilityContent",
  "csharp"
);
@@clientName(
  KustoPools.DatabaseCheckNameRequest,
  "KustoPoolChildResourceNameAvailabilityContent",
  "csharp"
);
@@clientName(
  KustoPools.ClusterPrincipalAssignmentCheckNameRequest,
  "KustoPoolPrincipalAssignmentNameAvailabilityContent",
  "csharp"
);
@@clientName(
  KustoPools.KustoPoolCheckNameRequest,
  "KustoPoolNameAvailabilityContent",
  "csharp"
);
@@clientName(
  SqlPools.ConnectionPolicyName,
  "SqlPoolConnectionPolicyName",
  "csharp"
);
@@clientName(SqlPools.CreateMode, "SqlPoolCreateMode", "csharp");
@@clientName(
  SqlPools.CreateSqlPoolRestorePointDefinition,
  "SqlPoolCreateRestorePointContent",
  "csharp"
);
@@clientName(
  Workspaces.CustomerManagedKeyDetails,
  "WorkspaceCustomerManagedKeyDetails",
  "csharp"
);
@@clientName(
  IntegrationRuntimes.IntegrationRuntime,
  "SynapseIntegrationRuntimeProperties",
  "csharp"
);
@@clientName(KustoPools.Compression, "KustoPoolCompressionType", "csharp");
@@clientName(
  IntegrationRuntimes.IntegrationRuntimeMonitoringData,
  "SynapseIntegrationRuntimeMonitoringResult",
  "csharp"
);
@@clientName(
  IntegrationRuntimes.IntegrationRuntimeNodeMonitoringData,
  "SynapseIntegrationRuntimeNodeMonitoringResult",
  "csharp"
);
@@clientName(SqlPools.ColumnDataType, "SqlPoolColumnDataType", "csharp");
@@clientName(
  IntegrationRuntimes.IntegrationRuntimeListResponse,
  "SynapseIntegrationRuntimeListResult",
  "csharp"
);
@@clientName(
  IntegrationRuntimes.IntegrationRuntimeOutboundNetworkDependenciesEndpointsResponse,
  "SynapseIntegrationRuntimeOutboundNetworkDependenciesCategoryEndpointListResult",
  "csharp"
);
@@clientName(
  IntegrationRuntimes.IntegrationRuntimeStatusResponse,
  "SynapseIntegrationRuntimeStatusResult",
  "csharp"
);
@@clientName(
  IntegrationRuntimes.IntegrationRuntimeVNetProperties,
  "SynapseIntegrationRuntimeVnetProperties",
  "csharp"
);
@@clientName(BigDataPools.LibraryInfo, "BigDataPoolLibraryInfo", "csharp");
@@clientName(
  BigDataPools.LibraryListResponse,
  "BigDataPoolLibraryListResult",
  "csharp"
);
@@clientName(
  BigDataPools.LibraryRequirements,
  "BigDataPoolLibraryRequirements",
  "csharp"
);
@@clientName(
  KustoPools.ListResourceSkusResult,
  "SynapseDataSourceResourceSkuListResult",
  "csharp"
);
@@clientName(
  SqlPools.ListSqlPoolSecurityAlertPolicies,
  "SynapseSqlPoolSecurityAlertPolicyListResult",
  "csharp"
);
@@clientName(BigDataPools.NodeSize, "BigDataPoolNodeSize", "csharp");
@@clientName(
  BigDataPools.NodeSizeFamily,
  "BigDataPoolNodeSizeFamily",
  "csharp"
);
@@clientName(
  Workspaces.PrivateEndpointConnectionList,
  "SynapsePrivateEndpointConnectionListResult",
  "csharp"
);
@@clientName(
  Workspaces.PrivateLinkHubInfoListResult,
  "SynapsePrivateLinkHubListResult",
  "csharp"
);
@@clientName(
  SqlPools.RecommendedSensitivityLabelUpdateList,
  "SynapseRecommendedSensitivityLabelUpdateOperationListResult",
  "csharp"
);
@@clientName(
  SqlPools.RecoverableSqlPoolListResult,
  "SynapseRecoverableSqlPoolListResult",
  "csharp"
);
@@clientName(
  Workspaces.ReplaceAllFirewallRulesOperationResponse,
  "ReplaceAllFirewallRulesOperationResult",
  "csharp"
);
@@clientName(
  SqlPools.ReplicationLinkListResult,
  "SynapseReplicationLinkListResult",
  "csharp"
);
@@clientName(
  Workspaces.RestorableDroppedSqlPoolListResult,
  "SynapseRestorableDroppedSqlPoolListResult",
  "csharp"
);
@@clientName(
  SqlPools.RestorePointListResult,
  "SynapseRestorePointListResult",
  "csharp"
);
@@clientName(
  SqlPools.SensitivityLabelListResult,
  "SynapseSensitivityLabelListResult",
  "csharp"
);
@@clientName(
  SqlPools.SensitivityLabelUpdateList,
  "SynapseSensitivityLabelUpdateListResult",
  "csharp"
);
@@clientName(
  SqlPools.ServerBlobAuditingPolicyListResult,
  "SynapseServerBlobAuditingPolicyListResult",
  "csharp"
);
@@clientName(
  SqlPools.ServerSecurityAlertPolicyListResult,
  "SynapseServerSecurityAlertPolicyListResult",
  "csharp"
);
@@clientName(
  SqlPools.ServerUsageListResult,
  "SynapseServerUsageListResult",
  "csharp"
);
@@clientName(
  SqlPools.ServerVulnerabilityAssessmentListResult,
  "SynapseServerVulnerabilityAssessmentListResult",
  "csharp"
);
@@clientName(KustoPools.SkuDescription, "KustoPoolSkuDescription", "csharp");
@@clientName(
  KustoPools.SkuDescriptionList,
  "KustoPoolSkuDescriptionListResult",
  "csharp"
);
@@clientName(
  KustoPools.SkuLocationInfoItem,
  "KustoPoolSkuLocationInfoItem",
  "csharp"
);
@@clientName(KustoPools.SkuSize, "KustoPoolSkuSize", "csharp");
@@clientName(
  BigDataPools.SparkConfigProperties,
  "BigDataPoolSparkConfigProperties",
  "csharp"
);
@@clientName(
  BigDataPools.SparkConfigurationListResponse,
  "SynapseSparkConfigurationListResult",
  "csharp"
);
@@clientName(
  IntegrationRuntimes.SsisObjectMetadataStatusResponse,
  "SynapseSsisObjectMetadataStatusResult",
  "csharp"
);
@@clientName(KustoPools.State, "KustoPoolState", "csharp");
@@clientName(Workspaces.StateValue, "AadAuthenticationState", "csharp");
@@clientName(
  SqlPools.StorageAccountType,
  "SqlPoolStorageAccountType",
  "csharp"
);
@@clientName(
  IntegrationRuntimes.SsisObjectMetadataListResponse,
  "SynapseSsisObjectMetadataListResult",
  "csharp"
);
@@clientName(
  Workspaces.WorkspaceInfoListResult,
  "SynapseWorkspaceListResult",
  "csharp"
);
@@clientName(
  SqlPools.MaintenanceWindowTimeRange.startTime,
  "StartOn",
  "csharp"
);
@@clientName(BigDataPools.AutoPauseProperties.enabled, "IsEnabled", "csharp");
@@clientName(
  KustoPools.CheckNameResult.nameAvailable,
  "IsNameAvailable",
  "csharp"
);
@@clientName(
  SqlPools.ColumnDataType.uniqueidentifier,
  "UniqueIdentifier",
  "csharp"
);
@@clientName(SqlPools.ColumnDataType.datetime2, "DateTime2", "csharp");
@@clientName(
  SqlPools.ColumnDataType.datetimeoffset,
  "DateTimeOffset",
  "csharp"
);
@@clientName(SqlPools.ColumnDataType.tinyint, "TinyInt", "csharp");
@@clientName(SqlPools.ColumnDataType.smallint, "SmallInt", "csharp");
@@clientName(SqlPools.ColumnDataType.smalldatetime, "SmallDateTime", "csharp");
@@clientName(SqlPools.ColumnDataType.datetime, "DateTime", "csharp");
@@clientName(SqlPools.ColumnDataType.smallmoney, "SmallMoney", "csharp");
@@clientName(SqlPools.ColumnDataType.bigint, "BigInt", "csharp");
@@clientName(
  BigDataPools.LibraryInfo.uploadedTimestamp,
  "UploadedOn",
  "csharp"
);
@@clientName(
  Workspaces.ManagedVirtualNetworkSettings.linkedAccessCheckOnTargetResource,
  "EnableLinkedAccessCheckOnTargetResource",
  "csharp"
);
@@clientName(BigDataPools.AutoScaleProperties.enabled, "IsEnabled", "csharp");
@@clientName(SqlPools.ReplicationState.CATCH_UP, "CatchUp", "csharp");
@@clientName(
  Workspaces.AzureADOnlyAuthenticationProperties.azureADOnlyAuthentication,
  "IsAadOnlyAuthenticationEnabled",
  "csharp"
);
@@clientName(
  BigDataPools.BigDataPoolResourceProperties.sessionLevelPackagesEnabled,
  "IsSessionLevelPackagesEnabled",
  "csharp"
);
@@clientName(
  SqlPools.ServerSecurityAlertPolicyProperties.emailAccountAdmins,
  "EnableEmailToAccountAdmins",
  "csharp"
);
@@clientName(
  SqlPools.SecurityAlertPolicyProperties.emailAccountAdmins,
  "EnableEmailToAccountAdmins",
  "csharp"
);
@@clientName(
  Workspaces.WorkspaceProperties.azureADOnlyAuthentication,
  "IsAadOnlyAuthenticationEnabled",
  "csharp"
);
@@clientName(
  Workspaces.WorkspaceProperties.trustedServiceBypassEnabled,
  "IsTrustedServiceBypassEnabled",
  "csharp"
);
@@clientName(
  BigDataPools.DynamicExecutorAllocation.enabled,
  "IsEnabled",
  "csharp"
);
@@clientName(
  Workspaces.EncryptionDetails.doubleEncryptionEnabled,
  "IsDoubleEncryptionEnabled",
  "csharp"
);
@@clientName(
  IntegrationRuntimes.SsisParameter.required,
  "IsRequired",
  "csharp"
);
@@clientName(
  IntegrationRuntimes.SsisParameter.sensitive,
  "IsSensitive",
  "csharp"
);
@@clientName(
  IntegrationRuntimes.SsisVariable.sensitive,
  "IsSensitive",
  "csharp"
);
@@clientName(
  SqlPools.VulnerabilityAssessmentRecurringScansProperties.emailSubscriptionAdmins,
  "EnableEmailToAccountAdmins",
  "csharp"
);
@@alternateType(
  Workspaces.DataLakeStorageAccountDetails.resourceId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(
  IntegrationRuntimes.LinkedIntegrationRuntimeRbacAuthorization.resourceId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@clientName(BigDataPools.LibraryRequirements.time, "UpdatedOn", "csharp");
@@clientName(BigDataPools.SparkConfigProperties.time, "UpdatedOn", "csharp");
@@alternateType(
  Workspaces.CspWorkspaceAdminProperties.initialWorkspaceAdminObjectId,
  Azure.Core.uuid,
  "csharp"
);
@@clientName(
  Workspaces.KekIdentityProperties.userAssignedIdentity,
  "UserAssignedIdentityId",
  "csharp"
);
@@alternateType(
  Workspaces.KekIdentityProperties.userAssignedIdentity,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(
  KustoPools.SkuDescription.locations,
  Azure.Core.azureLocation[],
  "csharp"
);
@@alternateType(
  Workspaces.PurviewConfiguration.purviewResourceId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@clientName(SqlPools.DataMaskingFunction.CCN, "Ccn", "csharp");
@@clientName(SqlPools.DataMaskingFunction.SSN, "Ssn", "csharp");
@@alternateType(
  KustoPools.EventGridConnectionProperties.storageAccountResourceId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(
  KustoPools.EventGridConnectionProperties.eventHubResourceId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(
  KustoPools.EventHubConnectionProperties.eventHubResourceId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(
  KustoPools.EventHubConnectionProperties.managedIdentityResourceId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(
  KustoPools.FollowerDatabaseDefinition.clusterResourceId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@clientName(
  IntegrationRuntimes.IntegrationRuntimeComputeProperties.vNetProperties,
  "VnetProperties",
  "csharp"
);
@@alternateType(
  IntegrationRuntimes.IntegrationRuntimeConnectionInfo.identityCertThumbprint,
  unknown,
  "csharp"
);
@@alternateType(
  IntegrationRuntimes.IntegrationRuntimeSsisCatalogInfo.catalogServerEndpoint,
  url,
  "csharp"
);
@@clientName(
  IntegrationRuntimes.IntegrationRuntimeVNetProperties.vNetId,
  "VnetId",
  "csharp"
);
@@alternateType(
  IntegrationRuntimes.IntegrationRuntimeVNetProperties.vNetId,
  Azure.Core.uuid,
  "csharp"
);
@@alternateType(
  IntegrationRuntimes.IntegrationRuntimeVNetProperties.subnetId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(
  KustoPools.IotHubConnectionProperties.iotHubResourceId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@clientName(
  IntegrationRuntimes.SelfHostedIntegrationRuntimeNode.lastConnectTime,
  "LastConnectedOn",
  "csharp"
);
@@clientName(
  IntegrationRuntimes.SelfHostedIntegrationRuntimeNode.expiryTime,
  "ExpireOn",
  "csharp"
);
@@clientName(
  IntegrationRuntimes.SelfHostedIntegrationRuntimeNode.lastStartTime,
  "LastStartedOn",
  "csharp"
);
@@alternateType(
  KustoPools.AttachedDatabaseConfigurationProperties.clusterResourceId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@clientName(
  BigDataPools.BigDataPoolResourceProperties.lastSucceededTimestamp,
  "LastSucceededOn",
  "csharp"
);
@@alternateType(
  KustoPools.ClusterPrincipalProperties.aadObjectId,
  Azure.Core.uuid,
  "csharp"
);
@@alternateType(
  KustoPools.DatabasePrincipalProperties.aadObjectId,
  Azure.Core.uuid,
  "csharp"
);
@@clientName(SqlPools.DataMaskingRuleProperties.id, "ruleId", "csharp");
@@alternateType(
  SqlPools.EncryptionProtectorProperties.thumbprint,
  unknown,
  "csharp"
);
@@clientName(Workspaces.KeyProperties.isActiveCMK, "IsActiveCmk", "csharp");
@@clientName(
  KustoPools.KustoPoolProperties.workspaceUID,
  "WorkspaceUid",
  "csharp"
);
@@alternateType(
  KustoPools.KustoPoolProperties.workspaceUID,
  Azure.Core.uuid,
  "csharp"
);
@@alternateType(
  SqlPools.ReplicationLinkProperties.partnerLocation,
  Azure.Core.azureLocation,
  "csharp"
);
@@alternateType(
  SqlPools.SensitivityLabelProperties.labelId,
  Azure.Core.uuid,
  "csharp"
);
@@alternateType(
  SqlPools.SensitivityLabelProperties.informationTypeId,
  Azure.Core.uuid,
  "csharp"
);
@@clientName(
  BigDataPools.SparkConfigurationInfo.created,
  "CreatedOn",
  "csharp"
);
@@clientName(
  Workspaces.WorkspaceProperties.workspaceUID,
  "WorkspaceUid",
  "csharp"
);
@@alternateType(
  Workspaces.WorkspaceProperties.workspaceUID,
  Azure.Core.uuid,
  "csharp"
);
@@alternateType(
  Workspaces.WorkspaceProperties.adlaResourceId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@clientName(
  KustoPools.PrivateLinkResources,
  "SynapseKustoPoolPrivateLinkList",
  "csharp"
);
@@clientName(
  KustoPools.KustoPoolPrivateLinkResources,
  "SynapseKustoPoolPrivateLinkData",
  "csharp"
);
@@clientName(
  IntegrationRuntimes.IntegrationRuntimeStatus.type,
  "RuntimeType",
  "csharp"
);
@@clientName(
  IntegrationRuntimes.EntityReference.type,
  "IntegrationRuntimeEntityReferenceType",
  "csharp"
);

// prepend-rp-prefix (Synapse)
@@clientName(
  KustoPools.AttachedDatabaseConfiguration,
  "SynapseAttachedDatabaseConfiguration",
  "csharp"
);
@@clientName(
  KustoPools.AttachedDatabaseConfigurationListResult,
  "SynapseAttachedDatabaseConfigurationListResult",
  "csharp"
);
@@clientName(
  KustoPools.ClusterPrincipalAssignment,
  "SynapseClusterPrincipalAssignment",
  "csharp"
);
@@clientName(
  KustoPools.ClusterPrincipalAssignmentListResult,
  "SynapseClusterPrincipalAssignmentListResult",
  "csharp"
);
@@clientName(
  KustoPools.ClusterPrincipalRole,
  "SynapseClusterPrincipalRole",
  "csharp"
);
@@clientName(KustoPools.Database, "SynapseDatabase", "csharp");
@@clientName(
  KustoPools.DatabaseListResult,
  "SynapseDatabaseListResult",
  "csharp"
);
@@clientName(
  KustoPools.DatabasePrincipalAssignment,
  "SynapseDatabasePrincipalAssignment",
  "csharp"
);
@@clientName(
  KustoPools.DatabasePrincipalAssignmentListResult,
  "SynapseDatabasePrincipalAssignmentListResult",
  "csharp"
);
@@clientName(KustoPools.DataConnection, "SynapseDataConnection", "csharp");
@@clientName(SqlPools.DataMaskingPolicy, "SynapseDataMaskingPolicy", "csharp");
@@clientName(SqlPools.DataMaskingRule, "SynapseDataMaskingRule", "csharp");
@@clientName(
  SqlPools.DataMaskingRuleListResult,
  "SynapseDataMaskingRuleListResult",
  "csharp"
);
@@clientName(
  SqlPools.DataWarehouseUserActivities,
  "SynapseDataWarehouseUserActivity",
  "csharp"
);
@@clientName(
  SqlPools.EncryptionProtector,
  "SynapseEncryptionProtector",
  "csharp"
);
@@clientName(
  SqlPools.EncryptionProtectorListResult,
  "SynapseEncryptionProtectorListResult",
  "csharp"
);
@@clientName(
  SqlPools.ExtendedServerBlobAuditingPolicy,
  "SynapseExtendedServerBlobAuditingPolicy",
  "csharp"
);
@@clientName(
  SqlPools.ExtendedServerBlobAuditingPolicyListResult,
  "SynapseExtendedServerBlobAuditingPolicyListResult",
  "csharp"
);
@@clientName(
  SqlPools.ExtendedSqlPoolBlobAuditingPolicy,
  "SynapseExtendedSqlPoolBlobAuditingPolicy",
  "csharp"
);
@@clientName(
  SqlPools.ExtendedSqlPoolBlobAuditingPolicyListResult,
  "SynapseExtendedSqlPoolBlobAuditingPolicyListResult",
  "csharp"
);
@@clientName(SqlPools.GeoBackupPolicy, "SynapseGeoBackupPolicy", "csharp");
@@clientName(
  SqlPools.GeoBackupPolicyListResult,
  "SynapseGeoBackupPolicyListResult",
  "csharp"
);
@@clientName(
  Workspaces.IpFirewallRuleInfo,
  "SynapseIPFirewallRuleInfo",
  "csharp"
);
@@clientName(Workspaces.Key, "SynapseKey", "csharp");
@@clientName(KustoPools.KustoPool, "SynapseKustoPool", "csharp");
@@clientName(SqlPools.MaintenanceWindows, "SynapseMaintenanceWindow", "csharp");
@@clientName(
  SqlPools.MaintenanceWindowOptions,
  "SynapseMaintenanceWindowOption",
  "csharp"
);
@@clientName(
  Workspaces.PrivateEndpointConnectionForPrivateLinkHub,
  "SynapsePrivateEndpointConnectionForPrivateLinkHub",
  "csharp"
);
@@clientName(Workspaces.PrivateLinkHub, "SynapsePrivateLinkHub", "csharp");
@@clientName(
  SqlPools.RecoverableSqlPool,
  "SynapseRecoverableSqlPool",
  "csharp"
);
@@clientName(SqlPools.ReplicationLink, "SynapseReplicationLink", "csharp");
@@clientName(
  Workspaces.RestorableDroppedSqlPool,
  "SynapseRestorableDroppedSqlPool",
  "csharp"
);
@@clientName(SqlPools.RestorePoint, "SynapseRestorePoint", "csharp");
@@clientName(SqlPools.SensitivityLabel, "SynapseSensitivityLabel", "csharp");
@@clientName(
  SqlPools.ServerBlobAuditingPolicy,
  "SynapseServerBlobAuditingPolicy",
  "csharp"
);
@@clientName(
  SqlPools.ServerSecurityAlertPolicy,
  "SynapseServerSecurityAlertPolicy",
  "csharp"
);
@@clientName(
  SqlPools.ServerVulnerabilityAssessment,
  "SynapseServerVulnerabilityAssessment",
  "csharp"
);
@@clientName(SqlPools.SqlPool, "SynapseSqlPool", "csharp");
@@clientName(
  SqlPools.SqlPoolBlobAuditingPolicy,
  "SynapseSqlPoolBlobAuditingPolicy",
  "csharp"
);
@@clientName(
  SqlPools.SqlPoolBlobAuditingPolicyListResult,
  "SynapseSqlPoolBlobAuditingPolicyListResult",
  "csharp"
);
@@clientName(SqlPools.SqlPoolColumn, "SynapseSqlPoolColumn", "csharp");
@@clientName(
  SqlPools.SqlPoolConnectionPolicy,
  "SynapseSqlPoolConnectionPolicy",
  "csharp"
);
@@clientName(SqlPools.SqlPoolSchema, "SynapseSqlPoolSchema", "csharp");
@@clientName(
  SqlPools.SqlPoolSecurityAlertPolicy,
  "SynapseSqlPoolSecurityAlertPolicy",
  "csharp"
);
@@clientName(SqlPools.SqlPoolTable, "SynapseSqlPoolTable", "csharp");
@@clientName(
  SqlPools.SqlPoolVulnerabilityAssessment,
  "SynapseSqlPoolVulnerabilityAssessment",
  "csharp"
);
@@clientName(
  SqlPools.SqlPoolVulnerabilityAssessmentRuleBaseline,
  "SynapseSqlPoolVulnerabilityAssessmentRuleBaseline",
  "csharp"
);
@@clientName(
  SqlPools.TransparentDataEncryption,
  "SynapseTransparentDataEncryption",
  "csharp"
);
@@clientName(
  SqlPools.TransparentDataEncryptionListResult,
  "SynapseTransparentDataEncryptionListResult",
  "csharp"
);
@@clientName(
  SqlPools.TransparentDataEncryptionName,
  "SynapseTransparentDataEncryptionName",
  "csharp"
);
@@clientName(
  SqlPools.TransparentDataEncryptionStatus,
  "SynapseTransparentDataEncryptionStatus",
  "csharp"
);
@@clientName(
  SqlPools.VulnerabilityAssessmentScanRecord,
  "SynapseVulnerabilityAssessmentScanRecord",
  "csharp"
);
@@clientName(
  SqlPools.VulnerabilityAssessmentScanRecordListResult,
  "SynapseVulnerabilityAssessmentScanRecordListResult",
  "csharp"
);
@@clientName(
  SqlPools.WorkloadClassifier,
  "SynapseWorkloadClassifier",
  "csharp"
);
@@clientName(
  SqlPools.WorkloadClassifierListResult,
  "SynapseWorkloadClassifierListResult",
  "csharp"
);
@@clientName(SqlPools.WorkloadGroup, "SynapseWorkloadGroup", "csharp");
@@clientName(
  SqlPools.WorkloadGroupListResult,
  "SynapseWorkloadGroupListResult",
  "csharp"
);
@@clientName(
  Workspaces.WorkspaceAadAdminInfo,
  "SynapseWorkspaceAadAdminInfo",
  "csharp"
);
@@clientName(Workspaces.Workspace, "SynapseWorkspace", "csharp");
@@clientName(
  SqlPools.BlobAuditingPolicyName,
  "SynapseBlobAuditingPolicyName",
  "csharp"
);
@@clientName(
  SqlPools.BlobAuditingPolicyState,
  "SynapseBlobAuditingPolicyState",
  "csharp"
);
@@clientName(
  KustoPools.BlobStorageEventType,
  "SynapseBlobStorageEventType",
  "csharp"
);
@@clientName(IntegrationRuntimes.CmdkeySetup, "SynapseCmdkeySetup", "csharp");
@@clientName(
  IntegrationRuntimes.CustomSetupBase,
  "SynapseCustomSetupBase",
  "csharp"
);
@@clientName(
  IntegrationRuntimes.ComponentSetup,
  "SynapseComponentSetup",
  "csharp"
);
@@clientName(
  KustoPools.DatabasePrincipalRole,
  "SynapseDatabasePrincipalRole",
  "csharp"
);
@@clientName(
  KustoPools.DataConnectionKind,
  "SynapseDataConnectionKind",
  "csharp"
);
@@clientName(
  KustoPools.DataConnectionListResult,
  "SynapseDataConnectionListResult",
  "csharp"
);
@@clientName(
  KustoPools.DataConnectionValidation,
  "SynapseDataConnectionValidation",
  "csharp"
);
@@clientName(
  KustoPools.DataConnectionValidationListResult,
  "SynapseDataConnectionValidationListResult",
  "csharp"
);
@@clientName(
  KustoPools.DataConnectionValidationResult,
  "SynapseDataConnectionValidationResult",
  "csharp"
);
@@clientName(
  IntegrationRuntimes.DataFlowComputeType,
  "SynapseDataFlowComputeType",
  "csharp"
);
@@clientName(
  Workspaces.DataLakeStorageAccountDetails,
  "SynapseDataLakeStorageAccountDetails",
  "csharp"
);
@@clientName(
  SqlPools.DataMaskingFunction,
  "SynapseDataMaskingFunction",
  "csharp"
);
@@clientName(
  SqlPools.DataMaskingRuleState,
  "SynapseDataMaskingRuleState",
  "csharp"
);
@@clientName(SqlPools.DataMaskingState, "SynapseDataMaskingState", "csharp");
@@clientName(
  SqlPools.DataWarehouseUserActivityName,
  "SynapseDataWarehouseUserActivityName",
  "csharp"
);
@@clientName(SqlPools.DayOfWeek, "SynapseDayOfWeek", "csharp");
@@clientName(
  KustoPools.DefaultPrincipalsModificationKind,
  "SynapseDefaultPrincipalsModificationKind",
  "csharp"
);
@@clientName(Workspaces.DesiredState, "SynapseDesiredState", "csharp");
@@clientName(
  BigDataPools.DynamicExecutorAllocation,
  "SynapseDynamicExecutorAllocation",
  "csharp"
);
@@clientName(
  Workspaces.EncryptionDetails,
  "SynapseEncryptionDetails",
  "csharp"
);
@@clientName(
  SqlPools.EncryptionProtectorName,
  "SynapseEncryptionProtectorName",
  "csharp"
);
@@clientName(
  IntegrationRuntimes.EntityReference,
  "SynapseEntityReference",
  "csharp"
);
@@clientName(
  IntegrationRuntimes.EnvironmentVariableSetup,
  "SynapseEnvironmentVariableSetup",
  "csharp"
);
@@clientName(
  KustoPools.EventGridDataConnection,
  "SynapseEventGridDataConnection",
  "csharp"
);
@@clientName(
  KustoPools.EventGridDataFormat,
  "SynapseEventGridDataFormat",
  "csharp"
);
@@clientName(
  KustoPools.EventHubDataConnection,
  "SynapseEventHubDataConnection",
  "csharp"
);
@@clientName(
  KustoPools.EventHubDataFormat,
  "SynapseEventHubDataFormat",
  "csharp"
);
@@clientName(
  KustoPools.FollowerDatabaseDefinition,
  "SynapseFollowerDatabaseDefinition",
  "csharp"
);
@@clientName(
  KustoPools.FollowerDatabaseListResult,
  "SynapseFollowerDatabaseListResult",
  "csharp"
);
@@clientName(
  SqlPools.GeoBackupPolicyName,
  "SynapseGeoBackupPolicyName",
  "csharp"
);
@@clientName(
  SqlPools.GeoBackupPolicyState,
  "SynapseGeoBackupPolicyState",
  "csharp"
);
@@clientName(
  IntegrationRuntimes.GetSsisObjectMetadataRequest,
  "SynapseGetSsisObjectMetadataContent",
  "csharp"
);
@@clientName(
  IntegrationRuntimes.IntegrationRuntimeAuthKeyName,
  "SynapseIntegrationRuntimeAuthKeyName",
  "csharp"
);
@@clientName(
  IntegrationRuntimes.IntegrationRuntimeAuthKeys,
  "SynapseIntegrationRuntimeAuthKeys",
  "csharp"
);
@@clientName(
  IntegrationRuntimes.IntegrationRuntimeAutoUpdate,
  "SynapseIntegrationRuntimeAutoUpdate",
  "csharp"
);
@@clientName(
  IntegrationRuntimes.IntegrationRuntimeComputeProperties,
  "SynapseIntegrationRuntimeComputeProperties",
  "csharp"
);
@@clientName(
  IntegrationRuntimes.IntegrationRuntimeConnectionInfo,
  "SynapseIntegrationRuntimeConnectionInfo",
  "csharp"
);
@@clientName(
  IntegrationRuntimes.IntegrationRuntimeCustomSetupScriptProperties,
  "SynapseIntegrationRuntimeCustomSetupScriptProperties",
  "csharp"
);
@@clientName(
  IntegrationRuntimes.IntegrationRuntimeDataFlowProperties,
  "SynapseIntegrationRuntimeDataFlowProperties",
  "csharp"
);
@@clientName(
  IntegrationRuntimes.IntegrationRuntimeDataProxyProperties,
  "SynapseIntegrationRuntimeDataProxyProperties",
  "csharp"
);
@@clientName(
  IntegrationRuntimes.IntegrationRuntimeEdition,
  "SynapseIntegrationRuntimeEdition",
  "csharp"
);
@@clientName(
  IntegrationRuntimes.IntegrationRuntimeEntityReferenceType,
  "SynapseIntegrationRuntimeEntityReferenceType",
  "csharp"
);
@@clientName(
  IntegrationRuntimes.IntegrationRuntimeInternalChannelEncryptionMode,
  "SynapseIntegrationRuntimeInternalChannelEncryptionMode",
  "csharp"
);
@@clientName(
  IntegrationRuntimes.IntegrationRuntimeLicenseType,
  "SynapseIntegrationRuntimeLicenseType",
  "csharp"
);
@@clientName(
  IntegrationRuntimes.IntegrationRuntimeNodeIpAddress,
  "SynapseIntegrationRuntimeNodeIPAddress",
  "csharp"
);
@@clientName(
  IntegrationRuntimes.IntegrationRuntimeOutboundNetworkDependenciesCategoryEndpoint,
  "SynapseIntegrationRuntimeOutboundNetworkDependenciesCategoryEndpoint",
  "csharp"
);
@@clientName(
  IntegrationRuntimes.IntegrationRuntimeOutboundNetworkDependenciesEndpoint,
  "SynapseIntegrationRuntimeOutboundNetworkDependenciesEndpoint",
  "csharp"
);
@@clientName(
  IntegrationRuntimes.IntegrationRuntimeOutboundNetworkDependenciesEndpointDetails,
  "SynapseIntegrationRuntimeOutboundNetworkDependenciesEndpointDetails",
  "csharp"
);
@@clientName(
  IntegrationRuntimes.IntegrationRuntimeSsisCatalogInfo,
  "SynapseIntegrationRuntimeSsisCatalogInfo",
  "csharp"
);
@@clientName(
  IntegrationRuntimes.IntegrationRuntimeSsisCatalogPricingTier,
  "SynapseIntegrationRuntimeSsisCatalogPricingTier",
  "csharp"
);
@@clientName(
  IntegrationRuntimes.IntegrationRuntimeSsisProperties,
  "SynapseIntegrationRuntimeSsisProperties",
  "csharp"
);
@@clientName(
  IntegrationRuntimes.IntegrationRuntimeState,
  "SynapseIntegrationRuntimeState",
  "csharp"
);
@@clientName(
  IntegrationRuntimes.IntegrationRuntimeStatus,
  "SynapseIntegrationRuntimeStatus",
  "csharp"
);
@@clientName(
  IntegrationRuntimes.IntegrationRuntimeUpdateResult,
  "SynapseIntegrationRuntimeUpdateResult",
  "csharp"
);
@@clientName(
  KustoPools.IotHubDataConnection,
  "SynapseIotHubDataConnection",
  "csharp"
);
@@clientName(KustoPools.IotHubDataFormat, "SynapseIotHubDataFormat", "csharp");
@@clientName(
  Workspaces.IpFirewallRuleInfoListResult,
  "SynapseIpFirewallRuleInfoListResult",
  "csharp"
);
@@clientName(
  Workspaces.IpFirewallRuleProperties,
  "SynapseIPFirewallRuleProperties",
  "csharp"
);
@@clientName(
  KustoPools.LanguageExtension,
  "SynapseLanguageExtension",
  "csharp"
);
@@clientName(
  KustoPools.LanguageExtensionName,
  "SynapseLanguageExtensionName",
  "csharp"
);
@@clientName(
  KustoPools.LanguageExtensionsList,
  "SynapseLanguageExtensionsList",
  "csharp"
);
@@clientName(
  IntegrationRuntimes.LinkedIntegrationRuntime,
  "SynapseLinkedIntegrationRuntime",
  "csharp"
);
@@clientName(
  IntegrationRuntimes.LinkedIntegrationRuntimeKeyAuthorization,
  "SynapseLinkedIntegrationRuntimeKeyAuthorization",
  "csharp"
);
@@clientName(
  IntegrationRuntimes.LinkedIntegrationRuntimeRbacAuthorization,
  "SynapseLinkedIntegrationRuntimeRbacAuthorization",
  "csharp"
);
@@clientName(
  IntegrationRuntimes.LinkedIntegrationRuntimeType,
  "SynapseLinkedIntegrationRuntimeType",
  "csharp"
);
@@clientName(
  SqlPools.MaintenanceWindowTimeRange,
  "SynapseMaintenanceWindowTimeRange",
  "csharp"
);
@@clientName(
  IntegrationRuntimes.ManagedIntegrationRuntime,
  "SynapseManagedIntegrationRuntime",
  "csharp"
);
@@clientName(
  IntegrationRuntimes.ManagedIntegrationRuntimeError,
  "SynapseManagedIntegrationRuntimeError",
  "csharp"
);
@@clientName(
  IntegrationRuntimes.ManagedIntegrationRuntimeNode,
  "SynapseManagedIntegrationRuntimeNode",
  "csharp"
);
@@clientName(
  IntegrationRuntimes.ManagedIntegrationRuntimeNodeStatus,
  "SynapseManagedIntegrationRuntimeNodeStatus",
  "csharp"
);
@@clientName(
  IntegrationRuntimes.ManagedIntegrationRuntimeOperationResult,
  "SynapseManagedIntegrationRuntimeOperationResult",
  "csharp"
);
@@clientName(
  IntegrationRuntimes.ManagedIntegrationRuntimeStatus,
  "SynapseManagedIntegrationRuntimeStatus",
  "csharp"
);
@@clientName(
  Workspaces.ManagedVirtualNetworkSettings,
  "SynapseManagedVirtualNetworkSettings",
  "csharp"
);
@@clientName(
  SqlPools.ManagementOperationState,
  "SynapseManagementOperationState",
  "csharp"
);
@@clientName(
  KustoPools.OptimizedAutoscale,
  "SynapseOptimizedAutoscale",
  "csharp"
);
@@clientName(
  KustoPools.PrincipalsModificationKind,
  "SynapsePrincipalsModificationKind",
  "csharp"
);
@@clientName(KustoPools.PrincipalType, "SynapsePrincipalType", "csharp");
@@clientName(
  Workspaces.PrivateEndpointConnectionProperties,
  "SynapsePrivateEndpointConnectionProperties",
  "csharp"
);
@@clientName(
  Workspaces.ProvisioningState,
  "SynapseProvisioningState",
  "csharp"
);
@@clientName(
  KustoPools.ReadOnlyFollowingDatabase,
  "SynapseReadOnlyFollowingDatabase",
  "csharp"
);
@@clientName(
  KustoPools.ReadWriteDatabase,
  "SynapseReadWriteDatabase",
  "csharp"
);
@@clientName(
  SqlPools.RecommendedSensitivityLabelUpdate,
  "SynapseRecommendedSensitivityLabelUpdate",
  "csharp"
);
@@clientName(
  SqlPools.RecommendedSensitivityLabelUpdateKind,
  "SynapseRecommendedSensitivityLabelUpdateKind",
  "csharp"
);
@@clientName(SqlPools.ReplicationRole, "SynapseReplicationRole", "csharp");
@@clientName(SqlPools.ReplicationState, "SynapseReplicationState", "csharp");
@@clientName(SqlPools.RestorePointType, "SynapseRestorePointType", "csharp");
@@clientName(IntegrationRuntimes.SecretBase, "SynapseSecretBase", "csharp");
@@clientName(IntegrationRuntimes.SecureString, "SynapseSecureString", "csharp");
@@clientName(
  SqlPools.SecurityAlertPolicyState,
  "SynapseSecurityAlertPolicyState",
  "csharp"
);
@@clientName(
  IntegrationRuntimes.SelfHostedIntegrationRuntime,
  "SynapseSelfHostedIntegrationRuntime",
  "csharp"
);
@@clientName(
  IntegrationRuntimes.SelfHostedIntegrationRuntimeNode,
  "SynapseSelfHostedIntegrationRuntimeNode",
  "csharp"
);
@@clientName(
  IntegrationRuntimes.SelfHostedIntegrationRuntimeNodeStatus,
  "SynapseSelfHostedIntegrationRuntimeNodeStatus",
  "csharp"
);
@@clientName(
  IntegrationRuntimes.SelfHostedIntegrationRuntimeStatus,
  "SynapseSelfHostedIntegrationRuntimeStatus",
  "csharp"
);
@@clientName(
  SqlPools.SensitivityLabelRank,
  "SynapseSensitivityLabelRank",
  "csharp"
);
@@clientName(
  SqlPools.SensitivityLabelSource,
  "SynapseSensitivityLabelSource",
  "csharp"
);
@@clientName(
  SqlPools.SensitivityLabelUpdate,
  "SynapseSensitivityLabelUpdate",
  "csharp"
);
@@clientName(
  SqlPools.SensitivityLabelUpdateKind,
  "SynapseSensitivityLabelUpdateKind",
  "csharp"
);
@@clientName(SqlPools.ServerKeyType, "SynapseServerKeyType", "csharp");
@@clientName(SqlPools.ServerUsage, "SynapseServerUsage", "csharp");
@@clientName(
  IntegrationRuntimes.SsisEnvironment,
  "SynapseSsisEnvironment",
  "csharp"
);
@@clientName(
  IntegrationRuntimes.SsisEnvironmentReference,
  "SynapseSsisEnvironmentReference",
  "csharp"
);
@@clientName(IntegrationRuntimes.SsisFolder, "SynapseSsisFolder", "csharp");
@@clientName(
  IntegrationRuntimes.SsisObjectMetadata,
  "SynapseSsisObjectMetadata",
  "csharp"
);
@@clientName(
  IntegrationRuntimes.SsisObjectMetadataType,
  "SynapseSsisObjectMetadataType",
  "csharp"
);
@@clientName(IntegrationRuntimes.SsisPackage, "SynapseSsisPackage", "csharp");
@@clientName(
  IntegrationRuntimes.SsisParameter,
  "SynapseSsisParameter",
  "csharp"
);
@@clientName(IntegrationRuntimes.SsisProject, "SynapseSsisProject", "csharp");
@@clientName(IntegrationRuntimes.SsisVariable, "SynapseSsisVariable", "csharp");
@@clientName(
  KustoPools.TableLevelSharingProperties,
  "SynapseTableLevelSharingProperties",
  "csharp"
);
@@clientName(
  SqlPools.VulnerabilityAssessmentName,
  "SynapseVulnerabilityAssessmentName",
  "csharp"
);
@@clientName(
  SqlPools.VulnerabilityAssessmentPolicyBaselineName,
  "SynapseVulnerabilityAssessmentPolicyBaselineName",
  "csharp"
);
@@clientName(
  SqlPools.VulnerabilityAssessmentRecurringScansProperties,
  "SynapseVulnerabilityAssessmentRecurringScansProperties",
  "csharp"
);
@@clientName(
  SqlPools.VulnerabilityAssessmentScanError,
  "SynapseVulnerabilityAssessmentScanError",
  "csharp"
);
@@clientName(
  SqlPools.VulnerabilityAssessmentScanState,
  "SynapseVulnerabilityAssessmentScanState",
  "csharp"
);
@@clientName(
  SqlPools.VulnerabilityAssessmentScanTriggerType,
  "SynapseVulnerabilityAssessmentScanTriggerType",
  "csharp"
);
@@clientName(
  Workspaces.WorkspaceKeyDetails,
  "SynapseWorkspaceKeyDetails",
  "csharp"
);
@@clientName(
  Workspaces.WorkspaceRepositoryConfiguration,
  "SynapseWorkspaceRepositoryConfiguration",
  "csharp"
);

// override-operation-name
@@clientName(
  IntegrationRuntimes.IntegrationRuntimeResources.integrationRuntimeStatusGet,
  "GetIntegrationRuntimeStatus",
  "csharp"
);
@@clientName(
  KustoPools.Databases.checkNameAvailability,
  "CheckKustoPoolDataConnectionNameAvailability",
  "csharp"
);
@@clientName(
  KustoPools.Databases.kustoPoolDatabasePrincipalAssignmentsCheckNameAvailability,
  "CheckKustoPoolDatabasePrincipalAssignmentNameAvailability",
  "csharp"
);
@@clientName(
  KustoPools.KustoPools.checkNameAvailability,
  "CheckKustoPoolChildResourceNameAvailability",
  "csharp"
);
@@clientName(
  KustoPools.KustoPools.kustoPoolPrincipalAssignmentsCheckNameAvailability,
  "CheckKustoPoolPrincipalAssignmentNameAvailability",
  "csharp"
);
@@clientName(
  KustoPools.KustoPoolsOperationGroup.checkNameAvailability,
  "CheckKustoPoolNameAvailability",
  "csharp"
);
@@clientName(
  KustoPools.Databases.dataConnectionValidation,
  "ValidateDataConnection",
  "csharp"
);
@@clientName(
  IntegrationRuntimes.IntegrationRuntimeResources.integrationRuntimeNodeIpAddressGet,
  "GetIntegrationRuntimeNodeIPAddress",
  "csharp"
);
@@clientName(
  KustoPools.KustoPools.list,
  "GetAllKustoPoolPrivateLinkData",
  "csharp"
);

// directive remove-operation (not exposed in the released .NET SDK)
@@scope(
  IntegrationRuntimes.IntegrationRuntimeResources.integrationRuntimeStart,
  "!csharp"
);
@@scope(
  IntegrationRuntimes.IntegrationRuntimeResources.integrationRuntimeStop,
  "!csharp"
);
@@scope(
  IntegrationRuntimes.IntegrationRuntimeResources.integrationRuntimeEnableInteractivequery,
  "!csharp"
);
@@scope(Workspaces.Operations.list, "!csharp");
@@scope(Workspaces.Workspaces.getLocationHeaderResult, "!csharp");
@@scope(Workspaces.Workspaces.getAzureAsyncHeaderResult, "!csharp");
@@scope(KustoPools.KustoOperationsOperationGroup.list, "!csharp");
@@scope(SqlPools.SqlPools.list, "!csharp");
@@scope(SqlPools.SqlPoolOperationResults.getLocationHeaderResult, "!csharp");

// Names the GA autorest.md does not cover directly (input names differed, or new in TypeSpec).
@@clientName(
  Workspaces.PrivateEndpointConnectionForPrivateLinkHub_ResourceCollectionResponse,
  "SynapsePrivateEndpointConnectionForPrivateLinkHubListResult",
  "csharp"
);
@@clientName(
  IntegrationRuntimes.UpdateIntegrationRuntimeRequest,
  "SynapseIntegrationRuntimePatch",
  "csharp"
);
@@clientName(
  IntegrationRuntimes.UpdateIntegrationRuntimeNodeRequest,
  "UpdateIntegrationRuntimeNodeContent",
  "csharp"
);
@@clientName(
  Workspaces.ReplaceAllIpFirewallRulesRequest,
  "ReplaceAllIPFirewallRulesContent",
  "csharp"
);
@@clientName(
  Workspaces.DataLakeStorageAccountDetails.accountUrl,
  "AccountUri",
  "csharp"
);
@@clientName(
  Workspaces.WorkspaceKeyDetails.keyVaultUrl,
  "KeyVaultUri",
  "csharp"
);
@@clientName(Workspaces.KeyProperties.keyVaultUrl, "KeyVaultUri", "csharp");
@@clientName(
  Workspaces.CheckNameAvailabilityRequest,
  "SynapseNameAvailabilityContent",
  "csharp"
); // not shipped in .NET
@@clientName(
  Workspaces.CheckNameAvailabilityResponse,
  "SynapseNameAvailabilityResult",
  "csharp"
); // not shipped in .NET
@@clientName(
  SqlPools.SqlPoolNotFoundResponse,
  "SqlPoolNotFoundResult",
  "csharp"
); // no shipped name (404 error response)
@@clientName(
  SqlPools.SqlPoolAcceptedResponse,
  "SqlPoolAcceptedResult",
  "csharp"
); // no shipped name (pause/resume 202 envelope)

// GA names for flattened-property collisions (AutoRest collision names) and IR list operations.
@@clientName(
  IntegrationRuntimes.ManagedIntegrationRuntimeManagedVirtualNetworkReference.type,
  "TypeManagedVirtualNetworkType",
  "csharp"
);
@@clientName(BigDataPools.LibraryInfo.name, "NamePropertiesName", "csharp");
@@clientName(BigDataPools.LibraryInfo.type, "TypePropertiesType", "csharp");
@@clientName(
  IntegrationRuntimes.IntegrationRuntimeResources.list,
  "GetAllIntegrationRuntimeObjectMetadata",
  "csharp"
);
@@clientName(
  IntegrationRuntimes.IntegrationRuntimeResources.listOutboundNetworkDependenciesEndpoints,
  "GetOutboundNetworkDependenciesEndpoints",
  "csharp"
);
@@clientName(
  IntegrationRuntimes.IntegrationRuntimeResources.integrationRuntimeAuthKeysList,
  "GetIntegrationRuntimeAuthKey",
  "csharp"
);
@@clientName(
  IntegrationRuntimes.IntegrationRuntimeResources.integrationRuntimeMonitoringDataList,
  "GetIntegrationRuntimeMonitoringData",
  "csharp"
);

// The released .NET hub private endpoint connection data derives from ResourceData (Id is a ResourceIdentifier).
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Restores the released .NET ResourceData base for the hub private endpoint connection"
@@Azure.ClientGenerator.Core.Legacy.hierarchyBuilding(
  Workspaces.PrivateEndpointConnectionForPrivateLinkHub,
  Azure.ResourceManager.Foundations.ProxyResource,
  "csharp"
);
// Explicit C# name for the SsisObjectMetadata discriminator (internal in the released SDK).
@@clientName(
  IntegrationRuntimes.SsisObjectMetadata.type,
  "MetadataType",
  "csharp"
);
// GA resource names (request-path-to-resource-name and singularized names). Two resources share one
// model in each pair (workspace vs hub private link resources; AAD admin vs SQL AAD admin), so the
// resource name is set per Read operation, as in the Application Insights precedent.
@@clientName(
  Workspaces.PrivateLinkResource,
  "SynapsePrivateLinkResource",
  "csharp"
);
@@clientName(
  Workspaces.PrivateEndpointConnection,
  "SynapsePrivateEndpointConnection",
  "csharp"
);
#suppress "@azure-tools/typespec-client-generator-core/client-option" "Restore the GA C# resource name; the workspace and private link hub private link resources share one model."
@@clientOption(
  Workspaces.PrivateLinkResources.get,
  "resource-name",
  "SynapseWorkspacePrivateLinkResource",
  "csharp"
);
#suppress "@azure-tools/typespec-client-generator-core/client-option" "Restore the GA C# resource name; the workspace and private link hub private link resources share one model."
@@clientOption(
  Workspaces.PrivateLinkHubPrivateLinkResources.get,
  "resource-name",
  "SynapsePrivateLinkResource",
  "csharp"
);
#suppress "@azure-tools/typespec-client-generator-core/client-option" "Restore the GA C# resource name; the AAD admin and SQL AAD admin resources share one model."
@@clientOption(
  Workspaces.WorkspaceAadAdminInfos.get,
  "resource-name",
  "SynapseWorkspaceAdministratorResource",
  "csharp"
);
#suppress "@azure-tools/typespec-client-generator-core/client-option" "Restore the GA C# resource name; the AAD admin and SQL AAD admin resources share one model."
@@clientOption(
  Workspaces.WorkspaceSqlAadAdmins.get,
  "resource-name",
  "SynapseWorkspaceSqlAdministratorResource",
  "csharp"
);
@@clientName(
  IntegrationRuntimes.IntegrationRuntimeRegenerateKeyParameters,
  "IntegrationRuntimeRegenerateKeyContent",
  "csharp"
);

// Kusto check-name `type` values: closed enums in the original Swagger, released in .NET as
// KustoPoolType / SynapseDataConnectionType / Synapse(Database)PrincipalAssignmentType (extensible structs)
// and KustoPoolDatabaseType (enum, property ResourceType). TypeSpec keeps them as string literals (F4).
@@clientName(KustoPools.Type, "KustoPoolDatabaseType", "csharp");
@@clientName(
  KustoPools.DatabaseCheckNameRequest.type,
  "ResourceType",
  "csharp"
);
@@alternateType(
  KustoPools.KustoPoolCheckNameRequest.type,
  KustoPoolType,
  "csharp"
);
@@alternateType(
  KustoPools.DataConnectionCheckNameRequest.type,
  SynapseDataConnectionType,
  "csharp"
);
@@alternateType(
  KustoPools.ClusterPrincipalAssignmentCheckNameRequest.type,
  SynapsePrincipalAssignmentType,
  "csharp"
);
@@alternateType(
  KustoPools.DatabasePrincipalAssignmentCheckNameRequest.type,
  SynapseDatabasePrincipalAssignmentType,
  "csharp"
);
@@clientName(
  KustoPools.KustoPoolCheckNameRequest.type,
  "ResourceType",
  "csharp"
);
@@clientName(
  KustoPools.DataConnectionCheckNameRequest.type,
  "ResourceType",
  "csharp"
);
@@clientName(
  KustoPools.ClusterPrincipalAssignmentCheckNameRequest.type,
  "ResourceType",
  "csharp"
);
@@clientName(
  KustoPools.DatabasePrincipalAssignmentCheckNameRequest.type,
  "ResourceType",
  "csharp"
);

// GA format-by-name-rules ('tenantId': uuid, '*Uri': Uri) and released .NET property types.
@@alternateType(
  KustoPools.ClusterPrincipalProperties.tenantId,
  Azure.Core.uuid,
  "csharp"
);
@@alternateType(
  KustoPools.DatabasePrincipalProperties.tenantId,
  Azure.Core.uuid,
  "csharp"
);
@@alternateType(
  Workspaces.AadAdminProperties.tenantId,
  Azure.Core.uuid,
  "csharp"
);
@@alternateType(
  SqlPools.SqlPoolBlobAuditingPolicyProperties.storageAccountSubscriptionId,
  Azure.Core.uuid,
  "csharp"
);
@@alternateType(
  SqlPools.ExtendedSqlPoolBlobAuditingPolicyProperties.storageAccountSubscriptionId,
  Azure.Core.uuid,
  "csharp"
);
@@alternateType(
  SqlPools.ServerBlobAuditingPolicyProperties.storageAccountSubscriptionId,
  Azure.Core.uuid,
  "csharp"
);
@@alternateType(
  SqlPools.ExtendedServerBlobAuditingPolicyProperties.storageAccountSubscriptionId,
  Azure.Core.uuid,
  "csharp"
);
@@alternateType(KustoPools.KustoPoolProperties.uri, url, "csharp");
@@alternateType(KustoPools.KustoPoolProperties.dataIngestionUri, url, "csharp");
@@alternateType(SqlPools.EncryptionProtectorProperties.uri, url, "csharp");
@@alternateType(Workspaces.KeyProperties.keyVaultUrl, url, "csharp");
@@alternateType(
  Workspaces.PrivateEndpoint.id,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(
  Workspaces.WorkspaceProperties.extraProperties,
  Record<unknown>,
  "csharp"
);

// Released .NET property names (GA acronym-mapping 'ETA': Eta and AutoRest `type` property names).
@@clientName(
  Workspaces.PrivateEndpointConnectionProperties.privateLinkServiceConnectionState,
  "ConnectionState",
  "csharp"
);
@@clientName(
  IntegrationRuntimes.SelfHostedIntegrationRuntimeStatusTypeProperties.autoUpdateETA,
  "AutoUpdateEta",
  "csharp"
);
@@clientName(
  IntegrationRuntimes.ManagedIntegrationRuntimeOperationResult.type,
  "ManagedIntegrationRuntimeOperationResultType",
  "csharp"
);
@@clientName(
  Workspaces.WorkspaceRepositoryConfiguration.type,
  "WorkspaceRepositoryConfigurationType",
  "csharp"
);

// Read-only resources (GET/List only) were released with settable properties; mark them as
// input+output for C# so the generator keeps the setters.
@@usage(SqlPools.SqlPoolConnectionPolicy, Usage.input | Usage.output, "csharp");
@@usage(
  SqlPools.MaintenanceWindowOptions,
  Usage.input | Usage.output,
  "csharp"
);
@@usage(SqlPools.SqlPoolColumn, Usage.input | Usage.output, "csharp");
@@usage(
  BigDataPools.SparkConfigurationResource,
  Usage.input | Usage.output,
  "csharp"
);
@@usage(BigDataPools.LibraryResource, Usage.input | Usage.output, "csharp");
// GA operation names that AutoRest derived as {Verb}{OperationGroup} (not in autorest.md).
@@clientName(
  IntegrationRuntimes.IntegrationRuntimeResources.integrationRuntimeConnectionInfosGet,
  "GetIntegrationRuntimeConnectionInfo",
  "csharp"
);
@@clientName(
  IntegrationRuntimes.IntegrationRuntimeResources.regenerate,
  "RegenerateIntegrationRuntimeAuthKey",
  "csharp"
);
@@clientName(
  IntegrationRuntimes.IntegrationRuntimeResources.integrationRuntimeNodesGet,
  "GetIntegrationRuntimeNode",
  "csharp"
);
@@clientName(
  IntegrationRuntimes.IntegrationRuntimeResources.integrationRuntimeNodesUpdate,
  "UpdateIntegrationRuntimeNode",
  "csharp"
);
@@clientName(
  IntegrationRuntimes.IntegrationRuntimeResources.integrationRuntimeNodesDelete,
  "DeleteIntegrationRuntimeNode",
  "csharp"
);
@@clientName(
  IntegrationRuntimes.IntegrationRuntimeResources.sync,
  "SyncIntegrationRuntimeCredential",
  "csharp"
);
@@clientName(
  IntegrationRuntimes.IntegrationRuntimeResources.refresh,
  "RefreshIntegrationRuntimeObjectMetadata",
  "csharp"
);
@@clientName(
  SqlPools.SqlPoolColumns.enableRecommendation,
  "EnableRecommendationSqlPoolSensitivityLabel",
  "csharp"
);
@@clientName(
  SqlPools.SqlPoolColumns.disableRecommendation,
  "DisableRecommendationSqlPoolSensitivityLabel",
  "csharp"
);
@@clientName(
  SqlPools.SqlPools.sqlPoolSensitivityLabelsUpdate,
  "UpdateSqlPoolSensitivityLabel",
  "csharp"
);
@@clientName(
  SqlPools.SqlPools.sqlPoolRecommendedSensitivityLabelsUpdate,
  "UpdateSqlPoolRecommendedSensitivityLabel",
  "csharp"
);
@@clientName(SqlPools.SqlPools.sqlPoolUsagesList, "GetSqlPoolUsages", "csharp");
@@clientName(
  SqlPools.SqlPools.listCurrent,
  "GetCurrentSqlPoolSensitivityLabels",
  "csharp"
);
@@clientName(
  SqlPools.SqlPools.listRecommended,
  "GetRecommendedSqlPoolSensitivityLabels",
  "csharp"
);
@@clientName(
  SqlPools.SqlPools.sqlPoolRestorePointsCreate,
  "CreateSqlPoolRestorePoint",
  "csharp"
);
@@clientName(
  SqlPools.WorkspaceManagedSqlServerUsagesOperationGroup.list,
  "GetWorkspaceManagedSqlServerUsages",
  "csharp"
);
@@clientName(
  Workspaces.Workspaces.replaceAll,
  "ReplaceAllIpFirewallRule",
  "csharp"
);
@@clientName(
  KustoPools.KustoPoolsOperationGroup.listSkus,
  "GetSkusKustoPools",
  "csharp"
);
@@alternateType(
  KustoPools.KustoPoolsOperationGroup.checkNameAvailability::parameters.location,
  Azure.Core.azureLocation,
  "csharp"
);
// AutoRest .NET treated this POST list (value array) as pageable; keep the released Pageable signature.
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Restores the released .NET pageable signature"
@@Azure.ClientGenerator.Core.Legacy.markAsPageable(
  IntegrationRuntimes.IntegrationRuntimeResources.list,
  "csharp"
);
// GA autorest.md directive transforms.
@@clientName(
  SqlPools.SecurityAlertPolicyName,
  "SqlPoolSecurityAlertPolicyName",
  "csharp"
);
@@clientName(
  SqlPools.SecurityAlertPolicyNameAutoGenerated,
  "SqlServerSecurityAlertPolicyName",
  "csharp"
);
@@alternateType(
  SqlPools.MaintenanceWindowTimeRange.duration,
  duration,
  "csharp"
);
@@alternateType(
  SqlPools.MaintenanceWindowTimeRange.startTime,
  plainTime,
  "csharp"
);
@@alternateType(
  IntegrationRuntimes.IntegrationRuntimeNodeIpAddress.ipAddress,
  Azure.Core.ipV4Address,
  "csharp"
);
@@alternateType(
  Workspaces.IpFirewallRuleProperties.startIpAddress,
  Azure.Core.ipV4Address,
  "csharp"
);
@@alternateType(
  Workspaces.IpFirewallRuleProperties.endIpAddress,
  Azure.Core.ipV4Address,
  "csharp"
);

// --- Merged-client name clashes (python, csharp, java, javascript) ---
// Shipped names stay on the released types: KustoPools.ResourceProvisioningState (Python and .NET GA)
// and the workspace-level SqlPools.BlobAuditingPolicyName. The ARM common type is renamed instead.
@@clientName(
  Azure.ResourceManager.ResourceProvisioningState,
  "ArmResourceProvisioningState",
  "python, csharp, java, javascript"
);
// The pool-level blob auditing policy name was a fixed "default" in the released Python (Literal),
// .NET (singleton Get() without a name), Java, Go and JS SDKs (no parameter).
@@alternateType(
  SqlPools.SqlPoolLevel.BlobAuditingPolicyName,
  "default",
  "python, csharp, java, go, javascript"
);

// --- Python, Java, Go and JS (and .NET for the sensitivity label sources) ---
// Single-value path parameters shipped as fixed constants in azure-mgmt-synapse 2.1.0b7 (Literal) and in the
// released Java, Go and JS SDKs (no parameter on DataMaskingPolicies.get, SqlPoolSensitivityLabels.delete,
// enableRecommendation and disableRecommendation).
@@alternateType(
  SqlPools.DataMaskingPolicyName,
  "Default",
  "python, java, go, javascript"
);
@@alternateType(
  SqlPools.WritableSensitivityLabelSource,
  "current",
  "python, java, csharp, go, javascript"
);
@@alternateType(
  SqlPools.RecommendedSensitivityLabelSource,
  "recommended",
  "python, java, csharp, go, javascript"
);

// --- Java only ---
// The flattened managed virtual network reference `type` would collide with the IntegrationRuntime
// discriminator type() in ManagedIntegrationRuntime.
@@clientName(
  IntegrationRuntimes.ManagedIntegrationRuntimeManagedVirtualNetworkReference.type,
  "managedVirtualNetworkType",
  "java"
);

// LanguageExtensionsList is both a paged list result and the KustoPool.languageExtensions property type;
// keep it public so the public API does not expose an implementation type (checkstyle NoImplInPublicAPI).
@@access(KustoPools.LanguageExtensionsList, Access.public, "java");
// Property and enum names in azure-resourcemanager-synapse 1.0.0 (the two state enums also in @azure/arm-synapse).
@@clientName(Workspaces.KeyProperties.isActiveCMK, "isActiveCmk", "java");
@@clientName(
  Workspaces.WorkspaceProperties.workspaceUID,
  "workspaceUid",
  "java"
);
@@clientName(
  Workspaces.WorkspaceRepositoryConfiguration.hostName,
  "hostname",
  "java"
);
@@clientName(
  IntegrationRuntimes.SelfHostedIntegrationRuntimeStatusTypeProperties.autoUpdateETA,
  "autoUpdateEta",
  "java"
);
@@clientName(
  IntegrationRuntimes.CmdkeySetupTypeProperties.userName,
  "username",
  "java"
);
@@clientName(
  IntegrationRuntimes.IntegrationRuntimeSsisCatalogInfo.catalogAdminUserName,
  "catalogAdminUsername",
  "java"
);
@@clientName(
  Workspaces.ActualState,
  "ManagedIdentitySqlControlSettingsModelPropertiesGrantSqlControlToManagedIdentityActualState",
  "java, javascript"
);
@@clientName(
  Workspaces.DesiredState,
  "ManagedIdentitySqlControlSettingsModelPropertiesGrantSqlControlToManagedIdentityDesiredState",
  "java, javascript"
);
// extraProperties was a Map in azure-resourcemanager-synapse 1.0.0.
@@alternateType(
  Workspaces.WorkspaceProperties.extraProperties,
  Record<unknown>,
  "java"
);

// --- Go and JS ---
// userAssignedIdentities was a plain map in the released armsynapse and @azure/arm-synapse
// (the named Record model is emitted as a wrapper type).
@@alternateType(
  Workspaces.ManagedIdentity.userAssignedIdentities,
  Record<Workspaces.UserAssignedManagedIdentity>,
  "go, javascript"
);

// --- Python, Java, JS and Go ---
// Operations that were not pageable in the released SDKs (they returned the list model).
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Restores the released non-pageable signature"
@@Azure.ClientGenerator.Core.Legacy.disablePageable(
  KustoPools.KustoPools.listByWorkspace,
  "python, java, javascript, go"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Restores the released non-pageable signature"
@@Azure.ClientGenerator.Core.Legacy.disablePageable(
  IntegrationRuntimes.IntegrationRuntimeResources.listOutboundNetworkDependenciesEndpoints,
  "python, java, javascript, go"
);

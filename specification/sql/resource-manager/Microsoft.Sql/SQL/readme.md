# Sql

> see https://aka.ms/autorest

This is the AutoRest configuration file for Sql.

## Getting Started

To build the SDK for Sql, simply [Install AutoRest](https://aka.ms/autorest/install) and in this folder, run:

> `autorest`

To see additional help and options, run:

> `autorest --help`

## Configuration

### Basic Information

These are the global settings for the Sql API.

``` yaml
title: SqlManagementClient
description: 'The Azure SQL Database management API provides a RESTful set of web services that interact with Azure SQL Database services to manage your databases. The API enables you to create, retrieve, update, and delete databases.'
openapi-type: arm
tag: package-composite-v5
```

### Composite packages

The following packages may be composed from multiple api-versions.

### Tag: package-preview-2024-11-01-preview

These settings apply only when `--tag=package-preview-2024-11-01-preview` is specified on the command line.

```yaml $(tag) == 'package-preview-2024-11-01-preview'
input-file:
  - preview/2024-11-01-preview/BackupShortTermRetentionPolicies.json
  - preview/2024-11-01-preview/BlobAuditing.json
  - preview/2024-11-01-preview/DatabaseAdvancedThreatProtectionSettings.json
  - preview/2024-11-01-preview/DatabaseAdvisors.json
  - preview/2024-11-01-preview/DatabaseAutomaticTuning.json
  - preview/2024-11-01-preview/DatabaseColumns.json
  - preview/2024-11-01-preview/DatabaseEncryptionProtectorRevalidate.json
  - preview/2024-11-01-preview/DatabaseEncryptionProtectorRevert.json
  - preview/2024-11-01-preview/DatabaseExtensions.json
  - preview/2024-11-01-preview/DatabaseOperations.json
  - preview/2024-11-01-preview/DatabaseRecommendedActions.json
  - preview/2024-11-01-preview/Databases.json
  - preview/2024-11-01-preview/DatabaseSchemas.json
  - preview/2024-11-01-preview/DatabaseSecurityAlertPolicies.json
  - preview/2024-11-01-preview/DatabaseSqlVulnerabilityAssessmentBaselines.json
  - preview/2024-11-01-preview/DatabaseSqlVulnerabilityAssessmentExecuteScan.json
  - preview/2024-11-01-preview/DatabaseSqlVulnerabilityAssessmentRuleBaselines.json
  - preview/2024-11-01-preview/DatabaseSqlVulnerabilityAssessmentScanResult.json
  - preview/2024-11-01-preview/DatabaseSqlVulnerabilityAssessmentScans.json
  - preview/2024-11-01-preview/DatabaseSqlVulnerabilityAssessmentsSettings.json
  - preview/2024-11-01-preview/DatabaseTables.json
  - preview/2024-11-01-preview/DatabaseUsages.json
  - preview/2024-11-01-preview/DatabaseVulnerabilityAssessmentRuleBaselines.json
  - preview/2024-11-01-preview/DatabaseVulnerabilityAssessments.json
  - preview/2024-11-01-preview/DatabaseVulnerabilityAssessmentScans.json
  - preview/2024-11-01-preview/DataMaskingPolicies.json
  - preview/2024-11-01-preview/DataMaskingRules.json
  - preview/2024-11-01-preview/DataWarehouseUserActivities.json
  - preview/2024-11-01-preview/DeletedServers.json
  - preview/2024-11-01-preview/DistributedAvailabilityGroups.json
  - preview/2024-11-01-preview/ElasticPoolOperations.json
  - preview/2024-11-01-preview/ElasticPools.json
  - preview/2024-11-01-preview/EncryptionProtectors.json
  - preview/2024-11-01-preview/EndpointCertificates.json
  - preview/2024-11-01-preview/FailoverGroups.json
  - preview/2024-11-01-preview/FirewallRules.json
  - preview/2024-11-01-preview/GeoBackupPolicies.json
  - preview/2024-11-01-preview/InstanceFailoverGroups.json
  - preview/2024-11-01-preview/InstancePoolOperations.json
  - preview/2024-11-01-preview/InstancePools.json
  - preview/2024-11-01-preview/IPv6FirewallRules.json
  - preview/2024-11-01-preview/JobAgents.json
  - preview/2024-11-01-preview/JobCredentials.json
  - preview/2024-11-01-preview/JobExecutions.json
  - preview/2024-11-01-preview/JobPrivateEndpoints.json
  - preview/2024-11-01-preview/Jobs.json
  - preview/2024-11-01-preview/JobStepExecutions.json
  - preview/2024-11-01-preview/JobSteps.json
  - preview/2024-11-01-preview/JobTargetExecutions.json
  - preview/2024-11-01-preview/JobTargetGroups.json
  - preview/2024-11-01-preview/JobVersions.json
  - preview/2024-11-01-preview/LedgerDigestUploads.json
  - preview/2024-11-01-preview/LocationCapabilities.json
  - preview/2024-11-01-preview/LongTermRetentionBackups.json
  - preview/2024-11-01-preview/LongTermRetentionManagedInstanceBackups.json
  - preview/2024-11-01-preview/LongTermRetentionPolicies.json
  - preview/2024-11-01-preview/MaintenanceWindowOptions.json
  - preview/2024-11-01-preview/MaintenanceWindows.json
  - preview/2024-11-01-preview/ManagedBackupShortTermRetentionPolicies.json
  - preview/2024-11-01-preview/ManagedDatabaseAdvancedThreatProtectionSettings.json
  - preview/2024-11-01-preview/ManagedDatabaseColumns.json
  - preview/2024-11-01-preview/ManagedDatabaseMoveOperations.json
  - preview/2024-11-01-preview/ManagedDatabaseQueries.json
  - preview/2024-11-01-preview/ManagedDatabaseRestoreDetails.json
  - preview/2024-11-01-preview/ManagedDatabases.json
  - preview/2024-11-01-preview/ManagedDatabaseSchemas.json
  - preview/2024-11-01-preview/ManagedDatabaseSecurityAlertPolicies.json
  - preview/2024-11-01-preview/ManagedDatabaseSecurityEvents.json
  - preview/2024-11-01-preview/ManagedDatabaseSensitivityLabels.json
  - preview/2024-11-01-preview/ManagedDatabaseTables.json
  - preview/2024-11-01-preview/ManagedDatabaseTransparentDataEncryption.json
  - preview/2024-11-01-preview/ManagedDatabaseVulnerabilityAssessmentRuleBaselines.json
  - preview/2024-11-01-preview/ManagedDatabaseVulnerabilityAssessments.json
  - preview/2024-11-01-preview/ManagedDatabaseVulnerabilityAssessmentScans.json
  - preview/2024-11-01-preview/ManagedInstanceAdministrators.json
  - preview/2024-11-01-preview/ManagedInstanceAdvancedThreatProtectionSettings.json
  - preview/2024-11-01-preview/ManagedInstanceAzureADOnlyAuthentications.json
  - preview/2024-11-01-preview/ManagedInstanceDtcs.json
  - preview/2024-11-01-preview/ManagedInstanceEncryptionProtectors.json
  - preview/2024-11-01-preview/ManagedInstanceKeys.json
  - preview/2024-11-01-preview/ManagedInstanceLongTermRetentionPolicies.json
  - preview/2024-11-01-preview/ManagedInstanceOperations.json
  - preview/2024-11-01-preview/ManagedInstancePrivateEndpointConnections.json
  - preview/2024-11-01-preview/ManagedInstancePrivateLinkResources.json
  - preview/2024-11-01-preview/ManagedInstances.json
  - preview/2024-11-01-preview/ManagedInstanceTdeCertificates.json
  - preview/2024-11-01-preview/ManagedInstanceVulnerabilityAssessments.json
  - preview/2024-11-01-preview/ManagedLedgerDigestUploads.json
  - preview/2024-11-01-preview/ManagedRestorableDroppedDatabaseBackupShortTermRetentionPolicies.json
  - preview/2024-11-01-preview/ManagedServerDnsAliases.json
  - preview/2024-11-01-preview/ManagedServerSecurityAlertPolicies.json
  - preview/2024-11-01-preview/NetworkSecurityPerimeterConfigurations.json
  - preview/2024-11-01-preview/Operations.json
  - preview/2024-11-01-preview/OutboundFirewallRules.json
  - preview/2024-11-01-preview/PrivateEndpointConnections.json
  - preview/2024-11-01-preview/PrivateLinkResources.json
  - preview/2024-11-01-preview/RecoverableDatabases.json
  - preview/2024-11-01-preview/RecoverableManagedDatabases.json
  - preview/2024-11-01-preview/ReplicationLinks.json
  - preview/2024-11-01-preview/RestorableDroppedDatabases.json
  - preview/2024-11-01-preview/RestorableDroppedManagedDatabases.json
  - preview/2024-11-01-preview/RestorePoints.json
  - preview/2024-11-01-preview/SensitivityLabels.json
  - preview/2024-11-01-preview/ServerAdvancedThreatProtectionSettings.json
  - preview/2024-11-01-preview/ServerAdvisors.json
  - preview/2024-11-01-preview/ServerAutomaticTuning.json
  - preview/2024-11-01-preview/ServerAzureADAdministrators.json
  - preview/2024-11-01-preview/ServerAzureADOnlyAuthentications.json
  - preview/2024-11-01-preview/ServerConfigurationOptions.json
  - preview/2024-11-01-preview/ServerConnectionPolicies.json
  - preview/2024-11-01-preview/ServerDevOpsAudit.json
  - preview/2024-11-01-preview/ServerDnsAliases.json
  - preview/2024-11-01-preview/ServerKeys.json
  - preview/2024-11-01-preview/ServerOperations.json
  - preview/2024-11-01-preview/Servers.json
  - preview/2024-11-01-preview/ServerSecurityAlertPolicies.json
  - preview/2024-11-01-preview/ServerTrustCertificates.json
  - preview/2024-11-01-preview/ServerTrustGroups.json
  - preview/2024-11-01-preview/ServerUsages.json
  - preview/2024-11-01-preview/ServerVulnerabilityAssessments.json
  - preview/2024-11-01-preview/SqlAgent.json
  - preview/2024-11-01-preview/SqlVulnerabilityAssessmentBaseline.json
  - preview/2024-11-01-preview/SqlVulnerabilityAssessmentExecuteScan.json
  - preview/2024-11-01-preview/SqlVulnerabilityAssessmentRuleBaseline.json
  - preview/2024-11-01-preview/SqlVulnerabilityAssessmentScanResult.json
  - preview/2024-11-01-preview/SqlVulnerabilityAssessmentScans.json
  - preview/2024-11-01-preview/SqlVulnerabilityAssessmentsSettings.json
  - preview/2024-11-01-preview/StartStopManagedInstanceSchedules.json
  - preview/2024-11-01-preview/SubscriptionUsages.json
  - preview/2024-11-01-preview/SynapseLinkWorkspaces.json
  - preview/2024-11-01-preview/SyncAgents.json
  - preview/2024-11-01-preview/SyncGroups.json
  - preview/2024-11-01-preview/SyncMembers.json
  - preview/2024-11-01-preview/TdeCertificates.json
  - preview/2024-11-01-preview/TimeZones.json
  - preview/2024-11-01-preview/TransparentDataEncryptions.json
  - preview/2024-11-01-preview/Usages.json
  - preview/2024-11-01-preview/VirtualClusters.json
  - preview/2024-11-01-preview/VirtualNetworkRules.json
  - preview/2024-11-01-preview/WorkloadClassifiers.json
  - preview/2024-11-01-preview/WorkloadGroups.json
```

### Tag: package-2023-08

These settings apply only when `--tag=package-2023-08` is specified on the command line.

``` yaml $(tag) == 'package-2023-08'
input-file:
  - stable/2023-08-01/BackupShortTermRetentionPolicies.json
  - stable/2023-08-01/BlobAuditing.json
  - stable/2023-08-01/DataMaskingPolicies.json
  - stable/2023-08-01/DataMaskingRules.json
  - stable/2023-08-01/DataWarehouseUserActivities.json
  - stable/2023-08-01/DatabaseAdvancedThreatProtectionSettings.json
  - stable/2023-08-01/DatabaseAdvisors.json
  - stable/2023-08-01/DatabaseAutomaticTuning.json
  - stable/2023-08-01/DatabaseColumns.json
  - stable/2023-08-01/DatabaseEncryptionProtectorRevalidate.json
  - stable/2023-08-01/DatabaseEncryptionProtectorRevert.json
  - stable/2023-08-01/DatabaseExtensions.json
  - stable/2023-08-01/DatabaseOperations.json
  - stable/2023-08-01/DatabaseRecommendedActions.json
  - stable/2023-08-01/DatabaseSchemas.json
  - stable/2023-08-01/DatabaseSecurityAlertPolicies.json
  - stable/2023-08-01/DatabaseSqlVulnerabilityAssessmentBaselines.json
  - stable/2023-08-01/DatabaseSqlVulnerabilityAssessmentExecuteScan.json
  - stable/2023-08-01/DatabaseSqlVulnerabilityAssessmentRuleBaselines.json
  - stable/2023-08-01/DatabaseSqlVulnerabilityAssessmentScanResult.json
  - stable/2023-08-01/DatabaseSqlVulnerabilityAssessmentScans.json
  - stable/2023-08-01/DatabaseSqlVulnerabilityAssessmentsSettings.json
  - stable/2023-08-01/DatabaseTables.json
  - stable/2023-08-01/DatabaseUsages.json
  - stable/2023-08-01/DatabaseVulnerabilityAssessmentRuleBaselines.json
  - stable/2023-08-01/DatabaseVulnerabilityAssessmentScans.json
  - stable/2023-08-01/DatabaseVulnerabilityAssessments.json
  - stable/2023-08-01/Databases.json
  - stable/2023-08-01/DeletedServers.json
  - stable/2023-08-01/DistributedAvailabilityGroups.json
  - stable/2023-08-01/ElasticPoolOperations.json
  - stable/2023-08-01/ElasticPools.json
  - stable/2023-08-01/EncryptionProtectors.json
  - stable/2023-08-01/EndpointCertificates.json
  - stable/2023-08-01/FailoverGroups.json
  - stable/2023-08-01/FirewallRules.json
  - stable/2023-08-01/GeoBackupPolicies.json
  - stable/2023-08-01/IPv6FirewallRules.json
  - stable/2023-08-01/InstanceFailoverGroups.json
  - stable/2023-08-01/InstancePools.json
  - stable/2023-08-01/JobAgents.json
  - stable/2023-08-01/JobCredentials.json
  - stable/2023-08-01/JobExecutions.json
  - stable/2023-08-01/JobPrivateEndpoints.json
  - stable/2023-08-01/JobStepExecutions.json
  - stable/2023-08-01/JobSteps.json
  - stable/2023-08-01/JobTargetExecutions.json
  - stable/2023-08-01/JobTargetGroups.json
  - stable/2023-08-01/JobVersions.json
  - stable/2023-08-01/Jobs.json
  - stable/2023-08-01/LedgerDigestUploads.json
  - stable/2023-08-01/LocationCapabilities.json
  - stable/2023-08-01/LongTermRetentionBackups.json
  - stable/2023-08-01/LongTermRetentionManagedInstanceBackups.json
  - stable/2023-08-01/LongTermRetentionPolicies.json
  - stable/2023-08-01/MaintenanceWindowOptions.json
  - stable/2023-08-01/MaintenanceWindows.json
  - stable/2023-08-01/ManagedBackupShortTermRetentionPolicies.json
  - stable/2023-08-01/ManagedDatabaseAdvancedThreatProtectionSettings.json
  - stable/2023-08-01/ManagedDatabaseColumns.json
  - stable/2023-08-01/ManagedDatabaseMoveOperations.json
  - stable/2023-08-01/ManagedDatabaseQueries.json
  - stable/2023-08-01/ManagedDatabaseRestoreDetails.json
  - stable/2023-08-01/ManagedDatabaseSchemas.json
  - stable/2023-08-01/ManagedDatabaseSecurityAlertPolicies.json
  - stable/2023-08-01/ManagedDatabaseSecurityEvents.json
  - stable/2023-08-01/ManagedDatabaseSensitivityLabels.json
  - stable/2023-08-01/ManagedDatabaseTables.json
  - stable/2023-08-01/ManagedDatabaseTransparentDataEncryption.json
  - stable/2023-08-01/ManagedDatabaseVulnerabilityAssessmentRuleBaselines.json
  - stable/2023-08-01/ManagedDatabaseVulnerabilityAssessmentScans.json
  - stable/2023-08-01/ManagedDatabaseVulnerabilityAssessments.json
  - stable/2023-08-01/ManagedDatabases.json
  - stable/2023-08-01/ManagedInstanceAdministrators.json
  - stable/2023-08-01/ManagedInstanceAdvancedThreatProtectionSettings.json
  - stable/2023-08-01/ManagedInstanceAzureADOnlyAuthentications.json
  - stable/2023-08-01/ManagedInstanceDtcs.json
  - stable/2023-08-01/ManagedInstanceEncryptionProtectors.json
  - stable/2023-08-01/ManagedInstanceKeys.json
  - stable/2023-08-01/ManagedInstanceLongTermRetentionPolicies.json
  - stable/2023-08-01/ManagedInstanceOperations.json
  - stable/2023-08-01/ManagedInstancePrivateEndpointConnections.json
  - stable/2023-08-01/ManagedInstancePrivateLinkResources.json
  - stable/2023-08-01/ManagedInstanceTdeCertificates.json
  - stable/2023-08-01/ManagedInstanceVulnerabilityAssessments.json
  - stable/2023-08-01/ManagedInstances.json
  - stable/2023-08-01/ManagedLedgerDigestUploads.json
  - stable/2023-08-01/ManagedRestorableDroppedDatabaseBackupShortTermRetentionPolicies.json
  - stable/2023-08-01/ManagedServerDnsAliases.json
  - stable/2023-08-01/ManagedServerSecurityAlertPolicies.json
  - stable/2023-08-01/NetworkSecurityPerimeterConfigurations.json
  - stable/2023-08-01/Operations.json
  - stable/2023-08-01/OutboundFirewallRules.json
  - stable/2023-08-01/PrivateEndpointConnections.json
  - stable/2023-08-01/PrivateLinkResources.json
  - stable/2023-08-01/RecoverableDatabases.json
  - stable/2023-08-01/RecoverableManagedDatabases.json
  - stable/2023-08-01/ReplicationLinks.json
  - stable/2023-08-01/RestorableDroppedDatabases.json
  - stable/2023-08-01/RestorableDroppedManagedDatabases.json
  - stable/2023-08-01/RestorePoints.json
  - stable/2023-08-01/SensitivityLabels.json
  - stable/2023-08-01/ServerAdvancedThreatProtectionSettings.json
  - stable/2023-08-01/ServerAdvisors.json
  - stable/2023-08-01/ServerAutomaticTuning.json
  - stable/2023-08-01/ServerAzureADAdministrators.json
  - stable/2023-08-01/ServerAzureADOnlyAuthentications.json
  - stable/2023-08-01/ServerConfigurationOptions.json
  - stable/2023-08-01/ServerConnectionPolicies.json
  - stable/2023-08-01/ServerDevOpsAudit.json
  - stable/2023-08-01/ServerDnsAliases.json
  - stable/2023-08-01/ServerKeys.json
  - stable/2023-08-01/ServerOperations.json
  - stable/2023-08-01/ServerSecurityAlertPolicies.json
  - stable/2023-08-01/ServerTrustCertificates.json
  - stable/2023-08-01/ServerTrustGroups.json
  - stable/2023-08-01/ServerUsages.json
  - stable/2023-08-01/ServerVulnerabilityAssessments.json
  - stable/2023-08-01/Servers.json
  - stable/2023-08-01/SqlAgent.json
  - stable/2023-08-01/SqlVulnerabilityAssessmentBaseline.json
  - stable/2023-08-01/SqlVulnerabilityAssessmentExecuteScan.json
  - stable/2023-08-01/SqlVulnerabilityAssessmentRuleBaseline.json
  - stable/2023-08-01/SqlVulnerabilityAssessmentScanResult.json
  - stable/2023-08-01/SqlVulnerabilityAssessmentScans.json
  - stable/2023-08-01/SqlVulnerabilityAssessmentsSettings.json
  - stable/2023-08-01/StartStopManagedInstanceSchedules.json
  - stable/2023-08-01/SubscriptionUsages.json
  - stable/2023-08-01/SynapseLinkWorkspaces.json
  - stable/2023-08-01/SyncAgents.json
  - stable/2023-08-01/SyncGroups.json
  - stable/2023-08-01/SyncMembers.json
  - stable/2023-08-01/TdeCertificates.json
  - stable/2023-08-01/TimeZones.json
  - stable/2023-08-01/TransparentDataEncryptions.json
  - stable/2023-08-01/Usages.json
  - stable/2023-08-01/VirtualClusters.json
  - stable/2023-08-01/VirtualNetworkRules.json
  - stable/2023-08-01/WorkloadClassifiers.json
  - stable/2023-08-01/WorkloadGroups.json
```

### Tag: package-preview-2024-05

These settings apply only when `--tag=package-preview-2024-05` is specified on the command line.

```yaml $(tag) == 'package-preview-2024-05'
input-file:
  - preview/2024-05-01-preview/BackupShortTermRetentionPolicies.json
  - preview/2024-05-01-preview/BlobAuditing.json
  - preview/2024-05-01-preview/DataMaskingPolicies.json
  - preview/2024-05-01-preview/DataMaskingRules.json
  - preview/2024-05-01-preview/DataWarehouseUserActivities.json
  - preview/2024-05-01-preview/DatabaseAdvancedThreatProtectionSettings.json
  - preview/2024-05-01-preview/DatabaseAdvisors.json
  - preview/2024-05-01-preview/DatabaseAutomaticTuning.json
  - preview/2024-05-01-preview/DatabaseColumns.json
  - preview/2024-05-01-preview/DatabaseEncryptionProtectorRevalidate.json
  - preview/2024-05-01-preview/DatabaseEncryptionProtectorRevert.json
  - preview/2024-05-01-preview/DatabaseExtensions.json
  - preview/2024-05-01-preview/DatabaseOperations.json
  - preview/2024-05-01-preview/DatabaseRecommendedActions.json
  - preview/2024-05-01-preview/DatabaseSchemas.json
  - preview/2024-05-01-preview/DatabaseSecurityAlertPolicies.json
  - preview/2024-05-01-preview/DatabaseSqlVulnerabilityAssessmentBaselines.json
  - preview/2024-05-01-preview/DatabaseSqlVulnerabilityAssessmentExecuteScan.json
  - preview/2024-05-01-preview/DatabaseSqlVulnerabilityAssessmentRuleBaselines.json
  - preview/2024-05-01-preview/DatabaseSqlVulnerabilityAssessmentScanResult.json
  - preview/2024-05-01-preview/DatabaseSqlVulnerabilityAssessmentScans.json
  - preview/2024-05-01-preview/DatabaseSqlVulnerabilityAssessmentsSettings.json
  - preview/2024-05-01-preview/DatabaseTables.json
  - preview/2024-05-01-preview/DatabaseUsages.json
  - preview/2024-05-01-preview/DatabaseVulnerabilityAssessmentRuleBaselines.json
  - preview/2024-05-01-preview/DatabaseVulnerabilityAssessmentScans.json
  - preview/2024-05-01-preview/DatabaseVulnerabilityAssessments.json
  - preview/2024-05-01-preview/Databases.json
  - preview/2024-05-01-preview/DeletedServers.json
  - preview/2024-05-01-preview/DistributedAvailabilityGroups.json
  - preview/2024-05-01-preview/ElasticPoolOperations.json
  - preview/2024-05-01-preview/ElasticPools.json
  - preview/2024-05-01-preview/EncryptionProtectors.json
  - preview/2024-05-01-preview/EndpointCertificates.json
  - preview/2024-05-01-preview/FailoverGroups.json
  - preview/2024-05-01-preview/FirewallRules.json
  - preview/2024-05-01-preview/GeoBackupPolicies.json
  - preview/2024-05-01-preview/IPv6FirewallRules.json
  - preview/2024-05-01-preview/InstanceFailoverGroups.json
  - preview/2024-05-01-preview/InstancePools.json
  - preview/2024-05-01-preview/InstancePoolOperations.json
  - preview/2024-05-01-preview/JobAgents.json
  - preview/2024-05-01-preview/JobCredentials.json
  - preview/2024-05-01-preview/JobExecutions.json
  - preview/2024-05-01-preview/JobPrivateEndpoints.json
  - preview/2024-05-01-preview/JobStepExecutions.json
  - preview/2024-05-01-preview/JobSteps.json
  - preview/2024-05-01-preview/JobTargetExecutions.json
  - preview/2024-05-01-preview/JobTargetGroups.json
  - preview/2024-05-01-preview/JobVersions.json
  - preview/2024-05-01-preview/Jobs.json
  - preview/2024-05-01-preview/LedgerDigestUploads.json
  - preview/2024-05-01-preview/LocationCapabilities.json
  - preview/2024-05-01-preview/LongTermRetentionBackups.json
  - preview/2024-05-01-preview/LongTermRetentionManagedInstanceBackups.json
  - preview/2024-05-01-preview/LongTermRetentionPolicies.json
  - preview/2024-05-01-preview/MaintenanceWindowOptions.json
  - preview/2024-05-01-preview/MaintenanceWindows.json
  - preview/2024-05-01-preview/ManagedBackupShortTermRetentionPolicies.json
  - preview/2024-05-01-preview/ManagedDatabaseAdvancedThreatProtectionSettings.json
  - preview/2024-05-01-preview/ManagedDatabaseColumns.json
  - preview/2024-05-01-preview/ManagedDatabaseMoveOperations.json
  - preview/2024-05-01-preview/ManagedDatabaseQueries.json
  - preview/2024-05-01-preview/ManagedDatabaseRestoreDetails.json
  - preview/2024-05-01-preview/ManagedDatabaseSchemas.json
  - preview/2024-05-01-preview/ManagedDatabaseSecurityAlertPolicies.json
  - preview/2024-05-01-preview/ManagedDatabaseSecurityEvents.json
  - preview/2024-05-01-preview/ManagedDatabaseSensitivityLabels.json
  - preview/2024-05-01-preview/ManagedDatabaseTables.json
  - preview/2024-05-01-preview/ManagedDatabaseTransparentDataEncryption.json
  - preview/2024-05-01-preview/ManagedDatabaseVulnerabilityAssessmentRuleBaselines.json
  - preview/2024-05-01-preview/ManagedDatabaseVulnerabilityAssessmentScans.json
  - preview/2024-05-01-preview/ManagedDatabaseVulnerabilityAssessments.json
  - preview/2024-05-01-preview/ManagedDatabases.json
  - preview/2024-05-01-preview/ManagedInstanceAdministrators.json
  - preview/2024-05-01-preview/ManagedInstanceAdvancedThreatProtectionSettings.json
  - preview/2024-05-01-preview/ManagedInstanceAzureADOnlyAuthentications.json
  - preview/2024-05-01-preview/ManagedInstanceDtcs.json
  - preview/2024-05-01-preview/ManagedInstanceEncryptionProtectors.json
  - preview/2024-05-01-preview/ManagedInstanceKeys.json
  - preview/2024-05-01-preview/ManagedInstanceLongTermRetentionPolicies.json
  - preview/2024-05-01-preview/ManagedInstanceOperations.json
  - preview/2024-05-01-preview/ManagedInstancePrivateEndpointConnections.json
  - preview/2024-05-01-preview/ManagedInstancePrivateLinkResources.json
  - preview/2024-05-01-preview/ManagedInstanceTdeCertificates.json
  - preview/2024-05-01-preview/ManagedInstanceVulnerabilityAssessments.json
  - preview/2024-05-01-preview/ManagedInstances.json
  - preview/2024-05-01-preview/ManagedLedgerDigestUploads.json
  - preview/2024-05-01-preview/ManagedRestorableDroppedDatabaseBackupShortTermRetentionPolicies.json
  - preview/2024-05-01-preview/ManagedServerDnsAliases.json
  - preview/2024-05-01-preview/ManagedServerSecurityAlertPolicies.json
  - preview/2024-05-01-preview/NetworkSecurityPerimeterConfigurations.json
  - preview/2024-05-01-preview/Operations.json
  - preview/2024-05-01-preview/OutboundFirewallRules.json
  - preview/2024-05-01-preview/PrivateEndpointConnections.json
  - preview/2024-05-01-preview/PrivateLinkResources.json
  - preview/2024-05-01-preview/RecoverableDatabases.json
  - preview/2024-05-01-preview/RecoverableManagedDatabases.json
  - preview/2024-05-01-preview/ReplicationLinks.json
  - preview/2024-05-01-preview/RestorableDroppedDatabases.json
  - preview/2024-05-01-preview/RestorableDroppedManagedDatabases.json
  - preview/2024-05-01-preview/RestorePoints.json
  - preview/2024-05-01-preview/SensitivityLabels.json
  - preview/2024-05-01-preview/ServerAdvancedThreatProtectionSettings.json
  - preview/2024-05-01-preview/ServerAdvisors.json
  - preview/2024-05-01-preview/ServerAutomaticTuning.json
  - preview/2024-05-01-preview/ServerAzureADAdministrators.json
  - preview/2024-05-01-preview/ServerAzureADOnlyAuthentications.json
  - preview/2024-05-01-preview/ServerConfigurationOptions.json
  - preview/2024-05-01-preview/ServerConnectionPolicies.json
  - preview/2024-05-01-preview/ServerDevOpsAudit.json
  - preview/2024-05-01-preview/ServerDnsAliases.json
  - preview/2024-05-01-preview/ServerKeys.json
  - preview/2024-05-01-preview/ServerOperations.json
  - preview/2024-05-01-preview/ServerSecurityAlertPolicies.json
  - preview/2024-05-01-preview/ServerTrustCertificates.json
  - preview/2024-05-01-preview/ServerTrustGroups.json
  - preview/2024-05-01-preview/ServerUsages.json
  - preview/2024-05-01-preview/ServerVulnerabilityAssessments.json
  - preview/2024-05-01-preview/Servers.json
  - preview/2024-05-01-preview/SqlAgent.json
  - preview/2024-05-01-preview/SqlVulnerabilityAssessmentBaseline.json
  - preview/2024-05-01-preview/SqlVulnerabilityAssessmentExecuteScan.json
  - preview/2024-05-01-preview/SqlVulnerabilityAssessmentRuleBaseline.json
  - preview/2024-05-01-preview/SqlVulnerabilityAssessmentScanResult.json
  - preview/2024-05-01-preview/SqlVulnerabilityAssessmentScans.json
  - preview/2024-05-01-preview/SqlVulnerabilityAssessmentsSettings.json
  - preview/2024-05-01-preview/StartStopManagedInstanceSchedules.json
  - preview/2024-05-01-preview/SubscriptionUsages.json
  - preview/2024-05-01-preview/SynapseLinkWorkspaces.json
  - preview/2024-05-01-preview/SyncAgents.json
  - preview/2024-05-01-preview/SyncGroups.json
  - preview/2024-05-01-preview/SyncMembers.json
  - preview/2024-05-01-preview/TdeCertificates.json
  - preview/2024-05-01-preview/TimeZones.json
  - preview/2024-05-01-preview/TransparentDataEncryptions.json
  - preview/2024-05-01-preview/Usages.json
  - preview/2024-05-01-preview/VirtualClusters.json
  - preview/2024-05-01-preview/VirtualNetworkRules.json
  - preview/2024-05-01-preview/WorkloadClassifiers.json
  - preview/2024-05-01-preview/WorkloadGroups.json
```

### Tag: package-preview-2023-08

These settings apply only when `--tag=package-preview-2023-08` is specified on the command line.

``` yaml $(tag) == 'package-preview-2023-08'
input-file:
  - preview/2023-08-01-preview/BackupShortTermRetentionPolicies.json
  - preview/2023-08-01-preview/BlobAuditing.json
  - preview/2023-08-01-preview/DataMaskingPolicies.json
  - preview/2023-08-01-preview/DataMaskingRules.json
  - preview/2023-08-01-preview/DataWarehouseUserActivities.json
  - preview/2023-08-01-preview/DatabaseAdvancedThreatProtectionSettings.json
  - preview/2023-08-01-preview/DatabaseAdvisors.json
  - preview/2023-08-01-preview/DatabaseAutomaticTuning.json
  - preview/2023-08-01-preview/DatabaseColumns.json
  - preview/2023-08-01-preview/DatabaseEncryptionProtectorRevalidate.json
  - preview/2023-08-01-preview/DatabaseEncryptionProtectorRevert.json
  - preview/2023-08-01-preview/DatabaseExtensions.json
  - preview/2023-08-01-preview/DatabaseOperations.json
  - preview/2023-08-01-preview/DatabaseRecommendedActions.json
  - preview/2023-08-01-preview/DatabaseSchemas.json
  - preview/2023-08-01-preview/DatabaseSecurityAlertPolicies.json
  - preview/2023-08-01-preview/DatabaseSqlVulnerabilityAssessmentBaselines.json
  - preview/2023-08-01-preview/DatabaseSqlVulnerabilityAssessmentExecuteScan.json
  - preview/2023-08-01-preview/DatabaseSqlVulnerabilityAssessmentRuleBaselines.json
  - preview/2023-08-01-preview/DatabaseSqlVulnerabilityAssessmentScanResult.json
  - preview/2023-08-01-preview/DatabaseSqlVulnerabilityAssessmentScans.json
  - preview/2023-08-01-preview/DatabaseSqlVulnerabilityAssessmentsSettings.json
  - preview/2023-08-01-preview/DatabaseTables.json
  - preview/2023-08-01-preview/DatabaseUsages.json
  - preview/2023-08-01-preview/DatabaseVulnerabilityAssessmentRuleBaselines.json
  - preview/2023-08-01-preview/DatabaseVulnerabilityAssessmentScans.json
  - preview/2023-08-01-preview/DatabaseVulnerabilityAssessments.json
  - preview/2023-08-01-preview/Databases.json
  - preview/2023-08-01-preview/DeletedServers.json
  - preview/2023-08-01-preview/DistributedAvailabilityGroups.json
  - preview/2023-08-01-preview/ElasticPoolOperations.json
  - preview/2023-08-01-preview/ElasticPools.json
  - preview/2023-08-01-preview/EncryptionProtectors.json
  - preview/2023-08-01-preview/EndpointCertificates.json
  - preview/2023-08-01-preview/FailoverGroups.json
  - preview/2023-08-01-preview/FirewallRules.json
  - preview/2023-08-01-preview/GeoBackupPolicies.json
  - preview/2023-08-01-preview/IPv6FirewallRules.json
  - preview/2023-08-01-preview/InstanceFailoverGroups.json
  - preview/2023-08-01-preview/InstancePools.json
  - preview/2023-08-01-preview/JobAgents.json
  - preview/2023-08-01-preview/JobCredentials.json
  - preview/2023-08-01-preview/JobExecutions.json
  - preview/2023-08-01-preview/JobPrivateEndpoints.json
  - preview/2023-08-01-preview/JobStepExecutions.json
  - preview/2023-08-01-preview/JobSteps.json
  - preview/2023-08-01-preview/JobTargetExecutions.json
  - preview/2023-08-01-preview/JobTargetGroups.json
  - preview/2023-08-01-preview/JobVersions.json
  - preview/2023-08-01-preview/Jobs.json
  - preview/2023-08-01-preview/LedgerDigestUploads.json
  - preview/2023-08-01-preview/LocationCapabilities.json
  - preview/2023-08-01-preview/LongTermRetentionBackups.json
  - preview/2023-08-01-preview/LongTermRetentionManagedInstanceBackups.json
  - preview/2023-08-01-preview/LongTermRetentionPolicies.json
  - preview/2023-08-01-preview/MaintenanceWindowOptions.json
  - preview/2023-08-01-preview/MaintenanceWindows.json
  - preview/2023-08-01-preview/ManagedBackupShortTermRetentionPolicies.json
  - preview/2023-08-01-preview/ManagedDatabaseAdvancedThreatProtectionSettings.json
  - preview/2023-08-01-preview/ManagedDatabaseColumns.json
  - preview/2023-08-01-preview/ManagedDatabaseMoveOperations.json
  - preview/2023-08-01-preview/ManagedDatabaseQueries.json
  - preview/2023-08-01-preview/ManagedDatabaseRestoreDetails.json
  - preview/2023-08-01-preview/ManagedDatabaseSchemas.json
  - preview/2023-08-01-preview/ManagedDatabaseSecurityAlertPolicies.json
  - preview/2023-08-01-preview/ManagedDatabaseSecurityEvents.json
  - preview/2023-08-01-preview/ManagedDatabaseSensitivityLabels.json
  - preview/2023-08-01-preview/ManagedDatabaseTables.json
  - preview/2023-08-01-preview/ManagedDatabaseTransparentDataEncryption.json
  - preview/2023-08-01-preview/ManagedDatabaseVulnerabilityAssessmentRuleBaselines.json
  - preview/2023-08-01-preview/ManagedDatabaseVulnerabilityAssessmentScans.json
  - preview/2023-08-01-preview/ManagedDatabaseVulnerabilityAssessments.json
  - preview/2023-08-01-preview/ManagedDatabases.json
  - preview/2023-08-01-preview/ManagedInstanceAdministrators.json
  - preview/2023-08-01-preview/ManagedInstanceAdvancedThreatProtectionSettings.json
  - preview/2023-08-01-preview/ManagedInstanceAzureADOnlyAuthentications.json
  - preview/2023-08-01-preview/ManagedInstanceDtcs.json
  - preview/2023-08-01-preview/ManagedInstanceEncryptionProtectors.json
  - preview/2023-08-01-preview/ManagedInstanceKeys.json
  - preview/2023-08-01-preview/ManagedInstanceLongTermRetentionPolicies.json
  - preview/2023-08-01-preview/ManagedInstanceOperations.json
  - preview/2023-08-01-preview/ManagedInstancePrivateEndpointConnections.json
  - preview/2023-08-01-preview/ManagedInstancePrivateLinkResources.json
  - preview/2023-08-01-preview/ManagedInstanceTdeCertificates.json
  - preview/2023-08-01-preview/ManagedInstanceVulnerabilityAssessments.json
  - preview/2023-08-01-preview/ManagedInstances.json
  - preview/2023-08-01-preview/ManagedLedgerDigestUploads.json
  - preview/2023-08-01-preview/ManagedRestorableDroppedDatabaseBackupShortTermRetentionPolicies.json
  - preview/2023-08-01-preview/ManagedServerDnsAliases.json
  - preview/2023-08-01-preview/ManagedServerSecurityAlertPolicies.json
  - preview/2023-08-01-preview/NetworkSecurityPerimeterConfigurations.json
  - preview/2023-08-01-preview/Operations.json
  - preview/2023-08-01-preview/OutboundFirewallRules.json
  - preview/2023-08-01-preview/PrivateEndpointConnections.json
  - preview/2023-08-01-preview/PrivateLinkResources.json
  - preview/2023-08-01-preview/RecoverableDatabases.json
  - preview/2023-08-01-preview/RecoverableManagedDatabases.json
  - preview/2023-08-01-preview/ReplicationLinks.json
  - preview/2023-08-01-preview/RestorableDroppedDatabases.json
  - preview/2023-08-01-preview/RestorableDroppedManagedDatabases.json
  - preview/2023-08-01-preview/RestorePoints.json
  - preview/2023-08-01-preview/SensitivityLabels.json
  - preview/2023-08-01-preview/ServerAdvancedThreatProtectionSettings.json
  - preview/2023-08-01-preview/ServerAdvisors.json
  - preview/2023-08-01-preview/ServerAutomaticTuning.json
  - preview/2023-08-01-preview/ServerAzureADAdministrators.json
  - preview/2023-08-01-preview/ServerAzureADOnlyAuthentications.json
  - preview/2023-08-01-preview/ServerConfigurationOptions.json
  - preview/2023-08-01-preview/ServerConnectionPolicies.json
  - preview/2023-08-01-preview/ServerDevOpsAudit.json
  - preview/2023-08-01-preview/ServerDnsAliases.json
  - preview/2023-08-01-preview/ServerKeys.json
  - preview/2023-08-01-preview/ServerOperations.json
  - preview/2023-08-01-preview/ServerSecurityAlertPolicies.json
  - preview/2023-08-01-preview/ServerTrustCertificates.json
  - preview/2023-08-01-preview/ServerTrustGroups.json
  - preview/2023-08-01-preview/ServerUsages.json
  - preview/2023-08-01-preview/ServerVulnerabilityAssessments.json
  - preview/2023-08-01-preview/Servers.json
  - preview/2023-08-01-preview/SqlAgent.json
  - preview/2023-08-01-preview/SqlVulnerabilityAssessmentBaseline.json
  - preview/2023-08-01-preview/SqlVulnerabilityAssessmentExecuteScan.json
  - preview/2023-08-01-preview/SqlVulnerabilityAssessmentRuleBaseline.json
  - preview/2023-08-01-preview/SqlVulnerabilityAssessmentScanResult.json
  - preview/2023-08-01-preview/SqlVulnerabilityAssessmentScans.json
  - preview/2023-08-01-preview/SqlVulnerabilityAssessmentsSettings.json
  - preview/2023-08-01-preview/StartStopManagedInstanceSchedules.json
  - preview/2023-08-01-preview/SubscriptionUsages.json
  - preview/2023-08-01-preview/SynapseLinkWorkspaces.json
  - preview/2023-08-01-preview/SyncAgents.json
  - preview/2023-08-01-preview/SyncGroups.json
  - preview/2023-08-01-preview/SyncMembers.json
  - preview/2023-08-01-preview/TdeCertificates.json
  - preview/2023-08-01-preview/TimeZones.json
  - preview/2023-08-01-preview/TransparentDataEncryptions.json
  - preview/2023-08-01-preview/Usages.json
  - preview/2023-08-01-preview/VirtualClusters.json
  - preview/2023-08-01-preview/VirtualNetworkRules.json
  - preview/2023-08-01-preview/WorkloadClassifiers.json
  - preview/2023-08-01-preview/WorkloadGroups.json
```

### Tag: package-preview-2023-05

These settings apply only when `--tag=package-preview-2023-05` is specified on the command line.

``` yaml $(tag) == 'package-preview-2023-05'
input-file:
  - preview/2023-05-01-preview/BackupShortTermRetentionPolicies.json
  - preview/2023-05-01-preview/BlobAuditing.json
  - preview/2023-05-01-preview/DataMaskingPolicies.json
  - preview/2023-05-01-preview/DataMaskingRules.json
  - preview/2023-05-01-preview/DataWarehouseUserActivities.json
  - preview/2023-05-01-preview/DatabaseAdvancedThreatProtectionSettings.json
  - preview/2023-05-01-preview/DatabaseAdvisors.json
  - preview/2023-05-01-preview/DatabaseAutomaticTuning.json
  - preview/2023-05-01-preview/DatabaseColumns.json
  - preview/2023-05-01-preview/DatabaseEncryptionProtectorRevalidate.json
  - preview/2023-05-01-preview/DatabaseEncryptionProtectorRevert.json
  - preview/2023-05-01-preview/DatabaseExtensions.json
  - preview/2023-05-01-preview/DatabaseOperations.json
  - preview/2023-05-01-preview/DatabaseRecommendedActions.json
  - preview/2023-05-01-preview/DatabaseSchemas.json
  - preview/2023-05-01-preview/DatabaseSecurityAlertPolicies.json
  - preview/2023-05-01-preview/DatabaseSqlVulnerabilityAssessmentBaselines.json
  - preview/2023-05-01-preview/DatabaseSqlVulnerabilityAssessmentExecuteScan.json
  - preview/2023-05-01-preview/DatabaseSqlVulnerabilityAssessmentRuleBaselines.json
  - preview/2023-05-01-preview/DatabaseSqlVulnerabilityAssessmentScanResult.json
  - preview/2023-05-01-preview/DatabaseSqlVulnerabilityAssessmentScans.json
  - preview/2023-05-01-preview/DatabaseSqlVulnerabilityAssessmentsSettings.json
  - preview/2023-05-01-preview/DatabaseTables.json
  - preview/2023-05-01-preview/DatabaseUsages.json
  - preview/2023-05-01-preview/DatabaseVulnerabilityAssessmentRuleBaselines.json
  - preview/2023-05-01-preview/DatabaseVulnerabilityAssessmentScans.json
  - preview/2023-05-01-preview/DatabaseVulnerabilityAssessments.json
  - preview/2023-05-01-preview/Databases.json
  - preview/2023-05-01-preview/DeletedServers.json
  - preview/2023-05-01-preview/DistributedAvailabilityGroups.json
  - preview/2023-05-01-preview/ElasticPoolOperations.json
  - preview/2023-05-01-preview/ElasticPools.json
  - preview/2023-05-01-preview/EncryptionProtectors.json
  - preview/2023-05-01-preview/EndpointCertificates.json
  - preview/2023-05-01-preview/FailoverGroups.json
  - preview/2023-05-01-preview/FirewallRules.json
  - preview/2023-05-01-preview/GeoBackupPolicies.json
  - preview/2023-05-01-preview/IPv6FirewallRules.json
  - preview/2023-05-01-preview/InstanceFailoverGroups.json
  - preview/2023-05-01-preview/InstancePools.json
  - preview/2023-05-01-preview/JobAgents.json
  - preview/2023-05-01-preview/JobCredentials.json
  - preview/2023-05-01-preview/JobExecutions.json
  - preview/2023-05-01-preview/JobPrivateEndpoints.json
  - preview/2023-05-01-preview/JobStepExecutions.json
  - preview/2023-05-01-preview/JobSteps.json
  - preview/2023-05-01-preview/JobTargetExecutions.json
  - preview/2023-05-01-preview/JobTargetGroups.json
  - preview/2023-05-01-preview/JobVersions.json
  - preview/2023-05-01-preview/Jobs.json
  - preview/2023-05-01-preview/LedgerDigestUploads.json
  - preview/2023-05-01-preview/LocationCapabilities.json
  - preview/2023-05-01-preview/LongTermRetentionBackups.json
  - preview/2023-05-01-preview/LongTermRetentionManagedInstanceBackups.json
  - preview/2023-05-01-preview/LongTermRetentionPolicies.json
  - preview/2023-05-01-preview/MaintenanceWindowOptions.json
  - preview/2023-05-01-preview/MaintenanceWindows.json
  - preview/2023-05-01-preview/ManagedBackupShortTermRetentionPolicies.json
  - preview/2023-05-01-preview/ManagedDatabaseAdvancedThreatProtectionSettings.json
  - preview/2023-05-01-preview/ManagedDatabaseColumns.json
  - preview/2023-05-01-preview/ManagedDatabaseMoveOperations.json
  - preview/2023-05-01-preview/ManagedDatabaseQueries.json
  - preview/2023-05-01-preview/ManagedDatabaseRestoreDetails.json
  - preview/2023-05-01-preview/ManagedDatabaseSchemas.json
  - preview/2023-05-01-preview/ManagedDatabaseSecurityAlertPolicies.json
  - preview/2023-05-01-preview/ManagedDatabaseSecurityEvents.json
  - preview/2023-05-01-preview/ManagedDatabaseSensitivityLabels.json
  - preview/2023-05-01-preview/ManagedDatabaseTables.json
  - preview/2023-05-01-preview/ManagedDatabaseTransparentDataEncryption.json
  - preview/2023-05-01-preview/ManagedDatabaseVulnerabilityAssessmentRuleBaselines.json
  - preview/2023-05-01-preview/ManagedDatabaseVulnerabilityAssessmentScans.json
  - preview/2023-05-01-preview/ManagedDatabaseVulnerabilityAssessments.json
  - preview/2023-05-01-preview/ManagedDatabases.json
  - preview/2023-05-01-preview/ManagedInstanceAdministrators.json
  - preview/2023-05-01-preview/ManagedInstanceAdvancedThreatProtectionSettings.json
  - preview/2023-05-01-preview/ManagedInstanceAzureADOnlyAuthentications.json
  - preview/2023-05-01-preview/ManagedInstanceDtcs.json
  - preview/2023-05-01-preview/ManagedInstanceEncryptionProtectors.json
  - preview/2023-05-01-preview/ManagedInstanceKeys.json
  - preview/2023-05-01-preview/ManagedInstanceLongTermRetentionPolicies.json
  - preview/2023-05-01-preview/ManagedInstanceOperations.json
  - preview/2023-05-01-preview/ManagedInstancePrivateEndpointConnections.json
  - preview/2023-05-01-preview/ManagedInstancePrivateLinkResources.json
  - preview/2023-05-01-preview/ManagedInstanceTdeCertificates.json
  - preview/2023-05-01-preview/ManagedInstanceVulnerabilityAssessments.json
  - preview/2023-05-01-preview/ManagedInstances.json
  - preview/2023-05-01-preview/ManagedLedgerDigestUploads.json
  - preview/2023-05-01-preview/ManagedRestorableDroppedDatabaseBackupShortTermRetentionPolicies.json
  - preview/2023-05-01-preview/ManagedServerDnsAliases.json
  - preview/2023-05-01-preview/ManagedServerSecurityAlertPolicies.json
  - preview/2023-05-01-preview/NetworkSecurityPerimeterConfigurations.json
  - preview/2023-05-01-preview/Operations.json
  - preview/2023-05-01-preview/OutboundFirewallRules.json
  - preview/2023-05-01-preview/PrivateEndpointConnections.json
  - preview/2023-05-01-preview/PrivateLinkResources.json
  - preview/2023-05-01-preview/RecoverableDatabases.json
  - preview/2023-05-01-preview/RecoverableManagedDatabases.json
  - preview/2023-05-01-preview/ReplicationLinks.json
  - preview/2023-05-01-preview/RestorableDroppedDatabases.json
  - preview/2023-05-01-preview/RestorableDroppedManagedDatabases.json
  - preview/2023-05-01-preview/RestorePoints.json
  - preview/2023-05-01-preview/SensitivityLabels.json
  - preview/2023-05-01-preview/ServerAdvancedThreatProtectionSettings.json
  - preview/2023-05-01-preview/ServerAdvisors.json
  - preview/2023-05-01-preview/ServerAutomaticTuning.json
  - preview/2023-05-01-preview/ServerAzureADAdministrators.json
  - preview/2023-05-01-preview/ServerAzureADOnlyAuthentications.json
  - preview/2023-05-01-preview/ServerConfigurationOptions.json
  - preview/2023-05-01-preview/ServerConnectionPolicies.json
  - preview/2023-05-01-preview/ServerDevOpsAudit.json
  - preview/2023-05-01-preview/ServerDnsAliases.json
  - preview/2023-05-01-preview/ServerKeys.json
  - preview/2023-05-01-preview/ServerOperations.json
  - preview/2023-05-01-preview/ServerSecurityAlertPolicies.json
  - preview/2023-05-01-preview/ServerTrustCertificates.json
  - preview/2023-05-01-preview/ServerTrustGroups.json
  - preview/2023-05-01-preview/ServerUsages.json
  - preview/2023-05-01-preview/ServerVulnerabilityAssessments.json
  - preview/2023-05-01-preview/Servers.json
  - preview/2023-05-01-preview/SqlAgent.json
  - preview/2023-05-01-preview/SqlVulnerabilityAssessmentBaseline.json
  - preview/2023-05-01-preview/SqlVulnerabilityAssessmentExecuteScan.json
  - preview/2023-05-01-preview/SqlVulnerabilityAssessmentRuleBaseline.json
  - preview/2023-05-01-preview/SqlVulnerabilityAssessmentScanResult.json
  - preview/2023-05-01-preview/SqlVulnerabilityAssessmentScans.json
  - preview/2023-05-01-preview/SqlVulnerabilityAssessmentsSettings.json
  - preview/2023-05-01-preview/StartStopManagedInstanceSchedules.json
  - preview/2023-05-01-preview/SubscriptionUsages.json
  - preview/2023-05-01-preview/SynapseLinkWorkspaces.json
  - preview/2023-05-01-preview/SyncAgents.json
  - preview/2023-05-01-preview/SyncGroups.json
  - preview/2023-05-01-preview/SyncMembers.json
  - preview/2023-05-01-preview/TdeCertificates.json
  - preview/2023-05-01-preview/TimeZones.json
  - preview/2023-05-01-preview/TransparentDataEncryptions.json
  - preview/2023-05-01-preview/Usages.json
  - preview/2023-05-01-preview/VirtualClusters.json
  - preview/2023-05-01-preview/VirtualNetworkRules.json
  - preview/2023-05-01-preview/WorkloadClassifiers.json
  - preview/2023-05-01-preview/WorkloadGroups.json
```

### Tag: package-preview-2023-02

These settings apply only when `--tag=package-preview-2023-02` is specified on the command line.

``` yaml $(tag) == 'package-preview-2023-02'
input-file:
  - preview/2023-02-01-preview/BackupShortTermRetentionPolicies.json
  - preview/2023-02-01-preview/BlobAuditing.json
  - preview/2023-02-01-preview/DataMaskingPolicies.json
  - preview/2023-02-01-preview/DataMaskingRules.json
  - preview/2023-02-01-preview/DataWarehouseUserActivities.json
  - preview/2023-02-01-preview/DatabaseAdvancedThreatProtectionSettings.json
  - preview/2023-02-01-preview/DatabaseAdvisors.json
  - preview/2023-02-01-preview/DatabaseAutomaticTuning.json
  - preview/2023-02-01-preview/DatabaseColumns.json
  - preview/2023-02-01-preview/DatabaseEncryptionProtectorRevalidate.json
  - preview/2023-02-01-preview/DatabaseEncryptionProtectorRevert.json
  - preview/2023-02-01-preview/DatabaseExtensions.json
  - preview/2023-02-01-preview/DatabaseOperations.json
  - preview/2023-02-01-preview/DatabaseRecommendedActions.json
  - preview/2023-02-01-preview/DatabaseSchemas.json
  - preview/2023-02-01-preview/DatabaseSecurityAlertPolicies.json
  - preview/2023-02-01-preview/DatabaseSqlVulnerabilityAssessmentBaselines.json
  - preview/2023-02-01-preview/DatabaseSqlVulnerabilityAssessmentExecuteScan.json
  - preview/2023-02-01-preview/DatabaseSqlVulnerabilityAssessmentRuleBaselines.json
  - preview/2023-02-01-preview/DatabaseSqlVulnerabilityAssessmentScanResult.json
  - preview/2023-02-01-preview/DatabaseSqlVulnerabilityAssessmentScans.json
  - preview/2023-02-01-preview/DatabaseSqlVulnerabilityAssessmentsSettings.json
  - preview/2023-02-01-preview/DatabaseTables.json
  - preview/2023-02-01-preview/DatabaseUsages.json
  - preview/2023-02-01-preview/DatabaseVulnerabilityAssessmentRuleBaselines.json
  - preview/2023-02-01-preview/DatabaseVulnerabilityAssessmentScans.json
  - preview/2023-02-01-preview/DatabaseVulnerabilityAssessments.json
  - preview/2023-02-01-preview/Databases.json
  - preview/2023-02-01-preview/DeletedServers.json
  - preview/2023-02-01-preview/DistributedAvailabilityGroups.json
  - preview/2023-02-01-preview/ElasticPoolOperations.json
  - preview/2023-02-01-preview/ElasticPools.json
  - preview/2023-02-01-preview/EncryptionProtectors.json
  - preview/2023-02-01-preview/EndpointCertificates.json
  - preview/2023-02-01-preview/FailoverGroups.json
  - preview/2023-02-01-preview/FirewallRules.json
  - preview/2023-02-01-preview/GeoBackupPolicies.json
  - preview/2023-02-01-preview/IPv6FirewallRules.json
  - preview/2023-02-01-preview/InstanceFailoverGroups.json
  - preview/2023-02-01-preview/InstancePools.json
  - preview/2023-02-01-preview/JobAgents.json
  - preview/2023-02-01-preview/JobCredentials.json
  - preview/2023-02-01-preview/JobExecutions.json
  - preview/2023-02-01-preview/JobStepExecutions.json
  - preview/2023-02-01-preview/JobSteps.json
  - preview/2023-02-01-preview/JobTargetExecutions.json
  - preview/2023-02-01-preview/JobTargetGroups.json
  - preview/2023-02-01-preview/JobVersions.json
  - preview/2023-02-01-preview/Jobs.json
  - preview/2023-02-01-preview/LedgerDigestUploads.json
  - preview/2023-02-01-preview/LocationCapabilities.json
  - preview/2023-02-01-preview/LongTermRetentionBackups.json
  - preview/2023-02-01-preview/LongTermRetentionManagedInstanceBackups.json
  - preview/2023-02-01-preview/LongTermRetentionPolicies.json
  - preview/2023-02-01-preview/MaintenanceWindowOptions.json
  - preview/2023-02-01-preview/MaintenanceWindows.json
  - preview/2023-02-01-preview/ManagedBackupShortTermRetentionPolicies.json
  - preview/2023-02-01-preview/ManagedDatabaseAdvancedThreatProtectionSettings.json
  - preview/2023-02-01-preview/ManagedDatabaseColumns.json
  - preview/2023-02-01-preview/ManagedDatabaseMoveOperations.json
  - preview/2023-02-01-preview/ManagedDatabaseQueries.json
  - preview/2023-02-01-preview/ManagedDatabaseRestoreDetails.json
  - preview/2023-02-01-preview/ManagedDatabaseSchemas.json
  - preview/2023-02-01-preview/ManagedDatabaseSecurityAlertPolicies.json
  - preview/2023-02-01-preview/ManagedDatabaseSecurityEvents.json
  - preview/2023-02-01-preview/ManagedDatabaseSensitivityLabels.json
  - preview/2023-02-01-preview/ManagedDatabaseTables.json
  - preview/2023-02-01-preview/ManagedDatabaseTransparentDataEncryption.json
  - preview/2023-02-01-preview/ManagedDatabaseVulnerabilityAssessmentRuleBaselines.json
  - preview/2023-02-01-preview/ManagedDatabaseVulnerabilityAssessmentScans.json
  - preview/2023-02-01-preview/ManagedDatabaseVulnerabilityAssessments.json
  - preview/2023-02-01-preview/ManagedDatabases.json
  - preview/2023-02-01-preview/ManagedInstanceAdministrators.json
  - preview/2023-02-01-preview/ManagedInstanceAdvancedThreatProtectionSettings.json
  - preview/2023-02-01-preview/ManagedInstanceAzureADOnlyAuthentications.json
  - preview/2023-02-01-preview/ManagedInstanceDtcs.json
  - preview/2023-02-01-preview/ManagedInstanceEncryptionProtectors.json
  - preview/2023-02-01-preview/ManagedInstanceKeys.json
  - preview/2023-02-01-preview/ManagedInstanceLongTermRetentionPolicies.json
  - preview/2023-02-01-preview/ManagedInstanceOperations.json
  - preview/2023-02-01-preview/ManagedInstancePrivateEndpointConnections.json
  - preview/2023-02-01-preview/ManagedInstancePrivateLinkResources.json
  - preview/2023-02-01-preview/ManagedInstanceTdeCertificates.json
  - preview/2023-02-01-preview/ManagedInstanceVulnerabilityAssessments.json
  - preview/2023-02-01-preview/ManagedInstances.json
  - preview/2023-02-01-preview/ManagedLedgerDigestUploads.json
  - preview/2023-02-01-preview/ManagedRestorableDroppedDatabaseBackupShortTermRetentionPolicies.json
  - preview/2023-02-01-preview/ManagedServerDnsAliases.json
  - preview/2023-02-01-preview/ManagedServerSecurityAlertPolicies.json
  - preview/2023-02-01-preview/NetworkSecurityPerimeterConfigurations.json
  - preview/2023-02-01-preview/Operations.json
  - preview/2023-02-01-preview/OutboundFirewallRules.json
  - preview/2023-02-01-preview/PrivateEndpointConnections.json
  - preview/2023-02-01-preview/PrivateLinkResources.json
  - preview/2023-02-01-preview/RecoverableDatabases.json
  - preview/2023-02-01-preview/RecoverableManagedDatabases.json
  - preview/2023-02-01-preview/ReplicationLinks.json
  - preview/2023-02-01-preview/RestorableDroppedDatabases.json
  - preview/2023-02-01-preview/RestorableDroppedManagedDatabases.json
  - preview/2023-02-01-preview/RestorePoints.json
  - preview/2023-02-01-preview/SensitivityLabels.json
  - preview/2023-02-01-preview/ServerAdvancedThreatProtectionSettings.json
  - preview/2023-02-01-preview/ServerAdvisors.json
  - preview/2023-02-01-preview/ServerAutomaticTuning.json
  - preview/2023-02-01-preview/ServerAzureADAdministrators.json
  - preview/2023-02-01-preview/ServerAzureADOnlyAuthentications.json
  - preview/2023-02-01-preview/ServerConfigurationOptions.json
  - preview/2023-02-01-preview/ServerConnectionPolicies.json
  - preview/2023-02-01-preview/ServerDevOpsAudit.json
  - preview/2023-02-01-preview/ServerDnsAliases.json
  - preview/2023-02-01-preview/ServerKeys.json
  - preview/2023-02-01-preview/ServerOperations.json
  - preview/2023-02-01-preview/ServerSecurityAlertPolicies.json
  - preview/2023-02-01-preview/ServerTrustCertificates.json
  - preview/2023-02-01-preview/ServerTrustGroups.json
  - preview/2023-02-01-preview/ServerUsages.json
  - preview/2023-02-01-preview/ServerVulnerabilityAssessments.json
  - preview/2023-02-01-preview/Servers.json
  - preview/2023-02-01-preview/SqlAgent.json
  - preview/2023-02-01-preview/SqlVulnerabilityAssessmentBaseline.json
  - preview/2023-02-01-preview/SqlVulnerabilityAssessmentExecuteScan.json
  - preview/2023-02-01-preview/SqlVulnerabilityAssessmentRuleBaseline.json
  - preview/2023-02-01-preview/SqlVulnerabilityAssessmentScanResult.json
  - preview/2023-02-01-preview/SqlVulnerabilityAssessmentScans.json
  - preview/2023-02-01-preview/SqlVulnerabilityAssessmentsSettings.json
  - preview/2023-02-01-preview/StartStopManagedInstanceSchedules.json
  - preview/2023-02-01-preview/SubscriptionUsages.json
  - preview/2023-02-01-preview/SynapseLinkWorkspaces.json
  - preview/2023-02-01-preview/SyncAgents.json
  - preview/2023-02-01-preview/SyncGroups.json
  - preview/2023-02-01-preview/SyncMembers.json
  - preview/2023-02-01-preview/TdeCertificates.json
  - preview/2023-02-01-preview/TimeZones.json
  - preview/2023-02-01-preview/TransparentDataEncryptions.json
  - preview/2023-02-01-preview/Usages.json
  - preview/2023-02-01-preview/VirtualClusters.json
  - preview/2023-02-01-preview/VirtualNetworkRules.json
  - preview/2023-02-01-preview/WorkloadClassifiers.json
  - preview/2023-02-01-preview/WorkloadGroups.json
```

### Tag: package-preview-2022-11

These settings apply only when `--tag=package-preview-2022-11` is specified on the command line.

``` yaml $(tag) == 'package-preview-2022-11'
input-file:
  - preview/2022-11-01-preview/BackupShortTermRetentionPolicies.json
  - preview/2022-11-01-preview/BlobAuditing.json
  - preview/2022-11-01-preview/DataMaskingPolicies.json
  - preview/2022-11-01-preview/DataMaskingRules.json
  - preview/2022-11-01-preview/DataWarehouseUserActivities.json
  - preview/2022-11-01-preview/DatabaseAdvancedThreatProtectionSettings.json
  - preview/2022-11-01-preview/DatabaseAdvisors.json
  - preview/2022-11-01-preview/DatabaseAutomaticTuning.json
  - preview/2022-11-01-preview/DatabaseColumns.json
  - preview/2022-11-01-preview/DatabaseEncryptionProtectorRevalidate.json
  - preview/2022-11-01-preview/DatabaseEncryptionProtectorRevert.json
  - preview/2022-11-01-preview/DatabaseExtensions.json
  - preview/2022-11-01-preview/DatabaseOperations.json
  - preview/2022-11-01-preview/DatabaseRecommendedActions.json
  - preview/2022-11-01-preview/DatabaseSchemas.json
  - preview/2022-11-01-preview/DatabaseSecurityAlertPolicies.json
  - preview/2022-11-01-preview/DatabaseSqlVulnerabilityAssessmentBaselines.json
  - preview/2022-11-01-preview/DatabaseSqlVulnerabilityAssessmentExecuteScan.json
  - preview/2022-11-01-preview/DatabaseSqlVulnerabilityAssessmentRuleBaselines.json
  - preview/2022-11-01-preview/DatabaseSqlVulnerabilityAssessmentScanResult.json
  - preview/2022-11-01-preview/DatabaseSqlVulnerabilityAssessmentScans.json
  - preview/2022-11-01-preview/DatabaseSqlVulnerabilityAssessmentsSettings.json
  - preview/2022-11-01-preview/DatabaseTables.json
  - preview/2022-11-01-preview/DatabaseUsages.json
  - preview/2022-11-01-preview/DatabaseVulnerabilityAssessmentRuleBaselines.json
  - preview/2022-11-01-preview/DatabaseVulnerabilityAssessmentScans.json
  - preview/2022-11-01-preview/DatabaseVulnerabilityAssessments.json
  - preview/2022-11-01-preview/Databases.json
  - preview/2022-11-01-preview/DeletedServers.json
  - preview/2022-11-01-preview/DistributedAvailabilityGroups.json
  - preview/2022-11-01-preview/ElasticPoolOperations.json
  - preview/2022-11-01-preview/ElasticPools.json
  - preview/2022-11-01-preview/EncryptionProtectors.json
  - preview/2022-11-01-preview/EndpointCertificates.json
  - preview/2022-11-01-preview/FailoverGroups.json
  - preview/2022-11-01-preview/FirewallRules.json
  - preview/2022-11-01-preview/GeoBackupPolicies.json
  - preview/2022-11-01-preview/IPv6FirewallRules.json
  - preview/2022-11-01-preview/InstanceFailoverGroups.json
  - preview/2022-11-01-preview/InstancePools.json
  - preview/2022-11-01-preview/JobAgents.json
  - preview/2022-11-01-preview/JobCredentials.json
  - preview/2022-11-01-preview/JobExecutions.json
  - preview/2022-11-01-preview/JobStepExecutions.json
  - preview/2022-11-01-preview/JobSteps.json
  - preview/2022-11-01-preview/JobTargetExecutions.json
  - preview/2022-11-01-preview/JobTargetGroups.json
  - preview/2022-11-01-preview/JobVersions.json
  - preview/2022-11-01-preview/Jobs.json
  - preview/2022-11-01-preview/LedgerDigestUploads.json
  - preview/2022-11-01-preview/LocationCapabilities.json
  - preview/2022-11-01-preview/LongTermRetentionBackups.json
  - preview/2022-11-01-preview/LongTermRetentionManagedInstanceBackups.json
  - preview/2022-11-01-preview/LongTermRetentionPolicies.json
  - preview/2022-11-01-preview/MaintenanceWindowOptions.json
  - preview/2022-11-01-preview/MaintenanceWindows.json
  - preview/2022-11-01-preview/ManagedBackupShortTermRetentionPolicies.json
  - preview/2022-11-01-preview/ManagedDatabaseAdvancedThreatProtectionSettings.json
  - preview/2022-11-01-preview/ManagedDatabaseColumns.json
  - preview/2022-11-01-preview/ManagedDatabaseMoveOperations.json
  - preview/2022-11-01-preview/ManagedDatabaseQueries.json
  - preview/2022-11-01-preview/ManagedDatabaseRestoreDetails.json
  - preview/2022-11-01-preview/ManagedDatabaseSchemas.json
  - preview/2022-11-01-preview/ManagedDatabaseSecurityAlertPolicies.json
  - preview/2022-11-01-preview/ManagedDatabaseSecurityEvents.json
  - preview/2022-11-01-preview/ManagedDatabaseSensitivityLabels.json
  - preview/2022-11-01-preview/ManagedDatabaseTables.json
  - preview/2022-11-01-preview/ManagedDatabaseTransparentDataEncryption.json
  - preview/2022-11-01-preview/ManagedDatabaseVulnerabilityAssessmentRuleBaselines.json
  - preview/2022-11-01-preview/ManagedDatabaseVulnerabilityAssessmentScans.json
  - preview/2022-11-01-preview/ManagedDatabaseVulnerabilityAssessments.json
  - preview/2022-11-01-preview/ManagedDatabases.json
  - preview/2022-11-01-preview/ManagedInstanceAdministrators.json
  - preview/2022-11-01-preview/ManagedInstanceAdvancedThreatProtectionSettings.json
  - preview/2022-11-01-preview/ManagedInstanceAzureADOnlyAuthentications.json
  - preview/2022-11-01-preview/ManagedInstanceDtcs.json
  - preview/2022-11-01-preview/ManagedInstanceEncryptionProtectors.json
  - preview/2022-11-01-preview/ManagedInstanceKeys.json
  - preview/2022-11-01-preview/ManagedInstanceLongTermRetentionPolicies.json
  - preview/2022-11-01-preview/ManagedInstanceOperations.json
  - preview/2022-11-01-preview/ManagedInstancePrivateEndpointConnections.json
  - preview/2022-11-01-preview/ManagedInstancePrivateLinkResources.json
  - preview/2022-11-01-preview/ManagedInstanceTdeCertificates.json
  - preview/2022-11-01-preview/ManagedInstanceVulnerabilityAssessments.json
  - preview/2022-11-01-preview/ManagedInstances.json
  - preview/2022-11-01-preview/ManagedLedgerDigestUploads.json
  - preview/2022-11-01-preview/ManagedRestorableDroppedDatabaseBackupShortTermRetentionPolicies.json
  - preview/2022-11-01-preview/ManagedServerDnsAliases.json
  - preview/2022-11-01-preview/ManagedServerSecurityAlertPolicies.json
  - preview/2022-11-01-preview/NetworkSecurityPerimeterConfigurations.json
  - preview/2022-11-01-preview/Operations.json
  - preview/2022-11-01-preview/OutboundFirewallRules.json
  - preview/2022-11-01-preview/PrivateEndpointConnections.json
  - preview/2022-11-01-preview/PrivateLinkResources.json
  - preview/2022-11-01-preview/RecoverableDatabases.json
  - preview/2022-11-01-preview/RecoverableManagedDatabases.json
  - preview/2022-11-01-preview/ReplicationLinks.json
  - preview/2022-11-01-preview/RestorableDroppedDatabases.json
  - preview/2022-11-01-preview/RestorableDroppedManagedDatabases.json
  - preview/2022-11-01-preview/RestorePoints.json
  - preview/2022-11-01-preview/SensitivityLabels.json
  - preview/2022-11-01-preview/ServerAdvancedThreatProtectionSettings.json
  - preview/2022-11-01-preview/ServerAdvisors.json
  - preview/2022-11-01-preview/ServerAutomaticTuning.json
  - preview/2022-11-01-preview/ServerAzureADAdministrators.json
  - preview/2022-11-01-preview/ServerAzureADOnlyAuthentications.json
  - preview/2022-11-01-preview/ServerConfigurationOptions.json
  - preview/2022-11-01-preview/ServerConnectionPolicies.json
  - preview/2022-11-01-preview/ServerDevOpsAudit.json
  - preview/2022-11-01-preview/ServerDnsAliases.json
  - preview/2022-11-01-preview/ServerKeys.json
  - preview/2022-11-01-preview/ServerOperations.json
  - preview/2022-11-01-preview/ServerSecurityAlertPolicies.json
  - preview/2022-11-01-preview/ServerTrustCertificates.json
  - preview/2022-11-01-preview/ServerTrustGroups.json
  - preview/2022-11-01-preview/ServerUsages.json
  - preview/2022-11-01-preview/ServerVulnerabilityAssessments.json
  - preview/2022-11-01-preview/Servers.json
  - preview/2022-11-01-preview/SqlAgent.json
  - preview/2022-11-01-preview/SqlVulnerabilityAssessmentBaseline.json
  - preview/2022-11-01-preview/SqlVulnerabilityAssessmentExecuteScan.json
  - preview/2022-11-01-preview/SqlVulnerabilityAssessmentRuleBaseline.json
  - preview/2022-11-01-preview/SqlVulnerabilityAssessmentScanResult.json
  - preview/2022-11-01-preview/SqlVulnerabilityAssessmentScans.json
  - preview/2022-11-01-preview/SqlVulnerabilityAssessmentsSettings.json
  - preview/2022-11-01-preview/StartStopManagedInstanceSchedules.json
  - preview/2022-11-01-preview/SubscriptionUsages.json
  - preview/2022-11-01-preview/SynapseLinkWorkspaces.json
  - preview/2022-11-01-preview/SyncAgents.json
  - preview/2022-11-01-preview/SyncGroups.json
  - preview/2022-11-01-preview/SyncMembers.json
  - preview/2022-11-01-preview/TdeCertificates.json
  - preview/2022-11-01-preview/TimeZones.json
  - preview/2022-11-01-preview/TransparentDataEncryptions.json
  - preview/2022-11-01-preview/Usages.json
  - preview/2022-11-01-preview/VirtualClusters.json
  - preview/2022-11-01-preview/VirtualNetworkRules.json
  - preview/2022-11-01-preview/WorkloadClassifiers.json
  - preview/2022-11-01-preview/WorkloadGroups.json
```

### Tag: package-preview-2022-08

These settings apply only when `--tag=package-preview-2022-08` is specified on the command line.

``` yaml $(tag) == 'package-preview-2022-08'
input-file:
  - preview/2022-08-01-preview/BackupShortTermRetentionPolicies.json
  - preview/2022-08-01-preview/BlobAuditing.json
  - preview/2022-08-01-preview/DataMaskingPolicies.json
  - preview/2022-08-01-preview/DataMaskingRules.json
  - preview/2022-08-01-preview/DataWarehouseUserActivities.json
  - preview/2022-08-01-preview/DatabaseAdvancedThreatProtectionSettings.json
  - preview/2022-08-01-preview/DatabaseAdvisors.json
  - preview/2022-08-01-preview/DatabaseAutomaticTuning.json
  - preview/2022-08-01-preview/DatabaseColumns.json
  - preview/2022-08-01-preview/DatabaseEncryptionProtectorRevalidate.json
  - preview/2022-08-01-preview/DatabaseEncryptionProtectorRevert.json
  - preview/2022-08-01-preview/DatabaseExtensions.json
  - preview/2022-08-01-preview/DatabaseOperations.json
  - preview/2022-08-01-preview/DatabaseRecommendedActions.json
  - preview/2022-08-01-preview/DatabaseSchemas.json
  - preview/2022-08-01-preview/DatabaseSecurityAlertPolicies.json
  - preview/2022-08-01-preview/DatabaseSqlVulnerabilityAssessmentBaselines.json
  - preview/2022-08-01-preview/DatabaseSqlVulnerabilityAssessmentExecuteScan.json
  - preview/2022-08-01-preview/DatabaseSqlVulnerabilityAssessmentRuleBaselines.json
  - preview/2022-08-01-preview/DatabaseSqlVulnerabilityAssessmentScanResult.json
  - preview/2022-08-01-preview/DatabaseSqlVulnerabilityAssessmentScans.json
  - preview/2022-08-01-preview/DatabaseSqlVulnerabilityAssessmentsSettings.json
  - preview/2022-08-01-preview/DatabaseTables.json
  - preview/2022-08-01-preview/DatabaseUsages.json
  - preview/2022-08-01-preview/DatabaseVulnerabilityAssessmentRuleBaselines.json
  - preview/2022-08-01-preview/DatabaseVulnerabilityAssessmentScans.json
  - preview/2022-08-01-preview/DatabaseVulnerabilityAssessments.json
  - preview/2022-08-01-preview/Databases.json
  - preview/2022-08-01-preview/DeletedServers.json
  - preview/2022-08-01-preview/DistributedAvailabilityGroups.json
  - preview/2022-08-01-preview/ElasticPoolOperations.json
  - preview/2022-08-01-preview/ElasticPools.json
  - preview/2022-08-01-preview/EncryptionProtectors.json
  - preview/2022-08-01-preview/EndpointCertificates.json
  - preview/2022-08-01-preview/FailoverGroups.json
  - preview/2022-08-01-preview/FirewallRules.json
  - preview/2022-08-01-preview/GeoBackupPolicies.json
  - preview/2022-08-01-preview/IPv6FirewallRules.json
  - preview/2022-08-01-preview/InstanceFailoverGroups.json
  - preview/2022-08-01-preview/InstancePools.json
  - preview/2022-08-01-preview/JobAgents.json
  - preview/2022-08-01-preview/JobCredentials.json
  - preview/2022-08-01-preview/JobExecutions.json
  - preview/2022-08-01-preview/JobStepExecutions.json
  - preview/2022-08-01-preview/JobSteps.json
  - preview/2022-08-01-preview/JobTargetExecutions.json
  - preview/2022-08-01-preview/JobTargetGroups.json
  - preview/2022-08-01-preview/JobVersions.json
  - preview/2022-08-01-preview/Jobs.json
  - preview/2022-08-01-preview/LedgerDigestUploads.json
  - preview/2022-08-01-preview/LocationCapabilities.json
  - preview/2022-08-01-preview/LongTermRetentionBackups.json
  - preview/2022-08-01-preview/LongTermRetentionManagedInstanceBackups.json
  - preview/2022-08-01-preview/LongTermRetentionPolicies.json
  - preview/2022-08-01-preview/MaintenanceWindowOptions.json
  - preview/2022-08-01-preview/MaintenanceWindows.json
  - preview/2022-08-01-preview/ManagedBackupShortTermRetentionPolicies.json
  - preview/2022-08-01-preview/ManagedDatabaseAdvancedThreatProtectionSettings.json
  - preview/2022-08-01-preview/ManagedDatabaseColumns.json
  - preview/2022-08-01-preview/ManagedDatabaseMoveOperations.json
  - preview/2022-08-01-preview/ManagedDatabaseQueries.json
  - preview/2022-08-01-preview/ManagedDatabaseRestoreDetails.json
  - preview/2022-08-01-preview/ManagedDatabaseSchemas.json
  - preview/2022-08-01-preview/ManagedDatabaseSecurityAlertPolicies.json
  - preview/2022-08-01-preview/ManagedDatabaseSecurityEvents.json
  - preview/2022-08-01-preview/ManagedDatabaseSensitivityLabels.json
  - preview/2022-08-01-preview/ManagedDatabaseTables.json
  - preview/2022-08-01-preview/ManagedDatabaseTransparentDataEncryption.json
  - preview/2022-08-01-preview/ManagedDatabaseVulnerabilityAssessmentRuleBaselines.json
  - preview/2022-08-01-preview/ManagedDatabaseVulnerabilityAssessmentScans.json
  - preview/2022-08-01-preview/ManagedDatabaseVulnerabilityAssessments.json
  - preview/2022-08-01-preview/ManagedDatabases.json
  - preview/2022-08-01-preview/ManagedInstanceAdministrators.json
  - preview/2022-08-01-preview/ManagedInstanceAdvancedThreatProtectionSettings.json
  - preview/2022-08-01-preview/ManagedInstanceAzureADOnlyAuthentications.json
  - preview/2022-08-01-preview/ManagedInstanceDtcs.json
  - preview/2022-08-01-preview/ManagedInstanceEncryptionProtectors.json
  - preview/2022-08-01-preview/ManagedInstanceKeys.json
  - preview/2022-08-01-preview/ManagedInstanceLongTermRetentionPolicies.json
  - preview/2022-08-01-preview/ManagedInstanceOperations.json
  - preview/2022-08-01-preview/ManagedInstancePrivateEndpointConnections.json
  - preview/2022-08-01-preview/ManagedInstancePrivateLinkResources.json
  - preview/2022-08-01-preview/ManagedInstanceTdeCertificates.json
  - preview/2022-08-01-preview/ManagedInstanceVulnerabilityAssessments.json
  - preview/2022-08-01-preview/ManagedInstances.json
  - preview/2022-08-01-preview/ManagedLedgerDigestUploads.json
  - preview/2022-08-01-preview/ManagedRestorableDroppedDatabaseBackupShortTermRetentionPolicies.json
  - preview/2022-08-01-preview/ManagedServerDnsAliases.json
  - preview/2022-08-01-preview/ManagedServerSecurityAlertPolicies.json
  - preview/2022-08-01-preview/Operations.json
  - preview/2022-08-01-preview/OutboundFirewallRules.json
  - preview/2022-08-01-preview/PrivateEndpointConnections.json
  - preview/2022-08-01-preview/PrivateLinkResources.json
  - preview/2022-08-01-preview/RecoverableDatabases.json
  - preview/2022-08-01-preview/RecoverableManagedDatabases.json
  - preview/2022-08-01-preview/ReplicationLinks.json
  - preview/2022-08-01-preview/RestorableDroppedDatabases.json
  - preview/2022-08-01-preview/RestorableDroppedManagedDatabases.json
  - preview/2022-08-01-preview/RestorePoints.json
  - preview/2022-08-01-preview/SensitivityLabels.json
  - preview/2022-08-01-preview/ServerAdvancedThreatProtectionSettings.json
  - preview/2022-08-01-preview/ServerAdvisors.json
  - preview/2022-08-01-preview/ServerAutomaticTuning.json
  - preview/2022-08-01-preview/ServerAzureADAdministrators.json
  - preview/2022-08-01-preview/ServerAzureADOnlyAuthentications.json
  - preview/2022-08-01-preview/ServerConfigurationOptions.json
  - preview/2022-08-01-preview/ServerConnectionPolicies.json
  - preview/2022-08-01-preview/ServerDevOpsAudit.json
  - preview/2022-08-01-preview/ServerDnsAliases.json
  - preview/2022-08-01-preview/ServerKeys.json
  - preview/2022-08-01-preview/ServerOperations.json
  - preview/2022-08-01-preview/ServerSecurityAlertPolicies.json
  - preview/2022-08-01-preview/ServerTrustCertificates.json
  - preview/2022-08-01-preview/ServerTrustGroups.json
  - preview/2022-08-01-preview/ServerUsages.json
  - preview/2022-08-01-preview/ServerVulnerabilityAssessments.json
  - preview/2022-08-01-preview/Servers.json
  - preview/2022-08-01-preview/SqlAgent.json
  - preview/2022-08-01-preview/SqlVulnerabilityAssessmentBaseline.json
  - preview/2022-08-01-preview/SqlVulnerabilityAssessmentExecuteScan.json
  - preview/2022-08-01-preview/SqlVulnerabilityAssessmentRuleBaseline.json
  - preview/2022-08-01-preview/SqlVulnerabilityAssessmentScanResult.json
  - preview/2022-08-01-preview/SqlVulnerabilityAssessmentScans.json
  - preview/2022-08-01-preview/SqlVulnerabilityAssessmentsSettings.json
  - preview/2022-08-01-preview/StartStopManagedInstanceSchedules.json
  - preview/2022-08-01-preview/SubscriptionUsages.json
  - preview/2022-08-01-preview/SynapseLinkWorkspaces.json
  - preview/2022-08-01-preview/SyncAgents.json
  - preview/2022-08-01-preview/SyncGroups.json
  - preview/2022-08-01-preview/SyncMembers.json
  - preview/2022-08-01-preview/TdeCertificates.json
  - preview/2022-08-01-preview/TimeZones.json
  - preview/2022-08-01-preview/TransparentDataEncryptions.json
  - preview/2022-08-01-preview/Usages.json
  - preview/2022-08-01-preview/VirtualClusters.json
  - preview/2022-08-01-preview/VirtualNetworkRules.json
  - preview/2022-08-01-preview/WorkloadClassifiers.json
  - preview/2022-08-01-preview/WorkloadGroups.json
```

### Tag: package-2021-11

These settings apply only when `--tag=package-2021-11` is specified on the command line.

``` yaml $(tag) == 'package-2021-11'
input-file:
 - ./stable/2021-11-01/BackupShortTermRetentionPolicies.json
 - ./stable/2021-11-01/BlobAuditing.json
 - ./stable/2021-11-01/DatabaseAdvancedThreatProtectionSettings.json
 - ./stable/2021-11-01/DatabaseAdvisors.json
 - ./stable/2021-11-01/DatabaseAutomaticTuning.json
 - ./stable/2021-11-01/DatabaseColumns.json
 - ./stable/2021-11-01/DatabaseExtensions.json
 - ./stable/2021-11-01/DatabaseOperations.json
 - ./stable/2021-11-01/DatabaseRecommendedActions.json
 - ./stable/2021-11-01/Databases.json
 - ./stable/2021-11-01/DatabaseSchemas.json
 - ./stable/2021-11-01/DatabaseSecurityAlertPolicies.json
 - ./stable/2021-11-01/DatabaseTables.json
 - ./stable/2021-11-01/DatabaseUsages.json
 - ./stable/2021-11-01/DatabaseVulnerabilityAssessmentRuleBaselines.json
 - ./stable/2021-11-01/DatabaseVulnerabilityAssessments.json
 - ./stable/2021-11-01/DatabaseVulnerabilityAssessmentScans.json
 - ./stable/2021-11-01/DataMaskingPolicies.json
 - ./stable/2021-11-01/DataMaskingRules.json
 - ./stable/2021-11-01/DataWarehouseUserActivities.json
 - ./stable/2021-11-01/DeletedServers.json
 - ./stable/2021-11-01/DistributedAvailabilityGroups.json
 - ./stable/2021-11-01/ElasticPoolOperations.json
 - ./stable/2021-11-01/ElasticPools.json
 - ./stable/2021-11-01/EncryptionProtectors.json
 - ./stable/2021-11-01/EndpointCertificates.json
 - ./stable/2021-11-01/FailoverGroups.json
 - ./stable/2021-11-01/FirewallRules.json
 - ./stable/2021-11-01/GeoBackupPolicies.json
 - ./stable/2021-11-01/InstanceFailoverGroups.json
 - ./stable/2021-11-01/InstancePools.json
 - ./stable/2021-11-01/IPv6FirewallRules.json
 - ./stable/2021-11-01/JobAgents.json
 - ./stable/2021-11-01/JobCredentials.json
 - ./stable/2021-11-01/JobExecutions.json
 - ./stable/2021-11-01/Jobs.json
 - ./stable/2021-11-01/JobStepExecutions.json
 - ./stable/2021-11-01/JobSteps.json
 - ./stable/2021-11-01/JobTargetExecutions.json
 - ./stable/2021-11-01/JobTargetGroups.json
 - ./stable/2021-11-01/JobVersions.json
 - ./stable/2021-11-01/LedgerDigestUploads.json
 - ./stable/2021-11-01/LocationCapabilities.json
 - ./stable/2021-11-01/LongTermRetentionBackups.json
 - ./stable/2021-11-01/LongTermRetentionManagedInstanceBackups.json
 - ./stable/2021-11-01/LongTermRetentionPolicies.json
 - ./stable/2021-11-01/MaintenanceWindowOptions.json
 - ./stable/2021-11-01/MaintenanceWindows.json
 - ./stable/2021-11-01/ManagedBackupShortTermRetentionPolicies.json
 - ./stable/2021-11-01/ManagedDatabaseColumns.json
 - ./stable/2021-11-01/ManagedDatabaseQueries.json
 - ./stable/2021-11-01/ManagedDatabaseRestoreDetails.json
 - ./stable/2021-11-01/ManagedDatabases.json
 - ./stable/2021-11-01/ManagedDatabaseSchemas.json
 - ./stable/2021-11-01/ManagedDatabaseSecurityAlertPolicies.json
 - ./stable/2021-11-01/ManagedDatabaseSecurityEvents.json
 - ./stable/2021-11-01/ManagedDatabaseSensitivityLabels.json
 - ./stable/2021-11-01/ManagedDatabaseTables.json
 - ./stable/2021-11-01/ManagedDatabaseTransparentDataEncryption.json
 - ./stable/2021-11-01/ManagedDatabaseVulnerabilityAssessmentRuleBaselines.json
 - ./stable/2021-11-01/ManagedDatabaseVulnerabilityAssessments.json
 - ./stable/2021-11-01/ManagedDatabaseVulnerabilityAssessmentScans.json
 - ./stable/2021-11-01/ManagedInstanceAdministrators.json
 - ./stable/2021-11-01/ManagedInstanceAzureADOnlyAuthentications.json
 - ./stable/2021-11-01/ManagedInstanceEncryptionProtectors.json
 - ./stable/2021-11-01/ManagedInstanceKeys.json
 - ./stable/2021-11-01/ManagedInstanceLongTermRetentionPolicies.json
 - ./stable/2021-11-01/ManagedInstanceOperations.json
 - ./stable/2021-11-01/ManagedInstancePrivateEndpointConnections.json
 - ./stable/2021-11-01/ManagedInstancePrivateLinkResources.json
 - ./stable/2021-11-01/ManagedInstances.json
 - ./stable/2021-11-01/ManagedInstanceTdeCertificates.json
 - ./stable/2021-11-01/ManagedInstanceVulnerabilityAssessments.json
 - ./stable/2021-11-01/ManagedRestorableDroppedDatabaseBackupShortTermRetentionPolicies.json
 - ./stable/2021-11-01/ManagedServerDnsAliases.json
 - ./stable/2021-11-01/ManagedServerSecurityAlertPolicies.json
 - ./stable/2021-11-01/Operations.json
 - ./stable/2021-11-01/OutboundFirewallRules.json
 - ./stable/2021-11-01/PrivateEndpointConnections.json
 - ./stable/2021-11-01/PrivateLinkResources.json
 - ./stable/2021-11-01/RecoverableDatabases.json
 - ./stable/2021-11-01/RecoverableManagedDatabases.json
 - ./stable/2021-11-01/ReplicationLinks.json
 - ./stable/2021-11-01/RestorableDroppedDatabases.json
 - ./stable/2021-11-01/RestorableDroppedManagedDatabases.json
 - ./stable/2021-11-01/RestorePoints.json
 - ./stable/2021-11-01/SensitivityLabels.json
 - ./stable/2021-11-01/ServerAdvancedThreatProtectionSettings.json
 - ./stable/2021-11-01/ServerAdvisors.json
 - ./stable/2021-11-01/ServerAutomaticTuning.json
 - ./stable/2021-11-01/ServerAzureADAdministrators.json
 - ./stable/2021-11-01/ServerAzureADOnlyAuthentications.json
 - ./stable/2021-11-01/ServerConnectionPolicies.json
 - ./stable/2021-11-01/ServerDevOpsAudit.json
 - ./stable/2021-11-01/ServerDnsAliases.json
 - ./stable/2021-11-01/ServerKeys.json
 - ./stable/2021-11-01/ServerOperations.json
 - ./stable/2021-11-01/Servers.json
 - ./stable/2021-11-01/ServerSecurityAlertPolicies.json
 - ./stable/2021-11-01/ServerTrustCertificates.json
 - ./stable/2021-11-01/ServerTrustGroups.json
 - ./stable/2021-11-01/ServerUsages.json
 - ./stable/2021-11-01/ServerVulnerabilityAssessments.json
 - ./stable/2021-11-01/SqlAgent.json
 - ./stable/2021-11-01/SubscriptionUsages.json
 - ./stable/2021-11-01/SyncAgents.json
 - ./stable/2021-11-01/SyncGroups.json
 - ./stable/2021-11-01/SyncMembers.json
 - ./stable/2021-11-01/TdeCertificates.json
 - ./stable/2021-11-01/TimeZones.json
 - ./stable/2021-11-01/TransparentDataEncryptions.json
 - ./stable/2021-11-01/Usages.json
 - ./stable/2021-11-01/VirtualClusters.json
 - ./stable/2021-11-01/VirtualNetworkRules.json
 - ./stable/2021-11-01/WorkloadClassifiers.json
 - ./stable/2021-11-01/WorkloadGroups.json
```

### Tag: package-preview-2022-05

These settings apply only when `--tag=package-preview-2022-05` is specified on the command line.

``` yaml $(tag) == 'package-preview-2022-05'
input-file:
  - preview/2022-05-01-preview/BackupShortTermRetentionPolicies.json
  - preview/2022-05-01-preview/BlobAuditing.json
  - preview/2022-05-01-preview/DataMaskingPolicies.json
  - preview/2022-05-01-preview/DataMaskingRules.json
  - preview/2022-05-01-preview/DataWarehouseUserActivities.json
  - preview/2022-05-01-preview/DatabaseAdvancedThreatProtectionSettings.json
  - preview/2022-05-01-preview/DatabaseAdvisors.json
  - preview/2022-05-01-preview/DatabaseAutomaticTuning.json
  - preview/2022-05-01-preview/DatabaseColumns.json
  - preview/2022-05-01-preview/DatabaseExtensions.json
  - preview/2022-05-01-preview/DatabaseOperations.json
  - preview/2022-05-01-preview/DatabaseRecommendedActions.json
  - preview/2022-05-01-preview/DatabaseSchemas.json
  - preview/2022-05-01-preview/DatabaseSecurityAlertPolicies.json
  - preview/2022-05-01-preview/DatabaseSqlVulnerabilityAssessmentBaselines.json
  - preview/2022-05-01-preview/DatabaseSqlVulnerabilityAssessmentExecuteScan.json
  - preview/2022-05-01-preview/DatabaseSqlVulnerabilityAssessmentRuleBaselines.json
  - preview/2022-05-01-preview/DatabaseSqlVulnerabilityAssessmentScanResult.json
  - preview/2022-05-01-preview/DatabaseSqlVulnerabilityAssessmentScans.json
  - preview/2022-05-01-preview/DatabaseSqlVulnerabilityAssessmentsSettings.json
  - preview/2022-05-01-preview/DatabaseTables.json
  - preview/2022-05-01-preview/DatabaseUsages.json
  - preview/2022-05-01-preview/DatabaseVulnerabilityAssessmentRuleBaselines.json
  - preview/2022-05-01-preview/DatabaseVulnerabilityAssessmentScans.json
  - preview/2022-05-01-preview/DatabaseVulnerabilityAssessments.json
  - preview/2022-05-01-preview/Databases.json
  - preview/2022-05-01-preview/DeletedServers.json
  - preview/2022-05-01-preview/DistributedAvailabilityGroups.json
  - preview/2022-05-01-preview/ElasticPoolOperations.json
  - preview/2022-05-01-preview/ElasticPools.json
  - preview/2022-05-01-preview/EncryptionProtectors.json
  - preview/2022-05-01-preview/EndpointCertificates.json
  - preview/2022-05-01-preview/FailoverGroups.json
  - preview/2022-05-01-preview/FirewallRules.json
  - preview/2022-05-01-preview/GeoBackupPolicies.json
  - preview/2022-05-01-preview/IPv6FirewallRules.json
  - preview/2022-05-01-preview/InstanceFailoverGroups.json
  - preview/2022-05-01-preview/InstancePools.json
  - preview/2022-05-01-preview/JobAgents.json
  - preview/2022-05-01-preview/JobCredentials.json
  - preview/2022-05-01-preview/JobExecutions.json
  - preview/2022-05-01-preview/JobStepExecutions.json
  - preview/2022-05-01-preview/JobSteps.json
  - preview/2022-05-01-preview/JobTargetExecutions.json
  - preview/2022-05-01-preview/JobTargetGroups.json
  - preview/2022-05-01-preview/JobVersions.json
  - preview/2022-05-01-preview/Jobs.json
  - preview/2022-05-01-preview/LedgerDigestUploads.json
  - preview/2022-05-01-preview/LocationCapabilities.json
  - preview/2022-05-01-preview/LongTermRetentionBackups.json
  - preview/2022-05-01-preview/LongTermRetentionManagedInstanceBackups.json
  - preview/2022-05-01-preview/LongTermRetentionPolicies.json
  - preview/2022-05-01-preview/MaintenanceWindowOptions.json
  - preview/2022-05-01-preview/MaintenanceWindows.json
  - preview/2022-05-01-preview/ManagedBackupShortTermRetentionPolicies.json
  - preview/2022-05-01-preview/ManagedDatabaseAdvancedThreatProtectionSettings.json
  - preview/2022-05-01-preview/ManagedDatabaseColumns.json
  - preview/2022-05-01-preview/ManagedDatabaseMoveOperations.json
  - preview/2022-05-01-preview/ManagedDatabaseQueries.json
  - preview/2022-05-01-preview/ManagedDatabaseRestoreDetails.json
  - preview/2022-05-01-preview/ManagedDatabaseSchemas.json
  - preview/2022-05-01-preview/ManagedDatabaseSecurityAlertPolicies.json
  - preview/2022-05-01-preview/ManagedDatabaseSecurityEvents.json
  - preview/2022-05-01-preview/ManagedDatabaseSensitivityLabels.json
  - preview/2022-05-01-preview/ManagedDatabaseTables.json
  - preview/2022-05-01-preview/ManagedDatabaseTransparentDataEncryption.json
  - preview/2022-05-01-preview/ManagedDatabaseVulnerabilityAssessmentRuleBaselines.json
  - preview/2022-05-01-preview/ManagedDatabaseVulnerabilityAssessmentScans.json
  - preview/2022-05-01-preview/ManagedDatabaseVulnerabilityAssessments.json
  - preview/2022-05-01-preview/ManagedDatabases.json
  - preview/2022-05-01-preview/ManagedInstanceAdministrators.json
  - preview/2022-05-01-preview/ManagedInstanceAdvancedThreatProtectionSettings.json
  - preview/2022-05-01-preview/ManagedInstanceAzureADOnlyAuthentications.json
  - preview/2022-05-01-preview/ManagedInstanceDtcs.json
  - preview/2022-05-01-preview/ManagedInstanceEncryptionProtectors.json
  - preview/2022-05-01-preview/ManagedInstanceKeys.json
  - preview/2022-05-01-preview/ManagedInstanceLongTermRetentionPolicies.json
  - preview/2022-05-01-preview/ManagedInstanceOperations.json
  - preview/2022-05-01-preview/ManagedInstancePrivateEndpointConnections.json
  - preview/2022-05-01-preview/ManagedInstancePrivateLinkResources.json
  - preview/2022-05-01-preview/ManagedInstanceTdeCertificates.json
  - preview/2022-05-01-preview/ManagedInstanceVulnerabilityAssessments.json
  - preview/2022-05-01-preview/ManagedInstances.json
  - preview/2022-05-01-preview/ManagedRestorableDroppedDatabaseBackupShortTermRetentionPolicies.json
  - preview/2022-05-01-preview/ManagedServerDnsAliases.json
  - preview/2022-05-01-preview/ManagedServerSecurityAlertPolicies.json
  - preview/2022-05-01-preview/Operations.json
  - preview/2022-05-01-preview/OutboundFirewallRules.json
  - preview/2022-05-01-preview/PrivateEndpointConnections.json
  - preview/2022-05-01-preview/PrivateLinkResources.json
  - preview/2022-05-01-preview/RecoverableDatabases.json
  - preview/2022-05-01-preview/RecoverableManagedDatabases.json
  - preview/2022-05-01-preview/ReplicationLinks.json
  - preview/2022-05-01-preview/RestorableDroppedDatabases.json
  - preview/2022-05-01-preview/RestorableDroppedManagedDatabases.json
  - preview/2022-05-01-preview/RestorePoints.json
  - preview/2022-05-01-preview/SensitivityLabels.json
  - preview/2022-05-01-preview/ServerAdvancedThreatProtectionSettings.json
  - preview/2022-05-01-preview/ServerAdvisors.json
  - preview/2022-05-01-preview/ServerAutomaticTuning.json
  - preview/2022-05-01-preview/ServerAzureADAdministrators.json
  - preview/2022-05-01-preview/ServerAzureADOnlyAuthentications.json
  - preview/2022-05-01-preview/ServerConnectionPolicies.json
  - preview/2022-05-01-preview/ServerDevOpsAudit.json
  - preview/2022-05-01-preview/ServerDnsAliases.json
  - preview/2022-05-01-preview/ServerKeys.json
  - preview/2022-05-01-preview/ServerOperations.json
  - preview/2022-05-01-preview/ServerSecurityAlertPolicies.json
  - preview/2022-05-01-preview/ServerTrustCertificates.json
  - preview/2022-05-01-preview/ServerTrustGroups.json
  - preview/2022-05-01-preview/ServerUsages.json
  - preview/2022-05-01-preview/ServerVulnerabilityAssessments.json
  - preview/2022-05-01-preview/Servers.json
  - preview/2022-05-01-preview/SqlAgent.json
  - preview/2022-05-01-preview/SqlVulnerabilityAssessmentBaseline.json
  - preview/2022-05-01-preview/SqlVulnerabilityAssessmentExecuteScan.json
  - preview/2022-05-01-preview/SqlVulnerabilityAssessmentRuleBaseline.json
  - preview/2022-05-01-preview/SqlVulnerabilityAssessmentScanResult.json
  - preview/2022-05-01-preview/SqlVulnerabilityAssessmentScans.json
  - preview/2022-05-01-preview/SqlVulnerabilityAssessmentsSettings.json
  - preview/2022-05-01-preview/SubscriptionUsages.json
  - preview/2022-05-01-preview/SynapseLinkWorkspaces.json
  - preview/2022-05-01-preview/SyncAgents.json
  - preview/2022-05-01-preview/SyncGroups.json
  - preview/2022-05-01-preview/SyncMembers.json
  - preview/2022-05-01-preview/TdeCertificates.json
  - preview/2022-05-01-preview/TimeZones.json
  - preview/2022-05-01-preview/TransparentDataEncryptions.json
  - preview/2022-05-01-preview/Usages.json
  - preview/2022-05-01-preview/VirtualClusters.json
  - preview/2022-05-01-preview/VirtualNetworkRules.json
  - preview/2022-05-01-preview/WorkloadClassifiers.json
  - preview/2022-05-01-preview/WorkloadGroups.json
```

### Tag: package-preview-2022-02

These settings apply only when `--tag=package-preview-2022-02` is specified on the command line.

``` yaml $(tag) == 'package-preview-2022-02'
input-file:
 - ./preview/2022-02-01-preview/BackupShortTermRetentionPolicies.json
 - ./preview/2022-02-01-preview/BlobAuditing.json
 - ./preview/2022-02-01-preview/DatabaseAdvancedThreatProtectionSettings.json
 - ./preview/2022-02-01-preview/DatabaseAdvisors.json
 - ./preview/2022-02-01-preview/DatabaseAutomaticTuning.json
 - ./preview/2022-02-01-preview/DatabaseColumns.json
 - ./preview/2022-02-01-preview/DatabaseExtensions.json
 - ./preview/2022-02-01-preview/DatabaseOperations.json
 - ./preview/2022-02-01-preview/DatabaseRecommendedActions.json
 - ./preview/2022-02-01-preview/Databases.json
 - ./preview/2022-02-01-preview/DatabaseSchemas.json
 - ./preview/2022-02-01-preview/DatabaseSecurityAlertPolicies.json
 - ./preview/2022-02-01-preview/DatabaseSqlVulnerabilityAssessmentBaselines.json
 - ./preview/2022-02-01-preview/DatabaseSqlVulnerabilityAssessmentExecuteScan.json
 - ./preview/2022-02-01-preview/DatabaseSqlVulnerabilityAssessmentRuleBaselines.json
 - ./preview/2022-02-01-preview/DatabaseSqlVulnerabilityAssessmentScanResult.json
 - ./preview/2022-02-01-preview/DatabaseSqlVulnerabilityAssessmentScans.json
 - ./preview/2022-02-01-preview/DatabaseSqlVulnerabilityAssessmentsSettings.json
 - ./preview/2022-02-01-preview/DatabaseTables.json
 - ./preview/2022-02-01-preview/DatabaseUsages.json
 - ./preview/2022-02-01-preview/DatabaseVulnerabilityAssessmentRuleBaselines.json
 - ./preview/2022-02-01-preview/DatabaseVulnerabilityAssessments.json
 - ./preview/2022-02-01-preview/DatabaseVulnerabilityAssessmentScans.json
 - ./preview/2022-02-01-preview/DataMaskingPolicies.json
 - ./preview/2022-02-01-preview/DataMaskingRules.json
 - ./preview/2022-02-01-preview/DataWarehouseUserActivities.json
 - ./preview/2022-02-01-preview/DeletedServers.json
 - ./preview/2022-02-01-preview/DistributedAvailabilityGroups.json
 - ./preview/2022-02-01-preview/ElasticPoolOperations.json
 - ./preview/2022-02-01-preview/ElasticPools.json
 - ./preview/2022-02-01-preview/EncryptionProtectors.json
 - ./preview/2022-02-01-preview/EndpointCertificates.json
 - ./preview/2022-02-01-preview/FailoverGroups.json
 - ./preview/2022-02-01-preview/FirewallRules.json
 - ./preview/2022-02-01-preview/GeoBackupPolicies.json
 - ./preview/2022-02-01-preview/InstanceFailoverGroups.json
 - ./preview/2022-02-01-preview/InstancePools.json
 - ./preview/2022-02-01-preview/IPv6FirewallRules.json
 - ./preview/2022-02-01-preview/JobAgents.json
 - ./preview/2022-02-01-preview/JobCredentials.json
 - ./preview/2022-02-01-preview/JobExecutions.json
 - ./preview/2022-02-01-preview/Jobs.json
 - ./preview/2022-02-01-preview/JobStepExecutions.json
 - ./preview/2022-02-01-preview/JobSteps.json
 - ./preview/2022-02-01-preview/JobTargetExecutions.json
 - ./preview/2022-02-01-preview/JobTargetGroups.json
 - ./preview/2022-02-01-preview/JobVersions.json
 - ./preview/2022-02-01-preview/LedgerDigestUploads.json
 - ./preview/2022-02-01-preview/LocationCapabilities.json
 - ./preview/2022-02-01-preview/LongTermRetentionBackups.json
 - ./preview/2022-02-01-preview/LongTermRetentionManagedInstanceBackups.json
 - ./preview/2022-02-01-preview/LongTermRetentionPolicies.json
 - ./preview/2022-02-01-preview/MaintenanceWindowOptions.json
 - ./preview/2022-02-01-preview/MaintenanceWindows.json
 - ./preview/2022-02-01-preview/ManagedBackupShortTermRetentionPolicies.json
 - ./preview/2022-02-01-preview/ManagedDatabaseAdvancedThreatProtectionSettings.json
 - ./preview/2022-02-01-preview/ManagedDatabaseColumns.json
 - ./preview/2022-02-01-preview/ManagedDatabaseQueries.json
 - ./preview/2022-02-01-preview/ManagedDatabaseRestoreDetails.json
 - ./preview/2022-02-01-preview/ManagedDatabases.json
 - ./preview/2022-02-01-preview/ManagedDatabaseSchemas.json
 - ./preview/2022-02-01-preview/ManagedDatabaseSecurityAlertPolicies.json
 - ./preview/2022-02-01-preview/ManagedDatabaseSecurityEvents.json
 - ./preview/2022-02-01-preview/ManagedDatabaseSensitivityLabels.json
 - ./preview/2022-02-01-preview/ManagedDatabaseTables.json
 - ./preview/2022-02-01-preview/ManagedDatabaseTransparentDataEncryption.json
 - ./preview/2022-02-01-preview/ManagedDatabaseVulnerabilityAssessmentRuleBaselines.json
 - ./preview/2022-02-01-preview/ManagedDatabaseVulnerabilityAssessments.json
 - ./preview/2022-02-01-preview/ManagedDatabaseVulnerabilityAssessmentScans.json
 - ./preview/2022-02-01-preview/ManagedInstanceAdministrators.json
 - ./preview/2022-02-01-preview/ManagedInstanceAdvancedThreatProtectionSettings.json
 - ./preview/2022-02-01-preview/ManagedInstanceAzureADOnlyAuthentications.json
 - ./preview/2022-02-01-preview/ManagedInstanceDtcs.json
 - ./preview/2022-02-01-preview/ManagedInstanceEncryptionProtectors.json
 - ./preview/2022-02-01-preview/ManagedInstanceKeys.json
 - ./preview/2022-02-01-preview/ManagedInstanceLongTermRetentionPolicies.json
 - ./preview/2022-02-01-preview/ManagedInstanceOperations.json
 - ./preview/2022-02-01-preview/ManagedInstancePrivateEndpointConnections.json
 - ./preview/2022-02-01-preview/ManagedInstancePrivateLinkResources.json
 - ./preview/2022-02-01-preview/ManagedInstances.json
 - ./preview/2022-02-01-preview/ManagedInstanceTdeCertificates.json
 - ./preview/2022-02-01-preview/ManagedInstanceVulnerabilityAssessments.json
 - ./preview/2022-02-01-preview/ManagedRestorableDroppedDatabaseBackupShortTermRetentionPolicies.json
 - ./preview/2022-02-01-preview/ManagedServerDnsAliases.json
 - ./preview/2022-02-01-preview/ManagedServerSecurityAlertPolicies.json
 - ./preview/2022-02-01-preview/Operations.json
 - ./preview/2022-02-01-preview/OutboundFirewallRules.json
 - ./preview/2022-02-01-preview/PrivateEndpointConnections.json
 - ./preview/2022-02-01-preview/PrivateLinkResources.json
 - ./preview/2022-02-01-preview/RecoverableDatabases.json
 - ./preview/2022-02-01-preview/RecoverableManagedDatabases.json
 - ./preview/2022-02-01-preview/ReplicationLinks.json
 - ./preview/2022-02-01-preview/RestorableDroppedDatabases.json
 - ./preview/2022-02-01-preview/RestorableDroppedManagedDatabases.json
 - ./preview/2022-02-01-preview/RestorePoints.json
 - ./preview/2022-02-01-preview/SensitivityLabels.json
 - ./preview/2022-02-01-preview/ServerAdvancedThreatProtectionSettings.json
 - ./preview/2022-02-01-preview/ServerAdvisors.json
 - ./preview/2022-02-01-preview/ServerAutomaticTuning.json
 - ./preview/2022-02-01-preview/ServerAzureADAdministrators.json
 - ./preview/2022-02-01-preview/ServerAzureADOnlyAuthentications.json
 - ./preview/2022-02-01-preview/ServerConnectionPolicies.json
 - ./preview/2022-02-01-preview/ServerDevOpsAudit.json
 - ./preview/2022-02-01-preview/ServerDnsAliases.json
 - ./preview/2022-02-01-preview/ServerKeys.json
 - ./preview/2022-02-01-preview/ServerOperations.json
 - ./preview/2022-02-01-preview/Servers.json
 - ./preview/2022-02-01-preview/ServerSecurityAlertPolicies.json
 - ./preview/2022-02-01-preview/ServerTrustCertificates.json
 - ./preview/2022-02-01-preview/ServerTrustGroups.json
 - ./preview/2022-02-01-preview/ServerUsages.json
 - ./preview/2022-02-01-preview/ServerVulnerabilityAssessments.json
 - ./preview/2022-02-01-preview/SqlAgent.json
 - ./preview/2022-02-01-preview/SqlVulnerabilityAssessmentBaseline.json
 - ./preview/2022-02-01-preview/SqlVulnerabilityAssessmentExecuteScan.json
 - ./preview/2022-02-01-preview/SqlVulnerabilityAssessmentRuleBaseline.json
 - ./preview/2022-02-01-preview/SqlVulnerabilityAssessmentScanResult.json
 - ./preview/2022-02-01-preview/SqlVulnerabilityAssessmentScans.json
 - ./preview/2022-02-01-preview/SqlVulnerabilityAssessmentsSettings.json
 - ./preview/2022-02-01-preview/SubscriptionUsages.json
 - ./preview/2022-02-01-preview/SyncAgents.json
 - ./preview/2022-02-01-preview/SyncGroups.json
 - ./preview/2022-02-01-preview/SyncMembers.json
 - ./preview/2022-02-01-preview/TdeCertificates.json
 - ./preview/2022-02-01-preview/TimeZones.json
 - ./preview/2022-02-01-preview/TransparentDataEncryptions.json
 - ./preview/2022-02-01-preview/Usages.json
 - ./preview/2022-02-01-preview/VirtualClusters.json
 - ./preview/2022-02-01-preview/VirtualNetworkRules.json
 - ./preview/2022-02-01-preview/WorkloadClassifiers.json
 - ./preview/2022-02-01-preview/WorkloadGroups.json
```

### Tag: package-preview-2021-11

These settings apply only when `--tag=package-preview-2021-11` is specified on the command line.

``` yaml $(tag) == 'package-preview-2021-11'
input-file:
 - ./preview/2021-11-01-preview/BackupShortTermRetentionPolicies.json
 - ./preview/2021-11-01-preview/BlobAuditing.json
 - ./preview/2021-11-01-preview/DatabaseAdvancedThreatProtectionSettings.json
 - ./preview/2021-11-01-preview/DatabaseAdvisors.json
 - ./preview/2021-11-01-preview/DatabaseAutomaticTuning.json
 - ./preview/2021-11-01-preview/DatabaseColumns.json
 - ./preview/2021-11-01-preview/DatabaseExtensions.json
 - ./preview/2021-11-01-preview/DatabaseOperations.json
 - ./preview/2021-11-01-preview/DatabaseRecommendedActions.json
 - ./preview/2021-11-01-preview/Databases.json
 - ./preview/2021-11-01-preview/DatabaseSchemas.json
 - ./preview/2021-11-01-preview/DatabaseSecurityAlertPolicies.json
 - ./preview/2021-11-01-preview/DatabaseTables.json
 - ./preview/2021-11-01-preview/DatabaseUsages.json
 - ./preview/2021-11-01-preview/DatabaseVulnerabilityAssessmentRuleBaselines.json
 - ./preview/2021-11-01-preview/DatabaseVulnerabilityAssessments.json
 - ./preview/2021-11-01-preview/DatabaseVulnerabilityAssessmentScans.json
 - ./preview/2021-11-01-preview/DataWarehouseUserActivities.json
 - ./preview/2021-11-01-preview/DeletedServers.json
 - ./preview/2021-11-01-preview/DistributedAvailabilityGroups.json
 - ./preview/2021-11-01-preview/ElasticPoolOperations.json
 - ./preview/2021-11-01-preview/ElasticPools.json
 - ./preview/2021-11-01-preview/EncryptionProtectors.json
 - ./preview/2021-11-01-preview/EndpointCertificates.json
 - ./preview/2021-11-01-preview/FailoverGroups.json
 - ./preview/2021-11-01-preview/FirewallRules.json
 - ./preview/2021-11-01-preview/InstanceFailoverGroups.json
 - ./preview/2021-11-01-preview/InstancePools.json
 - ./preview/2021-11-01-preview/IPv6FirewallRules.json
 - ./preview/2021-11-01-preview/JobAgents.json
 - ./preview/2021-11-01-preview/JobCredentials.json
 - ./preview/2021-11-01-preview/JobExecutions.json
 - ./preview/2021-11-01-preview/Jobs.json
 - ./preview/2021-11-01-preview/JobStepExecutions.json
 - ./preview/2021-11-01-preview/JobSteps.json
 - ./preview/2021-11-01-preview/JobTargetExecutions.json
 - ./preview/2021-11-01-preview/JobTargetGroups.json
 - ./preview/2021-11-01-preview/JobVersions.json
 - ./preview/2021-11-01-preview/LedgerDigestUploads.json
 - ./preview/2021-11-01-preview/LocationCapabilities.json
 - ./preview/2021-11-01-preview/LongTermRetentionBackups.json
 - ./preview/2021-11-01-preview/LongTermRetentionManagedInstanceBackups.json
 - ./preview/2021-11-01-preview/LongTermRetentionPolicies.json
 - ./preview/2021-11-01-preview/MaintenanceWindowOptions.json
 - ./preview/2021-11-01-preview/MaintenanceWindows.json
 - ./preview/2021-11-01-preview/ManagedBackupShortTermRetentionPolicies.json
 - ./preview/2021-11-01-preview/ManagedDatabaseColumns.json
 - ./preview/2021-11-01-preview/ManagedDatabaseQueries.json
 - ./preview/2021-11-01-preview/ManagedDatabaseRestoreDetails.json
 - ./preview/2021-11-01-preview/ManagedDatabases.json
 - ./preview/2021-11-01-preview/ManagedDatabaseSchemas.json
 - ./preview/2021-11-01-preview/ManagedDatabaseSecurityAlertPolicies.json
 - ./preview/2021-11-01-preview/ManagedDatabaseSecurityEvents.json
 - ./preview/2021-11-01-preview/ManagedDatabaseSensitivityLabels.json
 - ./preview/2021-11-01-preview/ManagedDatabaseTables.json
 - ./preview/2021-11-01-preview/ManagedDatabaseTransparentDataEncryption.json
 - ./preview/2021-11-01-preview/ManagedDatabaseVulnerabilityAssessmentRuleBaselines.json
 - ./preview/2021-11-01-preview/ManagedDatabaseVulnerabilityAssessments.json
 - ./preview/2021-11-01-preview/ManagedDatabaseVulnerabilityAssessmentScans.json
 - ./preview/2021-11-01-preview/ManagedInstanceAdministrators.json
 - ./preview/2021-11-01-preview/ManagedInstanceAzureADOnlyAuthentications.json
 - ./preview/2021-11-01-preview/ManagedInstanceEncryptionProtectors.json
 - ./preview/2021-11-01-preview/ManagedInstanceKeys.json
 - ./preview/2021-11-01-preview/ManagedInstanceLongTermRetentionPolicies.json
 - ./preview/2021-11-01-preview/ManagedInstanceOperations.json
 - ./preview/2021-11-01-preview/ManagedInstancePrivateEndpointConnections.json
 - ./preview/2021-11-01-preview/ManagedInstancePrivateLinkResources.json
 - ./preview/2021-11-01-preview/ManagedInstances.json
 - ./preview/2021-11-01-preview/ManagedInstanceTdeCertificates.json
 - ./preview/2021-11-01-preview/ManagedInstanceVulnerabilityAssessments.json
 - ./preview/2021-11-01-preview/ManagedRestorableDroppedDatabaseBackupShortTermRetentionPolicies.json
 - ./preview/2021-11-01-preview/ManagedServerDnsAliases.json
 - ./preview/2021-11-01-preview/ManagedServerSecurityAlertPolicies.json
 - ./preview/2021-11-01-preview/Operations.json
 - ./preview/2021-11-01-preview/OutboundFirewallRules.json
 - ./preview/2021-11-01-preview/PrivateEndpointConnections.json
 - ./preview/2021-11-01-preview/PrivateLinkResources.json
 - ./preview/2021-11-01-preview/RecoverableManagedDatabases.json
 - ./preview/2021-11-01-preview/ReplicationLinks.json
 - ./preview/2021-11-01-preview/RestorableDroppedDatabases.json
 - ./preview/2021-11-01-preview/RestorableDroppedManagedDatabases.json
 - ./preview/2021-11-01-preview/RestorePoints.json
 - ./preview/2021-11-01-preview/SensitivityLabels.json
 - ./preview/2021-11-01-preview/ServerAdvancedThreatProtectionSettings.json
 - ./preview/2021-11-01-preview/ServerAdvisors.json
 - ./preview/2021-11-01-preview/ServerAutomaticTuning.json
 - ./preview/2021-11-01-preview/ServerAzureADAdministrators.json
 - ./preview/2021-11-01-preview/ServerAzureADOnlyAuthentications.json
 - ./preview/2021-11-01-preview/ServerConnectionPolicies.json
 - ./preview/2021-11-01-preview/ServerDevOpsAudit.json
 - ./preview/2021-11-01-preview/ServerDnsAliases.json
 - ./preview/2021-11-01-preview/ServerKeys.json
 - ./preview/2021-11-01-preview/ServerOperations.json
 - ./preview/2021-11-01-preview/Servers.json
 - ./preview/2021-11-01-preview/ServerSecurityAlertPolicies.json
 - ./preview/2021-11-01-preview/ServerTrustCertificates.json
 - ./preview/2021-11-01-preview/ServerTrustGroups.json
 - ./preview/2021-11-01-preview/ServerVulnerabilityAssessments.json
 - ./preview/2021-11-01-preview/SqlAgent.json
 - ./preview/2021-11-01-preview/SubscriptionUsages.json
 - ./preview/2021-11-01-preview/SyncAgents.json
 - ./preview/2021-11-01-preview/SyncGroups.json
 - ./preview/2021-11-01-preview/SyncMembers.json
 - ./preview/2021-11-01-preview/TdeCertificates.json
 - ./preview/2021-11-01-preview/TimeZones.json
 - ./preview/2021-11-01-preview/TransparentDataEncryptions.json
 - ./preview/2021-11-01-preview/Usages.json
 - ./preview/2021-11-01-preview/VirtualClusters.json
 - ./preview/2021-11-01-preview/VirtualNetworkRules.json
 - ./preview/2021-11-01-preview/WorkloadClassifiers.json
 - ./preview/2021-11-01-preview/WorkloadGroups.json
```

### Tag: package-composite-v5

These settings apply only when `--tag=package-composite-v5` is specified on the command line.

This section contains the "composite-v5" set of APIs, which is composed from a selection of api-versions that will remain backwards compatible with "v5" clients such as .NET SDK Microsoft.Azure.Management.Sql version 1.44.3.0-preview.

APIs must only be added to this section when the API is publicly available in at least 1 production region and at least 1 generated client has been tested end-to-end.

``` yaml $(tag) == 'package-composite-v5'
input-file:
- ./preview/2020-11-01-preview/DatabaseAdvisors.json
- ./preview/2020-11-01-preview/DatabaseAutomaticTuning.json
- ./preview/2020-11-01-preview/DatabaseColumns.json
- ./preview/2020-11-01-preview/DatabaseRecommendedActions.json
- ./preview/2020-11-01-preview/DatabaseSchemas.json
- ./preview/2020-11-01-preview/DatabaseSecurityAlertPolicies.json
- ./preview/2020-11-01-preview/DatabaseTables.json
- ./preview/2020-11-01-preview/DatabaseVulnerabilityAssesmentRuleBaselines.json
- ./preview/2020-11-01-preview/DatabaseVulnerabilityAssessments.json
- ./preview/2020-11-01-preview/DatabaseVulnerabilityAssessmentScans.json
- ./preview/2020-11-01-preview/DataWarehouseUserActivities.json
- ./preview/2020-11-01-preview/DeletedServers.json
- ./preview/2020-11-01-preview/ElasticPoolOperations.json
- ./preview/2020-11-01-preview/EncryptionProtectors.json
- ./preview/2020-11-01-preview/FirewallRules.json
- ./preview/2020-11-01-preview/JobAgents.json
- ./preview/2020-11-01-preview/JobCredentials.json
- ./preview/2020-11-01-preview/JobExecutions.json
- ./preview/2023-05-01-preview/JobPrivateEndpoints.json
- ./preview/2020-11-01-preview/Jobs.json
- ./preview/2020-11-01-preview/JobStepExecutions.json
- ./preview/2020-11-01-preview/JobSteps.json
- ./preview/2020-11-01-preview/JobTargetExecutions.json
- ./preview/2020-11-01-preview/JobTargetGroups.json
- ./preview/2020-11-01-preview/JobVersions.json
- ./preview/2020-11-01-preview/LocationCapabilities.json
- ./preview/2020-11-01-preview/MaintenanceWindowOptions.json
- ./preview/2020-11-01-preview/MaintenanceWindows.json
- ./preview/2020-11-01-preview/ManagedBackupShortTermRetentionPolicies.json
- ./preview/2020-11-01-preview/ManagedDatabaseColumns.json
- ./preview/2020-11-01-preview/ManagedDatabaseQueries.json
- ./preview/2020-11-01-preview/ManagedDatabaseSchemas.json
- ./preview/2020-11-01-preview/ManagedDatabaseSecurityAlertPolicies.json
- ./preview/2020-11-01-preview/ManagedDatabaseSecurityEvents.json
- ./preview/2020-11-01-preview/ManagedDatabaseTables.json
- ./preview/2020-11-01-preview/ManagedDatabaseTransparentDataEncryption.json
- ./preview/2020-11-01-preview/ManagedDatabaseVulnerabilityAssessmentRuleBaselines.json
- ./preview/2020-11-01-preview/ManagedDatabaseVulnerabilityAssessments.json
- ./preview/2020-11-01-preview/ManagedDatabaseVulnerabilityAssessmentScans.json
- ./preview/2020-11-01-preview/ManagedInstanceAdministrators.json
- ./preview/2020-11-01-preview/ManagedInstanceAzureADOnlyAuthentications.json
- ./preview/2020-11-01-preview/ManagedInstanceEncryptionProtectors.json
- ./preview/2020-11-01-preview/ManagedInstanceKeys.json
- ./preview/2020-11-01-preview/ManagedInstanceLongTermRetentionPolicies.json
- ./preview/2020-11-01-preview/ManagedInstanceOperations.json
- ./preview/2020-11-01-preview/ManagedInstancePrivateEndpointConnections.json
- ./preview/2020-11-01-preview/ManagedInstancePrivateLinkResources.json
- ./preview/2020-11-01-preview/ManagedInstanceTdeCertificates.json
- ./preview/2020-11-01-preview/ManagedInstanceVulnerabilityAssessments.json
- ./preview/2020-11-01-preview/ManagedRestorableDroppedDatabaseBackupShortTermRetentionPolicies.json
- ./preview/2020-11-01-preview/ManagedServerSecurityAlertPolicies.json
- ./preview/2020-11-01-preview/Operations.json
- ./preview/2022-08-01-preview/PrivateEndpointConnections.json
- ./preview/2020-11-01-preview/PrivateLinkResources.json
- ./preview/2020-11-01-preview/RecoverableManagedDatabases.json
- ./preview/2020-11-01-preview/RestorePoints.json
- ./preview/2020-11-01-preview/ServerAdvisors.json
- ./preview/2020-11-01-preview/ServerAutomaticTuning.json
- ./preview/2020-11-01-preview/ServerAzureADAdministrators.json
- ./preview/2020-11-01-preview/ServerAzureADOnlyAuthentications.json
- ./preview/2022-02-01-preview/ServerDevOpsAudit.json
- ./preview/2020-11-01-preview/ServerDnsAliases.json
- ./preview/2020-11-01-preview/ServerKeys.json
- ./preview/2020-11-01-preview/ServerOperations.json
- ./preview/2020-11-01-preview/ServerSecurityAlertPolicies.json
- ./preview/2020-11-01-preview/ServerTrustGroups.json
- ./preview/2020-11-01-preview/ServerVulnerabilityAssessments.json
- ./preview/2020-11-01-preview/SqlAgent.json
- ./preview/2020-11-01-preview/SubscriptionUsages.json
- ./preview/2020-11-01-preview/SyncAgents.json
- ./preview/2020-11-01-preview/SyncGroups.json
- ./preview/2020-11-01-preview/SyncMembers.json
- ./preview/2020-11-01-preview/TdeCertificates.json
- ./preview/2020-11-01-preview/TimeZones.json
- ./preview/2020-11-01-preview/VirtualNetworkRules.json
- ./preview/2020-11-01-preview/WorkloadClassifiers.json
- ./preview/2020-11-01-preview/WorkloadGroups.json
- ./preview/2021-02-01-preview/BackupShortTermRetentionPolicies.json
- ./preview/2021-02-01-preview/DatabaseExtensions.json
- ./preview/2021-02-01-preview/DatabaseUsages.json
- ./preview/2021-02-01-preview/LedgerDigestUploads.json
- ./preview/2021-02-01-preview/OutboundFirewallRules.json
- ./preview/2021-02-01-preview/Usages.json
- ./preview/2021-05-01-preview/LongTermRetentionManagedInstanceBackups.json
- ./preview/2021-05-01-preview/RestorableDroppedManagedDatabases.json
- ./preview/2021-05-01-preview/ServerConnectionPolicies.json
- ./preview/2021-11-01-preview/ServerTrustCertificates.json
- ./preview/2021-11-01-preview/EndpointCertificates.json
- ./preview/2020-11-01-preview/ManagedDatabaseSensitivityLabels.json
- ./preview/2020-11-01-preview/SensitivityLabels.json
- ./preview/2021-11-01-preview/BlobAuditing.json
- ./preview/2021-11-01-preview/DatabaseAdvancedThreatProtectionSettings.json
- ./preview/2021-11-01-preview/ServerAdvancedThreatProtectionSettings.json
- ./preview/2021-11-01-preview/ManagedServerDnsAliases.json
- ./preview/2022-02-01-preview/ManagedDatabaseAdvancedThreatProtectionSettings.json
- ./preview/2022-02-01-preview/ManagedInstanceAdvancedThreatProtectionSettings.json
- ./preview/2022-05-01-preview/ManagedDatabaseMoveOperations.json
- ./preview/2022-05-01-preview/ManagedInstanceDtcs.json
- ./preview/2022-05-01-preview/SynapseLinkWorkspaces.json
- ./preview/2022-05-01-preview/VirtualClusters.json
- ./preview/2022-05-01-preview/InstanceFailoverGroups.json
- ./preview/2022-05-01-preview/ManagedDatabaseRestoreDetails.json
- ./preview/2022-08-01-preview/DatabaseEncryptionProtectorRevalidate.json
- ./preview/2022-08-01-preview/DatabaseEncryptionProtectorRevert.json
- ./preview/2023-02-01-preview/Databases.json
- ./preview/2022-08-01-preview/ElasticPools.json
- ./preview/2022-08-01-preview/ManagedDatabases.json
- ./preview/2022-08-01-preview/ManagedLedgerDigestUploads.json
- ./preview/2022-08-01-preview/RecoverableDatabases.json
- ./preview/2022-08-01-preview/RestorableDroppedDatabases.json
- ./preview/2022-08-01-preview/ServerConfigurationOptions.json
- ./preview/2022-08-01-preview/StartStopManagedInstanceSchedules.json
- ./preview/2022-08-01-preview/TransparentDataEncryptions.json
- ./preview/2022-11-01-preview/IPv6FirewallRules.json
- ./preview/2022-11-01-preview/SqlVulnerabilityAssessmentBaseline.json
- ./preview/2022-11-01-preview/SqlVulnerabilityAssessmentExecuteScan.json
- ./preview/2022-11-01-preview/SqlVulnerabilityAssessmentRuleBaseline.json
- ./preview/2022-11-01-preview/SqlVulnerabilityAssessmentScanResult.json
- ./preview/2022-11-01-preview/SqlVulnerabilityAssessmentScans.json
- ./preview/2022-11-01-preview/SqlVulnerabilityAssessmentsSettings.json
- ./preview/2022-11-01-preview/DatabaseSqlVulnerabilityAssessmentBaselines.json
- ./preview/2022-11-01-preview/DatabaseSqlVulnerabilityAssessmentExecuteScan.json
- ./preview/2022-11-01-preview/DatabaseSqlVulnerabilityAssessmentRuleBaselines.json
- ./preview/2022-11-01-preview/DatabaseSqlVulnerabilityAssessmentScanResult.json
- ./preview/2022-11-01-preview/DatabaseSqlVulnerabilityAssessmentScans.json
- ./preview/2022-11-01-preview/DatabaseSqlVulnerabilityAssessmentsSettings.json
- ./preview/2023-05-01-preview/FailoverGroups.json
- ./preview/2023-05-01-preview/InstancePools.json
- ./preview/2023-05-01-preview/ManagedInstances.json
- ./preview/2023-05-01-preview/ReplicationLinks.json
- ./preview/2023-08-01-preview/DistributedAvailabilityGroups.json
- ./preview/2024-11-01-preview/Servers.json
- ./preview/2024-11-01-preview/LongTermRetentionBackups.json
- ./preview/2024-11-01-preview/LongTermRetentionPolicies.json
- ./preview/2024-11-01-preview/DatabaseOperations.json

# Needed when there is more than one input file
override-info:
  title: SqlManagementClient
```

### Tag: package-composite-v4

These settings apply only when `--tag=package-composite-v4` is specified on the command line.

This section contains the "composite-v4" set of APIs, which is composed from a selection of api-versions that will remain backwards compatible with "v4" clients such as .NET SDK Microsoft.Azure.Management.Sql version 1.44.3.0-preview.

APIs must only be added to this section when the API is publicly available in at least 1 production region and at least 1 generated client has been tested end-to-end.

Differences in v4 (compared to v3):

* Added new API for databases and elastic pools

* Failover API for elastic pools was integrated into elasticPools

``` yaml $(tag) == 'package-composite-v4'
input-file:
- preview/2015-05-01-preview/databaseAutomaticTuning.json
- preview/2015-05-01-preview/encryptionProtectors.json
- preview/2015-05-01-preview/failoverGroups.json
- preview/2015-05-01-preview/operations.json
- preview/2015-05-01-preview/serverKeys.json
- preview/2015-05-01-preview/syncAgents.json
- preview/2015-05-01-preview/usages.json
- preview/2015-05-01-preview/virtualclusters.json
- preview/2015-05-01-preview/virtualNetworkRules.json
- preview/2017-03-01-preview/blobAuditing.json
- preview/2017-03-01-preview/databaseVulnerabilityAssessmentBaselines.json
- preview/2017-03-01-preview/databaseVulnerabilityAssessments.json
- preview/2017-03-01-preview/jobs.json
- preview/2017-03-01-preview/ManagedBackupShortTermRetention.json
- preview/2017-03-01-preview/ManagedRestorableDroppedDatabaseBackupShortTermRetenion.json
- preview/2017-03-01-preview/serverAutomaticTuning.json
- preview/2017-03-01-preview/serverDnsAliases.json
- preview/2017-03-01-preview/serverSecurityAlertPolicies.json
- preview/2017-03-01-preview/restorableDroppedManagedDatabases.json
- preview/2017-03-01-preview/restorePoints.json
- preview/2017-03-01-preview/ManagedDatabaseSecurityAlertPolicies.json
- preview/2017-03-01-preview/ManagedServerSecurityAlertPolicy.json
- preview/2017-03-01-preview/SensitivityLabels.json
- preview/2017-03-01-preview/managedInstanceAdministrators.json
- preview/2017-10-01-preview/cancelOperations.json
- preview/2017-10-01-preview/cancelPoolOperations.json
- preview/2017-10-01-preview/databaseVulnerabilityAssessmentScans.json
- preview/2017-10-01-preview/managedDatabaseVulnerabilityAssesmentRuleBaselines.json
- preview/2017-10-01-preview/managedDatabaseVulnerabilityAssessmentScans.json
- preview/2017-10-01-preview/managedDatabaseVulnerabilityAssessments.json
- preview/2017-10-01-preview/instanceFailoverGroups.json
- preview/2017-10-01-preview/TdeCertificates.json
- preview/2017-10-01-preview/ManagedInstanceTdeCertificates.json
- preview/2017-10-01-preview/ManagedInstanceKeys.json
- preview/2017-10-01-preview/ManagedInstanceEncryptionProtectors.json
- preview/2017-10-01-preview/recoverableManagedDatabases.json
- preview/2017-10-01-preview/shortTermRetentionPolicies.json
- preview/2018-06-01-preview/ManagedInstanceVulnerabilityAssessments.json
- preview/2018-06-01-preview/ServerVulnerabilityAssessments.json
- preview/2018-06-01-preview/managedDatabaseSensitivityLabels.json
- preview/2018-06-01-preview/instancePools.json
- preview/2018-06-01-preview/usages.json
- preview/2018-06-01-preview/PrivateLinkResources.json
- preview/2019-06-01-preview/servers.json
- preview/2020-08-01-preview/LocationCapabilities.json
- preview/2018-06-01-preview/LongTermRetentionManagedInstanceBackups.json
- preview/2018-06-01-preview/ManagedInstanceLongTermRetentionPolicies.json
- preview/2019-06-01-preview/WorkloadGroups.json
- preview/2019-06-01-preview/WorkloadClassifiers.json
- preview/2019-06-01-preview/managedInstanceOperations.json
- preview/2019-06-01-preview/ServerAzureADAdministrators.json
- preview/2019-06-01-preview/syncGroups.json
- preview/2019-06-01-preview/syncMembers.json
- preview/2020-02-02-preview/ImportExport.json
- preview/2020-02-02-preview/ManagedDatabases.json
- preview/2020-02-02-preview/ManagedDatabaseRestoreDetails.json
- preview/2020-02-02-preview/ServerAzureADOnlyAuthentications.json
- preview/2020-02-02-preview/ManagedInstances.json
- preview/2020-02-02-preview/ManagedInstanceAzureADOnlyAuthentications.json
- preview/2020-02-02-preview/ServerTrustGroups.json
- preview/2020-08-01-preview/ElasticPools.json
- preview/2020-08-01-preview/ServerDevOpsAudit.json
- preview/2020-11-01-preview/Databases_legacy.json
- preview/2020-11-01-preview/LongTermRetentionBackups.json
- preview/2020-11-01-preview/LongTermRetentionPolicies.json
- preview/2020-11-01-preview/PrivateEndpointConnections.json


# Needed when there is more than one input file
override-info:
  title: SqlManagementClient
```

### Tag: package-composite-v3

These settings apply only when `--tag=package-composite-v3` is specified on the command line.

This section contains the "composite-v3" set of APIs, which is composed from a selection of api-versions that will remain backwards compatible with "v3" clients such as .NET SDK Microsoft.Azure.Management.Sql version 1.14.0-preview.

APIs must only be added to this section when the API is publicly available in at least 1 production region and at least 1 generated client has been tested end-to-end.

Differences in v3 (compared to v2):

* Decoupled database and recommended elastic pool APIs

  * `-2014-04-01/recommendedElasticPools.json`

  * `+2014-04-01/recommendedElasticPoolsDecoupled.json`

* Updated to new Sku-based API for databases and elastic pools

  * `-2014-04-01/capabilities.json`

  * `-2014-04-01/databases.json`

  * `-2014-04-01/elasticPools.json`

  * `+2017-10-01-preview/capabilities.json`

  * `+2017-10-01-preview/elasticPools.json`

  * `+2018-06-01-preview/capabilities.json`

``` yaml $(tag) == 'package-composite-v3'
input-file:
- preview/2015-05-01-preview/databaseAutomaticTuning.json
- preview/2015-05-01-preview/encryptionProtectors.json
- preview/2015-05-01-preview/failoverGroups.json
- preview/2015-05-01-preview/operations.json
- preview/2015-05-01-preview/serverKeys.json
- preview/2015-05-01-preview/syncAgents.json
- preview/2015-05-01-preview/usages.json
- preview/2015-05-01-preview/virtualclusters.json
- preview/2015-05-01-preview/virtualNetworkRules.json
- preview/2017-03-01-preview/blobAuditing.json
- preview/2017-03-01-preview/databaseVulnerabilityAssessmentBaselines.json
- preview/2017-03-01-preview/databaseVulnerabilityAssessments.json
- preview/2017-03-01-preview/jobs.json
- preview/2017-03-01-preview/longTermRetention.json
- preview/2017-03-01-preview/ManagedBackupShortTermRetention.json
- preview/2017-03-01-preview/ManagedRestorableDroppedDatabaseBackupShortTermRetenion.json
- preview/2017-03-01-preview/serverAutomaticTuning.json
- preview/2017-03-01-preview/serverDnsAliases.json
- preview/2017-03-01-preview/serverSecurityAlertPolicies.json
- preview/2017-03-01-preview/restorableDroppedManagedDatabases.json
- preview/2017-03-01-preview/restorePoints.json
- preview/2017-03-01-preview/ManagedDatabaseSecurityAlertPolicies.json
- preview/2017-03-01-preview/ManagedServerSecurityAlertPolicy.json
- preview/2017-03-01-preview/SensitivityLabels.json
- preview/2017-03-01-preview/managedInstanceAdministrators.json
- preview/2017-10-01-preview/cancelOperations.json
- preview/2017-10-01-preview/cancelPoolOperations.json
- preview/2017-10-01-preview/elasticPools.json
- preview/2017-10-01-preview/databaseVulnerabilityAssessmentScans.json
- preview/2017-10-01-preview/managedDatabaseVulnerabilityAssesmentRuleBaselines.json
- preview/2017-10-01-preview/managedDatabaseVulnerabilityAssessmentScans.json
- preview/2017-10-01-preview/managedDatabaseVulnerabilityAssessments.json
- preview/2017-10-01-preview/instanceFailoverGroups.json
- preview/2017-10-01-preview/TdeCertificates.json
- preview/2017-10-01-preview/ManagedInstanceTdeCertificates.json
- preview/2017-10-01-preview/ManagedInstanceKeys.json
- preview/2017-10-01-preview/ManagedInstanceEncryptionProtectors.json
- preview/2017-10-01-preview/recoverableManagedDatabases.json
- preview/2017-10-01-preview/shortTermRetentionPolicies.json
- preview/2018-06-01-preview/ManagedInstanceVulnerabilityAssessments.json
- preview/2018-06-01-preview/ServerVulnerabilityAssessments.json
- preview/2018-06-01-preview/managedDatabaseSensitivityLabels.json
- preview/2018-06-01-preview/instancePools.json
- preview/2018-06-01-preview/usages.json
- preview/2018-06-01-preview/FailoverElasticPools.json
- preview/2018-06-01-preview/PrivateLinkResources.json
- preview/2019-06-01-preview/databases.json
- preview/2019-06-01-preview/servers.json
- preview/2018-06-01-preview/capabilities.json
- preview/2018-06-01-preview/LongTermRetentionManagedInstanceBackups.json
- preview/2018-06-01-preview/ManagedInstanceLongTermRetentionPolicies.json
- preview/2019-06-01-preview/WorkloadGroups.json
- preview/2019-06-01-preview/WorkloadClassifiers.json
- preview/2019-06-01-preview/managedInstanceOperations.json
- preview/2019-06-01-preview/ServerAzureADAdministrators.json
- preview/2019-06-01-preview/syncGroups.json
- preview/2019-06-01-preview/syncMembers.json
- preview/2020-02-02-preview/ImportExport.json
- preview/2020-02-02-preview/ManagedDatabases.json
- preview/2020-02-02-preview/ServerAzureADOnlyAuthentications.json
- preview/2020-02-02-preview/ManagedInstances.json
- preview/2020-02-02-preview/ManagedInstanceAzureADOnlyAuthentications.json
- preview/2020-02-02-preview/ServerTrustGroups.json
- preview/2020-11-01-preview/PrivateEndpointConnections.json


# Needed when there is more than one input file
override-info:
  title: SqlManagementClient
```

### Tag: package-composite-v2

These settings apply only when `--tag=package-composite-v2` is specified on the command line.

This section contains the "composite-v2" set of APIs, which is composed from a selection of api-versions that will remain backwards compatible with "v2" clients such as .NET SDK Microsoft.Azure.Management.Sql version 1.13.0-preview.

APIs must only be added to this section when the API is publicly available in at least 1 production region and at least 1 generated client has been tested end-to-end.

Differences in v2 (compared to v1):

* Updated to LTRv2

  * `-201 4-04-01/backupLongTermRetentionPolicies.json`

  * `-2014-04-01/backupLongTermRetentionVaults.json`

  * `+2017-03-01-preview/longTermRetention.json`

``` yaml $(tag) == 'package-composite-v2'
input-file:
- preview/2015-05-01-preview/databaseAutomaticTuning.json
- preview/2015-05-01-preview/encryptionProtectors.json
- preview/2015-05-01-preview/failoverGroups.json
- preview/2015-05-01-preview/operations.json
- preview/2015-05-01-preview/serverKeys.json
- preview/2015-05-01-preview/syncAgents.json
- preview/2015-05-01-preview/usages.json
- preview/2015-05-01-preview/virtualclusters.json
- preview/2015-05-01-preview/virtualNetworkRules.json
- preview/2017-03-01-preview/blobAuditing.json
- preview/2017-03-01-preview/databaseVulnerabilityAssessmentBaselines.json
- preview/2017-03-01-preview/databaseVulnerabilityAssessments.json
- preview/2017-03-01-preview/jobs.json
- preview/2017-03-01-preview/longTermRetention.json
- preview/2017-03-01-preview/ManagedBackupShortTermRetention.json
- preview/2017-03-01-preview/ManagedRestorableDroppedDatabaseBackupShortTermRetenion.json
- preview/2017-03-01-preview/renameDatabase.json
- preview/2017-03-01-preview/serverAutomaticTuning.json
- preview/2017-03-01-preview/serverDnsAliases.json
- preview/2017-03-01-preview/serverSecurityAlertPolicies.json
- preview/2017-03-01-preview/restorableDroppedManagedDatabases.json
- preview/2017-03-01-preview/restorePoints.json
- preview/2017-03-01-preview/ManagedDatabaseSecurityAlertPolicies.json
- preview/2017-03-01-preview/ManagedServerSecurityAlertPolicy.json
- preview/2017-03-01-preview/SensitivityLabels.json
- preview/2017-03-01-preview/managedInstanceAdministrators.json
- preview/2017-10-01-preview/cancelOperations.json
- preview/2017-10-01-preview/cancelPoolOperations.json
- preview/2017-10-01-preview/databaseVulnerabilityAssessmentScans.json
- preview/2017-10-01-preview/managedDatabaseVulnerabilityAssesmentRuleBaselines.json
- preview/2017-10-01-preview/managedDatabaseVulnerabilityAssessmentScans.json
- preview/2017-10-01-preview/managedDatabaseVulnerabilityAssessments.json
- preview/2017-10-01-preview/instanceFailoverGroups.json
- preview/2017-10-01-preview/shortTermRetentionPolicies.json
- preview/2017-10-01-preview/TdeCertificates.json
- preview/2017-10-01-preview/ManagedInstanceTdeCertificates.json
- preview/2017-10-01-preview/ManagedInstanceKeys.json
- preview/2017-10-01-preview/ManagedInstanceEncryptionProtectors.json
- preview/2017-10-01-preview/recoverableManagedDatabases.json
- preview/2018-06-01-preview/ManagedInstanceVulnerabilityAssessments.json
- preview/2018-06-01-preview/ServerVulnerabilityAssessments.json
- preview/2018-06-01-preview/managedDatabaseSensitivityLabels.json
- preview/2018-06-01-preview/instancePools.json
- preview/2018-06-01-preview/usages.json
- preview/2018-06-01-preview/FailoverDatabases.json
- preview/2018-06-01-preview/FailoverElasticPools.json
- preview/2018-06-01-preview/PrivateLinkResources.json
- preview/2019-06-01-preview/servers.json
- preview/2018-06-01-preview/LongTermRetentionManagedInstanceBackups.json
- preview/2018-06-01-preview/ManagedInstanceLongTermRetentionPolicies.json
- preview/2019-06-01-preview/WorkloadGroups.json
- preview/2019-06-01-preview/WorkloadClassifiers.json
- preview/2019-06-01-preview/ServerAzureADAdministrators.json
- preview/2019-06-01-preview/syncGroups.json
- preview/2019-06-01-preview/syncMembers.json
- preview/2020-02-02-preview/ManagedDatabases.json
- preview/2020-02-02-preview/ServerAzureADOnlyAuthentications.json
- preview/2020-02-02-preview/ManagedInstances.json
- preview/2020-02-02-preview/ManagedInstanceAzureADOnlyAuthentications.json
- preview/2020-02-02-preview/ServerTrustGroups.json
- preview/2020-11-01-preview/PrivateEndpointConnections.json

# Needed when there is more than one input file
override-info:
  title: SqlManagementClient
```

### Tag: package-composite-v1

These settings apply only when `--tag=package-composite-v1` is specified on the command line.

This section contains the "composite-v1" set of APIs, which is composed from a selection of api-versions that will remain backwards compatible with "v1" clients such as .NET SDK Microsoft.Azure.Management.Sql version 1.12.0-preview and earlier.

APIs must only be added to this section when the API is publicly available in at least 1 production region and at least 1 generated client has been tested end-to-end.

``` yaml $(tag) == 'package-composite-v1'
input-file:
- preview/2015-05-01-preview/databaseAutomaticTuning.json
- preview/2015-05-01-preview/encryptionProtectors.json
- preview/2015-05-01-preview/failoverGroups.json
- preview/2015-05-01-preview/operations.json
- preview/2015-05-01-preview/serverKeys.json
- preview/2015-05-01-preview/syncAgents.json
- preview/2015-05-01-preview/usages.json
- preview/2015-05-01-preview/virtualclusters.json
- preview/2015-05-01-preview/virtualNetworkRules.json
- preview/2017-03-01-preview/blobAuditing.json
- preview/2017-03-01-preview/databaseVulnerabilityAssessmentBaselines.json
- preview/2017-03-01-preview/databaseVulnerabilityAssessments.json
- preview/2017-03-01-preview/jobs.json
- preview/2017-03-01-preview/ManagedBackupShortTermRetention.json
- preview/2017-03-01-preview/ManagedRestorableDroppedDatabaseBackupShortTermRetenion.json
- preview/2017-03-01-preview/renameDatabase.json
- preview/2017-03-01-preview/serverAutomaticTuning.json
- preview/2017-03-01-preview/serverDnsAliases.json
- preview/2017-03-01-preview/serverSecurityAlertPolicies.json
- preview/2017-03-01-preview/restorableDroppedManagedDatabases.json
- preview/2017-03-01-preview/restorePoints.json
- preview/2017-03-01-preview/ManagedDatabaseSecurityAlertPolicies.json
- preview/2017-03-01-preview/ManagedServerSecurityAlertPolicy.json
- preview/2017-03-01-preview/SensitivityLabels.json
- preview/2017-03-01-preview/managedInstanceAdministrators.json
- preview/2017-10-01-preview/cancelOperations.json
- preview/2017-10-01-preview/cancelPoolOperations.json
- preview/2017-10-01-preview/databaseVulnerabilityAssessmentScans.json
- preview/2017-10-01-preview/managedDatabaseVulnerabilityAssesmentRuleBaselines.json
- preview/2017-10-01-preview/managedDatabaseVulnerabilityAssessmentScans.json
- preview/2017-10-01-preview/managedDatabaseVulnerabilityAssessments.json
- preview/2017-10-01-preview/instanceFailoverGroups.json
- preview/2017-10-01-preview/shortTermRetentionPolicies.json
- preview/2017-10-01-preview/TdeCertificates.json
- preview/2017-10-01-preview/ManagedInstanceTdeCertificates.json
- preview/2017-10-01-preview/ManagedInstanceKeys.json
- preview/2017-10-01-preview/ManagedInstanceEncryptionProtectors.json
- preview/2017-10-01-preview/recoverableManagedDatabases.json
- preview/2018-06-01-preview/ManagedInstanceVulnerabilityAssessments.json
- preview/2018-06-01-preview/ServerVulnerabilityAssessments.json
- preview/2018-06-01-preview/managedDatabaseSensitivityLabels.json
- preview/2018-06-01-preview/instancePools.json
- preview/2018-06-01-preview/usages.json
- preview/2018-06-01-preview/FailoverDatabases.json
- preview/2018-06-01-preview/FailoverElasticPools.json
- preview/2018-06-01-preview/PrivateLinkResources.json
- preview/2019-06-01-preview/servers.json
- preview/2018-06-01-preview/LongTermRetentionManagedInstanceBackups.json
- preview/2018-06-01-preview/ManagedInstanceLongTermRetentionPolicies.json
- preview/2019-06-01-preview/WorkloadGroups.json
- preview/2019-06-01-preview/WorkloadClassifiers.json
- preview/2019-06-01-preview/ServerAzureADAdministrators.json
- preview/2019-06-01-preview/syncGroups.json
- preview/2019-06-01-preview/syncMembers.json
- preview/2020-02-02-preview/ManagedDatabases.json
- preview/2020-02-02-preview/ServerAzureADOnlyAuthentications.json
- preview/2020-02-02-preview/ManagedInstances.json
- preview/2020-02-02-preview/ManagedInstanceAzureADOnlyAuthentications.json
- preview/2020-02-02-preview/ServerTrustGroups.json
- preview/2020-11-01-preview/PrivateEndpointConnections.json

# Needed when there is more than one input file
override-info:
  title: SqlManagementClient
```

### Tag: package-2017-03-preview

These settings apply only when `--tag=package-2017-03-preview` is specified on the command line.

This section contains the input swagger files that are used when generating client SDKs up to and including api-version 2017-03-01-preview, except databases.json which remains at api-version 2014-04-01 in order to maintain compatibility with clients that have been previously released with this package. To prevent similar confusion moving forward, sections named like `package-20xx-xx(-preview)` will not be used after package-2017-03-preview. Instead, sections named like `package-composite-vx` will be used to compose across api-versions and `package-pure-20xx-xx(-preview)` will be used for single api-versions.

APIs must only be added to this section when the API is publicly available in at least 1 production region and at least 1 generated client has been tested end-to-end.

``` yaml $(tag) == 'package-2017-03-preview'
input-file:
- preview/2015-05-01-preview/databaseAutomaticTuning.json
- preview/2015-05-01-preview/encryptionProtectors.json
- preview/2015-05-01-preview/failoverGroups.json
- preview/2015-05-01-preview/managedInstances.json
- preview/2015-05-01-preview/operations.json
- preview/2015-05-01-preview/serverKeys.json
- preview/2015-05-01-preview/servers.json
- preview/2015-05-01-preview/syncAgents.json
- preview/2015-05-01-preview/syncGroups.json
- preview/2015-05-01-preview/syncMembers.json
- preview/2015-05-01-preview/usages.json
- preview/2015-05-01-preview/virtualclusters.json
- preview/2017-03-01-preview/blobAuditing.json
- preview/2017-03-01-preview/databaseVulnerabilityAssessmentBaselines.json
- preview/2017-03-01-preview/databaseVulnerabilityAssessments.json
- preview/2015-05-01-preview/virtualNetworkRules.json
- preview/2017-03-01-preview/cancelOperations.json
- preview/2017-03-01-preview/dataWarehouseUserActivities.json
- preview/2017-03-01-preview/jobs.json
- preview/2017-03-01-preview/ManagedBackupShortTermRetention.json
- preview/2017-03-01-preview/managedDatabases.json
- preview/2017-03-01-preview/renameDatabase.json
- preview/2017-03-01-preview/SensitivityLabels.json
- preview/2017-03-01-preview/managedInstanceAdministrators.json
- preview/2017-03-01-preview/serverAutomaticTuning.json
- preview/2017-03-01-preview/serverDnsAliases.json
- preview/2017-03-01-preview/serverSecurityAlertPolicies.json
- preview/2017-03-01-preview/restorableDroppedManagedDatabases.json
- preview/2017-03-01-preview/restorePoints.json

# Needed when there is more than one input file
override-info:
  title: SqlManagementClient
```

### Tag: package-2015-05-preview

These settings apply only when `--tag=package-2015-05-preview` is specified on the command line.

This section contains the input swagger files that are used when generating client SDKs up to and including api-version 2015-05-01-preview.

APIs must only be added to this section when the API is publicly available in at least 1 production region and at least 1 generated client has been tested end-to-end.

``` yaml $(tag) == 'package-2015-05-preview'
input-file:
- stable/2015-05-01/capabilities.json
- preview/2015-05-01-preview/blobAuditing.json
- preview/2015-05-01-preview/encryptionProtectors.json
- preview/2015-05-01-preview/failoverGroups.json
- preview/2015-05-01-preview/managedInstances.json
- preview/2015-05-01-preview/operations.json
- preview/2015-05-01-preview/serverKeys.json
- preview/2015-05-01-preview/servers.json
- preview/2015-05-01-preview/syncAgents.json
- preview/2015-05-01-preview/syncGroups.json
- preview/2015-05-01-preview/syncMembers.json
- preview/2015-05-01-preview/usages.json
- preview/2015-05-01-preview/virtualclusters.json
- preview/2015-05-01-preview/virtualNetworkRules.json

# Needed when there is more than one input file
override-info:
  title: SqlManagementClient
```

### Tag: package-2015-05

These settings apply only when `--tag=package-2015-05` is specified on the command line.

This section contains the input swagger files that are used when generating client SDKs up to and including api-version 2015-05-01-preview.

APIs must only be added to this section when the API is publicly available in at least 1 production region and at least 1 generated client has been tested end-to-end.

``` yaml $(tag) == 'package-2015-05'
input-file:
- stable/2015-05-01/capabilities.json
- stable/2015-05-01/usages.json

# Needed when there is more than one input file
override-info:
  title: SqlManagementClient
```

## Pure package versions

The following packages are each composed of all apis from only one api-version.

### Tag: package-preview-2021-08

These settings apply only when `--tag=package-preview-2021-08` is specified on the command line.

``` yaml $(tag) == 'package-preview-2021-08'
input-file:
- ./preview/2021-08-01-preview/BackupShortTermRetentionPolicies.json
- ./preview/2021-08-01-preview/BlobAuditing.json
- ./preview/2021-08-01-preview/DatabaseAdvisors.json
- ./preview/2021-08-01-preview/DatabaseAutomaticTuning.json
- ./preview/2021-08-01-preview/DatabaseColumns.json
- ./preview/2021-08-01-preview/DatabaseExtensions.json
- ./preview/2021-08-01-preview/DatabaseOperations.json
- ./preview/2021-08-01-preview/DatabaseRecommendedActions.json
- ./preview/2021-08-01-preview/Databases.json
- ./preview/2021-08-01-preview/DatabaseSchemas.json
- ./preview/2021-08-01-preview/DatabaseSecurityAlertPolicies.json
- ./preview/2021-08-01-preview/DatabaseTables.json
- ./preview/2021-08-01-preview/DatabaseUsages.json
- ./preview/2021-08-01-preview/DatabaseVulnerabilityAssessmentRuleBaselines.json
- ./preview/2021-08-01-preview/DatabaseVulnerabilityAssessments.json
- ./preview/2021-08-01-preview/DatabaseVulnerabilityAssessmentScans.json
- ./preview/2021-08-01-preview/DataWarehouseUserActivities.json
- ./preview/2021-08-01-preview/DeletedServers.json
- ./preview/2021-08-01-preview/DistributedAvailabilityGroups.json
- ./preview/2021-08-01-preview/ElasticPoolOperations.json
- ./preview/2021-08-01-preview/ElasticPools.json
- ./preview/2021-08-01-preview/EncryptionProtectors.json
- ./preview/2021-08-01-preview/FailoverGroups.json
- ./preview/2021-08-01-preview/FirewallRules.json
- ./preview/2021-08-01-preview/InstanceFailoverGroups.json
- ./preview/2021-08-01-preview/InstancePools.json
- ./preview/2021-08-01-preview/IPv6FirewallRules.json
- ./preview/2021-08-01-preview/JobAgents.json
- ./preview/2021-08-01-preview/JobCredentials.json
- ./preview/2021-08-01-preview/JobExecutions.json
- ./preview/2021-08-01-preview/Jobs.json
- ./preview/2021-08-01-preview/JobStepExecutions.json
- ./preview/2021-08-01-preview/JobSteps.json
- ./preview/2021-08-01-preview/JobTargetExecutions.json
- ./preview/2021-08-01-preview/JobTargetGroups.json
- ./preview/2021-08-01-preview/JobVersions.json
- ./preview/2021-08-01-preview/LedgerDigestUploads.json
- ./preview/2021-08-01-preview/LocationCapabilities.json
- ./preview/2021-08-01-preview/LongTermRetentionBackups.json
- ./preview/2021-08-01-preview/LongTermRetentionManagedInstanceBackups.json
- ./preview/2021-08-01-preview/LongTermRetentionPolicies.json
- ./preview/2021-08-01-preview/MaintenanceWindowOptions.json
- ./preview/2021-08-01-preview/MaintenanceWindows.json
- ./preview/2021-08-01-preview/ManagedBackupShortTermRetentionPolicies.json
- ./preview/2021-08-01-preview/ManagedDatabaseColumns.json
- ./preview/2021-08-01-preview/ManagedDatabaseQueries.json
- ./preview/2021-08-01-preview/ManagedDatabaseRestoreDetails.json
- ./preview/2021-08-01-preview/ManagedDatabases.json
- ./preview/2021-08-01-preview/ManagedDatabaseSchemas.json
- ./preview/2021-08-01-preview/ManagedDatabaseSecurityAlertPolicies.json
- ./preview/2021-08-01-preview/ManagedDatabaseSecurityEvents.json
- ./preview/2021-08-01-preview/ManagedDatabaseSensitivityLabels.json
- ./preview/2021-08-01-preview/ManagedDatabaseTables.json
- ./preview/2021-08-01-preview/ManagedDatabaseTransparentDataEncryption.json
- ./preview/2021-08-01-preview/ManagedDatabaseVulnerabilityAssessmentRuleBaselines.json
- ./preview/2021-08-01-preview/ManagedDatabaseVulnerabilityAssessments.json
- ./preview/2021-08-01-preview/ManagedDatabaseVulnerabilityAssessmentScans.json
- ./preview/2021-08-01-preview/ManagedInstanceAdministrators.json
- ./preview/2021-08-01-preview/ManagedInstanceAzureADOnlyAuthentications.json
- ./preview/2021-08-01-preview/ManagedInstanceEncryptionProtectors.json
- ./preview/2021-08-01-preview/ManagedInstanceKeys.json
- ./preview/2021-08-01-preview/ManagedInstanceLongTermRetentionPolicies.json
- ./preview/2021-08-01-preview/ManagedInstanceOperations.json
- ./preview/2021-08-01-preview/ManagedInstancePrivateEndpointConnections.json
- ./preview/2021-08-01-preview/ManagedInstancePrivateLinkResources.json
- ./preview/2021-08-01-preview/ManagedInstances.json
- ./preview/2021-08-01-preview/ManagedInstanceTdeCertificates.json
- ./preview/2021-08-01-preview/ManagedInstanceVulnerabilityAssessments.json
- ./preview/2021-08-01-preview/ManagedRestorableDroppedDatabaseBackupShortTermRetentionPolicies.json
- ./preview/2021-08-01-preview/ManagedServerSecurityAlertPolicies.json
- ./preview/2021-08-01-preview/Operations.json
- ./preview/2021-08-01-preview/OutboundFirewallRules.json
- ./preview/2021-08-01-preview/PrivateEndpointConnections.json
- ./preview/2021-08-01-preview/PrivateLinkResources.json
- ./preview/2021-08-01-preview/RecoverableManagedDatabases.json
- ./preview/2021-08-01-preview/ReplicationLinks.json
- ./preview/2021-08-01-preview/RestorableDroppedDatabases.json
- ./preview/2021-08-01-preview/RestorableDroppedManagedDatabases.json
- ./preview/2021-08-01-preview/RestorePoints.json
- ./preview/2021-08-01-preview/SensitivityLabels.json
- ./preview/2021-08-01-preview/ServerAdvisors.json
- ./preview/2021-08-01-preview/ServerAutomaticTuning.json
- ./preview/2021-08-01-preview/ServerAzureADAdministrators.json
- ./preview/2021-08-01-preview/ServerAzureADOnlyAuthentications.json
- ./preview/2021-08-01-preview/ServerConnectionPolicies.json
- ./preview/2021-08-01-preview/ServerDevOpsAudit.json
- ./preview/2021-08-01-preview/ServerDnsAliases.json
- ./preview/2021-08-01-preview/ServerKeys.json
- ./preview/2021-08-01-preview/ServerOperations.json
- ./preview/2021-08-01-preview/Servers.json
- ./preview/2021-08-01-preview/ServerSecurityAlertPolicies.json
- ./preview/2021-08-01-preview/ServerTrustCertificates.json
- ./preview/2021-08-01-preview/ServerTrustGroups.json
- ./preview/2021-08-01-preview/ServerVulnerabilityAssessments.json
- ./preview/2021-08-01-preview/SqlAgent.json
- ./preview/2021-08-01-preview/SubscriptionUsages.json
- ./preview/2021-08-01-preview/SyncAgents.json
- ./preview/2021-08-01-preview/SyncGroups.json
- ./preview/2021-08-01-preview/SyncMembers.json
- ./preview/2021-08-01-preview/TdeCertificates.json
- ./preview/2021-08-01-preview/TimeZones.json
- ./preview/2021-08-01-preview/TransparentDataEncryptions.json
- ./preview/2021-08-01-preview/Usages.json
- ./preview/2021-08-01-preview/VirtualClusters.json
- ./preview/2021-08-01-preview/VirtualNetworkRules.json
- ./preview/2021-08-01-preview/WorkloadClassifiers.json
- ./preview/2021-08-01-preview/WorkloadGroups.json

# Needed when there is more than one input file
override-info:
  title: SqlManagementClient
```

### Tag: package-preview-2021-05

These settings apply only when `--tag=package-preview-2021-05` is specified on the command line.

``` yaml $(tag) == 'package-preview-2021-05'
input-file:
 - ./preview/2021-05-01-preview/BackupShortTermRetentionPolicies.json
 - ./preview/2021-05-01-preview/BlobAuditing.json
 - ./preview/2021-05-01-preview/DatabaseAdvisors.json
 - ./preview/2021-05-01-preview/DatabaseAutomaticTuning.json
 - ./preview/2021-05-01-preview/DatabaseColumns.json
 - ./preview/2021-05-01-preview/DatabaseExtensions.json
 - ./preview/2021-05-01-preview/DatabaseOperations.json
 - ./preview/2021-05-01-preview/DatabaseRecommendedActions.json
 - ./preview/2021-05-01-preview/Databases.json
 - ./preview/2021-05-01-preview/DatabaseSchemas.json
 - ./preview/2021-05-01-preview/DatabaseSecurityAlertPolicies.json
 - ./preview/2021-05-01-preview/DatabaseTables.json
 - ./preview/2021-05-01-preview/DatabaseUsages.json
 - ./preview/2021-05-01-preview/DatabaseVulnerabilityAssessmentRuleBaselines.json
 - ./preview/2021-05-01-preview/DatabaseVulnerabilityAssessments.json
 - ./preview/2021-05-01-preview/DatabaseVulnerabilityAssessmentScans.json
 - ./preview/2021-05-01-preview/DataWarehouseUserActivities.json
 - ./preview/2021-05-01-preview/DeletedServers.json
 - ./preview/2021-05-01-preview/DistributedAvailabilityGroups.json
 - ./preview/2021-05-01-preview/ElasticPoolOperations.json
 - ./preview/2021-05-01-preview/ElasticPools.json
 - ./preview/2021-05-01-preview/EncryptionProtectors.json
 - ./preview/2021-05-01-preview/FailoverGroups.json
 - ./preview/2021-05-01-preview/FirewallRules.json
 - ./preview/2021-05-01-preview/InstanceFailoverGroups.json
 - ./preview/2021-05-01-preview/InstancePools.json
 - ./preview/2021-05-01-preview/JobAgents.json
 - ./preview/2021-05-01-preview/JobCredentials.json
 - ./preview/2021-05-01-preview/JobExecutions.json
 - ./preview/2021-05-01-preview/Jobs.json
 - ./preview/2021-05-01-preview/JobStepExecutions.json
 - ./preview/2021-05-01-preview/JobSteps.json
 - ./preview/2021-05-01-preview/JobTargetExecutions.json
 - ./preview/2021-05-01-preview/JobTargetGroups.json
 - ./preview/2021-05-01-preview/JobVersions.json
 - ./preview/2021-05-01-preview/LedgerDigestUploads.json
 - ./preview/2021-05-01-preview/LocationCapabilities.json
 - ./preview/2021-05-01-preview/LongTermRetentionBackups.json
 - ./preview/2021-05-01-preview/LongTermRetentionManagedInstanceBackups.json
 - ./preview/2021-05-01-preview/LongTermRetentionPolicies.json
 - ./preview/2021-05-01-preview/MaintenanceWindowOptions.json
 - ./preview/2021-05-01-preview/MaintenanceWindows.json
 - ./preview/2021-05-01-preview/ManagedBackupShortTermRetentionPolicies.json
 - ./preview/2021-05-01-preview/ManagedDatabaseColumns.json
 - ./preview/2021-05-01-preview/ManagedDatabaseQueries.json
 - ./preview/2021-05-01-preview/ManagedDatabaseRestoreDetails.json
 - ./preview/2021-05-01-preview/ManagedDatabases.json
 - ./preview/2021-05-01-preview/ManagedDatabaseSchemas.json
 - ./preview/2021-05-01-preview/ManagedDatabaseSecurityAlertPolicies.json
 - ./preview/2021-05-01-preview/ManagedDatabaseSecurityEvents.json
 - ./preview/2021-05-01-preview/ManagedDatabaseSensitivityLabels.json
 - ./preview/2021-05-01-preview/ManagedDatabaseTables.json
 - ./preview/2021-05-01-preview/ManagedDatabaseTransparentDataEncryption.json
 - ./preview/2021-05-01-preview/ManagedDatabaseVulnerabilityAssessmentRuleBaselines.json
 - ./preview/2021-05-01-preview/ManagedDatabaseVulnerabilityAssessments.json
 - ./preview/2021-05-01-preview/ManagedDatabaseVulnerabilityAssessmentScans.json
 - ./preview/2021-05-01-preview/ManagedInstanceAdministrators.json
 - ./preview/2021-05-01-preview/ManagedInstanceAzureADOnlyAuthentications.json
 - ./preview/2021-05-01-preview/ManagedInstanceEncryptionProtectors.json
 - ./preview/2021-05-01-preview/ManagedInstanceKeys.json
 - ./preview/2021-05-01-preview/ManagedInstanceLongTermRetentionPolicies.json
 - ./preview/2021-05-01-preview/ManagedInstanceOperations.json
 - ./preview/2021-05-01-preview/ManagedInstancePrivateEndpointConnections.json
 - ./preview/2021-05-01-preview/ManagedInstancePrivateLinkResources.json
 - ./preview/2021-05-01-preview/ManagedInstances.json
 - ./preview/2021-05-01-preview/ManagedInstanceTdeCertificates.json
 - ./preview/2021-05-01-preview/ManagedInstanceVulnerabilityAssessments.json
 - ./preview/2021-05-01-preview/ManagedRestorableDroppedDatabaseBackupShortTermRetentionPolicies.json
 - ./preview/2021-05-01-preview/ManagedServerSecurityAlertPolicies.json
 - ./preview/2021-05-01-preview/Operations.json
 - ./preview/2021-05-01-preview/OutboundFirewallRules.json
 - ./preview/2021-05-01-preview/PrivateEndpointConnections.json
 - ./preview/2021-05-01-preview/PrivateLinkResources.json
 - ./preview/2021-05-01-preview/RecoverableManagedDatabases.json
 - ./preview/2021-05-01-preview/ReplicationLinks.json
 - ./preview/2021-05-01-preview/RestorableDroppedDatabases.json
 - ./preview/2021-05-01-preview/RestorableDroppedManagedDatabases.json
 - ./preview/2021-05-01-preview/RestorePoints.json
 - ./preview/2021-05-01-preview/SensitivityLabels.json
 - ./preview/2021-05-01-preview/ServerAdvisors.json
 - ./preview/2021-05-01-preview/ServerAutomaticTuning.json
 - ./preview/2021-05-01-preview/ServerAzureADAdministrators.json
 - ./preview/2021-05-01-preview/ServerAzureADOnlyAuthentications.json
 - ./preview/2021-05-01-preview/ServerConnectionPolicies.json
 - ./preview/2021-05-01-preview/ServerDevOpsAudit.json
 - ./preview/2021-05-01-preview/ServerDnsAliases.json
 - ./preview/2021-05-01-preview/ServerKeys.json
 - ./preview/2021-05-01-preview/ServerOperations.json
 - ./preview/2021-05-01-preview/Servers.json
 - ./preview/2021-05-01-preview/ServerSecurityAlertPolicies.json
 - ./preview/2021-05-01-preview/ServerTrustCertificates.json
 - ./preview/2021-05-01-preview/ServerTrustGroups.json
 - ./preview/2021-05-01-preview/ServerVulnerabilityAssessments.json
 - ./preview/2021-05-01-preview/SqlAgent.json
 - ./preview/2021-05-01-preview/SubscriptionUsages.json
 - ./preview/2021-05-01-preview/SyncAgents.json
 - ./preview/2021-05-01-preview/SyncGroups.json
 - ./preview/2021-05-01-preview/SyncMembers.json
 - ./preview/2021-05-01-preview/TdeCertificates.json
 - ./preview/2021-05-01-preview/TimeZones.json
 - ./preview/2021-05-01-preview/TransparentDataEncryptions.json
 - ./preview/2021-05-01-preview/Usages.json
 - ./preview/2021-05-01-preview/VirtualClusters.json
 - ./preview/2021-05-01-preview/VirtualNetworkRules.json
 - ./preview/2021-05-01-preview/WorkloadClassifiers.json
 - ./preview/2021-05-01-preview/WorkloadGroups.json

# Needed when there is more than one input file
override-info:
  title: SqlManagementClient
```

### Tag: package-preview-2021-02

These settings apply only when `--tag=package-preview-2021-02` is specified on the command line.

``` yaml $(tag) == 'package-preview-2021-02'
input-file:
 - ./preview/2021-02-01-preview/BackupShortTermRetentionPolicies.json
 - ./preview/2021-02-01-preview/BlobAuditing.json
 - ./preview/2021-02-01-preview/DatabaseAdvisors.json
 - ./preview/2021-02-01-preview/DatabaseAutomaticTuning.json
 - ./preview/2021-02-01-preview/DatabaseColumns.json
 - ./preview/2021-02-01-preview/DatabaseExtensions.json
 - ./preview/2021-02-01-preview/DatabaseOperations.json
 - ./preview/2021-02-01-preview/DatabaseRecommendedActions.json
 - ./preview/2021-02-01-preview/Databases.json
 - ./preview/2021-02-01-preview/DatabaseSchemas.json
 - ./preview/2021-02-01-preview/DatabaseSecurityAlertPolicies.json
 - ./preview/2021-02-01-preview/DatabaseTables.json
 - ./preview/2021-02-01-preview/DatabaseUsages.json
 - ./preview/2021-02-01-preview/DatabaseVulnerabilityAssessmentRuleBaselines.json
 - ./preview/2021-02-01-preview/DatabaseVulnerabilityAssessments.json
 - ./preview/2021-02-01-preview/DatabaseVulnerabilityAssessmentScans.json
 - ./preview/2021-02-01-preview/DataWarehouseUserActivities.json
 - ./preview/2021-02-01-preview/DeletedServers.json
 - ./preview/2021-02-01-preview/ElasticPoolOperations.json
 - ./preview/2021-02-01-preview/ElasticPools.json
 - ./preview/2021-02-01-preview/EncryptionProtectors.json
 - ./preview/2021-02-01-preview/FailoverGroups.json
 - ./preview/2021-02-01-preview/FirewallRules.json
 - ./preview/2021-02-01-preview/InstanceFailoverGroups.json
 - ./preview/2021-02-01-preview/InstancePools.json
 - ./preview/2021-02-01-preview/JobAgents.json
 - ./preview/2021-02-01-preview/JobCredentials.json
 - ./preview/2021-02-01-preview/JobExecutions.json
 - ./preview/2021-02-01-preview/Jobs.json
 - ./preview/2021-02-01-preview/JobStepExecutions.json
 - ./preview/2021-02-01-preview/JobSteps.json
 - ./preview/2021-02-01-preview/JobTargetExecutions.json
 - ./preview/2021-02-01-preview/JobTargetGroups.json
 - ./preview/2021-02-01-preview/JobVersions.json
 - ./preview/2021-02-01-preview/LedgerDigestUploads.json
 - ./preview/2021-02-01-preview/LocationCapabilities.json
 - ./preview/2021-02-01-preview/LongTermRetentionBackups.json
 - ./preview/2021-02-01-preview/LongTermRetentionManagedInstanceBackups.json
 - ./preview/2021-02-01-preview/LongTermRetentionPolicies.json
 - ./preview/2021-02-01-preview/MaintenanceWindowOptions.json
 - ./preview/2021-02-01-preview/MaintenanceWindows.json
 - ./preview/2021-02-01-preview/ManagedBackupShortTermRetentionPolicies.json
 - ./preview/2021-02-01-preview/ManagedDatabaseColumns.json
 - ./preview/2021-02-01-preview/ManagedDatabaseQueries.json
 - ./preview/2021-02-01-preview/ManagedDatabaseRestoreDetails.json
 - ./preview/2021-02-01-preview/ManagedDatabases.json
 - ./preview/2021-02-01-preview/ManagedDatabaseSchemas.json
 - ./preview/2021-02-01-preview/ManagedDatabaseSecurityAlertPolicies.json
 - ./preview/2021-02-01-preview/ManagedDatabaseSecurityEvents.json
 - ./preview/2021-02-01-preview/ManagedDatabaseSensitivityLabels.json
 - ./preview/2021-02-01-preview/ManagedDatabaseTables.json
 - ./preview/2021-02-01-preview/ManagedDatabaseTransparentDataEncryption.json
 - ./preview/2021-02-01-preview/ManagedDatabaseVulnerabilityAssessmentRuleBaselines.json
 - ./preview/2021-02-01-preview/ManagedDatabaseVulnerabilityAssessments.json
 - ./preview/2021-02-01-preview/ManagedDatabaseVulnerabilityAssessmentScans.json
 - ./preview/2021-02-01-preview/ManagedInstanceAdministrators.json
 - ./preview/2021-02-01-preview/ManagedInstanceAzureADOnlyAuthentications.json
 - ./preview/2021-02-01-preview/ManagedInstanceEncryptionProtectors.json
 - ./preview/2021-02-01-preview/ManagedInstanceKeys.json
 - ./preview/2021-02-01-preview/ManagedInstanceLongTermRetentionPolicies.json
 - ./preview/2021-02-01-preview/ManagedInstanceOperations.json
 - ./preview/2021-02-01-preview/ManagedInstancePrivateEndpointConnections.json
 - ./preview/2021-02-01-preview/ManagedInstancePrivateLinkResources.json
 - ./preview/2021-02-01-preview/ManagedInstances.json
 - ./preview/2021-02-01-preview/ManagedInstanceTdeCertificates.json
 - ./preview/2021-02-01-preview/ManagedInstanceVulnerabilityAssessments.json
 - ./preview/2021-02-01-preview/ManagedRestorableDroppedDatabaseBackupShortTermRetentionPolicies.json
 - ./preview/2021-02-01-preview/ManagedServerSecurityAlertPolicies.json
 - ./preview/2021-02-01-preview/Operations.json
 - ./preview/2021-02-01-preview/OutboundFirewallRules.json
 - ./preview/2021-02-01-preview/PrivateEndpointConnections.json
 - ./preview/2021-02-01-preview/PrivateLinkResources.json
 - ./preview/2021-02-01-preview/RecoverableManagedDatabases.json
 - ./preview/2021-02-01-preview/ReplicationLinks.json
 - ./preview/2021-02-01-preview/RestorableDroppedDatabases.json
 - ./preview/2021-02-01-preview/RestorableDroppedManagedDatabases.json
 - ./preview/2021-02-01-preview/RestorePoints.json
 - ./preview/2021-02-01-preview/SensitivityLabels.json
 - ./preview/2021-02-01-preview/ServerAdvisors.json
 - ./preview/2021-02-01-preview/ServerAutomaticTuning.json
 - ./preview/2021-02-01-preview/ServerAzureADAdministrators.json
 - ./preview/2021-02-01-preview/ServerAzureADOnlyAuthentications.json
 - ./preview/2021-02-01-preview/ServerDevOpsAudit.json
 - ./preview/2021-02-01-preview/ServerDnsAliases.json
 - ./preview/2021-02-01-preview/ServerKeys.json
 - ./preview/2021-02-01-preview/ServerOperations.json
 - ./preview/2021-02-01-preview/Servers.json
 - ./preview/2021-02-01-preview/ServerSecurityAlertPolicies.json
 - ./preview/2021-02-01-preview/ServerTrustGroups.json
 - ./preview/2021-02-01-preview/ServerVulnerabilityAssessments.json
 - ./preview/2021-02-01-preview/SqlAgent.json
 - ./preview/2021-02-01-preview/SubscriptionUsages.json
 - ./preview/2021-02-01-preview/SyncAgents.json
 - ./preview/2021-02-01-preview/SyncGroups.json
 - ./preview/2021-02-01-preview/SyncMembers.json
 - ./preview/2021-02-01-preview/TdeCertificates.json
 - ./preview/2021-02-01-preview/TimeZones.json
 - ./preview/2021-02-01-preview/TransparentDataEncryptions.json
 - ./preview/2021-02-01-preview/Usages.json
 - ./preview/2021-02-01-preview/VirtualClusters.json
 - ./preview/2021-02-01-preview/VirtualNetworkRules.json
 - ./preview/2021-02-01-preview/WorkloadClassifiers.json
 - ./preview/2021-02-01-preview/WorkloadGroups.json

# Needed when there is more than one input file
override-info:
  title: SqlManagementClient
```

### Tag: package-preview-2020-11

These settings apply only when `--tag=package-preview-2020-11` is specified on the command line.

This section contains all input swagger files for version 2020-11-01-preview. All APIs of that version must be added this section when the API is ready for production.

APIs must only be added to this section when the API is publicly available in at least 1 production region and at least 1 generated client has been tested end-to-end.

These can be regenerated by running the following PowerShell script from this readme file's folder: `dir .\Microsoft.Sql\preview\2020-11-01-preview\ -File | Resolve-Path -Relative | % { " - $_".Replace("\", "/") }`

``` yaml $(tag) == 'package-preview-2020-11'
input-file:
  - preview/2020-11-01-preview/BackupShortTermRetentionPolicies.json
  - preview/2020-11-01-preview/BlobAuditing.json
  - preview/2020-11-01-preview/DataWarehouseUserActivities.json
  - preview/2020-11-01-preview/DatabaseAdvisors.json
  - preview/2020-11-01-preview/DatabaseAutomaticTuning.json
  - preview/2020-11-01-preview/DatabaseColumns.json
  - preview/2020-11-01-preview/DatabaseExtensions.json
  - preview/2020-11-01-preview/DatabaseOperations.json
  - preview/2020-11-01-preview/DatabaseRecommendedActions.json
  - preview/2020-11-01-preview/DatabaseSchemas.json
  - preview/2020-11-01-preview/DatabaseSecurityAlertPolicies.json
  - preview/2020-11-01-preview/DatabaseTables.json
  - preview/2020-11-01-preview/DatabaseUsages.json
  - preview/2020-11-01-preview/DatabaseVulnerabilityAssesmentRuleBaselines.json
  - preview/2020-11-01-preview/DatabaseVulnerabilityAssessmentScans.json
  - preview/2020-11-01-preview/DatabaseVulnerabilityAssessments.json
  - preview/2020-11-01-preview/Databases.json
  - preview/2020-11-01-preview/Databases_legacy.json
  - preview/2020-11-01-preview/DeletedServers.json
  - preview/2020-11-01-preview/ElasticPoolOperations.json
  - preview/2020-11-01-preview/ElasticPools.json
  - preview/2020-11-01-preview/EncryptionProtectors.json
  - preview/2020-11-01-preview/FailoverGroups.json
  - preview/2020-11-01-preview/FirewallRules.json
  - preview/2020-11-01-preview/InstanceFailoverGroups.json
  - preview/2020-11-01-preview/InstancePools.json
  - preview/2020-11-01-preview/JobAgents.json
  - preview/2020-11-01-preview/JobCredentials.json
  - preview/2020-11-01-preview/JobExecutions.json
  - preview/2020-11-01-preview/JobStepExecutions.json
  - preview/2020-11-01-preview/JobSteps.json
  - preview/2020-11-01-preview/JobTargetExecutions.json
  - preview/2020-11-01-preview/JobTargetGroups.json
  - preview/2020-11-01-preview/JobVersions.json
  - preview/2020-11-01-preview/Jobs.json
  - preview/2020-11-01-preview/LocationCapabilities.json
  - preview/2020-11-01-preview/LongTermRetentionBackups.json
  - preview/2020-11-01-preview/LongTermRetentionManagedInstanceBackups.json
  - preview/2020-11-01-preview/LongTermRetentionPolicies.json
  - preview/2020-11-01-preview/MaintenanceWindowOptions.json
  - preview/2020-11-01-preview/MaintenanceWindows.json
  - preview/2020-11-01-preview/ManagedBackupShortTermRetentionPolicies.json
  - preview/2020-11-01-preview/ManagedDatabaseColumns.json
  - preview/2020-11-01-preview/ManagedDatabaseQueries.json
  - preview/2020-11-01-preview/ManagedDatabaseRestoreDetails.json
  - preview/2020-11-01-preview/ManagedDatabaseSchemas.json
  - preview/2020-11-01-preview/ManagedDatabaseSecurityAlertPolicies.json
  - preview/2020-11-01-preview/ManagedDatabaseSecurityEvents.json
  - preview/2020-11-01-preview/ManagedDatabaseSensitivityLabels.json
  - preview/2020-11-01-preview/ManagedDatabaseTables.json
  - preview/2020-11-01-preview/ManagedDatabaseTransparentDataEncryption.json
  - preview/2020-11-01-preview/ManagedDatabaseVulnerabilityAssessmentRuleBaselines.json
  - preview/2020-11-01-preview/ManagedDatabaseVulnerabilityAssessmentScans.json
  - preview/2020-11-01-preview/ManagedDatabaseVulnerabilityAssessments.json
  - preview/2020-11-01-preview/ManagedDatabases.json
  - preview/2020-11-01-preview/ManagedInstanceAdministrators.json
  - preview/2020-11-01-preview/ManagedInstanceAzureADOnlyAuthentications.json
  - preview/2020-11-01-preview/ManagedInstanceEncryptionProtectors.json
  - preview/2020-11-01-preview/ManagedInstanceKeys.json
  - preview/2020-11-01-preview/ManagedInstanceLongTermRetentionPolicies.json
  - preview/2020-11-01-preview/ManagedInstanceOperations.json
  - preview/2020-11-01-preview/ManagedInstancePrivateEndpointConnections.json
  - preview/2020-11-01-preview/ManagedInstancePrivateLinkResources.json
  - preview/2020-11-01-preview/ManagedInstanceTdeCertificates.json
  - preview/2020-11-01-preview/ManagedInstanceVulnerabilityAssessments.json
  - preview/2020-11-01-preview/ManagedInstances.json
  - preview/2020-11-01-preview/ManagedRestorableDroppedDatabaseBackupShortTermRetentionPolicies.json
  - preview/2020-11-01-preview/ManagedServerSecurityAlertPolicies.json
  - preview/2020-11-01-preview/Operations.json
  - preview/2020-11-01-preview/PrivateEndpointConnections.json
  - preview/2020-11-01-preview/PrivateLinkResources.json
  - preview/2020-11-01-preview/RecoverableManagedDatabases.json
  - preview/2020-11-01-preview/ReplicationLinks.json
  - preview/2020-11-01-preview/RestorableDroppedDatabases.json
  - preview/2020-11-01-preview/RestorableDroppedManagedDatabases.json
  - preview/2020-11-01-preview/RestorePoints.json
  - preview/2020-11-01-preview/SensitivityLabels.json
  - preview/2020-11-01-preview/ServerAdvisors.json
  - preview/2020-11-01-preview/ServerAutomaticTuning.json
  - preview/2020-11-01-preview/ServerAzureADAdministrators.json
  - preview/2020-11-01-preview/ServerAzureADOnlyAuthentications.json
  - preview/2020-11-01-preview/ServerDevOpsAudit.json
  - preview/2020-11-01-preview/ServerDnsAliases.json
  - preview/2020-11-01-preview/ServerKeys.json
  - preview/2020-11-01-preview/ServerOperations.json
  - preview/2020-11-01-preview/ServerSecurityAlertPolicies.json
  - preview/2020-11-01-preview/ServerTrustGroups.json
  - preview/2020-11-01-preview/ServerVulnerabilityAssessments.json
  - preview/2020-11-01-preview/Servers.json
  - preview/2020-11-01-preview/SqlAgent.json
  - preview/2020-11-01-preview/SubscriptionUsages.json
  - preview/2020-11-01-preview/SyncAgents.json
  - preview/2020-11-01-preview/SyncGroups.json
  - preview/2020-11-01-preview/SyncMembers.json
  - preview/2020-11-01-preview/TdeCertificates.json
  - preview/2020-11-01-preview/TimeZones.json
  - preview/2020-11-01-preview/TransparentDataEncryptions.json
  - preview/2020-11-01-preview/VirtualClusters.json
  - preview/2020-11-01-preview/VirtualNetworkRules.json
  - preview/2020-11-01-preview/WorkloadClassifiers.json
  - preview/2020-11-01-preview/WorkloadGroups.json

# Needed when there is more than one input file
override-info:
  title: SqlManagementClient
```

### Tag: package-pure-2020-08-preview

These settings apply only when `--tag=package-pure-2020-08-preview` is specified on the command line.

This section contains all input swagger files for version 2020-08-01-preview. All APIs of that version must be added this section when the API is ready for production.

APIs must only be added to this section when the API is publicly available in at least 1 production region and at least 1 generated client has been tested end-to-end.

These can be regenerated by running the following PowerShell script from this readme file's folder: `dir .\Microsoft.Sql\preview\2020-08-01-preview\ -File | Resolve-Path -Relative | % { " - $_".Replace("\", "/") }`

``` yaml $(tag) == 'package-pure-2020-08-preview'
input-file:
 - ./preview/2020-08-01-preview/BackupShortTermRetentionPolicies.json
 - ./preview/2020-08-01-preview/BlobAuditing.json
 - ./preview/2020-08-01-preview/DatabaseAdvisors.json
 - ./preview/2020-08-01-preview/DatabaseAutomaticTuning.json
 - ./preview/2020-08-01-preview/DatabaseColumns.json
 - ./preview/2020-08-01-preview/DatabaseExtensions.json
 - ./preview/2020-08-01-preview/DatabaseOperations.json
 - ./preview/2020-08-01-preview/DatabaseRecommendedActions.json
 - ./preview/2020-08-01-preview/Databases.json
 - ./preview/2020-08-01-preview/Databases_legacy.json
 - ./preview/2020-08-01-preview/DatabaseSchemas.json
 - ./preview/2020-08-01-preview/DatabaseSecurityAlertPolicies.json
 - ./preview/2020-08-01-preview/DatabaseTables.json
 - ./preview/2020-08-01-preview/DatabaseUsages.json
 - ./preview/2020-08-01-preview/DatabaseVulnerabilityAssesmentRuleBaselines.json
 - ./preview/2020-08-01-preview/DatabaseVulnerabilityAssessments.json
 - ./preview/2020-08-01-preview/DatabaseVulnerabilityAssessmentScans.json
 - ./preview/2020-08-01-preview/DataWarehouseUserActivities.json
 - ./preview/2020-08-01-preview/DeletedServers.json
 - ./preview/2020-08-01-preview/ElasticPoolOperations.json
 - ./preview/2020-08-01-preview/ElasticPools.json
 - ./preview/2020-08-01-preview/EncryptionProtectors.json
 - ./preview/2020-08-01-preview/FailoverGroups.json
 - ./preview/2020-08-01-preview/FirewallRules.json
 - ./preview/2020-08-01-preview/InstanceFailoverGroups.json
 - ./preview/2020-08-01-preview/InstancePools.json
 - ./preview/2020-08-01-preview/JobAgents.json
 - ./preview/2020-08-01-preview/JobCredentials.json
 - ./preview/2020-08-01-preview/JobExecutions.json
 - ./preview/2020-08-01-preview/Jobs.json
 - ./preview/2020-08-01-preview/JobStepExecutions.json
 - ./preview/2020-08-01-preview/JobSteps.json
 - ./preview/2020-08-01-preview/JobTargetExecutions.json
 - ./preview/2020-08-01-preview/JobTargetGroups.json
 - ./preview/2020-08-01-preview/JobVersions.json
 - ./preview/2020-08-01-preview/LocationCapabilities.json
 - ./preview/2020-08-01-preview/LongTermRetentionBackups.json
 - ./preview/2020-08-01-preview/LongTermRetentionManagedInstanceBackups.json
 - ./preview/2020-08-01-preview/LongTermRetentionPolicies.json
 - ./preview/2020-08-01-preview/MaintenanceWindowOptions.json
 - ./preview/2020-08-01-preview/MaintenanceWindows.json
 - ./preview/2020-08-01-preview/ManagedBackupShortTermRetentionPolicies.json
 - ./preview/2020-08-01-preview/ManagedDatabaseColumns.json
 - ./preview/2020-08-01-preview/ManagedDatabaseQueries.json
 - ./preview/2020-08-01-preview/ManagedDatabaseRestoreDetails.json
 - ./preview/2020-08-01-preview/ManagedDatabases.json
 - ./preview/2020-08-01-preview/ManagedDatabaseSchemas.json
 - ./preview/2020-08-01-preview/ManagedDatabaseSecurityAlertPolicies.json
 - ./preview/2020-08-01-preview/ManagedDatabaseSecurityEvents.json
 - ./preview/2020-08-01-preview/ManagedDatabaseSensitivityLabels.json
 - ./preview/2020-08-01-preview/ManagedDatabaseTables.json
 - ./preview/2020-08-01-preview/ManagedDatabaseTransparentDataEncryption.json
 - ./preview/2020-08-01-preview/ManagedDatabaseVulnerabilityAssessmentRuleBaselines.json
 - ./preview/2020-08-01-preview/ManagedDatabaseVulnerabilityAssessments.json
 - ./preview/2020-08-01-preview/ManagedDatabaseVulnerabilityAssessmentScans.json
 - ./preview/2020-08-01-preview/ManagedInstanceAdministrators.json
 - ./preview/2020-08-01-preview/ManagedInstanceAzureADOnlyAuthentications.json
 - ./preview/2020-08-01-preview/ManagedInstanceEncryptionProtectors.json
 - ./preview/2020-08-01-preview/ManagedInstanceKeys.json
 - ./preview/2020-08-01-preview/ManagedInstanceLongTermRetentionPolicies.json
 - ./preview/2020-08-01-preview/ManagedInstanceOperations.json
 - ./preview/2020-08-01-preview/ManagedInstancePrivateEndpointConnections.json
 - ./preview/2020-08-01-preview/ManagedInstancePrivateLinkResources.json
 - ./preview/2020-08-01-preview/ManagedInstances.json
 - ./preview/2020-08-01-preview/ManagedInstanceTdeCertificates.json
 - ./preview/2020-08-01-preview/ManagedInstanceVulnerabilityAssessments.json
 - ./preview/2020-08-01-preview/ManagedRestorableDroppedDatabaseBackupShortTermRetentionPolicies.json
 - ./preview/2020-08-01-preview/ManagedServerSecurityAlertPolicies.json
 - ./preview/2020-08-01-preview/Operations.json
 - ./preview/2020-08-01-preview/PrivateEndpointConnections.json
 - ./preview/2020-08-01-preview/PrivateLinkResources.json
 - ./preview/2020-08-01-preview/RecoverableManagedDatabases.json
 - ./preview/2020-08-01-preview/ReplicationLinks.json
 - ./preview/2020-08-01-preview/RestorableDroppedDatabases.json
 - ./preview/2020-08-01-preview/RestorableDroppedManagedDatabases.json
 - ./preview/2020-08-01-preview/RestorePoints.json
 - ./preview/2020-08-01-preview/SensitivityLabels.json
 - ./preview/2020-08-01-preview/ServerAdvisors.json
 - ./preview/2020-08-01-preview/ServerAutomaticTuning.json
 - ./preview/2020-08-01-preview/ServerAzureADAdministrators.json
 - ./preview/2020-08-01-preview/ServerAzureADOnlyAuthentications.json
 - ./preview/2020-08-01-preview/ServerDevOpsAudit.json
 - ./preview/2020-08-01-preview/ServerDnsAliases.json
 - ./preview/2020-08-01-preview/ServerKeys.json
 - ./preview/2020-08-01-preview/ServerOperations.json
 - ./preview/2020-08-01-preview/Servers.json
 - ./preview/2020-08-01-preview/ServerSecurityAlertPolicies.json
 - ./preview/2020-08-01-preview/ServerTrustGroups.json
 - ./preview/2020-08-01-preview/ServerVulnerabilityAssessments.json
 - ./preview/2020-08-01-preview/SqlAgent.json
 - ./preview/2020-08-01-preview/SubscriptionUsages.json
 - ./preview/2020-08-01-preview/SyncAgents.json
 - ./preview/2020-08-01-preview/SyncGroups.json
 - ./preview/2020-08-01-preview/SyncMembers.json
 - ./preview/2020-08-01-preview/TdeCertificates.json
 - ./preview/2020-08-01-preview/TimeZones.json
 - ./preview/2020-08-01-preview/TransparentDataEncryptions.json
 - ./preview/2020-08-01-preview/VirtualClusters.json
 - ./preview/2020-08-01-preview/VirtualNetworkRules.json
 - ./preview/2020-08-01-preview/WorkloadClassifiers.json
 - ./preview/2020-08-01-preview/WorkloadGroups.json

# Needed when there is more than one input file
override-info:
  title: SqlManagementClient
```

### Tag: package-pure-2020-02-preview

These settings apply only when `--tag=package-pure-2020-02-preview` is specified on the command line.

This section contains all input swagger files for version 2020-02-02-preview. All APIs of that version must be added this section when the API is ready for production.

APIs must only be added to this section when the API is publicly available in at least 1 production region and at least 1 generated client has been tested end-to-end.

These can be regenerated by running the following PowerShell script from this readme file's folder: `dir .\Microsoft.Sql\preview\2020-02-02-preview\ -File | Resolve-Path -Relative | % { " - $_".Replace("\", "/") }`

``` yaml $(tag) == 'package-pure-2020-02-preview'
input-file:
 - ./preview/2020-02-02-preview/BackupShortTermRetentionPolicies.json
 - ./preview/2020-02-02-preview/BlobAuditing.json
 - ./preview/2020-02-02-preview/DatabaseAdvisors.json
 - ./preview/2020-02-02-preview/DatabaseAutomaticTuning.json
 - ./preview/2020-02-02-preview/DatabaseColumns.json
 - ./preview/2020-02-02-preview/DatabaseOperations.json
 - ./preview/2020-02-02-preview/DatabaseRecommendedActions.json
 - ./preview/2020-02-02-preview/Databases.json
 - ./preview/2020-02-02-preview/DatabaseSchemas.json
 - ./preview/2020-02-02-preview/DatabaseSecurityAlertPolicies.json
 - ./preview/2020-02-02-preview/DatabaseTables.json
 - ./preview/2020-02-02-preview/DatabaseUsages.json
 - ./preview/2020-02-02-preview/DatabaseVulnerabilityAssesmentRuleBaselines.json
 - ./preview/2020-02-02-preview/DatabaseVulnerabilityAssessments.json
 - ./preview/2020-02-02-preview/DatabaseVulnerabilityAssessmentScans.json
 - ./preview/2020-02-02-preview/DataWarehouseUserActivities.json
 - ./preview/2020-02-02-preview/DeletedServers.json
 - ./preview/2020-02-02-preview/ElasticPoolOperations.json
 - ./preview/2020-02-02-preview/ElasticPools.json
 - ./preview/2020-02-02-preview/EncryptionProtectors.json
 - ./preview/2020-02-02-preview/FailoverGroups.json
 - ./preview/2020-02-02-preview/FirewallRules.json
 - ./preview/2020-02-02-preview/ImportExport.json
 - ./preview/2020-02-02-preview/InstanceFailoverGroups.json
 - ./preview/2020-02-02-preview/InstancePools.json
 - ./preview/2020-02-02-preview/JobAgents.json
 - ./preview/2020-02-02-preview/JobCredentials.json
 - ./preview/2020-02-02-preview/JobExecutions.json
 - ./preview/2020-02-02-preview/Jobs.json
 - ./preview/2020-02-02-preview/JobStepExecutions.json
 - ./preview/2020-02-02-preview/JobSteps.json
 - ./preview/2020-02-02-preview/JobTargetExecutions.json
 - ./preview/2020-02-02-preview/JobTargetGroups.json
 - ./preview/2020-02-02-preview/JobVersions.json
 - ./preview/2020-02-02-preview/LocationCapabilities.json
 - ./preview/2020-02-02-preview/LongTermRetentionBackups.json
 - ./preview/2020-02-02-preview/LongTermRetentionManagedInstanceBackups.json
 - ./preview/2020-02-02-preview/LongTermRetentionPolicies.json
 - ./preview/2020-02-02-preview/MaintenanceWindowOptions.json
 - ./preview/2020-02-02-preview/MaintenanceWindows.json
 - ./preview/2020-02-02-preview/ManagedBackupShortTermRetentionPolicies.json
 - ./preview/2020-02-02-preview/ManagedDatabaseColumns.json
 - ./preview/2020-02-02-preview/ManagedDatabaseQueries.json
 - ./preview/2020-02-02-preview/ManagedDatabaseRestoreDetails.json
 - ./preview/2020-02-02-preview/ManagedDatabases.json
 - ./preview/2020-02-02-preview/ManagedDatabaseSchemas.json
 - ./preview/2020-02-02-preview/ManagedDatabaseSecurityAlertPolicies.json
 - ./preview/2020-02-02-preview/ManagedDatabaseSecurityEvents.json
 - ./preview/2020-02-02-preview/ManagedDatabaseSensitivityLabels.json
 - ./preview/2020-02-02-preview/ManagedDatabaseTables.json
 - ./preview/2020-02-02-preview/ManagedDatabaseTransparentDataEncryption.json
 - ./preview/2020-02-02-preview/ManagedDatabaseVulnerabilityAssessmentRuleBaselines.json
 - ./preview/2020-02-02-preview/ManagedDatabaseVulnerabilityAssessments.json
 - ./preview/2020-02-02-preview/ManagedDatabaseVulnerabilityAssessmentScans.json
 - ./preview/2020-02-02-preview/ManagedInstanceAdministrators.json
 - ./preview/2020-02-02-preview/ManagedInstanceAzureADOnlyAuthentications.json
 - ./preview/2020-02-02-preview/ManagedInstanceEncryptionProtectors.json
 - ./preview/2020-02-02-preview/ManagedInstanceKeys.json
 - ./preview/2020-02-02-preview/ManagedInstanceLongTermRetentionPolicies.json
 - ./preview/2020-02-02-preview/ManagedInstanceOperations.json
 - ./preview/2020-02-02-preview/ManagedInstancePrivateEndpointConnections.json
 - ./preview/2020-02-02-preview/ManagedInstancePrivateLinkResources.json
 - ./preview/2020-02-02-preview/ManagedInstances.json
 - ./preview/2020-02-02-preview/ManagedInstanceTdeCertificates.json
 - ./preview/2020-02-02-preview/ManagedInstanceVulnerabilityAssessments.json
 - ./preview/2020-02-02-preview/ManagedRestorableDroppedDatabaseBackupShortTermRetentionPolicies.json
 - ./preview/2020-02-02-preview/ManagedServerSecurityAlertPolicies.json
 - ./preview/2020-02-02-preview/Operations.json
 - ./preview/2020-02-02-preview/PrivateEndpointConnections.json
 - ./preview/2020-02-02-preview/PrivateLinkResources.json
 - ./preview/2020-02-02-preview/RecoverableManagedDatabases.json
 - ./preview/2020-02-02-preview/ReplicationLinks.json
 - ./preview/2020-02-02-preview/RestorableDroppedDatabases.json
 - ./preview/2020-02-02-preview/RestorableDroppedManagedDatabases.json
 - ./preview/2020-02-02-preview/RestorePoints.json
 - ./preview/2020-02-02-preview/SensitivityLabels.json
 - ./preview/2020-02-02-preview/ServerAdvisors.json
 - ./preview/2020-02-02-preview/ServerAutomaticTuning.json
 - ./preview/2020-02-02-preview/ServerAzureADAdministrators.json
 - ./preview/2020-02-02-preview/ServerAzureADOnlyAuthentications.json
 - ./preview/2020-02-02-preview/ServerDevOpsAudit.json
 - ./preview/2020-02-02-preview/ServerDnsAliases.json
 - ./preview/2020-02-02-preview/ServerKeys.json
 - ./preview/2020-02-02-preview/ServerOperations.json
 - ./preview/2020-02-02-preview/Servers.json
 - ./preview/2020-02-02-preview/ServerSecurityAlertPolicies.json
 - ./preview/2020-02-02-preview/ServerTrustGroups.json
 - ./preview/2020-02-02-preview/ServerVulnerabilityAssessments.json
 - ./preview/2020-02-02-preview/SqlAgent.json
 - ./preview/2020-02-02-preview/SubscriptionUsages.json
 - ./preview/2020-02-02-preview/SyncAgents.json
 - ./preview/2020-02-02-preview/SyncGroups.json
 - ./preview/2020-02-02-preview/SyncMembers.json
 - ./preview/2020-02-02-preview/TdeCertificates.json
 - ./preview/2020-02-02-preview/TimeZones.json
 - ./preview/2020-02-02-preview/TransparentDataEncryptions.json
 - ./preview/2020-02-02-preview/VirtualClusters.json
 - ./preview/2020-02-02-preview/VirtualNetworkRules.json
 - ./preview/2020-02-02-preview/WorkloadClassifiers.json
 - ./preview/2020-02-02-preview/WorkloadGroups.json

# Needed when there is more than one input file
override-info:
  title: SqlManagementClient
```

### Tag: package-pure-2019-06-preview

These settings apply only when `--tag=package-pure-2019-06-preview` is specified on the command line.

This section contains all input swagger files for version 2019-06-01-preview. All APIs of that version must be added this section when the API is ready for production.

APIs must only be added to this section when the API is publicly available in at least 1 production region and at least 1 generated client has been tested end-to-end.

These can be regenerated by running the following PowerShell script from this readme file's folder: `dir .\Microsoft.Sql\preview\2019-06-01-preview\ -File | Resolve-Path -Relative | % { " - $_".Replace("\", "/") }`

``` yaml $(tag) == 'package-pure-2019-06-preview'
input-file:
 - ./preview/2019-06-01-preview/databases.json
 - ./preview/2019-06-01-preview/managedDatabases.json
 - ./preview/2019-06-01-preview/serverOperations.json
 - ./preview/2019-06-01-preview/servers.json
 - ./preview/2019-06-01-preview/WorkloadGroups.json
 - ./preview/2019-06-01-preview/WorkloadClassifiers.json
 - ./preview/2019-06-01-preview/managedInstanceOperations.json
 - ./preview/2019-06-01-preview/ServerAzureADAdministrators.json
 - ./preview/2019-06-01-preview/syncGroups.json
 - ./preview/2019-06-01-preview/syncMembers.json
 - ./preview/2019-06-01-preview/FailoverManagedInstance.json

# Needed when there is more than one input file
override-info:
  title: SqlManagementClient
```

### Tag: package-pure-2018-06-preview

These settings apply only when `--tag=package-pure-2018-06-preview` is specified on the command line.

This section contains all input swagger files for version 2018-06-01-preview. All APIs of that version must be added this section when the API is ready for production.

APIs must only be added to this section when the API is publicly available in at least 1 production region and at least 1 generated client has been tested end-to-end.

These can be regenerated by running the following PowerShell script from this readme file's folder: `dir .\Microsoft.Sql\preview\2018-06-01-preview\ -File | Resolve-Path -Relative | % { " - $_".Replace("\", "/") }`

``` yaml $(tag) == 'package-pure-2018-06-preview'
input-file:
 - ./preview/2018-06-01-preview/DatabaseSecurityAlertPolicies.json
 - ./preview/2018-06-01-preview/DatabaseSchema.json
 - ./preview/2018-06-01-preview/managedDatabaseSensitivityLabels.json
 - ./preview/2018-06-01-preview/ManagedInstanceVulnerabilityAssessments.json
 - ./preview/2018-06-01-preview/managedInstanceOperations.json
 - ./preview/2018-06-01-preview/ManagedDatabaseSchema.json
 - ./preview/2018-06-01-preview/ServerVulnerabilityAssessments.json
 - ./preview/2018-06-01-preview/instancePools.json
 - ./preview/2018-06-01-preview/usages.json
 - ./preview/2018-06-01-preview/managedInstances.json
 - ./preview/2018-06-01-preview/managedDatabases.json
 - ./preview/2018-06-01-preview/FailoverDatabases.json
 - ./preview/2018-06-01-preview/FailoverElasticPools.json
 - ./preview/2018-06-01-preview/PrivateEndpointConnections.json
 - ./preview/2018-06-01-preview/ServerAzureADAdministrators.json
 - ./preview/2018-06-01-preview/ManagedInstanceLongTermRetentionPolicies.json
 - ./preview/2018-06-01-preview/LongTermRetentionManagedInstanceBackups.json

# Needed when there is more than one input file
override-info:
  title: SqlManagementClient
```

### Tag: package-pure-2017-10-preview

These settings apply only when `--tag=package-pure-2017-10-preview` is specified on the command line.

This section contains all input swagger files for version 2017-10-01-preview. All APIs of that version must be added this section when the API is ready for production.

APIs must only be added to this section when the API is publicly available in at least 1 production region and at least 1 generated client has been tested end-to-end.

These can be regenerated by running the following PowerShell script from this readme file's folder: `dir .\Microsoft.Sql\preview\2017-10-01-preview\ -File | Resolve-Path -Relative | % { " - $_".Replace("\", "/") }`

``` yaml $(tag) == 'package-pure-2017-10-preview'
input-file:
 - ./preview/2017-10-01-preview/cancelOperations.json
 - ./preview/2017-10-01-preview/cancelPoolOperations.json
 - ./preview/2017-10-01-preview/databaseVulnerabilityAssessmentScans.json
 - ./preview/2017-10-01-preview/managedDatabaseVulnerabilityAssesmentRuleBaselines.json
 - ./preview/2017-10-01-preview/managedDatabaseVulnerabilityAssessmentScans.json
 - ./preview/2017-10-01-preview/managedDatabaseVulnerabilityAssessments.json
 - ./preview/2017-10-01-preview/capabilities.json
 - ./preview/2017-10-01-preview/databases.json
 - ./preview/2017-10-01-preview/elasticPools.json
 - ./preview/2017-10-01-preview/instanceFailoverGroups.json
 - ./preview/2017-10-01-preview/shortTermRetentionPolicies.json
 - ./preview/2017-10-01-preview/TdeCertificates.json
 - ./preview/2017-10-01-preview/ManagedInstanceTdeCertificates.json
 - ./preview/2017-10-01-preview/ManagedInstanceKeys.json
 - ./preview/2017-10-01-preview/ManagedInstanceEncryptionProtectors.json
 - ./preview/2017-10-01-preview/recoverableManagedDatabases.json

# Needed when there is more than one input file
override-info:
  title: SqlManagementClient
```

### Tag: package-pure-2017-03-preview

These settings apply only when `--tag=package-pure-2017-03-preview` is specified on the command line.

This section contains all input swagger files for version 2017-03-01-preview. All APIs of that version must be added this section when the API is ready for production.

APIs must only be added to this section when the API is publicly available in at least 1 production region and at least 1 generated client has been tested end-to-end.

These can be regenerated by running the following PowerShell script from this readme file's folder: `dir .\Microsoft.Sql\preview\2017-03-01-preview\ -File | Resolve-Path -Relative | % { " - $_".Replace("\", "/") }`

``` yaml $(tag) == 'package-pure-2017-03-preview'
input-file:
 - ./preview/2017-03-01-preview/blobAuditing.json
 - ./preview/2017-03-01-preview/cancelOperations.json
 - ./preview/2017-03-01-preview/databases.json
 - ./preview/2017-03-01-preview/databaseVulnerabilityAssessmentBaselines.json
 - ./preview/2017-03-01-preview/databaseVulnerabilityAssessments.json
 - ./preview/2017-03-01-preview/dataWarehouseUserActivities.json
 - ./preview/2017-03-01-preview/jobs.json
 - ./preview/2017-03-01-preview/longTermRetention.json
 - ./preview/2017-03-01-preview/ManagedBackupShortTermRetention.json
 - ./preview/2017-03-01-preview/managedDatabases.json
 - ./preview/2017-03-01-preview/ManagedRestorableDroppedDatabaseBackupShortTermRetenion.json
 - ./preview/2017-03-01-preview/renameDatabase.json
 - ./preview/2017-03-01-preview/restorableDroppedManagedDatabases.json
 - ./preview/2017-03-01-preview/restorePoints.json
 - ./preview/2017-03-01-preview/serverAutomaticTuning.json
 - ./preview/2017-03-01-preview/serverDnsAliases.json
 - ./preview/2017-03-01-preview/serverSecurityAlertPolicies.json
 - ./preview/2017-03-01-preview/ManagedDatabaseSecurityAlertPolicies.json
 - ./preview/2017-03-01-preview/ManagedServerSecurityAlertPolicy.json
 - ./preview/2017-03-01-preview/SensitivityLabels.json
 - ./preview/2017-03-01-preview/managedInstanceAdministrators.json

# Needed when there is more than one input file
override-info:
  title: SqlManagementClient
```

### Tag: package-pure-2015-05-preview

These settings apply only when `--tag=package-pure-2015-05-preview` is specified on the command line.

This section contains all input swagger files for version 2015-05-01-preview. All APIs of that version must be added this section when the API is ready for production.

APIs must only be added to this section when the API is publicly available in at least 1 production region and at least 1 generated client has been tested end-to-end.

These can be regenerated by running the following PowerShell script from this readme file's folder: `dir .\Microsoft.Sql\preview\2015-05-01-preview\ -File | Resolve-Path -Relative | % { " - $_".Replace("\", "/") }`

``` yaml $(tag) == 'package-pure-2015-05-preview'
input-file:
 - ./preview/2015-05-01-preview/advisors.json
 - ./preview/2015-05-01-preview/blobAuditing.json
 - ./preview/2015-05-01-preview/blobAuditingPolicies.json
 - ./preview/2015-05-01-preview/databaseAutomaticTuning.json
 - ./preview/2015-05-01-preview/encryptionProtectors.json
 - ./preview/2015-05-01-preview/failoverGroups.json
 - ./preview/2015-05-01-preview/firewallRules.json
 - ./preview/2015-05-01-preview/managedInstances.json
 - ./preview/2015-05-01-preview/operations.json
 - ./preview/2015-05-01-preview/serverKeys.json
 - ./preview/2015-05-01-preview/servers.json
 - ./preview/2015-05-01-preview/syncAgents.json
 - ./preview/2015-05-01-preview/syncGroups.json
 - ./preview/2015-05-01-preview/syncMembers.json
 - ./preview/2015-05-01-preview/usages.json
 - ./preview/2015-05-01-preview/virtualclusters.json
 - ./preview/2015-05-01-preview/virtualNetworkRules.json

# Needed when there is more than one input file
override-info:
  title: SqlManagementClient
```

## Suppression

``` yaml
directive:
  - suppress: TrackedResourcePatchOperation
    from: restorableDroppedManagedDatabases.json
    reason: dropped database shouldn't support patch
```

---

## Code Generation

### Swagger to SDK

This section describes what SDK should be generated by the automatic system.
This is not used by Autorest itself.

``` yaml $(swagger-to-sdk)
swagger-to-sdk:
  - repo: azure-sdk-for-python
  - repo: azure-sdk-for-net
  - repo: azure-sdk-for-java
  - repo: azure-sdk-for-go
  - repo: azure-sdk-for-node
  - repo: azure-sdk-for-js
  - repo: azure-sdk-for-ruby
    after_scripts:
      - bundle install && rake arm:regen_all_profiles['azure_mgmt_sql']
  - repo: azure-resource-manager-schemas
  - repo: azure-powershell
```

### Python

See configuration in [readme.python.md](./readme.python.md)

### Go

See configuration in [readme.go.md](./readme.go.md)

### Java

See configuration in [readme.java.md](./readme.java.md)

## Validation

``` yaml
directive:
  - suppress: TrackedResourceListByImmediateParent
    reason: This warning gives many false positives for proxy resources.
  - suppress: GuidUsage
    reason: This warning gives many positives for existing APIs that cannot be changed.
  - suppress: EnumInsteadOfBoolean
    reason: This warning gives many positives for existing APIs that cannot be changed.
```

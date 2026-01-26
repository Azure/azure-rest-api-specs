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
tag: package-2025-01-01
```

### Composite packages

The following packages may be composed from multiple api-versions.

### Tag: package-2025-01-01

These settings apply only when `--tag=package-2025-01-01` is specified on the command line.

```yaml $(tag) == 'package-2025-01-01'
input-file:
  - Microsoft.Sql/stable/2025-01-01/BackupShortTermRetentionPolicies.json
  - Microsoft.Sql/stable/2025-01-01/BlobAuditing.json
  - Microsoft.Sql/stable/2025-01-01/DatabaseAdvancedThreatProtectionSettings.json
  - Microsoft.Sql/stable/2025-01-01/DatabaseAdvisors.json
  - Microsoft.Sql/stable/2025-01-01/DatabaseAutomaticTuning.json
  - Microsoft.Sql/stable/2025-01-01/DatabaseColumns.json
  - Microsoft.Sql/stable/2025-01-01/DatabaseEncryptionProtectorRevalidate.json
  - Microsoft.Sql/stable/2025-01-01/DatabaseEncryptionProtectorRevert.json
  - Microsoft.Sql/stable/2025-01-01/DatabaseExtensions.json
  - Microsoft.Sql/stable/2025-01-01/DatabaseOperations.json
  - Microsoft.Sql/stable/2025-01-01/DatabaseRecommendedActions.json
  - Microsoft.Sql/stable/2025-01-01/Databases.json
  - Microsoft.Sql/stable/2025-01-01/DatabaseSchemas.json
  - Microsoft.Sql/stable/2025-01-01/DatabaseSecurityAlertPolicies.json
  - Microsoft.Sql/stable/2025-01-01/DatabaseSqlVulnerabilityAssessmentBaselines.json
  - Microsoft.Sql/stable/2025-01-01/DatabaseSqlVulnerabilityAssessmentExecuteScan.json
  - Microsoft.Sql/stable/2025-01-01/DatabaseSqlVulnerabilityAssessmentRuleBaselines.json
  - Microsoft.Sql/stable/2025-01-01/DatabaseSqlVulnerabilityAssessmentScanResult.json
  - Microsoft.Sql/stable/2025-01-01/DatabaseSqlVulnerabilityAssessmentScans.json
  - Microsoft.Sql/stable/2025-01-01/DatabaseSqlVulnerabilityAssessmentsSettings.json
  - Microsoft.Sql/stable/2025-01-01/DatabaseTables.json
  - Microsoft.Sql/stable/2025-01-01/DatabaseUsages.json
  - Microsoft.Sql/stable/2025-01-01/DatabaseVulnerabilityAssessmentRuleBaselines.json
  - Microsoft.Sql/stable/2025-01-01/DatabaseVulnerabilityAssessments.json
  - Microsoft.Sql/stable/2025-01-01/DatabaseVulnerabilityAssessmentScans.json
  - Microsoft.Sql/stable/2025-01-01/DataMaskingPolicies.json
  - Microsoft.Sql/stable/2025-01-01/DataMaskingRules.json
  - Microsoft.Sql/stable/2025-01-01/DataWarehouseUserActivities.json
  - Microsoft.Sql/stable/2025-01-01/DeletedServers.json
  - Microsoft.Sql/stable/2025-01-01/DistributedAvailabilityGroups.json
  - Microsoft.Sql/stable/2025-01-01/ElasticPoolOperations.json
  - Microsoft.Sql/stable/2025-01-01/ElasticPools.json
  - Microsoft.Sql/stable/2025-01-01/EncryptionProtectors.json
  - Microsoft.Sql/stable/2025-01-01/EndpointCertificates.json
  - Microsoft.Sql/stable/2025-01-01/FailoverGroups.json
  - Microsoft.Sql/stable/2025-01-01/FirewallRules.json
  - Microsoft.Sql/stable/2025-01-01/GeoBackupPolicies.json
  - Microsoft.Sql/stable/2025-01-01/InstanceFailoverGroups.json
  - Microsoft.Sql/stable/2025-01-01/InstancePoolOperations.json
  - Microsoft.Sql/stable/2025-01-01/InstancePools.json
  - Microsoft.Sql/stable/2025-01-01/IPv6FirewallRules.json
  - Microsoft.Sql/stable/2025-01-01/JobAgents.json
  - Microsoft.Sql/stable/2025-01-01/JobCredentials.json
  - Microsoft.Sql/stable/2025-01-01/JobExecutions.json
  - Microsoft.Sql/stable/2025-01-01/JobPrivateEndpoints.json
  - Microsoft.Sql/stable/2025-01-01/Jobs.json
  - Microsoft.Sql/stable/2025-01-01/JobStepExecutions.json
  - Microsoft.Sql/stable/2025-01-01/JobSteps.json
  - Microsoft.Sql/stable/2025-01-01/JobTargetExecutions.json
  - Microsoft.Sql/stable/2025-01-01/JobTargetGroups.json
  - Microsoft.Sql/stable/2025-01-01/JobVersions.json
  - Microsoft.Sql/stable/2025-01-01/LedgerDigestUploads.json
  - Microsoft.Sql/stable/2025-01-01/LocationCapabilities.json
  - Microsoft.Sql/stable/2025-01-01/LongTermRetentionBackups.json
  - Microsoft.Sql/stable/2025-01-01/LongTermRetentionManagedInstanceBackups.json
  - Microsoft.Sql/stable/2025-01-01/LongTermRetentionPolicies.json
  - Microsoft.Sql/stable/2025-01-01/MaintenanceWindowOptions.json
  - Microsoft.Sql/stable/2025-01-01/MaintenanceWindows.json
  - Microsoft.Sql/stable/2025-01-01/ManagedBackupShortTermRetentionPolicies.json
  - Microsoft.Sql/stable/2025-01-01/ManagedDatabaseAdvancedThreatProtectionSettings.json
  - Microsoft.Sql/stable/2025-01-01/ManagedDatabaseColumns.json
  - Microsoft.Sql/stable/2025-01-01/ManagedDatabaseMoveOperations.json
  - Microsoft.Sql/stable/2025-01-01/ManagedDatabaseQueries.json
  - Microsoft.Sql/stable/2025-01-01/ManagedDatabaseRestoreDetails.json
  - Microsoft.Sql/stable/2025-01-01/ManagedDatabases.json
  - Microsoft.Sql/stable/2025-01-01/ManagedDatabaseSchemas.json
  - Microsoft.Sql/stable/2025-01-01/ManagedDatabaseSecurityAlertPolicies.json
  - Microsoft.Sql/stable/2025-01-01/ManagedDatabaseSecurityEvents.json
  - Microsoft.Sql/stable/2025-01-01/ManagedDatabaseSensitivityLabels.json
  - Microsoft.Sql/stable/2025-01-01/ManagedDatabaseTables.json
  - Microsoft.Sql/stable/2025-01-01/ManagedDatabaseTransparentDataEncryption.json
  - Microsoft.Sql/stable/2025-01-01/ManagedDatabaseVulnerabilityAssessmentRuleBaselines.json
  - Microsoft.Sql/stable/2025-01-01/ManagedDatabaseVulnerabilityAssessments.json
  - Microsoft.Sql/stable/2025-01-01/ManagedDatabaseVulnerabilityAssessmentScans.json
  - Microsoft.Sql/stable/2025-01-01/ManagedInstanceAdministrators.json
  - Microsoft.Sql/stable/2025-01-01/ManagedInstanceAdvancedThreatProtectionSettings.json
  - Microsoft.Sql/stable/2025-01-01/ManagedInstanceAzureADOnlyAuthentications.json
  - Microsoft.Sql/stable/2025-01-01/ManagedInstanceDtcs.json
  - Microsoft.Sql/stable/2025-01-01/ManagedInstanceEncryptionProtectors.json
  - Microsoft.Sql/stable/2025-01-01/ManagedInstanceKeys.json
  - Microsoft.Sql/stable/2025-01-01/ManagedInstanceLongTermRetentionPolicies.json
  - Microsoft.Sql/stable/2025-01-01/ManagedInstanceOperations.json
  - Microsoft.Sql/stable/2025-01-01/ManagedInstancePrivateEndpointConnections.json
  - Microsoft.Sql/stable/2025-01-01/ManagedInstancePrivateLinkResources.json
  - Microsoft.Sql/stable/2025-01-01/ManagedInstances.json
  - Microsoft.Sql/stable/2025-01-01/ManagedInstanceTdeCertificates.json
  - Microsoft.Sql/stable/2025-01-01/ManagedInstanceVulnerabilityAssessments.json
  - Microsoft.Sql/stable/2025-01-01/ManagedLedgerDigestUploads.json
  - Microsoft.Sql/stable/2025-01-01/ManagedRestorableDroppedDatabaseBackupShortTermRetentionPolicies.json
  - Microsoft.Sql/stable/2025-01-01/ManagedServerDnsAliases.json
  - Microsoft.Sql/stable/2025-01-01/ManagedServerSecurityAlertPolicies.json
  - Microsoft.Sql/stable/2025-01-01/NetworkSecurityPerimeterConfigurations.json
  - Microsoft.Sql/stable/2025-01-01/Operations.json
  - Microsoft.Sql/stable/2025-01-01/OutboundFirewallRules.json
  - Microsoft.Sql/stable/2025-01-01/PrivateEndpointConnections.json
  - Microsoft.Sql/stable/2025-01-01/PrivateLinkResources.json
  - Microsoft.Sql/stable/2025-01-01/RecoverableDatabases.json
  - Microsoft.Sql/stable/2025-01-01/RecoverableManagedDatabases.json
  - Microsoft.Sql/stable/2025-01-01/ReplicationLinks.json
  - Microsoft.Sql/stable/2025-01-01/RestorableDroppedDatabases.json
  - Microsoft.Sql/stable/2025-01-01/RestorableDroppedManagedDatabases.json
  - Microsoft.Sql/stable/2025-01-01/RestorePoints.json
  - Microsoft.Sql/stable/2025-01-01/SensitivityLabels.json
  - Microsoft.Sql/stable/2025-01-01/ServerAdvancedThreatProtectionSettings.json
  - Microsoft.Sql/stable/2025-01-01/ServerAdvisors.json
  - Microsoft.Sql/stable/2025-01-01/ServerAutomaticTuning.json
  - Microsoft.Sql/stable/2025-01-01/ServerAzureADAdministrators.json
  - Microsoft.Sql/stable/2025-01-01/ServerAzureADOnlyAuthentications.json
  - Microsoft.Sql/stable/2025-01-01/ServerConfigurationOptions.json
  - Microsoft.Sql/stable/2025-01-01/ServerConnectionPolicies.json
  - Microsoft.Sql/stable/2025-01-01/ServerDevOpsAudit.json
  - Microsoft.Sql/stable/2025-01-01/ServerDnsAliases.json
  - Microsoft.Sql/stable/2025-01-01/ServerKeys.json
  - Microsoft.Sql/stable/2025-01-01/ServerOperations.json
  - Microsoft.Sql/stable/2025-01-01/Servers.json
  - Microsoft.Sql/stable/2025-01-01/ServerSecurityAlertPolicies.json
  - Microsoft.Sql/stable/2025-01-01/ServerTrustCertificates.json
  - Microsoft.Sql/stable/2025-01-01/ServerTrustGroups.json
  - Microsoft.Sql/stable/2025-01-01/ServerUsages.json
  - Microsoft.Sql/stable/2025-01-01/ServerVulnerabilityAssessments.json
  - Microsoft.Sql/stable/2025-01-01/SqlAgent.json
  - Microsoft.Sql/stable/2025-01-01/SqlVulnerabilityAssessmentBaseline.json
  - Microsoft.Sql/stable/2025-01-01/SqlVulnerabilityAssessmentExecuteScan.json
  - Microsoft.Sql/stable/2025-01-01/SqlVulnerabilityAssessmentRuleBaseline.json
  - Microsoft.Sql/stable/2025-01-01/SqlVulnerabilityAssessmentScanResult.json
  - Microsoft.Sql/stable/2025-01-01/SqlVulnerabilityAssessmentScans.json
  - Microsoft.Sql/stable/2025-01-01/SqlVulnerabilityAssessmentsSettings.json
  - Microsoft.Sql/stable/2025-01-01/StartStopManagedInstanceSchedules.json
  - Microsoft.Sql/stable/2025-01-01/SubscriptionUsages.json
  - Microsoft.Sql/stable/2025-01-01/SynapseLinkWorkspaces.json
  - Microsoft.Sql/stable/2025-01-01/SyncAgents.json
  - Microsoft.Sql/stable/2025-01-01/SyncGroups.json
  - Microsoft.Sql/stable/2025-01-01/SyncMembers.json
  - Microsoft.Sql/stable/2025-01-01/TdeCertificates.json
  - Microsoft.Sql/stable/2025-01-01/TimeZones.json
  - Microsoft.Sql/stable/2025-01-01/TransparentDataEncryptions.json
  - Microsoft.Sql/stable/2025-01-01/Usages.json
  - Microsoft.Sql/stable/2025-01-01/VirtualClusters.json
  - Microsoft.Sql/stable/2025-01-01/VirtualNetworkRules.json
  - Microsoft.Sql/stable/2025-01-01/WorkloadClassifiers.json
  - Microsoft.Sql/stable/2025-01-01/WorkloadGroups.json
```

### Tag: package-preview-2024-11-01-preview

These settings apply only when `--tag=package-preview-2024-11-01-preview` is specified on the command line.

```yaml $(tag) == 'package-preview-2024-11-01-preview'
input-file:
  - Microsoft.Sql/preview/2024-11-01-preview/BackupShortTermRetentionPolicies.json
  - Microsoft.Sql/preview/2024-11-01-preview/BlobAuditing.json
  - Microsoft.Sql/preview/2024-11-01-preview/DatabaseAdvancedThreatProtectionSettings.json
  - Microsoft.Sql/preview/2024-11-01-preview/DatabaseAdvisors.json
  - Microsoft.Sql/preview/2024-11-01-preview/DatabaseAutomaticTuning.json
  - Microsoft.Sql/preview/2024-11-01-preview/DatabaseColumns.json
  - Microsoft.Sql/preview/2024-11-01-preview/DatabaseEncryptionProtectorRevalidate.json
  - Microsoft.Sql/preview/2024-11-01-preview/DatabaseEncryptionProtectorRevert.json
  - Microsoft.Sql/preview/2024-11-01-preview/DatabaseExtensions.json
  - Microsoft.Sql/preview/2024-11-01-preview/DatabaseOperations.json
  - Microsoft.Sql/preview/2024-11-01-preview/DatabaseRecommendedActions.json
  - Microsoft.Sql/preview/2024-11-01-preview/Databases.json
  - Microsoft.Sql/preview/2024-11-01-preview/DatabaseSchemas.json
  - Microsoft.Sql/preview/2024-11-01-preview/DatabaseSecurityAlertPolicies.json
  - Microsoft.Sql/preview/2024-11-01-preview/DatabaseSqlVulnerabilityAssessmentBaselines.json
  - Microsoft.Sql/preview/2024-11-01-preview/DatabaseSqlVulnerabilityAssessmentExecuteScan.json
  - Microsoft.Sql/preview/2024-11-01-preview/DatabaseSqlVulnerabilityAssessmentRuleBaselines.json
  - Microsoft.Sql/preview/2024-11-01-preview/DatabaseSqlVulnerabilityAssessmentScanResult.json
  - Microsoft.Sql/preview/2024-11-01-preview/DatabaseSqlVulnerabilityAssessmentScans.json
  - Microsoft.Sql/preview/2024-11-01-preview/DatabaseSqlVulnerabilityAssessmentsSettings.json
  - Microsoft.Sql/preview/2024-11-01-preview/DatabaseTables.json
  - Microsoft.Sql/preview/2024-11-01-preview/DatabaseUsages.json
  - Microsoft.Sql/preview/2024-11-01-preview/DatabaseVulnerabilityAssessmentRuleBaselines.json
  - Microsoft.Sql/preview/2024-11-01-preview/DatabaseVulnerabilityAssessments.json
  - Microsoft.Sql/preview/2024-11-01-preview/DatabaseVulnerabilityAssessmentScans.json
  - Microsoft.Sql/preview/2024-11-01-preview/DataMaskingPolicies.json
  - Microsoft.Sql/preview/2024-11-01-preview/DataMaskingRules.json
  - Microsoft.Sql/preview/2024-11-01-preview/DataWarehouseUserActivities.json
  - Microsoft.Sql/preview/2024-11-01-preview/DeletedServers.json
  - Microsoft.Sql/preview/2024-11-01-preview/DistributedAvailabilityGroups.json
  - Microsoft.Sql/preview/2024-11-01-preview/ElasticPoolOperations.json
  - Microsoft.Sql/preview/2024-11-01-preview/ElasticPools.json
  - Microsoft.Sql/preview/2024-11-01-preview/EncryptionProtectors.json
  - Microsoft.Sql/preview/2024-11-01-preview/EndpointCertificates.json
  - Microsoft.Sql/preview/2024-11-01-preview/FailoverGroups.json
  - Microsoft.Sql/preview/2024-11-01-preview/FirewallRules.json
  - Microsoft.Sql/preview/2024-11-01-preview/GeoBackupPolicies.json
  - Microsoft.Sql/preview/2024-11-01-preview/InstanceFailoverGroups.json
  - Microsoft.Sql/preview/2024-11-01-preview/InstancePoolOperations.json
  - Microsoft.Sql/preview/2024-11-01-preview/InstancePools.json
  - Microsoft.Sql/preview/2024-11-01-preview/IPv6FirewallRules.json
  - Microsoft.Sql/preview/2024-11-01-preview/JobAgents.json
  - Microsoft.Sql/preview/2024-11-01-preview/JobCredentials.json
  - Microsoft.Sql/preview/2024-11-01-preview/JobExecutions.json
  - Microsoft.Sql/preview/2024-11-01-preview/JobPrivateEndpoints.json
  - Microsoft.Sql/preview/2024-11-01-preview/Jobs.json
  - Microsoft.Sql/preview/2024-11-01-preview/JobStepExecutions.json
  - Microsoft.Sql/preview/2024-11-01-preview/JobSteps.json
  - Microsoft.Sql/preview/2024-11-01-preview/JobTargetExecutions.json
  - Microsoft.Sql/preview/2024-11-01-preview/JobTargetGroups.json
  - Microsoft.Sql/preview/2024-11-01-preview/JobVersions.json
  - Microsoft.Sql/preview/2024-11-01-preview/LedgerDigestUploads.json
  - Microsoft.Sql/preview/2024-11-01-preview/LocationCapabilities.json
  - Microsoft.Sql/preview/2024-11-01-preview/LongTermRetentionBackups.json
  - Microsoft.Sql/preview/2024-11-01-preview/LongTermRetentionManagedInstanceBackups.json
  - Microsoft.Sql/preview/2024-11-01-preview/LongTermRetentionPolicies.json
  - Microsoft.Sql/preview/2024-11-01-preview/MaintenanceWindowOptions.json
  - Microsoft.Sql/preview/2024-11-01-preview/MaintenanceWindows.json
  - Microsoft.Sql/preview/2024-11-01-preview/ManagedBackupShortTermRetentionPolicies.json
  - Microsoft.Sql/preview/2024-11-01-preview/ManagedDatabaseAdvancedThreatProtectionSettings.json
  - Microsoft.Sql/preview/2024-11-01-preview/ManagedDatabaseColumns.json
  - Microsoft.Sql/preview/2024-11-01-preview/ManagedDatabaseMoveOperations.json
  - Microsoft.Sql/preview/2024-11-01-preview/ManagedDatabaseQueries.json
  - Microsoft.Sql/preview/2024-11-01-preview/ManagedDatabaseRestoreDetails.json
  - Microsoft.Sql/preview/2024-11-01-preview/ManagedDatabases.json
  - Microsoft.Sql/preview/2024-11-01-preview/ManagedDatabaseSchemas.json
  - Microsoft.Sql/preview/2024-11-01-preview/ManagedDatabaseSecurityAlertPolicies.json
  - Microsoft.Sql/preview/2024-11-01-preview/ManagedDatabaseSecurityEvents.json
  - Microsoft.Sql/preview/2024-11-01-preview/ManagedDatabaseSensitivityLabels.json
  - Microsoft.Sql/preview/2024-11-01-preview/ManagedDatabaseTables.json
  - Microsoft.Sql/preview/2024-11-01-preview/ManagedDatabaseTransparentDataEncryption.json
  - Microsoft.Sql/preview/2024-11-01-preview/ManagedDatabaseVulnerabilityAssessmentRuleBaselines.json
  - Microsoft.Sql/preview/2024-11-01-preview/ManagedDatabaseVulnerabilityAssessments.json
  - Microsoft.Sql/preview/2024-11-01-preview/ManagedDatabaseVulnerabilityAssessmentScans.json
  - Microsoft.Sql/preview/2024-11-01-preview/ManagedInstanceAdministrators.json
  - Microsoft.Sql/preview/2024-11-01-preview/ManagedInstanceAdvancedThreatProtectionSettings.json
  - Microsoft.Sql/preview/2024-11-01-preview/ManagedInstanceAzureADOnlyAuthentications.json
  - Microsoft.Sql/preview/2024-11-01-preview/ManagedInstanceDtcs.json
  - Microsoft.Sql/preview/2024-11-01-preview/ManagedInstanceEncryptionProtectors.json
  - Microsoft.Sql/preview/2024-11-01-preview/ManagedInstanceKeys.json
  - Microsoft.Sql/preview/2024-11-01-preview/ManagedInstanceLongTermRetentionPolicies.json
  - Microsoft.Sql/preview/2024-11-01-preview/ManagedInstanceOperations.json
  - Microsoft.Sql/preview/2024-11-01-preview/ManagedInstancePrivateEndpointConnections.json
  - Microsoft.Sql/preview/2024-11-01-preview/ManagedInstancePrivateLinkResources.json
  - Microsoft.Sql/preview/2024-11-01-preview/ManagedInstances.json
  - Microsoft.Sql/preview/2024-11-01-preview/ManagedInstanceTdeCertificates.json
  - Microsoft.Sql/preview/2024-11-01-preview/ManagedInstanceVulnerabilityAssessments.json
  - Microsoft.Sql/preview/2024-11-01-preview/ManagedLedgerDigestUploads.json
  - Microsoft.Sql/preview/2024-11-01-preview/ManagedRestorableDroppedDatabaseBackupShortTermRetentionPolicies.json
  - Microsoft.Sql/preview/2024-11-01-preview/ManagedServerDnsAliases.json
  - Microsoft.Sql/preview/2024-11-01-preview/ManagedServerSecurityAlertPolicies.json
  - Microsoft.Sql/preview/2024-11-01-preview/NetworkSecurityPerimeterConfigurations.json
  - Microsoft.Sql/preview/2024-11-01-preview/Operations.json
  - Microsoft.Sql/preview/2024-11-01-preview/OutboundFirewallRules.json
  - Microsoft.Sql/preview/2024-11-01-preview/PrivateEndpointConnections.json
  - Microsoft.Sql/preview/2024-11-01-preview/PrivateLinkResources.json
  - Microsoft.Sql/preview/2024-11-01-preview/RecoverableDatabases.json
  - Microsoft.Sql/preview/2024-11-01-preview/RecoverableManagedDatabases.json
  - Microsoft.Sql/preview/2024-11-01-preview/ReplicationLinks.json
  - Microsoft.Sql/preview/2024-11-01-preview/RestorableDroppedDatabases.json
  - Microsoft.Sql/preview/2024-11-01-preview/RestorableDroppedManagedDatabases.json
  - Microsoft.Sql/preview/2024-11-01-preview/RestorePoints.json
  - Microsoft.Sql/preview/2024-11-01-preview/SensitivityLabels.json
  - Microsoft.Sql/preview/2024-11-01-preview/ServerAdvancedThreatProtectionSettings.json
  - Microsoft.Sql/preview/2024-11-01-preview/ServerAdvisors.json
  - Microsoft.Sql/preview/2024-11-01-preview/ServerAutomaticTuning.json
  - Microsoft.Sql/preview/2024-11-01-preview/ServerAzureADAdministrators.json
  - Microsoft.Sql/preview/2024-11-01-preview/ServerAzureADOnlyAuthentications.json
  - Microsoft.Sql/preview/2024-11-01-preview/ServerConfigurationOptions.json
  - Microsoft.Sql/preview/2024-11-01-preview/ServerConnectionPolicies.json
  - Microsoft.Sql/preview/2024-11-01-preview/ServerDevOpsAudit.json
  - Microsoft.Sql/preview/2024-11-01-preview/ServerDnsAliases.json
  - Microsoft.Sql/preview/2024-11-01-preview/ServerKeys.json
  - Microsoft.Sql/preview/2024-11-01-preview/ServerOperations.json
  - Microsoft.Sql/preview/2024-11-01-preview/Servers.json
  - Microsoft.Sql/preview/2024-11-01-preview/ServerSecurityAlertPolicies.json
  - Microsoft.Sql/preview/2024-11-01-preview/ServerTrustCertificates.json
  - Microsoft.Sql/preview/2024-11-01-preview/ServerTrustGroups.json
  - Microsoft.Sql/preview/2024-11-01-preview/ServerUsages.json
  - Microsoft.Sql/preview/2024-11-01-preview/ServerVulnerabilityAssessments.json
  - Microsoft.Sql/preview/2024-11-01-preview/SqlAgent.json
  - Microsoft.Sql/preview/2024-11-01-preview/SqlVulnerabilityAssessmentBaseline.json
  - Microsoft.Sql/preview/2024-11-01-preview/SqlVulnerabilityAssessmentExecuteScan.json
  - Microsoft.Sql/preview/2024-11-01-preview/SqlVulnerabilityAssessmentRuleBaseline.json
  - Microsoft.Sql/preview/2024-11-01-preview/SqlVulnerabilityAssessmentScanResult.json
  - Microsoft.Sql/preview/2024-11-01-preview/SqlVulnerabilityAssessmentScans.json
  - Microsoft.Sql/preview/2024-11-01-preview/SqlVulnerabilityAssessmentsSettings.json
  - Microsoft.Sql/preview/2024-11-01-preview/StartStopManagedInstanceSchedules.json
  - Microsoft.Sql/preview/2024-11-01-preview/SubscriptionUsages.json
  - Microsoft.Sql/preview/2024-11-01-preview/SynapseLinkWorkspaces.json
  - Microsoft.Sql/preview/2024-11-01-preview/SyncAgents.json
  - Microsoft.Sql/preview/2024-11-01-preview/SyncGroups.json
  - Microsoft.Sql/preview/2024-11-01-preview/SyncMembers.json
  - Microsoft.Sql/preview/2024-11-01-preview/TdeCertificates.json
  - Microsoft.Sql/preview/2024-11-01-preview/TimeZones.json
  - Microsoft.Sql/preview/2024-11-01-preview/TransparentDataEncryptions.json
  - Microsoft.Sql/preview/2024-11-01-preview/Usages.json
  - Microsoft.Sql/preview/2024-11-01-preview/VirtualClusters.json
  - Microsoft.Sql/preview/2024-11-01-preview/VirtualNetworkRules.json
  - Microsoft.Sql/preview/2024-11-01-preview/WorkloadClassifiers.json
  - Microsoft.Sql/preview/2024-11-01-preview/WorkloadGroups.json
```

### Tag: package-2023-08

These settings apply only when `--tag=package-2023-08` is specified on the command line.

``` yaml $(tag) == 'package-2023-08'
input-file:
  - Microsoft.Sql/stable/2023-08-01/BackupShortTermRetentionPolicies.json
  - Microsoft.Sql/stable/2023-08-01/BlobAuditing.json
  - Microsoft.Sql/stable/2023-08-01/DataMaskingPolicies.json
  - Microsoft.Sql/stable/2023-08-01/DataMaskingRules.json
  - Microsoft.Sql/stable/2023-08-01/DataWarehouseUserActivities.json
  - Microsoft.Sql/stable/2023-08-01/DatabaseAdvancedThreatProtectionSettings.json
  - Microsoft.Sql/stable/2023-08-01/DatabaseAdvisors.json
  - Microsoft.Sql/stable/2023-08-01/DatabaseAutomaticTuning.json
  - Microsoft.Sql/stable/2023-08-01/DatabaseColumns.json
  - Microsoft.Sql/stable/2023-08-01/DatabaseEncryptionProtectorRevalidate.json
  - Microsoft.Sql/stable/2023-08-01/DatabaseEncryptionProtectorRevert.json
  - Microsoft.Sql/stable/2023-08-01/DatabaseExtensions.json
  - Microsoft.Sql/stable/2023-08-01/DatabaseOperations.json
  - Microsoft.Sql/stable/2023-08-01/DatabaseRecommendedActions.json
  - Microsoft.Sql/stable/2023-08-01/DatabaseSchemas.json
  - Microsoft.Sql/stable/2023-08-01/DatabaseSecurityAlertPolicies.json
  - Microsoft.Sql/stable/2023-08-01/DatabaseSqlVulnerabilityAssessmentBaselines.json
  - Microsoft.Sql/stable/2023-08-01/DatabaseSqlVulnerabilityAssessmentExecuteScan.json
  - Microsoft.Sql/stable/2023-08-01/DatabaseSqlVulnerabilityAssessmentRuleBaselines.json
  - Microsoft.Sql/stable/2023-08-01/DatabaseSqlVulnerabilityAssessmentScanResult.json
  - Microsoft.Sql/stable/2023-08-01/DatabaseSqlVulnerabilityAssessmentScans.json
  - Microsoft.Sql/stable/2023-08-01/DatabaseSqlVulnerabilityAssessmentsSettings.json
  - Microsoft.Sql/stable/2023-08-01/DatabaseTables.json
  - Microsoft.Sql/stable/2023-08-01/DatabaseUsages.json
  - Microsoft.Sql/stable/2023-08-01/DatabaseVulnerabilityAssessmentRuleBaselines.json
  - Microsoft.Sql/stable/2023-08-01/DatabaseVulnerabilityAssessmentScans.json
  - Microsoft.Sql/stable/2023-08-01/DatabaseVulnerabilityAssessments.json
  - Microsoft.Sql/stable/2023-08-01/Databases.json
  - Microsoft.Sql/stable/2023-08-01/DeletedServers.json
  - Microsoft.Sql/stable/2023-08-01/DistributedAvailabilityGroups.json
  - Microsoft.Sql/stable/2023-08-01/ElasticPoolOperations.json
  - Microsoft.Sql/stable/2023-08-01/ElasticPools.json
  - Microsoft.Sql/stable/2023-08-01/EncryptionProtectors.json
  - Microsoft.Sql/stable/2023-08-01/EndpointCertificates.json
  - Microsoft.Sql/stable/2023-08-01/FailoverGroups.json
  - Microsoft.Sql/stable/2023-08-01/FirewallRules.json
  - Microsoft.Sql/stable/2023-08-01/GeoBackupPolicies.json
  - Microsoft.Sql/stable/2023-08-01/IPv6FirewallRules.json
  - Microsoft.Sql/stable/2023-08-01/InstanceFailoverGroups.json
  - Microsoft.Sql/stable/2023-08-01/InstancePools.json
  - Microsoft.Sql/stable/2023-08-01/JobAgents.json
  - Microsoft.Sql/stable/2023-08-01/JobCredentials.json
  - Microsoft.Sql/stable/2023-08-01/JobExecutions.json
  - Microsoft.Sql/stable/2023-08-01/JobPrivateEndpoints.json
  - Microsoft.Sql/stable/2023-08-01/JobStepExecutions.json
  - Microsoft.Sql/stable/2023-08-01/JobSteps.json
  - Microsoft.Sql/stable/2023-08-01/JobTargetExecutions.json
  - Microsoft.Sql/stable/2023-08-01/JobTargetGroups.json
  - Microsoft.Sql/stable/2023-08-01/JobVersions.json
  - Microsoft.Sql/stable/2023-08-01/Jobs.json
  - Microsoft.Sql/stable/2023-08-01/LedgerDigestUploads.json
  - Microsoft.Sql/stable/2023-08-01/LocationCapabilities.json
  - Microsoft.Sql/stable/2023-08-01/LongTermRetentionBackups.json
  - Microsoft.Sql/stable/2023-08-01/LongTermRetentionManagedInstanceBackups.json
  - Microsoft.Sql/stable/2023-08-01/LongTermRetentionPolicies.json
  - Microsoft.Sql/stable/2023-08-01/MaintenanceWindowOptions.json
  - Microsoft.Sql/stable/2023-08-01/MaintenanceWindows.json
  - Microsoft.Sql/stable/2023-08-01/ManagedBackupShortTermRetentionPolicies.json
  - Microsoft.Sql/stable/2023-08-01/ManagedDatabaseAdvancedThreatProtectionSettings.json
  - Microsoft.Sql/stable/2023-08-01/ManagedDatabaseColumns.json
  - Microsoft.Sql/stable/2023-08-01/ManagedDatabaseMoveOperations.json
  - Microsoft.Sql/stable/2023-08-01/ManagedDatabaseQueries.json
  - Microsoft.Sql/stable/2023-08-01/ManagedDatabaseRestoreDetails.json
  - Microsoft.Sql/stable/2023-08-01/ManagedDatabaseSchemas.json
  - Microsoft.Sql/stable/2023-08-01/ManagedDatabaseSecurityAlertPolicies.json
  - Microsoft.Sql/stable/2023-08-01/ManagedDatabaseSecurityEvents.json
  - Microsoft.Sql/stable/2023-08-01/ManagedDatabaseSensitivityLabels.json
  - Microsoft.Sql/stable/2023-08-01/ManagedDatabaseTables.json
  - Microsoft.Sql/stable/2023-08-01/ManagedDatabaseTransparentDataEncryption.json
  - Microsoft.Sql/stable/2023-08-01/ManagedDatabaseVulnerabilityAssessmentRuleBaselines.json
  - Microsoft.Sql/stable/2023-08-01/ManagedDatabaseVulnerabilityAssessmentScans.json
  - Microsoft.Sql/stable/2023-08-01/ManagedDatabaseVulnerabilityAssessments.json
  - Microsoft.Sql/stable/2023-08-01/ManagedDatabases.json
  - Microsoft.Sql/stable/2023-08-01/ManagedInstanceAdministrators.json
  - Microsoft.Sql/stable/2023-08-01/ManagedInstanceAdvancedThreatProtectionSettings.json
  - Microsoft.Sql/stable/2023-08-01/ManagedInstanceAzureADOnlyAuthentications.json
  - Microsoft.Sql/stable/2023-08-01/ManagedInstanceDtcs.json
  - Microsoft.Sql/stable/2023-08-01/ManagedInstanceEncryptionProtectors.json
  - Microsoft.Sql/stable/2023-08-01/ManagedInstanceKeys.json
  - Microsoft.Sql/stable/2023-08-01/ManagedInstanceLongTermRetentionPolicies.json
  - Microsoft.Sql/stable/2023-08-01/ManagedInstanceOperations.json
  - Microsoft.Sql/stable/2023-08-01/ManagedInstancePrivateEndpointConnections.json
  - Microsoft.Sql/stable/2023-08-01/ManagedInstancePrivateLinkResources.json
  - Microsoft.Sql/stable/2023-08-01/ManagedInstanceTdeCertificates.json
  - Microsoft.Sql/stable/2023-08-01/ManagedInstanceVulnerabilityAssessments.json
  - Microsoft.Sql/stable/2023-08-01/ManagedInstances.json
  - Microsoft.Sql/stable/2023-08-01/ManagedLedgerDigestUploads.json
  - Microsoft.Sql/stable/2023-08-01/ManagedRestorableDroppedDatabaseBackupShortTermRetentionPolicies.json
  - Microsoft.Sql/stable/2023-08-01/ManagedServerDnsAliases.json
  - Microsoft.Sql/stable/2023-08-01/ManagedServerSecurityAlertPolicies.json
  - Microsoft.Sql/stable/2023-08-01/NetworkSecurityPerimeterConfigurations.json
  - Microsoft.Sql/stable/2023-08-01/Operations.json
  - Microsoft.Sql/stable/2023-08-01/OutboundFirewallRules.json
  - Microsoft.Sql/stable/2023-08-01/PrivateEndpointConnections.json
  - Microsoft.Sql/stable/2023-08-01/PrivateLinkResources.json
  - Microsoft.Sql/stable/2023-08-01/RecoverableDatabases.json
  - Microsoft.Sql/stable/2023-08-01/RecoverableManagedDatabases.json
  - Microsoft.Sql/stable/2023-08-01/ReplicationLinks.json
  - Microsoft.Sql/stable/2023-08-01/RestorableDroppedDatabases.json
  - Microsoft.Sql/stable/2023-08-01/RestorableDroppedManagedDatabases.json
  - Microsoft.Sql/stable/2023-08-01/RestorePoints.json
  - Microsoft.Sql/stable/2023-08-01/SensitivityLabels.json
  - Microsoft.Sql/stable/2023-08-01/ServerAdvancedThreatProtectionSettings.json
  - Microsoft.Sql/stable/2023-08-01/ServerAdvisors.json
  - Microsoft.Sql/stable/2023-08-01/ServerAutomaticTuning.json
  - Microsoft.Sql/stable/2023-08-01/ServerAzureADAdministrators.json
  - Microsoft.Sql/stable/2023-08-01/ServerAzureADOnlyAuthentications.json
  - Microsoft.Sql/stable/2023-08-01/ServerConfigurationOptions.json
  - Microsoft.Sql/stable/2023-08-01/ServerConnectionPolicies.json
  - Microsoft.Sql/stable/2023-08-01/ServerDevOpsAudit.json
  - Microsoft.Sql/stable/2023-08-01/ServerDnsAliases.json
  - Microsoft.Sql/stable/2023-08-01/ServerKeys.json
  - Microsoft.Sql/stable/2023-08-01/ServerOperations.json
  - Microsoft.Sql/stable/2023-08-01/ServerSecurityAlertPolicies.json
  - Microsoft.Sql/stable/2023-08-01/ServerTrustCertificates.json
  - Microsoft.Sql/stable/2023-08-01/ServerTrustGroups.json
  - Microsoft.Sql/stable/2023-08-01/ServerUsages.json
  - Microsoft.Sql/stable/2023-08-01/ServerVulnerabilityAssessments.json
  - Microsoft.Sql/stable/2023-08-01/Servers.json
  - Microsoft.Sql/stable/2023-08-01/SqlAgent.json
  - Microsoft.Sql/stable/2023-08-01/SqlVulnerabilityAssessmentBaseline.json
  - Microsoft.Sql/stable/2023-08-01/SqlVulnerabilityAssessmentExecuteScan.json
  - Microsoft.Sql/stable/2023-08-01/SqlVulnerabilityAssessmentRuleBaseline.json
  - Microsoft.Sql/stable/2023-08-01/SqlVulnerabilityAssessmentScanResult.json
  - Microsoft.Sql/stable/2023-08-01/SqlVulnerabilityAssessmentScans.json
  - Microsoft.Sql/stable/2023-08-01/SqlVulnerabilityAssessmentsSettings.json
  - Microsoft.Sql/stable/2023-08-01/StartStopManagedInstanceSchedules.json
  - Microsoft.Sql/stable/2023-08-01/SubscriptionUsages.json
  - Microsoft.Sql/stable/2023-08-01/SynapseLinkWorkspaces.json
  - Microsoft.Sql/stable/2023-08-01/SyncAgents.json
  - Microsoft.Sql/stable/2023-08-01/SyncGroups.json
  - Microsoft.Sql/stable/2023-08-01/SyncMembers.json
  - Microsoft.Sql/stable/2023-08-01/TdeCertificates.json
  - Microsoft.Sql/stable/2023-08-01/TimeZones.json
  - Microsoft.Sql/stable/2023-08-01/TransparentDataEncryptions.json
  - Microsoft.Sql/stable/2023-08-01/Usages.json
  - Microsoft.Sql/stable/2023-08-01/VirtualClusters.json
  - Microsoft.Sql/stable/2023-08-01/VirtualNetworkRules.json
  - Microsoft.Sql/stable/2023-08-01/WorkloadClassifiers.json
  - Microsoft.Sql/stable/2023-08-01/WorkloadGroups.json
```

### Tag: package-preview-2024-05

These settings apply only when `--tag=package-preview-2024-05` is specified on the command line.

```yaml $(tag) == 'package-preview-2024-05'
input-file:
  - Microsoft.Sql/preview/2024-05-01-preview/BackupShortTermRetentionPolicies.json
  - Microsoft.Sql/preview/2024-05-01-preview/BlobAuditing.json
  - Microsoft.Sql/preview/2024-05-01-preview/DataMaskingPolicies.json
  - Microsoft.Sql/preview/2024-05-01-preview/DataMaskingRules.json
  - Microsoft.Sql/preview/2024-05-01-preview/DataWarehouseUserActivities.json
  - Microsoft.Sql/preview/2024-05-01-preview/DatabaseAdvancedThreatProtectionSettings.json
  - Microsoft.Sql/preview/2024-05-01-preview/DatabaseAdvisors.json
  - Microsoft.Sql/preview/2024-05-01-preview/DatabaseAutomaticTuning.json
  - Microsoft.Sql/preview/2024-05-01-preview/DatabaseColumns.json
  - Microsoft.Sql/preview/2024-05-01-preview/DatabaseEncryptionProtectorRevalidate.json
  - Microsoft.Sql/preview/2024-05-01-preview/DatabaseEncryptionProtectorRevert.json
  - Microsoft.Sql/preview/2024-05-01-preview/DatabaseExtensions.json
  - Microsoft.Sql/preview/2024-05-01-preview/DatabaseOperations.json
  - Microsoft.Sql/preview/2024-05-01-preview/DatabaseRecommendedActions.json
  - Microsoft.Sql/preview/2024-05-01-preview/DatabaseSchemas.json
  - Microsoft.Sql/preview/2024-05-01-preview/DatabaseSecurityAlertPolicies.json
  - Microsoft.Sql/preview/2024-05-01-preview/DatabaseSqlVulnerabilityAssessmentBaselines.json
  - Microsoft.Sql/preview/2024-05-01-preview/DatabaseSqlVulnerabilityAssessmentExecuteScan.json
  - Microsoft.Sql/preview/2024-05-01-preview/DatabaseSqlVulnerabilityAssessmentRuleBaselines.json
  - Microsoft.Sql/preview/2024-05-01-preview/DatabaseSqlVulnerabilityAssessmentScanResult.json
  - Microsoft.Sql/preview/2024-05-01-preview/DatabaseSqlVulnerabilityAssessmentScans.json
  - Microsoft.Sql/preview/2024-05-01-preview/DatabaseSqlVulnerabilityAssessmentsSettings.json
  - Microsoft.Sql/preview/2024-05-01-preview/DatabaseTables.json
  - Microsoft.Sql/preview/2024-05-01-preview/DatabaseUsages.json
  - Microsoft.Sql/preview/2024-05-01-preview/DatabaseVulnerabilityAssessmentRuleBaselines.json
  - Microsoft.Sql/preview/2024-05-01-preview/DatabaseVulnerabilityAssessmentScans.json
  - Microsoft.Sql/preview/2024-05-01-preview/DatabaseVulnerabilityAssessments.json
  - Microsoft.Sql/preview/2024-05-01-preview/Databases.json
  - Microsoft.Sql/preview/2024-05-01-preview/DeletedServers.json
  - Microsoft.Sql/preview/2024-05-01-preview/DistributedAvailabilityGroups.json
  - Microsoft.Sql/preview/2024-05-01-preview/ElasticPoolOperations.json
  - Microsoft.Sql/preview/2024-05-01-preview/ElasticPools.json
  - Microsoft.Sql/preview/2024-05-01-preview/EncryptionProtectors.json
  - Microsoft.Sql/preview/2024-05-01-preview/EndpointCertificates.json
  - Microsoft.Sql/preview/2024-05-01-preview/FailoverGroups.json
  - Microsoft.Sql/preview/2024-05-01-preview/FirewallRules.json
  - Microsoft.Sql/preview/2024-05-01-preview/GeoBackupPolicies.json
  - Microsoft.Sql/preview/2024-05-01-preview/IPv6FirewallRules.json
  - Microsoft.Sql/preview/2024-05-01-preview/InstanceFailoverGroups.json
  - Microsoft.Sql/preview/2024-05-01-preview/InstancePools.json
  - Microsoft.Sql/preview/2024-05-01-preview/InstancePoolOperations.json
  - Microsoft.Sql/preview/2024-05-01-preview/JobAgents.json
  - Microsoft.Sql/preview/2024-05-01-preview/JobCredentials.json
  - Microsoft.Sql/preview/2024-05-01-preview/JobExecutions.json
  - Microsoft.Sql/preview/2024-05-01-preview/JobPrivateEndpoints.json
  - Microsoft.Sql/preview/2024-05-01-preview/JobStepExecutions.json
  - Microsoft.Sql/preview/2024-05-01-preview/JobSteps.json
  - Microsoft.Sql/preview/2024-05-01-preview/JobTargetExecutions.json
  - Microsoft.Sql/preview/2024-05-01-preview/JobTargetGroups.json
  - Microsoft.Sql/preview/2024-05-01-preview/JobVersions.json
  - Microsoft.Sql/preview/2024-05-01-preview/Jobs.json
  - Microsoft.Sql/preview/2024-05-01-preview/LedgerDigestUploads.json
  - Microsoft.Sql/preview/2024-05-01-preview/LocationCapabilities.json
  - Microsoft.Sql/preview/2024-05-01-preview/LongTermRetentionBackups.json
  - Microsoft.Sql/preview/2024-05-01-preview/LongTermRetentionManagedInstanceBackups.json
  - Microsoft.Sql/preview/2024-05-01-preview/LongTermRetentionPolicies.json
  - Microsoft.Sql/preview/2024-05-01-preview/MaintenanceWindowOptions.json
  - Microsoft.Sql/preview/2024-05-01-preview/MaintenanceWindows.json
  - Microsoft.Sql/preview/2024-05-01-preview/ManagedBackupShortTermRetentionPolicies.json
  - Microsoft.Sql/preview/2024-05-01-preview/ManagedDatabaseAdvancedThreatProtectionSettings.json
  - Microsoft.Sql/preview/2024-05-01-preview/ManagedDatabaseColumns.json
  - Microsoft.Sql/preview/2024-05-01-preview/ManagedDatabaseMoveOperations.json
  - Microsoft.Sql/preview/2024-05-01-preview/ManagedDatabaseQueries.json
  - Microsoft.Sql/preview/2024-05-01-preview/ManagedDatabaseRestoreDetails.json
  - Microsoft.Sql/preview/2024-05-01-preview/ManagedDatabaseSchemas.json
  - Microsoft.Sql/preview/2024-05-01-preview/ManagedDatabaseSecurityAlertPolicies.json
  - Microsoft.Sql/preview/2024-05-01-preview/ManagedDatabaseSecurityEvents.json
  - Microsoft.Sql/preview/2024-05-01-preview/ManagedDatabaseSensitivityLabels.json
  - Microsoft.Sql/preview/2024-05-01-preview/ManagedDatabaseTables.json
  - Microsoft.Sql/preview/2024-05-01-preview/ManagedDatabaseTransparentDataEncryption.json
  - Microsoft.Sql/preview/2024-05-01-preview/ManagedDatabaseVulnerabilityAssessmentRuleBaselines.json
  - Microsoft.Sql/preview/2024-05-01-preview/ManagedDatabaseVulnerabilityAssessmentScans.json
  - Microsoft.Sql/preview/2024-05-01-preview/ManagedDatabaseVulnerabilityAssessments.json
  - Microsoft.Sql/preview/2024-05-01-preview/ManagedDatabases.json
  - Microsoft.Sql/preview/2024-05-01-preview/ManagedInstanceAdministrators.json
  - Microsoft.Sql/preview/2024-05-01-preview/ManagedInstanceAdvancedThreatProtectionSettings.json
  - Microsoft.Sql/preview/2024-05-01-preview/ManagedInstanceAzureADOnlyAuthentications.json
  - Microsoft.Sql/preview/2024-05-01-preview/ManagedInstanceDtcs.json
  - Microsoft.Sql/preview/2024-05-01-preview/ManagedInstanceEncryptionProtectors.json
  - Microsoft.Sql/preview/2024-05-01-preview/ManagedInstanceKeys.json
  - Microsoft.Sql/preview/2024-05-01-preview/ManagedInstanceLongTermRetentionPolicies.json
  - Microsoft.Sql/preview/2024-05-01-preview/ManagedInstanceOperations.json
  - Microsoft.Sql/preview/2024-05-01-preview/ManagedInstancePrivateEndpointConnections.json
  - Microsoft.Sql/preview/2024-05-01-preview/ManagedInstancePrivateLinkResources.json
  - Microsoft.Sql/preview/2024-05-01-preview/ManagedInstanceTdeCertificates.json
  - Microsoft.Sql/preview/2024-05-01-preview/ManagedInstanceVulnerabilityAssessments.json
  - Microsoft.Sql/preview/2024-05-01-preview/ManagedInstances.json
  - Microsoft.Sql/preview/2024-05-01-preview/ManagedLedgerDigestUploads.json
  - Microsoft.Sql/preview/2024-05-01-preview/ManagedRestorableDroppedDatabaseBackupShortTermRetentionPolicies.json
  - Microsoft.Sql/preview/2024-05-01-preview/ManagedServerDnsAliases.json
  - Microsoft.Sql/preview/2024-05-01-preview/ManagedServerSecurityAlertPolicies.json
  - Microsoft.Sql/preview/2024-05-01-preview/NetworkSecurityPerimeterConfigurations.json
  - Microsoft.Sql/preview/2024-05-01-preview/Operations.json
  - Microsoft.Sql/preview/2024-05-01-preview/OutboundFirewallRules.json
  - Microsoft.Sql/preview/2024-05-01-preview/PrivateEndpointConnections.json
  - Microsoft.Sql/preview/2024-05-01-preview/PrivateLinkResources.json
  - Microsoft.Sql/preview/2024-05-01-preview/RecoverableDatabases.json
  - Microsoft.Sql/preview/2024-05-01-preview/RecoverableManagedDatabases.json
  - Microsoft.Sql/preview/2024-05-01-preview/ReplicationLinks.json
  - Microsoft.Sql/preview/2024-05-01-preview/RestorableDroppedDatabases.json
  - Microsoft.Sql/preview/2024-05-01-preview/RestorableDroppedManagedDatabases.json
  - Microsoft.Sql/preview/2024-05-01-preview/RestorePoints.json
  - Microsoft.Sql/preview/2024-05-01-preview/SensitivityLabels.json
  - Microsoft.Sql/preview/2024-05-01-preview/ServerAdvancedThreatProtectionSettings.json
  - Microsoft.Sql/preview/2024-05-01-preview/ServerAdvisors.json
  - Microsoft.Sql/preview/2024-05-01-preview/ServerAutomaticTuning.json
  - Microsoft.Sql/preview/2024-05-01-preview/ServerAzureADAdministrators.json
  - Microsoft.Sql/preview/2024-05-01-preview/ServerAzureADOnlyAuthentications.json
  - Microsoft.Sql/preview/2024-05-01-preview/ServerConfigurationOptions.json
  - Microsoft.Sql/preview/2024-05-01-preview/ServerConnectionPolicies.json
  - Microsoft.Sql/preview/2024-05-01-preview/ServerDevOpsAudit.json
  - Microsoft.Sql/preview/2024-05-01-preview/ServerDnsAliases.json
  - Microsoft.Sql/preview/2024-05-01-preview/ServerKeys.json
  - Microsoft.Sql/preview/2024-05-01-preview/ServerOperations.json
  - Microsoft.Sql/preview/2024-05-01-preview/ServerSecurityAlertPolicies.json
  - Microsoft.Sql/preview/2024-05-01-preview/ServerTrustCertificates.json
  - Microsoft.Sql/preview/2024-05-01-preview/ServerTrustGroups.json
  - Microsoft.Sql/preview/2024-05-01-preview/ServerUsages.json
  - Microsoft.Sql/preview/2024-05-01-preview/ServerVulnerabilityAssessments.json
  - Microsoft.Sql/preview/2024-05-01-preview/Servers.json
  - Microsoft.Sql/preview/2024-05-01-preview/SqlAgent.json
  - Microsoft.Sql/preview/2024-05-01-preview/SqlVulnerabilityAssessmentBaseline.json
  - Microsoft.Sql/preview/2024-05-01-preview/SqlVulnerabilityAssessmentExecuteScan.json
  - Microsoft.Sql/preview/2024-05-01-preview/SqlVulnerabilityAssessmentRuleBaseline.json
  - Microsoft.Sql/preview/2024-05-01-preview/SqlVulnerabilityAssessmentScanResult.json
  - Microsoft.Sql/preview/2024-05-01-preview/SqlVulnerabilityAssessmentScans.json
  - Microsoft.Sql/preview/2024-05-01-preview/SqlVulnerabilityAssessmentsSettings.json
  - Microsoft.Sql/preview/2024-05-01-preview/StartStopManagedInstanceSchedules.json
  - Microsoft.Sql/preview/2024-05-01-preview/SubscriptionUsages.json
  - Microsoft.Sql/preview/2024-05-01-preview/SynapseLinkWorkspaces.json
  - Microsoft.Sql/preview/2024-05-01-preview/SyncAgents.json
  - Microsoft.Sql/preview/2024-05-01-preview/SyncGroups.json
  - Microsoft.Sql/preview/2024-05-01-preview/SyncMembers.json
  - Microsoft.Sql/preview/2024-05-01-preview/TdeCertificates.json
  - Microsoft.Sql/preview/2024-05-01-preview/TimeZones.json
  - Microsoft.Sql/preview/2024-05-01-preview/TransparentDataEncryptions.json
  - Microsoft.Sql/preview/2024-05-01-preview/Usages.json
  - Microsoft.Sql/preview/2024-05-01-preview/VirtualClusters.json
  - Microsoft.Sql/preview/2024-05-01-preview/VirtualNetworkRules.json
  - Microsoft.Sql/preview/2024-05-01-preview/WorkloadClassifiers.json
  - Microsoft.Sql/preview/2024-05-01-preview/WorkloadGroups.json
```

### Tag: package-preview-2023-08

These settings apply only when `--tag=package-preview-2023-08` is specified on the command line.

``` yaml $(tag) == 'package-preview-2023-08'
input-file:
  - Microsoft.Sql/preview/2023-08-01-preview/BackupShortTermRetentionPolicies.json
  - Microsoft.Sql/preview/2023-08-01-preview/BlobAuditing.json
  - Microsoft.Sql/preview/2023-08-01-preview/DataMaskingPolicies.json
  - Microsoft.Sql/preview/2023-08-01-preview/DataMaskingRules.json
  - Microsoft.Sql/preview/2023-08-01-preview/DataWarehouseUserActivities.json
  - Microsoft.Sql/preview/2023-08-01-preview/DatabaseAdvancedThreatProtectionSettings.json
  - Microsoft.Sql/preview/2023-08-01-preview/DatabaseAdvisors.json
  - Microsoft.Sql/preview/2023-08-01-preview/DatabaseAutomaticTuning.json
  - Microsoft.Sql/preview/2023-08-01-preview/DatabaseColumns.json
  - Microsoft.Sql/preview/2023-08-01-preview/DatabaseEncryptionProtectorRevalidate.json
  - Microsoft.Sql/preview/2023-08-01-preview/DatabaseEncryptionProtectorRevert.json
  - Microsoft.Sql/preview/2023-08-01-preview/DatabaseExtensions.json
  - Microsoft.Sql/preview/2023-08-01-preview/DatabaseOperations.json
  - Microsoft.Sql/preview/2023-08-01-preview/DatabaseRecommendedActions.json
  - Microsoft.Sql/preview/2023-08-01-preview/DatabaseSchemas.json
  - Microsoft.Sql/preview/2023-08-01-preview/DatabaseSecurityAlertPolicies.json
  - Microsoft.Sql/preview/2023-08-01-preview/DatabaseSqlVulnerabilityAssessmentBaselines.json
  - Microsoft.Sql/preview/2023-08-01-preview/DatabaseSqlVulnerabilityAssessmentExecuteScan.json
  - Microsoft.Sql/preview/2023-08-01-preview/DatabaseSqlVulnerabilityAssessmentRuleBaselines.json
  - Microsoft.Sql/preview/2023-08-01-preview/DatabaseSqlVulnerabilityAssessmentScanResult.json
  - Microsoft.Sql/preview/2023-08-01-preview/DatabaseSqlVulnerabilityAssessmentScans.json
  - Microsoft.Sql/preview/2023-08-01-preview/DatabaseSqlVulnerabilityAssessmentsSettings.json
  - Microsoft.Sql/preview/2023-08-01-preview/DatabaseTables.json
  - Microsoft.Sql/preview/2023-08-01-preview/DatabaseUsages.json
  - Microsoft.Sql/preview/2023-08-01-preview/DatabaseVulnerabilityAssessmentRuleBaselines.json
  - Microsoft.Sql/preview/2023-08-01-preview/DatabaseVulnerabilityAssessmentScans.json
  - Microsoft.Sql/preview/2023-08-01-preview/DatabaseVulnerabilityAssessments.json
  - Microsoft.Sql/preview/2023-08-01-preview/Databases.json
  - Microsoft.Sql/preview/2023-08-01-preview/DeletedServers.json
  - Microsoft.Sql/preview/2023-08-01-preview/DistributedAvailabilityGroups.json
  - Microsoft.Sql/preview/2023-08-01-preview/ElasticPoolOperations.json
  - Microsoft.Sql/preview/2023-08-01-preview/ElasticPools.json
  - Microsoft.Sql/preview/2023-08-01-preview/EncryptionProtectors.json
  - Microsoft.Sql/preview/2023-08-01-preview/EndpointCertificates.json
  - Microsoft.Sql/preview/2023-08-01-preview/FailoverGroups.json
  - Microsoft.Sql/preview/2023-08-01-preview/FirewallRules.json
  - Microsoft.Sql/preview/2023-08-01-preview/GeoBackupPolicies.json
  - Microsoft.Sql/preview/2023-08-01-preview/IPv6FirewallRules.json
  - Microsoft.Sql/preview/2023-08-01-preview/InstanceFailoverGroups.json
  - Microsoft.Sql/preview/2023-08-01-preview/InstancePools.json
  - Microsoft.Sql/preview/2023-08-01-preview/JobAgents.json
  - Microsoft.Sql/preview/2023-08-01-preview/JobCredentials.json
  - Microsoft.Sql/preview/2023-08-01-preview/JobExecutions.json
  - Microsoft.Sql/preview/2023-08-01-preview/JobPrivateEndpoints.json
  - Microsoft.Sql/preview/2023-08-01-preview/JobStepExecutions.json
  - Microsoft.Sql/preview/2023-08-01-preview/JobSteps.json
  - Microsoft.Sql/preview/2023-08-01-preview/JobTargetExecutions.json
  - Microsoft.Sql/preview/2023-08-01-preview/JobTargetGroups.json
  - Microsoft.Sql/preview/2023-08-01-preview/JobVersions.json
  - Microsoft.Sql/preview/2023-08-01-preview/Jobs.json
  - Microsoft.Sql/preview/2023-08-01-preview/LedgerDigestUploads.json
  - Microsoft.Sql/preview/2023-08-01-preview/LocationCapabilities.json
  - Microsoft.Sql/preview/2023-08-01-preview/LongTermRetentionBackups.json
  - Microsoft.Sql/preview/2023-08-01-preview/LongTermRetentionManagedInstanceBackups.json
  - Microsoft.Sql/preview/2023-08-01-preview/LongTermRetentionPolicies.json
  - Microsoft.Sql/preview/2023-08-01-preview/MaintenanceWindowOptions.json
  - Microsoft.Sql/preview/2023-08-01-preview/MaintenanceWindows.json
  - Microsoft.Sql/preview/2023-08-01-preview/ManagedBackupShortTermRetentionPolicies.json
  - Microsoft.Sql/preview/2023-08-01-preview/ManagedDatabaseAdvancedThreatProtectionSettings.json
  - Microsoft.Sql/preview/2023-08-01-preview/ManagedDatabaseColumns.json
  - Microsoft.Sql/preview/2023-08-01-preview/ManagedDatabaseMoveOperations.json
  - Microsoft.Sql/preview/2023-08-01-preview/ManagedDatabaseQueries.json
  - Microsoft.Sql/preview/2023-08-01-preview/ManagedDatabaseRestoreDetails.json
  - Microsoft.Sql/preview/2023-08-01-preview/ManagedDatabaseSchemas.json
  - Microsoft.Sql/preview/2023-08-01-preview/ManagedDatabaseSecurityAlertPolicies.json
  - Microsoft.Sql/preview/2023-08-01-preview/ManagedDatabaseSecurityEvents.json
  - Microsoft.Sql/preview/2023-08-01-preview/ManagedDatabaseSensitivityLabels.json
  - Microsoft.Sql/preview/2023-08-01-preview/ManagedDatabaseTables.json
  - Microsoft.Sql/preview/2023-08-01-preview/ManagedDatabaseTransparentDataEncryption.json
  - Microsoft.Sql/preview/2023-08-01-preview/ManagedDatabaseVulnerabilityAssessmentRuleBaselines.json
  - Microsoft.Sql/preview/2023-08-01-preview/ManagedDatabaseVulnerabilityAssessmentScans.json
  - Microsoft.Sql/preview/2023-08-01-preview/ManagedDatabaseVulnerabilityAssessments.json
  - Microsoft.Sql/preview/2023-08-01-preview/ManagedDatabases.json
  - Microsoft.Sql/preview/2023-08-01-preview/ManagedInstanceAdministrators.json
  - Microsoft.Sql/preview/2023-08-01-preview/ManagedInstanceAdvancedThreatProtectionSettings.json
  - Microsoft.Sql/preview/2023-08-01-preview/ManagedInstanceAzureADOnlyAuthentications.json
  - Microsoft.Sql/preview/2023-08-01-preview/ManagedInstanceDtcs.json
  - Microsoft.Sql/preview/2023-08-01-preview/ManagedInstanceEncryptionProtectors.json
  - Microsoft.Sql/preview/2023-08-01-preview/ManagedInstanceKeys.json
  - Microsoft.Sql/preview/2023-08-01-preview/ManagedInstanceLongTermRetentionPolicies.json
  - Microsoft.Sql/preview/2023-08-01-preview/ManagedInstanceOperations.json
  - Microsoft.Sql/preview/2023-08-01-preview/ManagedInstancePrivateEndpointConnections.json
  - Microsoft.Sql/preview/2023-08-01-preview/ManagedInstancePrivateLinkResources.json
  - Microsoft.Sql/preview/2023-08-01-preview/ManagedInstanceTdeCertificates.json
  - Microsoft.Sql/preview/2023-08-01-preview/ManagedInstanceVulnerabilityAssessments.json
  - Microsoft.Sql/preview/2023-08-01-preview/ManagedInstances.json
  - Microsoft.Sql/preview/2023-08-01-preview/ManagedLedgerDigestUploads.json
  - Microsoft.Sql/preview/2023-08-01-preview/ManagedRestorableDroppedDatabaseBackupShortTermRetentionPolicies.json
  - Microsoft.Sql/preview/2023-08-01-preview/ManagedServerDnsAliases.json
  - Microsoft.Sql/preview/2023-08-01-preview/ManagedServerSecurityAlertPolicies.json
  - Microsoft.Sql/preview/2023-08-01-preview/NetworkSecurityPerimeterConfigurations.json
  - Microsoft.Sql/preview/2023-08-01-preview/Operations.json
  - Microsoft.Sql/preview/2023-08-01-preview/OutboundFirewallRules.json
  - Microsoft.Sql/preview/2023-08-01-preview/PrivateEndpointConnections.json
  - Microsoft.Sql/preview/2023-08-01-preview/PrivateLinkResources.json
  - Microsoft.Sql/preview/2023-08-01-preview/RecoverableDatabases.json
  - Microsoft.Sql/preview/2023-08-01-preview/RecoverableManagedDatabases.json
  - Microsoft.Sql/preview/2023-08-01-preview/ReplicationLinks.json
  - Microsoft.Sql/preview/2023-08-01-preview/RestorableDroppedDatabases.json
  - Microsoft.Sql/preview/2023-08-01-preview/RestorableDroppedManagedDatabases.json
  - Microsoft.Sql/preview/2023-08-01-preview/RestorePoints.json
  - Microsoft.Sql/preview/2023-08-01-preview/SensitivityLabels.json
  - Microsoft.Sql/preview/2023-08-01-preview/ServerAdvancedThreatProtectionSettings.json
  - Microsoft.Sql/preview/2023-08-01-preview/ServerAdvisors.json
  - Microsoft.Sql/preview/2023-08-01-preview/ServerAutomaticTuning.json
  - Microsoft.Sql/preview/2023-08-01-preview/ServerAzureADAdministrators.json
  - Microsoft.Sql/preview/2023-08-01-preview/ServerAzureADOnlyAuthentications.json
  - Microsoft.Sql/preview/2023-08-01-preview/ServerConfigurationOptions.json
  - Microsoft.Sql/preview/2023-08-01-preview/ServerConnectionPolicies.json
  - Microsoft.Sql/preview/2023-08-01-preview/ServerDevOpsAudit.json
  - Microsoft.Sql/preview/2023-08-01-preview/ServerDnsAliases.json
  - Microsoft.Sql/preview/2023-08-01-preview/ServerKeys.json
  - Microsoft.Sql/preview/2023-08-01-preview/ServerOperations.json
  - Microsoft.Sql/preview/2023-08-01-preview/ServerSecurityAlertPolicies.json
  - Microsoft.Sql/preview/2023-08-01-preview/ServerTrustCertificates.json
  - Microsoft.Sql/preview/2023-08-01-preview/ServerTrustGroups.json
  - Microsoft.Sql/preview/2023-08-01-preview/ServerUsages.json
  - Microsoft.Sql/preview/2023-08-01-preview/ServerVulnerabilityAssessments.json
  - Microsoft.Sql/preview/2023-08-01-preview/Servers.json
  - Microsoft.Sql/preview/2023-08-01-preview/SqlAgent.json
  - Microsoft.Sql/preview/2023-08-01-preview/SqlVulnerabilityAssessmentBaseline.json
  - Microsoft.Sql/preview/2023-08-01-preview/SqlVulnerabilityAssessmentExecuteScan.json
  - Microsoft.Sql/preview/2023-08-01-preview/SqlVulnerabilityAssessmentRuleBaseline.json
  - Microsoft.Sql/preview/2023-08-01-preview/SqlVulnerabilityAssessmentScanResult.json
  - Microsoft.Sql/preview/2023-08-01-preview/SqlVulnerabilityAssessmentScans.json
  - Microsoft.Sql/preview/2023-08-01-preview/SqlVulnerabilityAssessmentsSettings.json
  - Microsoft.Sql/preview/2023-08-01-preview/StartStopManagedInstanceSchedules.json
  - Microsoft.Sql/preview/2023-08-01-preview/SubscriptionUsages.json
  - Microsoft.Sql/preview/2023-08-01-preview/SynapseLinkWorkspaces.json
  - Microsoft.Sql/preview/2023-08-01-preview/SyncAgents.json
  - Microsoft.Sql/preview/2023-08-01-preview/SyncGroups.json
  - Microsoft.Sql/preview/2023-08-01-preview/SyncMembers.json
  - Microsoft.Sql/preview/2023-08-01-preview/TdeCertificates.json
  - Microsoft.Sql/preview/2023-08-01-preview/TimeZones.json
  - Microsoft.Sql/preview/2023-08-01-preview/TransparentDataEncryptions.json
  - Microsoft.Sql/preview/2023-08-01-preview/Usages.json
  - Microsoft.Sql/preview/2023-08-01-preview/VirtualClusters.json
  - Microsoft.Sql/preview/2023-08-01-preview/VirtualNetworkRules.json
  - Microsoft.Sql/preview/2023-08-01-preview/WorkloadClassifiers.json
  - Microsoft.Sql/preview/2023-08-01-preview/WorkloadGroups.json
```

### Tag: package-preview-2023-05

These settings apply only when `--tag=package-preview-2023-05` is specified on the command line.

``` yaml $(tag) == 'package-preview-2023-05'
input-file:
  - Microsoft.Sql/preview/2023-05-01-preview/BackupShortTermRetentionPolicies.json
  - Microsoft.Sql/preview/2023-05-01-preview/BlobAuditing.json
  - Microsoft.Sql/preview/2023-05-01-preview/DataMaskingPolicies.json
  - Microsoft.Sql/preview/2023-05-01-preview/DataMaskingRules.json
  - Microsoft.Sql/preview/2023-05-01-preview/DataWarehouseUserActivities.json
  - Microsoft.Sql/preview/2023-05-01-preview/DatabaseAdvancedThreatProtectionSettings.json
  - Microsoft.Sql/preview/2023-05-01-preview/DatabaseAdvisors.json
  - Microsoft.Sql/preview/2023-05-01-preview/DatabaseAutomaticTuning.json
  - Microsoft.Sql/preview/2023-05-01-preview/DatabaseColumns.json
  - Microsoft.Sql/preview/2023-05-01-preview/DatabaseEncryptionProtectorRevalidate.json
  - Microsoft.Sql/preview/2023-05-01-preview/DatabaseEncryptionProtectorRevert.json
  - Microsoft.Sql/preview/2023-05-01-preview/DatabaseExtensions.json
  - Microsoft.Sql/preview/2023-05-01-preview/DatabaseOperations.json
  - Microsoft.Sql/preview/2023-05-01-preview/DatabaseRecommendedActions.json
  - Microsoft.Sql/preview/2023-05-01-preview/DatabaseSchemas.json
  - Microsoft.Sql/preview/2023-05-01-preview/DatabaseSecurityAlertPolicies.json
  - Microsoft.Sql/preview/2023-05-01-preview/DatabaseSqlVulnerabilityAssessmentBaselines.json
  - Microsoft.Sql/preview/2023-05-01-preview/DatabaseSqlVulnerabilityAssessmentExecuteScan.json
  - Microsoft.Sql/preview/2023-05-01-preview/DatabaseSqlVulnerabilityAssessmentRuleBaselines.json
  - Microsoft.Sql/preview/2023-05-01-preview/DatabaseSqlVulnerabilityAssessmentScanResult.json
  - Microsoft.Sql/preview/2023-05-01-preview/DatabaseSqlVulnerabilityAssessmentScans.json
  - Microsoft.Sql/preview/2023-05-01-preview/DatabaseSqlVulnerabilityAssessmentsSettings.json
  - Microsoft.Sql/preview/2023-05-01-preview/DatabaseTables.json
  - Microsoft.Sql/preview/2023-05-01-preview/DatabaseUsages.json
  - Microsoft.Sql/preview/2023-05-01-preview/DatabaseVulnerabilityAssessmentRuleBaselines.json
  - Microsoft.Sql/preview/2023-05-01-preview/DatabaseVulnerabilityAssessmentScans.json
  - Microsoft.Sql/preview/2023-05-01-preview/DatabaseVulnerabilityAssessments.json
  - Microsoft.Sql/preview/2023-05-01-preview/Databases.json
  - Microsoft.Sql/preview/2023-05-01-preview/DeletedServers.json
  - Microsoft.Sql/preview/2023-05-01-preview/DistributedAvailabilityGroups.json
  - Microsoft.Sql/preview/2023-05-01-preview/ElasticPoolOperations.json
  - Microsoft.Sql/preview/2023-05-01-preview/ElasticPools.json
  - Microsoft.Sql/preview/2023-05-01-preview/EncryptionProtectors.json
  - Microsoft.Sql/preview/2023-05-01-preview/EndpointCertificates.json
  - Microsoft.Sql/preview/2023-05-01-preview/FailoverGroups.json
  - Microsoft.Sql/preview/2023-05-01-preview/FirewallRules.json
  - Microsoft.Sql/preview/2023-05-01-preview/GeoBackupPolicies.json
  - Microsoft.Sql/preview/2023-05-01-preview/IPv6FirewallRules.json
  - Microsoft.Sql/preview/2023-05-01-preview/InstanceFailoverGroups.json
  - Microsoft.Sql/preview/2023-05-01-preview/InstancePools.json
  - Microsoft.Sql/preview/2023-05-01-preview/JobAgents.json
  - Microsoft.Sql/preview/2023-05-01-preview/JobCredentials.json
  - Microsoft.Sql/preview/2023-05-01-preview/JobExecutions.json
  - Microsoft.Sql/preview/2023-05-01-preview/JobPrivateEndpoints.json
  - Microsoft.Sql/preview/2023-05-01-preview/JobStepExecutions.json
  - Microsoft.Sql/preview/2023-05-01-preview/JobSteps.json
  - Microsoft.Sql/preview/2023-05-01-preview/JobTargetExecutions.json
  - Microsoft.Sql/preview/2023-05-01-preview/JobTargetGroups.json
  - Microsoft.Sql/preview/2023-05-01-preview/JobVersions.json
  - Microsoft.Sql/preview/2023-05-01-preview/Jobs.json
  - Microsoft.Sql/preview/2023-05-01-preview/LedgerDigestUploads.json
  - Microsoft.Sql/preview/2023-05-01-preview/LocationCapabilities.json
  - Microsoft.Sql/preview/2023-05-01-preview/LongTermRetentionBackups.json
  - Microsoft.Sql/preview/2023-05-01-preview/LongTermRetentionManagedInstanceBackups.json
  - Microsoft.Sql/preview/2023-05-01-preview/LongTermRetentionPolicies.json
  - Microsoft.Sql/preview/2023-05-01-preview/MaintenanceWindowOptions.json
  - Microsoft.Sql/preview/2023-05-01-preview/MaintenanceWindows.json
  - Microsoft.Sql/preview/2023-05-01-preview/ManagedBackupShortTermRetentionPolicies.json
  - Microsoft.Sql/preview/2023-05-01-preview/ManagedDatabaseAdvancedThreatProtectionSettings.json
  - Microsoft.Sql/preview/2023-05-01-preview/ManagedDatabaseColumns.json
  - Microsoft.Sql/preview/2023-05-01-preview/ManagedDatabaseMoveOperations.json
  - Microsoft.Sql/preview/2023-05-01-preview/ManagedDatabaseQueries.json
  - Microsoft.Sql/preview/2023-05-01-preview/ManagedDatabaseRestoreDetails.json
  - Microsoft.Sql/preview/2023-05-01-preview/ManagedDatabaseSchemas.json
  - Microsoft.Sql/preview/2023-05-01-preview/ManagedDatabaseSecurityAlertPolicies.json
  - Microsoft.Sql/preview/2023-05-01-preview/ManagedDatabaseSecurityEvents.json
  - Microsoft.Sql/preview/2023-05-01-preview/ManagedDatabaseSensitivityLabels.json
  - Microsoft.Sql/preview/2023-05-01-preview/ManagedDatabaseTables.json
  - Microsoft.Sql/preview/2023-05-01-preview/ManagedDatabaseTransparentDataEncryption.json
  - Microsoft.Sql/preview/2023-05-01-preview/ManagedDatabaseVulnerabilityAssessmentRuleBaselines.json
  - Microsoft.Sql/preview/2023-05-01-preview/ManagedDatabaseVulnerabilityAssessmentScans.json
  - Microsoft.Sql/preview/2023-05-01-preview/ManagedDatabaseVulnerabilityAssessments.json
  - Microsoft.Sql/preview/2023-05-01-preview/ManagedDatabases.json
  - Microsoft.Sql/preview/2023-05-01-preview/ManagedInstanceAdministrators.json
  - Microsoft.Sql/preview/2023-05-01-preview/ManagedInstanceAdvancedThreatProtectionSettings.json
  - Microsoft.Sql/preview/2023-05-01-preview/ManagedInstanceAzureADOnlyAuthentications.json
  - Microsoft.Sql/preview/2023-05-01-preview/ManagedInstanceDtcs.json
  - Microsoft.Sql/preview/2023-05-01-preview/ManagedInstanceEncryptionProtectors.json
  - Microsoft.Sql/preview/2023-05-01-preview/ManagedInstanceKeys.json
  - Microsoft.Sql/preview/2023-05-01-preview/ManagedInstanceLongTermRetentionPolicies.json
  - Microsoft.Sql/preview/2023-05-01-preview/ManagedInstanceOperations.json
  - Microsoft.Sql/preview/2023-05-01-preview/ManagedInstancePrivateEndpointConnections.json
  - Microsoft.Sql/preview/2023-05-01-preview/ManagedInstancePrivateLinkResources.json
  - Microsoft.Sql/preview/2023-05-01-preview/ManagedInstanceTdeCertificates.json
  - Microsoft.Sql/preview/2023-05-01-preview/ManagedInstanceVulnerabilityAssessments.json
  - Microsoft.Sql/preview/2023-05-01-preview/ManagedInstances.json
  - Microsoft.Sql/preview/2023-05-01-preview/ManagedLedgerDigestUploads.json
  - Microsoft.Sql/preview/2023-05-01-preview/ManagedRestorableDroppedDatabaseBackupShortTermRetentionPolicies.json
  - Microsoft.Sql/preview/2023-05-01-preview/ManagedServerDnsAliases.json
  - Microsoft.Sql/preview/2023-05-01-preview/ManagedServerSecurityAlertPolicies.json
  - Microsoft.Sql/preview/2023-05-01-preview/NetworkSecurityPerimeterConfigurations.json
  - Microsoft.Sql/preview/2023-05-01-preview/Operations.json
  - Microsoft.Sql/preview/2023-05-01-preview/OutboundFirewallRules.json
  - Microsoft.Sql/preview/2023-05-01-preview/PrivateEndpointConnections.json
  - Microsoft.Sql/preview/2023-05-01-preview/PrivateLinkResources.json
  - Microsoft.Sql/preview/2023-05-01-preview/RecoverableDatabases.json
  - Microsoft.Sql/preview/2023-05-01-preview/RecoverableManagedDatabases.json
  - Microsoft.Sql/preview/2023-05-01-preview/ReplicationLinks.json
  - Microsoft.Sql/preview/2023-05-01-preview/RestorableDroppedDatabases.json
  - Microsoft.Sql/preview/2023-05-01-preview/RestorableDroppedManagedDatabases.json
  - Microsoft.Sql/preview/2023-05-01-preview/RestorePoints.json
  - Microsoft.Sql/preview/2023-05-01-preview/SensitivityLabels.json
  - Microsoft.Sql/preview/2023-05-01-preview/ServerAdvancedThreatProtectionSettings.json
  - Microsoft.Sql/preview/2023-05-01-preview/ServerAdvisors.json
  - Microsoft.Sql/preview/2023-05-01-preview/ServerAutomaticTuning.json
  - Microsoft.Sql/preview/2023-05-01-preview/ServerAzureADAdministrators.json
  - Microsoft.Sql/preview/2023-05-01-preview/ServerAzureADOnlyAuthentications.json
  - Microsoft.Sql/preview/2023-05-01-preview/ServerConfigurationOptions.json
  - Microsoft.Sql/preview/2023-05-01-preview/ServerConnectionPolicies.json
  - Microsoft.Sql/preview/2023-05-01-preview/ServerDevOpsAudit.json
  - Microsoft.Sql/preview/2023-05-01-preview/ServerDnsAliases.json
  - Microsoft.Sql/preview/2023-05-01-preview/ServerKeys.json
  - Microsoft.Sql/preview/2023-05-01-preview/ServerOperations.json
  - Microsoft.Sql/preview/2023-05-01-preview/ServerSecurityAlertPolicies.json
  - Microsoft.Sql/preview/2023-05-01-preview/ServerTrustCertificates.json
  - Microsoft.Sql/preview/2023-05-01-preview/ServerTrustGroups.json
  - Microsoft.Sql/preview/2023-05-01-preview/ServerUsages.json
  - Microsoft.Sql/preview/2023-05-01-preview/ServerVulnerabilityAssessments.json
  - Microsoft.Sql/preview/2023-05-01-preview/Servers.json
  - Microsoft.Sql/preview/2023-05-01-preview/SqlAgent.json
  - Microsoft.Sql/preview/2023-05-01-preview/SqlVulnerabilityAssessmentBaseline.json
  - Microsoft.Sql/preview/2023-05-01-preview/SqlVulnerabilityAssessmentExecuteScan.json
  - Microsoft.Sql/preview/2023-05-01-preview/SqlVulnerabilityAssessmentRuleBaseline.json
  - Microsoft.Sql/preview/2023-05-01-preview/SqlVulnerabilityAssessmentScanResult.json
  - Microsoft.Sql/preview/2023-05-01-preview/SqlVulnerabilityAssessmentScans.json
  - Microsoft.Sql/preview/2023-05-01-preview/SqlVulnerabilityAssessmentsSettings.json
  - Microsoft.Sql/preview/2023-05-01-preview/StartStopManagedInstanceSchedules.json
  - Microsoft.Sql/preview/2023-05-01-preview/SubscriptionUsages.json
  - Microsoft.Sql/preview/2023-05-01-preview/SynapseLinkWorkspaces.json
  - Microsoft.Sql/preview/2023-05-01-preview/SyncAgents.json
  - Microsoft.Sql/preview/2023-05-01-preview/SyncGroups.json
  - Microsoft.Sql/preview/2023-05-01-preview/SyncMembers.json
  - Microsoft.Sql/preview/2023-05-01-preview/TdeCertificates.json
  - Microsoft.Sql/preview/2023-05-01-preview/TimeZones.json
  - Microsoft.Sql/preview/2023-05-01-preview/TransparentDataEncryptions.json
  - Microsoft.Sql/preview/2023-05-01-preview/Usages.json
  - Microsoft.Sql/preview/2023-05-01-preview/VirtualClusters.json
  - Microsoft.Sql/preview/2023-05-01-preview/VirtualNetworkRules.json
  - Microsoft.Sql/preview/2023-05-01-preview/WorkloadClassifiers.json
  - Microsoft.Sql/preview/2023-05-01-preview/WorkloadGroups.json
```

### Tag: package-preview-2023-02

These settings apply only when `--tag=package-preview-2023-02` is specified on the command line.

``` yaml $(tag) == 'package-preview-2023-02'
input-file:
  - Microsoft.Sql/preview/2023-02-01-preview/BackupShortTermRetentionPolicies.json
  - Microsoft.Sql/preview/2023-02-01-preview/BlobAuditing.json
  - Microsoft.Sql/preview/2023-02-01-preview/DataMaskingPolicies.json
  - Microsoft.Sql/preview/2023-02-01-preview/DataMaskingRules.json
  - Microsoft.Sql/preview/2023-02-01-preview/DataWarehouseUserActivities.json
  - Microsoft.Sql/preview/2023-02-01-preview/DatabaseAdvancedThreatProtectionSettings.json
  - Microsoft.Sql/preview/2023-02-01-preview/DatabaseAdvisors.json
  - Microsoft.Sql/preview/2023-02-01-preview/DatabaseAutomaticTuning.json
  - Microsoft.Sql/preview/2023-02-01-preview/DatabaseColumns.json
  - Microsoft.Sql/preview/2023-02-01-preview/DatabaseEncryptionProtectorRevalidate.json
  - Microsoft.Sql/preview/2023-02-01-preview/DatabaseEncryptionProtectorRevert.json
  - Microsoft.Sql/preview/2023-02-01-preview/DatabaseExtensions.json
  - Microsoft.Sql/preview/2023-02-01-preview/DatabaseOperations.json
  - Microsoft.Sql/preview/2023-02-01-preview/DatabaseRecommendedActions.json
  - Microsoft.Sql/preview/2023-02-01-preview/DatabaseSchemas.json
  - Microsoft.Sql/preview/2023-02-01-preview/DatabaseSecurityAlertPolicies.json
  - Microsoft.Sql/preview/2023-02-01-preview/DatabaseSqlVulnerabilityAssessmentBaselines.json
  - Microsoft.Sql/preview/2023-02-01-preview/DatabaseSqlVulnerabilityAssessmentExecuteScan.json
  - Microsoft.Sql/preview/2023-02-01-preview/DatabaseSqlVulnerabilityAssessmentRuleBaselines.json
  - Microsoft.Sql/preview/2023-02-01-preview/DatabaseSqlVulnerabilityAssessmentScanResult.json
  - Microsoft.Sql/preview/2023-02-01-preview/DatabaseSqlVulnerabilityAssessmentScans.json
  - Microsoft.Sql/preview/2023-02-01-preview/DatabaseSqlVulnerabilityAssessmentsSettings.json
  - Microsoft.Sql/preview/2023-02-01-preview/DatabaseTables.json
  - Microsoft.Sql/preview/2023-02-01-preview/DatabaseUsages.json
  - Microsoft.Sql/preview/2023-02-01-preview/DatabaseVulnerabilityAssessmentRuleBaselines.json
  - Microsoft.Sql/preview/2023-02-01-preview/DatabaseVulnerabilityAssessmentScans.json
  - Microsoft.Sql/preview/2023-02-01-preview/DatabaseVulnerabilityAssessments.json
  - Microsoft.Sql/preview/2023-02-01-preview/Databases.json
  - Microsoft.Sql/preview/2023-02-01-preview/DeletedServers.json
  - Microsoft.Sql/preview/2023-02-01-preview/DistributedAvailabilityGroups.json
  - Microsoft.Sql/preview/2023-02-01-preview/ElasticPoolOperations.json
  - Microsoft.Sql/preview/2023-02-01-preview/ElasticPools.json
  - Microsoft.Sql/preview/2023-02-01-preview/EncryptionProtectors.json
  - Microsoft.Sql/preview/2023-02-01-preview/EndpointCertificates.json
  - Microsoft.Sql/preview/2023-02-01-preview/FailoverGroups.json
  - Microsoft.Sql/preview/2023-02-01-preview/FirewallRules.json
  - Microsoft.Sql/preview/2023-02-01-preview/GeoBackupPolicies.json
  - Microsoft.Sql/preview/2023-02-01-preview/IPv6FirewallRules.json
  - Microsoft.Sql/preview/2023-02-01-preview/InstanceFailoverGroups.json
  - Microsoft.Sql/preview/2023-02-01-preview/InstancePools.json
  - Microsoft.Sql/preview/2023-02-01-preview/JobAgents.json
  - Microsoft.Sql/preview/2023-02-01-preview/JobCredentials.json
  - Microsoft.Sql/preview/2023-02-01-preview/JobExecutions.json
  - Microsoft.Sql/preview/2023-02-01-preview/JobStepExecutions.json
  - Microsoft.Sql/preview/2023-02-01-preview/JobSteps.json
  - Microsoft.Sql/preview/2023-02-01-preview/JobTargetExecutions.json
  - Microsoft.Sql/preview/2023-02-01-preview/JobTargetGroups.json
  - Microsoft.Sql/preview/2023-02-01-preview/JobVersions.json
  - Microsoft.Sql/preview/2023-02-01-preview/Jobs.json
  - Microsoft.Sql/preview/2023-02-01-preview/LedgerDigestUploads.json
  - Microsoft.Sql/preview/2023-02-01-preview/LocationCapabilities.json
  - Microsoft.Sql/preview/2023-02-01-preview/LongTermRetentionBackups.json
  - Microsoft.Sql/preview/2023-02-01-preview/LongTermRetentionManagedInstanceBackups.json
  - Microsoft.Sql/preview/2023-02-01-preview/LongTermRetentionPolicies.json
  - Microsoft.Sql/preview/2023-02-01-preview/MaintenanceWindowOptions.json
  - Microsoft.Sql/preview/2023-02-01-preview/MaintenanceWindows.json
  - Microsoft.Sql/preview/2023-02-01-preview/ManagedBackupShortTermRetentionPolicies.json
  - Microsoft.Sql/preview/2023-02-01-preview/ManagedDatabaseAdvancedThreatProtectionSettings.json
  - Microsoft.Sql/preview/2023-02-01-preview/ManagedDatabaseColumns.json
  - Microsoft.Sql/preview/2023-02-01-preview/ManagedDatabaseMoveOperations.json
  - Microsoft.Sql/preview/2023-02-01-preview/ManagedDatabaseQueries.json
  - Microsoft.Sql/preview/2023-02-01-preview/ManagedDatabaseRestoreDetails.json
  - Microsoft.Sql/preview/2023-02-01-preview/ManagedDatabaseSchemas.json
  - Microsoft.Sql/preview/2023-02-01-preview/ManagedDatabaseSecurityAlertPolicies.json
  - Microsoft.Sql/preview/2023-02-01-preview/ManagedDatabaseSecurityEvents.json
  - Microsoft.Sql/preview/2023-02-01-preview/ManagedDatabaseSensitivityLabels.json
  - Microsoft.Sql/preview/2023-02-01-preview/ManagedDatabaseTables.json
  - Microsoft.Sql/preview/2023-02-01-preview/ManagedDatabaseTransparentDataEncryption.json
  - Microsoft.Sql/preview/2023-02-01-preview/ManagedDatabaseVulnerabilityAssessmentRuleBaselines.json
  - Microsoft.Sql/preview/2023-02-01-preview/ManagedDatabaseVulnerabilityAssessmentScans.json
  - Microsoft.Sql/preview/2023-02-01-preview/ManagedDatabaseVulnerabilityAssessments.json
  - Microsoft.Sql/preview/2023-02-01-preview/ManagedDatabases.json
  - Microsoft.Sql/preview/2023-02-01-preview/ManagedInstanceAdministrators.json
  - Microsoft.Sql/preview/2023-02-01-preview/ManagedInstanceAdvancedThreatProtectionSettings.json
  - Microsoft.Sql/preview/2023-02-01-preview/ManagedInstanceAzureADOnlyAuthentications.json
  - Microsoft.Sql/preview/2023-02-01-preview/ManagedInstanceDtcs.json
  - Microsoft.Sql/preview/2023-02-01-preview/ManagedInstanceEncryptionProtectors.json
  - Microsoft.Sql/preview/2023-02-01-preview/ManagedInstanceKeys.json
  - Microsoft.Sql/preview/2023-02-01-preview/ManagedInstanceLongTermRetentionPolicies.json
  - Microsoft.Sql/preview/2023-02-01-preview/ManagedInstanceOperations.json
  - Microsoft.Sql/preview/2023-02-01-preview/ManagedInstancePrivateEndpointConnections.json
  - Microsoft.Sql/preview/2023-02-01-preview/ManagedInstancePrivateLinkResources.json
  - Microsoft.Sql/preview/2023-02-01-preview/ManagedInstanceTdeCertificates.json
  - Microsoft.Sql/preview/2023-02-01-preview/ManagedInstanceVulnerabilityAssessments.json
  - Microsoft.Sql/preview/2023-02-01-preview/ManagedInstances.json
  - Microsoft.Sql/preview/2023-02-01-preview/ManagedLedgerDigestUploads.json
  - Microsoft.Sql/preview/2023-02-01-preview/ManagedRestorableDroppedDatabaseBackupShortTermRetentionPolicies.json
  - Microsoft.Sql/preview/2023-02-01-preview/ManagedServerDnsAliases.json
  - Microsoft.Sql/preview/2023-02-01-preview/ManagedServerSecurityAlertPolicies.json
  - Microsoft.Sql/preview/2023-02-01-preview/NetworkSecurityPerimeterConfigurations.json
  - Microsoft.Sql/preview/2023-02-01-preview/Operations.json
  - Microsoft.Sql/preview/2023-02-01-preview/OutboundFirewallRules.json
  - Microsoft.Sql/preview/2023-02-01-preview/PrivateEndpointConnections.json
  - Microsoft.Sql/preview/2023-02-01-preview/PrivateLinkResources.json
  - Microsoft.Sql/preview/2023-02-01-preview/RecoverableDatabases.json
  - Microsoft.Sql/preview/2023-02-01-preview/RecoverableManagedDatabases.json
  - Microsoft.Sql/preview/2023-02-01-preview/ReplicationLinks.json
  - Microsoft.Sql/preview/2023-02-01-preview/RestorableDroppedDatabases.json
  - Microsoft.Sql/preview/2023-02-01-preview/RestorableDroppedManagedDatabases.json
  - Microsoft.Sql/preview/2023-02-01-preview/RestorePoints.json
  - Microsoft.Sql/preview/2023-02-01-preview/SensitivityLabels.json
  - Microsoft.Sql/preview/2023-02-01-preview/ServerAdvancedThreatProtectionSettings.json
  - Microsoft.Sql/preview/2023-02-01-preview/ServerAdvisors.json
  - Microsoft.Sql/preview/2023-02-01-preview/ServerAutomaticTuning.json
  - Microsoft.Sql/preview/2023-02-01-preview/ServerAzureADAdministrators.json
  - Microsoft.Sql/preview/2023-02-01-preview/ServerAzureADOnlyAuthentications.json
  - Microsoft.Sql/preview/2023-02-01-preview/ServerConfigurationOptions.json
  - Microsoft.Sql/preview/2023-02-01-preview/ServerConnectionPolicies.json
  - Microsoft.Sql/preview/2023-02-01-preview/ServerDevOpsAudit.json
  - Microsoft.Sql/preview/2023-02-01-preview/ServerDnsAliases.json
  - Microsoft.Sql/preview/2023-02-01-preview/ServerKeys.json
  - Microsoft.Sql/preview/2023-02-01-preview/ServerOperations.json
  - Microsoft.Sql/preview/2023-02-01-preview/ServerSecurityAlertPolicies.json
  - Microsoft.Sql/preview/2023-02-01-preview/ServerTrustCertificates.json
  - Microsoft.Sql/preview/2023-02-01-preview/ServerTrustGroups.json
  - Microsoft.Sql/preview/2023-02-01-preview/ServerUsages.json
  - Microsoft.Sql/preview/2023-02-01-preview/ServerVulnerabilityAssessments.json
  - Microsoft.Sql/preview/2023-02-01-preview/Servers.json
  - Microsoft.Sql/preview/2023-02-01-preview/SqlAgent.json
  - Microsoft.Sql/preview/2023-02-01-preview/SqlVulnerabilityAssessmentBaseline.json
  - Microsoft.Sql/preview/2023-02-01-preview/SqlVulnerabilityAssessmentExecuteScan.json
  - Microsoft.Sql/preview/2023-02-01-preview/SqlVulnerabilityAssessmentRuleBaseline.json
  - Microsoft.Sql/preview/2023-02-01-preview/SqlVulnerabilityAssessmentScanResult.json
  - Microsoft.Sql/preview/2023-02-01-preview/SqlVulnerabilityAssessmentScans.json
  - Microsoft.Sql/preview/2023-02-01-preview/SqlVulnerabilityAssessmentsSettings.json
  - Microsoft.Sql/preview/2023-02-01-preview/StartStopManagedInstanceSchedules.json
  - Microsoft.Sql/preview/2023-02-01-preview/SubscriptionUsages.json
  - Microsoft.Sql/preview/2023-02-01-preview/SynapseLinkWorkspaces.json
  - Microsoft.Sql/preview/2023-02-01-preview/SyncAgents.json
  - Microsoft.Sql/preview/2023-02-01-preview/SyncGroups.json
  - Microsoft.Sql/preview/2023-02-01-preview/SyncMembers.json
  - Microsoft.Sql/preview/2023-02-01-preview/TdeCertificates.json
  - Microsoft.Sql/preview/2023-02-01-preview/TimeZones.json
  - Microsoft.Sql/preview/2023-02-01-preview/TransparentDataEncryptions.json
  - Microsoft.Sql/preview/2023-02-01-preview/Usages.json
  - Microsoft.Sql/preview/2023-02-01-preview/VirtualClusters.json
  - Microsoft.Sql/preview/2023-02-01-preview/VirtualNetworkRules.json
  - Microsoft.Sql/preview/2023-02-01-preview/WorkloadClassifiers.json
  - Microsoft.Sql/preview/2023-02-01-preview/WorkloadGroups.json
```

### Tag: package-preview-2022-11

These settings apply only when `--tag=package-preview-2022-11` is specified on the command line.

``` yaml $(tag) == 'package-preview-2022-11'
input-file:
  - Microsoft.Sql/preview/2022-11-01-preview/BackupShortTermRetentionPolicies.json
  - Microsoft.Sql/preview/2022-11-01-preview/BlobAuditing.json
  - Microsoft.Sql/preview/2022-11-01-preview/DataMaskingPolicies.json
  - Microsoft.Sql/preview/2022-11-01-preview/DataMaskingRules.json
  - Microsoft.Sql/preview/2022-11-01-preview/DataWarehouseUserActivities.json
  - Microsoft.Sql/preview/2022-11-01-preview/DatabaseAdvancedThreatProtectionSettings.json
  - Microsoft.Sql/preview/2022-11-01-preview/DatabaseAdvisors.json
  - Microsoft.Sql/preview/2022-11-01-preview/DatabaseAutomaticTuning.json
  - Microsoft.Sql/preview/2022-11-01-preview/DatabaseColumns.json
  - Microsoft.Sql/preview/2022-11-01-preview/DatabaseEncryptionProtectorRevalidate.json
  - Microsoft.Sql/preview/2022-11-01-preview/DatabaseEncryptionProtectorRevert.json
  - Microsoft.Sql/preview/2022-11-01-preview/DatabaseExtensions.json
  - Microsoft.Sql/preview/2022-11-01-preview/DatabaseOperations.json
  - Microsoft.Sql/preview/2022-11-01-preview/DatabaseRecommendedActions.json
  - Microsoft.Sql/preview/2022-11-01-preview/DatabaseSchemas.json
  - Microsoft.Sql/preview/2022-11-01-preview/DatabaseSecurityAlertPolicies.json
  - Microsoft.Sql/preview/2022-11-01-preview/DatabaseSqlVulnerabilityAssessmentBaselines.json
  - Microsoft.Sql/preview/2022-11-01-preview/DatabaseSqlVulnerabilityAssessmentExecuteScan.json
  - Microsoft.Sql/preview/2022-11-01-preview/DatabaseSqlVulnerabilityAssessmentRuleBaselines.json
  - Microsoft.Sql/preview/2022-11-01-preview/DatabaseSqlVulnerabilityAssessmentScanResult.json
  - Microsoft.Sql/preview/2022-11-01-preview/DatabaseSqlVulnerabilityAssessmentScans.json
  - Microsoft.Sql/preview/2022-11-01-preview/DatabaseSqlVulnerabilityAssessmentsSettings.json
  - Microsoft.Sql/preview/2022-11-01-preview/DatabaseTables.json
  - Microsoft.Sql/preview/2022-11-01-preview/DatabaseUsages.json
  - Microsoft.Sql/preview/2022-11-01-preview/DatabaseVulnerabilityAssessmentRuleBaselines.json
  - Microsoft.Sql/preview/2022-11-01-preview/DatabaseVulnerabilityAssessmentScans.json
  - Microsoft.Sql/preview/2022-11-01-preview/DatabaseVulnerabilityAssessments.json
  - Microsoft.Sql/preview/2022-11-01-preview/Databases.json
  - Microsoft.Sql/preview/2022-11-01-preview/DeletedServers.json
  - Microsoft.Sql/preview/2022-11-01-preview/DistributedAvailabilityGroups.json
  - Microsoft.Sql/preview/2022-11-01-preview/ElasticPoolOperations.json
  - Microsoft.Sql/preview/2022-11-01-preview/ElasticPools.json
  - Microsoft.Sql/preview/2022-11-01-preview/EncryptionProtectors.json
  - Microsoft.Sql/preview/2022-11-01-preview/EndpointCertificates.json
  - Microsoft.Sql/preview/2022-11-01-preview/FailoverGroups.json
  - Microsoft.Sql/preview/2022-11-01-preview/FirewallRules.json
  - Microsoft.Sql/preview/2022-11-01-preview/GeoBackupPolicies.json
  - Microsoft.Sql/preview/2022-11-01-preview/IPv6FirewallRules.json
  - Microsoft.Sql/preview/2022-11-01-preview/InstanceFailoverGroups.json
  - Microsoft.Sql/preview/2022-11-01-preview/InstancePools.json
  - Microsoft.Sql/preview/2022-11-01-preview/JobAgents.json
  - Microsoft.Sql/preview/2022-11-01-preview/JobCredentials.json
  - Microsoft.Sql/preview/2022-11-01-preview/JobExecutions.json
  - Microsoft.Sql/preview/2022-11-01-preview/JobStepExecutions.json
  - Microsoft.Sql/preview/2022-11-01-preview/JobSteps.json
  - Microsoft.Sql/preview/2022-11-01-preview/JobTargetExecutions.json
  - Microsoft.Sql/preview/2022-11-01-preview/JobTargetGroups.json
  - Microsoft.Sql/preview/2022-11-01-preview/JobVersions.json
  - Microsoft.Sql/preview/2022-11-01-preview/Jobs.json
  - Microsoft.Sql/preview/2022-11-01-preview/LedgerDigestUploads.json
  - Microsoft.Sql/preview/2022-11-01-preview/LocationCapabilities.json
  - Microsoft.Sql/preview/2022-11-01-preview/LongTermRetentionBackups.json
  - Microsoft.Sql/preview/2022-11-01-preview/LongTermRetentionManagedInstanceBackups.json
  - Microsoft.Sql/preview/2022-11-01-preview/LongTermRetentionPolicies.json
  - Microsoft.Sql/preview/2022-11-01-preview/MaintenanceWindowOptions.json
  - Microsoft.Sql/preview/2022-11-01-preview/MaintenanceWindows.json
  - Microsoft.Sql/preview/2022-11-01-preview/ManagedBackupShortTermRetentionPolicies.json
  - Microsoft.Sql/preview/2022-11-01-preview/ManagedDatabaseAdvancedThreatProtectionSettings.json
  - Microsoft.Sql/preview/2022-11-01-preview/ManagedDatabaseColumns.json
  - Microsoft.Sql/preview/2022-11-01-preview/ManagedDatabaseMoveOperations.json
  - Microsoft.Sql/preview/2022-11-01-preview/ManagedDatabaseQueries.json
  - Microsoft.Sql/preview/2022-11-01-preview/ManagedDatabaseRestoreDetails.json
  - Microsoft.Sql/preview/2022-11-01-preview/ManagedDatabaseSchemas.json
  - Microsoft.Sql/preview/2022-11-01-preview/ManagedDatabaseSecurityAlertPolicies.json
  - Microsoft.Sql/preview/2022-11-01-preview/ManagedDatabaseSecurityEvents.json
  - Microsoft.Sql/preview/2022-11-01-preview/ManagedDatabaseSensitivityLabels.json
  - Microsoft.Sql/preview/2022-11-01-preview/ManagedDatabaseTables.json
  - Microsoft.Sql/preview/2022-11-01-preview/ManagedDatabaseTransparentDataEncryption.json
  - Microsoft.Sql/preview/2022-11-01-preview/ManagedDatabaseVulnerabilityAssessmentRuleBaselines.json
  - Microsoft.Sql/preview/2022-11-01-preview/ManagedDatabaseVulnerabilityAssessmentScans.json
  - Microsoft.Sql/preview/2022-11-01-preview/ManagedDatabaseVulnerabilityAssessments.json
  - Microsoft.Sql/preview/2022-11-01-preview/ManagedDatabases.json
  - Microsoft.Sql/preview/2022-11-01-preview/ManagedInstanceAdministrators.json
  - Microsoft.Sql/preview/2022-11-01-preview/ManagedInstanceAdvancedThreatProtectionSettings.json
  - Microsoft.Sql/preview/2022-11-01-preview/ManagedInstanceAzureADOnlyAuthentications.json
  - Microsoft.Sql/preview/2022-11-01-preview/ManagedInstanceDtcs.json
  - Microsoft.Sql/preview/2022-11-01-preview/ManagedInstanceEncryptionProtectors.json
  - Microsoft.Sql/preview/2022-11-01-preview/ManagedInstanceKeys.json
  - Microsoft.Sql/preview/2022-11-01-preview/ManagedInstanceLongTermRetentionPolicies.json
  - Microsoft.Sql/preview/2022-11-01-preview/ManagedInstanceOperations.json
  - Microsoft.Sql/preview/2022-11-01-preview/ManagedInstancePrivateEndpointConnections.json
  - Microsoft.Sql/preview/2022-11-01-preview/ManagedInstancePrivateLinkResources.json
  - Microsoft.Sql/preview/2022-11-01-preview/ManagedInstanceTdeCertificates.json
  - Microsoft.Sql/preview/2022-11-01-preview/ManagedInstanceVulnerabilityAssessments.json
  - Microsoft.Sql/preview/2022-11-01-preview/ManagedInstances.json
  - Microsoft.Sql/preview/2022-11-01-preview/ManagedLedgerDigestUploads.json
  - Microsoft.Sql/preview/2022-11-01-preview/ManagedRestorableDroppedDatabaseBackupShortTermRetentionPolicies.json
  - Microsoft.Sql/preview/2022-11-01-preview/ManagedServerDnsAliases.json
  - Microsoft.Sql/preview/2022-11-01-preview/ManagedServerSecurityAlertPolicies.json
  - Microsoft.Sql/preview/2022-11-01-preview/NetworkSecurityPerimeterConfigurations.json
  - Microsoft.Sql/preview/2022-11-01-preview/Operations.json
  - Microsoft.Sql/preview/2022-11-01-preview/OutboundFirewallRules.json
  - Microsoft.Sql/preview/2022-11-01-preview/PrivateEndpointConnections.json
  - Microsoft.Sql/preview/2022-11-01-preview/PrivateLinkResources.json
  - Microsoft.Sql/preview/2022-11-01-preview/RecoverableDatabases.json
  - Microsoft.Sql/preview/2022-11-01-preview/RecoverableManagedDatabases.json
  - Microsoft.Sql/preview/2022-11-01-preview/ReplicationLinks.json
  - Microsoft.Sql/preview/2022-11-01-preview/RestorableDroppedDatabases.json
  - Microsoft.Sql/preview/2022-11-01-preview/RestorableDroppedManagedDatabases.json
  - Microsoft.Sql/preview/2022-11-01-preview/RestorePoints.json
  - Microsoft.Sql/preview/2022-11-01-preview/SensitivityLabels.json
  - Microsoft.Sql/preview/2022-11-01-preview/ServerAdvancedThreatProtectionSettings.json
  - Microsoft.Sql/preview/2022-11-01-preview/ServerAdvisors.json
  - Microsoft.Sql/preview/2022-11-01-preview/ServerAutomaticTuning.json
  - Microsoft.Sql/preview/2022-11-01-preview/ServerAzureADAdministrators.json
  - Microsoft.Sql/preview/2022-11-01-preview/ServerAzureADOnlyAuthentications.json
  - Microsoft.Sql/preview/2022-11-01-preview/ServerConfigurationOptions.json
  - Microsoft.Sql/preview/2022-11-01-preview/ServerConnectionPolicies.json
  - Microsoft.Sql/preview/2022-11-01-preview/ServerDevOpsAudit.json
  - Microsoft.Sql/preview/2022-11-01-preview/ServerDnsAliases.json
  - Microsoft.Sql/preview/2022-11-01-preview/ServerKeys.json
  - Microsoft.Sql/preview/2022-11-01-preview/ServerOperations.json
  - Microsoft.Sql/preview/2022-11-01-preview/ServerSecurityAlertPolicies.json
  - Microsoft.Sql/preview/2022-11-01-preview/ServerTrustCertificates.json
  - Microsoft.Sql/preview/2022-11-01-preview/ServerTrustGroups.json
  - Microsoft.Sql/preview/2022-11-01-preview/ServerUsages.json
  - Microsoft.Sql/preview/2022-11-01-preview/ServerVulnerabilityAssessments.json
  - Microsoft.Sql/preview/2022-11-01-preview/Servers.json
  - Microsoft.Sql/preview/2022-11-01-preview/SqlAgent.json
  - Microsoft.Sql/preview/2022-11-01-preview/SqlVulnerabilityAssessmentBaseline.json
  - Microsoft.Sql/preview/2022-11-01-preview/SqlVulnerabilityAssessmentExecuteScan.json
  - Microsoft.Sql/preview/2022-11-01-preview/SqlVulnerabilityAssessmentRuleBaseline.json
  - Microsoft.Sql/preview/2022-11-01-preview/SqlVulnerabilityAssessmentScanResult.json
  - Microsoft.Sql/preview/2022-11-01-preview/SqlVulnerabilityAssessmentScans.json
  - Microsoft.Sql/preview/2022-11-01-preview/SqlVulnerabilityAssessmentsSettings.json
  - Microsoft.Sql/preview/2022-11-01-preview/StartStopManagedInstanceSchedules.json
  - Microsoft.Sql/preview/2022-11-01-preview/SubscriptionUsages.json
  - Microsoft.Sql/preview/2022-11-01-preview/SynapseLinkWorkspaces.json
  - Microsoft.Sql/preview/2022-11-01-preview/SyncAgents.json
  - Microsoft.Sql/preview/2022-11-01-preview/SyncGroups.json
  - Microsoft.Sql/preview/2022-11-01-preview/SyncMembers.json
  - Microsoft.Sql/preview/2022-11-01-preview/TdeCertificates.json
  - Microsoft.Sql/preview/2022-11-01-preview/TimeZones.json
  - Microsoft.Sql/preview/2022-11-01-preview/TransparentDataEncryptions.json
  - Microsoft.Sql/preview/2022-11-01-preview/Usages.json
  - Microsoft.Sql/preview/2022-11-01-preview/VirtualClusters.json
  - Microsoft.Sql/preview/2022-11-01-preview/VirtualNetworkRules.json
  - Microsoft.Sql/preview/2022-11-01-preview/WorkloadClassifiers.json
  - Microsoft.Sql/preview/2022-11-01-preview/WorkloadGroups.json
```

### Tag: package-preview-2022-08

These settings apply only when `--tag=package-preview-2022-08` is specified on the command line.

``` yaml $(tag) == 'package-preview-2022-08'
input-file:
  - Microsoft.Sql/preview/2022-08-01-preview/BackupShortTermRetentionPolicies.json
  - Microsoft.Sql/preview/2022-08-01-preview/BlobAuditing.json
  - Microsoft.Sql/preview/2022-08-01-preview/DataMaskingPolicies.json
  - Microsoft.Sql/preview/2022-08-01-preview/DataMaskingRules.json
  - Microsoft.Sql/preview/2022-08-01-preview/DataWarehouseUserActivities.json
  - Microsoft.Sql/preview/2022-08-01-preview/DatabaseAdvancedThreatProtectionSettings.json
  - Microsoft.Sql/preview/2022-08-01-preview/DatabaseAdvisors.json
  - Microsoft.Sql/preview/2022-08-01-preview/DatabaseAutomaticTuning.json
  - Microsoft.Sql/preview/2022-08-01-preview/DatabaseColumns.json
  - Microsoft.Sql/preview/2022-08-01-preview/DatabaseEncryptionProtectorRevalidate.json
  - Microsoft.Sql/preview/2022-08-01-preview/DatabaseEncryptionProtectorRevert.json
  - Microsoft.Sql/preview/2022-08-01-preview/DatabaseExtensions.json
  - Microsoft.Sql/preview/2022-08-01-preview/DatabaseOperations.json
  - Microsoft.Sql/preview/2022-08-01-preview/DatabaseRecommendedActions.json
  - Microsoft.Sql/preview/2022-08-01-preview/DatabaseSchemas.json
  - Microsoft.Sql/preview/2022-08-01-preview/DatabaseSecurityAlertPolicies.json
  - Microsoft.Sql/preview/2022-08-01-preview/DatabaseSqlVulnerabilityAssessmentBaselines.json
  - Microsoft.Sql/preview/2022-08-01-preview/DatabaseSqlVulnerabilityAssessmentExecuteScan.json
  - Microsoft.Sql/preview/2022-08-01-preview/DatabaseSqlVulnerabilityAssessmentRuleBaselines.json
  - Microsoft.Sql/preview/2022-08-01-preview/DatabaseSqlVulnerabilityAssessmentScanResult.json
  - Microsoft.Sql/preview/2022-08-01-preview/DatabaseSqlVulnerabilityAssessmentScans.json
  - Microsoft.Sql/preview/2022-08-01-preview/DatabaseSqlVulnerabilityAssessmentsSettings.json
  - Microsoft.Sql/preview/2022-08-01-preview/DatabaseTables.json
  - Microsoft.Sql/preview/2022-08-01-preview/DatabaseUsages.json
  - Microsoft.Sql/preview/2022-08-01-preview/DatabaseVulnerabilityAssessmentRuleBaselines.json
  - Microsoft.Sql/preview/2022-08-01-preview/DatabaseVulnerabilityAssessmentScans.json
  - Microsoft.Sql/preview/2022-08-01-preview/DatabaseVulnerabilityAssessments.json
  - Microsoft.Sql/preview/2022-08-01-preview/Databases.json
  - Microsoft.Sql/preview/2022-08-01-preview/DeletedServers.json
  - Microsoft.Sql/preview/2022-08-01-preview/DistributedAvailabilityGroups.json
  - Microsoft.Sql/preview/2022-08-01-preview/ElasticPoolOperations.json
  - Microsoft.Sql/preview/2022-08-01-preview/ElasticPools.json
  - Microsoft.Sql/preview/2022-08-01-preview/EncryptionProtectors.json
  - Microsoft.Sql/preview/2022-08-01-preview/EndpointCertificates.json
  - Microsoft.Sql/preview/2022-08-01-preview/FailoverGroups.json
  - Microsoft.Sql/preview/2022-08-01-preview/FirewallRules.json
  - Microsoft.Sql/preview/2022-08-01-preview/GeoBackupPolicies.json
  - Microsoft.Sql/preview/2022-08-01-preview/IPv6FirewallRules.json
  - Microsoft.Sql/preview/2022-08-01-preview/InstanceFailoverGroups.json
  - Microsoft.Sql/preview/2022-08-01-preview/InstancePools.json
  - Microsoft.Sql/preview/2022-08-01-preview/JobAgents.json
  - Microsoft.Sql/preview/2022-08-01-preview/JobCredentials.json
  - Microsoft.Sql/preview/2022-08-01-preview/JobExecutions.json
  - Microsoft.Sql/preview/2022-08-01-preview/JobStepExecutions.json
  - Microsoft.Sql/preview/2022-08-01-preview/JobSteps.json
  - Microsoft.Sql/preview/2022-08-01-preview/JobTargetExecutions.json
  - Microsoft.Sql/preview/2022-08-01-preview/JobTargetGroups.json
  - Microsoft.Sql/preview/2022-08-01-preview/JobVersions.json
  - Microsoft.Sql/preview/2022-08-01-preview/Jobs.json
  - Microsoft.Sql/preview/2022-08-01-preview/LedgerDigestUploads.json
  - Microsoft.Sql/preview/2022-08-01-preview/LocationCapabilities.json
  - Microsoft.Sql/preview/2022-08-01-preview/LongTermRetentionBackups.json
  - Microsoft.Sql/preview/2022-08-01-preview/LongTermRetentionManagedInstanceBackups.json
  - Microsoft.Sql/preview/2022-08-01-preview/LongTermRetentionPolicies.json
  - Microsoft.Sql/preview/2022-08-01-preview/MaintenanceWindowOptions.json
  - Microsoft.Sql/preview/2022-08-01-preview/MaintenanceWindows.json
  - Microsoft.Sql/preview/2022-08-01-preview/ManagedBackupShortTermRetentionPolicies.json
  - Microsoft.Sql/preview/2022-08-01-preview/ManagedDatabaseAdvancedThreatProtectionSettings.json
  - Microsoft.Sql/preview/2022-08-01-preview/ManagedDatabaseColumns.json
  - Microsoft.Sql/preview/2022-08-01-preview/ManagedDatabaseMoveOperations.json
  - Microsoft.Sql/preview/2022-08-01-preview/ManagedDatabaseQueries.json
  - Microsoft.Sql/preview/2022-08-01-preview/ManagedDatabaseRestoreDetails.json
  - Microsoft.Sql/preview/2022-08-01-preview/ManagedDatabaseSchemas.json
  - Microsoft.Sql/preview/2022-08-01-preview/ManagedDatabaseSecurityAlertPolicies.json
  - Microsoft.Sql/preview/2022-08-01-preview/ManagedDatabaseSecurityEvents.json
  - Microsoft.Sql/preview/2022-08-01-preview/ManagedDatabaseSensitivityLabels.json
  - Microsoft.Sql/preview/2022-08-01-preview/ManagedDatabaseTables.json
  - Microsoft.Sql/preview/2022-08-01-preview/ManagedDatabaseTransparentDataEncryption.json
  - Microsoft.Sql/preview/2022-08-01-preview/ManagedDatabaseVulnerabilityAssessmentRuleBaselines.json
  - Microsoft.Sql/preview/2022-08-01-preview/ManagedDatabaseVulnerabilityAssessmentScans.json
  - Microsoft.Sql/preview/2022-08-01-preview/ManagedDatabaseVulnerabilityAssessments.json
  - Microsoft.Sql/preview/2022-08-01-preview/ManagedDatabases.json
  - Microsoft.Sql/preview/2022-08-01-preview/ManagedInstanceAdministrators.json
  - Microsoft.Sql/preview/2022-08-01-preview/ManagedInstanceAdvancedThreatProtectionSettings.json
  - Microsoft.Sql/preview/2022-08-01-preview/ManagedInstanceAzureADOnlyAuthentications.json
  - Microsoft.Sql/preview/2022-08-01-preview/ManagedInstanceDtcs.json
  - Microsoft.Sql/preview/2022-08-01-preview/ManagedInstanceEncryptionProtectors.json
  - Microsoft.Sql/preview/2022-08-01-preview/ManagedInstanceKeys.json
  - Microsoft.Sql/preview/2022-08-01-preview/ManagedInstanceLongTermRetentionPolicies.json
  - Microsoft.Sql/preview/2022-08-01-preview/ManagedInstanceOperations.json
  - Microsoft.Sql/preview/2022-08-01-preview/ManagedInstancePrivateEndpointConnections.json
  - Microsoft.Sql/preview/2022-08-01-preview/ManagedInstancePrivateLinkResources.json
  - Microsoft.Sql/preview/2022-08-01-preview/ManagedInstanceTdeCertificates.json
  - Microsoft.Sql/preview/2022-08-01-preview/ManagedInstanceVulnerabilityAssessments.json
  - Microsoft.Sql/preview/2022-08-01-preview/ManagedInstances.json
  - Microsoft.Sql/preview/2022-08-01-preview/ManagedLedgerDigestUploads.json
  - Microsoft.Sql/preview/2022-08-01-preview/ManagedRestorableDroppedDatabaseBackupShortTermRetentionPolicies.json
  - Microsoft.Sql/preview/2022-08-01-preview/ManagedServerDnsAliases.json
  - Microsoft.Sql/preview/2022-08-01-preview/ManagedServerSecurityAlertPolicies.json
  - Microsoft.Sql/preview/2022-08-01-preview/Operations.json
  - Microsoft.Sql/preview/2022-08-01-preview/OutboundFirewallRules.json
  - Microsoft.Sql/preview/2022-08-01-preview/PrivateEndpointConnections.json
  - Microsoft.Sql/preview/2022-08-01-preview/PrivateLinkResources.json
  - Microsoft.Sql/preview/2022-08-01-preview/RecoverableDatabases.json
  - Microsoft.Sql/preview/2022-08-01-preview/RecoverableManagedDatabases.json
  - Microsoft.Sql/preview/2022-08-01-preview/ReplicationLinks.json
  - Microsoft.Sql/preview/2022-08-01-preview/RestorableDroppedDatabases.json
  - Microsoft.Sql/preview/2022-08-01-preview/RestorableDroppedManagedDatabases.json
  - Microsoft.Sql/preview/2022-08-01-preview/RestorePoints.json
  - Microsoft.Sql/preview/2022-08-01-preview/SensitivityLabels.json
  - Microsoft.Sql/preview/2022-08-01-preview/ServerAdvancedThreatProtectionSettings.json
  - Microsoft.Sql/preview/2022-08-01-preview/ServerAdvisors.json
  - Microsoft.Sql/preview/2022-08-01-preview/ServerAutomaticTuning.json
  - Microsoft.Sql/preview/2022-08-01-preview/ServerAzureADAdministrators.json
  - Microsoft.Sql/preview/2022-08-01-preview/ServerAzureADOnlyAuthentications.json
  - Microsoft.Sql/preview/2022-08-01-preview/ServerConfigurationOptions.json
  - Microsoft.Sql/preview/2022-08-01-preview/ServerConnectionPolicies.json
  - Microsoft.Sql/preview/2022-08-01-preview/ServerDevOpsAudit.json
  - Microsoft.Sql/preview/2022-08-01-preview/ServerDnsAliases.json
  - Microsoft.Sql/preview/2022-08-01-preview/ServerKeys.json
  - Microsoft.Sql/preview/2022-08-01-preview/ServerOperations.json
  - Microsoft.Sql/preview/2022-08-01-preview/ServerSecurityAlertPolicies.json
  - Microsoft.Sql/preview/2022-08-01-preview/ServerTrustCertificates.json
  - Microsoft.Sql/preview/2022-08-01-preview/ServerTrustGroups.json
  - Microsoft.Sql/preview/2022-08-01-preview/ServerUsages.json
  - Microsoft.Sql/preview/2022-08-01-preview/ServerVulnerabilityAssessments.json
  - Microsoft.Sql/preview/2022-08-01-preview/Servers.json
  - Microsoft.Sql/preview/2022-08-01-preview/SqlAgent.json
  - Microsoft.Sql/preview/2022-08-01-preview/SqlVulnerabilityAssessmentBaseline.json
  - Microsoft.Sql/preview/2022-08-01-preview/SqlVulnerabilityAssessmentExecuteScan.json
  - Microsoft.Sql/preview/2022-08-01-preview/SqlVulnerabilityAssessmentRuleBaseline.json
  - Microsoft.Sql/preview/2022-08-01-preview/SqlVulnerabilityAssessmentScanResult.json
  - Microsoft.Sql/preview/2022-08-01-preview/SqlVulnerabilityAssessmentScans.json
  - Microsoft.Sql/preview/2022-08-01-preview/SqlVulnerabilityAssessmentsSettings.json
  - Microsoft.Sql/preview/2022-08-01-preview/StartStopManagedInstanceSchedules.json
  - Microsoft.Sql/preview/2022-08-01-preview/SubscriptionUsages.json
  - Microsoft.Sql/preview/2022-08-01-preview/SynapseLinkWorkspaces.json
  - Microsoft.Sql/preview/2022-08-01-preview/SyncAgents.json
  - Microsoft.Sql/preview/2022-08-01-preview/SyncGroups.json
  - Microsoft.Sql/preview/2022-08-01-preview/SyncMembers.json
  - Microsoft.Sql/preview/2022-08-01-preview/TdeCertificates.json
  - Microsoft.Sql/preview/2022-08-01-preview/TimeZones.json
  - Microsoft.Sql/preview/2022-08-01-preview/TransparentDataEncryptions.json
  - Microsoft.Sql/preview/2022-08-01-preview/Usages.json
  - Microsoft.Sql/preview/2022-08-01-preview/VirtualClusters.json
  - Microsoft.Sql/preview/2022-08-01-preview/VirtualNetworkRules.json
  - Microsoft.Sql/preview/2022-08-01-preview/WorkloadClassifiers.json
  - Microsoft.Sql/preview/2022-08-01-preview/WorkloadGroups.json
```

### Tag: package-2021-11

These settings apply only when `--tag=package-2021-11` is specified on the command line.

``` yaml $(tag) == 'package-2021-11'
input-file:
 - ./Microsoft.Sql/stable/2021-11-01/BackupShortTermRetentionPolicies.json
 - ./Microsoft.Sql/stable/2021-11-01/BlobAuditing.json
 - ./Microsoft.Sql/stable/2021-11-01/DatabaseAdvancedThreatProtectionSettings.json
 - ./Microsoft.Sql/stable/2021-11-01/DatabaseAdvisors.json
 - ./Microsoft.Sql/stable/2021-11-01/DatabaseAutomaticTuning.json
 - ./Microsoft.Sql/stable/2021-11-01/DatabaseColumns.json
 - ./Microsoft.Sql/stable/2021-11-01/DatabaseExtensions.json
 - ./Microsoft.Sql/stable/2021-11-01/DatabaseOperations.json
 - ./Microsoft.Sql/stable/2021-11-01/DatabaseRecommendedActions.json
 - ./Microsoft.Sql/stable/2021-11-01/Databases.json
 - ./Microsoft.Sql/stable/2021-11-01/DatabaseSchemas.json
 - ./Microsoft.Sql/stable/2021-11-01/DatabaseSecurityAlertPolicies.json
 - ./Microsoft.Sql/stable/2021-11-01/DatabaseTables.json
 - ./Microsoft.Sql/stable/2021-11-01/DatabaseUsages.json
 - ./Microsoft.Sql/stable/2021-11-01/DatabaseVulnerabilityAssessmentRuleBaselines.json
 - ./Microsoft.Sql/stable/2021-11-01/DatabaseVulnerabilityAssessments.json
 - ./Microsoft.Sql/stable/2021-11-01/DatabaseVulnerabilityAssessmentScans.json
 - ./Microsoft.Sql/stable/2021-11-01/DataMaskingPolicies.json
 - ./Microsoft.Sql/stable/2021-11-01/DataMaskingRules.json
 - ./Microsoft.Sql/stable/2021-11-01/DataWarehouseUserActivities.json
 - ./Microsoft.Sql/stable/2021-11-01/DeletedServers.json
 - ./Microsoft.Sql/stable/2021-11-01/DistributedAvailabilityGroups.json
 - ./Microsoft.Sql/stable/2021-11-01/ElasticPoolOperations.json
 - ./Microsoft.Sql/stable/2021-11-01/ElasticPools.json
 - ./Microsoft.Sql/stable/2021-11-01/EncryptionProtectors.json
 - ./Microsoft.Sql/stable/2021-11-01/EndpointCertificates.json
 - ./Microsoft.Sql/stable/2021-11-01/FailoverGroups.json
 - ./Microsoft.Sql/stable/2021-11-01/FirewallRules.json
 - ./Microsoft.Sql/stable/2021-11-01/GeoBackupPolicies.json
 - ./Microsoft.Sql/stable/2021-11-01/InstanceFailoverGroups.json
 - ./Microsoft.Sql/stable/2021-11-01/InstancePools.json
 - ./Microsoft.Sql/stable/2021-11-01/IPv6FirewallRules.json
 - ./Microsoft.Sql/stable/2021-11-01/JobAgents.json
 - ./Microsoft.Sql/stable/2021-11-01/JobCredentials.json
 - ./Microsoft.Sql/stable/2021-11-01/JobExecutions.json
 - ./Microsoft.Sql/stable/2021-11-01/Jobs.json
 - ./Microsoft.Sql/stable/2021-11-01/JobStepExecutions.json
 - ./Microsoft.Sql/stable/2021-11-01/JobSteps.json
 - ./Microsoft.Sql/stable/2021-11-01/JobTargetExecutions.json
 - ./Microsoft.Sql/stable/2021-11-01/JobTargetGroups.json
 - ./Microsoft.Sql/stable/2021-11-01/JobVersions.json
 - ./Microsoft.Sql/stable/2021-11-01/LedgerDigestUploads.json
 - ./Microsoft.Sql/stable/2021-11-01/LocationCapabilities.json
 - ./Microsoft.Sql/stable/2021-11-01/LongTermRetentionBackups.json
 - ./Microsoft.Sql/stable/2021-11-01/LongTermRetentionManagedInstanceBackups.json
 - ./Microsoft.Sql/stable/2021-11-01/LongTermRetentionPolicies.json
 - ./Microsoft.Sql/stable/2021-11-01/MaintenanceWindowOptions.json
 - ./Microsoft.Sql/stable/2021-11-01/MaintenanceWindows.json
 - ./Microsoft.Sql/stable/2021-11-01/ManagedBackupShortTermRetentionPolicies.json
 - ./Microsoft.Sql/stable/2021-11-01/ManagedDatabaseColumns.json
 - ./Microsoft.Sql/stable/2021-11-01/ManagedDatabaseQueries.json
 - ./Microsoft.Sql/stable/2021-11-01/ManagedDatabaseRestoreDetails.json
 - ./Microsoft.Sql/stable/2021-11-01/ManagedDatabases.json
 - ./Microsoft.Sql/stable/2021-11-01/ManagedDatabaseSchemas.json
 - ./Microsoft.Sql/stable/2021-11-01/ManagedDatabaseSecurityAlertPolicies.json
 - ./Microsoft.Sql/stable/2021-11-01/ManagedDatabaseSecurityEvents.json
 - ./Microsoft.Sql/stable/2021-11-01/ManagedDatabaseSensitivityLabels.json
 - ./Microsoft.Sql/stable/2021-11-01/ManagedDatabaseTables.json
 - ./Microsoft.Sql/stable/2021-11-01/ManagedDatabaseTransparentDataEncryption.json
 - ./Microsoft.Sql/stable/2021-11-01/ManagedDatabaseVulnerabilityAssessmentRuleBaselines.json
 - ./Microsoft.Sql/stable/2021-11-01/ManagedDatabaseVulnerabilityAssessments.json
 - ./Microsoft.Sql/stable/2021-11-01/ManagedDatabaseVulnerabilityAssessmentScans.json
 - ./Microsoft.Sql/stable/2021-11-01/ManagedInstanceAdministrators.json
 - ./Microsoft.Sql/stable/2021-11-01/ManagedInstanceAzureADOnlyAuthentications.json
 - ./Microsoft.Sql/stable/2021-11-01/ManagedInstanceEncryptionProtectors.json
 - ./Microsoft.Sql/stable/2021-11-01/ManagedInstanceKeys.json
 - ./Microsoft.Sql/stable/2021-11-01/ManagedInstanceLongTermRetentionPolicies.json
 - ./Microsoft.Sql/stable/2021-11-01/ManagedInstanceOperations.json
 - ./Microsoft.Sql/stable/2021-11-01/ManagedInstancePrivateEndpointConnections.json
 - ./Microsoft.Sql/stable/2021-11-01/ManagedInstancePrivateLinkResources.json
 - ./Microsoft.Sql/stable/2021-11-01/ManagedInstances.json
 - ./Microsoft.Sql/stable/2021-11-01/ManagedInstanceTdeCertificates.json
 - ./Microsoft.Sql/stable/2021-11-01/ManagedInstanceVulnerabilityAssessments.json
 - ./Microsoft.Sql/stable/2021-11-01/ManagedRestorableDroppedDatabaseBackupShortTermRetentionPolicies.json
 - ./Microsoft.Sql/stable/2021-11-01/ManagedServerDnsAliases.json
 - ./Microsoft.Sql/stable/2021-11-01/ManagedServerSecurityAlertPolicies.json
 - ./Microsoft.Sql/stable/2021-11-01/Operations.json
 - ./Microsoft.Sql/stable/2021-11-01/OutboundFirewallRules.json
 - ./Microsoft.Sql/stable/2021-11-01/PrivateEndpointConnections.json
 - ./Microsoft.Sql/stable/2021-11-01/PrivateLinkResources.json
 - ./Microsoft.Sql/stable/2021-11-01/RecoverableDatabases.json
 - ./Microsoft.Sql/stable/2021-11-01/RecoverableManagedDatabases.json
 - ./Microsoft.Sql/stable/2021-11-01/ReplicationLinks.json
 - ./Microsoft.Sql/stable/2021-11-01/RestorableDroppedDatabases.json
 - ./Microsoft.Sql/stable/2021-11-01/RestorableDroppedManagedDatabases.json
 - ./Microsoft.Sql/stable/2021-11-01/RestorePoints.json
 - ./Microsoft.Sql/stable/2021-11-01/SensitivityLabels.json
 - ./Microsoft.Sql/stable/2021-11-01/ServerAdvancedThreatProtectionSettings.json
 - ./Microsoft.Sql/stable/2021-11-01/ServerAdvisors.json
 - ./Microsoft.Sql/stable/2021-11-01/ServerAutomaticTuning.json
 - ./Microsoft.Sql/stable/2021-11-01/ServerAzureADAdministrators.json
 - ./Microsoft.Sql/stable/2021-11-01/ServerAzureADOnlyAuthentications.json
 - ./Microsoft.Sql/stable/2021-11-01/ServerConnectionPolicies.json
 - ./Microsoft.Sql/stable/2021-11-01/ServerDevOpsAudit.json
 - ./Microsoft.Sql/stable/2021-11-01/ServerDnsAliases.json
 - ./Microsoft.Sql/stable/2021-11-01/ServerKeys.json
 - ./Microsoft.Sql/stable/2021-11-01/ServerOperations.json
 - ./Microsoft.Sql/stable/2021-11-01/Servers.json
 - ./Microsoft.Sql/stable/2021-11-01/ServerSecurityAlertPolicies.json
 - ./Microsoft.Sql/stable/2021-11-01/ServerTrustCertificates.json
 - ./Microsoft.Sql/stable/2021-11-01/ServerTrustGroups.json
 - ./Microsoft.Sql/stable/2021-11-01/ServerUsages.json
 - ./Microsoft.Sql/stable/2021-11-01/ServerVulnerabilityAssessments.json
 - ./Microsoft.Sql/stable/2021-11-01/SqlAgent.json
 - ./Microsoft.Sql/stable/2021-11-01/SubscriptionUsages.json
 - ./Microsoft.Sql/stable/2021-11-01/SyncAgents.json
 - ./Microsoft.Sql/stable/2021-11-01/SyncGroups.json
 - ./Microsoft.Sql/stable/2021-11-01/SyncMembers.json
 - ./Microsoft.Sql/stable/2021-11-01/TdeCertificates.json
 - ./Microsoft.Sql/stable/2021-11-01/TimeZones.json
 - ./Microsoft.Sql/stable/2021-11-01/TransparentDataEncryptions.json
 - ./Microsoft.Sql/stable/2021-11-01/Usages.json
 - ./Microsoft.Sql/stable/2021-11-01/VirtualClusters.json
 - ./Microsoft.Sql/stable/2021-11-01/VirtualNetworkRules.json
 - ./Microsoft.Sql/stable/2021-11-01/WorkloadClassifiers.json
 - ./Microsoft.Sql/stable/2021-11-01/WorkloadGroups.json
```

### Tag: package-preview-2022-05

These settings apply only when `--tag=package-preview-2022-05` is specified on the command line.

``` yaml $(tag) == 'package-preview-2022-05'
input-file:
  - Microsoft.Sql/preview/2022-05-01-preview/BackupShortTermRetentionPolicies.json
  - Microsoft.Sql/preview/2022-05-01-preview/BlobAuditing.json
  - Microsoft.Sql/preview/2022-05-01-preview/DataMaskingPolicies.json
  - Microsoft.Sql/preview/2022-05-01-preview/DataMaskingRules.json
  - Microsoft.Sql/preview/2022-05-01-preview/DataWarehouseUserActivities.json
  - Microsoft.Sql/preview/2022-05-01-preview/DatabaseAdvancedThreatProtectionSettings.json
  - Microsoft.Sql/preview/2022-05-01-preview/DatabaseAdvisors.json
  - Microsoft.Sql/preview/2022-05-01-preview/DatabaseAutomaticTuning.json
  - Microsoft.Sql/preview/2022-05-01-preview/DatabaseColumns.json
  - Microsoft.Sql/preview/2022-05-01-preview/DatabaseExtensions.json
  - Microsoft.Sql/preview/2022-05-01-preview/DatabaseOperations.json
  - Microsoft.Sql/preview/2022-05-01-preview/DatabaseRecommendedActions.json
  - Microsoft.Sql/preview/2022-05-01-preview/DatabaseSchemas.json
  - Microsoft.Sql/preview/2022-05-01-preview/DatabaseSecurityAlertPolicies.json
  - Microsoft.Sql/preview/2022-05-01-preview/DatabaseSqlVulnerabilityAssessmentBaselines.json
  - Microsoft.Sql/preview/2022-05-01-preview/DatabaseSqlVulnerabilityAssessmentExecuteScan.json
  - Microsoft.Sql/preview/2022-05-01-preview/DatabaseSqlVulnerabilityAssessmentRuleBaselines.json
  - Microsoft.Sql/preview/2022-05-01-preview/DatabaseSqlVulnerabilityAssessmentScanResult.json
  - Microsoft.Sql/preview/2022-05-01-preview/DatabaseSqlVulnerabilityAssessmentScans.json
  - Microsoft.Sql/preview/2022-05-01-preview/DatabaseSqlVulnerabilityAssessmentsSettings.json
  - Microsoft.Sql/preview/2022-05-01-preview/DatabaseTables.json
  - Microsoft.Sql/preview/2022-05-01-preview/DatabaseUsages.json
  - Microsoft.Sql/preview/2022-05-01-preview/DatabaseVulnerabilityAssessmentRuleBaselines.json
  - Microsoft.Sql/preview/2022-05-01-preview/DatabaseVulnerabilityAssessmentScans.json
  - Microsoft.Sql/preview/2022-05-01-preview/DatabaseVulnerabilityAssessments.json
  - Microsoft.Sql/preview/2022-05-01-preview/Databases.json
  - Microsoft.Sql/preview/2022-05-01-preview/DeletedServers.json
  - Microsoft.Sql/preview/2022-05-01-preview/DistributedAvailabilityGroups.json
  - Microsoft.Sql/preview/2022-05-01-preview/ElasticPoolOperations.json
  - Microsoft.Sql/preview/2022-05-01-preview/ElasticPools.json
  - Microsoft.Sql/preview/2022-05-01-preview/EncryptionProtectors.json
  - Microsoft.Sql/preview/2022-05-01-preview/EndpointCertificates.json
  - Microsoft.Sql/preview/2022-05-01-preview/FailoverGroups.json
  - Microsoft.Sql/preview/2022-05-01-preview/FirewallRules.json
  - Microsoft.Sql/preview/2022-05-01-preview/GeoBackupPolicies.json
  - Microsoft.Sql/preview/2022-05-01-preview/IPv6FirewallRules.json
  - Microsoft.Sql/preview/2022-05-01-preview/InstanceFailoverGroups.json
  - Microsoft.Sql/preview/2022-05-01-preview/InstancePools.json
  - Microsoft.Sql/preview/2022-05-01-preview/JobAgents.json
  - Microsoft.Sql/preview/2022-05-01-preview/JobCredentials.json
  - Microsoft.Sql/preview/2022-05-01-preview/JobExecutions.json
  - Microsoft.Sql/preview/2022-05-01-preview/JobStepExecutions.json
  - Microsoft.Sql/preview/2022-05-01-preview/JobSteps.json
  - Microsoft.Sql/preview/2022-05-01-preview/JobTargetExecutions.json
  - Microsoft.Sql/preview/2022-05-01-preview/JobTargetGroups.json
  - Microsoft.Sql/preview/2022-05-01-preview/JobVersions.json
  - Microsoft.Sql/preview/2022-05-01-preview/Jobs.json
  - Microsoft.Sql/preview/2022-05-01-preview/LedgerDigestUploads.json
  - Microsoft.Sql/preview/2022-05-01-preview/LocationCapabilities.json
  - Microsoft.Sql/preview/2022-05-01-preview/LongTermRetentionBackups.json
  - Microsoft.Sql/preview/2022-05-01-preview/LongTermRetentionManagedInstanceBackups.json
  - Microsoft.Sql/preview/2022-05-01-preview/LongTermRetentionPolicies.json
  - Microsoft.Sql/preview/2022-05-01-preview/MaintenanceWindowOptions.json
  - Microsoft.Sql/preview/2022-05-01-preview/MaintenanceWindows.json
  - Microsoft.Sql/preview/2022-05-01-preview/ManagedBackupShortTermRetentionPolicies.json
  - Microsoft.Sql/preview/2022-05-01-preview/ManagedDatabaseAdvancedThreatProtectionSettings.json
  - Microsoft.Sql/preview/2022-05-01-preview/ManagedDatabaseColumns.json
  - Microsoft.Sql/preview/2022-05-01-preview/ManagedDatabaseMoveOperations.json
  - Microsoft.Sql/preview/2022-05-01-preview/ManagedDatabaseQueries.json
  - Microsoft.Sql/preview/2022-05-01-preview/ManagedDatabaseRestoreDetails.json
  - Microsoft.Sql/preview/2022-05-01-preview/ManagedDatabaseSchemas.json
  - Microsoft.Sql/preview/2022-05-01-preview/ManagedDatabaseSecurityAlertPolicies.json
  - Microsoft.Sql/preview/2022-05-01-preview/ManagedDatabaseSecurityEvents.json
  - Microsoft.Sql/preview/2022-05-01-preview/ManagedDatabaseSensitivityLabels.json
  - Microsoft.Sql/preview/2022-05-01-preview/ManagedDatabaseTables.json
  - Microsoft.Sql/preview/2022-05-01-preview/ManagedDatabaseTransparentDataEncryption.json
  - Microsoft.Sql/preview/2022-05-01-preview/ManagedDatabaseVulnerabilityAssessmentRuleBaselines.json
  - Microsoft.Sql/preview/2022-05-01-preview/ManagedDatabaseVulnerabilityAssessmentScans.json
  - Microsoft.Sql/preview/2022-05-01-preview/ManagedDatabaseVulnerabilityAssessments.json
  - Microsoft.Sql/preview/2022-05-01-preview/ManagedDatabases.json
  - Microsoft.Sql/preview/2022-05-01-preview/ManagedInstanceAdministrators.json
  - Microsoft.Sql/preview/2022-05-01-preview/ManagedInstanceAdvancedThreatProtectionSettings.json
  - Microsoft.Sql/preview/2022-05-01-preview/ManagedInstanceAzureADOnlyAuthentications.json
  - Microsoft.Sql/preview/2022-05-01-preview/ManagedInstanceDtcs.json
  - Microsoft.Sql/preview/2022-05-01-preview/ManagedInstanceEncryptionProtectors.json
  - Microsoft.Sql/preview/2022-05-01-preview/ManagedInstanceKeys.json
  - Microsoft.Sql/preview/2022-05-01-preview/ManagedInstanceLongTermRetentionPolicies.json
  - Microsoft.Sql/preview/2022-05-01-preview/ManagedInstanceOperations.json
  - Microsoft.Sql/preview/2022-05-01-preview/ManagedInstancePrivateEndpointConnections.json
  - Microsoft.Sql/preview/2022-05-01-preview/ManagedInstancePrivateLinkResources.json
  - Microsoft.Sql/preview/2022-05-01-preview/ManagedInstanceTdeCertificates.json
  - Microsoft.Sql/preview/2022-05-01-preview/ManagedInstanceVulnerabilityAssessments.json
  - Microsoft.Sql/preview/2022-05-01-preview/ManagedInstances.json
  - Microsoft.Sql/preview/2022-05-01-preview/ManagedRestorableDroppedDatabaseBackupShortTermRetentionPolicies.json
  - Microsoft.Sql/preview/2022-05-01-preview/ManagedServerDnsAliases.json
  - Microsoft.Sql/preview/2022-05-01-preview/ManagedServerSecurityAlertPolicies.json
  - Microsoft.Sql/preview/2022-05-01-preview/Operations.json
  - Microsoft.Sql/preview/2022-05-01-preview/OutboundFirewallRules.json
  - Microsoft.Sql/preview/2022-05-01-preview/PrivateEndpointConnections.json
  - Microsoft.Sql/preview/2022-05-01-preview/PrivateLinkResources.json
  - Microsoft.Sql/preview/2022-05-01-preview/RecoverableDatabases.json
  - Microsoft.Sql/preview/2022-05-01-preview/RecoverableManagedDatabases.json
  - Microsoft.Sql/preview/2022-05-01-preview/ReplicationLinks.json
  - Microsoft.Sql/preview/2022-05-01-preview/RestorableDroppedDatabases.json
  - Microsoft.Sql/preview/2022-05-01-preview/RestorableDroppedManagedDatabases.json
  - Microsoft.Sql/preview/2022-05-01-preview/RestorePoints.json
  - Microsoft.Sql/preview/2022-05-01-preview/SensitivityLabels.json
  - Microsoft.Sql/preview/2022-05-01-preview/ServerAdvancedThreatProtectionSettings.json
  - Microsoft.Sql/preview/2022-05-01-preview/ServerAdvisors.json
  - Microsoft.Sql/preview/2022-05-01-preview/ServerAutomaticTuning.json
  - Microsoft.Sql/preview/2022-05-01-preview/ServerAzureADAdministrators.json
  - Microsoft.Sql/preview/2022-05-01-preview/ServerAzureADOnlyAuthentications.json
  - Microsoft.Sql/preview/2022-05-01-preview/ServerConnectionPolicies.json
  - Microsoft.Sql/preview/2022-05-01-preview/ServerDevOpsAudit.json
  - Microsoft.Sql/preview/2022-05-01-preview/ServerDnsAliases.json
  - Microsoft.Sql/preview/2022-05-01-preview/ServerKeys.json
  - Microsoft.Sql/preview/2022-05-01-preview/ServerOperations.json
  - Microsoft.Sql/preview/2022-05-01-preview/ServerSecurityAlertPolicies.json
  - Microsoft.Sql/preview/2022-05-01-preview/ServerTrustCertificates.json
  - Microsoft.Sql/preview/2022-05-01-preview/ServerTrustGroups.json
  - Microsoft.Sql/preview/2022-05-01-preview/ServerUsages.json
  - Microsoft.Sql/preview/2022-05-01-preview/ServerVulnerabilityAssessments.json
  - Microsoft.Sql/preview/2022-05-01-preview/Servers.json
  - Microsoft.Sql/preview/2022-05-01-preview/SqlAgent.json
  - Microsoft.Sql/preview/2022-05-01-preview/SqlVulnerabilityAssessmentBaseline.json
  - Microsoft.Sql/preview/2022-05-01-preview/SqlVulnerabilityAssessmentExecuteScan.json
  - Microsoft.Sql/preview/2022-05-01-preview/SqlVulnerabilityAssessmentRuleBaseline.json
  - Microsoft.Sql/preview/2022-05-01-preview/SqlVulnerabilityAssessmentScanResult.json
  - Microsoft.Sql/preview/2022-05-01-preview/SqlVulnerabilityAssessmentScans.json
  - Microsoft.Sql/preview/2022-05-01-preview/SqlVulnerabilityAssessmentsSettings.json
  - Microsoft.Sql/preview/2022-05-01-preview/SubscriptionUsages.json
  - Microsoft.Sql/preview/2022-05-01-preview/SynapseLinkWorkspaces.json
  - Microsoft.Sql/preview/2022-05-01-preview/SyncAgents.json
  - Microsoft.Sql/preview/2022-05-01-preview/SyncGroups.json
  - Microsoft.Sql/preview/2022-05-01-preview/SyncMembers.json
  - Microsoft.Sql/preview/2022-05-01-preview/TdeCertificates.json
  - Microsoft.Sql/preview/2022-05-01-preview/TimeZones.json
  - Microsoft.Sql/preview/2022-05-01-preview/TransparentDataEncryptions.json
  - Microsoft.Sql/preview/2022-05-01-preview/Usages.json
  - Microsoft.Sql/preview/2022-05-01-preview/VirtualClusters.json
  - Microsoft.Sql/preview/2022-05-01-preview/VirtualNetworkRules.json
  - Microsoft.Sql/preview/2022-05-01-preview/WorkloadClassifiers.json
  - Microsoft.Sql/preview/2022-05-01-preview/WorkloadGroups.json
```

### Tag: package-preview-2022-02

These settings apply only when `--tag=package-preview-2022-02` is specified on the command line.

``` yaml $(tag) == 'package-preview-2022-02'
input-file:
 - ./Microsoft.Sql/preview/2022-02-01-preview/BackupShortTermRetentionPolicies.json
 - ./Microsoft.Sql/preview/2022-02-01-preview/BlobAuditing.json
 - ./Microsoft.Sql/preview/2022-02-01-preview/DatabaseAdvancedThreatProtectionSettings.json
 - ./Microsoft.Sql/preview/2022-02-01-preview/DatabaseAdvisors.json
 - ./Microsoft.Sql/preview/2022-02-01-preview/DatabaseAutomaticTuning.json
 - ./Microsoft.Sql/preview/2022-02-01-preview/DatabaseColumns.json
 - ./Microsoft.Sql/preview/2022-02-01-preview/DatabaseExtensions.json
 - ./Microsoft.Sql/preview/2022-02-01-preview/DatabaseOperations.json
 - ./Microsoft.Sql/preview/2022-02-01-preview/DatabaseRecommendedActions.json
 - ./Microsoft.Sql/preview/2022-02-01-preview/Databases.json
 - ./Microsoft.Sql/preview/2022-02-01-preview/DatabaseSchemas.json
 - ./Microsoft.Sql/preview/2022-02-01-preview/DatabaseSecurityAlertPolicies.json
 - ./Microsoft.Sql/preview/2022-02-01-preview/DatabaseSqlVulnerabilityAssessmentBaselines.json
 - ./Microsoft.Sql/preview/2022-02-01-preview/DatabaseSqlVulnerabilityAssessmentExecuteScan.json
 - ./Microsoft.Sql/preview/2022-02-01-preview/DatabaseSqlVulnerabilityAssessmentRuleBaselines.json
 - ./Microsoft.Sql/preview/2022-02-01-preview/DatabaseSqlVulnerabilityAssessmentScanResult.json
 - ./Microsoft.Sql/preview/2022-02-01-preview/DatabaseSqlVulnerabilityAssessmentScans.json
 - ./Microsoft.Sql/preview/2022-02-01-preview/DatabaseSqlVulnerabilityAssessmentsSettings.json
 - ./Microsoft.Sql/preview/2022-02-01-preview/DatabaseTables.json
 - ./Microsoft.Sql/preview/2022-02-01-preview/DatabaseUsages.json
 - ./Microsoft.Sql/preview/2022-02-01-preview/DatabaseVulnerabilityAssessmentRuleBaselines.json
 - ./Microsoft.Sql/preview/2022-02-01-preview/DatabaseVulnerabilityAssessments.json
 - ./Microsoft.Sql/preview/2022-02-01-preview/DatabaseVulnerabilityAssessmentScans.json
 - ./Microsoft.Sql/preview/2022-02-01-preview/DataMaskingPolicies.json
 - ./Microsoft.Sql/preview/2022-02-01-preview/DataMaskingRules.json
 - ./Microsoft.Sql/preview/2022-02-01-preview/DataWarehouseUserActivities.json
 - ./Microsoft.Sql/preview/2022-02-01-preview/DeletedServers.json
 - ./Microsoft.Sql/preview/2022-02-01-preview/DistributedAvailabilityGroups.json
 - ./Microsoft.Sql/preview/2022-02-01-preview/ElasticPoolOperations.json
 - ./Microsoft.Sql/preview/2022-02-01-preview/ElasticPools.json
 - ./Microsoft.Sql/preview/2022-02-01-preview/EncryptionProtectors.json
 - ./Microsoft.Sql/preview/2022-02-01-preview/EndpointCertificates.json
 - ./Microsoft.Sql/preview/2022-02-01-preview/FailoverGroups.json
 - ./Microsoft.Sql/preview/2022-02-01-preview/FirewallRules.json
 - ./Microsoft.Sql/preview/2022-02-01-preview/GeoBackupPolicies.json
 - ./Microsoft.Sql/preview/2022-02-01-preview/InstanceFailoverGroups.json
 - ./Microsoft.Sql/preview/2022-02-01-preview/InstancePools.json
 - ./Microsoft.Sql/preview/2022-02-01-preview/IPv6FirewallRules.json
 - ./Microsoft.Sql/preview/2022-02-01-preview/JobAgents.json
 - ./Microsoft.Sql/preview/2022-02-01-preview/JobCredentials.json
 - ./Microsoft.Sql/preview/2022-02-01-preview/JobExecutions.json
 - ./Microsoft.Sql/preview/2022-02-01-preview/Jobs.json
 - ./Microsoft.Sql/preview/2022-02-01-preview/JobStepExecutions.json
 - ./Microsoft.Sql/preview/2022-02-01-preview/JobSteps.json
 - ./Microsoft.Sql/preview/2022-02-01-preview/JobTargetExecutions.json
 - ./Microsoft.Sql/preview/2022-02-01-preview/JobTargetGroups.json
 - ./Microsoft.Sql/preview/2022-02-01-preview/JobVersions.json
 - ./Microsoft.Sql/preview/2022-02-01-preview/LedgerDigestUploads.json
 - ./Microsoft.Sql/preview/2022-02-01-preview/LocationCapabilities.json
 - ./Microsoft.Sql/preview/2022-02-01-preview/LongTermRetentionBackups.json
 - ./Microsoft.Sql/preview/2022-02-01-preview/LongTermRetentionManagedInstanceBackups.json
 - ./Microsoft.Sql/preview/2022-02-01-preview/LongTermRetentionPolicies.json
 - ./Microsoft.Sql/preview/2022-02-01-preview/MaintenanceWindowOptions.json
 - ./Microsoft.Sql/preview/2022-02-01-preview/MaintenanceWindows.json
 - ./Microsoft.Sql/preview/2022-02-01-preview/ManagedBackupShortTermRetentionPolicies.json
 - ./Microsoft.Sql/preview/2022-02-01-preview/ManagedDatabaseAdvancedThreatProtectionSettings.json
 - ./Microsoft.Sql/preview/2022-02-01-preview/ManagedDatabaseColumns.json
 - ./Microsoft.Sql/preview/2022-02-01-preview/ManagedDatabaseQueries.json
 - ./Microsoft.Sql/preview/2022-02-01-preview/ManagedDatabaseRestoreDetails.json
 - ./Microsoft.Sql/preview/2022-02-01-preview/ManagedDatabases.json
 - ./Microsoft.Sql/preview/2022-02-01-preview/ManagedDatabaseSchemas.json
 - ./Microsoft.Sql/preview/2022-02-01-preview/ManagedDatabaseSecurityAlertPolicies.json
 - ./Microsoft.Sql/preview/2022-02-01-preview/ManagedDatabaseSecurityEvents.json
 - ./Microsoft.Sql/preview/2022-02-01-preview/ManagedDatabaseSensitivityLabels.json
 - ./Microsoft.Sql/preview/2022-02-01-preview/ManagedDatabaseTables.json
 - ./Microsoft.Sql/preview/2022-02-01-preview/ManagedDatabaseTransparentDataEncryption.json
 - ./Microsoft.Sql/preview/2022-02-01-preview/ManagedDatabaseVulnerabilityAssessmentRuleBaselines.json
 - ./Microsoft.Sql/preview/2022-02-01-preview/ManagedDatabaseVulnerabilityAssessments.json
 - ./Microsoft.Sql/preview/2022-02-01-preview/ManagedDatabaseVulnerabilityAssessmentScans.json
 - ./Microsoft.Sql/preview/2022-02-01-preview/ManagedInstanceAdministrators.json
 - ./Microsoft.Sql/preview/2022-02-01-preview/ManagedInstanceAdvancedThreatProtectionSettings.json
 - ./Microsoft.Sql/preview/2022-02-01-preview/ManagedInstanceAzureADOnlyAuthentications.json
 - ./Microsoft.Sql/preview/2022-02-01-preview/ManagedInstanceDtcs.json
 - ./Microsoft.Sql/preview/2022-02-01-preview/ManagedInstanceEncryptionProtectors.json
 - ./Microsoft.Sql/preview/2022-02-01-preview/ManagedInstanceKeys.json
 - ./Microsoft.Sql/preview/2022-02-01-preview/ManagedInstanceLongTermRetentionPolicies.json
 - ./Microsoft.Sql/preview/2022-02-01-preview/ManagedInstanceOperations.json
 - ./Microsoft.Sql/preview/2022-02-01-preview/ManagedInstancePrivateEndpointConnections.json
 - ./Microsoft.Sql/preview/2022-02-01-preview/ManagedInstancePrivateLinkResources.json
 - ./Microsoft.Sql/preview/2022-02-01-preview/ManagedInstances.json
 - ./Microsoft.Sql/preview/2022-02-01-preview/ManagedInstanceTdeCertificates.json
 - ./Microsoft.Sql/preview/2022-02-01-preview/ManagedInstanceVulnerabilityAssessments.json
 - ./Microsoft.Sql/preview/2022-02-01-preview/ManagedRestorableDroppedDatabaseBackupShortTermRetentionPolicies.json
 - ./Microsoft.Sql/preview/2022-02-01-preview/ManagedServerDnsAliases.json
 - ./Microsoft.Sql/preview/2022-02-01-preview/ManagedServerSecurityAlertPolicies.json
 - ./Microsoft.Sql/preview/2022-02-01-preview/Operations.json
 - ./Microsoft.Sql/preview/2022-02-01-preview/OutboundFirewallRules.json
 - ./Microsoft.Sql/preview/2022-02-01-preview/PrivateEndpointConnections.json
 - ./Microsoft.Sql/preview/2022-02-01-preview/PrivateLinkResources.json
 - ./Microsoft.Sql/preview/2022-02-01-preview/RecoverableDatabases.json
 - ./Microsoft.Sql/preview/2022-02-01-preview/RecoverableManagedDatabases.json
 - ./Microsoft.Sql/preview/2022-02-01-preview/ReplicationLinks.json
 - ./Microsoft.Sql/preview/2022-02-01-preview/RestorableDroppedDatabases.json
 - ./Microsoft.Sql/preview/2022-02-01-preview/RestorableDroppedManagedDatabases.json
 - ./Microsoft.Sql/preview/2022-02-01-preview/RestorePoints.json
 - ./Microsoft.Sql/preview/2022-02-01-preview/SensitivityLabels.json
 - ./Microsoft.Sql/preview/2022-02-01-preview/ServerAdvancedThreatProtectionSettings.json
 - ./Microsoft.Sql/preview/2022-02-01-preview/ServerAdvisors.json
 - ./Microsoft.Sql/preview/2022-02-01-preview/ServerAutomaticTuning.json
 - ./Microsoft.Sql/preview/2022-02-01-preview/ServerAzureADAdministrators.json
 - ./Microsoft.Sql/preview/2022-02-01-preview/ServerAzureADOnlyAuthentications.json
 - ./Microsoft.Sql/preview/2022-02-01-preview/ServerConnectionPolicies.json
 - ./Microsoft.Sql/preview/2022-02-01-preview/ServerDevOpsAudit.json
 - ./Microsoft.Sql/preview/2022-02-01-preview/ServerDnsAliases.json
 - ./Microsoft.Sql/preview/2022-02-01-preview/ServerKeys.json
 - ./Microsoft.Sql/preview/2022-02-01-preview/ServerOperations.json
 - ./Microsoft.Sql/preview/2022-02-01-preview/Servers.json
 - ./Microsoft.Sql/preview/2022-02-01-preview/ServerSecurityAlertPolicies.json
 - ./Microsoft.Sql/preview/2022-02-01-preview/ServerTrustCertificates.json
 - ./Microsoft.Sql/preview/2022-02-01-preview/ServerTrustGroups.json
 - ./Microsoft.Sql/preview/2022-02-01-preview/ServerUsages.json
 - ./Microsoft.Sql/preview/2022-02-01-preview/ServerVulnerabilityAssessments.json
 - ./Microsoft.Sql/preview/2022-02-01-preview/SqlAgent.json
 - ./Microsoft.Sql/preview/2022-02-01-preview/SqlVulnerabilityAssessmentBaseline.json
 - ./Microsoft.Sql/preview/2022-02-01-preview/SqlVulnerabilityAssessmentExecuteScan.json
 - ./Microsoft.Sql/preview/2022-02-01-preview/SqlVulnerabilityAssessmentRuleBaseline.json
 - ./Microsoft.Sql/preview/2022-02-01-preview/SqlVulnerabilityAssessmentScanResult.json
 - ./Microsoft.Sql/preview/2022-02-01-preview/SqlVulnerabilityAssessmentScans.json
 - ./Microsoft.Sql/preview/2022-02-01-preview/SqlVulnerabilityAssessmentsSettings.json
 - ./Microsoft.Sql/preview/2022-02-01-preview/SubscriptionUsages.json
 - ./Microsoft.Sql/preview/2022-02-01-preview/SyncAgents.json
 - ./Microsoft.Sql/preview/2022-02-01-preview/SyncGroups.json
 - ./Microsoft.Sql/preview/2022-02-01-preview/SyncMembers.json
 - ./Microsoft.Sql/preview/2022-02-01-preview/TdeCertificates.json
 - ./Microsoft.Sql/preview/2022-02-01-preview/TimeZones.json
 - ./Microsoft.Sql/preview/2022-02-01-preview/TransparentDataEncryptions.json
 - ./Microsoft.Sql/preview/2022-02-01-preview/Usages.json
 - ./Microsoft.Sql/preview/2022-02-01-preview/VirtualClusters.json
 - ./Microsoft.Sql/preview/2022-02-01-preview/VirtualNetworkRules.json
 - ./Microsoft.Sql/preview/2022-02-01-preview/WorkloadClassifiers.json
 - ./Microsoft.Sql/preview/2022-02-01-preview/WorkloadGroups.json
```

### Tag: package-preview-2021-11

These settings apply only when `--tag=package-preview-2021-11` is specified on the command line.

``` yaml $(tag) == 'package-preview-2021-11'
input-file:
 - ./Microsoft.Sql/preview/2021-11-01-preview/BackupShortTermRetentionPolicies.json
 - ./Microsoft.Sql/preview/2021-11-01-preview/BlobAuditing.json
 - ./Microsoft.Sql/preview/2021-11-01-preview/DatabaseAdvancedThreatProtectionSettings.json
 - ./Microsoft.Sql/preview/2021-11-01-preview/DatabaseAdvisors.json
 - ./Microsoft.Sql/preview/2021-11-01-preview/DatabaseAutomaticTuning.json
 - ./Microsoft.Sql/preview/2021-11-01-preview/DatabaseColumns.json
 - ./Microsoft.Sql/preview/2021-11-01-preview/DatabaseExtensions.json
 - ./Microsoft.Sql/preview/2021-11-01-preview/DatabaseOperations.json
 - ./Microsoft.Sql/preview/2021-11-01-preview/DatabaseRecommendedActions.json
 - ./Microsoft.Sql/preview/2021-11-01-preview/Databases.json
 - ./Microsoft.Sql/preview/2021-11-01-preview/DatabaseSchemas.json
 - ./Microsoft.Sql/preview/2021-11-01-preview/DatabaseSecurityAlertPolicies.json
 - ./Microsoft.Sql/preview/2021-11-01-preview/DatabaseTables.json
 - ./Microsoft.Sql/preview/2021-11-01-preview/DatabaseUsages.json
 - ./Microsoft.Sql/preview/2021-11-01-preview/DatabaseVulnerabilityAssessmentRuleBaselines.json
 - ./Microsoft.Sql/preview/2021-11-01-preview/DatabaseVulnerabilityAssessments.json
 - ./Microsoft.Sql/preview/2021-11-01-preview/DatabaseVulnerabilityAssessmentScans.json
 - ./Microsoft.Sql/preview/2021-11-01-preview/DataWarehouseUserActivities.json
 - ./Microsoft.Sql/preview/2021-11-01-preview/DeletedServers.json
 - ./Microsoft.Sql/preview/2021-11-01-preview/DistributedAvailabilityGroups.json
 - ./Microsoft.Sql/preview/2021-11-01-preview/ElasticPoolOperations.json
 - ./Microsoft.Sql/preview/2021-11-01-preview/ElasticPools.json
 - ./Microsoft.Sql/preview/2021-11-01-preview/EncryptionProtectors.json
 - ./Microsoft.Sql/preview/2021-11-01-preview/EndpointCertificates.json
 - ./Microsoft.Sql/preview/2021-11-01-preview/FailoverGroups.json
 - ./Microsoft.Sql/preview/2021-11-01-preview/FirewallRules.json
 - ./Microsoft.Sql/preview/2021-11-01-preview/InstanceFailoverGroups.json
 - ./Microsoft.Sql/preview/2021-11-01-preview/InstancePools.json
 - ./Microsoft.Sql/preview/2021-11-01-preview/IPv6FirewallRules.json
 - ./Microsoft.Sql/preview/2021-11-01-preview/JobAgents.json
 - ./Microsoft.Sql/preview/2021-11-01-preview/JobCredentials.json
 - ./Microsoft.Sql/preview/2021-11-01-preview/JobExecutions.json
 - ./Microsoft.Sql/preview/2021-11-01-preview/Jobs.json
 - ./Microsoft.Sql/preview/2021-11-01-preview/JobStepExecutions.json
 - ./Microsoft.Sql/preview/2021-11-01-preview/JobSteps.json
 - ./Microsoft.Sql/preview/2021-11-01-preview/JobTargetExecutions.json
 - ./Microsoft.Sql/preview/2021-11-01-preview/JobTargetGroups.json
 - ./Microsoft.Sql/preview/2021-11-01-preview/JobVersions.json
 - ./Microsoft.Sql/preview/2021-11-01-preview/LedgerDigestUploads.json
 - ./Microsoft.Sql/preview/2021-11-01-preview/LocationCapabilities.json
 - ./Microsoft.Sql/preview/2021-11-01-preview/LongTermRetentionBackups.json
 - ./Microsoft.Sql/preview/2021-11-01-preview/LongTermRetentionManagedInstanceBackups.json
 - ./Microsoft.Sql/preview/2021-11-01-preview/LongTermRetentionPolicies.json
 - ./Microsoft.Sql/preview/2021-11-01-preview/MaintenanceWindowOptions.json
 - ./Microsoft.Sql/preview/2021-11-01-preview/MaintenanceWindows.json
 - ./Microsoft.Sql/preview/2021-11-01-preview/ManagedBackupShortTermRetentionPolicies.json
 - ./Microsoft.Sql/preview/2021-11-01-preview/ManagedDatabaseColumns.json
 - ./Microsoft.Sql/preview/2021-11-01-preview/ManagedDatabaseQueries.json
 - ./Microsoft.Sql/preview/2021-11-01-preview/ManagedDatabaseRestoreDetails.json
 - ./Microsoft.Sql/preview/2021-11-01-preview/ManagedDatabases.json
 - ./Microsoft.Sql/preview/2021-11-01-preview/ManagedDatabaseSchemas.json
 - ./Microsoft.Sql/preview/2021-11-01-preview/ManagedDatabaseSecurityAlertPolicies.json
 - ./Microsoft.Sql/preview/2021-11-01-preview/ManagedDatabaseSecurityEvents.json
 - ./Microsoft.Sql/preview/2021-11-01-preview/ManagedDatabaseSensitivityLabels.json
 - ./Microsoft.Sql/preview/2021-11-01-preview/ManagedDatabaseTables.json
 - ./Microsoft.Sql/preview/2021-11-01-preview/ManagedDatabaseTransparentDataEncryption.json
 - ./Microsoft.Sql/preview/2021-11-01-preview/ManagedDatabaseVulnerabilityAssessmentRuleBaselines.json
 - ./Microsoft.Sql/preview/2021-11-01-preview/ManagedDatabaseVulnerabilityAssessments.json
 - ./Microsoft.Sql/preview/2021-11-01-preview/ManagedDatabaseVulnerabilityAssessmentScans.json
 - ./Microsoft.Sql/preview/2021-11-01-preview/ManagedInstanceAdministrators.json
 - ./Microsoft.Sql/preview/2021-11-01-preview/ManagedInstanceAzureADOnlyAuthentications.json
 - ./Microsoft.Sql/preview/2021-11-01-preview/ManagedInstanceEncryptionProtectors.json
 - ./Microsoft.Sql/preview/2021-11-01-preview/ManagedInstanceKeys.json
 - ./Microsoft.Sql/preview/2021-11-01-preview/ManagedInstanceLongTermRetentionPolicies.json
 - ./Microsoft.Sql/preview/2021-11-01-preview/ManagedInstanceOperations.json
 - ./Microsoft.Sql/preview/2021-11-01-preview/ManagedInstancePrivateEndpointConnections.json
 - ./Microsoft.Sql/preview/2021-11-01-preview/ManagedInstancePrivateLinkResources.json
 - ./Microsoft.Sql/preview/2021-11-01-preview/ManagedInstances.json
 - ./Microsoft.Sql/preview/2021-11-01-preview/ManagedInstanceTdeCertificates.json
 - ./Microsoft.Sql/preview/2021-11-01-preview/ManagedInstanceVulnerabilityAssessments.json
 - ./Microsoft.Sql/preview/2021-11-01-preview/ManagedRestorableDroppedDatabaseBackupShortTermRetentionPolicies.json
 - ./Microsoft.Sql/preview/2021-11-01-preview/ManagedServerDnsAliases.json
 - ./Microsoft.Sql/preview/2021-11-01-preview/ManagedServerSecurityAlertPolicies.json
 - ./Microsoft.Sql/preview/2021-11-01-preview/Operations.json
 - ./Microsoft.Sql/preview/2021-11-01-preview/OutboundFirewallRules.json
 - ./Microsoft.Sql/preview/2021-11-01-preview/PrivateEndpointConnections.json
 - ./Microsoft.Sql/preview/2021-11-01-preview/PrivateLinkResources.json
 - ./Microsoft.Sql/preview/2021-11-01-preview/RecoverableManagedDatabases.json
 - ./Microsoft.Sql/preview/2021-11-01-preview/ReplicationLinks.json
 - ./Microsoft.Sql/preview/2021-11-01-preview/RestorableDroppedDatabases.json
 - ./Microsoft.Sql/preview/2021-11-01-preview/RestorableDroppedManagedDatabases.json
 - ./Microsoft.Sql/preview/2021-11-01-preview/RestorePoints.json
 - ./Microsoft.Sql/preview/2021-11-01-preview/SensitivityLabels.json
 - ./Microsoft.Sql/preview/2021-11-01-preview/ServerAdvancedThreatProtectionSettings.json
 - ./Microsoft.Sql/preview/2021-11-01-preview/ServerAdvisors.json
 - ./Microsoft.Sql/preview/2021-11-01-preview/ServerAutomaticTuning.json
 - ./Microsoft.Sql/preview/2021-11-01-preview/ServerAzureADAdministrators.json
 - ./Microsoft.Sql/preview/2021-11-01-preview/ServerAzureADOnlyAuthentications.json
 - ./Microsoft.Sql/preview/2021-11-01-preview/ServerConnectionPolicies.json
 - ./Microsoft.Sql/preview/2021-11-01-preview/ServerDevOpsAudit.json
 - ./Microsoft.Sql/preview/2021-11-01-preview/ServerDnsAliases.json
 - ./Microsoft.Sql/preview/2021-11-01-preview/ServerKeys.json
 - ./Microsoft.Sql/preview/2021-11-01-preview/ServerOperations.json
 - ./Microsoft.Sql/preview/2021-11-01-preview/Servers.json
 - ./Microsoft.Sql/preview/2021-11-01-preview/ServerSecurityAlertPolicies.json
 - ./Microsoft.Sql/preview/2021-11-01-preview/ServerTrustCertificates.json
 - ./Microsoft.Sql/preview/2021-11-01-preview/ServerTrustGroups.json
 - ./Microsoft.Sql/preview/2021-11-01-preview/ServerVulnerabilityAssessments.json
 - ./Microsoft.Sql/preview/2021-11-01-preview/SqlAgent.json
 - ./Microsoft.Sql/preview/2021-11-01-preview/SubscriptionUsages.json
 - ./Microsoft.Sql/preview/2021-11-01-preview/SyncAgents.json
 - ./Microsoft.Sql/preview/2021-11-01-preview/SyncGroups.json
 - ./Microsoft.Sql/preview/2021-11-01-preview/SyncMembers.json
 - ./Microsoft.Sql/preview/2021-11-01-preview/TdeCertificates.json
 - ./Microsoft.Sql/preview/2021-11-01-preview/TimeZones.json
 - ./Microsoft.Sql/preview/2021-11-01-preview/TransparentDataEncryptions.json
 - ./Microsoft.Sql/preview/2021-11-01-preview/Usages.json
 - ./Microsoft.Sql/preview/2021-11-01-preview/VirtualClusters.json
 - ./Microsoft.Sql/preview/2021-11-01-preview/VirtualNetworkRules.json
 - ./Microsoft.Sql/preview/2021-11-01-preview/WorkloadClassifiers.json
 - ./Microsoft.Sql/preview/2021-11-01-preview/WorkloadGroups.json
```

### Tag: package-composite-v5

These settings apply only when `--tag=package-composite-v5` is specified on the command line.

This section contains the "composite-v5" set of APIs, which is composed from a selection of api-versions that will remain backwards compatible with "v5" clients such as .NET SDK Microsoft.Azure.Management.Sql version 1.44.3.0-preview.

APIs must only be added to this section when the API is publicly available in at least 1 production region and at least 1 generated client has been tested end-to-end.

``` yaml $(tag) == 'package-composite-v5'
input-file:
- Microsoft.Sql/stable/2014-04-01/dataMasking.json
- Microsoft.Sql/stable/2014-04-01/geoBackupPolicies.json
- Microsoft.Sql/stable/2014-04-01/metrics.json
- Microsoft.Sql/stable/2014-04-01/serverCommunicationLinks.json
- Microsoft.Sql/stable/2014-04-01/serviceObjectives.json
- Microsoft.Sql/stable/2014-04-01-legacy/sql.core_legacy.json
- Microsoft.Sql/stable/2014-04-01-legacy/usages_legacy.json
- ./Microsoft.Sql/preview/2020-11-01-preview/DatabaseAdvisors.json
- ./Microsoft.Sql/preview/2020-11-01-preview/DatabaseAutomaticTuning.json
- ./Microsoft.Sql/preview/2020-11-01-preview/DatabaseColumns.json
- ./Microsoft.Sql/preview/2020-11-01-preview/DatabaseRecommendedActions.json
- ./Microsoft.Sql/preview/2020-11-01-preview/DatabaseSchemas.json
- ./Microsoft.Sql/preview/2020-11-01-preview/DatabaseSecurityAlertPolicies.json
- ./Microsoft.Sql/preview/2020-11-01-preview/DatabaseTables.json
- ./Microsoft.Sql/preview/2020-11-01-preview/DatabaseVulnerabilityAssesmentRuleBaselines.json
- ./Microsoft.Sql/preview/2020-11-01-preview/DatabaseVulnerabilityAssessments.json
- ./Microsoft.Sql/preview/2020-11-01-preview/DatabaseVulnerabilityAssessmentScans.json
- ./Microsoft.Sql/preview/2020-11-01-preview/DataWarehouseUserActivities.json
- ./Microsoft.Sql/preview/2020-11-01-preview/DeletedServers.json
- ./Microsoft.Sql/preview/2020-11-01-preview/ElasticPoolOperations.json
- ./Microsoft.Sql/preview/2020-11-01-preview/EncryptionProtectors.json
- ./Microsoft.Sql/preview/2020-11-01-preview/FirewallRules.json
- ./Microsoft.Sql/preview/2020-11-01-preview/JobAgents.json
- ./Microsoft.Sql/preview/2020-11-01-preview/JobCredentials.json
- ./Microsoft.Sql/preview/2020-11-01-preview/JobExecutions.json
- ./Microsoft.Sql/preview/2023-05-01-preview/JobPrivateEndpoints.json
- ./Microsoft.Sql/preview/2020-11-01-preview/Jobs.json
- ./Microsoft.Sql/preview/2020-11-01-preview/JobStepExecutions.json
- ./Microsoft.Sql/preview/2020-11-01-preview/JobSteps.json
- ./Microsoft.Sql/preview/2020-11-01-preview/JobTargetExecutions.json
- ./Microsoft.Sql/preview/2020-11-01-preview/JobTargetGroups.json
- ./Microsoft.Sql/preview/2020-11-01-preview/JobVersions.json
- ./Microsoft.Sql/preview/2020-11-01-preview/LocationCapabilities.json
- ./Microsoft.Sql/preview/2020-11-01-preview/MaintenanceWindowOptions.json
- ./Microsoft.Sql/preview/2020-11-01-preview/MaintenanceWindows.json
- ./Microsoft.Sql/preview/2020-11-01-preview/ManagedBackupShortTermRetentionPolicies.json
- ./Microsoft.Sql/preview/2020-11-01-preview/ManagedDatabaseColumns.json
- ./Microsoft.Sql/preview/2020-11-01-preview/ManagedDatabaseQueries.json
- ./Microsoft.Sql/preview/2020-11-01-preview/ManagedDatabaseSchemas.json
- ./Microsoft.Sql/preview/2020-11-01-preview/ManagedDatabaseSecurityAlertPolicies.json
- ./Microsoft.Sql/preview/2020-11-01-preview/ManagedDatabaseSecurityEvents.json
- ./Microsoft.Sql/preview/2020-11-01-preview/ManagedDatabaseTables.json
- ./Microsoft.Sql/preview/2020-11-01-preview/ManagedDatabaseTransparentDataEncryption.json
- ./Microsoft.Sql/preview/2020-11-01-preview/ManagedDatabaseVulnerabilityAssessmentRuleBaselines.json
- ./Microsoft.Sql/preview/2020-11-01-preview/ManagedDatabaseVulnerabilityAssessments.json
- ./Microsoft.Sql/preview/2020-11-01-preview/ManagedDatabaseVulnerabilityAssessmentScans.json
- ./Microsoft.Sql/preview/2020-11-01-preview/ManagedInstanceAdministrators.json
- ./Microsoft.Sql/preview/2020-11-01-preview/ManagedInstanceAzureADOnlyAuthentications.json
- ./Microsoft.Sql/preview/2020-11-01-preview/ManagedInstanceEncryptionProtectors.json
- ./Microsoft.Sql/preview/2020-11-01-preview/ManagedInstanceKeys.json
- ./Microsoft.Sql/preview/2020-11-01-preview/ManagedInstanceLongTermRetentionPolicies.json
- ./Microsoft.Sql/preview/2020-11-01-preview/ManagedInstanceOperations.json
- ./Microsoft.Sql/preview/2020-11-01-preview/ManagedInstancePrivateEndpointConnections.json
- ./Microsoft.Sql/preview/2020-11-01-preview/ManagedInstancePrivateLinkResources.json
- ./Microsoft.Sql/preview/2020-11-01-preview/ManagedInstanceTdeCertificates.json
- ./Microsoft.Sql/preview/2020-11-01-preview/ManagedInstanceVulnerabilityAssessments.json
- ./Microsoft.Sql/preview/2020-11-01-preview/ManagedRestorableDroppedDatabaseBackupShortTermRetentionPolicies.json
- ./Microsoft.Sql/preview/2020-11-01-preview/ManagedServerSecurityAlertPolicies.json
- ./Microsoft.Sql/preview/2020-11-01-preview/Operations.json
- ./Microsoft.Sql/preview/2022-08-01-preview/PrivateEndpointConnections.json
- ./Microsoft.Sql/preview/2020-11-01-preview/PrivateLinkResources.json
- ./Microsoft.Sql/preview/2020-11-01-preview/RecoverableManagedDatabases.json
- ./Microsoft.Sql/preview/2020-11-01-preview/RestorePoints.json
- ./Microsoft.Sql/preview/2020-11-01-preview/ServerAdvisors.json
- ./Microsoft.Sql/preview/2020-11-01-preview/ServerAutomaticTuning.json
- ./Microsoft.Sql/preview/2020-11-01-preview/ServerAzureADAdministrators.json
- ./Microsoft.Sql/preview/2020-11-01-preview/ServerAzureADOnlyAuthentications.json
- ./Microsoft.Sql/preview/2022-02-01-preview/ServerDevOpsAudit.json
- ./Microsoft.Sql/preview/2020-11-01-preview/ServerDnsAliases.json
- ./Microsoft.Sql/preview/2020-11-01-preview/ServerKeys.json
- ./Microsoft.Sql/preview/2020-11-01-preview/ServerOperations.json
- ./Microsoft.Sql/preview/2020-11-01-preview/ServerSecurityAlertPolicies.json
- ./Microsoft.Sql/preview/2020-11-01-preview/ServerTrustGroups.json
- ./Microsoft.Sql/preview/2020-11-01-preview/ServerVulnerabilityAssessments.json
- ./Microsoft.Sql/preview/2020-11-01-preview/SqlAgent.json
- ./Microsoft.Sql/preview/2020-11-01-preview/SubscriptionUsages.json
- ./Microsoft.Sql/preview/2020-11-01-preview/SyncAgents.json
- ./Microsoft.Sql/preview/2020-11-01-preview/SyncGroups.json
- ./Microsoft.Sql/preview/2020-11-01-preview/SyncMembers.json
- ./Microsoft.Sql/preview/2020-11-01-preview/TdeCertificates.json
- ./Microsoft.Sql/preview/2020-11-01-preview/TimeZones.json
- ./Microsoft.Sql/preview/2020-11-01-preview/VirtualNetworkRules.json
- ./Microsoft.Sql/preview/2020-11-01-preview/WorkloadClassifiers.json
- ./Microsoft.Sql/preview/2020-11-01-preview/WorkloadGroups.json
- ./Microsoft.Sql/preview/2021-02-01-preview/BackupShortTermRetentionPolicies.json
- ./Microsoft.Sql/preview/2021-02-01-preview/DatabaseExtensions.json
- ./Microsoft.Sql/preview/2021-02-01-preview/DatabaseUsages.json
- ./Microsoft.Sql/preview/2021-02-01-preview/LedgerDigestUploads.json
- ./Microsoft.Sql/preview/2021-02-01-preview/OutboundFirewallRules.json
- ./Microsoft.Sql/preview/2021-02-01-preview/Usages.json
- ./Microsoft.Sql/preview/2021-05-01-preview/LongTermRetentionManagedInstanceBackups.json
- ./Microsoft.Sql/preview/2021-05-01-preview/RestorableDroppedManagedDatabases.json
- ./Microsoft.Sql/preview/2021-05-01-preview/ServerConnectionPolicies.json
- ./Microsoft.Sql/preview/2021-11-01-preview/ServerTrustCertificates.json
- ./Microsoft.Sql/preview/2021-11-01-preview/EndpointCertificates.json
- ./Microsoft.Sql/preview/2020-11-01-preview/ManagedDatabaseSensitivityLabels.json
- ./Microsoft.Sql/preview/2020-11-01-preview/SensitivityLabels.json
- ./Microsoft.Sql/preview/2021-11-01-preview/BlobAuditing.json
- ./Microsoft.Sql/preview/2021-11-01-preview/DatabaseAdvancedThreatProtectionSettings.json
- ./Microsoft.Sql/preview/2021-11-01-preview/ServerAdvancedThreatProtectionSettings.json
- ./Microsoft.Sql/preview/2021-11-01-preview/ManagedServerDnsAliases.json
- ./Microsoft.Sql/preview/2022-02-01-preview/ManagedDatabaseAdvancedThreatProtectionSettings.json
- ./Microsoft.Sql/preview/2022-02-01-preview/ManagedInstanceAdvancedThreatProtectionSettings.json
- ./Microsoft.Sql/preview/2022-05-01-preview/ManagedDatabaseMoveOperations.json
- ./Microsoft.Sql/preview/2022-05-01-preview/ManagedInstanceDtcs.json
- ./Microsoft.Sql/preview/2022-05-01-preview/SynapseLinkWorkspaces.json
- ./Microsoft.Sql/preview/2022-05-01-preview/VirtualClusters.json
- ./Microsoft.Sql/preview/2022-05-01-preview/InstanceFailoverGroups.json
- ./Microsoft.Sql/preview/2022-05-01-preview/ManagedDatabaseRestoreDetails.json
- ./Microsoft.Sql/preview/2022-08-01-preview/DatabaseEncryptionProtectorRevalidate.json
- ./Microsoft.Sql/preview/2022-08-01-preview/DatabaseEncryptionProtectorRevert.json
- ./Microsoft.Sql/preview/2023-02-01-preview/Databases.json
- ./Microsoft.Sql/preview/2022-08-01-preview/ElasticPools.json
- ./Microsoft.Sql/preview/2022-08-01-preview/ManagedDatabases.json
- ./Microsoft.Sql/preview/2022-08-01-preview/ManagedLedgerDigestUploads.json
- ./Microsoft.Sql/preview/2022-08-01-preview/RecoverableDatabases.json
- ./Microsoft.Sql/preview/2022-08-01-preview/RestorableDroppedDatabases.json
- ./Microsoft.Sql/preview/2022-08-01-preview/ServerConfigurationOptions.json
- ./Microsoft.Sql/preview/2022-08-01-preview/StartStopManagedInstanceSchedules.json
- ./Microsoft.Sql/preview/2022-08-01-preview/TransparentDataEncryptions.json
- ./Microsoft.Sql/preview/2022-11-01-preview/IPv6FirewallRules.json
- ./Microsoft.Sql/preview/2022-11-01-preview/SqlVulnerabilityAssessmentBaseline.json
- ./Microsoft.Sql/preview/2022-11-01-preview/SqlVulnerabilityAssessmentExecuteScan.json
- ./Microsoft.Sql/preview/2022-11-01-preview/SqlVulnerabilityAssessmentRuleBaseline.json
- ./Microsoft.Sql/preview/2022-11-01-preview/SqlVulnerabilityAssessmentScanResult.json
- ./Microsoft.Sql/preview/2022-11-01-preview/SqlVulnerabilityAssessmentScans.json
- ./Microsoft.Sql/preview/2022-11-01-preview/SqlVulnerabilityAssessmentsSettings.json
- ./Microsoft.Sql/preview/2022-11-01-preview/DatabaseSqlVulnerabilityAssessmentBaselines.json
- ./Microsoft.Sql/preview/2022-11-01-preview/DatabaseSqlVulnerabilityAssessmentExecuteScan.json
- ./Microsoft.Sql/preview/2022-11-01-preview/DatabaseSqlVulnerabilityAssessmentRuleBaselines.json
- ./Microsoft.Sql/preview/2022-11-01-preview/DatabaseSqlVulnerabilityAssessmentScanResult.json
- ./Microsoft.Sql/preview/2022-11-01-preview/DatabaseSqlVulnerabilityAssessmentScans.json
- ./Microsoft.Sql/preview/2022-11-01-preview/DatabaseSqlVulnerabilityAssessmentsSettings.json
- ./Microsoft.Sql/preview/2023-05-01-preview/FailoverGroups.json
- ./Microsoft.Sql/preview/2023-05-01-preview/InstancePools.json
- ./Microsoft.Sql/preview/2023-05-01-preview/ManagedInstances.json
- ./Microsoft.Sql/preview/2023-05-01-preview/ReplicationLinks.json
- ./Microsoft.Sql/preview/2023-08-01-preview/DistributedAvailabilityGroups.json
- ./Microsoft.Sql/preview/2024-11-01-preview/Servers.json
- ./Microsoft.Sql/preview/2024-11-01-preview/LongTermRetentionBackups.json
- ./Microsoft.Sql/preview/2024-11-01-preview/LongTermRetentionPolicies.json
- ./Microsoft.Sql/preview/2024-11-01-preview/DatabaseOperations.json

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
- Microsoft.Sql/stable/2014-04-01/backups.json
- Microsoft.Sql/stable/2014-04-01/connectionPolicies.json
- Microsoft.Sql/stable/2014-04-01/databaseSecurityAlertPolicies.json
- Microsoft.Sql/stable/2014-04-01/dataMasking.json
- Microsoft.Sql/stable/2014-04-01/firewallRules.json
- Microsoft.Sql/stable/2014-04-01/geoBackupPolicies.json
- Microsoft.Sql/stable/2014-04-01/metrics.json
- Microsoft.Sql/stable/2014-04-01/recommendedElasticPoolsDecoupled.json
- Microsoft.Sql/stable/2014-04-01/replicationLinks.json
- Microsoft.Sql/stable/2014-04-01/serverCommunicationLinks.json
- Microsoft.Sql/stable/2014-04-01/serviceObjectives.json
- Microsoft.Sql/stable/2014-04-01/sql.core.json
- Microsoft.Sql/stable/2014-04-01/usages.json
- Microsoft.Sql/preview/2015-05-01-preview/databaseAutomaticTuning.json
- Microsoft.Sql/preview/2015-05-01-preview/encryptionProtectors.json
- Microsoft.Sql/preview/2015-05-01-preview/failoverGroups.json
- Microsoft.Sql/preview/2015-05-01-preview/operations.json
- Microsoft.Sql/preview/2015-05-01-preview/serverKeys.json
- Microsoft.Sql/preview/2015-05-01-preview/syncAgents.json
- Microsoft.Sql/preview/2015-05-01-preview/usages.json
- Microsoft.Sql/preview/2015-05-01-preview/virtualclusters.json
- Microsoft.Sql/preview/2015-05-01-preview/virtualNetworkRules.json
- Microsoft.Sql/preview/2017-03-01-preview/blobAuditing.json
- Microsoft.Sql/preview/2017-03-01-preview/databaseVulnerabilityAssessmentBaselines.json
- Microsoft.Sql/preview/2017-03-01-preview/databaseVulnerabilityAssessments.json
- Microsoft.Sql/preview/2017-03-01-preview/jobs.json
- Microsoft.Sql/preview/2017-03-01-preview/ManagedBackupShortTermRetention.json
- Microsoft.Sql/preview/2017-03-01-preview/ManagedRestorableDroppedDatabaseBackupShortTermRetenion.json
- Microsoft.Sql/preview/2017-03-01-preview/serverAutomaticTuning.json
- Microsoft.Sql/preview/2017-03-01-preview/serverDnsAliases.json
- Microsoft.Sql/preview/2017-03-01-preview/serverSecurityAlertPolicies.json
- Microsoft.Sql/preview/2017-03-01-preview/restorableDroppedManagedDatabases.json
- Microsoft.Sql/preview/2017-03-01-preview/restorePoints.json
- Microsoft.Sql/preview/2017-03-01-preview/ManagedDatabaseSecurityAlertPolicies.json
- Microsoft.Sql/preview/2017-03-01-preview/ManagedServerSecurityAlertPolicy.json
- Microsoft.Sql/preview/2017-03-01-preview/SensitivityLabels.json
- Microsoft.Sql/preview/2017-03-01-preview/managedInstanceAdministrators.json
- Microsoft.Sql/preview/2017-10-01-preview/cancelOperations.json
- Microsoft.Sql/preview/2017-10-01-preview/cancelPoolOperations.json
- Microsoft.Sql/preview/2017-10-01-preview/databaseVulnerabilityAssessmentScans.json
- Microsoft.Sql/preview/2017-10-01-preview/managedDatabaseVulnerabilityAssesmentRuleBaselines.json
- Microsoft.Sql/preview/2017-10-01-preview/managedDatabaseVulnerabilityAssessmentScans.json
- Microsoft.Sql/preview/2017-10-01-preview/managedDatabaseVulnerabilityAssessments.json
- Microsoft.Sql/preview/2017-10-01-preview/instanceFailoverGroups.json
- Microsoft.Sql/preview/2017-10-01-preview/TdeCertificates.json
- Microsoft.Sql/preview/2017-10-01-preview/ManagedInstanceTdeCertificates.json
- Microsoft.Sql/preview/2017-10-01-preview/ManagedInstanceKeys.json
- Microsoft.Sql/preview/2017-10-01-preview/ManagedInstanceEncryptionProtectors.json
- Microsoft.Sql/preview/2017-10-01-preview/recoverableManagedDatabases.json
- Microsoft.Sql/preview/2017-10-01-preview/shortTermRetentionPolicies.json
- Microsoft.Sql/preview/2018-06-01-preview/ManagedInstanceVulnerabilityAssessments.json
- Microsoft.Sql/preview/2018-06-01-preview/ServerVulnerabilityAssessments.json
- Microsoft.Sql/preview/2018-06-01-preview/managedDatabaseSensitivityLabels.json
- Microsoft.Sql/preview/2018-06-01-preview/instancePools.json
- Microsoft.Sql/preview/2018-06-01-preview/usages.json
- Microsoft.Sql/preview/2018-06-01-preview/PrivateLinkResources.json
- Microsoft.Sql/preview/2019-06-01-preview/servers.json
- Microsoft.Sql/preview/2020-08-01-preview/LocationCapabilities.json
- Microsoft.Sql/preview/2018-06-01-preview/LongTermRetentionManagedInstanceBackups.json
- Microsoft.Sql/preview/2018-06-01-preview/ManagedInstanceLongTermRetentionPolicies.json
- Microsoft.Sql/preview/2019-06-01-preview/WorkloadGroups.json
- Microsoft.Sql/preview/2019-06-01-preview/WorkloadClassifiers.json
- Microsoft.Sql/preview/2019-06-01-preview/managedInstanceOperations.json
- Microsoft.Sql/preview/2019-06-01-preview/ServerAzureADAdministrators.json
- Microsoft.Sql/preview/2019-06-01-preview/syncGroups.json
- Microsoft.Sql/preview/2019-06-01-preview/syncMembers.json
- Microsoft.Sql/preview/2020-02-02-preview/ImportExport.json
- Microsoft.Sql/preview/2020-02-02-preview/ManagedDatabases.json
- Microsoft.Sql/preview/2020-02-02-preview/ManagedDatabaseRestoreDetails.json
- Microsoft.Sql/preview/2020-02-02-preview/ServerAzureADOnlyAuthentications.json
- Microsoft.Sql/preview/2020-02-02-preview/ManagedInstances.json
- Microsoft.Sql/preview/2020-02-02-preview/ManagedInstanceAzureADOnlyAuthentications.json
- Microsoft.Sql/preview/2020-02-02-preview/ServerTrustGroups.json
- Microsoft.Sql/preview/2020-08-01-preview/ElasticPools.json
- Microsoft.Sql/preview/2020-08-01-preview/ServerDevOpsAudit.json
- Microsoft.Sql/preview/2020-11-01-preview/Databases_legacy.json
- Microsoft.Sql/preview/2020-11-01-preview/LongTermRetentionBackups.json
- Microsoft.Sql/preview/2020-11-01-preview/LongTermRetentionPolicies.json
- Microsoft.Sql/preview/2020-11-01-preview/PrivateEndpointConnections.json


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
- Microsoft.Sql/stable/2014-04-01/backups.json
- Microsoft.Sql/stable/2014-04-01/connectionPolicies.json
- Microsoft.Sql/stable/2014-04-01/databaseSecurityAlertPolicies.json
- Microsoft.Sql/stable/2014-04-01/dataMasking.json
- Microsoft.Sql/stable/2014-04-01/firewallRules.json
- Microsoft.Sql/stable/2014-04-01/geoBackupPolicies.json
- Microsoft.Sql/stable/2014-04-01/metrics.json
- Microsoft.Sql/stable/2014-04-01/recommendedElasticPoolsDecoupled.json
- Microsoft.Sql/stable/2014-04-01/replicationLinks.json
- Microsoft.Sql/stable/2014-04-01/serverCommunicationLinks.json
- Microsoft.Sql/stable/2014-04-01/serviceObjectives.json
- Microsoft.Sql/stable/2014-04-01/sql.core.json
- Microsoft.Sql/stable/2014-04-01/usages.json
- Microsoft.Sql/preview/2015-05-01-preview/databaseAutomaticTuning.json
- Microsoft.Sql/preview/2015-05-01-preview/encryptionProtectors.json
- Microsoft.Sql/preview/2015-05-01-preview/failoverGroups.json
- Microsoft.Sql/preview/2015-05-01-preview/operations.json
- Microsoft.Sql/preview/2015-05-01-preview/serverKeys.json
- Microsoft.Sql/preview/2015-05-01-preview/syncAgents.json
- Microsoft.Sql/preview/2015-05-01-preview/usages.json
- Microsoft.Sql/preview/2015-05-01-preview/virtualclusters.json
- Microsoft.Sql/preview/2015-05-01-preview/virtualNetworkRules.json
- Microsoft.Sql/preview/2017-03-01-preview/blobAuditing.json
- Microsoft.Sql/preview/2017-03-01-preview/databaseVulnerabilityAssessmentBaselines.json
- Microsoft.Sql/preview/2017-03-01-preview/databaseVulnerabilityAssessments.json
- Microsoft.Sql/preview/2017-03-01-preview/jobs.json
- Microsoft.Sql/preview/2017-03-01-preview/longTermRetention.json
- Microsoft.Sql/preview/2017-03-01-preview/ManagedBackupShortTermRetention.json
- Microsoft.Sql/preview/2017-03-01-preview/ManagedRestorableDroppedDatabaseBackupShortTermRetenion.json
- Microsoft.Sql/preview/2017-03-01-preview/serverAutomaticTuning.json
- Microsoft.Sql/preview/2017-03-01-preview/serverDnsAliases.json
- Microsoft.Sql/preview/2017-03-01-preview/serverSecurityAlertPolicies.json
- Microsoft.Sql/preview/2017-03-01-preview/restorableDroppedManagedDatabases.json
- Microsoft.Sql/preview/2017-03-01-preview/restorePoints.json
- Microsoft.Sql/preview/2017-03-01-preview/ManagedDatabaseSecurityAlertPolicies.json
- Microsoft.Sql/preview/2017-03-01-preview/ManagedServerSecurityAlertPolicy.json
- Microsoft.Sql/preview/2017-03-01-preview/SensitivityLabels.json
- Microsoft.Sql/preview/2017-03-01-preview/managedInstanceAdministrators.json
- Microsoft.Sql/preview/2017-10-01-preview/cancelOperations.json
- Microsoft.Sql/preview/2017-10-01-preview/cancelPoolOperations.json
- Microsoft.Sql/preview/2017-10-01-preview/elasticPools.json
- Microsoft.Sql/preview/2017-10-01-preview/databaseVulnerabilityAssessmentScans.json
- Microsoft.Sql/preview/2017-10-01-preview/managedDatabaseVulnerabilityAssesmentRuleBaselines.json
- Microsoft.Sql/preview/2017-10-01-preview/managedDatabaseVulnerabilityAssessmentScans.json
- Microsoft.Sql/preview/2017-10-01-preview/managedDatabaseVulnerabilityAssessments.json
- Microsoft.Sql/preview/2017-10-01-preview/instanceFailoverGroups.json
- Microsoft.Sql/preview/2017-10-01-preview/TdeCertificates.json
- Microsoft.Sql/preview/2017-10-01-preview/ManagedInstanceTdeCertificates.json
- Microsoft.Sql/preview/2017-10-01-preview/ManagedInstanceKeys.json
- Microsoft.Sql/preview/2017-10-01-preview/ManagedInstanceEncryptionProtectors.json
- Microsoft.Sql/preview/2017-10-01-preview/recoverableManagedDatabases.json
- Microsoft.Sql/preview/2017-10-01-preview/shortTermRetentionPolicies.json
- Microsoft.Sql/preview/2018-06-01-preview/ManagedInstanceVulnerabilityAssessments.json
- Microsoft.Sql/preview/2018-06-01-preview/ServerVulnerabilityAssessments.json
- Microsoft.Sql/preview/2018-06-01-preview/managedDatabaseSensitivityLabels.json
- Microsoft.Sql/preview/2018-06-01-preview/instancePools.json
- Microsoft.Sql/preview/2018-06-01-preview/usages.json
- Microsoft.Sql/preview/2018-06-01-preview/FailoverElasticPools.json
- Microsoft.Sql/preview/2018-06-01-preview/PrivateLinkResources.json
- Microsoft.Sql/preview/2019-06-01-preview/databases.json
- Microsoft.Sql/preview/2019-06-01-preview/servers.json
- Microsoft.Sql/preview/2018-06-01-preview/capabilities.json
- Microsoft.Sql/preview/2018-06-01-preview/LongTermRetentionManagedInstanceBackups.json
- Microsoft.Sql/preview/2018-06-01-preview/ManagedInstanceLongTermRetentionPolicies.json
- Microsoft.Sql/preview/2019-06-01-preview/WorkloadGroups.json
- Microsoft.Sql/preview/2019-06-01-preview/WorkloadClassifiers.json
- Microsoft.Sql/preview/2019-06-01-preview/managedInstanceOperations.json
- Microsoft.Sql/preview/2019-06-01-preview/ServerAzureADAdministrators.json
- Microsoft.Sql/preview/2019-06-01-preview/syncGroups.json
- Microsoft.Sql/preview/2019-06-01-preview/syncMembers.json
- Microsoft.Sql/preview/2020-02-02-preview/ImportExport.json
- Microsoft.Sql/preview/2020-02-02-preview/ManagedDatabases.json
- Microsoft.Sql/preview/2020-02-02-preview/ServerAzureADOnlyAuthentications.json
- Microsoft.Sql/preview/2020-02-02-preview/ManagedInstances.json
- Microsoft.Sql/preview/2020-02-02-preview/ManagedInstanceAzureADOnlyAuthentications.json
- Microsoft.Sql/preview/2020-02-02-preview/ServerTrustGroups.json
- Microsoft.Sql/preview/2020-11-01-preview/PrivateEndpointConnections.json


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
- Microsoft.Sql/stable/2014-04-01/backups.json
- Microsoft.Sql/stable/2014-04-01/capabilities.json
- Microsoft.Sql/stable/2014-04-01/connectionPolicies.json
- Microsoft.Sql/stable/2014-04-01/databases.json
- Microsoft.Sql/stable/2014-04-01/databaseSecurityAlertPolicies.json
- Microsoft.Sql/stable/2014-04-01/dataMasking.json
- Microsoft.Sql/stable/2014-04-01/elasticPools.json
- Microsoft.Sql/stable/2014-04-01/firewallRules.json
- Microsoft.Sql/stable/2014-04-01/geoBackupPolicies.json
- Microsoft.Sql/stable/2014-04-01/importExport.json
- Microsoft.Sql/stable/2014-04-01/metrics.json
- Microsoft.Sql/stable/2014-04-01/recommendedElasticPools.json
- Microsoft.Sql/stable/2014-04-01/replicationLinks.json
- Microsoft.Sql/stable/2014-04-01/serverCommunicationLinks.json
- Microsoft.Sql/stable/2014-04-01/serviceObjectives.json
- Microsoft.Sql/stable/2014-04-01/sql.core.json
- Microsoft.Sql/stable/2014-04-01/usages.json
- Microsoft.Sql/preview/2015-05-01-preview/databaseAutomaticTuning.json
- Microsoft.Sql/preview/2015-05-01-preview/encryptionProtectors.json
- Microsoft.Sql/preview/2015-05-01-preview/failoverGroups.json
- Microsoft.Sql/preview/2015-05-01-preview/operations.json
- Microsoft.Sql/preview/2015-05-01-preview/serverKeys.json
- Microsoft.Sql/preview/2015-05-01-preview/syncAgents.json
- Microsoft.Sql/preview/2015-05-01-preview/usages.json
- Microsoft.Sql/preview/2015-05-01-preview/virtualclusters.json
- Microsoft.Sql/preview/2015-05-01-preview/virtualNetworkRules.json
- Microsoft.Sql/preview/2017-03-01-preview/blobAuditing.json
- Microsoft.Sql/preview/2017-03-01-preview/databaseVulnerabilityAssessmentBaselines.json
- Microsoft.Sql/preview/2017-03-01-preview/databaseVulnerabilityAssessments.json
- Microsoft.Sql/preview/2017-03-01-preview/jobs.json
- Microsoft.Sql/preview/2017-03-01-preview/longTermRetention.json
- Microsoft.Sql/preview/2017-03-01-preview/ManagedBackupShortTermRetention.json
- Microsoft.Sql/preview/2017-03-01-preview/ManagedRestorableDroppedDatabaseBackupShortTermRetenion.json
- Microsoft.Sql/preview/2017-03-01-preview/renameDatabase.json
- Microsoft.Sql/preview/2017-03-01-preview/serverAutomaticTuning.json
- Microsoft.Sql/preview/2017-03-01-preview/serverDnsAliases.json
- Microsoft.Sql/preview/2017-03-01-preview/serverSecurityAlertPolicies.json
- Microsoft.Sql/preview/2017-03-01-preview/restorableDroppedManagedDatabases.json
- Microsoft.Sql/preview/2017-03-01-preview/restorePoints.json
- Microsoft.Sql/preview/2017-03-01-preview/ManagedDatabaseSecurityAlertPolicies.json
- Microsoft.Sql/preview/2017-03-01-preview/ManagedServerSecurityAlertPolicy.json
- Microsoft.Sql/preview/2017-03-01-preview/SensitivityLabels.json
- Microsoft.Sql/preview/2017-03-01-preview/managedInstanceAdministrators.json
- Microsoft.Sql/preview/2017-10-01-preview/cancelOperations.json
- Microsoft.Sql/preview/2017-10-01-preview/cancelPoolOperations.json
- Microsoft.Sql/preview/2017-10-01-preview/databaseVulnerabilityAssessmentScans.json
- Microsoft.Sql/preview/2017-10-01-preview/managedDatabaseVulnerabilityAssesmentRuleBaselines.json
- Microsoft.Sql/preview/2017-10-01-preview/managedDatabaseVulnerabilityAssessmentScans.json
- Microsoft.Sql/preview/2017-10-01-preview/managedDatabaseVulnerabilityAssessments.json
- Microsoft.Sql/preview/2017-10-01-preview/instanceFailoverGroups.json
- Microsoft.Sql/preview/2017-10-01-preview/shortTermRetentionPolicies.json
- Microsoft.Sql/preview/2017-10-01-preview/TdeCertificates.json
- Microsoft.Sql/preview/2017-10-01-preview/ManagedInstanceTdeCertificates.json
- Microsoft.Sql/preview/2017-10-01-preview/ManagedInstanceKeys.json
- Microsoft.Sql/preview/2017-10-01-preview/ManagedInstanceEncryptionProtectors.json
- Microsoft.Sql/preview/2017-10-01-preview/recoverableManagedDatabases.json
- Microsoft.Sql/preview/2018-06-01-preview/ManagedInstanceVulnerabilityAssessments.json
- Microsoft.Sql/preview/2018-06-01-preview/ServerVulnerabilityAssessments.json
- Microsoft.Sql/preview/2018-06-01-preview/managedDatabaseSensitivityLabels.json
- Microsoft.Sql/preview/2018-06-01-preview/instancePools.json
- Microsoft.Sql/preview/2018-06-01-preview/usages.json
- Microsoft.Sql/preview/2018-06-01-preview/FailoverDatabases.json
- Microsoft.Sql/preview/2018-06-01-preview/FailoverElasticPools.json
- Microsoft.Sql/preview/2018-06-01-preview/PrivateLinkResources.json
- Microsoft.Sql/preview/2019-06-01-preview/servers.json
- Microsoft.Sql/preview/2018-06-01-preview/LongTermRetentionManagedInstanceBackups.json
- Microsoft.Sql/preview/2018-06-01-preview/ManagedInstanceLongTermRetentionPolicies.json
- Microsoft.Sql/preview/2019-06-01-preview/WorkloadGroups.json
- Microsoft.Sql/preview/2019-06-01-preview/WorkloadClassifiers.json
- Microsoft.Sql/preview/2019-06-01-preview/ServerAzureADAdministrators.json
- Microsoft.Sql/preview/2019-06-01-preview/syncGroups.json
- Microsoft.Sql/preview/2019-06-01-preview/syncMembers.json
- Microsoft.Sql/preview/2020-02-02-preview/ManagedDatabases.json
- Microsoft.Sql/preview/2020-02-02-preview/ServerAzureADOnlyAuthentications.json
- Microsoft.Sql/preview/2020-02-02-preview/ManagedInstances.json
- Microsoft.Sql/preview/2020-02-02-preview/ManagedInstanceAzureADOnlyAuthentications.json
- Microsoft.Sql/preview/2020-02-02-preview/ServerTrustGroups.json
- Microsoft.Sql/preview/2020-11-01-preview/PrivateEndpointConnections.json

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
- Microsoft.Sql/stable/2014-04-01/backups.json
- Microsoft.Sql/stable/2014-04-01/capabilities.json
- Microsoft.Sql/stable/2014-04-01/connectionPolicies.json
- Microsoft.Sql/stable/2014-04-01/databases.json
- Microsoft.Sql/stable/2014-04-01/databaseSecurityAlertPolicies.json
- Microsoft.Sql/stable/2014-04-01/dataMasking.json
- Microsoft.Sql/stable/2014-04-01/elasticPools.json
- Microsoft.Sql/stable/2014-04-01/firewallRules.json
- Microsoft.Sql/stable/2014-04-01/geoBackupPolicies.json
- Microsoft.Sql/stable/2014-04-01/importExport.json
- Microsoft.Sql/stable/2014-04-01/metrics.json
- Microsoft.Sql/stable/2014-04-01/recommendedElasticPools.json
- Microsoft.Sql/stable/2014-04-01/replicationLinks.json
- Microsoft.Sql/stable/2014-04-01/serverCommunicationLinks.json
- Microsoft.Sql/stable/2014-04-01/serviceObjectives.json
- Microsoft.Sql/stable/2014-04-01/sql.core.json
- Microsoft.Sql/stable/2014-04-01/usages.json
- Microsoft.Sql/preview/2015-05-01-preview/databaseAutomaticTuning.json
- Microsoft.Sql/preview/2015-05-01-preview/encryptionProtectors.json
- Microsoft.Sql/preview/2015-05-01-preview/failoverGroups.json
- Microsoft.Sql/preview/2015-05-01-preview/operations.json
- Microsoft.Sql/preview/2015-05-01-preview/serverKeys.json
- Microsoft.Sql/preview/2015-05-01-preview/syncAgents.json
- Microsoft.Sql/preview/2015-05-01-preview/usages.json
- Microsoft.Sql/preview/2015-05-01-preview/virtualclusters.json
- Microsoft.Sql/preview/2015-05-01-preview/virtualNetworkRules.json
- Microsoft.Sql/preview/2017-03-01-preview/blobAuditing.json
- Microsoft.Sql/preview/2017-03-01-preview/databaseVulnerabilityAssessmentBaselines.json
- Microsoft.Sql/preview/2017-03-01-preview/databaseVulnerabilityAssessments.json
- Microsoft.Sql/preview/2017-03-01-preview/jobs.json
- Microsoft.Sql/preview/2017-03-01-preview/ManagedBackupShortTermRetention.json
- Microsoft.Sql/preview/2017-03-01-preview/ManagedRestorableDroppedDatabaseBackupShortTermRetenion.json
- Microsoft.Sql/preview/2017-03-01-preview/renameDatabase.json
- Microsoft.Sql/preview/2017-03-01-preview/serverAutomaticTuning.json
- Microsoft.Sql/preview/2017-03-01-preview/serverDnsAliases.json
- Microsoft.Sql/preview/2017-03-01-preview/serverSecurityAlertPolicies.json
- Microsoft.Sql/preview/2017-03-01-preview/restorableDroppedManagedDatabases.json
- Microsoft.Sql/preview/2017-03-01-preview/restorePoints.json
- Microsoft.Sql/preview/2017-03-01-preview/ManagedDatabaseSecurityAlertPolicies.json
- Microsoft.Sql/preview/2017-03-01-preview/ManagedServerSecurityAlertPolicy.json
- Microsoft.Sql/preview/2017-03-01-preview/SensitivityLabels.json
- Microsoft.Sql/preview/2017-03-01-preview/managedInstanceAdministrators.json
- Microsoft.Sql/preview/2017-10-01-preview/cancelOperations.json
- Microsoft.Sql/preview/2017-10-01-preview/cancelPoolOperations.json
- Microsoft.Sql/preview/2017-10-01-preview/databaseVulnerabilityAssessmentScans.json
- Microsoft.Sql/preview/2017-10-01-preview/managedDatabaseVulnerabilityAssesmentRuleBaselines.json
- Microsoft.Sql/preview/2017-10-01-preview/managedDatabaseVulnerabilityAssessmentScans.json
- Microsoft.Sql/preview/2017-10-01-preview/managedDatabaseVulnerabilityAssessments.json
- Microsoft.Sql/preview/2017-10-01-preview/instanceFailoverGroups.json
- Microsoft.Sql/preview/2017-10-01-preview/shortTermRetentionPolicies.json
- Microsoft.Sql/preview/2017-10-01-preview/TdeCertificates.json
- Microsoft.Sql/preview/2017-10-01-preview/ManagedInstanceTdeCertificates.json
- Microsoft.Sql/preview/2017-10-01-preview/ManagedInstanceKeys.json
- Microsoft.Sql/preview/2017-10-01-preview/ManagedInstanceEncryptionProtectors.json
- Microsoft.Sql/preview/2017-10-01-preview/recoverableManagedDatabases.json
- Microsoft.Sql/preview/2018-06-01-preview/ManagedInstanceVulnerabilityAssessments.json
- Microsoft.Sql/preview/2018-06-01-preview/ServerVulnerabilityAssessments.json
- Microsoft.Sql/preview/2018-06-01-preview/managedDatabaseSensitivityLabels.json
- Microsoft.Sql/preview/2018-06-01-preview/instancePools.json
- Microsoft.Sql/preview/2018-06-01-preview/usages.json
- Microsoft.Sql/preview/2018-06-01-preview/FailoverDatabases.json
- Microsoft.Sql/preview/2018-06-01-preview/FailoverElasticPools.json
- Microsoft.Sql/preview/2018-06-01-preview/PrivateLinkResources.json
- Microsoft.Sql/preview/2019-06-01-preview/servers.json
- Microsoft.Sql/preview/2018-06-01-preview/LongTermRetentionManagedInstanceBackups.json
- Microsoft.Sql/preview/2018-06-01-preview/ManagedInstanceLongTermRetentionPolicies.json
- Microsoft.Sql/preview/2019-06-01-preview/WorkloadGroups.json
- Microsoft.Sql/preview/2019-06-01-preview/WorkloadClassifiers.json
- Microsoft.Sql/preview/2019-06-01-preview/ServerAzureADAdministrators.json
- Microsoft.Sql/preview/2019-06-01-preview/syncGroups.json
- Microsoft.Sql/preview/2019-06-01-preview/syncMembers.json
- Microsoft.Sql/preview/2020-02-02-preview/ManagedDatabases.json
- Microsoft.Sql/preview/2020-02-02-preview/ServerAzureADOnlyAuthentications.json
- Microsoft.Sql/preview/2020-02-02-preview/ManagedInstances.json
- Microsoft.Sql/preview/2020-02-02-preview/ManagedInstanceAzureADOnlyAuthentications.json
- Microsoft.Sql/preview/2020-02-02-preview/ServerTrustGroups.json
- Microsoft.Sql/preview/2020-11-01-preview/PrivateEndpointConnections.json

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
- Microsoft.Sql/stable/2014-04-01/backups.json
- Microsoft.Sql/stable/2014-04-01/capabilities.json
- Microsoft.Sql/stable/2014-04-01/checkNameAvailability.json
- Microsoft.Sql/stable/2014-04-01/connectionPolicies.json
- Microsoft.Sql/stable/2014-04-01/databases.json
- Microsoft.Sql/stable/2014-04-01/databaseSecurityAlertPolicies.json
- Microsoft.Sql/stable/2014-04-01/dataMasking.json
- Microsoft.Sql/stable/2014-04-01/elasticPools.json
- Microsoft.Sql/stable/2014-04-01/firewallRules.json
- Microsoft.Sql/stable/2014-04-01/geoBackupPolicies.json
- Microsoft.Sql/stable/2014-04-01/importExport.json
- Microsoft.Sql/stable/2014-04-01/metrics.json
- Microsoft.Sql/stable/2014-04-01/replicationLinks.json
- Microsoft.Sql/stable/2014-04-01/serverAzureADAdministrators.json
- Microsoft.Sql/stable/2014-04-01/serverCommunicationLinks.json
- Microsoft.Sql/stable/2014-04-01/serviceObjectives.json
- Microsoft.Sql/stable/2014-04-01/sql.core.json
- Microsoft.Sql/stable/2014-04-01/usages.json
- Microsoft.Sql/preview/2015-05-01-preview/databaseAutomaticTuning.json
- Microsoft.Sql/preview/2015-05-01-preview/encryptionProtectors.json
- Microsoft.Sql/preview/2015-05-01-preview/failoverGroups.json
- Microsoft.Sql/preview/2015-05-01-preview/managedInstances.json
- Microsoft.Sql/preview/2015-05-01-preview/operations.json
- Microsoft.Sql/preview/2015-05-01-preview/serverKeys.json
- Microsoft.Sql/preview/2015-05-01-preview/servers.json
- Microsoft.Sql/preview/2015-05-01-preview/syncAgents.json
- Microsoft.Sql/preview/2015-05-01-preview/syncGroups.json
- Microsoft.Sql/preview/2015-05-01-preview/syncMembers.json
- Microsoft.Sql/preview/2015-05-01-preview/usages.json
- Microsoft.Sql/preview/2015-05-01-preview/virtualclusters.json
- Microsoft.Sql/preview/2017-03-01-preview/blobAuditing.json
- Microsoft.Sql/preview/2017-03-01-preview/databaseVulnerabilityAssessmentBaselines.json
- Microsoft.Sql/preview/2017-03-01-preview/databaseVulnerabilityAssessments.json
- Microsoft.Sql/preview/2015-05-01-preview/virtualNetworkRules.json
- Microsoft.Sql/preview/2017-03-01-preview/cancelOperations.json
- Microsoft.Sql/preview/2017-03-01-preview/dataWarehouseUserActivities.json
- Microsoft.Sql/preview/2017-03-01-preview/jobs.json
- Microsoft.Sql/preview/2017-03-01-preview/ManagedBackupShortTermRetention.json
- Microsoft.Sql/preview/2017-03-01-preview/managedDatabases.json
- Microsoft.Sql/preview/2017-03-01-preview/renameDatabase.json
- Microsoft.Sql/preview/2017-03-01-preview/SensitivityLabels.json
- Microsoft.Sql/preview/2017-03-01-preview/managedInstanceAdministrators.json
- Microsoft.Sql/preview/2017-03-01-preview/serverAutomaticTuning.json
- Microsoft.Sql/preview/2017-03-01-preview/serverDnsAliases.json
- Microsoft.Sql/preview/2017-03-01-preview/serverSecurityAlertPolicies.json
- Microsoft.Sql/preview/2017-03-01-preview/restorableDroppedManagedDatabases.json
- Microsoft.Sql/preview/2017-03-01-preview/restorePoints.json

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
- Microsoft.Sql/stable/2014-04-01/backups.json
- Microsoft.Sql/stable/2014-04-01/restorePoints.json
- Microsoft.Sql/stable/2014-04-01/checkNameAvailability.json
- Microsoft.Sql/stable/2014-04-01/connectionPolicies.json
- Microsoft.Sql/stable/2014-04-01/databases.json
- Microsoft.Sql/stable/2014-04-01/databaseSecurityAlertPolicies.json
- Microsoft.Sql/stable/2014-04-01/dataMasking.json
- Microsoft.Sql/stable/2014-04-01/elasticPools.json
- Microsoft.Sql/stable/2014-04-01/firewallRules.json
- Microsoft.Sql/stable/2014-04-01/geoBackupPolicies.json
- Microsoft.Sql/stable/2014-04-01/importExport.json
- Microsoft.Sql/stable/2014-04-01/metrics.json
- Microsoft.Sql/stable/2014-04-01/replicationLinks.json
- Microsoft.Sql/stable/2014-04-01/serverAzureADAdministrators.json
- Microsoft.Sql/stable/2014-04-01/serverCommunicationLinks.json
- Microsoft.Sql/stable/2014-04-01/serviceObjectives.json
- Microsoft.Sql/stable/2014-04-01/sql.core.json
- Microsoft.Sql/stable/2014-04-01/usages.json
- Microsoft.Sql/stable/2015-05-01/capabilities.json
- Microsoft.Sql/preview/2015-05-01-preview/blobAuditing.json
- Microsoft.Sql/preview/2015-05-01-preview/encryptionProtectors.json
- Microsoft.Sql/preview/2015-05-01-preview/failoverGroups.json
- Microsoft.Sql/preview/2015-05-01-preview/managedInstances.json
- Microsoft.Sql/preview/2015-05-01-preview/operations.json
- Microsoft.Sql/preview/2015-05-01-preview/serverKeys.json
- Microsoft.Sql/preview/2015-05-01-preview/servers.json
- Microsoft.Sql/preview/2015-05-01-preview/syncAgents.json
- Microsoft.Sql/preview/2015-05-01-preview/syncGroups.json
- Microsoft.Sql/preview/2015-05-01-preview/syncMembers.json
- Microsoft.Sql/preview/2015-05-01-preview/usages.json
- Microsoft.Sql/preview/2015-05-01-preview/virtualclusters.json
- Microsoft.Sql/preview/2015-05-01-preview/virtualNetworkRules.json

# Needed when there is more than one input file
override-info:
  title: SqlManagementClient
```

### Tag: package-2014-04

These settings apply only when `--tag=package-2014-04` is specified on the command line.

APIs must only be added to this section when the API is publicly available in at least 1 production region and at least 1 generated client has been tested end-to-end.

``` yaml $(tag) == 'package-2014-04'
input-file:
- Microsoft.Sql/stable/2014-04-01/checkNameAvailability.json
- Microsoft.Sql/stable/2014-04-01/databases.json
- Microsoft.Sql/stable/2014-04-01/elasticPools.json
- Microsoft.Sql/stable/2014-04-01/firewallRules.json
- Microsoft.Sql/stable/2014-04-01/importExport.json
- Microsoft.Sql/stable/2014-04-01/recommendedElasticPools.json
- Microsoft.Sql/stable/2014-04-01/replicationLinks.json
- Microsoft.Sql/stable/2014-04-01/sql.core.json
- Microsoft.Sql/stable/2014-04-01/databaseSecurityAlertPolicies.json

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
- ./Microsoft.Sql/preview/2021-08-01-preview/BackupShortTermRetentionPolicies.json
- ./Microsoft.Sql/preview/2021-08-01-preview/BlobAuditing.json
- ./Microsoft.Sql/preview/2021-08-01-preview/DatabaseAdvisors.json
- ./Microsoft.Sql/preview/2021-08-01-preview/DatabaseAutomaticTuning.json
- ./Microsoft.Sql/preview/2021-08-01-preview/DatabaseColumns.json
- ./Microsoft.Sql/preview/2021-08-01-preview/DatabaseExtensions.json
- ./Microsoft.Sql/preview/2021-08-01-preview/DatabaseOperations.json
- ./Microsoft.Sql/preview/2021-08-01-preview/DatabaseRecommendedActions.json
- ./Microsoft.Sql/preview/2021-08-01-preview/Databases.json
- ./Microsoft.Sql/preview/2021-08-01-preview/DatabaseSchemas.json
- ./Microsoft.Sql/preview/2021-08-01-preview/DatabaseSecurityAlertPolicies.json
- ./Microsoft.Sql/preview/2021-08-01-preview/DatabaseTables.json
- ./Microsoft.Sql/preview/2021-08-01-preview/DatabaseUsages.json
- ./Microsoft.Sql/preview/2021-08-01-preview/DatabaseVulnerabilityAssessmentRuleBaselines.json
- ./Microsoft.Sql/preview/2021-08-01-preview/DatabaseVulnerabilityAssessments.json
- ./Microsoft.Sql/preview/2021-08-01-preview/DatabaseVulnerabilityAssessmentScans.json
- ./Microsoft.Sql/preview/2021-08-01-preview/DataWarehouseUserActivities.json
- ./Microsoft.Sql/preview/2021-08-01-preview/DeletedServers.json
- ./Microsoft.Sql/preview/2021-08-01-preview/DistributedAvailabilityGroups.json
- ./Microsoft.Sql/preview/2021-08-01-preview/ElasticPoolOperations.json
- ./Microsoft.Sql/preview/2021-08-01-preview/ElasticPools.json
- ./Microsoft.Sql/preview/2021-08-01-preview/EncryptionProtectors.json
- ./Microsoft.Sql/preview/2021-08-01-preview/FailoverGroups.json
- ./Microsoft.Sql/preview/2021-08-01-preview/FirewallRules.json
- ./Microsoft.Sql/preview/2021-08-01-preview/InstanceFailoverGroups.json
- ./Microsoft.Sql/preview/2021-08-01-preview/InstancePools.json
- ./Microsoft.Sql/preview/2021-08-01-preview/IPv6FirewallRules.json
- ./Microsoft.Sql/preview/2021-08-01-preview/JobAgents.json
- ./Microsoft.Sql/preview/2021-08-01-preview/JobCredentials.json
- ./Microsoft.Sql/preview/2021-08-01-preview/JobExecutions.json
- ./Microsoft.Sql/preview/2021-08-01-preview/Jobs.json
- ./Microsoft.Sql/preview/2021-08-01-preview/JobStepExecutions.json
- ./Microsoft.Sql/preview/2021-08-01-preview/JobSteps.json
- ./Microsoft.Sql/preview/2021-08-01-preview/JobTargetExecutions.json
- ./Microsoft.Sql/preview/2021-08-01-preview/JobTargetGroups.json
- ./Microsoft.Sql/preview/2021-08-01-preview/JobVersions.json
- ./Microsoft.Sql/preview/2021-08-01-preview/LedgerDigestUploads.json
- ./Microsoft.Sql/preview/2021-08-01-preview/LocationCapabilities.json
- ./Microsoft.Sql/preview/2021-08-01-preview/LongTermRetentionBackups.json
- ./Microsoft.Sql/preview/2021-08-01-preview/LongTermRetentionManagedInstanceBackups.json
- ./Microsoft.Sql/preview/2021-08-01-preview/LongTermRetentionPolicies.json
- ./Microsoft.Sql/preview/2021-08-01-preview/MaintenanceWindowOptions.json
- ./Microsoft.Sql/preview/2021-08-01-preview/MaintenanceWindows.json
- ./Microsoft.Sql/preview/2021-08-01-preview/ManagedBackupShortTermRetentionPolicies.json
- ./Microsoft.Sql/preview/2021-08-01-preview/ManagedDatabaseColumns.json
- ./Microsoft.Sql/preview/2021-08-01-preview/ManagedDatabaseQueries.json
- ./Microsoft.Sql/preview/2021-08-01-preview/ManagedDatabaseRestoreDetails.json
- ./Microsoft.Sql/preview/2021-08-01-preview/ManagedDatabases.json
- ./Microsoft.Sql/preview/2021-08-01-preview/ManagedDatabaseSchemas.json
- ./Microsoft.Sql/preview/2021-08-01-preview/ManagedDatabaseSecurityAlertPolicies.json
- ./Microsoft.Sql/preview/2021-08-01-preview/ManagedDatabaseSecurityEvents.json
- ./Microsoft.Sql/preview/2021-08-01-preview/ManagedDatabaseSensitivityLabels.json
- ./Microsoft.Sql/preview/2021-08-01-preview/ManagedDatabaseTables.json
- ./Microsoft.Sql/preview/2021-08-01-preview/ManagedDatabaseTransparentDataEncryption.json
- ./Microsoft.Sql/preview/2021-08-01-preview/ManagedDatabaseVulnerabilityAssessmentRuleBaselines.json
- ./Microsoft.Sql/preview/2021-08-01-preview/ManagedDatabaseVulnerabilityAssessments.json
- ./Microsoft.Sql/preview/2021-08-01-preview/ManagedDatabaseVulnerabilityAssessmentScans.json
- ./Microsoft.Sql/preview/2021-08-01-preview/ManagedInstanceAdministrators.json
- ./Microsoft.Sql/preview/2021-08-01-preview/ManagedInstanceAzureADOnlyAuthentications.json
- ./Microsoft.Sql/preview/2021-08-01-preview/ManagedInstanceEncryptionProtectors.json
- ./Microsoft.Sql/preview/2021-08-01-preview/ManagedInstanceKeys.json
- ./Microsoft.Sql/preview/2021-08-01-preview/ManagedInstanceLongTermRetentionPolicies.json
- ./Microsoft.Sql/preview/2021-08-01-preview/ManagedInstanceOperations.json
- ./Microsoft.Sql/preview/2021-08-01-preview/ManagedInstancePrivateEndpointConnections.json
- ./Microsoft.Sql/preview/2021-08-01-preview/ManagedInstancePrivateLinkResources.json
- ./Microsoft.Sql/preview/2021-08-01-preview/ManagedInstances.json
- ./Microsoft.Sql/preview/2021-08-01-preview/ManagedInstanceTdeCertificates.json
- ./Microsoft.Sql/preview/2021-08-01-preview/ManagedInstanceVulnerabilityAssessments.json
- ./Microsoft.Sql/preview/2021-08-01-preview/ManagedRestorableDroppedDatabaseBackupShortTermRetentionPolicies.json
- ./Microsoft.Sql/preview/2021-08-01-preview/ManagedServerSecurityAlertPolicies.json
- ./Microsoft.Sql/preview/2021-08-01-preview/Operations.json
- ./Microsoft.Sql/preview/2021-08-01-preview/OutboundFirewallRules.json
- ./Microsoft.Sql/preview/2021-08-01-preview/PrivateEndpointConnections.json
- ./Microsoft.Sql/preview/2021-08-01-preview/PrivateLinkResources.json
- ./Microsoft.Sql/preview/2021-08-01-preview/RecoverableManagedDatabases.json
- ./Microsoft.Sql/preview/2021-08-01-preview/ReplicationLinks.json
- ./Microsoft.Sql/preview/2021-08-01-preview/RestorableDroppedDatabases.json
- ./Microsoft.Sql/preview/2021-08-01-preview/RestorableDroppedManagedDatabases.json
- ./Microsoft.Sql/preview/2021-08-01-preview/RestorePoints.json
- ./Microsoft.Sql/preview/2021-08-01-preview/SensitivityLabels.json
- ./Microsoft.Sql/preview/2021-08-01-preview/ServerAdvisors.json
- ./Microsoft.Sql/preview/2021-08-01-preview/ServerAutomaticTuning.json
- ./Microsoft.Sql/preview/2021-08-01-preview/ServerAzureADAdministrators.json
- ./Microsoft.Sql/preview/2021-08-01-preview/ServerAzureADOnlyAuthentications.json
- ./Microsoft.Sql/preview/2021-08-01-preview/ServerConnectionPolicies.json
- ./Microsoft.Sql/preview/2021-08-01-preview/ServerDevOpsAudit.json
- ./Microsoft.Sql/preview/2021-08-01-preview/ServerDnsAliases.json
- ./Microsoft.Sql/preview/2021-08-01-preview/ServerKeys.json
- ./Microsoft.Sql/preview/2021-08-01-preview/ServerOperations.json
- ./Microsoft.Sql/preview/2021-08-01-preview/Servers.json
- ./Microsoft.Sql/preview/2021-08-01-preview/ServerSecurityAlertPolicies.json
- ./Microsoft.Sql/preview/2021-08-01-preview/ServerTrustCertificates.json
- ./Microsoft.Sql/preview/2021-08-01-preview/ServerTrustGroups.json
- ./Microsoft.Sql/preview/2021-08-01-preview/ServerVulnerabilityAssessments.json
- ./Microsoft.Sql/preview/2021-08-01-preview/SqlAgent.json
- ./Microsoft.Sql/preview/2021-08-01-preview/SubscriptionUsages.json
- ./Microsoft.Sql/preview/2021-08-01-preview/SyncAgents.json
- ./Microsoft.Sql/preview/2021-08-01-preview/SyncGroups.json
- ./Microsoft.Sql/preview/2021-08-01-preview/SyncMembers.json
- ./Microsoft.Sql/preview/2021-08-01-preview/TdeCertificates.json
- ./Microsoft.Sql/preview/2021-08-01-preview/TimeZones.json
- ./Microsoft.Sql/preview/2021-08-01-preview/TransparentDataEncryptions.json
- ./Microsoft.Sql/preview/2021-08-01-preview/Usages.json
- ./Microsoft.Sql/preview/2021-08-01-preview/VirtualClusters.json
- ./Microsoft.Sql/preview/2021-08-01-preview/VirtualNetworkRules.json
- ./Microsoft.Sql/preview/2021-08-01-preview/WorkloadClassifiers.json
- ./Microsoft.Sql/preview/2021-08-01-preview/WorkloadGroups.json

# Needed when there is more than one input file
override-info:
  title: SqlManagementClient
```

### Tag: package-preview-2021-05

These settings apply only when `--tag=package-preview-2021-05` is specified on the command line.

``` yaml $(tag) == 'package-preview-2021-05'
input-file:
 - ./Microsoft.Sql/preview/2021-05-01-preview/BackupShortTermRetentionPolicies.json
 - ./Microsoft.Sql/preview/2021-05-01-preview/BlobAuditing.json
 - ./Microsoft.Sql/preview/2021-05-01-preview/DatabaseAdvisors.json
 - ./Microsoft.Sql/preview/2021-05-01-preview/DatabaseAutomaticTuning.json
 - ./Microsoft.Sql/preview/2021-05-01-preview/DatabaseColumns.json
 - ./Microsoft.Sql/preview/2021-05-01-preview/DatabaseExtensions.json
 - ./Microsoft.Sql/preview/2021-05-01-preview/DatabaseOperations.json
 - ./Microsoft.Sql/preview/2021-05-01-preview/DatabaseRecommendedActions.json
 - ./Microsoft.Sql/preview/2021-05-01-preview/Databases.json
 - ./Microsoft.Sql/preview/2021-05-01-preview/DatabaseSchemas.json
 - ./Microsoft.Sql/preview/2021-05-01-preview/DatabaseSecurityAlertPolicies.json
 - ./Microsoft.Sql/preview/2021-05-01-preview/DatabaseTables.json
 - ./Microsoft.Sql/preview/2021-05-01-preview/DatabaseUsages.json
 - ./Microsoft.Sql/preview/2021-05-01-preview/DatabaseVulnerabilityAssessmentRuleBaselines.json
 - ./Microsoft.Sql/preview/2021-05-01-preview/DatabaseVulnerabilityAssessments.json
 - ./Microsoft.Sql/preview/2021-05-01-preview/DatabaseVulnerabilityAssessmentScans.json
 - ./Microsoft.Sql/preview/2021-05-01-preview/DataWarehouseUserActivities.json
 - ./Microsoft.Sql/preview/2021-05-01-preview/DeletedServers.json
 - ./Microsoft.Sql/preview/2021-05-01-preview/DistributedAvailabilityGroups.json
 - ./Microsoft.Sql/preview/2021-05-01-preview/ElasticPoolOperations.json
 - ./Microsoft.Sql/preview/2021-05-01-preview/ElasticPools.json
 - ./Microsoft.Sql/preview/2021-05-01-preview/EncryptionProtectors.json
 - ./Microsoft.Sql/preview/2021-05-01-preview/FailoverGroups.json
 - ./Microsoft.Sql/preview/2021-05-01-preview/FirewallRules.json
 - ./Microsoft.Sql/preview/2021-05-01-preview/InstanceFailoverGroups.json
 - ./Microsoft.Sql/preview/2021-05-01-preview/InstancePools.json
 - ./Microsoft.Sql/preview/2021-05-01-preview/JobAgents.json
 - ./Microsoft.Sql/preview/2021-05-01-preview/JobCredentials.json
 - ./Microsoft.Sql/preview/2021-05-01-preview/JobExecutions.json
 - ./Microsoft.Sql/preview/2021-05-01-preview/Jobs.json
 - ./Microsoft.Sql/preview/2021-05-01-preview/JobStepExecutions.json
 - ./Microsoft.Sql/preview/2021-05-01-preview/JobSteps.json
 - ./Microsoft.Sql/preview/2021-05-01-preview/JobTargetExecutions.json
 - ./Microsoft.Sql/preview/2021-05-01-preview/JobTargetGroups.json
 - ./Microsoft.Sql/preview/2021-05-01-preview/JobVersions.json
 - ./Microsoft.Sql/preview/2021-05-01-preview/LedgerDigestUploads.json
 - ./Microsoft.Sql/preview/2021-05-01-preview/LocationCapabilities.json
 - ./Microsoft.Sql/preview/2021-05-01-preview/LongTermRetentionBackups.json
 - ./Microsoft.Sql/preview/2021-05-01-preview/LongTermRetentionManagedInstanceBackups.json
 - ./Microsoft.Sql/preview/2021-05-01-preview/LongTermRetentionPolicies.json
 - ./Microsoft.Sql/preview/2021-05-01-preview/MaintenanceWindowOptions.json
 - ./Microsoft.Sql/preview/2021-05-01-preview/MaintenanceWindows.json
 - ./Microsoft.Sql/preview/2021-05-01-preview/ManagedBackupShortTermRetentionPolicies.json
 - ./Microsoft.Sql/preview/2021-05-01-preview/ManagedDatabaseColumns.json
 - ./Microsoft.Sql/preview/2021-05-01-preview/ManagedDatabaseQueries.json
 - ./Microsoft.Sql/preview/2021-05-01-preview/ManagedDatabaseRestoreDetails.json
 - ./Microsoft.Sql/preview/2021-05-01-preview/ManagedDatabases.json
 - ./Microsoft.Sql/preview/2021-05-01-preview/ManagedDatabaseSchemas.json
 - ./Microsoft.Sql/preview/2021-05-01-preview/ManagedDatabaseSecurityAlertPolicies.json
 - ./Microsoft.Sql/preview/2021-05-01-preview/ManagedDatabaseSecurityEvents.json
 - ./Microsoft.Sql/preview/2021-05-01-preview/ManagedDatabaseSensitivityLabels.json
 - ./Microsoft.Sql/preview/2021-05-01-preview/ManagedDatabaseTables.json
 - ./Microsoft.Sql/preview/2021-05-01-preview/ManagedDatabaseTransparentDataEncryption.json
 - ./Microsoft.Sql/preview/2021-05-01-preview/ManagedDatabaseVulnerabilityAssessmentRuleBaselines.json
 - ./Microsoft.Sql/preview/2021-05-01-preview/ManagedDatabaseVulnerabilityAssessments.json
 - ./Microsoft.Sql/preview/2021-05-01-preview/ManagedDatabaseVulnerabilityAssessmentScans.json
 - ./Microsoft.Sql/preview/2021-05-01-preview/ManagedInstanceAdministrators.json
 - ./Microsoft.Sql/preview/2021-05-01-preview/ManagedInstanceAzureADOnlyAuthentications.json
 - ./Microsoft.Sql/preview/2021-05-01-preview/ManagedInstanceEncryptionProtectors.json
 - ./Microsoft.Sql/preview/2021-05-01-preview/ManagedInstanceKeys.json
 - ./Microsoft.Sql/preview/2021-05-01-preview/ManagedInstanceLongTermRetentionPolicies.json
 - ./Microsoft.Sql/preview/2021-05-01-preview/ManagedInstanceOperations.json
 - ./Microsoft.Sql/preview/2021-05-01-preview/ManagedInstancePrivateEndpointConnections.json
 - ./Microsoft.Sql/preview/2021-05-01-preview/ManagedInstancePrivateLinkResources.json
 - ./Microsoft.Sql/preview/2021-05-01-preview/ManagedInstances.json
 - ./Microsoft.Sql/preview/2021-05-01-preview/ManagedInstanceTdeCertificates.json
 - ./Microsoft.Sql/preview/2021-05-01-preview/ManagedInstanceVulnerabilityAssessments.json
 - ./Microsoft.Sql/preview/2021-05-01-preview/ManagedRestorableDroppedDatabaseBackupShortTermRetentionPolicies.json
 - ./Microsoft.Sql/preview/2021-05-01-preview/ManagedServerSecurityAlertPolicies.json
 - ./Microsoft.Sql/preview/2021-05-01-preview/Operations.json
 - ./Microsoft.Sql/preview/2021-05-01-preview/OutboundFirewallRules.json
 - ./Microsoft.Sql/preview/2021-05-01-preview/PrivateEndpointConnections.json
 - ./Microsoft.Sql/preview/2021-05-01-preview/PrivateLinkResources.json
 - ./Microsoft.Sql/preview/2021-05-01-preview/RecoverableManagedDatabases.json
 - ./Microsoft.Sql/preview/2021-05-01-preview/ReplicationLinks.json
 - ./Microsoft.Sql/preview/2021-05-01-preview/RestorableDroppedDatabases.json
 - ./Microsoft.Sql/preview/2021-05-01-preview/RestorableDroppedManagedDatabases.json
 - ./Microsoft.Sql/preview/2021-05-01-preview/RestorePoints.json
 - ./Microsoft.Sql/preview/2021-05-01-preview/SensitivityLabels.json
 - ./Microsoft.Sql/preview/2021-05-01-preview/ServerAdvisors.json
 - ./Microsoft.Sql/preview/2021-05-01-preview/ServerAutomaticTuning.json
 - ./Microsoft.Sql/preview/2021-05-01-preview/ServerAzureADAdministrators.json
 - ./Microsoft.Sql/preview/2021-05-01-preview/ServerAzureADOnlyAuthentications.json
 - ./Microsoft.Sql/preview/2021-05-01-preview/ServerConnectionPolicies.json
 - ./Microsoft.Sql/preview/2021-05-01-preview/ServerDevOpsAudit.json
 - ./Microsoft.Sql/preview/2021-05-01-preview/ServerDnsAliases.json
 - ./Microsoft.Sql/preview/2021-05-01-preview/ServerKeys.json
 - ./Microsoft.Sql/preview/2021-05-01-preview/ServerOperations.json
 - ./Microsoft.Sql/preview/2021-05-01-preview/Servers.json
 - ./Microsoft.Sql/preview/2021-05-01-preview/ServerSecurityAlertPolicies.json
 - ./Microsoft.Sql/preview/2021-05-01-preview/ServerTrustCertificates.json
 - ./Microsoft.Sql/preview/2021-05-01-preview/ServerTrustGroups.json
 - ./Microsoft.Sql/preview/2021-05-01-preview/ServerVulnerabilityAssessments.json
 - ./Microsoft.Sql/preview/2021-05-01-preview/SqlAgent.json
 - ./Microsoft.Sql/preview/2021-05-01-preview/SubscriptionUsages.json
 - ./Microsoft.Sql/preview/2021-05-01-preview/SyncAgents.json
 - ./Microsoft.Sql/preview/2021-05-01-preview/SyncGroups.json
 - ./Microsoft.Sql/preview/2021-05-01-preview/SyncMembers.json
 - ./Microsoft.Sql/preview/2021-05-01-preview/TdeCertificates.json
 - ./Microsoft.Sql/preview/2021-05-01-preview/TimeZones.json
 - ./Microsoft.Sql/preview/2021-05-01-preview/TransparentDataEncryptions.json
 - ./Microsoft.Sql/preview/2021-05-01-preview/Usages.json
 - ./Microsoft.Sql/preview/2021-05-01-preview/VirtualClusters.json
 - ./Microsoft.Sql/preview/2021-05-01-preview/VirtualNetworkRules.json
 - ./Microsoft.Sql/preview/2021-05-01-preview/WorkloadClassifiers.json
 - ./Microsoft.Sql/preview/2021-05-01-preview/WorkloadGroups.json

# Needed when there is more than one input file
override-info:
  title: SqlManagementClient
```

### Tag: package-preview-2021-02

These settings apply only when `--tag=package-preview-2021-02` is specified on the command line.

``` yaml $(tag) == 'package-preview-2021-02'
input-file:
 - ./Microsoft.Sql/preview/2021-02-01-preview/BackupShortTermRetentionPolicies.json
 - ./Microsoft.Sql/preview/2021-02-01-preview/BlobAuditing.json
 - ./Microsoft.Sql/preview/2021-02-01-preview/DatabaseAdvisors.json
 - ./Microsoft.Sql/preview/2021-02-01-preview/DatabaseAutomaticTuning.json
 - ./Microsoft.Sql/preview/2021-02-01-preview/DatabaseColumns.json
 - ./Microsoft.Sql/preview/2021-02-01-preview/DatabaseExtensions.json
 - ./Microsoft.Sql/preview/2021-02-01-preview/DatabaseOperations.json
 - ./Microsoft.Sql/preview/2021-02-01-preview/DatabaseRecommendedActions.json
 - ./Microsoft.Sql/preview/2021-02-01-preview/Databases.json
 - ./Microsoft.Sql/preview/2021-02-01-preview/DatabaseSchemas.json
 - ./Microsoft.Sql/preview/2021-02-01-preview/DatabaseSecurityAlertPolicies.json
 - ./Microsoft.Sql/preview/2021-02-01-preview/DatabaseTables.json
 - ./Microsoft.Sql/preview/2021-02-01-preview/DatabaseUsages.json
 - ./Microsoft.Sql/preview/2021-02-01-preview/DatabaseVulnerabilityAssessmentRuleBaselines.json
 - ./Microsoft.Sql/preview/2021-02-01-preview/DatabaseVulnerabilityAssessments.json
 - ./Microsoft.Sql/preview/2021-02-01-preview/DatabaseVulnerabilityAssessmentScans.json
 - ./Microsoft.Sql/preview/2021-02-01-preview/DataWarehouseUserActivities.json
 - ./Microsoft.Sql/preview/2021-02-01-preview/DeletedServers.json
 - ./Microsoft.Sql/preview/2021-02-01-preview/ElasticPoolOperations.json
 - ./Microsoft.Sql/preview/2021-02-01-preview/ElasticPools.json
 - ./Microsoft.Sql/preview/2021-02-01-preview/EncryptionProtectors.json
 - ./Microsoft.Sql/preview/2021-02-01-preview/FailoverGroups.json
 - ./Microsoft.Sql/preview/2021-02-01-preview/FirewallRules.json
 - ./Microsoft.Sql/preview/2021-02-01-preview/InstanceFailoverGroups.json
 - ./Microsoft.Sql/preview/2021-02-01-preview/InstancePools.json
 - ./Microsoft.Sql/preview/2021-02-01-preview/JobAgents.json
 - ./Microsoft.Sql/preview/2021-02-01-preview/JobCredentials.json
 - ./Microsoft.Sql/preview/2021-02-01-preview/JobExecutions.json
 - ./Microsoft.Sql/preview/2021-02-01-preview/Jobs.json
 - ./Microsoft.Sql/preview/2021-02-01-preview/JobStepExecutions.json
 - ./Microsoft.Sql/preview/2021-02-01-preview/JobSteps.json
 - ./Microsoft.Sql/preview/2021-02-01-preview/JobTargetExecutions.json
 - ./Microsoft.Sql/preview/2021-02-01-preview/JobTargetGroups.json
 - ./Microsoft.Sql/preview/2021-02-01-preview/JobVersions.json
 - ./Microsoft.Sql/preview/2021-02-01-preview/LedgerDigestUploads.json
 - ./Microsoft.Sql/preview/2021-02-01-preview/LocationCapabilities.json
 - ./Microsoft.Sql/preview/2021-02-01-preview/LongTermRetentionBackups.json
 - ./Microsoft.Sql/preview/2021-02-01-preview/LongTermRetentionManagedInstanceBackups.json
 - ./Microsoft.Sql/preview/2021-02-01-preview/LongTermRetentionPolicies.json
 - ./Microsoft.Sql/preview/2021-02-01-preview/MaintenanceWindowOptions.json
 - ./Microsoft.Sql/preview/2021-02-01-preview/MaintenanceWindows.json
 - ./Microsoft.Sql/preview/2021-02-01-preview/ManagedBackupShortTermRetentionPolicies.json
 - ./Microsoft.Sql/preview/2021-02-01-preview/ManagedDatabaseColumns.json
 - ./Microsoft.Sql/preview/2021-02-01-preview/ManagedDatabaseQueries.json
 - ./Microsoft.Sql/preview/2021-02-01-preview/ManagedDatabaseRestoreDetails.json
 - ./Microsoft.Sql/preview/2021-02-01-preview/ManagedDatabases.json
 - ./Microsoft.Sql/preview/2021-02-01-preview/ManagedDatabaseSchemas.json
 - ./Microsoft.Sql/preview/2021-02-01-preview/ManagedDatabaseSecurityAlertPolicies.json
 - ./Microsoft.Sql/preview/2021-02-01-preview/ManagedDatabaseSecurityEvents.json
 - ./Microsoft.Sql/preview/2021-02-01-preview/ManagedDatabaseSensitivityLabels.json
 - ./Microsoft.Sql/preview/2021-02-01-preview/ManagedDatabaseTables.json
 - ./Microsoft.Sql/preview/2021-02-01-preview/ManagedDatabaseTransparentDataEncryption.json
 - ./Microsoft.Sql/preview/2021-02-01-preview/ManagedDatabaseVulnerabilityAssessmentRuleBaselines.json
 - ./Microsoft.Sql/preview/2021-02-01-preview/ManagedDatabaseVulnerabilityAssessments.json
 - ./Microsoft.Sql/preview/2021-02-01-preview/ManagedDatabaseVulnerabilityAssessmentScans.json
 - ./Microsoft.Sql/preview/2021-02-01-preview/ManagedInstanceAdministrators.json
 - ./Microsoft.Sql/preview/2021-02-01-preview/ManagedInstanceAzureADOnlyAuthentications.json
 - ./Microsoft.Sql/preview/2021-02-01-preview/ManagedInstanceEncryptionProtectors.json
 - ./Microsoft.Sql/preview/2021-02-01-preview/ManagedInstanceKeys.json
 - ./Microsoft.Sql/preview/2021-02-01-preview/ManagedInstanceLongTermRetentionPolicies.json
 - ./Microsoft.Sql/preview/2021-02-01-preview/ManagedInstanceOperations.json
 - ./Microsoft.Sql/preview/2021-02-01-preview/ManagedInstancePrivateEndpointConnections.json
 - ./Microsoft.Sql/preview/2021-02-01-preview/ManagedInstancePrivateLinkResources.json
 - ./Microsoft.Sql/preview/2021-02-01-preview/ManagedInstances.json
 - ./Microsoft.Sql/preview/2021-02-01-preview/ManagedInstanceTdeCertificates.json
 - ./Microsoft.Sql/preview/2021-02-01-preview/ManagedInstanceVulnerabilityAssessments.json
 - ./Microsoft.Sql/preview/2021-02-01-preview/ManagedRestorableDroppedDatabaseBackupShortTermRetentionPolicies.json
 - ./Microsoft.Sql/preview/2021-02-01-preview/ManagedServerSecurityAlertPolicies.json
 - ./Microsoft.Sql/preview/2021-02-01-preview/Operations.json
 - ./Microsoft.Sql/preview/2021-02-01-preview/OutboundFirewallRules.json
 - ./Microsoft.Sql/preview/2021-02-01-preview/PrivateEndpointConnections.json
 - ./Microsoft.Sql/preview/2021-02-01-preview/PrivateLinkResources.json
 - ./Microsoft.Sql/preview/2021-02-01-preview/RecoverableManagedDatabases.json
 - ./Microsoft.Sql/preview/2021-02-01-preview/ReplicationLinks.json
 - ./Microsoft.Sql/preview/2021-02-01-preview/RestorableDroppedDatabases.json
 - ./Microsoft.Sql/preview/2021-02-01-preview/RestorableDroppedManagedDatabases.json
 - ./Microsoft.Sql/preview/2021-02-01-preview/RestorePoints.json
 - ./Microsoft.Sql/preview/2021-02-01-preview/SensitivityLabels.json
 - ./Microsoft.Sql/preview/2021-02-01-preview/ServerAdvisors.json
 - ./Microsoft.Sql/preview/2021-02-01-preview/ServerAutomaticTuning.json
 - ./Microsoft.Sql/preview/2021-02-01-preview/ServerAzureADAdministrators.json
 - ./Microsoft.Sql/preview/2021-02-01-preview/ServerAzureADOnlyAuthentications.json
 - ./Microsoft.Sql/preview/2021-02-01-preview/ServerDevOpsAudit.json
 - ./Microsoft.Sql/preview/2021-02-01-preview/ServerDnsAliases.json
 - ./Microsoft.Sql/preview/2021-02-01-preview/ServerKeys.json
 - ./Microsoft.Sql/preview/2021-02-01-preview/ServerOperations.json
 - ./Microsoft.Sql/preview/2021-02-01-preview/Servers.json
 - ./Microsoft.Sql/preview/2021-02-01-preview/ServerSecurityAlertPolicies.json
 - ./Microsoft.Sql/preview/2021-02-01-preview/ServerTrustGroups.json
 - ./Microsoft.Sql/preview/2021-02-01-preview/ServerVulnerabilityAssessments.json
 - ./Microsoft.Sql/preview/2021-02-01-preview/SqlAgent.json
 - ./Microsoft.Sql/preview/2021-02-01-preview/SubscriptionUsages.json
 - ./Microsoft.Sql/preview/2021-02-01-preview/SyncAgents.json
 - ./Microsoft.Sql/preview/2021-02-01-preview/SyncGroups.json
 - ./Microsoft.Sql/preview/2021-02-01-preview/SyncMembers.json
 - ./Microsoft.Sql/preview/2021-02-01-preview/TdeCertificates.json
 - ./Microsoft.Sql/preview/2021-02-01-preview/TimeZones.json
 - ./Microsoft.Sql/preview/2021-02-01-preview/TransparentDataEncryptions.json
 - ./Microsoft.Sql/preview/2021-02-01-preview/Usages.json
 - ./Microsoft.Sql/preview/2021-02-01-preview/VirtualClusters.json
 - ./Microsoft.Sql/preview/2021-02-01-preview/VirtualNetworkRules.json
 - ./Microsoft.Sql/preview/2021-02-01-preview/WorkloadClassifiers.json
 - ./Microsoft.Sql/preview/2021-02-01-preview/WorkloadGroups.json

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
  - Microsoft.Sql/preview/2020-11-01-preview/BackupShortTermRetentionPolicies.json
  - Microsoft.Sql/preview/2020-11-01-preview/BlobAuditing.json
  - Microsoft.Sql/preview/2020-11-01-preview/DataWarehouseUserActivities.json
  - Microsoft.Sql/preview/2020-11-01-preview/DatabaseAdvisors.json
  - Microsoft.Sql/preview/2020-11-01-preview/DatabaseAutomaticTuning.json
  - Microsoft.Sql/preview/2020-11-01-preview/DatabaseColumns.json
  - Microsoft.Sql/preview/2020-11-01-preview/DatabaseExtensions.json
  - Microsoft.Sql/preview/2020-11-01-preview/DatabaseOperations.json
  - Microsoft.Sql/preview/2020-11-01-preview/DatabaseRecommendedActions.json
  - Microsoft.Sql/preview/2020-11-01-preview/DatabaseSchemas.json
  - Microsoft.Sql/preview/2020-11-01-preview/DatabaseSecurityAlertPolicies.json
  - Microsoft.Sql/preview/2020-11-01-preview/DatabaseTables.json
  - Microsoft.Sql/preview/2020-11-01-preview/DatabaseUsages.json
  - Microsoft.Sql/preview/2020-11-01-preview/DatabaseVulnerabilityAssesmentRuleBaselines.json
  - Microsoft.Sql/preview/2020-11-01-preview/DatabaseVulnerabilityAssessmentScans.json
  - Microsoft.Sql/preview/2020-11-01-preview/DatabaseVulnerabilityAssessments.json
  - Microsoft.Sql/preview/2020-11-01-preview/Databases.json
  - Microsoft.Sql/preview/2020-11-01-preview/Databases_legacy.json
  - Microsoft.Sql/preview/2020-11-01-preview/DeletedServers.json
  - Microsoft.Sql/preview/2020-11-01-preview/ElasticPoolOperations.json
  - Microsoft.Sql/preview/2020-11-01-preview/ElasticPools.json
  - Microsoft.Sql/preview/2020-11-01-preview/EncryptionProtectors.json
  - Microsoft.Sql/preview/2020-11-01-preview/FailoverGroups.json
  - Microsoft.Sql/preview/2020-11-01-preview/FirewallRules.json
  - Microsoft.Sql/preview/2020-11-01-preview/InstanceFailoverGroups.json
  - Microsoft.Sql/preview/2020-11-01-preview/InstancePools.json
  - Microsoft.Sql/preview/2020-11-01-preview/JobAgents.json
  - Microsoft.Sql/preview/2020-11-01-preview/JobCredentials.json
  - Microsoft.Sql/preview/2020-11-01-preview/JobExecutions.json
  - Microsoft.Sql/preview/2020-11-01-preview/JobStepExecutions.json
  - Microsoft.Sql/preview/2020-11-01-preview/JobSteps.json
  - Microsoft.Sql/preview/2020-11-01-preview/JobTargetExecutions.json
  - Microsoft.Sql/preview/2020-11-01-preview/JobTargetGroups.json
  - Microsoft.Sql/preview/2020-11-01-preview/JobVersions.json
  - Microsoft.Sql/preview/2020-11-01-preview/Jobs.json
  - Microsoft.Sql/preview/2020-11-01-preview/LocationCapabilities.json
  - Microsoft.Sql/preview/2020-11-01-preview/LongTermRetentionBackups.json
  - Microsoft.Sql/preview/2020-11-01-preview/LongTermRetentionManagedInstanceBackups.json
  - Microsoft.Sql/preview/2020-11-01-preview/LongTermRetentionPolicies.json
  - Microsoft.Sql/preview/2020-11-01-preview/MaintenanceWindowOptions.json
  - Microsoft.Sql/preview/2020-11-01-preview/MaintenanceWindows.json
  - Microsoft.Sql/preview/2020-11-01-preview/ManagedBackupShortTermRetentionPolicies.json
  - Microsoft.Sql/preview/2020-11-01-preview/ManagedDatabaseColumns.json
  - Microsoft.Sql/preview/2020-11-01-preview/ManagedDatabaseQueries.json
  - Microsoft.Sql/preview/2020-11-01-preview/ManagedDatabaseRestoreDetails.json
  - Microsoft.Sql/preview/2020-11-01-preview/ManagedDatabaseSchemas.json
  - Microsoft.Sql/preview/2020-11-01-preview/ManagedDatabaseSecurityAlertPolicies.json
  - Microsoft.Sql/preview/2020-11-01-preview/ManagedDatabaseSecurityEvents.json
  - Microsoft.Sql/preview/2020-11-01-preview/ManagedDatabaseSensitivityLabels.json
  - Microsoft.Sql/preview/2020-11-01-preview/ManagedDatabaseTables.json
  - Microsoft.Sql/preview/2020-11-01-preview/ManagedDatabaseTransparentDataEncryption.json
  - Microsoft.Sql/preview/2020-11-01-preview/ManagedDatabaseVulnerabilityAssessmentRuleBaselines.json
  - Microsoft.Sql/preview/2020-11-01-preview/ManagedDatabaseVulnerabilityAssessmentScans.json
  - Microsoft.Sql/preview/2020-11-01-preview/ManagedDatabaseVulnerabilityAssessments.json
  - Microsoft.Sql/preview/2020-11-01-preview/ManagedDatabases.json
  - Microsoft.Sql/preview/2020-11-01-preview/ManagedInstanceAdministrators.json
  - Microsoft.Sql/preview/2020-11-01-preview/ManagedInstanceAzureADOnlyAuthentications.json
  - Microsoft.Sql/preview/2020-11-01-preview/ManagedInstanceEncryptionProtectors.json
  - Microsoft.Sql/preview/2020-11-01-preview/ManagedInstanceKeys.json
  - Microsoft.Sql/preview/2020-11-01-preview/ManagedInstanceLongTermRetentionPolicies.json
  - Microsoft.Sql/preview/2020-11-01-preview/ManagedInstanceOperations.json
  - Microsoft.Sql/preview/2020-11-01-preview/ManagedInstancePrivateEndpointConnections.json
  - Microsoft.Sql/preview/2020-11-01-preview/ManagedInstancePrivateLinkResources.json
  - Microsoft.Sql/preview/2020-11-01-preview/ManagedInstanceTdeCertificates.json
  - Microsoft.Sql/preview/2020-11-01-preview/ManagedInstanceVulnerabilityAssessments.json
  - Microsoft.Sql/preview/2020-11-01-preview/ManagedInstances.json
  - Microsoft.Sql/preview/2020-11-01-preview/ManagedRestorableDroppedDatabaseBackupShortTermRetentionPolicies.json
  - Microsoft.Sql/preview/2020-11-01-preview/ManagedServerSecurityAlertPolicies.json
  - Microsoft.Sql/preview/2020-11-01-preview/Operations.json
  - Microsoft.Sql/preview/2020-11-01-preview/PrivateEndpointConnections.json
  - Microsoft.Sql/preview/2020-11-01-preview/PrivateLinkResources.json
  - Microsoft.Sql/preview/2020-11-01-preview/RecoverableManagedDatabases.json
  - Microsoft.Sql/preview/2020-11-01-preview/ReplicationLinks.json
  - Microsoft.Sql/preview/2020-11-01-preview/RestorableDroppedDatabases.json
  - Microsoft.Sql/preview/2020-11-01-preview/RestorableDroppedManagedDatabases.json
  - Microsoft.Sql/preview/2020-11-01-preview/RestorePoints.json
  - Microsoft.Sql/preview/2020-11-01-preview/SensitivityLabels.json
  - Microsoft.Sql/preview/2020-11-01-preview/ServerAdvisors.json
  - Microsoft.Sql/preview/2020-11-01-preview/ServerAutomaticTuning.json
  - Microsoft.Sql/preview/2020-11-01-preview/ServerAzureADAdministrators.json
  - Microsoft.Sql/preview/2020-11-01-preview/ServerAzureADOnlyAuthentications.json
  - Microsoft.Sql/preview/2020-11-01-preview/ServerDevOpsAudit.json
  - Microsoft.Sql/preview/2020-11-01-preview/ServerDnsAliases.json
  - Microsoft.Sql/preview/2020-11-01-preview/ServerKeys.json
  - Microsoft.Sql/preview/2020-11-01-preview/ServerOperations.json
  - Microsoft.Sql/preview/2020-11-01-preview/ServerSecurityAlertPolicies.json
  - Microsoft.Sql/preview/2020-11-01-preview/ServerTrustGroups.json
  - Microsoft.Sql/preview/2020-11-01-preview/ServerVulnerabilityAssessments.json
  - Microsoft.Sql/preview/2020-11-01-preview/Servers.json
  - Microsoft.Sql/preview/2020-11-01-preview/SqlAgent.json
  - Microsoft.Sql/preview/2020-11-01-preview/SubscriptionUsages.json
  - Microsoft.Sql/preview/2020-11-01-preview/SyncAgents.json
  - Microsoft.Sql/preview/2020-11-01-preview/SyncGroups.json
  - Microsoft.Sql/preview/2020-11-01-preview/SyncMembers.json
  - Microsoft.Sql/preview/2020-11-01-preview/TdeCertificates.json
  - Microsoft.Sql/preview/2020-11-01-preview/TimeZones.json
  - Microsoft.Sql/preview/2020-11-01-preview/TransparentDataEncryptions.json
  - Microsoft.Sql/preview/2020-11-01-preview/VirtualClusters.json
  - Microsoft.Sql/preview/2020-11-01-preview/VirtualNetworkRules.json
  - Microsoft.Sql/preview/2020-11-01-preview/WorkloadClassifiers.json
  - Microsoft.Sql/preview/2020-11-01-preview/WorkloadGroups.json

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
 - ./Microsoft.Sql/preview/2020-08-01-preview/BackupShortTermRetentionPolicies.json
 - ./Microsoft.Sql/preview/2020-08-01-preview/BlobAuditing.json
 - ./Microsoft.Sql/preview/2020-08-01-preview/DatabaseAdvisors.json
 - ./Microsoft.Sql/preview/2020-08-01-preview/DatabaseAutomaticTuning.json
 - ./Microsoft.Sql/preview/2020-08-01-preview/DatabaseColumns.json
 - ./Microsoft.Sql/preview/2020-08-01-preview/DatabaseExtensions.json
 - ./Microsoft.Sql/preview/2020-08-01-preview/DatabaseOperations.json
 - ./Microsoft.Sql/preview/2020-08-01-preview/DatabaseRecommendedActions.json
 - ./Microsoft.Sql/preview/2020-08-01-preview/Databases.json
 - ./Microsoft.Sql/preview/2020-08-01-preview/Databases_legacy.json
 - ./Microsoft.Sql/preview/2020-08-01-preview/DatabaseSchemas.json
 - ./Microsoft.Sql/preview/2020-08-01-preview/DatabaseSecurityAlertPolicies.json
 - ./Microsoft.Sql/preview/2020-08-01-preview/DatabaseTables.json
 - ./Microsoft.Sql/preview/2020-08-01-preview/DatabaseUsages.json
 - ./Microsoft.Sql/preview/2020-08-01-preview/DatabaseVulnerabilityAssesmentRuleBaselines.json
 - ./Microsoft.Sql/preview/2020-08-01-preview/DatabaseVulnerabilityAssessments.json
 - ./Microsoft.Sql/preview/2020-08-01-preview/DatabaseVulnerabilityAssessmentScans.json
 - ./Microsoft.Sql/preview/2020-08-01-preview/DataWarehouseUserActivities.json
 - ./Microsoft.Sql/preview/2020-08-01-preview/DeletedServers.json
 - ./Microsoft.Sql/preview/2020-08-01-preview/ElasticPoolOperations.json
 - ./Microsoft.Sql/preview/2020-08-01-preview/ElasticPools.json
 - ./Microsoft.Sql/preview/2020-08-01-preview/EncryptionProtectors.json
 - ./Microsoft.Sql/preview/2020-08-01-preview/FailoverGroups.json
 - ./Microsoft.Sql/preview/2020-08-01-preview/FirewallRules.json
 - ./Microsoft.Sql/preview/2020-08-01-preview/InstanceFailoverGroups.json
 - ./Microsoft.Sql/preview/2020-08-01-preview/InstancePools.json
 - ./Microsoft.Sql/preview/2020-08-01-preview/JobAgents.json
 - ./Microsoft.Sql/preview/2020-08-01-preview/JobCredentials.json
 - ./Microsoft.Sql/preview/2020-08-01-preview/JobExecutions.json
 - ./Microsoft.Sql/preview/2020-08-01-preview/Jobs.json
 - ./Microsoft.Sql/preview/2020-08-01-preview/JobStepExecutions.json
 - ./Microsoft.Sql/preview/2020-08-01-preview/JobSteps.json
 - ./Microsoft.Sql/preview/2020-08-01-preview/JobTargetExecutions.json
 - ./Microsoft.Sql/preview/2020-08-01-preview/JobTargetGroups.json
 - ./Microsoft.Sql/preview/2020-08-01-preview/JobVersions.json
 - ./Microsoft.Sql/preview/2020-08-01-preview/LocationCapabilities.json
 - ./Microsoft.Sql/preview/2020-08-01-preview/LongTermRetentionBackups.json
 - ./Microsoft.Sql/preview/2020-08-01-preview/LongTermRetentionManagedInstanceBackups.json
 - ./Microsoft.Sql/preview/2020-08-01-preview/LongTermRetentionPolicies.json
 - ./Microsoft.Sql/preview/2020-08-01-preview/MaintenanceWindowOptions.json
 - ./Microsoft.Sql/preview/2020-08-01-preview/MaintenanceWindows.json
 - ./Microsoft.Sql/preview/2020-08-01-preview/ManagedBackupShortTermRetentionPolicies.json
 - ./Microsoft.Sql/preview/2020-08-01-preview/ManagedDatabaseColumns.json
 - ./Microsoft.Sql/preview/2020-08-01-preview/ManagedDatabaseQueries.json
 - ./Microsoft.Sql/preview/2020-08-01-preview/ManagedDatabaseRestoreDetails.json
 - ./Microsoft.Sql/preview/2020-08-01-preview/ManagedDatabases.json
 - ./Microsoft.Sql/preview/2020-08-01-preview/ManagedDatabaseSchemas.json
 - ./Microsoft.Sql/preview/2020-08-01-preview/ManagedDatabaseSecurityAlertPolicies.json
 - ./Microsoft.Sql/preview/2020-08-01-preview/ManagedDatabaseSecurityEvents.json
 - ./Microsoft.Sql/preview/2020-08-01-preview/ManagedDatabaseSensitivityLabels.json
 - ./Microsoft.Sql/preview/2020-08-01-preview/ManagedDatabaseTables.json
 - ./Microsoft.Sql/preview/2020-08-01-preview/ManagedDatabaseTransparentDataEncryption.json
 - ./Microsoft.Sql/preview/2020-08-01-preview/ManagedDatabaseVulnerabilityAssessmentRuleBaselines.json
 - ./Microsoft.Sql/preview/2020-08-01-preview/ManagedDatabaseVulnerabilityAssessments.json
 - ./Microsoft.Sql/preview/2020-08-01-preview/ManagedDatabaseVulnerabilityAssessmentScans.json
 - ./Microsoft.Sql/preview/2020-08-01-preview/ManagedInstanceAdministrators.json
 - ./Microsoft.Sql/preview/2020-08-01-preview/ManagedInstanceAzureADOnlyAuthentications.json
 - ./Microsoft.Sql/preview/2020-08-01-preview/ManagedInstanceEncryptionProtectors.json
 - ./Microsoft.Sql/preview/2020-08-01-preview/ManagedInstanceKeys.json
 - ./Microsoft.Sql/preview/2020-08-01-preview/ManagedInstanceLongTermRetentionPolicies.json
 - ./Microsoft.Sql/preview/2020-08-01-preview/ManagedInstanceOperations.json
 - ./Microsoft.Sql/preview/2020-08-01-preview/ManagedInstancePrivateEndpointConnections.json
 - ./Microsoft.Sql/preview/2020-08-01-preview/ManagedInstancePrivateLinkResources.json
 - ./Microsoft.Sql/preview/2020-08-01-preview/ManagedInstances.json
 - ./Microsoft.Sql/preview/2020-08-01-preview/ManagedInstanceTdeCertificates.json
 - ./Microsoft.Sql/preview/2020-08-01-preview/ManagedInstanceVulnerabilityAssessments.json
 - ./Microsoft.Sql/preview/2020-08-01-preview/ManagedRestorableDroppedDatabaseBackupShortTermRetentionPolicies.json
 - ./Microsoft.Sql/preview/2020-08-01-preview/ManagedServerSecurityAlertPolicies.json
 - ./Microsoft.Sql/preview/2020-08-01-preview/Operations.json
 - ./Microsoft.Sql/preview/2020-08-01-preview/PrivateEndpointConnections.json
 - ./Microsoft.Sql/preview/2020-08-01-preview/PrivateLinkResources.json
 - ./Microsoft.Sql/preview/2020-08-01-preview/RecoverableManagedDatabases.json
 - ./Microsoft.Sql/preview/2020-08-01-preview/ReplicationLinks.json
 - ./Microsoft.Sql/preview/2020-08-01-preview/RestorableDroppedDatabases.json
 - ./Microsoft.Sql/preview/2020-08-01-preview/RestorableDroppedManagedDatabases.json
 - ./Microsoft.Sql/preview/2020-08-01-preview/RestorePoints.json
 - ./Microsoft.Sql/preview/2020-08-01-preview/SensitivityLabels.json
 - ./Microsoft.Sql/preview/2020-08-01-preview/ServerAdvisors.json
 - ./Microsoft.Sql/preview/2020-08-01-preview/ServerAutomaticTuning.json
 - ./Microsoft.Sql/preview/2020-08-01-preview/ServerAzureADAdministrators.json
 - ./Microsoft.Sql/preview/2020-08-01-preview/ServerAzureADOnlyAuthentications.json
 - ./Microsoft.Sql/preview/2020-08-01-preview/ServerDevOpsAudit.json
 - ./Microsoft.Sql/preview/2020-08-01-preview/ServerDnsAliases.json
 - ./Microsoft.Sql/preview/2020-08-01-preview/ServerKeys.json
 - ./Microsoft.Sql/preview/2020-08-01-preview/ServerOperations.json
 - ./Microsoft.Sql/preview/2020-08-01-preview/Servers.json
 - ./Microsoft.Sql/preview/2020-08-01-preview/ServerSecurityAlertPolicies.json
 - ./Microsoft.Sql/preview/2020-08-01-preview/ServerTrustGroups.json
 - ./Microsoft.Sql/preview/2020-08-01-preview/ServerVulnerabilityAssessments.json
 - ./Microsoft.Sql/preview/2020-08-01-preview/SqlAgent.json
 - ./Microsoft.Sql/preview/2020-08-01-preview/SubscriptionUsages.json
 - ./Microsoft.Sql/preview/2020-08-01-preview/SyncAgents.json
 - ./Microsoft.Sql/preview/2020-08-01-preview/SyncGroups.json
 - ./Microsoft.Sql/preview/2020-08-01-preview/SyncMembers.json
 - ./Microsoft.Sql/preview/2020-08-01-preview/TdeCertificates.json
 - ./Microsoft.Sql/preview/2020-08-01-preview/TimeZones.json
 - ./Microsoft.Sql/preview/2020-08-01-preview/TransparentDataEncryptions.json
 - ./Microsoft.Sql/preview/2020-08-01-preview/VirtualClusters.json
 - ./Microsoft.Sql/preview/2020-08-01-preview/VirtualNetworkRules.json
 - ./Microsoft.Sql/preview/2020-08-01-preview/WorkloadClassifiers.json
 - ./Microsoft.Sql/preview/2020-08-01-preview/WorkloadGroups.json

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
 - ./Microsoft.Sql/preview/2020-02-02-preview/BackupShortTermRetentionPolicies.json
 - ./Microsoft.Sql/preview/2020-02-02-preview/BlobAuditing.json
 - ./Microsoft.Sql/preview/2020-02-02-preview/DatabaseAdvisors.json
 - ./Microsoft.Sql/preview/2020-02-02-preview/DatabaseAutomaticTuning.json
 - ./Microsoft.Sql/preview/2020-02-02-preview/DatabaseColumns.json
 - ./Microsoft.Sql/preview/2020-02-02-preview/DatabaseOperations.json
 - ./Microsoft.Sql/preview/2020-02-02-preview/DatabaseRecommendedActions.json
 - ./Microsoft.Sql/preview/2020-02-02-preview/Databases.json
 - ./Microsoft.Sql/preview/2020-02-02-preview/DatabaseSchemas.json
 - ./Microsoft.Sql/preview/2020-02-02-preview/DatabaseSecurityAlertPolicies.json
 - ./Microsoft.Sql/preview/2020-02-02-preview/DatabaseTables.json
 - ./Microsoft.Sql/preview/2020-02-02-preview/DatabaseUsages.json
 - ./Microsoft.Sql/preview/2020-02-02-preview/DatabaseVulnerabilityAssesmentRuleBaselines.json
 - ./Microsoft.Sql/preview/2020-02-02-preview/DatabaseVulnerabilityAssessments.json
 - ./Microsoft.Sql/preview/2020-02-02-preview/DatabaseVulnerabilityAssessmentScans.json
 - ./Microsoft.Sql/preview/2020-02-02-preview/DataWarehouseUserActivities.json
 - ./Microsoft.Sql/preview/2020-02-02-preview/DeletedServers.json
 - ./Microsoft.Sql/preview/2020-02-02-preview/ElasticPoolOperations.json
 - ./Microsoft.Sql/preview/2020-02-02-preview/ElasticPools.json
 - ./Microsoft.Sql/preview/2020-02-02-preview/EncryptionProtectors.json
 - ./Microsoft.Sql/preview/2020-02-02-preview/FailoverGroups.json
 - ./Microsoft.Sql/preview/2020-02-02-preview/FirewallRules.json
 - ./Microsoft.Sql/preview/2020-02-02-preview/ImportExport.json
 - ./Microsoft.Sql/preview/2020-02-02-preview/InstanceFailoverGroups.json
 - ./Microsoft.Sql/preview/2020-02-02-preview/InstancePools.json
 - ./Microsoft.Sql/preview/2020-02-02-preview/JobAgents.json
 - ./Microsoft.Sql/preview/2020-02-02-preview/JobCredentials.json
 - ./Microsoft.Sql/preview/2020-02-02-preview/JobExecutions.json
 - ./Microsoft.Sql/preview/2020-02-02-preview/Jobs.json
 - ./Microsoft.Sql/preview/2020-02-02-preview/JobStepExecutions.json
 - ./Microsoft.Sql/preview/2020-02-02-preview/JobSteps.json
 - ./Microsoft.Sql/preview/2020-02-02-preview/JobTargetExecutions.json
 - ./Microsoft.Sql/preview/2020-02-02-preview/JobTargetGroups.json
 - ./Microsoft.Sql/preview/2020-02-02-preview/JobVersions.json
 - ./Microsoft.Sql/preview/2020-02-02-preview/LocationCapabilities.json
 - ./Microsoft.Sql/preview/2020-02-02-preview/LongTermRetentionBackups.json
 - ./Microsoft.Sql/preview/2020-02-02-preview/LongTermRetentionManagedInstanceBackups.json
 - ./Microsoft.Sql/preview/2020-02-02-preview/LongTermRetentionPolicies.json
 - ./Microsoft.Sql/preview/2020-02-02-preview/MaintenanceWindowOptions.json
 - ./Microsoft.Sql/preview/2020-02-02-preview/MaintenanceWindows.json
 - ./Microsoft.Sql/preview/2020-02-02-preview/ManagedBackupShortTermRetentionPolicies.json
 - ./Microsoft.Sql/preview/2020-02-02-preview/ManagedDatabaseColumns.json
 - ./Microsoft.Sql/preview/2020-02-02-preview/ManagedDatabaseQueries.json
 - ./Microsoft.Sql/preview/2020-02-02-preview/ManagedDatabaseRestoreDetails.json
 - ./Microsoft.Sql/preview/2020-02-02-preview/ManagedDatabases.json
 - ./Microsoft.Sql/preview/2020-02-02-preview/ManagedDatabaseSchemas.json
 - ./Microsoft.Sql/preview/2020-02-02-preview/ManagedDatabaseSecurityAlertPolicies.json
 - ./Microsoft.Sql/preview/2020-02-02-preview/ManagedDatabaseSecurityEvents.json
 - ./Microsoft.Sql/preview/2020-02-02-preview/ManagedDatabaseSensitivityLabels.json
 - ./Microsoft.Sql/preview/2020-02-02-preview/ManagedDatabaseTables.json
 - ./Microsoft.Sql/preview/2020-02-02-preview/ManagedDatabaseTransparentDataEncryption.json
 - ./Microsoft.Sql/preview/2020-02-02-preview/ManagedDatabaseVulnerabilityAssessmentRuleBaselines.json
 - ./Microsoft.Sql/preview/2020-02-02-preview/ManagedDatabaseVulnerabilityAssessments.json
 - ./Microsoft.Sql/preview/2020-02-02-preview/ManagedDatabaseVulnerabilityAssessmentScans.json
 - ./Microsoft.Sql/preview/2020-02-02-preview/ManagedInstanceAdministrators.json
 - ./Microsoft.Sql/preview/2020-02-02-preview/ManagedInstanceAzureADOnlyAuthentications.json
 - ./Microsoft.Sql/preview/2020-02-02-preview/ManagedInstanceEncryptionProtectors.json
 - ./Microsoft.Sql/preview/2020-02-02-preview/ManagedInstanceKeys.json
 - ./Microsoft.Sql/preview/2020-02-02-preview/ManagedInstanceLongTermRetentionPolicies.json
 - ./Microsoft.Sql/preview/2020-02-02-preview/ManagedInstanceOperations.json
 - ./Microsoft.Sql/preview/2020-02-02-preview/ManagedInstancePrivateEndpointConnections.json
 - ./Microsoft.Sql/preview/2020-02-02-preview/ManagedInstancePrivateLinkResources.json
 - ./Microsoft.Sql/preview/2020-02-02-preview/ManagedInstances.json
 - ./Microsoft.Sql/preview/2020-02-02-preview/ManagedInstanceTdeCertificates.json
 - ./Microsoft.Sql/preview/2020-02-02-preview/ManagedInstanceVulnerabilityAssessments.json
 - ./Microsoft.Sql/preview/2020-02-02-preview/ManagedRestorableDroppedDatabaseBackupShortTermRetentionPolicies.json
 - ./Microsoft.Sql/preview/2020-02-02-preview/ManagedServerSecurityAlertPolicies.json
 - ./Microsoft.Sql/preview/2020-02-02-preview/Operations.json
 - ./Microsoft.Sql/preview/2020-02-02-preview/PrivateEndpointConnections.json
 - ./Microsoft.Sql/preview/2020-02-02-preview/PrivateLinkResources.json
 - ./Microsoft.Sql/preview/2020-02-02-preview/RecoverableManagedDatabases.json
 - ./Microsoft.Sql/preview/2020-02-02-preview/ReplicationLinks.json
 - ./Microsoft.Sql/preview/2020-02-02-preview/RestorableDroppedDatabases.json
 - ./Microsoft.Sql/preview/2020-02-02-preview/RestorableDroppedManagedDatabases.json
 - ./Microsoft.Sql/preview/2020-02-02-preview/RestorePoints.json
 - ./Microsoft.Sql/preview/2020-02-02-preview/SensitivityLabels.json
 - ./Microsoft.Sql/preview/2020-02-02-preview/ServerAdvisors.json
 - ./Microsoft.Sql/preview/2020-02-02-preview/ServerAutomaticTuning.json
 - ./Microsoft.Sql/preview/2020-02-02-preview/ServerAzureADAdministrators.json
 - ./Microsoft.Sql/preview/2020-02-02-preview/ServerAzureADOnlyAuthentications.json
 - ./Microsoft.Sql/preview/2020-02-02-preview/ServerDevOpsAudit.json
 - ./Microsoft.Sql/preview/2020-02-02-preview/ServerDnsAliases.json
 - ./Microsoft.Sql/preview/2020-02-02-preview/ServerKeys.json
 - ./Microsoft.Sql/preview/2020-02-02-preview/ServerOperations.json
 - ./Microsoft.Sql/preview/2020-02-02-preview/Servers.json
 - ./Microsoft.Sql/preview/2020-02-02-preview/ServerSecurityAlertPolicies.json
 - ./Microsoft.Sql/preview/2020-02-02-preview/ServerTrustGroups.json
 - ./Microsoft.Sql/preview/2020-02-02-preview/ServerVulnerabilityAssessments.json
 - ./Microsoft.Sql/preview/2020-02-02-preview/SqlAgent.json
 - ./Microsoft.Sql/preview/2020-02-02-preview/SubscriptionUsages.json
 - ./Microsoft.Sql/preview/2020-02-02-preview/SyncAgents.json
 - ./Microsoft.Sql/preview/2020-02-02-preview/SyncGroups.json
 - ./Microsoft.Sql/preview/2020-02-02-preview/SyncMembers.json
 - ./Microsoft.Sql/preview/2020-02-02-preview/TdeCertificates.json
 - ./Microsoft.Sql/preview/2020-02-02-preview/TimeZones.json
 - ./Microsoft.Sql/preview/2020-02-02-preview/TransparentDataEncryptions.json
 - ./Microsoft.Sql/preview/2020-02-02-preview/VirtualClusters.json
 - ./Microsoft.Sql/preview/2020-02-02-preview/VirtualNetworkRules.json
 - ./Microsoft.Sql/preview/2020-02-02-preview/WorkloadClassifiers.json
 - ./Microsoft.Sql/preview/2020-02-02-preview/WorkloadGroups.json

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
 - ./Microsoft.Sql/preview/2019-06-01-preview/databases.json
 - ./Microsoft.Sql/preview/2019-06-01-preview/managedDatabases.json
 - ./Microsoft.Sql/preview/2019-06-01-preview/serverOperations.json
 - ./Microsoft.Sql/preview/2019-06-01-preview/servers.json
 - ./Microsoft.Sql/preview/2019-06-01-preview/WorkloadGroups.json
 - ./Microsoft.Sql/preview/2019-06-01-preview/WorkloadClassifiers.json
 - ./Microsoft.Sql/preview/2019-06-01-preview/managedInstanceOperations.json
 - ./Microsoft.Sql/preview/2019-06-01-preview/ServerAzureADAdministrators.json
 - ./Microsoft.Sql/preview/2019-06-01-preview/syncGroups.json
 - ./Microsoft.Sql/preview/2019-06-01-preview/syncMembers.json
 - ./Microsoft.Sql/preview/2019-06-01-preview/FailoverManagedInstance.json

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
 - ./Microsoft.Sql/preview/2018-06-01-preview/DatabaseSecurityAlertPolicies.json
 - ./Microsoft.Sql/preview/2018-06-01-preview/managedDatabaseSensitivityLabels.json
 - ./Microsoft.Sql/preview/2018-06-01-preview/ManagedInstanceVulnerabilityAssessments.json
 - ./Microsoft.Sql/preview/2018-06-01-preview/managedInstanceOperations.json
 - ./Microsoft.Sql/preview/2018-06-01-preview/ServerVulnerabilityAssessments.json
 - ./Microsoft.Sql/preview/2018-06-01-preview/instancePools.json
 - ./Microsoft.Sql/preview/2018-06-01-preview/usages.json
 - ./Microsoft.Sql/preview/2018-06-01-preview/managedInstances.json
 - ./Microsoft.Sql/preview/2018-06-01-preview/managedDatabases.json
 - ./Microsoft.Sql/preview/2018-06-01-preview/FailoverDatabases.json
 - ./Microsoft.Sql/preview/2018-06-01-preview/FailoverElasticPools.json
 - ./Microsoft.Sql/preview/2018-06-01-preview/PrivateEndpointConnections.json
 - ./Microsoft.Sql/preview/2018-06-01-preview/ServerAzureADAdministrators.json
 - ./Microsoft.Sql/preview/2018-06-01-preview/ManagedInstanceLongTermRetentionPolicies.json
 - ./Microsoft.Sql/preview/2018-06-01-preview/LongTermRetentionManagedInstanceBackups.json

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
 - ./Microsoft.Sql/preview/2017-10-01-preview/cancelOperations.json
 - ./Microsoft.Sql/preview/2017-10-01-preview/cancelPoolOperations.json
 - ./Microsoft.Sql/preview/2017-10-01-preview/databaseVulnerabilityAssessmentScans.json
 - ./Microsoft.Sql/preview/2017-10-01-preview/managedDatabaseVulnerabilityAssesmentRuleBaselines.json
 - ./Microsoft.Sql/preview/2017-10-01-preview/managedDatabaseVulnerabilityAssessmentScans.json
 - ./Microsoft.Sql/preview/2017-10-01-preview/managedDatabaseVulnerabilityAssessments.json
 - ./Microsoft.Sql/preview/2017-10-01-preview/capabilities.json
 - ./Microsoft.Sql/preview/2017-10-01-preview/databases.json
 - ./Microsoft.Sql/preview/2017-10-01-preview/elasticPools.json
 - ./Microsoft.Sql/preview/2017-10-01-preview/instanceFailoverGroups.json
 - ./Microsoft.Sql/preview/2017-10-01-preview/shortTermRetentionPolicies.json
 - ./Microsoft.Sql/preview/2017-10-01-preview/TdeCertificates.json
 - ./Microsoft.Sql/preview/2017-10-01-preview/ManagedInstanceTdeCertificates.json
 - ./Microsoft.Sql/preview/2017-10-01-preview/ManagedInstanceKeys.json
 - ./Microsoft.Sql/preview/2017-10-01-preview/ManagedInstanceEncryptionProtectors.json
 - ./Microsoft.Sql/preview/2017-10-01-preview/recoverableManagedDatabases.json

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
 - ./Microsoft.Sql/preview/2017-03-01-preview/blobAuditing.json
 - ./Microsoft.Sql/preview/2017-03-01-preview/cancelOperations.json
 - ./Microsoft.Sql/preview/2017-03-01-preview/databases.json
 - ./Microsoft.Sql/preview/2017-03-01-preview/databaseVulnerabilityAssessmentBaselines.json
 - ./Microsoft.Sql/preview/2017-03-01-preview/databaseVulnerabilityAssessments.json
 - ./Microsoft.Sql/preview/2017-03-01-preview/dataWarehouseUserActivities.json
 - ./Microsoft.Sql/preview/2017-03-01-preview/jobs.json
 - ./Microsoft.Sql/preview/2017-03-01-preview/longTermRetention.json
 - ./Microsoft.Sql/preview/2017-03-01-preview/ManagedBackupShortTermRetention.json
 - ./Microsoft.Sql/preview/2017-03-01-preview/managedDatabases.json
 - ./Microsoft.Sql/preview/2017-03-01-preview/ManagedRestorableDroppedDatabaseBackupShortTermRetenion.json
 - ./Microsoft.Sql/preview/2017-03-01-preview/renameDatabase.json
 - ./Microsoft.Sql/preview/2017-03-01-preview/restorableDroppedManagedDatabases.json
 - ./Microsoft.Sql/preview/2017-03-01-preview/restorePoints.json
 - ./Microsoft.Sql/preview/2017-03-01-preview/serverAutomaticTuning.json
 - ./Microsoft.Sql/preview/2017-03-01-preview/serverDnsAliases.json
 - ./Microsoft.Sql/preview/2017-03-01-preview/serverSecurityAlertPolicies.json
 - ./Microsoft.Sql/preview/2017-03-01-preview/ManagedDatabaseSecurityAlertPolicies.json
 - ./Microsoft.Sql/preview/2017-03-01-preview/ManagedServerSecurityAlertPolicy.json
 - ./Microsoft.Sql/preview/2017-03-01-preview/SensitivityLabels.json
 - ./Microsoft.Sql/preview/2017-03-01-preview/managedInstanceAdministrators.json

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
 - ./Microsoft.Sql/preview/2015-05-01-preview/advisors.json
 - ./Microsoft.Sql/preview/2015-05-01-preview/blobAuditing.json
 - ./Microsoft.Sql/preview/2015-05-01-preview/databaseAutomaticTuning.json
 - ./Microsoft.Sql/preview/2015-05-01-preview/encryptionProtectors.json
 - ./Microsoft.Sql/preview/2015-05-01-preview/failoverGroups.json
 - ./Microsoft.Sql/preview/2015-05-01-preview/firewallRules.json
 - ./Microsoft.Sql/preview/2015-05-01-preview/managedInstances.json
 - ./Microsoft.Sql/preview/2015-05-01-preview/operations.json
 - ./Microsoft.Sql/preview/2015-05-01-preview/serverKeys.json
 - ./Microsoft.Sql/preview/2015-05-01-preview/servers.json
 - ./Microsoft.Sql/preview/2015-05-01-preview/syncAgents.json
 - ./Microsoft.Sql/preview/2015-05-01-preview/syncGroups.json
 - ./Microsoft.Sql/preview/2015-05-01-preview/syncMembers.json
 - ./Microsoft.Sql/preview/2015-05-01-preview/usages.json
 - ./Microsoft.Sql/preview/2015-05-01-preview/virtualclusters.json
 - ./Microsoft.Sql/preview/2015-05-01-preview/virtualNetworkRules.json

# Needed when there is more than one input file
override-info:
  title: SqlManagementClient
```

### Tag: package-pure-2014-04

These settings apply only when `--tag=package-pure-2014-04` is specified on the command line.

This section contains all input swagger files for version 2014-04-01-preview. All APIs of that version must be added this section when the API is ready for production.

APIs must only be added to this section when the API is publicly available in at least 1 production region and at least 1 generated client has been tested end-to-end.

These can be regenerated by running the following PowerShell script from this readme file's folder: `dir .\Microsoft.Sql\stable\2014-04-01\ -File | Resolve-Path -Relative | % { " - $_".Replace("\", "/") }`

``` yaml $(tag) == 'package-pure-2014-04'
input-file:
 - ./Microsoft.Sql/stable/2014-04-01/advisors.json
 - ./Microsoft.Sql/stable/2014-04-01/backups.json
 - ./Microsoft.Sql/stable/2014-04-01/capabilities.json
 - ./Microsoft.Sql/stable/2014-04-01/checkNameAvailability.json
 - ./Microsoft.Sql/stable/2014-04-01/connectionPolicies.json
 - ./Microsoft.Sql/stable/2014-04-01/databases.json
 - ./Microsoft.Sql/stable/2014-04-01/databaseSecurityAlertPolicies.json
 - ./Microsoft.Sql/stable/2014-04-01/dataMasking.json
 - ./Microsoft.Sql/stable/2014-04-01/deprecated.json
 - ./Microsoft.Sql/stable/2014-04-01/disasterRecoveryConfigurations.json
 - ./Microsoft.Sql/stable/2014-04-01/elasticPools.json
 - ./Microsoft.Sql/stable/2014-04-01/firewallRules.json
 - ./Microsoft.Sql/stable/2014-04-01/geoBackupPolicies.json
 - ./Microsoft.Sql/stable/2014-04-01/importExport.json
 - ./Microsoft.Sql/stable/2014-04-01/metrics.json
 - ./Microsoft.Sql/stable/2014-04-01/operations.json
 - ./Microsoft.Sql/stable/2014-04-01/queries.json
 - ./Microsoft.Sql/stable/2014-04-01/recommendedElasticPools.json
 - ./Microsoft.Sql/stable/2014-04-01/replicationLinks.json
 - ./Microsoft.Sql/stable/2014-04-01/restorePoints.json
 - ./Microsoft.Sql/stable/2014-04-01/serverAzureADAdministrators.json
 - ./Microsoft.Sql/stable/2014-04-01/serverCommunicationLinks.json
 - ./Microsoft.Sql/stable/2014-04-01/servers.json
 - ./Microsoft.Sql/stable/2014-04-01/serviceObjectives.json
 - ./Microsoft.Sql/stable/2014-04-01/sql.core.json
 - ./Microsoft.Sql/stable/2014-04-01/tableAuditing.json
 - ./Microsoft.Sql/stable/2014-04-01/usages.json

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
## Suppressions

``` yaml
suppressions:
  - code: MissingSegmentsInNestedResourceListOperation
    from: BackupShortTermRetentionPolicies.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/backupShortTermRetentionPolicies"]
  - code: ResourceNameRestriction
    from: BackupShortTermRetentionPolicies.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/backupShortTermRetentionPolicies"]
  - code: ParameterNotDefinedInGlobalParameters
    from: BackupShortTermRetentionPolicies.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/backupShortTermRetentionPolicies"].get.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: BackupShortTermRetentionPolicies.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/backupShortTermRetentionPolicies"].get.responses.default.schema["$ref"]
  - code: ResourceNameRestriction
    from: BackupShortTermRetentionPolicies.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/backupShortTermRetentionPolicies/{policyName}"]
  - code: ParameterNotDefinedInGlobalParameters
    from: BackupShortTermRetentionPolicies.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/backupShortTermRetentionPolicies/{policyName}"].get.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: BackupShortTermRetentionPolicies.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/backupShortTermRetentionPolicies/{policyName}"].get.responses.default.schema["$ref"]
  - code: ProvisioningStateSpecifiedForLROPut
    from: BackupShortTermRetentionPolicies.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/backupShortTermRetentionPolicies/{policyName}"].put
  - code: PutResponseCodes
    from: BackupShortTermRetentionPolicies.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/backupShortTermRetentionPolicies/{policyName}"].put
  - code: ParameterNotDefinedInGlobalParameters
    from: BackupShortTermRetentionPolicies.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/backupShortTermRetentionPolicies/{policyName}"].put.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: BackupShortTermRetentionPolicies.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/backupShortTermRetentionPolicies/{policyName}"].put.responses.default.schema["$ref"]
  - code: ParameterNotDefinedInGlobalParameters
    from: BackupShortTermRetentionPolicies.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/backupShortTermRetentionPolicies/{policyName}"].patch.parameters
  - code: ProvisioningStateSpecifiedForLROPatch
    from: BackupShortTermRetentionPolicies.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/backupShortTermRetentionPolicies/{policyName}"].patch.responses["200"]
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: BackupShortTermRetentionPolicies.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/backupShortTermRetentionPolicies/{policyName}"].patch.responses.default.schema["$ref"]
  - code: PostOperationIdContainsUrlVerb
    from: DatabaseSqlVulnerabilityAssessmentExecuteScan.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/sqlVulnerabilityAssessments/{vulnerabilityAssessmentName}/initiateScan"].post.operationId
  - code: PostOperationIdContainsUrlVerb
    from: SqlVulnerabilityAssessmentExecuteScan.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/sqlVulnerabilityAssessments/{vulnerabilityAssessmentName}/initiateScan"].post.operationId
  - code: PostOperationIdContainsUrlVerb
    from: ManagedInstanceTdeCertificates.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/tdeCertificates"].post.operationId
  - code: PostOperationIdContainsUrlVerb
    from: TdeCertificates.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/tdeCertificates"].post.operationId
  - code: RequiredReadOnlySystemData
    from: DatabaseSchemas.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/schemas/{schemaName}"].get
  - code: RequiredReadOnlySystemData
    from: EndpointCertificates.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/endpointCertificates/{endpointType}"].get
  - code: RequiredReadOnlySystemData
    from: ManagedDatabaseSchemas.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/databases/{databaseName}/schemas/{schemaName}"].get
  - code: RequiredReadOnlySystemData
    from: RecoverableManagedDatabases.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/recoverableDatabases/{recoverableDatabaseName}"].get
  - code: RequiredReadOnlySystemData
    from: DataWarehouseUserActivities.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/dataWarehouseUserActivities/{dataWarehouseUserActivityName}"].get
  - code: RequiredReadOnlySystemData
    from: JobVersions.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/jobAgents/{jobAgentName}/jobs/{jobName}/versions/{jobVersion}"].get
  - code: XmsIdentifierValidation
    from: Operations.json
    where: $.definitions.OperationListResult.properties.value
  - code: RequiredPropertiesMissingInResourceModel
    from: Operations.json
    where: $.definitions.OperationListResult
  - code: RequiredReadOnlySystemData
    from: ManagedInstancePrivateLinkResources.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/privateLinkResources/{groupName}"].get
  - code: RequiredReadOnlySystemData
    from: TimeZones.json
    where: $.paths["/subscriptions/{subscriptionId}/providers/Microsoft.Sql/locations/{locationName}/timeZones/{timeZoneId}"].get
  - code: DefaultErrorResponseSchema
    from: MaintenanceWindows.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/maintenanceWindows/current"].get.responses.default
  - code: RequiredReadOnlySystemData
    from: PrivateLinkResources.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/privateLinkResources/{groupName}"].get
  - code: DefaultErrorResponseSchema
    from: MaintenanceWindows.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/maintenanceWindows/current"].put.responses.default
  - code: XmsEnumValidation
    from: SqlAgent.json
    where: $.definitions.SqlAgentConfigurationProperties.properties.state
  - code: AllProxyResourcesShouldHaveDelete
    from: SqlAgent.json
    where: $.definitions.SqlAgentConfiguration
  - code: RequiredReadOnlySystemData
    from: RestorableDroppedManagedDatabases.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/restorableDroppedDatabases/{restorableDroppedDatabaseId}"].get
  - code: RequiredReadOnlySystemData
    from: DatabaseTables.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/schemas/{schemaName}/tables/{tableName}"].get
  - code: RequiredReadOnlySystemData
    from: SubscriptionUsages.json
    where: $.paths["/subscriptions/{subscriptionId}/providers/Microsoft.Sql/locations/{locationName}/usages/{usageName}"].get
  - code: XmsIdentifierValidation
    from: MaintenanceWindowOptions.json
    where: $.definitions.MaintenanceWindowOptionsProperties.properties.maintenanceWindowCycles
  - code: RequiredPropertiesMissingInResourceModel
    from: Usages.json
    where: $.definitions.UsageListResult
  - code: RequiredReadOnlySystemData
    from: DataMaskingPolicies.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/dataMaskingPolicies/{dataMaskingPolicyName}"].get
  - code: XmsIdentifierValidation
    from: MaintenanceWindows.json
    where: $.definitions.MaintenanceWindowsProperties.properties.timeRanges
  - code: RequiredReadOnlySystemData
    from: ManagedDatabaseTables.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/databases/{databaseName}/schemas/{schemaName}/tables/{tableName}"].get
  - code: RequiredReadOnlySystemData
    from: DataMaskingPolicies.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/dataMaskingPolicies/{dataMaskingPolicyName}"].put
  - code: AllProxyResourcesShouldHaveDelete
    from: MaintenanceWindows.json
    where: $.definitions.MaintenanceWindows
  - code: AllTrackedResourcesMustHaveDelete
    from: RestorableDroppedManagedDatabases.json
    where: $.definitions.RestorableDroppedManagedDatabase
  - code: NestedResourcesMustHaveListOperation
    from: DataMaskingPolicies.json
    where: $.definitions.DataMaskingPolicy
  - code: TrackedResourcesMustHavePut
    from: RestorableDroppedManagedDatabases.json
    where: $.definitions.RestorableDroppedManagedDatabase
  - code: AllTrackedResourcesMustHaveDelete
    from: DataMaskingPolicies.json
    where: $.definitions.DataMaskingPolicy
  - code: TrackedResourcePatchOperation
    from: DataMaskingPolicies.json
    where: $.definitions.DataMaskingPolicy
  - code: RequiredReadOnlySystemData
    from: DeletedServers.json
    where: $.paths["/subscriptions/{subscriptionId}/providers/Microsoft.Sql/locations/{locationName}/deletedServers/{deletedServerName}"].get
  - code: RequiredReadOnlySystemData
    from: RecoverableDatabases.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/recoverableDatabases/{databaseName}"].get
  - code: RequiredReadOnlySystemData
    from: InstancePoolOperations.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/instancePools/{instancePoolName}/operations/{operationId}"].get
  - code: RequiredReadOnlySystemData
    from: GeoBackupPolicies.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/geoBackupPolicies/{geoBackupPolicyName}"].get
  - code: RequiredReadOnlySystemData
    from: GeoBackupPolicies.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/geoBackupPolicies/{geoBackupPolicyName}"].put
  - code: RequiredReadOnlySystemData
    from: OutboundFirewallRules.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/outboundFirewallRules/{outboundRuleFqdn}"].get
  - code: RequiredReadOnlySystemData
    from: ServerConfigurationOptions.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/serverConfigurationOptions/{serverConfigurationOptionName}"].get
  - code: RequiredReadOnlySystemData
    from: OutboundFirewallRules.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/outboundFirewallRules/{outboundRuleFqdn}"].put
  - code: RequiredReadOnlySystemData
    from: ServerConfigurationOptions.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/serverConfigurationOptions/{serverConfigurationOptionName}"].put
  - code: RequiredReadOnlySystemData
    from: ServerConnectionPolicies.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/connectionPolicies/{connectionPolicyName}"].get
  - code: RequiredReadOnlySystemData
    from: ServerConnectionPolicies.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/connectionPolicies/{connectionPolicyName}"].put
  - code: RequiredReadOnlySystemData
    from: ManagedDatabaseTransparentDataEncryption.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/databases/{databaseName}/transparentDataEncryption/{tdeName}"].get
  - code: RequiredReadOnlySystemData
    from: ManagedDatabaseTransparentDataEncryption.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/databases/{databaseName}/transparentDataEncryption/{tdeName}"].put
  - code: EnumMustRespectType
    from: BackupShortTermRetentionPolicies.json
    where: $.definitions.BackupShortTermRetentionPolicyProperties.properties.diffBackupIntervalInHours
  - code: RequiredReadOnlySystemData
    from: IPv6FirewallRules.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/ipv6FirewallRules/{firewallRuleName}"].get
  - code: RequiredReadOnlySystemData
    from: IPv6FirewallRules.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/ipv6FirewallRules/{firewallRuleName}"].put
  - code: RequiredReadOnlySystemData
    from: ManagedDatabaseMoveOperations.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/locations/{locationName}/managedDatabaseMoveOperationResults/{operationId}"].get
  - code: AllProxyResourcesShouldHaveDelete
    from: DatabaseAdvancedThreatProtectionSettings.json
    where: $.definitions.DatabaseAdvancedThreatProtection
  - code: RequiredReadOnlySystemData
    from: LongTermRetentionPolicies.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/backupLongTermRetentionPolicies/{policyName}"].get
  - code: RequiredReadOnlySystemData
    from: JobCredentials.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/jobAgents/{jobAgentName}/credentials/{credentialName}"].get
  - code: RequiredReadOnlySystemData
    from: LongTermRetentionPolicies.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/backupLongTermRetentionPolicies/{policyName}"].put
  - code: RequiredReadOnlySystemData
    from: JobCredentials.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/jobAgents/{jobAgentName}/credentials/{credentialName}"].put
  - code: RequiredReadOnlySystemData
    from: DataMaskingRules.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/dataMaskingPolicies/{dataMaskingPolicyName}/rules/{dataMaskingRuleName}"].put
  - code: RequiredReadOnlySystemData
    from: RestorableDroppedDatabases.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/restorableDroppedDatabases/{restorableDroppedDatabaseId}"].get
  - code: AllProxyResourcesShouldHaveDelete
    from: ManagedInstanceAdvancedThreatProtectionSettings.json
    where: $.definitions.ManagedInstanceAdvancedThreatProtection
  - code: UniqueXmsExample
    from: LongTermRetentionPolicies.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/backupLongTermRetentionPolicies/{policyName}"].get["x-ms-examples"]
  - code: RequiredReadOnlySystemData
    from: ServerTrustCertificates.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/serverTrustCertificates/{certificateName}"].get
  - code: RequiredReadOnlySystemData
    from: ServerTrustCertificates.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/serverTrustCertificates/{certificateName}"].put
  - code: AllTrackedResourcesMustHaveDelete
    from: GeoBackupPolicies.json
    where: $.definitions.GeoBackupPolicy
  - code: AllResourcesMustHaveGetOperation
    from: DataMaskingRules.json
    where: $.definitions.DataMaskingRule
  - code: RequiredReadOnlySystemData
    from: ManagedInstanceAzureADOnlyAuthentications.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/azureADOnlyAuthentications/{authenticationName}"].get
  - code: RequiredReadOnlySystemData
    from: ManagedInstancePrivateEndpointConnections.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/privateEndpointConnections/{privateEndpointConnectionName}"].get
  - code: RequiredReadOnlySystemData
    from: ManagedInstanceAzureADOnlyAuthentications.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/azureADOnlyAuthentications/{authenticationName}"].put
  - code: RequiredReadOnlySystemData
    from: ManagedInstancePrivateEndpointConnections.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/privateEndpointConnections/{privateEndpointConnectionName}"].put
  - code: AllProxyResourcesShouldHaveDelete
    from: ServerConfigurationOptions.json
    where: $.definitions.ServerConfigurationOption
  - code: NestedResourcesMustHaveListOperation
    from: DataMaskingRules.json
    where: $.definitions.DataMaskingRule
  - code: TrackedResourcePatchOperation
    from: GeoBackupPolicies.json
    where: $.definitions.GeoBackupPolicy
  - code: AllProxyResourcesShouldHaveDelete
    from: ManagedDatabaseAdvancedThreatProtectionSettings.json
    where: $.definitions.ManagedDatabaseAdvancedThreatProtection
  - code: AllTrackedResourcesMustHaveDelete
    from: ServerConnectionPolicies.json
    where: $.definitions.ServerConnectionPolicy
  - code: AllProxyResourcesShouldHaveDelete
    from: ServerAdvancedThreatProtectionSettings.json
    where: $.definitions.ServerAdvancedThreatProtection
  - code: RequiredReadOnlySystemData
    from: JobPrivateEndpoints.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/jobAgents/{jobAgentName}/privateEndpoints/{privateEndpointName}"].get
  - code: RequiredReadOnlySystemData
    from: LedgerDigestUploads.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/ledgerDigestUploads/{ledgerDigestUploads}"].get
  - code: PostOperationIdContainsUrlVerb
    from: RestorePoints.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/restorePoints"].post.operationId
  - code: RequiredReadOnlySystemData
    from: JobPrivateEndpoints.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/jobAgents/{jobAgentName}/privateEndpoints/{privateEndpointName}"].put
  - code: RequiredReadOnlySystemData
    from: BackupShortTermRetentionPolicies.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/backupShortTermRetentionPolicies/{policyName}"].get
  - code: RequiredReadOnlySystemData
    from: LedgerDigestUploads.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/ledgerDigestUploads/{ledgerDigestUploads}"].put
  - code: RequiredReadOnlySystemData
    from: BackupShortTermRetentionPolicies.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/backupShortTermRetentionPolicies/{policyName}"].put
  - code: DeleteOperationResponses
    from: DatabaseVulnerabilityAssessmentRuleBaselines.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/vulnerabilityAssessments/{vulnerabilityAssessmentName}/rules/{ruleId}/baselines/{baselineName}"].delete.responses
  - code: RequiredReadOnlySystemData
    from: BackupShortTermRetentionPolicies.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/backupShortTermRetentionPolicies/{policyName}"].patch
  - code: AllProxyResourcesShouldHaveDelete
    from: ManagedDatabaseTransparentDataEncryption.json
    where: $.definitions.ManagedTransparentDataEncryption
  - code: RequiredReadOnlySystemData
    from: ServerAzureADOnlyAuthentications.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/azureADOnlyAuthentications/{authenticationName}"].get
  - code: TrackedResourcePatchOperation
    from: ServerConnectionPolicies.json
    where: $.definitions.ServerConnectionPolicy
  - code: RequiredReadOnlySystemData
    from: DatabaseVulnerabilityAssessmentRuleBaselines.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/vulnerabilityAssessments/{vulnerabilityAssessmentName}/rules/{ruleId}/baselines/{baselineName}"].get
  - code: RequiredReadOnlySystemData
    from: ManagedBackupShortTermRetentionPolicies.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/databases/{databaseName}/backupShortTermRetentionPolicies/{policyName}"].get
  - code: RequiredReadOnlySystemData
    from: ServerAzureADOnlyAuthentications.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/azureADOnlyAuthentications/{authenticationName}"].put
  - code: RequiredReadOnlySystemData
    from: DatabaseVulnerabilityAssessmentRuleBaselines.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/vulnerabilityAssessments/{vulnerabilityAssessmentName}/rules/{ruleId}/baselines/{baselineName}"].put
  - code: RequiredReadOnlySystemData
    from: ManagedBackupShortTermRetentionPolicies.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/databases/{databaseName}/backupShortTermRetentionPolicies/{policyName}"].put
  - code: RequiredReadOnlySystemData
    from: ManagedDatabaseSecurityAlertPolicies.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/databases/{databaseName}/securityAlertPolicies/{securityAlertPolicyName}"].get
  - code: RequiredReadOnlySystemData
    from: ManagedDatabaseRestoreDetails.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/databases/{databaseName}/restoreDetails/{restoreDetailsName}"].get
  - code: RequiredReadOnlySystemData
    from: ManagedBackupShortTermRetentionPolicies.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/databases/{databaseName}/backupShortTermRetentionPolicies/{policyName}"].patch
  - code: RequiredReadOnlySystemData
    from: ManagedDatabaseSecurityAlertPolicies.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/databases/{databaseName}/securityAlertPolicies/{securityAlertPolicyName}"].put
  - code: RequiredReadOnlySystemData
    from: ManagedInstanceDtcs.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/dtc/{dtcName}"].get
  - code: RequiredReadOnlySystemData
    from: ManagedInstanceDtcs.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/dtc/{dtcName}"].put
  - code: NestedResourcesMustHaveListOperation
    from: ManagedDatabaseRestoreDetails.json
    where: $.definitions.ManagedDatabaseRestoreDetailsResult
  - code: RequiredReadOnlySystemData
    from: ManagedInstanceAdministrators.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/administrators/{administratorName}"].get
  - code: RequiredReadOnlySystemData
    from: ManagedInstanceAdministrators.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/administrators/{administratorName}"].put
  - code: NestedResourcesMustHaveListOperation
    from: DatabaseVulnerabilityAssessmentRuleBaselines.json
    where: $.definitions.DatabaseVulnerabilityAssessmentRuleBaseline
  - code: RequiredReadOnlySystemData
    from: VirtualNetworkRules.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/virtualNetworkRules/{virtualNetworkRuleName}"].get
  - code: RequiredReadOnlySystemData
    from: VirtualNetworkRules.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/virtualNetworkRules/{virtualNetworkRuleName}"].put
  - code: UniqueXmsExample
    from: BackupShortTermRetentionPolicies.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/backupShortTermRetentionPolicies/{policyName}"].get["x-ms-examples"]
  - code: UniqueXmsExample
    from: BackupShortTermRetentionPolicies.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/backupShortTermRetentionPolicies/{policyName}"].patch["x-ms-examples"]
  - code: RequiredReadOnlySystemData
    from: NetworkSecurityPerimeterConfigurations.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/networkSecurityPerimeterConfigurations/{nspConfigName}"].get
  - code: RequiredPropertiesMissingInResourceModel
    from: IPv6FirewallRules.json
    where: $.definitions.IPv6FirewallRule
  - code: RequiredReadOnlySystemData
    from: ManagedInstanceKeys.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/keys/{keyName}"].get
  - code: RequiredPropertiesMissingInResourceModel
    from: IPv6FirewallRules.json
    where: $.definitions.IPv6FirewallRuleListResult
  - code: AllProxyResourcesShouldHaveDelete
    from: LongTermRetentionPolicies.json
    where: $.definitions.LongTermRetentionPolicy
  - code: RequiredReadOnlySystemData
    from: ManagedInstanceKeys.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/keys/{keyName}"].put
  - code: RequiredReadOnlySystemData
    from: ManagedLedgerDigestUploads.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/databases/{databaseName}/ledgerDigestUploads/{ledgerDigestUploads}"].get
  - code: UniqueXmsExample
    from: ManagedBackupShortTermRetentionPolicies.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/databases/{databaseName}/backupShortTermRetentionPolicies/{policyName}"].patch["x-ms-examples"]
  - code: RequiredReadOnlySystemData
    from: ManagedLedgerDigestUploads.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/databases/{databaseName}/ledgerDigestUploads/{ledgerDigestUploads}"].put
  - code: AllTrackedResourcesMustHaveDelete
    from: RestorableDroppedDatabases.json
    where: $.definitions.RestorableDroppedDatabase
  - code: AllProxyResourcesShouldHaveDelete
    from: ServerDevOpsAudit.json
    where: $.definitions.ServerDevOpsAuditingSettings
  - code: RequiredReadOnlySystemData
    from: ManagedRestorableDroppedDatabaseBackupShortTermRetentionPolicies.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/restorableDroppedDatabases/{restorableDroppedDatabaseId}/backupShortTermRetentionPolicies/{policyName}"].get
  - code: RequiredReadOnlySystemData
    from: ManagedRestorableDroppedDatabaseBackupShortTermRetentionPolicies.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/restorableDroppedDatabases/{restorableDroppedDatabaseId}/backupShortTermRetentionPolicies/{policyName}"].put
  - code: RequiredReadOnlySystemData
    from: ManagedRestorableDroppedDatabaseBackupShortTermRetentionPolicies.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/restorableDroppedDatabases/{restorableDroppedDatabaseId}/backupShortTermRetentionPolicies/{policyName}"].patch
  - code: AllTrackedResourcesMustHaveDelete
    from: DataMaskingRules.json
    where: $.definitions.DataMaskingRule
  - code: RequiredReadOnlySystemData
    from: ManagedInstanceEncryptionProtectors.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/encryptionProtector/{encryptionProtectorName}"].get
  - code: RequiredReadOnlySystemData
    from: ManagedInstanceEncryptionProtectors.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/encryptionProtector/{encryptionProtectorName}"].put
  - code: UniqueXmsExample
    from: DatabaseSqlVulnerabilityAssessmentBaselines.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/sqlVulnerabilityAssessments/{vulnerabilityAssessmentName}/baselines/{baselineName}"].get["x-ms-examples"]
  - code: TrackedResourcePatchOperation
    from: RestorableDroppedDatabases.json
    where: $.definitions.RestorableDroppedDatabase
  - code: DeleteOperationResponses
    from: RestorePoints.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/restorePoints/{restorePointName}"].delete.responses
  - code: RequiredReadOnlySystemData
    from: FirewallRules.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/firewallRules/{firewallRuleName}"].get
  - code: RequiredReadOnlySystemData
    from: FirewallRules.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/firewallRules"].put
  - code: ArmResourcePropertiesBag
    from: DataMaskingRules.json
    where: $.definitions.DataMaskingRule
  - code: RequiredReadOnlySystemData
    from: EncryptionProtectors.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/encryptionProtector/{encryptionProtectorName}"].get
  - code: RequiredReadOnlySystemData
    from: FirewallRules.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/firewallRules/{firewallRuleName}"].put
  - code: RequiredReadOnlySystemData
    from: RestorePoints.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/restorePoints/{restorePointName}"].get
  - code: RequiredReadOnlySystemData
    from: EncryptionProtectors.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/encryptionProtector/{encryptionProtectorName}"].put
  - code: RequiredReadOnlySystemData
    from: Jobs.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/jobAgents/{jobAgentName}/jobs/{jobName}"].get
  - code: DeleteOperationResponses
    from: ManagedDatabaseVulnerabilityAssessmentRuleBaselines.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/databases/{databaseName}/vulnerabilityAssessments/{vulnerabilityAssessmentName}/rules/{ruleId}/baselines/{baselineName}"].delete.responses
  - code: TrackedResourcePatchOperation
    from: DataMaskingRules.json
    where: $.definitions.DataMaskingRule
  - code: AllProxyResourcesShouldHaveDelete
    from: ManagedServerSecurityAlertPolicies.json
    where: $.definitions.ManagedServerSecurityAlertPolicy
  - code: TrackedResourcesMustHavePut
    from: RestorableDroppedDatabases.json
    where: $.definitions.RestorableDroppedDatabase
  - code: RequiredReadOnlySystemData
    from: Jobs.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/jobAgents/{jobAgentName}/jobs/{jobName}"].put
  - code: AllProxyResourcesShouldHaveDelete
    from: DatabaseSecurityAlertPolicies.json
    where: $.definitions.DatabaseSecurityAlertPolicy
  - code: RequiredReadOnlySystemData
    from: ManagedDatabaseVulnerabilityAssessmentRuleBaselines.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/databases/{databaseName}/vulnerabilityAssessments/{vulnerabilityAssessmentName}/rules/{ruleId}/baselines/{baselineName}"].get
  - code: DeleteOperationResponses
    from: DatabaseVulnerabilityAssessments.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/vulnerabilityAssessments/{vulnerabilityAssessmentName}"].delete.responses
  - code: RequiredReadOnlySystemData
    from: ManagedDatabaseVulnerabilityAssessmentRuleBaselines.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/databases/{databaseName}/vulnerabilityAssessments/{vulnerabilityAssessmentName}/rules/{ruleId}/baselines/{baselineName}"].put
  - code: XmsIdentifierValidation
    from: ManagedDatabaseRestoreDetails.json
    where: $.definitions.ManagedDatabaseRestoreDetailsProperties.properties.fullBackupSets
  - code: TrackedResourceBeyondsThirdLevel
    from: DataMaskingRules.json
    where: $.definitions.DataMaskingRule
  - code: RequiredReadOnlySystemData
    from: DatabaseColumns.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/schemas/{schemaName}/tables/{tableName}/columns/{columnName}"].get
  - code: RequiredReadOnlySystemData
    from: DatabaseVulnerabilityAssessments.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/vulnerabilityAssessments/{vulnerabilityAssessmentName}"].get
  - code: XmsIdentifierValidation
    from: ManagedDatabaseRestoreDetails.json
    where: $.definitions.ManagedDatabaseRestoreDetailsProperties.properties.diffBackupSets
  - code: RequiredReadOnlySystemData
    from: ManagedInstanceLongTermRetentionPolicies.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/databases/{databaseName}/backupLongTermRetentionPolicies/{policyName}"].get
  - code: RequiredReadOnlySystemData
    from: DatabaseVulnerabilityAssessments.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/vulnerabilityAssessments/{vulnerabilityAssessmentName}"].put
  - code: RequiredReadOnlySystemData
    from: ManagedInstanceLongTermRetentionPolicies.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/databases/{databaseName}/backupLongTermRetentionPolicies/{policyName}"].put
  - code: UniqueXmsExample
    from: ManagedRestorableDroppedDatabaseBackupShortTermRetentionPolicies.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/restorableDroppedDatabases/{restorableDroppedDatabaseId}/backupShortTermRetentionPolicies/{policyName}"].patch["x-ms-examples"]
  - code: XmsIdentifierValidation
    from: ManagedDatabaseRestoreDetails.json
    where: $.definitions.ManagedDatabaseRestoreDetailsProperties.properties.logBackupSets
  - code: RequiredReadOnlySystemData
    from: ServerAzureADAdministrators.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/administrators/{administratorName}"].get
  - code: RequiredReadOnlySystemData
    from: ServerAzureADAdministrators.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/administrators/{administratorName}"].put
  - code: XmsIdentifierValidation
    from: ManagedDatabaseRestoreDetails.json
    where: $.definitions.ManagedDatabaseRestoreDetailsProperties.properties.unrestorableFiles
  - code: AllProxyResourcesShouldHaveDelete
    from: ServerSecurityAlertPolicies.json
    where: $.definitions.ServerSecurityAlertPolicy
  - code: NestedResourcesMustHaveListOperation
    from: ManagedDatabaseVulnerabilityAssessmentRuleBaselines.json
    where: $.definitions.DatabaseVulnerabilityAssessmentRuleBaseline
  - code: DeleteOperationResponses
    from: ManagedInstanceVulnerabilityAssessments.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/vulnerabilityAssessments/{vulnerabilityAssessmentName}"].delete.responses
  - code: RequiredReadOnlySystemData
    from: JobTargetGroups.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/jobAgents/{jobAgentName}/targetGroups/{targetGroupName}"].get
  - code: RequiredReadOnlySystemData
    from: ManagedInstanceVulnerabilityAssessments.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/vulnerabilityAssessments/{vulnerabilityAssessmentName}"].get
  - code: RequiredReadOnlySystemData
    from: JobTargetGroups.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/jobAgents/{jobAgentName}/targetGroups/{targetGroupName}"].put
  - code: ArmResourcePropertiesBag
    from: ManagedDatabaseRestoreDetails.json
    where: $.definitions.ManagedDatabaseRestoreDetailsResult
  - code: RequiredReadOnlySystemData
    from: ManagedInstanceVulnerabilityAssessments.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/vulnerabilityAssessments/{vulnerabilityAssessmentName}"].put
  - code: RequiredReadOnlySystemData
    from: WorkloadGroups.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/workloadGroups/{workloadGroupName}"].get
  - code: RequiredReadOnlySystemData
    from: PrivateEndpointConnections.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/privateEndpointConnections/{privateEndpointConnectionName}"].get
  - code: RequiredReadOnlySystemData
    from: ServerKeys.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/keys/{keyName}"].get
  - code: RequiredReadOnlySystemData
    from: WorkloadGroups.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/workloadGroups/{workloadGroupName}"].put
  - code: UniqueXmsExample
    from: DatabaseColumns.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/schemas/{schemaName}/tables/{tableName}/columns"].get["x-ms-examples"]
  - code: RequiredReadOnlySystemData
    from: PrivateEndpointConnections.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/privateEndpointConnections/{privateEndpointConnectionName}"].put
  - code: RequiredReadOnlySystemData
    from: ServerKeys.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/keys/{keyName}"].put
  - code: XmsIdentifierValidation
    from: DatabaseVulnerabilityAssessmentRuleBaselines.json
    where: $.definitions.DatabaseVulnerabilityAssessmentRuleBaselineProperties.properties.baselineResults
  - code: AllProxyResourcesShouldHaveDelete
    from: ManagedDatabaseSecurityAlertPolicies.json
    where: $.definitions.ManagedDatabaseSecurityAlertPolicy
  - code: RequiredReadOnlySystemData
    from: ManagedServerDnsAliases.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/dnsAliases/{dnsAliasName}"].get
  - code: AllProxyResourcesShouldHaveDelete
    from: LedgerDigestUploads.json
    where: $.definitions.LedgerDigestUploads
  - code: AllProxyResourcesShouldHaveDelete
    from: ManagedInstanceDtcs.json
    where: $.definitions.ManagedInstanceDtc
  - code: RequiredReadOnlySystemData
    from: ManagedServerDnsAliases.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/dnsAliases/{dnsAliasName}"].put
  - code: AllProxyResourcesShouldHaveDelete
    from: BackupShortTermRetentionPolicies.json
    where: $.definitions.BackupShortTermRetentionPolicy
  - code: AllProxyResourcesShouldHaveDelete
    from: ManagedBackupShortTermRetentionPolicies.json
    where: $.definitions.ManagedBackupShortTermRetentionPolicy
  - code: DeleteOperationResponses
    from: ServerVulnerabilityAssessments.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/vulnerabilityAssessments/{vulnerabilityAssessmentName}"].delete.responses
  - code: RequiredReadOnlySystemData
    from: ServerVulnerabilityAssessments.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/vulnerabilityAssessments/{vulnerabilityAssessmentName}"].get
  - code: RequiredReadOnlySystemData
    from: ServerVulnerabilityAssessments.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/vulnerabilityAssessments/{vulnerabilityAssessmentName}"].put
  - code: XmsIdentifierValidation
    from: DatabaseSqlVulnerabilityAssessmentScans.json
    where: $.definitions.SqlVulnerabilityAssessmentScanRecordProperties.properties.errors
  - code: RequiredReadOnlySystemData
    from: ServerDnsAliases.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/dnsAliases/{dnsAliasName}"].get
  - code: DeleteOperationResponses
    from: ManagedDatabaseVulnerabilityAssessments.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/databases/{databaseName}/vulnerabilityAssessments/{vulnerabilityAssessmentName}"].delete.responses
  - code: AllProxyResourcesShouldHaveDelete
    from: DatabaseSqlVulnerabilityAssessmentBaselines.json
    where: $.definitions.DatabaseSqlVulnerabilityAssessmentBaselineSet
  - code: RequiredReadOnlySystemData
    from: ManagedDatabaseQueries.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/databases/{databaseName}/queries/{queryId}"].get
  - code: RequiredReadOnlySystemData
    from: ServerDnsAliases.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/dnsAliases/{dnsAliasName}"].put
  - code: RequiredReadOnlySystemData
    from: WorkloadClassifiers.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/workloadGroups/{workloadGroupName}/workloadClassifiers/{workloadClassifierName}"].get
  - code: RequiredReadOnlySystemData
    from: ManagedDatabaseVulnerabilityAssessments.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/databases/{databaseName}/vulnerabilityAssessments/{vulnerabilityAssessmentName}"].get
  - code: RequiredReadOnlySystemData
    from: WorkloadClassifiers.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/workloadGroups/{workloadGroupName}/workloadClassifiers/{workloadClassifierName}"].put
  - code: RequiredReadOnlySystemData
    from: ManagedDatabaseVulnerabilityAssessments.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/databases/{databaseName}/vulnerabilityAssessments/{vulnerabilityAssessmentName}"].put
  - code: RequiredReadOnlySystemData
    from: ManagedDatabaseColumns.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/databases/{databaseName}/schemas/{schemaName}/tables/{tableName}/columns/{columnName}"].get
  - code: AllProxyResourcesShouldHaveDelete
    from: ManagedLedgerDigestUploads.json
    where: $.definitions.ManagedLedgerDigestUploads
  - code: NestedResourcesMustHaveListOperation
    from: ManagedDatabaseQueries.json
    where: $.definitions.ManagedInstanceQuery
  - code: AllProxyResourcesShouldHaveDelete
    from: ManagedRestorableDroppedDatabaseBackupShortTermRetentionPolicies.json
    where: $.definitions.ManagedBackupShortTermRetentionPolicy
  - code: AllTrackedResourcesMustHaveDelete
    from: RestorePoints.json
    where: $.definitions.RestorePoint
  - code: AllProxyResourcesShouldHaveDelete
    from: ManagedInstanceEncryptionProtectors.json
    where: $.definitions.ManagedInstanceEncryptionProtector
  - code: XmsIdentifierValidation
    from: ManagedDatabaseVulnerabilityAssessmentRuleBaselines.json
    where: $.definitions.DatabaseVulnerabilityAssessmentRuleBaselineProperties.properties.baselineResults
  - code: AllTrackedResourcesMustHaveDelete
    from: EncryptionProtectors.json
    where: $.definitions.EncryptionProtector
  - code: RequiredReadOnlySystemData
    from: ServerTrustGroups.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/locations/{locationName}/serverTrustGroups/{serverTrustGroupName}"].get
  - code: RequiredReadOnlySystemData
    from: ServerTrustGroups.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/locations/{locationName}/serverTrustGroups/{serverTrustGroupName}"].put
  - code: TrackedResourcePatchOperation
    from: RestorePoints.json
    where: $.definitions.RestorePoint
  - code: UniqueXmsExample
    from: ManagedDatabaseColumns.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/databases/{databaseName}/schemas/{schemaName}/tables/{tableName}/columns"].get["x-ms-examples"]
  - code: TrackedResourcePatchOperation
    from: EncryptionProtectors.json
    where: $.definitions.EncryptionProtector
  - code: AllProxyResourcesShouldHaveDelete
    from: FirewallRules.json
    where: $.definitions.FirewallRule
  - code: TrackedResourcesMustHavePut
    from: RestorePoints.json
    where: $.definitions.RestorePoint
  - code: RequiredPropertiesMissingInResourceModel
    from: FirewallRules.json
    where: $.definitions.FirewallRule
  - code: RequiredPropertiesMissingInResourceModel
    from: FirewallRules.json
    where: $.definitions.FirewallRuleListResult
  - code: RequiredReadOnlySystemData
    from: ManagedInstanceOperations.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/operations/{operationId}"].get
  - code: XmsIdentifierValidation
    from: JobTargetGroups.json
    where: $.definitions.JobTargetGroupProperties.properties.members
  - code: TrackedResourcePatchOperation
    from: ServerKeys.json
    where: $.definitions.ServerKey
  - code: RequiredReadOnlySystemData
    from: JobStepExecutions.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/jobAgents/{jobAgentName}/jobs/{jobName}/executions/{jobExecutionId}/steps/{stepName}"].get
  - code: UniqueXmsExample
    from: SqlVulnerabilityAssessmentBaseline.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/sqlVulnerabilityAssessments/{vulnerabilityAssessmentName}/baselines/{baselineName}"].get["x-ms-examples"]
  - code: RequiredReadOnlySystemData
    from: InstancePools.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/instancePools/{instancePoolName}"].get
  - code: RequiredReadOnlySystemData
    from: InstancePools.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/instancePools/{instancePoolName}"].put
  - code: RequiredReadOnlySystemData
    from: InstancePools.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/instancePools/{instancePoolName}"].patch
  - code: RequiredReadOnlySystemData
    from: DatabaseExtensions.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/extensions/{extensionName}"].put
  - code: XmsIdentifierValidation
    from: SqlVulnerabilityAssessmentScans.json
    where: $.definitions.SqlVulnerabilityAssessmentScanRecordProperties.properties.errors
  - code: XmsEnumValidation
    from: ServerTrustGroups.json
    where: $.definitions.ServerTrustGroupProperties.properties.trustScopes.items
  - code: XmsEnumValidation
    from: ManagedInstanceOperations.json
    where: $.definitions.UpsertManagedServerOperationStepWithEstimatesAndDuration.properties.status
  - code: AllResourcesMustHaveGetOperation
    from: DatabaseExtensions.json
    where: $.definitions.ImportExportExtensionsOperationResult
  - code: NestedResourcesMustHaveListOperation
    from: DatabaseExtensions.json
    where: $.definitions.ImportExportExtensionsOperationResult
  - code: XmsIdentifierValidation
    from: ServerTrustGroups.json
    where: $.definitions.ServerTrustGroupProperties.properties.groupMembers
  - code: XmsIdentifierValidation
    from: ManagedInstanceOperations.json
    where: $.definitions.ManagedInstanceOperationSteps.properties.stepsList
  - code: PostOperationIdContainsUrlVerb
    from: VirtualClusters.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/virtualClusters/{virtualClusterName}/updateManagedInstanceDnsServers"].post.operationId
  - code: RequiredReadOnlySystemData
    from: DatabaseVulnerabilityAssessmentScans.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/vulnerabilityAssessments/{vulnerabilityAssessmentName}/scans/{scanId}"].get
  - code: RequiredReadOnlySystemData
    from: JobAgents.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/jobAgents/{jobAgentName}"].get
  - code: RequiredReadOnlySystemData
    from: JobAgents.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/jobAgents/{jobAgentName}"].put
  - code: RequiredReadOnlySystemData
    from: JobAgents.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/jobAgents/{jobAgentName}"].patch
  - code: AllProxyResourcesShouldHaveDelete
    from: SqlVulnerabilityAssessmentBaseline.json
    where: $.definitions.DatabaseSqlVulnerabilityAssessmentBaselineSet
  - code: AllProxyResourcesShouldHaveDelete
    from: DatabaseExtensions.json
    where: $.definitions.ImportExportExtensionsOperationResult
  - code: RequiredReadOnlySystemData
    from: ManagedDatabaseVulnerabilityAssessmentScans.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/databases/{databaseName}/vulnerabilityAssessments/{vulnerabilityAssessmentName}/scans/{scanId}"].get
  - code: RequiredReadOnlySystemData
    from: VirtualClusters.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/virtualClusters/{virtualClusterName}"].get
  - code: RequiredReadOnlySystemData
    from: VirtualClusters.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/virtualClusters/{virtualClusterName}"].put
  - code: RequiredReadOnlySystemData
    from: VirtualClusters.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/virtualClusters/{virtualClusterName}"].patch
  - code: RequiredReadOnlySystemData
    from: TransparentDataEncryptions.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/transparentDataEncryption/{tdeName}"].get
  - code: RequiredReadOnlySystemData
    from: TransparentDataEncryptions.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/transparentDataEncryption/{tdeName}"].put
  - code: XmsIdentifierValidation
    from: DatabaseVulnerabilityAssessmentScans.json
    where: $.definitions.VulnerabilityAssessmentScanRecordProperties.properties.errors
  - code: XmsIdentifierValidation
    from: ManagedDatabaseVulnerabilityAssessmentScans.json
    where: $.definitions.VulnerabilityAssessmentScanRecordProperties.properties.errors
  - code: UniqueXmsExample
    from: SqlVulnerabilityAssessmentRuleBaseline.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/sqlVulnerabilityAssessments/{vulnerabilityAssessmentName}/baselines/{baselineName}/rules/{ruleId}"].get["x-ms-examples"]
  - code: AllProxyResourcesShouldHaveDelete
    from: TransparentDataEncryptions.json
    where: $.definitions.LogicalDatabaseTransparentDataEncryption
  - code: XmsIdentifierValidation
    from: DatabaseSqlVulnerabilityAssessmentScanResult.json
    where: $.definitions.VaRule.properties.benchmarkReferences
  - code: RequiredReadOnlySystemData
    from: InstanceFailoverGroups.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/locations/{locationName}/instanceFailoverGroups/{failoverGroupName}"].get
  - code: RequiredReadOnlySystemData
    from: InstanceFailoverGroups.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/locations/{locationName}/instanceFailoverGroups/{failoverGroupName}"].put
  - code: RequiredReadOnlySystemData
    from: JobTargetExecutions.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/jobAgents/{jobAgentName}/jobs/{jobName}/executions/{jobExecutionId}/steps/{stepName}/targets/{targetId}"].get
  - code: RequiredReadOnlySystemData
    from: SyncAgents.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/syncAgents/{syncAgentName}"].get
  - code: RequiredReadOnlySystemData
    from: SyncAgents.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/syncAgents/{syncAgentName}"].put
  - code: UniqueXmsExample
    from: JobTargetExecutions.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/jobAgents/{jobAgentName}/jobs/{jobName}/executions/{jobExecutionId}/targets"].get["x-ms-examples"]
  - code: RequiredReadOnlySystemData
    from: DatabaseRecommendedActions.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/advisors/{advisorName}/recommendedActions/{recommendedActionName}"].get
  - code: RequiredReadOnlySystemData
    from: DatabaseRecommendedActions.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/advisors/{advisorName}/recommendedActions/{recommendedActionName}"].patch
  - code: NestedResourcesMustHaveListOperation
    from: DatabaseRecommendedActions.json
    where: $.definitions.RecommendedAction
  - code: PostOperationIdContainsUrlVerb
    from: ReplicationLinks.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/replicationLinks/{linkId}/forceFailoverAllowDataLoss"].post.operationId
  - code: XmsIdentifierValidation
    from: SqlVulnerabilityAssessmentScanResult.json
    where: $.definitions.VaRule.properties.benchmarkReferences
  - code: XmsIdentifierValidation
    from: InstanceFailoverGroups.json
    where: $.definitions.InstanceFailoverGroupProperties.properties.partnerRegions
  - code: XmsIdentifierValidation
    from: InstanceFailoverGroups.json
    where: $.definitions.InstanceFailoverGroupProperties.properties.managedInstancePairs
  - code: XmsIdentifierValidation
    from: DatabaseRecommendedActions.json
    where: $.definitions.RecommendedActionProperties.properties.estimatedImpact
  - code: XmsIdentifierValidation
    from: DatabaseRecommendedActions.json
    where: $.definitions.RecommendedActionProperties.properties.observedImpact
  - code: XmsIdentifierValidation
    from: DatabaseRecommendedActions.json
    where: $.definitions.RecommendedActionProperties.properties.timeSeries
  - code: AllTrackedResourcesMustHaveDelete
    from: DatabaseRecommendedActions.json
    where: $.definitions.RecommendedAction
  - code: ArmResourcePropertiesBag
    from: SyncAgents.json
    where: $.definitions.SyncAgent
  - code: RequiredReadOnlySystemData
    from: JobSteps.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/jobAgents/{jobAgentName}/jobs/{jobName}/steps/{stepName}"].get
  - code: RequiredReadOnlySystemData
    from: JobSteps.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/jobAgents/{jobAgentName}/jobs/{jobName}/versions/{jobVersion}/steps/{stepName}"].get
  - code: RequiredReadOnlySystemData
    from: JobSteps.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/jobAgents/{jobAgentName}/jobs/{jobName}/steps/{stepName}"].put
  - code: TrackedResourceBeyondsThirdLevel
    from: DatabaseRecommendedActions.json
    where: $.definitions.RecommendedAction
  - code: TrackedResourcesMustHavePut
    from: DatabaseRecommendedActions.json
    where: $.definitions.RecommendedAction
  - code: PostOperationIdContainsUrlVerb
    from: JobExecutions.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/jobAgents/{jobAgentName}/jobs/{jobName}/start"].post.operationId
  - code: RequiredReadOnlySystemData
    from: ReplicationLinks.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/replicationLinks/{linkId}"].get
  - code: RequiredReadOnlySystemData
    from: ReplicationLinks.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/replicationLinks/{linkId}"].put
  - code: RequiredReadOnlySystemData
    from: ReplicationLinks.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/replicationLinks/{linkId}"].patch
  - code: RequiredReadOnlySystemData
    from: DatabaseAdvisors.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/advisors/{advisorName}"].get
  - code: RequiredReadOnlySystemData
    from: DatabaseAdvisors.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/advisors/{advisorName}"].patch
  - code: RequiredReadOnlySystemData
    from: ElasticPools.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/elasticPools/{elasticPoolName}"].get
  - code: RequiredReadOnlySystemData
    from: ElasticPools.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/elasticPools/{elasticPoolName}"].put
  - code: RequiredReadOnlySystemData
    from: ElasticPools.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/elasticPools/{elasticPoolName}"].patch
  - code: NestedResourcesMustHaveListOperation
    from: DatabaseAdvisors.json
    where: $.definitions.Advisor
  - code: RequiredReadOnlySystemData
    from: JobExecutions.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/jobAgents/{jobAgentName}/jobs/{jobName}/executions/{jobExecutionId}"].get
  - code: RequiredReadOnlySystemData
    from: ServerAdvisors.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/advisors/{advisorName}"].get
  - code: RequiredReadOnlySystemData
    from: JobExecutions.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/jobAgents/{jobAgentName}/jobs/{jobName}/executions/{jobExecutionId}"].put
  - code: RequiredReadOnlySystemData
    from: ServerAdvisors.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/advisors/{advisorName}"].patch
  - code: NestedResourcesMustHaveListOperation
    from: ServerAdvisors.json
    where: $.definitions.Advisor
  - code: XmsIdentifierValidation
    from: DatabaseAdvisors.json
    where: $.definitions.RecommendedActionProperties.properties.estimatedImpact
  - code: XmsIdentifierValidation
    from: DatabaseAdvisors.json
    where: $.definitions.RecommendedActionProperties.properties.observedImpact
  - code: XmsIdentifierValidation
    from: DatabaseAdvisors.json
    where: $.definitions.RecommendedActionProperties.properties.timeSeries
  - code: AllTrackedResourcesMustHaveDelete
    from: DatabaseAdvisors.json
    where: $.definitions.Advisor
  - code: TrackedResourcesMustHavePut
    from: DatabaseAdvisors.json
    where: $.definitions.Advisor
  - code: PostOperationIdContainsUrlVerb
    from: SyncMembers.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/syncGroups/{syncGroupName}/syncMembers/{syncMemberName}/refreshSchema"].post.operationId
  - code: XmsIdentifierValidation
    from: ServerAdvisors.json
    where: $.definitions.RecommendedActionProperties.properties.estimatedImpact
  - code: XmsIdentifierValidation
    from: ServerAdvisors.json
    where: $.definitions.RecommendedActionProperties.properties.observedImpact
  - code: XmsIdentifierValidation
    from: ServerAdvisors.json
    where: $.definitions.RecommendedActionProperties.properties.timeSeries
  - code: AllProxyResourcesShouldHaveDelete
    from: JobExecutions.json
    where: $.definitions.JobExecution
  - code: AllTrackedResourcesMustHaveDelete
    from: ServerAdvisors.json
    where: $.definitions.Advisor
  - code: TrackedResourcesMustHavePut
    from: ServerAdvisors.json
    where: $.definitions.Advisor
  - code: RequiredReadOnlySystemData
    from: FailoverGroups.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/failoverGroups/{failoverGroupName}"].get
  - code: RequiredReadOnlySystemData
    from: FailoverGroups.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/failoverGroups/{failoverGroupName}"].put
  - code: RequiredReadOnlySystemData
    from: FailoverGroups.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/failoverGroups/{failoverGroupName}"].patch
  - code: RequiredReadOnlySystemData
    from: SyncMembers.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/syncGroups/{syncGroupName}/syncMembers/{syncMemberName}"].get
  - code: RequiredReadOnlySystemData
    from: SyncMembers.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/syncGroups/{syncGroupName}/syncMembers/{syncMemberName}"].put
  - code: RequiredReadOnlySystemData
    from: SyncMembers.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/syncGroups/{syncGroupName}/syncMembers/{syncMemberName}"].patch
  - code: RequiredReadOnlySystemData
    from: DistributedAvailabilityGroups.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/distributedAvailabilityGroups/{distributedAvailabilityGroupName}"].get
  - code: RequiredReadOnlySystemData
    from: DistributedAvailabilityGroups.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/distributedAvailabilityGroups/{distributedAvailabilityGroupName}"].put
  - code: RequiredReadOnlySystemData
    from: DistributedAvailabilityGroups.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/distributedAvailabilityGroups/{distributedAvailabilityGroupName}"].patch
  - code: XmsIdentifierValidation
    from: SyncMembers.json
    where: $.definitions.SyncFullSchemaProperties.properties.tables
  - code: XmsIdentifierValidation
    from: SyncMembers.json
    where: $.definitions.SyncFullSchemaPropertiesListResult.properties.value
  - code: XmsIdentifierValidation
    from: SyncMembers.json
    where: $.definitions.SyncFullSchemaTable.properties.columns
  - code: RequiredPropertiesMissingInResourceModel
    from: SyncMembers.json
    where: $.definitions.SyncFullSchemaPropertiesListResult
  - code: XmsIdentifierValidation
    from: DistributedAvailabilityGroups.json
    where: $.definitions.DistributedAvailabilityGroupProperties.properties.databases
  - code: RequiredReadOnlySystemData
    from: LongTermRetentionManagedInstanceBackups.json
    where: $.paths["/subscriptions/{subscriptionId}/providers/Microsoft.Sql/locations/{locationName}/longTermRetentionManagedInstances/{managedInstanceName}/longTermRetentionDatabases/{databaseName}/longTermRetentionManagedInstanceBackups/{backupName}"].get
  - code: RequiredReadOnlySystemData
    from: LongTermRetentionManagedInstanceBackups.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/locations/{locationName}/longTermRetentionManagedInstances/{managedInstanceName}/longTermRetentionDatabases/{databaseName}/longTermRetentionManagedInstanceBackups/{backupName}"].get
  - code: DeleteOperationResponses
    from: SensitivityLabels.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/schemas/{schemaName}/tables/{tableName}/columns/{columnName}/sensitivityLabels/{sensitivityLabelSource}"].delete.responses
  - code: UniqueXmsExample
    from: LongTermRetentionManagedInstanceBackups.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/locations/{locationName}/longTermRetentionManagedInstanceBackups"].get["x-ms-examples"]
  - code: UniqueXmsExample
    from: LongTermRetentionManagedInstanceBackups.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/locations/{locationName}/longTermRetentionManagedInstances/{managedInstanceName}/longTermRetentionDatabases/{databaseName}/longTermRetentionManagedInstanceBackups"].get["x-ms-examples"]
  - code: RequiredReadOnlySystemData
    from: SensitivityLabels.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/schemas/{schemaName}/tables/{tableName}/columns/{columnName}/sensitivityLabels/{sensitivityLabelSource}"].get
  - code: UniqueXmsExample
    from: LongTermRetentionManagedInstanceBackups.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/locations/{locationName}/longTermRetentionManagedInstances/{managedInstanceName}/longTermRetentionDatabases/{databaseName}/longTermRetentionManagedInstanceBackups/{backupName}"].delete["x-ms-examples"]
  - code: RequiredReadOnlySystemData
    from: SensitivityLabels.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/schemas/{schemaName}/tables/{tableName}/columns/{columnName}/sensitivityLabels/{sensitivityLabelSource}"].put
  - code: UniqueXmsExample
    from: LongTermRetentionManagedInstanceBackups.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/locations/{locationName}/longTermRetentionManagedInstances/{managedInstanceName}/longTermRetentionManagedInstanceBackups"].get["x-ms-examples"]
  - code: RequiredReadOnlySystemData
    from: ManagedDatabases.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/databases/{databaseName}"].get
  - code: RequiredReadOnlySystemData
    from: ManagedDatabases.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/databases/{databaseName}"].put
  - code: RequiredReadOnlySystemData
    from: ManagedDatabases.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/databases/{databaseName}"].patch
  - code: DeleteOperationResponses
    from: ManagedDatabaseSensitivityLabels.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/databases/{databaseName}/schemas/{schemaName}/tables/{tableName}/columns/{columnName}/sensitivityLabels/{sensitivityLabelSource}"].delete.responses
  - code: RequiredReadOnlySystemData
    from: ManagedDatabaseSensitivityLabels.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/databases/{databaseName}/schemas/{schemaName}/tables/{tableName}/columns/{columnName}/sensitivityLabels/{sensitivityLabelSource}"].get
  - code: RequiredReadOnlySystemData
    from: ManagedDatabaseSensitivityLabels.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/databases/{databaseName}/schemas/{schemaName}/tables/{tableName}/columns/{columnName}/sensitivityLabels/{sensitivityLabelSource}"].put
  - code: RequiredReadOnlySystemData
    from: BlobAuditing.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/auditingSettings/{blobAuditingPolicyName}"].get
  - code: RequiredReadOnlySystemData
    from: BlobAuditing.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/auditingSettings/{blobAuditingPolicyName}"].get
  - code: RequiredReadOnlySystemData
    from: BlobAuditing.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/extendedAuditingSettings/{blobAuditingPolicyName}"].get
  - code: RequiredReadOnlySystemData
    from: BlobAuditing.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/extendedAuditingSettings/{blobAuditingPolicyName}"].get
  - code: RequiredReadOnlySystemData
    from: BlobAuditing.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/auditingSettings/{blobAuditingPolicyName}"].put
  - code: RequiredReadOnlySystemData
    from: BlobAuditing.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/auditingSettings/{blobAuditingPolicyName}"].put
  - code: RequiredReadOnlySystemData
    from: BlobAuditing.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/extendedAuditingSettings/{blobAuditingPolicyName}"].put
  - code: RequiredReadOnlySystemData
    from: BlobAuditing.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/extendedAuditingSettings/{blobAuditingPolicyName}"].put
  - code: RequiredReadOnlySystemData
    from: SyncGroups.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/syncGroups/{syncGroupName}"].get
  - code: RequiredReadOnlySystemData
    from: SyncGroups.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/syncGroups/{syncGroupName}"].put
  - code: RequiredReadOnlySystemData
    from: SyncGroups.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/syncGroups/{syncGroupName}"].patch
  - code: UniqueXmsExample
    from: SyncGroups.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/syncGroups/{syncGroupName}"].patch["x-ms-examples"]
  - code: AllProxyResourcesShouldHaveDelete
    from: BlobAuditing.json
    where: $.definitions.ServerBlobAuditingPolicy
  - code: AllProxyResourcesShouldHaveDelete
    from: BlobAuditing.json
    where: $.definitions.DatabaseBlobAuditingPolicy
  - code: AllProxyResourcesShouldHaveDelete
    from: BlobAuditing.json
    where: $.definitions.ExtendedDatabaseBlobAuditingPolicy
  - code: AllProxyResourcesShouldHaveDelete
    from: BlobAuditing.json
    where: $.definitions.ExtendedServerBlobAuditingPolicy
  - code: PostOperationIdContainsUrlVerb
    from: Servers.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/refreshExternalGovernanceStatus"].post.operationId
  - code: XmsIdentifierValidation
    from: SyncGroups.json
    where: $.definitions.SyncFullSchemaProperties.properties.tables
  - code: XmsIdentifierValidation
    from: SyncGroups.json
    where: $.definitions.SyncFullSchemaPropertiesListResult.properties.value
  - code: XmsIdentifierValidation
    from: SyncGroups.json
    where: $.definitions.SyncFullSchemaTable.properties.columns
  - code: XmsIdentifierValidation
    from: SyncGroups.json
    where: $.definitions.SyncGroupLogListResult.properties.value
  - code: XmsIdentifierValidation
    from: SyncGroups.json
    where: $.definitions.SyncGroupSchema.properties.tables
  - code: XmsIdentifierValidation
    from: SyncGroups.json
    where: $.definitions.SyncGroupSchemaTable.properties.columns
  - code: RequiredPropertiesMissingInResourceModel
    from: SyncGroups.json
    where: $.definitions.SyncDatabaseIdListResult
  - code: RequiredPropertiesMissingInResourceModel
    from: SyncGroups.json
    where: $.definitions.SyncFullSchemaPropertiesListResult
  - code: RequiredPropertiesMissingInResourceModel
    from: SyncGroups.json
    where: $.definitions.SyncGroupLogListResult
  - code: RequiredReadOnlySystemData
    from: Servers.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}"].get
  - code: RequiredReadOnlySystemData
    from: Servers.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}"].put
  - code: RequiredReadOnlySystemData
    from: Servers.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}"].patch
  - code: XmsIdentifierValidation
    from: Servers.json
    where: $.definitions.ImportExportOperationResultProperties.properties.privateEndpointConnections
  - code: PostOperationIdContainsUrlVerb
    from: ManagedInstances.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/refreshExternalGovernanceStatus"].post.operationId
  - code: RequiredReadOnlySystemData
    from: ManagedInstances.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}"].get
  - code: RequiredReadOnlySystemData
    from: ManagedInstances.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}"].put
  - code: RequiredReadOnlySystemData
    from: ManagedInstances.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}"].patch
  - code: XmsEnumValidation
    from: LocationCapabilities.json
    where: $.definitions.StorageCapability.properties.storageAccountType
  - code: XmsIdentifierValidation
    from: LocationCapabilities.json
    where: $.definitions.EditionCapability.properties.supportedStorageCapabilities
  - code: XmsIdentifierValidation
    from: LocationCapabilities.json
    where: $.definitions.ElasticPoolEditionCapability.properties.supportedElasticPoolPerformanceLevels
  - code: XmsIdentifierValidation
    from: LocationCapabilities.json
    where: $.definitions.ElasticPoolPerDatabaseMaxPerformanceLevelCapability.properties.supportedPerDatabaseMinPerformanceLevels
  - code: XmsIdentifierValidation
    from: LocationCapabilities.json
    where: $.definitions.ElasticPoolPerformanceLevelCapability.properties.supportedLicenseTypes
  - code: XmsIdentifierValidation
    from: LocationCapabilities.json
    where: $.definitions.ElasticPoolPerformanceLevelCapability.properties.supportedMaxSizes
  - code: XmsIdentifierValidation
    from: LocationCapabilities.json
    where: $.definitions.ElasticPoolPerformanceLevelCapability.properties.supportedPerDatabaseMaxSizes
  - code: XmsIdentifierValidation
    from: LocationCapabilities.json
    where: $.definitions.ElasticPoolPerformanceLevelCapability.properties.supportedPerDatabaseMaxPerformanceLevels
  - code: XmsIdentifierValidation
    from: LocationCapabilities.json
    where: $.definitions.ElasticPoolPerformanceLevelCapability.properties.supportedMaintenanceConfigurations
  - code: XmsIdentifierValidation
    from: LocationCapabilities.json
    where: $.definitions.ElasticPoolPerformanceLevelCapability.properties.supportedZones
  - code: XmsIdentifierValidation
    from: LocationCapabilities.json
    where: $.definitions.InstancePoolEditionCapability.properties.supportedFamilies
  - code: XmsIdentifierValidation
    from: LocationCapabilities.json
    where: $.definitions.InstancePoolFamilyCapability.properties.supportedLicenseTypes
  - code: XmsIdentifierValidation
    from: LocationCapabilities.json
    where: $.definitions.InstancePoolFamilyCapability.properties.supportedVcoresValues
  - code: XmsIdentifierValidation
    from: LocationCapabilities.json
    where: $.definitions.LocationCapabilities.properties.supportedServerVersions
  - code: XmsIdentifierValidation
    from: LocationCapabilities.json
    where: $.definitions.LocationCapabilities.properties.supportedManagedInstanceVersions
  - code: XmsIdentifierValidation
    from: LocationCapabilities.json
    where: $.definitions.ManagedInstanceEditionCapability.properties.supportedFamilies
  - code: XmsIdentifierValidation
    from: LocationCapabilities.json
    where: $.definitions.ManagedInstanceEditionCapability.properties.supportedStorageCapabilities
  - code: XmsIdentifierValidation
    from: LocationCapabilities.json
    where: $.definitions.ManagedInstanceFamilyCapability.properties.supportedLicenseTypes
  - code: XmsIdentifierValidation
    from: LocationCapabilities.json
    where: $.definitions.ManagedInstanceFamilyCapability.properties.supportedVcoresValues
  - code: XmsIdentifierValidation
    from: LocationCapabilities.json
    where: $.definitions.ManagedInstanceVcoresCapability.properties.supportedStorageSizes
  - code: XmsIdentifierValidation
    from: LocationCapabilities.json
    where: $.definitions.ManagedInstanceVcoresCapability.properties.supportedMaintenanceConfigurations
  - code: XmsIdentifierValidation
    from: LocationCapabilities.json
    where: $.definitions.ManagedInstanceVersionCapability.properties.supportedEditions
  - code: XmsIdentifierValidation
    from: LocationCapabilities.json
    where: $.definitions.ManagedInstanceVersionCapability.properties.supportedInstancePoolEditions
  - code: XmsIdentifierValidation
    from: LocationCapabilities.json
    where: $.definitions.ServerVersionCapability.properties.supportedEditions
  - code: XmsIdentifierValidation
    from: LocationCapabilities.json
    where: $.definitions.ServerVersionCapability.properties.supportedElasticPoolEditions
  - code: XmsIdentifierValidation
    from: LocationCapabilities.json
    where: $.definitions.ServiceObjectiveCapability.properties.supportedMaxSizes
  - code: XmsIdentifierValidation
    from: LocationCapabilities.json
    where: $.definitions.ServiceObjectiveCapability.properties.supportedLicenseTypes
  - code: XmsIdentifierValidation
    from: LocationCapabilities.json
    where: $.definitions.ServiceObjectiveCapability.properties.supportedMinCapacities
  - code: XmsIdentifierValidation
    from: LocationCapabilities.json
    where: $.definitions.ServiceObjectiveCapability.properties.supportedMaintenanceConfigurations
  - code: XmsIdentifierValidation
    from: LocationCapabilities.json
    where: $.definitions.ServiceObjectiveCapability.properties.supportedZones
  - code: RequiredPropertiesMissingInResourceModel
    from: LocationCapabilities.json
    where: $.definitions.LocationCapabilities
  - code: PostOperationIdContainsUrlVerb
    from: Databases.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/move"].post.operationId
  - code: XmsIdentifierValidation
    from: ManagedInstances.json
    where: $.definitions.OutboundEnvironmentEndpointCollection.properties.value
  - code: XmsIdentifierValidation
    from: ManagedInstances.json
    where: $.definitions.TopQueriesListResult.properties.value
  - code: RequiredPropertiesMissingInResourceModel
    from: ManagedInstances.json
    where: $.definitions.OutboundEnvironmentEndpointCollection
  - code: RequiredPropertiesMissingInResourceModel
    from: ManagedInstances.json
    where: $.definitions.TopQueriesListResult
  - code: RequiredReadOnlySystemData
    from: LongTermRetentionBackups.json
    where: $.paths["/subscriptions/{subscriptionId}/providers/Microsoft.Sql/locations/{locationName}/longTermRetentionServers/{longTermRetentionServerName}/longTermRetentionDatabases/{longTermRetentionDatabaseName}/longTermRetentionBackups/{backupName}"].get
  - code: RequiredReadOnlySystemData
    from: LongTermRetentionBackups.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/locations/{locationName}/longTermRetentionServers/{longTermRetentionServerName}/longTermRetentionDatabases/{longTermRetentionDatabaseName}/longTermRetentionBackups/{backupName}"].get
  - code: UniqueXmsExample
    from: LongTermRetentionBackups.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/locations/{locationName}/longTermRetentionServers/{longTermRetentionServerName}/longTermRetentionDatabases/{longTermRetentionDatabaseName}/longTermRetentionBackups"].get["x-ms-examples"]
  - code: UniqueXmsExample
    from: LongTermRetentionBackups.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/locations/{locationName}/longTermRetentionServers/{longTermRetentionServerName}/longTermRetentionDatabases/{longTermRetentionDatabaseName}/longTermRetentionBackups/{backupName}"].get["x-ms-examples"]
  - code: UniqueXmsExample
    from: LongTermRetentionBackups.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/locations/{locationName}/longTermRetentionServers/{longTermRetentionServerName}/longTermRetentionDatabases/{longTermRetentionDatabaseName}/longTermRetentionBackups/{backupName}"].delete["x-ms-examples"]
  - code: UniqueXmsExample
    from: LongTermRetentionBackups.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/locations/{locationName}/longTermRetentionServers/{longTermRetentionServerName}/longTermRetentionDatabases/{longTermRetentionDatabaseName}/longTermRetentionBackups/{backupName}/copy"].post["x-ms-examples"]
  - code: RequiredReadOnlySystemData
    from: Databases.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}"].get
  - code: UniqueXmsExample
    from: LongTermRetentionBackups.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/locations/{locationName}/longTermRetentionServers/{longTermRetentionServerName}/longTermRetentionDatabases/{longTermRetentionDatabaseName}/longTermRetentionBackups/{backupName}/lockTimeBasedImmutability"].post["x-ms-examples"]
  - code: RequiredReadOnlySystemData
    from: Databases.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}"].put
  - code: UniqueXmsExample
    from: LongTermRetentionBackups.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/locations/{locationName}/longTermRetentionServers/{longTermRetentionServerName}/longTermRetentionDatabases/{longTermRetentionDatabaseName}/longTermRetentionBackups/{backupName}/removeLegalHoldImmutability"].post["x-ms-examples"]
  - code: RequiredReadOnlySystemData
    from: Databases.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}"].patch
  - code: UniqueXmsExample
    from: LongTermRetentionBackups.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/locations/{locationName}/longTermRetentionServers/{longTermRetentionServerName}/longTermRetentionDatabases/{longTermRetentionDatabaseName}/longTermRetentionBackups/{backupName}/removeTimeBasedImmutability"].post["x-ms-examples"]
  - code: UniqueXmsExample
    from: LongTermRetentionBackups.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/locations/{locationName}/longTermRetentionServers/{longTermRetentionServerName}/longTermRetentionDatabases/{longTermRetentionDatabaseName}/longTermRetentionBackups/{backupName}/setLegalHoldImmutability"].post["x-ms-examples"]
  - code: UniqueXmsExample
    from: LongTermRetentionBackups.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/locations/{locationName}/longTermRetentionServers/{longTermRetentionServerName}/longTermRetentionDatabases/{longTermRetentionDatabaseName}/longTermRetentionBackups/{backupName}/update"].post["x-ms-examples"]
  - code: XmsIdentifierValidation
    from: Databases.json
    where: $.definitions.ImportExportOperationResultProperties.properties.privateEndpointConnections
  - code: MissingSegmentsInNestedResourceListOperation
    from: BlobAuditing.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/auditingSettings"]
  - code: ResourceNameRestriction
    from: BlobAuditing.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/auditingSettings"]
  - code: ParameterNotDefinedInGlobalParameters
    from: BlobAuditing.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/auditingSettings"].get.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: BlobAuditing.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/auditingSettings"].get.responses.default.schema["$ref"]
  - code: ResourceNameRestriction
    from: BlobAuditing.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/auditingSettings/{blobAuditingPolicyName}"]
  - code: ParameterNotDefinedInGlobalParameters
    from: BlobAuditing.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/auditingSettings/{blobAuditingPolicyName}"].get.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: BlobAuditing.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/auditingSettings/{blobAuditingPolicyName}"].get.responses.default.schema["$ref"]
  - code: ProvisioningStateSpecifiedForLROPut
    from: BlobAuditing.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/auditingSettings/{blobAuditingPolicyName}"].put
  - code: PutResponseCodes
    from: BlobAuditing.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/auditingSettings/{blobAuditingPolicyName}"].put
  - code: ParameterNotDefinedInGlobalParameters
    from: BlobAuditing.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/auditingSettings/{blobAuditingPolicyName}"].put.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: BlobAuditing.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/auditingSettings/{blobAuditingPolicyName}"].put.responses.default.schema["$ref"]
  - code: MissingSegmentsInNestedResourceListOperation
    from: BlobAuditing.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/auditingSettings"]
  - code: ResourceNameRestriction
    from: BlobAuditing.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/auditingSettings"]
  - code: ParameterNotDefinedInGlobalParameters
    from: BlobAuditing.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/auditingSettings"].get.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: BlobAuditing.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/auditingSettings"].get.responses.default.schema["$ref"]
  - code: ResourceNameRestriction
    from: BlobAuditing.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/auditingSettings/{blobAuditingPolicyName}"]
  - code: ParameterNotDefinedInGlobalParameters
    from: BlobAuditing.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/auditingSettings/{blobAuditingPolicyName}"].get.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: BlobAuditing.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/auditingSettings/{blobAuditingPolicyName}"].get.responses.default.schema["$ref"]
  - code: ParameterNotDefinedInGlobalParameters
    from: BlobAuditing.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/auditingSettings/{blobAuditingPolicyName}"].put.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: BlobAuditing.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/auditingSettings/{blobAuditingPolicyName}"].put.responses.default.schema["$ref"]
  - code: MissingSegmentsInNestedResourceListOperation
    from: BlobAuditing.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/extendedAuditingSettings"]
  - code: ResourceNameRestriction
    from: BlobAuditing.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/extendedAuditingSettings"]
  - code: ParameterNotDefinedInGlobalParameters
    from: BlobAuditing.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/extendedAuditingSettings"].get.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: BlobAuditing.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/extendedAuditingSettings"].get.responses.default.schema["$ref"]
  - code: ResourceNameRestriction
    from: BlobAuditing.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/extendedAuditingSettings/{blobAuditingPolicyName}"]
  - code: ParameterNotDefinedInGlobalParameters
    from: BlobAuditing.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/extendedAuditingSettings/{blobAuditingPolicyName}"].get.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: BlobAuditing.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/extendedAuditingSettings/{blobAuditingPolicyName}"].get.responses.default.schema["$ref"]
  - code: ParameterNotDefinedInGlobalParameters
    from: BlobAuditing.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/extendedAuditingSettings/{blobAuditingPolicyName}"].put.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: BlobAuditing.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/extendedAuditingSettings/{blobAuditingPolicyName}"].put.responses.default.schema["$ref"]
  - code: MissingSegmentsInNestedResourceListOperation
    from: BlobAuditing.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/extendedAuditingSettings"]
  - code: ResourceNameRestriction
    from: BlobAuditing.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/extendedAuditingSettings"]
  - code: ParameterNotDefinedInGlobalParameters
    from: BlobAuditing.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/extendedAuditingSettings"].get.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: BlobAuditing.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/extendedAuditingSettings"].get.responses.default.schema["$ref"]
  - code: ResourceNameRestriction
    from: BlobAuditing.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/extendedAuditingSettings/{blobAuditingPolicyName}"]
  - code: ParameterNotDefinedInGlobalParameters
    from: BlobAuditing.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/extendedAuditingSettings/{blobAuditingPolicyName}"].get.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: BlobAuditing.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/extendedAuditingSettings/{blobAuditingPolicyName}"].get.responses.default.schema["$ref"]
  - code: ProvisioningStateSpecifiedForLROPut
    from: BlobAuditing.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/extendedAuditingSettings/{blobAuditingPolicyName}"].put
  - code: PutResponseCodes
    from: BlobAuditing.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/extendedAuditingSettings/{blobAuditingPolicyName}"].put
  - code: ParameterNotDefinedInGlobalParameters
    from: BlobAuditing.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/extendedAuditingSettings/{blobAuditingPolicyName}"].put.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: BlobAuditing.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/extendedAuditingSettings/{blobAuditingPolicyName}"].put.responses.default.schema["$ref"]
  - code: MissingSegmentsInNestedResourceListOperation
    from: DatabaseAdvancedThreatProtectionSettings.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/advancedThreatProtectionSettings"]
  - code: ResourceNameRestriction
    from: DatabaseAdvancedThreatProtectionSettings.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/advancedThreatProtectionSettings"]
  - code: ParameterNotDefinedInGlobalParameters
    from: DatabaseAdvancedThreatProtectionSettings.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/advancedThreatProtectionSettings"].get.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: DatabaseAdvancedThreatProtectionSettings.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/advancedThreatProtectionSettings"].get.responses.default.schema["$ref"]
  - code: ResourceNameRestriction
    from: DatabaseAdvancedThreatProtectionSettings.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/advancedThreatProtectionSettings/{advancedThreatProtectionName}"]
  - code: ParameterNotDefinedInGlobalParameters
    from: DatabaseAdvancedThreatProtectionSettings.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/advancedThreatProtectionSettings/{advancedThreatProtectionName}"].get.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: DatabaseAdvancedThreatProtectionSettings.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/advancedThreatProtectionSettings/{advancedThreatProtectionName}"].get.responses.default.schema["$ref"]
  - code: ParameterNotDefinedInGlobalParameters
    from: DatabaseAdvancedThreatProtectionSettings.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/advancedThreatProtectionSettings/{advancedThreatProtectionName}"].put.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: DatabaseAdvancedThreatProtectionSettings.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/advancedThreatProtectionSettings/{advancedThreatProtectionName}"].put.responses.default.schema["$ref"]
  - code: SystemDataDefinitionsCommonTypes
    from: DatabaseAdvancedThreatProtectionSettings.json
    where: $.definitions.DatabaseAdvancedThreatProtection.properties.systemData["$ref"]
  - code: PatchBodyParametersSchema
    from: DatabaseAdvisors.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/advisors/{advisorName}"].patch.parameters["4"].schema.properties.properties
  - code: MissingSegmentsInNestedResourceListOperation
    from: DatabaseAdvisors.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/advisors"]
  - code: ResourceNameRestriction
    from: DatabaseAdvisors.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/advisors"]
  - code: XmsPageableForListCalls
    from: DatabaseAdvisors.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/advisors"].get
  - code: ParameterNotDefinedInGlobalParameters
    from: DatabaseAdvisors.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/advisors"].get.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: DatabaseAdvisors.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/advisors"].get.responses.default.schema["$ref"]
  - code: ResourceNameRestriction
    from: DatabaseAdvisors.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/advisors/{advisorName}"]
  - code: ParameterNotDefinedInGlobalParameters
    from: DatabaseAdvisors.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/advisors/{advisorName}"].get.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: DatabaseAdvisors.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/advisors/{advisorName}"].get.responses.default.schema["$ref"]
  - code: ParameterNotDefinedInGlobalParameters
    from: DatabaseAdvisors.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/advisors/{advisorName}"].patch.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: DatabaseAdvisors.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/advisors/{advisorName}"].patch.responses.default.schema["$ref"]
  - code: LocationMustHaveXmsMutability
    from: DatabaseAdvisors.json
    where: $.definitions.Advisor.properties.location
  - code: LocationMustHaveXmsMutability
    from: DatabaseAdvisors.json
    where: $.definitions.RecommendedAction.properties.location
  - code: AvoidAdditionalProperties
    from: DatabaseAdvisors.json
    where: $.definitions.RecommendedActionProperties.properties.details
  - code: MissingSegmentsInNestedResourceListOperation
    from: DatabaseAutomaticTuning.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/automaticTuning/current"]
  - code: PathForNestedResource
    from: DatabaseAutomaticTuning.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/automaticTuning/current"]
  - code: ResourceNameRestriction
    from: DatabaseAutomaticTuning.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/automaticTuning/current"]
  - code: OperationIdNounConflictingModelNames
    from: DatabaseAutomaticTuning.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/automaticTuning/current"].get.operationId
  - code: ParameterNotDefinedInGlobalParameters
    from: DatabaseAutomaticTuning.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/automaticTuning/current"].get.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: DatabaseAutomaticTuning.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/automaticTuning/current"].get.responses.default.schema["$ref"]
  - code: OperationIdNounConflictingModelNames
    from: DatabaseAutomaticTuning.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/automaticTuning/current"].patch.operationId
  - code: ParameterNotDefinedInGlobalParameters
    from: DatabaseAutomaticTuning.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/automaticTuning/current"].patch.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: DatabaseAutomaticTuning.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/automaticTuning/current"].patch.responses.default.schema["$ref"]
  - code: AvoidAdditionalProperties
    from: DatabaseAutomaticTuning.json
    where: $.definitions.DatabaseAutomaticTuningProperties.properties.options
  - code: MissingSegmentsInNestedResourceListOperation
    from: DatabaseColumns.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/columns"]
  - code: ResourceNameRestriction
    from: DatabaseColumns.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/columns"]
  - code: ParameterNotDefinedInGlobalParameters
    from: DatabaseColumns.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/columns"].get.parameters
  - code: ParameterDescription
    from: DatabaseColumns.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/columns"].get.parameters["3"]
  - code: ParameterDescription
    from: DatabaseColumns.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/columns"].get.parameters["4"]
  - code: ParameterDescription
    from: DatabaseColumns.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/columns"].get.parameters["5"]
  - code: ParameterDescription
    from: DatabaseColumns.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/columns"].get.parameters["6"]
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: DatabaseColumns.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/columns"].get.responses.default.schema["$ref"]
  - code: MissingSegmentsInNestedResourceListOperation
    from: DatabaseColumns.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/schemas/{schemaName}/tables/{tableName}/columns"]
  - code: ResourceNameRestriction
    from: DatabaseColumns.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/schemas/{schemaName}/tables/{tableName}/columns"]
  - code: ParameterNotDefinedInGlobalParameters
    from: DatabaseColumns.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/schemas/{schemaName}/tables/{tableName}/columns"].get.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: DatabaseColumns.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/schemas/{schemaName}/tables/{tableName}/columns"].get.responses.default.schema["$ref"]
  - code: ResourceNameRestriction
    from: DatabaseColumns.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/schemas/{schemaName}/tables/{tableName}/columns/{columnName}"]
  - code: ParameterNotDefinedInGlobalParameters
    from: DatabaseColumns.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/schemas/{schemaName}/tables/{tableName}/columns/{columnName}"].get.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: DatabaseColumns.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/schemas/{schemaName}/tables/{tableName}/columns/{columnName}"].get.responses.default.schema["$ref"]
  - code: ResourceNameRestriction
    from: DatabaseEncryptionProtectorRevalidate.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/encryptionProtector/{encryptionProtectorName}/revalidate"]
  - code: PostResponseCodes
    from: DatabaseEncryptionProtectorRevalidate.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/encryptionProtector/{encryptionProtectorName}/revalidate"].post
  - code: ParameterNotDefinedInGlobalParameters
    from: DatabaseEncryptionProtectorRevalidate.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/encryptionProtector/{encryptionProtectorName}/revalidate"].post.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: DatabaseEncryptionProtectorRevalidate.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/encryptionProtector/{encryptionProtectorName}/revalidate"].post.responses.default.schema["$ref"]
  - code: ResourceNameRestriction
    from: DatabaseEncryptionProtectorRevert.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/encryptionProtector/{encryptionProtectorName}/revert"]
  - code: PostResponseCodes
    from: DatabaseEncryptionProtectorRevert.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/encryptionProtector/{encryptionProtectorName}/revert"].post
  - code: ParameterNotDefinedInGlobalParameters
    from: DatabaseEncryptionProtectorRevert.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/encryptionProtector/{encryptionProtectorName}/revert"].post.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: DatabaseEncryptionProtectorRevert.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/encryptionProtector/{encryptionProtectorName}/revert"].post.responses.default.schema["$ref"]
  - code: MissingSegmentsInNestedResourceListOperation
    from: DatabaseExtensions.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/extensions"]
  - code: ResourceNameRestriction
    from: DatabaseExtensions.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/extensions"]
  - code: OperationIdNounConflictingModelNames
    from: DatabaseExtensions.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/extensions"].get.operationId
  - code: ParameterNotDefinedInGlobalParameters
    from: DatabaseExtensions.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/extensions"].get.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: DatabaseExtensions.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/extensions"].get.responses.default.schema["$ref"]
  - code: PutGetPatchResponseSchema
    from: DatabaseExtensions.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/extensions/{extensionName}"]
  - code: ResourceNameRestriction
    from: DatabaseExtensions.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/extensions/{extensionName}"]
  - code: OperationIdNounConflictingModelNames
    from: DatabaseExtensions.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/extensions/{extensionName}"].get.operationId
  - code: ParameterNotDefinedInGlobalParameters
    from: DatabaseExtensions.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/extensions/{extensionName}"].get.parameters
  - code: ParameterDescription
    from: DatabaseExtensions.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/extensions/{extensionName}"].get.parameters["3"]
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: DatabaseExtensions.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/extensions/{extensionName}"].get.responses.default.schema["$ref"]
  - code: ProvisioningStateSpecifiedForLROPut
    from: DatabaseExtensions.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/extensions/{extensionName}"].put
  - code: PutRequestResponseSchemeArm
    from: DatabaseExtensions.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/extensions/{extensionName}"].put
  - code: PutResponseCodes
    from: DatabaseExtensions.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/extensions/{extensionName}"].put
  - code: OperationIdNounConflictingModelNames
    from: DatabaseExtensions.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/extensions/{extensionName}"].put.operationId
  - code: ParameterNotDefinedInGlobalParameters
    from: DatabaseExtensions.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/extensions/{extensionName}"].put.parameters
  - code: ParameterDescription
    from: DatabaseExtensions.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/extensions/{extensionName}"].put.parameters["3"]
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: DatabaseExtensions.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/extensions/{extensionName}"].put.responses.default.schema["$ref"]
  - code: MissingSegmentsInNestedResourceListOperation
    from: DatabaseOperations.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/operations"]
  - code: ParameterNotDefinedInGlobalParameters
    from: DatabaseOperations.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/operations"].get.parameters
  - code: ParameterNotUsingCommonTypes
    from: DatabaseOperations.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/operations"].get.parameters["0"].name
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: DatabaseOperations.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/operations"].get.responses.default.schema["$ref"]
  - code: ResourceNameRestriction
    from: DatabaseOperations.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/operations/{operationId}/cancel"]
  - code: ParameterNotDefinedInGlobalParameters
    from: DatabaseOperations.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/operations/{operationId}/cancel"].post.parameters
  - code: ParameterNotUsingCommonTypes
    from: DatabaseOperations.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/operations/{operationId}/cancel"].post.parameters["3"].name
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: DatabaseOperations.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/operations/{operationId}/cancel"].post.responses.default.schema["$ref"]
  - code: AvoidAdditionalProperties
    from: DatabaseOperations.json
    where: $.definitions.PhaseDetails.properties.phaseInformation
  - code: PatchBodyParametersSchema
    from: DatabaseRecommendedActions.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/advisors/{advisorName}/recommendedActions/{recommendedActionName}"].patch.parameters["5"].schema.properties.properties
  - code: MissingSegmentsInNestedResourceListOperation
    from: DatabaseRecommendedActions.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/advisors/{advisorName}/recommendedActions"]
  - code: ResourceNameRestriction
    from: DatabaseRecommendedActions.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/advisors/{advisorName}/recommendedActions"]
  - code: XmsPageableForListCalls
    from: DatabaseRecommendedActions.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/advisors/{advisorName}/recommendedActions"].get
  - code: ParameterNotDefinedInGlobalParameters
    from: DatabaseRecommendedActions.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/advisors/{advisorName}/recommendedActions"].get.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: DatabaseRecommendedActions.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/advisors/{advisorName}/recommendedActions"].get.responses.default.schema["$ref"]
  - code: ResourceNameRestriction
    from: DatabaseRecommendedActions.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/advisors/{advisorName}/recommendedActions/{recommendedActionName}"]
  - code: ParameterNotDefinedInGlobalParameters
    from: DatabaseRecommendedActions.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/advisors/{advisorName}/recommendedActions/{recommendedActionName}"].get.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: DatabaseRecommendedActions.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/advisors/{advisorName}/recommendedActions/{recommendedActionName}"].get.responses.default.schema["$ref"]
  - code: ParameterNotDefinedInGlobalParameters
    from: DatabaseRecommendedActions.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/advisors/{advisorName}/recommendedActions/{recommendedActionName}"].patch.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: DatabaseRecommendedActions.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/advisors/{advisorName}/recommendedActions/{recommendedActionName}"].patch.responses.default.schema["$ref"]
  - code: LocationMustHaveXmsMutability
    from: DatabaseRecommendedActions.json
    where: $.definitions.RecommendedAction.properties.location
  - code: AvoidAdditionalProperties
    from: DatabaseRecommendedActions.json
    where: $.definitions.RecommendedActionProperties.properties.details
  - code: PatchBodyParametersSchema
    from: Databases.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}"].patch.parameters["3"].schema.properties.properties
  - code: PatchBodyParametersSchema
    from: Databases.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}"].patch.parameters["3"].schema.properties.sku
  - code: MissingSegmentsInNestedResourceListOperation
    from: Databases.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases"]
  - code: ResourceNameRestriction
    from: Databases.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases"]
  - code: ParameterNotDefinedInGlobalParameters
    from: Databases.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases"].get.parameters
  - code: ParameterDescription
    from: Databases.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases"].get.parameters["2"]
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: Databases.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases"].get.responses.default.schema["$ref"]
  - code: ResourceNameRestriction
    from: Databases.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}"]
  - code: ParameterNotDefinedInGlobalParameters
    from: Databases.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}"].get.parameters
  - code: ParametersInPointGet
    from: Databases.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}"].get.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: Databases.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}"].get.responses.default.schema["$ref"]
  - code: ProvisioningStateSpecifiedForLROPut
    from: Databases.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}"].put
  - code: PutResponseCodes
    from: Databases.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}"].put
  - code: ParameterNotDefinedInGlobalParameters
    from: Databases.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}"].put.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: Databases.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}"].put.responses.default.schema["$ref"]
  - code: DeleteResponseCodes
    from: Databases.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}"].delete
  - code: ParameterNotDefinedInGlobalParameters
    from: Databases.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}"].delete.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: Databases.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}"].delete.responses.default.schema["$ref"]
  - code: ParameterNotDefinedInGlobalParameters
    from: Databases.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}"].patch.parameters
  - code: ProvisioningStateSpecifiedForLROPatch
    from: Databases.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}"].patch.responses["200"]
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: Databases.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}"].patch.responses.default.schema["$ref"]
  - code: LongRunningOperationsOptionsValidator
    from: Databases.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/export"]
  - code: ResourceNameRestriction
    from: Databases.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/export"]
  - code: ParameterNotDefinedInGlobalParameters
    from: Databases.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/export"].post.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: Databases.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/export"].post.responses.default.schema["$ref"]
  - code: ResourceNameRestriction
    from: Databases.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/failover"]
  - code: PostResponseCodes
    from: Databases.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/failover"].post
  - code: ParameterNotDefinedInGlobalParameters
    from: Databases.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/failover"].post.parameters
  - code: ParametersInPost
    from: Databases.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/failover"].post.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: Databases.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/failover"].post.responses.default.schema["$ref"]
  - code: LongRunningOperationsOptionsValidator
    from: Databases.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/import"]
  - code: ResourceNameRestriction
    from: Databases.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/import"]
  - code: ParameterNotDefinedInGlobalParameters
    from: Databases.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/import"].post.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: Databases.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/import"].post.responses.default.schema["$ref"]
  - code: ResourceNameRestriction
    from: Databases.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/move"]
  - code: ParameterNotDefinedInGlobalParameters
    from: Databases.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/move"].post.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: Databases.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/move"].post.responses.default.schema["$ref"]
  - code: LongRunningOperationsOptionsValidator
    from: Databases.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/pause"]
  - code: ResourceNameRestriction
    from: Databases.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/pause"]
  - code: ParameterNotDefinedInGlobalParameters
    from: Databases.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/pause"].post.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: Databases.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/pause"].post.responses.default.schema["$ref"]
  - code: LongRunningOperationsOptionsValidator
    from: Databases.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/resume"]
  - code: ResourceNameRestriction
    from: Databases.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/resume"]
  - code: ParameterNotDefinedInGlobalParameters
    from: Databases.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/resume"].post.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: Databases.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/resume"].post.responses.default.schema["$ref"]
  - code: ResourceNameRestriction
    from: Databases.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/upgradeDataWarehouse"]
  - code: PostResponseCodes
    from: Databases.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/upgradeDataWarehouse"].post
  - code: ParameterNotDefinedInGlobalParameters
    from: Databases.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/upgradeDataWarehouse"].post.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: Databases.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/upgradeDataWarehouse"].post.responses.default.schema["$ref"]
  - code: MissingSegmentsInNestedResourceListOperation
    from: Databases.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/elasticPools/{elasticPoolName}/databases"]
  - code: ResourceNameRestriction
    from: Databases.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/elasticPools/{elasticPoolName}/databases"]
  - code: ParameterNotDefinedInGlobalParameters
    from: Databases.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/elasticPools/{elasticPoolName}/databases"].get.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: Databases.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/elasticPools/{elasticPoolName}/databases"].get.responses.default.schema["$ref"]
  - code: MissingSegmentsInNestedResourceListOperation
    from: Databases.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/inaccessibleDatabases"]
  - code: ResourceNameRestriction
    from: Databases.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/inaccessibleDatabases"]
  - code: ParameterNotDefinedInGlobalParameters
    from: Databases.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/inaccessibleDatabases"].get.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: Databases.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/inaccessibleDatabases"].get.responses.default.schema["$ref"]
  - code: AvoidAdditionalProperties
    from: Databases.json
    where: $.definitions.DatabaseProperties.properties.keys
  - code: AvoidAdditionalProperties
    from: Databases.json
    where: $.definitions.DatabaseUpdateProperties.properties.keys
  - code: MissingSegmentsInNestedResourceListOperation
    from: DatabaseSchemas.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/schemas"]
  - code: ResourceNameRestriction
    from: DatabaseSchemas.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/schemas"]
  - code: ParameterNotDefinedInGlobalParameters
    from: DatabaseSchemas.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/schemas"].get.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: DatabaseSchemas.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/schemas"].get.responses.default.schema["$ref"]
  - code: ResourceNameRestriction
    from: DatabaseSchemas.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/schemas/{schemaName}"]
  - code: ParameterNotDefinedInGlobalParameters
    from: DatabaseSchemas.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/schemas/{schemaName}"].get.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: DatabaseSchemas.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/schemas/{schemaName}"].get.responses.default.schema["$ref"]
  - code: MissingSegmentsInNestedResourceListOperation
    from: DatabaseSecurityAlertPolicies.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/securityAlertPolicies"]
  - code: ResourceNameRestriction
    from: DatabaseSecurityAlertPolicies.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/securityAlertPolicies"]
  - code: ParameterNotDefinedInGlobalParameters
    from: DatabaseSecurityAlertPolicies.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/securityAlertPolicies"].get.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: DatabaseSecurityAlertPolicies.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/securityAlertPolicies"].get.responses.default.schema["$ref"]
  - code: ResourceNameRestriction
    from: DatabaseSecurityAlertPolicies.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/securityAlertPolicies/{securityAlertPolicyName}"]
  - code: ParameterNotDefinedInGlobalParameters
    from: DatabaseSecurityAlertPolicies.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/securityAlertPolicies/{securityAlertPolicyName}"].get.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: DatabaseSecurityAlertPolicies.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/securityAlertPolicies/{securityAlertPolicyName}"].get.responses.default.schema["$ref"]
  - code: ParameterNotDefinedInGlobalParameters
    from: DatabaseSecurityAlertPolicies.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/securityAlertPolicies/{securityAlertPolicyName}"].put.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: DatabaseSecurityAlertPolicies.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/securityAlertPolicies/{securityAlertPolicyName}"].put.responses.default.schema["$ref"]
  - code: SystemDataDefinitionsCommonTypes
    from: DatabaseSecurityAlertPolicies.json
    where: $.definitions.DatabaseSecurityAlertPolicy.properties.systemData["$ref"]
  - code: MissingSegmentsInNestedResourceListOperation
    from: DatabaseSqlVulnerabilityAssessmentBaselines.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/sqlVulnerabilityAssessments/{vulnerabilityAssessmentName}/baselines"]
  - code: ResourceNameRestriction
    from: DatabaseSqlVulnerabilityAssessmentBaselines.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/sqlVulnerabilityAssessments/{vulnerabilityAssessmentName}/baselines"]
  - code: ParameterNotDefinedInGlobalParameters
    from: DatabaseSqlVulnerabilityAssessmentBaselines.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/sqlVulnerabilityAssessments/{vulnerabilityAssessmentName}/baselines"].get.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: DatabaseSqlVulnerabilityAssessmentBaselines.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/sqlVulnerabilityAssessments/{vulnerabilityAssessmentName}/baselines"].get.responses.default.schema["$ref"]
  - code: ResourceNameRestriction
    from: DatabaseSqlVulnerabilityAssessmentBaselines.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/sqlVulnerabilityAssessments/{vulnerabilityAssessmentName}/baselines/{baselineName}"]
  - code: ParameterNotDefinedInGlobalParameters
    from: DatabaseSqlVulnerabilityAssessmentBaselines.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/sqlVulnerabilityAssessments/{vulnerabilityAssessmentName}/baselines/{baselineName}"].get.parameters
  - code: ParameterDescription
    from: DatabaseSqlVulnerabilityAssessmentBaselines.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/sqlVulnerabilityAssessments/{vulnerabilityAssessmentName}/baselines/{baselineName}"].get.parameters["4"]
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: DatabaseSqlVulnerabilityAssessmentBaselines.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/sqlVulnerabilityAssessments/{vulnerabilityAssessmentName}/baselines/{baselineName}"].get.responses.default.schema["$ref"]
  - code: PutRequestResponseSchemeArm
    from: DatabaseSqlVulnerabilityAssessmentBaselines.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/sqlVulnerabilityAssessments/{vulnerabilityAssessmentName}/baselines/{baselineName}"].put
  - code: PutResponseCodes
    from: DatabaseSqlVulnerabilityAssessmentBaselines.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/sqlVulnerabilityAssessments/{vulnerabilityAssessmentName}/baselines/{baselineName}"].put
  - code: ParameterNotDefinedInGlobalParameters
    from: DatabaseSqlVulnerabilityAssessmentBaselines.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/sqlVulnerabilityAssessments/{vulnerabilityAssessmentName}/baselines/{baselineName}"].put.parameters
  - code: ParameterDescription
    from: DatabaseSqlVulnerabilityAssessmentBaselines.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/sqlVulnerabilityAssessments/{vulnerabilityAssessmentName}/baselines/{baselineName}"].put.parameters["4"]
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: DatabaseSqlVulnerabilityAssessmentBaselines.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/sqlVulnerabilityAssessments/{vulnerabilityAssessmentName}/baselines/{baselineName}"].put.responses.default.schema["$ref"]
  - code: SystemDataDefinitionsCommonTypes
    from: DatabaseSqlVulnerabilityAssessmentBaselines.json
    where: $.definitions.DatabaseSqlVulnerabilityAssessmentBaselineSet.properties.systemData["$ref"]
  - code: AvoidAdditionalProperties
    from: DatabaseSqlVulnerabilityAssessmentBaselines.json
    where: $.definitions.DatabaseSqlVulnerabilityAssessmentBaselineSetProperties.properties.results
  - code: SystemDataDefinitionsCommonTypes
    from: DatabaseSqlVulnerabilityAssessmentBaselines.json
    where: $.definitions.DatabaseSqlVulnerabilityAssessmentRuleBaselineListInput.properties.systemData["$ref"]
  - code: AvoidAdditionalProperties
    from: DatabaseSqlVulnerabilityAssessmentBaselines.json
    where: $.definitions.DatabaseSqlVulnerabilityAssessmentRuleBaselineListInputProperties.properties.results
  - code: ResourceNameRestriction
    from: DatabaseSqlVulnerabilityAssessmentExecuteScan.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/sqlVulnerabilityAssessments/{vulnerabilityAssessmentName}/initiateScan"]
  - code: PostResponseCodes
    from: DatabaseSqlVulnerabilityAssessmentExecuteScan.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/sqlVulnerabilityAssessments/{vulnerabilityAssessmentName}/initiateScan"].post
  - code: ParameterNotDefinedInGlobalParameters
    from: DatabaseSqlVulnerabilityAssessmentExecuteScan.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/sqlVulnerabilityAssessments/{vulnerabilityAssessmentName}/initiateScan"].post.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: DatabaseSqlVulnerabilityAssessmentExecuteScan.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/sqlVulnerabilityAssessments/{vulnerabilityAssessmentName}/initiateScan"].post.responses.default.schema["$ref"]
  - code: MissingSegmentsInNestedResourceListOperation
    from: DatabaseSqlVulnerabilityAssessmentRuleBaselines.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/sqlVulnerabilityAssessments/{vulnerabilityAssessmentName}/baselines/{baselineName}/rules"]
  - code: ResourceNameRestriction
    from: DatabaseSqlVulnerabilityAssessmentRuleBaselines.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/sqlVulnerabilityAssessments/{vulnerabilityAssessmentName}/baselines/{baselineName}/rules"]
  - code: ParameterNotDefinedInGlobalParameters
    from: DatabaseSqlVulnerabilityAssessmentRuleBaselines.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/sqlVulnerabilityAssessments/{vulnerabilityAssessmentName}/baselines/{baselineName}/rules"].get.parameters
  - code: ParameterDescription
    from: DatabaseSqlVulnerabilityAssessmentRuleBaselines.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/sqlVulnerabilityAssessments/{vulnerabilityAssessmentName}/baselines/{baselineName}/rules"].get.parameters["4"]
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: DatabaseSqlVulnerabilityAssessmentRuleBaselines.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/sqlVulnerabilityAssessments/{vulnerabilityAssessmentName}/baselines/{baselineName}/rules"].get.responses.default.schema["$ref"]
  - code: ResourceNameRestriction
    from: DatabaseSqlVulnerabilityAssessmentRuleBaselines.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/sqlVulnerabilityAssessments/{vulnerabilityAssessmentName}/baselines/{baselineName}/rules/{ruleId}"]
  - code: ParameterNotDefinedInGlobalParameters
    from: DatabaseSqlVulnerabilityAssessmentRuleBaselines.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/sqlVulnerabilityAssessments/{vulnerabilityAssessmentName}/baselines/{baselineName}/rules/{ruleId}"].get.parameters
  - code: ParameterDescription
    from: DatabaseSqlVulnerabilityAssessmentRuleBaselines.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/sqlVulnerabilityAssessments/{vulnerabilityAssessmentName}/baselines/{baselineName}/rules/{ruleId}"].get.parameters["4"]
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: DatabaseSqlVulnerabilityAssessmentRuleBaselines.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/sqlVulnerabilityAssessments/{vulnerabilityAssessmentName}/baselines/{baselineName}/rules/{ruleId}"].get.responses.default.schema["$ref"]
  - code: PutRequestResponseSchemeArm
    from: DatabaseSqlVulnerabilityAssessmentRuleBaselines.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/sqlVulnerabilityAssessments/{vulnerabilityAssessmentName}/baselines/{baselineName}/rules/{ruleId}"].put
  - code: PutResponseCodes
    from: DatabaseSqlVulnerabilityAssessmentRuleBaselines.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/sqlVulnerabilityAssessments/{vulnerabilityAssessmentName}/baselines/{baselineName}/rules/{ruleId}"].put
  - code: ParameterNotDefinedInGlobalParameters
    from: DatabaseSqlVulnerabilityAssessmentRuleBaselines.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/sqlVulnerabilityAssessments/{vulnerabilityAssessmentName}/baselines/{baselineName}/rules/{ruleId}"].put.parameters
  - code: ParameterDescription
    from: DatabaseSqlVulnerabilityAssessmentRuleBaselines.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/sqlVulnerabilityAssessments/{vulnerabilityAssessmentName}/baselines/{baselineName}/rules/{ruleId}"].put.parameters["4"]
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: DatabaseSqlVulnerabilityAssessmentRuleBaselines.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/sqlVulnerabilityAssessments/{vulnerabilityAssessmentName}/baselines/{baselineName}/rules/{ruleId}"].put.responses.default.schema["$ref"]
  - code: ParameterNotDefinedInGlobalParameters
    from: DatabaseSqlVulnerabilityAssessmentRuleBaselines.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/sqlVulnerabilityAssessments/{vulnerabilityAssessmentName}/baselines/{baselineName}/rules/{ruleId}"].delete.parameters
  - code: ParameterDescription
    from: DatabaseSqlVulnerabilityAssessmentRuleBaselines.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/sqlVulnerabilityAssessments/{vulnerabilityAssessmentName}/baselines/{baselineName}/rules/{ruleId}"].delete.parameters["4"]
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: DatabaseSqlVulnerabilityAssessmentRuleBaselines.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/sqlVulnerabilityAssessments/{vulnerabilityAssessmentName}/baselines/{baselineName}/rules/{ruleId}"].delete.responses.default.schema["$ref"]
  - code: SystemDataDefinitionsCommonTypes
    from: DatabaseSqlVulnerabilityAssessmentRuleBaselines.json
    where: $.definitions.DatabaseSqlVulnerabilityAssessmentRuleBaseline.properties.systemData["$ref"]
  - code: SystemDataDefinitionsCommonTypes
    from: DatabaseSqlVulnerabilityAssessmentRuleBaselines.json
    where: $.definitions.DatabaseSqlVulnerabilityAssessmentRuleBaselineInput.properties.systemData["$ref"]
  - code: MissingSegmentsInNestedResourceListOperation
    from: DatabaseSqlVulnerabilityAssessmentScanResult.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/sqlVulnerabilityAssessments/{vulnerabilityAssessmentName}/scans/{scanId}/scanResults"]
  - code: ResourceNameRestriction
    from: DatabaseSqlVulnerabilityAssessmentScanResult.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/sqlVulnerabilityAssessments/{vulnerabilityAssessmentName}/scans/{scanId}/scanResults"]
  - code: ParameterNotDefinedInGlobalParameters
    from: DatabaseSqlVulnerabilityAssessmentScanResult.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/sqlVulnerabilityAssessments/{vulnerabilityAssessmentName}/scans/{scanId}/scanResults"].get.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: DatabaseSqlVulnerabilityAssessmentScanResult.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/sqlVulnerabilityAssessments/{vulnerabilityAssessmentName}/scans/{scanId}/scanResults"].get.responses.default.schema["$ref"]
  - code: ResourceNameRestriction
    from: DatabaseSqlVulnerabilityAssessmentScanResult.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/sqlVulnerabilityAssessments/{vulnerabilityAssessmentName}/scans/{scanId}/scanResults/{scanResultId}"]
  - code: ParameterNotDefinedInGlobalParameters
    from: DatabaseSqlVulnerabilityAssessmentScanResult.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/sqlVulnerabilityAssessments/{vulnerabilityAssessmentName}/scans/{scanId}/scanResults/{scanResultId}"].get.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: DatabaseSqlVulnerabilityAssessmentScanResult.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/sqlVulnerabilityAssessments/{vulnerabilityAssessmentName}/scans/{scanId}/scanResults/{scanResultId}"].get.responses.default.schema["$ref"]
  - code: SchemaDescriptionOrTitle
    from: DatabaseSqlVulnerabilityAssessmentScanResult.json
    where: $.definitions.SqlVulnerabilityAssessmentScanResults
  - code: SystemDataDefinitionsCommonTypes
    from: DatabaseSqlVulnerabilityAssessmentScanResult.json
    where: $.definitions.SqlVulnerabilityAssessmentScanResults.properties.systemData["$ref"]
  - code: MissingSegmentsInNestedResourceListOperation
    from: DatabaseSqlVulnerabilityAssessmentScans.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/sqlVulnerabilityAssessments/{vulnerabilityAssessmentName}/scans"]
  - code: ResourceNameRestriction
    from: DatabaseSqlVulnerabilityAssessmentScans.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/sqlVulnerabilityAssessments/{vulnerabilityAssessmentName}/scans"]
  - code: ParameterNotDefinedInGlobalParameters
    from: DatabaseSqlVulnerabilityAssessmentScans.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/sqlVulnerabilityAssessments/{vulnerabilityAssessmentName}/scans"].get.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: DatabaseSqlVulnerabilityAssessmentScans.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/sqlVulnerabilityAssessments/{vulnerabilityAssessmentName}/scans"].get.responses.default.schema["$ref"]
  - code: ResourceNameRestriction
    from: DatabaseSqlVulnerabilityAssessmentScans.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/sqlVulnerabilityAssessments/{vulnerabilityAssessmentName}/scans/{scanId}"]
  - code: ParameterNotDefinedInGlobalParameters
    from: DatabaseSqlVulnerabilityAssessmentScans.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/sqlVulnerabilityAssessments/{vulnerabilityAssessmentName}/scans/{scanId}"].get.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: DatabaseSqlVulnerabilityAssessmentScans.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/sqlVulnerabilityAssessments/{vulnerabilityAssessmentName}/scans/{scanId}"].get.responses.default.schema["$ref"]
  - code: SystemDataDefinitionsCommonTypes
    from: DatabaseSqlVulnerabilityAssessmentScans.json
    where: $.definitions.SqlVulnerabilityAssessmentScanRecord.properties.systemData["$ref"]
  - code: MissingSegmentsInNestedResourceListOperation
    from: DatabaseSqlVulnerabilityAssessmentsSettings.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/sqlVulnerabilityAssessments"]
  - code: ResourceNameRestriction
    from: DatabaseSqlVulnerabilityAssessmentsSettings.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/sqlVulnerabilityAssessments"]
  - code: ParameterNotDefinedInGlobalParameters
    from: DatabaseSqlVulnerabilityAssessmentsSettings.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/sqlVulnerabilityAssessments"].get.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: DatabaseSqlVulnerabilityAssessmentsSettings.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/sqlVulnerabilityAssessments"].get.responses.default.schema["$ref"]
  - code: ResourceNameRestriction
    from: DatabaseSqlVulnerabilityAssessmentsSettings.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/sqlVulnerabilityAssessments/{vulnerabilityAssessmentName}"]
  - code: ParameterNotDefinedInGlobalParameters
    from: DatabaseSqlVulnerabilityAssessmentsSettings.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/sqlVulnerabilityAssessments/{vulnerabilityAssessmentName}"].get.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: DatabaseSqlVulnerabilityAssessmentsSettings.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/sqlVulnerabilityAssessments/{vulnerabilityAssessmentName}"].get.responses.default.schema["$ref"]
  - code: SystemDataDefinitionsCommonTypes
    from: DatabaseSqlVulnerabilityAssessmentsSettings.json
    where: $.definitions.SqlVulnerabilityAssessment.properties.systemData["$ref"]
  - code: SchemaDescriptionOrTitle
    from: DatabaseSqlVulnerabilityAssessmentsSettings.json
    where: $.definitions.SqlVulnerabilityAssessmentPolicyProperties
  - code: MissingSegmentsInNestedResourceListOperation
    from: DatabaseTables.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/schemas/{schemaName}/tables"]
  - code: ResourceNameRestriction
    from: DatabaseTables.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/schemas/{schemaName}/tables"]
  - code: ParameterNotDefinedInGlobalParameters
    from: DatabaseTables.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/schemas/{schemaName}/tables"].get.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: DatabaseTables.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/schemas/{schemaName}/tables"].get.responses.default.schema["$ref"]
  - code: ResourceNameRestriction
    from: DatabaseTables.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/schemas/{schemaName}/tables/{tableName}"]
  - code: ParameterNotDefinedInGlobalParameters
    from: DatabaseTables.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/schemas/{schemaName}/tables/{tableName}"].get.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: DatabaseTables.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/schemas/{schemaName}/tables/{tableName}"].get.responses.default.schema["$ref"]
  - code: MissingSegmentsInNestedResourceListOperation
    from: DatabaseUsages.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/usages"]
  - code: ResourceNameRestriction
    from: DatabaseUsages.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/usages"]
  - code: ParameterNotDefinedInGlobalParameters
    from: DatabaseUsages.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/usages"].get.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: DatabaseUsages.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/usages"].get.responses.default.schema["$ref"]
  - code: MissingSegmentsInNestedResourceListOperation
    from: DatabaseVulnerabilityAssessmentRuleBaselines.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/vulnerabilityAssessments/{vulnerabilityAssessmentName}/rules/{ruleId}/baselines/{baselineName}"]
  - code: ResourceNameRestriction
    from: DatabaseVulnerabilityAssessmentRuleBaselines.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/vulnerabilityAssessments/{vulnerabilityAssessmentName}/rules/{ruleId}/baselines/{baselineName}"]
  - code: ParameterNotDefinedInGlobalParameters
    from: DatabaseVulnerabilityAssessmentRuleBaselines.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/vulnerabilityAssessments/{vulnerabilityAssessmentName}/rules/{ruleId}/baselines/{baselineName}"].get.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: DatabaseVulnerabilityAssessmentRuleBaselines.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/vulnerabilityAssessments/{vulnerabilityAssessmentName}/rules/{ruleId}/baselines/{baselineName}"].get.responses.default.schema["$ref"]
  - code: PutResponseCodes
    from: DatabaseVulnerabilityAssessmentRuleBaselines.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/vulnerabilityAssessments/{vulnerabilityAssessmentName}/rules/{ruleId}/baselines/{baselineName}"].put
  - code: ParameterNotDefinedInGlobalParameters
    from: DatabaseVulnerabilityAssessmentRuleBaselines.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/vulnerabilityAssessments/{vulnerabilityAssessmentName}/rules/{ruleId}/baselines/{baselineName}"].put.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: DatabaseVulnerabilityAssessmentRuleBaselines.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/vulnerabilityAssessments/{vulnerabilityAssessmentName}/rules/{ruleId}/baselines/{baselineName}"].put.responses.default.schema["$ref"]
  - code: DeleteResponseCodes
    from: DatabaseVulnerabilityAssessmentRuleBaselines.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/vulnerabilityAssessments/{vulnerabilityAssessmentName}/rules/{ruleId}/baselines/{baselineName}"].delete
  - code: ParameterNotDefinedInGlobalParameters
    from: DatabaseVulnerabilityAssessmentRuleBaselines.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/vulnerabilityAssessments/{vulnerabilityAssessmentName}/rules/{ruleId}/baselines/{baselineName}"].delete.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: DatabaseVulnerabilityAssessmentRuleBaselines.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/vulnerabilityAssessments/{vulnerabilityAssessmentName}/rules/{ruleId}/baselines/{baselineName}"].delete.responses.default.schema["$ref"]
  - code: MissingSegmentsInNestedResourceListOperation
    from: DatabaseVulnerabilityAssessments.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/vulnerabilityAssessments"]
  - code: ResourceNameRestriction
    from: DatabaseVulnerabilityAssessments.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/vulnerabilityAssessments"]
  - code: ParameterNotDefinedInGlobalParameters
    from: DatabaseVulnerabilityAssessments.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/vulnerabilityAssessments"].get.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: DatabaseVulnerabilityAssessments.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/vulnerabilityAssessments"].get.responses.default.schema["$ref"]
  - code: ResourceNameRestriction
    from: DatabaseVulnerabilityAssessments.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/vulnerabilityAssessments/{vulnerabilityAssessmentName}"]
  - code: ParameterNotDefinedInGlobalParameters
    from: DatabaseVulnerabilityAssessments.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/vulnerabilityAssessments/{vulnerabilityAssessmentName}"].get.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: DatabaseVulnerabilityAssessments.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/vulnerabilityAssessments/{vulnerabilityAssessmentName}"].get.responses.default.schema["$ref"]
  - code: ParameterNotDefinedInGlobalParameters
    from: DatabaseVulnerabilityAssessments.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/vulnerabilityAssessments/{vulnerabilityAssessmentName}"].put.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: DatabaseVulnerabilityAssessments.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/vulnerabilityAssessments/{vulnerabilityAssessmentName}"].put.responses.default.schema["$ref"]
  - code: DeleteResponseCodes
    from: DatabaseVulnerabilityAssessments.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/vulnerabilityAssessments/{vulnerabilityAssessmentName}"].delete
  - code: ParameterNotDefinedInGlobalParameters
    from: DatabaseVulnerabilityAssessments.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/vulnerabilityAssessments/{vulnerabilityAssessmentName}"].delete.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: DatabaseVulnerabilityAssessments.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/vulnerabilityAssessments/{vulnerabilityAssessmentName}"].delete.responses.default.schema["$ref"]
  - code: MissingSegmentsInNestedResourceListOperation
    from: DatabaseVulnerabilityAssessmentScans.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/vulnerabilityAssessments/{vulnerabilityAssessmentName}/scans"]
  - code: ResourceNameRestriction
    from: DatabaseVulnerabilityAssessmentScans.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/vulnerabilityAssessments/{vulnerabilityAssessmentName}/scans"]
  - code: ParameterNotDefinedInGlobalParameters
    from: DatabaseVulnerabilityAssessmentScans.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/vulnerabilityAssessments/{vulnerabilityAssessmentName}/scans"].get.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: DatabaseVulnerabilityAssessmentScans.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/vulnerabilityAssessments/{vulnerabilityAssessmentName}/scans"].get.responses.default.schema["$ref"]
  - code: ResourceNameRestriction
    from: DatabaseVulnerabilityAssessmentScans.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/vulnerabilityAssessments/{vulnerabilityAssessmentName}/scans/{scanId}"]
  - code: ParameterNotDefinedInGlobalParameters
    from: DatabaseVulnerabilityAssessmentScans.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/vulnerabilityAssessments/{vulnerabilityAssessmentName}/scans/{scanId}"].get.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: DatabaseVulnerabilityAssessmentScans.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/vulnerabilityAssessments/{vulnerabilityAssessmentName}/scans/{scanId}"].get.responses.default.schema["$ref"]
  - code: ResourceNameRestriction
    from: DatabaseVulnerabilityAssessmentScans.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/vulnerabilityAssessments/{vulnerabilityAssessmentName}/scans/{scanId}/export"]
  - code: PostResponseCodes
    from: DatabaseVulnerabilityAssessmentScans.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/vulnerabilityAssessments/{vulnerabilityAssessmentName}/scans/{scanId}/export"].post
  - code: ParameterNotDefinedInGlobalParameters
    from: DatabaseVulnerabilityAssessmentScans.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/vulnerabilityAssessments/{vulnerabilityAssessmentName}/scans/{scanId}/export"].post.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: DatabaseVulnerabilityAssessmentScans.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/vulnerabilityAssessments/{vulnerabilityAssessmentName}/scans/{scanId}/export"].post.responses.default.schema["$ref"]
  - code: ResourceNameRestriction
    from: DatabaseVulnerabilityAssessmentScans.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/vulnerabilityAssessments/{vulnerabilityAssessmentName}/scans/{scanId}/initiateScan"]
  - code: PostResponseCodes
    from: DatabaseVulnerabilityAssessmentScans.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/vulnerabilityAssessments/{vulnerabilityAssessmentName}/scans/{scanId}/initiateScan"].post
  - code: ParameterNotDefinedInGlobalParameters
    from: DatabaseVulnerabilityAssessmentScans.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/vulnerabilityAssessments/{vulnerabilityAssessmentName}/scans/{scanId}/initiateScan"].post.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: DatabaseVulnerabilityAssessmentScans.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/vulnerabilityAssessments/{vulnerabilityAssessmentName}/scans/{scanId}/initiateScan"].post.responses.default.schema["$ref"]
  - code: MissingSegmentsInNestedResourceListOperation
    from: DataMaskingPolicies.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/dataMaskingPolicies/{dataMaskingPolicyName}"]
  - code: ResourceNameRestriction
    from: DataMaskingPolicies.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/dataMaskingPolicies/{dataMaskingPolicyName}"]
  - code: ParameterNotDefinedInGlobalParameters
    from: DataMaskingPolicies.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/dataMaskingPolicies/{dataMaskingPolicyName}"].get.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: DataMaskingPolicies.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/dataMaskingPolicies/{dataMaskingPolicyName}"].get.responses.default.schema["$ref"]
  - code: RequestSchemaForTrackedResourcesMustHaveTags
    from: DataMaskingPolicies.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/dataMaskingPolicies/{dataMaskingPolicyName}"].put
  - code: ParameterNotDefinedInGlobalParameters
    from: DataMaskingPolicies.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/dataMaskingPolicies/{dataMaskingPolicyName}"].put.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: DataMaskingPolicies.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/dataMaskingPolicies/{dataMaskingPolicyName}"].put.responses.default.schema["$ref"]
  - code: LocationMustHaveXmsMutability
    from: DataMaskingPolicies.json
    where: $.definitions.DataMaskingPolicy.properties.location
  - code: MissingSegmentsInNestedResourceListOperation
    from: DataMaskingRules.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/dataMaskingPolicies/{dataMaskingPolicyName}/rules"]
  - code: ResourceNameRestriction
    from: DataMaskingRules.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/dataMaskingPolicies/{dataMaskingPolicyName}/rules"]
  - code: ParameterNotDefinedInGlobalParameters
    from: DataMaskingRules.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/dataMaskingPolicies/{dataMaskingPolicyName}/rules"].get.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: DataMaskingRules.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/dataMaskingPolicies/{dataMaskingPolicyName}/rules"].get.responses.default.schema["$ref"]
  - code: ResourceNameRestriction
    from: DataMaskingRules.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/dataMaskingPolicies/{dataMaskingPolicyName}/rules/{dataMaskingRuleName}"]
  - code: RequestSchemaForTrackedResourcesMustHaveTags
    from: DataMaskingRules.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/dataMaskingPolicies/{dataMaskingPolicyName}/rules/{dataMaskingRuleName}"].put
  - code: ParameterNotDefinedInGlobalParameters
    from: DataMaskingRules.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/dataMaskingPolicies/{dataMaskingPolicyName}/rules/{dataMaskingRuleName}"].put.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: DataMaskingRules.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/dataMaskingPolicies/{dataMaskingPolicyName}/rules/{dataMaskingRuleName}"].put.responses.default.schema["$ref"]
  - code: LocationMustHaveXmsMutability
    from: DataMaskingRules.json
    where: $.definitions.DataMaskingRule.properties.location
  - code: MissingSegmentsInNestedResourceListOperation
    from: DataWarehouseUserActivities.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/dataWarehouseUserActivities"]
  - code: ResourceNameRestriction
    from: DataWarehouseUserActivities.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/dataWarehouseUserActivities"]
  - code: OperationIdNounConflictingModelNames
    from: DataWarehouseUserActivities.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/dataWarehouseUserActivities"].get.operationId
  - code: ParameterNotDefinedInGlobalParameters
    from: DataWarehouseUserActivities.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/dataWarehouseUserActivities"].get.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: DataWarehouseUserActivities.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/dataWarehouseUserActivities"].get.responses.default.schema["$ref"]
  - code: ResourceNameRestriction
    from: DataWarehouseUserActivities.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/dataWarehouseUserActivities/{dataWarehouseUserActivityName}"]
  - code: OperationIdNounConflictingModelNames
    from: DataWarehouseUserActivities.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/dataWarehouseUserActivities/{dataWarehouseUserActivityName}"].get.operationId
  - code: ParameterNotDefinedInGlobalParameters
    from: DataWarehouseUserActivities.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/dataWarehouseUserActivities/{dataWarehouseUserActivityName}"].get.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: DataWarehouseUserActivities.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/dataWarehouseUserActivities/{dataWarehouseUserActivityName}"].get.responses.default.schema["$ref"]
  - code: ParameterNotDefinedInGlobalParameters
    from: DeletedServers.json
    where: $.paths["/subscriptions/{subscriptionId}/providers/Microsoft.Sql/deletedServers"].get.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: DeletedServers.json
    where: $.paths["/subscriptions/{subscriptionId}/providers/Microsoft.Sql/deletedServers"].get.responses.default.schema["$ref"]
  - code: ResourceNameRestriction
    from: DeletedServers.json
    where: $.paths["/subscriptions/{subscriptionId}/providers/Microsoft.Sql/locations/{locationName}/deletedServers"]
  - code: ParameterNotDefinedInGlobalParameters
    from: DeletedServers.json
    where: $.paths["/subscriptions/{subscriptionId}/providers/Microsoft.Sql/locations/{locationName}/deletedServers"].get.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: DeletedServers.json
    where: $.paths["/subscriptions/{subscriptionId}/providers/Microsoft.Sql/locations/{locationName}/deletedServers"].get.responses.default.schema["$ref"]
  - code: ResourceNameRestriction
    from: DeletedServers.json
    where: $.paths["/subscriptions/{subscriptionId}/providers/Microsoft.Sql/locations/{locationName}/deletedServers/{deletedServerName}"]
  - code: ParameterNotDefinedInGlobalParameters
    from: DeletedServers.json
    where: $.paths["/subscriptions/{subscriptionId}/providers/Microsoft.Sql/locations/{locationName}/deletedServers/{deletedServerName}"].get.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: DeletedServers.json
    where: $.paths["/subscriptions/{subscriptionId}/providers/Microsoft.Sql/locations/{locationName}/deletedServers/{deletedServerName}"].get.responses.default.schema["$ref"]
  - code: LongRunningOperationsOptionsValidator
    from: DeletedServers.json
    where: $.paths["/subscriptions/{subscriptionId}/providers/Microsoft.Sql/locations/{locationName}/deletedServers/{deletedServerName}/recover"]
  - code: ResourceNameRestriction
    from: DeletedServers.json
    where: $.paths["/subscriptions/{subscriptionId}/providers/Microsoft.Sql/locations/{locationName}/deletedServers/{deletedServerName}/recover"]
  - code: ParameterNotDefinedInGlobalParameters
    from: DeletedServers.json
    where: $.paths["/subscriptions/{subscriptionId}/providers/Microsoft.Sql/locations/{locationName}/deletedServers/{deletedServerName}/recover"].post.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: DeletedServers.json
    where: $.paths["/subscriptions/{subscriptionId}/providers/Microsoft.Sql/locations/{locationName}/deletedServers/{deletedServerName}/recover"].post.responses.default.schema["$ref"]
  - code: MissingSegmentsInNestedResourceListOperation
    from: DistributedAvailabilityGroups.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/distributedAvailabilityGroups"]
  - code: ResourceNameRestriction
    from: DistributedAvailabilityGroups.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/distributedAvailabilityGroups"]
  - code: ParameterNotDefinedInGlobalParameters
    from: DistributedAvailabilityGroups.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/distributedAvailabilityGroups"].get.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: DistributedAvailabilityGroups.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/distributedAvailabilityGroups"].get.responses.default.schema["$ref"]
  - code: ResourceNameRestriction
    from: DistributedAvailabilityGroups.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/distributedAvailabilityGroups/{distributedAvailabilityGroupName}"]
  - code: ParameterNotDefinedInGlobalParameters
    from: DistributedAvailabilityGroups.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/distributedAvailabilityGroups/{distributedAvailabilityGroupName}"].get.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: DistributedAvailabilityGroups.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/distributedAvailabilityGroups/{distributedAvailabilityGroupName}"].get.responses.default.schema["$ref"]
  - code: ProvisioningStateSpecifiedForLROPut
    from: DistributedAvailabilityGroups.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/distributedAvailabilityGroups/{distributedAvailabilityGroupName}"].put
  - code: PutResponseCodes
    from: DistributedAvailabilityGroups.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/distributedAvailabilityGroups/{distributedAvailabilityGroupName}"].put
  - code: ParameterNotDefinedInGlobalParameters
    from: DistributedAvailabilityGroups.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/distributedAvailabilityGroups/{distributedAvailabilityGroupName}"].put.parameters
  - code: RepeatedPathInfo
    from: DistributedAvailabilityGroups.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/distributedAvailabilityGroups/{distributedAvailabilityGroupName}"].put.parameters["2"]
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: DistributedAvailabilityGroups.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/distributedAvailabilityGroups/{distributedAvailabilityGroupName}"].put.responses.default.schema["$ref"]
  - code: DeleteResponseCodes
    from: DistributedAvailabilityGroups.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/distributedAvailabilityGroups/{distributedAvailabilityGroupName}"].delete
  - code: ParameterNotDefinedInGlobalParameters
    from: DistributedAvailabilityGroups.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/distributedAvailabilityGroups/{distributedAvailabilityGroupName}"].delete.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: DistributedAvailabilityGroups.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/distributedAvailabilityGroups/{distributedAvailabilityGroupName}"].delete.responses.default.schema["$ref"]
  - code: ParameterNotDefinedInGlobalParameters
    from: DistributedAvailabilityGroups.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/distributedAvailabilityGroups/{distributedAvailabilityGroupName}"].patch.parameters
  - code: ProvisioningStateSpecifiedForLROPatch
    from: DistributedAvailabilityGroups.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/distributedAvailabilityGroups/{distributedAvailabilityGroupName}"].patch.responses["200"]
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: DistributedAvailabilityGroups.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/distributedAvailabilityGroups/{distributedAvailabilityGroupName}"].patch.responses.default.schema["$ref"]
  - code: ParameterNotDefinedInGlobalParameters
    from: DistributedAvailabilityGroups.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/distributedAvailabilityGroups/{distributedAvailabilityGroupName}/failover"].post.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: DistributedAvailabilityGroups.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/distributedAvailabilityGroups/{distributedAvailabilityGroupName}/failover"].post.responses.default.schema["$ref"]
  - code: ResourceNameRestriction
    from: DistributedAvailabilityGroups.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/distributedAvailabilityGroups/{distributedAvailabilityGroupName}/setRole"]
  - code: ParameterNotDefinedInGlobalParameters
    from: DistributedAvailabilityGroups.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/distributedAvailabilityGroups/{distributedAvailabilityGroupName}/setRole"].post.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: DistributedAvailabilityGroups.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/distributedAvailabilityGroups/{distributedAvailabilityGroupName}/setRole"].post.responses.default.schema["$ref"]
  - code: MissingSegmentsInNestedResourceListOperation
    from: ElasticPoolOperations.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/elasticPools/{elasticPoolName}/operations"]
  - code: ResourceNameRestriction
    from: ElasticPoolOperations.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/elasticPools/{elasticPoolName}/operations"]
  - code: ParameterNotDefinedInGlobalParameters
    from: ElasticPoolOperations.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/elasticPools/{elasticPoolName}/operations"].get.parameters
  - code: ParameterDescription
    from: ElasticPoolOperations.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/elasticPools/{elasticPoolName}/operations"].get.parameters["2"]
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: ElasticPoolOperations.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/elasticPools/{elasticPoolName}/operations"].get.responses.default.schema["$ref"]
  - code: ResourceNameRestriction
    from: ElasticPoolOperations.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/elasticPools/{elasticPoolName}/operations/{operationId}/cancel"]
  - code: ParameterNotDefinedInGlobalParameters
    from: ElasticPoolOperations.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/elasticPools/{elasticPoolName}/operations/{operationId}/cancel"].post.parameters
  - code: ParameterDescription
    from: ElasticPoolOperations.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/elasticPools/{elasticPoolName}/operations/{operationId}/cancel"].post.parameters["2"]
  - code: ParameterNotUsingCommonTypes
    from: ElasticPoolOperations.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/elasticPools/{elasticPoolName}/operations/{operationId}/cancel"].post.parameters["3"].name
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: ElasticPoolOperations.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/elasticPools/{elasticPoolName}/operations/{operationId}/cancel"].post.responses.default.schema["$ref"]
  - code: PatchBodyParametersSchema
    from: ElasticPools.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/elasticPools/{elasticPoolName}"].patch.parameters["3"].schema.properties.sku
  - code: MissingSegmentsInNestedResourceListOperation
    from: ElasticPools.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/elasticPools"]
  - code: ResourceNameRestriction
    from: ElasticPools.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/elasticPools"]
  - code: ParameterNotDefinedInGlobalParameters
    from: ElasticPools.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/elasticPools"].get.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: ElasticPools.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/elasticPools"].get.responses.default.schema["$ref"]
  - code: ResourceNameRestriction
    from: ElasticPools.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/elasticPools/{elasticPoolName}"]
  - code: ParameterNotDefinedInGlobalParameters
    from: ElasticPools.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/elasticPools/{elasticPoolName}"].get.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: ElasticPools.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/elasticPools/{elasticPoolName}"].get.responses.default.schema["$ref"]
  - code: ProvisioningStateSpecifiedForLROPut
    from: ElasticPools.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/elasticPools/{elasticPoolName}"].put
  - code: PutResponseCodes
    from: ElasticPools.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/elasticPools/{elasticPoolName}"].put
  - code: ParameterNotDefinedInGlobalParameters
    from: ElasticPools.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/elasticPools/{elasticPoolName}"].put.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: ElasticPools.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/elasticPools/{elasticPoolName}"].put.responses.default.schema["$ref"]
  - code: DeleteResponseCodes
    from: ElasticPools.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/elasticPools/{elasticPoolName}"].delete
  - code: ParameterNotDefinedInGlobalParameters
    from: ElasticPools.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/elasticPools/{elasticPoolName}"].delete.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: ElasticPools.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/elasticPools/{elasticPoolName}"].delete.responses.default.schema["$ref"]
  - code: ParameterNotDefinedInGlobalParameters
    from: ElasticPools.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/elasticPools/{elasticPoolName}"].patch.parameters
  - code: ProvisioningStateSpecifiedForLROPatch
    from: ElasticPools.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/elasticPools/{elasticPoolName}"].patch.responses["200"]
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: ElasticPools.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/elasticPools/{elasticPoolName}"].patch.responses.default.schema["$ref"]
  - code: ResourceNameRestriction
    from: ElasticPools.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/elasticPools/{elasticPoolName}/failover"]
  - code: PostResponseCodes
    from: ElasticPools.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/elasticPools/{elasticPoolName}/failover"].post
  - code: ParameterNotDefinedInGlobalParameters
    from: ElasticPools.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/elasticPools/{elasticPoolName}/failover"].post.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: ElasticPools.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/elasticPools/{elasticPoolName}/failover"].post.responses.default.schema["$ref"]
  - code: MissingSegmentsInNestedResourceListOperation
    from: EncryptionProtectors.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/encryptionProtector"]
  - code: ResourceNameRestriction
    from: EncryptionProtectors.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/encryptionProtector"]
  - code: ParameterNotDefinedInGlobalParameters
    from: EncryptionProtectors.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/encryptionProtector"].get.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: EncryptionProtectors.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/encryptionProtector"].get.responses.default.schema["$ref"]
  - code: ResourceNameRestriction
    from: EncryptionProtectors.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/encryptionProtector/{encryptionProtectorName}"]
  - code: ParameterNotDefinedInGlobalParameters
    from: EncryptionProtectors.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/encryptionProtector/{encryptionProtectorName}"].get.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: EncryptionProtectors.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/encryptionProtector/{encryptionProtectorName}"].get.responses.default.schema["$ref"]
  - code: ProvisioningStateSpecifiedForLROPut
    from: EncryptionProtectors.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/encryptionProtector/{encryptionProtectorName}"].put
  - code: PutResponseCodes
    from: EncryptionProtectors.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/encryptionProtector/{encryptionProtectorName}"].put
  - code: RequestSchemaForTrackedResourcesMustHaveTags
    from: EncryptionProtectors.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/encryptionProtector/{encryptionProtectorName}"].put
  - code: ParameterNotDefinedInGlobalParameters
    from: EncryptionProtectors.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/encryptionProtector/{encryptionProtectorName}"].put.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: EncryptionProtectors.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/encryptionProtector/{encryptionProtectorName}"].put.responses.default.schema["$ref"]
  - code: ResourceNameRestriction
    from: EncryptionProtectors.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/encryptionProtector/{encryptionProtectorName}/revalidate"]
  - code: PostResponseCodes
    from: EncryptionProtectors.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/encryptionProtector/{encryptionProtectorName}/revalidate"].post
  - code: ParameterNotDefinedInGlobalParameters
    from: EncryptionProtectors.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/encryptionProtector/{encryptionProtectorName}/revalidate"].post.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: EncryptionProtectors.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/encryptionProtector/{encryptionProtectorName}/revalidate"].post.responses.default.schema["$ref"]
  - code: LocationMustHaveXmsMutability
    from: EncryptionProtectors.json
    where: $.definitions.EncryptionProtector.properties.location
  - code: MissingSegmentsInNestedResourceListOperation
    from: EndpointCertificates.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/endpointCertificates"]
  - code: ResourceNameRestriction
    from: EndpointCertificates.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/endpointCertificates"]
  - code: ParameterNotDefinedInGlobalParameters
    from: EndpointCertificates.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/endpointCertificates"].get.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: EndpointCertificates.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/endpointCertificates"].get.responses.default.schema["$ref"]
  - code: ResourceNameRestriction
    from: EndpointCertificates.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/endpointCertificates/{endpointType}"]
  - code: ParameterNotDefinedInGlobalParameters
    from: EndpointCertificates.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/endpointCertificates/{endpointType}"].get.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: EndpointCertificates.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/endpointCertificates/{endpointType}"].get.responses.default.schema["$ref"]
  - code: PatchBodyParametersSchema
    from: FailoverGroups.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/failoverGroups/{failoverGroupName}"].patch.parameters["3"].schema.properties.properties
  - code: MissingSegmentsInNestedResourceListOperation
    from: FailoverGroups.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/failoverGroups"]
  - code: ResourceNameRestriction
    from: FailoverGroups.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/failoverGroups"]
  - code: ParameterNotDefinedInGlobalParameters
    from: FailoverGroups.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/failoverGroups"].get.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: FailoverGroups.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/failoverGroups"].get.responses.default.schema["$ref"]
  - code: ResourceNameRestriction
    from: FailoverGroups.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/failoverGroups/{failoverGroupName}"]
  - code: ParameterNotDefinedInGlobalParameters
    from: FailoverGroups.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/failoverGroups/{failoverGroupName}"].get.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: FailoverGroups.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/failoverGroups/{failoverGroupName}"].get.responses.default.schema["$ref"]
  - code: ProvisioningStateSpecifiedForLROPut
    from: FailoverGroups.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/failoverGroups/{failoverGroupName}"].put
  - code: PutResponseCodes
    from: FailoverGroups.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/failoverGroups/{failoverGroupName}"].put
  - code: ParameterNotDefinedInGlobalParameters
    from: FailoverGroups.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/failoverGroups/{failoverGroupName}"].put.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: FailoverGroups.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/failoverGroups/{failoverGroupName}"].put.responses.default.schema["$ref"]
  - code: DeleteResponseCodes
    from: FailoverGroups.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/failoverGroups/{failoverGroupName}"].delete
  - code: ParameterNotDefinedInGlobalParameters
    from: FailoverGroups.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/failoverGroups/{failoverGroupName}"].delete.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: FailoverGroups.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/failoverGroups/{failoverGroupName}"].delete.responses.default.schema["$ref"]
  - code: ParameterNotDefinedInGlobalParameters
    from: FailoverGroups.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/failoverGroups/{failoverGroupName}"].patch.parameters
  - code: ProvisioningStateSpecifiedForLROPatch
    from: FailoverGroups.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/failoverGroups/{failoverGroupName}"].patch.responses["200"]
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: FailoverGroups.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/failoverGroups/{failoverGroupName}"].patch.responses.default.schema["$ref"]
  - code: LongRunningOperationsOptionsValidator
    from: FailoverGroups.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/failoverGroups/{failoverGroupName}/failover"]
  - code: ResourceNameRestriction
    from: FailoverGroups.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/failoverGroups/{failoverGroupName}/failover"]
  - code: ParameterNotDefinedInGlobalParameters
    from: FailoverGroups.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/failoverGroups/{failoverGroupName}/failover"].post.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: FailoverGroups.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/failoverGroups/{failoverGroupName}/failover"].post.responses.default.schema["$ref"]
  - code: LongRunningOperationsOptionsValidator
    from: FailoverGroups.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/failoverGroups/{failoverGroupName}/forceFailoverAllowDataLoss"]
  - code: ResourceNameRestriction
    from: FailoverGroups.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/failoverGroups/{failoverGroupName}/forceFailoverAllowDataLoss"]
  - code: ParameterNotDefinedInGlobalParameters
    from: FailoverGroups.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/failoverGroups/{failoverGroupName}/forceFailoverAllowDataLoss"].post.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: FailoverGroups.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/failoverGroups/{failoverGroupName}/forceFailoverAllowDataLoss"].post.responses.default.schema["$ref"]
  - code: ResourceNameRestriction
    from: FailoverGroups.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/failoverGroups/{failoverGroupName}/tryPlannedBeforeForcedFailover"]
  - code: ParameterNotDefinedInGlobalParameters
    from: FailoverGroups.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/failoverGroups/{failoverGroupName}/tryPlannedBeforeForcedFailover"].post.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: FailoverGroups.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/failoverGroups/{failoverGroupName}/tryPlannedBeforeForcedFailover"].post.responses.default.schema["$ref"]
  - code: LocationMustHaveXmsMutability
    from: FailoverGroups.json
    where: $.definitions.FailoverGroup.properties.location
  - code: LocationMustHaveXmsMutability
    from: FailoverGroups.json
    where: $.definitions.PartnerInfo.properties.location
  - code: EvenSegmentedPathForPutOperation
    from: FirewallRules.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/firewallRules"]
  - code: MissingSegmentsInNestedResourceListOperation
    from: FirewallRules.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/firewallRules"]
  - code: PutGetPatchResponseSchema
    from: FirewallRules.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/firewallRules"]
  - code: ResourceNameRestriction
    from: FirewallRules.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/firewallRules"]
  - code: ParameterNotDefinedInGlobalParameters
    from: FirewallRules.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/firewallRules"].get.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: FirewallRules.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/firewallRules"].get.responses.default.schema["$ref"]
  - code: LroExtension
    from: FirewallRules.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/firewallRules"].put
  - code: PutRequestResponseSchemeArm
    from: FirewallRules.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/firewallRules"].put
  - code: PutResponseCodes
    from: FirewallRules.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/firewallRules"].put
  - code: PutInOperationName
    from: FirewallRules.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/firewallRules"].put.operationId
  - code: ParameterNotDefinedInGlobalParameters
    from: FirewallRules.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/firewallRules"].put.parameters
  - code: ParameterDescription
    from: FirewallRules.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/firewallRules"].put.parameters["2"]
  - code: LroLocationHeader
    from: FirewallRules.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/firewallRules"].put.responses["202"]
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: FirewallRules.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/firewallRules"].put.responses.default.schema["$ref"]
  - code: ResourceNameRestriction
    from: FirewallRules.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/firewallRules/{firewallRuleName}"]
  - code: ParameterNotDefinedInGlobalParameters
    from: FirewallRules.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/firewallRules/{firewallRuleName}"].get.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: FirewallRules.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/firewallRules/{firewallRuleName}"].get.responses.default.schema["$ref"]
  - code: ParameterNotDefinedInGlobalParameters
    from: FirewallRules.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/firewallRules/{firewallRuleName}"].put.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: FirewallRules.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/firewallRules/{firewallRuleName}"].put.responses.default.schema["$ref"]
  - code: ParameterNotDefinedInGlobalParameters
    from: FirewallRules.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/firewallRules/{firewallRuleName}"].delete.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: FirewallRules.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/firewallRules/{firewallRuleName}"].delete.responses.default.schema["$ref"]
  - code: MissingSegmentsInNestedResourceListOperation
    from: GeoBackupPolicies.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/geoBackupPolicies"]
  - code: ResourceNameRestriction
    from: GeoBackupPolicies.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/geoBackupPolicies"]
  - code: ParameterNotDefinedInGlobalParameters
    from: GeoBackupPolicies.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/geoBackupPolicies"].get.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: GeoBackupPolicies.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/geoBackupPolicies"].get.responses.default.schema["$ref"]
  - code: ResourceNameRestriction
    from: GeoBackupPolicies.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/geoBackupPolicies/{geoBackupPolicyName}"]
  - code: ParameterNotDefinedInGlobalParameters
    from: GeoBackupPolicies.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/geoBackupPolicies/{geoBackupPolicyName}"].get.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: GeoBackupPolicies.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/geoBackupPolicies/{geoBackupPolicyName}"].get.responses.default.schema["$ref"]
  - code: RequestSchemaForTrackedResourcesMustHaveTags
    from: GeoBackupPolicies.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/geoBackupPolicies/{geoBackupPolicyName}"].put
  - code: ParameterNotDefinedInGlobalParameters
    from: GeoBackupPolicies.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/geoBackupPolicies/{geoBackupPolicyName}"].put.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: GeoBackupPolicies.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/geoBackupPolicies/{geoBackupPolicyName}"].put.responses.default.schema["$ref"]
  - code: LocationMustHaveXmsMutability
    from: GeoBackupPolicies.json
    where: $.definitions.GeoBackupPolicy.properties.location
  - code: MissingSegmentsInNestedResourceListOperation
    from: InstanceFailoverGroups.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/locations/{locationName}/instanceFailoverGroups"]
  - code: ResourceNameRestriction
    from: InstanceFailoverGroups.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/locations/{locationName}/instanceFailoverGroups"]
  - code: ParameterNotDefinedInGlobalParameters
    from: InstanceFailoverGroups.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/locations/{locationName}/instanceFailoverGroups"].get.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: InstanceFailoverGroups.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/locations/{locationName}/instanceFailoverGroups"].get.responses.default.schema["$ref"]
  - code: ResourceNameRestriction
    from: InstanceFailoverGroups.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/locations/{locationName}/instanceFailoverGroups/{failoverGroupName}"]
  - code: ParameterNotDefinedInGlobalParameters
    from: InstanceFailoverGroups.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/locations/{locationName}/instanceFailoverGroups/{failoverGroupName}"].get.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: InstanceFailoverGroups.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/locations/{locationName}/instanceFailoverGroups/{failoverGroupName}"].get.responses.default.schema["$ref"]
  - code: ProvisioningStateSpecifiedForLROPut
    from: InstanceFailoverGroups.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/locations/{locationName}/instanceFailoverGroups/{failoverGroupName}"].put
  - code: PutResponseCodes
    from: InstanceFailoverGroups.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/locations/{locationName}/instanceFailoverGroups/{failoverGroupName}"].put
  - code: ParameterNotDefinedInGlobalParameters
    from: InstanceFailoverGroups.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/locations/{locationName}/instanceFailoverGroups/{failoverGroupName}"].put.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: InstanceFailoverGroups.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/locations/{locationName}/instanceFailoverGroups/{failoverGroupName}"].put.responses.default.schema["$ref"]
  - code: DeleteResponseCodes
    from: InstanceFailoverGroups.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/locations/{locationName}/instanceFailoverGroups/{failoverGroupName}"].delete
  - code: ParameterNotDefinedInGlobalParameters
    from: InstanceFailoverGroups.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/locations/{locationName}/instanceFailoverGroups/{failoverGroupName}"].delete.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: InstanceFailoverGroups.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/locations/{locationName}/instanceFailoverGroups/{failoverGroupName}"].delete.responses.default.schema["$ref"]
  - code: LongRunningOperationsOptionsValidator
    from: InstanceFailoverGroups.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/locations/{locationName}/instanceFailoverGroups/{failoverGroupName}/failover"]
  - code: ResourceNameRestriction
    from: InstanceFailoverGroups.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/locations/{locationName}/instanceFailoverGroups/{failoverGroupName}/failover"]
  - code: ParameterNotDefinedInGlobalParameters
    from: InstanceFailoverGroups.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/locations/{locationName}/instanceFailoverGroups/{failoverGroupName}/failover"].post.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: InstanceFailoverGroups.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/locations/{locationName}/instanceFailoverGroups/{failoverGroupName}/failover"].post.responses.default.schema["$ref"]
  - code: LongRunningOperationsOptionsValidator
    from: InstanceFailoverGroups.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/locations/{locationName}/instanceFailoverGroups/{failoverGroupName}/forceFailoverAllowDataLoss"]
  - code: ResourceNameRestriction
    from: InstanceFailoverGroups.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/locations/{locationName}/instanceFailoverGroups/{failoverGroupName}/forceFailoverAllowDataLoss"]
  - code: ParameterNotDefinedInGlobalParameters
    from: InstanceFailoverGroups.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/locations/{locationName}/instanceFailoverGroups/{failoverGroupName}/forceFailoverAllowDataLoss"].post.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: InstanceFailoverGroups.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/locations/{locationName}/instanceFailoverGroups/{failoverGroupName}/forceFailoverAllowDataLoss"].post.responses.default.schema["$ref"]
  - code: LocationMustHaveXmsMutability
    from: InstanceFailoverGroups.json
    where: $.definitions.PartnerRegionInfo.properties.location
  - code: MissingSegmentsInNestedResourceListOperation
    from: InstancePoolOperations.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/instancePools/{instancePoolName}/operations"]
  - code: ParameterNotDefinedInGlobalParameters
    from: InstancePoolOperations.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/instancePools/{instancePoolName}/operations"].get.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: InstancePoolOperations.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/instancePools/{instancePoolName}/operations"].get.responses.default.schema["$ref"]
  - code: ParameterNotDefinedInGlobalParameters
    from: InstancePoolOperations.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/instancePools/{instancePoolName}/operations/{operationId}"].get.parameters
  - code: ParameterDescription
    from: InstancePoolOperations.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/instancePools/{instancePoolName}/operations/{operationId}"].get.parameters["2"]
  - code: ParameterNotUsingCommonTypes
    from: InstancePoolOperations.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/instancePools/{instancePoolName}/operations/{operationId}"].get.parameters["2"].name
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: InstancePoolOperations.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/instancePools/{instancePoolName}/operations/{operationId}"].get.responses.default.schema["$ref"]
  - code: PatchBodyParametersSchema
    from: InstancePools.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/instancePools/{instancePoolName}"].patch.parameters["2"].schema.properties.properties
  - code: PatchBodyParametersSchema
    from: InstancePools.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/instancePools/{instancePoolName}"].patch.parameters["2"].schema.properties.sku
  - code: ParameterNotDefinedInGlobalParameters
    from: InstancePools.json
    where: $.paths["/subscriptions/{subscriptionId}/providers/Microsoft.Sql/instancePools"].get.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: InstancePools.json
    where: $.paths["/subscriptions/{subscriptionId}/providers/Microsoft.Sql/instancePools"].get.responses.default.schema["$ref"]
  - code: ParameterNotDefinedInGlobalParameters
    from: InstancePools.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/instancePools"].get.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: InstancePools.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/instancePools"].get.responses.default.schema["$ref"]
  - code: ResourceNameRestriction
    from: InstancePools.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/instancePools/{instancePoolName}"]
  - code: ParameterNotDefinedInGlobalParameters
    from: InstancePools.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/instancePools/{instancePoolName}"].get.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: InstancePools.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/instancePools/{instancePoolName}"].get.responses.default.schema["$ref"]
  - code: ProvisioningStateSpecifiedForLROPut
    from: InstancePools.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/instancePools/{instancePoolName}"].put
  - code: PutResponseCodes
    from: InstancePools.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/instancePools/{instancePoolName}"].put
  - code: ParameterNotDefinedInGlobalParameters
    from: InstancePools.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/instancePools/{instancePoolName}"].put.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: InstancePools.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/instancePools/{instancePoolName}"].put.responses.default.schema["$ref"]
  - code: DeleteResponseCodes
    from: InstancePools.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/instancePools/{instancePoolName}"].delete
  - code: ParameterNotDefinedInGlobalParameters
    from: InstancePools.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/instancePools/{instancePoolName}"].delete.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: InstancePools.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/instancePools/{instancePoolName}"].delete.responses.default.schema["$ref"]
  - code: ParameterNotDefinedInGlobalParameters
    from: InstancePools.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/instancePools/{instancePoolName}"].patch.parameters
  - code: ProvisioningStateSpecifiedForLROPatch
    from: InstancePools.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/instancePools/{instancePoolName}"].patch.responses["200"]
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: InstancePools.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/instancePools/{instancePoolName}"].patch.responses.default.schema["$ref"]
  - code: MissingSegmentsInNestedResourceListOperation
    from: IPv6FirewallRules.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/ipv6FirewallRules"]
  - code: ResourceNameRestriction
    from: IPv6FirewallRules.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/ipv6FirewallRules"]
  - code: ParameterNotDefinedInGlobalParameters
    from: IPv6FirewallRules.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/ipv6FirewallRules"].get.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: IPv6FirewallRules.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/ipv6FirewallRules"].get.responses.default.schema["$ref"]
  - code: ResourceNameRestriction
    from: IPv6FirewallRules.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/ipv6FirewallRules/{firewallRuleName}"]
  - code: ParameterNotDefinedInGlobalParameters
    from: IPv6FirewallRules.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/ipv6FirewallRules/{firewallRuleName}"].get.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: IPv6FirewallRules.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/ipv6FirewallRules/{firewallRuleName}"].get.responses.default.schema["$ref"]
  - code: ParameterNotDefinedInGlobalParameters
    from: IPv6FirewallRules.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/ipv6FirewallRules/{firewallRuleName}"].put.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: IPv6FirewallRules.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/ipv6FirewallRules/{firewallRuleName}"].put.responses.default.schema["$ref"]
  - code: ParameterNotDefinedInGlobalParameters
    from: IPv6FirewallRules.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/ipv6FirewallRules/{firewallRuleName}"].delete.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: IPv6FirewallRules.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/ipv6FirewallRules/{firewallRuleName}"].delete.responses.default.schema["$ref"]
  - code: PatchBodyParametersSchema
    from: JobAgents.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/jobAgents/{jobAgentName}"].patch.parameters["3"].schema.properties.sku
  - code: MissingSegmentsInNestedResourceListOperation
    from: JobAgents.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/jobAgents"]
  - code: ResourceNameRestriction
    from: JobAgents.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/jobAgents"]
  - code: ParameterNotDefinedInGlobalParameters
    from: JobAgents.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/jobAgents"].get.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: JobAgents.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/jobAgents"].get.responses.default.schema["$ref"]
  - code: ResourceNameRestriction
    from: JobAgents.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/jobAgents/{jobAgentName}"]
  - code: ParameterNotDefinedInGlobalParameters
    from: JobAgents.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/jobAgents/{jobAgentName}"].get.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: JobAgents.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/jobAgents/{jobAgentName}"].get.responses.default.schema["$ref"]
  - code: ProvisioningStateSpecifiedForLROPut
    from: JobAgents.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/jobAgents/{jobAgentName}"].put
  - code: PutResponseCodes
    from: JobAgents.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/jobAgents/{jobAgentName}"].put
  - code: ParameterNotDefinedInGlobalParameters
    from: JobAgents.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/jobAgents/{jobAgentName}"].put.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: JobAgents.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/jobAgents/{jobAgentName}"].put.responses.default.schema["$ref"]
  - code: DeleteResponseCodes
    from: JobAgents.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/jobAgents/{jobAgentName}"].delete
  - code: ParameterNotDefinedInGlobalParameters
    from: JobAgents.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/jobAgents/{jobAgentName}"].delete.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: JobAgents.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/jobAgents/{jobAgentName}"].delete.responses.default.schema["$ref"]
  - code: ParameterNotDefinedInGlobalParameters
    from: JobAgents.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/jobAgents/{jobAgentName}"].patch.parameters
  - code: ProvisioningStateSpecifiedForLROPatch
    from: JobAgents.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/jobAgents/{jobAgentName}"].patch.responses["200"]
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: JobAgents.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/jobAgents/{jobAgentName}"].patch.responses.default.schema["$ref"]
  - code: MissingSegmentsInNestedResourceListOperation
    from: JobCredentials.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/jobAgents/{jobAgentName}/credentials"]
  - code: ResourceNameRestriction
    from: JobCredentials.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/jobAgents/{jobAgentName}/credentials"]
  - code: ParameterNotDefinedInGlobalParameters
    from: JobCredentials.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/jobAgents/{jobAgentName}/credentials"].get.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: JobCredentials.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/jobAgents/{jobAgentName}/credentials"].get.responses.default.schema["$ref"]
  - code: ResourceNameRestriction
    from: JobCredentials.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/jobAgents/{jobAgentName}/credentials/{credentialName}"]
  - code: ParameterNotDefinedInGlobalParameters
    from: JobCredentials.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/jobAgents/{jobAgentName}/credentials/{credentialName}"].get.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: JobCredentials.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/jobAgents/{jobAgentName}/credentials/{credentialName}"].get.responses.default.schema["$ref"]
  - code: ParameterNotDefinedInGlobalParameters
    from: JobCredentials.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/jobAgents/{jobAgentName}/credentials/{credentialName}"].put.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: JobCredentials.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/jobAgents/{jobAgentName}/credentials/{credentialName}"].put.responses.default.schema["$ref"]
  - code: ParameterNotDefinedInGlobalParameters
    from: JobCredentials.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/jobAgents/{jobAgentName}/credentials/{credentialName}"].delete.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: JobCredentials.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/jobAgents/{jobAgentName}/credentials/{credentialName}"].delete.responses.default.schema["$ref"]
  - code: MissingSegmentsInNestedResourceListOperation
    from: JobExecutions.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/jobAgents/{jobAgentName}/executions"]
  - code: ResourceNameRestriction
    from: JobExecutions.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/jobAgents/{jobAgentName}/executions"]
  - code: ParameterNotDefinedInGlobalParameters
    from: JobExecutions.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/jobAgents/{jobAgentName}/executions"].get.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: JobExecutions.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/jobAgents/{jobAgentName}/executions"].get.responses.default.schema["$ref"]
  - code: MissingSegmentsInNestedResourceListOperation
    from: JobExecutions.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/jobAgents/{jobAgentName}/jobs/{jobName}/executions"]
  - code: ResourceNameRestriction
    from: JobExecutions.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/jobAgents/{jobAgentName}/jobs/{jobName}/executions"]
  - code: ParameterNotDefinedInGlobalParameters
    from: JobExecutions.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/jobAgents/{jobAgentName}/jobs/{jobName}/executions"].get.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: JobExecutions.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/jobAgents/{jobAgentName}/jobs/{jobName}/executions"].get.responses.default.schema["$ref"]
  - code: ResourceNameRestriction
    from: JobExecutions.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/jobAgents/{jobAgentName}/jobs/{jobName}/executions/{jobExecutionId}"]
  - code: ParameterNotDefinedInGlobalParameters
    from: JobExecutions.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/jobAgents/{jobAgentName}/jobs/{jobName}/executions/{jobExecutionId}"].get.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: JobExecutions.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/jobAgents/{jobAgentName}/jobs/{jobName}/executions/{jobExecutionId}"].get.responses.default.schema["$ref"]
  - code: PutResponseCodes
    from: JobExecutions.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/jobAgents/{jobAgentName}/jobs/{jobName}/executions/{jobExecutionId}"].put
  - code: ParameterNotDefinedInGlobalParameters
    from: JobExecutions.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/jobAgents/{jobAgentName}/jobs/{jobName}/executions/{jobExecutionId}"].put.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: JobExecutions.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/jobAgents/{jobAgentName}/jobs/{jobName}/executions/{jobExecutionId}"].put.responses.default.schema["$ref"]
  - code: ResourceNameRestriction
    from: JobExecutions.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/jobAgents/{jobAgentName}/jobs/{jobName}/executions/{jobExecutionId}/cancel"]
  - code: ParameterNotDefinedInGlobalParameters
    from: JobExecutions.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/jobAgents/{jobAgentName}/jobs/{jobName}/executions/{jobExecutionId}/cancel"].post.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: JobExecutions.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/jobAgents/{jobAgentName}/jobs/{jobName}/executions/{jobExecutionId}/cancel"].post.responses.default.schema["$ref"]
  - code: LongRunningOperationsOptionsValidator
    from: JobExecutions.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/jobAgents/{jobAgentName}/jobs/{jobName}/start"]
  - code: ResourceNameRestriction
    from: JobExecutions.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/jobAgents/{jobAgentName}/jobs/{jobName}/start"]
  - code: ParameterNotDefinedInGlobalParameters
    from: JobExecutions.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/jobAgents/{jobAgentName}/jobs/{jobName}/start"].post.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: JobExecutions.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/jobAgents/{jobAgentName}/jobs/{jobName}/start"].post.responses.default.schema["$ref"]
  - code: MissingSegmentsInNestedResourceListOperation
    from: JobPrivateEndpoints.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/jobAgents/{jobAgentName}/privateEndpoints"]
  - code: ResourceNameRestriction
    from: JobPrivateEndpoints.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/jobAgents/{jobAgentName}/privateEndpoints"]
  - code: ParameterNotDefinedInGlobalParameters
    from: JobPrivateEndpoints.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/jobAgents/{jobAgentName}/privateEndpoints"].get.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: JobPrivateEndpoints.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/jobAgents/{jobAgentName}/privateEndpoints"].get.responses.default.schema["$ref"]
  - code: ResourceNameRestriction
    from: JobPrivateEndpoints.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/jobAgents/{jobAgentName}/privateEndpoints/{privateEndpointName}"]
  - code: ParameterNotDefinedInGlobalParameters
    from: JobPrivateEndpoints.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/jobAgents/{jobAgentName}/privateEndpoints/{privateEndpointName}"].get.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: JobPrivateEndpoints.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/jobAgents/{jobAgentName}/privateEndpoints/{privateEndpointName}"].get.responses.default.schema["$ref"]
  - code: ProvisioningStateSpecifiedForLROPut
    from: JobPrivateEndpoints.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/jobAgents/{jobAgentName}/privateEndpoints/{privateEndpointName}"].put
  - code: PutResponseCodes
    from: JobPrivateEndpoints.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/jobAgents/{jobAgentName}/privateEndpoints/{privateEndpointName}"].put
  - code: ParameterNotDefinedInGlobalParameters
    from: JobPrivateEndpoints.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/jobAgents/{jobAgentName}/privateEndpoints/{privateEndpointName}"].put.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: JobPrivateEndpoints.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/jobAgents/{jobAgentName}/privateEndpoints/{privateEndpointName}"].put.responses.default.schema["$ref"]
  - code: DeleteResponseCodes
    from: JobPrivateEndpoints.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/jobAgents/{jobAgentName}/privateEndpoints/{privateEndpointName}"].delete
  - code: ParameterNotDefinedInGlobalParameters
    from: JobPrivateEndpoints.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/jobAgents/{jobAgentName}/privateEndpoints/{privateEndpointName}"].delete.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: JobPrivateEndpoints.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/jobAgents/{jobAgentName}/privateEndpoints/{privateEndpointName}"].delete.responses.default.schema["$ref"]
  - code: MissingSegmentsInNestedResourceListOperation
    from: Jobs.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/jobAgents/{jobAgentName}/jobs"]
  - code: ResourceNameRestriction
    from: Jobs.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/jobAgents/{jobAgentName}/jobs"]
  - code: ParameterNotDefinedInGlobalParameters
    from: Jobs.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/jobAgents/{jobAgentName}/jobs"].get.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: Jobs.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/jobAgents/{jobAgentName}/jobs"].get.responses.default.schema["$ref"]
  - code: ResourceNameRestriction
    from: Jobs.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/jobAgents/{jobAgentName}/jobs/{jobName}"]
  - code: ParameterNotDefinedInGlobalParameters
    from: Jobs.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/jobAgents/{jobAgentName}/jobs/{jobName}"].get.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: Jobs.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/jobAgents/{jobAgentName}/jobs/{jobName}"].get.responses.default.schema["$ref"]
  - code: ParameterNotDefinedInGlobalParameters
    from: Jobs.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/jobAgents/{jobAgentName}/jobs/{jobName}"].put.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: Jobs.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/jobAgents/{jobAgentName}/jobs/{jobName}"].put.responses.default.schema["$ref"]
  - code: ParameterNotDefinedInGlobalParameters
    from: Jobs.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/jobAgents/{jobAgentName}/jobs/{jobName}"].delete.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: Jobs.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/jobAgents/{jobAgentName}/jobs/{jobName}"].delete.responses.default.schema["$ref"]
  - code: MissingSegmentsInNestedResourceListOperation
    from: JobStepExecutions.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/jobAgents/{jobAgentName}/jobs/{jobName}/executions/{jobExecutionId}/steps"]
  - code: ResourceNameRestriction
    from: JobStepExecutions.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/jobAgents/{jobAgentName}/jobs/{jobName}/executions/{jobExecutionId}/steps"]
  - code: ParameterNotDefinedInGlobalParameters
    from: JobStepExecutions.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/jobAgents/{jobAgentName}/jobs/{jobName}/executions/{jobExecutionId}/steps"].get.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: JobStepExecutions.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/jobAgents/{jobAgentName}/jobs/{jobName}/executions/{jobExecutionId}/steps"].get.responses.default.schema["$ref"]
  - code: ResourceNameRestriction
    from: JobStepExecutions.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/jobAgents/{jobAgentName}/jobs/{jobName}/executions/{jobExecutionId}/steps/{stepName}"]
  - code: ParameterNotDefinedInGlobalParameters
    from: JobStepExecutions.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/jobAgents/{jobAgentName}/jobs/{jobName}/executions/{jobExecutionId}/steps/{stepName}"].get.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: JobStepExecutions.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/jobAgents/{jobAgentName}/jobs/{jobName}/executions/{jobExecutionId}/steps/{stepName}"].get.responses.default.schema["$ref"]
  - code: MissingSegmentsInNestedResourceListOperation
    from: JobSteps.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/jobAgents/{jobAgentName}/jobs/{jobName}/steps"]
  - code: ResourceNameRestriction
    from: JobSteps.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/jobAgents/{jobAgentName}/jobs/{jobName}/steps"]
  - code: ParameterNotDefinedInGlobalParameters
    from: JobSteps.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/jobAgents/{jobAgentName}/jobs/{jobName}/steps"].get.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: JobSteps.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/jobAgents/{jobAgentName}/jobs/{jobName}/steps"].get.responses.default.schema["$ref"]
  - code: ResourceNameRestriction
    from: JobSteps.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/jobAgents/{jobAgentName}/jobs/{jobName}/steps/{stepName}"]
  - code: ParameterNotDefinedInGlobalParameters
    from: JobSteps.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/jobAgents/{jobAgentName}/jobs/{jobName}/steps/{stepName}"].get.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: JobSteps.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/jobAgents/{jobAgentName}/jobs/{jobName}/steps/{stepName}"].get.responses.default.schema["$ref"]
  - code: ParameterNotDefinedInGlobalParameters
    from: JobSteps.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/jobAgents/{jobAgentName}/jobs/{jobName}/steps/{stepName}"].put.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: JobSteps.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/jobAgents/{jobAgentName}/jobs/{jobName}/steps/{stepName}"].put.responses.default.schema["$ref"]
  - code: ParameterNotDefinedInGlobalParameters
    from: JobSteps.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/jobAgents/{jobAgentName}/jobs/{jobName}/steps/{stepName}"].delete.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: JobSteps.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/jobAgents/{jobAgentName}/jobs/{jobName}/steps/{stepName}"].delete.responses.default.schema["$ref"]
  - code: MissingSegmentsInNestedResourceListOperation
    from: JobSteps.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/jobAgents/{jobAgentName}/jobs/{jobName}/versions/{jobVersion}/steps"]
  - code: ResourceNameRestriction
    from: JobSteps.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/jobAgents/{jobAgentName}/jobs/{jobName}/versions/{jobVersion}/steps"]
  - code: ParameterNotDefinedInGlobalParameters
    from: JobSteps.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/jobAgents/{jobAgentName}/jobs/{jobName}/versions/{jobVersion}/steps"].get.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: JobSteps.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/jobAgents/{jobAgentName}/jobs/{jobName}/versions/{jobVersion}/steps"].get.responses.default.schema["$ref"]
  - code: ResourceNameRestriction
    from: JobSteps.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/jobAgents/{jobAgentName}/jobs/{jobName}/versions/{jobVersion}/steps/{stepName}"]
  - code: ParameterNotDefinedInGlobalParameters
    from: JobSteps.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/jobAgents/{jobAgentName}/jobs/{jobName}/versions/{jobVersion}/steps/{stepName}"].get.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: JobSteps.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/jobAgents/{jobAgentName}/jobs/{jobName}/versions/{jobVersion}/steps/{stepName}"].get.responses.default.schema["$ref"]
  - code: MissingSegmentsInNestedResourceListOperation
    from: JobTargetExecutions.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/jobAgents/{jobAgentName}/jobs/{jobName}/executions/{jobExecutionId}/steps/{stepName}/targets"]
  - code: ResourceNameRestriction
    from: JobTargetExecutions.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/jobAgents/{jobAgentName}/jobs/{jobName}/executions/{jobExecutionId}/steps/{stepName}/targets"]
  - code: ParameterNotDefinedInGlobalParameters
    from: JobTargetExecutions.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/jobAgents/{jobAgentName}/jobs/{jobName}/executions/{jobExecutionId}/steps/{stepName}/targets"].get.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: JobTargetExecutions.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/jobAgents/{jobAgentName}/jobs/{jobName}/executions/{jobExecutionId}/steps/{stepName}/targets"].get.responses.default.schema["$ref"]
  - code: ResourceNameRestriction
    from: JobTargetExecutions.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/jobAgents/{jobAgentName}/jobs/{jobName}/executions/{jobExecutionId}/steps/{stepName}/targets/{targetId}"]
  - code: ParameterNotDefinedInGlobalParameters
    from: JobTargetExecutions.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/jobAgents/{jobAgentName}/jobs/{jobName}/executions/{jobExecutionId}/steps/{stepName}/targets/{targetId}"].get.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: JobTargetExecutions.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/jobAgents/{jobAgentName}/jobs/{jobName}/executions/{jobExecutionId}/steps/{stepName}/targets/{targetId}"].get.responses.default.schema["$ref"]
  - code: MissingSegmentsInNestedResourceListOperation
    from: JobTargetExecutions.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/jobAgents/{jobAgentName}/jobs/{jobName}/executions/{jobExecutionId}/targets"]
  - code: ResourceNameRestriction
    from: JobTargetExecutions.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/jobAgents/{jobAgentName}/jobs/{jobName}/executions/{jobExecutionId}/targets"]
  - code: ParameterNotDefinedInGlobalParameters
    from: JobTargetExecutions.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/jobAgents/{jobAgentName}/jobs/{jobName}/executions/{jobExecutionId}/targets"].get.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: JobTargetExecutions.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/jobAgents/{jobAgentName}/jobs/{jobName}/executions/{jobExecutionId}/targets"].get.responses.default.schema["$ref"]
  - code: MissingSegmentsInNestedResourceListOperation
    from: JobTargetGroups.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/jobAgents/{jobAgentName}/targetGroups"]
  - code: ResourceNameRestriction
    from: JobTargetGroups.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/jobAgents/{jobAgentName}/targetGroups"]
  - code: ParameterNotDefinedInGlobalParameters
    from: JobTargetGroups.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/jobAgents/{jobAgentName}/targetGroups"].get.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: JobTargetGroups.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/jobAgents/{jobAgentName}/targetGroups"].get.responses.default.schema["$ref"]
  - code: ResourceNameRestriction
    from: JobTargetGroups.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/jobAgents/{jobAgentName}/targetGroups/{targetGroupName}"]
  - code: ParameterNotDefinedInGlobalParameters
    from: JobTargetGroups.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/jobAgents/{jobAgentName}/targetGroups/{targetGroupName}"].get.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: JobTargetGroups.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/jobAgents/{jobAgentName}/targetGroups/{targetGroupName}"].get.responses.default.schema["$ref"]
  - code: ParameterNotDefinedInGlobalParameters
    from: JobTargetGroups.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/jobAgents/{jobAgentName}/targetGroups/{targetGroupName}"].put.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: JobTargetGroups.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/jobAgents/{jobAgentName}/targetGroups/{targetGroupName}"].put.responses.default.schema["$ref"]
  - code: ParameterNotDefinedInGlobalParameters
    from: JobTargetGroups.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/jobAgents/{jobAgentName}/targetGroups/{targetGroupName}"].delete.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: JobTargetGroups.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/jobAgents/{jobAgentName}/targetGroups/{targetGroupName}"].delete.responses.default.schema["$ref"]
  - code: MissingSegmentsInNestedResourceListOperation
    from: JobVersions.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/jobAgents/{jobAgentName}/jobs/{jobName}/versions"]
  - code: ResourceNameRestriction
    from: JobVersions.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/jobAgents/{jobAgentName}/jobs/{jobName}/versions"]
  - code: ParameterNotDefinedInGlobalParameters
    from: JobVersions.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/jobAgents/{jobAgentName}/jobs/{jobName}/versions"].get.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: JobVersions.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/jobAgents/{jobAgentName}/jobs/{jobName}/versions"].get.responses.default.schema["$ref"]
  - code: ResourceNameRestriction
    from: JobVersions.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/jobAgents/{jobAgentName}/jobs/{jobName}/versions/{jobVersion}"]
  - code: ParameterNotDefinedInGlobalParameters
    from: JobVersions.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/jobAgents/{jobAgentName}/jobs/{jobName}/versions/{jobVersion}"].get.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: JobVersions.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/jobAgents/{jobAgentName}/jobs/{jobName}/versions/{jobVersion}"].get.responses.default.schema["$ref"]
  - code: MissingSegmentsInNestedResourceListOperation
    from: LedgerDigestUploads.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/ledgerDigestUploads"]
  - code: ResourceNameRestriction
    from: LedgerDigestUploads.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/ledgerDigestUploads"]
  - code: OperationIdNounConflictingModelNames
    from: LedgerDigestUploads.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/ledgerDigestUploads"].get.operationId
  - code: ParameterNotDefinedInGlobalParameters
    from: LedgerDigestUploads.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/ledgerDigestUploads"].get.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: LedgerDigestUploads.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/ledgerDigestUploads"].get.responses.default.schema["$ref"]
  - code: ResourceNameRestriction
    from: LedgerDigestUploads.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/ledgerDigestUploads/{ledgerDigestUploads}"]
  - code: OperationIdNounConflictingModelNames
    from: LedgerDigestUploads.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/ledgerDigestUploads/{ledgerDigestUploads}"].get.operationId
  - code: ParameterNotDefinedInGlobalParameters
    from: LedgerDigestUploads.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/ledgerDigestUploads/{ledgerDigestUploads}"].get.parameters
  - code: ParameterDescription
    from: LedgerDigestUploads.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/ledgerDigestUploads/{ledgerDigestUploads}"].get.parameters["3"]
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: LedgerDigestUploads.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/ledgerDigestUploads/{ledgerDigestUploads}"].get.responses.default.schema["$ref"]
  - code: ProvisioningStateSpecifiedForLROPut
    from: LedgerDigestUploads.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/ledgerDigestUploads/{ledgerDigestUploads}"].put
  - code: PutResponseCodes
    from: LedgerDigestUploads.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/ledgerDigestUploads/{ledgerDigestUploads}"].put
  - code: OperationIdNounConflictingModelNames
    from: LedgerDigestUploads.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/ledgerDigestUploads/{ledgerDigestUploads}"].put.operationId
  - code: ParameterNotDefinedInGlobalParameters
    from: LedgerDigestUploads.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/ledgerDigestUploads/{ledgerDigestUploads}"].put.parameters
  - code: ParameterDescription
    from: LedgerDigestUploads.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/ledgerDigestUploads/{ledgerDigestUploads}"].put.parameters["3"]
  - code: ParameterDescription
    from: LedgerDigestUploads.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/ledgerDigestUploads/{ledgerDigestUploads}"].put.parameters["4"]
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: LedgerDigestUploads.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/ledgerDigestUploads/{ledgerDigestUploads}"].put.responses.default.schema["$ref"]
  - code: LongRunningOperationsOptionsValidator
    from: LedgerDigestUploads.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/ledgerDigestUploads/{ledgerDigestUploads}/disable"]
  - code: ResourceNameRestriction
    from: LedgerDigestUploads.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/ledgerDigestUploads/{ledgerDigestUploads}/disable"]
  - code: OperationIdNounConflictingModelNames
    from: LedgerDigestUploads.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/ledgerDigestUploads/{ledgerDigestUploads}/disable"].post.operationId
  - code: ParameterNotDefinedInGlobalParameters
    from: LedgerDigestUploads.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/ledgerDigestUploads/{ledgerDigestUploads}/disable"].post.parameters
  - code: ParameterDescription
    from: LedgerDigestUploads.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/ledgerDigestUploads/{ledgerDigestUploads}/disable"].post.parameters["3"]
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: LedgerDigestUploads.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/ledgerDigestUploads/{ledgerDigestUploads}/disable"].post.responses.default.schema["$ref"]
  - code: GetCollectionOnlyHasValueAndNextLink
    from: LocationCapabilities.json
    where: $.paths["/subscriptions/{subscriptionId}/providers/Microsoft.Sql/locations/{locationName}/capabilities"].get.responses["200"].schema.properties
  - code: ResourceNameRestriction
    from: LocationCapabilities.json
    where: $.paths["/subscriptions/{subscriptionId}/providers/Microsoft.Sql/locations/{locationName}/capabilities"]
  - code: XmsPageableForListCalls
    from: LocationCapabilities.json
    where: $.paths["/subscriptions/{subscriptionId}/providers/Microsoft.Sql/locations/{locationName}/capabilities"].get
  - code: ParameterNotDefinedInGlobalParameters
    from: LocationCapabilities.json
    where: $.paths["/subscriptions/{subscriptionId}/providers/Microsoft.Sql/locations/{locationName}/capabilities"].get.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: LocationCapabilities.json
    where: $.paths["/subscriptions/{subscriptionId}/providers/Microsoft.Sql/locations/{locationName}/capabilities"].get.responses.default.schema["$ref"]
  - code: ResourceNameRestriction
    from: LongTermRetentionBackups.json
    where: $.paths["/subscriptions/{subscriptionId}/providers/Microsoft.Sql/locations/{locationName}/longTermRetentionBackups"]
  - code: ParameterNotDefinedInGlobalParameters
    from: LongTermRetentionBackups.json
    where: $.paths["/subscriptions/{subscriptionId}/providers/Microsoft.Sql/locations/{locationName}/longTermRetentionBackups"].get.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: LongTermRetentionBackups.json
    where: $.paths["/subscriptions/{subscriptionId}/providers/Microsoft.Sql/locations/{locationName}/longTermRetentionBackups"].get.responses.default.schema["$ref"]
  - code: ResourceNameRestriction
    from: LongTermRetentionBackups.json
    where: $.paths["/subscriptions/{subscriptionId}/providers/Microsoft.Sql/locations/{locationName}/longTermRetentionServers/{longTermRetentionServerName}/longTermRetentionBackups"]
  - code: ParameterNotDefinedInGlobalParameters
    from: LongTermRetentionBackups.json
    where: $.paths["/subscriptions/{subscriptionId}/providers/Microsoft.Sql/locations/{locationName}/longTermRetentionServers/{longTermRetentionServerName}/longTermRetentionBackups"].get.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: LongTermRetentionBackups.json
    where: $.paths["/subscriptions/{subscriptionId}/providers/Microsoft.Sql/locations/{locationName}/longTermRetentionServers/{longTermRetentionServerName}/longTermRetentionBackups"].get.responses.default.schema["$ref"]
  - code: ResourceNameRestriction
    from: LongTermRetentionBackups.json
    where: $.paths["/subscriptions/{subscriptionId}/providers/Microsoft.Sql/locations/{locationName}/longTermRetentionServers/{longTermRetentionServerName}/longTermRetentionDatabases/{longTermRetentionDatabaseName}/longTermRetentionBackups"]
  - code: ParameterNotDefinedInGlobalParameters
    from: LongTermRetentionBackups.json
    where: $.paths["/subscriptions/{subscriptionId}/providers/Microsoft.Sql/locations/{locationName}/longTermRetentionServers/{longTermRetentionServerName}/longTermRetentionDatabases/{longTermRetentionDatabaseName}/longTermRetentionBackups"].get.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: LongTermRetentionBackups.json
    where: $.paths["/subscriptions/{subscriptionId}/providers/Microsoft.Sql/locations/{locationName}/longTermRetentionServers/{longTermRetentionServerName}/longTermRetentionDatabases/{longTermRetentionDatabaseName}/longTermRetentionBackups"].get.responses.default.schema["$ref"]
  - code: ResourceNameRestriction
    from: LongTermRetentionBackups.json
    where: $.paths["/subscriptions/{subscriptionId}/providers/Microsoft.Sql/locations/{locationName}/longTermRetentionServers/{longTermRetentionServerName}/longTermRetentionDatabases/{longTermRetentionDatabaseName}/longTermRetentionBackups/{backupName}"]
  - code: ParameterNotDefinedInGlobalParameters
    from: LongTermRetentionBackups.json
    where: $.paths["/subscriptions/{subscriptionId}/providers/Microsoft.Sql/locations/{locationName}/longTermRetentionServers/{longTermRetentionServerName}/longTermRetentionDatabases/{longTermRetentionDatabaseName}/longTermRetentionBackups/{backupName}"].get.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: LongTermRetentionBackups.json
    where: $.paths["/subscriptions/{subscriptionId}/providers/Microsoft.Sql/locations/{locationName}/longTermRetentionServers/{longTermRetentionServerName}/longTermRetentionDatabases/{longTermRetentionDatabaseName}/longTermRetentionBackups/{backupName}"].get.responses.default.schema["$ref"]
  - code: DeleteResponseCodes
    from: LongTermRetentionBackups.json
    where: $.paths["/subscriptions/{subscriptionId}/providers/Microsoft.Sql/locations/{locationName}/longTermRetentionServers/{longTermRetentionServerName}/longTermRetentionDatabases/{longTermRetentionDatabaseName}/longTermRetentionBackups/{backupName}"].delete
  - code: ParameterNotDefinedInGlobalParameters
    from: LongTermRetentionBackups.json
    where: $.paths["/subscriptions/{subscriptionId}/providers/Microsoft.Sql/locations/{locationName}/longTermRetentionServers/{longTermRetentionServerName}/longTermRetentionDatabases/{longTermRetentionDatabaseName}/longTermRetentionBackups/{backupName}"].delete.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: LongTermRetentionBackups.json
    where: $.paths["/subscriptions/{subscriptionId}/providers/Microsoft.Sql/locations/{locationName}/longTermRetentionServers/{longTermRetentionServerName}/longTermRetentionDatabases/{longTermRetentionDatabaseName}/longTermRetentionBackups/{backupName}"].delete.responses.default.schema["$ref"]
  - code: LongRunningOperationsOptionsValidator
    from: LongTermRetentionBackups.json
    where: $.paths["/subscriptions/{subscriptionId}/providers/Microsoft.Sql/locations/{locationName}/longTermRetentionServers/{longTermRetentionServerName}/longTermRetentionDatabases/{longTermRetentionDatabaseName}/longTermRetentionBackups/{backupName}/changeAccessTier"]
  - code: ResourceNameRestriction
    from: LongTermRetentionBackups.json
    where: $.paths["/subscriptions/{subscriptionId}/providers/Microsoft.Sql/locations/{locationName}/longTermRetentionServers/{longTermRetentionServerName}/longTermRetentionDatabases/{longTermRetentionDatabaseName}/longTermRetentionBackups/{backupName}/changeAccessTier"]
  - code: ParameterNotDefinedInGlobalParameters
    from: LongTermRetentionBackups.json
    where: $.paths["/subscriptions/{subscriptionId}/providers/Microsoft.Sql/locations/{locationName}/longTermRetentionServers/{longTermRetentionServerName}/longTermRetentionDatabases/{longTermRetentionDatabaseName}/longTermRetentionBackups/{backupName}/changeAccessTier"].post.parameters
  - code: ParameterDescription
    from: LongTermRetentionBackups.json
    where: $.paths["/subscriptions/{subscriptionId}/providers/Microsoft.Sql/locations/{locationName}/longTermRetentionServers/{longTermRetentionServerName}/longTermRetentionDatabases/{longTermRetentionDatabaseName}/longTermRetentionBackups/{backupName}/changeAccessTier"].post.parameters["0"]
  - code: ParameterDescription
    from: LongTermRetentionBackups.json
    where: $.paths["/subscriptions/{subscriptionId}/providers/Microsoft.Sql/locations/{locationName}/longTermRetentionServers/{longTermRetentionServerName}/longTermRetentionDatabases/{longTermRetentionDatabaseName}/longTermRetentionBackups/{backupName}/changeAccessTier"].post.parameters["1"]
  - code: ParameterDescription
    from: LongTermRetentionBackups.json
    where: $.paths["/subscriptions/{subscriptionId}/providers/Microsoft.Sql/locations/{locationName}/longTermRetentionServers/{longTermRetentionServerName}/longTermRetentionDatabases/{longTermRetentionDatabaseName}/longTermRetentionBackups/{backupName}/changeAccessTier"].post.parameters["2"]
  - code: ParameterDescription
    from: LongTermRetentionBackups.json
    where: $.paths["/subscriptions/{subscriptionId}/providers/Microsoft.Sql/locations/{locationName}/longTermRetentionServers/{longTermRetentionServerName}/longTermRetentionDatabases/{longTermRetentionDatabaseName}/longTermRetentionBackups/{backupName}/changeAccessTier"].post.parameters["3"]
  - code: ParameterDescription
    from: LongTermRetentionBackups.json
    where: $.paths["/subscriptions/{subscriptionId}/providers/Microsoft.Sql/locations/{locationName}/longTermRetentionServers/{longTermRetentionServerName}/longTermRetentionDatabases/{longTermRetentionDatabaseName}/longTermRetentionBackups/{backupName}/changeAccessTier"].post.parameters["4"]
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: LongTermRetentionBackups.json
    where: $.paths["/subscriptions/{subscriptionId}/providers/Microsoft.Sql/locations/{locationName}/longTermRetentionServers/{longTermRetentionServerName}/longTermRetentionDatabases/{longTermRetentionDatabaseName}/longTermRetentionBackups/{backupName}/changeAccessTier"].post.responses.default.schema["$ref"]
  - code: LongRunningOperationsOptionsValidator
    from: LongTermRetentionBackups.json
    where: $.paths["/subscriptions/{subscriptionId}/providers/Microsoft.Sql/locations/{locationName}/longTermRetentionServers/{longTermRetentionServerName}/longTermRetentionDatabases/{longTermRetentionDatabaseName}/longTermRetentionBackups/{backupName}/copy"]
  - code: ResourceNameRestriction
    from: LongTermRetentionBackups.json
    where: $.paths["/subscriptions/{subscriptionId}/providers/Microsoft.Sql/locations/{locationName}/longTermRetentionServers/{longTermRetentionServerName}/longTermRetentionDatabases/{longTermRetentionDatabaseName}/longTermRetentionBackups/{backupName}/copy"]
  - code: ParameterNotDefinedInGlobalParameters
    from: LongTermRetentionBackups.json
    where: $.paths["/subscriptions/{subscriptionId}/providers/Microsoft.Sql/locations/{locationName}/longTermRetentionServers/{longTermRetentionServerName}/longTermRetentionDatabases/{longTermRetentionDatabaseName}/longTermRetentionBackups/{backupName}/copy"].post.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: LongTermRetentionBackups.json
    where: $.paths["/subscriptions/{subscriptionId}/providers/Microsoft.Sql/locations/{locationName}/longTermRetentionServers/{longTermRetentionServerName}/longTermRetentionDatabases/{longTermRetentionDatabaseName}/longTermRetentionBackups/{backupName}/copy"].post.responses.default.schema["$ref"]
  - code: LongRunningOperationsOptionsValidator
    from: LongTermRetentionBackups.json
    where: $.paths["/subscriptions/{subscriptionId}/providers/Microsoft.Sql/locations/{locationName}/longTermRetentionServers/{longTermRetentionServerName}/longTermRetentionDatabases/{longTermRetentionDatabaseName}/longTermRetentionBackups/{backupName}/lockTimeBasedImmutability"]
  - code: ResourceNameRestriction
    from: LongTermRetentionBackups.json
    where: $.paths["/subscriptions/{subscriptionId}/providers/Microsoft.Sql/locations/{locationName}/longTermRetentionServers/{longTermRetentionServerName}/longTermRetentionDatabases/{longTermRetentionDatabaseName}/longTermRetentionBackups/{backupName}/lockTimeBasedImmutability"]
  - code: ParameterNotDefinedInGlobalParameters
    from: LongTermRetentionBackups.json
    where: $.paths["/subscriptions/{subscriptionId}/providers/Microsoft.Sql/locations/{locationName}/longTermRetentionServers/{longTermRetentionServerName}/longTermRetentionDatabases/{longTermRetentionDatabaseName}/longTermRetentionBackups/{backupName}/lockTimeBasedImmutability"].post.parameters
  - code: ParameterDescription
    from: LongTermRetentionBackups.json
    where: $.paths["/subscriptions/{subscriptionId}/providers/Microsoft.Sql/locations/{locationName}/longTermRetentionServers/{longTermRetentionServerName}/longTermRetentionDatabases/{longTermRetentionDatabaseName}/longTermRetentionBackups/{backupName}/lockTimeBasedImmutability"].post.parameters["0"]
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: LongTermRetentionBackups.json
    where: $.paths["/subscriptions/{subscriptionId}/providers/Microsoft.Sql/locations/{locationName}/longTermRetentionServers/{longTermRetentionServerName}/longTermRetentionDatabases/{longTermRetentionDatabaseName}/longTermRetentionBackups/{backupName}/lockTimeBasedImmutability"].post.responses.default.schema["$ref"]
  - code: LongRunningOperationsOptionsValidator
    from: LongTermRetentionBackups.json
    where: $.paths["/subscriptions/{subscriptionId}/providers/Microsoft.Sql/locations/{locationName}/longTermRetentionServers/{longTermRetentionServerName}/longTermRetentionDatabases/{longTermRetentionDatabaseName}/longTermRetentionBackups/{backupName}/removeLegalHoldImmutability"]
  - code: ResourceNameRestriction
    from: LongTermRetentionBackups.json
    where: $.paths["/subscriptions/{subscriptionId}/providers/Microsoft.Sql/locations/{locationName}/longTermRetentionServers/{longTermRetentionServerName}/longTermRetentionDatabases/{longTermRetentionDatabaseName}/longTermRetentionBackups/{backupName}/removeLegalHoldImmutability"]
  - code: ParameterNotDefinedInGlobalParameters
    from: LongTermRetentionBackups.json
    where: $.paths["/subscriptions/{subscriptionId}/providers/Microsoft.Sql/locations/{locationName}/longTermRetentionServers/{longTermRetentionServerName}/longTermRetentionDatabases/{longTermRetentionDatabaseName}/longTermRetentionBackups/{backupName}/removeLegalHoldImmutability"].post.parameters
  - code: ParameterDescription
    from: LongTermRetentionBackups.json
    where: $.paths["/subscriptions/{subscriptionId}/providers/Microsoft.Sql/locations/{locationName}/longTermRetentionServers/{longTermRetentionServerName}/longTermRetentionDatabases/{longTermRetentionDatabaseName}/longTermRetentionBackups/{backupName}/removeLegalHoldImmutability"].post.parameters["0"]
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: LongTermRetentionBackups.json
    where: $.paths["/subscriptions/{subscriptionId}/providers/Microsoft.Sql/locations/{locationName}/longTermRetentionServers/{longTermRetentionServerName}/longTermRetentionDatabases/{longTermRetentionDatabaseName}/longTermRetentionBackups/{backupName}/removeLegalHoldImmutability"].post.responses.default.schema["$ref"]
  - code: LongRunningOperationsOptionsValidator
    from: LongTermRetentionBackups.json
    where: $.paths["/subscriptions/{subscriptionId}/providers/Microsoft.Sql/locations/{locationName}/longTermRetentionServers/{longTermRetentionServerName}/longTermRetentionDatabases/{longTermRetentionDatabaseName}/longTermRetentionBackups/{backupName}/removeTimeBasedImmutability"]
  - code: ResourceNameRestriction
    from: LongTermRetentionBackups.json
    where: $.paths["/subscriptions/{subscriptionId}/providers/Microsoft.Sql/locations/{locationName}/longTermRetentionServers/{longTermRetentionServerName}/longTermRetentionDatabases/{longTermRetentionDatabaseName}/longTermRetentionBackups/{backupName}/removeTimeBasedImmutability"]
  - code: ParameterNotDefinedInGlobalParameters
    from: LongTermRetentionBackups.json
    where: $.paths["/subscriptions/{subscriptionId}/providers/Microsoft.Sql/locations/{locationName}/longTermRetentionServers/{longTermRetentionServerName}/longTermRetentionDatabases/{longTermRetentionDatabaseName}/longTermRetentionBackups/{backupName}/removeTimeBasedImmutability"].post.parameters
  - code: ParameterDescription
    from: LongTermRetentionBackups.json
    where: $.paths["/subscriptions/{subscriptionId}/providers/Microsoft.Sql/locations/{locationName}/longTermRetentionServers/{longTermRetentionServerName}/longTermRetentionDatabases/{longTermRetentionDatabaseName}/longTermRetentionBackups/{backupName}/removeTimeBasedImmutability"].post.parameters["0"]
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: LongTermRetentionBackups.json
    where: $.paths["/subscriptions/{subscriptionId}/providers/Microsoft.Sql/locations/{locationName}/longTermRetentionServers/{longTermRetentionServerName}/longTermRetentionDatabases/{longTermRetentionDatabaseName}/longTermRetentionBackups/{backupName}/removeTimeBasedImmutability"].post.responses.default.schema["$ref"]
  - code: LongRunningOperationsOptionsValidator
    from: LongTermRetentionBackups.json
    where: $.paths["/subscriptions/{subscriptionId}/providers/Microsoft.Sql/locations/{locationName}/longTermRetentionServers/{longTermRetentionServerName}/longTermRetentionDatabases/{longTermRetentionDatabaseName}/longTermRetentionBackups/{backupName}/setLegalHoldImmutability"]
  - code: ResourceNameRestriction
    from: LongTermRetentionBackups.json
    where: $.paths["/subscriptions/{subscriptionId}/providers/Microsoft.Sql/locations/{locationName}/longTermRetentionServers/{longTermRetentionServerName}/longTermRetentionDatabases/{longTermRetentionDatabaseName}/longTermRetentionBackups/{backupName}/setLegalHoldImmutability"]
  - code: ParameterNotDefinedInGlobalParameters
    from: LongTermRetentionBackups.json
    where: $.paths["/subscriptions/{subscriptionId}/providers/Microsoft.Sql/locations/{locationName}/longTermRetentionServers/{longTermRetentionServerName}/longTermRetentionDatabases/{longTermRetentionDatabaseName}/longTermRetentionBackups/{backupName}/setLegalHoldImmutability"].post.parameters
  - code: ParameterDescription
    from: LongTermRetentionBackups.json
    where: $.paths["/subscriptions/{subscriptionId}/providers/Microsoft.Sql/locations/{locationName}/longTermRetentionServers/{longTermRetentionServerName}/longTermRetentionDatabases/{longTermRetentionDatabaseName}/longTermRetentionBackups/{backupName}/setLegalHoldImmutability"].post.parameters["0"]
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: LongTermRetentionBackups.json
    where: $.paths["/subscriptions/{subscriptionId}/providers/Microsoft.Sql/locations/{locationName}/longTermRetentionServers/{longTermRetentionServerName}/longTermRetentionDatabases/{longTermRetentionDatabaseName}/longTermRetentionBackups/{backupName}/setLegalHoldImmutability"].post.responses.default.schema["$ref"]
  - code: LongRunningOperationsOptionsValidator
    from: LongTermRetentionBackups.json
    where: $.paths["/subscriptions/{subscriptionId}/providers/Microsoft.Sql/locations/{locationName}/longTermRetentionServers/{longTermRetentionServerName}/longTermRetentionDatabases/{longTermRetentionDatabaseName}/longTermRetentionBackups/{backupName}/update"]
  - code: ResourceNameRestriction
    from: LongTermRetentionBackups.json
    where: $.paths["/subscriptions/{subscriptionId}/providers/Microsoft.Sql/locations/{locationName}/longTermRetentionServers/{longTermRetentionServerName}/longTermRetentionDatabases/{longTermRetentionDatabaseName}/longTermRetentionBackups/{backupName}/update"]
  - code: ParameterNotDefinedInGlobalParameters
    from: LongTermRetentionBackups.json
    where: $.paths["/subscriptions/{subscriptionId}/providers/Microsoft.Sql/locations/{locationName}/longTermRetentionServers/{longTermRetentionServerName}/longTermRetentionDatabases/{longTermRetentionDatabaseName}/longTermRetentionBackups/{backupName}/update"].post.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: LongTermRetentionBackups.json
    where: $.paths["/subscriptions/{subscriptionId}/providers/Microsoft.Sql/locations/{locationName}/longTermRetentionServers/{longTermRetentionServerName}/longTermRetentionDatabases/{longTermRetentionDatabaseName}/longTermRetentionBackups/{backupName}/update"].post.responses.default.schema["$ref"]
  - code: MissingSegmentsInNestedResourceListOperation
    from: LongTermRetentionBackups.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/locations/{locationName}/longTermRetentionBackups"]
  - code: ResourceNameRestriction
    from: LongTermRetentionBackups.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/locations/{locationName}/longTermRetentionBackups"]
  - code: ParameterNotDefinedInGlobalParameters
    from: LongTermRetentionBackups.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/locations/{locationName}/longTermRetentionBackups"].get.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: LongTermRetentionBackups.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/locations/{locationName}/longTermRetentionBackups"].get.responses.default.schema["$ref"]
  - code: MissingSegmentsInNestedResourceListOperation
    from: LongTermRetentionBackups.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/locations/{locationName}/longTermRetentionServers/{longTermRetentionServerName}/longTermRetentionBackups"]
  - code: ResourceNameRestriction
    from: LongTermRetentionBackups.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/locations/{locationName}/longTermRetentionServers/{longTermRetentionServerName}/longTermRetentionBackups"]
  - code: ParameterNotDefinedInGlobalParameters
    from: LongTermRetentionBackups.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/locations/{locationName}/longTermRetentionServers/{longTermRetentionServerName}/longTermRetentionBackups"].get.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: LongTermRetentionBackups.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/locations/{locationName}/longTermRetentionServers/{longTermRetentionServerName}/longTermRetentionBackups"].get.responses.default.schema["$ref"]
  - code: MissingSegmentsInNestedResourceListOperation
    from: LongTermRetentionBackups.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/locations/{locationName}/longTermRetentionServers/{longTermRetentionServerName}/longTermRetentionDatabases/{longTermRetentionDatabaseName}/longTermRetentionBackups"]
  - code: ResourceNameRestriction
    from: LongTermRetentionBackups.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/locations/{locationName}/longTermRetentionServers/{longTermRetentionServerName}/longTermRetentionDatabases/{longTermRetentionDatabaseName}/longTermRetentionBackups"]
  - code: ParameterNotDefinedInGlobalParameters
    from: LongTermRetentionBackups.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/locations/{locationName}/longTermRetentionServers/{longTermRetentionServerName}/longTermRetentionDatabases/{longTermRetentionDatabaseName}/longTermRetentionBackups"].get.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: LongTermRetentionBackups.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/locations/{locationName}/longTermRetentionServers/{longTermRetentionServerName}/longTermRetentionDatabases/{longTermRetentionDatabaseName}/longTermRetentionBackups"].get.responses.default.schema["$ref"]
  - code: ResourceNameRestriction
    from: LongTermRetentionBackups.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/locations/{locationName}/longTermRetentionServers/{longTermRetentionServerName}/longTermRetentionDatabases/{longTermRetentionDatabaseName}/longTermRetentionBackups/{backupName}"]
  - code: ParameterNotDefinedInGlobalParameters
    from: LongTermRetentionBackups.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/locations/{locationName}/longTermRetentionServers/{longTermRetentionServerName}/longTermRetentionDatabases/{longTermRetentionDatabaseName}/longTermRetentionBackups/{backupName}"].get.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: LongTermRetentionBackups.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/locations/{locationName}/longTermRetentionServers/{longTermRetentionServerName}/longTermRetentionDatabases/{longTermRetentionDatabaseName}/longTermRetentionBackups/{backupName}"].get.responses.default.schema["$ref"]
  - code: DeleteResponseCodes
    from: LongTermRetentionBackups.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/locations/{locationName}/longTermRetentionServers/{longTermRetentionServerName}/longTermRetentionDatabases/{longTermRetentionDatabaseName}/longTermRetentionBackups/{backupName}"].delete
  - code: ParameterNotDefinedInGlobalParameters
    from: LongTermRetentionBackups.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/locations/{locationName}/longTermRetentionServers/{longTermRetentionServerName}/longTermRetentionDatabases/{longTermRetentionDatabaseName}/longTermRetentionBackups/{backupName}"].delete.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: LongTermRetentionBackups.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/locations/{locationName}/longTermRetentionServers/{longTermRetentionServerName}/longTermRetentionDatabases/{longTermRetentionDatabaseName}/longTermRetentionBackups/{backupName}"].delete.responses.default.schema["$ref"]
  - code: LongRunningOperationsOptionsValidator
    from: LongTermRetentionBackups.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/locations/{locationName}/longTermRetentionServers/{longTermRetentionServerName}/longTermRetentionDatabases/{longTermRetentionDatabaseName}/longTermRetentionBackups/{backupName}/changeAccessTier"]
  - code: ResourceNameRestriction
    from: LongTermRetentionBackups.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/locations/{locationName}/longTermRetentionServers/{longTermRetentionServerName}/longTermRetentionDatabases/{longTermRetentionDatabaseName}/longTermRetentionBackups/{backupName}/changeAccessTier"]
  - code: ParameterNotDefinedInGlobalParameters
    from: LongTermRetentionBackups.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/locations/{locationName}/longTermRetentionServers/{longTermRetentionServerName}/longTermRetentionDatabases/{longTermRetentionDatabaseName}/longTermRetentionBackups/{backupName}/changeAccessTier"].post.parameters
  - code: ParameterDescription
    from: LongTermRetentionBackups.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/locations/{locationName}/longTermRetentionServers/{longTermRetentionServerName}/longTermRetentionDatabases/{longTermRetentionDatabaseName}/longTermRetentionBackups/{backupName}/changeAccessTier"].post.parameters["1"]
  - code: ParameterDescription
    from: LongTermRetentionBackups.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/locations/{locationName}/longTermRetentionServers/{longTermRetentionServerName}/longTermRetentionDatabases/{longTermRetentionDatabaseName}/longTermRetentionBackups/{backupName}/changeAccessTier"].post.parameters["2"]
  - code: ParameterDescription
    from: LongTermRetentionBackups.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/locations/{locationName}/longTermRetentionServers/{longTermRetentionServerName}/longTermRetentionDatabases/{longTermRetentionDatabaseName}/longTermRetentionBackups/{backupName}/changeAccessTier"].post.parameters["3"]
  - code: ParameterDescription
    from: LongTermRetentionBackups.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/locations/{locationName}/longTermRetentionServers/{longTermRetentionServerName}/longTermRetentionDatabases/{longTermRetentionDatabaseName}/longTermRetentionBackups/{backupName}/changeAccessTier"].post.parameters["4"]
  - code: ParameterDescription
    from: LongTermRetentionBackups.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/locations/{locationName}/longTermRetentionServers/{longTermRetentionServerName}/longTermRetentionDatabases/{longTermRetentionDatabaseName}/longTermRetentionBackups/{backupName}/changeAccessTier"].post.parameters["5"]
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: LongTermRetentionBackups.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/locations/{locationName}/longTermRetentionServers/{longTermRetentionServerName}/longTermRetentionDatabases/{longTermRetentionDatabaseName}/longTermRetentionBackups/{backupName}/changeAccessTier"].post.responses.default.schema["$ref"]
  - code: LongRunningOperationsOptionsValidator
    from: LongTermRetentionBackups.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/locations/{locationName}/longTermRetentionServers/{longTermRetentionServerName}/longTermRetentionDatabases/{longTermRetentionDatabaseName}/longTermRetentionBackups/{backupName}/copy"]
  - code: ResourceNameRestriction
    from: LongTermRetentionBackups.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/locations/{locationName}/longTermRetentionServers/{longTermRetentionServerName}/longTermRetentionDatabases/{longTermRetentionDatabaseName}/longTermRetentionBackups/{backupName}/copy"]
  - code: ParameterNotDefinedInGlobalParameters
    from: LongTermRetentionBackups.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/locations/{locationName}/longTermRetentionServers/{longTermRetentionServerName}/longTermRetentionDatabases/{longTermRetentionDatabaseName}/longTermRetentionBackups/{backupName}/copy"].post.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: LongTermRetentionBackups.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/locations/{locationName}/longTermRetentionServers/{longTermRetentionServerName}/longTermRetentionDatabases/{longTermRetentionDatabaseName}/longTermRetentionBackups/{backupName}/copy"].post.responses.default.schema["$ref"]
  - code: LongRunningOperationsOptionsValidator
    from: LongTermRetentionBackups.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/locations/{locationName}/longTermRetentionServers/{longTermRetentionServerName}/longTermRetentionDatabases/{longTermRetentionDatabaseName}/longTermRetentionBackups/{backupName}/lockTimeBasedImmutability"]
  - code: ResourceNameRestriction
    from: LongTermRetentionBackups.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/locations/{locationName}/longTermRetentionServers/{longTermRetentionServerName}/longTermRetentionDatabases/{longTermRetentionDatabaseName}/longTermRetentionBackups/{backupName}/lockTimeBasedImmutability"]
  - code: ParameterNotDefinedInGlobalParameters
    from: LongTermRetentionBackups.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/locations/{locationName}/longTermRetentionServers/{longTermRetentionServerName}/longTermRetentionDatabases/{longTermRetentionDatabaseName}/longTermRetentionBackups/{backupName}/lockTimeBasedImmutability"].post.parameters
  - code: ParameterNotUsingCommonTypes
    from: LongTermRetentionBackups.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/locations/{locationName}/longTermRetentionServers/{longTermRetentionServerName}/longTermRetentionDatabases/{longTermRetentionDatabaseName}/longTermRetentionBackups/{backupName}/lockTimeBasedImmutability"].post.parameters["0"].name
  - code: ParameterDescription
    from: LongTermRetentionBackups.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/locations/{locationName}/longTermRetentionServers/{longTermRetentionServerName}/longTermRetentionDatabases/{longTermRetentionDatabaseName}/longTermRetentionBackups/{backupName}/lockTimeBasedImmutability"].post.parameters["1"]
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: LongTermRetentionBackups.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/locations/{locationName}/longTermRetentionServers/{longTermRetentionServerName}/longTermRetentionDatabases/{longTermRetentionDatabaseName}/longTermRetentionBackups/{backupName}/lockTimeBasedImmutability"].post.responses.default.schema["$ref"]
  - code: LongRunningOperationsOptionsValidator
    from: LongTermRetentionBackups.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/locations/{locationName}/longTermRetentionServers/{longTermRetentionServerName}/longTermRetentionDatabases/{longTermRetentionDatabaseName}/longTermRetentionBackups/{backupName}/removeLegalHoldImmutability"]
  - code: ResourceNameRestriction
    from: LongTermRetentionBackups.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/locations/{locationName}/longTermRetentionServers/{longTermRetentionServerName}/longTermRetentionDatabases/{longTermRetentionDatabaseName}/longTermRetentionBackups/{backupName}/removeLegalHoldImmutability"]
  - code: ParameterNotDefinedInGlobalParameters
    from: LongTermRetentionBackups.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/locations/{locationName}/longTermRetentionServers/{longTermRetentionServerName}/longTermRetentionDatabases/{longTermRetentionDatabaseName}/longTermRetentionBackups/{backupName}/removeLegalHoldImmutability"].post.parameters
  - code: ParameterNotUsingCommonTypes
    from: LongTermRetentionBackups.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/locations/{locationName}/longTermRetentionServers/{longTermRetentionServerName}/longTermRetentionDatabases/{longTermRetentionDatabaseName}/longTermRetentionBackups/{backupName}/removeLegalHoldImmutability"].post.parameters["0"].name
  - code: ParameterDescription
    from: LongTermRetentionBackups.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/locations/{locationName}/longTermRetentionServers/{longTermRetentionServerName}/longTermRetentionDatabases/{longTermRetentionDatabaseName}/longTermRetentionBackups/{backupName}/removeLegalHoldImmutability"].post.parameters["1"]
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: LongTermRetentionBackups.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/locations/{locationName}/longTermRetentionServers/{longTermRetentionServerName}/longTermRetentionDatabases/{longTermRetentionDatabaseName}/longTermRetentionBackups/{backupName}/removeLegalHoldImmutability"].post.responses.default.schema["$ref"]
  - code: LongRunningOperationsOptionsValidator
    from: LongTermRetentionBackups.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/locations/{locationName}/longTermRetentionServers/{longTermRetentionServerName}/longTermRetentionDatabases/{longTermRetentionDatabaseName}/longTermRetentionBackups/{backupName}/removeTimeBasedImmutability"]
  - code: ResourceNameRestriction
    from: LongTermRetentionBackups.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/locations/{locationName}/longTermRetentionServers/{longTermRetentionServerName}/longTermRetentionDatabases/{longTermRetentionDatabaseName}/longTermRetentionBackups/{backupName}/removeTimeBasedImmutability"]
  - code: ParameterNotDefinedInGlobalParameters
    from: LongTermRetentionBackups.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/locations/{locationName}/longTermRetentionServers/{longTermRetentionServerName}/longTermRetentionDatabases/{longTermRetentionDatabaseName}/longTermRetentionBackups/{backupName}/removeTimeBasedImmutability"].post.parameters
  - code: ParameterNotUsingCommonTypes
    from: LongTermRetentionBackups.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/locations/{locationName}/longTermRetentionServers/{longTermRetentionServerName}/longTermRetentionDatabases/{longTermRetentionDatabaseName}/longTermRetentionBackups/{backupName}/removeTimeBasedImmutability"].post.parameters["0"].name
  - code: ParameterDescription
    from: LongTermRetentionBackups.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/locations/{locationName}/longTermRetentionServers/{longTermRetentionServerName}/longTermRetentionDatabases/{longTermRetentionDatabaseName}/longTermRetentionBackups/{backupName}/removeTimeBasedImmutability"].post.parameters["1"]
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: LongTermRetentionBackups.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/locations/{locationName}/longTermRetentionServers/{longTermRetentionServerName}/longTermRetentionDatabases/{longTermRetentionDatabaseName}/longTermRetentionBackups/{backupName}/removeTimeBasedImmutability"].post.responses.default.schema["$ref"]
  - code: LongRunningOperationsOptionsValidator
    from: LongTermRetentionBackups.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/locations/{locationName}/longTermRetentionServers/{longTermRetentionServerName}/longTermRetentionDatabases/{longTermRetentionDatabaseName}/longTermRetentionBackups/{backupName}/setLegalHoldImmutability"]
  - code: ResourceNameRestriction
    from: LongTermRetentionBackups.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/locations/{locationName}/longTermRetentionServers/{longTermRetentionServerName}/longTermRetentionDatabases/{longTermRetentionDatabaseName}/longTermRetentionBackups/{backupName}/setLegalHoldImmutability"]
  - code: ParameterNotDefinedInGlobalParameters
    from: LongTermRetentionBackups.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/locations/{locationName}/longTermRetentionServers/{longTermRetentionServerName}/longTermRetentionDatabases/{longTermRetentionDatabaseName}/longTermRetentionBackups/{backupName}/setLegalHoldImmutability"].post.parameters
  - code: ParameterNotUsingCommonTypes
    from: LongTermRetentionBackups.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/locations/{locationName}/longTermRetentionServers/{longTermRetentionServerName}/longTermRetentionDatabases/{longTermRetentionDatabaseName}/longTermRetentionBackups/{backupName}/setLegalHoldImmutability"].post.parameters["0"].name
  - code: ParameterDescription
    from: LongTermRetentionBackups.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/locations/{locationName}/longTermRetentionServers/{longTermRetentionServerName}/longTermRetentionDatabases/{longTermRetentionDatabaseName}/longTermRetentionBackups/{backupName}/setLegalHoldImmutability"].post.parameters["1"]
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: LongTermRetentionBackups.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/locations/{locationName}/longTermRetentionServers/{longTermRetentionServerName}/longTermRetentionDatabases/{longTermRetentionDatabaseName}/longTermRetentionBackups/{backupName}/setLegalHoldImmutability"].post.responses.default.schema["$ref"]
  - code: LongRunningOperationsOptionsValidator
    from: LongTermRetentionBackups.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/locations/{locationName}/longTermRetentionServers/{longTermRetentionServerName}/longTermRetentionDatabases/{longTermRetentionDatabaseName}/longTermRetentionBackups/{backupName}/update"]
  - code: ResourceNameRestriction
    from: LongTermRetentionBackups.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/locations/{locationName}/longTermRetentionServers/{longTermRetentionServerName}/longTermRetentionDatabases/{longTermRetentionDatabaseName}/longTermRetentionBackups/{backupName}/update"]
  - code: ParameterNotDefinedInGlobalParameters
    from: LongTermRetentionBackups.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/locations/{locationName}/longTermRetentionServers/{longTermRetentionServerName}/longTermRetentionDatabases/{longTermRetentionDatabaseName}/longTermRetentionBackups/{backupName}/update"].post.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: LongTermRetentionBackups.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/locations/{locationName}/longTermRetentionServers/{longTermRetentionServerName}/longTermRetentionDatabases/{longTermRetentionDatabaseName}/longTermRetentionBackups/{backupName}/update"].post.responses.default.schema["$ref"]
  - code: ResourceNameRestriction
    from: LongTermRetentionManagedInstanceBackups.json
    where: $.paths["/subscriptions/{subscriptionId}/providers/Microsoft.Sql/locations/{locationName}/longTermRetentionManagedInstanceBackups"]
  - code: ParameterNotDefinedInGlobalParameters
    from: LongTermRetentionManagedInstanceBackups.json
    where: $.paths["/subscriptions/{subscriptionId}/providers/Microsoft.Sql/locations/{locationName}/longTermRetentionManagedInstanceBackups"].get.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: LongTermRetentionManagedInstanceBackups.json
    where: $.paths["/subscriptions/{subscriptionId}/providers/Microsoft.Sql/locations/{locationName}/longTermRetentionManagedInstanceBackups"].get.responses.default.schema["$ref"]
  - code: ResourceNameRestriction
    from: LongTermRetentionManagedInstanceBackups.json
    where: $.paths["/subscriptions/{subscriptionId}/providers/Microsoft.Sql/locations/{locationName}/longTermRetentionManagedInstances/{managedInstanceName}/longTermRetentionDatabases/{databaseName}/longTermRetentionManagedInstanceBackups"]
  - code: ParameterNotDefinedInGlobalParameters
    from: LongTermRetentionManagedInstanceBackups.json
    where: $.paths["/subscriptions/{subscriptionId}/providers/Microsoft.Sql/locations/{locationName}/longTermRetentionManagedInstances/{managedInstanceName}/longTermRetentionDatabases/{databaseName}/longTermRetentionManagedInstanceBackups"].get.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: LongTermRetentionManagedInstanceBackups.json
    where: $.paths["/subscriptions/{subscriptionId}/providers/Microsoft.Sql/locations/{locationName}/longTermRetentionManagedInstances/{managedInstanceName}/longTermRetentionDatabases/{databaseName}/longTermRetentionManagedInstanceBackups"].get.responses.default.schema["$ref"]
  - code: ResourceNameRestriction
    from: LongTermRetentionManagedInstanceBackups.json
    where: $.paths["/subscriptions/{subscriptionId}/providers/Microsoft.Sql/locations/{locationName}/longTermRetentionManagedInstances/{managedInstanceName}/longTermRetentionDatabases/{databaseName}/longTermRetentionManagedInstanceBackups/{backupName}"]
  - code: ParameterNotDefinedInGlobalParameters
    from: LongTermRetentionManagedInstanceBackups.json
    where: $.paths["/subscriptions/{subscriptionId}/providers/Microsoft.Sql/locations/{locationName}/longTermRetentionManagedInstances/{managedInstanceName}/longTermRetentionDatabases/{databaseName}/longTermRetentionManagedInstanceBackups/{backupName}"].get.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: LongTermRetentionManagedInstanceBackups.json
    where: $.paths["/subscriptions/{subscriptionId}/providers/Microsoft.Sql/locations/{locationName}/longTermRetentionManagedInstances/{managedInstanceName}/longTermRetentionDatabases/{databaseName}/longTermRetentionManagedInstanceBackups/{backupName}"].get.responses.default.schema["$ref"]
  - code: DeleteResponseCodes
    from: LongTermRetentionManagedInstanceBackups.json
    where: $.paths["/subscriptions/{subscriptionId}/providers/Microsoft.Sql/locations/{locationName}/longTermRetentionManagedInstances/{managedInstanceName}/longTermRetentionDatabases/{databaseName}/longTermRetentionManagedInstanceBackups/{backupName}"].delete
  - code: ParameterNotDefinedInGlobalParameters
    from: LongTermRetentionManagedInstanceBackups.json
    where: $.paths["/subscriptions/{subscriptionId}/providers/Microsoft.Sql/locations/{locationName}/longTermRetentionManagedInstances/{managedInstanceName}/longTermRetentionDatabases/{databaseName}/longTermRetentionManagedInstanceBackups/{backupName}"].delete.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: LongTermRetentionManagedInstanceBackups.json
    where: $.paths["/subscriptions/{subscriptionId}/providers/Microsoft.Sql/locations/{locationName}/longTermRetentionManagedInstances/{managedInstanceName}/longTermRetentionDatabases/{databaseName}/longTermRetentionManagedInstanceBackups/{backupName}"].delete.responses.default.schema["$ref"]
  - code: ResourceNameRestriction
    from: LongTermRetentionManagedInstanceBackups.json
    where: $.paths["/subscriptions/{subscriptionId}/providers/Microsoft.Sql/locations/{locationName}/longTermRetentionManagedInstances/{managedInstanceName}/longTermRetentionManagedInstanceBackups"]
  - code: ParameterNotDefinedInGlobalParameters
    from: LongTermRetentionManagedInstanceBackups.json
    where: $.paths["/subscriptions/{subscriptionId}/providers/Microsoft.Sql/locations/{locationName}/longTermRetentionManagedInstances/{managedInstanceName}/longTermRetentionManagedInstanceBackups"].get.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: LongTermRetentionManagedInstanceBackups.json
    where: $.paths["/subscriptions/{subscriptionId}/providers/Microsoft.Sql/locations/{locationName}/longTermRetentionManagedInstances/{managedInstanceName}/longTermRetentionManagedInstanceBackups"].get.responses.default.schema["$ref"]
  - code: MissingSegmentsInNestedResourceListOperation
    from: LongTermRetentionManagedInstanceBackups.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/locations/{locationName}/longTermRetentionManagedInstanceBackups"]
  - code: ResourceNameRestriction
    from: LongTermRetentionManagedInstanceBackups.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/locations/{locationName}/longTermRetentionManagedInstanceBackups"]
  - code: ParameterNotDefinedInGlobalParameters
    from: LongTermRetentionManagedInstanceBackups.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/locations/{locationName}/longTermRetentionManagedInstanceBackups"].get.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: LongTermRetentionManagedInstanceBackups.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/locations/{locationName}/longTermRetentionManagedInstanceBackups"].get.responses.default.schema["$ref"]
  - code: MissingSegmentsInNestedResourceListOperation
    from: LongTermRetentionManagedInstanceBackups.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/locations/{locationName}/longTermRetentionManagedInstances/{managedInstanceName}/longTermRetentionDatabases/{databaseName}/longTermRetentionManagedInstanceBackups"]
  - code: ResourceNameRestriction
    from: LongTermRetentionManagedInstanceBackups.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/locations/{locationName}/longTermRetentionManagedInstances/{managedInstanceName}/longTermRetentionDatabases/{databaseName}/longTermRetentionManagedInstanceBackups"]
  - code: ParameterNotDefinedInGlobalParameters
    from: LongTermRetentionManagedInstanceBackups.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/locations/{locationName}/longTermRetentionManagedInstances/{managedInstanceName}/longTermRetentionDatabases/{databaseName}/longTermRetentionManagedInstanceBackups"].get.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: LongTermRetentionManagedInstanceBackups.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/locations/{locationName}/longTermRetentionManagedInstances/{managedInstanceName}/longTermRetentionDatabases/{databaseName}/longTermRetentionManagedInstanceBackups"].get.responses.default.schema["$ref"]
  - code: ResourceNameRestriction
    from: LongTermRetentionManagedInstanceBackups.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/locations/{locationName}/longTermRetentionManagedInstances/{managedInstanceName}/longTermRetentionDatabases/{databaseName}/longTermRetentionManagedInstanceBackups/{backupName}"]
  - code: ParameterNotDefinedInGlobalParameters
    from: LongTermRetentionManagedInstanceBackups.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/locations/{locationName}/longTermRetentionManagedInstances/{managedInstanceName}/longTermRetentionDatabases/{databaseName}/longTermRetentionManagedInstanceBackups/{backupName}"].get.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: LongTermRetentionManagedInstanceBackups.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/locations/{locationName}/longTermRetentionManagedInstances/{managedInstanceName}/longTermRetentionDatabases/{databaseName}/longTermRetentionManagedInstanceBackups/{backupName}"].get.responses.default.schema["$ref"]
  - code: DeleteResponseCodes
    from: LongTermRetentionManagedInstanceBackups.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/locations/{locationName}/longTermRetentionManagedInstances/{managedInstanceName}/longTermRetentionDatabases/{databaseName}/longTermRetentionManagedInstanceBackups/{backupName}"].delete
  - code: ParameterNotDefinedInGlobalParameters
    from: LongTermRetentionManagedInstanceBackups.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/locations/{locationName}/longTermRetentionManagedInstances/{managedInstanceName}/longTermRetentionDatabases/{databaseName}/longTermRetentionManagedInstanceBackups/{backupName}"].delete.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: LongTermRetentionManagedInstanceBackups.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/locations/{locationName}/longTermRetentionManagedInstances/{managedInstanceName}/longTermRetentionDatabases/{databaseName}/longTermRetentionManagedInstanceBackups/{backupName}"].delete.responses.default.schema["$ref"]
  - code: MissingSegmentsInNestedResourceListOperation
    from: LongTermRetentionManagedInstanceBackups.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/locations/{locationName}/longTermRetentionManagedInstances/{managedInstanceName}/longTermRetentionManagedInstanceBackups"]
  - code: ResourceNameRestriction
    from: LongTermRetentionManagedInstanceBackups.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/locations/{locationName}/longTermRetentionManagedInstances/{managedInstanceName}/longTermRetentionManagedInstanceBackups"]
  - code: ParameterNotDefinedInGlobalParameters
    from: LongTermRetentionManagedInstanceBackups.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/locations/{locationName}/longTermRetentionManagedInstances/{managedInstanceName}/longTermRetentionManagedInstanceBackups"].get.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: LongTermRetentionManagedInstanceBackups.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/locations/{locationName}/longTermRetentionManagedInstances/{managedInstanceName}/longTermRetentionManagedInstanceBackups"].get.responses.default.schema["$ref"]
  - code: MissingSegmentsInNestedResourceListOperation
    from: LongTermRetentionPolicies.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/backupLongTermRetentionPolicies"]
  - code: ResourceNameRestriction
    from: LongTermRetentionPolicies.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/backupLongTermRetentionPolicies"]
  - code: ParameterNotDefinedInGlobalParameters
    from: LongTermRetentionPolicies.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/backupLongTermRetentionPolicies"].get.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: LongTermRetentionPolicies.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/backupLongTermRetentionPolicies"].get.responses.default.schema["$ref"]
  - code: ResourceNameRestriction
    from: LongTermRetentionPolicies.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/backupLongTermRetentionPolicies/{policyName}"]
  - code: ParameterNotDefinedInGlobalParameters
    from: LongTermRetentionPolicies.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/backupLongTermRetentionPolicies/{policyName}"].get.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: LongTermRetentionPolicies.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/backupLongTermRetentionPolicies/{policyName}"].get.responses.default.schema["$ref"]
  - code: ProvisioningStateSpecifiedForLROPut
    from: LongTermRetentionPolicies.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/backupLongTermRetentionPolicies/{policyName}"].put
  - code: PutResponseCodes
    from: LongTermRetentionPolicies.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/backupLongTermRetentionPolicies/{policyName}"].put
  - code: ParameterNotDefinedInGlobalParameters
    from: LongTermRetentionPolicies.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/backupLongTermRetentionPolicies/{policyName}"].put.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: LongTermRetentionPolicies.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/backupLongTermRetentionPolicies/{policyName}"].put.responses.default.schema["$ref"]
  - code: MissingSegmentsInNestedResourceListOperation
    from: MaintenanceWindowOptions.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/maintenanceWindowOptions/current"]
  - code: PathForNestedResource
    from: MaintenanceWindowOptions.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/maintenanceWindowOptions/current"]
  - code: ReservedResourceNamesModelAsEnum
    from: MaintenanceWindowOptions.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/maintenanceWindowOptions/current"]
  - code: ResourceNameRestriction
    from: MaintenanceWindowOptions.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/maintenanceWindowOptions/current"]
  - code: OperationIdNounConflictingModelNames
    from: MaintenanceWindowOptions.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/maintenanceWindowOptions/current"].get.operationId
  - code: ParameterNotDefinedInGlobalParameters
    from: MaintenanceWindowOptions.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/maintenanceWindowOptions/current"].get.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: MaintenanceWindowOptions.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/maintenanceWindowOptions/current"].get.responses.default.schema["$ref"]
  - code: EvenSegmentedPathForPutOperation
    from: MaintenanceWindows.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/maintenanceWindows/current"]
  - code: MissingSegmentsInNestedResourceListOperation
    from: MaintenanceWindows.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/maintenanceWindows/current"]
  - code: PathForNestedResource
    from: MaintenanceWindows.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/maintenanceWindows/current"]
  - code: PutGetPatchResponseSchema
    from: MaintenanceWindows.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/maintenanceWindows/current"]
  - code: ReservedResourceNamesModelAsEnum
    from: MaintenanceWindows.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/maintenanceWindows/current"]
  - code: ResourceNameRestriction
    from: MaintenanceWindows.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/maintenanceWindows/current"]
  - code: OperationIdNounConflictingModelNames
    from: MaintenanceWindows.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/maintenanceWindows/current"].get.operationId
  - code: ParameterNotDefinedInGlobalParameters
    from: MaintenanceWindows.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/maintenanceWindows/current"].get.parameters
  - code: PutRequestResponseSchemeArm
    from: MaintenanceWindows.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/maintenanceWindows/current"].put
  - code: PutResponseCodes
    from: MaintenanceWindows.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/maintenanceWindows/current"].put
  - code: ResponseSchemaSpecifiedForSuccessStatusCode
    from: MaintenanceWindows.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/maintenanceWindows/current"].put
  - code: OperationIdNounConflictingModelNames
    from: MaintenanceWindows.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/maintenanceWindows/current"].put.operationId
  - code: ParameterNotDefinedInGlobalParameters
    from: MaintenanceWindows.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/maintenanceWindows/current"].put.parameters
  - code: ParameterDescription
    from: MaintenanceWindows.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/maintenanceWindows/current"].put.parameters["4"]
  - code: MissingSegmentsInNestedResourceListOperation
    from: ManagedBackupShortTermRetentionPolicies.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/databases/{databaseName}/backupShortTermRetentionPolicies"]
  - code: ResourceNameRestriction
    from: ManagedBackupShortTermRetentionPolicies.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/databases/{databaseName}/backupShortTermRetentionPolicies"]
  - code: ParameterNotDefinedInGlobalParameters
    from: ManagedBackupShortTermRetentionPolicies.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/databases/{databaseName}/backupShortTermRetentionPolicies"].get.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: ManagedBackupShortTermRetentionPolicies.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/databases/{databaseName}/backupShortTermRetentionPolicies"].get.responses.default.schema["$ref"]
  - code: ResourceNameRestriction
    from: ManagedBackupShortTermRetentionPolicies.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/databases/{databaseName}/backupShortTermRetentionPolicies/{policyName}"]
  - code: ParameterNotDefinedInGlobalParameters
    from: ManagedBackupShortTermRetentionPolicies.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/databases/{databaseName}/backupShortTermRetentionPolicies/{policyName}"].get.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: ManagedBackupShortTermRetentionPolicies.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/databases/{databaseName}/backupShortTermRetentionPolicies/{policyName}"].get.responses.default.schema["$ref"]
  - code: ProvisioningStateSpecifiedForLROPut
    from: ManagedBackupShortTermRetentionPolicies.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/databases/{databaseName}/backupShortTermRetentionPolicies/{policyName}"].put
  - code: PutResponseCodes
    from: ManagedBackupShortTermRetentionPolicies.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/databases/{databaseName}/backupShortTermRetentionPolicies/{policyName}"].put
  - code: ParameterNotDefinedInGlobalParameters
    from: ManagedBackupShortTermRetentionPolicies.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/databases/{databaseName}/backupShortTermRetentionPolicies/{policyName}"].put.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: ManagedBackupShortTermRetentionPolicies.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/databases/{databaseName}/backupShortTermRetentionPolicies/{policyName}"].put.responses.default.schema["$ref"]
  - code: ParameterNotDefinedInGlobalParameters
    from: ManagedBackupShortTermRetentionPolicies.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/databases/{databaseName}/backupShortTermRetentionPolicies/{policyName}"].patch.parameters
  - code: ProvisioningStateSpecifiedForLROPatch
    from: ManagedBackupShortTermRetentionPolicies.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/databases/{databaseName}/backupShortTermRetentionPolicies/{policyName}"].patch.responses["200"]
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: ManagedBackupShortTermRetentionPolicies.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/databases/{databaseName}/backupShortTermRetentionPolicies/{policyName}"].patch.responses.default.schema["$ref"]
  - code: MissingSegmentsInNestedResourceListOperation
    from: ManagedDatabaseAdvancedThreatProtectionSettings.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/databases/{databaseName}/advancedThreatProtectionSettings"]
  - code: ResourceNameRestriction
    from: ManagedDatabaseAdvancedThreatProtectionSettings.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/databases/{databaseName}/advancedThreatProtectionSettings"]
  - code: ParameterNotDefinedInGlobalParameters
    from: ManagedDatabaseAdvancedThreatProtectionSettings.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/databases/{databaseName}/advancedThreatProtectionSettings"].get.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: ManagedDatabaseAdvancedThreatProtectionSettings.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/databases/{databaseName}/advancedThreatProtectionSettings"].get.responses.default.schema["$ref"]
  - code: ResourceNameRestriction
    from: ManagedDatabaseAdvancedThreatProtectionSettings.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/databases/{databaseName}/advancedThreatProtectionSettings/{advancedThreatProtectionName}"]
  - code: ParameterNotDefinedInGlobalParameters
    from: ManagedDatabaseAdvancedThreatProtectionSettings.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/databases/{databaseName}/advancedThreatProtectionSettings/{advancedThreatProtectionName}"].get.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: ManagedDatabaseAdvancedThreatProtectionSettings.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/databases/{databaseName}/advancedThreatProtectionSettings/{advancedThreatProtectionName}"].get.responses.default.schema["$ref"]
  - code: ParameterNotDefinedInGlobalParameters
    from: ManagedDatabaseAdvancedThreatProtectionSettings.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/databases/{databaseName}/advancedThreatProtectionSettings/{advancedThreatProtectionName}"].put.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: ManagedDatabaseAdvancedThreatProtectionSettings.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/databases/{databaseName}/advancedThreatProtectionSettings/{advancedThreatProtectionName}"].put.responses.default.schema["$ref"]
  - code: SystemDataDefinitionsCommonTypes
    from: ManagedDatabaseAdvancedThreatProtectionSettings.json
    where: $.definitions.ManagedDatabaseAdvancedThreatProtection.properties.systemData["$ref"]
  - code: MissingSegmentsInNestedResourceListOperation
    from: ManagedDatabaseColumns.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/databases/{databaseName}/columns"]
  - code: ResourceNameRestriction
    from: ManagedDatabaseColumns.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/databases/{databaseName}/columns"]
  - code: ParameterNotDefinedInGlobalParameters
    from: ManagedDatabaseColumns.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/databases/{databaseName}/columns"].get.parameters
  - code: ParameterDescription
    from: ManagedDatabaseColumns.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/databases/{databaseName}/columns"].get.parameters["3"]
  - code: ParameterDescription
    from: ManagedDatabaseColumns.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/databases/{databaseName}/columns"].get.parameters["4"]
  - code: ParameterDescription
    from: ManagedDatabaseColumns.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/databases/{databaseName}/columns"].get.parameters["5"]
  - code: ParameterDescription
    from: ManagedDatabaseColumns.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/databases/{databaseName}/columns"].get.parameters["6"]
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: ManagedDatabaseColumns.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/databases/{databaseName}/columns"].get.responses.default.schema["$ref"]
  - code: MissingSegmentsInNestedResourceListOperation
    from: ManagedDatabaseColumns.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/databases/{databaseName}/schemas/{schemaName}/tables/{tableName}/columns"]
  - code: ResourceNameRestriction
    from: ManagedDatabaseColumns.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/databases/{databaseName}/schemas/{schemaName}/tables/{tableName}/columns"]
  - code: ParameterNotDefinedInGlobalParameters
    from: ManagedDatabaseColumns.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/databases/{databaseName}/schemas/{schemaName}/tables/{tableName}/columns"].get.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: ManagedDatabaseColumns.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/databases/{databaseName}/schemas/{schemaName}/tables/{tableName}/columns"].get.responses.default.schema["$ref"]
  - code: ResourceNameRestriction
    from: ManagedDatabaseColumns.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/databases/{databaseName}/schemas/{schemaName}/tables/{tableName}/columns/{columnName}"]
  - code: ParameterNotDefinedInGlobalParameters
    from: ManagedDatabaseColumns.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/databases/{databaseName}/schemas/{schemaName}/tables/{tableName}/columns/{columnName}"].get.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: ManagedDatabaseColumns.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/databases/{databaseName}/schemas/{schemaName}/tables/{tableName}/columns/{columnName}"].get.responses.default.schema["$ref"]
  - code: MissingSegmentsInNestedResourceListOperation
    from: ManagedDatabaseMoveOperations.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/locations/{locationName}/managedDatabaseMoveOperationResults"]
  - code: ResourceNameRestriction
    from: ManagedDatabaseMoveOperations.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/locations/{locationName}/managedDatabaseMoveOperationResults"]
  - code: ParameterNotDefinedInGlobalParameters
    from: ManagedDatabaseMoveOperations.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/locations/{locationName}/managedDatabaseMoveOperationResults"].get.parameters
  - code: ParameterDescription
    from: ManagedDatabaseMoveOperations.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/locations/{locationName}/managedDatabaseMoveOperationResults"].get.parameters["1"]
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: ManagedDatabaseMoveOperations.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/locations/{locationName}/managedDatabaseMoveOperationResults"].get.responses.default.schema["$ref"]
  - code: ResourceNameRestriction
    from: ManagedDatabaseMoveOperations.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/locations/{locationName}/managedDatabaseMoveOperationResults/{operationId}"]
  - code: ParameterNotDefinedInGlobalParameters
    from: ManagedDatabaseMoveOperations.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/locations/{locationName}/managedDatabaseMoveOperationResults/{operationId}"].get.parameters
  - code: ParameterDescription
    from: ManagedDatabaseMoveOperations.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/locations/{locationName}/managedDatabaseMoveOperationResults/{operationId}"].get.parameters["1"]
  - code: ParameterDescription
    from: ManagedDatabaseMoveOperations.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/locations/{locationName}/managedDatabaseMoveOperationResults/{operationId}"].get.parameters["2"]
  - code: ParameterNotUsingCommonTypes
    from: ManagedDatabaseMoveOperations.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/locations/{locationName}/managedDatabaseMoveOperationResults/{operationId}"].get.parameters["2"].name
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: ManagedDatabaseMoveOperations.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/locations/{locationName}/managedDatabaseMoveOperationResults/{operationId}"].get.responses.default.schema["$ref"]
  - code: MissingSegmentsInNestedResourceListOperation
    from: ManagedDatabaseQueries.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/databases/{databaseName}/queries/{queryId}"]
  - code: ResourceNameRestriction
    from: ManagedDatabaseQueries.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/databases/{databaseName}/queries/{queryId}"]
  - code: ParameterNotDefinedInGlobalParameters
    from: ManagedDatabaseQueries.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/databases/{databaseName}/queries/{queryId}"].get.parameters
  - code: ParameterDescription
    from: ManagedDatabaseQueries.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/databases/{databaseName}/queries/{queryId}"].get.parameters["3"]
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: ManagedDatabaseQueries.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/databases/{databaseName}/queries/{queryId}"].get.responses.default.schema["$ref"]
  - code: ResourceNameRestriction
    from: ManagedDatabaseQueries.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/databases/{databaseName}/queries/{queryId}/statistics"]
  - code: ParameterNotDefinedInGlobalParameters
    from: ManagedDatabaseQueries.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/databases/{databaseName}/queries/{queryId}/statistics"].get.parameters
  - code: ParameterDescription
    from: ManagedDatabaseQueries.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/databases/{databaseName}/queries/{queryId}/statistics"].get.parameters["3"]
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: ManagedDatabaseQueries.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/databases/{databaseName}/queries/{queryId}/statistics"].get.responses.default.schema["$ref"]
  - code: SchemaDescriptionOrTitle
    from: ManagedDatabaseQueries.json
    where: $.definitions.QueryStatistics
  - code: MissingSegmentsInNestedResourceListOperation
    from: ManagedDatabaseRestoreDetails.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/databases/{databaseName}/restoreDetails/{restoreDetailsName}"]
  - code: ResourceNameRestriction
    from: ManagedDatabaseRestoreDetails.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/databases/{databaseName}/restoreDetails/{restoreDetailsName}"]
  - code: ParameterNotDefinedInGlobalParameters
    from: ManagedDatabaseRestoreDetails.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/databases/{databaseName}/restoreDetails/{restoreDetailsName}"].get.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: ManagedDatabaseRestoreDetails.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/databases/{databaseName}/restoreDetails/{restoreDetailsName}"].get.responses.default.schema["$ref"]
  - code: PatchBodyParametersSchema
    from: ManagedDatabases.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/databases/{databaseName}"].patch.parameters["3"].schema.properties.properties
  - code: MissingSegmentsInNestedResourceListOperation
    from: ManagedDatabases.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/databases"]
  - code: ResourceNameRestriction
    from: ManagedDatabases.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/databases"]
  - code: ParameterNotDefinedInGlobalParameters
    from: ManagedDatabases.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/databases"].get.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: ManagedDatabases.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/databases"].get.responses.default.schema["$ref"]
  - code: ResourceNameRestriction
    from: ManagedDatabases.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/databases/{databaseName}"]
  - code: ParameterNotDefinedInGlobalParameters
    from: ManagedDatabases.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/databases/{databaseName}"].get.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: ManagedDatabases.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/databases/{databaseName}"].get.responses.default.schema["$ref"]
  - code: ProvisioningStateSpecifiedForLROPut
    from: ManagedDatabases.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/databases/{databaseName}"].put
  - code: PutResponseCodes
    from: ManagedDatabases.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/databases/{databaseName}"].put
  - code: ParameterNotDefinedInGlobalParameters
    from: ManagedDatabases.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/databases/{databaseName}"].put.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: ManagedDatabases.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/databases/{databaseName}"].put.responses.default.schema["$ref"]
  - code: DeleteResponseCodes
    from: ManagedDatabases.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/databases/{databaseName}"].delete
  - code: ParameterNotDefinedInGlobalParameters
    from: ManagedDatabases.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/databases/{databaseName}"].delete.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: ManagedDatabases.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/databases/{databaseName}"].delete.responses.default.schema["$ref"]
  - code: ParameterNotDefinedInGlobalParameters
    from: ManagedDatabases.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/databases/{databaseName}"].patch.parameters
  - code: ProvisioningStateSpecifiedForLROPatch
    from: ManagedDatabases.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/databases/{databaseName}"].patch.responses["200"]
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: ManagedDatabases.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/databases/{databaseName}"].patch.responses.default.schema["$ref"]
  - code: ResourceNameRestriction
    from: ManagedDatabases.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/databases/{databaseName}/cancelMove"]
  - code: PostResponseCodes
    from: ManagedDatabases.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/databases/{databaseName}/cancelMove"].post
  - code: ParameterNotDefinedInGlobalParameters
    from: ManagedDatabases.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/databases/{databaseName}/cancelMove"].post.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: ManagedDatabases.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/databases/{databaseName}/cancelMove"].post.responses.default.schema["$ref"]
  - code: ResourceNameRestriction
    from: ManagedDatabases.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/databases/{databaseName}/completeMove"]
  - code: PostResponseCodes
    from: ManagedDatabases.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/databases/{databaseName}/completeMove"].post
  - code: ParameterNotDefinedInGlobalParameters
    from: ManagedDatabases.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/databases/{databaseName}/completeMove"].post.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: ManagedDatabases.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/databases/{databaseName}/completeMove"].post.responses.default.schema["$ref"]
  - code: ResourceNameRestriction
    from: ManagedDatabases.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/databases/{databaseName}/completeRestore"]
  - code: PostResponseCodes
    from: ManagedDatabases.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/databases/{databaseName}/completeRestore"].post
  - code: ParameterNotDefinedInGlobalParameters
    from: ManagedDatabases.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/databases/{databaseName}/completeRestore"].post.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: ManagedDatabases.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/databases/{databaseName}/completeRestore"].post.responses.default.schema["$ref"]
  - code: LongRunningOperationsOptionsValidator
    from: ManagedDatabases.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/databases/{databaseName}/reevaluateInaccessibleDatabaseState"]
  - code: ResourceNameRestriction
    from: ManagedDatabases.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/databases/{databaseName}/reevaluateInaccessibleDatabaseState"]
  - code: ParameterNotDefinedInGlobalParameters
    from: ManagedDatabases.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/databases/{databaseName}/reevaluateInaccessibleDatabaseState"].post.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: ManagedDatabases.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/databases/{databaseName}/reevaluateInaccessibleDatabaseState"].post.responses.default.schema["$ref"]
  - code: ResourceNameRestriction
    from: ManagedDatabases.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/databases/{databaseName}/startMove"]
  - code: PostResponseCodes
    from: ManagedDatabases.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/databases/{databaseName}/startMove"].post
  - code: ParameterNotDefinedInGlobalParameters
    from: ManagedDatabases.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/databases/{databaseName}/startMove"].post.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: ManagedDatabases.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/databases/{databaseName}/startMove"].post.responses.default.schema["$ref"]
  - code: MissingSegmentsInNestedResourceListOperation
    from: ManagedDatabases.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/inaccessibleManagedDatabases"]
  - code: ResourceNameRestriction
    from: ManagedDatabases.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/inaccessibleManagedDatabases"]
  - code: ParameterNotDefinedInGlobalParameters
    from: ManagedDatabases.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/inaccessibleManagedDatabases"].get.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: ManagedDatabases.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/inaccessibleManagedDatabases"].get.responses.default.schema["$ref"]
  - code: MissingSegmentsInNestedResourceListOperation
    from: ManagedDatabaseSchemas.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/databases/{databaseName}/schemas"]
  - code: ResourceNameRestriction
    from: ManagedDatabaseSchemas.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/databases/{databaseName}/schemas"]
  - code: ParameterNotDefinedInGlobalParameters
    from: ManagedDatabaseSchemas.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/databases/{databaseName}/schemas"].get.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: ManagedDatabaseSchemas.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/databases/{databaseName}/schemas"].get.responses.default.schema["$ref"]
  - code: ResourceNameRestriction
    from: ManagedDatabaseSchemas.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/databases/{databaseName}/schemas/{schemaName}"]
  - code: ParameterNotDefinedInGlobalParameters
    from: ManagedDatabaseSchemas.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/databases/{databaseName}/schemas/{schemaName}"].get.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: ManagedDatabaseSchemas.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/databases/{databaseName}/schemas/{schemaName}"].get.responses.default.schema["$ref"]
  - code: MissingSegmentsInNestedResourceListOperation
    from: ManagedDatabaseSecurityAlertPolicies.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/databases/{databaseName}/securityAlertPolicies"]
  - code: ResourceNameRestriction
    from: ManagedDatabaseSecurityAlertPolicies.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/databases/{databaseName}/securityAlertPolicies"]
  - code: ParameterNotDefinedInGlobalParameters
    from: ManagedDatabaseSecurityAlertPolicies.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/databases/{databaseName}/securityAlertPolicies"].get.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: ManagedDatabaseSecurityAlertPolicies.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/databases/{databaseName}/securityAlertPolicies"].get.responses.default.schema["$ref"]
  - code: ResourceNameRestriction
    from: ManagedDatabaseSecurityAlertPolicies.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/databases/{databaseName}/securityAlertPolicies/{securityAlertPolicyName}"]
  - code: ParameterNotDefinedInGlobalParameters
    from: ManagedDatabaseSecurityAlertPolicies.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/databases/{databaseName}/securityAlertPolicies/{securityAlertPolicyName}"].get.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: ManagedDatabaseSecurityAlertPolicies.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/databases/{databaseName}/securityAlertPolicies/{securityAlertPolicyName}"].get.responses.default.schema["$ref"]
  - code: ParameterNotDefinedInGlobalParameters
    from: ManagedDatabaseSecurityAlertPolicies.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/databases/{databaseName}/securityAlertPolicies/{securityAlertPolicyName}"].put.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: ManagedDatabaseSecurityAlertPolicies.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/databases/{databaseName}/securityAlertPolicies/{securityAlertPolicyName}"].put.responses.default.schema["$ref"]
  - code: MissingSegmentsInNestedResourceListOperation
    from: ManagedDatabaseSecurityEvents.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/databases/{databaseName}/securityEvents"]
  - code: ResourceNameRestriction
    from: ManagedDatabaseSecurityEvents.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/databases/{databaseName}/securityEvents"]
  - code: ParameterNotDefinedInGlobalParameters
    from: ManagedDatabaseSecurityEvents.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/databases/{databaseName}/securityEvents"].get.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: ManagedDatabaseSecurityEvents.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/databases/{databaseName}/securityEvents"].get.responses.default.schema["$ref"]
  - code: MissingSegmentsInNestedResourceListOperation
    from: ManagedDatabaseSensitivityLabels.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/databases/{databaseName}/currentSensitivityLabels"]
  - code: ResourceNameRestriction
    from: ManagedDatabaseSensitivityLabels.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/databases/{databaseName}/currentSensitivityLabels"]
  - code: ParameterNotDefinedInGlobalParameters
    from: ManagedDatabaseSensitivityLabels.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/databases/{databaseName}/currentSensitivityLabels"].get.parameters
  - code: ParameterDescription
    from: ManagedDatabaseSensitivityLabels.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/databases/{databaseName}/currentSensitivityLabels"].get.parameters["3"]
  - code: ParameterDescription
    from: ManagedDatabaseSensitivityLabels.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/databases/{databaseName}/currentSensitivityLabels"].get.parameters["4"]
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: ManagedDatabaseSensitivityLabels.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/databases/{databaseName}/currentSensitivityLabels"].get.responses.default.schema["$ref"]
  - code: ParameterNotDefinedInGlobalParameters
    from: ManagedDatabaseSensitivityLabels.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/databases/{databaseName}/currentSensitivityLabels"].patch.parameters
  - code: ParameterDescription
    from: ManagedDatabaseSensitivityLabels.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/databases/{databaseName}/currentSensitivityLabels"].patch.parameters["3"]
  - code: ConsistentPatchProperties
    from: ManagedDatabaseSensitivityLabels.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/databases/{databaseName}/currentSensitivityLabels"].patch.parameters["3"].schema
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: ManagedDatabaseSensitivityLabels.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/databases/{databaseName}/currentSensitivityLabels"].patch.responses.default.schema["$ref"]
  - code: MissingSegmentsInNestedResourceListOperation
    from: ManagedDatabaseSensitivityLabels.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/databases/{databaseName}/recommendedSensitivityLabels"]
  - code: ResourceNameRestriction
    from: ManagedDatabaseSensitivityLabels.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/databases/{databaseName}/recommendedSensitivityLabels"]
  - code: ParameterNotDefinedInGlobalParameters
    from: ManagedDatabaseSensitivityLabels.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/databases/{databaseName}/recommendedSensitivityLabels"].get.parameters
  - code: ParameterDescription
    from: ManagedDatabaseSensitivityLabels.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/databases/{databaseName}/recommendedSensitivityLabels"].get.parameters["3"]
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: ManagedDatabaseSensitivityLabels.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/databases/{databaseName}/recommendedSensitivityLabels"].get.responses.default.schema["$ref"]
  - code: ParameterNotDefinedInGlobalParameters
    from: ManagedDatabaseSensitivityLabels.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/databases/{databaseName}/recommendedSensitivityLabels"].patch.parameters
  - code: ParameterDescription
    from: ManagedDatabaseSensitivityLabels.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/databases/{databaseName}/recommendedSensitivityLabels"].patch.parameters["3"]
  - code: ConsistentPatchProperties
    from: ManagedDatabaseSensitivityLabels.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/databases/{databaseName}/recommendedSensitivityLabels"].patch.parameters["3"].schema
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: ManagedDatabaseSensitivityLabels.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/databases/{databaseName}/recommendedSensitivityLabels"].patch.responses.default.schema["$ref"]
  - code: MissingSegmentsInNestedResourceListOperation
    from: ManagedDatabaseSensitivityLabels.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/databases/{databaseName}/schemas/{schemaName}/tables/{tableName}/columns/{columnName}/sensitivityLabels/{sensitivityLabelSource}"]
  - code: ResourceNameRestriction
    from: ManagedDatabaseSensitivityLabels.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/databases/{databaseName}/schemas/{schemaName}/tables/{tableName}/columns/{columnName}/sensitivityLabels/{sensitivityLabelSource}"]
  - code: ParameterNotDefinedInGlobalParameters
    from: ManagedDatabaseSensitivityLabels.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/databases/{databaseName}/schemas/{schemaName}/tables/{tableName}/columns/{columnName}/sensitivityLabels/{sensitivityLabelSource}"].get.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: ManagedDatabaseSensitivityLabels.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/databases/{databaseName}/schemas/{schemaName}/tables/{tableName}/columns/{columnName}/sensitivityLabels/{sensitivityLabelSource}"].get.responses.default.schema["$ref"]
  - code: ParameterNotDefinedInGlobalParameters
    from: ManagedDatabaseSensitivityLabels.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/databases/{databaseName}/schemas/{schemaName}/tables/{tableName}/columns/{columnName}/sensitivityLabels/{sensitivityLabelSource}"].put.parameters
  - code: RepeatedPathInfo
    from: ManagedDatabaseSensitivityLabels.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/databases/{databaseName}/schemas/{schemaName}/tables/{tableName}/columns/{columnName}/sensitivityLabels/{sensitivityLabelSource}"].put.parameters["3"]
  - code: RepeatedPathInfo
    from: ManagedDatabaseSensitivityLabels.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/databases/{databaseName}/schemas/{schemaName}/tables/{tableName}/columns/{columnName}/sensitivityLabels/{sensitivityLabelSource}"].put.parameters["4"]
  - code: RepeatedPathInfo
    from: ManagedDatabaseSensitivityLabels.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/databases/{databaseName}/schemas/{schemaName}/tables/{tableName}/columns/{columnName}/sensitivityLabels/{sensitivityLabelSource}"].put.parameters["5"]
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: ManagedDatabaseSensitivityLabels.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/databases/{databaseName}/schemas/{schemaName}/tables/{tableName}/columns/{columnName}/sensitivityLabels/{sensitivityLabelSource}"].put.responses.default.schema["$ref"]
  - code: DeleteResponseCodes
    from: ManagedDatabaseSensitivityLabels.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/databases/{databaseName}/schemas/{schemaName}/tables/{tableName}/columns/{columnName}/sensitivityLabels/{sensitivityLabelSource}"].delete
  - code: ParameterNotDefinedInGlobalParameters
    from: ManagedDatabaseSensitivityLabels.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/databases/{databaseName}/schemas/{schemaName}/tables/{tableName}/columns/{columnName}/sensitivityLabels/{sensitivityLabelSource}"].delete.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: ManagedDatabaseSensitivityLabels.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/databases/{databaseName}/schemas/{schemaName}/tables/{tableName}/columns/{columnName}/sensitivityLabels/{sensitivityLabelSource}"].delete.responses.default.schema["$ref"]
  - code: ResourceNameRestriction
    from: ManagedDatabaseSensitivityLabels.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/databases/{databaseName}/schemas/{schemaName}/tables/{tableName}/columns/{columnName}/sensitivityLabels/{sensitivityLabelSource}/disable"]
  - code: ParameterNotDefinedInGlobalParameters
    from: ManagedDatabaseSensitivityLabels.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/databases/{databaseName}/schemas/{schemaName}/tables/{tableName}/columns/{columnName}/sensitivityLabels/{sensitivityLabelSource}/disable"].post.parameters
  - code: ParameterDescription
    from: ManagedDatabaseSensitivityLabels.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/databases/{databaseName}/schemas/{schemaName}/tables/{tableName}/columns/{columnName}/sensitivityLabels/{sensitivityLabelSource}/disable"].post.parameters["6"]
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: ManagedDatabaseSensitivityLabels.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/databases/{databaseName}/schemas/{schemaName}/tables/{tableName}/columns/{columnName}/sensitivityLabels/{sensitivityLabelSource}/disable"].post.responses.default.schema["$ref"]
  - code: ResourceNameRestriction
    from: ManagedDatabaseSensitivityLabels.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/databases/{databaseName}/schemas/{schemaName}/tables/{tableName}/columns/{columnName}/sensitivityLabels/{sensitivityLabelSource}/enable"]
  - code: ParameterNotDefinedInGlobalParameters
    from: ManagedDatabaseSensitivityLabels.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/databases/{databaseName}/schemas/{schemaName}/tables/{tableName}/columns/{columnName}/sensitivityLabels/{sensitivityLabelSource}/enable"].post.parameters
  - code: ParameterDescription
    from: ManagedDatabaseSensitivityLabels.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/databases/{databaseName}/schemas/{schemaName}/tables/{tableName}/columns/{columnName}/sensitivityLabels/{sensitivityLabelSource}/enable"].post.parameters["6"]
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: ManagedDatabaseSensitivityLabels.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/databases/{databaseName}/schemas/{schemaName}/tables/{tableName}/columns/{columnName}/sensitivityLabels/{sensitivityLabelSource}/enable"].post.responses.default.schema["$ref"]
  - code: MissingSegmentsInNestedResourceListOperation
    from: ManagedDatabaseSensitivityLabels.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/databases/{databaseName}/sensitivityLabels"]
  - code: ResourceNameRestriction
    from: ManagedDatabaseSensitivityLabels.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/databases/{databaseName}/sensitivityLabels"]
  - code: ParameterNotDefinedInGlobalParameters
    from: ManagedDatabaseSensitivityLabels.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/databases/{databaseName}/sensitivityLabels"].get.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: ManagedDatabaseSensitivityLabels.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/databases/{databaseName}/sensitivityLabels"].get.responses.default.schema["$ref"]
  - code: MissingSegmentsInNestedResourceListOperation
    from: ManagedDatabaseTables.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/databases/{databaseName}/schemas/{schemaName}/tables"]
  - code: ResourceNameRestriction
    from: ManagedDatabaseTables.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/databases/{databaseName}/schemas/{schemaName}/tables"]
  - code: ParameterNotDefinedInGlobalParameters
    from: ManagedDatabaseTables.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/databases/{databaseName}/schemas/{schemaName}/tables"].get.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: ManagedDatabaseTables.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/databases/{databaseName}/schemas/{schemaName}/tables"].get.responses.default.schema["$ref"]
  - code: ResourceNameRestriction
    from: ManagedDatabaseTables.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/databases/{databaseName}/schemas/{schemaName}/tables/{tableName}"]
  - code: ParameterNotDefinedInGlobalParameters
    from: ManagedDatabaseTables.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/databases/{databaseName}/schemas/{schemaName}/tables/{tableName}"].get.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: ManagedDatabaseTables.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/databases/{databaseName}/schemas/{schemaName}/tables/{tableName}"].get.responses.default.schema["$ref"]
  - code: MissingSegmentsInNestedResourceListOperation
    from: ManagedDatabaseTransparentDataEncryption.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/databases/{databaseName}/transparentDataEncryption"]
  - code: ResourceNameRestriction
    from: ManagedDatabaseTransparentDataEncryption.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/databases/{databaseName}/transparentDataEncryption"]
  - code: ParameterNotDefinedInGlobalParameters
    from: ManagedDatabaseTransparentDataEncryption.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/databases/{databaseName}/transparentDataEncryption"].get.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: ManagedDatabaseTransparentDataEncryption.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/databases/{databaseName}/transparentDataEncryption"].get.responses.default.schema["$ref"]
  - code: ResourceNameRestriction
    from: ManagedDatabaseTransparentDataEncryption.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/databases/{databaseName}/transparentDataEncryption/{tdeName}"]
  - code: ParameterNotDefinedInGlobalParameters
    from: ManagedDatabaseTransparentDataEncryption.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/databases/{databaseName}/transparentDataEncryption/{tdeName}"].get.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: ManagedDatabaseTransparentDataEncryption.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/databases/{databaseName}/transparentDataEncryption/{tdeName}"].get.responses.default.schema["$ref"]
  - code: ParameterNotDefinedInGlobalParameters
    from: ManagedDatabaseTransparentDataEncryption.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/databases/{databaseName}/transparentDataEncryption/{tdeName}"].put.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: ManagedDatabaseTransparentDataEncryption.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/databases/{databaseName}/transparentDataEncryption/{tdeName}"].put.responses.default.schema["$ref"]
  - code: MissingSegmentsInNestedResourceListOperation
    from: ManagedDatabaseVulnerabilityAssessmentRuleBaselines.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/databases/{databaseName}/vulnerabilityAssessments/{vulnerabilityAssessmentName}/rules/{ruleId}/baselines/{baselineName}"]
  - code: ResourceNameRestriction
    from: ManagedDatabaseVulnerabilityAssessmentRuleBaselines.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/databases/{databaseName}/vulnerabilityAssessments/{vulnerabilityAssessmentName}/rules/{ruleId}/baselines/{baselineName}"]
  - code: ParameterNotDefinedInGlobalParameters
    from: ManagedDatabaseVulnerabilityAssessmentRuleBaselines.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/databases/{databaseName}/vulnerabilityAssessments/{vulnerabilityAssessmentName}/rules/{ruleId}/baselines/{baselineName}"].get.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: ManagedDatabaseVulnerabilityAssessmentRuleBaselines.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/databases/{databaseName}/vulnerabilityAssessments/{vulnerabilityAssessmentName}/rules/{ruleId}/baselines/{baselineName}"].get.responses.default.schema["$ref"]
  - code: PutResponseCodes
    from: ManagedDatabaseVulnerabilityAssessmentRuleBaselines.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/databases/{databaseName}/vulnerabilityAssessments/{vulnerabilityAssessmentName}/rules/{ruleId}/baselines/{baselineName}"].put
  - code: ParameterNotDefinedInGlobalParameters
    from: ManagedDatabaseVulnerabilityAssessmentRuleBaselines.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/databases/{databaseName}/vulnerabilityAssessments/{vulnerabilityAssessmentName}/rules/{ruleId}/baselines/{baselineName}"].put.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: ManagedDatabaseVulnerabilityAssessmentRuleBaselines.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/databases/{databaseName}/vulnerabilityAssessments/{vulnerabilityAssessmentName}/rules/{ruleId}/baselines/{baselineName}"].put.responses.default.schema["$ref"]
  - code: DeleteResponseCodes
    from: ManagedDatabaseVulnerabilityAssessmentRuleBaselines.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/databases/{databaseName}/vulnerabilityAssessments/{vulnerabilityAssessmentName}/rules/{ruleId}/baselines/{baselineName}"].delete
  - code: ParameterNotDefinedInGlobalParameters
    from: ManagedDatabaseVulnerabilityAssessmentRuleBaselines.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/databases/{databaseName}/vulnerabilityAssessments/{vulnerabilityAssessmentName}/rules/{ruleId}/baselines/{baselineName}"].delete.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: ManagedDatabaseVulnerabilityAssessmentRuleBaselines.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/databases/{databaseName}/vulnerabilityAssessments/{vulnerabilityAssessmentName}/rules/{ruleId}/baselines/{baselineName}"].delete.responses.default.schema["$ref"]
  - code: MissingSegmentsInNestedResourceListOperation
    from: ManagedDatabaseVulnerabilityAssessments.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/databases/{databaseName}/vulnerabilityAssessments"]
  - code: ResourceNameRestriction
    from: ManagedDatabaseVulnerabilityAssessments.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/databases/{databaseName}/vulnerabilityAssessments"]
  - code: ParameterNotDefinedInGlobalParameters
    from: ManagedDatabaseVulnerabilityAssessments.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/databases/{databaseName}/vulnerabilityAssessments"].get.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: ManagedDatabaseVulnerabilityAssessments.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/databases/{databaseName}/vulnerabilityAssessments"].get.responses.default.schema["$ref"]
  - code: ResourceNameRestriction
    from: ManagedDatabaseVulnerabilityAssessments.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/databases/{databaseName}/vulnerabilityAssessments/{vulnerabilityAssessmentName}"]
  - code: ParameterNotDefinedInGlobalParameters
    from: ManagedDatabaseVulnerabilityAssessments.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/databases/{databaseName}/vulnerabilityAssessments/{vulnerabilityAssessmentName}"].get.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: ManagedDatabaseVulnerabilityAssessments.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/databases/{databaseName}/vulnerabilityAssessments/{vulnerabilityAssessmentName}"].get.responses.default.schema["$ref"]
  - code: ParameterNotDefinedInGlobalParameters
    from: ManagedDatabaseVulnerabilityAssessments.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/databases/{databaseName}/vulnerabilityAssessments/{vulnerabilityAssessmentName}"].put.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: ManagedDatabaseVulnerabilityAssessments.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/databases/{databaseName}/vulnerabilityAssessments/{vulnerabilityAssessmentName}"].put.responses.default.schema["$ref"]
  - code: DeleteResponseCodes
    from: ManagedDatabaseVulnerabilityAssessments.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/databases/{databaseName}/vulnerabilityAssessments/{vulnerabilityAssessmentName}"].delete
  - code: ParameterNotDefinedInGlobalParameters
    from: ManagedDatabaseVulnerabilityAssessments.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/databases/{databaseName}/vulnerabilityAssessments/{vulnerabilityAssessmentName}"].delete.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: ManagedDatabaseVulnerabilityAssessments.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/databases/{databaseName}/vulnerabilityAssessments/{vulnerabilityAssessmentName}"].delete.responses.default.schema["$ref"]
  - code: MissingSegmentsInNestedResourceListOperation
    from: ManagedDatabaseVulnerabilityAssessmentScans.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/databases/{databaseName}/vulnerabilityAssessments/{vulnerabilityAssessmentName}/scans"]
  - code: ResourceNameRestriction
    from: ManagedDatabaseVulnerabilityAssessmentScans.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/databases/{databaseName}/vulnerabilityAssessments/{vulnerabilityAssessmentName}/scans"]
  - code: ParameterNotDefinedInGlobalParameters
    from: ManagedDatabaseVulnerabilityAssessmentScans.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/databases/{databaseName}/vulnerabilityAssessments/{vulnerabilityAssessmentName}/scans"].get.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: ManagedDatabaseVulnerabilityAssessmentScans.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/databases/{databaseName}/vulnerabilityAssessments/{vulnerabilityAssessmentName}/scans"].get.responses.default.schema["$ref"]
  - code: ResourceNameRestriction
    from: ManagedDatabaseVulnerabilityAssessmentScans.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/databases/{databaseName}/vulnerabilityAssessments/{vulnerabilityAssessmentName}/scans/{scanId}"]
  - code: ParameterNotDefinedInGlobalParameters
    from: ManagedDatabaseVulnerabilityAssessmentScans.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/databases/{databaseName}/vulnerabilityAssessments/{vulnerabilityAssessmentName}/scans/{scanId}"].get.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: ManagedDatabaseVulnerabilityAssessmentScans.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/databases/{databaseName}/vulnerabilityAssessments/{vulnerabilityAssessmentName}/scans/{scanId}"].get.responses.default.schema["$ref"]
  - code: ResourceNameRestriction
    from: ManagedDatabaseVulnerabilityAssessmentScans.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/databases/{databaseName}/vulnerabilityAssessments/{vulnerabilityAssessmentName}/scans/{scanId}/export"]
  - code: PostResponseCodes
    from: ManagedDatabaseVulnerabilityAssessmentScans.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/databases/{databaseName}/vulnerabilityAssessments/{vulnerabilityAssessmentName}/scans/{scanId}/export"].post
  - code: ParameterNotDefinedInGlobalParameters
    from: ManagedDatabaseVulnerabilityAssessmentScans.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/databases/{databaseName}/vulnerabilityAssessments/{vulnerabilityAssessmentName}/scans/{scanId}/export"].post.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: ManagedDatabaseVulnerabilityAssessmentScans.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/databases/{databaseName}/vulnerabilityAssessments/{vulnerabilityAssessmentName}/scans/{scanId}/export"].post.responses.default.schema["$ref"]
  - code: ResourceNameRestriction
    from: ManagedDatabaseVulnerabilityAssessmentScans.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/databases/{databaseName}/vulnerabilityAssessments/{vulnerabilityAssessmentName}/scans/{scanId}/initiateScan"]
  - code: PostResponseCodes
    from: ManagedDatabaseVulnerabilityAssessmentScans.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/databases/{databaseName}/vulnerabilityAssessments/{vulnerabilityAssessmentName}/scans/{scanId}/initiateScan"].post
  - code: ParameterNotDefinedInGlobalParameters
    from: ManagedDatabaseVulnerabilityAssessmentScans.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/databases/{databaseName}/vulnerabilityAssessments/{vulnerabilityAssessmentName}/scans/{scanId}/initiateScan"].post.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: ManagedDatabaseVulnerabilityAssessmentScans.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/databases/{databaseName}/vulnerabilityAssessments/{vulnerabilityAssessmentName}/scans/{scanId}/initiateScan"].post.responses.default.schema["$ref"]
  - code: MissingSegmentsInNestedResourceListOperation
    from: ManagedInstanceAdministrators.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/administrators"]
  - code: ResourceNameRestriction
    from: ManagedInstanceAdministrators.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/administrators"]
  - code: ParameterNotDefinedInGlobalParameters
    from: ManagedInstanceAdministrators.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/administrators"].get.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: ManagedInstanceAdministrators.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/administrators"].get.responses.default.schema["$ref"]
  - code: ResourceNameRestriction
    from: ManagedInstanceAdministrators.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/administrators/{administratorName}"]
  - code: ParameterNotDefinedInGlobalParameters
    from: ManagedInstanceAdministrators.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/administrators/{administratorName}"].get.parameters
  - code: ParameterDescription
    from: ManagedInstanceAdministrators.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/administrators/{administratorName}"].get.parameters["2"]
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: ManagedInstanceAdministrators.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/administrators/{administratorName}"].get.responses.default.schema["$ref"]
  - code: ProvisioningStateSpecifiedForLROPut
    from: ManagedInstanceAdministrators.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/administrators/{administratorName}"].put
  - code: PutResponseCodes
    from: ManagedInstanceAdministrators.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/administrators/{administratorName}"].put
  - code: ParameterNotDefinedInGlobalParameters
    from: ManagedInstanceAdministrators.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/administrators/{administratorName}"].put.parameters
  - code: ParameterDescription
    from: ManagedInstanceAdministrators.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/administrators/{administratorName}"].put.parameters["2"]
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: ManagedInstanceAdministrators.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/administrators/{administratorName}"].put.responses.default.schema["$ref"]
  - code: DeleteResponseCodes
    from: ManagedInstanceAdministrators.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/administrators/{administratorName}"].delete
  - code: ParameterNotDefinedInGlobalParameters
    from: ManagedInstanceAdministrators.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/administrators/{administratorName}"].delete.parameters
  - code: ParameterDescription
    from: ManagedInstanceAdministrators.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/administrators/{administratorName}"].delete.parameters["2"]
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: ManagedInstanceAdministrators.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/administrators/{administratorName}"].delete.responses.default.schema["$ref"]
  - code: MissingSegmentsInNestedResourceListOperation
    from: ManagedInstanceAdvancedThreatProtectionSettings.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/advancedThreatProtectionSettings"]
  - code: ResourceNameRestriction
    from: ManagedInstanceAdvancedThreatProtectionSettings.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/advancedThreatProtectionSettings"]
  - code: ParameterNotDefinedInGlobalParameters
    from: ManagedInstanceAdvancedThreatProtectionSettings.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/advancedThreatProtectionSettings"].get.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: ManagedInstanceAdvancedThreatProtectionSettings.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/advancedThreatProtectionSettings"].get.responses.default.schema["$ref"]
  - code: ResourceNameRestriction
    from: ManagedInstanceAdvancedThreatProtectionSettings.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/advancedThreatProtectionSettings/{advancedThreatProtectionName}"]
  - code: ParameterNotDefinedInGlobalParameters
    from: ManagedInstanceAdvancedThreatProtectionSettings.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/advancedThreatProtectionSettings/{advancedThreatProtectionName}"].get.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: ManagedInstanceAdvancedThreatProtectionSettings.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/advancedThreatProtectionSettings/{advancedThreatProtectionName}"].get.responses.default.schema["$ref"]
  - code: ProvisioningStateSpecifiedForLROPut
    from: ManagedInstanceAdvancedThreatProtectionSettings.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/advancedThreatProtectionSettings/{advancedThreatProtectionName}"].put
  - code: PutResponseCodes
    from: ManagedInstanceAdvancedThreatProtectionSettings.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/advancedThreatProtectionSettings/{advancedThreatProtectionName}"].put
  - code: ParameterNotDefinedInGlobalParameters
    from: ManagedInstanceAdvancedThreatProtectionSettings.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/advancedThreatProtectionSettings/{advancedThreatProtectionName}"].put.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: ManagedInstanceAdvancedThreatProtectionSettings.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/advancedThreatProtectionSettings/{advancedThreatProtectionName}"].put.responses.default.schema["$ref"]
  - code: SystemDataDefinitionsCommonTypes
    from: ManagedInstanceAdvancedThreatProtectionSettings.json
    where: $.definitions.ManagedInstanceAdvancedThreatProtection.properties.systemData["$ref"]
  - code: MissingSegmentsInNestedResourceListOperation
    from: ManagedInstanceAzureADOnlyAuthentications.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/azureADOnlyAuthentications"]
  - code: ResourceNameRestriction
    from: ManagedInstanceAzureADOnlyAuthentications.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/azureADOnlyAuthentications"]
  - code: ParameterNotDefinedInGlobalParameters
    from: ManagedInstanceAzureADOnlyAuthentications.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/azureADOnlyAuthentications"].get.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: ManagedInstanceAzureADOnlyAuthentications.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/azureADOnlyAuthentications"].get.responses.default.schema["$ref"]
  - code: ResourceNameRestriction
    from: ManagedInstanceAzureADOnlyAuthentications.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/azureADOnlyAuthentications/{authenticationName}"]
  - code: ParameterNotDefinedInGlobalParameters
    from: ManagedInstanceAzureADOnlyAuthentications.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/azureADOnlyAuthentications/{authenticationName}"].get.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: ManagedInstanceAzureADOnlyAuthentications.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/azureADOnlyAuthentications/{authenticationName}"].get.responses.default.schema["$ref"]
  - code: ProvisioningStateSpecifiedForLROPut
    from: ManagedInstanceAzureADOnlyAuthentications.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/azureADOnlyAuthentications/{authenticationName}"].put
  - code: PutResponseCodes
    from: ManagedInstanceAzureADOnlyAuthentications.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/azureADOnlyAuthentications/{authenticationName}"].put
  - code: ParameterNotDefinedInGlobalParameters
    from: ManagedInstanceAzureADOnlyAuthentications.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/azureADOnlyAuthentications/{authenticationName}"].put.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: ManagedInstanceAzureADOnlyAuthentications.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/azureADOnlyAuthentications/{authenticationName}"].put.responses.default.schema["$ref"]
  - code: DeleteResponseCodes
    from: ManagedInstanceAzureADOnlyAuthentications.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/azureADOnlyAuthentications/{authenticationName}"].delete
  - code: ParameterNotDefinedInGlobalParameters
    from: ManagedInstanceAzureADOnlyAuthentications.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/azureADOnlyAuthentications/{authenticationName}"].delete.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: ManagedInstanceAzureADOnlyAuthentications.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/azureADOnlyAuthentications/{authenticationName}"].delete.responses.default.schema["$ref"]
  - code: MissingSegmentsInNestedResourceListOperation
    from: ManagedInstanceDtcs.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/dtc"]
  - code: ResourceNameRestriction
    from: ManagedInstanceDtcs.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/dtc"]
  - code: ParameterNotDefinedInGlobalParameters
    from: ManagedInstanceDtcs.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/dtc"].get.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: ManagedInstanceDtcs.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/dtc"].get.responses.default.schema["$ref"]
  - code: ResourceNameRestriction
    from: ManagedInstanceDtcs.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/dtc/{dtcName}"]
  - code: ParameterNotDefinedInGlobalParameters
    from: ManagedInstanceDtcs.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/dtc/{dtcName}"].get.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: ManagedInstanceDtcs.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/dtc/{dtcName}"].get.responses.default.schema["$ref"]
  - code: ProvisioningStateSpecifiedForLROPut
    from: ManagedInstanceDtcs.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/dtc/{dtcName}"].put
  - code: PutResponseCodes
    from: ManagedInstanceDtcs.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/dtc/{dtcName}"].put
  - code: ParameterNotDefinedInGlobalParameters
    from: ManagedInstanceDtcs.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/dtc/{dtcName}"].put.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: ManagedInstanceDtcs.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/dtc/{dtcName}"].put.responses.default.schema["$ref"]
  - code: MissingSegmentsInNestedResourceListOperation
    from: ManagedInstanceEncryptionProtectors.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/encryptionProtector"]
  - code: ResourceNameRestriction
    from: ManagedInstanceEncryptionProtectors.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/encryptionProtector"]
  - code: ParameterNotDefinedInGlobalParameters
    from: ManagedInstanceEncryptionProtectors.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/encryptionProtector"].get.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: ManagedInstanceEncryptionProtectors.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/encryptionProtector"].get.responses.default.schema["$ref"]
  - code: ResourceNameRestriction
    from: ManagedInstanceEncryptionProtectors.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/encryptionProtector/{encryptionProtectorName}"]
  - code: ParameterNotDefinedInGlobalParameters
    from: ManagedInstanceEncryptionProtectors.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/encryptionProtector/{encryptionProtectorName}"].get.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: ManagedInstanceEncryptionProtectors.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/encryptionProtector/{encryptionProtectorName}"].get.responses.default.schema["$ref"]
  - code: ProvisioningStateSpecifiedForLROPut
    from: ManagedInstanceEncryptionProtectors.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/encryptionProtector/{encryptionProtectorName}"].put
  - code: PutResponseCodes
    from: ManagedInstanceEncryptionProtectors.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/encryptionProtector/{encryptionProtectorName}"].put
  - code: ParameterNotDefinedInGlobalParameters
    from: ManagedInstanceEncryptionProtectors.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/encryptionProtector/{encryptionProtectorName}"].put.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: ManagedInstanceEncryptionProtectors.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/encryptionProtector/{encryptionProtectorName}"].put.responses.default.schema["$ref"]
  - code: ResourceNameRestriction
    from: ManagedInstanceEncryptionProtectors.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/encryptionProtector/{encryptionProtectorName}/revalidate"]
  - code: PostResponseCodes
    from: ManagedInstanceEncryptionProtectors.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/encryptionProtector/{encryptionProtectorName}/revalidate"].post
  - code: ParameterNotDefinedInGlobalParameters
    from: ManagedInstanceEncryptionProtectors.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/encryptionProtector/{encryptionProtectorName}/revalidate"].post.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: ManagedInstanceEncryptionProtectors.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/encryptionProtector/{encryptionProtectorName}/revalidate"].post.responses.default.schema["$ref"]
  - code: MissingSegmentsInNestedResourceListOperation
    from: ManagedInstanceKeys.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/keys"]
  - code: ResourceNameRestriction
    from: ManagedInstanceKeys.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/keys"]
  - code: ParameterNotDefinedInGlobalParameters
    from: ManagedInstanceKeys.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/keys"].get.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: ManagedInstanceKeys.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/keys"].get.responses.default.schema["$ref"]
  - code: ResourceNameRestriction
    from: ManagedInstanceKeys.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/keys/{keyName}"]
  - code: ParameterNotDefinedInGlobalParameters
    from: ManagedInstanceKeys.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/keys/{keyName}"].get.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: ManagedInstanceKeys.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/keys/{keyName}"].get.responses.default.schema["$ref"]
  - code: ProvisioningStateSpecifiedForLROPut
    from: ManagedInstanceKeys.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/keys/{keyName}"].put
  - code: PutResponseCodes
    from: ManagedInstanceKeys.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/keys/{keyName}"].put
  - code: ParameterNotDefinedInGlobalParameters
    from: ManagedInstanceKeys.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/keys/{keyName}"].put.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: ManagedInstanceKeys.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/keys/{keyName}"].put.responses.default.schema["$ref"]
  - code: DeleteResponseCodes
    from: ManagedInstanceKeys.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/keys/{keyName}"].delete
  - code: ParameterNotDefinedInGlobalParameters
    from: ManagedInstanceKeys.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/keys/{keyName}"].delete.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: ManagedInstanceKeys.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/keys/{keyName}"].delete.responses.default.schema["$ref"]
  - code: MissingSegmentsInNestedResourceListOperation
    from: ManagedInstanceLongTermRetentionPolicies.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/databases/{databaseName}/backupLongTermRetentionPolicies"]
  - code: ResourceNameRestriction
    from: ManagedInstanceLongTermRetentionPolicies.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/databases/{databaseName}/backupLongTermRetentionPolicies"]
  - code: ParameterNotDefinedInGlobalParameters
    from: ManagedInstanceLongTermRetentionPolicies.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/databases/{databaseName}/backupLongTermRetentionPolicies"].get.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: ManagedInstanceLongTermRetentionPolicies.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/databases/{databaseName}/backupLongTermRetentionPolicies"].get.responses.default.schema["$ref"]
  - code: ResourceNameRestriction
    from: ManagedInstanceLongTermRetentionPolicies.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/databases/{databaseName}/backupLongTermRetentionPolicies/{policyName}"]
  - code: ParameterNotDefinedInGlobalParameters
    from: ManagedInstanceLongTermRetentionPolicies.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/databases/{databaseName}/backupLongTermRetentionPolicies/{policyName}"].get.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: ManagedInstanceLongTermRetentionPolicies.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/databases/{databaseName}/backupLongTermRetentionPolicies/{policyName}"].get.responses.default.schema["$ref"]
  - code: ProvisioningStateSpecifiedForLROPut
    from: ManagedInstanceLongTermRetentionPolicies.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/databases/{databaseName}/backupLongTermRetentionPolicies/{policyName}"].put
  - code: PutResponseCodes
    from: ManagedInstanceLongTermRetentionPolicies.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/databases/{databaseName}/backupLongTermRetentionPolicies/{policyName}"].put
  - code: ParameterNotDefinedInGlobalParameters
    from: ManagedInstanceLongTermRetentionPolicies.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/databases/{databaseName}/backupLongTermRetentionPolicies/{policyName}"].put.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: ManagedInstanceLongTermRetentionPolicies.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/databases/{databaseName}/backupLongTermRetentionPolicies/{policyName}"].put.responses.default.schema["$ref"]
  - code: DeleteResponseCodes
    from: ManagedInstanceLongTermRetentionPolicies.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/databases/{databaseName}/backupLongTermRetentionPolicies/{policyName}"].delete
  - code: ParameterNotDefinedInGlobalParameters
    from: ManagedInstanceLongTermRetentionPolicies.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/databases/{databaseName}/backupLongTermRetentionPolicies/{policyName}"].delete.parameters
  - code: DeleteResponseBodyEmpty
    from: ManagedInstanceLongTermRetentionPolicies.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/databases/{databaseName}/backupLongTermRetentionPolicies/{policyName}"].delete.responses["200"].schema
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: ManagedInstanceLongTermRetentionPolicies.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/databases/{databaseName}/backupLongTermRetentionPolicies/{policyName}"].delete.responses.default.schema["$ref"]
  - code: MissingSegmentsInNestedResourceListOperation
    from: ManagedInstanceOperations.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/operations"]
  - code: ResourceNameRestriction
    from: ManagedInstanceOperations.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/operations"]
  - code: ParameterNotDefinedInGlobalParameters
    from: ManagedInstanceOperations.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/operations"].get.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: ManagedInstanceOperations.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/operations"].get.responses.default.schema["$ref"]
  - code: ResourceNameRestriction
    from: ManagedInstanceOperations.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/operations/{operationId}"]
  - code: ParameterNotDefinedInGlobalParameters
    from: ManagedInstanceOperations.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/operations/{operationId}"].get.parameters
  - code: ParameterDescription
    from: ManagedInstanceOperations.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/operations/{operationId}"].get.parameters["2"]
  - code: ParameterNotUsingCommonTypes
    from: ManagedInstanceOperations.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/operations/{operationId}"].get.parameters["2"].name
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: ManagedInstanceOperations.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/operations/{operationId}"].get.responses.default.schema["$ref"]
  - code: ResourceNameRestriction
    from: ManagedInstanceOperations.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/operations/{operationId}/cancel"]
  - code: ParameterNotDefinedInGlobalParameters
    from: ManagedInstanceOperations.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/operations/{operationId}/cancel"].post.parameters
  - code: ParameterDescription
    from: ManagedInstanceOperations.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/operations/{operationId}/cancel"].post.parameters["2"]
  - code: ParameterNotUsingCommonTypes
    from: ManagedInstanceOperations.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/operations/{operationId}/cancel"].post.parameters["2"].name
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: ManagedInstanceOperations.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/operations/{operationId}/cancel"].post.responses.default.schema["$ref"]
  - code: SchemaDescriptionOrTitle
    from: ManagedInstanceOperations.json
    where: $.definitions.UpsertManagedServerOperationParameters
  - code: SchemaDescriptionOrTitle
    from: ManagedInstanceOperations.json
    where: $.definitions.UpsertManagedServerOperationStepWithEstimatesAndDuration
  - code: MissingSegmentsInNestedResourceListOperation
    from: ManagedInstancePrivateEndpointConnections.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/privateEndpointConnections"]
  - code: ResourceNameRestriction
    from: ManagedInstancePrivateEndpointConnections.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/privateEndpointConnections"]
  - code: ParameterNotDefinedInGlobalParameters
    from: ManagedInstancePrivateEndpointConnections.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/privateEndpointConnections"].get.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: ManagedInstancePrivateEndpointConnections.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/privateEndpointConnections"].get.responses.default.schema["$ref"]
  - code: ResourceNameRestriction
    from: ManagedInstancePrivateEndpointConnections.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/privateEndpointConnections/{privateEndpointConnectionName}"]
  - code: ParameterNotDefinedInGlobalParameters
    from: ManagedInstancePrivateEndpointConnections.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/privateEndpointConnections/{privateEndpointConnectionName}"].get.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: ManagedInstancePrivateEndpointConnections.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/privateEndpointConnections/{privateEndpointConnectionName}"].get.responses.default.schema["$ref"]
  - code: ProvisioningStateSpecifiedForLROPut
    from: ManagedInstancePrivateEndpointConnections.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/privateEndpointConnections/{privateEndpointConnectionName}"].put
  - code: PutResponseCodes
    from: ManagedInstancePrivateEndpointConnections.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/privateEndpointConnections/{privateEndpointConnectionName}"].put
  - code: ParameterNotDefinedInGlobalParameters
    from: ManagedInstancePrivateEndpointConnections.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/privateEndpointConnections/{privateEndpointConnectionName}"].put.parameters
  - code: ParameterDescription
    from: ManagedInstancePrivateEndpointConnections.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/privateEndpointConnections/{privateEndpointConnectionName}"].put.parameters["2"]
  - code: ParameterDescription
    from: ManagedInstancePrivateEndpointConnections.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/privateEndpointConnections/{privateEndpointConnectionName}"].put.parameters["3"]
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: ManagedInstancePrivateEndpointConnections.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/privateEndpointConnections/{privateEndpointConnectionName}"].put.responses.default.schema["$ref"]
  - code: DeleteResponseCodes
    from: ManagedInstancePrivateEndpointConnections.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/privateEndpointConnections/{privateEndpointConnectionName}"].delete
  - code: ParameterNotDefinedInGlobalParameters
    from: ManagedInstancePrivateEndpointConnections.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/privateEndpointConnections/{privateEndpointConnectionName}"].delete.parameters
  - code: ParameterDescription
    from: ManagedInstancePrivateEndpointConnections.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/privateEndpointConnections/{privateEndpointConnectionName}"].delete.parameters["2"]
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: ManagedInstancePrivateEndpointConnections.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/privateEndpointConnections/{privateEndpointConnectionName}"].delete.responses.default.schema["$ref"]
  - code: SchemaDescriptionOrTitle
    from: ManagedInstancePrivateEndpointConnections.json
    where: $.definitions.ManagedInstancePrivateEndpointProperty
  - code: SchemaDescriptionOrTitle
    from: ManagedInstancePrivateEndpointConnections.json
    where: $.definitions.ManagedInstancePrivateLinkServiceConnectionStateProperty
  - code: MissingSegmentsInNestedResourceListOperation
    from: ManagedInstancePrivateLinkResources.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/privateLinkResources"]
  - code: ResourceNameRestriction
    from: ManagedInstancePrivateLinkResources.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/privateLinkResources"]
  - code: ParameterNotDefinedInGlobalParameters
    from: ManagedInstancePrivateLinkResources.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/privateLinkResources"].get.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: ManagedInstancePrivateLinkResources.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/privateLinkResources"].get.responses.default.schema["$ref"]
  - code: ResourceNameRestriction
    from: ManagedInstancePrivateLinkResources.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/privateLinkResources/{groupName}"]
  - code: ParameterNotDefinedInGlobalParameters
    from: ManagedInstancePrivateLinkResources.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/privateLinkResources/{groupName}"].get.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: ManagedInstancePrivateLinkResources.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/privateLinkResources/{groupName}"].get.responses.default.schema["$ref"]
  - code: PatchBodyParametersSchema
    from: ManagedInstances.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}"].patch.parameters["2"].schema.properties.properties
  - code: PatchBodyParametersSchema
    from: ManagedInstances.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}"].patch.parameters["2"].schema.properties.sku
  - code: ParameterNotDefinedInGlobalParameters
    from: ManagedInstances.json
    where: $.paths["/subscriptions/{subscriptionId}/providers/Microsoft.Sql/managedInstances"].get.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: ManagedInstances.json
    where: $.paths["/subscriptions/{subscriptionId}/providers/Microsoft.Sql/managedInstances"].get.responses.default.schema["$ref"]
  - code: MissingSegmentsInNestedResourceListOperation
    from: ManagedInstances.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/instancePools/{instancePoolName}/managedInstances"]
  - code: ResourceNameRestriction
    from: ManagedInstances.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/instancePools/{instancePoolName}/managedInstances"]
  - code: ParameterNotDefinedInGlobalParameters
    from: ManagedInstances.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/instancePools/{instancePoolName}/managedInstances"].get.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: ManagedInstances.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/instancePools/{instancePoolName}/managedInstances"].get.responses.default.schema["$ref"]
  - code: ParameterNotDefinedInGlobalParameters
    from: ManagedInstances.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances"].get.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: ManagedInstances.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances"].get.responses.default.schema["$ref"]
  - code: ResourceNameRestriction
    from: ManagedInstances.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}"]
  - code: ParameterNotDefinedInGlobalParameters
    from: ManagedInstances.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}"].get.parameters
  - code: ParametersInPointGet
    from: ManagedInstances.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}"].get.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: ManagedInstances.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}"].get.responses.default.schema["$ref"]
  - code: PutResponseCodes
    from: ManagedInstances.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}"].put
  - code: ParameterNotDefinedInGlobalParameters
    from: ManagedInstances.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}"].put.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: ManagedInstances.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}"].put.responses.default.schema["$ref"]
  - code: DeleteResponseCodes
    from: ManagedInstances.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}"].delete
  - code: ParameterNotDefinedInGlobalParameters
    from: ManagedInstances.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}"].delete.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: ManagedInstances.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}"].delete.responses.default.schema["$ref"]
  - code: ParameterNotDefinedInGlobalParameters
    from: ManagedInstances.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}"].patch.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: ManagedInstances.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}"].patch.responses.default.schema["$ref"]
  - code: ResourceNameRestriction
    from: ManagedInstances.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/failover"]
  - code: PostResponseCodes
    from: ManagedInstances.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/failover"].post
  - code: ParameterNotDefinedInGlobalParameters
    from: ManagedInstances.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/failover"].post.parameters
  - code: ParametersInPost
    from: ManagedInstances.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/failover"].post.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: ManagedInstances.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/failover"].post.responses.default.schema["$ref"]
  - code: ResourceNameRestriction
    from: ManagedInstances.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/outboundNetworkDependenciesEndpoints"]
  - code: OperationIdNounVerb
    from: ManagedInstances.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/outboundNetworkDependenciesEndpoints"].get.operationId
  - code: ParameterNotDefinedInGlobalParameters
    from: ManagedInstances.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/outboundNetworkDependenciesEndpoints"].get.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: ManagedInstances.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/outboundNetworkDependenciesEndpoints"].get.responses.default.schema["$ref"]
  - code: ResourceNameRestriction
    from: ManagedInstances.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/reevaluateInaccessibleDatabaseState"]
  - code: PostResponseCodes
    from: ManagedInstances.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/reevaluateInaccessibleDatabaseState"].post
  - code: ParameterNotDefinedInGlobalParameters
    from: ManagedInstances.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/reevaluateInaccessibleDatabaseState"].post.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: ManagedInstances.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/reevaluateInaccessibleDatabaseState"].post.responses.default.schema["$ref"]
  - code: ResourceNameRestriction
    from: ManagedInstances.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/refreshExternalGovernanceStatus"]
  - code: ParameterNotDefinedInGlobalParameters
    from: ManagedInstances.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/refreshExternalGovernanceStatus"].post.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: ManagedInstances.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/refreshExternalGovernanceStatus"].post.responses.default.schema["$ref"]
  - code: ResourceNameRestriction
    from: ManagedInstances.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/start"]
  - code: ParameterNotDefinedInGlobalParameters
    from: ManagedInstances.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/start"].post.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: ManagedInstances.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/start"].post.responses.default.schema["$ref"]
  - code: ResourceNameRestriction
    from: ManagedInstances.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/stop"]
  - code: ParameterNotDefinedInGlobalParameters
    from: ManagedInstances.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/stop"].post.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: ManagedInstances.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/stop"].post.responses.default.schema["$ref"]
  - code: ResourceNameRestriction
    from: ManagedInstances.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/topqueries"]
  - code: OperationIdNounVerb
    from: ManagedInstances.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/topqueries"].get.operationId
  - code: ParameterNotDefinedInGlobalParameters
    from: ManagedInstances.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/topqueries"].get.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: ManagedInstances.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/topqueries"].get.responses.default.schema["$ref"]
  - code: ResourceNameRestriction
    from: ManagedInstances.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/validateAzureKeyVaultEncryptionKey"]
  - code: PostResponseCodes
    from: ManagedInstances.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/validateAzureKeyVaultEncryptionKey"].post
  - code: ParameterNotDefinedInGlobalParameters
    from: ManagedInstances.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/validateAzureKeyVaultEncryptionKey"].post.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: ManagedInstances.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/validateAzureKeyVaultEncryptionKey"].post.responses.default.schema["$ref"]
  - code: SchemaDescriptionOrTitle
    from: ManagedInstances.json
    where: $.definitions.ManagedInstancePrivateEndpointProperty
  - code: SchemaDescriptionOrTitle
    from: ManagedInstances.json
    where: $.definitions.ManagedInstancePrivateLinkServiceConnectionStateProperty
  - code: SchemaDescriptionOrTitle
    from: ManagedInstances.json
    where: $.definitions.TopQueries
  - code: ResourceNameRestriction
    from: ManagedInstanceTdeCertificates.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/tdeCertificates"]
  - code: PostResponseCodes
    from: ManagedInstanceTdeCertificates.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/tdeCertificates"].post
  - code: ParameterNotDefinedInGlobalParameters
    from: ManagedInstanceTdeCertificates.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/tdeCertificates"].post.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: ManagedInstanceTdeCertificates.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/tdeCertificates"].post.responses.default.schema["$ref"]
  - code: MissingSegmentsInNestedResourceListOperation
    from: ManagedInstanceVulnerabilityAssessments.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/vulnerabilityAssessments"]
  - code: ResourceNameRestriction
    from: ManagedInstanceVulnerabilityAssessments.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/vulnerabilityAssessments"]
  - code: ParameterNotDefinedInGlobalParameters
    from: ManagedInstanceVulnerabilityAssessments.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/vulnerabilityAssessments"].get.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: ManagedInstanceVulnerabilityAssessments.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/vulnerabilityAssessments"].get.responses.default.schema["$ref"]
  - code: ResourceNameRestriction
    from: ManagedInstanceVulnerabilityAssessments.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/vulnerabilityAssessments/{vulnerabilityAssessmentName}"]
  - code: ParameterNotDefinedInGlobalParameters
    from: ManagedInstanceVulnerabilityAssessments.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/vulnerabilityAssessments/{vulnerabilityAssessmentName}"].get.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: ManagedInstanceVulnerabilityAssessments.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/vulnerabilityAssessments/{vulnerabilityAssessmentName}"].get.responses.default.schema["$ref"]
  - code: ParameterNotDefinedInGlobalParameters
    from: ManagedInstanceVulnerabilityAssessments.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/vulnerabilityAssessments/{vulnerabilityAssessmentName}"].put.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: ManagedInstanceVulnerabilityAssessments.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/vulnerabilityAssessments/{vulnerabilityAssessmentName}"].put.responses.default.schema["$ref"]
  - code: DeleteResponseCodes
    from: ManagedInstanceVulnerabilityAssessments.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/vulnerabilityAssessments/{vulnerabilityAssessmentName}"].delete
  - code: ParameterNotDefinedInGlobalParameters
    from: ManagedInstanceVulnerabilityAssessments.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/vulnerabilityAssessments/{vulnerabilityAssessmentName}"].delete.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: ManagedInstanceVulnerabilityAssessments.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/vulnerabilityAssessments/{vulnerabilityAssessmentName}"].delete.responses.default.schema["$ref"]
  - code: MissingSegmentsInNestedResourceListOperation
    from: ManagedLedgerDigestUploads.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/databases/{databaseName}/ledgerDigestUploads"]
  - code: ResourceNameRestriction
    from: ManagedLedgerDigestUploads.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/databases/{databaseName}/ledgerDigestUploads"]
  - code: OperationIdNounConflictingModelNames
    from: ManagedLedgerDigestUploads.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/databases/{databaseName}/ledgerDigestUploads"].get.operationId
  - code: ParameterNotDefinedInGlobalParameters
    from: ManagedLedgerDigestUploads.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/databases/{databaseName}/ledgerDigestUploads"].get.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: ManagedLedgerDigestUploads.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/databases/{databaseName}/ledgerDigestUploads"].get.responses.default.schema["$ref"]
  - code: ResourceNameRestriction
    from: ManagedLedgerDigestUploads.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/databases/{databaseName}/ledgerDigestUploads/{ledgerDigestUploads}"]
  - code: OperationIdNounConflictingModelNames
    from: ManagedLedgerDigestUploads.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/databases/{databaseName}/ledgerDigestUploads/{ledgerDigestUploads}"].get.operationId
  - code: ParameterNotDefinedInGlobalParameters
    from: ManagedLedgerDigestUploads.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/databases/{databaseName}/ledgerDigestUploads/{ledgerDigestUploads}"].get.parameters
  - code: ParameterDescription
    from: ManagedLedgerDigestUploads.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/databases/{databaseName}/ledgerDigestUploads/{ledgerDigestUploads}"].get.parameters["3"]
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: ManagedLedgerDigestUploads.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/databases/{databaseName}/ledgerDigestUploads/{ledgerDigestUploads}"].get.responses.default.schema["$ref"]
  - code: ProvisioningStateSpecifiedForLROPut
    from: ManagedLedgerDigestUploads.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/databases/{databaseName}/ledgerDigestUploads/{ledgerDigestUploads}"].put
  - code: PutResponseCodes
    from: ManagedLedgerDigestUploads.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/databases/{databaseName}/ledgerDigestUploads/{ledgerDigestUploads}"].put
  - code: OperationIdNounConflictingModelNames
    from: ManagedLedgerDigestUploads.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/databases/{databaseName}/ledgerDigestUploads/{ledgerDigestUploads}"].put.operationId
  - code: ParameterNotDefinedInGlobalParameters
    from: ManagedLedgerDigestUploads.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/databases/{databaseName}/ledgerDigestUploads/{ledgerDigestUploads}"].put.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: ManagedLedgerDigestUploads.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/databases/{databaseName}/ledgerDigestUploads/{ledgerDigestUploads}"].put.responses.default.schema["$ref"]
  - code: LongRunningOperationsOptionsValidator
    from: ManagedLedgerDigestUploads.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/databases/{databaseName}/ledgerDigestUploads/{ledgerDigestUploads}/disable"]
  - code: ResourceNameRestriction
    from: ManagedLedgerDigestUploads.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/databases/{databaseName}/ledgerDigestUploads/{ledgerDigestUploads}/disable"]
  - code: OperationIdNounConflictingModelNames
    from: ManagedLedgerDigestUploads.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/databases/{databaseName}/ledgerDigestUploads/{ledgerDigestUploads}/disable"].post.operationId
  - code: ParameterNotDefinedInGlobalParameters
    from: ManagedLedgerDigestUploads.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/databases/{databaseName}/ledgerDigestUploads/{ledgerDigestUploads}/disable"].post.parameters
  - code: ParameterDescription
    from: ManagedLedgerDigestUploads.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/databases/{databaseName}/ledgerDigestUploads/{ledgerDigestUploads}/disable"].post.parameters["3"]
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: ManagedLedgerDigestUploads.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/databases/{databaseName}/ledgerDigestUploads/{ledgerDigestUploads}/disable"].post.responses.default.schema["$ref"]
  - code: MissingSegmentsInNestedResourceListOperation
    from: ManagedRestorableDroppedDatabaseBackupShortTermRetentionPolicies.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/restorableDroppedDatabases/{restorableDroppedDatabaseId}/backupShortTermRetentionPolicies"]
  - code: ResourceNameRestriction
    from: ManagedRestorableDroppedDatabaseBackupShortTermRetentionPolicies.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/restorableDroppedDatabases/{restorableDroppedDatabaseId}/backupShortTermRetentionPolicies"]
  - code: ParameterNotDefinedInGlobalParameters
    from: ManagedRestorableDroppedDatabaseBackupShortTermRetentionPolicies.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/restorableDroppedDatabases/{restorableDroppedDatabaseId}/backupShortTermRetentionPolicies"].get.parameters
  - code: ParameterDescription
    from: ManagedRestorableDroppedDatabaseBackupShortTermRetentionPolicies.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/restorableDroppedDatabases/{restorableDroppedDatabaseId}/backupShortTermRetentionPolicies"].get.parameters["2"]
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: ManagedRestorableDroppedDatabaseBackupShortTermRetentionPolicies.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/restorableDroppedDatabases/{restorableDroppedDatabaseId}/backupShortTermRetentionPolicies"].get.responses.default.schema["$ref"]
  - code: ResourceNameRestriction
    from: ManagedRestorableDroppedDatabaseBackupShortTermRetentionPolicies.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/restorableDroppedDatabases/{restorableDroppedDatabaseId}/backupShortTermRetentionPolicies/{policyName}"]
  - code: ParameterNotDefinedInGlobalParameters
    from: ManagedRestorableDroppedDatabaseBackupShortTermRetentionPolicies.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/restorableDroppedDatabases/{restorableDroppedDatabaseId}/backupShortTermRetentionPolicies/{policyName}"].get.parameters
  - code: ParameterDescription
    from: ManagedRestorableDroppedDatabaseBackupShortTermRetentionPolicies.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/restorableDroppedDatabases/{restorableDroppedDatabaseId}/backupShortTermRetentionPolicies/{policyName}"].get.parameters["2"]
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: ManagedRestorableDroppedDatabaseBackupShortTermRetentionPolicies.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/restorableDroppedDatabases/{restorableDroppedDatabaseId}/backupShortTermRetentionPolicies/{policyName}"].get.responses.default.schema["$ref"]
  - code: ProvisioningStateSpecifiedForLROPut
    from: ManagedRestorableDroppedDatabaseBackupShortTermRetentionPolicies.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/restorableDroppedDatabases/{restorableDroppedDatabaseId}/backupShortTermRetentionPolicies/{policyName}"].put
  - code: PutResponseCodes
    from: ManagedRestorableDroppedDatabaseBackupShortTermRetentionPolicies.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/restorableDroppedDatabases/{restorableDroppedDatabaseId}/backupShortTermRetentionPolicies/{policyName}"].put
  - code: ParameterNotDefinedInGlobalParameters
    from: ManagedRestorableDroppedDatabaseBackupShortTermRetentionPolicies.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/restorableDroppedDatabases/{restorableDroppedDatabaseId}/backupShortTermRetentionPolicies/{policyName}"].put.parameters
  - code: ParameterDescription
    from: ManagedRestorableDroppedDatabaseBackupShortTermRetentionPolicies.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/restorableDroppedDatabases/{restorableDroppedDatabaseId}/backupShortTermRetentionPolicies/{policyName}"].put.parameters["2"]
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: ManagedRestorableDroppedDatabaseBackupShortTermRetentionPolicies.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/restorableDroppedDatabases/{restorableDroppedDatabaseId}/backupShortTermRetentionPolicies/{policyName}"].put.responses.default.schema["$ref"]
  - code: ParameterNotDefinedInGlobalParameters
    from: ManagedRestorableDroppedDatabaseBackupShortTermRetentionPolicies.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/restorableDroppedDatabases/{restorableDroppedDatabaseId}/backupShortTermRetentionPolicies/{policyName}"].patch.parameters
  - code: ParameterDescription
    from: ManagedRestorableDroppedDatabaseBackupShortTermRetentionPolicies.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/restorableDroppedDatabases/{restorableDroppedDatabaseId}/backupShortTermRetentionPolicies/{policyName}"].patch.parameters["2"]
  - code: ProvisioningStateSpecifiedForLROPatch
    from: ManagedRestorableDroppedDatabaseBackupShortTermRetentionPolicies.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/restorableDroppedDatabases/{restorableDroppedDatabaseId}/backupShortTermRetentionPolicies/{policyName}"].patch.responses["200"]
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: ManagedRestorableDroppedDatabaseBackupShortTermRetentionPolicies.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/restorableDroppedDatabases/{restorableDroppedDatabaseId}/backupShortTermRetentionPolicies/{policyName}"].patch.responses.default.schema["$ref"]
  - code: MissingSegmentsInNestedResourceListOperation
    from: ManagedServerDnsAliases.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/dnsAliases"]
  - code: ResourceNameRestriction
    from: ManagedServerDnsAliases.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/dnsAliases"]
  - code: ParameterNotDefinedInGlobalParameters
    from: ManagedServerDnsAliases.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/dnsAliases"].get.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: ManagedServerDnsAliases.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/dnsAliases"].get.responses.default.schema["$ref"]
  - code: ResourceNameRestriction
    from: ManagedServerDnsAliases.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/dnsAliases/{dnsAliasName}"]
  - code: ParameterNotDefinedInGlobalParameters
    from: ManagedServerDnsAliases.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/dnsAliases/{dnsAliasName}"].get.parameters
  - code: ParameterDescription
    from: ManagedServerDnsAliases.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/dnsAliases/{dnsAliasName}"].get.parameters["2"]
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: ManagedServerDnsAliases.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/dnsAliases/{dnsAliasName}"].get.responses.default.schema["$ref"]
  - code: ProvisioningStateSpecifiedForLROPut
    from: ManagedServerDnsAliases.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/dnsAliases/{dnsAliasName}"].put
  - code: PutRequestResponseSchemeArm
    from: ManagedServerDnsAliases.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/dnsAliases/{dnsAliasName}"].put
  - code: PutResponseCodes
    from: ManagedServerDnsAliases.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/dnsAliases/{dnsAliasName}"].put
  - code: ParameterNotDefinedInGlobalParameters
    from: ManagedServerDnsAliases.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/dnsAliases/{dnsAliasName}"].put.parameters
  - code: ParameterDescription
    from: ManagedServerDnsAliases.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/dnsAliases/{dnsAliasName}"].put.parameters["2"]
  - code: ParameterDescription
    from: ManagedServerDnsAliases.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/dnsAliases/{dnsAliasName}"].put.parameters["3"]
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: ManagedServerDnsAliases.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/dnsAliases/{dnsAliasName}"].put.responses.default.schema["$ref"]
  - code: DeleteResponseCodes
    from: ManagedServerDnsAliases.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/dnsAliases/{dnsAliasName}"].delete
  - code: ParameterNotDefinedInGlobalParameters
    from: ManagedServerDnsAliases.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/dnsAliases/{dnsAliasName}"].delete.parameters
  - code: ParameterDescription
    from: ManagedServerDnsAliases.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/dnsAliases/{dnsAliasName}"].delete.parameters["2"]
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: ManagedServerDnsAliases.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/dnsAliases/{dnsAliasName}"].delete.responses.default.schema["$ref"]
  - code: LongRunningOperationsOptionsValidator
    from: ManagedServerDnsAliases.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/dnsAliases/{dnsAliasName}/acquire"]
  - code: ResourceNameRestriction
    from: ManagedServerDnsAliases.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/dnsAliases/{dnsAliasName}/acquire"]
  - code: ParameterNotDefinedInGlobalParameters
    from: ManagedServerDnsAliases.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/dnsAliases/{dnsAliasName}/acquire"].post.parameters
  - code: ParameterDescription
    from: ManagedServerDnsAliases.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/dnsAliases/{dnsAliasName}/acquire"].post.parameters["2"]
  - code: ParameterDescription
    from: ManagedServerDnsAliases.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/dnsAliases/{dnsAliasName}/acquire"].post.parameters["3"]
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: ManagedServerDnsAliases.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/dnsAliases/{dnsAliasName}/acquire"].post.responses.default.schema["$ref"]
  - code: MissingSegmentsInNestedResourceListOperation
    from: ManagedServerSecurityAlertPolicies.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/securityAlertPolicies"]
  - code: ResourceNameRestriction
    from: ManagedServerSecurityAlertPolicies.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/securityAlertPolicies"]
  - code: ParameterNotDefinedInGlobalParameters
    from: ManagedServerSecurityAlertPolicies.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/securityAlertPolicies"].get.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: ManagedServerSecurityAlertPolicies.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/securityAlertPolicies"].get.responses.default.schema["$ref"]
  - code: ResourceNameRestriction
    from: ManagedServerSecurityAlertPolicies.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/securityAlertPolicies/{securityAlertPolicyName}"]
  - code: ParameterNotDefinedInGlobalParameters
    from: ManagedServerSecurityAlertPolicies.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/securityAlertPolicies/{securityAlertPolicyName}"].get.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: ManagedServerSecurityAlertPolicies.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/securityAlertPolicies/{securityAlertPolicyName}"].get.responses.default.schema["$ref"]
  - code: ProvisioningStateSpecifiedForLROPut
    from: ManagedServerSecurityAlertPolicies.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/securityAlertPolicies/{securityAlertPolicyName}"].put
  - code: PutResponseCodes
    from: ManagedServerSecurityAlertPolicies.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/securityAlertPolicies/{securityAlertPolicyName}"].put
  - code: ParameterNotDefinedInGlobalParameters
    from: ManagedServerSecurityAlertPolicies.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/securityAlertPolicies/{securityAlertPolicyName}"].put.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: ManagedServerSecurityAlertPolicies.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/securityAlertPolicies/{securityAlertPolicyName}"].put.responses.default.schema["$ref"]
  - code: SystemDataDefinitionsCommonTypes
    from: ManagedServerSecurityAlertPolicies.json
    where: $.definitions.ManagedServerSecurityAlertPolicy.properties.systemData["$ref"]
  - code: MissingSegmentsInNestedResourceListOperation
    from: NetworkSecurityPerimeterConfigurations.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/networkSecurityPerimeterConfigurations"]
  - code: ResourceNameRestriction
    from: NetworkSecurityPerimeterConfigurations.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/networkSecurityPerimeterConfigurations"]
  - code: ParameterNotDefinedInGlobalParameters
    from: NetworkSecurityPerimeterConfigurations.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/networkSecurityPerimeterConfigurations"].get.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: NetworkSecurityPerimeterConfigurations.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/networkSecurityPerimeterConfigurations"].get.responses.default.schema["$ref"]
  - code: ResourceNameRestriction
    from: NetworkSecurityPerimeterConfigurations.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/networkSecurityPerimeterConfigurations/{nspConfigName}"]
  - code: ParameterNotDefinedInGlobalParameters
    from: NetworkSecurityPerimeterConfigurations.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/networkSecurityPerimeterConfigurations/{nspConfigName}"].get.parameters
  - code: ParameterDescription
    from: NetworkSecurityPerimeterConfigurations.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/networkSecurityPerimeterConfigurations/{nspConfigName}"].get.parameters["2"]
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: NetworkSecurityPerimeterConfigurations.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/networkSecurityPerimeterConfigurations/{nspConfigName}"].get.responses.default.schema["$ref"]
  - code: ResourceNameRestriction
    from: NetworkSecurityPerimeterConfigurations.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/networkSecurityPerimeterConfigurations/{nspConfigName}/reconcile"]
  - code: ParameterNotDefinedInGlobalParameters
    from: NetworkSecurityPerimeterConfigurations.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/networkSecurityPerimeterConfigurations/{nspConfigName}/reconcile"].post.parameters
  - code: ParameterDescription
    from: NetworkSecurityPerimeterConfigurations.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/networkSecurityPerimeterConfigurations/{nspConfigName}/reconcile"].post.parameters["2"]
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: NetworkSecurityPerimeterConfigurations.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/networkSecurityPerimeterConfigurations/{nspConfigName}/reconcile"].post.responses.default.schema["$ref"]
  - code: SchemaDescriptionOrTitle
    from: NetworkSecurityPerimeterConfigurations.json
    where: $.definitions.NSPConfigAccessRule
  - code: SchemaDescriptionOrTitle
    from: NetworkSecurityPerimeterConfigurations.json
    where: $.definitions.NSPConfigAccessRuleProperties
  - code: SchemaDescriptionOrTitle
    from: NetworkSecurityPerimeterConfigurations.json
    where: $.definitions.NSPConfigAssociation
  - code: SchemaDescriptionOrTitle
    from: NetworkSecurityPerimeterConfigurations.json
    where: $.definitions.NSPConfigNetworkSecurityPerimeterRule
  - code: LocationMustHaveXmsMutability
    from: NetworkSecurityPerimeterConfigurations.json
    where: $.definitions.NSPConfigNetworkSecurityPerimeterRule.properties.location
  - code: SchemaDescriptionOrTitle
    from: NetworkSecurityPerimeterConfigurations.json
    where: $.definitions.NSPConfigPerimeter
  - code: LocationMustHaveXmsMutability
    from: NetworkSecurityPerimeterConfigurations.json
    where: $.definitions.NSPConfigPerimeter.properties.location
  - code: SchemaDescriptionOrTitle
    from: NetworkSecurityPerimeterConfigurations.json
    where: $.definitions.NSPConfigProfile
  - code: SchemaDescriptionOrTitle
    from: NetworkSecurityPerimeterConfigurations.json
    where: $.definitions.NSPProvisioningIssue
  - code: SchemaDescriptionOrTitle
    from: NetworkSecurityPerimeterConfigurations.json
    where: $.definitions.NSPProvisioningIssueProperties
  - code: ParameterNotDefinedInGlobalParameters
    from: Operations.json
    where: $.paths["/providers/Microsoft.Sql/operations"].get.parameters
  - code: OperationsApiResponseSchema
    from: Operations.json
    where: $.paths["/providers/Microsoft.Sql/operations"].get.responses["200"].schema
  - code: OperationsApiSchemaUsesCommonTypes
    from: Operations.json
    where: $.paths["/providers/Microsoft.Sql/operations"].get.responses["200"].schema["$ref"]
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: Operations.json
    where: $.paths["/providers/Microsoft.Sql/operations"].get.responses.default.schema["$ref"]
  - code: AvoidAdditionalProperties
    from: Operations.json
    where: $.definitions.Operation.properties.properties
  - code: MissingSegmentsInNestedResourceListOperation
    from: OutboundFirewallRules.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/outboundFirewallRules"]
  - code: ResourceNameRestriction
    from: OutboundFirewallRules.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/outboundFirewallRules"]
  - code: ParameterNotDefinedInGlobalParameters
    from: OutboundFirewallRules.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/outboundFirewallRules"].get.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: OutboundFirewallRules.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/outboundFirewallRules"].get.responses.default.schema["$ref"]
  - code: ResourceNameRestriction
    from: OutboundFirewallRules.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/outboundFirewallRules/{outboundRuleFqdn}"]
  - code: ParameterNotDefinedInGlobalParameters
    from: OutboundFirewallRules.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/outboundFirewallRules/{outboundRuleFqdn}"].get.parameters
  - code: ParameterDescription
    from: OutboundFirewallRules.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/outboundFirewallRules/{outboundRuleFqdn}"].get.parameters["2"]
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: OutboundFirewallRules.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/outboundFirewallRules/{outboundRuleFqdn}"].get.responses.default.schema["$ref"]
  - code: PutResponseCodes
    from: OutboundFirewallRules.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/outboundFirewallRules/{outboundRuleFqdn}"].put
  - code: ParameterNotDefinedInGlobalParameters
    from: OutboundFirewallRules.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/outboundFirewallRules/{outboundRuleFqdn}"].put.parameters
  - code: ParameterDescription
    from: OutboundFirewallRules.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/outboundFirewallRules/{outboundRuleFqdn}"].put.parameters["2"]
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: OutboundFirewallRules.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/outboundFirewallRules/{outboundRuleFqdn}"].put.responses.default.schema["$ref"]
  - code: DeleteResponseCodes
    from: OutboundFirewallRules.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/outboundFirewallRules/{outboundRuleFqdn}"].delete
  - code: ParameterNotDefinedInGlobalParameters
    from: OutboundFirewallRules.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/outboundFirewallRules/{outboundRuleFqdn}"].delete.parameters
  - code: ParameterDescription
    from: OutboundFirewallRules.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/outboundFirewallRules/{outboundRuleFqdn}"].delete.parameters["2"]
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: OutboundFirewallRules.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/outboundFirewallRules/{outboundRuleFqdn}"].delete.responses.default.schema["$ref"]
  - code: MissingSegmentsInNestedResourceListOperation
    from: PrivateEndpointConnections.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/privateEndpointConnections"]
  - code: ResourceNameRestriction
    from: PrivateEndpointConnections.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/privateEndpointConnections"]
  - code: ParameterNotDefinedInGlobalParameters
    from: PrivateEndpointConnections.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/privateEndpointConnections"].get.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: PrivateEndpointConnections.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/privateEndpointConnections"].get.responses.default.schema["$ref"]
  - code: ResourceNameRestriction
    from: PrivateEndpointConnections.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/privateEndpointConnections/{privateEndpointConnectionName}"]
  - code: ParameterNotDefinedInGlobalParameters
    from: PrivateEndpointConnections.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/privateEndpointConnections/{privateEndpointConnectionName}"].get.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: PrivateEndpointConnections.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/privateEndpointConnections/{privateEndpointConnectionName}"].get.responses.default.schema["$ref"]
  - code: ProvisioningStateSpecifiedForLROPut
    from: PrivateEndpointConnections.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/privateEndpointConnections/{privateEndpointConnectionName}"].put
  - code: PutResponseCodes
    from: PrivateEndpointConnections.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/privateEndpointConnections/{privateEndpointConnectionName}"].put
  - code: ParameterNotDefinedInGlobalParameters
    from: PrivateEndpointConnections.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/privateEndpointConnections/{privateEndpointConnectionName}"].put.parameters
  - code: ParameterDescription
    from: PrivateEndpointConnections.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/privateEndpointConnections/{privateEndpointConnectionName}"].put.parameters["2"]
  - code: ParameterDescription
    from: PrivateEndpointConnections.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/privateEndpointConnections/{privateEndpointConnectionName}"].put.parameters["3"]
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: PrivateEndpointConnections.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/privateEndpointConnections/{privateEndpointConnectionName}"].put.responses.default.schema["$ref"]
  - code: DeleteResponseCodes
    from: PrivateEndpointConnections.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/privateEndpointConnections/{privateEndpointConnectionName}"].delete
  - code: ParameterNotDefinedInGlobalParameters
    from: PrivateEndpointConnections.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/privateEndpointConnections/{privateEndpointConnectionName}"].delete.parameters
  - code: ParameterDescription
    from: PrivateEndpointConnections.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/privateEndpointConnections/{privateEndpointConnectionName}"].delete.parameters["2"]
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: PrivateEndpointConnections.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/privateEndpointConnections/{privateEndpointConnectionName}"].delete.responses.default.schema["$ref"]
  - code: ProvisioningStateValidation
    from: PrivateEndpointConnections.json
    where: $.definitions.PrivateEndpointConnectionProperties.properties.provisioningState
  - code: SchemaDescriptionOrTitle
    from: PrivateEndpointConnections.json
    where: $.definitions.PrivateEndpointProperty
  - code: SchemaDescriptionOrTitle
    from: PrivateEndpointConnections.json
    where: $.definitions.PrivateLinkServiceConnectionStateProperty
  - code: MissingSegmentsInNestedResourceListOperation
    from: PrivateLinkResources.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/privateLinkResources"]
  - code: ResourceNameRestriction
    from: PrivateLinkResources.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/privateLinkResources"]
  - code: ParameterNotDefinedInGlobalParameters
    from: PrivateLinkResources.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/privateLinkResources"].get.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: PrivateLinkResources.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/privateLinkResources"].get.responses.default.schema["$ref"]
  - code: ResourceNameRestriction
    from: PrivateLinkResources.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/privateLinkResources/{groupName}"]
  - code: ParameterNotDefinedInGlobalParameters
    from: PrivateLinkResources.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/privateLinkResources/{groupName}"].get.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: PrivateLinkResources.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/privateLinkResources/{groupName}"].get.responses.default.schema["$ref"]
  - code: MissingSegmentsInNestedResourceListOperation
    from: RecoverableDatabases.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/recoverableDatabases"]
  - code: ResourceNameRestriction
    from: RecoverableDatabases.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/recoverableDatabases"]
  - code: ParameterNotDefinedInGlobalParameters
    from: RecoverableDatabases.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/recoverableDatabases"].get.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: RecoverableDatabases.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/recoverableDatabases"].get.responses.default.schema["$ref"]
  - code: ResourceNameRestriction
    from: RecoverableDatabases.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/recoverableDatabases/{databaseName}"]
  - code: ParameterNotDefinedInGlobalParameters
    from: RecoverableDatabases.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/recoverableDatabases/{databaseName}"].get.parameters
  - code: ParametersInPointGet
    from: RecoverableDatabases.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/recoverableDatabases/{databaseName}"].get.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: RecoverableDatabases.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/recoverableDatabases/{databaseName}"].get.responses.default.schema["$ref"]
  - code: AvoidAdditionalProperties
    from: RecoverableDatabases.json
    where: $.definitions.RecoverableDatabaseProperties.properties.keys
  - code: MissingSegmentsInNestedResourceListOperation
    from: RecoverableManagedDatabases.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/recoverableDatabases"]
  - code: ResourceNameRestriction
    from: RecoverableManagedDatabases.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/recoverableDatabases"]
  - code: ParameterNotDefinedInGlobalParameters
    from: RecoverableManagedDatabases.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/recoverableDatabases"].get.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: RecoverableManagedDatabases.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/recoverableDatabases"].get.responses.default.schema["$ref"]
  - code: ResourceNameRestriction
    from: RecoverableManagedDatabases.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/recoverableDatabases/{recoverableDatabaseName}"]
  - code: ParameterNotDefinedInGlobalParameters
    from: RecoverableManagedDatabases.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/recoverableDatabases/{recoverableDatabaseName}"].get.parameters
  - code: ParameterDescription
    from: RecoverableManagedDatabases.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/recoverableDatabases/{recoverableDatabaseName}"].get.parameters["2"]
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: RecoverableManagedDatabases.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/recoverableDatabases/{recoverableDatabaseName}"].get.responses.default.schema["$ref"]
  - code: MissingSegmentsInNestedResourceListOperation
    from: ReplicationLinks.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/replicationLinks"]
  - code: ResourceNameRestriction
    from: ReplicationLinks.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/replicationLinks"]
  - code: ParameterNotDefinedInGlobalParameters
    from: ReplicationLinks.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/replicationLinks"].get.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: ReplicationLinks.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/replicationLinks"].get.responses.default.schema["$ref"]
  - code: ResourceNameRestriction
    from: ReplicationLinks.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/replicationLinks/{linkId}"]
  - code: ParameterNotDefinedInGlobalParameters
    from: ReplicationLinks.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/replicationLinks/{linkId}"].get.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: ReplicationLinks.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/replicationLinks/{linkId}"].get.responses.default.schema["$ref"]
  - code: ProvisioningStateSpecifiedForLROPut
    from: ReplicationLinks.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/replicationLinks/{linkId}"].put
  - code: PutResponseCodes
    from: ReplicationLinks.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/replicationLinks/{linkId}"].put
  - code: ParameterNotDefinedInGlobalParameters
    from: ReplicationLinks.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/replicationLinks/{linkId}"].put.parameters
  - code: ParameterDescription
    from: ReplicationLinks.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/replicationLinks/{linkId}"].put.parameters["3"]
  - code: ParameterDescription
    from: ReplicationLinks.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/replicationLinks/{linkId}"].put.parameters["4"]
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: ReplicationLinks.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/replicationLinks/{linkId}"].put.responses.default.schema["$ref"]
  - code: DeleteResponseCodes
    from: ReplicationLinks.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/replicationLinks/{linkId}"].delete
  - code: ParameterNotDefinedInGlobalParameters
    from: ReplicationLinks.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/replicationLinks/{linkId}"].delete.parameters
  - code: ParameterDescription
    from: ReplicationLinks.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/replicationLinks/{linkId}"].delete.parameters["3"]
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: ReplicationLinks.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/replicationLinks/{linkId}"].delete.responses.default.schema["$ref"]
  - code: ParameterNotDefinedInGlobalParameters
    from: ReplicationLinks.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/replicationLinks/{linkId}"].patch.parameters
  - code: ParameterDescription
    from: ReplicationLinks.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/replicationLinks/{linkId}"].patch.parameters["3"]
  - code: ParameterDescription
    from: ReplicationLinks.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/replicationLinks/{linkId}"].patch.parameters["4"]
  - code: ProvisioningStateSpecifiedForLROPatch
    from: ReplicationLinks.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/replicationLinks/{linkId}"].patch.responses["200"]
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: ReplicationLinks.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/replicationLinks/{linkId}"].patch.responses.default.schema["$ref"]
  - code: LongRunningOperationsOptionsValidator
    from: ReplicationLinks.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/replicationLinks/{linkId}/failover"]
  - code: ResourceNameRestriction
    from: ReplicationLinks.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/replicationLinks/{linkId}/failover"]
  - code: ParameterNotDefinedInGlobalParameters
    from: ReplicationLinks.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/replicationLinks/{linkId}/failover"].post.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: ReplicationLinks.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/replicationLinks/{linkId}/failover"].post.responses.default.schema["$ref"]
  - code: LongRunningOperationsOptionsValidator
    from: ReplicationLinks.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/replicationLinks/{linkId}/forceFailoverAllowDataLoss"]
  - code: ResourceNameRestriction
    from: ReplicationLinks.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/replicationLinks/{linkId}/forceFailoverAllowDataLoss"]
  - code: ParameterNotDefinedInGlobalParameters
    from: ReplicationLinks.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/replicationLinks/{linkId}/forceFailoverAllowDataLoss"].post.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: ReplicationLinks.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/replicationLinks/{linkId}/forceFailoverAllowDataLoss"].post.responses.default.schema["$ref"]
  - code: MissingSegmentsInNestedResourceListOperation
    from: ReplicationLinks.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/replicationLinks"]
  - code: ResourceNameRestriction
    from: ReplicationLinks.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/replicationLinks"]
  - code: ParameterNotDefinedInGlobalParameters
    from: ReplicationLinks.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/replicationLinks"].get.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: ReplicationLinks.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/replicationLinks"].get.responses.default.schema["$ref"]
  - code: MissingSegmentsInNestedResourceListOperation
    from: RestorableDroppedDatabases.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/restorableDroppedDatabases"]
  - code: ResourceNameRestriction
    from: RestorableDroppedDatabases.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/restorableDroppedDatabases"]
  - code: ParameterNotDefinedInGlobalParameters
    from: RestorableDroppedDatabases.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/restorableDroppedDatabases"].get.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: RestorableDroppedDatabases.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/restorableDroppedDatabases"].get.responses.default.schema["$ref"]
  - code: ResourceNameRestriction
    from: RestorableDroppedDatabases.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/restorableDroppedDatabases/{restorableDroppedDatabaseId}"]
  - code: ParameterNotDefinedInGlobalParameters
    from: RestorableDroppedDatabases.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/restorableDroppedDatabases/{restorableDroppedDatabaseId}"].get.parameters
  - code: ParametersInPointGet
    from: RestorableDroppedDatabases.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/restorableDroppedDatabases/{restorableDroppedDatabaseId}"].get.parameters
  - code: ParameterDescription
    from: RestorableDroppedDatabases.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/restorableDroppedDatabases/{restorableDroppedDatabaseId}"].get.parameters["2"]
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: RestorableDroppedDatabases.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/restorableDroppedDatabases/{restorableDroppedDatabaseId}"].get.responses.default.schema["$ref"]
  - code: AvoidAdditionalProperties
    from: RestorableDroppedDatabases.json
    where: $.definitions.RestorableDroppedDatabaseProperties.properties.keys
  - code: MissingSegmentsInNestedResourceListOperation
    from: RestorableDroppedManagedDatabases.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/restorableDroppedDatabases"]
  - code: ResourceNameRestriction
    from: RestorableDroppedManagedDatabases.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/restorableDroppedDatabases"]
  - code: ParameterNotDefinedInGlobalParameters
    from: RestorableDroppedManagedDatabases.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/restorableDroppedDatabases"].get.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: RestorableDroppedManagedDatabases.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/restorableDroppedDatabases"].get.responses.default.schema["$ref"]
  - code: ResourceNameRestriction
    from: RestorableDroppedManagedDatabases.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/restorableDroppedDatabases/{restorableDroppedDatabaseId}"]
  - code: ParameterNotDefinedInGlobalParameters
    from: RestorableDroppedManagedDatabases.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/restorableDroppedDatabases/{restorableDroppedDatabaseId}"].get.parameters
  - code: ParameterDescription
    from: RestorableDroppedManagedDatabases.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/restorableDroppedDatabases/{restorableDroppedDatabaseId}"].get.parameters["2"]
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: RestorableDroppedManagedDatabases.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/restorableDroppedDatabases/{restorableDroppedDatabaseId}"].get.responses.default.schema["$ref"]
  - code: LongRunningOperationsOptionsValidator
    from: RestorePoints.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/restorePoints"]
  - code: MissingSegmentsInNestedResourceListOperation
    from: RestorePoints.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/restorePoints"]
  - code: ResourceNameRestriction
    from: RestorePoints.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/restorePoints"]
  - code: ParameterNotDefinedInGlobalParameters
    from: RestorePoints.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/restorePoints"].get.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: RestorePoints.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/restorePoints"].get.responses.default.schema["$ref"]
  - code: PostResponseCodes
    from: RestorePoints.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/restorePoints"].post
  - code: ParameterNotDefinedInGlobalParameters
    from: RestorePoints.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/restorePoints"].post.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: RestorePoints.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/restorePoints"].post.responses.default.schema["$ref"]
  - code: ResourceNameRestriction
    from: RestorePoints.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/restorePoints/{restorePointName}"]
  - code: ParameterNotDefinedInGlobalParameters
    from: RestorePoints.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/restorePoints/{restorePointName}"].get.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: RestorePoints.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/restorePoints/{restorePointName}"].get.responses.default.schema["$ref"]
  - code: DeleteResponseCodes
    from: RestorePoints.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/restorePoints/{restorePointName}"].delete
  - code: ParameterNotDefinedInGlobalParameters
    from: RestorePoints.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/restorePoints/{restorePointName}"].delete.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: RestorePoints.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/restorePoints/{restorePointName}"].delete.responses.default.schema["$ref"]
  - code: LocationMustHaveXmsMutability
    from: RestorePoints.json
    where: $.definitions.RestorePoint.properties.location
  - code: MissingSegmentsInNestedResourceListOperation
    from: SensitivityLabels.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/currentSensitivityLabels"]
  - code: ResourceNameRestriction
    from: SensitivityLabels.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/currentSensitivityLabels"]
  - code: ParameterNotDefinedInGlobalParameters
    from: SensitivityLabels.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/currentSensitivityLabels"].get.parameters
  - code: ParameterDescription
    from: SensitivityLabels.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/currentSensitivityLabels"].get.parameters["3"]
  - code: ParameterDescription
    from: SensitivityLabels.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/currentSensitivityLabels"].get.parameters["4"]
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: SensitivityLabels.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/currentSensitivityLabels"].get.responses.default.schema["$ref"]
  - code: ParameterNotDefinedInGlobalParameters
    from: SensitivityLabels.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/currentSensitivityLabels"].patch.parameters
  - code: ParameterDescription
    from: SensitivityLabels.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/currentSensitivityLabels"].patch.parameters["3"]
  - code: ConsistentPatchProperties
    from: SensitivityLabels.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/currentSensitivityLabels"].patch.parameters["3"].schema
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: SensitivityLabels.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/currentSensitivityLabels"].patch.responses.default.schema["$ref"]
  - code: MissingSegmentsInNestedResourceListOperation
    from: SensitivityLabels.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/recommendedSensitivityLabels"]
  - code: ResourceNameRestriction
    from: SensitivityLabels.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/recommendedSensitivityLabels"]
  - code: ParameterNotDefinedInGlobalParameters
    from: SensitivityLabels.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/recommendedSensitivityLabels"].get.parameters
  - code: ParameterDescription
    from: SensitivityLabels.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/recommendedSensitivityLabels"].get.parameters["3"]
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: SensitivityLabels.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/recommendedSensitivityLabels"].get.responses.default.schema["$ref"]
  - code: ParameterNotDefinedInGlobalParameters
    from: SensitivityLabels.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/recommendedSensitivityLabels"].patch.parameters
  - code: ParameterDescription
    from: SensitivityLabels.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/recommendedSensitivityLabels"].patch.parameters["3"]
  - code: ConsistentPatchProperties
    from: SensitivityLabels.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/recommendedSensitivityLabels"].patch.parameters["3"].schema
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: SensitivityLabels.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/recommendedSensitivityLabels"].patch.responses.default.schema["$ref"]
  - code: MissingSegmentsInNestedResourceListOperation
    from: SensitivityLabels.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/schemas/{schemaName}/tables/{tableName}/columns/{columnName}/sensitivityLabels/{sensitivityLabelSource}"]
  - code: ResourceNameRestriction
    from: SensitivityLabels.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/schemas/{schemaName}/tables/{tableName}/columns/{columnName}/sensitivityLabels/{sensitivityLabelSource}"]
  - code: ParameterNotDefinedInGlobalParameters
    from: SensitivityLabels.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/schemas/{schemaName}/tables/{tableName}/columns/{columnName}/sensitivityLabels/{sensitivityLabelSource}"].get.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: SensitivityLabels.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/schemas/{schemaName}/tables/{tableName}/columns/{columnName}/sensitivityLabels/{sensitivityLabelSource}"].get.responses.default.schema["$ref"]
  - code: ParameterNotDefinedInGlobalParameters
    from: SensitivityLabels.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/schemas/{schemaName}/tables/{tableName}/columns/{columnName}/sensitivityLabels/{sensitivityLabelSource}"].put.parameters
  - code: RepeatedPathInfo
    from: SensitivityLabels.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/schemas/{schemaName}/tables/{tableName}/columns/{columnName}/sensitivityLabels/{sensitivityLabelSource}"].put.parameters["3"]
  - code: RepeatedPathInfo
    from: SensitivityLabels.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/schemas/{schemaName}/tables/{tableName}/columns/{columnName}/sensitivityLabels/{sensitivityLabelSource}"].put.parameters["4"]
  - code: RepeatedPathInfo
    from: SensitivityLabels.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/schemas/{schemaName}/tables/{tableName}/columns/{columnName}/sensitivityLabels/{sensitivityLabelSource}"].put.parameters["5"]
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: SensitivityLabels.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/schemas/{schemaName}/tables/{tableName}/columns/{columnName}/sensitivityLabels/{sensitivityLabelSource}"].put.responses.default.schema["$ref"]
  - code: DeleteResponseCodes
    from: SensitivityLabels.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/schemas/{schemaName}/tables/{tableName}/columns/{columnName}/sensitivityLabels/{sensitivityLabelSource}"].delete
  - code: ParameterNotDefinedInGlobalParameters
    from: SensitivityLabels.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/schemas/{schemaName}/tables/{tableName}/columns/{columnName}/sensitivityLabels/{sensitivityLabelSource}"].delete.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: SensitivityLabels.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/schemas/{schemaName}/tables/{tableName}/columns/{columnName}/sensitivityLabels/{sensitivityLabelSource}"].delete.responses.default.schema["$ref"]
  - code: ResourceNameRestriction
    from: SensitivityLabels.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/schemas/{schemaName}/tables/{tableName}/columns/{columnName}/sensitivityLabels/{sensitivityLabelSource}/disable"]
  - code: ParameterNotDefinedInGlobalParameters
    from: SensitivityLabels.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/schemas/{schemaName}/tables/{tableName}/columns/{columnName}/sensitivityLabels/{sensitivityLabelSource}/disable"].post.parameters
  - code: ParameterDescription
    from: SensitivityLabels.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/schemas/{schemaName}/tables/{tableName}/columns/{columnName}/sensitivityLabels/{sensitivityLabelSource}/disable"].post.parameters["6"]
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: SensitivityLabels.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/schemas/{schemaName}/tables/{tableName}/columns/{columnName}/sensitivityLabels/{sensitivityLabelSource}/disable"].post.responses.default.schema["$ref"]
  - code: ResourceNameRestriction
    from: SensitivityLabels.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/schemas/{schemaName}/tables/{tableName}/columns/{columnName}/sensitivityLabels/{sensitivityLabelSource}/enable"]
  - code: ParameterNotDefinedInGlobalParameters
    from: SensitivityLabels.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/schemas/{schemaName}/tables/{tableName}/columns/{columnName}/sensitivityLabels/{sensitivityLabelSource}/enable"].post.parameters
  - code: ParameterDescription
    from: SensitivityLabels.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/schemas/{schemaName}/tables/{tableName}/columns/{columnName}/sensitivityLabels/{sensitivityLabelSource}/enable"].post.parameters["6"]
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: SensitivityLabels.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/schemas/{schemaName}/tables/{tableName}/columns/{columnName}/sensitivityLabels/{sensitivityLabelSource}/enable"].post.responses.default.schema["$ref"]
  - code: MissingSegmentsInNestedResourceListOperation
    from: SensitivityLabels.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/sensitivityLabels"]
  - code: ResourceNameRestriction
    from: SensitivityLabels.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/sensitivityLabels"]
  - code: ParameterNotDefinedInGlobalParameters
    from: SensitivityLabels.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/sensitivityLabels"].get.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: SensitivityLabels.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/sensitivityLabels"].get.responses.default.schema["$ref"]
  - code: MissingSegmentsInNestedResourceListOperation
    from: ServerAdvancedThreatProtectionSettings.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/advancedThreatProtectionSettings"]
  - code: ResourceNameRestriction
    from: ServerAdvancedThreatProtectionSettings.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/advancedThreatProtectionSettings"]
  - code: ParameterNotDefinedInGlobalParameters
    from: ServerAdvancedThreatProtectionSettings.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/advancedThreatProtectionSettings"].get.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: ServerAdvancedThreatProtectionSettings.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/advancedThreatProtectionSettings"].get.responses.default.schema["$ref"]
  - code: ResourceNameRestriction
    from: ServerAdvancedThreatProtectionSettings.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/advancedThreatProtectionSettings/{advancedThreatProtectionName}"]
  - code: ParameterNotDefinedInGlobalParameters
    from: ServerAdvancedThreatProtectionSettings.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/advancedThreatProtectionSettings/{advancedThreatProtectionName}"].get.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: ServerAdvancedThreatProtectionSettings.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/advancedThreatProtectionSettings/{advancedThreatProtectionName}"].get.responses.default.schema["$ref"]
  - code: ProvisioningStateSpecifiedForLROPut
    from: ServerAdvancedThreatProtectionSettings.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/advancedThreatProtectionSettings/{advancedThreatProtectionName}"].put
  - code: PutResponseCodes
    from: ServerAdvancedThreatProtectionSettings.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/advancedThreatProtectionSettings/{advancedThreatProtectionName}"].put
  - code: ParameterNotDefinedInGlobalParameters
    from: ServerAdvancedThreatProtectionSettings.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/advancedThreatProtectionSettings/{advancedThreatProtectionName}"].put.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: ServerAdvancedThreatProtectionSettings.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/advancedThreatProtectionSettings/{advancedThreatProtectionName}"].put.responses.default.schema["$ref"]
  - code: SystemDataDefinitionsCommonTypes
    from: ServerAdvancedThreatProtectionSettings.json
    where: $.definitions.ServerAdvancedThreatProtection.properties.systemData["$ref"]
  - code: PatchBodyParametersSchema
    from: ServerAdvisors.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/advisors/{advisorName}"].patch.parameters["3"].schema.properties.properties
  - code: MissingSegmentsInNestedResourceListOperation
    from: ServerAdvisors.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/advisors"]
  - code: ResourceNameRestriction
    from: ServerAdvisors.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/advisors"]
  - code: XmsPageableForListCalls
    from: ServerAdvisors.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/advisors"].get
  - code: ParameterNotDefinedInGlobalParameters
    from: ServerAdvisors.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/advisors"].get.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: ServerAdvisors.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/advisors"].get.responses.default.schema["$ref"]
  - code: ResourceNameRestriction
    from: ServerAdvisors.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/advisors/{advisorName}"]
  - code: ParameterNotDefinedInGlobalParameters
    from: ServerAdvisors.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/advisors/{advisorName}"].get.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: ServerAdvisors.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/advisors/{advisorName}"].get.responses.default.schema["$ref"]
  - code: ParameterNotDefinedInGlobalParameters
    from: ServerAdvisors.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/advisors/{advisorName}"].patch.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: ServerAdvisors.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/advisors/{advisorName}"].patch.responses.default.schema["$ref"]
  - code: LocationMustHaveXmsMutability
    from: ServerAdvisors.json
    where: $.definitions.Advisor.properties.location
  - code: LocationMustHaveXmsMutability
    from: ServerAdvisors.json
    where: $.definitions.RecommendedAction.properties.location
  - code: AvoidAdditionalProperties
    from: ServerAdvisors.json
    where: $.definitions.RecommendedActionProperties.properties.details
  - code: MissingSegmentsInNestedResourceListOperation
    from: ServerAutomaticTuning.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/automaticTuning/current"]
  - code: PathForNestedResource
    from: ServerAutomaticTuning.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/automaticTuning/current"]
  - code: ResourceNameRestriction
    from: ServerAutomaticTuning.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/automaticTuning/current"]
  - code: OperationIdNounConflictingModelNames
    from: ServerAutomaticTuning.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/automaticTuning/current"].get.operationId
  - code: ParameterNotDefinedInGlobalParameters
    from: ServerAutomaticTuning.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/automaticTuning/current"].get.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: ServerAutomaticTuning.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/automaticTuning/current"].get.responses.default.schema["$ref"]
  - code: OperationIdNounConflictingModelNames
    from: ServerAutomaticTuning.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/automaticTuning/current"].patch.operationId
  - code: ParameterNotDefinedInGlobalParameters
    from: ServerAutomaticTuning.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/automaticTuning/current"].patch.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: ServerAutomaticTuning.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/automaticTuning/current"].patch.responses.default.schema["$ref"]
  - code: AvoidAdditionalProperties
    from: ServerAutomaticTuning.json
    where: $.definitions.AutomaticTuningServerProperties.properties.options
  - code: MissingSegmentsInNestedResourceListOperation
    from: ServerAzureADAdministrators.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/administrators"]
  - code: ResourceNameRestriction
    from: ServerAzureADAdministrators.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/administrators"]
  - code: ParameterNotDefinedInGlobalParameters
    from: ServerAzureADAdministrators.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/administrators"].get.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: ServerAzureADAdministrators.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/administrators"].get.responses.default.schema["$ref"]
  - code: ResourceNameRestriction
    from: ServerAzureADAdministrators.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/administrators/{administratorName}"]
  - code: ParameterNotDefinedInGlobalParameters
    from: ServerAzureADAdministrators.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/administrators/{administratorName}"].get.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: ServerAzureADAdministrators.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/administrators/{administratorName}"].get.responses.default.schema["$ref"]
  - code: ProvisioningStateSpecifiedForLROPut
    from: ServerAzureADAdministrators.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/administrators/{administratorName}"].put
  - code: PutResponseCodes
    from: ServerAzureADAdministrators.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/administrators/{administratorName}"].put
  - code: ParameterNotDefinedInGlobalParameters
    from: ServerAzureADAdministrators.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/administrators/{administratorName}"].put.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: ServerAzureADAdministrators.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/administrators/{administratorName}"].put.responses.default.schema["$ref"]
  - code: DeleteResponseCodes
    from: ServerAzureADAdministrators.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/administrators/{administratorName}"].delete
  - code: ParameterNotDefinedInGlobalParameters
    from: ServerAzureADAdministrators.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/administrators/{administratorName}"].delete.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: ServerAzureADAdministrators.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/administrators/{administratorName}"].delete.responses.default.schema["$ref"]
  - code: MissingSegmentsInNestedResourceListOperation
    from: ServerAzureADOnlyAuthentications.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/azureADOnlyAuthentications"]
  - code: ResourceNameRestriction
    from: ServerAzureADOnlyAuthentications.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/azureADOnlyAuthentications"]
  - code: ParameterNotDefinedInGlobalParameters
    from: ServerAzureADOnlyAuthentications.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/azureADOnlyAuthentications"].get.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: ServerAzureADOnlyAuthentications.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/azureADOnlyAuthentications"].get.responses.default.schema["$ref"]
  - code: ResourceNameRestriction
    from: ServerAzureADOnlyAuthentications.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/azureADOnlyAuthentications/{authenticationName}"]
  - code: ParameterNotDefinedInGlobalParameters
    from: ServerAzureADOnlyAuthentications.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/azureADOnlyAuthentications/{authenticationName}"].get.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: ServerAzureADOnlyAuthentications.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/azureADOnlyAuthentications/{authenticationName}"].get.responses.default.schema["$ref"]
  - code: ProvisioningStateSpecifiedForLROPut
    from: ServerAzureADOnlyAuthentications.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/azureADOnlyAuthentications/{authenticationName}"].put
  - code: PutResponseCodes
    from: ServerAzureADOnlyAuthentications.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/azureADOnlyAuthentications/{authenticationName}"].put
  - code: ParameterNotDefinedInGlobalParameters
    from: ServerAzureADOnlyAuthentications.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/azureADOnlyAuthentications/{authenticationName}"].put.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: ServerAzureADOnlyAuthentications.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/azureADOnlyAuthentications/{authenticationName}"].put.responses.default.schema["$ref"]
  - code: DeleteResponseCodes
    from: ServerAzureADOnlyAuthentications.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/azureADOnlyAuthentications/{authenticationName}"].delete
  - code: ParameterNotDefinedInGlobalParameters
    from: ServerAzureADOnlyAuthentications.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/azureADOnlyAuthentications/{authenticationName}"].delete.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: ServerAzureADOnlyAuthentications.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/azureADOnlyAuthentications/{authenticationName}"].delete.responses.default.schema["$ref"]
  - code: MissingSegmentsInNestedResourceListOperation
    from: ServerConfigurationOptions.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/serverConfigurationOptions"]
  - code: ResourceNameRestriction
    from: ServerConfigurationOptions.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/serverConfigurationOptions"]
  - code: ParameterNotDefinedInGlobalParameters
    from: ServerConfigurationOptions.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/serverConfigurationOptions"].get.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: ServerConfigurationOptions.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/serverConfigurationOptions"].get.responses.default.schema["$ref"]
  - code: ResourceNameRestriction
    from: ServerConfigurationOptions.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/serverConfigurationOptions/{serverConfigurationOptionName}"]
  - code: ParameterNotDefinedInGlobalParameters
    from: ServerConfigurationOptions.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/serverConfigurationOptions/{serverConfigurationOptionName}"].get.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: ServerConfigurationOptions.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/serverConfigurationOptions/{serverConfigurationOptionName}"].get.responses.default.schema["$ref"]
  - code: ProvisioningStateSpecifiedForLROPut
    from: ServerConfigurationOptions.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/serverConfigurationOptions/{serverConfigurationOptionName}"].put
  - code: PutResponseCodes
    from: ServerConfigurationOptions.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/serverConfigurationOptions/{serverConfigurationOptionName}"].put
  - code: ParameterNotDefinedInGlobalParameters
    from: ServerConfigurationOptions.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/serverConfigurationOptions/{serverConfigurationOptionName}"].put.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: ServerConfigurationOptions.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/serverConfigurationOptions/{serverConfigurationOptionName}"].put.responses.default.schema["$ref"]
  - code: MissingSegmentsInNestedResourceListOperation
    from: ServerConnectionPolicies.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/connectionPolicies"]
  - code: ResourceNameRestriction
    from: ServerConnectionPolicies.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/connectionPolicies"]
  - code: ParameterNotDefinedInGlobalParameters
    from: ServerConnectionPolicies.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/connectionPolicies"].get.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: ServerConnectionPolicies.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/connectionPolicies"].get.responses.default.schema["$ref"]
  - code: ResourceNameRestriction
    from: ServerConnectionPolicies.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/connectionPolicies/{connectionPolicyName}"]
  - code: ParameterNotDefinedInGlobalParameters
    from: ServerConnectionPolicies.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/connectionPolicies/{connectionPolicyName}"].get.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: ServerConnectionPolicies.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/connectionPolicies/{connectionPolicyName}"].get.responses.default.schema["$ref"]
  - code: ProvisioningStateSpecifiedForLROPut
    from: ServerConnectionPolicies.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/connectionPolicies/{connectionPolicyName}"].put
  - code: PutResponseCodes
    from: ServerConnectionPolicies.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/connectionPolicies/{connectionPolicyName}"].put
  - code: RequestSchemaForTrackedResourcesMustHaveTags
    from: ServerConnectionPolicies.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/connectionPolicies/{connectionPolicyName}"].put
  - code: ParameterNotDefinedInGlobalParameters
    from: ServerConnectionPolicies.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/connectionPolicies/{connectionPolicyName}"].put.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: ServerConnectionPolicies.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/connectionPolicies/{connectionPolicyName}"].put.responses.default.schema["$ref"]
  - code: LocationMustHaveXmsMutability
    from: ServerConnectionPolicies.json
    where: $.definitions.ServerConnectionPolicy.properties.location
  - code: MissingSegmentsInNestedResourceListOperation
    from: ServerDevOpsAudit.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/devOpsAuditingSettings"]
  - code: ResourceNameRestriction
    from: ServerDevOpsAudit.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/devOpsAuditingSettings"]
  - code: ParameterNotDefinedInGlobalParameters
    from: ServerDevOpsAudit.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/devOpsAuditingSettings"].get.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: ServerDevOpsAudit.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/devOpsAuditingSettings"].get.responses.default.schema["$ref"]
  - code: ResourceNameRestriction
    from: ServerDevOpsAudit.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/devOpsAuditingSettings/{devOpsAuditingSettingsName}"]
  - code: ParameterNotDefinedInGlobalParameters
    from: ServerDevOpsAudit.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/devOpsAuditingSettings/{devOpsAuditingSettingsName}"].get.parameters
  - code: ParameterDescription
    from: ServerDevOpsAudit.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/devOpsAuditingSettings/{devOpsAuditingSettingsName}"].get.parameters["2"]
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: ServerDevOpsAudit.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/devOpsAuditingSettings/{devOpsAuditingSettingsName}"].get.responses.default.schema["$ref"]
  - code: ProvisioningStateSpecifiedForLROPut
    from: ServerDevOpsAudit.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/devOpsAuditingSettings/{devOpsAuditingSettingsName}"].put
  - code: PutResponseCodes
    from: ServerDevOpsAudit.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/devOpsAuditingSettings/{devOpsAuditingSettingsName}"].put
  - code: ParameterNotDefinedInGlobalParameters
    from: ServerDevOpsAudit.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/devOpsAuditingSettings/{devOpsAuditingSettingsName}"].put.parameters
  - code: ParameterDescription
    from: ServerDevOpsAudit.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/devOpsAuditingSettings/{devOpsAuditingSettingsName}"].put.parameters["2"]
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: ServerDevOpsAudit.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/devOpsAuditingSettings/{devOpsAuditingSettingsName}"].put.responses.default.schema["$ref"]
  - code: SystemDataDefinitionsCommonTypes
    from: ServerDevOpsAudit.json
    where: $.definitions.ServerDevOpsAuditingSettings.properties.systemData["$ref"]
  - code: MissingSegmentsInNestedResourceListOperation
    from: ServerDnsAliases.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/dnsAliases"]
  - code: ResourceNameRestriction
    from: ServerDnsAliases.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/dnsAliases"]
  - code: ParameterNotDefinedInGlobalParameters
    from: ServerDnsAliases.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/dnsAliases"].get.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: ServerDnsAliases.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/dnsAliases"].get.responses.default.schema["$ref"]
  - code: ResourceNameRestriction
    from: ServerDnsAliases.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/dnsAliases/{dnsAliasName}"]
  - code: ParameterNotDefinedInGlobalParameters
    from: ServerDnsAliases.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/dnsAliases/{dnsAliasName}"].get.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: ServerDnsAliases.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/dnsAliases/{dnsAliasName}"].get.responses.default.schema["$ref"]
  - code: ProvisioningStateSpecifiedForLROPut
    from: ServerDnsAliases.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/dnsAliases/{dnsAliasName}"].put
  - code: PutResponseCodes
    from: ServerDnsAliases.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/dnsAliases/{dnsAliasName}"].put
  - code: ParameterNotDefinedInGlobalParameters
    from: ServerDnsAliases.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/dnsAliases/{dnsAliasName}"].put.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: ServerDnsAliases.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/dnsAliases/{dnsAliasName}"].put.responses.default.schema["$ref"]
  - code: DeleteResponseCodes
    from: ServerDnsAliases.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/dnsAliases/{dnsAliasName}"].delete
  - code: ParameterNotDefinedInGlobalParameters
    from: ServerDnsAliases.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/dnsAliases/{dnsAliasName}"].delete.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: ServerDnsAliases.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/dnsAliases/{dnsAliasName}"].delete.responses.default.schema["$ref"]
  - code: LongRunningOperationsOptionsValidator
    from: ServerDnsAliases.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/dnsAliases/{dnsAliasName}/acquire"]
  - code: ResourceNameRestriction
    from: ServerDnsAliases.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/dnsAliases/{dnsAliasName}/acquire"]
  - code: ParameterNotDefinedInGlobalParameters
    from: ServerDnsAliases.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/dnsAliases/{dnsAliasName}/acquire"].post.parameters
  - code: ParameterDescription
    from: ServerDnsAliases.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/dnsAliases/{dnsAliasName}/acquire"].post.parameters["3"]
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: ServerDnsAliases.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/dnsAliases/{dnsAliasName}/acquire"].post.responses.default.schema["$ref"]
  - code: MissingSegmentsInNestedResourceListOperation
    from: ServerKeys.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/keys"]
  - code: ResourceNameRestriction
    from: ServerKeys.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/keys"]
  - code: ParameterNotDefinedInGlobalParameters
    from: ServerKeys.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/keys"].get.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: ServerKeys.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/keys"].get.responses.default.schema["$ref"]
  - code: ResourceNameRestriction
    from: ServerKeys.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/keys/{keyName}"]
  - code: ParameterNotDefinedInGlobalParameters
    from: ServerKeys.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/keys/{keyName}"].get.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: ServerKeys.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/keys/{keyName}"].get.responses.default.schema["$ref"]
  - code: ProvisioningStateSpecifiedForLROPut
    from: ServerKeys.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/keys/{keyName}"].put
  - code: PutResponseCodes
    from: ServerKeys.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/keys/{keyName}"].put
  - code: RequestSchemaForTrackedResourcesMustHaveTags
    from: ServerKeys.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/keys/{keyName}"].put
  - code: ParameterNotDefinedInGlobalParameters
    from: ServerKeys.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/keys/{keyName}"].put.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: ServerKeys.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/keys/{keyName}"].put.responses.default.schema["$ref"]
  - code: DeleteResponseCodes
    from: ServerKeys.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/keys/{keyName}"].delete
  - code: ParameterNotDefinedInGlobalParameters
    from: ServerKeys.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/keys/{keyName}"].delete.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: ServerKeys.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/keys/{keyName}"].delete.responses.default.schema["$ref"]
  - code: LocationMustHaveXmsMutability
    from: ServerKeys.json
    where: $.definitions.ServerKey.properties.location
  - code: MissingSegmentsInNestedResourceListOperation
    from: ServerOperations.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/operations"]
  - code: ResourceNameRestriction
    from: ServerOperations.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/operations"]
  - code: ParameterNotDefinedInGlobalParameters
    from: ServerOperations.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/operations"].get.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: ServerOperations.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/operations"].get.responses.default.schema["$ref"]
  - code: ParameterNotDefinedInGlobalParameters
    from: Servers.json
    where: $.paths["/subscriptions/{subscriptionId}/providers/Microsoft.Sql/checkNameAvailability"].post.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: Servers.json
    where: $.paths["/subscriptions/{subscriptionId}/providers/Microsoft.Sql/checkNameAvailability"].post.responses.default.schema["$ref"]
  - code: ParameterNotDefinedInGlobalParameters
    from: Servers.json
    where: $.paths["/subscriptions/{subscriptionId}/providers/Microsoft.Sql/servers"].get.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: Servers.json
    where: $.paths["/subscriptions/{subscriptionId}/providers/Microsoft.Sql/servers"].get.responses.default.schema["$ref"]
  - code: ParameterNotDefinedInGlobalParameters
    from: Servers.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers"].get.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: Servers.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers"].get.responses.default.schema["$ref"]
  - code: ResourceNameRestriction
    from: Servers.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}"]
  - code: ParameterNotDefinedInGlobalParameters
    from: Servers.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}"].get.parameters
  - code: ParametersInPointGet
    from: Servers.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}"].get.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: Servers.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}"].get.responses.default.schema["$ref"]
  - code: ProvisioningStateSpecifiedForLROPut
    from: Servers.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}"].put
  - code: PutResponseCodes
    from: Servers.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}"].put
  - code: ParameterNotDefinedInGlobalParameters
    from: Servers.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}"].put.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: Servers.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}"].put.responses.default.schema["$ref"]
  - code: DeleteResponseCodes
    from: Servers.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}"].delete
  - code: ParameterNotDefinedInGlobalParameters
    from: Servers.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}"].delete.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: Servers.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}"].delete.responses.default.schema["$ref"]
  - code: ParameterNotDefinedInGlobalParameters
    from: Servers.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}"].patch.parameters
  - code: ProvisioningStateSpecifiedForLROPatch
    from: Servers.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}"].patch.responses["200"]
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: Servers.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}"].patch.responses.default.schema["$ref"]
  - code: LongRunningOperationsOptionsValidator
    from: Servers.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/import"]
  - code: ResourceNameRestriction
    from: Servers.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/import"]
  - code: ParameterNotDefinedInGlobalParameters
    from: Servers.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/import"].post.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: Servers.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/import"].post.responses.default.schema["$ref"]
  - code: ResourceNameRestriction
    from: Servers.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/refreshExternalGovernanceStatus"]
  - code: ParameterNotDefinedInGlobalParameters
    from: Servers.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/refreshExternalGovernanceStatus"].post.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: Servers.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/refreshExternalGovernanceStatus"].post.responses.default.schema["$ref"]
  - code: ProvisioningStateValidation
    from: Servers.json
    where: $.definitions.PrivateEndpointConnectionProperties.properties.provisioningState
  - code: SchemaDescriptionOrTitle
    from: Servers.json
    where: $.definitions.PrivateEndpointProperty
  - code: SchemaDescriptionOrTitle
    from: Servers.json
    where: $.definitions.PrivateLinkServiceConnectionStateProperty
  - code: MissingSegmentsInNestedResourceListOperation
    from: ServerSecurityAlertPolicies.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/securityAlertPolicies"]
  - code: ResourceNameRestriction
    from: ServerSecurityAlertPolicies.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/securityAlertPolicies"]
  - code: ParameterNotDefinedInGlobalParameters
    from: ServerSecurityAlertPolicies.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/securityAlertPolicies"].get.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: ServerSecurityAlertPolicies.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/securityAlertPolicies"].get.responses.default.schema["$ref"]
  - code: ResourceNameRestriction
    from: ServerSecurityAlertPolicies.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/securityAlertPolicies/{securityAlertPolicyName}"]
  - code: ParameterNotDefinedInGlobalParameters
    from: ServerSecurityAlertPolicies.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/securityAlertPolicies/{securityAlertPolicyName}"].get.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: ServerSecurityAlertPolicies.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/securityAlertPolicies/{securityAlertPolicyName}"].get.responses.default.schema["$ref"]
  - code: ProvisioningStateSpecifiedForLROPut
    from: ServerSecurityAlertPolicies.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/securityAlertPolicies/{securityAlertPolicyName}"].put
  - code: PutResponseCodes
    from: ServerSecurityAlertPolicies.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/securityAlertPolicies/{securityAlertPolicyName}"].put
  - code: ParameterNotDefinedInGlobalParameters
    from: ServerSecurityAlertPolicies.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/securityAlertPolicies/{securityAlertPolicyName}"].put.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: ServerSecurityAlertPolicies.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/securityAlertPolicies/{securityAlertPolicyName}"].put.responses.default.schema["$ref"]
  - code: SystemDataDefinitionsCommonTypes
    from: ServerSecurityAlertPolicies.json
    where: $.definitions.ServerSecurityAlertPolicy.properties.systemData["$ref"]
  - code: MissingSegmentsInNestedResourceListOperation
    from: ServerTrustCertificates.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/serverTrustCertificates"]
  - code: ResourceNameRestriction
    from: ServerTrustCertificates.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/serverTrustCertificates"]
  - code: ParameterNotDefinedInGlobalParameters
    from: ServerTrustCertificates.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/serverTrustCertificates"].get.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: ServerTrustCertificates.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/serverTrustCertificates"].get.responses.default.schema["$ref"]
  - code: ResourceNameRestriction
    from: ServerTrustCertificates.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/serverTrustCertificates/{certificateName}"]
  - code: ParameterNotDefinedInGlobalParameters
    from: ServerTrustCertificates.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/serverTrustCertificates/{certificateName}"].get.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: ServerTrustCertificates.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/serverTrustCertificates/{certificateName}"].get.responses.default.schema["$ref"]
  - code: ProvisioningStateSpecifiedForLROPut
    from: ServerTrustCertificates.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/serverTrustCertificates/{certificateName}"].put
  - code: PutResponseCodes
    from: ServerTrustCertificates.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/serverTrustCertificates/{certificateName}"].put
  - code: ParameterNotDefinedInGlobalParameters
    from: ServerTrustCertificates.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/serverTrustCertificates/{certificateName}"].put.parameters
  - code: RepeatedPathInfo
    from: ServerTrustCertificates.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/serverTrustCertificates/{certificateName}"].put.parameters["2"]
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: ServerTrustCertificates.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/serverTrustCertificates/{certificateName}"].put.responses.default.schema["$ref"]
  - code: DeleteResponseCodes
    from: ServerTrustCertificates.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/serverTrustCertificates/{certificateName}"].delete
  - code: ParameterNotDefinedInGlobalParameters
    from: ServerTrustCertificates.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/serverTrustCertificates/{certificateName}"].delete.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: ServerTrustCertificates.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/serverTrustCertificates/{certificateName}"].delete.responses.default.schema["$ref"]
  - code: MissingSegmentsInNestedResourceListOperation
    from: ServerTrustGroups.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/locations/{locationName}/serverTrustGroups"]
  - code: ResourceNameRestriction
    from: ServerTrustGroups.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/locations/{locationName}/serverTrustGroups"]
  - code: ParameterNotDefinedInGlobalParameters
    from: ServerTrustGroups.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/locations/{locationName}/serverTrustGroups"].get.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: ServerTrustGroups.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/locations/{locationName}/serverTrustGroups"].get.responses.default.schema["$ref"]
  - code: ResourceNameRestriction
    from: ServerTrustGroups.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/locations/{locationName}/serverTrustGroups/{serverTrustGroupName}"]
  - code: ParameterNotDefinedInGlobalParameters
    from: ServerTrustGroups.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/locations/{locationName}/serverTrustGroups/{serverTrustGroupName}"].get.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: ServerTrustGroups.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/locations/{locationName}/serverTrustGroups/{serverTrustGroupName}"].get.responses.default.schema["$ref"]
  - code: ProvisioningStateSpecifiedForLROPut
    from: ServerTrustGroups.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/locations/{locationName}/serverTrustGroups/{serverTrustGroupName}"].put
  - code: PutResponseCodes
    from: ServerTrustGroups.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/locations/{locationName}/serverTrustGroups/{serverTrustGroupName}"].put
  - code: ParameterNotDefinedInGlobalParameters
    from: ServerTrustGroups.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/locations/{locationName}/serverTrustGroups/{serverTrustGroupName}"].put.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: ServerTrustGroups.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/locations/{locationName}/serverTrustGroups/{serverTrustGroupName}"].put.responses.default.schema["$ref"]
  - code: DeleteResponseCodes
    from: ServerTrustGroups.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/locations/{locationName}/serverTrustGroups/{serverTrustGroupName}"].delete
  - code: ParameterNotDefinedInGlobalParameters
    from: ServerTrustGroups.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/locations/{locationName}/serverTrustGroups/{serverTrustGroupName}"].delete.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: ServerTrustGroups.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/locations/{locationName}/serverTrustGroups/{serverTrustGroupName}"].delete.responses.default.schema["$ref"]
  - code: MissingSegmentsInNestedResourceListOperation
    from: ServerTrustGroups.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/serverTrustGroups"]
  - code: ResourceNameRestriction
    from: ServerTrustGroups.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/serverTrustGroups"]
  - code: ParameterNotDefinedInGlobalParameters
    from: ServerTrustGroups.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/serverTrustGroups"].get.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: ServerTrustGroups.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/serverTrustGroups"].get.responses.default.schema["$ref"]
  - code: MissingSegmentsInNestedResourceListOperation
    from: ServerUsages.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/usages"]
  - code: ResourceNameRestriction
    from: ServerUsages.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/usages"]
  - code: ParameterNotDefinedInGlobalParameters
    from: ServerUsages.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/usages"].get.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: ServerUsages.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/usages"].get.responses.default.schema["$ref"]
  - code: MissingSegmentsInNestedResourceListOperation
    from: ServerVulnerabilityAssessments.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/vulnerabilityAssessments"]
  - code: ResourceNameRestriction
    from: ServerVulnerabilityAssessments.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/vulnerabilityAssessments"]
  - code: ParameterNotDefinedInGlobalParameters
    from: ServerVulnerabilityAssessments.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/vulnerabilityAssessments"].get.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: ServerVulnerabilityAssessments.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/vulnerabilityAssessments"].get.responses.default.schema["$ref"]
  - code: ResourceNameRestriction
    from: ServerVulnerabilityAssessments.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/vulnerabilityAssessments/{vulnerabilityAssessmentName}"]
  - code: ParameterNotDefinedInGlobalParameters
    from: ServerVulnerabilityAssessments.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/vulnerabilityAssessments/{vulnerabilityAssessmentName}"].get.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: ServerVulnerabilityAssessments.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/vulnerabilityAssessments/{vulnerabilityAssessmentName}"].get.responses.default.schema["$ref"]
  - code: ParameterNotDefinedInGlobalParameters
    from: ServerVulnerabilityAssessments.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/vulnerabilityAssessments/{vulnerabilityAssessmentName}"].put.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: ServerVulnerabilityAssessments.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/vulnerabilityAssessments/{vulnerabilityAssessmentName}"].put.responses.default.schema["$ref"]
  - code: DeleteResponseCodes
    from: ServerVulnerabilityAssessments.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/vulnerabilityAssessments/{vulnerabilityAssessmentName}"].delete
  - code: ParameterNotDefinedInGlobalParameters
    from: ServerVulnerabilityAssessments.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/vulnerabilityAssessments/{vulnerabilityAssessmentName}"].delete.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: ServerVulnerabilityAssessments.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/vulnerabilityAssessments/{vulnerabilityAssessmentName}"].delete.responses.default.schema["$ref"]
  - code: EvenSegmentedPathForPutOperation
    from: SqlAgent.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/sqlAgent/current"]
  - code: MissingSegmentsInNestedResourceListOperation
    from: SqlAgent.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/sqlAgent/current"]
  - code: PathForNestedResource
    from: SqlAgent.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/sqlAgent/current"]
  - code: ResourceNameRestriction
    from: SqlAgent.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/sqlAgent/current"]
  - code: ParameterNotDefinedInGlobalParameters
    from: SqlAgent.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/sqlAgent/current"].get.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: SqlAgent.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/sqlAgent/current"].get.responses.default.schema["$ref"]
  - code: PutResponseCodes
    from: SqlAgent.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/sqlAgent/current"].put
  - code: ParameterNotDefinedInGlobalParameters
    from: SqlAgent.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/sqlAgent/current"].put.parameters
  - code: ParameterDescription
    from: SqlAgent.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/sqlAgent/current"].put.parameters["2"]
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: SqlAgent.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/sqlAgent/current"].put.responses.default.schema["$ref"]
  - code: MissingSegmentsInNestedResourceListOperation
    from: SqlVulnerabilityAssessmentBaseline.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/sqlVulnerabilityAssessments/{vulnerabilityAssessmentName}/baselines"]
  - code: ResourceNameRestriction
    from: SqlVulnerabilityAssessmentBaseline.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/sqlVulnerabilityAssessments/{vulnerabilityAssessmentName}/baselines"]
  - code: ParameterNotDefinedInGlobalParameters
    from: SqlVulnerabilityAssessmentBaseline.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/sqlVulnerabilityAssessments/{vulnerabilityAssessmentName}/baselines"].get.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: SqlVulnerabilityAssessmentBaseline.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/sqlVulnerabilityAssessments/{vulnerabilityAssessmentName}/baselines"].get.responses.default.schema["$ref"]
  - code: ResourceNameRestriction
    from: SqlVulnerabilityAssessmentBaseline.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/sqlVulnerabilityAssessments/{vulnerabilityAssessmentName}/baselines/{baselineName}"]
  - code: ParameterNotDefinedInGlobalParameters
    from: SqlVulnerabilityAssessmentBaseline.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/sqlVulnerabilityAssessments/{vulnerabilityAssessmentName}/baselines/{baselineName}"].get.parameters
  - code: ParametersInPointGet
    from: SqlVulnerabilityAssessmentBaseline.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/sqlVulnerabilityAssessments/{vulnerabilityAssessmentName}/baselines/{baselineName}"].get.parameters
  - code: ParameterDescription
    from: SqlVulnerabilityAssessmentBaseline.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/sqlVulnerabilityAssessments/{vulnerabilityAssessmentName}/baselines/{baselineName}"].get.parameters["3"]
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: SqlVulnerabilityAssessmentBaseline.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/sqlVulnerabilityAssessments/{vulnerabilityAssessmentName}/baselines/{baselineName}"].get.responses.default.schema["$ref"]
  - code: PutRequestResponseSchemeArm
    from: SqlVulnerabilityAssessmentBaseline.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/sqlVulnerabilityAssessments/{vulnerabilityAssessmentName}/baselines/{baselineName}"].put
  - code: PutResponseCodes
    from: SqlVulnerabilityAssessmentBaseline.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/sqlVulnerabilityAssessments/{vulnerabilityAssessmentName}/baselines/{baselineName}"].put
  - code: ParameterNotDefinedInGlobalParameters
    from: SqlVulnerabilityAssessmentBaseline.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/sqlVulnerabilityAssessments/{vulnerabilityAssessmentName}/baselines/{baselineName}"].put.parameters
  - code: ParameterDescription
    from: SqlVulnerabilityAssessmentBaseline.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/sqlVulnerabilityAssessments/{vulnerabilityAssessmentName}/baselines/{baselineName}"].put.parameters["3"]
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: SqlVulnerabilityAssessmentBaseline.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/sqlVulnerabilityAssessments/{vulnerabilityAssessmentName}/baselines/{baselineName}"].put.responses.default.schema["$ref"]
  - code: SystemDataDefinitionsCommonTypes
    from: SqlVulnerabilityAssessmentBaseline.json
    where: $.definitions.DatabaseSqlVulnerabilityAssessmentBaselineSet.properties.systemData["$ref"]
  - code: AvoidAdditionalProperties
    from: SqlVulnerabilityAssessmentBaseline.json
    where: $.definitions.DatabaseSqlVulnerabilityAssessmentBaselineSetProperties.properties.results
  - code: SystemDataDefinitionsCommonTypes
    from: SqlVulnerabilityAssessmentBaseline.json
    where: $.definitions.DatabaseSqlVulnerabilityAssessmentRuleBaselineListInput.properties.systemData["$ref"]
  - code: AvoidAdditionalProperties
    from: SqlVulnerabilityAssessmentBaseline.json
    where: $.definitions.DatabaseSqlVulnerabilityAssessmentRuleBaselineListInputProperties.properties.results
  - code: ResourceNameRestriction
    from: SqlVulnerabilityAssessmentExecuteScan.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/sqlVulnerabilityAssessments/{vulnerabilityAssessmentName}/initiateScan"]
  - code: PostResponseCodes
    from: SqlVulnerabilityAssessmentExecuteScan.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/sqlVulnerabilityAssessments/{vulnerabilityAssessmentName}/initiateScan"].post
  - code: ParameterNotDefinedInGlobalParameters
    from: SqlVulnerabilityAssessmentExecuteScan.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/sqlVulnerabilityAssessments/{vulnerabilityAssessmentName}/initiateScan"].post.parameters
  - code: ParametersInPost
    from: SqlVulnerabilityAssessmentExecuteScan.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/sqlVulnerabilityAssessments/{vulnerabilityAssessmentName}/initiateScan"].post.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: SqlVulnerabilityAssessmentExecuteScan.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/sqlVulnerabilityAssessments/{vulnerabilityAssessmentName}/initiateScan"].post.responses.default.schema["$ref"]
  - code: MissingSegmentsInNestedResourceListOperation
    from: SqlVulnerabilityAssessmentRuleBaseline.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/sqlVulnerabilityAssessments/{vulnerabilityAssessmentName}/baselines/{baselineName}/rules"]
  - code: ResourceNameRestriction
    from: SqlVulnerabilityAssessmentRuleBaseline.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/sqlVulnerabilityAssessments/{vulnerabilityAssessmentName}/baselines/{baselineName}/rules"]
  - code: ParameterNotDefinedInGlobalParameters
    from: SqlVulnerabilityAssessmentRuleBaseline.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/sqlVulnerabilityAssessments/{vulnerabilityAssessmentName}/baselines/{baselineName}/rules"].get.parameters
  - code: ParameterDescription
    from: SqlVulnerabilityAssessmentRuleBaseline.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/sqlVulnerabilityAssessments/{vulnerabilityAssessmentName}/baselines/{baselineName}/rules"].get.parameters["3"]
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: SqlVulnerabilityAssessmentRuleBaseline.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/sqlVulnerabilityAssessments/{vulnerabilityAssessmentName}/baselines/{baselineName}/rules"].get.responses.default.schema["$ref"]
  - code: ResourceNameRestriction
    from: SqlVulnerabilityAssessmentRuleBaseline.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/sqlVulnerabilityAssessments/{vulnerabilityAssessmentName}/baselines/{baselineName}/rules/{ruleId}"]
  - code: ParameterNotDefinedInGlobalParameters
    from: SqlVulnerabilityAssessmentRuleBaseline.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/sqlVulnerabilityAssessments/{vulnerabilityAssessmentName}/baselines/{baselineName}/rules/{ruleId}"].get.parameters
  - code: ParametersInPointGet
    from: SqlVulnerabilityAssessmentRuleBaseline.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/sqlVulnerabilityAssessments/{vulnerabilityAssessmentName}/baselines/{baselineName}/rules/{ruleId}"].get.parameters
  - code: ParameterDescription
    from: SqlVulnerabilityAssessmentRuleBaseline.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/sqlVulnerabilityAssessments/{vulnerabilityAssessmentName}/baselines/{baselineName}/rules/{ruleId}"].get.parameters["3"]
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: SqlVulnerabilityAssessmentRuleBaseline.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/sqlVulnerabilityAssessments/{vulnerabilityAssessmentName}/baselines/{baselineName}/rules/{ruleId}"].get.responses.default.schema["$ref"]
  - code: PutRequestResponseSchemeArm
    from: SqlVulnerabilityAssessmentRuleBaseline.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/sqlVulnerabilityAssessments/{vulnerabilityAssessmentName}/baselines/{baselineName}/rules/{ruleId}"].put
  - code: PutResponseCodes
    from: SqlVulnerabilityAssessmentRuleBaseline.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/sqlVulnerabilityAssessments/{vulnerabilityAssessmentName}/baselines/{baselineName}/rules/{ruleId}"].put
  - code: ParameterNotDefinedInGlobalParameters
    from: SqlVulnerabilityAssessmentRuleBaseline.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/sqlVulnerabilityAssessments/{vulnerabilityAssessmentName}/baselines/{baselineName}/rules/{ruleId}"].put.parameters
  - code: ParameterDescription
    from: SqlVulnerabilityAssessmentRuleBaseline.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/sqlVulnerabilityAssessments/{vulnerabilityAssessmentName}/baselines/{baselineName}/rules/{ruleId}"].put.parameters["3"]
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: SqlVulnerabilityAssessmentRuleBaseline.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/sqlVulnerabilityAssessments/{vulnerabilityAssessmentName}/baselines/{baselineName}/rules/{ruleId}"].put.responses.default.schema["$ref"]
  - code: ParameterNotDefinedInGlobalParameters
    from: SqlVulnerabilityAssessmentRuleBaseline.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/sqlVulnerabilityAssessments/{vulnerabilityAssessmentName}/baselines/{baselineName}/rules/{ruleId}"].delete.parameters
  - code: ParameterDescription
    from: SqlVulnerabilityAssessmentRuleBaseline.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/sqlVulnerabilityAssessments/{vulnerabilityAssessmentName}/baselines/{baselineName}/rules/{ruleId}"].delete.parameters["3"]
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: SqlVulnerabilityAssessmentRuleBaseline.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/sqlVulnerabilityAssessments/{vulnerabilityAssessmentName}/baselines/{baselineName}/rules/{ruleId}"].delete.responses.default.schema["$ref"]
  - code: SystemDataDefinitionsCommonTypes
    from: SqlVulnerabilityAssessmentRuleBaseline.json
    where: $.definitions.DatabaseSqlVulnerabilityAssessmentRuleBaseline.properties.systemData["$ref"]
  - code: SystemDataDefinitionsCommonTypes
    from: SqlVulnerabilityAssessmentRuleBaseline.json
    where: $.definitions.DatabaseSqlVulnerabilityAssessmentRuleBaselineInput.properties.systemData["$ref"]
  - code: MissingSegmentsInNestedResourceListOperation
    from: SqlVulnerabilityAssessmentScanResult.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/sqlVulnerabilityAssessments/{vulnerabilityAssessmentName}/scans/{scanId}/scanResults"]
  - code: ResourceNameRestriction
    from: SqlVulnerabilityAssessmentScanResult.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/sqlVulnerabilityAssessments/{vulnerabilityAssessmentName}/scans/{scanId}/scanResults"]
  - code: ParameterNotDefinedInGlobalParameters
    from: SqlVulnerabilityAssessmentScanResult.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/sqlVulnerabilityAssessments/{vulnerabilityAssessmentName}/scans/{scanId}/scanResults"].get.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: SqlVulnerabilityAssessmentScanResult.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/sqlVulnerabilityAssessments/{vulnerabilityAssessmentName}/scans/{scanId}/scanResults"].get.responses.default.schema["$ref"]
  - code: ResourceNameRestriction
    from: SqlVulnerabilityAssessmentScanResult.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/sqlVulnerabilityAssessments/{vulnerabilityAssessmentName}/scans/{scanId}/scanResults/{scanResultId}"]
  - code: ParameterNotDefinedInGlobalParameters
    from: SqlVulnerabilityAssessmentScanResult.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/sqlVulnerabilityAssessments/{vulnerabilityAssessmentName}/scans/{scanId}/scanResults/{scanResultId}"].get.parameters
  - code: ParametersInPointGet
    from: SqlVulnerabilityAssessmentScanResult.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/sqlVulnerabilityAssessments/{vulnerabilityAssessmentName}/scans/{scanId}/scanResults/{scanResultId}"].get.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: SqlVulnerabilityAssessmentScanResult.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/sqlVulnerabilityAssessments/{vulnerabilityAssessmentName}/scans/{scanId}/scanResults/{scanResultId}"].get.responses.default.schema["$ref"]
  - code: SchemaDescriptionOrTitle
    from: SqlVulnerabilityAssessmentScanResult.json
    where: $.definitions.SqlVulnerabilityAssessmentScanResults
  - code: SystemDataDefinitionsCommonTypes
    from: SqlVulnerabilityAssessmentScanResult.json
    where: $.definitions.SqlVulnerabilityAssessmentScanResults.properties.systemData["$ref"]
  - code: MissingSegmentsInNestedResourceListOperation
    from: SqlVulnerabilityAssessmentScans.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/sqlVulnerabilityAssessments/{vulnerabilityAssessmentName}/scans"]
  - code: ResourceNameRestriction
    from: SqlVulnerabilityAssessmentScans.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/sqlVulnerabilityAssessments/{vulnerabilityAssessmentName}/scans"]
  - code: ParameterNotDefinedInGlobalParameters
    from: SqlVulnerabilityAssessmentScans.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/sqlVulnerabilityAssessments/{vulnerabilityAssessmentName}/scans"].get.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: SqlVulnerabilityAssessmentScans.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/sqlVulnerabilityAssessments/{vulnerabilityAssessmentName}/scans"].get.responses.default.schema["$ref"]
  - code: ResourceNameRestriction
    from: SqlVulnerabilityAssessmentScans.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/sqlVulnerabilityAssessments/{vulnerabilityAssessmentName}/scans/{scanId}"]
  - code: ParameterNotDefinedInGlobalParameters
    from: SqlVulnerabilityAssessmentScans.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/sqlVulnerabilityAssessments/{vulnerabilityAssessmentName}/scans/{scanId}"].get.parameters
  - code: ParametersInPointGet
    from: SqlVulnerabilityAssessmentScans.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/sqlVulnerabilityAssessments/{vulnerabilityAssessmentName}/scans/{scanId}"].get.parameters
  - code: ParameterDescription
    from: SqlVulnerabilityAssessmentScans.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/sqlVulnerabilityAssessments/{vulnerabilityAssessmentName}/scans/{scanId}"].get.parameters["3"]
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: SqlVulnerabilityAssessmentScans.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/sqlVulnerabilityAssessments/{vulnerabilityAssessmentName}/scans/{scanId}"].get.responses.default.schema["$ref"]
  - code: SystemDataDefinitionsCommonTypes
    from: SqlVulnerabilityAssessmentScans.json
    where: $.definitions.SqlVulnerabilityAssessmentScanRecord.properties.systemData["$ref"]
  - code: MissingSegmentsInNestedResourceListOperation
    from: SqlVulnerabilityAssessmentsSettings.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/sqlVulnerabilityAssessments"]
  - code: ResourceNameRestriction
    from: SqlVulnerabilityAssessmentsSettings.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/sqlVulnerabilityAssessments"]
  - code: ParameterNotDefinedInGlobalParameters
    from: SqlVulnerabilityAssessmentsSettings.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/sqlVulnerabilityAssessments"].get.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: SqlVulnerabilityAssessmentsSettings.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/sqlVulnerabilityAssessments"].get.responses.default.schema["$ref"]
  - code: ResourceNameRestriction
    from: SqlVulnerabilityAssessmentsSettings.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/sqlVulnerabilityAssessments/{vulnerabilityAssessmentName}"]
  - code: ParameterNotDefinedInGlobalParameters
    from: SqlVulnerabilityAssessmentsSettings.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/sqlVulnerabilityAssessments/{vulnerabilityAssessmentName}"].get.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: SqlVulnerabilityAssessmentsSettings.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/sqlVulnerabilityAssessments/{vulnerabilityAssessmentName}"].get.responses.default.schema["$ref"]
  - code: ParameterNotDefinedInGlobalParameters
    from: SqlVulnerabilityAssessmentsSettings.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/sqlVulnerabilityAssessments/{vulnerabilityAssessmentName}"].put.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: SqlVulnerabilityAssessmentsSettings.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/sqlVulnerabilityAssessments/{vulnerabilityAssessmentName}"].put.responses.default.schema["$ref"]
  - code: ParameterNotDefinedInGlobalParameters
    from: SqlVulnerabilityAssessmentsSettings.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/sqlVulnerabilityAssessments/{vulnerabilityAssessmentName}"].delete.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: SqlVulnerabilityAssessmentsSettings.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/sqlVulnerabilityAssessments/{vulnerabilityAssessmentName}"].delete.responses.default.schema["$ref"]
  - code: SystemDataDefinitionsCommonTypes
    from: SqlVulnerabilityAssessmentsSettings.json
    where: $.definitions.SqlVulnerabilityAssessment.properties.systemData["$ref"]
  - code: SchemaDescriptionOrTitle
    from: SqlVulnerabilityAssessmentsSettings.json
    where: $.definitions.SqlVulnerabilityAssessmentPolicyProperties
  - code: MissingSegmentsInNestedResourceListOperation
    from: StartStopManagedInstanceSchedules.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/startStopSchedules"]
  - code: ResourceNameRestriction
    from: StartStopManagedInstanceSchedules.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/startStopSchedules"]
  - code: ParameterNotDefinedInGlobalParameters
    from: StartStopManagedInstanceSchedules.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/startStopSchedules"].get.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: StartStopManagedInstanceSchedules.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/startStopSchedules"].get.responses.default.schema["$ref"]
  - code: ResourceNameRestriction
    from: StartStopManagedInstanceSchedules.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/startStopSchedules/{startStopScheduleName}"]
  - code: ParameterNotDefinedInGlobalParameters
    from: StartStopManagedInstanceSchedules.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/startStopSchedules/{startStopScheduleName}"].get.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: StartStopManagedInstanceSchedules.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/startStopSchedules/{startStopScheduleName}"].get.responses.default.schema["$ref"]
  - code: ParameterNotDefinedInGlobalParameters
    from: StartStopManagedInstanceSchedules.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/startStopSchedules/{startStopScheduleName}"].put.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: StartStopManagedInstanceSchedules.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/startStopSchedules/{startStopScheduleName}"].put.responses.default.schema["$ref"]
  - code: ParameterNotDefinedInGlobalParameters
    from: StartStopManagedInstanceSchedules.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/startStopSchedules/{startStopScheduleName}"].delete.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: StartStopManagedInstanceSchedules.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/startStopSchedules/{startStopScheduleName}"].delete.responses.default.schema["$ref"]
  - code: SystemDataDefinitionsCommonTypes
    from: StartStopManagedInstanceSchedules.json
    where: $.definitions.StartStopManagedInstanceSchedule.properties.systemData["$ref"]
  - code: ResourceNameRestriction
    from: SubscriptionUsages.json
    where: $.paths["/subscriptions/{subscriptionId}/providers/Microsoft.Sql/locations/{locationName}/usages"]
  - code: ParameterNotDefinedInGlobalParameters
    from: SubscriptionUsages.json
    where: $.paths["/subscriptions/{subscriptionId}/providers/Microsoft.Sql/locations/{locationName}/usages"].get.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: SubscriptionUsages.json
    where: $.paths["/subscriptions/{subscriptionId}/providers/Microsoft.Sql/locations/{locationName}/usages"].get.responses.default.schema["$ref"]
  - code: ResourceNameRestriction
    from: SubscriptionUsages.json
    where: $.paths["/subscriptions/{subscriptionId}/providers/Microsoft.Sql/locations/{locationName}/usages/{usageName}"]
  - code: ParameterNotDefinedInGlobalParameters
    from: SubscriptionUsages.json
    where: $.paths["/subscriptions/{subscriptionId}/providers/Microsoft.Sql/locations/{locationName}/usages/{usageName}"].get.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: SubscriptionUsages.json
    where: $.paths["/subscriptions/{subscriptionId}/providers/Microsoft.Sql/locations/{locationName}/usages/{usageName}"].get.responses.default.schema["$ref"]
  - code: MissingSegmentsInNestedResourceListOperation
    from: SynapseLinkWorkspaces.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/linkWorkspaces"]
  - code: ResourceNameRestriction
    from: SynapseLinkWorkspaces.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/linkWorkspaces"]
  - code: ParameterNotDefinedInGlobalParameters
    from: SynapseLinkWorkspaces.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/linkWorkspaces"].get.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: SynapseLinkWorkspaces.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/linkWorkspaces"].get.responses.default.schema["$ref"]
  - code: MissingSegmentsInNestedResourceListOperation
    from: SyncAgents.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/syncAgents"]
  - code: ResourceNameRestriction
    from: SyncAgents.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/syncAgents"]
  - code: ParameterNotDefinedInGlobalParameters
    from: SyncAgents.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/syncAgents"].get.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: SyncAgents.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/syncAgents"].get.responses.default.schema["$ref"]
  - code: ResourceNameRestriction
    from: SyncAgents.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/syncAgents/{syncAgentName}"]
  - code: ParameterNotDefinedInGlobalParameters
    from: SyncAgents.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/syncAgents/{syncAgentName}"].get.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: SyncAgents.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/syncAgents/{syncAgentName}"].get.responses.default.schema["$ref"]
  - code: ProvisioningStateSpecifiedForLROPut
    from: SyncAgents.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/syncAgents/{syncAgentName}"].put
  - code: PutResponseCodes
    from: SyncAgents.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/syncAgents/{syncAgentName}"].put
  - code: ParameterNotDefinedInGlobalParameters
    from: SyncAgents.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/syncAgents/{syncAgentName}"].put.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: SyncAgents.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/syncAgents/{syncAgentName}"].put.responses.default.schema["$ref"]
  - code: DeleteResponseCodes
    from: SyncAgents.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/syncAgents/{syncAgentName}"].delete
  - code: ParameterNotDefinedInGlobalParameters
    from: SyncAgents.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/syncAgents/{syncAgentName}"].delete.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: SyncAgents.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/syncAgents/{syncAgentName}"].delete.responses.default.schema["$ref"]
  - code: ResourceNameRestriction
    from: SyncAgents.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/syncAgents/{syncAgentName}/generateKey"]
  - code: ParameterNotDefinedInGlobalParameters
    from: SyncAgents.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/syncAgents/{syncAgentName}/generateKey"].post.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: SyncAgents.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/syncAgents/{syncAgentName}/generateKey"].post.responses.default.schema["$ref"]
  - code: ResourceNameRestriction
    from: SyncAgents.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/syncAgents/{syncAgentName}/linkedDatabases"]
  - code: ParameterNotDefinedInGlobalParameters
    from: SyncAgents.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/syncAgents/{syncAgentName}/linkedDatabases"].get.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: SyncAgents.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/syncAgents/{syncAgentName}/linkedDatabases"].get.responses.default.schema["$ref"]
  - code: PatchBodyParametersSchema
    from: SyncGroups.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/syncGroups/{syncGroupName}"].patch.parameters["4"].schema.properties.sku
  - code: ResourceNameRestriction
    from: SyncGroups.json
    where: $.paths["/subscriptions/{subscriptionId}/providers/Microsoft.Sql/locations/{locationName}/syncDatabaseIds"]
  - code: ParameterNotDefinedInGlobalParameters
    from: SyncGroups.json
    where: $.paths["/subscriptions/{subscriptionId}/providers/Microsoft.Sql/locations/{locationName}/syncDatabaseIds"].get.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: SyncGroups.json
    where: $.paths["/subscriptions/{subscriptionId}/providers/Microsoft.Sql/locations/{locationName}/syncDatabaseIds"].get.responses.default.schema["$ref"]
  - code: MissingSegmentsInNestedResourceListOperation
    from: SyncGroups.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/syncGroups"]
  - code: ResourceNameRestriction
    from: SyncGroups.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/syncGroups"]
  - code: ParameterNotDefinedInGlobalParameters
    from: SyncGroups.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/syncGroups"].get.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: SyncGroups.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/syncGroups"].get.responses.default.schema["$ref"]
  - code: ResourceNameRestriction
    from: SyncGroups.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/syncGroups/{syncGroupName}"]
  - code: ParameterNotDefinedInGlobalParameters
    from: SyncGroups.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/syncGroups/{syncGroupName}"].get.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: SyncGroups.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/syncGroups/{syncGroupName}"].get.responses.default.schema["$ref"]
  - code: ProvisioningStateSpecifiedForLROPut
    from: SyncGroups.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/syncGroups/{syncGroupName}"].put
  - code: PutResponseCodes
    from: SyncGroups.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/syncGroups/{syncGroupName}"].put
  - code: ParameterNotDefinedInGlobalParameters
    from: SyncGroups.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/syncGroups/{syncGroupName}"].put.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: SyncGroups.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/syncGroups/{syncGroupName}"].put.responses.default.schema["$ref"]
  - code: DeleteResponseCodes
    from: SyncGroups.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/syncGroups/{syncGroupName}"].delete
  - code: ParameterNotDefinedInGlobalParameters
    from: SyncGroups.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/syncGroups/{syncGroupName}"].delete.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: SyncGroups.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/syncGroups/{syncGroupName}"].delete.responses.default.schema["$ref"]
  - code: ParameterNotDefinedInGlobalParameters
    from: SyncGroups.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/syncGroups/{syncGroupName}"].patch.parameters
  - code: ProvisioningStateSpecifiedForLROPatch
    from: SyncGroups.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/syncGroups/{syncGroupName}"].patch.responses["200"]
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: SyncGroups.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/syncGroups/{syncGroupName}"].patch.responses.default.schema["$ref"]
  - code: ResourceNameRestriction
    from: SyncGroups.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/syncGroups/{syncGroupName}/cancelSync"]
  - code: ParameterNotDefinedInGlobalParameters
    from: SyncGroups.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/syncGroups/{syncGroupName}/cancelSync"].post.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: SyncGroups.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/syncGroups/{syncGroupName}/cancelSync"].post.responses.default.schema["$ref"]
  - code: ResourceNameRestriction
    from: SyncGroups.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/syncGroups/{syncGroupName}/hubSchemas"]
  - code: ParameterNotDefinedInGlobalParameters
    from: SyncGroups.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/syncGroups/{syncGroupName}/hubSchemas"].get.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: SyncGroups.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/syncGroups/{syncGroupName}/hubSchemas"].get.responses.default.schema["$ref"]
  - code: ResourceNameRestriction
    from: SyncGroups.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/syncGroups/{syncGroupName}/logs"]
  - code: ParameterNotDefinedInGlobalParameters
    from: SyncGroups.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/syncGroups/{syncGroupName}/logs"].get.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: SyncGroups.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/syncGroups/{syncGroupName}/logs"].get.responses.default.schema["$ref"]
  - code: ResourceNameRestriction
    from: SyncGroups.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/syncGroups/{syncGroupName}/refreshHubSchema"]
  - code: PostResponseCodes
    from: SyncGroups.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/syncGroups/{syncGroupName}/refreshHubSchema"].post
  - code: ParameterNotDefinedInGlobalParameters
    from: SyncGroups.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/syncGroups/{syncGroupName}/refreshHubSchema"].post.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: SyncGroups.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/syncGroups/{syncGroupName}/refreshHubSchema"].post.responses.default.schema["$ref"]
  - code: ResourceNameRestriction
    from: SyncGroups.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/syncGroups/{syncGroupName}/triggerSync"]
  - code: ParameterNotDefinedInGlobalParameters
    from: SyncGroups.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/syncGroups/{syncGroupName}/triggerSync"].post.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: SyncGroups.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/syncGroups/{syncGroupName}/triggerSync"].post.responses.default.schema["$ref"]
  - code: MissingSegmentsInNestedResourceListOperation
    from: SyncMembers.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/syncGroups/{syncGroupName}/syncMembers"]
  - code: ResourceNameRestriction
    from: SyncMembers.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/syncGroups/{syncGroupName}/syncMembers"]
  - code: ParameterNotDefinedInGlobalParameters
    from: SyncMembers.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/syncGroups/{syncGroupName}/syncMembers"].get.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: SyncMembers.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/syncGroups/{syncGroupName}/syncMembers"].get.responses.default.schema["$ref"]
  - code: ResourceNameRestriction
    from: SyncMembers.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/syncGroups/{syncGroupName}/syncMembers/{syncMemberName}"]
  - code: ParameterNotDefinedInGlobalParameters
    from: SyncMembers.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/syncGroups/{syncGroupName}/syncMembers/{syncMemberName}"].get.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: SyncMembers.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/syncGroups/{syncGroupName}/syncMembers/{syncMemberName}"].get.responses.default.schema["$ref"]
  - code: ProvisioningStateSpecifiedForLROPut
    from: SyncMembers.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/syncGroups/{syncGroupName}/syncMembers/{syncMemberName}"].put
  - code: PutResponseCodes
    from: SyncMembers.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/syncGroups/{syncGroupName}/syncMembers/{syncMemberName}"].put
  - code: ParameterNotDefinedInGlobalParameters
    from: SyncMembers.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/syncGroups/{syncGroupName}/syncMembers/{syncMemberName}"].put.parameters
  - code: RepeatedPathInfo
    from: SyncMembers.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/syncGroups/{syncGroupName}/syncMembers/{syncMemberName}"].put.parameters["1"]
  - code: RepeatedPathInfo
    from: SyncMembers.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/syncGroups/{syncGroupName}/syncMembers/{syncMemberName}"].put.parameters["2"]
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: SyncMembers.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/syncGroups/{syncGroupName}/syncMembers/{syncMemberName}"].put.responses.default.schema["$ref"]
  - code: DeleteResponseCodes
    from: SyncMembers.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/syncGroups/{syncGroupName}/syncMembers/{syncMemberName}"].delete
  - code: ParameterNotDefinedInGlobalParameters
    from: SyncMembers.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/syncGroups/{syncGroupName}/syncMembers/{syncMemberName}"].delete.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: SyncMembers.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/syncGroups/{syncGroupName}/syncMembers/{syncMemberName}"].delete.responses.default.schema["$ref"]
  - code: ParameterNotDefinedInGlobalParameters
    from: SyncMembers.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/syncGroups/{syncGroupName}/syncMembers/{syncMemberName}"].patch.parameters
  - code: ProvisioningStateSpecifiedForLROPatch
    from: SyncMembers.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/syncGroups/{syncGroupName}/syncMembers/{syncMemberName}"].patch.responses["200"]
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: SyncMembers.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/syncGroups/{syncGroupName}/syncMembers/{syncMemberName}"].patch.responses.default.schema["$ref"]
  - code: ResourceNameRestriction
    from: SyncMembers.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/syncGroups/{syncGroupName}/syncMembers/{syncMemberName}/refreshSchema"]
  - code: PostResponseCodes
    from: SyncMembers.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/syncGroups/{syncGroupName}/syncMembers/{syncMemberName}/refreshSchema"].post
  - code: ParameterNotDefinedInGlobalParameters
    from: SyncMembers.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/syncGroups/{syncGroupName}/syncMembers/{syncMemberName}/refreshSchema"].post.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: SyncMembers.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/syncGroups/{syncGroupName}/syncMembers/{syncMemberName}/refreshSchema"].post.responses.default.schema["$ref"]
  - code: ResourceNameRestriction
    from: SyncMembers.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/syncGroups/{syncGroupName}/syncMembers/{syncMemberName}/schemas"]
  - code: ParameterNotDefinedInGlobalParameters
    from: SyncMembers.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/syncGroups/{syncGroupName}/syncMembers/{syncMemberName}/schemas"].get.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: SyncMembers.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/syncGroups/{syncGroupName}/syncMembers/{syncMemberName}/schemas"].get.responses.default.schema["$ref"]
  - code: ResourceNameRestriction
    from: TdeCertificates.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/tdeCertificates"]
  - code: PostResponseCodes
    from: TdeCertificates.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/tdeCertificates"].post
  - code: ParameterNotDefinedInGlobalParameters
    from: TdeCertificates.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/tdeCertificates"].post.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: TdeCertificates.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/tdeCertificates"].post.responses.default.schema["$ref"]
  - code: ResourceNameRestriction
    from: TimeZones.json
    where: $.paths["/subscriptions/{subscriptionId}/providers/Microsoft.Sql/locations/{locationName}/timeZones"]
  - code: ParameterNotDefinedInGlobalParameters
    from: TimeZones.json
    where: $.paths["/subscriptions/{subscriptionId}/providers/Microsoft.Sql/locations/{locationName}/timeZones"].get.parameters
  - code: ParameterDescription
    from: TimeZones.json
    where: $.paths["/subscriptions/{subscriptionId}/providers/Microsoft.Sql/locations/{locationName}/timeZones"].get.parameters["0"]
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: TimeZones.json
    where: $.paths["/subscriptions/{subscriptionId}/providers/Microsoft.Sql/locations/{locationName}/timeZones"].get.responses.default.schema["$ref"]
  - code: ResourceNameRestriction
    from: TimeZones.json
    where: $.paths["/subscriptions/{subscriptionId}/providers/Microsoft.Sql/locations/{locationName}/timeZones/{timeZoneId}"]
  - code: ParameterNotDefinedInGlobalParameters
    from: TimeZones.json
    where: $.paths["/subscriptions/{subscriptionId}/providers/Microsoft.Sql/locations/{locationName}/timeZones/{timeZoneId}"].get.parameters
  - code: ParameterDescription
    from: TimeZones.json
    where: $.paths["/subscriptions/{subscriptionId}/providers/Microsoft.Sql/locations/{locationName}/timeZones/{timeZoneId}"].get.parameters["0"]
  - code: ParameterDescription
    from: TimeZones.json
    where: $.paths["/subscriptions/{subscriptionId}/providers/Microsoft.Sql/locations/{locationName}/timeZones/{timeZoneId}"].get.parameters["1"]
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: TimeZones.json
    where: $.paths["/subscriptions/{subscriptionId}/providers/Microsoft.Sql/locations/{locationName}/timeZones/{timeZoneId}"].get.responses.default.schema["$ref"]
  - code: MissingSegmentsInNestedResourceListOperation
    from: TransparentDataEncryptions.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/transparentDataEncryption"]
  - code: ResourceNameRestriction
    from: TransparentDataEncryptions.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/transparentDataEncryption"]
  - code: ParameterNotDefinedInGlobalParameters
    from: TransparentDataEncryptions.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/transparentDataEncryption"].get.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: TransparentDataEncryptions.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/transparentDataEncryption"].get.responses.default.schema["$ref"]
  - code: ResourceNameRestriction
    from: TransparentDataEncryptions.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/transparentDataEncryption/{tdeName}"]
  - code: ParameterNotDefinedInGlobalParameters
    from: TransparentDataEncryptions.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/transparentDataEncryption/{tdeName}"].get.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: TransparentDataEncryptions.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/transparentDataEncryption/{tdeName}"].get.responses.default.schema["$ref"]
  - code: ProvisioningStateSpecifiedForLROPut
    from: TransparentDataEncryptions.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/transparentDataEncryption/{tdeName}"].put
  - code: PutResponseCodes
    from: TransparentDataEncryptions.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/transparentDataEncryption/{tdeName}"].put
  - code: ParameterNotDefinedInGlobalParameters
    from: TransparentDataEncryptions.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/transparentDataEncryption/{tdeName}"].put.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: TransparentDataEncryptions.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/transparentDataEncryption/{tdeName}"].put.responses.default.schema["$ref"]
  - code: LongRunningOperationsOptionsValidator
    from: TransparentDataEncryptions.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/transparentDataEncryption/{tdeName}/resume"]
  - code: ResourceNameRestriction
    from: TransparentDataEncryptions.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/transparentDataEncryption/{tdeName}/resume"]
  - code: ParameterNotDefinedInGlobalParameters
    from: TransparentDataEncryptions.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/transparentDataEncryption/{tdeName}/resume"].post.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: TransparentDataEncryptions.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/transparentDataEncryption/{tdeName}/resume"].post.responses.default.schema["$ref"]
  - code: LongRunningOperationsOptionsValidator
    from: TransparentDataEncryptions.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/transparentDataEncryption/{tdeName}/suspend"]
  - code: ResourceNameRestriction
    from: TransparentDataEncryptions.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/transparentDataEncryption/{tdeName}/suspend"]
  - code: ParameterNotDefinedInGlobalParameters
    from: TransparentDataEncryptions.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/transparentDataEncryption/{tdeName}/suspend"].post.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: TransparentDataEncryptions.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/transparentDataEncryption/{tdeName}/suspend"].post.responses.default.schema["$ref"]
  - code: MissingSegmentsInNestedResourceListOperation
    from: Usages.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/instancePools/{instancePoolName}/usages"]
  - code: ResourceNameRestriction
    from: Usages.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/instancePools/{instancePoolName}/usages"]
  - code: ParameterNotDefinedInGlobalParameters
    from: Usages.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/instancePools/{instancePoolName}/usages"].get.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: Usages.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/instancePools/{instancePoolName}/usages"].get.responses.default.schema["$ref"]
  - code: ParameterNotDefinedInGlobalParameters
    from: VirtualClusters.json
    where: $.paths["/subscriptions/{subscriptionId}/providers/Microsoft.Sql/virtualClusters"].get.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: VirtualClusters.json
    where: $.paths["/subscriptions/{subscriptionId}/providers/Microsoft.Sql/virtualClusters"].get.responses.default.schema["$ref"]
  - code: ParameterNotDefinedInGlobalParameters
    from: VirtualClusters.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/virtualClusters"].get.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: VirtualClusters.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/virtualClusters"].get.responses.default.schema["$ref"]
  - code: ResourceNameRestriction
    from: VirtualClusters.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/virtualClusters/{virtualClusterName}"]
  - code: ParameterNotDefinedInGlobalParameters
    from: VirtualClusters.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/virtualClusters/{virtualClusterName}"].get.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: VirtualClusters.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/virtualClusters/{virtualClusterName}"].get.responses.default.schema["$ref"]
  - code: ProvisioningStateSpecifiedForLROPut
    from: VirtualClusters.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/virtualClusters/{virtualClusterName}"].put
  - code: PutResponseCodes
    from: VirtualClusters.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/virtualClusters/{virtualClusterName}"].put
  - code: ParameterNotDefinedInGlobalParameters
    from: VirtualClusters.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/virtualClusters/{virtualClusterName}"].put.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: VirtualClusters.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/virtualClusters/{virtualClusterName}"].put.responses.default.schema["$ref"]
  - code: DeleteResponseCodes
    from: VirtualClusters.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/virtualClusters/{virtualClusterName}"].delete
  - code: ParameterNotDefinedInGlobalParameters
    from: VirtualClusters.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/virtualClusters/{virtualClusterName}"].delete.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: VirtualClusters.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/virtualClusters/{virtualClusterName}"].delete.responses.default.schema["$ref"]
  - code: ParameterNotDefinedInGlobalParameters
    from: VirtualClusters.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/virtualClusters/{virtualClusterName}"].patch.parameters
  - code: ProvisioningStateSpecifiedForLROPatch
    from: VirtualClusters.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/virtualClusters/{virtualClusterName}"].patch.responses["200"]
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: VirtualClusters.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/virtualClusters/{virtualClusterName}"].patch.responses.default.schema["$ref"]
  - code: LongRunningOperationsOptionsValidator
    from: VirtualClusters.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/virtualClusters/{virtualClusterName}/updateManagedInstanceDnsServers"]
  - code: ResourceNameRestriction
    from: VirtualClusters.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/virtualClusters/{virtualClusterName}/updateManagedInstanceDnsServers"]
  - code: ParameterNotDefinedInGlobalParameters
    from: VirtualClusters.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/virtualClusters/{virtualClusterName}/updateManagedInstanceDnsServers"].post.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: VirtualClusters.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/virtualClusters/{virtualClusterName}/updateManagedInstanceDnsServers"].post.responses.default.schema["$ref"]
  - code: MissingSegmentsInNestedResourceListOperation
    from: VirtualNetworkRules.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/virtualNetworkRules"]
  - code: ResourceNameRestriction
    from: VirtualNetworkRules.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/virtualNetworkRules"]
  - code: ParameterNotDefinedInGlobalParameters
    from: VirtualNetworkRules.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/virtualNetworkRules"].get.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: VirtualNetworkRules.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/virtualNetworkRules"].get.responses.default.schema["$ref"]
  - code: ResourceNameRestriction
    from: VirtualNetworkRules.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/virtualNetworkRules/{virtualNetworkRuleName}"]
  - code: ParameterNotDefinedInGlobalParameters
    from: VirtualNetworkRules.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/virtualNetworkRules/{virtualNetworkRuleName}"].get.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: VirtualNetworkRules.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/virtualNetworkRules/{virtualNetworkRuleName}"].get.responses.default.schema["$ref"]
  - code: ProvisioningStateSpecifiedForLROPut
    from: VirtualNetworkRules.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/virtualNetworkRules/{virtualNetworkRuleName}"].put
  - code: PutResponseCodes
    from: VirtualNetworkRules.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/virtualNetworkRules/{virtualNetworkRuleName}"].put
  - code: ParameterNotDefinedInGlobalParameters
    from: VirtualNetworkRules.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/virtualNetworkRules/{virtualNetworkRuleName}"].put.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: VirtualNetworkRules.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/virtualNetworkRules/{virtualNetworkRuleName}"].put.responses.default.schema["$ref"]
  - code: DeleteResponseCodes
    from: VirtualNetworkRules.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/virtualNetworkRules/{virtualNetworkRuleName}"].delete
  - code: ParameterNotDefinedInGlobalParameters
    from: VirtualNetworkRules.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/virtualNetworkRules/{virtualNetworkRuleName}"].delete.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: VirtualNetworkRules.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/virtualNetworkRules/{virtualNetworkRuleName}"].delete.responses.default.schema["$ref"]
  - code: MissingSegmentsInNestedResourceListOperation
    from: WorkloadClassifiers.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/workloadGroups/{workloadGroupName}/workloadClassifiers"]
  - code: ResourceNameRestriction
    from: WorkloadClassifiers.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/workloadGroups/{workloadGroupName}/workloadClassifiers"]
  - code: ParameterNotDefinedInGlobalParameters
    from: WorkloadClassifiers.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/workloadGroups/{workloadGroupName}/workloadClassifiers"].get.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: WorkloadClassifiers.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/workloadGroups/{workloadGroupName}/workloadClassifiers"].get.responses.default.schema["$ref"]
  - code: ResourceNameRestriction
    from: WorkloadClassifiers.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/workloadGroups/{workloadGroupName}/workloadClassifiers/{workloadClassifierName}"]
  - code: ParameterNotDefinedInGlobalParameters
    from: WorkloadClassifiers.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/workloadGroups/{workloadGroupName}/workloadClassifiers/{workloadClassifierName}"].get.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: WorkloadClassifiers.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/workloadGroups/{workloadGroupName}/workloadClassifiers/{workloadClassifierName}"].get.responses.default.schema["$ref"]
  - code: ProvisioningStateSpecifiedForLROPut
    from: WorkloadClassifiers.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/workloadGroups/{workloadGroupName}/workloadClassifiers/{workloadClassifierName}"].put
  - code: PutResponseCodes
    from: WorkloadClassifiers.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/workloadGroups/{workloadGroupName}/workloadClassifiers/{workloadClassifierName}"].put
  - code: ParameterNotDefinedInGlobalParameters
    from: WorkloadClassifiers.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/workloadGroups/{workloadGroupName}/workloadClassifiers/{workloadClassifierName}"].put.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: WorkloadClassifiers.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/workloadGroups/{workloadGroupName}/workloadClassifiers/{workloadClassifierName}"].put.responses.default.schema["$ref"]
  - code: DeleteResponseCodes
    from: WorkloadClassifiers.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/workloadGroups/{workloadGroupName}/workloadClassifiers/{workloadClassifierName}"].delete
  - code: ParameterNotDefinedInGlobalParameters
    from: WorkloadClassifiers.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/workloadGroups/{workloadGroupName}/workloadClassifiers/{workloadClassifierName}"].delete.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: WorkloadClassifiers.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/workloadGroups/{workloadGroupName}/workloadClassifiers/{workloadClassifierName}"].delete.responses.default.schema["$ref"]
  - code: MissingSegmentsInNestedResourceListOperation
    from: WorkloadGroups.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/workloadGroups"]
  - code: ResourceNameRestriction
    from: WorkloadGroups.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/workloadGroups"]
  - code: ParameterNotDefinedInGlobalParameters
    from: WorkloadGroups.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/workloadGroups"].get.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: WorkloadGroups.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/workloadGroups"].get.responses.default.schema["$ref"]
  - code: ResourceNameRestriction
    from: WorkloadGroups.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/workloadGroups/{workloadGroupName}"]
  - code: ParameterNotDefinedInGlobalParameters
    from: WorkloadGroups.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/workloadGroups/{workloadGroupName}"].get.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: WorkloadGroups.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/workloadGroups/{workloadGroupName}"].get.responses.default.schema["$ref"]
  - code: ProvisioningStateSpecifiedForLROPut
    from: WorkloadGroups.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/workloadGroups/{workloadGroupName}"].put
  - code: PutResponseCodes
    from: WorkloadGroups.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/workloadGroups/{workloadGroupName}"].put
  - code: ParameterNotDefinedInGlobalParameters
    from: WorkloadGroups.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/workloadGroups/{workloadGroupName}"].put.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: WorkloadGroups.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/workloadGroups/{workloadGroupName}"].put.responses.default.schema["$ref"]
  - code: DeleteResponseCodes
    from: WorkloadGroups.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/workloadGroups/{workloadGroupName}"].delete
  - code: ParameterNotDefinedInGlobalParameters
    from: WorkloadGroups.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/workloadGroups/{workloadGroupName}"].delete.parameters
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: WorkloadGroups.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/workloadGroups/{workloadGroupName}"].delete.responses.default.schema["$ref"]

```
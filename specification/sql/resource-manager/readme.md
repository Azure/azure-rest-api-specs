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
tag: package-composite-v3
```

## Composite packages

The following packages may be composed from multiple api-versions.

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

  * `+2017-10-01-preview/databases.json`

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
- Microsoft.Sql/stable/2014-04-01/importExport.json
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
- Microsoft.Sql/preview/2015-05-01-preview/syncGroups.json
- Microsoft.Sql/preview/2015-05-01-preview/syncMembers.json
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
- Microsoft.Sql/preview/2017-10-01-preview/databases.json
- Microsoft.Sql/preview/2017-10-01-preview/elasticPools.json
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
- Microsoft.Sql/preview/2018-06-01-preview/managedInstances.json
- Microsoft.Sql/preview/2018-06-01-preview/FailoverDatabases.json
- Microsoft.Sql/preview/2018-06-01-preview/FailoverElasticPools.json
- Microsoft.Sql/preview/2018-06-01-preview/PrivateEndpointConnections.json
- Microsoft.Sql/preview/2018-06-01-preview/PrivateLinkResources.json
- Microsoft.Sql/preview/2019-06-01-preview/servers.json
- Microsoft.Sql/preview/2018-06-01-preview/capabilities.json
- Microsoft.Sql/preview/2018-06-01-preview/LongTermRetentionManagedInstanceBackups.json
- Microsoft.Sql/preview/2018-06-01-preview/ManagedInstanceLongTermRetentionPolicies.json
- Microsoft.Sql/preview/2019-06-01-preview/WorkloadGroups.json
- Microsoft.Sql/preview/2019-06-01-preview/WorkloadClassifiers.json
- Microsoft.Sql/preview/2019-06-01-preview/managedDatabases.json
- Microsoft.Sql/preview/2019-06-01-preview/ServerAzureADAdministrators.json
- Microsoft.Sql/preview/2019-06-01-preview/managedInstanceOperations.json

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
- Microsoft.Sql/preview/2015-05-01-preview/syncGroups.json
- Microsoft.Sql/preview/2015-05-01-preview/syncMembers.json
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
- Microsoft.Sql/preview/2018-06-01-preview/managedInstances.json
- Microsoft.Sql/preview/2018-06-01-preview/FailoverDatabases.json
- Microsoft.Sql/preview/2018-06-01-preview/FailoverElasticPools.json
- Microsoft.Sql/preview/2018-06-01-preview/PrivateEndpointConnections.json
- Microsoft.Sql/preview/2018-06-01-preview/PrivateLinkResources.json
- Microsoft.Sql/preview/2019-06-01-preview/servers.json
- Microsoft.Sql/preview/2018-06-01-preview/LongTermRetentionManagedInstanceBackups.json
- Microsoft.Sql/preview/2018-06-01-preview/ManagedInstanceLongTermRetentionPolicies.json
- Microsoft.Sql/preview/2019-06-01-preview/WorkloadGroups.json
- Microsoft.Sql/preview/2019-06-01-preview/WorkloadClassifiers.json
- Microsoft.Sql/preview/2019-06-01-preview/managedDatabases.json
- Microsoft.Sql/preview/2019-06-01-preview/ServerAzureADAdministrators.json

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
- Microsoft.Sql/stable/2014-04-01/backupLongTermRetentionPolicies.json
- Microsoft.Sql/stable/2014-04-01/backupLongTermRetentionVaults.json
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
- Microsoft.Sql/preview/2015-05-01-preview/syncGroups.json
- Microsoft.Sql/preview/2015-05-01-preview/syncMembers.json
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
- Microsoft.Sql/preview/2018-06-01-preview/managedInstances.json
- Microsoft.Sql/preview/2018-06-01-preview/FailoverDatabases.json
- Microsoft.Sql/preview/2018-06-01-preview/FailoverElasticPools.json
- Microsoft.Sql/preview/2018-06-01-preview/PrivateEndpointConnections.json
- Microsoft.Sql/preview/2018-06-01-preview/PrivateLinkResources.json
- Microsoft.Sql/preview/2019-06-01-preview/servers.json
- Microsoft.Sql/preview/2018-06-01-preview/LongTermRetentionManagedInstanceBackups.json
- Microsoft.Sql/preview/2018-06-01-preview/ManagedInstanceLongTermRetentionPolicies.json
- Microsoft.Sql/preview/2019-06-01-preview/WorkloadGroups.json
- Microsoft.Sql/preview/2019-06-01-preview/WorkloadClassifiers.json
- Microsoft.Sql/preview/2019-06-01-preview/managedDatabases.json
- Microsoft.Sql/preview/2019-06-01-preview/ServerAzureADAdministrators.json

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
- Microsoft.Sql/stable/2014-04-01/backupLongTermRetentionPolicies.json
- Microsoft.Sql/stable/2014-04-01/backupLongTermRetentionVaults.json
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
- Microsoft.Sql/stable/2014-04-01/backupLongTermRetentionPolicies.json
- Microsoft.Sql/stable/2014-04-01/backupLongTermRetentionVaults.json
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
 - ./Microsoft.Sql/stable/2014-04-01/backupLongTermRetentionPolicies.json
 - ./Microsoft.Sql/stable/2014-04-01/backupLongTermRetentionVaults.json
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
  - repo: azure-sdk-for-net
  - repo: azure-sdk-for-python
  - repo: azure-sdk-for-java
  - repo: azure-sdk-for-go
  - repo: azure-sdk-for-node
  - repo: azure-sdk-for-js
  - repo: azure-sdk-for-ruby
    after_scripts:
      - bundle install && rake arm:regen_all_profiles['azure_mgmt_sql']
```

### C#

These settings apply only when `--csharp` is specified on the command line.
Please also specify `--csharp-sdks-folder=<path to "SDKs" directory of your azure-sdk-for-net clone>`.

``` yaml $(csharp)
csharp:
  azure-arm: true
  license-header: MICROSOFT_MIT_NO_VERSION
  namespace: Microsoft.Azure.Management.Sql
  output-folder: $(csharp-sdks-folder)/sqlmanagement/Microsoft.Azure.Management.Sql/src/Generated
  clear-output-folder: true
```

### Python

These settings apply only when `--python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.
Use `--python-mode=update` if you already have a setup.py and just want to update the code itself.

``` yaml $(python)
python-mode: create
python:
  azure-arm: true
  license-header: MICROSOFT_MIT_NO_VERSION
  payload-flattening-threshold: 2
  namespace: azure.mgmt.sql
  package-name: azure-mgmt-sql
  package-version: 0.9.0
  clear-output-folder: true
```

``` yaml $(python) && $(python-mode) == 'update'
python:
  no-namespace-folders: true
  output-folder: $(python-sdks-folder)/sql/azure-mgmt-sql/azure/mgmt/sql
```

``` yaml $(python) && $(python-mode) == 'create'
python:
  basic-setup-py: true
  output-folder: $(python-sdks-folder)/sql/azure-mgmt-sql
```

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

## Multi-API/Profile support for AutoRest v3 generators

AutoRest V3 generators require the use of `--tag=all-api-versions` to select api files.

This block is updated by an automatic script. Edits may be lost!

``` yaml $(tag) == 'all-api-versions' /* autogenerated */
# include the azure profile definitions from the standard location
require: $(this-folder)/../../../profiles/readme.md

# all the input files across all versions
input-file:
  - $(this-folder)/Microsoft.Sql/stable/2014-04-01/backups.json
  - $(this-folder)/Microsoft.Sql/stable/2014-04-01/connectionPolicies.json
  - $(this-folder)/Microsoft.Sql/stable/2014-04-01/databaseSecurityAlertPolicies.json
  - $(this-folder)/Microsoft.Sql/stable/2014-04-01/dataMasking.json
  - $(this-folder)/Microsoft.Sql/stable/2014-04-01/firewallRules.json
  - $(this-folder)/Microsoft.Sql/stable/2014-04-01/geoBackupPolicies.json
  - $(this-folder)/Microsoft.Sql/stable/2014-04-01/importExport.json
  - $(this-folder)/Microsoft.Sql/stable/2014-04-01/metrics.json
  - $(this-folder)/Microsoft.Sql/stable/2014-04-01/recommendedElasticPoolsDecoupled.json
  - $(this-folder)/Microsoft.Sql/stable/2014-04-01/replicationLinks.json
  - $(this-folder)/Microsoft.Sql/stable/2014-04-01/serverCommunicationLinks.json
  - $(this-folder)/Microsoft.Sql/stable/2014-04-01/serviceObjectives.json
  - $(this-folder)/Microsoft.Sql/stable/2014-04-01/sql.core.json
  - $(this-folder)/Microsoft.Sql/stable/2014-04-01/usages.json
  - $(this-folder)/Microsoft.Sql/preview/2015-05-01-preview/databaseAutomaticTuning.json
  - $(this-folder)/Microsoft.Sql/preview/2015-05-01-preview/encryptionProtectors.json
  - $(this-folder)/Microsoft.Sql/preview/2015-05-01-preview/failoverGroups.json
  - $(this-folder)/Microsoft.Sql/preview/2015-05-01-preview/operations.json
  - $(this-folder)/Microsoft.Sql/preview/2015-05-01-preview/serverKeys.json
  - $(this-folder)/Microsoft.Sql/preview/2015-05-01-preview/syncAgents.json
  - $(this-folder)/Microsoft.Sql/preview/2015-05-01-preview/syncGroups.json
  - $(this-folder)/Microsoft.Sql/preview/2015-05-01-preview/syncMembers.json
  - $(this-folder)/Microsoft.Sql/preview/2015-05-01-preview/usages.json
  - $(this-folder)/Microsoft.Sql/preview/2015-05-01-preview/virtualclusters.json
  - $(this-folder)/Microsoft.Sql/preview/2015-05-01-preview/virtualNetworkRules.json
  - $(this-folder)/Microsoft.Sql/preview/2017-03-01-preview/blobAuditing.json
  - $(this-folder)/Microsoft.Sql/preview/2017-03-01-preview/databaseVulnerabilityAssessmentBaselines.json
  - $(this-folder)/Microsoft.Sql/preview/2017-03-01-preview/databaseVulnerabilityAssessments.json
  - $(this-folder)/Microsoft.Sql/preview/2017-03-01-preview/jobs.json
  - $(this-folder)/Microsoft.Sql/preview/2017-03-01-preview/longTermRetention.json
  - $(this-folder)/Microsoft.Sql/preview/2017-03-01-preview/ManagedBackupShortTermRetention.json
  - $(this-folder)/Microsoft.Sql/preview/2017-03-01-preview/ManagedRestorableDroppedDatabaseBackupShortTermRetenion.json
  - $(this-folder)/Microsoft.Sql/preview/2017-03-01-preview/serverAutomaticTuning.json
  - $(this-folder)/Microsoft.Sql/preview/2017-03-01-preview/serverDnsAliases.json
  - $(this-folder)/Microsoft.Sql/preview/2017-03-01-preview/serverSecurityAlertPolicies.json
  - $(this-folder)/Microsoft.Sql/preview/2017-03-01-preview/restorableDroppedManagedDatabases.json
  - $(this-folder)/Microsoft.Sql/preview/2017-03-01-preview/restorePoints.json
  - $(this-folder)/Microsoft.Sql/preview/2017-03-01-preview/ManagedDatabaseSecurityAlertPolicies.json
  - $(this-folder)/Microsoft.Sql/preview/2017-03-01-preview/ManagedServerSecurityAlertPolicy.json
  - $(this-folder)/Microsoft.Sql/preview/2017-03-01-preview/SensitivityLabels.json
  - $(this-folder)/Microsoft.Sql/preview/2017-03-01-preview/managedInstanceAdministrators.json
  - $(this-folder)/Microsoft.Sql/preview/2017-10-01-preview/cancelOperations.json
  - $(this-folder)/Microsoft.Sql/preview/2017-10-01-preview/cancelPoolOperations.json
  - $(this-folder)/Microsoft.Sql/preview/2017-10-01-preview/databases.json
  - $(this-folder)/Microsoft.Sql/preview/2017-10-01-preview/elasticPools.json
  - $(this-folder)/Microsoft.Sql/preview/2017-10-01-preview/databaseVulnerabilityAssessmentScans.json
  - $(this-folder)/Microsoft.Sql/preview/2017-10-01-preview/managedDatabaseVulnerabilityAssesmentRuleBaselines.json
  - $(this-folder)/Microsoft.Sql/preview/2017-10-01-preview/managedDatabaseVulnerabilityAssessmentScans.json
  - $(this-folder)/Microsoft.Sql/preview/2017-10-01-preview/managedDatabaseVulnerabilityAssessments.json
  - $(this-folder)/Microsoft.Sql/preview/2017-10-01-preview/instanceFailoverGroups.json
  - $(this-folder)/Microsoft.Sql/preview/2017-10-01-preview/shortTermRetentionPolicies.json
  - $(this-folder)/Microsoft.Sql/preview/2017-10-01-preview/TdeCertificates.json
  - $(this-folder)/Microsoft.Sql/preview/2017-10-01-preview/ManagedInstanceTdeCertificates.json
  - $(this-folder)/Microsoft.Sql/preview/2017-10-01-preview/ManagedInstanceKeys.json
  - $(this-folder)/Microsoft.Sql/preview/2017-10-01-preview/ManagedInstanceEncryptionProtectors.json
  - $(this-folder)/Microsoft.Sql/preview/2017-10-01-preview/recoverableManagedDatabases.json
  - $(this-folder)/Microsoft.Sql/preview/2018-06-01-preview/ManagedInstanceVulnerabilityAssessments.json
  - $(this-folder)/Microsoft.Sql/preview/2018-06-01-preview/ServerVulnerabilityAssessments.json
  - $(this-folder)/Microsoft.Sql/preview/2018-06-01-preview/managedDatabaseSensitivityLabels.json
  - $(this-folder)/Microsoft.Sql/preview/2018-06-01-preview/instancePools.json
  - $(this-folder)/Microsoft.Sql/preview/2018-06-01-preview/usages.json
  - $(this-folder)/Microsoft.Sql/preview/2018-06-01-preview/managedInstances.json
  - $(this-folder)/Microsoft.Sql/preview/2018-06-01-preview/FailoverDatabases.json
  - $(this-folder)/Microsoft.Sql/preview/2018-06-01-preview/FailoverElasticPools.json
  - $(this-folder)/Microsoft.Sql/preview/2018-06-01-preview/PrivateEndpointConnections.json
  - $(this-folder)/Microsoft.Sql/preview/2018-06-01-preview/PrivateLinkResources.json
  - $(this-folder)/Microsoft.Sql/preview/2019-06-01-preview/servers.json
  - $(this-folder)/Microsoft.Sql/preview/2018-06-01-preview/capabilities.json
  - $(this-folder)/Microsoft.Sql/preview/2018-06-01-preview/LongTermRetentionManagedInstanceBackups.json
  - $(this-folder)/Microsoft.Sql/preview/2018-06-01-preview/ManagedInstanceLongTermRetentionPolicies.json
  - $(this-folder)/Microsoft.Sql/preview/2019-06-01-preview/WorkloadGroups.json
  - $(this-folder)/Microsoft.Sql/preview/2019-06-01-preview/WorkloadClassifiers.json
  - $(this-folder)/Microsoft.Sql/preview/2019-06-01-preview/managedDatabases.json
  - $(this-folder)/Microsoft.Sql/preview/2019-06-01-preview/ServerAzureADAdministrators.json
  - $(this-folder)/Microsoft.Sql/preview/2019-06-01-preview/managedInstanceOperations.json
  - $(this-folder)/Microsoft.Sql/stable/2014-04-01/capabilities.json
  - $(this-folder)/Microsoft.Sql/stable/2014-04-01/databases.json
  - $(this-folder)/Microsoft.Sql/stable/2014-04-01/elasticPools.json
  - $(this-folder)/Microsoft.Sql/stable/2014-04-01/recommendedElasticPools.json
  - $(this-folder)/Microsoft.Sql/preview/2017-03-01-preview/renameDatabase.json
  - $(this-folder)/Microsoft.Sql/stable/2014-04-01/backupLongTermRetentionPolicies.json
  - $(this-folder)/Microsoft.Sql/stable/2014-04-01/backupLongTermRetentionVaults.json
  - $(this-folder)/Microsoft.Sql/stable/2014-04-01/checkNameAvailability.json
  - $(this-folder)/Microsoft.Sql/stable/2014-04-01/serverAzureADAdministrators.json
  - $(this-folder)/Microsoft.Sql/preview/2015-05-01-preview/managedInstances.json
  - $(this-folder)/Microsoft.Sql/preview/2015-05-01-preview/servers.json
  - $(this-folder)/Microsoft.Sql/preview/2017-03-01-preview/cancelOperations.json
  - $(this-folder)/Microsoft.Sql/preview/2017-03-01-preview/dataWarehouseUserActivities.json
  - $(this-folder)/Microsoft.Sql/preview/2017-03-01-preview/managedDatabases.json
  - $(this-folder)/Microsoft.Sql/stable/2014-04-01/restorePoints.json
  - $(this-folder)/Microsoft.Sql/stable/2015-05-01/capabilities.json
  - $(this-folder)/Microsoft.Sql/preview/2015-05-01-preview/blobAuditing.json
  - $(this-folder)/./Microsoft.Sql/preview/2019-06-01-preview/databases.json
  - $(this-folder)/./Microsoft.Sql/preview/2019-06-01-preview/managedDatabases.json
  - $(this-folder)/./Microsoft.Sql/preview/2019-06-01-preview/serverOperations.json
  - $(this-folder)/./Microsoft.Sql/preview/2019-06-01-preview/servers.json
  - $(this-folder)/./Microsoft.Sql/preview/2019-06-01-preview/WorkloadGroups.json
  - $(this-folder)/./Microsoft.Sql/preview/2019-06-01-preview/WorkloadClassifiers.json
  - $(this-folder)/./Microsoft.Sql/preview/2019-06-01-preview/managedInstanceOperations.json
  - $(this-folder)/./Microsoft.Sql/preview/2019-06-01-preview/ServerAzureADAdministrators.json
  - $(this-folder)/./Microsoft.Sql/preview/2018-06-01-preview/DatabaseSecurityAlertPolicies.json
  - $(this-folder)/./Microsoft.Sql/preview/2018-06-01-preview/managedDatabaseSensitivityLabels.json
  - $(this-folder)/./Microsoft.Sql/preview/2018-06-01-preview/ManagedInstanceVulnerabilityAssessments.json
  - $(this-folder)/./Microsoft.Sql/preview/2018-06-01-preview/managedInstanceOperations.json
  - $(this-folder)/./Microsoft.Sql/preview/2018-06-01-preview/ServerVulnerabilityAssessments.json
  - $(this-folder)/./Microsoft.Sql/preview/2018-06-01-preview/instancePools.json
  - $(this-folder)/./Microsoft.Sql/preview/2018-06-01-preview/usages.json
  - $(this-folder)/./Microsoft.Sql/preview/2018-06-01-preview/managedInstances.json
  - $(this-folder)/./Microsoft.Sql/preview/2018-06-01-preview/managedDatabases.json
  - $(this-folder)/./Microsoft.Sql/preview/2018-06-01-preview/FailoverDatabases.json
  - $(this-folder)/./Microsoft.Sql/preview/2018-06-01-preview/FailoverElasticPools.json
  - $(this-folder)/./Microsoft.Sql/preview/2018-06-01-preview/PrivateEndpointConnections.json
  - $(this-folder)/./Microsoft.Sql/preview/2018-06-01-preview/ServerAzureADAdministrators.json
  - $(this-folder)/./Microsoft.Sql/preview/2018-06-01-preview/ManagedInstanceLongTermRetentionPolicies.json
  - $(this-folder)/./Microsoft.Sql/preview/2018-06-01-preview/LongTermRetentionManagedInstanceBackups.json
  - $(this-folder)/./Microsoft.Sql/preview/2017-10-01-preview/cancelOperations.json
  - $(this-folder)/./Microsoft.Sql/preview/2017-10-01-preview/cancelPoolOperations.json
  - $(this-folder)/./Microsoft.Sql/preview/2017-10-01-preview/databaseVulnerabilityAssessmentScans.json
  - $(this-folder)/./Microsoft.Sql/preview/2017-10-01-preview/managedDatabaseVulnerabilityAssesmentRuleBaselines.json
  - $(this-folder)/./Microsoft.Sql/preview/2017-10-01-preview/managedDatabaseVulnerabilityAssessmentScans.json
  - $(this-folder)/./Microsoft.Sql/preview/2017-10-01-preview/managedDatabaseVulnerabilityAssessments.json
  - $(this-folder)/./Microsoft.Sql/preview/2017-10-01-preview/capabilities.json
  - $(this-folder)/./Microsoft.Sql/preview/2017-10-01-preview/databases.json
  - $(this-folder)/./Microsoft.Sql/preview/2017-10-01-preview/elasticPools.json
  - $(this-folder)/./Microsoft.Sql/preview/2017-10-01-preview/instanceFailoverGroups.json
  - $(this-folder)/./Microsoft.Sql/preview/2017-10-01-preview/shortTermRetentionPolicies.json
  - $(this-folder)/./Microsoft.Sql/preview/2017-10-01-preview/TdeCertificates.json
  - $(this-folder)/./Microsoft.Sql/preview/2017-10-01-preview/ManagedInstanceTdeCertificates.json
  - $(this-folder)/./Microsoft.Sql/preview/2017-10-01-preview/ManagedInstanceKeys.json
  - $(this-folder)/./Microsoft.Sql/preview/2017-10-01-preview/ManagedInstanceEncryptionProtectors.json
  - $(this-folder)/./Microsoft.Sql/preview/2017-10-01-preview/recoverableManagedDatabases.json
  - $(this-folder)/./Microsoft.Sql/preview/2017-03-01-preview/blobAuditing.json
  - $(this-folder)/./Microsoft.Sql/preview/2017-03-01-preview/cancelOperations.json
  - $(this-folder)/./Microsoft.Sql/preview/2017-03-01-preview/databases.json
  - $(this-folder)/./Microsoft.Sql/preview/2017-03-01-preview/databaseVulnerabilityAssessmentBaselines.json
  - $(this-folder)/./Microsoft.Sql/preview/2017-03-01-preview/databaseVulnerabilityAssessments.json
  - $(this-folder)/./Microsoft.Sql/preview/2017-03-01-preview/dataWarehouseUserActivities.json
  - $(this-folder)/./Microsoft.Sql/preview/2017-03-01-preview/jobs.json
  - $(this-folder)/./Microsoft.Sql/preview/2017-03-01-preview/longTermRetention.json
  - $(this-folder)/./Microsoft.Sql/preview/2017-03-01-preview/ManagedBackupShortTermRetention.json
  - $(this-folder)/./Microsoft.Sql/preview/2017-03-01-preview/managedDatabases.json
  - $(this-folder)/./Microsoft.Sql/preview/2017-03-01-preview/ManagedRestorableDroppedDatabaseBackupShortTermRetenion.json
  - $(this-folder)/./Microsoft.Sql/preview/2017-03-01-preview/renameDatabase.json
  - $(this-folder)/./Microsoft.Sql/preview/2017-03-01-preview/restorableDroppedManagedDatabases.json
  - $(this-folder)/./Microsoft.Sql/preview/2017-03-01-preview/restorePoints.json
  - $(this-folder)/./Microsoft.Sql/preview/2017-03-01-preview/serverAutomaticTuning.json
  - $(this-folder)/./Microsoft.Sql/preview/2017-03-01-preview/serverDnsAliases.json
  - $(this-folder)/./Microsoft.Sql/preview/2017-03-01-preview/serverSecurityAlertPolicies.json
  - $(this-folder)/./Microsoft.Sql/preview/2017-03-01-preview/ManagedDatabaseSecurityAlertPolicies.json
  - $(this-folder)/./Microsoft.Sql/preview/2017-03-01-preview/ManagedServerSecurityAlertPolicy.json
  - $(this-folder)/./Microsoft.Sql/preview/2017-03-01-preview/SensitivityLabels.json
  - $(this-folder)/./Microsoft.Sql/preview/2017-03-01-preview/managedInstanceAdministrators.json
  - $(this-folder)/./Microsoft.Sql/preview/2015-05-01-preview/advisors.json
  - $(this-folder)/./Microsoft.Sql/preview/2015-05-01-preview/blobAuditing.json
  - $(this-folder)/./Microsoft.Sql/preview/2015-05-01-preview/databaseAutomaticTuning.json
  - $(this-folder)/./Microsoft.Sql/preview/2015-05-01-preview/encryptionProtectors.json
  - $(this-folder)/./Microsoft.Sql/preview/2015-05-01-preview/failoverGroups.json
  - $(this-folder)/./Microsoft.Sql/preview/2015-05-01-preview/firewallRules.json
  - $(this-folder)/./Microsoft.Sql/preview/2015-05-01-preview/managedInstances.json
  - $(this-folder)/./Microsoft.Sql/preview/2015-05-01-preview/operations.json
  - $(this-folder)/./Microsoft.Sql/preview/2015-05-01-preview/serverKeys.json
  - $(this-folder)/./Microsoft.Sql/preview/2015-05-01-preview/servers.json
  - $(this-folder)/./Microsoft.Sql/preview/2015-05-01-preview/syncAgents.json
  - $(this-folder)/./Microsoft.Sql/preview/2015-05-01-preview/syncGroups.json
  - $(this-folder)/./Microsoft.Sql/preview/2015-05-01-preview/syncMembers.json
  - $(this-folder)/./Microsoft.Sql/preview/2015-05-01-preview/usages.json
  - $(this-folder)/./Microsoft.Sql/preview/2015-05-01-preview/virtualclusters.json
  - $(this-folder)/./Microsoft.Sql/preview/2015-05-01-preview/virtualNetworkRules.json
  - $(this-folder)/./Microsoft.Sql/stable/2014-04-01/advisors.json
  - $(this-folder)/./Microsoft.Sql/stable/2014-04-01/backupLongTermRetentionPolicies.json
  - $(this-folder)/./Microsoft.Sql/stable/2014-04-01/backupLongTermRetentionVaults.json
  - $(this-folder)/./Microsoft.Sql/stable/2014-04-01/backups.json
  - $(this-folder)/./Microsoft.Sql/stable/2014-04-01/capabilities.json
  - $(this-folder)/./Microsoft.Sql/stable/2014-04-01/checkNameAvailability.json
  - $(this-folder)/./Microsoft.Sql/stable/2014-04-01/connectionPolicies.json
  - $(this-folder)/./Microsoft.Sql/stable/2014-04-01/databases.json
  - $(this-folder)/./Microsoft.Sql/stable/2014-04-01/databaseSecurityAlertPolicies.json
  - $(this-folder)/./Microsoft.Sql/stable/2014-04-01/dataMasking.json
  - $(this-folder)/./Microsoft.Sql/stable/2014-04-01/deprecated.json
  - $(this-folder)/./Microsoft.Sql/stable/2014-04-01/disasterRecoveryConfigurations.json
  - $(this-folder)/./Microsoft.Sql/stable/2014-04-01/elasticPools.json
  - $(this-folder)/./Microsoft.Sql/stable/2014-04-01/firewallRules.json
  - $(this-folder)/./Microsoft.Sql/stable/2014-04-01/geoBackupPolicies.json
  - $(this-folder)/./Microsoft.Sql/stable/2014-04-01/importExport.json
  - $(this-folder)/./Microsoft.Sql/stable/2014-04-01/metrics.json
  - $(this-folder)/./Microsoft.Sql/stable/2014-04-01/operations.json
  - $(this-folder)/./Microsoft.Sql/stable/2014-04-01/queries.json
  - $(this-folder)/./Microsoft.Sql/stable/2014-04-01/recommendedElasticPools.json
  - $(this-folder)/./Microsoft.Sql/stable/2014-04-01/replicationLinks.json
  - $(this-folder)/./Microsoft.Sql/stable/2014-04-01/restorePoints.json
  - $(this-folder)/./Microsoft.Sql/stable/2014-04-01/serverAzureADAdministrators.json
  - $(this-folder)/./Microsoft.Sql/stable/2014-04-01/serverCommunicationLinks.json
  - $(this-folder)/./Microsoft.Sql/stable/2014-04-01/servers.json
  - $(this-folder)/./Microsoft.Sql/stable/2014-04-01/serviceObjectives.json
  - $(this-folder)/./Microsoft.Sql/stable/2014-04-01/sql.core.json
  - $(this-folder)/./Microsoft.Sql/stable/2014-04-01/tableAuditing.json
  - $(this-folder)/./Microsoft.Sql/stable/2014-04-01/usages.json

```

If there are files that should not be in the `all-api-versions` set,
uncomment the  `exclude-file` section below and add the file paths.

``` yaml $(tag) == 'all-api-versions'
#exclude-file: 
#  - $(this-folder)/Microsoft.Example/stable/2010-01-01/somefile.json
```

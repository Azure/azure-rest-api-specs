## AzureResourceSchema

These settings apply only when `--azureresourceschema` is specified on the command line.

### AzureResourceSchema multi-api

``` yaml $(azureresourceschema) && $(multiapi)
batch:
  - tag: schema-sql-2020-08-01-preview
  - tag: schema-sql-2020-02-02-preview
  - tag: schema-sql-2019-06-01-preview
  - tag: schema-sql-2018-06-01-preview
  - tag: schema-sql-2017-10-01-preview
  - tag: schema-sql-2017-03-01-preview
  - tag: schema-sql-2015-05-01-preview
  - tag: schema-sql-2015-05-01
  - tag: schema-sql-2014-04-01

```

Please also specify `--azureresourceschema-folder=<path to the root directory of your azure-resource-manager-schemas clone>`.

### Tag: schema-sql-2020-08-01-preview and azureresourceschema

``` yaml $(tag) == 'schema-sql-2020-08-01-preview' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - ./Microsoft.Sql/preview/2020-08-01-preview/databases.json
  - ./Microsoft.Sql/preview/2020-08-01-preview/elasticPools.json

```

### Tag: schema-sql-2020-02-02-preview and azureresourceschema

``` yaml $(tag) == 'schema-sql-2020-02-02-preview' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.Sql/preview/2020-02-02-preview/shortTermRetentionPolicies.json
  - Microsoft.Sql/preview/2020-02-02-preview/managedDatabases.json
  - Microsoft.Sql/preview/2020-02-02-preview/ServerAzureADOnlyAuthentications.json
  - Microsoft.Sql/preview/2020-02-02-preview/managedInstances.json
  - Microsoft.Sql/preview/2020-02-02-preview/importexport.json
  - Microsoft.Sql/preview/2020-02-02-preview/ManagedInstanceAzureADOnlyAuthentications.json
  - Microsoft.Sql/preview/2020-02-02-preview/ServerTrustGroups.json
  - ./Microsoft.Sql/preview/2020-02-02-preview/DatabaseSecurityAlertPolicies.json
  - ./Microsoft.Sql/preview/2020-02-02-preview/ManagedServerSecurityAlertPolicies.json
  - ./Microsoft.Sql/preview/2020-02-02-preview/ServerSecurityAlertPolicies.json
  - ./Microsoft.Sql/preview/2020-02-02-preview/operations.json
  - ./Microsoft.Sql/preview/2020-02-02-preview/managedDatabases.json
  - ./Microsoft.Sql/preview/2020-02-02-preview/managedInstances.json
  - ./Microsoft.Sql/preview/2020-02-02-preview/ServerAzureADOnlyAuthentications.json
  - ./Microsoft.Sql/preview/2020-02-02-preview/ManagedInstanceAzureADOnlyAuthentications.json
  - ./Microsoft.Sql/preview/2020-02-02-preview/ServerTrustGroups.json

```

### Tag: schema-sql-2019-06-01-preview and azureresourceschema

``` yaml $(tag) == 'schema-sql-2019-06-01-preview' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.Sql/preview/2019-06-01-preview/databases.json
  - Microsoft.Sql/preview/2019-06-01-preview/servers.json
  - Microsoft.Sql/preview/2019-06-01-preview/WorkloadGroups.json
  - Microsoft.Sql/preview/2019-06-01-preview/WorkloadClassifiers.json
  - Microsoft.Sql/preview/2019-06-01-preview/managedInstanceOperations.json
  - Microsoft.Sql/preview/2019-06-01-preview/ServerAzureADAdministrators.json
  - Microsoft.Sql/preview/2019-06-01-preview/syncGroups.json
  - Microsoft.Sql/preview/2019-06-01-preview/syncMembers.json
  - Microsoft.Sql/preview/2019-06-01-preview/FailoverManagedInstance.json
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

```

### Tag: schema-sql-2018-06-01-preview and azureresourceschema

``` yaml $(tag) == 'schema-sql-2018-06-01-preview' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.Sql/preview/2018-06-01-preview/ManagedInstanceVulnerabilityAssessments.json
  - Microsoft.Sql/preview/2018-06-01-preview/ServerVulnerabilityAssessments.json
  - Microsoft.Sql/preview/2018-06-01-preview/managedDatabaseSensitivityLabels.json
  - Microsoft.Sql/preview/2018-06-01-preview/instancePools.json
  - Microsoft.Sql/preview/2018-06-01-preview/usages.json
  - Microsoft.Sql/preview/2018-06-01-preview/FailoverElasticPools.json
  - Microsoft.Sql/preview/2018-06-01-preview/PrivateEndpointConnections.json
  - Microsoft.Sql/preview/2018-06-01-preview/PrivateLinkResources.json
  - Microsoft.Sql/preview/2018-06-01-preview/capabilities.json
  - Microsoft.Sql/preview/2018-06-01-preview/LongTermRetentionManagedInstanceBackups.json
  - Microsoft.Sql/preview/2018-06-01-preview/ManagedInstanceLongTermRetentionPolicies.json
  - Microsoft.Sql/preview/2018-06-01-preview/FailoverDatabases.json
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

```

### Tag: schema-sql-2017-10-01-preview and azureresourceschema

``` yaml $(tag) == 'schema-sql-2017-10-01-preview' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
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

```

### Tag: schema-sql-2017-03-01-preview and azureresourceschema

``` yaml $(tag) == 'schema-sql-2017-03-01-preview' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
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
  - Microsoft.Sql/preview/2017-03-01-preview/renameDatabase.json
  - Microsoft.Sql/preview/2017-03-01-preview/cancelOperations.json
  - Microsoft.Sql/preview/2017-03-01-preview/dataWarehouseUserActivities.json
  - Microsoft.Sql/preview/2017-03-01-preview/managedDatabases.json
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

```

### Tag: schema-sql-2015-05-01-preview and azureresourceschema

``` yaml $(tag) == 'schema-sql-2015-05-01-preview' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.Sql/preview/2015-05-01-preview/databaseAutomaticTuning.json
  - Microsoft.Sql/preview/2015-05-01-preview/encryptionProtectors.json
  - Microsoft.Sql/preview/2015-05-01-preview/failoverGroups.json
  - Microsoft.Sql/preview/2015-05-01-preview/operations.json
  - Microsoft.Sql/preview/2015-05-01-preview/serverKeys.json
  - Microsoft.Sql/preview/2015-05-01-preview/syncAgents.json
  - Microsoft.Sql/preview/2015-05-01-preview/usages.json
  - Microsoft.Sql/preview/2015-05-01-preview/virtualclusters.json
  - Microsoft.Sql/preview/2015-05-01-preview/virtualNetworkRules.json
  - Microsoft.Sql/preview/2015-05-01-preview/managedInstances.json
  - Microsoft.Sql/preview/2015-05-01-preview/servers.json
  - Microsoft.Sql/preview/2015-05-01-preview/syncGroups.json
  - Microsoft.Sql/preview/2015-05-01-preview/syncMembers.json
  - Microsoft.Sql/preview/2015-05-01-preview/blobAuditing.json
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

```

### Tag: schema-sql-2015-05-01 and azureresourceschema

``` yaml $(tag) == 'schema-sql-2015-05-01' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.Sql/stable/2015-05-01/capabilities.json

```

### Tag: schema-sql-2014-04-01 and azureresourceschema

``` yaml $(tag) == 'schema-sql-2014-04-01' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
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
  - Microsoft.Sql/stable/2014-04-01/capabilities.json
  - Microsoft.Sql/stable/2014-04-01/databases.json
  - Microsoft.Sql/stable/2014-04-01/elasticPools.json
  - Microsoft.Sql/stable/2014-04-01/importExport.json
  - Microsoft.Sql/stable/2014-04-01/recommendedElasticPools.json
  - Microsoft.Sql/stable/2014-04-01/checkNameAvailability.json
  - Microsoft.Sql/stable/2014-04-01/serverAzureADAdministrators.json
  - Microsoft.Sql/stable/2014-04-01/restorePoints.json
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

```


### Java

These settings apply only when `--java` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-libraries-for-java clone>`.

``` yaml $(java)
azure-arm: true
fluent: true
namespace: com.microsoft.azure.management.sql
license-header: MICROSOFT_MIT_NO_CODEGEN
payload-flattening-threshold: 1
output-folder: $(azure-libraries-for-java-folder)/azure-mgmt-sql
```


### Java multi-api

``` yaml $(java) && $(multiapi)
batch:
  - tag: package-composite-v3-2014-04
  - tag: package-composite-v3-2015-05
  - tag: package-composite-v3-2017-03
  - tag: package-composite-v3-2017-10
  - tag: package-composite-v3-2018-06
```

### Tag: package-composite-v3-2014-04

These settings apply only when `--tag=package-composite-v3-2014-04` is specified on the command line.

This section contains all input swagger files from API version 2014-04 for `--tag=package-composite-v3`. To generate multi-api Java client we need to group swagger files by their API version rather than logical composite groups. 

``` yaml $(tag) == 'package-composite-v3-2014-04'
input-file:
- ./Microsoft.Sql/stable/2014-04-01/backups.json
- ./Microsoft.Sql/stable/2014-04-01/checkNameAvailability.json
- ./Microsoft.Sql/stable/2014-04-01/connectionPolicies.json
- ./Microsoft.Sql/stable/2014-04-01/databaseSecurityAlertPolicies.json
- ./Microsoft.Sql/stable/2014-04-01/dataMasking.json
- ./Microsoft.Sql/stable/2014-04-01/firewallRules.json
- ./Microsoft.Sql/stable/2014-04-01/geoBackupPolicies.json
- ./Microsoft.Sql/stable/2014-04-01/importExport.json
- ./Microsoft.Sql/stable/2014-04-01/metrics.json
- ./Microsoft.Sql/stable/2014-04-01/recommendedElasticPoolsDecoupled.json
- ./Microsoft.Sql/stable/2014-04-01/replicationLinks.json
- ./Microsoft.Sql/stable/2014-04-01/serverAzureADAdministrators.json
- ./Microsoft.Sql/stable/2014-04-01/serverCommunicationLinks.json
- ./Microsoft.Sql/stable/2014-04-01/serviceObjectives.json
- ./Microsoft.Sql/stable/2014-04-01/sql.core.json
- ./Microsoft.Sql/stable/2014-04-01/usages.json

# Needed when there is more than one input file
override-info:
  title: SqlManagementClient
```


### Tag: package-composite-v3-2014-04 and java

These settings apply only when `--tag=package-composite-v3-2014-04 --java` is specified on the command line.
Please also specify `--azure-libraries-for-java=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-composite-v3-2014-04' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.sql.v3_2014_04
  output-folder: $(azure-libraries-for-java-folder)/sql/resource-manager/v3_2014_04
regenerate-manager: true
generate-interface: true
```


### Tag: package-composite-v3-2015-05

These settings apply only when `--tag=package-composite-v3-2015-05` is specified on the command line.

This section contains all input swagger files from API version 2015-05 for `--tag=package-composite-v3`. To generate multi-api Java client we need to group swagger files by their API version rather than logical composite groups. 

``` yaml $(tag) == 'package-composite-v3-2015-05'
input-file:
- ./Microsoft.Sql/preview/2015-05-01-preview/databaseAutomaticTuning.json
- ./Microsoft.Sql/preview/2015-05-01-preview/encryptionProtectors.json
- ./Microsoft.Sql/preview/2015-05-01-preview/failoverGroups.json
- ./Microsoft.Sql/preview/2015-05-01-preview/managedInstances.json
- ./Microsoft.Sql/preview/2015-05-01-preview/operations.json
- ./Microsoft.Sql/preview/2015-05-01-preview/serverKeys.json
- ./Microsoft.Sql/preview/2015-05-01-preview/servers.json
- ./Microsoft.Sql/preview/2015-05-01-preview/syncAgents.json
- ./Microsoft.Sql/preview/2015-05-01-preview/syncGroups.json
- ./Microsoft.Sql/preview/2015-05-01-preview/syncMembers.json
- ./Microsoft.Sql/preview/2015-05-01-preview/usages.json
- ./Microsoft.Sql/preview/2015-05-01-preview/virtualNetworkRules.json

# Needed when there is more than one input file
override-info:
  title: SqlManagementClient
```


### Tag: package-composite-v3-2015-05 and java

These settings apply only when `--tag=package-composite-v3-2015-05 --java` is specified on the command line.
Please also specify `--azure-libraries-for-java=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-composite-v3-2015-05' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.sql.v3_2015_05
  output-folder: $(azure-libraries-for-java-folder)/sql/resource-manager/v3_2015_05
regenerate-manager: true
generate-interface: true
```


### Tag: package-composite-v3-2017-03

These settings apply only when `--tag=package-composite-v3-2017-03` is specified on the command line.

This section contains all input swagger files from API version 2017-03 for `--tag=package-composite-v3`. To generate multi-api Java client we need to group swagger files by their API version rather than logical composite groups. 

``` yaml $(tag) == 'package-composite-v3-2017-03'
input-file:
- ./Microsoft.Sql/preview/2017-03-01-preview/blobAuditing.json
- ./Microsoft.Sql/preview/2017-03-01-preview/databaseVulnerabilityAssessmentBaselines.json
- ./Microsoft.Sql/preview/2017-03-01-preview/databaseVulnerabilityAssessments.json
- ./Microsoft.Sql/preview/2017-03-01-preview/jobs.json
- ./Microsoft.Sql/preview/2017-03-01-preview/longTermRetention.json
- ./Microsoft.Sql/preview/2017-03-01-preview/ManagedBackupShortTermRetention.json
- ./Microsoft.Sql/preview/2017-03-01-preview/managedDatabases.json
- ./Microsoft.Sql/preview/2017-03-01-preview/serverAutomaticTuning.json
- ./Microsoft.Sql/preview/2017-03-01-preview/serverDnsAliases.json
- ./Microsoft.Sql/preview/2017-03-01-preview/serverSecurityAlertPolicies.json
- ./Microsoft.Sql/preview/2017-03-01-preview/restorePoints.json

# Needed when there is more than one input file
override-info:
  title: SqlManagementClient
```


### Tag: package-composite-v3-2017-03 and java

These settings apply only when `--tag=package-composite-v3-2017-03 --java` is specified on the command line.
Please also specify `--azure-libraries-for-java=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-composite-v3-2017-03' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.sql.v3_2017_03
  output-folder: $(azure-libraries-for-java-folder)/sql/resource-manager/v3_2017_03
regenerate-manager: true
generate-interface: true
```


### Tag: package-composite-v3-2017-10

These settings apply only when `--tag=package-composite-v3-2017-10` is specified on the command line.

This section contains all input swagger files from API version 2017-10 for `--tag=package-composite-v3`. To generate multi-api Java client we need to group swagger files by their API version rather than logical composite groups. 

``` yaml $(tag) == 'package-composite-v3-2017-10'
input-file:
- ./Microsoft.Sql/preview/2017-10-01-preview/cancelOperations.json
- ./Microsoft.Sql/preview/2017-10-01-preview/cancelPoolOperations.json
- ./Microsoft.Sql/preview/2017-10-01-preview/capabilities.json
- ./Microsoft.Sql/preview/2017-10-01-preview/databases.json
- ./Microsoft.Sql/preview/2017-10-01-preview/elasticPools.json
- ./Microsoft.Sql/preview/2017-10-01-preview/databaseVulnerabilityAssessmentScans.json
- ./Microsoft.Sql/preview/2017-10-01-preview/managedDatabaseVulnerabilityAssesmentRuleBaselines.json
- ./Microsoft.Sql/preview/2017-10-01-preview/managedDatabaseVulnerabilityAssessmentScans.json
- ./Microsoft.Sql/preview/2017-10-01-preview/managedDatabaseVulnerabilityAssessments.json
- ./Microsoft.Sql/preview/2017-10-01-preview/instanceFailoverGroups.json
- ./Microsoft.Sql/preview/2017-10-01-preview/shortTermRetentionPolicies.json
- ./Microsoft.Sql/preview/2017-10-01-preview/TdeCertificates.json
- ./Microsoft.Sql/preview/2017-10-01-preview/ManagedInstanceTdeCertificates.json
- ./Microsoft.Sql/preview/2017-10-01-preview/ManagedInstanceKeys.json
- ./Microsoft.Sql/preview/2017-10-01-preview/ManagedInstanceEncryptionProtectors.json

# Needed when there is more than one input file
override-info:
  title: SqlManagementClient
```


### Tag: package-composite-v3-2017-10 and java

These settings apply only when `--tag=package-composite-v3-2017-10 --java` is specified on the command line.
Please also specify `--azure-libraries-for-java=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-composite-v3-2017-10' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.sql.v3_2017_10
  output-folder: $(azure-libraries-for-java-folder)/sql/resource-manager/v3_2017_10
regenerate-manager: true
generate-interface: true
```


### Tag: package-composite-v3-2018-06

These settings apply only when `--tag=package-composite-v3-2018-06` is specified on the command line.

This section contains all input swagger files from API version 2018-06 for `--tag=package-composite-v3`. To generate multi-api Java client we need to group swagger files by their API version rather than logical composite groups. 

``` yaml $(tag) == 'package-composite-v3-2018-06'
input-file:
- ./Microsoft.Sql/preview/2018-06-01-preview/ManagedInstanceVulnerabilityAssessments.json
- ./Microsoft.Sql/preview/2018-06-01-preview/ServerVulnerabilityAssessments.json

# Needed when there is more than one input file
override-info:
  title: SqlManagementClient
```


### Tag: package-composite-v3-2018-06 and java

These settings apply only when `--tag=package-composite-v3-2018-06 --java` is specified on the command line.
Please also specify `--azure-libraries-for-java=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-composite-v3-2018-06' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.sql.v3_2018_06
  output-folder: $(azure-libraries-for-java-folder)/sql/resource-manager/v3_2018_06
regenerate-manager: true
generate-interface: true
```



### Tag: package-pure-2017-10-preview and java

These settings apply only when `--tag=package-pure-2017-10-preview --java` is specified on the command line.
Please also specify `--azure-libraries-for-java=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-pure-2017-10-preview' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.sql.v2017_10_01_preview
  output-folder: $(azure-libraries-for-java-folder)/sql/resource-manager/v2017_10_01_preview
regenerate-manager: true
generate-interface: true
```

### Tag: package-2014-04 and java

These settings apply only when `--tag=package-2014-04 --java` is specified on the command line.
Please also specify `--azure-libraries-for-java=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2014-04' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.sql.v2014_04_01
  output-folder: $(azure-libraries-for-java-folder)/sql/resource-manager/v2014_04_01
regenerate-manager: true
generate-interface: true
```

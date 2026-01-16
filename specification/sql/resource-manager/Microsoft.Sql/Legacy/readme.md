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

### Tag: package-composite-v5

These settings apply only when `--tag=package-composite-v5` is specified on the command line.

This section contains the "composite-v5" set of APIs, which is composed from a selection of api-versions that will remain backwards compatible with "v5" clients such as .NET SDK Microsoft.Azure.Management.Sql version 1.44.3.0-preview.

APIs must only be added to this section when the API is publicly available in at least 1 production region and at least 1 generated client has been tested end-to-end.

``` yaml $(tag) == 'package-composite-v5'
input-file:
- stable/2014-04-01/dataMasking.json
- stable/2014-04-01/geoBackupPolicies.json
- stable/2014-04-01/metrics.json
- stable/2014-04-01/serverCommunicationLinks.json
- stable/2014-04-01/serviceObjectives.json
- stable/2014-04-01-legacy/sql.core_legacy.json
- stable/2014-04-01-legacy/usages_legacy.json

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
- stable/2014-04-01/backups.json
- stable/2014-04-01/connectionPolicies.json
- stable/2014-04-01/databaseSecurityAlertPolicies.json
- stable/2014-04-01/dataMasking.json
- stable/2014-04-01/firewallRules.json
- stable/2014-04-01/geoBackupPolicies.json
- stable/2014-04-01/metrics.json
- stable/2014-04-01/recommendedElasticPoolsDecoupled.json
- stable/2014-04-01/replicationLinks.json
- stable/2014-04-01/serverCommunicationLinks.json
- stable/2014-04-01/serviceObjectives.json
- stable/2014-04-01/sql.core.json
- stable/2014-04-01/usages.json

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
- stable/2014-04-01/backups.json
- stable/2014-04-01/connectionPolicies.json
- stable/2014-04-01/databaseSecurityAlertPolicies.json
- stable/2014-04-01/dataMasking.json
- stable/2014-04-01/firewallRules.json
- stable/2014-04-01/geoBackupPolicies.json
- stable/2014-04-01/metrics.json
- stable/2014-04-01/recommendedElasticPoolsDecoupled.json
- stable/2014-04-01/replicationLinks.json
- stable/2014-04-01/serverCommunicationLinks.json
- stable/2014-04-01/serviceObjectives.json
- stable/2014-04-01/sql.core.json
- stable/2014-04-01/usages.json

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
- stable/2014-04-01/backups.json
- stable/2014-04-01/capabilities.json
- stable/2014-04-01/connectionPolicies.json
- stable/2014-04-01/databases.json
- stable/2014-04-01/databaseSecurityAlertPolicies.json
- stable/2014-04-01/dataMasking.json
- stable/2014-04-01/elasticPools.json
- stable/2014-04-01/firewallRules.json
- stable/2014-04-01/geoBackupPolicies.json
- stable/2014-04-01/importExport.json
- stable/2014-04-01/metrics.json
- stable/2014-04-01/recommendedElasticPools.json
- stable/2014-04-01/replicationLinks.json
- stable/2014-04-01/serverCommunicationLinks.json
- stable/2014-04-01/serviceObjectives.json
- stable/2014-04-01/sql.core.json
- stable/2014-04-01/usages.json

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
- stable/2014-04-01/backups.json
- stable/2014-04-01/capabilities.json
- stable/2014-04-01/connectionPolicies.json
- stable/2014-04-01/databases.json
- stable/2014-04-01/databaseSecurityAlertPolicies.json
- stable/2014-04-01/dataMasking.json
- stable/2014-04-01/elasticPools.json
- stable/2014-04-01/firewallRules.json
- stable/2014-04-01/geoBackupPolicies.json
- stable/2014-04-01/importExport.json
- stable/2014-04-01/metrics.json
- stable/2014-04-01/recommendedElasticPools.json
- stable/2014-04-01/replicationLinks.json
- stable/2014-04-01/serverCommunicationLinks.json
- stable/2014-04-01/serviceObjectives.json
- stable/2014-04-01/sql.core.json
- stable/2014-04-01/usages.json

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
- stable/2014-04-01/backups.json
- stable/2014-04-01/capabilities.json
- stable/2014-04-01/checkNameAvailability.json
- stable/2014-04-01/connectionPolicies.json
- stable/2014-04-01/databases.json
- stable/2014-04-01/databaseSecurityAlertPolicies.json
- stable/2014-04-01/dataMasking.json
- stable/2014-04-01/elasticPools.json
- stable/2014-04-01/firewallRules.json
- stable/2014-04-01/geoBackupPolicies.json
- stable/2014-04-01/importExport.json
- stable/2014-04-01/metrics.json
- stable/2014-04-01/replicationLinks.json
- stable/2014-04-01/serverAzureADAdministrators.json
- stable/2014-04-01/serverCommunicationLinks.json
- stable/2014-04-01/serviceObjectives.json
- stable/2014-04-01/sql.core.json
- stable/2014-04-01/usages.json

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
- stable/2014-04-01/backups.json
- stable/2014-04-01/restorePoints.json
- stable/2014-04-01/checkNameAvailability.json
- stable/2014-04-01/connectionPolicies.json
- stable/2014-04-01/databases.json
- stable/2014-04-01/databaseSecurityAlertPolicies.json
- stable/2014-04-01/dataMasking.json
- stable/2014-04-01/elasticPools.json
- stable/2014-04-01/firewallRules.json
- stable/2014-04-01/geoBackupPolicies.json
- stable/2014-04-01/importExport.json
- stable/2014-04-01/metrics.json
- stable/2014-04-01/replicationLinks.json
- stable/2014-04-01/serverAzureADAdministrators.json
- stable/2014-04-01/serverCommunicationLinks.json
- stable/2014-04-01/serviceObjectives.json
- stable/2014-04-01/sql.core.json
- stable/2014-04-01/usages.json

# Needed when there is more than one input file
override-info:
  title: SqlManagementClient
```

### Tag: package-2014-04

These settings apply only when `--tag=package-2014-04` is specified on the command line.

APIs must only be added to this section when the API is publicly available in at least 1 production region and at least 1 generated client has been tested end-to-end.

``` yaml $(tag) == 'package-2014-04'
input-file:
- stable/2014-04-01/checkNameAvailability.json
- stable/2014-04-01/databases.json
- stable/2014-04-01/elasticPools.json
- stable/2014-04-01/firewallRules.json
- stable/2014-04-01/importExport.json
- stable/2014-04-01/recommendedElasticPools.json
- stable/2014-04-01/replicationLinks.json
- stable/2014-04-01/sql.core.json
- stable/2014-04-01/databaseSecurityAlertPolicies.json

# Needed when there is more than one input file
override-info:
  title: SqlManagementClient
```

## Pure package versions

The following packages are each composed of all apis from only one api-version.

### Tag: package-pure-2014-04

These settings apply only when `--tag=package-pure-2014-04` is specified on the command line.

This section contains all input swagger files for version 2014-04-01-preview. All APIs of that version must be added this section when the API is ready for production.

APIs must only be added to this section when the API is publicly available in at least 1 production region and at least 1 generated client has been tested end-to-end.

These can be regenerated by running the following PowerShell script from this readme file's folder: `dir .\Microsoft.Sql\stable\2014-04-01\ -File | Resolve-Path -Relative | % { " - $_".Replace("\", "/") }`

``` yaml $(tag) == 'package-pure-2014-04'
input-file:
 - ./stable/2014-04-01/advisors.json
 - ./stable/2014-04-01/backups.json
 - ./stable/2014-04-01/capabilities.json
 - ./stable/2014-04-01/checkNameAvailability.json
 - ./stable/2014-04-01/connectionPolicies.json
 - ./stable/2014-04-01/databases.json
 - ./stable/2014-04-01/databaseSecurityAlertPolicies.json
 - ./stable/2014-04-01/dataMasking.json
 - ./stable/2014-04-01/deprecated.json
 - ./stable/2014-04-01/disasterRecoveryConfigurations.json
 - ./stable/2014-04-01/elasticPools.json
 - ./stable/2014-04-01/firewallRules.json
 - ./stable/2014-04-01/geoBackupPolicies.json
 - ./stable/2014-04-01/importExport.json
 - ./stable/2014-04-01/metrics.json
 - ./stable/2014-04-01/operations.json
 - ./stable/2014-04-01/queries.json
 - ./stable/2014-04-01/recommendedElasticPools.json
 - ./stable/2014-04-01/replicationLinks.json
 - ./stable/2014-04-01/restorePoints.json
 - ./stable/2014-04-01/serverAzureADAdministrators.json
 - ./stable/2014-04-01/serverCommunicationLinks.json
 - ./stable/2014-04-01/servers.json
 - ./stable/2014-04-01/serviceObjectives.json
 - ./stable/2014-04-01/sql.core.json
 - ./stable/2014-04-01/tableAuditing.json
 - ./stable/2014-04-01/usages.json

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

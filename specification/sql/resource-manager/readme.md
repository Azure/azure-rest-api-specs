# Sql

> see https://aka.ms/autorest

This is the AutoRest configuration file for Sql.



---
## Getting Started
To build the SDK for Sql, simply [Install AutoRest](https://aka.ms/autorest/install) and in this folder, run:

> `autorest`

To see additional help and options, run:

> `autorest --help`
---

## Configuration



### Basic Information
These are the global settings for the Sql API.

``` yaml
title: SqlManagementClient
description: The Azure SQL Database management API provides a RESTful set of web services that interact with Azure SQL Database services to manage your databases. The API enables you to create, retrieve, update, and delete databases.
openapi-type: arm
tag: package-2017-03-preview
```


### Tag: package-2017-03-preview

These settings apply only when `--tag=package-2017-03-preview` is specified on the command line.

This section contains the input swagger files that are used when generating client SDKs up to and including api-version 2017-03-01-preview. APIs should only be added to this section when the API is ready for production and the generated client code has been tested end-to-end.

``` yaml $(tag) == 'package-2017-03-preview'
input-file:
- Microsoft.Sql/2014-04-01/backupLongTermRetentionPolicies.json
- Microsoft.Sql/2014-04-01/backupLongTermRetentionVaults.json
- Microsoft.Sql/2014-04-01/backups.json
- Microsoft.Sql/2014-04-01/capabilities.json
- Microsoft.Sql/2014-04-01/connectionPolicies.json
- Microsoft.Sql/2014-04-01/databaseSecurityAlertPolicies.json
- Microsoft.Sql/2014-04-01/dataMasking.json
- Microsoft.Sql/2014-04-01/firewallRules.json
- Microsoft.Sql/2014-04-01/geoBackupPolicies.json
- Microsoft.Sql/2014-04-01/importExport.json
- Microsoft.Sql/2014-04-01/metrics.json
- Microsoft.Sql/2014-04-01/replicationLinks.json
- Microsoft.Sql/2014-04-01/serverAzureADAdministrators.json
- Microsoft.Sql/2014-04-01/serverCommunicationLinks.json
- Microsoft.Sql/2014-04-01/serviceObjectives.json
- Microsoft.Sql/2014-04-01/sql.core.json
- Microsoft.Sql/2014-04-01/usages.json
- Microsoft.Sql/2015-05-01-preview/blobAuditingPolicies.json
- Microsoft.Sql/2015-05-01-preview/encryptionProtectors.json
- Microsoft.Sql/2015-05-01-preview/failoverGroups.json
- Microsoft.Sql/2015-05-01-preview/operations.json
- Microsoft.Sql/2015-05-01-preview/serverKeys.json
- Microsoft.Sql/2015-05-01-preview/servers.json
- Microsoft.Sql/2015-05-01-preview/syncAgents.json
- Microsoft.Sql/2015-05-01-preview/syncGroups.json
- Microsoft.Sql/2015-05-01-preview/syncMembers.json
- Microsoft.Sql/2015-05-01-preview/usages.json
- Microsoft.Sql/2015-05-01-preview/virtualNetworkRules.json
- Microsoft.Sql/2017-03-01-preview/cancelOperations.json
- Microsoft.Sql/2017-03-01-preview/serverDnsAliases.json

# Needed when there is more than one input file
override-info:
  title: SqlManagementClient
```

### Tag: package-2015-05-preview

These settings apply only when `--tag=package-2015-05-preview` is specified on the command line.

This section contains the input swagger files that are used when generating client SDKs up to and including api-version 2015-05-01-preview. APIs should only be added to this section when the API is ready for production and the generated client code has been tested end-to-end.

``` yaml $(tag) == 'package-2015-05-preview'
input-file:
- Microsoft.Sql/2014-04-01/backupLongTermRetentionPolicies.json
- Microsoft.Sql/2014-04-01/backupLongTermRetentionVaults.json
- Microsoft.Sql/2014-04-01/backups.json
- Microsoft.Sql/2014-04-01/connectionPolicies.json
- Microsoft.Sql/2014-04-01/databaseSecurityAlertPolicies.json
- Microsoft.Sql/2014-04-01/dataMasking.json
- Microsoft.Sql/2014-04-01/firewallRules.json
- Microsoft.Sql/2014-04-01/geoBackupPolicies.json
- Microsoft.Sql/2014-04-01/importExport.json
- Microsoft.Sql/2014-04-01/metrics.json
- Microsoft.Sql/2014-04-01/replicationLinks.json
- Microsoft.Sql/2014-04-01/serverAzureADAdministrators.json
- Microsoft.Sql/2014-04-01/serverCommunicationLinks.json
- Microsoft.Sql/2014-04-01/serviceObjectives.json
- Microsoft.Sql/2014-04-01/sql.core.json
- Microsoft.Sql/2014-04-01/usages.json
- Microsoft.Sql/2015-05-01-preview/blobAuditingPolicies.json
- Microsoft.Sql/2015-05-01/capabilities.json
- Microsoft.Sql/2015-05-01-preview/encryptionProtectors.json
- Microsoft.Sql/2015-05-01-preview/failoverGroups.json
- Microsoft.Sql/2015-05-01-preview/operations.json
- Microsoft.Sql/2015-05-01-preview/serverKeys.json
- Microsoft.Sql/2015-05-01-preview/servers.json
- Microsoft.Sql/2015-05-01-preview/syncAgents.json
- Microsoft.Sql/2015-05-01-preview/syncGroups.json
- Microsoft.Sql/2015-05-01-preview/syncMembers.json
- Microsoft.Sql/2015-05-01-preview/usages.json
- Microsoft.Sql/2015-05-01-preview/virtualNetworkRules.json

# Needed when there is more than one input file
override-info:
  title: SqlManagementClient
```

### Tag: package-2014-04

These settings apply only when `--tag=package-2014-04` is specified on the command line.

``` yaml $(tag) == 'package-2014-04'
input-file:
- Microsoft.Sql/2014-04-01/firewallRules.json
- Microsoft.Sql/2014-04-01/importExport.json
- Microsoft.Sql/2014-04-01/replicationLinks.json
- Microsoft.Sql/2014-04-01/sql.core.json
- Microsoft.Sql/2014-04-01/databaseSecurityAlertPolicies.json

# Needed when there is more than one input file
override-info:
  title: SqlManagementClient
```

### Tag: schema-2017-03-preview

These settings apply only when `--tag=schema-2017-03-preview` is specified on the command line.

This section contains the input swagger files that are used when generating resource manager schemas for version 2017-03-01-preview. All APIs of that version must be added this section when the API is ready for production.

These can be regenerated by running the following PowerShell script from this readme file's folder: `dir .\Microsoft.Sql\2017-03-01-preview\ -File | Resolve-Path -Relative | % { " - $_".Replace("\", "/") }`

``` yaml $(tag) == 'schema-2017-03-preview'
input-file:
 - ./Microsoft.Sql/2017-03-01-preview/Databases.json
 - ./Microsoft.Sql/2017-03-01-preview/serverDnsAliases.json

# Needed when there is more than one input file
override-info:
  title: SqlManagementClient
```

### Tag: schema-2015-05-preview

These settings apply only when `--tag=schema-2015-05-preview` is specified on the command line.

This section contains the input swagger files that are used when generating resource manager schemas for version 2015-05-01-preview. All APIs of that version must be added this section when the API is ready for production.

These can be regenerated by running the following PowerShell script from this readme file's folder: `dir .\Microsoft.Sql\2015-05-01-preview\ -File | Resolve-Path -Relative | % { " - $_".Replace("\", "/") }`

``` yaml $(tag) == 'schema-2015-05-preview'
input-file:
 - ./Microsoft.Sql/2015-05-01-preview/advisors.json
 - ./Microsoft.Sql/2015-05-01-preview/blobAuditingPolicies.json
 - ./Microsoft.Sql/2015-05-01-preview/encryptionProtectors.json
 - ./Microsoft.Sql/2015-05-01-preview/failoverGroups.json
 - ./Microsoft.Sql/2015-05-01-preview/operations.json
 - ./Microsoft.Sql/2015-05-01-preview/serverKeys.json
 - ./Microsoft.Sql/2015-05-01-preview/servers.json
 - ./Microsoft.Sql/2015-05-01-preview/syncAgents.json
 - ./Microsoft.Sql/2015-05-01-preview/syncGroups.json
 - ./Microsoft.Sql/2015-05-01-preview/syncMembers.json
 - ./Microsoft.Sql/2015-05-01-preview/usages.json
 - ./Microsoft.Sql/2015-05-01-preview/virtualNetworkRules.json

# Needed when there is more than one input file
override-info:
  title: SqlManagementClient
```

### Tag: schema-2014-04

These settings apply only when `--tag=schema-2014-04` is specified on the command line.

This section contains the input swagger files that are used when generating resource manager schemas for version 2014-04-01-preview. All APIs of that version must be added this section when the API is ready for production.

These can be regenerated by running the following PowerShell script from this readme file's folder: `dir .\Microsoft.Sql\2014-04-01\ -File | Resolve-Path -Relative | % { " - $_".Replace("\", "/") }`

``` yaml $(tag) == 'schema-2014-04'
input-file:
 - ./Microsoft.Sql/2014-04-01/advisors.json
 - ./Microsoft.Sql/2014-04-01/backupLongTermRetentionPolicies.json
 - ./Microsoft.Sql/2014-04-01/backupLongTermRetentionVaults.json
 - ./Microsoft.Sql/2014-04-01/backups.json
 - ./Microsoft.Sql/2014-04-01/capabilities.json
 - ./Microsoft.Sql/2014-04-01/connectionPolicies.json
 - ./Microsoft.Sql/2014-04-01/databaseSecurityAlertPolicies.json
 - ./Microsoft.Sql/2014-04-01/dataMasking.json
 - ./Microsoft.Sql/2014-04-01/deprecated.json
 - ./Microsoft.Sql/2014-04-01/firewallRules.json
 - ./Microsoft.Sql/2014-04-01/geoBackupPolicies.json
 - ./Microsoft.Sql/2014-04-01/importExport.json
 - ./Microsoft.Sql/2014-04-01/metrics.json
 - ./Microsoft.Sql/2014-04-01/operations.json
 - ./Microsoft.Sql/2014-04-01/queries.json
 - ./Microsoft.Sql/2014-04-01/replicationLinks.json
 - ./Microsoft.Sql/2014-04-01/serverAzureADAdministrators.json
 - ./Microsoft.Sql/2014-04-01/serverCommunicationLinks.json
 - ./Microsoft.Sql/2014-04-01/servers.json
 - ./Microsoft.Sql/2014-04-01/serviceObjectives.json
 - ./Microsoft.Sql/2014-04-01/sql.core.json
 - ./Microsoft.Sql/2014-04-01/tableAuditing.json
 - ./Microsoft.Sql/2014-04-01/usages.json

# Needed when there is more than one input file
override-info:
  title: SqlManagementClient
```

---
# Code Generation


## C#

These settings apply only when `--csharp` is specified on the command line.
Please also specify `--csharp-sdks-folder=<path to "SDKs" directory of your azure-sdk-for-net clone>`.

``` yaml $(csharp)
csharp:
  azure-arm: true
  license-header: MICROSOFT_MIT_NO_VERSION
  namespace: Microsoft.Azure.Management.Sql
  output-folder: $(csharp-sdks-folder)/SqlManagement/Management.Sql/Generated
  clear-output-folder: true
```


## Go

These settings apply only when `--go` is specified on the command line.

``` yaml $(go)
go:
  license-header: MICROSOFT_APACHE_NO_VERSION
  namespace: sql
  clear-output-folder: true
```

### Tag: package-2017-03-preview and go

These settings apply only when `--tag=package-2017-03-preview --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-2017-03-preview' && $(go)
output-folder: $(go-sdk-folder)/services/sql/mgmt/2017-03-01-preview/sql
```

### Tag: package-2015-05-preview and go

These settings apply only when `--tag=package-2015-05-preview --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-2015-05-preview' && $(go)
output-folder: $(go-sdk-folder)/services/sql/mgmt/2015-05-01-preview/sql
```

### Tag: package-2014-04 and go

These settings apply only when `--tag=package-2014-04 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-2014-04' && $(go)
output-folder: $(go-sdk-folder)/services/sql/mgmt/2014-04-01/sql
```


## Python

These settings apply only when `--python` is specified on the command line.

``` yaml $(python)
python:
  # override the default output folder
  output-folder: $(output-folder)/python
  license-header: MICROSOFT_MIT_NO_VERSION
  payload-flattening-threshold: 2
  namespace: azure.mgmt.sql
```

# Validation

``` yaml
directive:
  - suppress: TrackedResourceListByImmediateParent
    reason: This warning gives many false positives for proxy resources.
  - suppress: GuidUsage
    reason: This warning gives many positives for existing APIs that cannot be changed.
  - suppress: EnumInsteadOfBoolean
    reason: This warning gives many positives for existing APIs that cannot be changed.
```

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

## Configuration for generating APIs


---
#### Basic Information 
These are the global settings for the Sql API.

``` yaml
# common 
title: Sql
description: Sql Client
openapi-type: arm
tag: package-2015-05-preview

```


# Tag: package-2015-05-preview

These settings apply only when `--tag=package-2015-05-preview` is specified on the command line.

``` yaml $(tag) == 'package-2015-05-preview'
input-file:
- Microsoft.Sql/2014-04-01/backups.json
- Microsoft.Sql/2014-04-01/capabilities.json
- Microsoft.Sql/2014-04-01/firewallRules.json
- Microsoft.Sql/2014-04-01/geoBackupPolicies.json
- Microsoft.Sql/2014-04-01/importExport.json
- Microsoft.Sql/2014-04-01/metrics.json
- Microsoft.Sql/2014-04-01/operations.json
- Microsoft.Sql/2014-04-01/replicationLinks.json
- Microsoft.Sql/2014-04-01/sql.core.json
- Microsoft.Sql/2014-04-01/serverAzureADAdministrators.json
- Microsoft.Sql/2014-04-01/databaseSecurityAlertPolicies.json
- Microsoft.Sql/2014-04-01/serverCommunicationLinks.json
- Microsoft.Sql/2014-04-01/serviceObjectives.json
- Microsoft.Sql/2014-04-01/usages.json
- Microsoft.Sql/2015-05-01-preview/blobAuditingPolicies.json
- Microsoft.Sql/2015-05-01-preview/failoverGroups.json
- Microsoft.Sql/2015-05-01-preview/virtualNetworkRules.json
- Microsoft.Sql/2015-05-01-preview/servers.json
- Microsoft.Sql/2015-05-01-preview/serverKeys.json
- Microsoft.Sql/2015-05-01-preview/encryptionProtectors.json

```
 
# Tag: package-2014-04

These settings apply only when `--tag=package-2014-04` is specified on the command line.

``` yaml $(tag) == 'package-2014-04'
input-file:
- Microsoft.Sql/2014-04-01/firewallRules.json
- Microsoft.Sql/2014-04-01/importExport.json
- Microsoft.Sql/2014-04-01/replicationLinks.json
- Microsoft.Sql/2014-04-01/sql.core.json
- Microsoft.Sql/2014-04-01/databaseSecurityAlertPolicies.json

```


---
#### Language-specific settings: CSharp

These settings apply only when `--csharp` is specified on the command line.

``` yaml $(csharp)
csharp:
  # override the default output folder
  output-folder: $(output-folder)/csharp
```


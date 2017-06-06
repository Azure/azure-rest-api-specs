# RecoveryServicesBackup
    
> see https://aka.ms/autorest

This is the AutoRest configuration file for RecoveryServicesBackup.



---
## Getting Started 
To build the SDK for RecoveryServicesBackup, simply [Install AutoRest](https://aka.ms/autorest/install) and in this folder, run:

> `autorest`

To see additional help and options, run:

> `autorest --help`
---

## Configuration for generating APIs


---
#### Basic Information 
These are the global settings for the RecoveryServicesBackup API.

``` yaml
# common 
title: Recovery Services Backup
description: Open API 2.0 Specs for Azure RecoveryServices Backup service
tag: 2016-12-01

azure-arm: true
license-header: MICROSOFT_MIT
```


# Tag: 2016-12-01

These settings apply only when `--tag=2016-12-01` is specified on the command line.

``` yaml $(tag) == '2016-12-01'
input-file:
- Microsoft.RecoveryServices/2016-12-01/backupManagement.json
- Microsoft.RecoveryServices/2016-08-10/operations.json

```
 
# Tag: 2016-06-01

These settings apply only when `--tag=2016-06-01` is specified on the command line.

``` yaml $(tag) == '2016-06-01'
input-file:
- Microsoft.RecoveryServices/2016-06-01/recoveryservicesbackup.json
- Microsoft.RecoveryServices/2016-06-01/registeredIdentities.json

```


---
# Code Generation

## C#

These settings apply only when `--csharp` is specified on the command line.

``` yaml $(csharp)
csharp:
  namespace: Microsoft.Azure.Management.RecoveryServices.Backup
  output-folder: Generated/CSharp
```

## Python

```yaml
python:
  namespace: azure.mgmt.recoveryservicesbackup
  package-name: azure-mgmt-recoveryservicesbackup
  package-version: 0.1.0
  output-folder: Generated/Python
  payload-flattening-threshold: 2
  license-header: MICROSOFT_MIT_NO_VERSION
```


---
# Validation

## Suppression

``` yaml
directive:
  - suppress: DefinitionsPropertiesNamesCamelCase
    reason: Autorest invalidates two letter acronyms as well and changes in data contracts require service wide changes and require more time
```
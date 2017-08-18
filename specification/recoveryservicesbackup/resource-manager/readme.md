# RecoveryServices.Backup
    
> see https://aka.ms/autorest

This is the AutoRest configuration file for RecoveryServicesBackup.



---
## Getting Started 
To build the SDK for RecoveryServicesBackup, simply [Install AutoRest](https://aka.ms/autorest/install) and in this folder, run:

> `autorest`

To see additional help and options, run:

> `autorest --help`
---

## Configuration



### Basic Information 
These are the global settings for the RecoveryServicesBackup API.

``` yaml
title: Recovery Services Backup Client
description: Open API 2.0 Specs for Azure RecoveryServices Backup service
openapi-type: arm
tag: package-2017-07
output-folder: ./
csharp-sdks-folder: ./Generated/CSharp

license-header: MICROSOFT_MIT
```


### Tag: package-2017-07

These settings apply only when `--tag=package-2017-07` is specified on the command line.

``` yaml $(tag) == 'package-2017-07'
input-file:
- Microsoft.RecoveryServices/2017-07-01/jobs.json
- Microsoft.RecoveryServices/2016-12-01/backupManagement.json
- Microsoft.RecoveryServices/2016-08-10/operations.json
```
 
### Tag: package-2016-06

These settings apply only when `--tag=package-2016-06` is specified on the command line.

``` yaml $(tag) == 'package-2016-06'
input-file:
- Microsoft.RecoveryServices/2016-06-01/recoveryservicesbackup.json
- Microsoft.RecoveryServices/2016-06-01/registeredIdentities.json
```


---
# Code Generation

## C#

These settings apply only when `--csharp` is specified on the command line.
Please also specify `--csharp-sdks-folder=<path to "SDKs" directory of your azure-sdk-for-net clone>`.

```yaml $(csharp)
csharp:
  azure-arm: true
  payload-flattening-threshold: 1
  license-header: MICROSOFT_MIT_NO_VERSION
  namespace: Microsoft.Azure.Management.RecoveryServices.Backup
  output-folder: $(csharp-sdks-folder)/RecoveryServices.Backup/Management.RecoveryServices.Backup/Generated
  clear-output-folder: true
```

## Python

These settings apply only when `--python` is specified on the command line.

```yaml $(python)
python:
  azure-arm: true
  namespace: azure.mgmt.recoveryservicesbackup
  package-version: 0.2.0
  output-folder: $(output-folder)Generated/Python
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

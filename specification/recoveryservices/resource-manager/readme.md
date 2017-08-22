# RecoveryServices
    
> see https://aka.ms/autorest

This is the AutoRest configuration file for RecoveryServices.



---
## Getting Started 
To build the SDK for RecoveryServices, simply [Install AutoRest](https://aka.ms/autorest/install) and in this folder, run:

> `autorest`

To see additional help and options, run:

> `autorest --help`
---

## Configuration



### Basic Information 
These are the global settings for the RecoveryServices API.

``` yaml
title: RecoveryServicesClient
description: Recovery Services Client
openapi-type: arm
tag: package-2016-12
```


### Tag: package-2016-12

These settings apply only when `--tag=package-2016-12` is specified on the command line.

``` yaml $(tag) == 'package-2016-12'
input-file:
- Microsoft.RecoveryServices/2016-12-01/backup.json
- Microsoft.RecoveryServices/2016-06-01/registeredidentities.json
- Microsoft.RecoveryServices/2016-06-01/replicationusages.json
- Microsoft.RecoveryServices/2016-06-01/vaults.json
- Microsoft.RecoveryServices/2016-06-01/vaultusages.json
```
 
### Tag: package-2016-06

These settings apply only when `--tag=package-2016-06` is specified on the command line.

``` yaml $(tag) == 'package-2016-06'
input-file:
- Microsoft.RecoveryServices/2016-06-01/registeredidentities.json
- Microsoft.RecoveryServices/2016-06-01/replicationusages.json
- Microsoft.RecoveryServices/2016-06-01/vaults.json
- Microsoft.RecoveryServices/2016-06-01/vaultusages.json
```


---
## C# 

These settings apply only when `--csharp` is specified on the command line.
Please also specify `--csharp-sdks-folder=<path to "SDKs" directory of your azure-sdk-for-net clone>`.

``` yaml $(csharp)
csharp:
  azure-arm: true
  license-header: MICROSOFT_MIT_NO_VERSION
  payload-flattening-threshold: 1
  namespace: Microsoft.Azure.Management.RecoveryServices
  output-folder: $(csharp-sdks-folder)/RecoveryServices/Management.RecoveryServices/Generated
  clear-output-folder: true
```

## Python

These settings apply only when `--python` is specified on the command line.

```yaml $(python)
python:
  azure-arm: true
  namespace: azure.mgmt.recoveryservices
  package-version: 0.1.0
  output-folder: $(output-folder)Generated/Python
  payload-flattening-threshold: 2
  license-header: MICROSOFT_MIT_NO_VERSION
```

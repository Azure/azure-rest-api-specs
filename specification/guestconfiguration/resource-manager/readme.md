# Guest Configuration
    
> see https://aka.ms/autorest

This is the AutoRest configuration file for Guest Configuration.

---
## Getting Started 
To build the SDK for Guest Configuration, simply [Install AutoRest](https://aka.ms/autorest/install) and in this folder, run:

> `autorest`

To see additional help and options, run:

> `autorest --help`
---

## Configuration

### Basic Information 
These are the global settings for the Guest Configuration API.

``` yaml
title: GuestConfigurationClient
description: Guest Configuration Client
openapi-type: arm
tag: package-2018-06-30-preview
```
### Tag: package-2018-06-30-preview

These settings apply only when `--tag=package-2018-06-30-preview` is specified on the command line.

``` yaml $(tag) == 'package-2018-06-30-preview'
input-file:
- Microsoft.GuestConfiguration/preview/2018-06-30-preview/guestconfiguration.json

```

### Tag: package-2018-01-20-preview

These settings apply only when `--tag=package-2018-01-20-preview` is specified on the command line.

``` yaml $(tag) == 'package-2018-01-20-preview'
input-file:
- Microsoft.GuestConfiguration/preview/2018-01-20-preview/guestconfiguration.json

```
## Suppression
``` yaml
directive:
  - suppress: UniqueResourcePaths
    from: guestconfiguration.json
    where: $.paths
    reason: Microsoft.GuestConfiguration is a proxy resource provider under Microsoft. Please refer PR https://github.com/Azure/azure-rest-api-specs-pr/pull/540
  - suppress: OperationsAPIImplementation
    from: guestconfiguration.json
    where: $.paths
    reason: Microsoft.GuestConfiguration is a proxy resource provider under Microsoft.Compute. However, Operations API for is implmented. So, suppressing the false positive. Please refer PR https://github.com/Azure/azure-rest-api-specs-pr/pull/540
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
  namespace: Microsoft.Azure.GuestConfiguration
  output-folder: $(csharp-sdks-folder)/GuestConfiguration/Azure.GuestConfiguration/Generated
  clear-output-folder: true
```


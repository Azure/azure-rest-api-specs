# OperationalInsights
    
> see https://aka.ms/autorest

This is the AutoRest configuration file for OperationalInsights.



---
## Getting Started 
To build the SDK for OperationalInsights, simply [Install AutoRest](https://aka.ms/autorest/install) and in this folder, run:

> `autorest`

To see additional help and options, run:

> `autorest --help`
---

## Configuration



### Basic Information 
These are the global settings for the OperationalInsights API.

``` yaml
title: OperationalInsightsManagementClient
description: Operational Insights Client
openapi-type: arm
tag: package-2015-11-preview
```


### Tag: package-2015-11-preview

These settings apply only when `--tag=package-2015-11-preview` is specified on the command line.

``` yaml $(tag) == 'package-2015-11-preview'
input-file:
- Microsoft.OperationalInsights/2015-11-01-preview/OperationalInsights.json
- Microsoft.OperationalInsights/2015-03-20/OperationalInsights.json
```
 
### Tag: package-2015-03

These settings apply only when `--tag=package-2015-03` is specified on the command line.

``` yaml $(tag) == 'package-2015-03'
input-file:
- Microsoft.OperationalInsights/2015-03-20/OperationalInsights.json
```

---
# Code Generation


## C#

These settings apply only when `--csharp` is specified on the command line.
Please also specify `--csharp-sdks-folder=<path to "SDKs" directory of your azure-sdk-for-net clone>`.

```yaml $(csharp)
csharp:
  # last generated using AutoRest.1.0.0-Nightly20170126 
  azure-arm: true
  namespace: Microsoft.Azure.Management.OperationalInsights
  payload-flattening-threshold: 1
  license-header: MICROSOFT_MIT_NO_VERSION
  output-folder: $(csharp-sdks-folder)/OperationalInsights/Management.OperationalInsights/Generated
  clear-output-folder: true
```
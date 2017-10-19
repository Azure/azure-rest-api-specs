# My API 
> see https://aka.ms/autorest 

## Getting Started 
To build the SDKs for ADM, simply [Install AutoRest](https://aka.ms/autorest/install) and in this folder, run:

> `autorest`

To see additional help and options, run:
> `autorest --help`

For other options on installation see [Installing AutoRest](https://aka.ms/autorest/install) on the AutoRest github page.

---

## Configuration 

### Basic Information 
These are the global settings for the DataLakeStore API.

``` yaml
openapi-type: data-plane
tag: package-2017-11-preview
```

### Tag: package-2015-10-preview

These settings apply only when `--tag=package-2015-10-preview` is specified on the command line.

``` yaml $(tag) == 'package-2017-11-preview'
input-file:
- Microsoft.DeploymentManager/2017-11-01-preview/rollouts.json
```

---
# Code Generation


## C# 

These settings apply only when `--csharp` is specified on the command line.
Please also specify `--csharp-sdks-folder=<path to "SDKs" directory of your azure-sdk-for-net clone>`.

``` yaml $(csharp)
csharp:
  azure-arm: false
  license-header: MICROSOFT_MIT_NO_VERSION
  namespace: Microsoft.DeploymentManager
  output-folder: $(csharp-sdks-folder)/deploymentmanager/dataplane/Microsoft.DeploymentManager/Generated
  clear-output-folder: true
```
